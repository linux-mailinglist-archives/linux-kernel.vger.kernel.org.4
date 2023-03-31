Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16C96D214E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjCaNOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjCaNOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:14:33 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301A12061F;
        Fri, 31 Mar 2023 06:14:17 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Pp12s2S9Zz9syH;
        Fri, 31 Mar 2023 15:14:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680268453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rNlamqJZPI1pREt0hFxVw7uj3j9kqBoV5fjNpXoUpCA=;
        b=cAZuQsjcze0ruha73ofKnMyw5hwY1C13MelArknvE5IA68EkNtvxQCdfAM1eBZpyFyThVM
        sr3qvvbqM5jtu4bZXGbnrjAcOm16XkeDDdnbb0RJXcVb84eeGxIOceauYG3l0DXFnrtL7O
        TJl6hNVHARy8f4eahrO9eoTt1f5Nf+gS0oMaHsK5Wgpi3rx98jmT189UrEQUsfa3YIbqfW
        WwE9G260L7B0Vixp8aiKRe0/Kb8UIL85IL/hpqdJ0pXZOtJXov9DoskGxqPbSqxemNzarl
        StdhD2wd3S4unM9MHNrayi5PsZYHxuxoxMq8VbmiYsw9kjzmF2AZx5S3WdyGtA==
Message-ID: <603ef0bf04b9c4f7f8e94e2ccece97ffa1b0582b.camel@dylanvanassche.be>
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
Date:   Fri, 31 Mar 2023 15:14:10 +0200
In-Reply-To: <e43e944c-9f65-cde5-5d8c-a76f33f99b44@linaro.org>
References: <20230330165322.118279-1-me@dylanvanassche.be>
         <20230330165322.118279-3-me@dylanvanassche.be>
         <f9a4a2de-42f8-676a-ae6d-d20391206f83@linaro.org>
         <e7b73a24b8ba76cb6dc9921f73c47632a749b93f.camel@dylanvanassche.be>
         <e43e944c-9f65-cde5-5d8c-a76f33f99b44@linaro.org>
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

T24gRnJpLCAyMDIzLTAzLTMxIGF0IDE0OjIwICswMjAwLCBLb25yYWQgRHliY2lvIHdyb3RlOgo+
IAo+IAo+IE9uIDMxLjAzLjIwMjMgMTE6MzYsIER5bGFuIFZhbiBBc3NjaGUgd3JvdGU6Cj4gPiBI
aSBLb25yYWQsCj4gPiAKPiA+IE9uIEZyaSwgMjAyMy0wMy0zMSBhdCAwNDowMyArMDIwMCwgS29u
cmFkIER5YmNpbyB3cm90ZToKPiA+ID4gCj4gPiA+IAo+ID4gPiBPbiAzMC4wMy4yMDIzIDE4OjUz
LCBEeWxhbiBWYW4gQXNzY2hlIHdyb3RlOgo+ID4gPiA+IFF1YWxjb21tIFNETTg0NSBTb0MgZmVh
dHVyZXMgYSBTTFBJIERTUCB3aGljaCB1c2VzIEZhc3RSUEMKPiA+ID4gPiB0aHJvdWdoCj4gPiA+
ID4gYW4gYWxsb2NhdGVkIG1lbW9yeSByZWdpb24gdG8gbG9hZCBmaWxlcyBmcm9tIHRoZSBob3N0
Cj4gPiA+ID4gZmlsZXN5c3RlbQo+ID4gPiA+IHN1Y2ggYXMgc2Vuc29yIGNvbmZpZ3VyYXRpb24g
ZmlsZXMuCj4gPiA+ID4gCj4gPiA+ID4gQWRkIGEgRmFzdFJQQyBub2RlIGF0IC9kZXYvZmFzdHJw
Yy1zZHNwIGFuZCBhIERNQSByZWdpb24sCj4gPiA+ID4gc2ltaWxhcgo+ID4gPiA+IHRvCj4gPiA+
ID4gZG93bnN0cmVhbSwgdG8gYWxsb3cgdXNlcnNwYWNlIHRvIGNvbW11bmljYXRlIHdpdGggdGhl
IFNMUEkgdmlhCj4gPiA+ID4gdGhlCj4gPiA+ID4gRmFzdFJQQyBpbnRlcmZhY2UgZm9yIGluaXRp
YWxpemluZyB0aGUgc2Vuc29ycyBvbiB0aGUgU0xQSS4KPiA+ID4gPiAKPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBEeWxhbiBWYW4gQXNzY2hlIDxtZUBkeWxhbnZhbmFzc2NoZS5iZT4KPiA+ID4gPiAt
LS0KPiA+ID4gPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zZG04NDUuZHRzaSB8IDI0Cj4g
PiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwg
MjQgaW5zZXJ0aW9ucygrKQo+ID4gPiA+IAo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL3Fjb20vc2RtODQ1LmR0c2kKPiA+ID4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
cWNvbS9zZG04NDUuZHRzaQo+ID4gPiA+IGluZGV4IDNiNTQ3Y2I3YWViOC4uOGVhNDk0NGYzYWQ2
IDEwMDY0NAo+ID4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zZG04NDUuZHRz
aQo+ID4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zZG04NDUuZHRzaQo+ID4g
PiA+IEBAIC04NzgsNiArODc4LDE0IEBAIG1kYXRhX21lbTogbXBzcy1tZXRhZGF0YSB7Cj4gPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2l6ZSA9
IDwwIDB4NDAwMD47Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgbm8tbWFwOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgfTsKPiA+ID4gPiArCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZh
c3RycGNfbWVtOiBmYXN0cnBjIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAic2hhcmVkLWRtYS1wb29sIjsKPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldXNhYmxl
Owo+ID4gPiBQbGVhc2UgbW92ZSBpdCBsYXN0IHRvIGdldCBhIG5pY2UgcmV2ZXJzZS1DaHJpc3Rt
YXMtdHJlZSBsYXlvdXQuCj4gPiA+IAo+ID4gCj4gPiBXaWxsIGZpeCBpbiB2NC4KPiA+IAo+ID4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWxsb2Mt
cmFuZ2VzID0gPDAgMHgwMDAwMDAwMCAwCj4gPiA+ID4gMHhmZmZmZmZmZj47Cj4gPiA+IFdvdWxk
IHRoZXJlIGJlIGFueSBpc3N1ZXMgd2l0aCBpdCBzdGFydGluZyBvdmVyICgxPDwzMSAtIDEpPwo+
ID4gPiAKPiA+IAo+ID4gWW91IG1lYW4gYSBiaWdnZXIgcmVnaW9uIHRoZW4sIGxpa2UgdGhlIHdo
b2xlIENNQSByZWdpb24gdGhlbj8KPiA+IEFGQUlLLAo+ID4gdGhlIFNMUEkgYWx3YXlzIHVzZSB0
aGUgc2FtZSByZWdpb24gZXhwZWN0aW5nIGl0IHRvIGJlIGluIHRoaXMKPiA+IHJhbmdlLgo+ID4g
SG93ZXZlciwgSSBjYW5ub3QgY29uZmlybSBtb3JlLCBhcyBJIGhhdmUgbm8gaW5zaWdodHMgaW4g
dGhlCj4gPiBmaXJtd2FyZQo+ID4gcnVubmluZyBvbiB0aGVyZSwgdGhpcyBhbGwgY29tZXMgZnJv
bSBmaW5kaW5nIG91dCB3aGF0IGl0IGV4YWN0bHkKPiA+IGRvZXMKPiA+IG9uIGRvd25zdHJlYW0u
Cj4gSSB3YXMgYXNraW5nIGFib3V0IHRoZSA8Li4gMCAweGZmZi5mPiBwYXJ0IHNwZWNpZmljYWxs
eSwgYXMgdGhhdAo+IG1lYW5zCj4gaXQgY2FuJ3QgYmUgYWxsb2NhdGVkIGFib3ZlIDQgZ2lncy4g
QnV0IEkgZ3Vlc3MgaXQncyBqdXN0IGhvdyBxY29tCj4gZW52aXNpb25lZCBpdC4KPiAKCkkgdGhp
bmsgaXQgaXMgbGltaXRlZCBieSBxY29tLCBidXQgSSBjYW5ub3QgYmUgZW50aXJlbHkgc3VyZSA6
KQpJbiBhbnkgY2FzZSwgZm9yIHY0LCBkbyBJIGtlZXAgMHhmZmZmZmZmZj8KCj4gQWxzbywgcGxl
YXNlIHVzZSAweDAgaW4gYWxsb2MtcmFuZ2VzIGFzIHdlbGwsIHRoaXMgaXMgYWxsIGFkZHJlc3Nl
cy8KPiByZWcgc2l6ZXMuCj4gCj4gS29ucmFkCgpZZXMsIHdpbGwgdXNlIDB4MCBpbnN0ZWFkIG9m
IDAuCgpEeWxhbgoKPiA+IAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgYWxpZ25tZW50ID0gPDAgMHg0MDAwMDA+Owo+ID4gPiBQbGVhc2UgdXNl
IDB4MCBmb3IgdGhlIDAgaGVyZSwgYXMgaXQncyBlc3NlbnRpYWxseSByZWcuc2l6ZSB3aXRoCj4g
PiA+IHNpemUtY2VsbHMgPSAyCj4gPiAKPiA+IFdpbGwgZml4IGluIHY0Lgo+ID4gCj4gPiA+IAo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2l6
ZSA9IDwwIDB4MTAwMDAwMD47Cj4gPiA+IERpdHRvCj4gPiAKPiA+IFdpbGwgZml4IGluIHY0Lgo+
ID4gCj4gPiA+IAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4g
PiA+IMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gPiA+IMKgCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oGFkc3BfcGFzOiByZW1vdGVwcm9jLWFkc3Agewo+ID4gPiA+IEBAIC0zMzQ0LDYgKzMzNTIsMjIg
QEAgZ2xpbmstZWRnZSB7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxhYmVsID0gImRzcHMiOwo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBxY29tLHJlbW90ZS1waWQgPSA8Mz47Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1ib3hlcyA9IDwmYXBz
c19zaGFyZWQgMjQ+Owo+ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmYXN0cnBjIHsKPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9Cj4gPiA+ID4gInFjb20sZmFzdHJwYyI7
Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHFjb20sZ2xpbmstY2hhbm5lbHMgPQo+ID4g
PiA+ICJmYXN0cnBjZ2xpbmstYXBwcy1kc3AiOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBsYWJlbCA9ICJzZHNwIjsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcWNvbSxub24t
c2VjdXJlLWRvbWFpbjsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcWNvbSx2bWlkcyA9
IDwweDMgMHhGCj4gPiA+ID4gMHg1Cj4gPiA+ID4gMHg2PjsKPiA+ID4gUGxlYXNlIHVzZSB0aGUg
cmVjZW50bHktaW50cm9kdWNlZCBoZWFkZXIgYW5kIGRlcGVuZCBvbiAoYW5kCj4gPiA+IG1ha2Ug
YSBwYXRjaCBhdG9wKQo+ID4gPiAKPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
YXJtLW1zbS84Njg1YjcxMC1iNzRkLTU1NmEtODE1ZC0wZmZlZjJiMGVlZmZAbGluYXJvLm9yZy9U
LyN0Cj4gPiA+IAo+ID4gPiBLb25yYWQKPiA+ID4gCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoG1lbW9yeS1yZWdpb24gPQo+ID4gPiA+IDwmZmFzdHJwY19tZW0+Owo+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgI3NpemUtY2VsbHMgPSA8MD47Cj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBjb21wdXRlLWNiQDAgewo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9Cj4gPiA+ID4gInFjb20sZmFzdHJwYy1jb21w
dXRlLWNiIjsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
ZyA9IDwwPjsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9
Owo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oH07Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gPiA+IMKg
Cj4gPiAKPiA+IEtpbmQgcmVnYXJkcywKPiA+IER5bGFuCgo=

