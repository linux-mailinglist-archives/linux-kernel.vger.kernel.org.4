Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E3764E59A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiLPBZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPBZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:25:27 -0500
X-Greylist: delayed 461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Dec 2022 17:25:24 PST
Received: from mail6.msi.com (mail6.msi.com [114.30.40.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBC95E0BD;
        Thu, 15 Dec 2022 17:25:24 -0800 (PST)
Received: from mail9.msi.com (mail9.msi.com [220.130.147.43])
        by mail6.msi.com (Postfix) with ESMTPS id 57CA05E0619;
        Fri, 16 Dec 2022 09:17:41 +0800 (CST)
Received: from mail9.msi.com (localhost [127.0.0.1])
        by postfix.imss91 (Postfix) with ESMTP id 2F164F807FF;
        Fri, 16 Dec 2022 09:17:41 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 postfix.imss91 2F164F807FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msi.com; s=20220711;
        t=1671153461; bh=59bgXTL4ehW5JIivQFyzfvUgbNP9jA2aJ2fMep79eCw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LwfTWzl3Uuh1uZIF3nny/+vGyDcm6+2x53rmCmyrOvD2e4xNjsNgipMG5cjsNVHx2
         gNYiDaPkR6/PgI5Iwokr6v7OT2umpuXn0PO/qCmuPQAPcFxiProoNdmMyDfGlHOWzK
         x07V7q7nxR1hDpIvpeBIEcoUTY7TXWNk/Vm8TGKyC/n7o49RL1jbix9Jp6RLSNRE1U
         DKkYiX+BPECHFgwTIPuiYH1o1gZC9BM5S85sY/4VhfUnQ/N7NCgx1EHNRDXOr1OfTk
         T7tio/2VRhnSzIAM+C6reRBTpXpj7Fzsk7n+PWIo2l9DLkP90TCnOSP3Sa2IoeGYsc
         qBSi56Wif39hg==
Received: from EX2016D.msi.com.tw (unknown [172.16.0.57])
        by mail9.msi.com (Postfix) with ESMTPS id 20837F80677;
        Fri, 16 Dec 2022 09:17:41 +0800 (CST)
Received: from EX2016A.msi.com.tw (172.16.0.54) by EX2016D.msi.com.tw
 (172.16.0.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.16; Fri, 16 Dec
 2022 09:17:40 +0800
Received: from EX2016A.msi.com.tw ([fe80::111c:1b9e:5379:1011]) by
 EX2016A.msi.com.tw ([fe80::111c:1b9e:5379:1011%10]) with mapi id
 15.01.2507.016; Fri, 16 Dec 2022 09:17:40 +0800
From:   =?utf-8?B?am9ld3Uo5ZCz5Luy5oyvKQ==?= <joewu@msi.com>
To:     Prashant Malani <pmalani@chromium.org>,
        Joe Wu <joewu@msi.corp-partner.google.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Derek Huang <derekhuang@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "Douglas Anderson" <dianders@chromium.org>,
        "Dustin L . Howett" <dustin@howett.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: RE: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Thread-Topic: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Thread-Index: AQHZEEy2MF2RiyAUZk2itU6kR3IX965vCtaAgACr/0A=
Date:   Fri, 16 Dec 2022 01:17:40 +0000
Message-ID: <dad487c20e134f5a96909315c0e7911d@msi.com>
References: <20221215061550.18993-1-joewu@msi.corp-partner.google.com>
 <CACeCKae01WNKbP8wWONdpbNJQjLWFF67AFay0kwA_zmoaUNVUQ@mail.gmail.com>
In-Reply-To: <CACeCKae01WNKbP8wWONdpbNJQjLWFF67AFay0kwA_zmoaUNVUQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.252.125]
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-RCPT: <pmalani@chromium.org>, <joewu@msi.corp-partner.google.com>, <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>, <wangxiang@cdjrlc.com>, <linux-input@vger.kernel.org>, <derekhuang@google.com>, <gregkh@linuxfoundation.org>, <bleung@chromium.org>, <dnojiri@chromium.org>, <furquan@chromium.org>, <tzungbi@kernel.org>, <chrome-platform@lists.linux.dev>, <dianders@chromium.org>, <dustin@howett.net>, <dmitry.torokhov@gmail.com>, <groeck@chromium.org>, <gustavoars@kernel.org>, <sebastian.reichel@collabora.com>
X-TM-AS-GCONF: 00
X-RCPT: <wangxiang@cdjrlc.com>, <bleung@chromium.org>, <dianders@chromium.org>, <dnojiri@chromium.org>, <furquan@chromium.org>, <groeck@chromium.org>, <pmalani@chromium.org>, <swboyd@chromium.org>, <sebastian.reichel@collabora.com>, <dmitry.torokhov@gmail.com>, <derekhuang@google.com>, <dustin@howett.net>, <gustavoars@kernel.org>, <tzungbi@kernel.org>, <gregkh@linuxfoundation.org>, <chrome-platform@lists.linux.dev>, <internal@maedb.msi.com>, <joewu@msi.corp-partner.google.com>, <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhc2hhbnQsDQoNClRoYW5rIHlvdSBmb3IgY29tbWVudHMuIEkgd2lsbCBjb3JyZWN0IHRo
ZSBkZXNjcmlwdGlvbiB0byBiZSBpbXBlcmF0aXZlIG1vb2QuDQoNCkJScywNCkpvZQ0KDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQcmFzaGFudCBNYWxhbmkgPHBtYWxhbmlA
Y2hyb21pdW0ub3JnPiANClNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTYsIDIwMjIgNjo1OSBBTQ0K
VG86IEpvZSBXdSA8am9ld3VAbXNpLmNvcnAtcGFydG5lci5nb29nbGUuY29tPg0KQ2M6IExLTUwg
PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBTdGVwaGVuIEJveWQgPHN3Ym95ZEBjaHJv
bWl1bS5vcmc+OyBYaWFuZyB3YW5neCA8d2FuZ3hpYW5nQGNkanJsYy5jb20+OyBsaW51eC1pbnB1
dEB2Z2VyLmtlcm5lbC5vcmc7IERlcmVrIEh1YW5nIDxkZXJla2h1YW5nQGdvb2dsZS5jb20+OyBH
cmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgQmVuc29uIExl
dW5nIDxibGV1bmdAY2hyb21pdW0ub3JnPjsgRGFpc3VrZSBOb2ppcmkgPGRub2ppcmlAY2hyb21p
dW0ub3JnPjsgRnVycXVhbiBTaGFpa2ggPGZ1cnF1YW5AY2hyb21pdW0ub3JnPjsgVHp1bmctQmkg
U2hpaCA8dHp1bmdiaUBrZXJuZWwub3JnPjsgY2hyb21lLXBsYXRmb3JtQGxpc3RzLmxpbnV4LmRl
djsgRG91Z2xhcyBBbmRlcnNvbiA8ZGlhbmRlcnNAY2hyb21pdW0ub3JnPjsgRHVzdGluIEwgLiBI
b3dldHQgPGR1c3RpbkBob3dldHQubmV0PjsgRG1pdHJ5IFRvcm9raG92IDxkbWl0cnkudG9yb2to
b3ZAZ21haWwuY29tPjsgR3VlbnRlciBSb2VjayA8Z3JvZWNrQGNocm9taXVtLm9yZz47IEd1c3Rh
dm8gQSAuIFIgLiBTaWx2YSA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPjsgU2ViYXN0aWFuIFJlaWNo
ZWwgPHNlYmFzdGlhbi5yZWljaGVsQGNvbGxhYm9yYS5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENI
XSBjcm9zX2VjX2tleWI6IEFkZCAzIGJ1dHRvbnMgZm9yIG1vbml0b3IgZnVuY3Rpb24NCg0KSGkg
Sm9lLA0KDQpPbiBXZWQsIERlYyAxNCwgMjAyMiBhdCAxMDoxNSBQTSBKb2UgV3UNCjxqb2V3dUBt
c2kuY29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+IHdyb3RlOg0KPg0KPiBUaGlzIHBhdGNoIGlzIHRv
IGFkZCBleHRyYSAzIGJ1dHRvbnM6ICdicmlnaHRuZXNzIHVwJywgJ2JyaWdodG5lc3MgDQo+IGRv
d24nIGFuZCAnbGVhdmUgUEMoY3JvcykgbW9kZScgdG8gc3VwcG9ydCBtb25pdG9yIG5hdmlnYXRp
b24gDQo+IGZ1bmN0aW9uLg0KDQpuaXQ6IFBsZWFzZSB1c2UgdGhlIGltcGVyYXRpdmUgZm9ybSBb
MV0gd2hpbGUgZGVzY3JpYmluZyBwYXRjaGVzLg0KSW4gdGhpcyBjYXNlLCB0aGF0IHdvdWxkIHRy
YW5zbGF0ZSB0bzoNCiJBZGQgZXh0cmEgMyBidXR0b25zLi4uIg0KDQpUaGFua3MsDQoNCi1QcmFz
aGFudA0KDQpbMV0gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vz
cy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbCNkZXNjcmliZS15b3VyLWNoYW5nZXMNCg0KKioqKipD
T05GSURFTlRJQUwgSU5GT1JNQVRJT04qKioqKg0KDQpUaGlzIGVtYWlsIGlzIGludGVuZGVkIG9u
bHkgZm9yIHRoZSB1c2Ugb2YgdGhlIHBlcnNvbiBvciBlbnRpdHkgdG8gd2hvbSBpdCBpcw0KYWRk
cmVzc2VkIGFuZCBjb250YWlucyBpbmZvcm1hdGlvbiB0aGF0IG1heSBiZSBzdWJqZWN0IHRvIGFu
ZC9vciBtYXkgYmUNCnJlc3RyaWN0ZWQgZnJvbSBkaXNjbG9zdXJlIGJ5IGNvbnRyYWN0IG9yIGFw
cGxpY2FibGUgbGF3LiBJZiB5b3UgYXJlIG5vdCB0aGUgDQppbnRlbmRlZCByZWNpcGllbnQgb2Yg
dGhpcyBlbWFpbCwgYmUgYWR2aXNlZCB0aGF0IGFueSBkaXNjbG9zdXJlLCBjb3B5LCANCmRpc3Ry
aWJ1dGlvbiBvciB1c2Ugb2YgdGhlIGNvbnRlbnRzIG9mIHRoaXMgbWVzc2FnZSBpcyBzdHJpY3Rs
eSBwcm9oaWJpdGVkLiANCklmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgb2Yg
dGhpcyBlbWFpbCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIA0KdGhhdCB5b3UgaGF2ZSByZWNl
aXZlZCB0aGlzIGluIGVycm9yIGJ5IHJlcGx5aW5nIHRvIHRoaXMgbWVzc2FnZS4gVGhlbiwgDQpw
bGVhc2UgZGVsZXRlIGl0IGZyb20geW91ciBzeXN0ZW0uIE91ciBQcml2YWN5IFBvbGljeSBpcyBh
dmFpbGFibGUgaGVyZSANCmh0dHBzOi8vd3d3Lm1zaS5jb20vcGFnZS9wcml2YWN5LXBvbGljeS4g
VGhhbmsgeW91Lg==

