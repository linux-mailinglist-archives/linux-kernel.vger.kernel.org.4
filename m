Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2641F72797C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjFHICn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjFHICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:02:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521BD213C;
        Thu,  8 Jun 2023 01:01:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35880vbB6001727, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35880vbB6001727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 8 Jun 2023 16:00:57 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 8 Jun 2023 16:01:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Jun 2023 16:01:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 8 Jun 2023 16:01:13 +0800
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
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v3 4/5] dt-bindings: phy: realtek: Add the doc about the Realtek SoC USB 2.0 PHY
Thread-Topic: [PATCH v3 4/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0 PHY
Thread-Index: AQHZmQjdazkCXQ0o50uX71FuvNBNuK9+uDoAgAHOxvD//3z9gIAAiH4Q
Date:   Thu, 8 Jun 2023 08:01:13 +0000
Message-ID: <289f65f0554344f69f3b0439a9e706ff@realtek.com>
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-4-stanley_chang@realtek.com>
 <7cce1d72-6b4d-9fff-32bc-942193388134@linaro.org>
 <0c405afedbcf4e468add480399775ebd@realtek.com>
 <7390105c-dad9-2785-1768-7f50b067633a@linaro.org>
In-Reply-To: <7390105c-dad9-2785-1768-7f50b067633a@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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

PiA+Pg0KPiA+PiBUaGlzIG5lZWRzIHRvIGJlIHNwZWNpZmljLiBXaGF0IHRoZSBoZWNrIGlzICJQ
SFkgcGFyYW1ldGVyIj8NCj4gPj4NCj4gPiBJdCBjb250YWlucyBtb3JlIHBhcmFtZXRlcnMNCj4g
PiBwYWdlMCBoYXMgMTYgcGFyYW1ldGVycw0KPiA+IHBhZ2UxIGhhcyA4IHBhcmFtZXRlcnMNCj4g
PiBwYWdlMiBoYXMgOCBwYXJhbWV0ZXJzDQo+ID4gSXQncyB0ZWRpb3VzIGlmIHdlIGxpc3QgdGhl
bSBhbGwuDQo+IA0KPiBTdXJlLCBpZiB5b3UgcHJlZmVyIG5vdCB0byBsaXN0IHRoZW0sIHRoZW4g
dGhleSBzaG91bGQgYmUgcmVtb3ZlZCBmcm9tIERULg0KPiANCj4gPiBBbmQgd2Ugb25seSBzZXQg
dGhlIHBhcnQgdGhhdCBkaWZmZXJzIGZyb20gdGhlIGRlZmF1bHQuDQo+ID4gSXQncyBoYXJkIHRv
IGV4cGxhaW4gd2hpY2ggcGFyYW1ldGVycyB3ZXJlIGNoYW5nZWQgYmVjYXVzZSBlYWNoIHBsYXRm
b3JtIGlzDQo+IGRpZmZlcmVudC4NCj4gDQo+IElmIHRoaXMgaXMgcGh5IHR1bmluZyBwZXIgYm9h
cmQsIHlvdSBuZWVkIHRvIGV4cGxhaW4gYW5kIGp1c3RpZnkgdGhlbS4NCj4gSWYgdGhpcyBpcyBw
ZXIgcGxhdGZvcm0sIHRoZW4gZHJvcCBpdCAtIG5vdCBldmVuIG5lZWRlZCwgYmVjYXVzZSB5b3Ug
aGF2ZQ0KPiBjb21wYXRpYmxlIGZvciB0aGlzLg0KPiANCk9rYXksIEkgdHJ5IHRvIHNwZWNpZnkg
YnkgdGhlIGNvbXBhdGlibGUuDQoNClRoYW5rcywNClN0YW5sZXkNCg==
