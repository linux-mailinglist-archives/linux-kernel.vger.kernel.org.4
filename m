Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35407366CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjFTI74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjFTI7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:59:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09CC10DB;
        Tue, 20 Jun 2023 01:59:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35K8wLdvD030667, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35K8wLdvD030667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 20 Jun 2023 16:58:21 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 20 Jun 2023 16:58:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 20 Jun 2023 16:58:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 20 Jun 2023 16:58:41 +0800
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
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ray Chi <raychi@google.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v4 4/5] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 2.0 PHY
Thread-Topic: [PATCH v4 4/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0 PHY
Thread-Index: AQHZnqK1vMyD2bJSwUOEWYKbsH58Tq+OJm6AgAUT6pA=
Date:   Tue, 20 Jun 2023 08:58:41 +0000
Message-ID: <4b7a084f109a42fb8b0f0182b88c1054@realtek.com>
References: <20230614092850.21460-1-stanley_chang@realtek.com>
 <20230614092850.21460-4-stanley_chang@realtek.com>
 <63698c0e-1e30-cb88-d71d-6bdf7f5ad4d7@linaro.org>
In-Reply-To: <63698c0e-1e30-cb88-d71d-6bdf7f5ad4d7@linaro.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4g
PiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAtIHJlYWx0
ZWsscnRkMTI5NS11c2IycGh5DQo+ID4gKyAgICAgICAgICAtIHJlYWx0ZWsscnRkMTMxMmMtdXNi
MnBoeQ0KPiA+ICsgICAgICAgICAgLSByZWFsdGVrLHJ0ZDEzMTVlLXVzYjJwaHkNCj4gPiArICAg
ICAgICAgIC0gcmVhbHRlayxydGQxMzE5LXVzYjJwaHkNCj4gPiArICAgICAgICAgIC0gcmVhbHRl
ayxydGQxMzE5ZC11c2IycGh5DQo+ID4gKyAgICAgICAgICAtIHJlYWx0ZWsscnRkMTM5NS11c2Iy
cGh5DQo+ID4gKyAgICAgICAgICAtIHJlYWx0ZWsscnRkMTM5NS11c2IycGh5LTJwb3J0DQo+ID4g
KyAgICAgICAgICAtIHJlYWx0ZWsscnRkMTYxOS11c2IycGh5DQo+ID4gKyAgICAgICAgICAtIHJl
YWx0ZWsscnRkMTYxOWItdXNiMnBoeQ0KPiA+ICsgICAgICAtIGNvbnN0OiByZWFsdGVrLHVzYjJw
aHkNCj4gDQo+IFRoYXQncyBub3Qgd2hhdCB5b3VyIGRyaXZlciBpcyBzYXlpbmcuLi4gVGhpcyBw
YXRjaHNldCBoYXMgcmFuZG9tIHNldCBvZg0KPiBjaGFuZ2VzLg0KPiANCj4gSSBzdWdnZXN0IHRv
IGRyb3AgInJlYWx0ZWssdXNiMnBoeSIuDQoNCk9rYXksIEkgd2lsbCByZW1vdmUgaXQuDQoNCj4g
PiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRp
b246IFBIWSBkYXRhIHJlZ2lzdGVycw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBQSFkgY29u
dHJvbCByZWdpc3RlcnMNCj4gPiArDQo+ID4gKyAgIiNwaHktY2VsbHMiOg0KPiA+ICsgICAgY29u
c3Q6IDANCj4gPiArDQo+ID4gKyAgbnZtZW0tY2VsbHM6DQo+ID4gKyAgICBtYXhJdGVtczogMg0K
PiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFBoYW5kbGVzIHRvIG52bWVtIGNlbGwg
dGhhdCBjb250YWlucyB0aGUgdHJpbW1pbmcgZGF0YS4NCj4gPiArICAgICAgSWYgdW5zcGVjaWZp
ZWQsIGRlZmF1bHQgdmFsdWUgaXMgdXNlZC4NCj4gPiArDQo+ID4gKyAgbnZtZW0tY2VsbC1uYW1l
czoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiB1c2ItZGMtY2FsDQo+ID4g
KyAgICAgIC0gY29uc3Q6IHVzYi1kYy1kaXMNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsg
ICAgICBUaGUgZm9sbG93aW5nIG5hbWVzLCB3aGljaCBjb3JyZXNwb25kIHRvIGVhY2ggbnZtZW0t
Y2VsbHMuDQo+ID4gKyAgICAgIHVzYi1kYy1jYWwgaXMgdGhlIGRyaXZpbmcgbGV2ZWwgZm9yIGVh
Y2ggcGh5IHNwZWNpZmllZCB2aWEgZWZ1c2UuDQo+ID4gKyAgICAgIHVzYi1kYy1kaXMgaXMgdGhl
IGRpc2Nvbm5lY3Rpb24gbGV2ZWwgZm9yIGVhY2ggcGh5IHNwZWNpZmllZCB2aWEgZWZ1c2UuDQo+
ID4gKw0KPiA+ICsgIHJlYWx0ZWssaW52ZXJzZS1oc3R4LXN5bmMtY2xvY2s6DQo+ID4gKyAgICBk
ZXNjcmlwdGlvbjoNCj4gPiArICAgICAgRm9yIG9uZSBvZiB0aGUgcGh5cyBvZiBSVEQxNjE5YiBT
b0MsIHRoZSBzeW5jaHJvbm91cyBjbG9jayBvZiB0aGUNCj4gPiArICAgICAgaGlnaC1zcGVlZCB0
eCBtdXN0IGJlIGludmVydGVkLiBTbyB0aGlzIHByb3BlcnR5IGlzIHVzZWQgdG8gc2V0IHRoZQ0K
PiA+ICsgICAgICBpbnZlcnRlZCBjbG9jay4NCj4gDQo+IERyb3AgbGFzdCBzZW50ZW5jZSwgaXQg
aXMgcmVkdW5kYW50Lg0KDQpPa2F5DQoNCj4gPiArICAgIHR5cGU6IGJvb2xlYW4NCj4gPiArDQo+
ID4gKyAgcmVhbHRlayxkcml2aW5nLWxldmVsOg0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4g
KyAgICAgIEVhY2ggYm9hcmQgb3IgcG9ydCBtYXkgaGF2ZSBhIGRpZmZlcmVudCBkcml2aW5nIGNh
cGFiaWxpdHkuIFRoaXMNCj4gPiArICAgICAgd2lsbCBhZGp1c3QgdGhlIGRyaXZpbmcgbGV2ZWwg
dmFsdWUgaWYgdGhlIHZhbHVlIGlzIG5vdCB0aGUgZGVmYXVsdC4NCj4gDQo+IEkgZG9uJ3QgdW5k
ZXJzdGFuZCBpdC4gV2hhdCBpcyAiZHJpdmluZyBjYXBhYmlsaXR5IiBhbmQgaWYgZWFjaCBwb3J0
IGNhbiBoYXZlIGl0DQo+IGRpZmZlcmVudCwgd2h5IGRvIHlvdSBuZWVkIHByb3BlcnR5IGZvciB0
aGlzPw0KDQpTb3JyeS4gSSBkaWRuJ3QgZXhwcmVzcyBteXNlbGYgY2xlYXJseS4NCiJEcml2aW5n
IGNhcGFiaWxpdHkiIHJlZmVycyB0byB0aGUgbWFnbml0dWRlIG9mIHRoZSBEcC9EbSBvdXRwdXQg
c3dpbmcuDQpGb3IgYSBkaWZmZXJlbnQgYm9hcmQgb3IgcG9ydCwgdGhlIG9yaWdpbmFsIG1hZ25p
dHVkZSBtYXliZSBub3QgbWVldCB0aGUgc3BlY2lmaWNhdGlvbi4gDQpJbiB0aGlzIHNpdHVhdGlv
biB3ZSBjYW4gYWRqdXN0IHRoZSB2YWx1ZSB0byBtZWV0IHRoZSBzcGVjaWZpY2F0aW9uLg0KDQo+
IFlvdSBtZW50aW9uIHNvbWUgZGVmYXVsdCAtIHdoeSBpdCBpcyBub3QgZXhwcmVzc2VkIGFzICJk
ZWZhdWx0OiB4eCI/DQoNClRoZSBkZWZhdWx0IGlzIG1lYW4gaGFyZHdhcmUgZGVmYXVsdCB2YWx1
ZS4NCkkgY2FuIGFkZCB0aGUgZGVmYXVsdCB2YWx1ZS4NCg0KPiBXaGF0IGRvIHRoZSB2YWx1ZXMg
bWVhbj8NCg0KVGhlIGRlc2NyaXB0aW9uIGNhbiBiZSBtb2RpZmllZCB0bzoNCiAgICBkZXNjcmlw
dGlvbjoNCiAgICAgIENvbnRyb2wgdGhlIG1hZ25pdHVkZSBvZiBIaWdoIHNwZWVkIERwL0RtIG91
dHB1dCBzd2luZy4NCiAgICAgIEZvciBhIGRpZmZlcmVudCBib2FyZCBvciBwb3J0LCB0aGUgb3Jp
Z2luYWwgbWFnbml0dWRlIG1heWJlIG5vdCBtZWV0DQogICAgICB0aGUgc3BlY2lmaWNhdGlvbi4g
SW4gdGhpcyBzaXR1YXRpb24gd2UgY2FuIGFkanVzdCB0aGUgdmFsdWUgdG8gbWVldA0KICAgICAg
dGhlIHNwZWNpZmljYXRpb24uDQogICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5p
dGlvbnMvdWludDMyDQogICAgZGVmYXVsdDogOA0KICAgIG1pbmltdW06IDANCiAgICBtYXhpbXVt
OiAzMQ0KDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91
aW50MzINCj4gPiArICAgIG1pbmltdW06IDANCj4gPiArICAgIG1heGltdW06IDMxDQo+ID4gKw0K
PiA+ICsgIHJlYWx0ZWssZHJpdmluZy1jb21wZW5zYXRlOg0KPiA+ICsgICAgZGVzY3JpcHRpb246
DQo+ID4gKyAgICAgIEZvciBSVEQxMzE1ZSBTb0MsIHRoZSBkcml2aW5nIGxldmVsIGNhbiBiZSBh
ZGp1c3RlZCBieSByZWFkaW5nIHRoZQ0KPiA+ICsgICAgICBlZnVzZSB0YWJsZS4gVGhlcmVmb3Jl
LCB0aGlzIHByb3BlcnR5IHByb3ZpZGVzIGRyaXZlIGNvbXBlbnNhdGlvbg0KPiBmb3INCj4gPiAr
ICAgICAgZGlmZmVyZW50IGJvYXJkcyB3aXRoIGRpZmZlcmVudCBkcml2ZSBjYXBhYmlsaXRpZXMu
DQo+IA0KPiBpZiBkcml2aW5nIGxldmVsIGNhbiBiZSByZWFkIGZyb20gbnZtZW0sIHdoeSBkbyB5
b3UgaGF2ZSByZWFsdGVrLGRyaXZpbmctbGV2ZWwNCj4gaW4gdGhlIGZpcnN0IHBsYWNlPyBEb24n
dCB5b3UgbWlzcyBoZXJlIHNvbWUgYWxsT2YgbWFraW5nIHRoaXMgY29uc3RyYWluZWQgcGVyDQo+
IHZhcmlhbnQ/DQo+IA0KPiAiVGhlcmVmb3JlIiBtZWFucyAiZm9yIHRoYXQgcmVhc29uIiBvciAi
YXMgYSBjb25zZXF1ZW5jZSIuIEhvdyBpcyB0aGlzDQo+IHByb3BlcnR5IGEgY29uc2VxdWVuY2Ug
b2YgcmVhZGluZyBkcml2aW5nIGxldmVsIGZyb20gZWZ1c2U/IElzIGl0IHRoZW4gbXV0dWFsbHkN
Cj4gZXhjbHVzaXZlIHdpdGggInJlYWx0ZWssZHJpdmluZy1sZXZlbCI/IEJ1dCB5b3VyIHNjaGVt
YSBkb2VzIG5vdCBleHByZXNzIGl0Lg0KDQpObywgaXQncyBub3QgdGhhdCBjb21wbGljYXRlZC4N
CkluIG91ciBjYXNlLCBub3QgYWxsIElDcyBoYXZlIHByb2dyYW1taW5nIGVmdXNlLg0KVGhlIHZh
bHVlICJyZWFsdGVrLGRlaXZpbmctbGV2ZWwiIGlzIGZvciBub24tcHJvZ3JhbW1lZCBlZnVzZSBJ
Q3MuDQoNCkluIHRoZSBwcm9ncmFtbWVkIGVmdXNlIElDLCB3ZSB1c2UgdGhlIHZhbHVlIG9mIGVm
dXNlIHRvIGluc3RlYWQgb2YgInJlYWx0ZWssZHJpdmluZy1sZXZlbCIuIA0KSWYgdGhlIG1hZ25p
dHVkZSBvZiBIaWdoIHNwZWVkIERwL0RtIG91dHB1dCBzd2luZyBzdGlsbCBub3QgbWVldCB0aGUg
c3BlY2lmaWNhdGlvbiwNCnRoZW4gd2UgY2FuIHNldCB0aGUgdmFsdWUgImRyaXZpbmctY29tcGVu
c2F0ZSIgdG8gbWVldCB0aGUgc3BlY2lmaWNhdGlvbi4NCg0KVGhlIGRlc2NyaXB0aW9uIGNhbiBi
ZSBtb2RpZmllZCB0bzoNCiAgcmVhbHRlayxkcml2aW5nLWNvbXBlbnNhdGU6DQogICAgZGVzY3Jp
cHRpb246DQogICAgICBGb3IgUlREMTMxNWUgU29DLCB0aGUgZHJpdmluZyBsZXZlbCBjYW4gYmUg
YWRqdXN0ZWQgYnkgcmVhZGluZyB0aGUNCiAgICAgIGVmdXNlIHRhYmxlLiBUaGlzIHByb3BlcnR5
IHByb3ZpZGVzIGRyaXZlIGNvbXBlbnNhdGlvbi4NCiAgICAgIElmIHRoZSBtYWduaXR1ZGUgb2Yg
SGlnaCBzcGVlZCBEcC9EbSBvdXRwdXQgc3dpbmcgc3RpbGwgbm90IG1lZXQgdGhlDQogICAgICBz
cGVjaWZpY2F0aW9uLCB0aGVuIHdlIGNhbiBzZXQgdGhpcyB2YWx1ZSB0byBtZWV0IHRoZSBzcGVj
aWZpY2F0aW9uLg0KICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL2lu
dDMyDQogICAgbWluaW11bTogLTgNCiAgICBtYXhpbXVtOiA4DQoNCj4gPiArICAgICRyZWY6IC9z
Y2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL2ludDMyDQo+ID4gKyAgICBtaW5pbXVtOiAt
OA0KPiA+ICsgICAgbWF4aW11bTogOA0KPiA+ICsNCj4gPiArICByZWFsdGVrLGRpc2Nvbm5lY3Rp
b24tY29tcGVuc2F0ZToNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBUaGlzIGFk
anVzdHMgdGhlIGRpc2Nvbm5lY3Rpb24gbGV2ZWwgY29tcGVuc2F0aW9uIGZvciB0aGUgZGlmZmVy
ZW50DQo+ID4gKyAgICAgIGJvYXJkcyB3aXRoIGRpZmZlcmVudCBkaXNjb25uZWN0aW9uIGxldmVs
Lg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvaW50MzIN
Cj4gPiArICAgIG1pbmltdW06IC04DQo+ID4gKyAgICBtYXhpbXVtOiA4DQo+ID4gKw0KPiA+ICty
ZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gIiNw
aHktY2VsbHMiDQo+ID4gKw0KPiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiAr
DQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgdXNiX3BvcnQwX3VzYjJwaHk6
IHVzYi1waHlAMTMyMTQgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAicmVhbHRlayxydGQx
MzE5ZC11c2IycGh5IiwgInJlYWx0ZWssdXNiMnBoeSI7DQo+ID4gKyAgICAgICAgcmVnID0gPDB4
MTMyMTQgMHg0PiwgPDB4MjgyODAgMHg0PjsNCj4gPiArICAgICAgICAjcGh5LWNlbGxzID0gPDA+
Ow0KPiA+ICsNCj4gPiArICAgICAgICByZWFsdGVrLGRyaXZpbmctbGV2ZWwgPSA8MHhlPjsNCj4g
DQo+IFdoeSB0aGlzIGV4YW1wbGUgaXMgc28gZW1wdHk/IFlvdSBoYXZlIGF0IGxlYXN0IDYgbW9y
ZSBwcm9wZXJ0aWVzIHdoaWNoDQo+IHNob3VsZCBiZSBzaG93biBoZXJlLg0KDQpJIHdpbGwgYWRk
IG1vcmUgZXhhbXBsZXMgaW4gaGVyZS4NCmV4YW1wbGVzOg0KICAtIHwNCiAgICB1c2JfcG9ydDBf
dXNiMnBoeTogdXNiLXBoeUAxMzIxNCB7DQogICAgICAgIGNvbXBhdGlibGUgPSAicmVhbHRlayxy
dGQxMzE5ZC11c2IycGh5IjsNCiAgICAgICAgcmVnID0gPDB4MTMyMTQgMHg0PiwgPDB4MjgyODAg
MHg0PjsNCiAgICAgICAgI3BoeS1jZWxscyA9IDwwPjsNCiAgICAgICAgbnZtZW0tY2VsbHMgPSA8
Jm90cF91c2JfcG9ydDBfZGNfY2FsPiwgPCZvdHBfdXNiX3BvcnQwX2RjX2Rpcz47DQogICAgICAg
IG52bWVtLWNlbGwtbmFtZXMgPSAidXNiLWRjLWNhbCIsICJ1c2ItZGMtZGlzIjsNCg0KICAgICAg
ICByZWFsdGVrLGRyaXZpbmctbGV2ZWwgPSA8MHhlPjsNCiAgICB9Ow0KDQogIC0gfA0KICAgIHBv
cnQwX3VzYjJwaHk6IHVzYi1waHlAMTMyMTQgew0KICAgICAgICBjb21wYXRpYmxlID0gInJlYWx0
ZWsscnRkMTYxOWItdXNiMnBoeSI7DQogICAgICAgIHJlZyA9IDwweDEzMjE0IDB4ND4sIDwweDI4
MjgwIDB4ND47DQogICAgICAgICNwaHktY2VsbHMgPSA8MD47DQogICAgICAgIG52bWVtLWNlbGxz
ID0gPCZvdHBfdXNiX3BvcnQwX2RjX2NhbD4sIDwmb3RwX3VzYl9wb3J0MF9kY19kaXM+Ow0KICAg
ICAgICBudm1lbS1jZWxsLW5hbWVzID0gInVzYi1kYy1jYWwiLCAidXNiLWRjLWRpcyI7DQoNCiAg
ICAgICAgcmVhbHRlayxpbnZlcnNlLWhzdHgtc3luYy1jbG9jazsNCiAgICAgICAgcmVhbHRlayxk
cml2aW5nLWxldmVsID0gPDB4YT47DQogICAgICAgIHJlYWx0ZWssZHJpdmluZy1jb21wZW5zYXRl
ID0gPCgtMSk+Ow0KICAgICAgICByZWFsdGVrLGRpc2Nvbm5lY3Rpb24tY29tcGVuc2F0ZSA9IDwo
LTEpPjsNCiAgICB9Ow0KDQogICAgcG9ydDFfdXNiMnBoeTogdXNiLXBoeUAxM2MxNCB7DQogICAg
ICAgIGNvbXBhdGlibGUgPSAicmVhbHRlayxydGQxNjE5Yi11c2IycGh5IjsNCiAgICAgICAgcmVn
ID0gPDB4MTNjMTQgMHg0PiwgPDB4MzEyODAgMHg0PjsNCiAgICAgICAgI3BoeS1jZWxscyA9IDww
PjsNCiAgICAgICAgbnZtZW0tY2VsbHMgPSA8Jm90cF91c2JfcG9ydDFfZGNfY2FsPiwgPCZvdHBf
dXNiX3BvcnQxX2RjX2Rpcz47DQogICAgICAgIG52bWVtLWNlbGwtbmFtZXMgPSAidXNiLWRjLWNh
bCIsICJ1c2ItZGMtZGlzIjsNCg0KICAgICAgICByZWFsdGVrLGRyaXZpbmctbGV2ZWwgPSA8OD47
DQogICAgICAgIHJlYWx0ZWssZHJpdmluZy1jb21wZW5zYXRlID0gPDE+Ow0KICAgICAgICByZWFs
dGVrLGRpc2Nvbm5lY3Rpb24tY29tcGVuc2F0ZSA9IDwwPjsNCiAgICB9Ow0KDQpUaGFua3MsDQpT
dGFubGV5DQo=
