Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B440B6E2F6B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 09:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjDOHQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 03:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDOHQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 03:16:15 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E956D5243;
        Sat, 15 Apr 2023 00:16:13 -0700 (PDT)
Received: from void0red$hust.edu.cn ( [172.16.0.254] ) by ajax-webmail-app2
 (Coremail) ; Sat, 15 Apr 2023 15:14:35 +0800 (GMT+08:00)
X-Originating-IP: [172.16.0.254]
Date:   Sat, 15 Apr 2023 15:14:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   void0red@hust.edu.cn
To:     daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, daniel@makrotopia.org, dzm91@hust.edu.cn,
        error27@gmail.com, henry.yen@mediatek.com,
        hust-os-kernel-patches@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        matthias.bgg@gmail.com, rafael@kernel.org, rdunlap@infradead.org,
        rui.zhang@intel.com, void0red@gmail.com
Subject: Re: [PATCH v3 2/2] thermal: mediatek: change clk_prepare_enable to
 devm_clk_get_enabled in mtk_thermal_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2023 www.mailtech.cn hust
In-Reply-To: <20230411063531.3976354-2-void0red@hust.edu.cn>
References: <b2e5ef14-9a12-15d5-8016-d0994c1177c3@linaro.org>
 <20230411063531.3976354-1-void0red@hust.edu.cn>
 <20230411063531.3976354-2-void0red@hust.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4fed91ef.3c256.18783c407e3.Coremail.void0red@hust.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: GQEQrABnSU7bTjpkkInBAg--.44137W
X-CM-SenderInfo: rpsqjiaxrxjmo6kx23oohg3hdfq/1tbiAQsBAl7Em5Ce0gABsV
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiS2FuZyBDaGVuIiA8dm9p
ZDByZWRAaHVzdC5lZHUuY24+Cj4gU2VudCBUaW1lOiAyMDIzLTA0LTExIDE0OjM1OjMxIChUdWVz
ZGF5KQo+IFRvOiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnCj4gQ2M6IGFtaXRrQGtlcm5lbC5v
cmcsIGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbSwgYmNoaWhpQGJheWxp
YnJlLmNvbSwgZGFuaWVsQG1ha3JvdG9waWEub3JnLCBkem05MUBodXN0LmVkdS5jbiwgZXJyb3Iy
N0BnbWFpbC5jb20sIGhlbnJ5LnllbkBtZWRpYXRlay5jb20sIGh1c3Qtb3Mta2VybmVsLXBhdGNo
ZXNAZ29vZ2xlZ3JvdXBzLmNvbSwgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
LCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZy
YWRlYWQub3JnLCBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcsIG1hdHRoaWFzLmJnZ0BnbWFpbC5j
b20sIHJhZmFlbEBrZXJuZWwub3JnLCByZHVubGFwQGluZnJhZGVhZC5vcmcsIHJ1aS56aGFuZ0Bp
bnRlbC5jb20sIHZvaWQwcmVkQGdtYWlsLmNvbSwgdm9pZDByZWRAaHVzdC5lZHUuY24KPiBTdWJq
ZWN0OiBbUEFUQ0ggdjMgMi8yXSB0aGVybWFsOiBtZWRpYXRlazogY2hhbmdlIGNsa19wcmVwYXJl
X2VuYWJsZSB0byBkZXZtX2Nsa19nZXRfZW5hYmxlZCBpbiBtdGtfdGhlcm1hbF9wcm9iZQo+IAo+
IHVzZSBkZXZtX2Nsa19nZXRfZW5hYmxlZCB0byBkbyBhdXRvbWF0aWMgcmVzb3VyY2UgbWFuYWdl
bWVudC4KPiBNZWFud2hpbGUsIHJlbW92ZSBlcnJvciBoYW5kbGluZyBsYWJlbHMgaW4gdGhlIHBy
b2JlIGZ1bmN0aW9uIGFuZAo+IHRoZSB3aG9sZSByZW1vdmUgZnVuY3Rpb24uCj4gCj4gU2lnbmVk
LW9mZi1ieTogS2FuZyBDaGVuIDx2b2lkMHJlZEBodXN0LmVkdS5jbj4KPiBSZXZpZXdlZC1ieTog
RG9uZ2xpYW5nIE11IDxkem05MUBodXN0LmVkdS5jbj4KPiAtLS0KPiB2MyAtPiB2MjogcmVtb3Zl
IHNvbWUgdXNlbGVzIGZ1bmMgY2FsbHMuCj4gdjIgLT4gdjE6IGluaXQKPiAKPiBOb3RpY2UgdGhl
IGRldm1fY2xrX2dldF9lbmFibGVkIGRvIHRoZSBjbGtfZ2V0IGFuZCBjbGtfcHJlcGFyZV9lbmFi
bGUKPiBhdCB0aGUgc2FtZSB0aW1lLgo+IEknbSBub3Qgc3VyZSBpZiB0aGlzIGhhcyBhbnkgc2lk
ZSBlZmZlY3RzIGluIGluaXRpYWxpemF0aW9uLgo+IAo+ICBkcml2ZXJzL3RoZXJtYWwvbWVkaWF0
ZWsvYXV4YWRjX3RoZXJtYWwuYyB8IDQ4ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy90aGVybWFsL21lZGlhdGVrL2F1eGFkY190aGVybWFsLmMgYi9kcml2ZXJz
L3RoZXJtYWwvbWVkaWF0ZWsvYXV4YWRjX3RoZXJtYWwuYwo+IGluZGV4IDMzNzJmN2MyOTYyNi4u
OTk1ODM3Y2UzZWEyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9tZWRpYXRlay9hdXhh
ZGNfdGhlcm1hbC5jCj4gKysrIGIvZHJpdmVycy90aGVybWFsL21lZGlhdGVrL2F1eGFkY190aGVy
bWFsLmMKPiBAQCAtMTExNiwxNCArMTExNiw2IEBAIHN0YXRpYyBpbnQgbXRrX3RoZXJtYWxfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgCj4gIAltdC0+Y29uZiA9IG9mX2Rl
dmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsKPiAgCj4gLQltdC0+Y2xrX3BlcmlfdGhl
cm0gPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgInRoZXJtIik7Cj4gLQlpZiAoSVNfRVJSKG10
LT5jbGtfcGVyaV90aGVybSkpCj4gLQkJcmV0dXJuIFBUUl9FUlIobXQtPmNsa19wZXJpX3RoZXJt
KTsKPiAtCj4gLQltdC0+Y2xrX2F1eGFkYyA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAiYXV4
YWRjIik7Cj4gLQlpZiAoSVNfRVJSKG10LT5jbGtfYXV4YWRjKSkKPiAtCQlyZXR1cm4gUFRSX0VS
UihtdC0+Y2xrX2F1eGFkYyk7Cj4gLQo+ICAJbXQtPnRoZXJtYWxfYmFzZSA9IGRldm1fcGxhdGZv
cm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAsIE5VTEwpOwo+ICAJaWYgKElTX0VS
UihtdC0+dGhlcm1hbF9iYXNlKSkKPiAgCQlyZXR1cm4gUFRSX0VSUihtdC0+dGhlcm1hbF9iYXNl
KTsKPiBAQCAtMTE4MiwxNiArMTE3NCwxNiBAQCBzdGF0aWMgaW50IG10a190aGVybWFsX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIAlpZiAocmV0KQo+ICAJCXJldHVybiBy
ZXQ7Cj4gIAo+IC0JcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKG10LT5jbGtfYXV4YWRjKTsKPiAt
CWlmIChyZXQpIHsKPiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDYW4ndCBlbmFibGUgYXV4YWRj
IGNsazogJWRcbiIsIHJldCk7Cj4gLQkJcmV0dXJuIHJldDsKPiArCW10LT5jbGtfYXV4YWRjID0g
ZGV2bV9jbGtfZ2V0X2VuYWJsZWQoJnBkZXYtPmRldiwgImF1eGFkYyIpOwo+ICsJaWYgKElTX0VS
UihtdC0+Y2xrX2F1eGFkYykpIHsKPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDYW4ndCBlbmFi
bGUgYXV4YWRjIGNsazogJWRcbiIsIG10LT5jbGtfYXV4YWRjKTsKPiArCQlyZXR1cm4gUFRSX0VS
UihtdC0+Y2xrX2F1eGFkYyk7Cj4gIAl9Cj4gIAo+IC0JcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxl
KG10LT5jbGtfcGVyaV90aGVybSk7Cj4gLQlpZiAocmV0KSB7Cj4gLQkJZGV2X2VycigmcGRldi0+
ZGV2LCAiQ2FuJ3QgZW5hYmxlIHBlcmkgY2xrOiAlZFxuIiwgcmV0KTsKPiAtCQlnb3RvIGVycl9k
aXNhYmxlX2Nsa19hdXhhZGM7Cj4gKwltdC0+Y2xrX3BlcmlfdGhlcm0gPSBkZXZtX2Nsa19nZXRf
ZW5hYmxlZCgmcGRldi0+ZGV2LCAidGhlcm0iKTsKPiArCWlmIChJU19FUlIobXQtPmNsa19wZXJp
X3RoZXJtKSkgewo+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIkNhbid0IGVuYWJsZSBwZXJpIGNs
azogJWRcbiIsIG10LT5jbGtfcGVyaV90aGVybSk7Cj4gKwkJcmV0dXJuIFBUUl9FUlIobXQtPmNs
a19wZXJpX3RoZXJtKTsKPiAgCX0KPiAgCj4gIAlpZiAobXQtPmNvbmYtPnZlcnNpb24gIT0gTVRL
X1RIRVJNQUxfVjEpIHsKPiBAQCAtMTIxNSwzOCArMTIwNywxOCBAQCBzdGF0aWMgaW50IG10a190
aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIAo+ICAJdHpkZXYg
PSBkZXZtX3RoZXJtYWxfb2Zfem9uZV9yZWdpc3RlcigmcGRldi0+ZGV2LCAwLCBtdCwKPiAgCQkJ
CQkgICAgICAmbXRrX3RoZXJtYWxfb3BzKTsKPiAtCWlmIChJU19FUlIodHpkZXYpKSB7Cj4gLQkJ
cmV0ID0gUFRSX0VSUih0emRldik7Cj4gLQkJZ290byBlcnJfZGlzYWJsZV9jbGtfcGVyaV90aGVy
bTsKPiAtCX0KPiArCWlmIChJU19FUlIodHpkZXYpKQo+ICsJCXJldHVybiBQVFJfRVJSKHR6ZGV2
KTsKPiAgCj4gIAlyZXQgPSBkZXZtX3RoZXJtYWxfYWRkX2h3bW9uX3N5c2ZzKHR6ZGV2KTsKPiAg
CWlmIChyZXQpCj4gIAkJZGV2X3dhcm4oJnBkZXYtPmRldiwgImVycm9yIGluIHRoZXJtYWxfYWRk
X2h3bW9uX3N5c2ZzIik7Cj4gIAo+ICAJcmV0dXJuIDA7Cj4gLQo+IC1lcnJfZGlzYWJsZV9jbGtf
cGVyaV90aGVybToKPiAtCWNsa19kaXNhYmxlX3VucHJlcGFyZShtdC0+Y2xrX3BlcmlfdGhlcm0p
Owo+IC1lcnJfZGlzYWJsZV9jbGtfYXV4YWRjOgo+IC0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKG10
LT5jbGtfYXV4YWRjKTsKPiAtCj4gLQlyZXR1cm4gcmV0Owo+IC19Cj4gLQo+IC1zdGF0aWMgaW50
IG10a190aGVybWFsX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+IC17Cj4g
LQlzdHJ1Y3QgbXRrX3RoZXJtYWwgKm10ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7Cj4g
LQo+IC0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKG10LT5jbGtfcGVyaV90aGVybSk7Cj4gLQljbGtf
ZGlzYWJsZV91bnByZXBhcmUobXQtPmNsa19hdXhhZGMpOwo+IC0KPiAtCXJldHVybiAwOwo+ICB9
Cj4gIAo+ICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfdGhlcm1hbF9kcml2ZXIg
PSB7Cj4gIAkucHJvYmUgPSBtdGtfdGhlcm1hbF9wcm9iZSwKPiAtCS5yZW1vdmUgPSBtdGtfdGhl
cm1hbF9yZW1vdmUsCj4gIAkuZHJpdmVyID0gewo+ICAJCS5uYW1lID0gIm10ay10aGVybWFsIiwK
PiAgCQkub2ZfbWF0Y2hfdGFibGUgPSBtdGtfdGhlcm1hbF9vZl9tYXRjaCwKPiAtLSAKPiAyLjM0
LjEKCnBpbmc/Cg==
