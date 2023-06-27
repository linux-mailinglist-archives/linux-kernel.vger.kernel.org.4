Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A831C73F977
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjF0KAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjF0J72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:59:28 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2052.outbound.protection.outlook.com [40.107.9.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EF84219;
        Tue, 27 Jun 2023 02:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjGEThWUhsy3l2MLzVCL2F1N4KJA6Si7WIQnMurA6oo4TRTgApddQN1TvOTF3jm58mxPHZzDYWd4ugxOXgwzr0sOQR//dbPk739zXC/HJHkQPNr1yK42nfiDQl4i3hDAyaWllKU9hu+pq2qrRVhRwiLz23O2AHTWADU9ou+VDrCg3ktrP0gPU2bTWZ6Wr8BhIhVmpXMi5tLFspXVCYF/EPodIsPdHHaz+Rn3dV1o5af6v25lYetW8YjOn5d4Bkmonxp9obPpCkScIR0yjfQrbJRBdSsFbPk7FI4mrayA4TtOWueiC9QsM8NXZE5kr3A6HTV7iwO3X3Aj8r4OGgWNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3Zhj7+tWYHC6UVV5nwuNAuGxFrZKhrV3EYNw79Cy4Y=;
 b=Wlp/n/NZ0AkK/QwTP2C3fNrOhUiATid/YsGTdvUILX6n+m//xo+buuOlAarr3nOlol4Nnv+yZCPO2pASWfr0n43/ANLxf9sCkBzyRg8kLT5QuTG7gzx9Z+iUonRIhbtfEVuBT/PiAdTU/X5V6we/cXwsTFbdoJy+s5EuDl6LOyUkQq/WXY+EQcTSu2qudH6GRNSbLFn1AqAMniRIVuy/CHCTgJ7ERW/dri0udNmxSYWPd3U/tQGknVnUBfXg64T9zlqBp9Bhl7JpYzF9eZi/PaFQWd3iYk7L80IbQqn32Or2KBOYFpFsVoBgClN3+zdnYT+RhvopyT5enx7tE3tNzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3Zhj7+tWYHC6UVV5nwuNAuGxFrZKhrV3EYNw79Cy4Y=;
 b=VRnaCVMdsFlIohq0lrUAd/9ybkGOQG19ZPwBGj6YHXw7/7BlwIuzZwwx137nxmd6XaSeZXTXED2mOD0FVGL3O7cOj4oTPhMrj93lITn+GFT4+kH5Q1SeDcjeu68YEs3lRiRBfM6xQf9iFbtsF+iNckXimPkk6j0GFmFIchbltY2K2ZbkVi2BnU2ON563bDUhllBJJ/SSUK80tTTNeEY+xChjgHyrQT1Vjx4mLt1l1oCq3rPj94WIJYpqnWcMV/gqyHcobp1OFjy+izihZx0GLqZaTo0DQoyLvqN8EnLxkuJSx7GBVmO7d8DAJotpFsiBbXokc9Na0J79Fg4sXiYohw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2423.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:57:30 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:57:30 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 08/13] iio: inkern: Use max_array() to get the maximum
 value from an array
Thread-Topic: [PATCH v6 08/13] iio: inkern: Use max_array() to get the maximum
 value from an array
Thread-Index: AQHZpbDyR0q08AzsJkm6oZ3roa5GJa+ecC+A
Date:   Tue, 27 Jun 2023 09:57:30 +0000
Message-ID: <f3a765a0-63bb-308e-44d1-f00e85cea97a@csgroup.eu>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
 <20230623085830.749991-9-herve.codina@bootlin.com>
In-Reply-To: <20230623085830.749991-9-herve.codina@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2423:EE_
x-ms-office365-filtering-correlation-id: 3d4499b2-8bb2-46e2-9875-08db76f4ebd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QYt5M27GNcxup1TYIzxAo1xv6dKdcKX8h80tW18YZf2xKE59PxwkltGboWrkWUHbkVJuS5874RrVxR91Rj2YvEMJ7uEjaWwOKk+Jb66z48qEqKoVLfVH2BIHrYNqierK65LHHCdbWStSxl+Gq8xC3yqFpYUllN7IU2G/Uj78JGGpg0Swg/Evn89n/KHjM2SyF7NwO8wgp5rp1fkyeA0JhoSiunGkSZENyhnVPrwfgBzPDGgILaelRl2Npg3pxYL8DJOkXOJ+O+BIaC1aoTIxo+nnAMIt1+6XAkDLGPmBmjxLtnTBrXVS8KDY8Nn1W5dtWCUjRVuhwaoNH6BnehmeCZKs5IMGZPyPKFPwQJYy8DOyinn7gJwwwpWgjQsUeH+9kzxX1u839QsSGXFIblY6MFOmihknJgVnV2VZOSqDokLLT4Gqk2TDwdLc7LMY9D73GEm1pdKoIXRWWGRgSjTKmz0L1X7+mGfmdAOUcCP8LLsSjoCsGFw3+l6T8nm2aOcfTgSXeEL3Jy8VbCzgXcR/dWMtu7Th77GqAR4cRokOjMwIhqoF4zND0mdHGcjXb3wZi8dZA/srrCHaVAthQ1eNDzMCKQRKnXLN05WnBUr5DoTTgYS7PoOJlIih6QdQddK2mHOEo5QNt4I4dp4Cv/IHLw4+sfZNNMmql5T0tE7tykH3/GgxtRR7982pT72nyCqqZMTwvtEe87+QW3whgb+/iA7f1A9Xff+h1u+uB9305H4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(41300700001)(66476007)(26005)(4744005)(186003)(2906002)(38070700005)(921005)(38100700002)(71200400001)(122000001)(6512007)(6506007)(8936002)(5660300002)(64756008)(83380400001)(44832011)(91956017)(76116006)(66446008)(66946007)(66556008)(8676002)(36756003)(7416002)(2616005)(110136005)(6486002)(54906003)(31696002)(86362001)(4326008)(478600001)(316002)(31686004)(15583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDNvNXdVVE4xb1lxMmRjbUh1bUJJeHdydzNXcmpyUThlY1pOYVoxMEdIQzlX?=
 =?utf-8?B?UGdBalhzN1dLMlQ2UVNJemlDbXNQMHYvNW54bmJNYlA4TG9GeWlWMkRsclBm?=
 =?utf-8?B?L1BGRjI4bHk1OVJGUnI1K2RJWnlmQnNKMGx3aGRTaHNWQ2t2bGd6ZHNVanpM?=
 =?utf-8?B?VFh3b2VaN0Y4cFczMzd6VjJGYkNpeWJOSVpkTVRtVjFCY3RUWmhuNURjRU5M?=
 =?utf-8?B?c3JlYUZWS29WSXlaRXVYTS9ZWmtWYTE0N205Z29zbTBqTU1RVGlKaFI5QXNS?=
 =?utf-8?B?ZmROSlh1WUh0VHhqdkdaZVB4cjFMeW1rMCtzM3RNQWVzd1dSVzlTYksxUTdR?=
 =?utf-8?B?V0pObnJzTURsL09Zbjc1ZFl3Z3d6enEvWW9BcXB5eTVPbEJHZTRwMlV0Zi9V?=
 =?utf-8?B?dk5yWUdFME8wc0paU01Mc040TzA2eURoUjNtYUUwamNDU2lUMldxN1VsZ25S?=
 =?utf-8?B?RllHY1ZkaUdrV1ZacDhSSXZtb1hzVk0velp5VEEyN2tFUkJHeS82VEZramNT?=
 =?utf-8?B?NHBnUTg2QVQvTG42akFJUS8zamVucFRzckwza1hPVkkzQ0E4dGNIL3hqZFNn?=
 =?utf-8?B?S3h0WmZDU1RlOUZNM1JHelF3dFlFOWhPYkJmVDBZY0dOYUFObTYyeDhWYjhz?=
 =?utf-8?B?SG8wMHlOZy9iOVFuTG1QZVlJb2ZxN2txNmdvaXBZMksvWEtwNmFvNGxiSTNY?=
 =?utf-8?B?ZFZxbTZVTHhsOGRlVC9wV2pPK0JGenpFYll0N1ZOOVlyU1p5aENCT3hiRzh0?=
 =?utf-8?B?dGFseGVQRTJvbWMzRGxBeVdnUDMyZytiUzFLNTRVWVowcGpSNE9nbjBlQXZ6?=
 =?utf-8?B?UGhDVGlOY2IxR05jNlRxS2NlNmpudjZOTDQwMW8vSkJCbmVuL2pGSDYwTTMw?=
 =?utf-8?B?TFBQaUtYSHd1UjhXSmtvTzJwTUl0Qm5NNDY5ODJ0cGttTmVLWkVnVHhhN1cy?=
 =?utf-8?B?bHhSVUtOQWRsNi9kYVY3YnhqdnFLUVZjdW84R014Q3c1Uk5PeHAyY2pEdzJP?=
 =?utf-8?B?K2pycFFJeVY4NVVMZTBrcDVXRm9JZlFaYXNWbmtEZXJlQmNscytDVlllQkhW?=
 =?utf-8?B?bUtselBOd3oxNW5PVFNNOHJuYU04Y3VJWTlhTkZQUUZKTFkxRS9XbEhtRjg5?=
 =?utf-8?B?SitVT2JtMHBjc0JsOTk1M2Iva3VqUENTdFE1bnNUZ0YzK2M0dFFGVFRmcUtV?=
 =?utf-8?B?OEx3eS9jYXpGUnFPSUl1Y3F2enl3Vk1Za2R2YkFFZTA0NG1TYmVkcVRyb3RL?=
 =?utf-8?B?VE1kalRqeWZFMHdCZjRkeWZRNGJBb3Q2YXl4NDI4d3NtcVZrUC9NaGVqWXo3?=
 =?utf-8?B?NVc3cmNmUkdPZ1RaVGpBV2ZscXQ2enN2K3EvTlg1eHBrNHZIRStIWnRydFly?=
 =?utf-8?B?elV4eENkbFpBUlNTMENEajNSNitoL0xQQ1hwelZ4bklUNnUzdCtTeS9WRnhJ?=
 =?utf-8?B?anZSdU5FNldnRmYyblJFN3BZSkYvQjFMTm9UbjMycHErZWxEcDJ1NWpFR2tM?=
 =?utf-8?B?KzFRVFNHYlBYR2VGUkliU3BxUzNqVlZXU1hIdytCRlN4aWMzQzVRMGo1eS9F?=
 =?utf-8?B?M0MwSXZCT3hUTG11WkRpRVBPSXVGYS9hLzNHT3o5OVk4K1B6TnBVeTJzcFhv?=
 =?utf-8?B?dmtQQU9uQUVRU1krUkhxcGFXOWZWR2dkRm91ZEt0VG1CcDZ5V2tSNXpoUnA2?=
 =?utf-8?B?VDhsSUNrYmFBK1BhTFdEMk5WOFJCYkFDSE51K2ZUVTFRMms5eU82VkZWdkxa?=
 =?utf-8?B?cHAvZXU2bWlPbUdlQmh2allsOVNUU2VHVzFYVDM2Z2dRRnVGUzN1bGUzeHBF?=
 =?utf-8?B?a3A1NWVjcHkwMThXNnhOQ2JKTmQ0NW10WXFnZGs3bm5ZcHc5REdvekkwK2ti?=
 =?utf-8?B?RnloRTdRTFd3c2gwUDdQbUFNKzIwVXFxT0R3MlhiSWwyaDBzUWlsU3ZVTFJW?=
 =?utf-8?B?Y2U2MTBwQ0JRL3c4MkozR3ZtMVhRZi85ejV1YTJSeUFSK3d6VXBhTmc1S1dm?=
 =?utf-8?B?MGtSR1JiQTJXNHJXNlVlTTBhRTNyYzhaUVJZc0l1bW5GeURvSnB4Z2prc0ho?=
 =?utf-8?B?M3VCNlNHS3lSSjljSkFCaHZUaWlRc2NObHNCYkFtREtQVXRZT0NzRWRjeEZL?=
 =?utf-8?Q?/eMNr3AezeGeydKH1NsvTHxTC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C036485721C40D49AE79C4F63FA8B9DC@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4499b2-8bb2-46e2-9875-08db76f4ebd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:57:30.3516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4uYhVUO0V8JlgxBiR7ixhGDg0S/rfYy6+Gc7Cn8BN/SZfWRRirShxCBd9dkt1+m4qUiCS3pu44ugRAo9GuplwcR8HCR8NyXyhv2baBDE3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2423
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA2LzIwMjMgw6AgMTA6NTgsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPiBV
c2UgbWF4X2FycmF5KCkgdG8gZ2V0IHRoZSBtYXhpbXVtIHZhbHVlIGZyb20gYW4gYXJyYXkgaW5z
dGVhZCBvZiBhDQo+IGN1c3RvbSBsb2NhbCBsb29wLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGVy
dmUgQ29kaW5hIDxoZXJ2ZS5jb2RpbmFAYm9vdGxpbi5jb20+DQo+IFJldmlld2VkLWJ5OiBBbmR5
IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IEFja2VkLWJ5OiBKb25h
dGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQoNClJldmlld2VkLWJ5
OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQoNCj4gLS0t
DQo+ICAgZHJpdmVycy9paW8vaW5rZXJuLmMgfCA3ICsrLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL2lua2Vybi5jIGIvZHJpdmVycy9paW8vaW5rZXJuLmMNCj4gaW5kZXggNzFkMDQy
NDM4M2I2Li44YmZkOTFmNzQxMDEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2lua2Vybi5j
DQo+ICsrKyBiL2RyaXZlcnMvaWlvL2lua2Vybi5jDQo+IEBAIC01LDYgKzUsNyBAQA0KPiAgICAq
Lw0KPiAgICNpbmNsdWRlIDxsaW51eC9lcnIuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvZXhwb3J0
Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvbWlubWF4Lmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L211
dGV4Lmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3Byb3BlcnR5Lmg+DQo+ICAgI2luY2x1ZGUgPGxp
bnV4L3NsYWIuaD4NCj4gQEAgLTg3NSwxMSArODc2LDcgQEAgc3RhdGljIGludCBpaW9fY2hhbm5l
bF9yZWFkX21heChzdHJ1Y3QgaWlvX2NoYW5uZWwgKmNoYW4sDQo+ICAgCQkJcmV0dXJuIC1FSU5W
QUw7DQo+ICAgCQlzd2l0Y2ggKCp0eXBlKSB7DQo+ICAgCQljYXNlIElJT19WQUxfSU5UOg0KPiAt
CQkJKnZhbCA9IHZhbHNbLS1sZW5ndGhdOw0KPiAtCQkJd2hpbGUgKGxlbmd0aCkgew0KPiAtCQkJ
CWlmICh2YWxzWy0tbGVuZ3RoXSA+ICp2YWwpDQo+IC0JCQkJCSp2YWwgPSB2YWxzW2xlbmd0aF07
DQo+IC0JCQl9DQo+ICsJCQkqdmFsID0gbWF4X2FycmF5KHZhbHMsIGxlbmd0aCk7DQo+ICAgCQkJ
YnJlYWs7DQo+ICAgCQlkZWZhdWx0Og0KPiAgIAkJCS8qIEZJWE1FOiBsZWFybiBhYm91dCBtYXgg
Zm9yIG90aGVyIGlpbyB2YWx1ZXMgKi8NCg==
