Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D80618E89
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKDC6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiKDC61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:58:27 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F71D13EAE;
        Thu,  3 Nov 2022 19:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1667530685; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=HGROk1IHBLD9eZNc2KHlMQ9xMeqpXQp4CaZSqIOqVI5NVzrxqchwSVgHzy7gY0ISKcVl8+cU9+PYPmW7JjRyw8DCSY+ltP6gp0zOg9RoCd31XReyLU9S9eMoE/i3jOr+8RfwLmT6DGkWgqQrtQju280CDxIeN2VYVJlyEkGi3sQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1667530685; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=sZWmAQKUNOAA0Xj4lFuSKt2VFrYPobVt0IOs4He/Z5U=; 
        b=WGQVeswf7REhX8JCB1zHrWFDdufdEWCcYp/I7E3SqS/cDVD1+yTv/TxwfHqoUiCO5rax2dD7j6NDarsQT0gm0rEGAXVrVN/SWgt2TwQMi4MXxbffpWPgVbU4w0c9N+XMbBb38HmBisAiMhpMONn/tYf5xXbg4p8azrAuVbz3W3A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1667530685;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=sZWmAQKUNOAA0Xj4lFuSKt2VFrYPobVt0IOs4He/Z5U=;
        b=SPQ4krNDX74eE3+m2J0oq7vsUKs2aY+XKTnDYDrWuiSyWmgfDgcMTSaSPGCjAcs9
        OttCBIdakfA9y4Ocz70eASiKY2MOPi913Ea5d9IrDmZVeGXcQU91hvAnOrOnub09CqC
        k76Zo9UnQEg/6hpAqQ/H0vl+RJPbAww+HyCyxOo0=
Received: from edelgard.fodlan.icenowy.me (112.94.102.138 [112.94.102.138]) by mx.zohomail.com
        with SMTPS id 1667530683283476.95396203223686; Thu, 3 Nov 2022 19:58:03 -0700 (PDT)
Message-ID: <76d9c4fb368dca87c64494b927706d0b18d712d2.camel@icenowy.me>
Subject: Re: [PATCH 02/12] dt-bindings: riscv: Add T-HEAD C906 and C910
 compatibles
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Date:   Fri, 04 Nov 2022 10:57:58 +0800
In-Reply-To: <20220815050815.22340-3-samuel@sholland.org>
References: <20220815050815.22340-1-samuel@sholland.org>
         <20220815050815.22340-3-samuel@sholland.org>
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

5ZyoIDIwMjItMDgtMTXmmJ/mnJ/kuIDnmoQgMDA6MDggLTA1MDDvvIxTYW11ZWwgSG9sbGFuZOWG
memBk++8mgo+IFRoZSBDOTA2IGFuZCBDOTEwIGFyZSBSSVNDLVYgQ1BVIGNvcmVzIGZyb20gVC1I
RUFEIFNlbWljb25kdWN0b3IuCj4gTm90YWJseSwgdGhlIEM5MDYgY29yZSBpcyB1c2VkIGluIHRo
ZSBBbGx3aW5uZXIgRDEgU29DLgoKQ291bGQgdGhpcyBnZXQgYXBwbGllZCBmaXJzdD8KCkM5MDYg
YW5kIEM5MTAgbm93IGhhdmUgYSBmaXhlZC1jb25maWd1cmF0aW9uIG9wZW4tc291cmNlIHZlcnNp
b24sIHdoaWNoCm1lYW5zIHRoZXNlIGNvcmVzIGNvdWxkIGJlIHBsYXllZCBieSBhbnlvbmUsIGFu
ZCBoYXZpbmcgdGhlbSBpbiB0aGUgRFQKYmluZGluZyByZWFsbHkgaGVscHMgcGVvcGxlLiBJbiBh
ZGRpdGlvbiBJIGFtIGF3YXJlIG9mIHNvbWUgQzkwNi0KZXF1aXBwZWQgU29DIG91dCBvZiBBbGx3
aW5uZXIuCgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNhbXVlbCBIb2xsYW5kIDxzYW11ZWxAc2hvbGxh
bmQub3JnPgo+IC0tLQo+IAo+IMKgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jp
c2N2L2NwdXMueWFtbCB8IDIgKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
PiAKPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2
L2NwdXMueWFtbAo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L2Nw
dXMueWFtbAo+IGluZGV4IDg3M2RkMTJmNmU4OS4uY2UyMTYxZDkxMTVhIDEwMDY0NAo+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9jcHVzLnlhbWwKPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3YvY3B1cy55YW1sCj4gQEAg
LTM4LDYgKzM4LDggQEAgcHJvcGVydGllczoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC0gc2lmaXZlLHU1Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIHNpZml2ZSx1Nwo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjYW5hYW4sazIxMAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAtIHRoZWFkLGM5MDYKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLSB0aGVhZCxjOTEwCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogcmlzY3YKPiDC
oMKgwqDCoMKgwqAgLSBpdGVtczoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGVudW06Cgo=

