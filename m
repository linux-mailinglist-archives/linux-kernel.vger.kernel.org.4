Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DD6719A22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjFAKuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjFAKuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:50:16 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE6BD7;
        Thu,  1 Jun 2023 03:50:14 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 351Aml3M3003538, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 351Aml3M3003538
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 1 Jun 2023 18:48:47 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 1 Jun 2023 18:49:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 1 Jun 2023 18:49:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 1 Jun 2023 18:49:00 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 2.0/3.0 PHY
Thread-Topic: [PATCH v2 3/3] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0/3.0 PHY
Thread-Index: AQHZjrBYcJlLsVj/HkuHUZRifSysgq90OEaAgAGJYxA=
Date:   Thu, 1 Jun 2023 10:49:00 +0000
Message-ID: <ee65a9d6d40d4099987db5ff1ad1753f@realtek.com>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-3-stanley_chang@realtek.com>
 <0b2143ca-ead7-c8fa-2e80-a94222af51ca@linaro.org>
In-Reply-To: <0b2143ca-ead7-c8fa-2e80-a94222af51ca@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4gVGhlcmUgaXMgc29t
ZXRoaW5nIHRvIGRpc2N1c3MvaW1wcm92ZS4NCj4gDQo+IEFjdHVhbGx5IGEgbG90Li4uIFRoZSBi
aW5kaW5ncyBhcmUgbm90IHN1aXRhYmxlIGZvciByZXZpZXcuDQoNClRoYW5rcyBmb3IgeW91ciBw
YXRpZW5jZSBpbiByZXZpZXdpbmcgbXkgcGF0Y2hlcy4NCg0KTW9zdCBvZiB0aGUgcHJvcGVydGll
cyBhcmUgYWJvdXQgdGhlIHBoeSBwYXJhbWV0ZXJzLg0KSXMgdGhlIHBoeSBwYXJhbWV0ZXIgZGF0
YSBzdWl0YWJsZSB0byBiZSBwbGFjZWQgaW4gRFRTPw0KSSByZWZlcmVuY2VkIG90aGVyIHBoeSBk
cml2ZXJzLiANClRoZXNlIHBhcmFtZXRlcnMgc2hvdWxkIG5vdCBiZSBkZWZpbmVkIGluIGR0cy4N
Ckkgd291bGQgbW92ZSB0aGUgcGFyYW1ldGVycyB0byB0aGUgZHJpdmVyLg0KDQo+ID4gKyAgcmVh
bHRlayx1c2I6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGVyIG9mIHJlYWx0ZWsg
ZHdjMyBub2RlDQo+IA0KPiAicGhhbmRsZXIiPyBFeGNlcHQgb2J2aW91cyB0eXBvLCBkcm9wICJU
aGUgcGhhbmRsZXIgb2YiIGFuZCBkZXNjcmliZSB3aGF0IGlzDQo+IGl0IGZvci4NCg0KcmVhbHRl
ayx1c2IgaXMgYSBwaGFuZGxlIG9mIHN5c2NvbiB1c2VkIHRvIGNvbnRyb2wgcmVhbHRlayBkd2Mz
IHJlZ2lzdGVyLg0KDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy9waGFuZGxlDQo+IA0KPiBBbnl3YXksIGl0IHNob3VsZG4ndCBiZSBoZXJlLiBObywgbm8u
DQoNCkNhbiBJIHVzZSBpdCBmb3IgcGhhbmRsZSBvZiBzeXNjb24/DQoNCj4gPiArICByZWFsdGVr
LHBvcnQtaW5kZXg6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogVGhlIGluZGV4IG9mIFVTQiAyLjAg
UEhZDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50
MzINCj4gDQo+IE5vLiBObyByZWFzb24gZm9yIHRoaXMuIFlvdSBoYXZlIHJlZy4NCg0KVGhpcyBp
bmRleCBpcyB1c2VkIGZvciBwaHkgcGFyYW1ldGVycy4gSSB3aWxsIG1vdmUgaXQgdG8gcGh5IGRy
aXZlci4NCg0KPiA+ICsNCj4gPiArICByZWFsdGVrLHBoeU46DQo+ID4gKyAgICBkZXNjcmlwdGlv
bjogVGhlIHRvdGFsIGFtb3VudCBvZiBVU0IgMi4wIFBIWQ0KPiA+ICsgICAgJHJlZjogL3NjaGVt
YXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+IA0KPiBOby4gQ29tcGF0aWJsZSBk
ZWZpbmVzIGl0Lg0KDQpUaGlzIGFtb3VudCBpcyB1c2VkIGZvciBwaHkgcGFyYW1ldGVycy4gSSB3
aWxsIG1vdmUgaXQgdG8gcGh5IGRyaXZlci4NCg0KDQo+ID4gKw0KPiA+ICsgIHBoeTA6DQo+ID4g
KyAgICBkZXNjcmlwdGlvbjogVGhlIGNoaWxkIG5vZGUgb2YgUEhZIGZvciB0aGUgcGFyYW1ldGVy
IHYxLg0KPiANCj4gPz8/IE9wZW4gb3RoZXIgcGh5IGJpbmRpbmdzIGFuZCB1c2UgdGhlbSBhcyBl
eGFtcGxlLg0KDQpwaHkwIENoaWxkIG5vZGUgaXMgZGVmaW5lZCB0byBhc3NpZ24gdGhlIHBoeSBw
YXJhbWV0ZXIuDQpJIHdpbGwgcmVtb3ZlIGl0Lg0KDQo+ID4gKyAgICB0eXBlOiBvYmplY3QNCj4g
PiArICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgIHJlYWx0ZWsscGh5LWRhdGEtcGFnZTAtc2l6
ZToNCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjogUEhZIGRhdGEgcGFnZSAwIHNpemUNCj4gPiAr
ICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4g
PiArDQo+ID4gKyAgICAgIHJlYWx0ZWsscGh5LWRhdGEtcGFnZTAtYWRkcjoNCj4gPiArICAgICAg
ICBkZXNjcmlwdGlvbjogUEhZIGRhdGEgcGFnZSAwIGFkZHJlc3MNCj4gPiArICAgICAgICAkcmVm
OiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50OC1hcnJheQ0KPiA+ICsNCj4g
PiArICAgICAgcmVhbHRlayxwaHktZGF0YS1wYWdlMC1BMDA6DQo+ID4gKyAgICAgICAgZGVzY3Jp
cHRpb246IFBIWSBkYXRhIHBhZ2UgMCB2YWx1ZQ0KPiA+ICsgICAgICAgICRyZWY6IC9zY2hlbWFz
L3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQ4LWFycmF5DQo+ID4gKw0KPiA+ICsgICAgICBy
ZWFsdGVrLHBoeS1kYXRhLXBhZ2UxLXNpemU6DQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IFBI
WSBkYXRhIHBhZ2UgMSBzaXplDQo+ID4gKyAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFt
bCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKw0KPiA+ICsgICAgICByZWFsdGVrLHBoeS1kYXRh
LXBhZ2UxLWFkZHI6DQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IFBIWSBkYXRhIHBhZ2UgMSBh
ZGRyZXNzDQo+ID4gKyAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlv
bnMvdWludDgtYXJyYXkNCj4gPiArDQo+ID4gKyAgICAgIHJlYWx0ZWsscGh5LWRhdGEtcGFnZTEt
QTAwOg0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBQSFkgZGF0YSBwYWdlIDEgdmFsdWUNCj4g
PiArICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50OC1h
cnJheQ0KPiA+ICsNCj4gPiArICAgICAgcmVhbHRlayxwaHktZGF0YS1wYWdlMi1zaXplOg0KPiA+
ICsgICAgICAgIGRlc2NyaXB0aW9uOiBQSFkgZGF0YSBwYWdlIDIgc2l6ZQ0KPiA+ICsgICAgICAg
ICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsNCj4g
PiArICAgICAgcmVhbHRlayxwaHktZGF0YS1wYWdlMi1hZGRyOg0KPiA+ICsgICAgICAgIGRlc2Ny
aXB0aW9uOiBQSFkgZGF0YSBwYWdlIDIgYWRkcmVzcw0KPiA+ICsgICAgICAgICRyZWY6IC9zY2hl
bWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQ4LWFycmF5DQo+ID4gKw0KPiA+ICsgICAg
ICByZWFsdGVrLHBoeS1kYXRhLXBhZ2UyLUEwMDoNCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjog
UEhZIGRhdGEgcGFnZSAyIHZhbHVlDQo+ID4gKyAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMu
eWFtbCMvZGVmaW5pdGlvbnMvdWludDgtYXJyYXkNCj4gPiArDQo+ID4gKyAgICAgIHJlYWx0ZWss
ZG8tdG9nZ2xlOg0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBEbyBQSFkgcGFyYW1ldGVyIHRv
Z2dsZSB3aGVuIHBvcnQgc3RhdHVzIGNoYW5nZQ0KPiA+ICsgICAgICAgIHR5cGU6IGJvb2xlYW4N
Cj4gPiArDQo+ID4gKyAgICAgIHJlYWx0ZWssY2hlY2stZWZ1c2U6DQo+ID4gKyAgICAgICAgZGVz
Y3JpcHRpb246IEVuYWJsZSB0byBmaXggUEhZIHBhcmFtZXRlciBmcm9tIHJlYWRpbmcgb3RwIHRh
YmxlDQo+ID4gKyAgICAgICAgdHlwZTogYm9vbGVhbg0KPiA+ICsNCj4gPiArICAgICAgcmVhbHRl
ayx1c2UtZGVmYXVsdC1wYXJhbWV0ZXI6DQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IERvbid0
IHNldCBwYXJhbWV0ZXIgYW5kIHVzZSBkZWZhdWx0IHZhbHVlDQo+ID4gKyAgICAgICAgdHlwZTog
Ym9vbGVhbg0KPiA+ICsNCj4gPiArICAgICAgcmVhbHRlayxpcy1kb3VibGUtc2Vuc2l0aXZpdHkt
bW9kZToNCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjogRW5hYmxlIGRvdWJsZSBzZW5zaXRpdml0
eSBtb2RlDQo+ID4gKyAgICAgICAgdHlwZTogYm9vbGVhbg0KPiA+ICsNCj4gPiArICAgICAgcmVh
bHRlayxsZG8tcGFnZTAtZTQtY29tcGVuc2F0ZToNCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjog
QWRqdXN0IHRoZSBQSFkgcGFyYW1ldGVyIGZvciBwYWdlIDAgMHhFNCBmb3IgbGRvDQo+IG1vZGUN
Cj4gPiArICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50
MzINCj4gPiArDQo+ID4gKyAgICAgIHJlYWx0ZWsscGFnZTAtZTQtY29tcGVuc2F0ZToNCj4gPiAr
ICAgICAgICBkZXNjcmlwdGlvbjogQWRqdXN0IHRoZSBQSFkgcGFyYW1ldGVyIGZvciBwYWdlIDAg
MHhFNA0KPiA+ICsgICAgICAgICAgZm9yIGVmdXNlIHRhYmxlIHYyDQo+ID4gKyAgICAgICAgJHJl
ZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+IA0KPiBJIGRvbid0
IHVuZGVyc3RhbmQgd2hhdCdzIGFsbCB0aGlzIGZvci4gTW9zdCBvZiB0aGVzZSBkZXNjcmlwdGlv
bnMgZG8gbm90IGV4cGxhaW4NCj4gYW55dGhpbmcgZXhjZXB0IGR1cGxpY2F0aW5nIG5hbWUgb2Yg
cHJvcGVydHkuDQoNCkknbGwgc2ltcGxpZnkgdGhlc2UgcHJvcGVydGllcyBhbmQgcmVtb3ZlIHRo
ZSBvbmUgYWJvdXQgdGhlIHBoeSBwYXJhbWV0ZXIuDQoNCj4gT25lIGh1Z2UgTkFLIGZvciB0aGVz
ZSBiaW5kaW5ncy4gSXQgbG9va3MgbGlrZSBjb3B5LXBhc3RlIGZyb20gZG93bnN0cmVhbQ0KPiBz
dHVmZiB3aGljaCBzaG91bGQgbmV2ZXIgYmUgc2VudCBhcyBpcyB0byB1cHN0cmVhbS4gSSBhbSBz
b3JyeSBmb3IgYmVpbmcgaGFyc2gsDQo+IGJ1dCBhbW91bnQgb2YgcXVlc3Rpb25zLCBjb2Rpbmcg
YW5kIG5hbWluZyBzdHlsZXMsIGluY29ycmVjdCBjaG9pY2VzIGlzIGp1c3QgdG9vDQo+IGJpZyB0
byBoYW5kbGUgaW4gb25lIHJldmlldy4NCj4gDQoNCkkgd2lsbCByZWZhY3RvciB0aGlzIGR0cyBi
YXNlZCBvbiB5b3VyIGNvbW1lbnRzLg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
