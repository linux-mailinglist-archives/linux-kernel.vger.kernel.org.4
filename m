Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA535609682
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 23:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJWV1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 17:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJWV1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 17:27:22 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C2E66874
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 14:27:21 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-3a2WCR6DNna4B4JR5mElEA-2; Sun, 23 Oct 2022 23:27:18 +0200
X-MC-Unique: 3a2WCR6DNna4B4JR5mElEA-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0903.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:52::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Sun, 23 Oct 2022 21:27:16 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3c38:efa9:5eff:4caa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3c38:efa9:5eff:4caa%4]) with mapi id 15.20.5746.023; Sun, 23 Oct 2022
 21:27:16 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v1 2/8] arm64: dts: verdin-imx8mm: verdin-imx8mp: improve
 include notation
Thread-Topic: [PATCH v1 2/8] arm64: dts: verdin-imx8mm: verdin-imx8mp: improve
 include notation
Thread-Index: AQHYzqE+I/phM+AqSEyEC+imRWjmYK4cry6A
Date:   Sun, 23 Oct 2022 21:27:16 +0000
Message-ID: <69449ded99d51315e0a8133239dcdaa4d1547168.camel@toradex.com>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
         <20220922162925.2368577-3-marcel@ziswiler.com>
In-Reply-To: <20220922162925.2368577-3-marcel@ziswiler.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB0903:EE_
x-ms-office365-filtering-correlation-id: 97430b46-e513-4724-44fb-08dab53d5bb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: Jt29tLhcNX3Nlt7IWu2CjBC6c4gU5fjpNTVbl+tIyL02FD+LRfI26f1DS1V+y9NPoGUWUeoXp3Ud9QSs8gKOSUOtAM7QceorR/UKT/Wc7hDvUhnJELdsnWKP01Rp8hhTarRXIRrozeWdAoAqV7z8iENhmysVqBoscfei/Y+H+b/KauysWdtChXjjofTUnMAPLuja/KOnTOCoJJhPUnG8LrmhW6fyUQGPJu1AL5G6m/lq+X/BdKS1DNiPsrtMqUFxie703UXqNAPOnnvmbokK5A6vlWV7A7xhfCpuKgqnQ6v2z5o6bZ9GT2XXAb6cM2WFU6d8bihNgIaUr+vDE677Vci3hZ5ISReKsN/aD8pK+oqr2NweVU0Yz9qUMeNRP0TCOEi8vaQ4Qe2tX8LrUL4IvRTN09xt5iNKs+Evt64MpJpLsoZU6ymR3j1r4EmDBKKkNQUxgEC+aySMuGNapshTtW6qJMunlrQ07l7KlOTnlPzRlV2079Jt9inY9OnOtqQVeodzINUTCl6MWtRUwR19QQ79nu9LmdILLIm4po4vJ/HeOO7cKd7wx164z63+h8YpQ/Cu6aFvNlqWpQmGuyL40HAgl0ADKuD2vQIHsYyKnmCESQif40HWzdQNC/yq+UuCDESGRyTbl1qWL/yCEXVGCf4kI3eqknVToEv7E8TlAAQBwpfKr27q1i/VYf0Z5P7+Bp7eGsiDImTuCwZvcDEaJDGh+5Cr9HZm8hqKj5sZkde9PY9W3NbMlyHfPHeYW2g+WwF5jU4qQv1Fi78mXmb1pQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(366004)(39830400003)(451199015)(36756003)(38100700002)(41300700001)(122000001)(38070700005)(83380400001)(66946007)(86362001)(186003)(6512007)(2616005)(6506007)(2906002)(478600001)(44832011)(71200400001)(5660300002)(8936002)(7416002)(6486002)(6916009)(54906003)(316002)(4326008)(8676002)(66476007)(66446008)(64756008)(66556008)(76116006);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2NlTDRvM2dhd1J5K1YrdkJoNFdRUFYvV3hINHFKNzVZQytPc1BLenVGOWRN?=
 =?utf-8?B?WHZJSzBzU3hjVGt5SjFhRUpFU2pmQ2hLQlRyNWtkRFdkdXMvVEh4YmRxYVpH?=
 =?utf-8?B?RzhXcVN2YWZ4WTlpaXl1TE83WldFOFNSdU10cC8wbXlJWkcybzl1M0NNKzV0?=
 =?utf-8?B?TkF4b200WWFFTlhVaEpTTS81U2t5WnpBMGUzYm5tQmRzS09wZGtFc3FMSG9r?=
 =?utf-8?B?MEV2TE1MWU96UjR6d2p6R2JCRXdUMUp2aW93em5KbkF6VnNxUjVIRGlHNWUw?=
 =?utf-8?B?aTd4V0JCTjNnaUZHZEVwVXRsbWtqaWZGbTBIK0o0bXJJQlkwS2pvMmRBMStu?=
 =?utf-8?B?TEZSLzNlTmUzQ2ovdnpEcW9Id1BaTC9FRFg0d3kyYnZ6NEFNSDl2Q1d2N0o2?=
 =?utf-8?B?a2t1YnNoT0s5NGxxSmdzaEZUVXJUNHE2NXh2RXptUXdHd3hUT0ZmdVA0VWNC?=
 =?utf-8?B?RDBjOEI1N3hIUGtsV0hTd0IrUTZ5TjNVT1p5V0M1azlsYjE1K1FPRXhZaFJ1?=
 =?utf-8?B?aGNWUWV4Yit6Y2VvNi9YRlQrUGZmUGdxRW1jZGo5bnVwZVZxR09lbnpCNHJi?=
 =?utf-8?B?Zy9rcFJEeG5KanN2eVBiREJMY2JzTk9LbE5IdS9NNzAvcmVNZWp1MVhMVU04?=
 =?utf-8?B?eVJZRi90bWM5T2tCS0RJWjdYWU5jVW1WdDI5UHFRRmJSeHR0M3VvTjZRdFVj?=
 =?utf-8?B?V2NzRWZSYjRWV0JSSFZhMUE2V2kzWnBxZkRJUFAvUU5iMk9MVlp1Yk53YlNx?=
 =?utf-8?B?N3VrektGZG9iMEZZK3VWMDYyckFyOW5nRDNiWktnRVZ6aWdRcktiR3h6aHlY?=
 =?utf-8?B?eDJDWW9icktSVU56Sit6ZlY1dHB6MkIzblN2c1ZFRlgySnpmZzdFR1FqVW5I?=
 =?utf-8?B?Z2gvanZQbGJmaDFlazdRVEg2azRYSEZsNWJiQVJmOGZ4cnFBbXNuZFg1Tjlu?=
 =?utf-8?B?T0Jac3ZCLzNwVnR5cXFZcWZ3SEJ2U1pCRlcrcUkrN1Nuc251cm9kaXhzUFFq?=
 =?utf-8?B?K2J4R0srQ0xaSFJGUnJxUEZrMWVUdDFPVURsZGZCbzhrc21SQlFOaHZBYUtP?=
 =?utf-8?B?QzI0U1J0d2VwS09TZUVtUFlIVVBHT1NET3diMHMxV0FJamhiRDJjakx5ZWM3?=
 =?utf-8?B?WWhYTkdJMGV5aHIyYjdHWnZ4VDJOR2pvQTllRnY1SWVzbG5abmZJU2RmdndV?=
 =?utf-8?B?bHVRbVRMVXZ3b3gxUkFkWlNTRVhoc2RjemQwVzN5cUNCYW5iRnVzYzdjSWZG?=
 =?utf-8?B?V1pLaWIvWkJwTFFHS2RRUjRDdVM4eW1KWEFaLzFBd0I1RmVHVjZxR1QrQmk1?=
 =?utf-8?B?ZWZFMkEvQmFsZFlSbEtVazQxSkJTSlVURWpmeG1rbVgzV1RQVmcwd2dQTVJ5?=
 =?utf-8?B?MnU0T0IvWUVkQnlVRmVoWTNOSmUwelFsZmsxVXdRUldvaEk3V1FkRDBCUk1m?=
 =?utf-8?B?YkMraEZwQ0xYdUY5QUEvSW14SEJCSkJMdExYWVViWm9Rc0Z6a0ExbTdLVC9z?=
 =?utf-8?B?V1h2RVdaS3lLb3kvR0hXd1VMVWRJdUIzQ3hWcEFSb0F0UVIrL0RkdHRnZUdw?=
 =?utf-8?B?azRLSWVOZnFBRk40UmtEendLc0NZSWhPV0Z3N3BlNWVXWGNwdmdycUdCajJy?=
 =?utf-8?B?aFNhSnBod3ovWkZwZEZVVXFua3R3Ri91NFg5N0pOTHU3RUcvNWpJSUtBbHI2?=
 =?utf-8?B?VFVBYi8zaUFkYkFQamxFZFZZWk9tZHdXTVFCTVhaWUdKMXpJMnpEdmVKSUYz?=
 =?utf-8?B?Qm1vZWNhYU15Qlo0QVFiSDNCUitmSDVFTmVzQ0hBS3NzbXNCYXlzNFpueTdt?=
 =?utf-8?B?WTNzSVRXOUx5N1BlOXY2UExPN2I2U1BSMjk0NlBqZVMxd3h6ejVDYVlQUVlu?=
 =?utf-8?B?ME5oNG5WWGU1clJqbE81a1MrYVNEdUdCdnByOW94cGI2UG5hR1RhNkVvcGxY?=
 =?utf-8?B?OHZ2cGFsUzhWRGM5d25lTStpMFAxU0d5YzFLQVZzRDVGc3AzRlpRZ1FKeko5?=
 =?utf-8?B?UGRKKzVMMVlONzVZS25SVzgxelRGd0RQR2hKbGlKY25xZ280RG1uQ2dHcmFH?=
 =?utf-8?B?Z0dRWm5PT2tqc0N6cFVwa0dYTGVONE5FZ0tvWnBlbXhONWNicFY4REJqWVNJ?=
 =?utf-8?B?L2R1b1ZzQ1hobDV4VWN0andVVzhockFBM2pscGtHR1FYcHN4V1hmQzZDUDNU?=
 =?utf-8?Q?v4T3P79mVzl6sWb2a5BpGnmqNL6vVmPZuv/zt3ZC663n?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 97430b46-e513-4724-44fb-08dab53d5bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 21:27:16.2141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZuMAVatKB6mcgCO+ocI4JmxDDIz2QltW5OkVolwVAlx4jXitDRl/NSvNdA2LOYEgzhIKpAiLtfwlJH8xXSTgFuh2pRnWyylmpfWDEy7rbBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0903
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <85A72BE46BD69C41A1AF13F71A1E1916@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24NCg0KT24gVGh1LCAyMDIyLTA5LTIyIGF0IDE4OjI5ICswMjAwLCBNYXJjZWwgWmlz
d2lsZXIgd3JvdGU6DQo+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRv
cmFkZXguY29tPg0KPiANCj4gSW1wcm92ZSBpbmNsdWRlIG5vdGF0aW9uLiBVc3VhbGx5IG9ubHkg
ZHRzaSBmaWxlcyBmcm9tIHRoZSBzYW1lIGxvY2F0aW9uDQo+IGFyZSBpbmNsdWRlZCB3aXRoIGFu
IGFic29sdXRlIHBhdGggaW4gcXVvdGVzLiBPdGhlcnMgc2hvdWxkIHVzZSBhDQo+IHJlbGF0aXZl
IHBhdGggZW5jbG9zZWQgaW4gYW5nbGUgYnJhY2tldHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBN
YXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gLS0tDQo+IA0K
PiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS12ZXJkaW4uZHRzaSB8IDQg
KystLQ0KPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC12ZXJkaW4uZHRz
aSB8IDMgKystDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1tLXZlcmRpbi5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1t
LQ0KPiB2ZXJkaW4uZHRzaQ0KPiBpbmRleCBiMzc5YzQ2MWFhMTMuLmE3NDlkMDYzYzM2NyAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXZlcmRpbi5k
dHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS12ZXJkaW4u
ZHRzaQ0KPiBAQCAtMyw4ICszLDggQEANCj4gwqAgKiBDb3B5cmlnaHQgMjAyMiBUb3JhZGV4DQo+
IMKgICovDQo+IMKgDQo+IC0jaW5jbHVkZSAiZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUu
aCINCj4gLSNpbmNsdWRlICJkdC1iaW5kaW5ncy9wd20vcHdtLmgiDQo+ICsjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUuaD4NCj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9w
d20vcHdtLmg+DQo+IMKgI2luY2x1ZGUgImlteDhtbS5kdHNpIg0KPiDCoA0KPiDCoC8gew0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXZlcmRpbi5k
dHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLQ0KPiB2ZXJkaW4uZHRz
aQ0KPiBpbmRleCAzNjBiZTUxYTM1MjcuLmVlNDIzMWQxMzhmZSAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXZlcmRpbi5kdHNpDQo+ICsrKyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC12ZXJkaW4uZHRzaQ0KPiBAQCAtMyw3
ICszLDggQEANCj4gwqAgKiBDb3B5cmlnaHQgMjAyMiBUb3JhZGV4DQo+IMKgICovDQo+IMKgDQo+
IC0jaW5jbHVkZSAiZHQtYmluZGluZ3MvcHdtL3B3bS5oIg0KPiArI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL3BoeS9waHktaW14OC1wY2llLmg+DQoNClNvcnJ5LCBJIGp1c3Qgbm90aWNlZCB0aGF0IGFi
b3ZlIGxpbmUgc2xpcHBlZCBpbiBmcm9tIHBhdGNoIDYuIEhvd2V2ZXIsIGF0IGxlYXN0IGl0IHNo
b3VsZCBub3QgaHVydCBhcyB0aGF0DQpoZWFkZXIgZmlsZSBkb2VzIGluZGVlZCBleGlzdCBzaW5j
ZSBxdWl0ZSBhIHdoaWxlIHdoZW4gUENJZSBzdXBwb3J0IGdvdCBtZXJnZWQgZm9yIHRoZSBNaW5p
Lg0KDQo+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcHdtL3B3bS5oPg0KPiDCoCNpbmNsdWRlICJp
bXg4bXAuZHRzaSINCj4gwqANCj4gwqAvIHsNCg0KQ2hlZXJzDQoNCk1hcmNlbA0K

