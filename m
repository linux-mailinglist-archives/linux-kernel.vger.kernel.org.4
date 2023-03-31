Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C816D1C97
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjCaJhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjCaJhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:37:12 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C19C172C;
        Fri, 31 Mar 2023 02:37:02 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PnwCq5qnZz9sSL;
        Fri, 31 Mar 2023 11:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680255399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYLxII/AzHSuhLaXujV1FeTSBkeqV/qJ8zqJUY5DdQU=;
        b=YkxkO5Wu4rQH7Jkf7KZTwSe2qEmE4rS/2rBdzEJzWwqVaBSEiHYuaOxgQ06UtiWhL+GJ1J
        a5al0uAqOav2KTb9Bl2dGYprFLXDIC2HjjIHVdgnP9RqifKqu0Re1K8l4YncvrwaacXERc
        KsKkqll9XxiKwzwYRrRGFcO4mC5KIkmkHVgSc2Y8+/DVaxHu0NkQjIWOC7eV5wyfek6aWj
        mDLYu38RdvKaG4RJwWfSqU3uURfVBMaXSNZBYFZXaojGttw8YApvOqobvOyCQkFULbqjiv
        HIUE2uBRluWF/WP+V1ZmZ8rBpFk0nvWRv8KPa638WADac/elPxNh1Tre49r13Q==
Message-ID: <e7b73a24b8ba76cb6dc9921f73c47632a749b93f.camel@dylanvanassche.be>
Subject: Re: [PATCH v3 2/4] dts: arm64: qcom: sdm845: add SLPI FastRPC
 support
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Date:   Fri, 31 Mar 2023 11:36:37 +0200
In-Reply-To: <f9a4a2de-42f8-676a-ae6d-d20391206f83@linaro.org>
References: <20230330165322.118279-1-me@dylanvanassche.be>
         <20230330165322.118279-3-me@dylanvanassche.be>
         <f9a4a2de-42f8-676a-ae6d-d20391206f83@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS29ucmFkLAoKT24gRnJpLCAyMDIzLTAzLTMxIGF0IDA0OjAzICswMjAwLCBLb25yYWQgRHli
Y2lvIHdyb3RlOgo+IAo+IAo+IE9uIDMwLjAzLjIwMjMgMTg6NTMsIER5bGFuIFZhbiBBc3NjaGUg
d3JvdGU6Cj4gPiBRdWFsY29tbSBTRE04NDUgU29DIGZlYXR1cmVzIGEgU0xQSSBEU1Agd2hpY2gg
dXNlcyBGYXN0UlBDIHRocm91Z2gKPiA+IGFuIGFsbG9jYXRlZCBtZW1vcnkgcmVnaW9uIHRvIGxv
YWQgZmlsZXMgZnJvbSB0aGUgaG9zdCBmaWxlc3lzdGVtCj4gPiBzdWNoIGFzIHNlbnNvciBjb25m
aWd1cmF0aW9uIGZpbGVzLgo+ID4gCj4gPiBBZGQgYSBGYXN0UlBDIG5vZGUgYXQgL2Rldi9mYXN0
cnBjLXNkc3AgYW5kIGEgRE1BIHJlZ2lvbiwgc2ltaWxhcgo+ID4gdG8KPiA+IGRvd25zdHJlYW0s
IHRvIGFsbG93IHVzZXJzcGFjZSB0byBjb21tdW5pY2F0ZSB3aXRoIHRoZSBTTFBJIHZpYSB0aGUK
PiA+IEZhc3RSUEMgaW50ZXJmYWNlIGZvciBpbml0aWFsaXppbmcgdGhlIHNlbnNvcnMgb24gdGhl
IFNMUEkuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IER5bGFuIFZhbiBBc3NjaGUgPG1lQGR5bGFu
dmFuYXNzY2hlLmJlPgo+ID4gLS0tCj4gPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zZG04
NDUuZHRzaSB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gwqAxIGZpbGUgY2hhbmdl
ZCwgMjQgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9xY29tL3NkbTg0NS5kdHNpCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zZG04
NDUuZHRzaQo+ID4gaW5kZXggM2I1NDdjYjdhZWI4Li44ZWE0OTQ0ZjNhZDYgMTAwNjQ0Cj4gPiAt
LS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2RtODQ1LmR0c2kKPiA+ICsrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvcWNvbS9zZG04NDUuZHRzaQo+ID4gQEAgLTg3OCw2ICs4NzgsMTQgQEAg
bWRhdGFfbWVtOiBtcHNzLW1ldGFkYXRhIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNpemUgPSA8MCAweDQwMDA+Owo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbm8tbWFwOwo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGZhc3RycGNfbWVtOiBmYXN0cnBjIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJzaGFyZWQtZG1hLXBvb2wi
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXVz
YWJsZTsKPiBQbGVhc2UgbW92ZSBpdCBsYXN0IHRvIGdldCBhIG5pY2UgcmV2ZXJzZS1DaHJpc3Rt
YXMtdHJlZSBsYXlvdXQuCj4gCgpXaWxsIGZpeCBpbiB2NC4KCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFsbG9jLXJhbmdlcyA9IDwwIDB4MDAwMDAw
MDAgMCAweGZmZmZmZmZmPjsKPiBXb3VsZCB0aGVyZSBiZSBhbnkgaXNzdWVzIHdpdGggaXQgc3Rh
cnRpbmcgb3ZlciAoMTw8MzEgLSAxKT8KPiAKCllvdSBtZWFuIGEgYmlnZ2VyIHJlZ2lvbiB0aGVu
LCBsaWtlIHRoZSB3aG9sZSBDTUEgcmVnaW9uIHRoZW4/IEFGQUlLLAp0aGUgU0xQSSBhbHdheXMg
dXNlIHRoZSBzYW1lIHJlZ2lvbiBleHBlY3RpbmcgaXQgdG8gYmUgaW4gdGhpcyByYW5nZS4KSG93
ZXZlciwgSSBjYW5ub3QgY29uZmlybSBtb3JlLCBhcyBJIGhhdmUgbm8gaW5zaWdodHMgaW4gdGhl
IGZpcm13YXJlCnJ1bm5pbmcgb24gdGhlcmUsIHRoaXMgYWxsIGNvbWVzIGZyb20gZmluZGluZyBv
dXQgd2hhdCBpdCBleGFjdGx5IGRvZXMKb24gZG93bnN0cmVhbS4KCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFsaWdubWVudCA9IDwwIDB4NDAwMDAw
PjsKPiBQbGVhc2UgdXNlIDB4MCBmb3IgdGhlIDAgaGVyZSwgYXMgaXQncyBlc3NlbnRpYWxseSBy
ZWcuc2l6ZSB3aXRoCj4gc2l6ZS1jZWxscyA9IDIKCldpbGwgZml4IGluIHY0LgoKPiAKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2l6ZSA9IDwwIDB4
MTAwMDAwMD47Cj4gRGl0dG8KCldpbGwgZml4IGluIHY0LgoKPiAKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gPiDCoAo+ID4gwqDC
oMKgwqDCoMKgwqDCoGFkc3BfcGFzOiByZW1vdGVwcm9jLWFkc3Agewo+ID4gQEAgLTMzNDQsNiAr
MzM1MiwyMiBAQCBnbGluay1lZGdlIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsYWJlbCA9ICJkc3BzIjsKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBxY29tLHJlbW90ZS1waWQgPSA8Mz47Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWJveGVzID0gPCZhcHNzX3No
YXJlZCAyND47Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmYXN0cnBjIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjb21wYXRpYmxlID0KPiA+ICJxY29tLGZhc3RycGMiOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHFjb20sZ2xpbmstY2hhbm5lbHMgPQo+ID4gImZhc3RycGNnbGluay1hcHBzLWRzcCI7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGFiZWwgPSAic2RzcCI7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcWNvbSxub24tc2VjdXJlLWRvbWFpbjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBxY29tLHZtaWRzID0gPDB4MyAweEYgMHg1Cj4gPiAweDY+Owo+IFBsZWFzZSB1c2UgdGhl
IHJlY2VudGx5LWludHJvZHVjZWQgaGVhZGVyIGFuZCBkZXBlbmQgb24gKGFuZAo+IG1ha2UgYSBw
YXRjaCBhdG9wKQo+IAo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1tc20vODY4
NWI3MTAtYjc0ZC01NTZhLTgxNWQtMGZmZWYyYjBlZWZmQGxpbmFyby5vcmcvVC8jdAo+IAo+IEtv
bnJhZAo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1lbW9yeS1yZWdpb24gPQo+ID4gPCZm
YXN0cnBjX21lbT47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgI2FkZHJlc3MtY2VsbHMgPSA8
MT47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgI3NpemUtY2VsbHMgPSA8MD47Cj4gPiArCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcHV0ZS1jYkAwIHsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9Cj4gPiAicWNvbSxmYXN0cnBjLWNv
bXB1dGUtY2IiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWcg
PSA8MD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gwqAKCktpbmQgcmVnYXJkcywKRHlsYW4K


