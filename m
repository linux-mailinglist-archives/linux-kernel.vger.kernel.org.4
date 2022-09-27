Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDC95ECDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiI0UCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiI0UCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:02:07 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A891E1CED;
        Tue, 27 Sep 2022 13:01:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8B394320030E;
        Tue, 27 Sep 2022 16:01:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 27 Sep 2022 16:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1664308879; x=
        1664395279; bh=mICjPnNaqxu4gzadim9OQSUrJ0m9K+Z9yEzI6Vaz0y4=; b=u
        KMPp6BRC4PbTpzQ+kaD8xQiqpdAF2cwqKoHj3M2c3o6c4nGgfnrfhgAPT1GgTwk8
        LXDaI45RxDkgORPwPnRJ9ASUfFW0xueuaAACOzUuhfPVfWLYwupRLMd4ZXQVvDFH
        +bL+DAD7UUnfl+X87GwBAzvY+RiScP5n3YEKuyiQTUFAc37vjxgGvRgtIueS90+i
        RtDjY1guNofghhKQP43vbDVHYLlUxIxPvfkXMKJEbiSQq5aulY+Im6beOI9bIwNy
        Ci9n8X9PT7hzUpZFY75XxbWLBLGI7INJEHDci0XUZX7FcpP93yJUdtsbBLDzznHA
        D6grgvuDrtf3puUQm0LCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1664308879; x=
        1664395279; bh=mICjPnNaqxu4gzadim9OQSUrJ0m9K+Z9yEzI6Vaz0y4=; b=P
        X8Amxtdr8CPmwnv/lJvn7dMlW6EpyZwsPfbKmO+XmF//8urpRrLtlekeBn5qHFsI
        LO8q3A8iLxXVxgVpYtRb3a/FyopAAmZqN7odrz5Ujx9wosnEJbMAmhZlQ4MqhyZV
        BspBIVvvmrS/iKwXjVfRXdR/zaaRLbDs/TkdvIW4VtVR0BNcie2wyELNdph439H+
        Tc3dewO8+wOoiDqwwJQIE/LcSh39RjZajj0eq1F9tKSgVTSE/X1L6ZnhoQG2fOBP
        uQvEDF6SFD0XE+hFAnsbweNEzh1MWrsbAaoGL+vzfmRk2XVbWmxgM9ZDG5O0//w9
        XR5/uk/5u05YXda2NXYOQ==
X-ME-Sender: <xms:jVYzY3YIdGvwn1kAwKqvutD0lK1D5ZZYSflhHj0pxeCK4oiSDsfjAQ>
    <xme:jVYzY2a6v2jiNfKYJEhcrOjUekCeAb1yD2r6repV3V0PZU3J1cP5Ly3pvHdrpr01T
    CISqA3IPdR5GY011OM>
X-ME-Received: <xmr:jVYzY59ZghwF9DQwvrGyfs4lmU9vBKSiU56WKLJy4b8VysccbgXUVoaUH7gLhsPWsM-0Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegiedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkuffhvfevffgjfhgtgfgfggesthgsredttderjeenucfhrhhomhepnfhu
    khgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvg
    hrnhepfffgfeeiudeutdeftdevudeflefhffdukedttdevtddvveegfeevleeutdetgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukh
    gvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:jVYzY9pufAUipyFx24bxSj1uy7PbNOx68V-V9WhqQvV_tqkfeklbXg>
    <xmx:jVYzYyrTzpqOfCm_XlTdFu29FOoEEhMVePhCVwjVOL-grxa4tkY3bQ>
    <xmx:jVYzYzRBZlOclBrJtpyJZuXyV05d3OHu_-rB7LX-T-9mNhhf2jdoXQ>
    <xmx:j1YzY_QIn0NlgeUIMlxSdXBSUCL0h2gyLNOpuyrHHBXZazzZme9kOg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Sep 2022 16:01:11 -0400 (EDT)
Message-ID: <3d32f14710b8437d010c146f306d15359a405f1d.camel@ljones.dev>
Subject: Re: [PATCH v4 7/7] acpi/x86: s2idle: Add a quirk for ASUSTeK
 COMPUTER INC. ROG Flow X13
From:   Luke Jones <luke@ljones.dev>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     travisghansen@yahoo.com, catalin@antebit.com,
        Shyam-sundar.S-k@amd.com, ruinairas1992@gmail.com,
        philipp.zabel@gmail.com, iam@decentr.al, hdegoede@redhat.com,
        davidedp91@gmail.com, marko.cekrlic.26@gmail.com,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Date:   Wed, 28 Sep 2022 09:00:47 +1300
In-Reply-To: <df22755c-bf4c-9d85-2c7c-a149f8580d05@amd.com>
References: <20220921204055.22889-1-mario.limonciello@amd.com>
         <20220921204055.22889-8-mario.limonciello@amd.com>
         <26bbda5d03f0eadc54dfa0036e24e16ae9134f5e.camel@ljones.dev>
         <df22755c-bf4c-9d85-2c7c-a149f8580d05@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.0 (by Flathub.org)) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA5LTI3IGF0IDExOjA3IC0wNTAwLCBMaW1vbmNpZWxsbywgTWFyaW8gd3Jv
dGU6Cj4gT24gOS8yNy8yMDIyIDA0OjA2LCBMdWtlIEpvbmVzIHdyb3RlOgo+ID4gSGVsbG8gTWFy
aW8sCj4gPiAKPiA+IEkgaGF2ZSBjb25maXJtZWQgdGhhdCBhbm90aGVyIHN1c3BlY3QgQVNVUyBs
YXB0b3AgcmVxdWlyZXMgdGhlCj4gPiBxdWlyaywKPiA+IHBhdGNoIGlzIGFzIGZvbGxvd3M6Cj4g
PiAKPiA+IAo+ID4gLS0tCj4gPiDCoCBkcml2ZXJzL2FjcGkveDg2L3MyaWRsZS5jIHwgMTIgKysr
KysrKysrKysrCj4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQo+ID4gCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3g4Ni9zMmlkbGUuYyBiL2RyaXZlcnMvYWNwaS94
ODYvczJpZGxlLmMKPiA+IGluZGV4IDJjZDM4MWY2YzAwMi4uYzgxMWVlZWQ0MmNkIDEwMDY0NAo+
ID4gLS0tIGEvZHJpdmVycy9hY3BpL3g4Ni9zMmlkbGUuYwo+ID4gKysrIGIvZHJpdmVycy9hY3Bp
L3g4Ni9zMmlkbGUuYwo+ID4gQEAgLTQyOCw2ICs0MjgsMTYgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBkbWlfc3lzdGVtX2lkCj4gPiBzMmlkbGVfZG1pX3RhYmxlW10gX19pbml0Y29uc3QgPSB7Cj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBETUlfTUFU
Q0goRE1JX1BST0RVQ1RfTkFNRSwgIlJPRyBaZXBoeXJ1cwo+ID4gRzE0Cj4gPiBHQTQwMiIpLAo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9LAo+ID4gwqDCoMKgwqDCoMKgwqDC
oH0sCj4gPiArwqDCoMKgwqDCoMKgwqB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBBU1VTIFJPRyBGbG93
IFgxNiAtIEdWNjAxCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmNhbGxiYWNrID0gbHBzMF9wcmVmZXJfbWlj
cm9zb2Z0LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5tYXRjaGVzID0gewo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBETUlfTUFU
Q0goRE1JX0JPQVJEX1ZFTkRPUiwgIkFTVVNUZUsKPiA+IENPTVBVVEVSCj4gPiBJTkMuIiksCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoERNSV9NQVRD
SChETUlfUFJPRFVDVF9OQU1FLCAiR1Y2MDEiKSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB9LAo+ID4gK8KgwqDCoMKgwqDCoMKgfSwKPiA+IMKgwqDCoMKgwqDCoMKgwqB7fQo+
ID4gwqAgfTsKPiA+IMKgIAo+IAo+IEhleSBMdWtlLAo+IAo+IFRoZSBzZXJpZXMgdGhhdCB3YXMg
dW5kZXIgZGV2ZWxvcG1lbnQgaGFzIGJlZW4gbWVyZ2VkIGZvciA2LjEuwqAgQXQKPiB0aGlzIAo+
IHBvaW50LCBjYW4geW91IGp1c3QgbWFrZSBhIHByb3BlciBwYXRjaCB3aXRoIGEgUy1vLWIgb24g
dG9wIG9mIAo+IGxpbnV4LXBtL2JsZWVkaW5nLWVkZ2UgZm9yIHRoZSBuZXcgbW9kZWwgdG8gYWRk
IHRvIHRoZSBsaXN0IGFuZCBzZW5kCj4gaXQgb3V0Pwo+IAo+IEluIGFkZGl0aW9uIHRvIHRoYXQs
IGlmIHlvdSBjYW4gcGxlYXNlIGFkZCBhIExpbms6IHRvIHRoZSBhY3BpZHVtcAo+IGFuZCAKPiBk
bWVzZyBpZiBhdmFpbGFibGU/Cj4gCj4gVGhhbmtzCgpTdXJlIG5vIHByb2JsZW0gYXQgYWxsCg==

