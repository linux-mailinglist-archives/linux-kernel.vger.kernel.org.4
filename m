Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9FA63E2EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiK3VuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiK3Vt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:49:59 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632045B851;
        Wed, 30 Nov 2022 13:49:58 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 0F467320094F;
        Wed, 30 Nov 2022 16:49:52 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 30 Nov 2022 16:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669844992; x=1669931392; bh=wX9irGcUbl
        Xc4RqeTgp4fnnU07GYdQWcxMiKg/SvwkU=; b=fYP7D2uDlDvE8/Ds6VeE/7Js1t
        bQFViWjZyp6L1w5ntvcYnOcilhM10S3q+BNI1JWhdoIwvpWjZlWAOworhoWcVC2+
        8evG3Ri+9YaIU5U9QPfzxxLZv9wL1auCHYE9/jJWKEEm6JcDVYM9dpVXV47DXJb3
        sNe+s8hoXA7EwOX+vH6kgRgJAsMP3YNc0+OzJnCHwNNew7Ck3FSHU+BEbmmAXqsp
        UufeNGRBPTOyxyQcufueB/l3uuigsAy0KC4FyJwg7DzMKElSkXUQ2K6c7qSvbnrn
        ngWxB5GElmPps4W52sfKfcG/b58vwh54QnZ42F8I9CO6rncEFs2Q2XWj4b8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669844992; x=1669931392; bh=wX9irGcUblXc4RqeTgp4fnnU07GY
        dQWcxMiKg/SvwkU=; b=LAaMgeKHxDISnihMHN5JzfsPU/S073/o2JnSspeGe+5c
        gvEoMGdMjeDlUm//JERDpnVz3KrA32Pf04rq+wVo2H/NL7GCHRF9Axf672OvY/zg
        CqxBqSCadZ5oZnRryunTZf+VZYN50zsuKHr7w2+0aBP19Kqpt5zImOq2qCV5DLRB
        RZiVt43z4EFtj5A7UP7t1sFiI2cXyvoaqofTrRE0UOUzgnS3rNCSplrRlCQUtzCx
        JmpMPbaTaksHqTNArpFMHArbo1LQoXjnU5ijTrq9Wjd925hE4IpfKndQGbMHCUJy
        dOznD9JmmTcbsYrAnMcqUnfVj5zL+7ThHqHwp+ejtA==
X-ME-Sender: <xms:_8-HYxmp-_ZaWfU5EVYBM0XPygw6gQuSYzh3odRSxPjKPwe8lSLG_g>
    <xme:_8-HY82RFRwOo7I1sXZjOpFP8uVh_qY3FBNPbwEt58oL_FZKl5tKfYLvMD8R8X4Sf
    86f1wqnLGKfyohi-p0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdefgdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:_8-HY3qaiXy8wIy2OuRAjh--jtlSPfQqTADfp7VrLDcA0Cp9Y2VzdQ>
    <xmx:_8-HYxnOuyA-4BOEGwKLSRJK06g9oqFSPuKvVKZdBzdd_nYeRmdsHg>
    <xmx:_8-HY_36cJSstcsQ1L2lDJ9tqJVuaaTT9WDPjSLiRP_HA2mj0gALzQ>
    <xmx:ANCHY4dUQeAv_Y2f9f1ZgRo7GBQRvD6LpXfyzmE_bPQCFCm1TMCm1w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5EF4DB60086; Wed, 30 Nov 2022 16:49:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <7fcafe92-35d9-4a83-b00d-7816fdb43139@app.fastmail.com>
In-Reply-To: <mhng-f034544d-5b0a-47c5-8e45-3dbcefc0aaaa@palmer-ri-x1c9a>
References: <mhng-f034544d-5b0a-47c5-8e45-3dbcefc0aaaa@palmer-ri-x1c9a>
Date:   Wed, 30 Nov 2022 22:49:31 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Conor Dooley" <conor@kernel.org>, "Will Deacon" <will@kernel.org>,
        "Marc Zyngier" <maz@kernel.org>
Cc:     ajones@ventanamicro.com,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Samuel Holland" <samuel@sholland.org>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        "Rob Herring" <robh+dt@kernel.org>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Andre Przywara" <andre.przywara@arm.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@rivosinc.com>, christianshewitt@gmail.com,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        guoren <guoren@kernel.org>, heinrich.schuchardt@canonical.com,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>, stano.jakubek@gmail.com
Subject: Re: [PATCH v2 12/12] riscv: defconfig: Enable the Allwinner D1 platform and
 drivers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022, at 21:24, Palmer Dabbelt wrote:
> On Mon, 28 Nov 2022 22:54:18 PST (-0800), Conor Dooley wrote:
>>
>> idk, defconfig to me is not about you or I, it's about A Developer that gets an SBC or a devkit and their experience.
>> Or alternatively, someone's CI ;)
>> I'd like to put everything in, but I recall that being shot down, that's all.
>
> The whole "who is defconfig for" discussion always ends up kind of 
> vague, but IIUC it's generally aimed at kernel hackers as opposed to end 
> users -- so it's not meant to be a disto config, that's why we have 
> things like the debug options turned on.  I tend to think of it as a "if 
> a patch submitter is going to test only one config, then what do I want 
> in it?" and let that determine what goes in defconfig.
>
> IMO having defconfig contain the drivers necessary to boot every common 
> dev board as =y, and having =m for anything else on those boards also 
> seem reasonable.  That will make the transition from vendor/distro 
> kernels to upstream a bit smoother, which is always good.  I guess 
> there's some slight build time and image size issues, but aside from 
> some very small systems that shouldn't be too bad for kernel developers 
> -- and if we really end up with another popular system with 6MiB of RAM 
> we can just stick another tiny defconfig in there for it.
>
> I actually don't use modules when doing kernel development because I 
> find it easier to track things when they're packed into a single binary, 
> but I don't think it's necessary to steer everyone that way.
>
> Adding some of the Arm folks here, in case they have thoughts.  The best 
> bet is probably to try and do something similar, though my worry is that 
> the answer is something like "target standard platforms" and we don't 
> have any.

I think this is handled very inconsistently across architectures. On
32-bit arm, we used to have a board specific defconfig for each machine,
but of course that never scaled to the number of supported machines.

The important defconfig files we have these days are the arm64
one, and on arm32 we have the ones that are mutually incompatible,
in particular one for armv7 and one for armv5, each enabling as
many machines as possible, plus usually one per SoC vendor that
is more specialized.

If you want to formalize it a bit more than this,  I would recommend
having more fragments, e.g. one for typical debugging options,
one for things that are needed to boot both Fedora and Debian
userland, etc.

      Arnd
