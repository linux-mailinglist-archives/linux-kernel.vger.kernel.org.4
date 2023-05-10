Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB656FD99D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbjEJIjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjEJIir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:38:47 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA2771BD;
        Wed, 10 May 2023 01:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=YYSr3I8/gWPxzbmgurMpSucILS/vqoM9VSmPYgZQ2q8=; b=G
        kQLKlgKhJZodGLR1njoog5H8MtWV7yE/Ok4tT11+hGpswhTydK+wbhTi8s2TKez+
        7fIMCPlkW1uvR5alEJ7z/VQqpZ94j3JQhGVJuYAfxu8u6IOak3/UQquNWR4BDP1S
        LZHQ+9ajlA2r6oM8s8caMVgNjRLFofB+9VZBqb92VE=
Received: from wangyouwan$126.com ( [103.163.180.46] ) by
 ajax-webmail-wmsvr24 (Coremail) ; Wed, 10 May 2023 15:51:12 +0800 (CST)
X-Originating-IP: [103.163.180.46]
Date:   Wed, 10 May 2023 15:51:12 +0800 (CST)
From:   wangyouwan <wangyouwan@126.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] cpufreq: create cooling device based on ACPI
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 126com
In-Reply-To: <CAJZ5v0jT0tiwQtTpg-YeptVYq_t80o0nW3O7d9OBDmAxdv8=Dw@mail.gmail.com>
References: <20230428070314.225560-1-wangyouwan@126.com>
 <CAJZ5v0jT0tiwQtTpg-YeptVYq_t80o0nW3O7d9OBDmAxdv8=Dw@mail.gmail.com>
X-NTES-SC: AL_QuyTAfubukgs5CSbZukXm00ahOY2W8K4svsj3YBSPZk0kSnV5AEqZGZFMnnM+s+CJAO3qQGobDN/7MdnZ4tDc5wUhksREZUX7b5YiJj+yoTU
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2225e42.53da.18804a48b33.Coremail.wangyouwan@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowAB3h8_xTFtkHjcaAA--.23197W
X-CM-SenderInfo: 5zdqw5prxzt0a6rslhhfrp/1tbiuBlpFWJVmu56IAACsG
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9rYXksIHRoYW5rIHlvdSBmb3IgdGhlIHJlbWluZGVyISAKSWYgSSBtYWtlIHRoaXMgY2hhbmdl
LCBJJ20gbm90IHN1cmUgaWYgaXQgd2lsbCB3b3JrLiBJZiBpdCBkb2VzLCBJJ2xsIHN1Ym1pdCBh
IG5ldyBwYXRjaC4KCi0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMKKysrIGIvZHJpdmVy
cy9jcHVmcmVxL2NwdWZyZXEuYwpAQCAtMTQ5NCw4ICsxNDk0LDEzIEBAIHN0YXRpYyBpbnQgY3B1
ZnJlcV9vbmxpbmUodW5zaWduZWQgaW50IGNwdSkKwqDCoMKgwqDCoMKgwqAgaWYgKGNwdWZyZXFf
ZHJpdmVyLT5yZWFkeSkKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdWZyZXFfZHJp
dmVyLT5yZWFkeShwb2xpY3kpOwrCoAotwqDCoMKgwqDCoMKgIGlmIChjcHVmcmVxX3RoZXJtYWxf
Y29udHJvbF9lbmFibGVkKGNwdWZyZXFfZHJpdmVyKSkKLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcG9saWN5LT5jZGV2ID0gb2ZfY3B1ZnJlcV9jb29saW5nX3JlZ2lzdGVyKHBvbGljeSk7
CivCoMKgwqDCoMKgwqAgaWYgKGNwdWZyZXFfdGhlcm1hbF9jb250cm9sX2VuYWJsZWQoY3B1ZnJl
cV9kcml2ZXIpKSB7CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnAgPSBvZl9nZXRfY3B1X25vZGUocG9saWN5LT5jcHUsIE5VTEwpOworwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobnApCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBwb2xpY3ktPmNkZXYgPSBvZl9jcHVmcmVxX2Nvb2xpbmdfcmVnaXN0
ZXIocG9saWN5KTsKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZQorwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG9saWN5LT5jZGV2ID0gY3B1ZnJl
cV9jb29saW5nX3JlZ2lzdGVyKHBvbGljeSk7CgorwqDCoMKgwqDCoMKgIH0KCgoKCgoKCgoKCgoK
CkF0IDIwMjMtMDQtMjggMTk6Mzc6MjYsICJSYWZhZWwgSi4gV3lzb2NraSIgPHJhZmFlbEBrZXJu
ZWwub3JnPiB3cm90ZToKPk9uIEZyaSwgQXByIDI4LCAyMDIzIGF0IDk6MTnigK9BTSA8d2FuZ3lv
dXdhbkAxMjYuY29tPiB3cm90ZToKPj4KPj4gRnJvbTogeW91d2FuIFdhbmcgPHdhbmd5b3V3YW5A
MTI2LmNvbT4KPj4KPj4gV2hlbiB1c2luZyB0aGUgInNjcGlfY3B1ZnJlcSIgZHJpdmVyLCBhbiBl
cnJvcgo+PiBvY2N1cnM6Y3B1ZnJlcV9jb29saW5nOiBPRiBub2RlIG5vdCBhdmFpbGFibGUgZm9y
IGNwdSouCj4+IFRoZSBjdXJyZW50IGNvbXB1dGVyIG1vdGhlcmJvYXJkIGlzIHVzaW5nIEFDUEkg
ZmlybXdhcmUuCj4+IEdvIHRvIHNlZSB0aGF0IHRoZSBlcnJvciBpcyBjYXVzZWQgYnkgY2FsbGlu
ZyB0aGUKPj4gIm9mX2NwdWZyZXFfY29vbGluZ19yZWdpc3RlciIgaW50ZXJmYWNlLgo+PiBjb21t
ZW50OmNyZWF0ZSBjcHVmcmVxIGNvb2xpbmcgZGV2aWNlIGJhc2VkIG9uIERULgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiB5b3V3YW4gV2FuZyA8d2FuZ3lvdXdhbkAxMjYuY29tPgo+PiAtLS0KPj4gIGRy
aXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMgfCA3ICsrKysrKy0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y3B1ZnJlcS9jcHVmcmVxLmMgYi9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jCj4+IGluZGV4IDZi
NTJlYmU1YTg5MC4uMzQxOGM2ODk1OWQ1IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEv
Y3B1ZnJlcS5jCj4+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMKPj4gQEAgLTE1Mjgs
OCArMTUyOCwxMyBAQCBzdGF0aWMgaW50IGNwdWZyZXFfb25saW5lKHVuc2lnbmVkIGludCBjcHUp
Cj4+ICAgICAgICAgaWYgKGNwdWZyZXFfZHJpdmVyLT5yZWFkeSkKPj4gICAgICAgICAgICAgICAg
IGNwdWZyZXFfZHJpdmVyLT5yZWFkeShwb2xpY3kpOwo+Pgo+PiAtICAgICAgIGlmIChjcHVmcmVx
X3RoZXJtYWxfY29udHJvbF9lbmFibGVkKGNwdWZyZXFfZHJpdmVyKSkKPj4gKyAgICAgICBpZiAo
Y3B1ZnJlcV90aGVybWFsX2NvbnRyb2xfZW5hYmxlZChjcHVmcmVxX2RyaXZlcikpIHsKPj4gKyNp
ZmRlZiBDT05GSUdfQUNQSQo+PiArICAgICAgICAgICAgICAgcG9saWN5LT5jZGV2ID0gY3B1ZnJl
cV9jb29saW5nX3JlZ2lzdGVyKHBvbGljeSk7Cj4+ICsjZWxzZQo+PiAgICAgICAgICAgICAgICAg
cG9saWN5LT5jZGV2ID0gb2ZfY3B1ZnJlcV9jb29saW5nX3JlZ2lzdGVyKHBvbGljeSk7Cj4+ICsj
ZW5kaWYKPgo+UGxlYXNlIGF2b2lkIGFkZGluZyAjaWZkZWZzIGxpa2UgdGhpcyBpbiByYW5kb20g
cGxhY2VzLgo+Cj5Nb3Jlb3Zlciwgd2hhdCBpZiB0aGUga2VybmVsIHN1cHBvcnRzIEFDUEkgYW5k
IHRoZSBwbGF0Zm9ybSBpcyBEVC1iYXNlZD8KPgo+PiArICAgICAgIH0KPj4KPj4gICAgICAgICBw
cl9kZWJ1ZygiaW5pdGlhbGl6YXRpb24gY29tcGxldGVcbiIpOwo+Pgo+PiAtLQo=
