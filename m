Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB31671FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjAROoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjAROno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:43:44 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3CB1A971
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:35:11 -0800 (PST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-49-3IQL0Qp-MJeW5K3F3ycQLw-1; Wed, 18 Jan 2023 15:35:09 +0100
X-MC-Unique: 3IQL0Qp-MJeW5K3F3ycQLw-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0003.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:27::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12; Wed, 18 Jan 2023 14:35:07 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa%2]) with mapi id 15.20.6002.012; Wed, 18 Jan 2023
 14:35:07 +0000
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
Subject: Re: [PATCH v4 15/17] arm64: dts: freescale: apalis-imx8: enable
 messaging units
Thread-Topic: [PATCH v4 15/17] arm64: dts: freescale: apalis-imx8: enable
 messaging units
Thread-Index: AQHZKw5wJTDEK2pAHkaL4f6nH1NRVa6kNJEAgAAJcIA=
Date:   Wed, 18 Jan 2023 14:35:07 +0000
Message-ID: <3aa914386a1102e65f7333d955f01b68abebc258.camel@toradex.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
         <20230118072656.18845-16-marcel@ziswiler.com>
         <ec696e66-531e-6abc-f880-ed1dedbcaa8c@linaro.org>
In-Reply-To: <ec696e66-531e-6abc-f880-ed1dedbcaa8c@linaro.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB0003:EE_
x-ms-office365-filtering-correlation-id: 7793cd1b-2d59-4cad-b5c5-08daf9613256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 1hG+sKvo0b/cHvigMpxd8Aou6Efor4kH7/epJm9Z9x2Zc7Q041mi1G5NZc358lFjuIm2BLo9q5NcGfOt6Sjw2j32OaJp2xSBFxwybRjrd0DecvqlWNBBUScDY+ycyUabv1KxApJRuhpcGDtNxtVOv3xtgurGVA4IJyHXezVDKbUumldLS5FaD4mHxPSgCRqUzBrJOiH287vX3WHAU5NUfTNfgHOmJqdDSNanffAL4pO+b2WG9m5de54l8ir/GYVNGKAIMFNJvV8wiJPlUmADFdcZLKqxPekgcO95kSB4ydJmH0ktKuAEG75lUl+DikV2zg9H/uQRobjk3ZohXa+7eo2f4HSBco10QBT3uIAAdL1yZm1tDNkhALenlmiinuttNRn7ZTIwRFtf8BFFfY4SHiePVwcJC3YO1EHPBkQnHoRGLjYVpJNUmAuWadwdPgHV/OlzswWhL9/JA51XUiX+Hp3+wZyhMzKxT6d3MJJ9kakwETuCkpQs2rS32g04OrdTkKu0mNcK8xk9i4/gq4Wmmd1CHdBicedvB7bi7Q0AG5O8OMY+0uaQsyStQMsbLqc0BKajX0G8R+GWzp8a/IeCyAQOmVDUPeLQS/iMabp/pA9pGp7ZdcnI4mUJUYEEpu7fFvFkjeUXl/PYuqRib1O7vPbec20VhQ9gQlnF1pJyd6Pg36y3LVhOM4kFRncZvn9tVcsaZWOaZJV5RYAIVqP3VA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(39850400004)(396003)(346002)(451199015)(26005)(6486002)(38100700002)(76116006)(478600001)(71200400001)(316002)(110136005)(6512007)(41300700001)(4326008)(8676002)(83380400001)(66476007)(66556008)(66946007)(66446008)(64756008)(6506007)(186003)(2906002)(44832011)(4744005)(54906003)(2616005)(5660300002)(8936002)(7416002)(53546011)(38070700005)(122000001)(36756003)(86362001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vit6QXU2K2RKaVVrL1ZvVGdpNjlXUE95aUxhcG11YkJZVVZ1L1EwVSsvdU1G?=
 =?utf-8?B?dWV6SDBEdFgvSjZEVDk0TWJ5ZUFXUmhYVnJRbWJKaTNBNmJBY1prLzc4T3lL?=
 =?utf-8?B?NzZyaGhKR1dxblppTkx1RFFtMWdNcWIvcGR5amJmblJlVlpwVVIrQVB1bmhS?=
 =?utf-8?B?MjVtRFFXWFpPM0hYN3hDNFBxUHBlWFRSU3I4MXBzdU1MbzNvdmpuZ1VGOXpW?=
 =?utf-8?B?ejRuYjVBVVZNZU93Vi8vVkQzQVh0VStzSmQvV0cyQmVrRmd0U0dYZnZMdXFX?=
 =?utf-8?B?VlpMWHRKZk1kYkE1RkFpWmxTNERnVENENDYrbVdzWFRtZk8vcGdmYUoyUldE?=
 =?utf-8?B?WG5IaW1nVGZwN2JnaTNSUmZidm9obTdBUVhuOFQvZk9UejBIQ0U3NUkxZm1m?=
 =?utf-8?B?Z2VLNERuUzFuZGl3ZndZVzRiOStxRWNITncvNzZsc0F3TXpWbDRLL0Y1Sm5l?=
 =?utf-8?B?YkRQSzlQaXR1SU9ncHp2NzlKREltcy92cFk0Z25aYysvWUIyQWRCei91Rmc5?=
 =?utf-8?B?L0RobCtEeFJaMWVON1BuS0NBVFduRlpHTHdZd0hGSTFIUkhGYlduSGpNblhQ?=
 =?utf-8?B?SVBBN05UOFQzZmtTQXBnUHY1S1ZMbjk1SFg4dFZNY0czZjFMaVd2d2pQUlM4?=
 =?utf-8?B?d0pqdisrcTVqVDEwaDdtdi9HN2Z6R0IyY0dMdVpVakNNWWJra3pJQ0pteS9T?=
 =?utf-8?B?UEVDOG44ajVhYkc4YTdobWVXclVBaWJ1bzU2Y21MaFJGN0hKZHpnQktwSGFw?=
 =?utf-8?B?T2F2cHVaYkRCbjdPRFV0ejRYWWd3cTNyTDZLODR2Q09KbHprQ0c4bGF0REdQ?=
 =?utf-8?B?VHFOM0VVVWFmN1NrMnhHejNTR3JPOHFXVU1UNHJzTXVycTVvQWFQNHJmaUd3?=
 =?utf-8?B?aElDTUVYWG5SSTYxYW05ZXd3LzZLdmxiNFNRZE45OHJEUVVLL0NEYkdnNDN0?=
 =?utf-8?B?cFVTbnJyeVliTXNwQUpGN0o0ZDk2dUI0ZHpmSmZ1Q3htWXZkWTdhSEpXWXdK?=
 =?utf-8?B?SG02cWdtNFpheHJqSlJmS3dzemUzQzd0UWMrb1UxL2ZBa1YyVnB0cXJoLzhn?=
 =?utf-8?B?NnVtbDB0aXoxQTVuL01BTGhZc29Hd21nYk45Smo2VE5IcWRGNHJZUmM5Z2I0?=
 =?utf-8?B?dXNQdkNpU2lpMC9YdXIxZ05yNHFrSm5mVEVXSEtBNWZkODJvdUR2c3RiL2pl?=
 =?utf-8?B?bURvVncyT0pHNU5DSld4c2FGMDFtMXNjNmN1QUhhOC85bEM5YmlMMXlFcjFD?=
 =?utf-8?B?RjcrMmlQNm5hdzhCbkpKdFlralQremRQN3Q2WWRLZzlsVmhscUZmVG03REZI?=
 =?utf-8?B?Z2dzYkcvNFJXUEN0WkpyRFVYMlNySzRjN1dnOHpVNnJQdUx1M25Fd1BPazZu?=
 =?utf-8?B?L2VGN3djVjVmc25EVXFxMW9MNGFiMkFtTVVYWklmNENSamZtVUR2OHhpSXI1?=
 =?utf-8?B?bkZheUcvbGlLMW43OXlkeWR6S2xhTktFL2ZUSU5TbkxRVWJ4UkNQWUhTQytF?=
 =?utf-8?B?T3NMNFBnVnFiWFpUOHhEQThKNHRQY3h4eHYrd2xKNUNsa25vOExaaVpUa0Yv?=
 =?utf-8?B?Q3gyaitSSFoxak9UeGpLVFVjUjlEMkR0WG5ycFVWRXJSSWdiZzI3RUZySWJl?=
 =?utf-8?B?RTVHQjYybjVKRExjNW1NOFJ1ajJjbldGVjJ0bVNEb2RIWFRNd0RiQzUrRWp5?=
 =?utf-8?B?cG1sdjYxOFR1R2ZUaFBIZkpXYkh6UXFUZ2JuR0lrMmNTSUtCczdzazBCbVJt?=
 =?utf-8?B?OGplbnJsVEdaaHFqc3VkbklpTDdpVjlKWTlXcStabGNOVzJYQWNWcHZ3M3A2?=
 =?utf-8?B?QURsZkl2SEUvY2JFZGpNVWlGampvcGllaG0yLzdibXVUa1pGWUpWaHc0azBp?=
 =?utf-8?B?dStreTZuamxmdnNZSHV2cUUrSkJQQzdreDhXemd1TWFIQ2EwWkRuNEs3dXFJ?=
 =?utf-8?B?L3RVdGw0bWFWcDR1S0d1RHNQSlpQb3l2dytQdW1GaDBsZm14bHV4MG1CWTBm?=
 =?utf-8?B?R3BPbllOaVV3Ui9QOWJLZTNPMkl4QVgxT1AyMTd1MVhERDRzeHBCOW83TU1J?=
 =?utf-8?B?L0t3aXNtOFZCUUZyaXhwTFNIL2hlLzhqN2RvREoxTk1MZEJpcktINlhkUjJQ?=
 =?utf-8?B?NllieFA1d3p4YzR2bmIvYU9RZTdycHVJc1NRYVQ2OW0ycHd6aE1IY3RRdmFk?=
 =?utf-8?Q?8OtHSD7yKihfc2jhPXzBYc8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7793cd1b-2d59-4cad-b5c5-08daf9613256
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 14:35:07.7408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1bgIU4iUwPdYPzFT/y+vzjb+t/BujlKM6Jo5rbBT6Mj1pYdsOBeytzVTjLmBL6e/wctvTaOmtwk6ZMr9WYcuW1lIL6VEESL+dHhrcjHOMiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0003
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <678B89D44CAE7A4ABDB3B670CEBDB20C@CHEP278.PROD.OUTLOOK.COM>
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
DQo+ID4gRW5hYmxlIG1lc3NhZ2luZyB1bml0cyBha2EgTVVzLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+
IA0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjQ6DQo+ID4gLSBOZXcgcGF0Y2ggZW5h
YmxpbmcgbWVzc2FnaW5nIHVuaXRzIGFrYSBNVXMuDQo+ID4gDQo+ID4gwqBhcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4LWFwYWxpcy12MS4xLmR0c2kgfCAxMyArKysrKysrKysrKyst
DQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
LWFwYWxpcy12MS4xLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LQ0K
PiA+IGFwYWxpcy12MS4xLmR0c2kNCj4gPiBpbmRleCA1NDU2MTg3OTk4NTIuLjcwYzAwYjkyY2Iw
NSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LWFw
YWxpcy12MS4xLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4LWFwYWxpcy12MS4xLmR0c2kNCj4gPiBAQCAtNjg0LDcgKzY4NCwxOCBAQCAmbHNpb19wd20z
IHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgI3B3bS1jZWxscyA9IDwzPjsNCj4gPiDCoH07DQo+ID4g
wqANCj4gPiAtLyogVE9ETzogTWVzc2FnaW5nIFVuaXRzICovDQo+ID4gKy8qIE1lc3NhZ2luZyBV
bml0cyAqLw0KPiANCj4gU3F1YXNoIHRoZSBwYXRjaC7CoCBJdCdzIG5vdCBUT0RPIGFueW1vcmUu
DQoNCkRpdHRvLg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

