Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557BD6E5C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDRIey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDRIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:34:51 -0400
Received: from gfmail2.glenfly.com (unknown [113.31.180.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A8EE1FF3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:34:49 -0700 (PDT)
X-ASG-Debug-ID: 1681806886-196b961946c6150001-xx1T2L
Received: from GFSHEXCH03.glenfly.com (GFSHEXCH03.glenfly.com [10.5.250.53]) by gfmail2.glenfly.com with ESMTP id qPa3ZwIPbiBA9eFK; Tue, 18 Apr 2023 16:34:46 +0800 (CST)
X-Barracuda-Envelope-From: ReaperLi@glenfly.com
X-Barracuda-RBL-Trusted-Forwarder: 10.5.250.53
Received: from GFSHEXCH02.glenfly.com (10.5.250.52) by GFSHEXCH03.glenfly.com
 (10.5.250.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Apr
 2023 16:35:07 +0800
Received: from GFSHEXCH02.glenfly.com ([fe80::cd31:d55d:9030:69c1]) by
 GFSHEXCH02.glenfly.com ([fe80::cd31:d55d:9030:69c1%2]) with mapi id
 15.01.2507.023; Tue, 18 Apr 2023 16:34:46 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.5.250.53
From:   "Reaper Li(WH-RD)" <ReaperLi@glenfly.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jason Tao(SH-RD)" <JasonTao@glenfly.com>
Subject: =?utf-8?B?562U5aSNOiBb5Y+v6IO95piv5Z6D5Zy+6YKu5Lu2XSAgUmU6IFtQQVRDSCB2?=
 =?utf-8?B?Ml0gQUxTQTogaGRhOiBHbGVuZmx5OiBhZGQgSEQgQXVkaW8gUENJIElEcyBh?=
 =?utf-8?Q?nd_HDMI_Codec_Vendor_IDs.?=
Thread-Topic: =?utf-8?B?W+WPr+iDveaYr+Weg+WcvumCruS7tl0gIFJlOiBbUEFUQ0ggdjJdIEFMU0E6?=
 =?utf-8?B?IGhkYTogR2xlbmZseTogYWRkIEhEIEF1ZGlvIFBDSSBJRHMgYW5kIEhETUkg?=
 =?utf-8?Q?Codec_Vendor_IDs.?=
X-ASG-Orig-Subj: =?utf-8?B?562U5aSNOiBb5Y+v6IO95piv5Z6D5Zy+6YKu5Lu2XSAgUmU6IFtQQVRDSCB2?=
 =?utf-8?B?Ml0gQUxTQTogaGRhOiBHbGVuZmx5OiBhZGQgSEQgQXVkaW8gUENJIElEcyBh?=
 =?utf-8?Q?nd_HDMI_Codec_Vendor_IDs.?=
Thread-Index: AQHZbrtIYAw2tCey3E6t1qlDYwmuYK8qMoOAgAaPqQA=
Date:   Tue, 18 Apr 2023 08:34:45 +0000
Message-ID: <e8a38b90791846a4b3d5bf1b268e5b9c@glenfly.com>
References: <20230414102912.798-1-ReaperLi@glenfly.com>
 <87y1mulkty.wl-tiwai@suse.de>
In-Reply-To: <87y1mulkty.wl-tiwai@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.30.24.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Barracuda-Connect: GFSHEXCH03.glenfly.com[10.5.250.53]
X-Barracuda-Start-Time: 1681806886
X-Barracuda-URL: https://10.5.252.52:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at glenfly.com
X-Barracuda-Scan-Msg-Size: 1572
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4997 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_SC0_MV0113c
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107580
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 BSF_SC0_MV0113c        BSF_SC0_MV0113c
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGFrYXNoaSwNCg0KVGhhbmtzIGZvciB5b3VyIHRpbWUuIEhhdmUgYmVlbiB1c2luZyBnaXQt
c2VuZC1lbWFpbCBmcm9tIHRoZSBiZWdpbm5pbmcsIGFmdGVyIGluc3BlY3Rpb24sIHRoZSBwYXRj
aCBtYXliZSBiZSBjb3JydXB0ZWQgYnkgdGhlIGF1dG8gc2lnbmVkIG1lc3NhZ2UgZnJvbSB0aGUg
bWFpbCBzZXJ2ZXIuDQoNCnBsZWFzZSBoZWxwIGNoZWNrIHRoZSBuZXcgcGF0Y2ggZmlsZSBmcm9t
IHRoZSByZWFwZXJsaW9jQGdsZW5mbHkuY29tLg0KDQpCZXN0IFJlZ2FyZHMsDQpSZWFwZXINCg0K
LS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1
c2UuZGU+DQrlj5HpgIHml7bpl7Q6IDIwMjPlubQ05pyIMTTml6UgMjA6MTcNCuaUtuS7tuS6ujog
UmVhcGVyIExpKFdILVJEKSA8UmVhcGVyTGlAZ2xlbmZseS5jb20+DQrmioTpgIE6IHBlcmV4QHBl
cmV4LmN6OyB0aXdhaUBzdXNlLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSmFz
b24gVGFvKFNILVJEKSA8SmFzb25UYW9AZ2xlbmZseS5jb20+DQrkuLvpopg6IFvlj6/og73mmK/l
noPlnL7pgq7ku7ZdIFJlOiBbUEFUQ0ggdjJdIEFMU0E6IGhkYTogR2xlbmZseTogYWRkIEhEIEF1
ZGlvIFBDSSBJRHMgYW5kIEhETUkgQ29kZWMgVmVuZG9yIElEcy4NCg0KT24gRnJpLCAxNCBBcHIg
MjAyMyAxMjoyOToxMiArMDIwMCwNClJlYXBlckxpIHdyb3RlOg0KPg0KPiBGcm9tOiBqYXNvbnRh
byA8amFzb250YW9AZ2xlbmZseS5jb20+DQo+DQo+IEFkZCBhIHNldCBvZiBIRCBBdWRpbyBQQ0kg
SURTLCBhbmQgdGhlIEhETUkgY29kZWMgdmVuZG9yIElEcyBmb3INCj4gR2xlbmZseSBBcmlzZS4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogamFzb250YW8gPGphc29udGFvQGdsZW5mbHkuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBSZWFwZXJMaSA8UmVhcGVyTGlAZ2xlbmZseS5jb20+DQo+IC0tLQ0KPiBD
aGFuZ2VzIGluIHYyOg0KPiAgIC0gdXNlIHRhYiBpbnN0ZWFkIG9mIHNwYWNlLg0KDQpUaGUgcGF0
Y2ggc3RpbGwgY2FuJ3QgYmUgYXBwbGllZCwgYW5kIGl0J3MgbGlrZWx5IHRoZSBwcm9ibGVtIG9m
IHlvdXIgbWFpbGVyLiAgVHJ5IGdpdC1zZW5kLWVtYWlsLg0KDQoNClRha2FzaGkNCg0KDQrkv53l
r4blo7DmmI7vvJoNCuacrOmCruS7tuWQq+acieS/neWvhuaIluS4k+acieS/oeaBr++8jOS7heS+
m+aMh+WumuaUtuS7tuS6uuS9v+eUqOOAguS4peemgeWvueacrOmCruS7tuaIluWFtuWGheWuueWB
muS7u+S9leacque7j+aOiOadg+eahOafpemYheOAgeS9v+eUqOOAgeWkjeWItuaIlui9rOWPkeOA
gg0KQ09ORklERU5USUFMIE5PVEU6DQpUaGlzIGVtYWlsIGNvbnRhaW5zIGNvbmZpZGVudGlhbCBv
ciBsZWdhbGx5IHByaXZpbGVnZWQgaW5mb3JtYXRpb24gYW5kIGlzIGZvciB0aGUgc29sZSB1c2Ug
b2YgaXRzIGludGVuZGVkIHJlY2lwaWVudC4gQW55IHVuYXV0aG9yaXplZCByZXZpZXcsIHVzZSwg
Y29weWluZyBvciBmb3J3YXJkaW5nIG9mIHRoaXMgZW1haWwgb3IgdGhlIGNvbnRlbnQgb2YgdGhp
cyBlbWFpbCBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLg0K
