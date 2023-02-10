Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C468691F93
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjBJNH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjBJNH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:07:56 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2095.outbound.protection.outlook.com [40.92.107.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9AD23860;
        Fri, 10 Feb 2023 05:07:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKImQl+wcfevkUGj3sH2eNz4Oddk9UfMAuNnlaZCX+oJ1CzBk3wvJXSxRBw4DvxJyod1HROvhQ4fO9rEyl24MvyN+mwAVlTORQNo9JHYSGixGDkpjTiD5Z5aEVWkF6wgKeAlT+yUzoN6xnj+tNGpq/QiC/stjkPwMmofFCDP13b0qE/jwqwUazAvL3XZR+0S1U9vYJIgliUaUY/PJrqiXJOniCUnlCd9VZ0U44oclCYtds9uDFPt+61LyOnEhWMxWO8mCi072xH7/fRpRTk2bUeZLRfPbBnn4i/2XqpyLCKlBeH01grwhRl0v/SCWkGGUK6GHZI/NXEPFYSCXMX3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3LnRX5rmLaUXCtPyNoOabiTBtYTp/pa3zb0ETGpuEE=;
 b=UiJmkw61lZxNMhjqZxA36yCYYsK+19oa1k69GrHX7M1AVhemZsJtLq4mo8TJMiV8szGo1m1Uq4/7pql6HoSv31MMsJTgXEfSU3P9BEDw9vq4xd5l8EkCaJbDiFBYd4iCr0AMZJ0VUlR73OcxF2s9OuI+X/IPe7bsuAsNxlPiDEqbZNOfAPv7UUlEvrMIiT8blEnDBoxDg6YGNFCpOQUvqBNfEzX8TrEOK2yBUrHnfJf+XEkkumLfnrK3kBFfy9LxA+Tu0ZnA6pB5KkhruL8gdW3EpuCl0ql6AR6kx59kJw2YPFj7gsDwQrM+1l1zl71OX1WDEyrus7IbB56995hU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3LnRX5rmLaUXCtPyNoOabiTBtYTp/pa3zb0ETGpuEE=;
 b=aeWyWYfTqOpvrRAK5VWgLL10F4aTZ1DCljNwVv5Hp0bw79zpUYw1Vke61kHkeyW4TgoAWXtAn73q+KIjJ6a+SC+/9N2RtwD89bFW68s8JnmoItt+4wD5wwQ/Q8EGqmI78jDVa1hmBEVeftRgs5VvmFAp2S242PDZpzvQ/tGgZmGgWWxJhmJdDKofqQom5Mx27g0AozIjc7QtezDxF3Ml7YuqZs83id4G4L/CYQel4GtFOWBCeZlAkKbirI86QKb/Li7xqnwMsBZVOFV1EAxtS1UE3HSSvQbLOdApmNR623Ht4gwRBCuFYCxN3kyiMABOWEJnwb6efGAIBtefey/Cgw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN2PR01MB4204.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:11::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17; Fri, 10 Feb 2023 13:07:48 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d%11]) with mapi id 15.20.6111.005; Fri, 10 Feb
 2023 13:07:48 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
CC:     =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <thomas@t-8ch.de>,
        Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>
Subject: Re: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
Thread-Topic: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
Thread-Index: AQHZPQwM5DSulXBskEykQ8jgSAssVq7IFbWAgAAEY4CAAA0kQQ==
Date:   Fri, 10 Feb 2023 13:07:48 +0000
Message-ID: <BM1PR01MB0931E8F14D84CFB59EABEBA4B8DE9@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
        <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
        <20230210045624.cjxroikmmvm3liij@t-8ch.de>
        <B9E319F8-6047-40E5-BD9F-D90D6504AA9E@live.com>
 <20230210232043.18483401@redecorated-mbp>
In-Reply-To: <20230210232043.18483401@redecorated-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [YH6ez02/umdkWNRwWEOKyL8PjvBi4i4jTdXUpveo6ViKqKARgAUR0eVUM0l2dymv]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN2PR01MB4204:EE_
x-ms-office365-filtering-correlation-id: 2843cd92-8cd2-44ec-b75c-08db0b67cf1d
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFZ/mTQMo+t8T8MR9pGfQwmkyE2JPnStNi1Q+I3JLCDJ+3X51LopPbaHTN/sMkNpWeSVLsCSiSXbTktHyzYf1nHxWku0zX2opVA+fwhSNSXpU6G+nlqjDJzxl9TfQnA5h0ES5z4XClPA2cFtjiSe/CRr5/jW2m86I7oU1cpcwqZKu1jwSWQ8UCqPDvZKVXa7dInAs9vrrtsuFtZnA5T5/Nel/cG5vG1rgy+IzjBl6E7aGmCBfe+LVm9E3CtxMr3Y1toKyqieZ5pcaUbKzNwpMXBhk5rsAVMkE4eaZvBcnnkp14cn7VPPtmQYIrWGrIHgp1vggAx1b/MMuKYUOwNMA6uoM3FVaPEDZ1is711Af3EAfQagT2TWxHXNg0yegsQTKd+NO8V1xg6fOKGsv59O6G2sKcL4do9lcfbUNYEVWF63erRtfFVN5g/xmuQu1NZy3zjA4ENpOZWM2OUMwZhmprr3iUJWwO/3IbwVFe3oObHNKLlC77krCeFzybn1rUjuiOvYzG0Qj7ZdiT970PnzAHN9FqG1nozZLtgCe7BCXXDjpmpiX3zvuMm574IQdpsCPh93aZl/k2qm/Dsi92lKjHJA4xPKLTSsD8KjrojYxAbrQk87UryVrPudF+kyY1o3w28Bj7B82l5etfZN9y07Mw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVlnZWYvbUlrNUt3YmZVbkE5ZjRqTHdYSGxJZzB0NmNqYTNSdkdUdktNanNZ?=
 =?utf-8?B?WnFsUzRMelZBOXNFVlRQNDAxU2UwMXdmVEMrdERjYWNjR1l2aDlHYUNHTnoz?=
 =?utf-8?B?STFRdzVVZ1JHQ1pUNytwRHNGRURRSElTcTAyMGp0VmZ5SDNEMmplMitJeFRy?=
 =?utf-8?B?b1lxLzNoMnlSUThIUEJVWDMzZURldmZ1ZnpqTGFjTldVTzVaNnB5MGVYbFJZ?=
 =?utf-8?B?b21sbHl5VHp6WnllWWRXSTRzV2taWVZjVU1jZVg1dE9pSFlBSEh1Vlk4R29v?=
 =?utf-8?B?SjhHZElydXAzSS8vRVZqUWs4d2srSzFFMENKc3dtRkU3Y0JoZ2c3MnM5K01r?=
 =?utf-8?B?MlZ0d29oNFZGeUNhckNMUFdSU2JpcUg0SzQyOGZpTXN6NVVSVEc1YXFtdVVS?=
 =?utf-8?B?OUdzNm01UVovRlc2cUNIRE1maWIvc25OcVdjUGN1b3huN01wRFFVM3hZcytu?=
 =?utf-8?B?K3p5NFl4MFZXN3ZZakRZVHp1WXUwemROaS95bkpTeEV2M2U2cnJPVUd2THNY?=
 =?utf-8?B?NUs4QUpSTnlDMFZnZjRHV29NeU1NcGE4WWFUZkcveUMybUU2Q1NaajhlY2xp?=
 =?utf-8?B?ck9NMFlvU21STmF5SG9WME5RSGZUSS8wWWppcWduNkZGUGZDWjUwTW1EWjRW?=
 =?utf-8?B?Wk11RUg5TUV3UXN5UzUxRVhhYVhWbXhRM1R0WTRnM3hnZ0V2L0hhTFExRkN0?=
 =?utf-8?B?aDhkbHdnVnhkTEx6TmlmaFc5RlNLVU1pRjVFNll3TFNQZW5NZ2VONUQzTU00?=
 =?utf-8?B?dCs5dWZ2TDBEelJKTGdSVmhPT2lKWHprTVJRQk03ZVZRQUE1WmlRakNQanJi?=
 =?utf-8?B?Rnh5R3IrdDRFU2ZWb2ZaVG5KbERjU1V4dzd1WjdMckhwZG5EZEdNZnl3MjZG?=
 =?utf-8?B?OTdyL2N1MTNzcnJwZmhUaEZHeSt0bWxHT3hadlFadUxRTlZIdXBmdEw2MTJa?=
 =?utf-8?B?YjFlQzFmUjNPTW42SmRROGNIV0FYVVRxT1pleWJpM1NYVUFSb3ppeXlOZDJH?=
 =?utf-8?B?OHExeGFZRU1qT3FpLzdNVEkrUHRiMkdINVlsRVpuQWJkVzNnaHVQLytzSlEz?=
 =?utf-8?B?dHp1NXd0N2tESzV1bFBwN1VuSjBaeHpsakF5UjRHZmZRa0xEczBWOHlCQW5u?=
 =?utf-8?B?SnZSWEI2MCs2S2NwTThmb1k1Tm4rcE5ub0FFRElXWlpJRENHY2J3TE5KeS9h?=
 =?utf-8?B?UU02L1FxSVBidFcrakVRUjByaFFNcTFLMHcrK0Z0QXZiN2sza016bnUxaHZ5?=
 =?utf-8?B?L0N4REo1TUgwcm5hbVV2RXVmZWszVnVtbnNmUm5rN0dmVnpWTkZ5TE1TUmVt?=
 =?utf-8?B?RitUY3E2L3hzQWNEWGlybnJnS2ovWmRqc0p5K2JpZEozMWZWYlFJemxVL3JX?=
 =?utf-8?B?OWpLUEp2c1pZeXVzZ2o0NGN2K3F0TFovdDk5Wk05KzlWOTh3ZWUrNDZEWGt3?=
 =?utf-8?B?OURVY1dlNkYycU1CRDU3aEF2SHA1TlFTYlBHQ1crekVLQXo1YUNwWDB1enYr?=
 =?utf-8?B?UTdzQVNEZVkrRS9uVFJMT3dTVEtqaVJJUGVaUC9jN3NYTWtoTFFBVHl0SENE?=
 =?utf-8?B?RWRZNGxtTitXd2c2dkttU0pjYWpPVVpOS0c2Ym9yNEp1cGxhaSt0T3pMZ0pp?=
 =?utf-8?B?cFQrc0xqeXc1V0FQMTBWUEEybHRYd1ZGU1ovVlJLVWZiOTNRZTVROENjWWEw?=
 =?utf-8?B?Y3gwMzliczhLTFZ5MkZuN1pCTURDcXAwQy85TXRXa1BoR0ltVHRPZ05GTmwv?=
 =?utf-8?B?cWIvUHgvalNmOUdQaFhrTlpoY2RLM1lYZTl3NGVUdnNHWEkvdm9YUjV0WTQ5?=
 =?utf-8?B?WlZIbFlWcHVTaGVpb0gzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2843cd92-8cd2-44ec-b75c-08db0b67cf1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 13:07:48.6800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4204
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFdlcmUgdGhlIGNoYW5nZXMgbmVlZGVkIGZvciB0aGVzZSBzdHJ1Y3RzIHRvIGJlIGNvbnN0
IGluIHRoZQ0KPiBsaW51eC1pbnB1dCB0cmVlIGZvciA2LjM/IElmIHNvIHRoZW4gaWYgeW91J3Jl
IGFwcGx5aW5nIHRoZSBwYXRjaGVzDQo+IG9udG8gbGludXMnIHRyZWUgdGhhdCBtaWdodCBiZSB3
aHkgdGhlcmUgYXJlIGVycm9ycyBhYm91dCBjb25zdHMuDQoNCknigJlkIHdhbnQgdGhlIG1haW50
YWluZXJzIGNvbW1lbnQgb24gdGhpcy4gSW1vLCB0aGVzZSAyIHN0cnVjdHVyZXMgbmVlZG7igJl0
IGJlIGNvbnN0YW50aWZpZWQuDQoNCkFsc28sIGl0IHdvdWxkIGJlIG5pY2UgaWYgd2UgY291bGQg
Z2V0IGEgcmV2aWV3IG9uIHRoZSBvdGhlciAyIHBhdGNoZXMsIHNvIHRoYXQgYSB2MiBjYW4gYmUg
cHJlcGFyZWQu
