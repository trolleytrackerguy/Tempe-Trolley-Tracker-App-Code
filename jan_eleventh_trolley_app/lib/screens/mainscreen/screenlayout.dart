import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

class ScreenLayout extends StatefulWidget {
  final double textContainerWidth;
  final double buttonSpacing;
  final double buttonScale;
  final double buttonTextSize;
  final double appBarTextSize;
  final Color appBarColor;
  final Color appBarTextColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color buttonBackgroundColor;
  final double
      directionTextSize; // New: Customizable text size for direction window
  final Color
      directionTextColor; // New: Customizable text color for direction window
  final Color
      directionBoxColor; // New: Customizable background color for direction window
  final Color routeButtonColor1;
  final Color routeButtonColor2;
  final Color routeButtonTextColor1;
  final Color routeButtonTextColor2;
  final double routeButtonTextSize;
  final double routeButtonWidth;
  final Color northboundStationButtonColor;
  final Color southboundStationButtonColor;

// (255, 163, 205, 78), original lime green

  const ScreenLayout({
    super.key,
    this.textContainerWidth = 125.0,
    this.buttonSpacing = 4.0,
    this.buttonScale = 1.0,
    this.buttonTextSize = 8.0, // Default size for button text
    this.appBarTextSize = 32.0,
    this.appBarColor = const Color.fromARGB(200, 163, 205, 78),
    this.appBarTextColor = const Color.fromARGB(255, 71, 8, 88),
    this.buttonColor = const Color.fromARGB(255, 1, 128, 247),
    this.buttonTextColor = const Color.fromARGB(255, 226, 227, 231),
    this.buttonBackgroundColor = const Color.fromARGB(200, 163, 205, 78),
    this.directionTextSize = 18.0,
    this.directionTextColor = const Color.fromARGB(255, 226, 227, 231),
    this.directionBoxColor = const Color.fromARGB(255, 103, 43, 117),
    this.routeButtonColor1 = const Color.fromARGB(255, 110, 139, 52),
    this.routeButtonColor2 = const Color.fromARGB(255, 71, 8, 88),
    this.routeButtonTextColor1 = const Color.fromARGB(255, 226, 227, 231),
    this.routeButtonTextColor2 = const Color.fromARGB(255, 226, 227, 231),
    this.routeButtonTextSize = 12.0,
    this.routeButtonWidth = 110.0,
    this.northboundStationButtonColor = const Color.fromARGB(255, 110, 139, 52),
    this.southboundStationButtonColor = const Color.fromARGB(255, 71, 8, 88),
  });

  @override
  _ScreenLayoutState createState() => _ScreenLayoutState();
}

class Station {
  String name;
  double latitude;
  double longitude;

  Station(this.name, this.latitude, this.longitude);
}

List<Station> allStations = [
  // Northbound Stations
  Station("Dorsey Ln & Apache", 33.41477284654628, -111.91690185644913),
  Station("Rural & Apache", 33.41477658649356, -111.9252637030677),
  Station("Paseo Del Saber & Apache", 33.41475614226398, -111.92937444873536),
  Station("College Avenue & Apache", 33.41468012925794, -111.93527785667233),
  Station("Eleventh St. & Mill", 33.41807703647487, -111.93991169341936),
  Station("Ninth St. & Mill", 33.42094582703488, -111.93996414067765),
  Station("Sixth St. & Mill", 33.42487607610848, -111.9398995808292),
  Station("Third St. & Mill", 33.42795119149542, -111.93995686292477),
  Station("Hayden Ferry & Rio Salado", 33.43012723203294, -111.93817343680085),
  Station("Marina Heights & Rio Salado", 33.42936659026769, -111.9326979621387),

  // Southbound Stations
  Station(
      "Marina Heights & Rio Salado", 33.42936664671106, -111.93273554829678),
  Station("Hayden Ferry & Rio Salado", 33.430130327320946, -111.93817302174809),
  Station(
      "Tempe Beach Park & Rio Salado", 33.42947411549018, -111.94200484179896),
  Station("Third St. & Ash", 33.42746364261942, -111.94303055284118),
  Station("Fifth St. & Ash", 33.42511839420524, -111.94346826989384),
  Station("University Dr. & Ash", 33.42236325087138, -111.9425140113804),
  Station("Ninth St. & Mill", 33.42094829479461, -111.93995396612915),
  Station("Eleventh St. & Mill", 33.41807979532159, -111.9399166796726),
  Station("College Avenue & Apache", 33.41467718477817, -111.93527892933075),
  Station("Paseo Del Saber & Apache", 33.41475505025213, -111.92937904873207),
  Station("Rural & Apache", 33.414771154132445, -111.92526621859021),
  Station("Dorsey Ln & Apache", 33.41464756781561, -111.91698210303163),
];

List<String> northboundStations = [
  "Dorsey Ln & Apache",
  "Rural & Apache",
  "Paseo Del Saber & Apache",
  "College Avenue & Apache",
  "Eleventh St. & Mill",
  "Ninth St. & Mill",
  "Sixth St. & Mill",
  "Third St. & Mill",
  "Hayden Ferry & Rio Salado",
  "Marina Heights & Rio Salado"
];

List<String> southboundStations = [
  "Marina Heights & Rio Salado",
  "Hayden Ferry & Rio Salado",
  "Tempe Beach Park & Rio Salado",
  "Third St. & Ash",
  "Fifth St. & Ash",
  "University Dr. & Ash",
  "Ninth St. & Mill",
  "Eleventh St. & Mill",
  "College Avenue & Apache",
  "Paseo Del Saber & Apache",
  "Rural & Apache",
  "Dorsey Ln & Apache"
];

List<LatLng> northRoute = [
  LatLng(33.41477284654628, -111.91690185644913),
  LatLng(33.414694367111245, -111.91770192784509),
  LatLng(33.414676456247975, -111.91831347151621),
  LatLng(33.41469884482614, -111.91922005815566),
  LatLng(33.414725711112375, -111.92018028898512),
  LatLng(33.41478392137162, -111.92100640934795),
  LatLng(33.41476508323501, -111.92208264026972),
  LatLng(33.41476125827005, -111.92295788062758),
  LatLng(33.414765083234826, -111.92386519785282),
  LatLng(33.4147803830941, -111.92459380110256),
  LatLng(33.41477658649356, -111.9252637030677),
  LatLng(33.414810982803196, -111.9263076225202),
  LatLng(33.41476508323285, -111.92756320294126),
  LatLng(33.41474978337073, -111.92845219052569),
  LatLng(33.41475359254006, -111.9288707875075),
  LatLng(33.41475614226398, -111.92937444873536),
  LatLng(33.41477456937125, -111.92981470512946),
  LatLng(33.41474069573552, -111.93065677156939),
  LatLng(33.41472375891328, -111.93140076600525),
  LatLng(33.41470682208684, -111.93205683383296),
  LatLng(33.41470964489143, -111.93277377393115),
  LatLng(33.414709644891154, -111.93364965829225),
  LatLng(33.41469553086727, -111.93444776141672),
  LatLng(33.414684239646654, -111.93491106704387),
  LatLng(33.41468012925794, -111.93527785667233),
  LatLng(33.41468064836609, -111.93622047767265),
  LatLng(33.41469857812216, -111.93696512831205),
  LatLng(33.414776273689036, -111.93763817793103),
  LatLng(33.41498246543399, -111.93829332729648),
  LatLng(33.41522750426228, -111.93871935337991),
  LatLng(33.41547254239459, -111.93905587819654),
  LatLng(33.415807227513596, -111.93937092269395),
  LatLng(33.4162196056202, -111.93965732678245),
  LatLng(33.416572217230346, -111.93981126897967),
  LatLng(33.4170353913118, -111.93991509046565),
  LatLng(33.41741788160413, -111.93992225056517),
  LatLng(33.41772566554403, -111.93992583061198),
  LatLng(33.41807703647487, -111.93991169341936),
  LatLng(33.41871560760023, -111.93993660645202),
  LatLng(33.419278036332905, -111.9399479632624),
  LatLng(33.41982466301489, -111.93995932007365),
  LatLng(33.42038076524442, -111.9399820336957),
  LatLng(33.42072516768421, -111.93996689128033),
  LatLng(33.42094582703488, -111.93996414067765),
  LatLng(33.42150559750232, -111.93997446248675),
  LatLng(33.42221019005554, -111.93999339050538),
  LatLng(33.42265885139221, -111.9400085329191),
  LatLng(33.42330972217065, -111.94001231852066),
  LatLng(33.42382472811559, -111.93996689127484),
  LatLng(33.42432393341311, -111.93995174885944),
  LatLng(33.42457433458257, -111.93994799005368),
  LatLng(33.42487607610848, -111.9398995808292),
  LatLng(33.425397372291584, -111.93994388115024),
  LatLng(33.4258877618818, -111.93995209896073),
  LatLng(33.42632328038479, -111.93996442567585),
  LatLng(33.4267656552127, -111.93996442567556),
  LatLng(33.427256037070734, -111.93997675239164),
  LatLng(33.42768126105797, -111.93997675239133),
  LatLng(33.42795119149542, -111.93995686292477),
  LatLng(33.42826092079594, -111.9399830848822),
  LatLng(33.42848447868492, -111.9399830848822),
  LatLng(33.428772701238685, -111.93994987781878),
  LatLng(33.4290405995439, -111.93995430542708),
  LatLng(33.42930480188982, -111.93995430542702),
  LatLng(33.42944521679368, -111.93990338793212),
  LatLng(33.429489558295074, -111.9398259047877),
  LatLng(33.42952466196858, -111.93969750415344),
  LatLng(33.42954868026266, -111.93955582068938),
  LatLng(33.429559765628866, -111.93923924671275),
  LatLng(33.42961149731, -111.93900679727949),
  LatLng(33.42968539966126, -111.93884076197945),
  LatLng(33.4298239663998, -111.93865037483032),
  LatLng(33.42997916087836, -111.93846662908787),
  LatLng(33.43006045311351, -111.9383426560568),
  LatLng(33.43012723203294, -111.93817343680085),
  LatLng(33.43024705546662, -111.93799066122564),
  LatLng(33.43034128025952, -111.93781134309141),
  LatLng(33.4304558279092, -111.9375656108334),
  LatLng(33.430540814781224, -111.93729995435264),
  LatLng(33.430598088494996, -111.93704093927788),
  LatLng(33.43063688679549, -111.93674428953454),
  LatLng(33.4306609047818, -111.93645206738988),
  LatLng(33.430642429406994, -111.93616648667255),
  LatLng(33.430590698340296, -111.9358831197444),
  LatLng(33.43050940659932, -111.9356063942427),
  LatLng(33.430396706563144, -111.9353097444898),
  LatLng(33.430252598103145, -111.93503080518582),
  LatLng(33.43006969086775, -111.93474522446527),
  LatLng(33.42985906993781, -111.93446628515389),
  LatLng(33.429705722802055, -111.9342028424629),
  LatLng(33.429460144266, -111.93383185742998),
  LatLng(33.429357993751694, -111.9335298066024),
  LatLng(33.42933327989984, -111.9333126458708),
  LatLng(33.42935799375111, -111.93298098221838),
  LatLng(33.42936659026769, -111.9326979621387),
];

List<LatLng> southRoute = [
  LatLng(33.42936664671106, -111.93273554829678),
  LatLng(33.429353729163324, -111.93303346770686),
  LatLng(33.42933256835368, -111.93332505563446),
  LatLng(33.42934949700182, -111.93353297050456),
  LatLng(33.42943625627163, -111.93379159631858),
  LatLng(33.429698649639526, -111.93420489049078),
  LatLng(33.429865819190006, -111.93446351630482),
  LatLng(33.430058381189795, -111.93475763977062),
  LatLng(33.430257290938805, -111.93503147885508),
  LatLng(33.43039271858847, -111.93530785349948),
  LatLng(33.43050910156181, -111.93560451250656),
  LatLng(33.43058104731827, -111.93587835160376),
  LatLng(33.43063183252368, -111.93616740397161),
  LatLng(33.43065722511453, -111.93645138525763),
  LatLng(33.430650876967356, -111.93674804426543),
  LatLng(33.43061913622368, -111.93704723882476),
  LatLng(33.430557770756174, -111.93729318690282),
  LatLng(33.430460432334904, -111.9375619548878),
  LatLng(33.43036309380898, -111.93781804515464),
  LatLng(33.430236130347325, -111.93804117330016),
  LatLng(33.430130327320946, -111.93817302174809),
  LatLng(33.429984425875226, -111.93843208692383),
  LatLng(33.42978571130116, -111.93883648763978),
  LatLng(33.42975360541545, -111.93916247326737),
  LatLng(33.42970291188856, -111.93955325107775),
  LatLng(33.42967418554337, -111.9398954347505),
  LatLng(33.429640389830645, -111.94025179171352),
  LatLng(33.42958800645053, -111.94080657471476),
  LatLng(33.42954163122868, -111.9412261152903),
  LatLng(33.42950949233976, -111.94150949729898),
  LatLng(33.42947411549018, -111.94200484179896),
  LatLng(33.429476590979625, -111.94228632855044),
  LatLng(33.4293875421889, -111.94257575460081),
  LatLng(33.42931407686766, -111.94271179818193),
  LatLng(33.429235045924116, -111.94277048364962),
  LatLng(33.42913778169936, -111.9427758045688),
  LatLng(33.42901867845872, -111.94272378790426),
  LatLng(33.42888065206638, -111.94265709987367),
  LatLng(33.42870700564822, -111.9425997481672),
  LatLng(33.42854337697476, -111.94256773791265),
  LatLng(33.42833522304524, -111.94255840158742),
  LatLng(33.42817381992164, -111.94258107551724),
  LatLng(33.427884406676164, -111.94266776995548),
  LatLng(33.42767847743078, -111.94278514088663),
  LatLng(33.42746364261942, -111.94303055284118),
  LatLng(33.42720762749398, -111.94317239250844),
  LatLng(33.427026045989855, -111.9432763959584),
  LatLng(33.426829498546866, -111.94336485866067),
  LatLng(33.42659204469702, -111.94342104443088),
  LatLng(33.426349831505206, -111.94343931308579),
  LatLng(33.42611584877599, -111.94344062930399),
  LatLng(33.42588516096074, -111.9434379968668),
  LatLng(33.42556439402884, -111.94343799686544),
  LatLng(33.42535237961834, -111.94343536442707),
  LatLng(33.42511839420524, -111.94346826989384),
  LatLng(33.4249239551334, -111.9434419455205),
  LatLng(33.42466909649365, -111.94342746711513),
  LatLng(33.42439556202939, -111.9433708697135),
  LatLng(33.42413411061015, -111.94325767491154),
  LatLng(33.42391110730691, -111.94312736926629),
  LatLng(33.423645260257075, -111.94292467159767),
  LatLng(33.42339698913767, -111.94274434964322),
  LatLng(33.42312125356413, -111.94259956559222),
  LatLng(33.42286089686196, -111.94251532759834),
  LatLng(33.422535724527386, -111.94247847347629),
  LatLng(33.42236325087138, -111.9425140113804),
  LatLng(33.422145735827854, -111.9424745248219),
  LatLng(33.42196776857363, -111.94242450851463),
  LatLng(33.42191503746576, -111.94233237320768),
  LatLng(33.4218930661611, -111.9420967700735),
  LatLng(33.42189746042229, -111.94182168037847),
  LatLng(33.42190844607447, -111.94157423127479),
  LatLng(33.421923825985324, -111.9412793983005),
  LatLng(33.42193151593959, -111.94084109749193),
  LatLng(33.42192162885517, -111.94044623190302),
  LatLng(33.421913938898, -111.94017377464235),
  LatLng(33.42184582783365, -111.94008822043222),
  LatLng(33.42168873275971, -111.94006057984012),
  LatLng(33.42160963583169, -111.94005399874678),
  LatLng(33.42147121602836, -111.94005005009139),
  LatLng(33.42125589590041, -111.94002635815565),
  LatLng(33.4210801239721, -111.94000398243864),
  LatLng(33.42094829479461, -111.93995396612915),
  LatLng(33.42059812533658, -111.93999697137271),
  LatLng(33.420350746627086, -111.93999069201298),
  LatLng(33.41986227643279, -111.93999069201217),
  LatLng(33.41952055530588, -111.9399856685249),
  LatLng(33.419121180135896, -111.93997813329356),
  LatLng(33.418714465478544, -111.93996934218967),
  LatLng(33.418320327806725, -111.93996934219085),
  LatLng(33.41807979532159, -111.9399166796726),
  LatLng(33.417717102218056, -111.93995561170232),
  LatLng(33.41722652070001, -111.93995184408668),
  LatLng(33.41698023604736, -111.93994449346087),
  LatLng(33.41668672357948, -111.93988923509677),
  LatLng(33.41643618893677, -111.93980634755083),
  LatLng(33.41614896423204, -111.93967071338514),
  LatLng(33.415886897066876, -111.93949740306222),
  LatLng(33.41567304967229, -111.93932158099808),
  LatLng(33.41548331208334, -111.93911812975064),
  LatLng(33.415278898194025, -111.93886318775532),
  LatLng(33.41510698050004, -111.93859819878413),
  LatLng(33.41497489716517, -111.93832818631759),
  LatLng(33.41475475782347, -111.93769899449207),
  LatLng(33.41465307422393, -111.93705975569512),
  LatLng(33.414646784512954, -111.93646321653856),
  LatLng(33.41465307422398, -111.93581518663429),
  LatLng(33.41467718477817, -111.93527892933075),
  LatLng(33.41466030054853, -111.9349524587086),
  LatLng(33.41466525198497, -111.93455620475744),
  LatLng(33.414668222846245, -111.93409469940688),
  LatLng(33.414671193707946, -111.93357980654609),
  LatLng(33.414676145143595, -111.93307084563493),
  LatLng(33.41467713543074, -111.93248595581862),
  LatLng(33.41468604801336, -111.93182157793557),
  LatLng(33.41469198973507, -111.93110499893812),
  LatLng(33.41469793145628, -111.93065891664509),
  LatLng(33.41470684403719, -111.92993996486695),
  LatLng(33.41475505025213, -111.92937904873207),
  LatLng(33.41471726386218, -111.92888781069493),
  LatLng(33.41472036925548, -111.92832107864625),
  LatLng(33.41472450977985, -111.92790316026276),
  LatLng(33.4147276151727, -111.9272992247982),
  LatLng(33.41473175569599, -111.92661220170064),
  LatLng(33.41473589621945, -111.92598222384777),
  LatLng(33.41474201591128, -111.92552261450122),
  LatLng(33.414771154132445, -111.92526621859021),
  LatLng(33.4147359873125, -111.924681202588),
  LatLng(33.41473900161185, -111.9241684107775),
  LatLng(33.41473297301276, -111.92372784316859),
  LatLng(33.41474000637884, -111.92301884228647),
  LatLng(33.414739001612055, -111.92221956115539),
  LatLng(33.41473598731247, -111.92168510208722),
  LatLng(33.41477416843096, -111.92123851579449),
  LatLng(33.414798282812576, -111.9207822996084),
  LatLng(33.41476211123678, -111.92042960477362),
  LatLng(33.414714887212845, -111.92003237168264),
  LatLng(33.41471187291263, -111.91952319108108),
  LatLng(33.414708858612315, -111.91900076938047),
  LatLng(33.4147048395451, -111.91846751404778),
  LatLng(33.414696801409455, -111.91777416173923),
  LatLng(33.41469077280777, -111.91737090997074),
  LatLng(33.41464756781561, -111.91698210303163),
];

class _ScreenLayoutState extends State<ScreenLayout> {
  String _selectedDirection = "Northbound"; // or "Southbound"
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child("vehicles/182");
  double _trolleyLatitude = 33.41565; // Default location
  double _trolleyLongitude = -111.92371; // Default location
  Marker? _trolleyMarker;

  final Map<String, LatLng> _stationLocations = {};
  String? _selectedStation;
  final ScrollController _scrollController = ScrollController();
  String _travelDirection =
      "Unknown"; // Default, will update in future with GPS

  double? _previousLatitude;
  double? _previousLongitude;
  DateTime? _previousUpdateTime;
  double _currentSpeedMps = 0;

  final List<double> _recentSpeeds = [];

  List<LatLng> recentPositions = []; // store last 2 GPS points

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _addStationMarkers();
    _listenForTrolleyUpdates(); // Start listening to Firebase updates
  }

  Future<BitmapDescriptor> _getTrolleyIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
          size: Size(100, 100)), // Size hint (may not affect actual scaling)
      "assets/Trolley_Icon.png",
    );
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371000; // Earth's radius in meters
    double dLat = (lat2 - lat1) * pi / 180;
    double dLon = (lon2 - lon1) * pi / 180;
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) *
            cos(lat2 * pi / 180) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distance in meters
  }

  Station? getClosestStation(double trolleyLat, double trolleyLon) {
    const double proximityThreshold = 20; // meters
    Station? closestStation;
    double minDistance = double.infinity;

    for (Station station in allStations) {
      double distance = calculateDistance(
          trolleyLat, trolleyLon, station.latitude, station.longitude);

      if (distance < minDistance && distance <= proximityThreshold) {
        minDistance = distance;
        closestStation = station;
      }
    }
    return closestStation;
  }

  List<String> trolleyStationHistory = [];

  void updateTrolleyStation(String currentStation) {
    if (trolleyStationHistory.isEmpty ||
        trolleyStationHistory.last != currentStation) {
      trolleyStationHistory.add(currentStation);

      if (trolleyStationHistory.length > 6) {
        trolleyStationHistory.removeAt(0);
      }

      // Detect route change at terminus
      if (currentStation == northboundStations.last) {
        _travelDirection = "Southbound";
        trolleyStationHistory.clear();
        trolleyStationHistory.add(currentStation);
      } else if (currentStation == southboundStations.last) {
        _travelDirection = "Northbound";
        trolleyStationHistory.clear();
        trolleyStationHistory.add(currentStation);
      }
    }
  }

  String determineRoute(List<String> stationHistory) {
    if (_matchesRoute(stationHistory, northboundStations)) {
      return "Northbound";
    } else if (_matchesRoute(stationHistory, southboundStations)) {
      return "Southbound";
    }
    return "Unknown";
  }

  bool _matchesRoute(List<String> history, List<String> route) {
    if (history.isEmpty) return false;

    int firstIndex = route.indexOf(history.first);
    if (firstIndex == -1) return false;

    for (int i = 1; i < history.length; i++) {
      int expectedIndex = firstIndex + i;
      if (expectedIndex >= route.length || history[i] != route[expectedIndex]) {
        return false;
      }
    }
    return true;
  }

  Duration calculateETAFromSpeed({
    required double currentLat,
    required double currentLon,
    required String currentDirection,
    required String selectedStation,
    required double speedMetersPerSecond,
  }) {
    if (speedMetersPerSecond < 0.5) return Duration.zero;

    List<String> route = currentDirection == "Northbound"
        ? northboundStations
        : southboundStations;

    int targetIndex = route.indexOf(selectedStation);
    if (targetIndex == -1) return Duration.zero;

    // Find the segment the trolley is currently on (between two consecutive stations)
    int currentSegmentIndex = -1;
    double minDistanceToSegment = double.infinity;

    for (int i = 0; i < route.length - 1; i++) {
      Station start = allStations.firstWhere((s) => s.name == route[i]);
      Station end = allStations.firstWhere((s) => s.name == route[i + 1]);

      // Approximate distance from point to line segment
      double distanceToSegment = _distanceFromPointToSegment(
        currentLat,
        currentLon,
        start.latitude,
        start.longitude,
        end.latitude,
        end.longitude,
      );

      if (distanceToSegment < minDistanceToSegment) {
        minDistanceToSegment = distanceToSegment;
        currentSegmentIndex = i;
      }
    }

    // If trolley is ahead of the target station
    if (currentSegmentIndex >= targetIndex) {
      return Duration.zero;
    }

    double totalDistance = 0;

    // 1. Add distance from current position to end of current segment
    Station segEnd =
        allStations.firstWhere((s) => s.name == route[currentSegmentIndex + 1]);
    totalDistance += calculateDistance(
        currentLat, currentLon, segEnd.latitude, segEnd.longitude);

    // 2. Add all full segment distances between upcoming stations
    for (int i = currentSegmentIndex + 1; i < targetIndex; i++) {
      Station from = allStations.firstWhere((s) => s.name == route[i]);
      Station to = allStations.firstWhere((s) => s.name == route[i + 1]);
      totalDistance += calculateDistance(
          from.latitude, from.longitude, to.latitude, to.longitude);
    }

    double etaSeconds = totalDistance / speedMetersPerSecond;

    print("Current Speed: $speedMetersPerSecond m/s");
    print(
        "Segment: ${route[currentSegmentIndex]} to ${route[currentSegmentIndex + 1]}");
    print(
        "Total Distance to $selectedStation: ${totalDistance.toStringAsFixed(2)} meters");
    print("ETA (raw seconds): ${etaSeconds.round()}");

    return Duration(seconds: etaSeconds.round());
  }

  double _distanceFromPointToSegment(
    double px,
    double py,
    double x1,
    double y1,
    double x2,
    double y2,
  ) {
    double dx = x2 - x1;
    double dy = y2 - y1;

    if (dx == 0 && dy == 0) {
      return calculateDistance(px, py, x1, y1);
    }

    double t = ((px - x1) * dx + (py - y1) * dy) / (dx * dx + dy * dy);
    t = t.clamp(0.0, 1.0);

    double nearestX = x1 + t * dx;
    double nearestY = y1 + t * dy;

    return calculateDistance(px, py, nearestX, nearestY);
  }

  String formatDuration(Duration duration) {
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    return "\n$minutes minutes \n$seconds seconds";
  }

  int getClosestIndex(LatLng point, List<LatLng> route) {
    double minDist = double.infinity;
    int minIndex = -1;

    for (int i = 0; i < route.length; i++) {
      double dist = calculateDistance(
        point.latitude,
        point.longitude,
        route[i].latitude,
        route[i].longitude,
      );
      if (dist < minDist) {
        minDist = dist;
        minIndex = i;
      }
    }
    return minIndex;
  }

  String determineRouteFromTwoPoints() {
    //if (recentPositions.length < 2) return "Unknown";

    LatLng pointA = recentPositions[0];
    LatLng pointB = recentPositions[1];

    //double physicalDistance = calculateDistance(
    //pointA.latitude, pointA.longitude, pointB.latitude, pointB.longitude);

    //if (physicalDistance < 2) return "Unknown"; // Too little movement

    int northA = getClosestIndex(pointA, northRoute);
    int northB = getClosestIndex(pointB, northRoute);
    int southA = getClosestIndex(pointA, southRoute);
    int southB = getClosestIndex(pointB, southRoute);

    int deltaNorth = northB - northA;
    int deltaSouth = southB - southA;

    if (deltaNorth >= 1 && deltaSouth <= 0) return "Northbound";
    return "Southbound";
  }

  void _listenForTrolleyUpdates() async {
    BitmapDescriptor customTrolleyIcon = await _getTrolleyIcon();

    _database.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null &&
          data.containsKey("latitude") &&
          data.containsKey("longitude")) {
        setState(() {
          double newLat = data["latitude"];
          double newLon = data["longitude"];
          DateTime newTime = DateTime.now();

          // Calculate speed based on last position
          if (_previousLatitude != null &&
              _previousLongitude != null &&
              _previousUpdateTime != null) {
            double distance = calculateDistance(_previousLatitude!,
                _previousLongitude!, newLat, newLon); // meters
            double deltaTime =
                newTime.difference(_previousUpdateTime!).inSeconds.toDouble();

            if (deltaTime > 0) {
              double newSpeed = distance / deltaTime;
              if (newSpeed > 0) {
                _recentSpeeds.add(newSpeed);
                if (_recentSpeeds.length > 5) {
                  _recentSpeeds.removeAt(0);
                }
                _currentSpeedMps = _recentSpeeds.reduce((a, b) => a + b) /
                    _recentSpeeds.length;
              }
            }
          }

          // Update previous position and time
          _previousLatitude = newLat;
          _previousLongitude = newLon;
          _previousUpdateTime = newTime;

          _trolleyLatitude = newLat;
          _trolleyLongitude = newLon;
          LatLng newPoint = LatLng(newLat, newLon);
          recentPositions.add(newPoint);
          if (recentPositions.length > 2) {
            recentPositions.removeAt(0);
          }

          Station? closestStation =
              getClosestStation(_trolleyLatitude, _trolleyLongitude);
          if (closestStation != null) {
            updateTrolleyStation(closestStation.name);
          }

          _travelDirection = determineRouteFromTwoPoints();

          _trolleyMarker = Marker(
            markerId: const MarkerId("trolley"),
            position: LatLng(_trolleyLatitude, _trolleyLongitude),
            icon: customTrolleyIcon,
            infoWindow: InfoWindow(
              title: "Trolley Location",
              snippet: "Current Route: $_travelDirection",
            ),
          );

          _markers.removeWhere((marker) => marker.markerId.value == "trolley");
          _markers.add(_trolleyMarker!);
        });
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    _mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
  }

  List<Map<String, dynamic>> stations = [
    {
      "name": "Dorsey Ln & Apache",
      "location": const LatLng(33.41477284654628, -111.91690185644913),
      "route": "Both"
    },
    {
      "name": "Rural & Apache",
      "location": const LatLng(33.41477658649356, -111.9252637030677),
      "route": "Both"
    },
    {
      "name": "Paseo Del Saber & Apache",
      "location": const LatLng(33.41475614226398, -111.92937444873536),
      "route": "Both"
    },
    {
      "name": "College Avenue & Apache",
      "location": const LatLng(33.41468012925794, -111.93527785667233),
      "route": "Both"
    },
    {
      "name": "Eleventh St. & Mill",
      "location": const LatLng(33.41807703647487, -111.93991169341936),
      "route": "Both"
    },
    {
      "name": "Ninth St. & Mill",
      "location": const LatLng(33.42094582703488, -111.93996414067765),
      "route": "Both"
    },
    {
      "name": "Sixth St. & Mill",
      "location": const LatLng(33.42487607610848, -111.9398995808292),
      "route": "Northbound"
    },
    {
      "name": "Third St. & Mill",
      "location": const LatLng(33.42795119149542, -111.93995686292477),
      "route": "Northbound"
    },
    {
      "name": "University Dr. & Ash",
      "location": const LatLng(33.42236325087138, -111.9425140113804),
      "route": "Southbound"
    },
    {
      "name": "Fifth St. & Ash",
      "location": const LatLng(33.42511839420524, -111.94346826989384),
      "route": "Southbound"
    },
    {
      "name": "Third St. & Ash",
      "location": const LatLng(33.42746364261942, -111.94303055284118),
      "route": "Southbound"
    },
    {
      "name": "Tempe Beach Park & Rio Salado",
      "location": const LatLng(33.42947411549018, -111.94200484179896),
      "route": "Southbound"
    },
    {
      "name": "Hayden Ferry & Rio Salado",
      "location": const LatLng(33.43012723203294, -111.93817343680085),
      "route": "Both"
    },
    {
      "name": "Marina Heights & Rio Salado",
      "location": const LatLng(33.42936659026769, -111.9326979621387),
      "route": "Both"
    },
  ];

  void _addStationMarkers() {
    for (var station in stations) {
      _markers.add(Marker(
        markerId: MarkerId(station["name"]),
        position: station["location"],
        infoWindow: InfoWindow(
          title: station["name"],
          onTap: () => _toggleStationInfo(
              station["name"]), // Allows tapping the info window
        ),
        onTap: () => _toggleStationInfo(
            station["name"]), // Allows tapping the marker itself
      ));
      _stationLocations[station["name"]] = station["location"];
    }
  }

  void _toggleStationInfo(String stationName) {
    setState(() {
      if (_selectedStation == stationName) {
        _selectedStation = null;
      } else {
        _selectedStation = stationName;
      }
    });

    if (_selectedStation != null) {
      _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_stationLocations[stationName]!, 15));
      _scrollToSelectedButton(stationName);
    }
  }

  void _scrollToSelectedButton(String stationName) {
    int index = _stationLocations.keys.toList().indexOf(stationName);
    if (index != -1) {
      _scrollController.animateTo(
        index * 60.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Tempe Trolley Tracker',
            style: TextStyle(
              color: widget.appBarTextColor,
              fontSize: widget.appBarTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: widget.appBarColor,
        iconTheme: IconThemeData(color: widget.appBarTextColor),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(33.422098795671566, -111.92635400321065),
              zoom: 12,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          ),
          Positioned(
            top: 1,
            right: 55,
            left: MediaQuery.of(context).size.width * 0.285,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: widget.directionBoxColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "Trolley's Current Route",
                    style: TextStyle(
                      fontSize: widget.directionTextSize,
                      color: widget.directionTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _travelDirection,
                    style: TextStyle(
                      fontSize: widget.directionTextSize,
                      color: widget.directionTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 105,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedDirection = "Northbound";
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.routeButtonColor1,
                minimumSize: Size(widget.routeButtonWidth, 40),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              ),
              child: SizedBox(
                width: widget.routeButtonWidth,
                child: Text(
                  "Northbound Stations",
                  style: TextStyle(
                    fontSize: widget.routeButtonTextSize,
                    color: widget.routeButtonTextColor1,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 225,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedDirection = "Southbound";
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.routeButtonColor2,
                minimumSize: Size(widget.routeButtonWidth, 40),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              ),
              child: SizedBox(
                width: widget.routeButtonWidth,
                child: Text(
                  "Southbound Stations",
                  style: TextStyle(
                    fontSize: widget.routeButtonTextSize,
                    color: widget.routeButtonTextColor2,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.01,
            left: 1,
            child: Container(
              width: 100,
              height: 525,
              color: widget.buttonBackgroundColor,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: stations
                      .where((station) =>
                          station["route"] == _selectedDirection ||
                          station["route"] == "Both")
                      .map((station) {
                    String stationName = station["name"];
                    Color buttonColor = _selectedDirection == "Northbound"
                        ? widget.northboundStationButtonColor
                        : widget.southboundStationButtonColor;
                    bool isSelected = _selectedStation == stationName;
                    return Padding(
                      padding: EdgeInsets.only(bottom: widget.buttonSpacing),
                      child: Column(
                        children: [
                          Transform.scale(
                            scale: widget.buttonScale,
                            child: ElevatedButton(
                              onPressed: () => _toggleStationInfo(stationName),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(90, 50),
                                alignment: Alignment.center,
                              ),
                              child: SizedBox(
                                width:
                                    90, // Ensures text stays within button width
                                child: Text(
                                  stationName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: widget.buttonTextColor,
                                    fontSize: widget.buttonTextSize,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (isSelected)
                            Container(
                              width: widget.textContainerWidth,
                              padding: const EdgeInsets.all(10),
                              color: Colors.white,
                              child: Builder(
                                builder: (context) {
                                  String stationName = station["name"];
                                  if (_travelDirection != _selectedDirection) {
                                    return const Text(
                                        "The trolley is not currently travelling this route.");
                                  }

                                  if (_currentSpeedMps == 0) {
                                    return const Text(
                                        "Waiting for movement...");
                                  }
                                  Duration eta = calculateETAFromSpeed(
                                    currentLat: _trolleyLatitude,
                                    currentLon: _trolleyLongitude,
                                    currentDirection: _travelDirection,
                                    selectedStation: stationName,
                                    speedMetersPerSecond: _currentSpeedMps,
                                  );
                                  if (eta == Duration.zero) {
                                    return const Text(
                                        "ETA unavailable or station already passed.");
                                  }
                                  return Text("ETA is ${formatDuration(eta)}");
                                },
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
