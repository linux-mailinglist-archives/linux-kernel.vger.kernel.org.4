Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFFE5EEAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiI2BBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiI2BBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:01:10 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86828F594F;
        Wed, 28 Sep 2022 18:01:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2FEFC5C00B9;
        Wed, 28 Sep 2022 21:01:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 28 Sep 2022 21:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1664413266; x=
        1664499666; bh=1bzeay9T/xf/VGzfHLUYmp/sbMPH/2mBk8/Ri+FZl/k=; b=G
        Ic9RYonaLiQpc2RTPn3KE1cXzv/bXu0ydKaSA+Pu9ZGEA0E88hedJoWWvQ+lYCYj
        /kS//4jaNJYZwkgYiOOGJCWkaxNI2IcX8mi3cExZkZuGrfD5oGqV63kjqX54nUIR
        rbZE0tlwnERVv2Fr0CTCfalyfkkaLCDhxTzkJrhoglF8uwnFL5y8CS2zfQuylkBK
        ZZQkXQv9O8eM3AnjJxuKr0uprLAeIUW1ZBDclaQjg3kp4+LMbfyzS/o2BGiG8K+m
        iW3vhnMff2I43kRn9kifLPPUao3wxj7zMgMnsDQifnAhnkaJxC7bqnwzrHJNYCIf
        MB8bBxPEcjsnMGpbBZ8WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1664413266; x=
        1664499666; bh=1bzeay9T/xf/VGzfHLUYmp/sbMPH/2mBk8/Ri+FZl/k=; b=P
        rJApjIy23iRgQygazkXHFrkfeOmc9NCtZXr6Keal0HwyEY63bhppx/9+acrXE5jr
        X6vcwhcYJdS6CeLEWsdSpoGmzV4K1XKGBNdzugeHPKWdmkN9DJwOwPjFZUyUjeuM
        tCuiuYr7Yl21mtdloE8BLpaCsU5J7x01hyuZdYUm1+X31biBB68GMSSbU+JpT4Ei
        jOd9yms9n3BeLVWOG3AMi4n3Z/mNmsJoU0Q3Q/5hxfL5Gyun1HaXGo0mvq31Rg6R
        r4/An8sWdNdU7p7XhZ84rJlGx2Xm4MBfrOKXe3hxbj2I7X8Q+SvNijml8rmoXi2x
        OgXbUJzn3vC31rYxJO2dw==
X-ME-Sender: <xms:Ue40Y2WKmtqCbT9ilrbQSwfLSJKu_slahH7JvHaeI4MCay99Cr0ugw>
    <xme:Ue40YynHNV-ucaCTO3FrEd8p8p78X2gWc8of58WYeFN6sPWnjRwjm1eSHMUSm-vOG
    nq5IGuC7glmYd0PIuo>
X-ME-Received: <xmr:Ue40Y6b6APpq7yUBpizuujPX8Y4dlhq3hEzzsgfAVKvMZ4E0HT9byIQXmHh2wAl7-5wy5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegledggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtsgertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeeluddtveejgefgjeekleevjeevjeetgeettdehheffffekheeiveeggedvjeffvden
    ucffohhmrghinheprhgvugguihhtrdgtohhmpdhfrhgvvgguvghskhhtohhprdhorhhgpd
    hgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Uu40Y9VIh510DJqoxTQT_lB-SaDwZf6tbameG24fvx98wkWblxKjFQ>
    <xmx:Uu40YwklqbS7BbezZvpLVAHI0J_ruDjFbusroRZ15gBzQRPbOzE6Zg>
    <xmx:Uu40Yyd3fVYy2UR_mY4ahC9LYt-WFJh5bAZHUoBmjgAsVn6JoXZxmA>
    <xmx:Uu40Y6j6eGrvZqBH9XtWCnnIB8FWYHTHWaDug0cigb4yOJnG83UH-Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Sep 2022 21:01:03 -0400 (EDT)
Message-ID: <f49217c531a61d42d2cf370d2140cf57fe79ec34.camel@ljones.dev>
Subject: Re: [PATCH 2/2] ACPI: x86: s2idle: Add another ID to
 s2idle_dmi_table
From:   Luke Jones <luke@ljones.dev>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Shyam-sundar.S-k@amd.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Date:   Thu, 29 Sep 2022 14:00:53 +1300
In-Reply-To: <20220928161935.31913-2-mario.limonciello@amd.com>
References: <20220928161935.31913-1-mario.limonciello@amd.com>
         <20220928161935.31913-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.0 (by Flathub.org)) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA5LTI4IGF0IDExOjE5IC0wNTAwLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90
ZToKPiBJdCdzIHJlcG9ydGVkIHRoYXQgIkFTVVNUZUsgQ09NUFVURVIgSU5DLiBST0cgRmxvdyBY
MTYgR1Y2MDFSVyIgaGFzCj4gbm9uLWZ1bmN0aW9uYWwgZmFucyBhZnRlciByZXN1bWUgd2hlbiB1
c2luZyB0aGUgQU1EIGNvZGVwYXRoLsKgIFRoaXMKPiBpc3N1ZSBpcyBmaXhlZCB1c2luZyB0aGUg
TWljcm9zb2Z0IGNvZGVwYXRoLgo+IAo+IEFkZCB0aGUgMyB2YXJpYW50cyBvZiB0aGlzIHN5c3Rl
bSB0byB0aGUgTWljcm9zb2Z0IGNvZGVwYXRoIERNSQo+IHRhYmxlLgo+ICogR1Y2MDFSVwo+ICog
R1Y2MDFSTQo+ICogR1Y2MDFSRQo+IAo+IExpbms6Cj4gaHR0cHM6Ly93d3cucmVkZGl0LmNvbS9y
L2xpbnV4aGFyZHdhcmUvY29tbWVudHMvd2g1MG5kL2NvbXBhdGliaWxpdHlfcmVwb3J0X2FzdXNf
cm9nX2Zsb3dfeDE2X2d2NjAxcm0vCj4gTGluazoKPiBodHRwczovL2dpdGxhYi5mcmVlZGVza3Rv
cC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8yMTQ4I25vdGVfMTU3MTI0MQo+IFJlcG9ydGVkLWJ5OiBM
dWtlIEpvbmVzIDxsdWtlQGxqb25lcy5kZXY+Cj4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25j
aWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+Cj4gLS0tCj4gwqBkcml2ZXJzL2FjcGkv
eDg2L3MyaWRsZS5jIHwgMTEgKysrKysrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS94ODYvczJpZGxlLmMgYi9k
cml2ZXJzL2FjcGkveDg2L3MyaWRsZS5jCj4gaW5kZXggM2FlMmJhNzRkZTkyLi4wMTU1YzFkMmQ2
MDggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9hY3BpL3g4Ni9zMmlkbGUuYwo+ICsrKyBiL2RyaXZl
cnMvYWNwaS94ODYvczJpZGxlLmMKPiBAQCAtNDUxLDYgKzQ1MSwxNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGRtaV9zeXN0ZW1faWQKPiBzMmlkbGVfZG1pX3RhYmxlW10gX19pbml0Y29uc3QgPSB7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgRE1JX01B
VENIKERNSV9QUk9EVUNUX05BTUUsICJST0cgRmxvdyBYMTMKPiBHVjMwMSIpLAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfSwKPiDCoMKgwqDCoMKgwqDCoMKgfSwKPiArwqDCoMKg
wqDCoMKgwqB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIEFTVVNUZUsgQ09NUFVURVIgSU5DLiBST0cgRmxvdyBY
MTYgR1Y2MDFSV19HVjYwMVJXCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqCj4g
aHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMjE0OAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLmNhbGxiYWNrID0gbHBzMF9wcmVmZXJfbWljcm9zb2Z0LAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAubWF0Y2hlcyA9IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoERNSV9NQVRDSChETUlfU1lTX1ZFTkRPUiwgIkFTVVNU
ZUsgQ09NUFVURVIKPiBJTkMuIiksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBETUlfTUFUQ0goRE1JX1BST0RVQ1RfTkFNRSwgIlJPRyBGbG93IFgxNgo+
IEdWNjAxIiksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0sCj4gK8KgwqDCoMKg
wqDCoMKgfSwKPiDCoMKgwqDCoMKgwqDCoMKge30KPiDCoH07Cj4gwqAKCkhpIE1hcmlvLAoKcmVs
YXRlZCBkdHMgaGVyZQpodHRwczovL2dpdGxhYi5jb20vYXN1cy1saW51eC9yZXZlcnNlLWVuZ2lu
ZWVyaW5nLy0vdHJlZS9tYXN0ZXIvR1Y2MDFSCgo=

