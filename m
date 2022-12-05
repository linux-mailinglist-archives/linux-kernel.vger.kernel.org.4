Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D791864245C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiLEIS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiLEISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:18:22 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 00:18:19 PST
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABBB1138;
        Mon,  5 Dec 2022 00:18:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670228286; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jwvtdncZDQDdtE9vOMBAAVzm8D1kXwJoKOkjaisVKH2frLZgfEmqEvGCA6pwYtcgTYa/c/xo4UvJhDSvw11NJtCegSy+Y5oVS1sLD0e9qrIjR/wn7mr44+gfELsqirGAPwZ+JGaa8L4GlpZZLs9tAi/guRZDq358XexbbThvr3M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670228286; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=jxprcl7J4slR4tX8AQYdq2rpgO9wNqS0lCJfct1ok6Q=; 
        b=Dts6xw3S1ElToXELwzCiWSQFA9RMfpo5/UeGfkCOFQYzs+JbepkA3wgAO+NvBFVBRumi0AF8FguhKgAwG8kw6gdawS6c7xLpv7FGCgNOHXnVU1ftZnmWQ54POZmbPEjLoSVlyx5NvStC4ZT0ezJwn1xy720jIRAzemR8UOf1KfY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670228286;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=jxprcl7J4slR4tX8AQYdq2rpgO9wNqS0lCJfct1ok6Q=;
        b=UIBY7ActtQRq6q/GhRGpnwEICmZ9ED9mD4C8RFPBClLx7zDQREsY1c30iB+xJBsA
        b8WYVCWeMQK5bZXVqyfH9kOudcBsnZfO+vZivLbMrZEm+X0N3xu9VaTaAjfC96xSpgB
        6pN+URN8bmdadS2OD3KQ5VwCN4LFIVGJhgwIhfkQ=
Received: from edelgard.fodlan.icenowy.me (120.85.99.143 [120.85.99.143]) by mx.zohomail.com
        with SMTPS id 16702282847821005.1365184429435; Mon, 5 Dec 2022 00:18:04 -0800 (PST)
Message-ID: <04abc8d6d8a9200e593f3f667a31ea0d3674c64b.camel@icenowy.me>
Subject: Re: [PATCH v2 6/9] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Samuel Holland <samuel@sholland.org>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date:   Mon, 05 Dec 2022 16:17:59 +0800
In-Reply-To: <d4d8998f-288c-3ff6-141d-02814f8e35d0@sholland.org>
References: <20221127132448.4034-1-jszhang@kernel.org>
         <20221127132448.4034-7-jszhang@kernel.org>
         <d4d8998f-288c-3ff6-141d-02814f8e35d0@sholland.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjItMTEtMzDmmJ/mnJ/kuInnmoQgMDE6MjEgLTA2MDDvvIxTYW11ZWwgSG9sbGFuZOWG
memBk++8mgo+IE9uIDExLzI3LzIyIDA3OjI0LCBKaXNoZW5nIFpoYW5nIHdyb3RlOgo+ID4gQWRk
IGEgYmFpc2MgZHRzaSBmb3IgdGhlIGJvdWZmYWxvbGFiIGJsODA4IFNvQy4KPiA+IAo+ID4gU2ln
bmVkLW9mZi1ieTogSmlzaGVuZyBaaGFuZyA8anN6aGFuZ0BrZXJuZWwub3JnPgo+ID4gLS0tCj4g
PiDCoGFyY2gvcmlzY3YvYm9vdC9kdHMvYm91ZmZhbG9sYWIvYmw4MDguZHRzaSB8IDc0Cj4gPiAr
KysrKysrKysrKysrKysrKysrKysrCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA3NCBpbnNlcnRpb25z
KCspCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL2JvdWZmYWxv
bGFiL2JsODA4LmR0c2kKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMv
Ym91ZmZhbG9sYWIvYmw4MDguZHRzaQo+ID4gYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2JvdWZmYWxv
bGFiL2JsODA4LmR0c2kKPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPiBpbmRleCAwMDAwMDAw
MDAwMDAuLmY0YjE3MGNjYzMyZQo+ID4gLS0tIC9kZXYvbnVsbAo+ID4gKysrIGIvYXJjaC9yaXNj
di9ib290L2R0cy9ib3VmZmFsb2xhYi9ibDgwOC5kdHNpCj4gPiBAQCAtMCwwICsxLDc0IEBACj4g
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wKyBvciBNSVQpCj4gPiArLyoK
PiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjIgSmlzaGVuZyBaaGFuZyA8anN6aGFuZ0BrZXJuZWwu
b3JnPgo+ID4gKyAqLwo+ID4gKwo+ID4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQt
Y29udHJvbGxlci9pcnEuaD4KPiA+ICsKPiA+ICsvIHsKPiA+ICvCoMKgwqDCoMKgwqDCoGNvbXBh
dGlibGUgPSAiYm91ZmZhbG9sYWIsYmw4MDgiOwo+ID4gK8KgwqDCoMKgwqDCoMKgI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47Cj4gPiArwqDCoMKgwqDCoMKgwqAjc2l6ZS1jZWxscyA9IDwxPjsKPiA+ICsK
PiA+ICvCoMKgwqDCoMKgwqDCoGNwdXMgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHRpbWViYXNlLWZyZXF1ZW5jeSA9IDwxMDAwMDAwPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAjc2l6ZS1jZWxscyA9IDwwPjsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBjcHUwOiBjcHVAMCB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAidGhlYWQsYzkwNiIsICJyaXNj
diI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRl
dmljZV90eXBlID0gImNwdSI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJlZyA9IDwwPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZC1jYWNoZS1ibG9jay1zaXplID0gPDY0PjsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZC1jYWNoZS1zZXRzID0gPDI1
Nj47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGQt
Y2FjaGUtc2l6ZSA9IDwzMjc2OD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGktY2FjaGUtYmxvY2stc2l6ZSA9IDw2ND47Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGktY2FjaGUtc2V0cyA9IDwxMjg+
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpLWNh
Y2hlLXNpemUgPSA8MzI3Njg+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBtbXUtdHlwZSA9ICJyaXNjdixzdjM5IjsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmlzY3YsaXNhID0gInJ2NjRpbWFmZGMi
Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjcHUwX2ludGM6IGludGVycnVwdC1jb250cm9sbGVyIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUg
PSAicmlzY3YsY3B1LWludGMiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0LWNvbnRyb2xsZXI7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAjYWRkcmVzcy1jZWxscyA9IDwwPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNpbnRlcnJ1cHQtY2VsbHMgPSA8
MT47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+ICvCoMKgwqDCoMKgwqDC
oH07Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqB4dGFsOiB4dGFsLWNsayB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgI2Nsb2NrLWNlbGxzID0gPDA+Owo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIFRoaXMgdmFsdWUgbXVzdCBiZSBvdmVycmlk
ZGVuIGJ5IHRoZSBib2FyZCAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNs
b2NrLWZyZXF1ZW5jeSA9IDwwPjsKPiA+ICvCoMKgwqDCoMKgwqDCoH07Cj4gPiArCj4gPiArwqDC
oMKgwqDCoMKgwqBzb2Mgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBh
dGlibGUgPSAic2ltcGxlLWJ1cyI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmFuZ2VzOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVycnVwdC1wYXJl
bnQgPSA8JnBsaWM+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRtYS1ub25j
b2hlcmVudDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjYWRkcmVzcy1jZWxs
cyA9IDwxPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjc2l6ZS1jZWxscyA9
IDwxPjsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1YXJ0MDogc2Vy
aWFsQDMwMDAyMDAwIHsKPiAKPiBJdCdzIHVuZm9ydHVuYXRlIHRoYXQgdGhlIFNESy9kb2N1bWVu
dGF0aW9uIGNhbGxzIHRoaXMgcGVyaXBoZXJhbAo+IGJvdGgKPiBVQVJUMCBhbmQgVUFSVDMuIEkg
ZG9uJ3Qga25vdyBpZiB3ZSBjYW4vc2hvdWxkIHB1dCB0aGUgIk0wIiBhbmQgIkQwIgo+IGJ1cwo+
IHBlcmlwaGVyYWxzIGluIHRoZSBzYW1lIERUOyBpdCBzZWVtcyBsaWtlIG1vc3Qgb2YgdGhlICJN
MCIKPiBwZXJpcGhlcmFscwo+IGFyZSBub3QgYWNjZXNzaWJsZSBmcm9tIHRoZSBDOTA2LiBCdXQg
aWYgd2UgZGlkLCB0aGlzIHdvdWxkIGNvbmZsaWN0Cj4gd2l0aCB0aGUgb3RoZXIgVUFSVDAuCgpU
aGV5J3JlIGFjY2Vzc2libGUgYnV0IHRoZWlyIGludGVycnVwdHMgYXJlIG5vdCwgYW5kIEkgdGhp
bmsgdGhpcyBpcwpjYWxsZWQgZDBfdWFydCBvciB1YXJ0MywgYnV0IG5vdCB1YXJ0MCBhdCBhbGwu
Cgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBj
b21wYXRpYmxlID0gImJvdWZmYWxvbGFiLGJsODA4LXVhcnQiOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWcgPSA8MHgzMDAwMjAwMCAweDEwMDA+
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnRl
cnJ1cHRzID0gPDIwIElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9ja3MgPSA8Jnh0YWw+Owo+IAo+IFRoZXJl
J3MgYSBjbG9jayBjb250cm9sbGVyIHdpdGggYSBtdXggYW5kIGEgZ2F0ZSBiZXR3ZWVuIHRoZSBj
cnlzdGFsCj4gYW5kCj4gdGhlIFVBUlQuIEknbSBub3Qgc3VyZSB3aGF0IHRoZSBwb2xpY3kgaXMg
YWJvdXQgYWRkaW5nICJmYWtlIgo+IHN1cHBsaWVycwo+IGJlZm9yZSB0aGUgcmVhbCBzdXBwbGll
ciBoYXMgYSBiaW5kaW5nIGRlZmluZWQuCj4gCj4gVW5mb3J0dW5hdGVseSwgQm91ZmZhbG9sYWIg
dGhyZXcgZXZlcnl0aGluZyBhbmQgdGhlIGtpdGNoZW4gc2luayBpbnRvCj4gdGhlIEdMQiByZWdp
c3RlciBzcGFjZSwgc28gdGhhdCBjb21wbGljYXRlcyBkZWZpbmluZyB0aGUgYmluZGluZyBmb3IK
PiB0aGUKPiBjbG9jay9yZXNldCBjb250cm9sbGVyIHBhcnQuCj4gCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBwbGljOiBpbnRlcnJ1cHQtY29udHJvbGxlckBlMDAwMDAwMCB7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBh
dGlibGUgPSAidGhlYWQsYzkwMC1wbGljIjsKClVzaW5nIGEgc2luZ2xlIGM5MDAtcGxpYyBoZXJl
IG5lZWRzIG1vcmUgZGlzY3Vzc2lvbiwgSSB0aGluay4KCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwweGUwMDAwMDAwIDB4NDAwMDAwMD47
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVy
cnVwdHMtZXh0ZW5kZWQgPSA8JmNwdTBfaW50Ywo+ID4gMHhmZmZmZmZmZj4sCj4gCj4gVGhlIEM5
MDYgUExJQyBoYXMgYW4gTS1tb2RlIGNvbnRleHQsIHNvIDB4ZmZmZmZmZmYgaXMgbm90IGNvcnJl
Y3QuCj4gVGhpcwo+IHNob3VsZCByZWZlcmVuY2UgdGhlIE0tbW9kZSBleHRlcm5hbCBpbnRlcnJ1
cHQuCj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JmNwdTBfaW50YyA5
PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50
ZXJydXB0LWNvbnRyb2xsZXI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCNhZGRyZXNzLWNlbGxzID0gPDA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjaW50ZXJydXB0LWNlbGxzID0gPDI+Owo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByaXNjdixuZGV2
ID0gPDY0PjsKPiAKPiBUaGUgU0RLL2RvY3VtZW50YXRpb24gbGlzdHMgSVJRIG51bWJlcnMgdXAg
dG8gQkw4MDhfSVJRX1BEUyA9PSA4Miwgc28KPiB0aGlzIHZhbHVlIHNob3VsZCBiZSBhdCBsZWFz
dCB0aGF0Lgo+IAo+IFJlZ2FyZHMsCj4gU2FtdWVsCj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgfTsKPiA+ICvCoMKgwqDCoMKgwqDCoH07Cj4gPiArfTsKPiAKPiAKPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGxpbnV4LXJpc2N2
IG1haWxpbmcgbGlzdAo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2Cgo=

