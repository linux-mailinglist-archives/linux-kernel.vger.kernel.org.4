Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECB1658989
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 06:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiL2FZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 00:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiL2FZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 00:25:50 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D95B5B;
        Wed, 28 Dec 2022 21:25:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672291509; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=m10Ebk3aFUEusqoGNLlpxwFQi/8DWKYjXTyCjzzUmTqFMZmjNpWfDKNC9fKP71nd5wp65652FwCMj1zADIDPHZtxmZfOHvFypRgCxe39X2oZHRiQk21ox8XULir8yvAKoD21J0qR9/oD3NsiZ0qLC7TV5KuctKRIqvayKsz6f2M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1672291509; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NAS0fK/e8lDKFjnrjwgoQpECmXMWsHoHrb0rCyC3ck8=; 
        b=m5QMiVBDG47IPeFiPZ6fqnZrucNYwFmMPy4eTsUYOgSavo3xVXRgZVMkkkYGCwWwvF36woBrlux3WkRpaREj6Rs4at/0Phsd3kI9Q1PrdifCsb6GUonuytgoh65luSDZUkqw2z1DAnEy8q6I+4glebk0TGu4xQIZ92A0AnOx6qE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672291509;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=NAS0fK/e8lDKFjnrjwgoQpECmXMWsHoHrb0rCyC3ck8=;
        b=cGLVsoIm5IqTfymLYR8j58s+Fhe8ELb7z3A30/tu0vULQJE8rPUslmMsBvBvjh6L
        lao5aSRTcPvgs+wYYg8hLTDnKTgKuc7a9s9KMxY9U67K3NCvOqWWTdH+A1ugQ8/rxEQ
        NtVIt/At77P6bUxO5S2sdro4PjJP10QbL0RLYaWI=
Received: from edelgard.fodlan.icenowy.me (120.85.98.122 [120.85.98.122]) by mx.zohomail.com
        with SMTPS id 1672291506328914.6557228533895; Wed, 28 Dec 2022 21:25:06 -0800 (PST)
Message-ID: <dda144a8397a175f3ce092485f08896c9a66d232.camel@icenowy.me>
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive
 JH7110 device tree
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor Dooley <conor@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 29 Dec 2022 13:25:00 +0800
In-Reply-To: <Y6zHy9oL4xzl+6Rd@spud>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
         <20221220011247.35560-7-hal.feng@starfivetech.com> <Y6zHy9oL4xzl+6Rd@spud>
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

5ZyoIDIwMjItMTItMjjmmJ/mnJ/kuInnmoQgMjI6NDggKzAwMDDvvIxDb25vciBEb29sZXnlhpnp
gZPvvJoKPiBIZXksCj4gCj4gT24gVHVlLCBEZWMgMjAsIDIwMjIgYXQgMDk6MTI6NDZBTSArMDgw
MCwgSGFsIEZlbmcgd3JvdGU6Cj4gPiBGcm9tOiBFbWlsIFJlbm5lciBCZXJ0aGluZyA8a2VybmVs
QGVzbWlsLmRrPgo+ID4gCj4gPiBBZGQgaW5pdGlhbCBkZXZpY2UgdHJlZSBmb3IgdGhlIEpINzEx
MCBSSVNDLVYgU29DIGJ5IFN0YXJGaXZlCj4gPiBUZWNobm9sb2d5IEx0ZC4KPiA+IAo+ID4gU2ln
bmVkLW9mZi1ieTogRW1pbCBSZW5uZXIgQmVydGhpbmcgPGtlcm5lbEBlc21pbC5kaz4KPiA+IENv
LWRldmVsb3BlZC1ieTogSmlhbmxvbmcgSHVhbmcgPGppYW5sb25nLmh1YW5nQHN0YXJmaXZldGVj
aC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFubG9uZyBIdWFuZyA8amlhbmxvbmcuaHVhbmdA
c3RhcmZpdmV0ZWNoLmNvbT4KPiA+IENvLWRldmVsb3BlZC1ieTogSGFsIEZlbmcgPGhhbC5mZW5n
QHN0YXJmaXZldGVjaC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWwgRmVuZyA8aGFsLmZlbmdA
c3RhcmZpdmV0ZWNoLmNvbT4KPiA+IC0tLQo+ID4gwqBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJm
aXZlL2poNzExMC5kdHNpIHwgNDExCj4gPiArKysrKysrKysrKysrKysrKysrKysrKwo+ID4gwqAx
IGZpbGUgY2hhbmdlZCwgNDExIGluc2VydGlvbnMoKykKPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0
IGFyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLmR0c2kKPiA+IAo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLmR0c2kKPiA+IGIvYXJj
aC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAuZHRzaQo+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQKPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNjRkMjYwZWExZjI5Cj4gPiAtLS0gL2Rldi9u
dWxsCj4gPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC5kdHNpCj4g
PiBAQCAtMCwwICsxLDQxMSBAQAo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wIE9SIE1JVAo+ID4gKy8qCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDIyIFN0YXJGaXZlIFRl
Y2hub2xvZ3kgQ28uLCBMdGQuCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDIyIEVtaWwgUmVubmVy
IEJlcnRoaW5nIDxrZXJuZWxAZXNtaWwuZGs+Cj4gPiArICovCj4gPiArCj4gPiArL2R0cy12MS87
Cj4gPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL3N0YXJmaXZlLGpoNzExMC1jcmcuaD4K
PiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcmVzZXQvc3RhcmZpdmUsamg3MTEwLWNyZy5oPgo+
ID4gKwo+ID4gKy8gewo+ID4gK8KgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJzdGFyZml2ZSxq
aDcxMTAiOwo+ID4gK8KgwqDCoMKgwqDCoMKgI2FkZHJlc3MtY2VsbHMgPSA8Mj47Cj4gPiArwqDC
oMKgwqDCoMKgwqAjc2l6ZS1jZWxscyA9IDwyPjsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGNw
dXMgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNhZGRyZXNzLWNlbGxzID0g
PDE+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNzaXplLWNlbGxzID0gPDA+
Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFM3Nl8wOiBjcHVAMCB7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBh
dGlibGUgPSAic2lmaXZlLHU3NC1tYyIsICJyaXNjdiI7Cj4gCj4gVGhlIGxhYmVsIGhlcmUgc2F5
cyBTNzYgYnV0IHRoZSBjb21wYXRpYmxlIHNheXMgdTc0LW1jLgo+IFdoaWNoIGlzIGNvcnJlY3Q/
IFlvdXIgZG9jcyBzYXkgUzcgYW5kIFM3Niwgc28gSSB3b3VsZCBpbWFnaW5lIHRoYXQKPiBpdAo+
IGlzIGFjdHVhbGx5IGFuIFM3Nj8KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkLWNhY2hlLWJsb2NrLXNpemUgPSA8NjQ+Owo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkLWNhY2hlLXNldHMg
PSA8NjQ+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBkLWNhY2hlLXNpemUgPSA8ODE5Mj47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGQtdGxiLXNldHMgPSA8MT47Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGQtdGxiLXNpemUgPSA8NDA+Owo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZpY2VfdHlwZSA9
ICJjcHUiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpLWNhY2hlLWJsb2NrLXNpemUgPSA8NjQ+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpLWNhY2hlLXNldHMgPSA8NjQ+Owo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpLWNhY2hlLXNpemUgPSA8MTYz
ODQ+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
LXRsYi1zZXRzID0gPDE+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpLXRsYi1zaXplID0gPDQwPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW11LXR5cGUgPSAicmlzY3Ysc3YzOSI7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5leHQtbGV2ZWwtY2Fj
aGUgPSA8JmNjYWNoZT47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJpc2N2LGlzYSA9ICJydjY0aW1hYyI7Cj4gCj4gV2hpbGUgSSB3YXMgcG9raW5n
IGFyb3VuZCB0cnlpbmcgdG8gc2VlIGlmIHRoZXJlIHdhcyBzb21lIGxvZ2ljCj4gYmVoaW5kCj4g
dGhhdCBjb21wYXRpYmxlLCBJIG5vdGljZWQgdGhhdCBTaUZpdmUncyBkb2NzIGZvciB0aGUgUzc2
IHNheSBpdCBpcwo+IFJWNjRHQkMgKmJ1dCogdGhlIGRvY3MgZm9yIHRoZSB1NzQtbWMgc2F5ICI0
eFJWNjRHQkMgYW5kIDF4UlY2NElNQUMiLgo+IEkgYXNzdW1lIHRoYXQgcnY2NGltYWMgaXMgdGhl
IGNvcnJlY3Qgb25lIGhlcmU/Cj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHRsYi1zcGxpdDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RhdHVzID0gImRpc2FibGVkIjsKPiA+ICsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3B1MF9pbnRjOiBpbnRl
cnJ1cHQtY29udHJvbGxlciB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gInJpc2N2LGNwdS1pbnRj
IjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGludGVycnVwdC1jb250cm9sbGVyOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgI2ludGVycnVwdC1j
ZWxscyA9IDwxPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgfTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gKwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFU3NF8xOiBjcHVAMSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAic2lm
aXZlLHU3NC1tYyIsICJyaXNjdiI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwxPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZC1jYWNoZS1ibG9jay1zaXplID0gPDY0PjsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZC1jYWNoZS1zZXRzID0g
PDY0PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZC1jYWNoZS1zaXplID0gPDMyNzY4PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZC10bGItc2V0cyA9IDwxPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZC10bGItc2l6ZSA9IDw0MD47Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldmljZV90eXBlID0g
ImNwdSI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGktY2FjaGUtYmxvY2stc2l6ZSA9IDw2ND47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGktY2FjaGUtc2V0cyA9IDw2ND47Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGktY2FjaGUtc2l6ZSA9IDwzMjc2
OD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGkt
dGxiLXNldHMgPSA8MT47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGktdGxiLXNpemUgPSA8NDA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtbXUtdHlwZSA9ICJyaXNjdixzdjM5IjsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmV4dC1sZXZlbC1jYWNo
ZSA9IDwmY2NhY2hlPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmlzY3YsaXNhID0gInJ2NjRpbWFmZGMiOwo+IAo+IFRoYXQgYWxzbyBiZWdzIHRo
ZSBxdWVzdGlvbjoKPiBEbyB5b3VyIHU3NHMgc3VwcG9ydCBSVjY0R0JDLCBhcyB0aGUgKGN1cnJl
bnQpIFNpRml2ZSBkb2N1bWVudGF0aW9uCj4gc3VnZ2VzdHM/CgpJdCBzdXBwb3J0cyBSVjY0R0Na
YmFaYmIuCgpCIGlzIG5vdCBhIHdlbGwtZGVmaW5lZCB0aGluZyBieSBzcGVjaWZpY2F0aW9ucywg
c28gaXQgc2hvdWxkIGJlCnByZXZlbnRlZCBoZXJlLgoKPiAKPiBUaGFua3MsCj4gQ29ub3IuCj4g
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsaW51
eC1yaXNjdiBtYWlsaW5nIGxpc3QKPiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnCj4g
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdgoK


