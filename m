Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C7D671FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjAROnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjAROmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:42:45 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A957348A1D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:34:24 -0800 (PST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2046.outbound.protection.outlook.com [104.47.22.46]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-44-PkB7BOdhOZa7gsgOWBdJUg-1; Wed, 18 Jan 2023 15:34:22 +0100
X-MC-Unique: PkB7BOdhOZa7gsgOWBdJUg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0144.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:14::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Wed, 18 Jan 2023 14:34:20 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa%2]) with mapi id 15.20.6002.012; Wed, 18 Jan 2023
 14:34:20 +0000
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
Subject: Re: [PATCH v4 13/17] arm64: dts: freescale: apalis-imx8: add bkl1_pwm
 functionality
Thread-Topic: [PATCH v4 13/17] arm64: dts: freescale: apalis-imx8: add
 bkl1_pwm functionality
Thread-Index: AQHZKw5sD+NBB5IwuEKgQE2BFZjPX66kNHOAgAAJVgA=
Date:   Wed, 18 Jan 2023 14:34:20 +0000
Message-ID: <b6e246e3b1a862cec97d1402bac34af63bd155ae.camel@toradex.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
         <20230118072656.18845-14-marcel@ziswiler.com>
         <019df6fb-6d22-77e5-0a58-095b589dd339@linaro.org>
In-Reply-To: <019df6fb-6d22-77e5-0a58-095b589dd339@linaro.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZRAP278MB0144:EE_
x-ms-office365-filtering-correlation-id: 4c7f33c3-ce80-4f7c-1a98-08daf961165f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: tvxVOqkdZCMjYmOmZolx/clJza+QhB7h9iSpJE+Om5ppfbvuXc5rfjdCvf6pJd1l89gmWONSFxbGvtSHP17L2oNEvYgDpUECm/p6OaHj0acDmiMoJNJqz+lnnQRAKHyGDhHwFZsU+os+6gO08ISOQY0RBjEl2uCQjEQnL0qXCpaffMyczsGYZPyf8ub4zAuQRPGurJ7LU/9l1M4/4SS8RC/kOWUziZ7/11RkKm0+svIwJ+V8/emVQYbnSVuVwU98tzLl31LgVG76zhGNHNEkksNjtBwwUH/v4rLNvDJc+lMQT2/GAch4vy4hP0lhyeb68zE1CHZK6EAvSvH6I8LecbwXW0XsJVb5psUfVckaE51Z90/gEnhpaOyu0KyOWXAq67K2i/LQSn4HCi+/s9qTyblqQPp21fxZXY6oSOK2TrvbnZXINbjQhy3v4zNfcPmpD+fli+DtT2oRVFZzIaD3DTw39/aK13BXJZ1u0M3EIn6xmd5NKZ34NMB24ju6KvI3XEUIZP9vkqqBhC3rr7esq1mBV3ke4zoTYXTcMJ/HODEc6O61lkdhNOtla5eLmnWWKn4Cf2yJJZad76mqCOOOL1ZQhHFA9sIxhDG8Wip4HZXRlkgcFFpGMLXaNn/uCbSZsR5mPIlVwBSRMNFcvQfkeh5g9gWDj2IzSi0B7cjoUWtFbGATTGvmWovVszA3FK2dMJLaFpid+YDIh+Pfuq8Gbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(136003)(346002)(396003)(376002)(366004)(451199015)(83380400001)(38100700002)(122000001)(5660300002)(86362001)(38070700005)(7416002)(76116006)(4326008)(66446008)(8676002)(8936002)(64756008)(44832011)(66556008)(66476007)(66946007)(2616005)(478600001)(26005)(53546011)(186003)(6506007)(6512007)(2906002)(316002)(54906003)(6486002)(110136005)(71200400001)(41300700001)(36756003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjZ0N1hGSzZLa1Z1UVFldlBReTl6N20yTFpiOWgxN3poSEp3dTZ4V0M2d0h6?=
 =?utf-8?B?NXkya0J0eWJMbks5SXMrV1dlcXJ1KzExdWRLRlExdnJQUjFxZnF3SU95SlBJ?=
 =?utf-8?B?OFgzai9PUERSNm53VHZya21FOEJCNHloekdycHRXQzlwMTJFVWdwRzBnaEdI?=
 =?utf-8?B?YTd5SEtwdW1lMW9LL2FEeWFrVm9JdXlSYStDSkxPamJWb205RGxLYkVTbGxL?=
 =?utf-8?B?bVRYaVhDSmU3em14YzdCRDgzd2R5YjlOdElNUDk4Z0NOMC9ZTHhhK2ZpTjUv?=
 =?utf-8?B?c010TEhyZnd5TkdYa2xiVVFLRzRCQ093WS8wZHVndTE0b0JVWGNZcmt3UFla?=
 =?utf-8?B?ZUpCTE9vQVNNbnh5OGdPY2duakJsWStYWC9NVG5NT2pveWhJVndsSjdpSmln?=
 =?utf-8?B?ekcwa0I1YVdYWW5ya1lyVkdJU2FVWEluY3dYMTB4SnQ3aVA4UExldVRuakgv?=
 =?utf-8?B?Y0dOOEdSQTRzc0lSakhYWDd4ejhUVmZNYUErbFFoaEVPcDFFYkFIcS9mRk51?=
 =?utf-8?B?YVdIQTZHQUxKWlduZVhoc2N6NUdnUWdSejdibkNycGYxRGtKT0l5OWJvZHpE?=
 =?utf-8?B?SWZaeWRUSjNOSHR2RkxrWWJlLzl3NmVkUUdUbUtaQ0JMTWdvcVZzd2RoeTlS?=
 =?utf-8?B?SDExVHBWNzlYUGZITHNzbmhtSndqVGVQVlY1MXZ3Z2FiYzQ2cmc0WDJaaHk5?=
 =?utf-8?B?cUtBeFMya1RCYzg2cTJOQkkxeW9tUkttelNaQytSWkdLeUxoU3k4MC92Y21P?=
 =?utf-8?B?a2F5RFhuTkYrS2VuMVVRNnlGYmFZNjR5V3ZkTXA4TGEyMEpBdjlCUDdzSE1s?=
 =?utf-8?B?aDcyUDZiWm4wNHB2U0pUby85dW1tWEFzT0lKS3Z5dnRZOWQvc1FWWG5KRkky?=
 =?utf-8?B?cXVmNEdtU2pMMHlNUnRxNDNaTWVLdzdSMFZUbDQydS9CUHI4M202bWZoaDlG?=
 =?utf-8?B?ajdoU0MwVTV3Q1ZoT01ZTkhuVE9UNUR1am9XeUJuMHVJelB4cHNuWGtxeW5l?=
 =?utf-8?B?NzVENFF6L1N2Szl3bUU2SnBmdGpicjhrWHpoenFtTVJSa1VvVGNLSHY3NWQw?=
 =?utf-8?B?ZkZwbTQ2OHhnQU0weVdNbWIrYnFaeGhzbjVaM05kWTN2M3Z2b2N3Rk01Q1JF?=
 =?utf-8?B?YU9Scll0Z0ZMZDBiOTV3c3dBczBIMjAzaXorVlFQelowSXRBNk1vTHhuaGFR?=
 =?utf-8?B?OWdjS1J6enVMdDZDQTBodzhPTjBTZUNqRkhIcHEzYWFqM05RcUVPV0FKZTFL?=
 =?utf-8?B?UUxPMjVRU1JFUEhuR0xQUXZIZTIyVnFxVzNHNit2T3puUmc4NXpwamZGK1NQ?=
 =?utf-8?B?dG8xbzJ5UW0xOXNGY2t5cElhbTQwTmJUL3FjeE5NNk9iVzMwM2xMUkhZNkJ3?=
 =?utf-8?B?b0RlZEtJc1VoNlVFeDlTZlA1YzlhYnhXVnQ2Y3kzODk0TkJUMUpvQldGUTBa?=
 =?utf-8?B?T3h0VVhQTzlpYmVpMjMyV1BNd3Y5a1U3TWpObkVBK0tCM254dmg2RFBvN1hT?=
 =?utf-8?B?elRJVmF6dExLNi9ZeUVsdmQraTE1ZklDNkZkNFp0Y0UyUnkvcjl4NEt3OGd4?=
 =?utf-8?B?T3E4bjAwakc1QjRsZ0svQzJVUW1ucFhWWmZLaG81ZmN0bG5uNGNzRGxQcFdj?=
 =?utf-8?B?d2JqRmk5d0E0aVE3bnMwRWt0NGZrU2tvZ3YzNVVGM1pDSEdvdW8yM3IrdU9J?=
 =?utf-8?B?SHljSkpERU5kM080cHRic3dSVGhHOFN5S0h3MlhTNUl6ejFFNGxCcS9vRXdx?=
 =?utf-8?B?dzcwM21nRXlWb1pjc0tVNlE1Y2VUamJQbG1VRkRhcnpKeWhJNUVWNWppT0FR?=
 =?utf-8?B?ZFpGZklpOUxIZHcvcjQ3QW5KY29oZGVwYWJhQlRCOHprN1JIdU5KajdRL3Y2?=
 =?utf-8?B?NkUvZDRsbytmV1dYS1pyb0I0OTU1dVRVUmNYMUs0UEI2K3JYTHUzN1NkOGdt?=
 =?utf-8?B?YlRsdEpzQytXckpEdWVJL1VjTExPMlJNdER2UmtFWXNhNHlrUXg3bS9weXdG?=
 =?utf-8?B?YjZOelZFS1l3S0JUazl2NS9HM2VKbVdDQlNLZkI5bm1UbVRuOWF4WFFyWGQr?=
 =?utf-8?B?Zy9zVlJrTHI4bTJjVEZwKy8veUNseWhuSDZhMUFidnhnWGRRRTVTL1BzOEo4?=
 =?utf-8?B?cStSMGVIc0Z3dmc4ZG9LN1NnaG95N0R1YXhDeEdua09rTkdXcHl1K094UjdY?=
 =?utf-8?Q?ZFj2RUE7Mt8dr3aCsQ2cfDU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7f33c3-ce80-4f7c-1a98-08daf961165f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 14:34:20.8509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbMDYqGHHzckai+wRDrBx07IgEVNhwlFH33zStW6K8dSx0yA6ZnH1BuvakcTcrivyaVnIm+vA0Wk6SXthMyiaEpHKQhW5It0C52wL931fRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0144
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <44BC806E54B6AA4A96EC06B5A7F1BF32@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTE4IGF0IDE1OjAwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxOC8wMS8yMDIzIDA4OjI2LCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4g
RnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4g
DQo+ID4gQWRkIEFwYWxpcyBCS0wxX1BXTSBmdW5jdGlvbmFsaXR5Lg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0K
PiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjQ6DQo+ID4gLSBOZXcgcGF0Y2ggYWRkaW5n
IEFwYWxpcyBCS0wxX1BXTSBmdW5jdGlvbmFsaXR5Lg0KPiA+IA0KPiA+IMKgYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OC1hcGFsaXMtZXZhbC5kdHNpwqDCoMKgwqDCoCB8IDcgKysr
KysrLQ0KPiA+IMKgLi4uL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LWFwYWxpcy1peG9y
YS12MS4xLmR0c2kgfCA3ICsrKysrKy0NCj4gPiDCoC4uLi9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OC1hcGFsaXMtaXhvcmEtdjEuMi5kdHNpIHwgNyArKysrKystDQo+ID4gwqBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LWFwYWxpcy12MS4xLmR0c2nCoMKgwqDCoMKgIHwg
OSArKysrKysrLS0NCj4gPiDCoDQgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OC1hcGFsaXMtZXZhbC5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OC0NCj4gPiBhcGFsaXMtZXZhbC5kdHNpDQo+ID4gaW5kZXggMDYwNDU0ZjI1Yzk4
Li4wMDNiYzUzNzdjZTcgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OC1hcGFsaXMtZXZhbC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OC1hcGFsaXMtZXZhbC5kdHNpDQo+ID4gQEAgLTEwNiw3ICsxMDYsMTIg
QEAgJmxzaW9fcHdtMyB7DQo+ID4gwqANCj4gPiDCoC8qIFRPRE86IEFwYWxpcyBQQ0lFMSAqLw0K
PiA+IMKgDQo+ID4gLS8qIFRPRE86IEFwYWxpcyBCS0wxX1BXTSAqLw0KPiA+ICsvKiBBcGFsaXMg
QktMMV9QV00gKi8NCj4gPiArJnB3bV9sdmRzMSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgcGluY3Ry
bC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiArwqDCoMKgwqDCoMKgwqBwaW5jdHJsLTAgPSA8JnBp
bmN0cmxfcHdtX2JrbD47DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RhdHVzID0gIm9rYXkiOw0KPiAN
Cj4gWW91IGp1c3QgYWRkZWQgdGhpcyBmaWxlIHdpdGggdGhhdCBjb21tZW50LiBUaGlzIGRvZXMg
bm90IG1ha2Ugc2Vuc2UuDQo+IFRoZSBzYW1lIHBhdGNoc2V0IGFkZGluZyBhIGxpbmUgYW5kIHRo
ZW0gaW1tZWRpYXRlbHkgY2hhbmdpbmcgaXQuIEl0DQo+IG1lYW5zIHByZXZpb3VzIHBhdGNoIGlz
IGluY29tcGxldGUgb3IgYnVnZ3kuIFRoaXMgbXVzdCBiZSBzcXVhc2hlZC4NCg0KRGl0dG8uDQoN
Cg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

