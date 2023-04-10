Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCE06DC304
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 05:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDJDrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 23:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDJDrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 23:47:01 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A2B6E68;
        Sun,  9 Apr 2023 20:46:57 -0700 (PDT)
Received: from void0red$hust.edu.cn ( [172.16.0.254] ) by ajax-webmail-app1
 (Coremail) ; Mon, 10 Apr 2023 11:46:17 +0800 (GMT+08:00)
X-Originating-IP: [172.16.0.254]
Date:   Mon, 10 Apr 2023 11:46:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5bq3?= <void0red@hust.edu.cn>
To:     daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, daniel@makrotopia.org, dzm91@hust.edu.cn,
        error27@gmail.com, henry.yen@mediatek.com,
        hust-os-kernel-patches@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        matthias.bgg@gmail.com, rafael@kernel.org, rdunlap@infradead.org,
        rui.zhang@intel.com, void0red@gmail.com
Subject: Re: [PATCH v2 2/2] thermal: mediatek: change clk_prepare_enable to
 devm_clk_get_enabled in mtk_thermal_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2023 www.mailtech.cn hust
In-Reply-To: <20230403164610.3608082-2-void0red@hust.edu.cn>
References: <6e3c59c3-8ad0-9c53-62a4-7be6f55a7c02@linaro.org>
 <20230403164610.3608082-1-void0red@hust.edu.cn>
 <20230403164610.3608082-2-void0red@hust.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7b1f01ae.3988f.18769458aaf.Coremail.void0red@hust.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: FgEQrAAHVwiJhjNk0EdOAg--.33659W
X-CM-SenderInfo: rpsqjiaxrxjmo6kx23oohg3hdfq/1tbiAQoOAl7Em44HSQACsE
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiS2FuZyBDaGVuIiA8dm9p
ZDByZWRAaHVzdC5lZHUuY24+Cj4g5Y+R6YCB5pe26Ze0OiAyMDIzLTA0LTA0IDAwOjQ2OjEwICjm
mJ/mnJ/kuowpCj4g5pS25Lu25Lq6OiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnCj4g5oqE6YCB
OiBhbWl0a0BrZXJuZWwub3JnLCBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5j
b20sIGJjaGloaUBiYXlsaWJyZS5jb20sIGRhbmllbEBtYWtyb3RvcGlhLm9yZywgZHptOTFAaHVz
dC5lZHUuY24sIGVycm9yMjdAZ21haWwuY29tLCBoZW5yeS55ZW5AbWVkaWF0ZWsuY29tLCBodXN0
LW9zLWtlcm5lbC1wYXRjaGVzQGdvb2dsZWdyb3Vwcy5jb20sIGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgbGludXgtbWVk
aWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZywgbGludXgtcG1Admdlci5rZXJuZWwub3JnLCBtYXR0
aGlhcy5iZ2dAZ21haWwuY29tLCByYWZhZWxAa2VybmVsLm9yZywgcmR1bmxhcEBpbmZyYWRlYWQu
b3JnLCBydWkuemhhbmdAaW50ZWwuY29tLCB2b2lkMHJlZEBnbWFpbC5jb20sIHZvaWQwcmVkQGh1
c3QuZWR1LmNuCj4g5Li76aKYOiBbUEFUQ0ggdjIgMi8yXSB0aGVybWFsOiBtZWRpYXRlazogY2hh
bmdlIGNsa19wcmVwYXJlX2VuYWJsZSB0byBkZXZtX2Nsa19nZXRfZW5hYmxlZCBpbiBtdGtfdGhl
cm1hbF9wcm9iZQo+IAo+IHVzZSBkZXZtX2Nsa19nZXRfZW5hYmxlZCB0byBkbyBhdXRvbWF0aWMg
cmVzb3VyY2UgbWFuYWdlbWVudC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBLYW5nIENoZW4gPHZvaWQw
cmVkQGh1c3QuZWR1LmNuPgo+IC0tLQo+IEknbSBub3QgcXVpdGUgc3VyZSBpZiB0aGlzIGZ1bmN0
aW9uIHNob3VsZCByZXR1cm4gMCB3aGVuCj4gZGV2bV90aGVybWFsX2FkZF9od21vbl9zeXNmcyBv
Y2N1cnMgZXJyb3IuIFNvIEkga2VlcCBpdC4KPiAKPiAgZHJpdmVycy90aGVybWFsL21lZGlhdGVr
L2F1eGFkY190aGVybWFsLmMgfCAyNSArKysrKysrKy0tLS0tLS0tLS0tLS0tLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy90aGVybWFsL21lZGlhdGVrL2F1eGFkY190aGVybWFsLmMgYi9kcml2ZXJzL3Ro
ZXJtYWwvbWVkaWF0ZWsvYXV4YWRjX3RoZXJtYWwuYwo+IGluZGV4IGRmNWUyZTM1NDQwOC4uNWJh
ZWMyYzA4ZWJjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9tZWRpYXRlay9hdXhhZGNf
dGhlcm1hbC5jCj4gKysrIGIvZHJpdmVycy90aGVybWFsL21lZGlhdGVrL2F1eGFkY190aGVybWFs
LmMKPiBAQCAtMTE3OCwxNiArMTE3OCwxNiBAQCBzdGF0aWMgaW50IG10a190aGVybWFsX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIAlpZiAocmV0KQo+ICAJCXJldHVybiBy
ZXQ7Cj4gIAo+IC0JcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKG10LT5jbGtfYXV4YWRjKTsKPiAt
CWlmIChyZXQpIHsKPiArCXJldCA9IGRldm1fY2xrX2dldF9lbmFibGVkKCZwZGV2LT5kZXYsIG10
LT5jbGtfYXV4YWRjKTsKPiArCWlmIChJU19FUlIocmV0KSkgewo+ICAJCWRldl9lcnIoJnBkZXYt
PmRldiwgIkNhbid0IGVuYWJsZSBhdXhhZGMgY2xrOiAlZFxuIiwgcmV0KTsKPiAtCQlyZXR1cm4g
cmV0Owo+ICsJCXJldHVybiBQVFJfRVJSKHJldCk7Cj4gIAl9Cj4gIAo+IC0JcmV0ID0gY2xrX3By
ZXBhcmVfZW5hYmxlKG10LT5jbGtfcGVyaV90aGVybSk7Cj4gLQlpZiAocmV0KSB7Cj4gKwlyZXQg
PSBkZXZtX2Nsa19nZXRfZW5hYmxlZCgmcGRldi0+ZGV2LCBtdC0+Y2xrX3BlcmlfdGhlcm0pOwo+
ICsJaWYgKElTX0VSUihyZXQpKSB7Cj4gIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ2FuJ3QgZW5h
YmxlIHBlcmkgY2xrOiAlZFxuIiwgcmV0KTsKPiAtCQlnb3RvIGVycl9kaXNhYmxlX2Nsa19hdXhh
ZGM7Cj4gKwkJcmV0dXJuIFBUUl9FUlIocmV0KTsKPiAgCX0KPiAgCj4gIAlpZiAobXQtPmNvbmYt
PnZlcnNpb24gIT0gTVRLX1RIRVJNQUxfVjEpIHsKPiBAQCAtMTIxMSwyMyArMTIxMSwxNCBAQCBz
dGF0aWMgaW50IG10a190aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
Cj4gIAo+ICAJdHpkZXYgPSBkZXZtX3RoZXJtYWxfb2Zfem9uZV9yZWdpc3RlcigmcGRldi0+ZGV2
LCAwLCBtdCwKPiAgCQkJCQkgICAgICAmbXRrX3RoZXJtYWxfb3BzKTsKPiAtCWlmIChJU19FUlIo
dHpkZXYpKSB7Cj4gLQkJcmV0ID0gUFRSX0VSUih0emRldik7Cj4gLQkJZ290byBlcnJfZGlzYWJs
ZV9jbGtfcGVyaV90aGVybTsKPiAtCX0KPiArCWlmIChJU19FUlIodHpkZXYpKQo+ICsJCXJldHVy
biBQVFJfRVJSKHR6ZGV2KTsKPiAgCj4gIAlyZXQgPSBkZXZtX3RoZXJtYWxfYWRkX2h3bW9uX3N5
c2ZzKHR6ZGV2KTsKPiAgCWlmIChyZXQpCj4gIAkJZGV2X3dhcm4oJnBkZXYtPmRldiwgImVycm9y
IGluIHRoZXJtYWxfYWRkX2h3bW9uX3N5c2ZzIik7Cj4gIAo+ICAJcmV0dXJuIDA7Cj4gLQo+IC1l
cnJfZGlzYWJsZV9jbGtfcGVyaV90aGVybToKPiAtCWNsa19kaXNhYmxlX3VucHJlcGFyZShtdC0+
Y2xrX3BlcmlfdGhlcm0pOwo+IC1lcnJfZGlzYWJsZV9jbGtfYXV4YWRjOgo+IC0JY2xrX2Rpc2Fi
bGVfdW5wcmVwYXJlKG10LT5jbGtfYXV4YWRjKTsKPiAtCj4gLQlyZXR1cm4gcmV0Owo+ICB9Cj4g
IAo+ICBzdGF0aWMgaW50IG10a190aGVybWFsX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQo+IC0tIAo+IDIuMzQuMQoKcGluZz8K
