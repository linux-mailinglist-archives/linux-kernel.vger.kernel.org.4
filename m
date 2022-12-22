Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAE4653A63
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 02:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiLVBuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 20:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVBuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 20:50:24 -0500
Received: from mail5.msi.com (mail5.msi.com [114.30.40.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AE0183AC;
        Wed, 21 Dec 2022 17:50:19 -0800 (PST)
Received: from mail9.msi.com (mail9.msi.com [220.130.147.43])
        by mail5.msi.com (Postfix) with ESMTPS id DED59540762;
        Thu, 22 Dec 2022 09:50:16 +0800 (CST)
Received: from mail9.msi.com (localhost [127.0.0.1])
        by postfix.imss91 (Postfix) with ESMTP id D30F9F80854;
        Thu, 22 Dec 2022 09:50:16 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 postfix.imss91 D30F9F80854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msi.com; s=20220711;
        t=1671673816; bh=dNu7MPFQc+IPFsKDT6Cnd1XmRyuaB1GGrw1EaqA9fm0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YzJuzLxBtxIIgan5GZFWq9lML+4x6Ekq4SLgQqVRDF+yOdKZ+EvR4U59W6vri1dlu
         Rbob5Ry5x7uZdZiHEZvC3hLfqo+0tTZuqMuDcAoI/+CNhv3wNQ/H2le9x9iz/Nx9xo
         6HAngbndfYY04zXq4Q5EHYnwKbf2rPWYXKFM09DGWDrSbB7slj1M36PyfmkPZAFdff
         7MAcNLtBTw1+ZEGOMgViaND0SdBamI22vVnKqsTbK5uvpjvmy5vHCGZmDCCbNBbS61
         0t4UG7QqUbQXqXIn/8c/XyG+K2VAbUVbPNcmHfqY8nBUuh4OBM3FTvmdDp8doL4q9L
         aJGbVfnTWR+EQ==
Received: from EX2016A.msi.com.tw (unknown [172.16.0.54])
        by mail9.msi.com (Postfix) with ESMTPS id C3D20F80852;
        Thu, 22 Dec 2022 09:50:16 +0800 (CST)
Received: from EX2016A.msi.com.tw (172.16.0.54) by EX2016A.msi.com.tw
 (172.16.0.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.16; Thu, 22 Dec
 2022 09:50:15 +0800
Received: from EX2016A.msi.com.tw ([fe80::111c:1b9e:5379:1011]) by
 EX2016A.msi.com.tw ([fe80::111c:1b9e:5379:1011%10]) with mapi id
 15.01.2507.016; Thu, 22 Dec 2022 09:50:15 +0800
From:   =?big5?B?am9ld3Uop2Sl8q62KQ==?= <joewu@msi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Wu <joewu@msi.corp-partner.google.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "Dustin L . Howett" <dustin@howett.net>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Derek Huang <derekhuang@google.com>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: RE: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Thread-Topic: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Thread-Index: AQHZFEmW7so/oHWwyUambKy505rGua53bQ4AgAG5gJA=
Date:   Thu, 22 Dec 2022 01:50:15 +0000
Message-ID: <6fa20adbcc4b43f4947a52d50083eedc@msi.com>
References: <20221220080226.17904-1-joewu@msi.corp-partner.google.com>
 <Y6K1sjCTM2Z6d4iU@kroah.com>
In-Reply-To: <Y6K1sjCTM2Z6d4iU@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.252.125]
Content-Type: text/plain;
        charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-RCPT: <gregkh@linuxfoundation.org>, <joewu@msi.corp-partner.google.com>, <linux-kernel@vger.kernel.org>, <tzungbi@kernel.org>, <dustin@howett.net>, <bleung@chromium.org>, <dmitry.torokhov@gmail.com>, <wangxiang@cdjrlc.com>, <linux-input@vger.kernel.org>, <pmalani@chromium.org>, <swboyd@chromium.org>, <dianders@chromium.org>, <dnojiri@chromium.org>, <furquan@chromium.org>, <gustavoars@kernel.org>, <derekhuang@google.com>, <chrome-platform@lists.linux.dev>, <groeck@chromium.org>, <Jonathan.Cameron@huawei.com>, <tinghan.shen@mediatek.com>
X-TM-AS-GCONF: 00
X-RCPT: <wangxiang@cdjrlc.com>, <bleung@chromium.org>, <dianders@chromium.org>, <dnojiri@chromium.org>, <furquan@chromium.org>, <groeck@chromium.org>, <pmalani@chromium.org>, <swboyd@chromium.org>, <dmitry.torokhov@gmail.com>, <derekhuang@google.com>, <dustin@howett.net>, <Jonathan.Cameron@huawei.com>, <gustavoars@kernel.org>, <tzungbi@kernel.org>, <gregkh@linuxfoundation.org>, <chrome-platform@lists.linux.dev>, <internal@maedb.msi.com>, <tinghan.shen@mediatek.com>, <joewu@msi.corp-partner.google.com>, <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KSSB3aWxsIGNvcnJlY3QgaXQuIFRoYW5rIHlvdSBmb3IgY29tbWVudHMuDQoN
CkpvZQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogR3JlZyBLcm9haC1IYXJ0
bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gDQpTZW50OiBXZWRuZXNkYXksIERlY2Vt
YmVyIDIxLCAyMDIyIDM6MjkgUE0NClRvOiBKb2UgV3UgPGpvZXd1QG1zaS5jb3JwLXBhcnRuZXIu
Z29vZ2xlLmNvbT4NCkNjOiBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgVHp1
bmctQmkgU2hpaCA8dHp1bmdiaUBrZXJuZWwub3JnPjsgRHVzdGluIEwgLiBIb3dldHQgPGR1c3Rp
bkBob3dldHQubmV0PjsgQmVuc29uIExldW5nIDxibGV1bmdAY2hyb21pdW0ub3JnPjsgRG1pdHJ5
IFRvcm9raG92IDxkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tPjsgWGlhbmcgd2FuZ3ggPHdhbmd4
aWFuZ0BjZGpybGMuY29tPjsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBQcmFzaGFudCBN
YWxhbmkgPHBtYWxhbmlAY2hyb21pdW0ub3JnPjsgU3RlcGhlbiBCb3lkIDxzd2JveWRAY2hyb21p
dW0ub3JnPjsgRG91Z2xhcyBBbmRlcnNvbiA8ZGlhbmRlcnNAY2hyb21pdW0ub3JnPjsgRGFpc3Vr
ZSBOb2ppcmkgPGRub2ppcmlAY2hyb21pdW0ub3JnPjsgRnVycXVhbiBTaGFpa2ggPGZ1cnF1YW5A
Y2hyb21pdW0ub3JnPjsgR3VzdGF2byBBIC4gUiAuIFNpbHZhIDxndXN0YXZvYXJzQGtlcm5lbC5v
cmc+OyBEZXJlayBIdWFuZyA8ZGVyZWtodWFuZ0Bnb29nbGUuY29tPjsgY2hyb21lLXBsYXRmb3Jt
QGxpc3RzLmxpbnV4LmRldjsgR3VlbnRlciBSb2VjayA8Z3JvZWNrQGNocm9taXVtLm9yZz47IEpv
bmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT47IFRpbmdoYW4gU2hl
biA8dGluZ2hhbi5zaGVuQG1lZGlhdGVrLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNyb3Nf
ZWNfa2V5YjogQWRkIDMgYnV0dG9ucyBmb3IgbW9uaXRvciBmdW5jdGlvbg0KDQpPbiBUdWUsIERl
YyAyMCwgMjAyMiBhdCAwNDowMjoyNlBNICswODAwLCBKb2UgV3Ugd3JvdGU6DQo+IEFkZCAzIGV4
dHJhIGJ1dHRvbnM6ICdicmlnaHRuZXNzIHVwJywgJ2JyaWdodG5lc3MgZG93bicNCj4gYW5kICdz
Y3JlZW4gbG9jaycgdG8gc3VwcG9ydCBtb25pdG9yIG1hbmlwdWxhdGluZyBmdW5jdGlvbi4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEpvZSBXdSA8am9ld3VAbXNpLmNvcnAtcGFydG5lci5nb29nbGUu
Y29tPg0KDQpOb3RlLCB0aGlzIGlzIGEgImZha2UiIGVtYWlsIGFkZHJlc3MsIHBsZWFzZSBhbHdh
eXMgdXNlIHlvdXIgcmVhbCBvbmUgYW5kIG5vdCBhIGdvb2dsZS1nZXJyaXQtYXNzaWduZWQgYWRk
cmVzcy4NCg0KdGhhbmtzLA0KDQpncmVnIGstaA0KDQoqKioqKkNPTkZJREVOVElBTCBJTkZPUk1B
VElPTioqKioqDQoNClRoaXMgZW1haWwgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHVzZSBvZiB0
aGUgcGVyc29uIG9yIGVudGl0eSB0byB3aG9tIGl0IGlzDQphZGRyZXNzZWQgYW5kIGNvbnRhaW5z
IGluZm9ybWF0aW9uIHRoYXQgbWF5IGJlIHN1YmplY3QgdG8gYW5kL29yIG1heSBiZQ0KcmVzdHJp
Y3RlZCBmcm9tIGRpc2Nsb3N1cmUgYnkgY29udHJhY3Qgb3IgYXBwbGljYWJsZSBsYXcuIElmIHlv
dSBhcmUgbm90IHRoZSANCmludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIGVtYWlsLCBiZSBhZHZp
c2VkIHRoYXQgYW55IGRpc2Nsb3N1cmUsIGNvcHksIA0KZGlzdHJpYnV0aW9uIG9yIHVzZSBvZiB0
aGUgY29udGVudHMgb2YgdGhpcyBtZXNzYWdlIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIA0KSWYg
eW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIGVtYWlsLCBwbGVhc2Ug
bm90aWZ5IHRoZSBzZW5kZXIgDQp0aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgaW4gZXJyb3Ig
YnkgcmVwbHlpbmcgdG8gdGhpcyBtZXNzYWdlLiBUaGVuLCANCnBsZWFzZSBkZWxldGUgaXQgZnJv
bSB5b3VyIHN5c3RlbS4gT3VyIFByaXZhY3kgUG9saWN5IGlzIGF2YWlsYWJsZSBoZXJlIA0KaHR0
cHM6Ly93d3cubXNpLmNvbS9wYWdlL3ByaXZhY3ktcG9saWN5LiBUaGFuayB5b3Uu

