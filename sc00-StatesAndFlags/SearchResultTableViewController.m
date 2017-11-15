//
//  SearchResultTableViewController.m
//  sc00-StatesAndFlags
//
//  Created by Asdruval De Leon on 11/13/17.
//  Copyright © 2017 COP2654. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "StateDetailViewController.h"

@interface SearchResultTableViewController ()
@property(nonatomic, strong)NSDictionary *states;
@property(nonatomic, strong)NSArray* keys;
@property(nonatomic, strong)UISearchController* searchController;

@end

@implementation SearchResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"US-States" ofType:@"plist"];

    self.states = [[NSDictionary alloc]initWithContentsOfFile:path];
    
    self.keys = [[self.states allKeys]sortedArrayUsingSelector:@selector(compare:)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
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

    return [self.searchResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchResultCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.searchResults[indexPath.row];
    
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"selectedDetail"]){
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
