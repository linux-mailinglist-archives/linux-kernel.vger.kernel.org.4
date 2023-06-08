Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3B77278DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbjFHHcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjFHHcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:32:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86209E;
        Thu,  8 Jun 2023 00:32:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3587VjrS6005923, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3587VjrS6005923
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 8 Jun 2023 15:31:45 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 8 Jun 2023 15:32:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Jun 2023 15:32:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 8 Jun 2023 15:32:01 +0800
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
        Ray Chi <raychi@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Flavio Suligoi" <f.suligoi@asem.it>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v3 5/5] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 3.0 PHY
Thread-Topic: [PATCH v3 5/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 3.0 PHY
Thread-Index: AQHZmQjklnRAOra5tUWspHWKA9A7xK9+uVYAgAG7/iA=
Date:   Thu, 8 Jun 2023 07:32:01 +0000
Message-ID: <1f13680401e449a3b9384710206cc2b0@realtek.com>
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-5-stanley_chang@realtek.com>
 <58aea31d-8f47-a558-6e17-17b55059bb23@linaro.org>
In-Reply-To: <58aea31d-8f47-a558-6e17-17b55059bb23@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

SGkgS3J6eXN6dG9mLA0KDQo+IA0KPiAxIHBoeSBvciA0PyBEZWNpZGUuDQoNCkluIGFjdHVhbGx5
LCB3ZSBoYXZlIG9uZSBwaHkgZm9yIG9uZSBjb250cm9sbGVyLg0KSSBtZWFuIHRoZSBkcml2ZXIg
Y2FuIHN1cHBvcnQgdXAgdG8gNCBwaHlzLg0KSSBjYW4gcmV2aXNlZCBhcw0KIl5waHlAWzBdKyQi
DQpPciBvbmx5ICJwaHkiDQoNCj4gPiArDQo+ID4gK3BhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICsg
ICJecGh5QFswLTNdKyQiOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IEVhY2ggc3ViLW5vZGUgaXMg
YSBQSFkgZGV2aWNlIGZvciBvbmUgWEhDSSBjb250cm9sbGVyLg0KPiA+ICsgICAgdHlwZTogb2Jq
ZWN0DQo+ID4gKyAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICByZWFsdGVrLHBhcmFtOg0KPiA+
ICsgICAgICAgIGRlc2NyaXB0aW9uOiBUaGUgZGF0YSBvZiBQSFkgcGFyYW1ldGVyIGFyZSB0aGUg
cGFpciBvZiB0aGUNCj4gPiArICAgICAgICAgIG9mZnNldCBhbmQgdmFsdWUuDQo+ID4gKyAgICAg
ICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDgtYXJyYXkNCj4g
DQo+IFlvdXIgY2hvaWNlIG9mIHR5cGVzIGlzIHN1cnByaXNpbmcuIElmIHRoaXMgaXMgYXJyYXks
IHRoYW4gbWF4SXRlbXMgKGFuZCBwbGVhc2UNCj4gZG9uJ3QgdGVsbCBtZSBpdCBpcyBtYXhJdGVt
czogMSkuIEFueXdheSwgd2h5IDggYml0cyBsb25nPw0KDQpJdCBzaG91bGQgYmUgYSB1aW50MzIt
bWF0cml4Lg0KDQo+ID4gKw0KPiA+ICsgICAgICByZWFsdGVrLGRvLXRvZ2dsZToNCj4gPiArICAg
ICAgICBkZXNjcmlwdGlvbjogU2V0IHRoaXMgZmxhZyB0byBlbmFibGUgdGhlIFBIWSBwYXJhbWV0
ZXIgdG9nZ2xlDQo+ID4gKyAgICAgICAgICB3aGVuIHBvcnQgc3RhdHVzIGNoYW5nZS4NCj4gPiAr
ICAgICAgICB0eXBlOiBib29sZWFuDQo+ID4gKw0KPiA+ICsgICAgICByZWFsdGVrLGRvLXRvZ2ds
ZS1vbmNlOg0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBTZXQgdGhpcyBmbGFnIHRvIGRvIFBI
WSBwYXJhbWV0ZXIgdG9nZ2xlIG9ubHkgb24NCj4gPiArICAgICAgICAgIFBIWSBpbml0Lg0KPiA+
ICsgICAgICAgIHR5cGU6IGJvb2xlYW4NCj4gPiArDQo+ID4gKyAgICAgIHJlYWx0ZWssY2hlY2st
ZWZ1c2U6DQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IEVuYWJsZSB0byB1cGRhdGUgUEhZIHBh
cmFtZXRlciBmcm9tIHJlYWRpbmcgb3RwDQo+IHRhYmxlLg0KPiA+ICsgICAgICAgIHR5cGU6IGJv
b2xlYW4NCj4gPiArDQo+ID4gKyAgICAgIHJlYWx0ZWssdXNlLWRlZmF1bHQtcGFyYW1ldGVyOg0K
PiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBEb24ndCBzZXQgcGFyYW1ldGVyIGFuZCB1c2UgZGVm
YXVsdCB2YWx1ZSBpbg0KPiBoYXJkd2FyZS4NCj4gPiArICAgICAgICB0eXBlOiBib29sZWFuDQo+
ID4gKw0KPiA+ICsgICAgICByZWFsdGVrLGNoZWNrLXJ4LWZyb250LWVuZC1vZmZzZXQ6DQo+ID4g
KyAgICAgICAgZGVzY3JpcHRpb246IEVuYWJsZSB0byBjaGVjayByeCBmcm9udCBlbmQgb2Zmc2V0
Lg0KPiA+ICsgICAgICAgIHR5cGU6IGJvb2xlYW4NCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+
ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSAiI2FkZHJlc3MtY2VsbHMi
DQo+ID4gKyAgLSAiI3NpemUtY2VsbHMiDQo+ID4gKyAgLSAiI3BoeS1jZWxscyINCj4gPiArDQo+
ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+
ID4gKyAgLSB8DQo+ID4gKyAgICB1c2JfcG9ydDJfdXNiM3BoeTogdXNiLXBoeUAxM2UxMCB7DQo+
ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJyZWFsdGVrLHJ0ZDEzMTlkLXVzYjNwaHkiLCAicmVh
bHRlayx1c2IzcGh5IjsNCj4gPiArICAgICAgICByZWcgPSA8MHgxM2UxMCAweDQ+Ow0KPiA+ICsg
ICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICNzaXplLWNlbGxzID0g
PDA+Ow0KPiA+ICsgICAgICAgICNwaHktY2VsbHMgPSA8MD47DQo+ID4gKw0KPiA+ICsgICAgICAg
IHBoeUAwIHsNCj4gPiArICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiA+ICsgICAgICAgICAgICBy
ZWFsdGVrLHBhcmFtID0NCj4gPiArICAgICAgICAgICAgICAgICAgICA8MHgwMSAweGFjOGM+LA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgIDwweDA2IDB4MDAxNz4sDQo+IA0KPiBGaXJzdCwgdGhp
cyBpcyBtYXRyaXgsIG5vdCB1aW50OCBhcnJheS4gU2Vjb25kLCAweGFjOGMgaXMgcGFzdCAxNiBi
aXRzIGxvbmcsIG5vdCA4Lg0KPiBUaGlyZCwgeW91IHB1dCBzb21lIG1hZ2ljIHJlZ2lzdGVyIHBy
b2dyYW1taW5nIHRvIERULg0KPiBQbGVhc2UgZG9uJ3QuIERyb3AgYWxsIHRoaXMgZnJvbSBEVC4N
Cg0KcmVhbHRlayxwYXJhbSBpcyBhbiB1aW50MzItbWF0cnguDQpJIHdpbGwgcmV2aXNlZCB0aGUg
dHlwZS4NCg0KVGhhbmtzLA0KU3RhbmxleQ0KDQo=
