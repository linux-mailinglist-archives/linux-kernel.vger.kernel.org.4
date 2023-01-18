Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6262A671FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjAROnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjAROnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:43:13 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23694FAD2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:34:45 -0800 (PST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-DiGjuonDNXymvtCr16eiqw-1; Wed, 18 Jan 2023 15:34:42 +0100
X-MC-Unique: DiGjuonDNXymvtCr16eiqw-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0123.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:19::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.24; Wed, 18 Jan 2023 14:34:40 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa%2]) with mapi id 15.20.6002.012; Wed, 18 Jan 2023
 14:34:40 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v4 14/17] arm64: dts: freescale: apalis-imx8: add flexcan
 functionality
Thread-Topic: [PATCH v4 14/17] arm64: dts: freescale: apalis-imx8: add flexcan
 functionality
Thread-Index: AQHZKw5uE4UzkrM3dE+jtOLW+8IJQq6kNIAAgAAJYIA=
Date:   Wed, 18 Jan 2023 14:34:40 +0000
Message-ID: <7b43598d09ac5e22d4636d809db344f98ca03dcd.camel@toradex.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
         <20230118072656.18845-15-marcel@ziswiler.com>
         <91b93fed-5bf1-b1d8-0bca-1b945b57a576@linaro.org>
In-Reply-To: <91b93fed-5bf1-b1d8-0bca-1b945b57a576@linaro.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB0123:EE_
x-ms-office365-filtering-correlation-id: c71d2d6b-d64a-4cd0-bcae-08daf9612212
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: fVqNmRVuQGaThhhTUaKU1BE8wVlCkxWp1yfUZqRT6IAva6FVOMacCE5Q0IY2ZEeBFSP6cQNqrTSvdaDxo61f0P1oPTcS3gY6ryFc7+bgL1QoFpQ4an1RNlFZfCaFLb5MCaPuW7BHtXPaZNkwzOKfGmL7RbzEIOHA13iBSJrUZIg1EksIbxe2KCcQJKZDj3uPfk9ucV8s3Glrp4wVwnLMvYSgn988FUhWg4kRT0RUh9lPNJSSo2wcxaLjwVFoX93m0sxIEkL19JPfOft2VYgE/9tGcK3a4W7BDdAion80V95Mxf0wkn5cbzAT1QLAcBy6P7WKST7Nfmg27D/z9IAKrZoD4RLP/JVee58oOl/JFvgBM7b42IpIHKTansfekMkYfcH+2j6m+NHuTYCj9yy83ZfW08RjAdnOiMnGfAI60E7/6AYRYhzntV1GzloNbLcd9ilqbN9cfyQBiXPusSe5Gd1SdmCVyaYpKAi0lrOZXwJ2+3we0dztJcZJseiQZqXupNfS61CV0UEhK4NEfoq/Gsq7OpjXlZ7W09CkRtnDu2C2JIPcFDEAQ0/tdnB76yW0gJt0vfznZqMysw3lNlz7YA15YxZC5pDSkDy5nhf/sZge374y/mnBb9DGikSdi1+/UESs7EzrB7mdXr3bXEHMZlhr0Vn8QWuG7JO9Mou3gJRLEzOrpNPsqJ9G0d5eylv/X1v4o9+MbY5DY1JGAPtRfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39840400004)(396003)(346002)(376002)(366004)(451199015)(122000001)(38100700002)(38070700005)(8936002)(66476007)(5660300002)(44832011)(66946007)(2906002)(7416002)(76116006)(66556008)(66446008)(64756008)(8676002)(4326008)(41300700001)(26005)(2616005)(6512007)(186003)(83380400001)(53546011)(71200400001)(54906003)(110136005)(86362001)(6486002)(36756003)(478600001)(316002)(6506007);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXd4bE5jZk1Qem04cm8yaU5waWU3YjRyZnVSZjJFSjM5QkJ5UFR6SmR1M1Rt?=
 =?utf-8?B?TkxhMzd0NzlBQ1NlM1lWektaWG5meVFxZDRDWmtjS2hnQXVub0FwbFhXV3VV?=
 =?utf-8?B?UDArZlV5ZHJqUC9ESElIZm5qSjd5NkpiS2IyRUhCeEpxcEI4bHdpV1k0OUxt?=
 =?utf-8?B?bmtYMlQyYkh5d0tqa3N6MGNXSm5scGxzNnpITDN6SGRtNGRXZTFPYUFSUmsv?=
 =?utf-8?B?VXhwOHhNNXhBczNSSk5OekFPVTdCZjNhUDhGcEZmYk84N3BsOC9HTXNYcysy?=
 =?utf-8?B?YnVhcEdBQWtFYkorQk03bzEwVzQ4M0NhTFJWSXRxTGxsM3owVjYrbnVjVkhQ?=
 =?utf-8?B?ZWl3YjYzRDlYazFwU3V3VnV6aU05OXBYUWVxa2ZrVkxjU3ZPa0oyeW9xTGt0?=
 =?utf-8?B?c08xa3pSL3RlNzZTc3lBQ002Ly9iQWVIWmRiZ3J1bmR5RHlIV0tFNVF2azJD?=
 =?utf-8?B?LytabE5jQVQ2M3lLVHg5SVJvZCtHRWV1cnpoM1Byem0rd1MyYmRxTzR0L1V5?=
 =?utf-8?B?b0NqOEI2SHA4TFB0NkxjVldHWS9HSnlNRTc0Z0cxdk5KSTNsdVhDbE5GNGJ6?=
 =?utf-8?B?a0k0ZWdnZU53bWFjKzVFbElmcEhkZ0VvZzc1KzdiRjl1R0N6S1dIU0NpcGtw?=
 =?utf-8?B?VEd1a25KODJwbXhqZUtqWVNMc0k4L0FIWDBkbm5DdVV4OHBneFE0cjBlOHhv?=
 =?utf-8?B?MXhhWmI2WG1qTndteVh4MTBOMTlmVkFsK0piZm4rUE95VTZRd2N4eFY0bHV5?=
 =?utf-8?B?S01yTkcxdGZNaWlxWm15TlFYS1JMNWd4dmVNejdId2FIS3Z6aHZ0U2F6NkFD?=
 =?utf-8?B?cG5URDExZzU1Vk1ZZHA4Q0wrZ0Z4a0krb2hFWTY3VXQ5SGIzNjlVYzN0eHdE?=
 =?utf-8?B?RkRIY1lrVEdkZkY3QTIyUmdMZ1AzNEFlTnRNQkJEdURta29ETU05cS9LdGFZ?=
 =?utf-8?B?N2RvcVltMFhzNDJlSnJVSUh2SUpIT0VQd09EampTU2g1K3dTQ3JxRGIxVW8z?=
 =?utf-8?B?emlDYUpGNEJHTk03K3hIUWZBWGE1NU5IcTVNcVRYN05Bck1xL21ScVVPc20z?=
 =?utf-8?B?WHlGeDBDNWpvbTVFQ2NEUk01ZVNLMTNhYkYzUUhRTnFkTkhTM2dHRmgwRWVV?=
 =?utf-8?B?S2IzcnBBa1JwZlRUM1dCS0sxWlM5Z3FJSUZ1QmxZNHhrSXpFaUc3d1dvb1lP?=
 =?utf-8?B?REVkYXpwMFpIc1BSWUQ2OTh5UTdFa3VGT1ZSbjhOcmlES1hjbTl1S2xJUFRx?=
 =?utf-8?B?VXEwQUJJNURER1hIYVEvRkhadmxUR09hVXlybE5TVmhsZFJqZG84OHVqN2gz?=
 =?utf-8?B?NVhzdjBxSkNkaGFxdEY5cGlKVWRtdC9QdFNseVd6UG5lYnpkSm5iQmYvYXR2?=
 =?utf-8?B?eUpKTGpRbmpwZnFvYlNjMUhYRkRuWTloYkEvR01vZVdZWHVEbjZCamM0U2Er?=
 =?utf-8?B?ZWF5d1V3em9GdGd2aVZIZXZrek9XTHNoQUV0V1o5Y1lNbWtkR2RJNHhGSWEv?=
 =?utf-8?B?dFAvbUs0RjJTaE5QRkdSS3hCWWExTjVIMXhBUitMVHJCY0M2aWNXV0V1UXZN?=
 =?utf-8?B?cndNZDkwUllYV1U4YW9rcVNDNHZzUVV3dGtmcWtJT21YSVVYUm5Ud2tVQVhl?=
 =?utf-8?B?azVNRWxSajN4ZXlScVJ4UVB5ckVlZ2ZwbmJTSFBtNXZBSVJZSUhqd3hOYVJx?=
 =?utf-8?B?c1k5ZDFLT2pGY1NlK3RsZVlhNm50U2tUUXB1cEl2Q2pockprM1p5L0VldjZO?=
 =?utf-8?B?TitkL1BJYnhZQngySHN4TlBRSkNIRGZwdmtpV1BjZHV2d0pEeUhRN0xHelIw?=
 =?utf-8?B?YVVWOUZPbmJrZVV2b2FPSDdwQjhBcjhiNDYwRXJDK1FsaHc4UnBXMUhkQWFC?=
 =?utf-8?B?aXhBV2RQRVlIQWd0SWVKRzU2Yk9oWlZSWHdRY09IWndrUXdCeHg0MXAza3FE?=
 =?utf-8?B?Q1BUMnl2cklDekdOczBJOHduU1ZuNVdHSFI5ejIyeS94eHBVSWJqUzdYM2tR?=
 =?utf-8?B?ZEk5V21IVDhKTnY3K0hkN1hzcS9EOWN1S2hoSm84UlJXekVzb2wyNG8yV1lq?=
 =?utf-8?B?SEY0SHpHMHN0UVJUdmVPdHJoVWRzWnpwYlVab0JTT2VJb01yMENlRlJORllQ?=
 =?utf-8?B?a2hrN2x4OHhBQXdEdk81blNJOUJhUEgvUzhuSnNGSWFrRlhHTXBSOVNiV1lT?=
 =?utf-8?Q?X5zFls7dZ7tTlN79nTe6MvI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c71d2d6b-d64a-4cd0-bcae-08daf9612212
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 14:34:40.4831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rf0Or2qmbzZ9n4IpRpsI9WeSJl7s4snFwJht4nTABumNIkrLLAH3h3NLTKI8E5oAfKt3TAdhlxMJ5yhAaZkrRsNhWImbwJTLpwLQQlonkks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0123
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <F2337FA355F4424CBFF197BD6E5C5025@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTE4IGF0IDE1OjAxICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxOC8wMS8yMDIzIDA4OjI2LCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4g
RnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4g
DQo+ID4gQWRkIEFwYWxpcyBDQU4xLCBDQU4yIGFuZCBvcHRpb25hbCBDQU4zIGZ1bmN0aW9uYWxp
dHkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlz
d2lsZXJAdG9yYWRleC5jb20+DQo+ID4gLS0tDQo+ID4gDQo+ID4gQ2hhbmdlcyBpbiB2NDoNCj4g
PiAtIE5ldyBwYXRjaCBhZGRpbmcgZmxleGNhbiBmdW5jdGlvbmFsaXR5Lg0KPiA+IA0KPiA+IMKg
Li4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LWFwYWxpcy1ldmFsLmR0c2nCoMKgIHwgMTAgKysr
KysrKysrLQ0KPiA+IMKgLi4uL2R0cy9mcmVlc2NhbGUvaW14OC1hcGFsaXMtaXhvcmEtdjEuMS5k
dHNpwqAgfCAxMCArKysrKysrKystDQo+ID4gwqAuLi4vZHRzL2ZyZWVzY2FsZS9pbXg4LWFwYWxp
cy1peG9yYS12MS4yLmR0c2nCoCB8IDEyICsrKysrKysrKysrLQ0KPiA+IMKgLi4uL2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4LWFwYWxpcy12MS4xLmR0c2nCoMKgIHwgMTggKysrKysrKysrKysrKysr
LS0tDQo+ID4gwqA0IGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDgtYXBhbGlzLWV2YWwuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDgtDQo+ID4gYXBhbGlzLWV2YWwuZHRzaQ0KPiA+IGluZGV4IDAwM2JjNTM3N2NlNy4uMzIxMjg3
Nzc3M2UzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDgtYXBhbGlzLWV2YWwuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDgtYXBhbGlzLWV2YWwuZHRzaQ0KPiA+IEBAIC0zNSw3ICszNSwxNSBAQCAmZmVjMSB7
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0YXR1cyA9ICJva2F5IjsNCj4gPiDCoH07DQo+ID4gwqAN
Cj4gPiAtLyogVE9ETzogQ0FOICovDQo+ID4gKy8qIEFwYWxpcyBDQU4xICovDQo+IA0KPiBTcXVh
c2ggdGhlIHBhdGNoLg0KDQpEaXR0by4NCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

