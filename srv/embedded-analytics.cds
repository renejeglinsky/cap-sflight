using { sap.fe.cap.travel as my } from '../db/schema';


@protocol: 'ina'
service FlightService {

annotate my.Airline with @ObjectModel.modelingPattern: #ANALYTICAL_DIMENSION
                         @ObjectModel.supportedCapabilities: [#ANALYTICAL_DIMENSION];
entity FlightByAirport as select from my.Flight {
  // dimension fields:
  @ObjectModel.foreignKey.association: to_Airline
  AirlineID,
  to_Airline, 
  FlightDate,
  ConnectionID,
  CurrencyCode,

  // measures:
  @AnalyticsDetails.measureType: #BASE
  Price,
  @AnalyticsDetails.measureType: #BASE
  MaximumSeats,
  @AnalyticsDetails.measureType: #BASE
  @Aggregation.default: #SUM
  OccupiedSeats * Price as Profit : Decimal 
};
};