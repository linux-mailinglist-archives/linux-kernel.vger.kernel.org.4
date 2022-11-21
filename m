Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110AE6318F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 04:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKUDhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 22:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKUDhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 22:37:18 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B972A94E;
        Sun, 20 Nov 2022 19:37:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669001817; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=aDRve4Bh1riz39MgYUlVCLhIrfsqhw/jGfTDxsak0HwXyaO0ihITmT/KaxQ9GTzmQ2cjU3MYDbOOrtQn5N3iuW1WilW5WKHaTmX060KnrEzhN/31ccyB9QIywvbYSbRIpgx+B+Qt3G65tboggYdKhlvRlxaqLgPknU4lH5Y7UyY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669001817; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=DPud3lWL+Az2iSvY80r58tGURnnC/1tYpjYck5z06i4=; 
        b=aaYvoryJdCBAChcVHvySeDIoiUBJQspSTHkSeut0dyIaF2NJ0dYapmJlsPdNJFCKIaiWQCNlzEZIIkN8nBKkUaHeJSytguyj4Wn5u5QaVjM8bmp00PYCbIMJFjmCDDrGwJzybhvcv5GSafR9EM7qSQX5z/N/BMDa1triF9OqQAs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669001817;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=DPud3lWL+Az2iSvY80r58tGURnnC/1tYpjYck5z06i4=;
        b=OkMR19YWYRr67mLAeVIVrMBpwyYDbr69/IUbKpuZeDeCFK9d1P8XPPUDS9R/TYMB
        A+T6WMpUWeSnP+2nep46DQYDO7wWjh/9ulfi9pVMHeUcDRd9V0V5aZOEjnFscs1ZAjK
        zrSi7nNczGH0Em2zlfD4rnDfedaoVIV0hkjikXl8=
Received: from edelgard.fodlan.icenowy.me (112.94.100.29 [112.94.100.29]) by mx.zohomail.com
        with SMTPS id 1669001815235313.1942571311573; Sun, 20 Nov 2022 19:36:55 -0800 (PST)
Message-ID: <540beefcad5f9921068d54d056f168a4c45ffeaf.camel@icenowy.me>
Subject: Re: [PATCH 5/7] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Mon, 21 Nov 2022 11:36:50 +0800
In-Reply-To: <CAJM55Z_f=zp3Z=wno_yr7csAUMQ472RiZXD19CrDTTxmGAmU4w@mail.gmail.com>
References: <20221120082114.3030-1-jszhang@kernel.org>
         <20221120082114.3030-6-jszhang@kernel.org>
         <CAJM55Z_f=zp3Z=wno_yr7csAUMQ472RiZXD19CrDTTxmGAmU4w@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjItMTEtMjDmmJ/mnJ/ml6XnmoQgMTU6NTcgKzAxMDDvvIxFbWlsIFJlbm5lciBCZXJ0
aGluZ+WGmemBk++8mgo+IE9uIFN1biwgMjAgTm92IDIwMjIgYXQgMDk6MzIsIEppc2hlbmcgWmhh
bmcgPGpzemhhbmdAa2VybmVsLm9yZz4KPiB3cm90ZToKPiA+IAo+ID4gQWRkIGEgYmFpc2MgZHRz
aSBmb3IgdGhlIGJvdWZmYWxvbGFiIGJsODA4IFNvQy4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTog
SmlzaGVuZyBaaGFuZyA8anN6aGFuZ0BrZXJuZWwub3JnPgo+ID4gLS0tCj4gPiDCoGFyY2gvcmlz
Y3YvYm9vdC9kdHMvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsK
PiA+IMKgYXJjaC9yaXNjdi9ib290L2R0cy9ib3VmZmFsb2xhYi9ibDgwOC5kdHNpIHwgNzQKPiA+
ICsrKysrKysrKysrKysrKysrKysrKysKPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCA3NSBpbnNlcnRp
b25zKCspCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL2JvdWZm
YWxvbGFiL2JsODA4LmR0c2kKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9k
dHMvTWFrZWZpbGUKPiA+IGIvYXJjaC9yaXNjdi9ib290L2R0cy9NYWtlZmlsZQo+ID4gaW5kZXgg
ZmYxNzQ5OTZjZGZkLi5iNTI1NDY3MTUyYjIgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL3Jpc2N2L2Jv
b3QvZHRzL01ha2VmaWxlCj4gPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL01ha2VmaWxlCj4g
PiBAQCAtMSw0ICsxLDUgQEAKPiA+IMKgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MAo+ID4gK3N1YmRpci15ICs9IGJvdWZmYWxvbGFiCj4gPiDCoHN1YmRpci15ICs9IHNpZml2ZQo+
ID4gwqBzdWJkaXIteSArPSBzdGFyZml2ZQo+ID4gwqBzdWJkaXItJChDT05GSUdfU09DX0NBTkFB
Tl9LMjEwX0RUQl9CVUlMVElOKSArPSBjYW5hYW4KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2
L2Jvb3QvZHRzL2JvdWZmYWxvbGFiL2JsODA4LmR0c2kKPiA+IGIvYXJjaC9yaXNjdi9ib290L2R0
cy9ib3VmZmFsb2xhYi9ibDgwOC5kdHNpCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5jOThlYmIxNGVlMTAKPiA+IC0tLSAvZGV2L251bGwKPiA+ICsrKyBi
L2FyY2gvcmlzY3YvYm9vdC9kdHMvYm91ZmZhbG9sYWIvYmw4MDguZHRzaQo+ID4gQEAgLTAsMCAr
MSw3NCBAQAo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCsgb3IgTUlU
KQo+ID4gKy8qCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDIyIEppc2hlbmcgWmhhbmcgPGpzemhh
bmdAa2VybmVsLm9yZz4KPiA+ICsgKi8KPiA+ICsKPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
aW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+Cj4gPiArCj4gPiArLyB7Cj4gPiArwqDCoMKgwqDC
oMKgIGNvbXBhdGlibGUgPSAiYm91ZmZhbG9sYWIsYmw4MDgiOwo+ID4gK8KgwqDCoMKgwqDCoCAj
YWRkcmVzcy1jZWxscyA9IDwxPjsKPiA+ICvCoMKgwqDCoMKgwqAgI3NpemUtY2VsbHMgPSA8MT47
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIGNwdXMgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdGltZWJhc2UtZnJlcXVlbmN5ID0gPDEwMDAwMDA+Owo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8MT47Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsKPiA+ICsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNwdTA6IGNwdUAwIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInRoZWFkLGM5MDYiLCAicmlz
Y3YiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
dmljZV90eXBlID0gImNwdSI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmVnID0gPDA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGQtY2FjaGUtYmxvY2stc2l6ZSA9IDw2ND47Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZC1jYWNoZS1zZXRzID0gPDI1Nj47
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZC1jYWNo
ZS1zaXplID0gPDMyNzY4PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpLWNhY2hlLWJsb2NrLXNpemUgPSA8NjQ+Owo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGktY2FjaGUtc2V0cyA9IDwxMjg+Owo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGktY2FjaGUtc2l6
ZSA9IDwzMjc2OD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbW11LXR5cGUgPSAicmlzY3Ysc3YzOSI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmlzY3YsaXNhID0gInJ2NjRpbWFmZGMiOwo+ID4gKwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdTBfaW50
YzogaW50ZXJydXB0LWNvbnRyb2xsZXIgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInJpc2N2LGNw
dS1pbnRjIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaW50ZXJydXB0LWNvbnRyb2xsZXI7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNhZGRyZXNz
LWNlbGxzID0gPDA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjaW50ZXJydXB0LWNlbGxzID0gPDE+Owo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+ID4gK8KgwqDCoMKgwqDCoCB9Owo+ID4gKwo+ID4gK8Kg
wqDCoMKgwqDCoCB4dGFsOiB4dGFsLWNsayB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNsb2NrLWZyZXF1ZW5jeSA9IDw0MDAwMDAwMD47Cj4gCj4gVGhpcyB3YXMgZGlz
Y3Vzc2VkIG1hbnkgdGltZXMgYmVmb3JlLCBidXQgSSB0aGluayB0aGUgY29uY2x1c2lvbiB3YXMK
PiB0aGF0IHRoZSBmcmVxdWVuY3kgaXMgYSBwcm9wZXJ0eSBvZiB0aGUgY3J5c3RhbCBvbiB0aGUg
Ym9hcmQsIHNvIHRoaXMKPiBzaG91bGQgYmUgMCBpbiB0aGUgU29DIGR0c2ksIGFuZCB0aGVuIG92
ZXJ3cml0dGVuIGluIHRoZSBib2FyZCBkZXZpY2UKPiB0cmVlLgoKQnV0IG1hbnkgY2hpcHMganVz
dCBzcGVjaWZ5IGFuIGFjY2VwdGVkIGZyZXF1ZW5jeSBpbiB0aGVpciBkYXRhc2hlZXQsCmFuZCB1
c2luZyBhIGZyZXF1ZW5jeSBvdGhlciB0aGFuIHRoaXMgaXMgdW5kZWZpbmVkIGJlaGF2aW9yLgoK
PiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2NrLW91dHB1dC1uYW1lcyA9
ICJ4dGFsIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNjbG9jay1jZWxscyA9
IDwwPjsKPiA+ICvCoMKgwqDCoMKgwqAgfTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgc29jIHsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAic2ltcGxlLWJ1
cyI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYW5nZXM7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHQtcGFyZW50ID0gPCZwbGljPjsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYS1ub25jb2hlcmVudDsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDE+Owo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgI3NpemUtY2VsbHMgPSA8MT47Cj4gPiArCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1YXJ0MDogc2VyaWFsQDMwMDAyMDAwIHsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImJv
dWZmYWxvbGFiLHVhcnQiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJlZyA9IDwweDMwMDAyMDAwIDB4MTAwMD47Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50ZXJydXB0cyA9IDwyMCBJUlFfVFlQRV9M
RVZFTF9ISUdIPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjbG9ja3MgPSA8Jnh0YWw+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cGxpYzogaW50ZXJydXB0LWNvbnRyb2xsZXJAZTAwMDAwMDAgewo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAidGhlYWQsYzkwMC1w
bGljIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZWcgPSA8MHhlMDAwMDAwMCAweDQwMDAwMDA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludGVycnVwdHMtZXh0ZW5kZWQgPSA8JmNwdTBfaW50Ywo+
ID4gMHhmZmZmZmZmZj4sCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JmNw
dTBfaW50YyA5PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpbnRlcnJ1cHQtY29udHJvbGxlcjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwwPjsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjaW50ZXJydXB0LWNlbGxzID0gPDI+
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJpc2N2
LG5kZXYgPSA8NjQ+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+ICvC
oMKgwqDCoMKgwqAgfTsKPiA+ICt9Owo+ID4gLS0KPiA+IDIuMzcuMgo+ID4gCj4gPiAKPiA+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBsaW51eC1y
aXNjdiBtYWlsaW5nIGxpc3QKPiA+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcKPiA+
IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YK
PiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGxp
bnV4LXJpc2N2IG1haWxpbmcgbGlzdAo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcK
PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2
Cgo=

