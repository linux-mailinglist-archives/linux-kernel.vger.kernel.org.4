Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BAD6E0883
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDMIAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjDMIAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:00:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D05B5FD4;
        Thu, 13 Apr 2023 01:00:17 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33D7xm103025841, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33D7xm103025841
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 13 Apr 2023 15:59:48 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 13 Apr 2023 16:00:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 13 Apr 2023 16:00:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 13 Apr 2023 16:00:09 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] usb: dwc3: core: add support for disabling High-speed park mode
Thread-Topic: [PATCH v2 1/2] usb: dwc3: core: add support for disabling
 High-speed park mode
Thread-Index: AQHZbDd6mjqPmjMt8EayK+GV5r/KUq8mG4+AgAFsAjCAANC0AIAAiV6g
Date:   Thu, 13 Apr 2023 08:00:09 +0000
Message-ID: <95791748e8284bf188386bba91688988@realtek.com>
References: <20230411053550.16360-1-stanley_chang@realtek.com>
 <20230411213158.r7i6thg67okbovjp@synopsys.com>
 <e9964b3cd1a34b05990c1061af9d1951@realtek.com>
 <2023041355-parole-enviable-b002@gregkh>
In-Reply-To: <2023041355-parole-enviable-b002@gregkh>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gV2VkLCBBcHIgMTIsIDIwMjMgYXQgMTE6MTU6MzVBTSArMDAwMCwgU3RhbmxleSBD
aGFuZ1vmmIzogrLlvrddIHdyb3RlOg0KPiA+DQo+ID4gQ0MgbW9yZSBtYWludGFpbmVycyBieSB1
c2luZyBzY3JpcHRzL2dldF9tYWludGFpbmVycy5wbA0KPiA+DQo+IA0KPiBJIGRvIG5vdCBzZWUg
YW55IG1lc3NhZ2UgaGVyZSwgc28gSSBhbSB0b3RhbGx5IGNvbmZ1c2VkLg0KPiANCj4gWW91IGhh
dmUgdG8gdXNlIHRoZSBzY3JpcHQgd2hlbiBkZXRlcm1pbmluZyB3aG8gdG8gc2VuZCB0aGUgcGF0
Y2ggdG8sIHlvdQ0KPiBjYW4ndCBkbyBpdCBhZnRlciB0aGUgZmFjdCBsaWtlIHRoaXMgYXMgaXQg
d2lsbCBub3Qgd29yayBhdCBhbGwuDQo+IA0KPiBncmVnIGstaA0KPiANCg0KU29ycnkgZm9yIHRo
ZSBjb25mdXNpb24uDQpJbiB0aGUgYmVnaW5uaW5nIEkgZGlkbid0IGhhdmUgY2MgYWxsIG1haW50
YWluZXJzLg0KSSdsbCByZXN1Ym1pdCBhIG5ldyByZXZpZXcgdGhyZWFkLg0KUGxlYXNlIGlnbm9y
ZSB0aGlzIGVtYWlsLg0KDQoNCg==
