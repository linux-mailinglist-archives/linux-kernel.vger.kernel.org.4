Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C202F6F9E43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjEHDcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEHDcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:32:42 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5392040FC;
        Sun,  7 May 2023 20:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683516745; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RBTuCgMHRK2gfh8llovAYCPGNBvmstD+1XFvCqwc4ASaeoG328ZYM6CZ/YYf70QZKS9+OJovRVXQkslOUfAhICMW7XCF9qc8axN1K4R5fzHLBhEpI+1GDGwAotfQKmVaXPG2nzieIy+aivxmKILCVAY5THQQBjYeihc9sfDwfpA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1683516745; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=oRGcZerxA6Lwws1tmfxkffu7f7raQvcnx2Pon0KubIU=; 
        b=INXBlqKVSz6gV7x3LLpuzqpnUX5g0HEa61FAGTg+IE4E7kxf1k1jiduQ43Dlcah/9p7KadCo8rrx04W2WfiQDoxV/vwMUbUmc+Z1FThSrY8JaknQeo7NDqAcX8aihgkhlDje6oaA6btmbVjiF3abSVY+IFOfzLUnQwan5bzqcYE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1683516745;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=oRGcZerxA6Lwws1tmfxkffu7f7raQvcnx2Pon0KubIU=;
        b=G20n1ds2gW6n9QfjxJ4ksfKQ7GldodmljuT8fMjiDjNSJLqO/MoTSJ9PqAyvpMGw
        Ibb4vQrYEeICFzAZto3jW+guJ7BlJqPSHPuwIWXav7tHUGJcwtfLLPwMKWAlTvTH/VN
        Jk0Y/T/uTmc4zKvIJwlRl0ylxmyhAncjQPrqQhCQ=
Received: from edelgard.fodlan.icenowy.me (120.85.98.36 [120.85.98.36]) by mx.zohomail.com
        with SMTPS id 1683516743648863.2035343610653; Sun, 7 May 2023 20:32:23 -0700 (PDT)
Message-ID: <394696a52bf1d767044e3f990cebfbaf69dabe70.camel@icenowy.me>
Subject: Re: [PATCH 3/5] riscv: dts: add initial T-HEAD light SoC device tree
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor Dooley <conor@kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        heiko@sntech.de
Date:   Mon, 08 May 2023 11:32:17 +0800
In-Reply-To: <20230507-calamari-gentleman-bbe62af06f92@spud>
References: <20230507182304.2934-1-jszhang@kernel.org>
         <20230507182304.2934-4-jszhang@kernel.org>
         <20230507-calamari-gentleman-bbe62af06f92@spud>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjMtMDUtMDfmmJ/mnJ/ml6XnmoQgMjI6MzUgKzAxMDDvvIxDb25vciBEb29sZXnlhpnp
gZPvvJoKPiBIZXkgSmlzaGVuZywKPiAKPiBPbiBNb24sIE1heSAwOCwgMjAyMyBhdCAwMjoyMzow
MkFNICswODAwLCBKaXNoZW5nIFpoYW5nIHdyb3RlOgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGM5MTBfMDogY3B1QDAgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gInRoZWFkLGM5MTAiLCAicmlzY3Yi
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZp
Y2VfdHlwZSA9ICJjcHUiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByaXNjdixpc2EgPSAicnY2NGltYWZkYyI7Cj4gCj4gRG9lcyB0aGlzIHN1cHBv
cnQgbW9yZSB0aGFuICJydjY0aW1hZmRjIj8KPiBJIGFzc3VtZSB0aGVyZSdzIHNvbWUgX3h0aGVh
ZGZvbyBleHRlbnNpb25zIHRoYXQgaXQgZG9lcyBzdXBwb3J0LAo+IGFsdGhvdWdoIEkgYW0gbm90
IHN1cmUgaG93IHdlIGFyZSBwcm9jZWVkaW5nIHdpdGggdGhvc2UgLSBIZWlrbyBtaWdodAo+IGhh
dmUgYSBtb3JlIG51YW5jZWQgdGFrZS4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXNldDogcmVzZXQtc2FtcGxlIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJ0aGVhZCxyZXNldC1zYW1wbGUiOwo+
IAo+IFdoYXQgaXMgYSAicmVzZXQtc2FtcGxlIj8KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZW50cnktcmVnID0gPDB4ZmYgMHhmZjAxOTA1MD47
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVudHJ5
LWNudCA9IDw0PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY29udHJvbC1yZWcgPSA8MHhmZiAweGZmMDE1MDA0PjsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udHJvbC12YWwgPSA8MHgxYz47Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNzci1jb3B5
ID0gPDB4N2YzIDB4N2MwIDB4N2MxIDB4N2MyIDB4N2MzCj4gPiAweDdjNSAweDdjYz47Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBwbGljOiBpbnRlcnJ1cHQtY29udHJvbGxlckBmZmQ4MDAwMDAwIHsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0
aWJsZSA9ICJ0aGVhZCxjOTEwLXBsaWMiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZWcgPSA8MHhmZiAweGQ4MDAwMDAwIDB4MCAweDAxMDAwMDAw
PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50
ZXJydXB0cy1leHRlbmRlZCA9IDwmY3B1MF9pbnRjIDExPiwKPiA+IDwmY3B1MF9pbnRjIDk+LAo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPCZjcHUxX2ludGMgMTE+LAo+ID4g
PCZjcHUxX2ludGMgOT4sCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JmNw
dTJfaW50YyAxMT4sCj4gPiA8JmNwdTJfaW50YyA5PiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDwmY3B1M19pbnRjIDExPiwKPiA+IDwmY3B1M19pbnRjIDk+Owo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnRlcnJ1cHQtY29u
dHJvbGxlcjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgI2ludGVycnVwdC1jZWxscyA9IDwxPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmlzY3YsbmRldiA9IDwyNDA+Owo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY2xpbnQ6IHRpbWVyQGZmZGMwMDAwMDAgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gInRoZWFkLGM5MDAtY2xpbnQi
Owo+IAo+ICJjOTAwIj8gVGhhdCBhIHR5cG8gb3IgaW50ZW50aW9uYWwuIEhhcmQgdG8gdGVsbCBz
aW5jZSB0aGlzCj4gY29tcGF0aWJsZQo+IGlzIHVuZG9jdW1lbnRlZCA7KQoKSW50ZW50aW9uYWws
IGZvciBzdXBwb3J0aW5nIGJvdGggQzkwNiBhbmQgQzkxMC4KCkhvd2V2ZXIsIGFzIHdlIGRpc2N1
c3NlZCBpbiBzb21lIGJpbmRpbmcgcGF0Y2hlcywgdGhlcmUgc2hvdWxkIGJlIGEgRFQKYmluZGlu
ZyBzdHJpbmcgcGVyIGNoaXAuCgpTbyBoZXJlIHNob3VsZCBiZSAidGhlYWQsbGlnaHQtY2xpbnQi
LCAidGhlYWQsYzkwMC1jbGludCIuCgooT3IgdXNlIHRoMTUyMCwgdGhlIG1hcmtldGluZyBuYW1l
LCBpbnN0ZWFkIG9mIGxpZ2h0LCB0aGUgY29kZW5hbWUpCgpQLlMuIHdoaWNoIG9uZSBpcyBwcmVm
ZXJyZWQgYnkgRFQgYmluZGluZyBtYWludGFpbmVycywgdGhlIG1hcmtldGluZwpuYW1lIG9yIHRo
ZSBjb2RlbmFtZT8KCj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJlZyA9IDwweGZmIDB4ZGMwMDAwMDAgMHgwIDB4MDAwMTAwMDA+Owo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnRlcnJ1cHRzLWV4
dGVuZGVkID0gPCZjcHUwX2ludGMgMz4sCj4gPiA8JmNwdTBfaW50YyA3PiwKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwmY3B1MV9pbnRjIDM+LAo+ID4gPCZjcHUxX2ludGMg
Nz4sCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JmNwdTJfaW50YyAzPiwK
PiA+IDwmY3B1Ml9pbnRjIDc+LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
PCZjcHUzX2ludGMgMz4sCj4gPiA8JmNwdTNfaW50YyA3PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB9Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHVhcnQwOiBzZXJpYWxAZmZlNzAxNDAwMCB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAic25wcyxkdy1hcGItdWFydCI7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDww
eGZmIDB4ZTcwMTQwMDAgMHgwIDB4NDAwMD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVycnVwdHMgPSA8MzY+Owo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9ja3MgPSA8JnVhcnRfc2Nsaz47
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2Nr
LW5hbWVzID0gImJhdWRjbGsiOwo+IAo+IGR0YnNfY2hlY2sgY29tcGxhaW5zIGFib3V0IHRoaXMg
Y2xvY2sgbmFtZS4KPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkbWFj
MDogZG1hY0BmZmVmYzAwMDAwIHsKPiAKPiBkbWEtY29udHJvbGxlckAKPiAKPiBBcyBJIG1lbnRp
b25lZCBpbiB0aGUgb3RoZXIgcGF0Y2gsIHBsZWFzZSBjbGVhbiB1cCB0aGUgZHRic19jaGVjawo+
IGNvbXBsYWludHMgZm9yIHYyLgo+IAo+IENoZWVycywKPiBDb25vci4KPiAKPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGxpbnV4LXJpc2N2IG1haWxp
bmcgbGlzdAo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2Cgo=

