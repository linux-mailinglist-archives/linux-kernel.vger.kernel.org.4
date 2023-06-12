Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A2672BF48
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjFLKi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjFLKil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:38:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FC125A15
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:21:54 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-80-JBvm8a2QMzWcyDGfkZf9HA-1; Mon, 12 Jun 2023 11:13:52 +0100
X-MC-Unique: JBvm8a2QMzWcyDGfkZf9HA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 12 Jun
 2023 11:13:40 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 12 Jun 2023 11:13:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Chen-Yu Tsai' <wenst@chromium.org>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "linux-actions@lists.infradead.org" 
        <linux-actions@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] regulator: Use bitfield values for range selectors
Thread-Topic: [PATCH] regulator: Use bitfield values for range selectors
Thread-Index: AQHZmd7Pe+BdgVqXZ0e5XsPeombenK+ER+4AgAIyfwCAAFXbcIAAC1kAgAAcgoA=
Date:   Mon, 12 Jun 2023 10:13:40 +0000
Message-ID: <f5e6353f324343df8c289d8aed2a8930@AcuMS.aculab.com>
References: <20230608075651.3214540-1-wenst@chromium.org>
 <ce04685b7c4840b683add0bdd4404da6@AcuMS.aculab.com>
 <CAGXv+5EtdhkMq916LLOfpz8ok_xump5tv+oeNBvPq-_3-93oqQ@mail.gmail.com>
 <0929093384864ff99c78800029ff5d76@AcuMS.aculab.com>
 <CAGXv+5Hnrpv8kTU+0B9S4NyqALEz+DQOLfO3U7GwMZp9AoqLEw@mail.gmail.com>
In-Reply-To: <CAGXv+5Hnrpv8kTU+0B9S4NyqALEz+DQOLfO3U7GwMZp9AoqLEw@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hlbi1ZdSBUc2FpDQo+IFNlbnQ6IDEyIEp1bmUgMjAyMyAxMDoyNw0KPiBUbzogRGF2
aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAQUNVTEFCLkNPTT4NCj4gQ2M6IE1hcmsgQnJvd24gPGJy
b29uaWVAa2VybmVsLm9yZz47IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+OyBN
YW5pdmFubmFuIFNhZGhhc2l2YW0NCj4gPG1hbmlAa2VybmVsLm9yZz47IENyaXN0aWFuIENpb2Nh
bHRlYSA8Y3Jpc3RpYW4uY2lvY2FsdGVhQGdtYWlsLmNvbT47IE1hdHRpIFZhaXR0aW5lbg0KPiA8
bWF6emllc2FjY291bnRAZ21haWwuY29tPjsgbGludXgtYWN0aW9uc0BsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHJlZ3VsYXRvcjogVXNl
IGJpdGZpZWxkIHZhbHVlcyBmb3IgcmFuZ2Ugc2VsZWN0b3JzDQo+IA0KPiBPbiBNb24sIEp1biAx
MiwgMjAyMyBhdCAzOjQ44oCvUE0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBDaGVuLVl1IFRzYWkNCj4gPiA+IFNlbnQ6IDEyIEp1
bmUgMjAyMyAwNDozOQ0KPiA+ID4NCj4gPiA+IE9uIFN1biwgSnVuIDExLCAyMDIzIGF0IDE6MTDi
gK9BTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPiA+
ID4NCj4gPiA+ID4gRnJvbTogQ2hlbi1ZdSBUc2FpDQo+ID4gPiA+ID4gU2VudDogMDggSnVuZSAy
MDIzIDA4OjU3DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBSaWdodCBub3cgdGhlIHJlZ3VsYXRvciBo
ZWxwZXJzIGV4cGVjdCByYXcgcmVnaXN0ZXIgdmFsdWVzIGZvciB0aGUgcmFuZ2UNCj4gPiA+ID4g
PiBzZWxlY3RvcnMuIFRoaXMgaXMgZGlmZmVyZW50IGZyb20gdGhlIHZvbHRhZ2Ugc2VsZWN0b3Jz
LCB3aGljaCBhcmUNCj4gPiA+ID4gPiBub3JtYWxpemVkIGFzIGJpdGZpZWxkIHZhbHVlcy4gVGhp
cyBsZWFkcyB0byBhIGJpdCBvZiBjb25mdXNpb24uIEFsc28sDQo+ID4gPiA+ID4gcmF3IHZhbHVl
cyBhcmUgaGFyZGVyIHRvIGNvcHkgZnJvbSBkYXRhc2hlZXRzIG9yIG1hdGNoIHVwIHdpdGggdGhl
bSwNCj4gPiA+ID4gPiBhcyBkYXRhc2hlZXRzIHdpbGwgdHlwaWNhbGx5IGhhdmUgYml0ZmllbGQg
dmFsdWVzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gTWFrZSB0aGUgaGVscGVycyBleHBlY3QgYml0
ZmllbGQgdmFsdWVzLCBhbmQgY29udmVydCBleGlzdGluZyB1c2Vycy4NCj4gPiA+ID4gPiBJbmNs
dWRlIGJpdG9wcy5oIGV4cGxpY2l0bHkgZm9yIGZmcygpLCBhbmQgcmVvcmRlciB0aGUgaGVhZGVy
IGluY2x1ZGUNCj4gPiA+ID4gPiBzdGF0ZW1lbnRzLiBXaGlsZSBhdCBpdCwgYWxzbyByZXBsYWNl
IG1vZHVsZS5oIHdpdGggZXhwb3J0LmgsIHNpbmNlIHRoZQ0KPiA+ID4gPiA+IG9ubHkgdXNlIGlz
IEVYUE9SVF9TWU1CT0xfR1BMLg0KPiA+ID4gPiA+DQo+ID4gPiA+IC4uLg0KPiA+ID4gPiA+ICBz
dGF0aWMgY29uc3QgdW5zaWduZWQgaW50IGF0YzI2MHhfbGRvX3ZvbHRhZ2VfcmFuZ2Vfc2VsW10g
PSB7DQo+ID4gPiA+ID4gLSAgICAgMHgwLCAweDIwLA0KPiA+ID4gPiA+ICsgICAgIDB4MCwgMHgx
LA0KPiA+ID4gPiA+ICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiBJcyB0aGVyZSBhbnkgd2F5IHRoZSBj
aGFuZ2UgY2FuIGJlIGRvbmUgc28gdGhhdCB1bi1lZGl0ZWQNCj4gPiA+ID4gbW9kdWxlcyBmYWls
IHRvIGNvbXBpbGU/DQo+ID4gPiA+IE90aGVyd2lzZSB0aGUgd2hvbGUgdGhpbmcgaXMgYW4gYWNj
aWRlbnQgd2FpdGluZyB0byBoYXBwZW4uDQo+ID4gPg0KPiA+ID4gSSB0aGluayB3ZSBjb3VsZCBj
aGFuZ2UgdGhlIGZpZWxkIG5hbWUgaW4gdGhlIHJlZ3VsYXRvciBkZXNjcmlwdGlvbj8NCj4gPiA+
IEJ1dCB1bnN1c3BlY3RpbmcgZW5kIHVzZXJzIC8gZGV2ZWxvcGVycyBtaWdodCBqdXN0IGVkaXQg
dGhlIG5hbWUgYW5kIG5vdA0KPiA+ID4gc2VlIHRoYXQgdGhlIHNjaGVtZSBoYXMgY2hhbmdlZC4N
Cg0KTG9va2luZyBhdCBpdCwgdGhhdCB3b3VsZCBzZWVtIHRvIGJlIG5lZWRlZC4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

