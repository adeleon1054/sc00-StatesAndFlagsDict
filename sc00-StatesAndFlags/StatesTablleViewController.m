//
//  StatesTablleViewController.m
//  sc00-StatesAndFlags
//
//  Created by Entec Department on 11/2/16.
//  Copyright © 2016 COP2654. All rights reserved.
//

#import "StatesTablleViewController.h"
#import "States.h"
#import "StateTableViewCell.h"
#import "StateDetailViewController.h"
#import "SearchResultTableViewController.h"

@interface StatesTablleViewController ()<UISearchResultsUpdating>
@property(nonatomic, strong)NSDictionary *states;
@property(nonatomic, strong)NSArray* keys;
@property(nonatomic, strong)UISearchController* searchController;
@property(nonatomic, strong)NSMutableArray* searchResults;
@end

@implementation StatesTablleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"US-States" ofType:@"plist"];
    
    // load the content of the plist into device memory through a dictionary data structure
    self.states = [[NSDictionary alloc]initWithContentsOfFile:path];
    
    self.keys = [[self.states allKeys]sortedArrayUsingSelector:@selector(compare:)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Grab the newly added navigation controller via its storyboard id
    UINavigationController* searchResutlController = [[self storyboard]instantiateViewControllerWithIdentifier:@"TableSearchResultNavigationController"];
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:searchResutlController];
    self.searchController.searchResultsUpdater = self;
    
    //add the search bar programmatic
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.00);
    
    //where do we want it
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.keys count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"stateInfoCell";
    StateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // populate cells with data
    NSString *key = [self.keys objectAtIndex:indexPath.row];
    cell.stateName.text = self.states[key][@"Name"];
    cell.stateMotto.text = self.states[key][@"Motto"];
                            
    cell.flagImageView.image = [UIImage imageNamed:self.states[key][@"FlagIcon"]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation
-(void)defaultSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"showDetail"]){
        StateDetailViewController *destinationViewController = [segue destinationViewController];
        
        // get the selection
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        States* aState = [[States alloc]init];
    
        NSString *key = [self.keys objectAtIndex:myIndexPath.row];
        
        
        aState.name = self.states[key][@"Name"];
        aState.motto = self.states[key][@"Motto"];
        aState.flag = [UIImage imageNamed:self.states[key][@"FlagImage"]];
        
        // Pass the selected object to the new view controller.
        destinationViewController.myState = aState;
    }
    
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString* searchString = self.searchController.searchBar.text;
//    NSLog(@"User typed search string: %@", searchString);
    //call our search utility method
    [self updateFilteredContentForStateName:searchString];
    
    //juxtapose
    if (self.searchController.searchResultsController)
    {
        UINavigationController* navController = (UINavigationController*)self.searchController.searchResultsController;
        
        //present the searchResultTableView as the top view Controller
        SearchResultTableViewController* vc = (SearchResultTableViewController*) navController.topViewController;
        
        // update search result
        vc.searchResults = _searchResults;
        
        //reload the table view with new data
        [vc.tableView reloadData];
    }
    
}
-(void)updateFilteredContentForStateName:(NSString*)stateName {
//    NSLog(@"DEBUG: received: %@", stateName);
    if (stateName == nil)
    {
        self.searchResults = [self.keys mutableCopy];
    }
    else
    {
        //loop through the dictionary looking for match
        //if found, add the object to searchResults array
        NSMutableArray *searchResults = [[NSMutableArray alloc]init];
        for (id key in self.states)
        {
            NSDictionary* myValues = [_states objectForKey:key];
//            NSLog(@"myValues: %@", myValues);
            
            //start filtering
            if ([myValues[@"Name"]containsString:stateName]) {
                NSString *str = [NSString stringWithFormat:@"%@",myValues[@"Name"]];
                [searchResults addObject:str];
            }
            self.searchResults = searchResults;
        }
    }
}


    @end
    
