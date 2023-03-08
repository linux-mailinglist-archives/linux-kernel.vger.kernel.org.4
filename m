Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AAD6B09B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjCHNqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjCHNon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:44:43 -0500
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7B513D4D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:43:32 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWtnH3fThzMr2Tq;
        Wed,  8 Mar 2023 14:43:31 +0100 (CET)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWtnG6FGhzMsTWG;
        Wed,  8 Mar 2023 14:43:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678283011;
        bh=tyKmsDlAQD9+lFicrsaKGhfFm/M0KQNH6VuicVoojQY=;
        h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
        b=cH1T67o3jLgKA5u5KZ9ZR4Ki/nrzw3MTaH0ib3qjsjkD4iY+ZLl1dHBFzvZKpMKXA
         ZoVXk9GYLRlKgVsvdAhwifJxFYpcpaUxy28Lt8nXMb49ce4YEA8JfRtrJUD6eBhjVj
         WP16tmnoDTUeDvaYfl9wJA0MS5z7nP64bF8BRJK4=
Message-ID: <3730a506119804b5740854c74d1558010ce37b47.camel@pschenker.ch>
Subject: Re: [PATCH v1 17/25] arm64: dts: colibri-imx8x: eval: Add spi-to-can
From:   Philippe Schenker <dev@pschenker.ch>
Reply-To: dev@pschenker.ch
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 08 Mar 2023 14:43:30 +0100
In-Reply-To: <07e64710-6b91-9da6-f483-03706b7ea95a@linaro.org>
References: <20230308125300.58244-1-dev@pschenker.ch>
         <20230308125300.58244-18-dev@pschenker.ch>
         <07e64710-6b91-9da6-f483-03706b7ea95a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTA4IGF0IDE0OjAwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOgo+IE9uIDA4LzAzLzIwMjMgMTM6NTIsIFBoaWxpcHBlIFNjaGVua2VyIHdyb3RlOgo+ID4g
RnJvbTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPgo+
ID4gCj4gPiBBZGQgbWNwMjUxNSBzcGktdG8tY2FuIHRvICZscHNwaTIuCj4gPiAKPiA+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNv
bT4KPiA+IC0tLQo+ID4gCj4gPiDCoC4uLi9kdHMvZnJlZXNjYWxlL2lteDh4LWNvbGlicmktZXZh
bC12My5kdHNpwqAgfCAxOQo+ID4gKysrKysrKysrKysrKysrKysrKwo+ID4gwqAxIGZpbGUgY2hh
bmdlZCwgMTkgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OHgtY29saWJyaS1ldmFsLQo+ID4gdjMuZHRzaSBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDh4LWNvbGlicmktZXZhbC12My5kdHNpCj4gPiBp
bmRleCA2MjVkMmNhYWY1ZDEuLmU3ZTNjZjQ2MjQwOCAxMDA2NDQKPiA+IC0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDh4LWNvbGlicmktZXZhbC12My5kdHNpCj4gPiArKysg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4eC1jb2xpYnJpLWV2YWwtdjMuZHRz
aQo+IAo+IFRoZXJlIGlzIG5vIHN1Y2ggZmlsZS4KClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayEK
ClRoaXMgZmlsZSBpcyBiZWluZyBjcmVhdGVkIGludCBoZSBmaXJzdCBwYXRjaCBpbiB0aGUgc2Vy
aWVzLgoKPiAKPiA+IEBAIC0xMSw2ICsxMSwxMyBAQCBhbGlhc2VzIHsKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcnRjMSA9ICZydGM7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgfTsK
PiA+IMKgCj4gPiArwqDCoMKgwqDCoMKgwqAvKiBmaXhlZCBjcnlzdGFsIGRlZGljYXRlZCB0byBt
Y3AyNXh4ICovCj4gPiArwqDCoMKgwqDCoMKgwqBjbGsxNm06IGNsb2NrLTE2bWh6LWZpeGVkIHsK
PiAKPiBEcm9wICJmaXhlZCIuCgpJJ2xsIHByZXBhcmUgYSB2MiBhbmQgcGxhbiB0byBzZW5kIGl0
IG91dCBiZWdpbm5pbmcgb2YgbmV4dCB3ZWVrLgoKPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBjb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAjY2xvY2stY2VsbHMgPSA8MD47Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgY2xvY2stZnJlcXVlbmN5ID0gPDE2MDAwMDAwPjsKPiA+ICvCoMKgwqDC
oMKgwqDCoH07Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoMKgZ3Bpby1rZXlzIHsKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJncGlvLWtleXMiOwo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQi
Owo+ID4gQEAgLTQ0LDYgKzUxLDE4IEBAIHJ0Y19pMmM6IHJ0Y0A2OCB7Cj4gPiDCoC8qIENvbGli
cmkgU1BJICovCj4gPiDCoCZscHNwaTIgewo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0YXR1cyA9ICJv
a2F5IjsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoG1jcDI1MTU6IGNhbkAwIHsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtY3AyNTE1
IjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWcgPSA8MD47Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0LXBhcmVudCA9IDwmbHNpb19ncGlv
Mz47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0cyA9IDwxMyBJ
UlFfVFlQRV9FREdFX0ZBTExJTkc+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHBpbmN0cmwtMCA9IDwmcGluY3RybF9jYW5faW50PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGNsb2NrcyA9IDwmY2xrMTZtPjsKPiAKPiBZb3UganVzdCBzb3J0ZWQg
YWxsIG5vZGVzIGluIHByZXZpb3VzIHBhdGNoZXMgYW5kIGFkZCBzb21ldGhpbmcKPiB1bnNvcnRl
ZD8gV2hhdCBpcyB0aGVuIHRoZSBzdHlsZSBvZiBvcmRlcj8gUmFuZG9tIG5hbWU/CgpNeSBsb2dp
YyBiZWhpbmQgdGhpcyBvbmUgaXMKCjEuIGNvbXBhdGlibGUgcHJvcGVydHkKMi4gcmVnIHByb3Bl
cnR5CjMuIHN0YW5kYXJkIHByb3BlcnRpZXMgCiAgIC0gZmlyc3QgaW50ZXJydXB0CiAgIC0gdGhl
biBwaW5jdHJsCjQuIHNwZWNpZmljIHByb3BlcnRpZXMKICAgLSBhZ2FpbiBhbHBoYWJldGljYWxs
eTogY2xvY2tzLCBzcGktbWF4LWZyZXF1ZW5jeQo1LiBzdGF0dXMKCkhvdyB3b3VsZCB5b3UgZG8g
aXQ/Cgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwaS1tYXgtZnJlcXVl
bmN5ID0gPDEwMDAwMDAwPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0
dXMgPSAib2theSI7Cj4gCj4gV2h5IGRvIHlvdSBuZWVkIGl0PwoKVGhpcyBjaGlwIGlzIHBsYWNl
ZCBvbiBvdXIgZXZhbC1ib2FyZCBhbmQgd2UgdXN1YWxseSB0cnkgdG8gZW5hYmxlIGl0IHNvCnNv
bWVvbmUgY2FuIHJpZ2h0IGF3YXkgdXNlIENBTi4KCj4gCj4gPiArwqDCoMKgwqDCoMKgwqB9Owo+
ID4gwqB9Owo+ID4gwqAKPiA+IMKgLyogQ29saWJyaSBVQVJUX0IgKi8KPiAKPiBCZXN0IHJlZ2Fy
ZHMsCj4gS3J6eXN6dG9mCj4gCgo=

