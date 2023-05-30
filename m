Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81203715394
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjE3CU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjE3CUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:20:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E3DB5;
        Mon, 29 May 2023 19:20:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34U2JXGT0028436, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34U2JXGT0028436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 30 May 2023 10:19:33 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 30 May 2023 10:19:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 30 May 2023 10:19:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 30 May 2023 10:19:45 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Flavio Suligoi" <f.suligoi@asem.it>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>,
        Ray Chi <raychi@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] usb: phy: add usb phy notify port status API
Thread-Topic: [PATCH v2 1/3] usb: phy: add usb phy notify port status API
Thread-Index: AQHZjrBJqs57LUq3CEa1m1O4SeqC6K9wz9gAgAFFkIA=
Date:   Tue, 30 May 2023 02:19:45 +0000
Message-ID: <647ded70ff024a3081cbf5c45f5da12c@realtek.com>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <2023052905-maimed-studied-3563@gregkh>
In-Reply-To: <2023052905-maimed-studied-3563@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
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

SGkgR3JlZywNCg0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvdXNiL3BoeS5oDQo+ID4gKysrIGIv
aW5jbHVkZS9saW51eC91c2IvcGh5LmgNCj4gPiBAQCAtMTQ0LDYgKzE0NCwxMCBAQCBzdHJ1Y3Qg
dXNiX3BoeSB7DQo+ID4gICAgICAgICovDQo+ID4gICAgICAgaW50ICAgICAoKnNldF93YWtldXAp
KHN0cnVjdCB1c2JfcGh5ICp4LCBib29sIGVuYWJsZWQpOw0KPiA+DQo+ID4gKyAgICAgLyogbm90
aWZ5IHBoeSBwb3J0IHN0YXR1cyBjaGFuZ2UgKi8NCj4gPiArICAgICBpbnQgICAgICgqbm90aWZ5
X3BvcnRfc3RhdHVzKShzdHJ1Y3QgdXNiX3BoeSAqeCwNCj4gPiArICAgICAgICAgICAgIGludCBw
b3J0LCB1MTYgcG9ydHN0YXR1cywgdTE2IHBvcnRjaGFuZ2UpOw0KPiA+ICsNCj4gPiAgICAgICAv
KiBub3RpZnkgcGh5IGNvbm5lY3Qgc3RhdHVzIGNoYW5nZSAqLw0KPiA+ICAgICAgIGludCAgICAg
KCpub3RpZnlfY29ubmVjdCkoc3RydWN0IHVzYl9waHkgKngsDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgIGVudW0gdXNiX2RldmljZV9zcGVlZCBzcGVlZCk7DQo+IA0KPiBXaHkgY2FuJ3QgdGhp
cyBiZSBwYXJ0IG9mIHRoZSBzYW1lIG5vdGlmeV9jb25uZWN0KCkgY2FsbGJhY2s/DQoNClRoZSBu
b3RpZnkgY29ubmVjdCBpcyBhdCBkZXZpY2UgcmVhZHkuIEJ1dCBJIHdhbnQgbm90aWZ5IHBvcnQg
c3RhdHVzIGNoYW5nZSBiZWZvcmUgcG9ydCByZXNldC4NCg0KPiBXaGF0IG1ha2VzIGl0IGRpZmZl
cmVudCBzb21laG93PyAgUGxlYXNlIGRvY3VtZW50IHRoaXMgbXVjaCBiZXR0ZXIuDQoNCkluIFJl
YWx0ZWsgcGh5IGRyaXZlciwgd2UgaGF2ZSBkZXNpZ25lZCB0byBkeW5hbWljYWxseSBhZGp1c3Qg
ZGlzY29ubmVjdGlvbiBsZXZlbCBhbmQgY2FsaWJyYXRlIHBoeSBwYXJhbWV0ZXJzLg0KU28gd2Ug
ZG8gdGhpcyB3aGVuIHRoZSBkZXZpY2UgY29ubmVjdGVkIGJpdCBjaGFuZ2VzIGFuZCB3aGVuIHRo
ZSBkaXNjb25uZWN0ZWQgYml0IGNoYW5nZXMuDQpQb3J0IHN0YXR1cyBjaGFuZ2Ugbm90aWZpY2F0
aW9uOg0KMS4gQ2hlY2sgaWYgcG9ydHN0YXR1cyBpcyBVU0JfUE9SVF9TVEFUX0NPTk5FQ1RJT04g
YW5kIHBvcnRjaGFuZ2UgaXMgVVNCX1BPUlRfU1RBVF9DX0NPTk5FQ1RJT04uDQogIFRoZSBkZXZp
Y2UgaXMgY29ubmVjdGVkLCB0aGUgZHJpdmVyIGxvd2VycyB0aGUgZGlzY29ubmVjdGlvbiBsZXZl
bCBhbmQgY2FsaWJyYXRlcyB0aGUgcGh5IHBhcmFtZXRlcnMuDQoyLiBUaGUgZGV2aWNlIGRpc2Nv
bm5lY3RzLCB0aGUgZHJpdmVyIGluY3JlYXNlcyB0aGUgZGlzY29ubmVjdCBsZXZlbCBhbmQgY2Fs
aWJyYXRlcyB0aGUgcGh5IHBhcmFtZXRlcnMuDQoNCklmIHdlIGFkanVzdCB0aGUgZGlzY29ubmVj
dGlvbiBsZXZlbCBpbiBub3RpZnlfY29ubmVjdCAsIHRoZSBkaXNjb25uZWN0IG1heSBoYXZlIGJl
ZW4gdHJpZ2dlcmVkIGF0IHRoaXMgc3RhZ2UuIA0KU28gd2UgbmVlZCB0byBjaGFuZ2UgdGhhdCBh
cyBlYXJseSBhcyBwb3NzaWJsZS4NCg0KDQo+IA0KPiA+IEBAIC0zMTYsNiArMzIwLDE2IEBAIHVz
Yl9waHlfc2V0X3dha2V1cChzdHJ1Y3QgdXNiX3BoeSAqeCwgYm9vbA0KPiBlbmFibGVkKQ0KPiA+
ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW5saW5l
IGludA0KPiA+ICt1c2JfcGh5X25vdGlmeV9wb3J0X3N0YXR1cyhzdHJ1Y3QgdXNiX3BoeSAqeCwg
aW50IHBvcnQsIHUxNiBwb3J0c3RhdHVzLA0KPiA+ICsgICAgICAgICB1MTYgcG9ydGNoYW5nZSkN
Cj4gPiArew0KPiA+ICsgICAgIGlmICh4ICYmIHgtPm5vdGlmeV9wb3J0X3N0YXR1cykNCj4gDQo+
IEhvdyBjYW4geCBldmVyIGJlIE5VTEw/DQoNCkl0IGlzIHBvc3NpYmxlLg0KSWYgdGhlIGNvbnRy
b2xsZXIgbm90IHVzZSB1c2ItcGh5IGRyaXZlci4gSXQgIGlzIE5VTEwuDQoNClRoYW5rcywNClN0
YW5sZXkNCg==
