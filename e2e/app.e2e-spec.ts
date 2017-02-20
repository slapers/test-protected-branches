import { TestProtectedBranchesPage } from './app.po';

describe('test-protected-branches App', function() {
  let page: TestProtectedBranchesPage;

  beforeEach(() => {
    page = new TestProtectedBranchesPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
