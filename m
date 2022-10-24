Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A087B60BF74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiJYAWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiJYAVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:21:38 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003462B769B;
        Mon, 24 Oct 2022 15:45:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666623425; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=UM5dIx/4JCtgw2pFhQX2FBPell4w0p3prcLhJ9Xl8sjeSXdWck/11kv1VO2BUVt+aCtGYRRciHNJIrgTrlby8I9vLnAaLfSS/d6zh4XmNOIE7GHYUZAOTnZtYjxUngHy5AzMLimaY2xyQHrG02P5e56cPCmmRpa3BZc+CrI0Q08=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666623425; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=QQUAzeD8aKn6vfQ4194+hXQmHVFhvbqRGZcAWeeulV0=; 
        b=dny98F8sv/tEnWGIyk1FvKy5TgekX+a2+On5B8f1l6cpzMJbxa9AhmykRY7WiE2n3i/Q2CmgbwfV8eV5v3USQ28IwpWzRYgoyhw/eQkGw2fvvE5/pB2S8kWHcmq9Hf15xvSWb2/mvH08fTlNQGK/zCYumcVb0+uTUFunxNlHtTU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666623425;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=QQUAzeD8aKn6vfQ4194+hXQmHVFhvbqRGZcAWeeulV0=;
        b=KxJWw+/g6vGuWJ4PSVZbgXj526uXN3Ma0OsdySm9orcLSgPdqC0eRBgIbBq9J/Cz
        gyDQY3k5WVd0lRTv7bGajO6tXeWRK63IeNRzMrLvTOEn2cdWWkkLwytO+hYWnobC0FQ
        jFEds1m9444cO7ioPsn2D+ZC3gm6xlqUs98QfMTo=
Received: from edelgard.fodlan.icenowy.me (112.94.102.105 [112.94.102.105]) by mx.zohomail.com
        with SMTPS id 1666623423433294.70361609256247; Mon, 24 Oct 2022 07:57:03 -0700 (PDT)
Message-ID: <0612c54fd441585141d37ecbc8508d412b3c3a14.camel@icenowy.me>
Subject: Re: [PATCH v2 06/10] ARM: suniv: add USB-related device nodes
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Date:   Mon, 24 Oct 2022 22:56:58 +0800
In-Reply-To: <20221024151643.23217a25@donnerap.cambridge.arm.com>
References: <20221012055602.1544944-1-uwu@icenowy.me>
         <20221012055602.1544944-7-uwu@icenowy.me>
         <20221024151643.23217a25@donnerap.cambridge.arm.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjItMTAtMjTmmJ/mnJ/kuIDnmoQgMTU6MTYgKzAxMDDvvIxBbmRyZSBQcnp5d2FyYeWG
memBk++8mgo+IE9uIFdlZCwgMTIgT2N0IDIwMjIgMTM6NTU6NTggKzA4MDAKPiBJY2Vub3d5IFpo
ZW5nIDx1d3VAaWNlbm93eS5tZT4gd3JvdGU6Cj4gCj4gSGksCj4gCj4gPiBUaGUgc3VuaXYgU29D
IGhhcyBhIFVTQiBPVEcgY29udHJvbGxlciBhbmQgYSBVU0IgUEhZIGxpa2Ugb3RoZXIKPiA+IEFs
bHdpbm5lciBTb0NzLgo+ID4gCj4gPiBBZGQgdGhlaXIgZGV2aWNlIHRyZWUgbm9kZS4KPiAKPiBM
b29rcyBhbHJpZ2h0IHRvIG1lLCBjaGVja2VkIGFnYWluc3QgdGhlIG1hbnVhbCwgYWxzbyBjb21w
YXJlZAo+IGFnYWluc3QKPiBzb21lIG90aGVyIEFsbHdpbm5lciBVU0IgRFQgbm9kZXMuIEFsc28g
cGFzc2VzIHRoZSBiaW5kaW5nIGFuZCBEVEIKPiBjaGVja3MuCj4gCj4gSnVzdCBvbmUgc21hbGwg
cXVlc3Rpb24gYmVsb3csIGJ1dCBuZXZlcnRoZWxlc3M6Cj4gCj4gUmV2aWV3ZWQtYnk6IEFuZHJl
IFByenl3YXJhIDxhbmRyZS5wcnp5d2FyYUBhcm0uY29tPgo+IAo+ID4gU2lnbmVkLW9mZi1ieTog
SWNlbm93eSBaaGVuZyA8dXd1QGljZW5vd3kubWU+Cj4gPiAtLS0KPiA+IE5vIGNoYW5nZXMgc2lu
Y2UgdjEuCj4gPiAKPiA+IMKgYXJjaC9hcm0vYm9vdC9kdHMvc3VuaXYtZjFjMTAwcy5kdHNpIHwg
MjYKPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAy
NiBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9z
dW5pdi1mMWMxMDBzLmR0c2kKPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvc3VuaXYtZjFjMTAwcy5k
dHNpCj4gPiBpbmRleCAwZWRjMTcyNDQwN2IuLmEwMTU0MWJhNDJjNSAxMDA2NDQKPiA+IC0tLSBh
L2FyY2gvYXJtL2Jvb3QvZHRzL3N1bml2LWYxYzEwMHMuZHRzaQo+ID4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvc3VuaXYtZjFjMTAwcy5kdHNpCj4gPiBAQCAtMTMzLDYgKzEzMywzMiBAQCBtbWMx
OiBtbWNAMWMxMDAwMCB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAjc2l6ZS1jZWxscyA9IDwwPjsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgfTsKPiA+IMKgCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdXNi
X290ZzogdXNiQDFjMTMwMDAgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gImFsbHdpbm5lcixzdW5pdi1mMWMxMDBzLQo+ID4g
bXVzYiI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJlZyA9IDwweDAxYzEzMDAwIDB4MDQwMD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrcyA9IDwmY2N1IENMS19CVVNfT1RHPjsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVzZXRzID0gPCZj
Y3UgUlNUX0JVU19PVEc+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpbnRlcnJ1cHRzID0gPDI2PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0LW5hbWVzID0gIm1jIjsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGh5cyA9IDwmdXNicGh5
IDA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBw
aHktbmFtZXMgPSAidXNiIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZXh0Y29uID0gPCZ1c2JwaHkgMD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFsbHdpbm5lcixzcmFtID0gPCZvdGdfc3JhbSAx
PjsKPiAKPiBXaGF0IGlzIHRoaXMgIjEiIGZvcj8gSSBzZWUgaXQgYWxsIG92ZXIgdGhlIG90aGVy
IEFsbHdpbm5lciBTUkFNCj4gcHJvcGVydGllcywgYnV0IGNhbid0IGZpbmQgYW55IGRvY3VtZW50
YXRpb24gYWJvdXQgdGhhdCBudW1iZXIsIG5vcgo+IGNhbiBJCj4gc2VlIHRoYXQgaXQgd291bGQg
YmUgdXNlZCBpbiB0aGUgY29kZS4KCkl0IG1lYW5zIG1hcHBpbmcgdGhlIFNSQU0gdG8gZGVkaWNh
dGVkIGRldmljZSBpbnN0ZWFkIG9mIENQVS4KClRoaXMgaW5mb3JtYXRpb24gaXMgYXZhaWxhYmxl
IGluIHByZXZpb3VzIHN1bnhpLXNyYW0udHh0IGJpbmRpbmcsIGJ1dApsb3N0IHdoZW4gY29udmVy
dGluZyB0byBqc29uIHNjaGVtYSwgbWF5YmUgYmVjYXVzZSBpdCBkb2VzIG5vdCBmaXQgd2VsbApp
biBqc29uIHNjaGVtYS4KCj4gCj4gRG9lcyBhbnlvbmUga25vdz8KPiAKPiBDaGVlcnMsCj4gQW5k
cmUKPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
c3RhdHVzID0gImRpc2FibGVkIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9
Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVzYnBoeTogcGh5QDFj
MTM0MDAgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjb21wYXRpYmxlID0gImFsbHdpbm5lcixzdW5pdi1mMWMxMDBzLXVzYi0KPiA+IHBoeSI7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDww
eDAxYzEzNDAwIDB4MTA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZWctbmFtZXMgPSAicGh5X2N0cmwiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9ja3MgPSA8JmNjdSBDTEtfVVNCX1BIWTA+
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9j
ay1uYW1lcyA9ICJ1c2IwX3BoeSI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJlc2V0cyA9IDwmY2N1IFJTVF9VU0JfUEhZMD47Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlc2V0LW5hbWVzID0gInVz
YjBfcmVzZXQiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAjcGh5LWNlbGxzID0gPDE+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoH07Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGNjdTogY2xvY2tAMWMyMDAwMCB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gImFsbHdpbm5lcixzdW5pdi1mMWMxMDBz
LWNjdSI7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZWcgPSA8MHgwMWMyMDAwMCAweDQwMD47Cj4gCgo=

