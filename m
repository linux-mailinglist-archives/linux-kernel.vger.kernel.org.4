Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D4F6E779A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjDSKmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjDSKmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:42:39 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1339EBE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1681900957;
        bh=NnE0CzIOhkCFuAdtNBZ4R7pyy7AFXsTSMSAcvOT6l9w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NycJOzskKcJJLuSWJPr4QbUapy7gTm4VqcUuSLE6mBqpZOBGbI2+buO8tNt6YMPp+
         nx6NG59RDKagt2u8P2rZKHR/HPoTdsiQTMFoGgYfCxbR7zlCXSn0hWZyI4UdY57Cxz
         pR1aar1PZILK2u6WCZV0K8qSXlp3TJxjSth1KjkU=
Received: from [192.168.124.11] (unknown [113.140.11.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 2508C65C28;
        Wed, 19 Apr 2023 06:42:35 -0400 (EDT)
Message-ID: <a7fa32c3af68083855e7690f67824d060d5c6135.camel@xry111.site>
Subject: Re: [PATCH 1/2] LoongArch: Add pad structure members for explicit
 alignment
From:   Xi Ruoyao <xry111@xry111.site>
To:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Wed, 19 Apr 2023 18:42:28 +0800
In-Reply-To: <20230418091348.9239-1-zhangqing@loongson.cn>
References: <20230418091348.9239-1-zhangqing@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA0LTE4IGF0IDE3OjEzICswODAwLCBRaW5nIFpoYW5nIHdyb3RlOgo+IFRo
aXMgaXMgZG9uZSBpbiBvcmRlciB0byBlYXNpbHkgY2FsY3VsYXRlIHRoZSBudW1iZXIgb2YgYnJl
YWtwb2ludHMKPiBpbiBod19icmVha19nZXQuCj4gCj4gU2lnbmVkLW9mZi1ieTogUWluZyBaaGFu
ZyA8emhhbmdxaW5nQGxvb25nc29uLmNuPgo+IC0tLQo+IMKgYXJjaC9sb29uZ2FyY2gvaW5jbHVk
ZS91YXBpL2FzbS9wdHJhY2UuaCB8wqAgMyArKy0KPiDCoGFyY2gvbG9vbmdhcmNoL2tlcm5lbC9w
dHJhY2UuY8KgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTMgKysrKysrKysrLS0tLQo+IMKgMiBmaWxl
cyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1n
aXQgYS9hcmNoL2xvb25nYXJjaC9pbmNsdWRlL3VhcGkvYXNtL3B0cmFjZS5oCj4gYi9hcmNoL2xv
b25nYXJjaC9pbmNsdWRlL3VhcGkvYXNtL3B0cmFjZS5oCj4gaW5kZXggMjI4MmFlMWZkM2I2Li4w
NmUzYmU1MmNiMDQgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS91YXBpL2Fz
bS9wdHJhY2UuaAo+ICsrKyBiL2FyY2gvbG9vbmdhcmNoL2luY2x1ZGUvdWFwaS9hc20vcHRyYWNl
LmgKPiBAQCAtNTcsMTEgKzU3LDEyIEBAIHN0cnVjdCB1c2VyX2xhc3hfc3RhdGUgewo+IMKgfTsK
PiDCoAo+IMKgc3RydWN0IHVzZXJfd2F0Y2hfc3RhdGUgewo+IC3CoMKgwqDCoMKgwqDCoHVpbnQx
Nl90IGRiZ19pbmZvOwo+ICvCoMKgwqDCoMKgwqDCoHVpbnQ2NF90IGRiZ19pbmZvOwoKT3VjaC4g
IFRoaXMgaXMgYSBicmVha2luZyBjaGFuZ2Ugd2hlbiB3ZSBjb25zaWRlciB1c2VyIGNvZGUgbGlr
ZQpgcHJpbnRmKFBSSXUxNiAiXG4iLCBwdHItPmRiZ19pbmZvKTtgLiAgSXMgaXQgcmVhbGx5IG5l
Y2Vzc2FyeT8KCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB1aW50NjRfdMKgwqDCoCBhZGRyOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdWludDY0X3TCoMKgwqAgbWFzazsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHVpbnQzMl90wqDCoMKgIGN0cmw7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHVpbnQzMl90wqDCoMKgIHBhZDsKPiDCoMKgwqDCoMKgwqDCoMKgfSBkYmdfcmVnc1s4
XTsKPiDCoH07Cj4gwqAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gva2VybmVsL3B0cmFj
ZS5jCj4gYi9hcmNoL2xvb25nYXJjaC9rZXJuZWwvcHRyYWNlLmMKPiBpbmRleCAwYzdjNDFlNDFj
YWQuLjljM2JjMWJiZjJmZiAxMDA2NDQKPiAtLS0gYS9hcmNoL2xvb25nYXJjaC9rZXJuZWwvcHRy
YWNlLmMKPiArKysgYi9hcmNoL2xvb25nYXJjaC9rZXJuZWwvcHRyYWNlLmMKPiBAQCAtNDc1LDEw
ICs0NzUsMTAgQEAgc3RhdGljIGludCBwdHJhY2VfaGJwX2ZpbGxfYXR0cl9jdHJsKHVuc2lnbmVk
Cj4gaW50IG5vdGVfdHlwZSwKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gwqB9Cj4gwqAK
PiAtc3RhdGljIGludCBwdHJhY2VfaGJwX2dldF9yZXNvdXJjZV9pbmZvKHVuc2lnbmVkIGludCBu
b3RlX3R5cGUsIHUxNgo+ICppbmZvKQo+ICtzdGF0aWMgaW50IHB0cmFjZV9oYnBfZ2V0X3Jlc291
cmNlX2luZm8odW5zaWduZWQgaW50IG5vdGVfdHlwZSwgdTY0Cj4gKmluZm8pCj4gwqB7Cj4gwqDC
oMKgwqDCoMKgwqDCoHU4IG51bTsKPiAtwqDCoMKgwqDCoMKgwqB1MTYgcmVnID0gMDsKPiArwqDC
oMKgwqDCoMKgwqB1NjQgcmVnID0gMDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKG5v
dGVfdHlwZSkgewo+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIE5UX0xPT05HQVJDSF9IV19CUkVBSzoK
PiBAQCAtNjE2LDcgKzYxNiw3IEBAIHN0YXRpYyBpbnQgaHdfYnJlYWtfZ2V0KHN0cnVjdCB0YXNr
X3N0cnVjdAo+ICp0YXJnZXQsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IHVzZXJfcmVnc2V0ICpyZWdzZXQsCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG1lbWJ1ZiB0bykK
PiDCoHsKPiAtwqDCoMKgwqDCoMKgwqB1MTYgaW5mbzsKPiArwqDCoMKgwqDCoMKgwqB1NjQgaW5m
bzsKPiDCoMKgwqDCoMKgwqDCoMKgdTMyIGN0cmw7Cj4gwqDCoMKgwqDCoMKgwqDCoHU2NCBhZGRy
LCBtYXNrOwo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0LCBpZHggPSAwOwo+IEBAIC02NDYsNiAr
NjQ2LDcgQEAgc3RhdGljIGludCBod19icmVha19nZXQoc3RydWN0IHRhc2tfc3RydWN0Cj4gKnRh
cmdldCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1lbWJ1Zl9zdG9yZSgmdG8s
IGFkZHIpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWVtYnVmX3N0b3JlKCZ0
bywgbWFzayk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtZW1idWZfc3RvcmUo
JnRvLCBjdHJsKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWVtYnVmX3plcm8o
JnRvLCBzaXplb2YodTMyKSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZHgr
KzsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gQEAgLTY2Miw3ICs2NjMsNyBAQCBzdGF0aWMg
aW50IGh3X2JyZWFrX3NldChzdHJ1Y3QgdGFza19zdHJ1Y3QKPiAqdGFyZ2V0LAo+IMKgwqDCoMKg
wqDCoMKgwqBpbnQgcmV0LCBpZHggPSAwLCBvZmZzZXQsIGxpbWl0Owo+IMKgwqDCoMKgwqDCoMKg
wqB1bnNpZ25lZCBpbnQgbm90ZV90eXBlID0gcmVnc2V0LT5jb3JlX25vdGVfdHlwZTsKPiDCoAo+
IC3CoMKgwqDCoMKgwqDCoC8qIFJlc291cmNlIGluZm8gKi8KPiArwqDCoMKgwqDCoMKgwqAvKiBS
ZXNvdXJjZSBpbmZvIGFuZCBwYWQgKi8KPiDCoMKgwqDCoMKgwqDCoMKgb2Zmc2V0ID0gb2Zmc2V0
b2Yoc3RydWN0IHVzZXJfd2F0Y2hfc3RhdGUsIGRiZ19yZWdzKTsKPiDCoMKgwqDCoMKgwqDCoMKg
dXNlcl9yZWdzZXRfY29weWluX2lnbm9yZSgmcG9zLCAmY291bnQsICZrYnVmLCAmdWJ1ZiwgMCwK
PiBvZmZzZXQpOwo+IMKgCj4gQEAgLTcwNCw2ICs3MDUsMTAgQEAgc3RhdGljIGludCBod19icmVh
a19zZXQoc3RydWN0IHRhc2tfc3RydWN0Cj4gKnRhcmdldCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlmIChyZXQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoG9mZnNldCArPSBQVFJBQ0VfSEJQX0NUUkxfU1o7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB1c2VyX3JlZ3NldF9jb3B5aW5faWdub3JlKCZwb3MsICZjb3VudCwgJmti
dWYsICZ1YnVmLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvZmZzZXQsIG9mZnNldCArCj4g
UFRSQUNFX0hCUF9QQURfU1opOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvZmZz
ZXQgKz0gUFRSQUNFX0hCUF9QQURfU1o7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpZHgrKzsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCgotLSAKWGkgUnVveWFvIDx4cnkxMTFA
eHJ5MTExLnNpdGU+ClNjaG9vbCBvZiBBZXJvc3BhY2UgU2NpZW5jZSBhbmQgVGVjaG5vbG9neSwg
WGlkaWFuIFVuaXZlcnNpdHkK

