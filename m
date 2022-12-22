Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678CE653C33
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbiLVGfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiLVGfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:35:06 -0500
Received: from mail5.msi.com (mail5.msi.com [114.30.40.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F741E3C7;
        Wed, 21 Dec 2022 22:35:03 -0800 (PST)
Received: from mail9.msi.com (mail9.msi.com [220.130.147.43])
        by mail5.msi.com (Postfix) with ESMTPS id E0F9D54075F;
        Thu, 22 Dec 2022 14:35:00 +0800 (CST)
Received: from mail9.msi.com (localhost [127.0.0.1])
        by postfix.imss91 (Postfix) with ESMTP id 495E9F80847;
        Thu, 22 Dec 2022 14:35:01 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 postfix.imss91 495E9F80847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msi.com; s=20220711;
        t=1671690901; bh=FMkzPP79JR7fD/AyLN5SPMrzM7fk9s10M3lmAcRPCIk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CUtYDjYGXADhWGl577BQggqYroHrqCOkXwMOZNMwwJ9v/9ztzB1y71GSx2TezfbHo
         VZhYrI+v2UqK1IwjcQNmVdmDPGO85cknJnXrqFtVFvFGU1eG5wXGgJJT/Z66xashyS
         /pzJgrTX7Jbu2+FJWEN6W6j1VJIxMsNryST1Ldovy8/B/xtzkCMWrohrHXCfaXbMgT
         0e1C8gNIj3P59L/usF1Aj6X0/rMe0B5sX76c1w/3DWUL1qGnoMbaqPHe4y5J7WMWXu
         hNe+WAVn3TtuKeB1k5JgvSjmiqKk+l8aze4anO6OoAtUaql2w0sqJOAqp9gfL+vOjo
         OumzxYTU2QUXQ==
Received: from EX2016B.msi.com.tw (unknown [172.16.0.55])
        by mail9.msi.com (Postfix) with ESMTPS id 39C59F8080A;
        Thu, 22 Dec 2022 14:35:01 +0800 (CST)
Received: from EX2016A.msi.com.tw (172.16.0.54) by EX2016B.msi.com.tw
 (172.16.0.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.16; Thu, 22 Dec
 2022 14:35:00 +0800
Received: from EX2016A.msi.com.tw ([fe80::111c:1b9e:5379:1011]) by
 EX2016A.msi.com.tw ([fe80::111c:1b9e:5379:1011%10]) with mapi id
 15.01.2507.016; Thu, 22 Dec 2022 14:35:00 +0800
From:   =?big5?B?am9ld3Uop2Sl8q62KQ==?= <joewu@msi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Wu <joewu@msi.corp-partner.google.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Derek Huang <derekhuang@google.com>,
        "Dustin L . Howett" <dustin@howett.net>,
        Guenter Roeck <groeck@chromium.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: RE: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Thread-Topic: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Thread-Index: AQHZFatT8gbwWzGO90iM45R7vLG2J6545gIAgACNcoA=
Date:   Thu, 22 Dec 2022 06:34:59 +0000
Message-ID: <5600a6d36a944f0e968e4935ffac8430@msi.com>
References: <20221222021542.11706-1-joewu@msi.corp-partner.google.com>
 <Y6P0Ogh1T6n5i3Bi@kroah.com>
In-Reply-To: <Y6P0Ogh1T6n5i3Bi@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.252.125]
Content-Type: text/plain;
        charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-RCPT: <gregkh@linuxfoundation.org>, <joewu@msi.corp-partner.google.com>, <linux-kernel@vger.kernel.org>, <furquan@chromium.org>, <dnojiri@chromium.org>, <dmitry.torokhov@gmail.com>, <bleung@chromium.org>, <derekhuang@google.com>, <dustin@howett.net>, <groeck@chromium.org>, <linux-input@vger.kernel.org>, <wangxiang@cdjrlc.com>, <gustavoars@kernel.org>, <pmalani@chromium.org>, <dianders@chromium.org>, <tzungbi@kernel.org>, <chrome-platform@lists.linux.dev>, <swboyd@chromium.org>, <Jonathan.Cameron@huawei.com>, <sebastian.reichel@collabora.com>, <tinghan.shen@mediatek.com>
X-TM-AS-GCONF: 00
X-RCPT: <wangxiang@cdjrlc.com>, <bleung@chromium.org>, <dianders@chromium.org>, <dnojiri@chromium.org>, <furquan@chromium.org>, <groeck@chromium.org>, <pmalani@chromium.org>, <swboyd@chromium.org>, <sebastian.reichel@collabora.com>, <dmitry.torokhov@gmail.com>, <derekhuang@google.com>, <dustin@howett.net>, <Jonathan.Cameron@huawei.com>, <gustavoars@kernel.org>, <tzungbi@kernel.org>, <gregkh@linuxfoundation.org>, <chrome-platform@lists.linux.dev>, <internal@maedb.msi.com>, <tinghan.shen@mediatek.com>, <joewu@msi.corp-partner.google.com>, <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KSSdsbCBmaXggaXQuIFRoYW5rcy4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+IA0KU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDIyLCAyMDIyIDI6MDggUE0NClRvOiBKb2Ug
V3UgPGpvZXd1QG1zaS5jb3JwLXBhcnRuZXIuZ29vZ2xlLmNvbT4NCkNjOiBMS01MIDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgRnVycXVhbiBTaGFpa2ggPGZ1cnF1YW5AY2hyb21pdW0u
b3JnPjsgRGFpc3VrZSBOb2ppcmkgPGRub2ppcmlAY2hyb21pdW0ub3JnPjsgRG1pdHJ5IFRvcm9r
aG92IDxkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tPjsgQmVuc29uIExldW5nIDxibGV1bmdAY2hy
b21pdW0ub3JnPjsgRGVyZWsgSHVhbmcgPGRlcmVraHVhbmdAZ29vZ2xlLmNvbT47IER1c3RpbiBM
IC4gSG93ZXR0IDxkdXN0aW5AaG93ZXR0Lm5ldD47IGpvZXd1KKdkpfKutikgPGpvZXd1QG1zaS5j
b20+OyBHdWVudGVyIFJvZWNrIDxncm9lY2tAY2hyb21pdW0ub3JnPjsgbGludXgtaW5wdXRAdmdl
ci5rZXJuZWwub3JnOyBYaWFuZyB3YW5neCA8d2FuZ3hpYW5nQGNkanJsYy5jb20+OyBHdXN0YXZv
IEEgLiBSIC4gU2lsdmEgPGd1c3Rhdm9hcnNAa2VybmVsLm9yZz47IFByYXNoYW50IE1hbGFuaSA8
cG1hbGFuaUBjaHJvbWl1bS5vcmc+OyBEb3VnbGFzIEFuZGVyc29uIDxkaWFuZGVyc0BjaHJvbWl1
bS5vcmc+OyBUenVuZy1CaSBTaGloIDx0enVuZ2JpQGtlcm5lbC5vcmc+OyBjaHJvbWUtcGxhdGZv
cm1AbGlzdHMubGludXguZGV2OyBTdGVwaGVuIEJveWQgPHN3Ym95ZEBjaHJvbWl1bS5vcmc+OyBK
b25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+OyBTZWJhc3RpYW4g
UmVpY2hlbCA8c2ViYXN0aWFuLnJlaWNoZWxAY29sbGFib3JhLmNvbT47IFRpbmdoYW4gU2hlbiA8
dGluZ2hhbi5zaGVuQG1lZGlhdGVrLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNyb3NfZWNf
a2V5YjogQWRkIDMgYnV0dG9ucyBmb3IgbW9uaXRvciBmdW5jdGlvbg0KDQpPbiBUaHUsIERlYyAy
MiwgMjAyMiBhdCAxMDoxNTo0MkFNICswODAwLCBKb2UgV3Ugd3JvdGU6DQo+IC0tLSBhL2luY2x1
ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9jcm9zX2VjX2NvbW1hbmRzLmgNCj4gKysrIGIvaW5jbHVk
ZS9saW51eC9wbGF0Zm9ybV9kYXRhL2Nyb3NfZWNfY29tbWFuZHMuaA0KPiBAQCAtMzQ3MSw2ICsz
NDcxLDkgQEAgc3RydWN0IGVjX3Jlc3BvbnNlX2dldF9uZXh0X2V2ZW50X3YxIHsNCj4gICNkZWZp
bmUgRUNfTUtCUF9WT0xfVVAJCTENCj4gICNkZWZpbmUgRUNfTUtCUF9WT0xfRE9XTgkyDQo+ICAj
ZGVmaW5lIEVDX01LQlBfUkVDT1ZFUlkJMw0KPiArI2RlZmluZSBFQ19NS0JQX0JSSV9VUCAgICAg
ICAgICA0DQo+ICsjZGVmaW5lIEVDX01LQlBfQlJJX0RPV04gICAgICAgIDUNCj4gKyNkZWZpbmUg
RUNfTUtCUF9TQ1JFRU5fTE9DSyAgICAgNg0KDQpZb3UgZm9yZ290IHRvIHVzZSB0YWJzIDooDQoN
Cg0KKioqKipDT05GSURFTlRJQUwgSU5GT1JNQVRJT04qKioqKg0KDQpUaGlzIGVtYWlsIGlzIGlu
dGVuZGVkIG9ubHkgZm9yIHRoZSB1c2Ugb2YgdGhlIHBlcnNvbiBvciBlbnRpdHkgdG8gd2hvbSBp
dCBpcw0KYWRkcmVzc2VkIGFuZCBjb250YWlucyBpbmZvcm1hdGlvbiB0aGF0IG1heSBiZSBzdWJq
ZWN0IHRvIGFuZC9vciBtYXkgYmUNCnJlc3RyaWN0ZWQgZnJvbSBkaXNjbG9zdXJlIGJ5IGNvbnRy
YWN0IG9yIGFwcGxpY2FibGUgbGF3LiBJZiB5b3UgYXJlIG5vdCB0aGUgDQppbnRlbmRlZCByZWNp
cGllbnQgb2YgdGhpcyBlbWFpbCwgYmUgYWR2aXNlZCB0aGF0IGFueSBkaXNjbG9zdXJlLCBjb3B5
LCANCmRpc3RyaWJ1dGlvbiBvciB1c2Ugb2YgdGhlIGNvbnRlbnRzIG9mIHRoaXMgbWVzc2FnZSBp
cyBzdHJpY3RseSBwcm9oaWJpdGVkLiANCklmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNp
cGllbnQgb2YgdGhpcyBlbWFpbCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIA0KdGhhdCB5b3Ug
aGF2ZSByZWNlaXZlZCB0aGlzIGluIGVycm9yIGJ5IHJlcGx5aW5nIHRvIHRoaXMgbWVzc2FnZS4g
VGhlbiwgDQpwbGVhc2UgZGVsZXRlIGl0IGZyb20geW91ciBzeXN0ZW0uIE91ciBQcml2YWN5IFBv
bGljeSBpcyBhdmFpbGFibGUgaGVyZSANCmh0dHBzOi8vd3d3Lm1zaS5jb20vcGFnZS9wcml2YWN5
LXBvbGljeS4gVGhhbmsgeW91Lg==

