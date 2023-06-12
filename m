Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7172B922
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjFLHuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjFLHtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:49:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCD2210E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:49:18 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-313-HZe_V5L0PEyyqlexZe_fvA-1; Mon, 12 Jun 2023 08:48:10 +0100
X-MC-Unique: HZe_V5L0PEyyqlexZe_fvA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 12 Jun
 2023 08:47:58 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 12 Jun 2023 08:47:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Chen-Yu Tsai' <wenst@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        "Matti Vaittinen" <mazziesaccount@gmail.com>,
        "linux-actions@lists.infradead.org" 
        <linux-actions@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] regulator: Use bitfield values for range selectors
Thread-Topic: [PATCH] regulator: Use bitfield values for range selectors
Thread-Index: AQHZmd7Pe+BdgVqXZ0e5XsPeombenK+ER+4AgAIyfwCAAFXbcA==
Date:   Mon, 12 Jun 2023 07:47:58 +0000
Message-ID: <0929093384864ff99c78800029ff5d76@AcuMS.aculab.com>
References: <20230608075651.3214540-1-wenst@chromium.org>
 <ce04685b7c4840b683add0bdd4404da6@AcuMS.aculab.com>
 <CAGXv+5EtdhkMq916LLOfpz8ok_xump5tv+oeNBvPq-_3-93oqQ@mail.gmail.com>
In-Reply-To: <CAGXv+5EtdhkMq916LLOfpz8ok_xump5tv+oeNBvPq-_3-93oqQ@mail.gmail.com>
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

RnJvbTogQ2hlbi1ZdSBUc2FpDQo+IFNlbnQ6IDEyIEp1bmUgMjAyMyAwNDozOQ0KPiANCj4gT24g
U3VuLCBKdW4gMTEsIDIwMjMgYXQgMToxMOKAr0FNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogQ2hlbi1ZdSBUc2FpDQo+ID4gPiBT
ZW50OiAwOCBKdW5lIDIwMjMgMDg6NTcNCj4gPiA+DQo+ID4gPiBSaWdodCBub3cgdGhlIHJlZ3Vs
YXRvciBoZWxwZXJzIGV4cGVjdCByYXcgcmVnaXN0ZXIgdmFsdWVzIGZvciB0aGUgcmFuZ2UNCj4g
PiA+IHNlbGVjdG9ycy4gVGhpcyBpcyBkaWZmZXJlbnQgZnJvbSB0aGUgdm9sdGFnZSBzZWxlY3Rv
cnMsIHdoaWNoIGFyZQ0KPiA+ID4gbm9ybWFsaXplZCBhcyBiaXRmaWVsZCB2YWx1ZXMuIFRoaXMg
bGVhZHMgdG8gYSBiaXQgb2YgY29uZnVzaW9uLiBBbHNvLA0KPiA+ID4gcmF3IHZhbHVlcyBhcmUg
aGFyZGVyIHRvIGNvcHkgZnJvbSBkYXRhc2hlZXRzIG9yIG1hdGNoIHVwIHdpdGggdGhlbSwNCj4g
PiA+IGFzIGRhdGFzaGVldHMgd2lsbCB0eXBpY2FsbHkgaGF2ZSBiaXRmaWVsZCB2YWx1ZXMuDQo+
ID4gPg0KPiA+ID4gTWFrZSB0aGUgaGVscGVycyBleHBlY3QgYml0ZmllbGQgdmFsdWVzLCBhbmQg
Y29udmVydCBleGlzdGluZyB1c2Vycy4NCj4gPiA+IEluY2x1ZGUgYml0b3BzLmggZXhwbGljaXRs
eSBmb3IgZmZzKCksIGFuZCByZW9yZGVyIHRoZSBoZWFkZXIgaW5jbHVkZQ0KPiA+ID4gc3RhdGVt
ZW50cy4gV2hpbGUgYXQgaXQsIGFsc28gcmVwbGFjZSBtb2R1bGUuaCB3aXRoIGV4cG9ydC5oLCBz
aW5jZSB0aGUNCj4gPiA+IG9ubHkgdXNlIGlzIEVYUE9SVF9TWU1CT0xfR1BMLg0KPiA+ID4NCj4g
PiAuLi4NCj4gPiA+ICBzdGF0aWMgY29uc3QgdW5zaWduZWQgaW50IGF0YzI2MHhfbGRvX3ZvbHRh
Z2VfcmFuZ2Vfc2VsW10gPSB7DQo+ID4gPiAtICAgICAweDAsIDB4MjAsDQo+ID4gPiArICAgICAw
eDAsIDB4MSwNCj4gPiA+ICB9Ow0KPiA+DQo+ID4gSXMgdGhlcmUgYW55IHdheSB0aGUgY2hhbmdl
IGNhbiBiZSBkb25lIHNvIHRoYXQgdW4tZWRpdGVkDQo+ID4gbW9kdWxlcyBmYWlsIHRvIGNvbXBp
bGU/DQo+ID4gT3RoZXJ3aXNlIHRoZSB3aG9sZSB0aGluZyBpcyBhbiBhY2NpZGVudCB3YWl0aW5n
IHRvIGhhcHBlbi4NCj4gDQo+IEkgdGhpbmsgd2UgY291bGQgY2hhbmdlIHRoZSBmaWVsZCBuYW1l
IGluIHRoZSByZWd1bGF0b3IgZGVzY3JpcHRpb24/DQo+IEJ1dCB1bnN1c3BlY3RpbmcgZW5kIHVz
ZXJzIC8gZGV2ZWxvcGVycyBtaWdodCBqdXN0IGVkaXQgdGhlIG5hbWUgYW5kIG5vdA0KPiBzZWUg
dGhhdCB0aGUgc2NoZW1lIGhhcyBjaGFuZ2VkLg0KPiANCj4gT3Igd2UgY291bGQgYWRkIGEgc2Fu
aXR5IGNoZWNrIGF0IHJ1bnRpbWUgdGhhdCBjaGVja3MgdGhlIHZhbHVlcyBkdXJpbmcNCj4gcmVn
dWxhdG9yIHJlZ2lzdHJhdGlvbi4gSG93IGRvZXMgdGhhdCBzb3VuZD8NCj4gDQo+IE1hcmssIGlz
IHRoaXMgc29tZXRoaW5nIHlvdSdkIGxpa2U/DQoNCkNhbiB5b3UgY2hhbmdlIHRoZSBuYW1lIG9m
IHRoZSBmdW5jdGlvbiB0aGUgdmFsdWVzIGFyZSBwYXNzZWQgdG8/DQpPciBtYXliZSBjaGFuZ2Ug
dGhlIHR5cGUgdG8gJ3Vuc2lnbmVkIGNoYXInIChhc3N1bWluZyBiaXQgbnVtYmVycw0KYXJlIHNt
YWxsKS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

