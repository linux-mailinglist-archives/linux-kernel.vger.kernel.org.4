Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FDA727926
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjFHHsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjFHHsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:48:02 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0382126;
        Thu,  8 Jun 2023 00:47:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3587l5knD008024, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3587l5knD008024
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 8 Jun 2023 15:47:05 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 8 Jun 2023 15:47:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Jun 2023 15:47:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 8 Jun 2023 15:47:21 +0800
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
Thread-Index: AQHZmQjdazkCXQ0o50uX71FuvNBNuK9+uDoAgAHOxvA=
Date:   Thu, 8 Jun 2023 07:47:21 +0000
Message-ID: <0c405afedbcf4e468add480399775ebd@realtek.com>
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-4-stanley_chang@realtek.com>
 <7cce1d72-6b4d-9fff-32bc-942193388134@linaro.org>
In-Reply-To: <7cce1d72-6b4d-9fff-32bc-942193388134@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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

SGkgS3J6eXN6dG9mLA0KDQoNCj4gPiArICAgICAgRm9yIG1vc3QgUmVsYXRlayBTb0NzLCBvbmUg
WEhDSSBjb250cm9sbGVyIG9ubHkgc3VwcG9ydCBvbmUgdGhlIFVTQg0KPiAyLjANCj4gPiArICAg
ICAgcGh5LiBGb3IgUlREMTM5NSBTb0MsIHRoZSBvbmUgWEhDSSBjb250cm9sbGVyIGhhcyB0d28g
VVNCIDIuMA0KPiBQSFlzLg0KPiA+ICsgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgcmVhbHRl
ayxwYWdlMC1wYXJhbToNCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjogUEhZIHBhcmFtZXRlciBh
dCBwYWdlIDAuIFRoZSBkYXRhIGFyZSB0aGUgcGFpciBvZg0KPiB0aGUNCj4gPiArICAgICAgICAg
IG9mZnNldCBhbmQgdmFsdWUuDQo+IA0KPiBUaGlzIG5lZWRzIHRvIGJlIHNwZWNpZmljLiBXaGF0
IHRoZSBoZWNrIGlzICJQSFkgcGFyYW1ldGVyIj8NCj4gDQpJdCBjb250YWlucyBtb3JlIHBhcmFt
ZXRlcnMNCnBhZ2UwIGhhcyAxNiBwYXJhbWV0ZXJzDQpwYWdlMSBoYXMgOCBwYXJhbWV0ZXJzDQpw
YWdlMiBoYXMgOCBwYXJhbWV0ZXJzDQpJdCdzIHRlZGlvdXMgaWYgd2UgbGlzdCB0aGVtIGFsbC4N
CkFuZCB3ZSBvbmx5IHNldCB0aGUgcGFydCB0aGF0IGRpZmZlcnMgZnJvbSB0aGUgZGVmYXVsdC4N
Ckl0J3MgaGFyZCB0byBleHBsYWluIHdoaWNoIHBhcmFtZXRlcnMgd2VyZSBjaGFuZ2VkIGJlY2F1
c2UgZWFjaCBwbGF0Zm9ybSBpcyBkaWZmZXJlbnQuDQoNClRoYW5rcywNClN0YW5sZXkNCg==
