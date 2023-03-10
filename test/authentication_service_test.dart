import 'package:at_client/at_client.dart';
import 'package:atsign_login_app/services/authentication_service.dart';

void main() async {
  var atSign = '@general57';
  var namespace = 'buzz';
  var preference = AtClientPreference()
    ..rootDomain = 'root.atsign.org'
    ..rootPort = 64
    ..privateKey =
        'MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCN2nKioRBTLSjTVu+VRFeHeX9GKYbq34LR51c7VYuwc1F8+SslOS96RXmccDaHLkLRN5DtXg4pn/sSuZvthvw/X2vBBvVius3oNzbxAsXwBAwJNtRL7+p7PCRJ7a88uuD9VzqY1OsrhsEqrkUjfNKGH4LjrPTdGuourT7eOxh3DcNEzKPk3Fs45n1LiOmUAnCxW373oQ7zwgvuGcty3PcG5t7LxLpPqVhhT01z6k6k74cBSEqze+rPKOGCYffRReW9vTUCQyUQDc6ipaBSFNq898kKI/Z2cF7JXQuocuCGxf3vyEoP74rt80fhiFp/sWfqR3AaEGZq2DUWeD9Xyq09AgMBAAECggEAbH8emwDyCYxK44pk6RhCkl39WN6+ULrvxjhZYgqGM0mglCPIOkpI5A5re5ngOvjJJliHwuXjkzbHxISunLhYCuii9BqsaP1ULD6/CQwD9RZDVnDXY9V21Rck8l6XX63YFC05pleEH+CLsmdkfkYkh21moVlSWCMT5uufYD528eczXJNKljy9xwREY6bV4cwI90ogZhWeqCLwgLPa1pVOj5dPewRdA7NkAAGIqLvh0vlF9dQddyy3VCmCL++Zp2EmQTNyNYl06kocAKlu7LJh4oOBFz+sAM37+eEg8sBtHg8uGL8JW0sThEAjC+9FPD68t1JRpYwhOsr5/T6WC65cAQKBgQDBwc+7xp7pXVho7NSAKCVfCVI6wsmCGP1eoE8tELzRuIY5QeXpLtN94DyUOwV90obDmtY5MIy3w2oIfiNO9Sels8fz17ReYeTJS6E505wa1h0b5Mmy4iy4WxDDzz0nvysgfBVfCHgTTBBjv8/pEdPWaLCQMdD9cLFm2xPsUw4/gQKBgQC7bC0XdrBQcrH3HeD4AlnFXpmtXxFRevXoDEPifWBgmwanTc+zG7SrPvLKVGshYJ3kobqQB2b1grzDIVilk3hh9WsuYy1Uaiie+pda49TRZ4lc1mmzmLUgZmgr7F1iamiUVrHgLhBr9f4GGAFOPla0YJzIo8r5R43fqqcjrytLvQKBgGNbhrItBTp4QqjzoXjinV9hwUgesQTE2dDXdiKO7bTB4hqkf0iXWZ64CXid15AREEhoMyh6i/6D9/DI9kQ8FQu06HlTiMvJeW/8F3421FsypxSxuvi/YN1c3Xj74clrD6uF1dO43RJQNCtipjRHjxDo+HnJAfmk+2PaPho28RyBAoGARXS2VS6v8nA+0YRqHZ7JY+JF80D66wY1YTRCaAnskICC+7dTVF3dG2UtlpuoQ+tJODRTLhMALdWwXGPcNSgsgajwenVYlCLvQNM/CfjKonvLJPN0opDh9srcqgJjLRif/vEN5DVN8qRr6hg1S6jAewIeuCAzFSRWSGA2pnvBAMUCgYEAtRT1tgQkVwJVauS+khGvO85Bqg+2EbJVmAknn31SvGL8BpFl1pKjS8ms1KWL07812ozWtckWc7Q9RDppCXvtg6HvKmkUhx2nR3lEH3s72j8HXsH3gy4lPyOw/9cEDQ0Xft93lAojcAdl6Boau40Cv4DGFjBjNRHB36WChX4Va5A='
    ..isLocalStoreRequired = true
    ..hiveStoragePath =
        '/home/sitaram/IdeaProjects/at_auth_proj/atsign_login_app/hive'
    ..commitLogPath =
        '/home/sitaram/IdeaProjects/at_auth_proj/atsign_login_app/hive/commit';

  var authenticationService = AuthenticationService();

  await AtClientManager.getInstance()
      .setCurrentAtSign(atSign, namespace, preference);

  //authenticationService.atClient = AtClientManager.getInstance().atClient;

  var encryptionPublicKey =
      await authenticationService.getPublicKeyForAtsign(atSign);
  print(encryptionPublicKey);
}
