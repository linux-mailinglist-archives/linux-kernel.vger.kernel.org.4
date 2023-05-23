Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C7970D957
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjEWJmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbjEWJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:42:44 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FAA130;
        Tue, 23 May 2023 02:42:40 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E4B2D5FD61;
        Tue, 23 May 2023 12:42:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684834958;
        bh=1FcUH+gy4sE3bLG9rlfUvTj4cejOMNUNBOL1S8qRl24=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=avoLwrryQ4PNjwF5CEDnT1JiMHDIsEQlZVpwuECSQQeZEGqJLHdIOTUdp6mDabphs
         dww4IAuB4OQdiU8A0dNjif2HdoBwS7oKqllPU6yclJ768z5ipoX8uaT6ww8rndFyHV
         kva6cMUQlPhb5R8ceaJ/I1H29pdIkomfTnyEmoNNRZakPZFwqaV58NXFei/s5aK946
         lWiiGGt0pCw88K2YvvePMr1FeKUpkP46ilecgfwSrlGVR3ouWv/58Pn4ICd4oHGPQd
         XgVEv5G//+8mRMS0871jAzBTryLTVt44VLMjEgBpEZKbTY5k9bYR78PTBwQyYGWULs
         OrTvpJVqDKniw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 23 May 2023 12:42:38 +0300 (MSK)
From:   =?utf-8?B?0KHRgtCw0YDQuiDQk9C10L7RgNCz0LjQuSDQndC40LrQvtC70LDQtdCy0Lg=?=
         =?utf-8?B?0Yc=?= <GNStark@sberdevices.ru>
To:     Heiner Kallweit <hkallweit1@gmail.com>
CC:     Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jian.hu@amlogic.com" <jian.hu@amlogic.com>,
        kernel <kernel@sberdevices.ru>,
        "rockosov@gmail.com" <rockosov@gmail.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v14 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
Thread-Topic: [PATCH v14 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
Thread-Index: AQHZeCWgh7Cra6robkiAd2dht8ZDaq9FnXUAgBD12wCABr+9gIAA4M8AgAIxhICAAVD/AIAEjhaAgABy/YCAANqgAA==
Date:   Tue, 23 May 2023 09:42:37 +0000
Message-ID: <88425ad1-8070-5952-a8c0-bfd10ba4868e@sberdevices.ru>
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru>
 <20230426095805.15338-7-ddrokosov@sberdevices.ru>
 <CAFBinCA2OhtVaCJDi8ZfAFLSE4oUgxYBDScaP_WW63curEK8Mg@mail.gmail.com>
 <20230512140630.qd33rwzaalmadpmk@CAB-WSD-L081021>
 <CAFBinCA8e9evk+9hTEgoNOD_+3DBst6vYDcradmr2c996jdUmw@mail.gmail.com>
 <20230517103456.p3sjxzbepvg7cr2r@CAB-WSD-L081021>
 <CAFBinCCPf+asVakAxeBqV-jhsZp=i2zbShByTCXfYYAQ6cCnHg@mail.gmail.com>
 <573d96df-7b08-4fa2-668b-58ff674a314e@gmail.com>
 <20230522134425.pc5fhojf53v6q2jz@CAB-WSD-L081021>
 <a121266a-110a-8c4e-cd71-4e35165fc789@gmail.com>
In-Reply-To: <a121266a-110a-8c4e-cd71-4e35165fc789@gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.13]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F32683ABBC69E4BB75B7E24D487CED2@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/23 05:11:00 #21371280
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMi8yMyAyMzozNiwgSGVpbmVyIEthbGx3ZWl0IHdyb3RlOg0KPiBPbiAyMi4wNS4yMDIz
IDE1OjQ0LCBEbWl0cnkgUm9rb3NvdiB3cm90ZToNCj4+IEhlaW5lciwNCj4+DQo+PiBPbiBGcmks
IE1heSAxOSwgMjAyMyBhdCAwNjoxMDo1MFBNICswMjAwLCBIZWluZXIgS2FsbHdlaXQgd3JvdGU6
DQo+Pj4gT24gMTguMDUuMjAyMyAyMjowNCwgTWFydGluIEJsdW1lbnN0aW5nbCB3cm90ZToNCj4+
Pj4gSGkgRG1pdHJ5LA0KPj4+Pg0KPj4+PiBPbiBXZWQsIE1heSAxNywgMjAyMyBhdCAxMjozNOKA
r1BNIERtaXRyeSBSb2tvc292DQo+Pj4+IDxkZHJva29zb3ZAc2JlcmRldmljZXMucnU+IHdyb3Rl
Og0KPj4+PiBbLi4uXQ0KPj4+Pj4+PiBBZGRpdGlvbmFsbHksIHRoZSBDQ0YgZGV0ZXJtaW5lcyB0
aGUgYmVzdCBhbmNlc3RvciBiYXNlZCBvbiBob3cgY2xvc2UNCj4+Pj4+Pj4gaXRzIHJhdGUgaXMg
dG8gdGhlIGdpdmVuIG9uZSwgYmFzZWQgb24gYXJpdGhtZXRpYyBjYWxjdWxhdGlvbnMuIEhvd2V2
ZXIsDQo+Pj4+Pj4+IHdlIGhhdmUgaW5kZXBlbmRlbnQga25vd2xlZGdlIHRoYXQgYSBjZXJ0YWlu
IGNsb2NrIHdvdWxkIGJlIGJldHRlciwgd2l0aA0KPj4+Pj4+PiBsZXNzIGppdHRlciBhbmQgZmV3
ZXIgaW50ZXJtZWRpYXJpZXMsIHdoaWNoIHdpbGwgbGlrZWx5IGltcHJvdmUgZW5lcmd5DQo+Pj4+
Pj4+IGVmZmljaWVuY3kuIFNhZGx5LCB0aGUgQ0NGIGNhbm5vdCB0YWtlIHRoaXMgaW50byBhY2Nv
dW50Lg0KPj4+Pj4+IEkgYWdyZWUgdGhhdCB0aGUgaW1wbGVtZW50YXRpb24gaW4gQ0NGIGlzIGZh
aXJseSBzaW1wbGUuIFRoZXJlJ3Mgd2F5cw0KPj4+Pj4+IHRvIHRyaWNrIGl0IHRob3VnaDogSUlS
QyBpZiB0aGVyZSBhcmUgbXVsdGlwbGUgZXF1YWxseSBzdWl0YWJsZSBjbG9ja3MNCj4+Pj4+PiBp
dCBwaWNrcyB0aGUgZmlyc3Qgb25lLiBGb3IgbWUgYWxsIG9mIHRoaXMgaGFzIHdvcmtlZCBzbyBm
YXIgd2hpY2ggaXMNCj4+Pj4+PiB3aGF0IG1ha2VzIG1lIGN1cmlvdXMgaW4gdGhpcyBjYXNlIChu
b3Qgc2F5aW5nIHRoYXQgYW55dGhpbmcgaXMgd3JvbmcNCj4+Pj4+PiB3aXRoIHlvdXIgYXBwcm9h
Y2gpLg0KPj4+Pj4+DQo+Pj4+Pj4gRG8geW91IGhhdmUgYSAocmVhbCB3b3JsZCkgZXhhbXBsZSB3
aGVyZSB0aGUgUlRDIGNsb2NrIHNob3VsZCBiZQ0KPj4+Pj4+IHByZWZlcnJlZCBvdmVyIGFub3Ro
ZXIgY2xvY2s/DQo+Pj4+Pj4NCj4+Pj4+IFllcywgYSByZWFsLWxpZmUgZXhhbXBsZSBpcyB0aGUg
bmVlZCBmb3IgYSAzMktoeiBjbG9jayBmb3IgYW4gZXh0ZXJuYWwNCj4+Pj4+IHdpZmkgY2hpcC4g
VGhlcmUgaXMgb25lIG9wdGlvbiB0byBwcm92aWRlIHRoaXMgY2xvY2sgd2l0aCBoaWdoDQo+Pj4+
PiBwcmVjaXNpb24sIHdoaWNoIGlzIFJUQyArIEdFTkNMSy4NCj4+Pj4+DQo+Pj4+Pj4gSSdtIHRo
aW5raW5nIGFib3V0IHRoZSBmb2xsb3dpbmcgc2NlbmFyaW8uDQo+Pj4+Pj4gUFdNIHBhcmVudHM6
DQo+Pj4+Pj4gLSBYVEFMOiAyNE1Ieg0KPj4+Pj4+IC0gc3lzOiBub3Qgc3VyZSAtIGxldCdzIHNh
eSAxNjYuNjdNSHoNCj4+Pj4+PiAtIFJUQzogMzJrSHoNCj4+Pj4+Pg0KPj4+Pj4+IFRoZW4gYWZ0
ZXIgdGhhdCB0aGVyZSdzIGEgZGl2aWRlciBhbmQgYSBnYXRlLg0KPj4+Pj4+DQo+Pj4+Pj4gTGV0
J3Mgc2F5IHRoZSBQV00gY29udHJvbGxlciBuZWVkcyBhIDFNSHogY2xvY2s6IGl0IGNhbiB0YWtl
IHRoYXQgZnJvbQ0KPj4+Pj4+IFhUQUwgb3Igc3lzLiBTaW5jZSBYVEFMIGlzIGV2ZW5seSBkaXZp
c2libGUgdG8gMU1IeiBDQ0Ygd2lsbCBwaWNrIHRoYXQNCj4+Pj4+PiBhbmQgdXNlIHRoZSBkaXZp
ZGVyLg0KPj4+Pj4+IEJ1dCBsZXQncyBzYXkgdGhlIFBXTSBjb250cm9sbGVyIG5lZWRzIGEgMzJr
SHogY2xvY2s6IENDRiB3b3VsZA0KPj4+Pj4+IGF1dG9tYXRpY2FsbHkgcGljayB0aGUgUlRDIGNs
b2NrLg0KPj4+Pj4+IFNvIGlzIHlvdXIgaW1wbGVtZW50YXRpb24gdGhlcmUgdG8gY292ZXIgbGV0
J3Mgc2F5IDFrSHogd2hlcmUNCj4+Pj4+PiBtYXRoZW1hdGljYWxseSAyNE1IeiBjYW4gYmUgZGl2
aWRlZCBldmVubHkgdG8gMWtIeiAoYW5kIHRodXMgc2hvdWxkDQo+Pj4+Pj4gbm90IHJlc3VsdCBp
biBhbnkgaml0dGVyKSBidXQgUlRDIGdpdmVzIGJldHRlciBwcmVjaXNpb24gaW4gdGhlIHJlYWwN
Cj4+Pj4+PiB3b3JsZCAoZXZlbiB0aG91Z2ggaXQncyBvZmYgYnkgMjRIeik/DQo+Pj4+Pj4NCj4+
Pj4+IEkgZG9uJ3QgdGhpbmsgc28uIFRoZSBoaWdoZXN0IHByZWNpc2lvbiB0aGF0IFJUQyBjYW4g
cHJvdmlkZSBpcyBmcm9tIGENCj4+Pj4+IDMyS0h6IHJhdGUgb25seS4gSG93ZXZlciwgSSBiZWxp
ZXZlIHRoYXQgYSAxa0h6IGZyZXF1ZW5jeSBjYW4gYWxzbyBiZQ0KPj4+Pj4gYWNoaWV2ZWQgYnkg
dXNpbmcgeHRhbCAyNE1IeiB3aXRoIGEgZGl2aWRlciwgd2hpY2ggY2FuIHByb3ZpZGUgaGlnaA0K
Pj4+Pj4gcHJlY2lzaW9uIGFzIHdlbGwuDQo+Pj4+IFRoYW5rIHlvdSBhZ2FpbiBmb3IgdGhlIGdy
ZWF0IGRpc2N1c3Npb24gb24gSVJDIHRvZGF5Lg0KPj4+PiBIZXJlJ3MgbXkgc2hvcnQgc3VtbWFy
eSBzbyBJIGRvbid0IGZvcmdldCBiZWZvcmUgeW91J2xsIGZvbGxvdyB1cCBvbiB0aGlzLg0KPj4+
Pg0KPj4+PiBJbiBnZW5lcmFsIHRoZXJlJ3MgdHdvIGtub3duIGNhc2VzIHdoZXJlIHRoZSBSVEMg
Y2xvY2sgbmVlZHMgdG8gYmUgdXNlZDoNCj4+Pj4gYSkgV2hlbiB1c2luZyB0aGUgR0VOQ0xLIG91
dHB1dCBvZiB0aGUgU29DIHRvIG91dHB1dCB0aGUgMzJrSHogUlRDDQo+Pj4+IGNsb2NrIGFuZCBj
b25uZWN0IHRoYXQgdG8gYW4gU0RJTyBXaUZpIGNoaXAgY2xvY2sgaW5wdXQgKHRoaXMgc2VlbXMN
Cj4+Pj4gdXNlZnVsIGluIG15IHVuZGVyc3RhbmRpbmcgYmVjYXVzZSB0aGUgUlRDIGNsb2NrIHBy
b3ZpZGVzIGhpZ2gNCj4+Pj4gcHJlY2lzaW9uKQ0KPj4+PiBiKSBXaGVuIHVzaW5nIHRoZSBQV00g
Y29udHJvbGxlciB0byBvdXRwdXQgYSAzMmtIeiBjbG9jayBzaWduYWwuIEluDQo+Pj4+IHRoaXMg
Y2FzZSBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdXNpbmcgdGhlIFJUQyBjbG9jayBhcyBpbnB1
dCB0byB0aGUNCj4+Pj4gUFdNIGNvbnRyb2xsZXIgcmVzdWx0cyBpbiB0aGUgYmVzdCBwb3NzaWJs
ZSBzaWduYWwNCj4+Pj4NCj4+Pj4gVGhlIHNlY29uZCBjYXNlIHdvbid0IGJlIHN1cHBvcnRlZCB3
aXRoIEhlaW5lcidzIHBhdGNoZXMgWzBdIHRoYXQgdXNlDQo+Pj4+IENDRiAoY29tbW9uIGNsb2Nr
IGZyYW1ld29yaykgaW4gdGhlIFBXTSBjb250cm9sbGVyIGRyaXZlci4NCj4+Pj4gSW4gdGhpcyBz
ZXJpZXMgdGhlIHBhcmVudCBjbG9jayBpcyBjYWxjdWxhdGVkIHVzaW5nOg0KPj4+PiAgICBmcmVx
ID0gZGl2NjRfdTY0KE5TRUNfUEVSX1NFQyAqICh1NjQpMHhmZmZmLCBwZXJpb2QpOw0KPj4+Pg0K
Pj4+PiBBIDMya0h6IGNsb2NrIG1lYW5zIGEgUFdNIHBlcmlvZCBvZiAzMDUxOG5zLiBTbyB3aXRo
IHRoZSBhYm92ZQ0KPj4+IFRvIGJlIHByZWNpc2U6IDMwNTE3LDU3ODEyNW5zDQo+Pj4gV2hhdCBt
ZWFucyB0aGF0IHRoZSBQV00gZnJhbWV3b3JrIGNhbid0IHNheSAiSSB3YW50IDMyNzY4SHoiLA0K
Pj4+IGJ1dCBqdXN0ICJJIHdhbnQgc29tZXRoaW5nIGJlaW5nIHZlcnkgY2xvc2UgdG8gMzI3NjhI
eiIuDQo+Pj4gU28gd2hhdCB5b3UgbmVlZCBpcyBzb21lIHNpbXBsZSBoZXVyaXN0aWMgdG8gaW50
ZXJwcmV0IHRoZQ0KPj4+IFBXTSByZXF1ZXN0IC0+ICJQV00gcmVxdWVzdHMgMzA1MThucywgYnV0
IHN1cHBvc2VkbHkgaXQgd2FudHMNCj4+PiAzMjc2OEh6Ig0KPj4+DQo+Pj4gTlNFQ19QRVJfU0VD
IC8gMzA1MTggPSAzMjc2NyAocm91bmRlZCBkb3duIGZyb20gMzI3NjcsNTQ3KQ0KPj4+IGNsa19y
b3VuZF9yYXRlKGNoYW5uZWwtPmNsaywgMzI3NjcpIHdvdWxkIHJldHVybiAwIChJICp0aGluayop
LA0KPj4+IGJlY2F1c2UgaXQgdHJpZXMgdG8gZmluZCB0aGUgbmV4dCBsb3dlciBjbG9jay4NCj4+
Pg0KPj4+IFRoZSBTb0MgZmFtaWxpZXMgSSdtIGZhbWlsaWFyIHdpdGggaGF2ZSBmY2xraW4yIGFz
IFBXTSBwYXJlbnQuDQo+Pj4gVGhhdCdzIDEgR0h6IGluIG15IGNhc2UsIHdoYXQgcmVzdWx0cyBp
biBhIGZyZXF1ZW5jeSBvZiAzMi43NjcsNTQ3SHoNCj4+PiBmb3IgcGVyaW9kID0gMzA1MThuLg0K
Pj4+IFdoYXQgeW91J3JlIHNheWluZyBpcyB0aGF0IG5ld2VyIGdlbmVyYXRpb25zIGRvbid0IGhh
dmUgUFdNIHBhcmVudHMNCj4+Pj4gMjRNSHogYW55IGxvbmdlcj8NCj4+IE5vLCBvZiBjb3Vyc2Ug
bm90LiBGb3IgZXhhbXBsZSwgYSBmaXhlZCBQTEwgKHdpdGggYWxsIGZjbGtfZGl2WA0KPj4gc2V0
dGluZ3MpIGhhcyByYXRlcyBoaWdoZXIgdGhhbiAyNE1Iei4gSG93ZXZlciwgd2UgbmVlZCB0byBj
b25zaWRlciB0aGUNCj4+ICdoZWF2eScgYmFja2dyb3VuZCBvZiBzdWNoIFBXTS4NCj4+DQo+PiBI
b3dldmVyLCB3ZSBoYXZlIGEgImxpZ2h0d2VpZ2h0IiBjbGtpbiAoc3BlY2lhbCBydGMzMmspIHdp
dGggYSByYXRlIG9mDQo+PiAzMmtIeiB0aGF0IHdlIGNvdWxkIHBvdGVudGlhbGx5IHVzZSBhcyBh
biBpbnB1dCB0byBwcm9kdWNlIGEgMzJrSHoNCj4+IG91dHB1dCBvbiB0aGUgUFdNIGxpbmVzLiBJ
IGRvbid0IHNlZSBhbnkgcmVhc29uIHdoeSB3ZSBzaG91bGQgbm90DQo+PiBzdXBwb3J0IHN1Y2gg
c3BlY2lhbCBjYXNlcy4NCj4+DQo+IFR3byBtb3JlIHRoaW5ncyB0byBjb25zaWRlcjoNCj4gMS4g
V2hlbiB3YW50aW5nIGEgMzJrSHogKHdlbGwsIDMyNzY4SHopIG91dHB1dCB3aXRoIGEgNTAlIGR1
dHkgY3ljbGUsDQo+ICAgICB0aGVuIHdlIG5lZWQgaGk9MCBhbmQgbG89MCB3aXRoIGEgNjRrSHog
aW5wdXQgY2xvY2suDQo+ICAgICBTZWUgcG9pbnQgMiBmb3IgYW4gZXhwbGFuYXRpb24gb2Ygd2h5
IDAgYW5kIG5vdCAxLg0KPiAgICAgTWVhbnMgd2UgY291bGRuJ3QgdXNlIHRoZSBSVEMgaW5wdXQg
Y2xvY2suIERpZCB5b3UgY29uc2lkZXIgdGhpcz8NCj4gICAgIE9yIGRvIEkgbWlzcyBzb21ldGhp
bmc/DQo+IDIuIFNlZW1zIHRoZSBQV00gYmxvY2sgaW50ZXJuYWxseSBpbmNyZW1lbnRzIGhpIGFu
ZCBsbywgZXhjZXB0IHRoZQ0KPiAgICAgY29uc3RhbnRfZW4gYml0IGlzIHNldCBvbiBuZXdlciBQ
V00gYmxvY2sgdmVyc2lvbnMuDQo+ICAgICBGb3IgYmlnZ2VyIGNudCB2YWx1ZXMgdGhlIGltcGFj
dCBpcyBuZWdsaWdpYmxlLCBidXQgZm9yIHZlcnkgc21hbGwNCj4gICAgIHZhbHVlcyBpdCdzIHNv
bWV0aGluZyB3ZSBoYXZlIHRvIGNvbnNpZGVyLg0KPiAgICAgVGhpcyB3YXMgb25lIGFkZGl0aW9u
YWwgbW90aXZhdGlvbiBmb3IgbWUgdG8gY2hvb3NlIGFuIGlucHV0DQo+ICAgICBmcmVxdWVuY3kg
dGhhdCBjcmVhdGVzIGJpZyBjbnQgdmFsdWVzLg0KDQpIZWxsbyBIZWluZXINCg0KMS4geWVzLCB5
b3UncmUgcmlnaHQuIFRvIGdldCBwd20gb3V0cHV0IDMyayBjbG9jayBwYXJlbnQgY2xvY2sgc2hv
dWxkIGJlIDY0ayBhdCBsZWFzdC4NCjIuIHllcywgeW91J3JlIHJpZ2h0LiBXZSBoYXZlIHRoZSBz
YW1lIHZpc2lvbiBvZiBwd20gSVAgd29ya2luZy4gU2VlbXMgbGlrZSBsbyBhbmQgaGkgcmVncyBh
cmUgdHJlYXRlZCBsaWtlIGRpdmlkZXIgcmVncyAoaW50ZXJuYWwgaW5jcmVtZW50KSBleGNlcHQg
c3BlY2lhbCBjYXNlIHdoZW4gY29uc3RhbnQgYml0IG9uLg0KDQpXZSBoYXZlIHBhdGNoZXMgc3Vw
cG9ydGluZyBjb25zdGFudCBiaXQgYW5kdGFraW5nIGludG8gYWNjb3VudCBoaVxsbyAic2hhZG93
IiBpbmNyZW1lbnRpbmcsIHdpbGwgcHVibGljIGl0IHNvb24NCkJlc3QgcmVnYXJkcw0KR2Vvcmdl
DQoNCj4+Pg0KPj4+PiBjYWxjdWxhdGlvbiB0aGUgUFdNIGRyaXZlciBpcyBhc2tpbmcgZm9yIGEg
Y2xvY2sgcmF0ZSBvZiA+PTJHSHouDQo+Pj4+IFdlIGNvbmNsdWRlZCB0aGF0IGxldHRpbmcgdGhl
IGNvbW1vbiBjbG9jayBmcmFtZXdvcmsgY2hvb3NlIHRoZSBiZXN0DQo+Pj4+IHBvc3NpYmxlIHBh
cmVudCAobWVhbmluZzogcmVtb3ZpbmcgQ0xLX1NFVF9SQVRFX05PX1JFUEFSRU5UIGhlcmUpIGNh
bg0KPj4+PiBiZSBhIHdheSBmb3J3YXJkLg0KPj4+PiBCdXQgdGhpcyBtZWFucyB0aGF0IHRoZSBQ
V00gY29udHJvbGxlciBkcml2ZXIgbXVzdCB0cnkgdG8gZmluZCB0aGUNCj4+Pj4gYmVzdCBwb3Nz
aWJsZSBwYXJlbnQgc29tZWhvdy4gVGhlIGVhc2llc3Qgd2F5IHdlIGNhbWUgdXAgd2l0aA0KPj4+
PiAocHNldWRvLWNvZGUpOg0KPj4+PiAgICBmcmVxID0gTlNFQ19QRVJfU0VDIC8gcGVyaW9kOw0K
Pj4+PiAgICBmaW5fZnJlcSA9IGNsa19yb3VuZF9yYXRlKGNoYW5uZWwtPmNsaywgZnJlcSk7DQo+
Pj4+ICAgIGlmIChmaW5fZnJlcSAhPSBmcmVxKSB7DQo+Pj4+ICAgICAgZnJlcSA9IGRpdjY0X3U2
NChOU0VDX1BFUl9TRUMgKiAodTY0KTB4ZmZmZiwgcGVyaW9kKTsNCj4+Pj4gICAgICBmaW5fZnJl
cSA9IGNsa19yb3VuZF9yYXRlKGNoYW5uZWwtPmNsaywgZnJlcSk7DQo+Pj4+ICAgIH0NCj4+Pj4N
Cj4+Pj4gVGhlIGlkZWEgaXM6IGZvciBhIHJlcXVlc3RlZCAzMmtIeiBzaWduYWwgdGhlIFBXTSBw
ZXJpb2QgaXMgMzA1MThucy4NCj4+Pj4gVGhlIHVwZGF0ZWQgbG9naWMgd291bGQgZmluZCB0aGF0
IHRoZXJlJ3MgYSBtYXRjaGluZyBjbG9jayBpbnB1dCBhbmQNCj4+Pj4gdXNlIHRoYXQgZGlyZWN0
bHkuIElmIG5vdDogdXNlIHRoZSBvcmlnaW5hbCBsb2dpYyBhcyBzdWdnZXN0ZWQgYnkNCj4+Pj4g
SGVpbmVyLg0KPj4+Pg0KPj4+Pg0KPj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4+IE1hcnRpbg0KPj4+
Pg0KPj4+Pg0KPj4+PiBbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYW1sb2dpYy85
ZmFjYTJlNi1iN2ExLTQ3NDgtN2ViMC00OGY4MDY0ZTMyM2VAZ21haWwuY29tLw0KPg0KDQo=
