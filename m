Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127376D5B4F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjDDI4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjDDI4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:56:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97AB1735;
        Tue,  4 Apr 2023 01:56:12 -0700 (PDT)
Received: from [IPv6:2a00:23c7:6883:e501:e15b:407b:49da:d40e] (unknown [IPv6:2a00:23c7:6883:e501:e15b:407b:49da:d40e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F0656660312E;
        Tue,  4 Apr 2023 09:56:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680598571;
        bh=dmw4agSXfIQ/8qZuFX76Gw++1/H8qwLlzVcoLQiWdL4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JE4UxCzKD8diQjGDlsfvZVUHT0kV7ba5z7Y/jk/4Sn4fHYkPqFxHq1jFrBp6CC6JS
         238j9b53QjJVJFDiqc9cx9N9r9fq6v0EUGXeNrvTbpUf9IWXcxuHBQpCUM8weWUyyK
         0HQ4gWh1PUwXRzpTOAPLGzNJWxXlSg8cSn0vNV+uTcDEjvKpxSI0aLhmcgEeacql8H
         2R0N607E8H79Y9kFOqoFf+UeZK7+Jnb6bXYU42OVhkORjmvttlM9S2EPmGsvnZEnUz
         45LuVMxI0fog0dWudHGQ1jP6QMeulFVb4EUt8jhbJLeH/sNX02dwj5eqmUPx+q/Cyg
         BH3rvkqpNZexA==
Message-ID: <47ef157dfcceaaa2c9487cfe51400029a04ade94.camel@collabora.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rk3588-rock-5b: Add pwm-fan
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Date:   Tue, 04 Apr 2023 09:56:08 +0100
In-Reply-To: <20230403105052.426135-3-cristian.ciocaltea@collabora.com>
References: <20230403105052.426135-1-cristian.ciocaltea@collabora.com>
         <20230403105052.426135-3-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ3Jpc3RpYW4sCgpPbiBNb24sIDIwMjMtMDQtMDMgYXQgMTM6NTAgKzAzMDAsIENyaXN0aWFu
IENpb2NhbHRlYSB3cm90ZToKPiBBZGQgdGhlIG5lY2Vzc2FyeSBEVCBjaGFuZ2VzIGZvciB0aGUg
Um9jayA1QiBib2FyZCB0byBlbmFibGUgc3VwcG9ydCBmb3IKPiB0aGUgUFdNIGNvbnRyb2xsZWQg
aGVhdCBzaW5rIGZhbi4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDcmlzdGlhbiBDaW9jYWx0ZWEgPGNy
aXN0aWFuLmNpb2NhbHRlYUBjb2xsYWJvcmEuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdG9waGVy
IE9iYmFyZCA8Y2hyaXMub2JiYXJkQGNvbGxhYm9yYS5jb20+Cgo+IC0tLQo+IMKgYXJjaC9hcm02
NC9ib290L2R0cy9yb2NrY2hpcC9yazM1ODgtcm9jay01Yi5kdHMgfCAxMiArKysrKysrKysrKysK
PiDCoDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszNTg4LXJvY2stNWIuZHRzIGIvYXJjaC9hcm02
NC9ib290L2R0cy9yb2NrY2hpcC9yazM1ODgtcm9jay01Yi5kdHMKPiBpbmRleCA5NTgwNWNiMGFk
ZmEuLmJkNzRkOWRhMmMxNyAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tj
aGlwL3JrMzU4OC1yb2NrLTViLmR0cwo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2No
aXAvcmszNTg4LXJvY2stNWIuZHRzCj4gQEAgLTE3LDYgKzE3LDE0IEBAIGNob3NlbiB7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGRvdXQtcGF0aCA9ICJzZXJpYWwyOjE1MDAw
MDBuOCI7Cj4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gwqAKPiArwqDCoMKgwqDCoMKgwqBmYW46IHB3
bS1mYW4gewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gInB3
bS1mYW4iOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb29saW5nLWxldmVscyA9
IDwwIDk1IDE0NSAxOTUgMjU1PjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZmFu
LXN1cHBseSA9IDwmdmNjNXYwX3N5cz47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHB3bXMgPSA8JnB3bTEgMCA1MDAwMCAwPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgI2Nvb2xpbmctY2VsbHMgPSA8Mj47Cj4gK8KgwqDCoMKgwqDCoMKgfTsKPiArCj4gwqDCoMKg
wqDCoMKgwqDCoHZjYzV2MF9zeXM6IHZjYzV2MC1zeXMtcmVndWxhdG9yIHsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ3VsYXRvci1uYW1lID0gInZjYzV2MF9z
eXMiOwo+IEBAIC0yNyw2ICszNSwxMCBAQCB2Y2M1djBfc3lzOiB2Y2M1djAtc3lzLXJlZ3VsYXRv
ciB7Cj4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gwqB9Owo+IMKgCj4gKyZwd20xIHsKPiArwqDCoMKg
wqDCoMKgwqBzdGF0dXMgPSAib2theSI7Cj4gK307Cj4gKwo+IMKgJnNkaGNpIHsKPiDCoMKgwqDC
oMKgwqDCoMKgYnVzLXdpZHRoID0gPDg+Owo+IMKgwqDCoMKgwqDCoMKgwqBuby1zZGlvOwo+IC0t
IAo+IDIuNDAuMAo+IAo+IAo=

