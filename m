Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28D76D5FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbjDDMJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbjDDMHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:07:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DB03AB5;
        Tue,  4 Apr 2023 05:03:10 -0700 (PDT)
Received: from [IPv6:2a00:23c7:6883:e501:e15b:407b:49da:d40e] (unknown [IPv6:2a00:23c7:6883:e501:e15b:407b:49da:d40e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E6A26603158;
        Tue,  4 Apr 2023 13:03:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680609789;
        bh=EqCuUIa26dLCJIvyIcfxXwu2vSGTNNCWYPJnB/cNK2Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Tz0SoriJge1fjbnmAt9vwvUlwVBBreEh0NihySKYb4y97SmwkCYB2pIBWJvFPYQgg
         6T3XOohm875kZRmwGTDLmR/Giq81x/IEiLDxZhX5DgPoMZBRJGa6GQdKO7ORiy4xix
         FVf/yMEGnROX3NVpT52V+6ClFpYWgDjMfVMVprOU3oU8Q6umoM+sYMkZI93rsmKTCo
         zM3o+ocwH4hS/U7vi5fCKEACeMXUoUOWr+IdLLOs4LK7QLYd4ISW0OV3uOLUgUi5P4
         DeEo6HfFlZg8DawlvwposK3DhNv+R/yopCYWzGIJNPsWapqVRa6OD//jUs/io9ISff
         9RgQMqsJCK3cQ==
Message-ID: <b1c27c7499660d0601927e8fdc5e9b1f6c691e57.camel@collabora.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add RTC support for RK3588
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Date:   Tue, 04 Apr 2023 13:03:07 +0100
In-Reply-To: <20230404115802.33693-1-shreeya.patel@collabora.com>
References: <20230404115802.33693-1-shreeya.patel@collabora.com>
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

SGkgU2hyZWV5YSwKCk9uIFR1ZSwgMjAyMy0wNC0wNCBhdCAxNzoyOCArMDUzMCwgU2hyZWV5YSBQ
YXRlbCB3cm90ZToKPiBBZGQgRFQgbm9kZSB0byBlbmFibGUgUlRDIHN1cHBvcnQgb24gUkszNTg4
IGJvYXJkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNocmVleWEgUGF0ZWwgPHNocmVleWEucGF0ZWxA
Y29sbGFib3JhLmNvbT4KCm5pdDogSXQnZCBiZSBncmVhdCB0byBtYWtlIHRoZSBzdWJqZWN0IHNv
bWV0aGluZyBtb3JlIGRlc2NyaXB0aXZlIGFib3V0IHRoZSBzdXBwb3J0ZWQgaGFyZHdhcmUsIHNp
bmNlIHRoaXMgcGF0Y2ggZG9lc24ndCBlbmFibGUgdGhlIFJUQyBmb3IgX2FsbF8gUkszNTg4IGJv
YXJkcyB5b3VyIHN1YmplY3QgY291bGQgYmUgYSBiaXQgbWlzbGVhZGluZy4KU29tZXRoaW5nIGxp
a2UgImFybTY0OiBkdHM6IHJvY2tjaGlwOiBFbmFibGUgUlRDIHN1cHBvcnQgZm9yIFJvY2sgNUIi
IGNvdWxkIGJlIGJldHRlci4KClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlciBPYmJhcmQgPGNocmlz
Lm9iYmFyZEBjb2xsYWJvcmEuY29tPgoKPiAtLS0KPiDCoC4uLi9ib290L2R0cy9yb2NrY2hpcC9y
azM1ODgtcm9jay01Yi5kdHPCoMKgwqDCoMKgIHwgMjcgKysrKysrKysrKysrKysrKysrKwo+IMKg
MSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm02NC9ib290L2R0cy9yb2NrY2hpcC9yazM1ODgtcm9jay01Yi5kdHMgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL3JvY2tjaGlwL3JrMzU4OC1yb2NrLTViLmR0cwo+IGluZGV4IDk1ODA1Y2IwYWRmYS4u
YTMyYmZhOGQ5MTRhIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAv
cmszNTg4LXJvY2stNWIuZHRzCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9y
azM1ODgtcm9jay01Yi5kdHMKPiBAQCAtMjcsNiArMjcsMzEgQEAgdmNjNXYwX3N5czogdmNjNXYw
LXN5cy1yZWd1bGF0b3Igewo+IMKgwqDCoMKgwqDCoMKgwqB9Owo+IMKgfTsKPiDCoAo+ICsmaTJj
NiB7Cj4gK8KgwqDCoMKgwqDCoMKgc3RhdHVzID0gIm9rYXkiOwo+ICsKPiArwqDCoMKgwqDCoMKg
wqBoeW04NTYzOiBoeW04NTYzQDUxIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Y29tcGF0aWJsZSA9ICJoYW95dSxoeW04NTYzIjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmVnID0gPDB4NTE+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjY2xv
Y2stY2VsbHMgPSA8MD47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrLWZy
ZXF1ZW5jeSA9IDwzMjc2OD47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2Nr
LW91dHB1dC1uYW1lcyA9ICJoeW04NTYzIjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcGluY3RybC0wID0gPCZoeW04NTYzX2ludD47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8wPjsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0cyA9IDxSS19QQjAgSVJRX1RZUEVfTEVWRUxfTE9XPjsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd2FrZXVwLXNvdXJjZTsKPiArwqDCoMKg
wqDCoMKgwqB9Owo+ICt9Owo+ICsKPiArJnBpbmN0cmwgewo+ICvCoMKgwqDCoMKgwqDCoGh5bTg1
NjMgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBoeW04NTYzX2ludDogaHltODU2
My1pbnQgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cm9ja2NoaXAscGlucyA9IDwwIFJLX1BCMCBSS19GVU5DX0dQSU8gJnBjZmdfcHVsbF9ub25lPjsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiArwqDCoMKgwqDCoMKgwqB9Owo+
ICt9Owo+ICsKPiDCoCZzZGhjaSB7Cj4gwqDCoMKgwqDCoMKgwqDCoGJ1cy13aWR0aCA9IDw4PjsK
PiDCoMKgwqDCoMKgwqDCoMKgbm8tc2RpbzsKPiBAQCAtNDIsMyArNjcsNSBAQCAmdWFydDIgewo+
IMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLTAgPSA8JnVhcnQybTBfeGZlcj47Cj4gwqDCoMKgwqDC
oMKgwqDCoHN0YXR1cyA9ICJva2F5IjsKPiDCoH07Cj4gKwo+ICsKPiAtLSAKPiAyLjMwLjIK

