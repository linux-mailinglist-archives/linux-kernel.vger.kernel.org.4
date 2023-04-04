Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC856D5B9E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjDDJNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjDDJNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:13:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC4710F8;
        Tue,  4 Apr 2023 02:13:37 -0700 (PDT)
Received: from [IPv6:2a00:23c7:6883:e501:e15b:407b:49da:d40e] (unknown [IPv6:2a00:23c7:6883:e501:e15b:407b:49da:d40e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D2771660312E;
        Tue,  4 Apr 2023 10:13:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680599616;
        bh=78Ult8oKnA5bu8XEj12gOFRanNW2H/+HLsNXjSBOJBQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PZSxYXCWGNTexG2Zb2EViM0O2pu2422dNNBJPreD5vB8igjHVd2TajtKmEFq0ksuH
         GvuthxgMAO4wpLzIG6MrIu3sdPWyuTrEpb0R2pJ2c68qGjc/oAmuP/0oq9p+SYVZyz
         4d6M9kNsXoBBVJkWn026dfPlVYJ/aj+XSBw6SWFXPvzCb0IX2IpU++naKFs3s4fpVs
         Crp26gjBQyblPao3mF0yaNgL5ND7QnKBEJUSnc05mlLHV/5PkrVIJQ/tNwefiov2ma
         nToVewds14oCXtfjtQfBD61/jx1byKuTb08qn698JVJyW8cIM+PmdmDMUR4A1bcmtm
         0Ss2zj2W+DKeA==
Message-ID: <874713e89972ef8dba47a5fa6db79c0d0ebcee70.camel@collabora.com>
Subject: Re: [PATCH v4 5/5] arm64: dts: rockchip: rk3588-rock-5b: Add analog
 audio
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Date:   Tue, 04 Apr 2023 10:13:33 +0100
In-Reply-To: <20230402095054.384739-6-cristian.ciocaltea@collabora.com>
References: <20230402095054.384739-1-cristian.ciocaltea@collabora.com>
         <20230402095054.384739-6-cristian.ciocaltea@collabora.com>
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

SGkgQ3Jpc3RpYW4sCgpPbiBTdW4sIDIwMjMtMDQtMDIgYXQgMTI6NTAgKzAzMDAsIENyaXN0aWFu
IENpb2NhbHRlYSB3cm90ZToKPiBBZGQgdGhlIG5lY2Vzc2FyeSBEVCBub2RlcyBmb3IgdGhlIFJv
Y2sgNUIgYm9hcmQgdG8gZW5hYmxlIHRoZSBhbmFsb2cKPiBhdWRpbyBzdXBwb3J0IHByb3ZpZGVk
IGJ5IHRoZSBFdmVyZXN0IFNlbWkgRVM4MzE2IGNvZGVjLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENy
aXN0aWFuIENpb2NhbHRlYSA8Y3Jpc3RpYW4uY2lvY2FsdGVhQGNvbGxhYm9yYS5jb20+CgpSZXZp
ZXdlZC1ieTogQ2hyaXN0b3BoZXIgT2JiYXJkIDxjaHJpcy5vYmJhcmRAY29sbGFib3JhLmNvbT4K
Cj4gLS0tCj4gwqAuLi4vYm9vdC9kdHMvcm9ja2NoaXAvcmszNTg4LXJvY2stNWIuZHRzwqDCoMKg
wqDCoCB8IDYyICsrKysrKysrKysrKysrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNl
cnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAv
cmszNTg4LXJvY2stNWIuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazM1ODgt
cm9jay01Yi5kdHMKPiBpbmRleCA5NTgwNWNiMGFkZmEuLmE5ZTEyZTA5OGQ0OCAxMDA2NDQKPiAt
LS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzU4OC1yb2NrLTViLmR0cwo+ICsr
KyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszNTg4LXJvY2stNWIuZHRzCj4gQEAg
LTIsNiArMiw3IEBACj4gwqAKPiDCoC9kdHMtdjEvOwo+IMKgCj4gKyNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9ncGlvL2dwaW8uaD4KPiDCoCNpbmNsdWRlICJyazM1ODguZHRzaSIKPiDCoAo+IMKgLyB7
Cj4gQEAgLTE3LDYgKzE4LDIzIEBAIGNob3NlbiB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBzdGRvdXQtcGF0aCA9ICJzZXJpYWwyOjE1MDAwMDBuOCI7Cj4gwqDCoMKgwqDCoMKg
wqDCoH07Cj4gwqAKPiArwqDCoMKgwqDCoMKgwqBzb3VuZCB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAiYXVkaW8tZ3JhcGgtY2FyZCI7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxhYmVsID0gIkFuYWxvZyI7Cj4gKwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB3aWRnZXRzID0gIk1pY3JvcGhvbmUiLCAiTWljIEphY2siLAo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkhlYWRw
aG9uZSIsICJIZWFkcGhvbmVzIjsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJvdXRpbmcgPSAiTUlDMiIsICJNaWMgSmFjayIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiSGVhZHBob25lcyIsICJIUE9MIiwKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJIZWFkcGhvbmVzIiwg
IkhQT1IiOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGFpcyA9IDwmaTJz
MF84Y2hfcDA+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBocC1kZXQtZ3BpbyA9
IDwmZ3BpbzEgUktfUEQ1IEdQSU9fQUNUSVZFX0hJR0g+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBwaW5jdHJsLTAgPSA8JmhwX2RldGVjdD47Cj4gK8KgwqDCoMKgwqDCoMKg
fTsKPiArCj4gwqDCoMKgwqDCoMKgwqDCoHZjYzV2MF9zeXM6IHZjYzV2MC1zeXMtcmVndWxhdG9y
IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAicmVndWxh
dG9yLWZpeGVkIjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ3VsYXRvci1u
YW1lID0gInZjYzV2MF9zeXMiOwo+IEBAIC0yNyw2ICs0NSw1MCBAQCB2Y2M1djBfc3lzOiB2Y2M1
djAtc3lzLXJlZ3VsYXRvciB7Cj4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gwqB9Owo+IMKgCj4gKyZp
MmM3IHsKPiArwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSAib2theSI7Cj4gKwo+ICvCoMKgwqDCoMKg
wqDCoGVzODMxNjogZXM4MzE2QDExIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Y29tcGF0aWJsZSA9ICJldmVyZXN0LGVzODMxNiI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJlZyA9IDwweDExPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2xv
Y2tzID0gPCZjcnUgSTJTMF84Q0hfTUNMS09VVD47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGNsb2NrLW5hbWVzID0gIm1jbGsiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAjc291bmQtZGFpLWNlbGxzID0gPDA+Owo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcG9ydCB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBlczgzMTZfcDBfMDogZW5kcG9pbnQgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlbW90ZS1lbmRwb2ludCA9
IDwmaTJzMF84Y2hfcDBfMD47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB9Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ICvCoMKg
wqDCoMKgwqDCoH07Cj4gK307Cj4gKwo+ICsmaTJzMF84Y2ggewo+ICvCoMKgwqDCoMKgwqDCoHBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7Cj4gK8KgwqDCoMKgwqDCoMKgcGluY3RybC0wID0gPCZp
MnMwX2xyY2sKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmkyczBf
bWNsawo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmaTJzMF9zY2xr
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZpMnMwX3NkaTAKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmkyczBfc2RvMD47Cj4gK8Kg
wqDCoMKgwqDCoMKgc3RhdHVzID0gIm9rYXkiOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpMnMwXzhj
aF9wMDogcG9ydCB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGkyczBfOGNoX3Aw
XzA6IGVuZHBvaW50IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGRhaS1mb3JtYXQgPSAiaTJzIjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoG1jbGstZnMgPSA8MjU2PjsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlbW90ZS1lbmRwb2ludCA9IDwmZXM4MzE2X3Aw
XzA+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ICvCoMKgwqDCoMKgwqDC
oH07Cj4gK307Cj4gKwo+ICsmcGluY3RybCB7Cj4gK8KgwqDCoMKgwqDCoMKgc291bmQgewo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBocF9kZXRlY3Q6IGhwLWRldGVjdCB7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByb2NrY2hpcCxwaW5z
ID0gPDEgUktfUEQ1IFJLX0ZVTkNfR1BJTyAmcGNmZ19wdWxsX25vbmU+Owo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ICvCoMKgwqDCoMKgwqDCoH07Cj4gK307Cj4gKwo+IMKg
JnNkaGNpIHsKPiDCoMKgwqDCoMKgwqDCoMKgYnVzLXdpZHRoID0gPDg+Owo+IMKgwqDCoMKgwqDC
oMKgwqBuby1zZGlvOwo+IC0tIAo+IDIuNDAuMAo+IAo+IAo=

