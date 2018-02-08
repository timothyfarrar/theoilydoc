component {


	public string function index(
		event,
		rc,
		prc,
		args = {}
	) {

		oMigration = getModel('migration');
		oMigration.startMigrate();
	}
}