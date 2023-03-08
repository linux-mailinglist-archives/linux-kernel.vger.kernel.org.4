Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779716B0AC4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjCHOOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjCHON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:13:57 -0500
X-Greylist: delayed 2596 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 06:12:49 PST
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E232C7085
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:12:48 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWvR32CmfzMrXSn;
        Wed,  8 Mar 2023 15:12:47 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWvR24YypzMslsf;
        Wed,  8 Mar 2023 15:12:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678284767;
        bh=WrlHTBrezRUb+ZKhea5biLw3bhhxS6dMpZxCWWjM7HY=;
        h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
        b=wbPqVUr3XbO0KuHZ80dhydiruIY/kpaKs6Dsvw6qbHjMKssOFfBhgOWQ1UOQZB2zD
         nFjM5JwjgBvnxYJhQZtoW/hlJynvhtC0zl2yt9TwugoTgdGm2MQaNHpN296PxjsZat
         nybB2ijojcaY9AEmmDPRPM5jm94FwI03DFHLgTbA=
Message-ID: <897936e47217205feaf07d6de67f70aed97f48dc.camel@pschenker.ch>
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
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 08 Mar 2023 15:12:46 +0100
In-Reply-To: <07e64710-6b91-9da6-f483-03706b7ea95a@linaro.org>
References: <20230308125300.58244-1-dev@pschenker.ch>
         <20230308125300.58244-18-dev@pschenker.ch>
         <07e64710-6b91-9da6-f483-03706b7ea95a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
aQo+IAo+IFRoZXJlIGlzIG5vIHN1Y2ggZmlsZS4KPiAKPiA+IEBAIC0xMSw2ICsxMSwxMyBAQCBh
bGlhc2VzIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcnRjMSA9ICZydGM7
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+IMKgCj4gPiArwqDCoMKgwqDCoMKgwqAvKiBmaXhl
ZCBjcnlzdGFsIGRlZGljYXRlZCB0byBtY3AyNXh4ICovCj4gPiArwqDCoMKgwqDCoMKgwqBjbGsx
Nm06IGNsb2NrLTE2bWh6LWZpeGVkIHsKPiAKPiBEcm9wICJmaXhlZCIuCj4gCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgI2Nsb2NrLWNlbGxzID0gPDA+Owo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrLWZyZXF1ZW5jeSA9IDwxNjAwMDAwMD47
Cj4gPiArwqDCoMKgwqDCoMKgwqB9Owo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqDCoGdwaW8ta2V5
cyB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAiZ3Bp
by1rZXlzIjsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IjsKPiA+IEBAIC00NCw2ICs1MSwxOCBAQCBydGNfaTJjOiBydGNANjggewo+
ID4gwqAvKiBDb2xpYnJpIFNQSSAqLwo+ID4gwqAmbHBzcGkyIHsKPiA+IMKgwqDCoMKgwqDCoMKg
wqBzdGF0dXMgPSAib2theSI7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBtY3AyNTE1OiBjYW5A
MCB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJtaWNy
b2NoaXAsbWNwMjUxNSI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0g
PDA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVycnVwdC1wYXJlbnQg
PSA8JmxzaW9fZ3BpbzM+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVy
cnVwdHMgPSA8MTMgSVJRX1RZUEVfRURHRV9GQUxMSU5HPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfY2FuX2ludD47Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9ja3MgPSA8JmNsazE2bT47Cj4gCj4gWW91
IGp1c3Qgc29ydGVkIGFsbCBub2RlcyBpbiBwcmV2aW91cyBwYXRjaGVzIGFuZCBhZGQgc29tZXRo
aW5nCj4gdW5zb3J0ZWQ/IFdoYXQgaXMgdGhlbiB0aGUgc3R5bGUgb2Ygb3JkZXI/IFJhbmRvbSBu
YW1lPwo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwaS1tYXgtZnJlcXVl
bmN5ID0gPDEwMDAwMDAwPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0
dXMgPSAib2theSI7Cj4gCj4gV2h5IGRvIHlvdSBuZWVkIGl0PwoKT2ssIG5vdyBJIGtub3cgd2hh
dCB5b3UgbWVhbi4gV2lsbCByZW1vdmUgaXQgaW4gdjIuCgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKg
fTsKPiA+IMKgfTsKPiA+IMKgCj4gPiDCoC8qIENvbGlicmkgVUFSVF9CICovCj4gCj4gQmVzdCBy
ZWdhcmRzLAo+IEtyenlzenRvZgo+IAoK

