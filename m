Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2DC662161
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjAIJZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjAIJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:24:29 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94B392
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:24:22 -0800 (PST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.105
 [104.47.22.105]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-obpyomr3MXWRepks8FaDDw-1; Mon, 09 Jan 2023 10:23:16 +0100
X-MC-Unique: obpyomr3MXWRepks8FaDDw-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0053.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:22::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 09:23:15 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa%2]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 09:23:15 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 2/5] arm64: dts: fsl-imx8qm-device.dtsi: add
 io-channel-cells to adc nodes
Thread-Topic: [PATCH v2 2/5] arm64: dts: fsl-imx8qm-device.dtsi: add
 io-channel-cells to adc nodes
Thread-Index: AQHZHs0kMIF4JGIYz066E0T2QvT8MK6VyKIAgAARwwA=
Date:   Mon, 9 Jan 2023 09:23:15 +0000
Message-ID: <d125c410d022905a709d4535280c20214fd53747.camel@toradex.com>
References: <20230102171023.33853-1-marcel@ziswiler.com>
         <20230102171023.33853-3-marcel@ziswiler.com> <20230109081940.GG18301@T480>
In-Reply-To: <20230109081940.GG18301@T480>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GVAP278MB0053:EE_
x-ms-office365-filtering-correlation-id: 16193e3f-c1f6-4a52-4a6e-08daf2232324
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: YlEAa4aiAX9D55J5NrML/Zc4YIX+yCe4Mm3QbWVyegX/7aiYkws6SIF7F51v8FTFJ+njqo7SacPJVdgH0A/P5R+03F+4ZCUpU2kZmRQVLC8H+VwpD/Ira/tH5lmRwhpM1Enq6Up4TaKyCegbL9maHvFZ9zvSMrcbT2/q+KdlHy2lZJYxh1oCY4NF0CID5oW2gr7LkUKxp+N47b0p4ubDRJh9yHKMHTnhQk1PLdNF1fIIc6Cj6IjIJHH7vuaImBLisOkn1KVIkkPr5XtlQUTH7WEIRpLA/N4hyj8s35GlISSMn0Bkn8fRhLRIHk6IuFIFz75OGhwezdxxw3jF8eCTwnlyUTwJtBw0JA3OUMqy0HULup3vV3BIJAPg3qb7ENvDM03jUCLiIuHolsMSlLZoYGC6GEk40oSGpewyISf/oEpdC1mhMc4bX0RqHYsh2DorxMwijN7yw78TjcXgYTOuTv5G6xtk2bcWncc+Xe0KgcNeerHRr/RrvQiQQSejrMmkYDtxPmbHE2arO8PC6tANIcBIpSV0lP1mOGRkpS4LK4qpMcngAnPbqLsXmRfBHvFosTt39f4s5dFSzQJ+90WOqyQaIcNbIvLfFrZifCySmrxQbUB/NRnOJW4cwYr77eOsdiHgntt9ATXZVEjoOcRNLwII4I+PsoF5D/j/TIkOgPZ8yQcrWbOiY19eHYm6xq+be1kZxJmGA1mgQyLM3uRv7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(39840400004)(376002)(346002)(451199015)(36756003)(86362001)(2906002)(8936002)(5660300002)(7416002)(41300700001)(44832011)(83380400001)(122000001)(66946007)(71200400001)(54906003)(76116006)(38070700005)(66556008)(6506007)(186003)(38100700002)(6486002)(8676002)(26005)(66476007)(4326008)(316002)(6916009)(64756008)(66446008)(2616005)(478600001)(6512007);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE9VcGVrWkJnK29NdkFmNUJKUWFTb1I5TGdXNTlROGZ2SVd4TTkzOU9tRC9K?=
 =?utf-8?B?T3FKNWdyb3VkZnFDaUY2SHlLQmFXMTZKOWpvK1V6TEdBMDUxY3JEVzZQQlgr?=
 =?utf-8?B?OGxrKy9FZWJuVUJVS1RhUjU1dktybXltcGRmNnY1cUZEL1NLanpFZDlWcFlG?=
 =?utf-8?B?SVlpRGRTa2tWSGJ3Q3V3YTlLa2FKdnpMWEZkSzZuMmE1YzJvZkdQbjhKSUxl?=
 =?utf-8?B?VEVGZ1M0VHQ4ZEtvTHNYU0l1YTZZTDlNYUFmcTJ4Wk10Q1JzQ1lPUkVXWXNo?=
 =?utf-8?B?M1VRT2cveUQ3Um9SREJxUkRlc01mNmdXb25DSUtWdlg5cFF1WnhpVGlDU0Vi?=
 =?utf-8?B?ZUh1TlFtcXFkQ2hDNEVtcjBvR1Z1dGRCTFlFTSs1SXZwcWNKZThGU1pnTkYr?=
 =?utf-8?B?T3ZoS3FValVQZkZBS3Zka2x4dm5jSm5VQ3VjcTB1djBLU04rakQxTEltS3FO?=
 =?utf-8?B?STB2OFoyUWdna0gxdTVPOVpxL0xyYVNwdW9wNnVIeDVlK2FIMGlVUEo3Qk9Q?=
 =?utf-8?B?NjQwZXRlTXJkalJHcHpUYmhtOGs4RnMrckNDcFV6WTdJSTkxWSs3OTNjVzBz?=
 =?utf-8?B?V1BWM20wUS9wbS9Db1hDaTVEV3RwQzRkZ2lTaDdJR3JkV05Renl6cVUvRUxG?=
 =?utf-8?B?UVZCczIvUmYrWEJ3aGU4RXB4K0RmQ25TSkZ1VmIyU1dVckJ5YmIyd2hPZzVS?=
 =?utf-8?B?eWJPOHJvd2FYOTBWWHE1cXZuNFpzbDNRWnpOS3BvcEdXVW52YW1sckM3ODNX?=
 =?utf-8?B?WGxYeHRjVXZDSHhjWThCN0t6aFR4di9US2V2M2RxVlpHd25Bc2o4UEc2bzVJ?=
 =?utf-8?B?b0dmNStqR1Y5c2lvQytQMjFSc2duQkxheTdMZGNETGsvQ05WcmtvcDNJVStJ?=
 =?utf-8?B?elpXZlV2SnBGSm5UMFZSSGdhclh3U21lY0lFOHZXbmNpRnhIVVVPaGxmenpX?=
 =?utf-8?B?bVN6aWR5dGxhLzBjYy9VRDdpbU1vTncwRDdLMFMrVHlSbkFRL0N6ZW15b1Yx?=
 =?utf-8?B?cmgrSTFKT3R4alIzLzRjT2RYeXJLQ1N6Q2tuM1FraFhuRmc0MFVFWkl0NTNH?=
 =?utf-8?B?Tk41MTFlM21wQk9BYmFTdXl0UFY0Qkt3TmxHVGgzd2t5dE13a1pZMUNDcDlS?=
 =?utf-8?B?UFhpWGxJakpvUkNOcCttb0N0TCt5NUJiN2hiQTd2OFl6VFNheW9nWjlQdytT?=
 =?utf-8?B?NmJNK0R0c1dvU3hoZnFhakk3WUJJb1hOaEs0dExkR2phcUcwUGFWL3BwOVIv?=
 =?utf-8?B?QlIxZk5SQ2Z5b2ZqVFhKSTZJTVVmU0RnYW9hbkt1MHVvR0pVN1BldjR3QWp4?=
 =?utf-8?B?RW45c3VsUVlzT2I5ZEpaQ2w1N2Zld1dYSGJwaXRwL0kwU1NTUExsQkdBZzZh?=
 =?utf-8?B?ZXVRQ3BTa2tCRFJ4a3ZXbmY2eU00dWJtZTNHdGxjL25QSVJVZFpOWjFvRkRt?=
 =?utf-8?B?WlEzZFFReWxyTytxdHpIbFp2MXB2cEJIY1dLYzk5N0RBM2d4djVYSjNIUHBu?=
 =?utf-8?B?emYwTHlpbUNHV3FFNFNBL2JNNWIzbTlkbzh5RnUzcUpoMmVnTjk1YXB4MFlV?=
 =?utf-8?B?dnFQVkMzOWtBdGIzUVhHSVpDSkFjcUJDZGFOanJZWXdNQnl5MHM0OGNQdUFz?=
 =?utf-8?B?cUlJaTV4WDBob3RIaTE1ajIzNndGN3NMck12U2QyclBNWjAwbUpxNUh1MjZQ?=
 =?utf-8?B?YjZja09mbmV1bFNJN2hTeDBPV3pMaWdJNHlzUG83SkllQUdiOW85VGYrbC9W?=
 =?utf-8?B?Y0x4eFZFSzU3bHRNQWNRdUZWSFFlK3I3b3hVck8xejJrblprSFI5M3hteE5R?=
 =?utf-8?B?YWJJdWlhSE9RRUNmTk1TZk9jOUU4M1IvZVlGZUg0YThFV3VGZHpjU2E3UnBq?=
 =?utf-8?B?MUh3MElzaG4xbUdEbEs1RmRDSWxKUXkvNlB0MVlNM3pQOEpreEtkcUlpUTI4?=
 =?utf-8?B?VGdtRGczUWhQL1NoRmdVQ3RGbllXcEdVRlVxeHlVVE5KemF2L1dqZXFVZHU2?=
 =?utf-8?B?YUZ5RXI3SDQ1c0lMQnhJallKWFdWQUd6U1NaVVczOGx5T29xT3VsdDkwQ3Bx?=
 =?utf-8?B?NU4xR1htZW5ZcjN2NkVZRytvaGIzNVEyREhsTFpYWi9nZFB6QzFGMTVvMGpD?=
 =?utf-8?B?bllnb1dyZmY2SXRIeGF2WDRkNUs4cFIyV0RDZ2xvM2VRQVBPL1RjdGl5VlVl?=
 =?utf-8?Q?tVB2/ul99wqb7SRbZBHA33M=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 16193e3f-c1f6-4a52-4a6e-08daf2232324
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 09:23:15.3235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pgRNf6G4OGzCVOipg12dBFNsHqC3jYce1eTWKT2U16sbY6lVfD1gn+84oBu48OuRAcUzn0eaMfHmqXDSrziGLfCum1VMYyR/Ibxy81Nb1cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0053
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <E1304B851B09994E8E5DB6053304220D@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTA5IGF0IDE2OjE5ICswODAwLCBTaGF3biBHdW8gd3JvdGU6Cj4gT24g
TW9uLCBKYW4gMDIsIDIwMjMgYXQgMDY6MTA6MTlQTSArMDEwMCwgTWFyY2VsIFppc3dpbGVyIHdy
b3RlOgo+ID4gRnJvbTogTWF4IEtydW1tZW5hY2hlciA8bWF4LmtydW1tZW5hY2hlckB0b3JhZGV4
LmNvbT4KPiA+IAo+ID4gVGhpcyBjb21taXQgYWRkcyBpby1jaGFubmVsLWNlbGxzIHByb3BlcnR5
IHRvIHRoZSBBREMgbm9kZXMuIFRoaXMKPiA+IHByb3BlcnR5IGlzIHJlcXVpcmVkIGluIG9yZGVy
IGZvciBhbiBJSU8gY29uc3VtZXIgZHJpdmVyIHRvIHdvcmsuCj4gPiBFc3BlY2lhbGx5IHJlcXVp
cmVkIGZvciBBcGFsaXMgaU1YOCBRTSwgYXMgdGhlIHRvdWNoc2NyZWVuIGRyaXZlcgo+ID4gdXNl
cyBBREMgY2hhbm5lbHMgd2l0aCB0aGUgQURDIGRyaXZlciBiYXNlZCBvbiBJSU8gZnJhbWV3b3Jr
Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2No
ZW5rZXJAdG9yYWRleC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXggS3J1bW1lbmFjaGVyIDxt
YXgua3J1bW1lbmFjaGVyQHRvcmFkZXguY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFpp
c3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+Cj4gCj4gZnNsLWlteDhxbS1kZXZp
Y2UuZHRzaSBpbiBzdWJqZWN0PwoKKDstcCkuCgpMZXQgbWUgZml4IHRoaXMgaW4gYSB2My4gVGhh
bmtzIQoKPiBTaGF3bgoKQ2hlZXJzCgpNYXJjZWwKCj4gPiAtLS0KPiA+IAo+ID4gKG5vIGNoYW5n
ZXMgc2luY2UgdjEpCj4gPiAKPiA+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OC1zcy1kbWEuZHRzaSB8IDIgKysKPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OC1zcy1kbWEuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgtc3MtCj4g
PiBkbWEuZHRzaQo+ID4gaW5kZXggYTk0M2ExZTI3OTdmLi42ZTVlZjhiNjliZjggMTAwNjQ0Cj4g
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LXNzLWRtYS5kdHNpCj4g
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LXNzLWRtYS5kdHNpCj4g
PiBAQCAtMjcwLDYgKzI3MCw3IEBAIGkyYzM6IGkyY0A1YTgzMDAwMCB7Cj4gPiDCoAo+ID4gwqDC
oMKgwqDCoMKgwqDCoGFkYzA6IGFkY0A1YTg4MDAwMCB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAibnhwLGlteDhxeHAtYWRjIjsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjaW8tY2hhbm5lbC1jZWxscyA9IDwxPjsKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDB4NWE4ODAwMDAgMHgxMDAwMD47Cj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVycnVwdHMgPSA8R0lDX1NQSSAy
NDAgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47Cj4gPiBAQCAtMjg0LDYgKzI4NSw3IEBAIGFk
YzA6IGFkY0A1YTg4MDAwMCB7Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoGFkYzE6IGFkY0A1
YTg5MDAwMCB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUg
PSAibnhwLGlteDhxeHAtYWRjIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAj
aW8tY2hhbm5lbC1jZWxscyA9IDwxPjsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmVnID0gPDB4NWE4OTAwMDAgMHgxMDAwMD47Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGludGVycnVwdHMgPSA8R0lDX1NQSSAyNDEgSVJRX1RZUEVfTEVWRUxfSElHSD47
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVycnVwdC1wYXJlbnQgPSA8
JmdpYz47Cj4gPiAtLSAKPiA+IDIuMzUuMQo=

