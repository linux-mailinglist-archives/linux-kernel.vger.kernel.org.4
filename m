Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53970622EC7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiKIPI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiKIPIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:08:54 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768A61DA4C;
        Wed,  9 Nov 2022 07:08:53 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 82A6B320098E;
        Wed,  9 Nov 2022 10:08:51 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 09 Nov 2022 10:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1668006531; x=1668092931; bh=xhKbAUdZUF
        42SAnLS5OS6FjCUtELRIPIPopvmrbuffo=; b=jZxEw2dH7lqAdAEu59roSeJ0iT
        x4iI2YM/yfb9NpS8iK9RypyRZHYVMubnpYkKY2za7ChCY8IGnNscB5oHrUqn7cZa
        2D422iDXrP+OlJXXMPaCWSHtkjM6xb9j5Rd2WScbCPT76CLg3HMS+NkIahRZ2xIa
        +I6gBwsEBkNc0/UdKdDHyygwNXwh4QC533bZf5wdnriQMYxirGS9bLNDfTYgLesu
        eJSqlTPkRZ3YQmsWB89chJvRow9GSU2fvwk9Z5v2nF+aOYJTWk4Bv304kD3gtIuM
        tO7tdGZ613Yx89xgAty4L58YxUSBJT7u8ex//wbiv21ECL6wwpkYqCBulNYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668006531; x=1668092931; bh=xhKbAUdZUF42SAnLS5OS6FjCUtEL
        RIPIPopvmrbuffo=; b=gix+zTroPb9mqzvFD7LbzD/R+EcCZ8cSEbOE4Fy3nQl8
        e+5XTD9tf34tUZpK3DwOjpQJbj8iCIyQM49DvIBDQ3wQxXhlC1bmRV579pF1UckT
        GGsu/NSQn/MaNGzeWhJ9lDBeC1iUIokWuZVVZt7fTkNHWY3YXQx5wylzIroNUodc
        d7q6L34H1wMvCieYj+olJffLAwze2Znxr68sD5QT/NZ+k8t9bmY0krTi8Y1ZUlVe
        7NVIHTf3bbAEJ81vPQpdlCaP7LLEnG2wo4BngV/4q4vrKfNg8N5dwE7wlBsbqrKq
        wtyC0WVoY/ZN0ZwGHu2eH1H5jCuQW/3NWcg0wE2qVQ==
X-ME-Sender: <xms:gcJrYz3jfaol8sH1JDfYet-IhSLFwEEVSOPnqX1hg80EEx0KnThLVw>
    <xme:gcJrYyGr9FteB98ko6vkTdHyX0umJXdYCDBD4mWTFYJe6Z7xeOORRUdH_Utg4gv2G
    wMHTK3hPpDturrlCBo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:gcJrYz7buFArUSYkTa14k3Xe5JnV_DHtt2BgfMw8spWxjJyCDWI3Xg>
    <xmx:gcJrY415upmSgaEq7A_zB_cYLuUZQFkrpkiMzV1AYgp3-81O4BaHSQ>
    <xmx:gcJrY2Ez2o0BR8oDZOTWNwirQdLjBGxkydHpjrt6EBCoj_35iog-LQ>
    <xmx:g8JrYzezjm8kPevIXOo4Z6e6Sk5QdIQIiJ8Gdm8NMZhRuZ6tV405LA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1F5F2B60086; Wed,  9 Nov 2022 10:08:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <0b2ca852-61b2-4e88-b389-f102994d5b2d@app.fastmail.com>
In-Reply-To: <CAAhV-H64s-2gNMd0-F21kUzieh5G-MbBnA0k6J8EP2_7SpevaA@mail.gmail.com>
References: <20221104024835.3570-1-zhuyinbo@loongson.cn>
 <57c9f565-e75b-0c8f-fdce-9dc8c334d50f@loongson.cn>
 <CACRpkda=-_a+gWQVk1vi4QJ30j-hzeraX-wr86RcQ9xne4-d6Q@mail.gmail.com>
 <574d58b2-0e9a-4fa0-84a8-caf39a9bc37a@app.fastmail.com>
 <CAAhV-H64s-2gNMd0-F21kUzieh5G-MbBnA0k6J8EP2_7SpevaA@mail.gmail.com>
Date:   Wed, 09 Nov 2022 16:08:28 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huacai Chen" <chenhuacai@kernel.org>
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Yinbo Zhu" <zhuyinbo@loongson.cn>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Hector Martin" <marcan@marcan.st>,
        "Lubomir Rintel" <lkundrak@v3.sk>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Hitomi Hasegawa" <hasegawa-hitomi@fujitsu.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Brian Norris" <briannorris@chromium.org>,
        "Sven Peter" <sven@svenpeter.dev>, loongarch@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: Re: [PATCH v6 1/2] soc: loongson: add GUTS driver for loongson-2 platforms
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022, at 14:50, Huacai Chen wrote:
> On Wed, Nov 9, 2022 at 7:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Nov 9, 2022, at 11:15, Linus Walleij wrote:
>> > On Wed, Nov 9, 2022 at 11:03 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>> >
>> >> Hi maintainer,
>> >>
>> >> This patch I had verified that base on mainline 6.1-rc3 tree, it is
>> >> okay, if no other issue, please you help me merge it to upstream.
>> >
>> > Aren't these loongarch maintainers listed in MAINTAINERS able to
>> > merge this? Certainly Huacai can merge stuff to drivers/soc as
>> > need be. drivers/soc is a bit shared between different archs.
>>
>> I'm generally happy to keep an eye on stuff in drivers/soc/ across
>> architectures and merge it through the soc tree, especially for
>> new platforms, but merging this through the loongarch tree works
>> as well.
> So drivers/soc is similar to drivers/platform that can be merged
> through corresponding architecture trees?

Right, I think in both cases, there is no top-level subsystem
maintainer, but the rules are specific to the second-level
hierarchy: most parts of drivers/platform/ happen to go
through the x86 platform maintainer trees, and for drivers/soc
we merge most stuff through the soc tree, but a few parts
of each have different maintainers.

>> Since the driver was already sent to soc@kernel.org, I can
>> simply pick it up through patchwork[1] when I do my next round
>> of merges. I'll leave this up to Huacai Chen and WANG Xuerui,
>> let me know if you prefer to merge it through the loongarch
>> tree.
> I'm happy that this series be merged through your linux-arch tree, but
> if it is better (I'm not sure which is better) to go through loongarch
> tree I can also merge it later. However, I have some comments about
> this version. :)

I would prefer the soc tree, and will just apply the
patches from Yinbo Zhu directly this time as I already
have them in my queue. If there are more than a few
drivers/soc/loongarch/ patches in the future, maybe you can
pick them up into a separate branch and forward those
to soc@kernel.org.

Note that I have two separate roles here: I have the
asm-generic tree that I maintain for patches to
include/asm-generic as well as the occasional new
architecture review as I did for loongarch.

The other one is the group maintained soc tree that
is mainly for Arm device tree files, but also contains
soc specific code (arch/arm/mach-*), defconfig files,
drivers (drivers/{soc,firmware,memory,reset}). This is
now extended to arch/riscv and occasionally other
architectures as well, so drivers/soc/loongson fits
well in here.

     Arnd
