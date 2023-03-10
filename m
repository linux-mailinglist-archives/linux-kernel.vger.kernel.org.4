Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFB66B3B10
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCJJn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjCJJmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:42:47 -0500
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CD87F740;
        Fri, 10 Mar 2023 01:42:15 -0800 (PST)
Received: from dzm91$hust.edu.cn ( [172.16.0.254] ) by ajax-webmail-app2
 (Coremail) ; Fri, 10 Mar 2023 17:41:24 +0800 (GMT+08:00)
X-Originating-IP: [172.16.0.254]
Date:   Fri, 10 Mar 2023 17:41:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <dzm91@hust.edu.cn>
To:     claudiu.beznea@microchip.com
Cc:     chengziqiu@hust.edu.cn, eugen.hristev@collabora.com,
        jic23@kernel.org, lars@metafoo.de, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] drivers: iio: remove dead code in at91_adc_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2023 www.mailtech.cn hust
In-Reply-To: <cc97cfe5-e90a-d901-147a-2bb829a4409d@microchip.com>
References: <20230309150502.400312-1-chengziqiu@hust.edu.cn>
 <cc97cfe5-e90a-d901-147a-2bb829a4409d@microchip.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <774cfa3a.25898.186cae584b7.Coremail.dzm91@hust.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GQEQrAAHDeFE+wpk9GySAQ--.23967W
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/1tbiAQkGD17Em4RsRgACss
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiBDbGF1ZGl1LkJlem5lYUBt
aWNyb2NoaXAuY29tCj4g5Y+R6YCB5pe26Ze0OiAyMDIzLTAzLTEwIDE3OjE0OjU2ICjmmJ/mnJ/k
upQpCj4g5pS25Lu25Lq6OiBjaGVuZ3ppcWl1QGh1c3QuZWR1LmNuLCBldWdlbi5ocmlzdGV2QGNv
bGxhYm9yYS5jb20sIGppYzIzQGtlcm5lbC5vcmcsIGxhcnNAbWV0YWZvby5kZSwgTmljb2xhcy5G
ZXJyZUBtaWNyb2NoaXAuY29tLCBhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbQo+IOaKhOmA
gTogZHptOTFAaHVzdC5lZHUuY24sIGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zwo+IOS4u+mimDogUmU6IFtQQVRDSF0gZHJpdmVyczogaWlvOiByZW1vdmUgZGVhZCBjb2RlIGlu
IGF0OTFfYWRjX3Byb2JlCj4gCj4gT24gMDkuMDMuMjAyMyAxNzowNSwgQ2hlbmcgWmlxaXUgd3Jv
dGU6Cj4gPj5Gcm9tIHRoZSBjb21tZW50IG9mIHBsYXRmb3JtX2dldF9pcnEsIGl0IG9ubHkgcmV0
dXJucyBub24temVybyBJUlEKPiA+IG51bWJlciBhbmQgbmVnYXRpdmUgZXJyb3IgbnVtYmVyLCBv
dGhlciB0aGFuIHplcm8uCj4gPiAKPiA+IEZpeCB0aGlzIGJ5IHJlbW92aW5nIHRoZSBpZiBjb25k
aXRpb24uCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IENoZW5nIFppcWl1IDxjaGVuZ3ppcWl1QGh1
c3QuZWR1LmNuPgo+IAo+IEkgc2VlIEZyb20gYW5kIDFzdCBTb0IgbWF0Y2hlcyBidXQKPiAKPiA+
IFNpZ25lZC1vZmYtYnk6IERvbmdsaWFuZyBNdSA8ZHptOTFAaHVzdC5lZHUuY24+Cj4gCj4gdGhp
cyBTb0Igc2VlbXMgZXh0cmEuIFdoYXQgaXMgdGhlIGNvbnRyaWJ1dGlvbiBvZiBEb25nbGlhbmcg
TXUgdG8gdGhpcyBwYXRjaD8KCkkgcmV2aWV3ZWQgdGhpcyBwYXRjaCBsb2NhbGx5IHNpbmNlIHRo
aXMgc3R1ZGVudCBpcyB0aGUgZmlyc3QgdGltZSB0byBzdWJtaXQgcGF0Y2ggdG8gdGhlIGtlcm5l
bCBtYWlsaW5nIGxpc3QuCgpJbiBteSBsYWIsIEkgZW5jb3VyYWdlIGFsbCBzdHVkZW50cyB0byBm
aXgga2VybmVsIGlzc3Vlcy4gSG93ZXZlciwgdGhlaXIgcGF0Y2hlcyBzaG91bGQgYmUgcmV2aWV3
ZWQgYnkgbWUgZmlyc3QgYmVmb3JlIHNlbmRpbmcgdGhlIG1haWxpbmcgbGlzdC4KCj4gCj4gPiAt
LS0KPiA+ICBkcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIHwgNiArLS0tLS0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDUgZGVsZXRpb25zKC0pCj4gPiAKPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIGIvZHJpdmVy
cy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYwo+ID4gaW5kZXggNTBkMDJlNWZjNmZjLi4xNjgz
OTkwOTI1OTAgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2Fk
Yy5jCj4gPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jCj4gPiBAQCAt
MjQwMCwxMiArMjQwMCw4IEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikKPiA+ICAgICAgICAgc3QtPmRtYV9zdC5waHlzX2FkZHIgPSByZXMt
PnN0YXJ0Owo+ID4gCj4gPiAgICAgICAgIHN0LT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYs
IDApOwo+ID4gLSAgICAgICBpZiAoc3QtPmlycSA8PSAwKSB7Cj4gPiAtICAgICAgICAgICAgICAg
aWYgKCFzdC0+aXJxKQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgc3QtPmlycSA9IC1FTlhJ
TzsKPiA+IC0KPiA+ICsgICAgICAgaWYgKHN0LT5pcnEgPCAwKQo+ID4gICAgICAgICAgICAgICAg
IHJldHVybiBzdC0+aXJxOwo+ID4gLSAgICAgICB9Cj4gPiAKPiA+ICAgICAgICAgc3QtPnBlcl9j
bGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgImFkY19jbGsiKTsKPiA+ICAgICAgICAgaWYg
KElTX0VSUihzdC0+cGVyX2NsaykpCj4gPiAtLQo+ID4gMi4zNC4xCj4gPiAKPiAKCgotLQpCZXN0
IHJlZ2FyZHMsCkRvbmdsaWFuZyBNdQo=
