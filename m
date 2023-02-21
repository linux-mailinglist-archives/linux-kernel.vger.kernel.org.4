Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5CD69DCD6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjBUJYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjBUJYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:24:42 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2099.outbound.protection.outlook.com [40.92.102.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAFC193C9;
        Tue, 21 Feb 2023 01:24:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0VVflVR7XXyrz/AFVCu6OCB3eczcXvYt/H1WsH2dhOwi+eqUPYQPQ78UVx8wgINCbtjMf3X5cAT8c4E+GdIB9HF7FyXVtoZozbm8SNNa4iRUVO8SUCoL+fND/CICX1p3BInIPof7ef78NRTliRTrIGr/hHY4RMfz0sH24Zk8BdcAC5j8Lq2g+OY43tO25098LbO/5SFz/38Wsd+vW1RW/p3jSFTisE3ynokIwqFSYDtniZ6eCkoMqqKGETgFkoVe+0yfgv0mHdhALGmuMKh6oogVwIwxlXXy3iBkRFj5PjwbnIhj/3xJcipwbXw7OMz5J5TJeKo2eF712bmNk7fOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2A3E6QbkGOHI35I9fH9WptVm4934DbNqcRjYPh1sKg=;
 b=cnzEeNhBCArdWBaOBbx+wp2opRRbNh+d/Bi9Sah1axj1U3ot6G6QGhNFJcI3IvvmgzEE0N4ogXC0wblP/YAo6m0tDbGnLqXcas+STBWmL63w8o9+56Q5ZDaLa4mkSHmOptDtfLImsARWGBmm8BU1dPAPlikv9MBI9ykxP09+reuOJFRHxJ1JBTm0dF0g2I+itjFC4mGk5X9FZOZf9hJjiDEmxamJe0KpK8zUJG+G2bAEFSMGThdPiRdYZoyg+kaiGuK2U8EfCo2Y+OUmCW+vOfP1/gOYJUFMwn2X4GsemsRZXS2rhBre6YDCvthsKxgrCrWNbTT1xhjJ+6L/JESm9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2A3E6QbkGOHI35I9fH9WptVm4934DbNqcRjYPh1sKg=;
 b=avgpsgJgE+OW8DVtUfbEkHSA8+Go2HazI3jpoJ5y6zQbVgZtcnFu7ICOnmG7Z41WoJ+DCjvU3MsB8+5cNTxEhXkilBGcIj/K4ovxslOFtwg96IedD4ZZf4nbk0PACE2NdidUY+pR34qhI/7Z+JpXpbK97/Ug2Wdphp37maO9ai7/WhJ2Q2zepLycHUWlcQU/Yj7GP9J9tw96Db2xN111XyGQHLNkX5M7WKsehqhY5LhJe0Np7EWOOlBFt1lzaIWaO6M5sjT8uyo+99s4sRmyr+2HnlYguGiXLR9s2pQolcdkbDaPHvvh4gwUR90zrU4aHwgjBlbVT0h1cm8PwusjBw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN3PR01MB7272.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:8b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.17; Tue, 21 Feb 2023 09:24:34 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f156:868f:a45b:aeee]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f156:868f:a45b:aeee%11]) with mapi id 15.20.6134.017; Tue, 21 Feb
 2023 09:24:33 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v3 0/5] apple-gmux: support MMIO gmux type on T2 Macs
Thread-Topic: [PATCH v3 0/5] apple-gmux: support MMIO gmux type on T2 Macs
Thread-Index: AQHZRdZPnsOA0zlv+UikzIJmE+f5TQ==
Date:   Tue, 21 Feb 2023 09:24:33 +0000
Message-ID: <BM1PR01MB0931B467250831916F7C55B3B8A59@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [BtS69z0zWqszpAFEsu1ZpbIzOs3GarMeQXM7KLBB6QAPXVcFp1eudw2WJ+OE+o2z]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN3PR01MB7272:EE_
x-ms-office365-filtering-correlation-id: 7b8d8ff5-1911-4d74-aefe-08db13ed71c0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XW6jRx50cJQTU6kUUyylklociABdgUY/3Ws1/9RLq3qLVRsIoE/56jjm6Sloke/N5HYMVnamZuK0aoC96GgSQZFfipzB6OBRZO2HBUJ4E+mSK+o5wQ/iktnk84+Bq6IdYB1/dS9MgaigGuoiXeuvLM++7Wdota4PeWQydCsICopFMDmTJ2HjP5OleX3yl6YdZeuYRlSOThBx7dAQj7RQjzz2mu9XYr7Q1fRtujVo+luCxGk8CHP8ncldo8z2cN7Cq7QEPDgIPXmLjlQ+FbnJofha1L3/lzoCzGRdVtS5NkxjdJ3Wb2ImATGJEBbdoSn61hNyOIC3+k+hhKh/jXi5cETaXTgfi/qc56r+5p1iAakgSRqjfFQHz8fvp7gH5hDebRDUyZpDRFdLxddlJOvOOWgEjT4t6vK6XLAgZfZ0p+rn7Q5YQ9XA/aLjnxdSApUAa1yujNE/s44UGfkQXWOV3v2RYJUN+EI9notdvUtt9eSkso+kAwYLrt+Kn0J/2P4ZUAAYodTNJineefK+VIvpcHUmBTOnGOD7ftKED3SmaRKz37xbNrIUeixcVQ+a5R5Wug0DrY5XYUctbykll9UwN32V+uMeyo5rMapaIugklVkpS62Zo4y+fegDiqDbxbtaGzoNHmfrw1/OD4HerQsTwHDNaUPd55foGdpluq+Xvvs=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkxwTm96VFhHdjZidiszTmtETXBLcXA1b0t5SXdGWGVSaXFnQ2RWRXJ6anVI?=
 =?utf-8?B?RXpzUjd2S0dMTFpJRlFHbHMzMWQ2Z2R0VG1yUnVoUUxRdUI5a0ZyT29JeEJY?=
 =?utf-8?B?bWNFY3FoMlpBbzljWlM1cW8vVW9hcG9XaVdTV2JjMWhBRjBBQ3ZrWWY3VjN5?=
 =?utf-8?B?OVg3eTZycnNlSzcyaHhCSTNZSlZRUTlZenF2WXBBYlZqcXJuM2ZZN2VEZkNT?=
 =?utf-8?B?UHcyYTgzVEQ3bjYwZk1ML1NQUlQ1ajJDYk1uZEx2ZUNWckw0MEoyc21manRs?=
 =?utf-8?B?RWgzTGl0V1Z1MC8wWFBZeUVCTEFWcmk2WlRWd3p5NnVBR29uNXBadGkwNXhI?=
 =?utf-8?B?ZkVzZDgrQy8ySGVyWkF6QnJES3pLbm9ZcEx2UHhlaVB5M0tURXFHL1I0ays4?=
 =?utf-8?B?TWtPOGhhTWxCSDhzYXQrOGg2OVBXb3VmRVNERDVBc1lsMEYwTEw0TXVicElr?=
 =?utf-8?B?ZEwzQ2tPYVJHNllsK0hMa29rc0lEVDIwYWxzSkltOTJmZHF4Qk81M3pwVXFX?=
 =?utf-8?B?V3luTlN0QTR2dUIzV24yOE4zano5MWg1a0xod1pmV2ppUHlCSjlzOGRxMnAr?=
 =?utf-8?B?MUJoc29rYVA0R1VXTHRJTEgzckNFK0lrMTNoVjRka2l5V1luUE9malB4TmpX?=
 =?utf-8?B?bXlhRmZJeHhUK3pNTVVGNXhOSE1OK09VSEhmdEsxdkRUc1dyVWJuUDRVbzV0?=
 =?utf-8?B?R1k2MnpSK1FLd1ByQUZPbnl5bytnRFNSVDRLTVVlMmF5ZFYyUzNnWU9KUmhD?=
 =?utf-8?B?Mmt4QzNoYlAvdWJxMEpMMUVQUFVHb1dxb3dqb2s1MnNIdE5oZjhoWWVyWjU5?=
 =?utf-8?B?ODZVK0VUUUswMm1zUEcwbXhiUkUxamhueGtXbHorSVJLZUQxbmNTVkNaV1VC?=
 =?utf-8?B?NzNnNkwvT1kxdzMyaHpYRXR1Y1FqbFYwTGp1WVNIMDI1QVZKQnVVV2JEWk5S?=
 =?utf-8?B?OTkrdExPbkhLcGZLQ0Y4MHlvRllDOG9mQ3ljOGkwMjBTcDcvUVlrbEwvSS9W?=
 =?utf-8?B?Rk9nejFNUGlkbnhQSkdjcTBoL3Brd0orZTJUL1B4WGY3NHZMajZoSGJyV2NQ?=
 =?utf-8?B?ZE5pNG1sdkd6RHN3cUVKSitGREVDTS9vcFNxcWxxZzlQMW9rMk4xZGMrK21L?=
 =?utf-8?B?QmNsQVBDZGJ1ZUxtMlhTMXoxWG1nd3JxNE1tREVrR2dVTWxRTDhXKzhTQm00?=
 =?utf-8?B?aXBHdkpRVm1FdEw2aFgwOHBQWDM2U2pPbFhIZ0hxek9Wb1ZnZlh1dmc0a3lJ?=
 =?utf-8?B?L0J4RFlzczBTTGJmd3FpWExxUjh0NHQ2YTZwUThpZnRROUkxb3N1SWlkVXZ3?=
 =?utf-8?B?Y3g3N3dvM2lVVlZ1ZVo0SldvY3luWWphSGtzSDNpblpuQXJoOUlFak9Valdt?=
 =?utf-8?B?NDhjV1lqQ1BseGNxSFdsRDZMMjlka0lNTEFqTktIUG56OHFkTGRZS2JmLy82?=
 =?utf-8?B?Mk1hd2RzRUZpQm15cU52Mk0rbjh4ME9XaWhtQzVIZll5UlROaHB5c0IvdDhz?=
 =?utf-8?B?NksyR1NSV1BtSkV4UVFJWnVjNlk5RjdNL3pnRmRaL1JzVHdGdEdOTTNwNjlj?=
 =?utf-8?B?MWYyNXIyY1ROQmpFTGM3SnM4TFpabzdzcmxyZStrZ2lYeDVVaFFxOWtoOEl0?=
 =?utf-8?B?K2QxTFM2Z1pNdHh4RmRYTmJlYU5wS2tSUHpKWjkvTW9EYXArV1BaQVRjMHcv?=
 =?utf-8?B?eEFBYnFjWWhteGxuY0w1RkQxS2tvNTQxRkpYamkwdHo5d252UVE1R2pRN2F5?=
 =?utf-8?B?S2NXUWg0WURVc0RsdTZSUUk0VG1RTTZWNG9keVd0SlRSaVdlNnBKNUhVZWFm?=
 =?utf-8?B?U1RkbThuZVoyUUxJaFBLQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE67D70AFEE28B44B2A4D13879C99665@sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8d8ff5-1911-4d74-aefe-08db13ed71c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 09:24:33.9062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7272
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDE4LUZlYi0yMDIzLCBhdCA2OjUwIFBNLCBPcmxhbmRvIENoYW1iZXJsYWluIDxvcmxh
bmRvY2guZGV2QGdtYWlsLmNvbT4gd3JvdGU6DQo+IO+7v0hpIEFsbCwNCj4gVGhpcyBwYXRjaCBz
ZXJpZXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgTU1JTyBiYXNlZCBnbXV4IHByZXNlbnQgb24gdGhl
c2UNCj4gRHVhbCBHUFUgQXBwbGUgVDIgTWFjczogTWFjQm9va1BybzE1LDEsIE1hY0Jvb2tQcm8x
NSwzLCBNYWNCb29rUHJvMTYsMSwNCj4gTWFjQm9va1BybzE2LDQgKGFsdGhvdWdoIGFtZGdwdSBp
c24ndCB3b3JraW5nIG9uIE1hY0Jvb2tQcm8xNiw0IFsxXSkuDQo+IA0KDQpDb3VsZCBiZSBhbiB1
cHN0cmVhbSBidWcsIGJ1dCBJ4oCZdmUgbm90aWNlZCB0aGF0IGFmdGVyIHVzaW5nIHRoZXNlIHBh
dGNoZXMsIGlmIEkgYWRkIGBhY3BpX2JhY2tsaWdodD12aWRlb2AgaW4gdGhlIGNvbW1hbmQgbGlu
ZSwgaXQgc3RpbGwgdXNlcyBgZ211eF9iYWNrbGlnaHRgDQoNCkhhbnMsIGFueSBpZGVhcyB3aHk/
DQoNCj4gQ2hhbmdlcyBmcm9tIHYyWzJdOg0KPiANCj4gLSBBZGQgIiwiIHRvIGxhc3QgaXRlbSBp
biBhcHBsZV9nbXV4X3R5cGUgZW51bQ0KPiAtIERvbid0IG5vdCBjbGVhciBpbnRlcnJ1cHRzIHdo
ZW4gc3RhdHVzIGlzIDANCj4gLSBEb24ndCBjaGVjayBpZiB3ZSBmYWlsZWQgdG8gbWFrZSBkZWJ1
Z2ZzIGZvbGRlcg0KPiAtIENoZWNrIGZvciBmYWtlIG1taW8gZ211eA0KPiANCj4gIyAxOg0KPiAN
Cj4gaGFzIGEgc2xpZ2h0IGNoYW5nZSBpbiBob3cgdGhlIHN3aXRjaCBzdGF0ZSBpcyByZWFkOiBp
bnN0ZWFkIG9mIGNoZWNraW5nDQo+IGZvciB4ID09IDIsIGNoZWNrICEoeCAmIDEpDQo+IA0KPiAj
IDI6DQo+IA0KPiBpbXBsZW1lbnRzIGEgc3lzdGVtIHRvIHN1cHBvcnQgbW9yZSB0aGFuIDIgZ211
eCB0eXBlcw0KPiANCj4gIyAzOg0KPiANCj4gc3RhcnQgdXNpbmcgdGhlIGdtdXgncyBHTVNQIGFj
cGkgbWV0aG9kIHdoZW4gaGFuZGxpbmcgaW50ZXJydXB0cyBvbiBNTUlPDQo+IGdtdXgncy4gVGhp
cyBpcyBuZWVkZWQgZm9yIHRoZSBNTUlPIGdtdXgncyB0byBjbGVhciBpbnRlcnJ1cHRzLg0KPiAN
Cj4gIyA0Og0KPiANCj4gQWRkcyBzdXBwb3J0IGZvciB0aGUgTU1JTyBiYXNlZCBnbXV4IG9uIFQy
IG1hY3MuDQo+IA0KPiAjIDU6DQo+IA0KPiBBZGQgYSBkZWJ1Z2ZzIGludGVyZmFjZSB0byBhcHBs
ZS1nbXV4IHNvIGRhdGEgZnJvbSBwb3J0cyBjYW4gYmUgcmVhZA0KPiBhbmQgd3JpdHRlbiB0byBm
cm9tIHVzZXJzcGFjZS4NCj4gDQo+IFRoaXMgY2FuIGJlIHVzZWQgZm9yIG1vcmUgZWFzaWx5IHJl
c2VhcmNoaW5nIHdoYXQgdW5rbm93biBwb3J0cyBkbywNCj4gYW5kIHN3aXRjaGluZyBncHVzIHdo
ZW4gdmdhX3N3aXRjaGVyb28gaXNuJ3QgcmVhZHkgKGUuZy4gd2hlbiBvbmUgZ3B1DQo+IGlzIGJv
dW5kIHRvIHZmaW8tcGNpIGFuZCBpbiB1c2UgYnkgYSBXaW5kb3dzIFZNLCBJIGNhbiB1c2UgdGhp
cyB0bw0KPiBzd2l0Y2ggbXkgaW50ZXJuYWwgZGlzcGxheSBiZXR3ZWVuIExpbnV4IGFuZCBXaW5k
b3dzIGVhc2lseSkuDQo+IA0KPiAjIElzc3VlczoNCj4gDQo+IDEuIFN3aXRjaGluZyBncHVzIGF0
IHJ1bnRpbWUgaGFzIHRoZSBzYW1lIGlzc3VlIGFzIGluZGV4ZWQgZ211eCdzOiB0aGUNCj4gaW5h
Y3RpdmUgZ3B1IGNhbid0IHByb2JlIHRoZSBEREMgbGluZXMgZm9yIGVEUCBbM10NCj4gDQo+IDIu
IGlNYWNQcm8xLDEsIGlNYWMyMCwxIGFuZCBpTWFjMjAsMiBhbGwgc2VlbSB0byBoYXZlIGEgZ211
eCBpbiB0aGVpcg0KPiBhY3BpIHRhYmxlcywgYnV0IHRoZXkgc2hvdWxkbid0LiBBIGNoZWNrIHRo
YXQgaG9wZWZ1bGx5IHdpbGwgZGV0ZWN0IHRoaXMNCj4gaXMgdXNlZCwgYnV0IGl0J3MgdW50ZXN0
ZWQgYXMgSSBkb24ndCBoYXZlIGFueSBvZiB0aG9zZSBjb21wdXRlcnMuDQo+IA0KPiAzLiBQb3dl
cmluZyBvbiB0aGUgYW1kZ3B1IHdpdGggdmdhX3N3aXRjaGVyb28gZG9lc24ndCB3b3JrIHdlbGwu
IEknbQ0KPiB0b2xkIG9uIHRoZSBNYWNCb29rUHJvMTUsMSBpdCB3b3JrcyBzb21ldGltZXMsIGFu
ZCBhZGRpbmcgZGVsYXlzIGhlbHBzLA0KPiBidXQgb24gbXkgTWFjQm9va1BybzE2LDEgSSBoYXZl
bid0IGJlZW4gYWJsZSB0byBnZXQgaXQgdG8gd29yayBhdCBhbGw6DQo+IA0KPiBhbWRncHU6IHN3
aXRjaGVkIG9mZg0KPiBhbWRncHU6IHN3aXRjaGVkIG9uDQo+IGFtZGdwdSAwMDAwOjAzOjAwLjA6
DQo+ICAgIFVuYWJsZSB0byBjaGFuZ2UgcG93ZXIgc3RhdGUgZnJvbSBEM2hvdCB0byBEMCwgZGV2
aWNlIGluYWNjZXNzaWJsZQ0KPiBhbWRncHUgMDAwMDowMzowMC4wOg0KPiAgICBVbmFibGUgdG8g
Y2hhbmdlIHBvd2VyIHN0YXRlIGZyb20gRDNjb2xkIHRvIEQwLCBkZXZpY2UgaW5hY2Nlc3NpYmxl
DQo+IFtkcm1dIFBDSUUgR0FSVCBvZiA1MTJNIGVuYWJsZWQgKHRhYmxlIGF0IDB4MDAwMDAwODBG
RUUwMDAwMCkuDQo+IFtkcm1dIFBTUCBpcyByZXN1bWluZy4uLg0KPiBbZHJtOnBzcF9od19zdGFy
dCBbYW1kZ3B1XV0gKkVSUk9SKiBQU1AgY3JlYXRlIHJpbmcgZmFpbGVkIQ0KPiBbZHJtOnBzcF9y
ZXN1bWUgW2FtZGdwdV1dICpFUlJPUiogUFNQIHJlc3VtZSBmYWlsZWQNCj4gW2RybTphbWRncHVf
ZGV2aWNlX2Z3X2xvYWRpbmcgW2FtZGdwdV1dDQo+ICAgICpFUlJPUiogcmVzdW1lIG9mIElQIGJs
b2NrIDxwc3A+IGZhaWxlZCAtNjINCj4gYW1kZ3B1IDAwMDA6MDM6MDAuMDogYW1kZ3B1OiBhbWRn
cHVfZGV2aWNlX2lwX3Jlc3VtZSBmYWlsZWQgKC02MikuDQo+IHNuZF9oZGFfaW50ZWwgMDAwMDow
MzowMC4xOiBFbmFibGluZyB2aWEgdmdhX3N3aXRjaGVyb28NCj4gc25kX2hkYV9pbnRlbCAwMDAw
OjAzOjAwLjE6DQo+ICAgIFVuYWJsZSB0byBjaGFuZ2UgcG93ZXIgc3RhdGUgZnJvbSBEM2NvbGQg
dG8gRDAsIGRldmljZSBpbmFjY2Vzc2libGUNCj4gc25kX2hkYV9pbnRlbCAwMDAwOjAzOjAwLjE6
IENPUkIgcmVzZXQgdGltZW91dCMyLCBDT1JCUlAgPSA2NTUzNQ0KPiBzbmRfaGRhX2NvZGVjX2hk
bWkgaGRhdWRpb0MwRDA6IFVuYWJsZSB0byBzeW5jIHJlZ2lzdGVyIDB4MmYwZDAwLiAtNQ0KPiAN
Cj4gVGhlcmUgYXJlIHNvbWUgYWNwaSBtZXRob2RzIChQV1JELCBQV0cxIFs0LCA1XSkgdGhhdCBt
YWNPUyBjYWxscyB3aGVuDQo+IGNoYW5naW5nIHRoZSBhbWRncHUncyBwb3dlciBzdGF0ZSwgYnV0
IHdlIGRvbid0IHVzZSB0aGVtIGFuZCB0aGF0IGNvdWxkIGJlDQo+IGEgY2F1c2UuIEFkZGl0aW9u
YWxseSB1bmxpa2UgcHJldmlvdXMgZ2VuZXJhdGlvbiBNYWNib29rcyB3aGljaCB3b3JrDQo+IGJl
dHRlciwgb24gTWFjQm9va1BybzE2LDEgdGhlIGdwdSBpcyBsb2NhdGVkIGJlaGluZCAyIHBjaSBi
cmlkZ2VzOg0KPiANCj4gMDE6MDAuMCBQQ0kgYnJpZGdlOiBBZHZhbmNlZCBNaWNybyBEZXZpY2Vz
LCBJbmMuIFtBTUQvQVRJXQ0KPiAgICBOYXZpIDEwIFhMIFVwc3RyZWFtIFBvcnQgb2YgUENJIEV4
cHJlc3MgU3dpdGNoIChyZXYgNDMpDQo+IDAyOjAwLjAgUENJIGJyaWRnZTogQWR2YW5jZWQgTWlj
cm8gRGV2aWNlcywgSW5jLiBbQU1EL0FUSV0NCj4gICAgTmF2aSAxMCBYTCBEb3duc3RyZWFtIFBv
cnQgb2YgUENJIEV4cHJlc3MgU3dpdGNoDQo+IDAzOjAwLjAgVkdBIGNvbXBhdGlibGUgY29udHJv
bGxlcjogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EL0FUSV0NCj4gICAgTmF2aSAx
NCBbUmFkZW9uIFJYIDU1MDAvNTUwME0gLyBQcm8gNTUwME1dIChyZXYgNDMpDQo+IDAzOjAwLjEg
QXVkaW8gZGV2aWNlOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTUQvQVRJXQ0KPiAg
ICBOYXZpIDEwIEhETUkgQXVkaW8NCj4gDQo+IFVwb24gYXR0ZW1wdGluZyB0byBwb3dlciBvbiB0
aGUgZ3B1IHdpdGggdmdhX3N3aXRjaGVyb28sIGFsbCB0aGVzZQ0KPiBkZXZpY2VzIGV4Y2VwdCAw
MTowMC4wIGhhdmUgdGhlaXIgY29uZmlnIHNwYWNlIGZpbGxlZCB3aXRoIDFzLg0KPiBSZXNjYW5u
aW5nIHBjaSBtYWtlcyB0aGUgY29uZmlnIHNwYWNlIG9mIGFsbCB0aGUgZGV2aWNlcyBnbyBiYWNr
IHRvDQo+IG5vcm1hbCwgaG93ZXZlciBhbWRncHUgc3RpbGwgZmFpbHMgdG8gcmVzdW1lIHdpdGgg
dGhlIHNhbWUgbG9ncyBhcw0KPiBhYm92ZS4NCj4gDQo+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzNBRkI5MTQyLTJCRDAtNDZGOS1BRUE5LUM5QzVEMTNFNjhFNkBsaXZlLmNvbS8N
Cj4gWzJdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9wbGF0Zm9ybS1kcml2ZXIteDg2LzIwMjMw
MjE2MTIyMzQyLjU5MTgtMS1vcmxhbmRvY2guZGV2QGdtYWlsLmNvbS8NCj4gWzNdOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvOWVlZDhlZGU2ZjE1YTI1NGFkNTc4ZTc4M2IwNTBlMWM1ODVk
NWExNS4xNDM5Mjg4OTU3LmdpdC5sdWthc0B3dW5uZXIuZGUvDQo+IFs0XTogaHR0cHM6Ly9naXN0
LmdpdGh1Yi5jb20vUmVkZWNvcmF0aW5nLzZjNzEzNmI3YTRhYzdjZTNiNzdkOGU0MTc0MGRkODdi
DQo+IFs1XTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMTIwNzEwMTYwNTU1LkdBMzE1
NjJAc3JjZi51Y2FtLm9yZy8NCj4gDQo+IE9ybGFuZG8gQ2hhbWJlcmxhaW4gKDUpOg0KPiAgYXBw
bGUtZ211eDogdXNlIGZpcnN0IGJpdCB0byBjaGVjayBzd2l0Y2ggc3RhdGUNCj4gIGFwcGxlLWdt
dXg6IHJlZmFjdG9yIGdtdXggdHlwZXMNCj4gIGFwcGxlLWdtdXg6IFVzZSBHTVNQIGFjcGkgbWV0
aG9kIGZvciBpbnRlcnJ1cHQgY2xlYXINCj4gIGFwcGxlLWdtdXg6IHN1cHBvcnQgTU1JTyBnbXV4
IG9uIFQyIE1hY3MNCj4gIGFwcGxlLWdtdXg6IGFkZCBkZWJ1Z2ZzIGludGVyZmFjZQ0KPiANCj4g
ZHJpdmVycy9wbGF0Zm9ybS94ODYvYXBwbGUtZ211eC5jIHwgMzQ5ICsrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLQ0KPiBpbmNsdWRlL2xpbnV4L2FwcGxlLWdtdXguaCAgICAgICAgfCAgNzAg
KysrKy0tDQo+IDIgZmlsZXMgY2hhbmdlZCwgMzU3IGluc2VydGlvbnMoKyksIDYyIGRlbGV0aW9u
cygtKQ0KPiANCj4gLS0gDQo+IDIuMzkuMQ0K
