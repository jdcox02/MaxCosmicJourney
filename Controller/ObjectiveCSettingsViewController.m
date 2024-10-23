//
//  ObjectiveCSettingsViewController.m
//  MaxCosmicJourney
//
//  Created by Joshua Cox on 3/30/24.
//

#import "ObjectiveCSettingsViewController.h"

@interface ObjectiveCSettingsViewController ()

// Outlet for the segmented control that lets the user choose the "Read To Me" preference.
// This control allows switching between different options.
@property (weak, nonatomic) IBOutlet UISegmentedControl *readToMeOptionSegmentedControl;
@end

@implementation ObjectiveCSettingsViewController

// Called after the view has been loaded into memory.
// Loads the user's "Read To Me" preference from UserDefaults and sets the segmented control to the saved value.

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger readToMePreference = [defaults integerForKey:@"ReadToMePreference"];
    self.readToMeOptionSegmentedControl.selectedSegmentIndex = readToMePreference;
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


// Action method triggered when the user updates the segmented control for "Read To Me".
// Saves the selected index to UserDefaults so that the preference persists.
- (IBAction)readToMeOptionUpdated:(UISegmentedControl *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:sender.selectedSegmentIndex forKey:@"ReadToMePreference"];
    [defaults synchronize];
    
    //Print result
    NSLog(@"User Defaults: %@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);

}
@end
