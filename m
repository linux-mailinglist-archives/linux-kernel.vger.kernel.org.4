Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FF961F24D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiKGMA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiKGMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:00:26 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA80B06
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:00:25 -0800 (PST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-U0qEeYIAMuKqMqZAUHoVdQ-1; Mon, 07 Nov 2022 13:00:21 +0100
X-MC-Unique: U0qEeYIAMuKqMqZAUHoVdQ-1
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::14)
 by GV0P278MB0035.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 12:00:19 +0000
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::17fb:1eb6:1b22:3db5]) by ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::17fb:1eb6:1b22:3db5%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 12:00:19 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "francesco@dolcini.it" <francesco@dolcini.it>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: colibri-imx6ull: Enable dual-role switching
Thread-Topic: [PATCH] ARM: dts: colibri-imx6ull: Enable dual-role switching
Thread-Index: AQHY7tMjyR99C5ARBUuYl8l4uHecTK4s00AAgAAFAoCABosZAA==
Date:   Mon, 7 Nov 2022 12:00:18 +0000
Message-ID: <f901af9b264ee58233c3549f85ee876829fdd721.camel@toradex.com>
References: <20221102155226.51587-1-dev@pschenker.ch>
         <4964263.31r3eYUQgx@steina-w>
         <Y2N2JYGvmzLjpGUq@francesco-nb.int.toradex.com>
In-Reply-To: <Y2N2JYGvmzLjpGUq@francesco-nb.int.toradex.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0377:EE_|GV0P278MB0035:EE_
x-ms-office365-filtering-correlation-id: dd205411-01ae-405f-1185-08dac0b7a432
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: +AZEmgoJ/PmKYE8IBTUyxwt8aUXF4IgqVO6W11Fd8lV21LvARmLFL1XXbI3XR2XJCMMaRRZMdz5eDm0r/du+a/c8pr2NwlK55I7e+eRxbnv4Wct3MPCsum87s7i57/O9ieixYL2vG233nPLN9flvmG0nlpqA6XSIvvdzQ8QosJH+MVPACbrcnVnKyz7yy+2S3d3TekM3R8lFwfBgoIn8dok2TP8xOWOr3e+dnsuXhtrcqctgfpjfgStkZWIZwA7LPl4N4flXzxErSD5e+VB5XfaGMNHrS6QhdhID4aNtknVTxST+J8+0271nCJAUeVEe2+8gMfHV7wm7W071qiDTEqjHpe1J3BOYVLp1uSCKqJADB3ahLgMVNOKU/o8+HHEyXn3hc66XPJx8eBQ4uoIejEDCytmPORsnsC1xF6WJb2xE3STrNHLtl9mK7BcjDBgAgL3ilLEjZjapbaFeXkjWeXBw6w3TTi2B6i3x6nZuAzgx1hVtm+IV074IplbHl12VjJ79Dv1OETAnd5V9N+UjCUbxXV5N4C2NGFOyCa1q6vgYl8fJIt10WtxArnI/FOyxs67lBZREUW7CUWBIl+RpDfvs7wwQdNGvYTGhFP084qf6/wSvJ7pDjrs/lfEzTVAU5uS9ZHQZle7ywmLjMND9v8X+/v7mhvZHQDEVfBRVYGpu3x7Scjgr2uDubgDBOrRuLq9n7XxLVH1FO2PzYY23/9jwok8ZhuVTLB7AJHSzm+Xja71YwASzc4wGANb5YLH7CFl1AOqMVo/Cji8tJlIkbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(366004)(396003)(376002)(346002)(136003)(451199015)(36756003)(86362001)(38070700005)(5660300002)(7416002)(44832011)(2906002)(26005)(6506007)(2616005)(186003)(38100700002)(122000001)(6512007)(76116006)(66946007)(110136005)(71200400001)(478600001)(54906003)(8936002)(4326008)(8676002)(66556008)(66476007)(64756008)(66446008)(41300700001)(6486002)(316002);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2ZiZVFXbWdYQm9ZZjhPaFBlc0RWS25NNHdkUEoxWVdKSUtBV0wvR25IKzV6?=
 =?utf-8?B?czF5Mzd1bi83Sm9nUGNaeTdMMXlOWDRxWFNtWHl0dFdxa1dqZ0pZWFpRaWph?=
 =?utf-8?B?MS9weXV4TGMvbmJkMnZCTGhXVi82STBsdGNpMkhlanVZQkVDZnh3M1UzR25v?=
 =?utf-8?B?Tk8xR3NXRmJoRkpsNkNySmU2M1g0R2xqWEtxMzJrS3l2VnJRVGVxRjExa1FP?=
 =?utf-8?B?eUVkL203L0dUcWN0c1VjMXhEWTBHeEE3a3VJUXVDclJVSzZvNXVXNFYzZFVQ?=
 =?utf-8?B?MER0OTdsOGNwd3BibzdHa3lSTjkzU3pmNzJFUktzY1pQcDBicHRTWnVyN1M3?=
 =?utf-8?B?ZllvT1BvTXpabWhhamY3L29Lc2VPT21kUSthSUsrOERoOHNNdXUwL3hBMy9G?=
 =?utf-8?B?WU5xZDVCMkh6RGxTZDhVK0dMM1hXcXAxcUNHMUhEaHJNU29RRW9tYzFSNnEv?=
 =?utf-8?B?Mk1GTERwdHVuZmtENVJzTTdiOGtEVXdEYkFGNXBIRExKdm9IUmhubnpNQjI4?=
 =?utf-8?B?K25ZOEc3a09SZEMvb0V3MlJsWW9OU3c2ZTBZLzBHb0JMQnUvd3NheFFpVXhp?=
 =?utf-8?B?bEhnc1FCZW5WdWJ2eVpCM2JSMWRKV2ZHd2xZcnhMK1hEeDhTSnYrRTlVWFdN?=
 =?utf-8?B?SHBMaC9lR1hSQ3E4MXJWZ2lEYUlZN3N2OXhBbG5Sa3lrRjVtUGVxMFdISldR?=
 =?utf-8?B?QzlnaFpFUmdXSWhBckg3cE8wbjFBSmpFMys2ajhIeGY1cHpTekM4NC9Dd1hw?=
 =?utf-8?B?WDJ4NHZlenV6WHBhZEtCZk1xU1o4RjFkWXFPRlFXSW9sekIrWkZWb2JwQWR3?=
 =?utf-8?B?OGNCMWk2YXNVTDFrcDBCTVM2cWxmejYxNW40dy9xckpGamVSN0ozczdGUEll?=
 =?utf-8?B?NkY2bWxrMThTZHBHVU1nWlRUQ2ppZEkrTjd6dVI3TWFUZkhlZ2REdis5L3pI?=
 =?utf-8?B?OElRZmxVNVdnNFRzNGJ4WktSQ2oyam9iOEIwQUtvWEZVcHRGR2VKWFl4N3Ru?=
 =?utf-8?B?YWZGbGQvR3UrbTRmbFVqSHZOanFObk1PRXhzNVZhVE5Wb3pqT1Qrbkx6ZnYz?=
 =?utf-8?B?NGpXcmk5SHd2dzEzaDlMbzhzeStXT3g0UjdhWVJLZDBpNW5VQVhYczFPL0FQ?=
 =?utf-8?B?TnU2anl0aUEvRDZpU1dxSmovaE55WWp2SVlDNVBkRlZ3VGRrUlhrWHdPWXNS?=
 =?utf-8?B?MllENENiZ05WWGJDQWV2OHpFZ2NFVWIzYTBCVUVNVmdsZHRncXUxVHVocjBx?=
 =?utf-8?B?c1ZML1JIelc1ZUtvRGRTMGsxdnhoa2hqTFo3S0NsVjY1VXFDQWNaYmE0eUM3?=
 =?utf-8?B?WEZCc2VxaUVqSDdVc3VFMVExWGd5cXNPc2NFdXAyaGZ5UFQ0bXFxdzlmU1JS?=
 =?utf-8?B?TTdoMWdGUWxxYVRtRVJEa25mQnA3d2xOOGZKb24rRVZibEZoZWExUVVkcEJ0?=
 =?utf-8?B?N0lKVWplZEhDSFU2OHBWRlVKeWgrdXlxaUhNNUhvbS90OTd6YnlHYU04djcy?=
 =?utf-8?B?RXNZMWtvbUt4dkNFSHlDeEhDNDFpRFAvMWREcGYxMGp0eDhDY2dmdkRhUWFL?=
 =?utf-8?B?RDZ1QnVraklMSW9yWm1tdGo4TUFHZ3kyQ1dQbVVVdjYyTWFyVEt3RjR6bktT?=
 =?utf-8?B?Y2M2d1NFUjF1aTBxRnA2clJUVk9pMFozU2ZUcUQ3QXpuSGRWQy9HUXpxdW0v?=
 =?utf-8?B?TTdUUWI0cFBjUThWRmFYU0EvbU5RMGU0M21zSmx2YzZrSWZ4Y21PNnVBOUlU?=
 =?utf-8?B?SGZ5MzVqWXJvUDgrMFQ4cndQd2VEWEhzSWVsY0kyT0FmbVNvN0ZubGFxSkdU?=
 =?utf-8?B?NXRpL2J1RmpCTi94a1JMc05rT005cGYrRjdKR0twUVcxOW9hb0lJb01vMktv?=
 =?utf-8?B?b2p3UGZ1d2JrSWJCZjhjNW5tZGRvUlU4V2pjeUFJcnNSZjg0Q1lmNmtYYVVT?=
 =?utf-8?B?N0V0Q3gwZmR4bkFIT1dXVmVrQWg4Wm41enliTmxpTHJ0dmxyYTNDdWF0NjNl?=
 =?utf-8?B?MnR6RjNZMjFlR091U2NTeFl2VWwzcU0rZDc4ekt4Mk1LenJjR3dPZ3krQnpW?=
 =?utf-8?B?UUREeW1XT1ZmVHg5aTBJWDBXZnZWQ2w0Y2kxR0pGbE1Nd3JIR2d5amwzYlB1?=
 =?utf-8?B?M21xSkdlcG8zYWpaZTZtQUQveGhBaUdiMWhYdkRPbXdER2lleUZWLzVVMzdp?=
 =?utf-8?Q?tFzYXNyHfx6ha7nEz+yGJKM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dd205411-01ae-405f-1185-08dac0b7a432
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 12:00:19.2483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCaAph3dQn0o5y5kcH3rMmh/sGHtK32dgiVGeJuaEWV4fK8tOM7DyQcftOuly6H2gbJoUqZUSykFcgOIAstpmAkrjQ8gRvsoa/j9CwBCqIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0035
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <08D4D4C227B0C84FBE04902D27DB1288@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTExLTAzIGF0IDA5OjA0ICswMTAwLCBGcmFuY2VzY28gRG9sY2luaSB3cm90
ZToNCj4gT24gVGh1LCBOb3YgMDMsIDIwMjIgYXQgMDg6NDY6NThBTSArMDEwMCwgQWxleGFuZGVy
IFN0ZWluIHdyb3RlOg0KPiA+IEhpIFBoaWxpcHBlLA0KPiA+IA0KPiA+IEFtIE1pdHR3b2NoLCAy
LiBOb3ZlbWJlciAyMDIyLCAxNjo1MjoyNiBDRVQgc2NocmllYiBQaGlsaXBwZQ0KPiA+IFNjaGVu
a2VyOg0KPiA+ID4gRnJvbTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRv
cmFkZXguY29tPg0KPiA+ID4gDQo+ID4gPiBUaGUgQ29saWJyaSBzdGFuZGFyZCBwcm92aWRlcyBh
IEdQSU8gY2FsbGVkIFVTQkNfREVUIHRvIHN3aXRjaA0KPiA+ID4gZnJvbQ0KPiA+ID4gVVNCIEhv
c3QgdG8gVVNCIERldmljZSBhbmQgYmFjay4gVGhlIENvbGlicmkgaU1YNlVMTCBkb2VzIGhhdmUg
dGhlDQo+ID4gPiBTb0MNCj4gPiA+IGJhbGwgVVNCX09URzFfVkJVUyBjb25uZWN0ZWQgaW4gc2Vy
aWVzIHdpdGggYSBjYXBhY2l0b3IgdG8gZ3JvdW5kLg0KPiA+ID4gDQo+ID4gPiBUaGlzIG1lYW5z
IHRoYXQgd2UgbmVlZCB0byBwcm92aWRlIHRvIHRoZSBleHRjb24gZnJhbWV3b3JrIFZCVVMNCj4g
PiA+IGFuZCBJRA0KPiA+ID4gZXZlbnRzIHVzaW5nIHRoZSBzaW5nbGUgR1BJTyB3ZSBoYXZlLiBU
aGUgRXh0Y29uIFVTQiBHUElPIGRyaXZlcg0KPiA+ID4gZG9lcw0KPiA+ID4gdXNlIGlkLWdwaW8g
YWxzbyBmb3IgVkJVUyBldmVudCwgYXMgaW4gb3VyIGNhc2Ugd2hlcmUgdmJ1cy1ncGlvIGlzDQo+
ID4gPiBhYnNlbnQuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVu
a2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4NCj4gPiA+IA0KPiA+ID4gLS0tDQo+
ID4gPiANCj4gPiA+IMKgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kgfCA4
ICsrKysrKysrDQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPiA+
IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5k
dHNpDQo+ID4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpIGluZGV4
DQo+ID4gPiA1NzdhNDI0YjBlMWQuLmZlYjFmY2Q5YTY4NA0KPiA+ID4gMTAwNjQ0DQo+ID4gPiAt
LS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmkuZHRzaQ0KPiA+ID4gKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gPiA+IEBAIC0yNCw2ICsy
NCwxMyBAQCBiYWNrbGlnaHQ6IGJhY2tsaWdodCB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHN0YXR1cyA9ICJva2F5IjsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqB9Ow0K
PiA+ID4gDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBleHRjb25fdXNiY19kZXQ6IHVzYmMtZGV0IHsN
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gImxpbnV4
LGV4dGNvbi11c2ItZ3BpbyI7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWQtZ3BpbyA9IDwmZ3BpbzUgMiBHUElPX0FDVElWRV9ISUdIPjsgLyogU09ESU1NDQo+ID4gPiAx
MzcgLyANCj4gPiBVU0JDX0RFVCAqLw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcGluY3RybC0wID0gPCZwaW5jdHJsX3NudnNfdXNiY19kZXQ+Ow0KPiA+ID4g
K8KgwqDCoMKgwqDCoMKgfTsNCj4gPiA+ICsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBncGlvLWtl
eXMgew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0g
ImdwaW8ta2V5cyI7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gPiBAQCAtMjc1LDYgKzI4Miw3IEBAICZ1YXJ0NSB7
DQo+ID4gPiDCoC8qIENvbGlicmkgVVNCQyAqLw0KPiA+ID4gwqAmdXNib3RnMSB7DQo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgZHJfbW9kZSA9ICJvdGciOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgZXh0
Y29uID0gPCZleHRjb25fdXNiY19kZXQ+LCA8JmV4dGNvbl91c2JjX2RldD47DQo+ID4gDQo+ID4g
SG93IGNhbWUgeW91IHVwIHdpdGggdGhpcyBkb3VibGUgZW50cmllcz8gSXMgdGhlcmUgc29tZQ0K
PiA+IGRvY3VtZW50YXRpb24geW91IG5lZWQgDQo+ID4gdHdvIHBoYW5kbGVzPw0KPiANCj4gZXh0
Y29uLXVzYi1ncGlvIHByb3ZpZGVzIGJvdGggdmJ1cy9vdGdfaWQgd2l0aCBhIHNpbmdsZSBoYW5k
bGUsDQo+IGhvd2V2ZXINCj4gdGhlIGludGVncmF0aW9uIGluIGNoaXBpZGVhIGlzIHNvbWVob3cg
d2VpcmQsIHRoZSBmaXJzdCBlbnRyeSBpcw0KPiBzdXBwb3NlZCB0byBiZQ0KPiB1c2VkIHRvIHJl
YWQgdGhlIHZidXMsIHRoZSBzZWNvbmQgb25lIHRvIHJlYWQgdGhlIG90Z19pZC4NCj4gDQo+IFNv
IGlmIHlvdSBuZWVkIHRvIHJlYWQgYm90aCB5b3UgcmVhbGx5IG5lZWQgdG8gaGF2ZSB0aGUgaGFu
ZGxlIHR3aWNlDQo+IC4uLg0KDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uIEFsZXggYW5kIEZy
YW5jZXNjbyBmb3IgYW5zd2VyaW5nLiBJIGNhbm5vdCBhZGQNCm11Y2ggbW9yZSwgd2UgdHJpZWQg
YSBsb3QgYmFjayBhbmQgZm9ydGggZHVlIHRvIHRoZSByZWFsbHkgc3BlY2lhbA0KaGFyZHdhcmUt
ZGVzaWduIHRoaXMgc29sdXRpb24gd2FzIHRoZSBiZXN0IHdlIGZvdW5kIGZvciB0aGUgY29saWJy
aS0NCmlteDZ1bGwuDQoNClJlZ2FyZHMsDQpQaGlsaXBwZQ0KDQo+IA0KPiBGcmFuY2VzY28NCj4g
DQoNCg==

