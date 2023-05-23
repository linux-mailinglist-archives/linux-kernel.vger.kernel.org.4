Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF20070E47D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjEWSUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEWSUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:20:46 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 11:20:43 PDT
Received: from mg.sunplus.com (unknown [113.196.136.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74151E5;
        Tue, 23 May 2023 11:20:43 -0700 (PDT)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(23310:0:AUTH_RELAY)
        (envelope-from <wells.lu@sunplus.com>); Wed, 24 May 2023 01:39:50 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.47; Wed, 24 May 2023 01:39:51 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::b840:bb05:862c:855c]) by
 sphcmbx02.sunplus.com.tw ([fe80::15f8:1252:3f23:8595%12]) with mapi id
 15.00.1497.047; Wed, 24 May 2023 01:39:51 +0800
From:   =?big5?B?V2VsbHMgTHUgp2aq2sTL?= <wells.lu@sunplus.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Wells Lu <wellslutw@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pinctrl:sunplus: Add check for kmalloc
Thread-Topic: [PATCH] pinctrl:sunplus: Add check for kmalloc
Thread-Index: AQHZjZWky9lKVU39LE6VqnWnQX/Sxa9oG1MQ
Date:   Tue, 23 May 2023 17:39:51 +0000
Message-ID: <1560e9c0e5154802ab020b9da846d65f@sphcmbx02.sunplus.com.tw>
References: <1684836688-9204-1-git-send-email-wellslutw@gmail.com>
 <ZGztCHNr1jmpFq0A@surfacebook>
In-Reply-To: <ZGztCHNr1jmpFq0A@surfacebook>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.39]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEZpeCBTbWF0Y2ggc3RhdGljIGNoZWNrZXIgd2FybmluZzoNCj4gPiBwb3RlbnRpYWwgbnVs
bCBkZXJlZmVyZW5jZSAnY29uZmlncycuIChrbWFsbG9jIHJldHVybnMgbnVsbCkNCj4gDQo+IC4u
Lg0KPiANCj4gPiAgCQkJY29uZmlncyA9IGttYWxsb2Moc2l6ZW9mKCpjb25maWdzKSwgR0ZQX0tF
Uk5FTCk7DQo+ID4gKwkJCWlmICghY29uZmlncykNCj4gDQo+ID4gKwkJCQlyZXR1cm4gLUVOT01F
TTsNCj4gDQo+ICJGaXhpbmciIGJ5IGFkZGluZyBhIG1lbW9yeSBsZWFrIGlzIG5vdCBwcm9iYWJs
eSBhIGdvb2QgYXBwcm9hY2guDQoNCkRvIHlvdSBtZWFuIEkgbmVlZCB0byBmcmVlIGFsbCBtZW1v
cnkgd2hpY2ggYXJlIGFsbG9jYXRlZCBpbiB0aGlzIHN1YnJvdXRpbmUgYmVmb3JlDQpyZXR1cm4g
LUVOT01FTT8NCg0KDQo+IC4uLg0KPiANCj4gPiAgCQkJY29uZmlncyA9IGttYWxsb2Moc2l6ZW9m
KCpjb25maWdzKSwgR0ZQX0tFUk5FTCk7DQo+ID4gKwkJCWlmICghY29uZmlncykNCj4gPiArCQkJ
CXJldHVybiAtRU5PTUVNOw0KPiANCj4gRGl0dG8uDQo+IA0KPiAuLi4NCj4gDQo+IEl0IG1pZ2h0
IGJlIHRoYXQgSSdtIG1pc3Rha2VuLiBJbiB0aGlzIGNhc2UgcGxlYXNlIGFkZCBhbiBleHBsYW5h
dGlvbiB3aHkgaW4gdGhlIGNvbW1pdA0KPiBtZXNzYWdlLg0KPiANCj4gLS0NCj4gV2l0aCBCZXN0
IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KPiANCg0KDQpCZXN0IHJlZ2FyZHMsDQpXZWxs
cyBMdQ0K
