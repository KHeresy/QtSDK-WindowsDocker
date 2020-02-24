function Controller() {
  installer.autoRejectMessageBoxes();
  installer.setMessageBoxAutomaticAnswer("installationError", QMessageBox.Retry);
  installer.setMessageBoxAutomaticAnswer("installationErrorWithRetry", QMessageBox.Retry);
  installer.setMessageBoxAutomaticAnswer("DownloadError", QMessageBox.Retry);
  installer.setMessageBoxAutomaticAnswer("archiveDownloadError", QMessageBox.Retry);
  installer.installationFinished.connect(function() {
    gui.clickButton(buttons.NextButton);
  })
}

Controller.prototype.WelcomePageCallback = function() {
  gui.clickButton(buttons.NextButton, 3000);
}

Controller.prototype.DynamicTelemetryPluginFormCallback = function() {
    gui.currentPageWidget().TelemetryPluginForm.statisticGroupBox.disableStatisticRadioButton.checked = true;
    gui.clickButton(buttons.NextButton, 3000);
}

Controller.prototype.CredentialsPageCallback = function() {
  gui.clickButton(buttons.NextButton);
}

Controller.prototype.ObligationsPageCallback = function() {
    var page = gui.pageWidgetByObjectName("ObligationsPage");
    page.obligationsAgreement.setChecked(true);
    page.completeChanged();
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.IntroductionPageCallback = function() {
  gui.clickButton(buttons.NextButton);
}

Controller.prototype.TargetDirectoryPageCallback = function() {
  gui.currentPageWidget().TargetDirectoryLineEdit.setText("C:/Qt/");
  gui.clickButton(buttons.NextButton);
}

Controller.prototype.PerformInstallationPageCallback = function() {
  gui.clickButton(buttons.CommitButton);
}

Controller.prototype.ComponentSelectionPageCallback = function() {
  var page = gui.pageWidgetByObjectName("ComponentSelectionPage");
  var archiveCheckBox = gui.findChild(page, "Archive"); 
  var latestCheckBox = gui.findChild(page, "Latest releases"); 
  var fetchButton = gui.findChild(page, "FetchCategoryButton"); 

  archiveCheckBox.click(); 
  latestCheckBox.click(); 
  fetchButton.click(); 

  var widget = gui.currentPageWidget();

  widget.deselectAll();
  widget.selectComponent("qt.qt5.5131.win64_msvc2017_64");

  gui.clickButton(buttons.NextButton);
}

Controller.prototype.LicenseAgreementPageCallback = function() {
  gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
  gui.clickButton(buttons.NextButton);
}

Controller.prototype.StartMenuDirectoryPageCallback = function() {
  gui.clickButton(buttons.NextButton);
}

Controller.prototype.ReadyForInstallationPageCallback = function()
{
  gui.clickButton(buttons.NextButton);
}

Controller.prototype.FinishedPageCallback = function() {
  var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm
  if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {
    checkBoxForm.launchQtCreatorCheckBox.checked = false;
  }
  gui.clickButton(buttons.FinishButton);
}
