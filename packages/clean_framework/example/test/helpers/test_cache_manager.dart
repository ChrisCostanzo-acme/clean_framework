import 'package:file/memory.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cache_manager/src/storage/file_system/file_system.dart';
import 'package:http/http.dart' as http;

class TestCacheManager extends CacheManager {
  TestCacheManager() : super(createTestConfig());

  @override
  Future<File> getSingleFile(
    String url, {
    String? key,
    Map<String, String>? headers,
  }) async {
    final file = await TestFileSystem().createFile('test.svg');
    await file.writeAsString('''
<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="226px" height="218px" viewBox="-6.65 -0.1 226.1 218.2">
<g>
<path fill="#68ae28" d="M146.15 46.8 L29.7 136.95 Q27.9 137.15 24.35 136.05 19.9 134.65 15.9 131.9 4.5 124.1 2.1 109.5 -0.25 95.5 6.4 79.45 8.6 74.15 11.8 68.5 L15.7 61.95 Q20.45 53.5 23.55 45.25 28.7 31.45 26.35 24.85 L27.95 25.05 Q29.75 25.4 30.85 26.35 30.7 24.75 30.0 22.6 28.55 18.2 25.85 15.2 L31.25 14.45 Q38.1 14.5 45.15 18.35 L44.8 15.6 Q44.6 12.8 45.35 12.5 46.5 12.05 48.65 14.7 48.7 12.5 49.6 9.7 51.35 4.2 55.5 1.4 L58.25 6.45 Q62.1 11.9 67.65 14.0 72.5 15.9 89.65 16.9 106.25 17.9 113.05 21.0 L117.85 21.4 Q123.7 22.15 128.65 24.15 144.6 30.6 146.15 46.8"/>
<path fill="#56931f" d="M5.55 119.3 Q-5.75 98.0 10.95 70.35 2.5 92.7 16.65 106.1 22.8 111.9 32.15 114.6 41.3 117.2 51.55 116.3 L28.25 137.35 Q23.15 136.9 16.9 132.4 9.75 127.15 5.55 119.3"/>
<path fill="#7cbeb3" d="M191.85 40.2 Q196.3 42.15 199.6 53.45 202.55 63.7 201.6 67.95 207.5 74.8 213.1 94.7 219.45 117.0 215.25 127.15 213.9 130.4 207.35 136.0 200.55 141.9 193.9 145.1 L196.15 148.75 Q198.85 153.55 201.0 159.1 207.85 177.0 206.7 196.2 206.35 202.3 196.6 206.2 187.05 209.95 176.25 208.7 172.6 208.2 166.6 200.15 159.75 190.8 158.45 180.75 149.3 186.05 143.0 187.9 L141.7 190.1 Q140.0 192.8 137.7 195.1 130.45 202.5 120.55 203.35 110.7 204.2 105.25 201.8 103.55 201.05 102.45 200.05 L101.75 199.2 61.8 200.55 57.7 204.15 Q52.2 207.8 45.0 208.0 35.15 208.3 29.5 206.2 22.4 203.5 19.4 196.35 15.05 186.05 14.8 172.75 14.45 155.45 22.55 144.45 30.35 133.85 42.9 122.85 46.4 119.8 61.95 107.35 69.9 101.05 76.1 95.15 82.4 89.15 83.75 86.55 85.2 76.6 87.55 66.35 92.3 45.85 96.75 44.45 101.2 43.1 109.85 47.3 114.15 49.45 117.55 51.8 L120.95 50.6 Q125.45 49.25 130.8 48.3 147.9 45.35 167.1 47.95 170.0 44.85 179.9 41.95 189.45 39.15 191.85 40.2"/>
<path fill="#68a198" d="M200.9 60.1 L201.9 67.95 196.75 60.3 Q197.55 56.95 197.45 51.25 L197.15 46.25 Q199.45 51.2 200.9 60.1"/>
<path fill="#68a198" d="M86.4 68.95 Q90.45 50.35 94.35 47.45 93.4 58.25 93.7 68.8 93.9 75.0 95.0 87.7 95.65 95.25 93.45 101.1 91.5 106.2 88.35 108.05 85.25 109.85 83.25 107.25 81.1 104.4 81.8 97.45 83.2 83.6 86.4 68.95"/>
<path fill="#68a198" d="M176.65 196.05 Q180.5 203.25 185.85 205.05 L183.95 208.85 Q176.4 210.35 170.6 204.9 163.65 198.25 158.3 180.75 149.65 186.0 139.1 188.6 128.7 191.2 114.1 191.75 111.8 192.5 110.75 194.95 109.7 197.3 110.7 199.2 L107.9 202.5 101.9 198.85 Q102.15 197.15 104.7 188.7 107.2 180.6 107.85 174.65 109.75 156.85 97.95 142.45 108.45 153.0 134.75 155.7 162.85 158.55 182.5 150.6 176.2 154.65 173.5 163.2 171.1 170.9 172.05 180.25 173.0 189.25 176.65 196.05"/>
<path fill="#68a198" d="M14.3 167.35 Q16.45 184.9 33.5 189.9 40.05 191.8 47.3 191.3 53.9 190.85 58.15 188.7 L61.8 201.0 Q57.9 204.8 51.3 206.95 38.1 211.25 24.75 203.2 18.3 199.3 15.5 183.4 14.6 178.05 14.3 172.55 14.05 167.95 14.3 167.35"/>
<path fill="#ffffff" d="M121.35 85.85 Q123.3 85.5 125.5 86.5 117.95 92.3 117.6 104.3 117.25 115.25 122.6 124.85 112.1 123.7 107.8 120.05 106.55 118.95 106.75 113.9 106.95 108.65 108.6 102.9 112.9 87.6 121.35 85.85"/>
<path fill="#d60040" d="M138.65 104.9 Q141.0 111.2 141.55 116.25 142.15 121.65 140.35 123.45 139.15 124.65 133.9 125.1 128.55 125.5 122.6 124.85 117.25 115.25 117.6 104.3 117.95 92.3 125.5 86.5 132.95 89.95 138.65 104.9"/>
<path fill="#d60040" d="M197.2 83.35 Q203.45 88.45 204.65 98.6 205.4 104.95 204.05 116.45 201.85 117.3 199.8 117.6 197.7 117.95 196.65 117.6 193.7 116.65 193.7 102.5 193.65 88.05 197.2 83.35"/>
<path fill="#ffffff" d="M197.2 83.35 Q198.1 82.1 199.1 81.9 203.95 80.85 208.5 93.75 212.95 106.55 210.25 112.05 209.0 114.65 204.05 116.45 205.4 104.95 204.65 98.6 203.45 88.45 197.2 83.35"/>
<path fill="#006359" d="M167.85 78.25 Q166.4 78.8 160.3 75.2 153.9 71.5 154.15 69.15 154.5 66.05 164.5 60.6 174.65 55.1 178.0 56.55 180.15 57.45 175.75 67.15 171.3 76.9 167.85 78.25"/>
<path fill="#006359" d="M145.6 82.55 Q145.45 81.9 147.1 80.1 148.8 78.25 150.15 77.9 L151.25 79.45 Q152.65 81.8 154.05 86.05 L153.4 87.6 Q152.45 89.3 151.05 89.95 L148.65 87.65 Q146.15 84.9 145.6 82.55"/>
<path fill="#006359" d="M184.25 93.45 Q185.8 102.3 184.5 103.35 183.35 104.3 177.5 102.6 171.6 100.9 170.8 99.3 171.05 95.6 174.6 90.05 178.25 84.5 180.5 84.5 182.7 84.5 184.25 93.45"/>
<path fill="#006359" d="M187.25 180.4 Q187.05 177.55 190.75 172.25 194.35 167.05 195.95 167.25 198.35 167.5 199.25 177.3 200.1 187.15 197.7 187.95 195.05 188.85 191.35 186.95 187.1 184.7 187.25 180.4"/>
<path fill="#006359" d="M28.75 152.3 L37.0 152.65 Q42.55 153.75 43.4 155.1 44.8 157.35 41.55 164.6 38.35 171.8 36.15 172.0 34.25 172.15 28.45 168.2 22.6 164.25 22.65 162.7 22.7 160.7 24.6 157.0 26.7 152.85 28.75 152.3"/>
<path fill="#006359" d="M76.3 109.45 Q77.6 111.7 72.1 121.95 66.6 132.2 63.65 132.85 60.95 133.5 54.85 130.5 49.1 127.75 47.2 125.45 46.6 124.7 48.0 121.05 L49.5 117.5 56.2 112.2 Q63.0 106.85 63.8 106.65 L70.05 107.2 Q75.55 108.15 76.3 109.45"/>
<path fill="#ffffff" d="M127.05 91.55 Q128.65 91.55 129.85 94.7 131.05 98.05 131.0 103.05 130.9 107.8 129.7 110.55 128.6 113.05 127.0 113.05 125.5 113.05 124.4 110.35 123.2 107.5 123.1 103.15 122.9 97.9 124.2 94.6 125.35 91.55 127.05 91.55"/>
<path fill="#ffffff" d="M194.85 92.65 L195.85 88.15 Q196.45 87.35 197.0 87.4 197.9 87.45 198.7 89.35 199.85 91.9 199.95 96.55 200.0 100.95 199.15 103.4 198.35 105.6 197.15 105.6 196.4 105.6 195.65 104.5 194.85 103.3 194.55 101.35 193.95 97.9 194.85 92.65"/>
<path fill="#0d131a" d="M173.55 50.25 Q159.85 47.6 145.8 48.2 130.7 48.8 118.05 53.1 117.6 53.25 116.8 52.1 115.95 50.95 116.4 50.75 130.75 45.9 147.5 45.55 162.2 45.2 174.35 48.3 180.55 49.9 180.25 50.65 L173.55 50.25"/>
<path fill="#0d131a" d="M200.55 64.2 Q210.7 78.9 215.35 98.3 219.4 115.2 217.35 124.45 215.1 134.7 194.95 145.45 174.95 156.15 156.3 157.3 136.35 158.5 118.75 154.0 101.15 149.5 96.05 141.85 94.4 139.35 95.0 138.8 95.65 138.25 97.95 140.75 104.7 148.15 122.0 152.05 138.45 155.75 156.35 154.65 175.05 153.5 194.1 142.9 212.4 132.7 214.4 123.6 216.5 114.15 212.65 98.1 208.35 80.15 198.9 65.8 195.0 59.85 195.85 59.2 196.65 58.55 200.55 64.2"/>
<path fill="#0d131a" d="M84.7 87.1 Q81.4 93.3 71.35 101.85 65.35 106.9 51.15 117.85 38.2 128.15 31.15 136.0 21.45 146.8 18.25 157.25 14.4 169.8 17.85 185.45 21.05 200.2 26.95 203.65 33.3 207.35 44.05 206.9 55.15 206.45 59.4 201.7 65.95 194.35 64.5 177.9 63.0 161.1 54.3 151.1 50.9 147.15 51.4 146.3 51.9 145.45 55.65 149.45 66.6 161.2 67.85 178.2 69.0 194.35 61.1 203.2 56.35 208.55 44.0 209.2 32.05 209.85 25.05 205.75 17.95 201.6 14.65 186.15 11.3 170.25 15.3 156.75 18.35 146.55 27.35 136.3 33.9 128.8 46.3 118.75 L66.8 102.15 Q77.9 92.6 83.35 84.6 83.6 84.25 84.25 85.45 84.95 86.7 84.7 87.1"/>
<path fill="#0d131a" d="M96.95 42.95 Q100.05 41.95 107.4 44.95 114.8 48.0 119.55 52.4 123.3 55.9 122.45 56.35 121.65 56.85 117.85 53.9 112.95 50.2 106.5 47.65 100.2 45.1 98.05 45.85 94.55 47.0 89.95 63.6 85.1 81.15 83.65 100.4 83.25 105.95 82.25 105.5 81.2 105.05 81.4 100.25 82.05 83.6 86.4 65.4 91.35 44.8 96.95 42.95"/>
<path fill="#0d131a" d="M165.5 47.25 Q169.85 43.95 178.85 40.95 189.0 37.55 192.95 39.35 196.85 41.1 200.05 51.1 203.0 60.4 203.35 69.8 203.35 70.25 202.1 68.85 200.8 67.45 200.8 66.95 200.5 59.35 197.3 50.95 194.25 42.95 191.65 41.75 189.2 40.65 180.45 43.15 171.6 45.65 167.85 48.5 167.5 48.8 166.3 48.2 165.15 47.55 165.5 47.25"/>
<path fill="#0d131a" d="M167.35 76.85 Q169.8 76.8 174.2 67.5 178.55 58.35 177.45 57.8 175.0 56.55 165.3 61.45 155.55 66.35 155.5 69.0 155.45 70.65 159.8 73.65 164.25 76.65 167.35 76.85 M163.35 60.1 Q174.0 54.35 178.55 55.2 180.1 55.5 179.45 59.3 178.85 62.8 176.75 67.5 171.5 79.2 167.35 79.0 164.05 78.8 158.55 75.2 152.8 71.45 152.8 68.85 152.8 65.8 163.35 60.1"/>
<path fill="#0d131a" d="M153.05 86.35 Q153.2 85.95 151.95 82.65 150.7 79.3 150.15 79.25 149.7 79.2 148.15 80.6 146.6 82.0 146.6 82.7 146.65 83.35 148.7 86.1 150.75 88.75 151.1 88.75 151.4 88.75 152.15 87.75 L153.05 86.35 M153.15 81.1 Q154.7 84.8 154.75 86.15 154.8 87.25 153.15 89.15 151.45 91.1 150.6 90.7 149.6 90.25 147.15 87.0 144.5 83.55 144.7 82.25 144.9 80.9 147.05 78.85 149.2 76.9 150.3 76.95 151.45 77.05 153.15 81.1"/>
<path fill="#0d131a" d="M180.15 85.95 Q178.6 85.85 175.05 91.8 171.6 97.7 172.0 98.85 172.4 99.9 177.65 101.4 182.95 102.9 183.7 102.2 184.85 101.1 183.25 93.55 181.65 86.05 180.15 85.95 M173.35 90.15 Q177.7 82.65 180.2 82.9 183.35 83.2 185.25 93.3 187.1 103.35 184.95 104.4 183.1 105.35 176.8 103.25 170.6 101.2 170.0 99.75 169.05 97.6 173.35 90.15"/>
<path fill="#0d131a" d="M109.8 95.9 Q115.65 84.05 122.35 84.8 131.8 85.9 138.6 100.75 141.45 107.05 142.35 113.2 143.3 119.6 141.7 123.4 140.85 125.5 135.3 126.2 130.2 126.8 123.45 126.1 116.65 125.4 111.85 123.65 106.55 121.8 106.1 119.4 103.85 108.0 109.8 95.9 M133.3 96.6 Q128.05 87.7 122.1 87.05 119.75 86.8 117.0 89.65 112.85 93.95 110.3 102.05 107.6 110.85 108.7 118.9 109.1 122.0 123.65 123.6 138.2 125.25 139.45 122.35 140.75 119.2 139.0 111.35 137.15 103.15 133.3 96.6"/>
<path fill="#0d131a" d="M206.95 92.6 Q203.2 83.3 199.4 83.3 196.05 83.3 195.3 99.15 194.55 114.9 197.2 116.45 198.95 117.45 203.8 115.35 208.65 113.25 209.05 111.4 211.0 102.55 206.95 92.6 M192.95 98.3 Q193.8 81.0 199.4 81.0 204.25 81.0 208.8 91.35 213.55 102.25 211.45 111.7 210.7 114.9 204.05 117.4 197.6 119.85 195.85 118.35 194.2 117.0 193.4 110.95 192.6 105.15 192.95 98.3"/>
<path fill="#0d131a" d="M63.25 105.7 L72.0 106.25 Q77.1 107.15 77.85 108.6 79.2 111.35 72.95 122.7 66.7 134.15 63.4 134.15 60.25 134.15 53.1 131.0 45.55 127.7 45.55 125.6 45.55 124.4 46.65 122.0 L49.05 117.3 Q49.3 116.9 50.4 116.8 51.55 116.75 51.3 117.15 49.95 119.65 49.15 122.0 48.45 124.05 48.45 124.95 48.65 126.3 54.9 129.1 61.0 131.85 63.35 131.9 65.55 131.2 70.55 121.7 75.55 112.2 74.85 110.1 74.45 109.25 70.55 108.5 L62.8 107.95 Q62.3 108.0 62.55 106.85 62.8 105.75 63.25 105.7"/><path fill="#0d131a" d="M29.2 153.2 Q27.65 153.95 25.65 157.35 23.65 160.7 23.8 162.0 24.0 163.35 29.1 166.95 34.2 170.55 35.7 170.35 37.2 170.15 40.35 163.45 43.5 156.75 42.7 155.9 41.8 155.0 36.15 153.8 30.4 152.6 29.2 153.2 M23.65 156.05 Q26.0 152.15 28.1 151.05 L36.75 151.45 Q43.95 152.8 45.15 154.7 46.25 156.45 42.65 164.5 39.05 172.5 36.75 173.35 35.0 174.05 28.5 169.5 21.9 164.9 21.55 162.3 21.3 160.05 23.65 156.05"/><path fill="#0d131a" d="M188.35 180.3 L188.35 180.35 Q188.45 184.5 192.4 186.4 195.95 188.1 197.2 186.95 198.5 185.75 198.1 177.85 197.7 169.8 195.75 168.9 194.7 168.45 191.5 173.4 188.35 178.35 188.35 180.3 M189.8 171.7 Q193.65 165.55 195.75 165.6 199.15 165.65 200.0 176.45 200.85 187.05 198.6 188.7 196.75 190.1 191.85 188.2 186.25 186.0 186.1 180.85 186.05 177.75 189.8 171.7"/><path fill="#0d131a" d="M211.75 122.1 Q211.7 124.05 211.2 125.3 L210.2 126.95 Q207.75 129.85 198.5 134.25 188.95 138.8 181.95 140.2 169.2 142.8 142.8 140.65 116.4 138.55 109.45 134.35 108.3 133.6 107.35 131.9 106.5 130.45 106.1 128.7 105.35 125.55 106.0 125.15 106.65 124.75 108.05 128.05 108.9 130.0 109.85 131.05 L111.85 132.55 Q117.45 135.6 141.8 137.95 168.15 140.5 181.5 137.8 187.5 136.55 195.75 132.95 203.4 129.6 207.2 126.85 208.6 125.8 209.25 124.7 209.95 123.55 210.15 121.9 210.5 118.9 211.15 119.1 211.8 119.35 211.75 122.1"/><path fill="#0d131a" d="M135.95 81.05 Q137.7 82.65 139.35 84.95 141.1 87.35 141.85 89.3 142.95 92.1 141.95 92.45 140.9 92.75 139.6 90.25 137.45 86.0 134.35 82.55 131.45 79.2 132.05 78.65 132.7 78.1 135.95 81.05"/><path fill="#0d131a" d="M192.3 81.4 Q191.35 84.15 191.1 87.3 190.9 90.05 189.85 90.0 188.8 90.0 188.95 87.3 189.1 84.0 190.65 80.8 192.05 77.95 192.7 78.1 193.3 78.3 192.3 81.4"/><path fill="#0d131a" d="M170.35 133.8 Q169.25 133.25 168.6 132.4 167.95 131.6 168.15 131.25 L169.7 131.3 Q171.15 131.6 171.85 132.25 172.75 133.15 172.2 133.8 171.65 134.45 170.35 133.8"/>
<path fill="#0d131a" d="M187.4 131.3 Q186.35 132.6 185.5 132.2 184.65 131.8 185.4 130.55 185.95 129.65 187.15 128.95 188.25 128.25 188.55 128.5 188.75 128.7 188.45 129.55 L187.4 131.3"/>
<path fill="#0d131a" d="M127.3 86.75 Q127.75 86.9 127.7 88.2 127.65 89.5 127.25 89.25 124.7 87.65 122.45 91.7 120.35 95.4 119.55 101.95 118.7 108.7 119.75 114.55 121.0 121.2 124.4 124.05 124.8 124.35 123.9 124.95 123.0 125.5 122.6 125.2 118.5 122.15 116.95 115.1 115.6 108.75 116.65 101.5 117.7 94.35 120.5 90.1 123.55 85.55 127.3 86.75"/>
<path fill="#0d131a" d="M196.35 83.75 Q198.1 82.4 200.4 84.9 202.7 87.35 204.35 92.2 208.45 104.35 204.7 116.1 204.55 116.55 203.55 116.75 202.55 116.9 202.65 116.45 205.7 106.95 202.85 94.9 201.7 90.05 200.0 87.25 198.3 84.4 196.9 85.15 196.5 85.4 196.25 84.7 196.0 84.05 196.35 83.75"/>
<path fill="#0d131a" d="M192.65 145.85 Q192.4 145.45 193.7 144.65 194.95 143.8 195.15 144.2 209.35 167.15 207.8 197.75 207.65 200.6 203.45 203.65 199.45 206.55 193.55 208.5 179.25 213.2 172.05 208.15 167.3 204.8 162.2 195.35 157.3 186.3 157.2 181.6 157.2 181.15 158.6 180.6 L159.95 180.45 Q160.05 185.1 164.6 193.6 169.45 202.65 174.35 206.1 180.6 210.45 193.2 206.35 198.3 204.7 201.8 202.25 205.45 199.75 205.55 197.65 207.0 169.05 192.65 145.85"/><path fill="#0d131a" d="M164.7 177.55 Q151.75 187.7 133.8 191.3 117.15 194.6 104.05 190.95 103.6 190.8 103.9 189.4 104.15 188.05 104.6 188.15 117.45 191.75 133.35 188.6 149.5 185.4 162.65 176.45 167.65 173.05 168.2 173.75 168.7 174.4 164.7 177.55"/><path fill="#0d131a" d="M141.35 187.65 Q141.6 187.25 143.65 186.95 L145.45 187.1 Q141.55 193.5 135.8 198.25 129.2 203.7 122.85 204.5 L107.85 204.05 Q101.95 202.6 100.9 199.65 100.75 199.2 101.65 198.15 102.5 197.05 102.65 197.5 103.65 200.3 108.8 201.7 114.4 203.25 122.55 202.25 127.3 201.65 132.6 197.5 137.85 193.4 141.35 187.65"/><path fill="#0d131a" d="M25.0 23.9 Q25.4 23.6 26.95 23.9 29.35 24.35 31.15 26.05 31.55 26.35 31.2 27.0 30.9 27.6 30.5 27.3 29.45 26.4 28.45 26.1 L27.5 26.05 27.7 27.65 28.0 30.65 Q28.15 37.45 23.55 48.45 19.95 57.2 14.3 66.55 -3.5 96.1 6.45 117.55 10.2 125.65 17.2 130.8 23.4 135.3 29.1 135.7 29.55 135.75 28.95 136.85 28.4 138.0 27.9 137.95 21.25 137.5 14.6 132.7 7.2 127.3 3.35 118.7 -6.65 96.4 12.0 65.55 20.8 50.95 23.95 41.55 27.3 31.6 25.05 25.4 24.6 24.25 25.0 23.9"/><path fill="#0d131a" d="M50.9 22.15 Q51.25 22.5 50.9 23.25 50.55 24.05 50.2 23.7 46.45 19.8 40.45 17.45 34.8 15.3 30.3 15.55 28.2 15.7 28.05 16.1 27.9 16.45 29.05 18.25 34.5 26.85 29.35 43.65 26.55 52.65 20.6 66.05 11.8 89.2 19.2 107.35 22.25 114.85 27.65 120.05 32.65 124.9 38.45 126.6 38.85 126.7 37.85 127.6 36.85 128.45 36.4 128.35 21.05 123.85 15.35 105.45 9.4 86.4 18.25 64.85 L22.65 54.9 Q25.8 47.6 27.4 42.15 32.3 25.75 26.25 18.0 24.2 15.35 24.35 14.6 24.5 13.75 27.35 13.4 32.7 12.7 39.35 15.05 46.4 17.55 50.9 22.15"/><path fill="#0d131a" d="M47.4 12.5 L49.25 14.0 Q49.55 14.35 49.1 15.45 48.65 16.5 48.35 16.15 L47.3 14.9 Q46.4 14.0 45.95 14.2 45.55 14.4 45.65 15.5 L46.1 18.35 Q46.2 18.75 45.3 18.75 44.4 18.7 44.35 18.25 L43.85 15.15 Q43.65 12.6 44.65 11.8 45.5 11.15 47.4 12.5"/><path fill="#0d131a" d="M124.1 26.6 Q134.85 35.25 135.4 47.5 135.45 48.0 134.1 48.25 132.75 48.55 132.75 48.05 132.25 36.85 122.65 28.7 111.1 18.9 90.35 18.15 72.6 17.5 64.95 14.2 58.75 11.55 56.0 5.25 55.4 3.9 55.0 3.8 54.55 3.65 53.55 4.8 50.2 8.5 49.6 13.85 49.0 19.35 51.9 22.4 57.75 28.4 61.15 36.55 63.25 41.6 66.25 53.4 69.9 67.75 74.3 74.75 77.85 80.4 84.7 84.95 85.0 85.1 84.3 86.4 83.65 87.65 83.25 87.4 74.45 81.6 70.6 75.1 67.05 69.1 63.75 55.6 60.2 40.95 58.45 36.55 55.75 29.6 50.3 23.95 46.4 19.9 47.8 12.0 49.15 4.55 53.25 1.35 55.1 -0.1 55.85 0.05 56.6 0.2 57.3 2.15 60.3 9.95 65.9 12.45 72.2 15.2 90.4 15.9 111.8 16.65 124.1 26.6"/><path fill="#0d131a" d="M138.7 29.1 Q148.25 37.3 146.95 46.85 146.9 47.3 145.45 47.25 144.0 47.2 144.05 46.75 145.15 38.55 137.55 31.35 128.8 23.1 113.2 21.95 112.7 21.9 110.3 20.75 107.85 19.55 108.3 19.55 127.6 19.55 138.7 29.1"/><path fill="#7cbeb3" d="M59.75 157.95 Q62.45 147.4 67.3 142.15 L104.35 152.95 Q109.2 171.45 105.3 188.2 102.95 198.15 97.95 205.95 95.25 210.2 86.95 211.55 78.2 213.0 70.1 209.8 64.2 207.5 60.85 198.55 57.75 190.4 57.5 179.0 57.25 167.85 59.75 157.95"/><path fill="#006359" d="M67.7 171.7 Q68.0 168.65 75.05 163.45 82.1 158.25 84.0 159.7 85.95 161.15 84.75 175.5 83.55 189.85 81.1 190.05 79.65 190.15 73.6 182.05 67.5 173.85 67.7 171.7"/><path fill="#68a198" d="M58.8 160.05 Q59.05 181.5 68.45 195.8 77.45 209.65 90.95 211.05 85.45 212.45 79.05 211.95 66.25 210.95 61.8 201.35 57.35 191.8 57.65 174.95 L58.8 160.05"/><path fill="#0d131a" d="M65.15 147.65 Q58.65 158.8 59.25 179.6 59.9 201.25 68.35 207.45 74.1 211.65 83.75 210.8 93.05 209.95 96.05 205.7 102.85 196.05 104.95 182.4 106.85 170.1 104.45 159.0 103.25 153.45 104.15 153.05 105.05 152.65 106.55 158.05 109.65 169.3 107.8 182.4 105.8 196.65 98.65 206.85 94.95 212.1 83.35 213.0 72.0 213.85 66.25 209.65 62.1 206.6 59.4 198.85 56.8 191.45 56.25 181.85 54.9 160.05 63.15 146.6 66.05 141.85 67.15 142.05 68.3 142.2 65.15 147.65"/><path fill="#0d131a" d="M68.9 171.2 Q68.8 172.95 74.05 181.0 79.4 189.2 80.9 189.0 82.55 188.75 83.6 175.45 84.65 162.1 83.1 161.0 81.65 160.0 75.3 164.75 69.0 169.5 68.9 171.2 M66.6 170.7 Q66.75 167.05 74.95 161.5 83.0 156.1 84.6 157.6 87.25 160.15 86.1 174.95 84.9 189.75 81.85 191.5 79.75 192.75 73.1 183.6 66.45 174.5 66.6 170.7"/><path fill="#ffffff" d="M28.9 206.05 Q28.65 205.3 30.8 203.5 33.0 201.7 34.1 201.85 36.1 202.1 36.85 206.2 37.55 210.0 36.95 210.55 36.25 211.2 33.05 209.75 29.6 208.2 28.9 206.05"/><path fill="#ffffff" d="M43.8 209.8 Q40.3 208.2 40.3 206.6 40.3 205.2 42.35 203.2 44.35 201.2 45.4 201.7 47.05 202.5 48.1 206.4 49.1 210.15 48.2 210.75 47.25 211.4 43.8 209.8"/><path fill="#ffffff" d="M51.65 206.75 Q51.3 204.15 53.55 201.95 L55.9 200.25 Q57.75 201.05 58.8 205.05 59.75 208.65 59.25 209.25 L55.3 209.15 Q51.8 208.3 51.65 206.75"/><path fill="#ffffff" d="M71.3 210.95 Q71.2 209.65 72.2 208.15 73.4 206.35 75.25 206.4 77.1 206.45 78.1 207.8 78.9 209.05 78.8 210.85 78.7 212.5 77.65 214.55 76.65 216.6 76.05 216.6 75.4 216.6 73.45 214.45 71.4 212.2 71.3 210.95"/><path fill="#ffffff" d="M81.25 212.05 Q81.1 209.6 82.6 208.0 83.8 206.65 85.0 206.65 85.9 206.65 87.1 208.0 88.3 209.4 88.6 210.8 88.8 211.7 88.15 213.9 87.5 216.25 86.6 216.7 85.7 217.2 83.6 215.6 81.35 213.95 81.25 212.05"/><path fill="#ffffff" d="M91.1 211.75 Q89.7 210.25 91.35 207.2 93.0 204.15 94.6 204.6 96.1 205.1 97.5 208.8 98.8 212.35 98.15 213.35 97.55 214.25 95.05 213.75 92.5 213.2 91.1 211.75"/><path fill="#ffffff" d="M108.1 202.65 Q107.9 201.6 110.05 200.05 112.15 198.55 113.1 198.95 114.75 199.7 115.25 203.15 115.75 206.5 114.85 206.9 113.95 207.3 111.3 205.95 108.45 204.45 108.1 202.65"/><path fill="#ffffff" d="M121.65 206.05 Q118.6 205.0 118.1 203.65 117.65 202.5 119.65 200.35 121.65 198.25 122.55 198.65 124.3 199.4 125.0 202.5 125.6 205.2 125.1 206.2 L121.65 206.05"/><path fill="#ffffff" d="M127.1 201.9 Q126.5 200.7 128.8 198.45 131.05 196.25 132.05 196.65 133.2 197.15 134.3 200.3 135.35 203.4 134.85 204.1 L131.05 204.0 Q127.75 203.2 127.1 201.9"/><path fill="#ffffff" d="M183.8 209.6 Q183.1 208.9 184.9 206.0 186.7 203.05 187.95 203.1 189.6 203.2 191.65 206.7 193.6 210.0 193.15 210.6 192.6 211.3 188.9 211.05 185.05 210.8 183.8 209.6"/><path fill="#ffffff" d="M194.7 206.85 Q194.0 206.1 195.6 203.1 197.15 200.1 198.3 200.2 199.4 200.3 201.4 203.7 203.3 207.05 202.95 207.8 202.5 208.55 199.3 208.35 195.9 208.15 194.7 206.85"/><path fill="#ffffff" d="M203.05 202.25 Q202.25 201.25 203.55 198.45 204.8 195.75 205.55 195.85 206.85 196.0 208.75 199.15 210.6 202.25 210.15 203.05 209.8 203.9 207.0 203.7 204.05 203.5 203.05 202.25"/><path fill="#dbdcdc" d="M31.05 203.2 L33.25 205.95 Q35.45 209.0 35.7 210.7 L32.2 208.9 Q28.75 206.95 28.95 206.1 29.15 205.25 30.15 204.15 L31.05 203.2"/><path fill="#dbdcdc" d="M42.3 203.4 L44.2 205.75 Q46.2 208.55 46.85 210.8 40.7 208.65 40.55 206.55 40.45 205.25 41.35 204.2 L42.3 203.4"/><path fill="#dbdcdc" d="M58.0 209.6 Q54.8 208.9 53.4 208.2 51.8 207.45 51.6 206.35 51.4 205.4 52.0 204.15 L52.65 203.1 Q54.0 203.75 55.95 206.3 57.6 208.5 58.0 209.6"/><path fill="#dbdcdc" d="M73.3 207.45 L73.8 210.5 Q74.45 213.95 75.4 215.9 L73.5 214.25 Q71.65 212.2 71.75 210.05 71.85 208.55 72.5 207.85 73.0 207.3 73.3 207.45"/><path fill="#dbdcdc" d="M82.3 209.05 L84.2 212.15 86.7 216.75 Q85.3 216.3 83.9 215.45 81.1 213.75 81.3 211.8 81.5 209.9 81.9 209.3 L82.3 209.05"/><path fill="#dbdcdc" d="M91.35 207.25 L93.7 209.5 Q96.2 212.05 96.75 213.75 L93.65 212.75 Q90.55 211.55 90.65 210.4 L91.05 208.15 91.35 207.25"/><path fill="#dbdcdc" d="M109.75 200.4 Q110.2 200.7 111.65 202.65 113.45 205.1 113.65 206.6 L110.05 204.9 Q108.65 204.05 108.6 202.75 108.55 201.8 109.15 201.0 L109.75 200.4"/><path fill="#dbdcdc" d="M119.1 200.7 L120.75 201.85 Q122.65 203.6 124.05 206.45 L121.35 205.7 Q118.6 204.7 118.3 203.4 118.0 202.1 118.5 201.3 L119.1 200.7"/><path fill="#dbdcdc" d="M128.5 198.7 L130.55 200.2 Q132.75 202.15 133.55 204.25 L130.7 203.85 Q127.7 203.1 127.15 201.6 126.85 200.9 127.4 199.85 127.9 198.85 128.5 198.7"/><path fill="#dbdcdc" d="M185.1 205.75 Q189.3 207.75 191.85 210.75 L188.1 210.8 Q184.35 210.6 184.2 209.3 184.05 208.0 184.55 206.75 L185.1 205.75"/><path fill="#dbdcdc" d="M195.55 203.6 Q196.4 203.85 198.4 205.1 201.1 206.75 201.75 208.25 L198.25 208.1 Q194.7 207.7 194.65 206.55 194.55 205.45 195.05 204.4 L195.55 203.6"/><path fill="#dbdcdc" d="M203.45 198.7 L205.65 200.05 Q208.1 201.75 209.05 203.65 L206.45 203.45 Q203.75 203.05 203.1 202.1 202.45 201.15 202.9 199.8 L203.45 198.7"/><path fill="#0d131a" d="M182.85 209.9 Q182.45 208.45 184.45 205.25 186.45 202.0 187.9 201.95 189.35 201.9 191.95 205.75 194.5 209.5 194.15 210.85 193.85 212.05 188.55 211.6 183.25 211.15 182.85 209.9 M186.1 206.0 Q184.85 208.0 185.1 208.9 185.6 209.6 188.65 210.05 191.6 210.5 191.85 210.0 192.1 209.45 190.5 206.8 188.8 204.1 187.85 204.05 187.3 204.0 186.1 206.0"/><path fill="#0d131a" d="M201.9 207.4 Q202.2 206.95 200.6 204.2 199.05 201.45 198.25 201.3 197.65 201.25 196.55 203.4 195.4 205.55 195.6 206.4 195.75 207.15 198.75 207.5 L201.9 207.4 M198.5 199.05 Q200.1 199.25 202.3 203.5 204.4 207.55 203.95 208.5 203.5 209.5 199.2 209.1 194.8 208.65 193.9 207.4 193.1 206.3 194.95 202.65 196.8 198.85 198.5 199.05"/><path fill="#0d131a" d="M204.2 199.0 Q203.45 200.7 203.9 201.8 204.1 202.4 206.55 202.75 L209.2 202.6 Q209.5 202.1 208.15 199.7 206.8 197.15 205.8 197.2 204.95 197.3 204.2 199.0 M203.1 197.75 Q204.65 194.9 205.75 194.9 207.6 194.9 209.65 199.05 211.65 203.05 211.05 204.05 L206.6 204.2 Q202.5 203.7 202.15 202.8 201.4 200.85 203.1 197.75"/><path fill="#0d131a" d="M86.6 208.7 Q85.75 207.7 84.95 207.8 83.8 207.85 82.9 209.25 82.0 210.6 82.15 211.85 82.3 213.0 84.1 214.45 85.85 215.8 86.45 215.55 86.85 215.4 87.3 214.1 87.9 212.6 87.7 211.3 87.55 209.75 86.6 208.7 M81.4 208.05 Q83.1 205.55 85.1 205.7 86.55 205.8 87.7 207.2 88.85 208.6 89.15 210.65 89.5 212.65 88.85 215.0 88.2 217.3 87.25 217.65 86.05 218.1 83.4 216.35 80.55 214.4 80.15 212.1 79.85 210.35 81.4 208.05"/><path fill="#0d131a" d="M77.05 208.6 Q76.4 207.7 75.6 207.6 74.65 207.5 73.6 208.4 72.5 209.3 72.5 210.35 72.55 211.65 73.95 213.45 75.2 215.15 75.8 215.15 76.35 215.1 77.0 213.7 77.7 212.3 77.75 210.9 77.8 209.6 77.05 208.6 M71.9 206.95 Q73.75 205.3 75.75 205.55 77.4 205.75 78.6 207.35 79.75 208.95 79.65 210.9 79.6 212.5 78.4 215.0 77.1 217.6 76.15 217.7 75.05 217.85 72.7 215.15 70.2 212.35 70.1 210.4 70.0 208.55 71.9 206.95"/><path fill="#0d131a" d="M96.3 207.6 Q95.15 206.0 94.2 206.0 93.25 205.9 92.3 207.4 91.3 208.95 91.55 210.3 91.8 211.5 94.35 212.4 96.8 213.2 97.2 212.85 97.55 212.55 97.35 210.75 97.15 208.8 96.3 207.6 M94.55 203.8 Q97.0 204.15 98.4 208.95 99.7 213.45 98.9 214.35 L94.2 214.05 Q90.0 212.9 89.65 211.05 89.25 209.0 90.8 206.35 92.5 203.5 94.55 203.8"/><path fill="#0d131a" d="M59.7 204.65 Q60.95 209.45 59.95 210.05 58.65 210.8 54.85 209.75 50.9 208.65 50.45 207.1 49.85 205.25 51.85 202.35 53.9 199.35 55.95 199.5 58.35 199.65 59.7 204.65 M52.55 206.3 Q52.7 207.35 55.3 208.2 57.8 209.0 58.35 208.5 58.75 208.15 57.9 205.15 57.0 201.95 55.8 201.75 54.8 201.6 53.6 203.1 52.25 204.7 52.55 206.3"/><path fill="#0d131a" d="M41.5 206.6 Q41.5 207.75 44.25 209.0 46.95 210.2 47.35 209.65 47.8 209.1 47.1 206.4 46.35 203.5 45.15 203.25 44.0 203.0 42.75 204.3 41.6 205.5 41.5 206.5 L41.5 206.6 M41.45 202.65 Q43.6 200.65 45.25 200.95 47.75 201.4 48.85 206.2 49.9 210.75 48.9 211.6 47.95 212.5 43.6 210.6 39.05 208.7 39.25 206.3 39.4 204.6 41.45 202.65"/><path fill="#0d131a" d="M128.1 201.2 Q128.25 202.2 131.0 203.1 133.65 203.95 134.0 203.5 134.35 203.05 133.55 200.4 132.7 197.6 131.7 197.5 130.85 197.4 129.4 198.8 127.95 200.25 128.1 201.2 M128.15 197.85 Q130.75 195.35 132.25 195.85 134.15 196.55 135.35 200.6 136.5 204.45 135.75 205.15 135.0 205.8 130.85 204.7 126.6 203.55 126.1 202.15 125.5 200.4 128.15 197.85"/><path fill="#0d131a" d="M121.75 205.2 Q123.95 205.95 124.3 205.6 124.65 205.25 124.15 202.75 123.6 200.1 122.6 199.85 121.6 199.6 120.25 200.95 118.9 202.35 119.15 203.4 119.45 204.45 121.75 205.2 M123.0 198.0 Q124.65 198.4 125.75 202.35 126.75 206.2 125.95 207.4 125.45 208.15 121.5 206.75 117.4 205.3 117.1 203.7 116.75 202.1 119.0 199.85 121.3 197.55 123.0 198.0"/><path fill="#0d131a" d="M111.65 205.1 Q113.85 206.3 114.3 206.0 114.7 205.75 114.4 203.1 114.05 200.3 113.0 199.95 112.0 199.6 110.6 200.65 109.25 201.65 109.3 202.65 109.35 203.85 111.65 205.1 M113.55 198.1 Q115.65 198.55 116.05 203.05 116.4 207.3 115.55 207.9 114.6 208.5 110.85 206.5 107.05 204.4 106.9 202.85 106.75 201.4 109.05 199.55 111.5 197.65 113.55 198.1"/><path fill="#0d131a" d="M32.85 208.25 Q35.5 209.6 35.9 209.1 36.35 208.6 35.75 205.95 35.1 203.2 34.2 202.95 33.15 202.6 31.65 203.75 30.15 204.9 30.15 206.0 30.2 206.85 32.85 208.25 M34.65 200.7 Q36.8 201.15 37.7 205.95 38.55 210.55 37.65 211.1 36.1 212.15 32.05 210.0 28.05 207.9 27.9 206.25 27.7 204.35 30.25 202.3 32.75 200.3 34.65 200.7"/></g></svg>''');

    return file;
  }
}

class TestFileSystem extends FileSystem {
  final directoryFuture =
      MemoryFileSystem().systemTempDirectory.createTemp('test');
  @override
  Future<File> createFile(String name) async {
    var dir = await directoryFuture;
    await dir.create(recursive: true);
    return dir.childFile(name);
  }
}

Config createTestConfig() {
  return Config(
    'test',
    fileSystem: TestFileSystem(),
    fileService: MockFileService(),
    repo: MockCacheInfoRepo(),
  );
}

class MockFileService extends FileService {
  @override
  Future<FileServiceResponse> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    return HttpGetResponse(http.StreamedResponse(Stream.value([]), 200));
  }
}

class MockCacheInfoRepo extends JsonCacheInfoRepository {
  @override
  Future<bool> open() async => true;
}
