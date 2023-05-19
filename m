Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E74709AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjESPIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjESPH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:07:58 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BCE121;
        Fri, 19 May 2023 08:07:54 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5CCB760AF3;
        Fri, 19 May 2023 18:07:48 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684508868;
        bh=uymjaxQi5VeZztsXUBTn6EcRZCUVcX2E5J/SCRmgpgo=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=j5n13jaJgq+L6TgXu+POcZhRg2GHXbNYotL5e2EFzibd+lgxwbbO1pmPTxZ5k0ZdB
         oXULVZ0Ua0CekGkSEKyyYdb/86YFlrhRw1RS+JDpqpW3Dyvhoi/y30VQXJDEkkQUZL
         UPHqgsIKmC6eSlDjzGJG/t/Pa5kIr9fQM2WXVQUbF4g9zLw4yB0kksFEROCP2t1jPt
         +NSQutq8I9geOOw3TrOysEQ6ml+2vtCa0iUwI8ePVrovqWIvqJRnAlbwprSkujsA2t
         5TIA6Ht5qkXZmRhmY3tQMO5/uQ36GASeGpEGDM6Tc5zk4HGPw6/f1yLgdGkYEXcS3T
         UIY/pdBXWPNBA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 19 May 2023 18:07:45 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
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
        <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v14 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
Thread-Topic: [PATCH v14 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
Thread-Index: AQHZeCWg/AAS9M+Srk+pE/iZ7FHnpq9FnXUAgBD12wCABr+9gIAA4M8AgAIxhICAAT9cgA==
Date:   Fri, 19 May 2023 15:07:44 +0000
Message-ID: <h4gjb3yr554cgpc7pye2z4pj3xhjtm3lwqlvdcad6ce2crb6dp@vwqnjezydodr>
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru>
 <20230426095805.15338-7-ddrokosov@sberdevices.ru>
 <CAFBinCA2OhtVaCJDi8ZfAFLSE4oUgxYBDScaP_WW63curEK8Mg@mail.gmail.com>
 <20230512140630.qd33rwzaalmadpmk@CAB-WSD-L081021>
 <CAFBinCA8e9evk+9hTEgoNOD_+3DBst6vYDcradmr2c996jdUmw@mail.gmail.com>
 <20230517103456.p3sjxzbepvg7cr2r@CAB-WSD-L081021>
 <CAFBinCCPf+asVakAxeBqV-jhsZp=i2zbShByTCXfYYAQ6cCnHg@mail.gmail.com>
In-Reply-To: <CAFBinCCPf+asVakAxeBqV-jhsZp=i2zbShByTCXfYYAQ6cCnHg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.25]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA792FC9E9DA8940A0034190D5E10BA5@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/19 11:16:00 #21342682
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

T24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgMTA6MDQ6NDFQTSArMDIwMCwgTWFydGluIEJsdW1lbnN0
aW5nbCB3cm90ZToNCj4gSGkgRG1pdHJ5LA0KPiANCj4gT24gV2VkLCBNYXkgMTcsIDIwMjMgYXQg
MTI6MzTigK9QTSBEbWl0cnkgUm9rb3Nvdg0KPiA8ZGRyb2tvc292QHNiZXJkZXZpY2VzLnJ1PiB3
cm90ZToNCj4gWy4uLl0NCj4gPiA+ID4gQWRkaXRpb25hbGx5LCB0aGUgQ0NGIGRldGVybWluZXMg
dGhlIGJlc3QgYW5jZXN0b3IgYmFzZWQgb24gaG93IGNsb3NlDQo+ID4gPiA+IGl0cyByYXRlIGlz
IHRvIHRoZSBnaXZlbiBvbmUsIGJhc2VkIG9uIGFyaXRobWV0aWMgY2FsY3VsYXRpb25zLiBIb3dl
dmVyLA0KPiA+ID4gPiB3ZSBoYXZlIGluZGVwZW5kZW50IGtub3dsZWRnZSB0aGF0IGEgY2VydGFp
biBjbG9jayB3b3VsZCBiZSBiZXR0ZXIsIHdpdGgNCj4gPiA+ID4gbGVzcyBqaXR0ZXIgYW5kIGZl
d2VyIGludGVybWVkaWFyaWVzLCB3aGljaCB3aWxsIGxpa2VseSBpbXByb3ZlIGVuZXJneQ0KPiA+
ID4gPiBlZmZpY2llbmN5LiBTYWRseSwgdGhlIENDRiBjYW5ub3QgdGFrZSB0aGlzIGludG8gYWNj
b3VudC4NCj4gPiA+IEkgYWdyZWUgdGhhdCB0aGUgaW1wbGVtZW50YXRpb24gaW4gQ0NGIGlzIGZh
aXJseSBzaW1wbGUuIFRoZXJlJ3Mgd2F5cw0KPiA+ID4gdG8gdHJpY2sgaXQgdGhvdWdoOiBJSVJD
IGlmIHRoZXJlIGFyZSBtdWx0aXBsZSBlcXVhbGx5IHN1aXRhYmxlIGNsb2Nrcw0KPiA+ID4gaXQg
cGlja3MgdGhlIGZpcnN0IG9uZS4gRm9yIG1lIGFsbCBvZiB0aGlzIGhhcyB3b3JrZWQgc28gZmFy
IHdoaWNoIGlzDQo+ID4gPiB3aGF0IG1ha2VzIG1lIGN1cmlvdXMgaW4gdGhpcyBjYXNlIChub3Qg
c2F5aW5nIHRoYXQgYW55dGhpbmcgaXMgd3JvbmcNCj4gPiA+IHdpdGggeW91ciBhcHByb2FjaCku
DQo+ID4gPg0KPiA+ID4gRG8geW91IGhhdmUgYSAocmVhbCB3b3JsZCkgZXhhbXBsZSB3aGVyZSB0
aGUgUlRDIGNsb2NrIHNob3VsZCBiZQ0KPiA+ID4gcHJlZmVycmVkIG92ZXIgYW5vdGhlciBjbG9j
az8NCj4gPiA+DQo+ID4NCj4gPiBZZXMsIGEgcmVhbC1saWZlIGV4YW1wbGUgaXMgdGhlIG5lZWQg
Zm9yIGEgMzJLaHogY2xvY2sgZm9yIGFuIGV4dGVybmFsDQo+ID4gd2lmaSBjaGlwLiBUaGVyZSBp
cyBvbmUgb3B0aW9uIHRvIHByb3ZpZGUgdGhpcyBjbG9jayB3aXRoIGhpZ2gNCj4gPiBwcmVjaXNp
b24sIHdoaWNoIGlzIFJUQyArIEdFTkNMSy4NCj4gPg0KPiA+ID4gSSdtIHRoaW5raW5nIGFib3V0
IHRoZSBmb2xsb3dpbmcgc2NlbmFyaW8uDQo+ID4gPiBQV00gcGFyZW50czoNCj4gPiA+IC0gWFRB
TDogMjRNSHoNCj4gPiA+IC0gc3lzOiBub3Qgc3VyZSAtIGxldCdzIHNheSAxNjYuNjdNSHoNCj4g
PiA+IC0gUlRDOiAzMmtIeg0KPiA+ID4NCj4gPiA+IFRoZW4gYWZ0ZXIgdGhhdCB0aGVyZSdzIGEg
ZGl2aWRlciBhbmQgYSBnYXRlLg0KPiA+ID4NCj4gPiA+IExldCdzIHNheSB0aGUgUFdNIGNvbnRy
b2xsZXIgbmVlZHMgYSAxTUh6IGNsb2NrOiBpdCBjYW4gdGFrZSB0aGF0IGZyb20NCj4gPiA+IFhU
QUwgb3Igc3lzLiBTaW5jZSBYVEFMIGlzIGV2ZW5seSBkaXZpc2libGUgdG8gMU1IeiBDQ0Ygd2ls
bCBwaWNrIHRoYXQNCj4gPiA+IGFuZCB1c2UgdGhlIGRpdmlkZXIuDQo+ID4gPiBCdXQgbGV0J3Mg
c2F5IHRoZSBQV00gY29udHJvbGxlciBuZWVkcyBhIDMya0h6IGNsb2NrOiBDQ0Ygd291bGQNCj4g
PiA+IGF1dG9tYXRpY2FsbHkgcGljayB0aGUgUlRDIGNsb2NrLg0KPiA+ID4gU28gaXMgeW91ciBp
bXBsZW1lbnRhdGlvbiB0aGVyZSB0byBjb3ZlciBsZXQncyBzYXkgMWtIeiB3aGVyZQ0KPiA+ID4g
bWF0aGVtYXRpY2FsbHkgMjRNSHogY2FuIGJlIGRpdmlkZWQgZXZlbmx5IHRvIDFrSHogKGFuZCB0
aHVzIHNob3VsZA0KPiA+ID4gbm90IHJlc3VsdCBpbiBhbnkgaml0dGVyKSBidXQgUlRDIGdpdmVz
IGJldHRlciBwcmVjaXNpb24gaW4gdGhlIHJlYWwNCj4gPiA+IHdvcmxkIChldmVuIHRob3VnaCBp
dCdzIG9mZiBieSAyNEh6KT8NCj4gPiA+DQo+ID4NCj4gPiBJIGRvbid0IHRoaW5rIHNvLiBUaGUg
aGlnaGVzdCBwcmVjaXNpb24gdGhhdCBSVEMgY2FuIHByb3ZpZGUgaXMgZnJvbSBhDQo+ID4gMzJL
SHogcmF0ZSBvbmx5LiBIb3dldmVyLCBJIGJlbGlldmUgdGhhdCBhIDFrSHogZnJlcXVlbmN5IGNh
biBhbHNvIGJlDQo+ID4gYWNoaWV2ZWQgYnkgdXNpbmcgeHRhbCAyNE1IeiB3aXRoIGEgZGl2aWRl
ciwgd2hpY2ggY2FuIHByb3ZpZGUgaGlnaA0KPiA+IHByZWNpc2lvbiBhcyB3ZWxsLg0KPiBUaGFu
ayB5b3UgYWdhaW4gZm9yIHRoZSBncmVhdCBkaXNjdXNzaW9uIG9uIElSQyB0b2RheS4NCj4gSGVy
ZSdzIG15IHNob3J0IHN1bW1hcnkgc28gSSBkb24ndCBmb3JnZXQgYmVmb3JlIHlvdSdsbCBmb2xs
b3cgdXAgb24gdGhpcy4NCj4gDQo+IEluIGdlbmVyYWwgdGhlcmUncyB0d28ga25vd24gY2FzZXMg
d2hlcmUgdGhlIFJUQyBjbG9jayBuZWVkcyB0byBiZSB1c2VkOg0KPiBhKSBXaGVuIHVzaW5nIHRo
ZSBHRU5DTEsgb3V0cHV0IG9mIHRoZSBTb0MgdG8gb3V0cHV0IHRoZSAzMmtIeiBSVEMNCj4gY2xv
Y2sgYW5kIGNvbm5lY3QgdGhhdCB0byBhbiBTRElPIFdpRmkgY2hpcCBjbG9jayBpbnB1dCAodGhp
cyBzZWVtcw0KPiB1c2VmdWwgaW4gbXkgdW5kZXJzdGFuZGluZyBiZWNhdXNlIHRoZSBSVEMgY2xv
Y2sgcHJvdmlkZXMgaGlnaA0KPiBwcmVjaXNpb24pDQo+IGIpIFdoZW4gdXNpbmcgdGhlIFBXTSBj
b250cm9sbGVyIHRvIG91dHB1dCBhIDMya0h6IGNsb2NrIHNpZ25hbC4gSW4NCj4gdGhpcyBjYXNl
IG15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB1c2luZyB0aGUgUlRDIGNsb2NrIGFzIGlucHV0IHRv
IHRoZQ0KPiBQV00gY29udHJvbGxlciByZXN1bHRzIGluIHRoZSBiZXN0IHBvc3NpYmxlIHNpZ25h
bA0KPiANCj4gVGhlIHNlY29uZCBjYXNlIHdvbid0IGJlIHN1cHBvcnRlZCB3aXRoIEhlaW5lcidz
IHBhdGNoZXMgWzBdIHRoYXQgdXNlDQo+IENDRiAoY29tbW9uIGNsb2NrIGZyYW1ld29yaykgaW4g
dGhlIFBXTSBjb250cm9sbGVyIGRyaXZlci4NCj4gSW4gdGhpcyBzZXJpZXMgdGhlIHBhcmVudCBj
bG9jayBpcyBjYWxjdWxhdGVkIHVzaW5nOg0KPiAgIGZyZXEgPSBkaXY2NF91NjQoTlNFQ19QRVJf
U0VDICogKHU2NCkweGZmZmYsIHBlcmlvZCk7DQo+IA0KPiBBIDMya0h6IGNsb2NrIG1lYW5zIGEg
UFdNIHBlcmlvZCBvZiAzMDUxOG5zLiBTbyB3aXRoIHRoZSBhYm92ZQ0KPiBjYWxjdWxhdGlvbiB0
aGUgUFdNIGRyaXZlciBpcyBhc2tpbmcgZm9yIGEgY2xvY2sgcmF0ZSBvZiA+PTJHSHouDQo+IFdl
IGNvbmNsdWRlZCB0aGF0IGxldHRpbmcgdGhlIGNvbW1vbiBjbG9jayBmcmFtZXdvcmsgY2hvb3Nl
IHRoZSBiZXN0DQo+IHBvc3NpYmxlIHBhcmVudCAobWVhbmluZzogcmVtb3ZpbmcgQ0xLX1NFVF9S
QVRFX05PX1JFUEFSRU5UIGhlcmUpIGNhbg0KPiBiZSBhIHdheSBmb3J3YXJkLg0KPiBCdXQgdGhp
cyBtZWFucyB0aGF0IHRoZSBQV00gY29udHJvbGxlciBkcml2ZXIgbXVzdCB0cnkgdG8gZmluZCB0
aGUNCj4gYmVzdCBwb3NzaWJsZSBwYXJlbnQgc29tZWhvdy4gVGhlIGVhc2llc3Qgd2F5IHdlIGNh
bWUgdXAgd2l0aA0KPiAocHNldWRvLWNvZGUpOg0KPiAgIGZyZXEgPSBOU0VDX1BFUl9TRUMgLyBw
ZXJpb2Q7DQo+ICAgZmluX2ZyZXEgPSBjbGtfcm91bmRfcmF0ZShjaGFubmVsLT5jbGssIGZyZXEp
Ow0KPiAgIGlmIChmaW5fZnJlcSAhPSBmcmVxKSB7DQo+ICAgICBmcmVxID0gZGl2NjRfdTY0KE5T
RUNfUEVSX1NFQyAqICh1NjQpMHhmZmZmLCBwZXJpb2QpOw0KPiAgICAgZmluX2ZyZXEgPSBjbGtf
cm91bmRfcmF0ZShjaGFubmVsLT5jbGssIGZyZXEpOw0KPiAgIH0NCj4gDQo+IFRoZSBpZGVhIGlz
OiBmb3IgYSByZXF1ZXN0ZWQgMzJrSHogc2lnbmFsIHRoZSBQV00gcGVyaW9kIGlzIDMwNTE4bnMu
DQo+IFRoZSB1cGRhdGVkIGxvZ2ljIHdvdWxkIGZpbmQgdGhhdCB0aGVyZSdzIGEgbWF0Y2hpbmcg
Y2xvY2sgaW5wdXQgYW5kDQo+IHVzZSB0aGF0IGRpcmVjdGx5LiBJZiBub3Q6IHVzZSB0aGUgb3Jp
Z2luYWwgbG9naWMgYXMgc3VnZ2VzdGVkIGJ5DQo+IEhlaW5lci4NCj4gDQo+IA0KPiBCZXN0IHJl
Z2FyZHMsDQo+IE1hcnRpbg0KPiANCj4gDQo+IFswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1hbWxvZ2ljLzlmYWNhMmU2LWI3YTEtNDc0OC03ZWIwLTQ4ZjgwNjRlMzIzZUBnbWFpbC5j
b20vDQoNClRoYW5rIHlvdSBmb3IgdGhlIGV4Y2VsbGVudCBmb2xsb3ctdXAhIEkgd2lsbCByZXBs
eSB0byBIZWluZXIncyB0aHJlYWQNCndpdGggdGhlc2UgY29tbWVudHMuIExldCdzIGNvbnRpbnVl
IHRoaXMgZGlzY3Vzc2lvbiBmdXJ0aGVyIGluIHRoZQ0KSGVpbmVyIHBhdGNoIHNlcmllcy4NCg0K
LS0gDQpUaGFuayB5b3UsDQpEbWl0cnk=
