Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44D2689987
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjBCNQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjBCNQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:16:41 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702B3302BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 05:16:39 -0800 (PST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-gXHNUIDSPFG6e8L8sXfx4Q-2; Fri, 03 Feb 2023 14:16:34 +0100
X-MC-Unique: gXHNUIDSPFG6e8L8sXfx4Q-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0136.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:22::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.25; Fri, 3 Feb 2023 13:16:28 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa%2]) with mapi id 15.20.6064.024; Fri, 3 Feb 2023
 13:16:28 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "viorel.suman@nxp.com" <viorel.suman@nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "oliver.graute@kococonnector.com" <oliver.graute@kococonnector.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@denx.de" <festevam@denx.de>,
        "eagle.zhou@nxp.com" <eagle.zhou@nxp.com>,
        "clin@suse.com" <clin@suse.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "qiangqing.zhang@nxp.com" <qiangqing.zhang@nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "reinhold.mueller@emtrion.com" <reinhold.mueller@emtrion.com>,
        "xiaoning.wang@nxp.com" <xiaoning.wang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "marex@denx.de" <marex@denx.de>,
        "ming.qian@nxp.com" <ming.qian@nxp.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "matthias.schiffer@tq-group.com" <matthias.schiffer@tq-group.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "victor.liu@nxp.com" <victor.liu@nxp.com>,
        "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "denys.drozdov@toradex.com" <denys.drozdov@toradex.com>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>
Subject: Re: [PATCH v6 00/10] arm64: dts: freescale: prepare and add apalis
 imx8 support
Thread-Topic: [PATCH v6 00/10] arm64: dts: freescale: prepare and add apalis
 imx8 support
Thread-Index: AQHZNxuc2WV33kOye0mJeUYf5jP7La69NTqA
Date:   Fri, 3 Feb 2023 13:16:27 +0000
Message-ID: <6e611196a52f7884cad8ccd030280d384d0e403b.camel@toradex.com>
References: <20230202153221.197308-1-marcel@ziswiler.com>
In-Reply-To: <20230202153221.197308-1-marcel@ziswiler.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GVAP278MB0136:EE_
x-ms-office365-filtering-correlation-id: 8774bdcd-2775-4c12-c9f5-08db05e8dbc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: PDeFwHdiPciJTtaYVhygIiMEjnv9kmOfmh0Obnj+FQbIR6IK1/d/qtLzbE2qQLF0BAagCmV5s5k10aO+5xx3rXH8OyCIVgQa0m3ZOzY7wdaxjKPJnygiu1jS/xUXHWndqgdwsuPrMz3kH7rD2t7T7h4rEgAvU0OwZrjlaCvxrJ09EUr6ccrifbMwpbQLee18zyRPPCYthParQzsKWH602FL5co5wYFK6eCjAdlQCcGax9Z7w0nsp2EKM5eRdITHvVE7C//lkj2wsCEMSf2JKMkD2AVHPBGfhtmxLAu2BmCnhIUAL8cHAGx7ytWnvHQhGNFJQdR07A55N2honWmwPkzHgFBQQ5sInJmCYzTHpUZiKG+qDCZJV1BxFIHUQj//ZVcG6/etBsbRDgJ/E4ZFFyEgrRiVpaEoubwaGRBWsnd8PkHjf6MMaSENdsDgrnfh9vWaPJ1oi/sp+3fuQ8EinnnIPnrs1RYsETX0rRG9EQY69elIevPvdjgQzcJFVGApbq1W2DqhMsmXkytTAvrKptFSxOU7sdHa29Ah1wEABfqzRtWPZGofTBANZeSvfbZ1Eh+7UTB60f7+QIEbzMjoAcUESzhgr968PfA0GNoxpJm+sfABt0lknKm/fu9PY2NXsbf3JQS1j3McqmFxMZJSg9xXHCKkMtygBYfGohtWDQvUcvTawm/r2xtgZeefbOb17xgZYMGdpTfSllfmNDCuI0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39850400004)(376002)(396003)(346002)(451199018)(2906002)(54906003)(86362001)(38070700005)(316002)(71200400001)(6486002)(478600001)(122000001)(38100700002)(6512007)(64756008)(83380400001)(41300700001)(186003)(36756003)(8936002)(8676002)(76116006)(4326008)(6916009)(66476007)(6506007)(66556008)(66946007)(66446008)(44832011)(5660300002)(7406005)(7416002)(2616005);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VllvU1BsUnFMQ3h6bXFhOE02R2VFUkFJS3J4Z1lxTUdRMGVqTkptMk5VVUhD?=
 =?utf-8?B?NUttbytHWDFLeUUyeWIvOTdVTDI0TnVFL3lnaTJXK1FxRjZ0OVNMSjdJU3h4?=
 =?utf-8?B?bVZvWWxKeHlyK2RLNWgwODN4N2lPTmlkYzVJTGN2cmxiallQWWhUV2VJL0RO?=
 =?utf-8?B?VEl0bnV2L0lRTllleHltT1hIblM2Y1pBVWdmc0M2MnFQVXRBenFjbGZQRHVz?=
 =?utf-8?B?N1BwTWJPMUJGZ0p6Qk9rNjd6am1VNWsyeUIzc09uUUtOaHRYazlSUys3bzRi?=
 =?utf-8?B?S2lKZTByTzIxU2h6anNLQ21GRFAzL0JMcENPNHkxTGs5dUx3V3h1STZKcFZI?=
 =?utf-8?B?aWZzVjJEaHlFT01wbzBxQjlQUWhERURCVzhFVVdhK3RaL2YyNDlSeXh2TGwz?=
 =?utf-8?B?Unk1MWF6Zmxhb3FBL1UzR0U4SkIxZFNGRGRBN2pjd3NTa1hVUXFvSlpqRG40?=
 =?utf-8?B?Z0RLWGI1dk9BTFc1SlVUZ2pGSXZWSkJXaUpOd3AzbnFRSHhkZjU5TUFuVmxy?=
 =?utf-8?B?bk01c2NRNlVweXQrRktxVzJzUnducmRwcU5kVk1yTzNIcy9WUmVMWHkrVlMv?=
 =?utf-8?B?VjRtTVFieFpWWGp0N20vOE1SMkJjSE9uVGFmVzJmRjBzejF1M2lFaXNsd1VO?=
 =?utf-8?B?TnZWWGFwSFhqSWRLbmtZdHhjbXdSbytwVFdSSmhuejU0b2V5cGx2Z3RYYmZD?=
 =?utf-8?B?YllzSjlIdkMwdUQzYTZrVGVvbnhnOGlhSG9EZkF6M25oYVNuZ0hMWGlMWTNv?=
 =?utf-8?B?aTN6czV4Y1NlcHExR21YNUFKSFlPRHI1Zk01UW9MN1JhdWp6ZGJiZEVHN2VE?=
 =?utf-8?B?MUlveGx4NHBwVG5sbDBncUpFWmlEbUY5NWJFamdGYk5Yc0RRbi9xYTU2V09Y?=
 =?utf-8?B?Qkxoc3hhb2tJTnh3UWorcGJBcE5ZdnNzY3ZKU3FCOHEyejRDQjBPZEpjK0Mv?=
 =?utf-8?B?L0V5NnNTWGMyZ2krZldXOFc2ZTk1MEpWRUt4Y3hpSWlUU2VZMEFTUCtvckdT?=
 =?utf-8?B?M3BRbTg5SUNVeEk1UEI1KzJNeFYzUytzOVdKa2czM0VTc0o0V0tWV2k3STAx?=
 =?utf-8?B?TzFENk5ZdkhSTWlNeEJwSzdyVjdOUmNyVFhWclNGUFE3VWt5MW44bzR4RUw5?=
 =?utf-8?B?a3FMRkZFVHVwTkhxdDR1UUxaQXBKeXBZQlBnSlExbjhqcFowWmx1d1NVYXlT?=
 =?utf-8?B?VlZlSTFYRHhuNGRWcjM1TkdDaFZYdmJBNWJnbTd4K2doS1hGeGdNakxFelkz?=
 =?utf-8?B?RWFiNHRhS1dPaXFXdkZjeTY0am1KdWVaYTZ5V0J4Qzc5S3UxUjNmRWdnM0ZQ?=
 =?utf-8?B?Q09GNFYvVVFOT1UwTC9JQ0lTUlp5dTFUTzBHLy9DdG5XbUlRcmNwbUplTlpi?=
 =?utf-8?B?OGE2d1RLUHo4S2RzTkFjOHFJOVhSRHB3eDFKa2tnRkVpRG1rTXFjUlpGeUEv?=
 =?utf-8?B?V1ZwdWZ5YUp5QnE2VWVFUGxLMDNqRk1HYVFMc3JKS2ZwRXlITlZadVdpT1cv?=
 =?utf-8?B?bjQxUWxWWG8vTHNZMDVhVlNraWlwd2lDMEY2clRPeWYrSGpRNjA5Ri8rZUNM?=
 =?utf-8?B?N2NxWER3M1Q1bldrUjAwc3ZQMDBUV25WTW84blNtblczUHZFTkVhcGxUcEtP?=
 =?utf-8?B?SnpsZ3VTTWUwS28wUnJPWC9XTExaTFU3c0NoQXZXOGlteGlWZlp0OHVLbGYw?=
 =?utf-8?B?b1h3Zi9KcU9nL3BZV0NZNktKdWlxNTJzdkc1N1B1U2xSS2VzN1BqL3JNY21y?=
 =?utf-8?B?SEFZdm9HTUNoOTF2T1ZsL2xRQnN3VDg3d3c1aHZiYldvYVd3YWt2NVEvTGJt?=
 =?utf-8?B?VytSOE5EQ1hEUmV1RWVEUFdPOGdEU2srT1I2VFl0ak01QVVNT1dUbWtJeWtX?=
 =?utf-8?B?aXNrYWZtdEVxc3crN244ZldSN0ZieXJkZmJXVE9xYW5lQzI1ekhVNXdDVkhP?=
 =?utf-8?B?a1NmNVc0QU9kTWpDbnZYTDdNNmFXcUI4RS9vNkx4QnRHTkVRRFBFVDlwT2dB?=
 =?utf-8?B?aTFwNWdSYWp0UkJFK290WHJES0pzVjZFMnFNSldXdm1EYXJ3eUZJbHRoT2FO?=
 =?utf-8?B?UHhqQWxwRUhscTl0UXp3TkFVc25VdnZQTXpwTWR6K09YTUV1aHpLMFZ2RHp6?=
 =?utf-8?B?cUpDWVlFS1ZNYVRaeHY2TzJhUG41c1VKaXFUOStjOUxrUk52L1c4azg5amVD?=
 =?utf-8?Q?IeyRuhVSmvLLtBXwCoTsPLdmXJsO0oqxj/TSFwP0WpUK?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8774bdcd-2775-4c12-c9f5-08db05e8dbc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 13:16:27.9829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hB99BG5Wwu6tHDT724Q+5A12tfU+SzbvH3TJmSZJBnhQyEsB96irQTCo4vb/XEDVA/KDbVKFvBfIYxXSTIGIgvqRloH1rynEjIjZ2EkghhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0136
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <66031C55AE5B1746B2BF57C5F275CDC6@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTAyIGF0IDE2OjMyICswMTAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6
DQo+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0K
PiANCj4gDQo+IEFkZCBzdXBwb3J0IGZvciBsc2lvX3B3bTAtMywgYWRkIGlvLWNoYW5uZWwtY2Vs
bHMgcHJvcGVydHkgZm9yIEFEQw0KPiBub2Rlcywgc2V0IGxwc3BpMCBtYXggZnJlcXVlbmN5IHRv
IDYwTUh6LCBhZGQgbWlzc2VkIExWRFMgbHBpMmMgYW5kIFBXTQ0KPiBwb3dlciBkb21haW5zLCBh
ZGQgZmxleGNhbiBpbiBhZG1hLCBhZGQgY2FuIG5vZGUgaW4gZGV2aWNldHJlZSwgYWRkIHZwdQ0K
PiBkZWNvZGVyIGFuZCBlbmNvZGVyLCBhZGQgdG9yYWRleCxhcGFsaXMtaW14OCBldCBhbC4gdG8g
ZHQtYmluZGluZ3MgYW5kDQo+IGZpbmFsbHksIGFkZCBpbml0aWFsIHN1cHBvcnQgZm9yIEFwYWxp
cyBpTVg4IHNwbGl0IGludG8gbW9kdWxlIGFuZA0KPiBjYXJyaWVyIGJvYXJkIHBhcnRzLg0KPiAN
Cj4gQ2hhbmdlcyBpbiB2NjoNCj4gLSBBZGQgQWxleGFuZGVyJ3MgYWNrZWQtYnkuIFRoYW5rcyEN
Cj4gLSBBZGQgQWxleGFuZGVyJ3MgdGVzdGVkLWJ5LiBUaGFua3MhDQo+IC0gSW5jb3Jwb3JhdGUg
U2hhd24ncyByZXZpZXcgZmVlZGJhY2suIFRoYW5rcyENCg0KU29ycnksIEkgbWlzc2VkIHRoZSBn
ZW5lcmFsbHnCoHdoZW4gU2hhd24gd2FzIHN1Z2dlc3RpbmcgdG8gcHV0IGdlbmVyaWMgcHJvcGVy
dGllcyBiZWZvcmUgZGV2aWNlIHNwZWNpZmljIG9uZXMuDQpMZXQgbWUgcmUtd29yayB0aGUgZGV2
aWNlIHRyZWVzIHdpdGggdGhpcyBpbiBtaW5kIGFkaGVyaW5nIHRvIGhvcGVmdWxseSBhbGwgdGhl
IHJ1bGVzIHdoaWNoIGFwcGx5IGFuZCBzZW5kIGEgdjcNCkFTQVAuDQoNCg0KPiBDaGFuZ2VzIGlu
IHY1Og0KPiAtIFVwZGF0ZSBzdWJqZWN0IHByZWZpeCBhcyBwb2ludGVkIG91dCBieSBLcnp5c3p0
b2YuIFRoYW5rcyENCj4gLSBSZW1vdmUgTFZEUyBQV00gc3VwcG9ydCB3YWl0aW5nIGZvciBMaXUn
cyBwYXRjaGVzIHRvIGxhbmQgZmlyc3QuDQo+IC0gUmVtb3ZlIGJrbDFfcHdtIGZ1bmN0aW9uYWxp
dHkgZGVwZW5kaW5nIG9uIHRoZSBhYm92ZS4NCj4gLSBTcXVhc2hpbmcgYWxsIEFwYWxpcyBpTVg4
IHNwZWNpZmljIGRldmljZSB0cmVlIHBhdGNoZXMuIEFzIG91dGxpbmVkIGJ5DQo+IMKgIEtyenlz
enRvZiByZXZpZXdlcnMgbWF5IHNpbXBseSB1c2UgYjQgZGlmZi4NCj4gDQo+IENoYW5nZXMgaW4g
djQ6DQo+IC0gTmV3IHBhdGNoIGluc3BpcmVkIGJ5IHRoZSBmb2xsb3dpbmcgZG93bnN0cmVhbSBw
YXRjaDoNCj4gwqAgY29tbWl0IDBjMzZjNWI2M2MxZSAoIkxGLTM1NjktMSBmaXJtd2FyZTogaW14
OiBzY3UtcGQ6IGFkZCBtaXNzZWQgbHZkcyBscGkyYyBhbmQgcHdtIHBvd2VyIGRvbWFpbnMiKQ0K
PiDCoCBBdm9pZGluZyB0aGUgZm9sbG93aW5nIGJlaW5nIHJlcG9ydGVkIHVwb24gYm9vdDoNCj4g
wqAgW8KgwqDCoCAxLjMwOTc3Nl0gbHZkczBfcHdtMF9jbGs6IGZhaWxlZCB0byBhdHRhY2hlZCB0
aGUgcG93ZXIgZG9tYWluIC0yDQo+IMKgIFvCoMKgwqAgMS4zMzQwOTddIGx2ZHMxX3B3bTBfY2xr
OiBmYWlsZWQgdG8gYXR0YWNoZWQgdGhlIHBvd2VyIGRvbWFpbiAtMg0KPiDCoCAuLi4NCj4gwqAg
W8KgwqAgMTUuMjgxNzY3XSBwbGF0Zm9ybSA1NzI0NDAwMC5wd206IGRlZmVycmVkIHByb2JlIHBl
bmRpbmcNCj4gwqAgLi4uDQo+IMKgIFvCoMKgIDE1LjI5MjYzMF0gcGxhdGZvcm0gYmFja2xpZ2h0
OiBkZWZlcnJlZCBwcm9iZSBwZW5kaW5nDQo+IC0gTmV3IHBhdGNoIGNvbWJpbmluZyB0aGUgZm9s
bG93aW5nIGRvd25zdHJlYW0gcGF0Y2hlczoNCj4gwqAgY29tbWl0IGU4ZmUzZjU3MjIzYSAoImFy
bTY0OiBkdHM6IGlteDhxeHA6IGFkZCBGbGV4Q0FOIGluIGFkbWEiKQ0KPiDCoCBjb21taXQgNGU5
MDM2MWYxZWQzICgiYXJtNjQ6IGR0czogaW14OHF4cDogYWRkIG11bHRpLXBkIHN1cHBvcnQgZm9y
IENBTjEvMiIpDQo+IMKgIGNvbW1pdCA4OTlmNTE2ZTYxZjggKCJhcm02NDogZHRzOiBpbXg4OiBk
bWE6IGZ1bGx5IHN3aXRjaGVkIHRvIG5ldyBjbGsgYmluZGluZyIpDQo+IMKgIGNvbW1pdCA4YTI4
Y2ExNWEwNTggKCJhcm02NDogZHRzOiBpbXg4cXhwOiBkcm9wIG11bHRpLXBkIGZvciBDQU4gZGV2
aWNlIikNCj4gwqAgY29tbWl0IGM0OTM0MDIxOTdkZCAoImFybTY0OiBkdHM6IGlteDg6IHVwZGF0
ZSBDQU4gZnNsLGNsay1zb3VyY2UgYW5kIGZzbCxzY3UtaW5kZXggcHJvcGVydHkiKQ0KPiAtIE5l
dyBwYXRjaCBpbnNwaXJlZCBieSB0aGUgZm9sbG93aW5nIGRvd25zdHJlYW0gcGF0Y2g6DQo+IMKg
IGNvbW1pdCAxMTc2MDdlNmE3YjUgKCJhcm02NDogZHRzOiBpbXg4cW06IGFkZCBDQU4gbm9kZSBp
biBkZXZpY2V0cmVlIikNCj4gLSBOZXcgcGF0Y2ggY29tYmluaW5nIHRoZSBmb2xsb3dpbmcgZG93
bnN0cmVhbSBwYXRjaGVzOg0KPiDCoCBjb21taXQgNGYyMTQ3Y2U2ZjBlICgiYXJtNjQ6IGR0czog
aW14OHFtOiBhZGQgdnB1IGRlY29kZXIgYW5kIGVuY29kZXIiKQ0KPiDCoCBjb21taXQgMGM5Zjli
NjRkMjdkICgiTEYtNjU3NTogaW14OHE6IHZwdTogc3dpdGNoIHRvIGFtcGhpb24gdXBzdHJlYW0g
ZHJpdmVyIikNCj4gLSBTaG9ydGVuIHN1YmplY3QuDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAt
IEZpeCBzdWJqZWN0IGFzIHBvaW50ZWQgb3V0IGJ5IFNoYXduLiBUaGFua3MhDQo+IC0gUHJvcGVy
bHkgYWNjb21tb2RhdGUgZm9yIC12MS4xIG1vZHVsZXMgY3VydHNleSBGcmFuY2VzY28uDQo+IC0g
T25seSB1c2UgVjEuMSBjb21wYXRpYmxlIGZvciBWMS4xIG1vZHVsZSBkdHNpLg0KPiAtIFNwbGl0
IHBhdGNoIGludG8gc2VwYXJhdGUgbW9kdWxlIGFuZCBjYXJyaWVyIGJvYXJkcyBwYXJ0cyBhcyBz
dWdnZXN0ZWQNCj4gwqAgYnkgU2hhd24uDQo+IC0gUHV0IHJlZyBhZnRlciBjb21wYXRpYmxlIGFz
IHJlcXVlc3RlZCBieSBTaGF3bi4NCj4gLSBNb3ZlIGF0bWVsX214dF90cyBhbmQgcnRjX2kyYyBp
bnRvIG1vZHVsZSBkdHNpIHRvIHNhdmUgc3VjaA0KPiDCoCBkdXBsaWNhdGlvbnMgYXMgc3VnZ2Vz
dGVkIGJ5IFNoYXduLg0KPiAtIENoYW5nZSBpb211eGMgcGluY3RybCBpbmRlbnQgc3R5bGUgYXMg
c3VnZ2VzdGVkIGJ5IFNoYXduLg0KPiAtIENoYW5nZSBsZWQgbm9kZSBuYW1lcyB0byB0aGUgcHJl
ZmVycmVkIGZpcnN0IGZvcm0gYXMgc3VnZ2VzdGVkIGJ5DQo+IMKgIFNoYXduLiBXaGlsZSBhdCBp
dCBhbHNvIGFkZCBjb2xvciAoeWlrZXMpLCBkZWZhdWx0LXN0YXRlIGFuZCBmdW5jdGlvbg0KPiDC
oCBwcm9wZXJ0aWVzIGFuZCByZW1vdmUgdGhlIGRlcHJlY2F0ZWQgbGFiZWwgcHJvcGVydHkuDQo+
IC0gUHV0IGVuYWJsZS1hY3RpdmUtaGlnaCBwcm9wZXJ0aWVzIGFmdGVyIHRoZSBncGlvIG9uZXMg
YXMgc3VnZ2VzdGVkIGJ5DQo+IMKgIFNoYXduLiBUaGFua3MhDQo+IC0gUmVtb3ZlIGFkYyBub2Rl
J3MgdnJlZi1zdXBwbHkgYW5kIGFjY29tcGFueWluZyByZWdfdnJlZl8xdjggcmVndWxhdG9yDQo+
IMKgIG5vZGUuDQo+IC0gUmVuYW1lIGdwaW8taG9ncyBhZGhlcnJpbmcgdG8gZHQgc2NoZW1hIG5h
bWluZyBjb252ZW50aW9uLg0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBGaXhlZCBtaXNzaW5n
IHNwYWNlIGluIHRoZSBjb21tZW50IFYxLjFNb2R1bGUgY3VydHNleSBNYXguDQo+IC0gQWRkZWQg
Um9iJ3MgYWNrLg0KPiANCj4gQ2xhcmsgV2FuZyAoMSk6DQo+IMKgIGZpcm13YXJlOiBpbXg6IHNj
dS1wZDogYWRkIG1pc3NlZCBsdmRzIGxwaTJjIGFuZCBwd20gcG93ZXIgZG9tYWlucw0KPiANCj4g
Sm9ha2ltIFpoYW5nICgyKToNCj4gwqAgYXJtNjQ6IGR0czogaW14OHF4cDogYWRkIGZsZXhjYW4g
aW4gYWRtYQ0KPiDCoCBhcm02NDogZHRzOiBpbXg4cW06IGFkZCBjYW4gbm9kZSBpbiBkZXZpY2V0
cmVlDQo+IA0KPiBNYXJjZWwgWmlzd2lsZXIgKDMpOg0KPiDCoCBkdC1iaW5kaW5nczogYXJtOiBm
c2w6IGFkZCB0b3JhZGV4LGFwYWxpcy1pbXg4IGV0IGFsLg0KPiDCoCBhcm02NDogZHRzOiBmcmVl
c2NhbGU6IGFkZCBpbml0aWFsIGFwYWxpcyBpbXg4IGFrYSBxdWFkbWF4IG1vZHVsZQ0KPiDCoMKg
wqAgc3VwcG9ydA0KPiDCoCBhcm02NDogZHRzOiBmcmVlc2NhbGU6IGFkZCBhcGFsaXMgaW14OCBh
a2EgcXVhZG1heCBjYXJyaWVyIGJvYXJkDQo+IMKgwqDCoCBzdXBwb3J0DQo+IA0KPiBNYXggS3J1
bW1lbmFjaGVyICgxKToNCj4gwqAgYXJtNjQ6IGR0czogaW14OC1zcy1kbWE6IGFkZCBpby1jaGFu
bmVsLWNlbGxzIHRvIGFkYyBub2Rlcw0KPiANCj4gUGhpbGlwcGUgU2NoZW5rZXIgKDIpOg0KPiDC
oCBhcm02NDogZHRzOiBmcmVlc2NhbGU6IGlteDgtc3MtbHNpbzogYWRkIHN1cHBvcnQgZm9yIGxz
aW9fcHdtMC0zDQo+IMKgIGFybTY0OiBkdHM6IGZyZWVzY2FsZTogaW14OC1zcy1kbWE6IHNldCBs
cHNwaTAgbWF4IGZyZXF1ZW5jeSB0byA2MG1oeg0KPiANCj4gWmhvdSBQZW5nICgxKToNCj4gwqAg
YXJtNjQ6IGR0czogaW14OHFtOiBhZGQgdnB1IGRlY29kZXIgYW5kIGVuY29kZXINCj4gDQo+IMKg
Li4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1swqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDE5ICsNCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZcKgwqDC
oMKgwqDCoMKgIHzCoMKgwqAgNSArDQo+IMKgLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LWFw
YWxpcy1ldmFsLmR0c2nCoCB8wqAgMTQ0ICsrDQo+IMKgLi4uL2R0cy9mcmVlc2NhbGUvaW14OC1h
cGFsaXMtaXhvcmEtdjEuMS5kdHNpIHzCoCAyMjAgKysrDQo+IMKgLi4uL2R0cy9mcmVlc2NhbGUv
aW14OC1hcGFsaXMtaXhvcmEtdjEuMi5kdHNpIHzCoCAyNzAgKysrDQo+IMKgLi4uL2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4LWFwYWxpcy12MS4xLmR0c2nCoCB8IDE0ODQgKysrKysrKysrKysrKysr
KysNCj4gwqAuLi4vYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgtc3MtZG1hLmR0c2kgfMKg
wqAgNzYgKy0NCj4gwqAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgtc3MtbHNpby5kdHNpwqDC
oMKgwqDCoCB8wqDCoCA0OCArDQo+IMKgLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cW0tYXBh
bGlzLWV2YWwuZHRzIHzCoMKgIDE2ICsNCj4gwqAuLi4vZnJlZXNjYWxlL2lteDhxbS1hcGFsaXMt
aXhvcmEtdjEuMS5kdHPCoMKgwqAgfMKgwqAgMTYgKw0KPiDCoC4uLi9kdHMvZnJlZXNjYWxlL2lt
eDhxbS1hcGFsaXMtdjEuMS1ldmFsLmR0cyB8wqDCoCAxNiArDQo+IMKgLi4uL2lteDhxbS1hcGFs
aXMtdjEuMS1peG9yYS12MS4xLmR0c8KgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMTYgKw0KPiDCoC4u
Li9pbXg4cW0tYXBhbGlzLXYxLjEtaXhvcmEtdjEuMi5kdHPCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
IDE2ICsNCj4gwqAuLi4vZHRzL2ZyZWVzY2FsZS9pbXg4cW0tYXBhbGlzLXYxLjEuZHRzacKgwqDC
oMKgIHzCoMKgIDE2ICsNCj4gwqAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS1hcGFsaXMu
ZHRzacKgwqDCoMKgIHzCoCAzNDAgKysrKw0KPiDCoC4uLi9ib290L2R0cy9mcmVlc2NhbGUvaW14
OHFtLXNzLWRtYS5kdHNpwqDCoMKgwqAgfMKgwqAgNDQgKw0KPiDCoGFyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhxbS5kdHNpwqDCoMKgwqAgfMKgwqDCoCA0ICsNCj4gwqBkcml2ZXJz
L2Zpcm13YXJlL2lteC9zY3UtcGQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgwqAgNCArDQo+IMKgMTggZmlsZXMgY2hhbmdlZCwgMjc1MyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDgtYXBhbGlzLWV2YWwuZHRzaQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LWFwYWxpcy1peG9yYS12MS4xLmR0c2kNCj4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OC1h
cGFsaXMtaXhvcmEtdjEuMi5kdHNpDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDgtYXBhbGlzLXYxLjEuZHRzaQ0KPiDCoGNyZWF0ZSBtb2Rl
IDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cW0tYXBhbGlzLWV2YWwu
ZHRzDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhxbS1hcGFsaXMtaXhvcmEtdjEuMS5kdHMNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFtLWFwYWxpcy12MS4xLWV2YWwuZHRzDQo+
IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhx
bS1hcGFsaXMtdjEuMS1peG9yYS12MS4xLmR0cw0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cW0tYXBhbGlzLXYxLjEtaXhvcmEtdjEuMi5k
dHMNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OHFtLWFwYWxpcy12MS4xLmR0c2kNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFtLWFwYWxpcy5kdHNpDQo=

