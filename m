Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02DA658DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiL2OGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiL2OGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:06:00 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F369B63DE;
        Thu, 29 Dec 2022 06:05:59 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 51CB55C009C;
        Thu, 29 Dec 2022 09:05:59 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Dec 2022 09:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1672322759; x=1672409159; bh=YrObHqLUZX
        ojkNm97IkZC/z6Y0VXxiZy8VywJIHip2I=; b=EihVn2yqPJgTkNJUYLt5HEq6So
        v7fLFzBBmYgT4lLtwOBVx4k/bfGt7/lG6DMCwdcyuBAEwnCF7xWE16JMPFsuA/6d
        y4GaS7TgqvCpVT5vqX3c4sI3Gnbqe8uVvn09nmUlVcmKfPd2CgVG+sFIQfj7Y05q
        AKYdEYyJaW7VpmJdikF3evf9Y8kOLrDePmNJltUDHEZGNLlcRFFQLTz9VhKPp/vo
        sKxQnsSjnj6E5NAJF/hrc2Qh7rDS5Ya1IPCD4ADAmc4d+aaWQ5lbxNPFJxfo/BNY
        iR8Gn+0AasaeeRfQ2fJCKlNJMMTOcJTAZCav2/6hWCtH6wW+C+vmoZjir2OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672322759; x=1672409159; bh=YrObHqLUZXojkNm97IkZC/z6Y0VX
        xiZy8VywJIHip2I=; b=JQTTJLSBLzA3pe3NW11WYmdZB2XibIhibGuLVbSJ1E5t
        2wlUOGtN0te2S50OA0SZqbFa3zA5BLKRsn4OaAIsfRvaf1av0OfosjuB7DacicQv
        x9ydzspIu9/rih9Ii5lkLFYPz/W1YZAYuwnoYn+SDbi76H9qA58cPE72QvDa2Tcm
        Pob8fLXk6tFh0LyJY+3a9HwI+sUwwHnkzeWfs1hWoGWc1oNx6Hkbk0Uqocc61bBs
        hFxBxpIlUng0jqL3r+6ABWk8v4zBNxTxCNSVmT94wztZqjVcb8N+WhudfLps2anJ
        CRjhMfurmHeFBgiIcws83Oavr/k50WT4bxtM+NPU8Q==
X-ME-Sender: <xms:xZ6tY0zcaTMo2j14BCVdcYKvM9buMKoux4lC4M62IPZ-0W3p0PpphA>
    <xme:xZ6tY4QwBUZWTi83XIWfjp70A1A7XDgmpYE5EdvFxBR9hqECVO9o3nQS7qUoCsiuq
    91QEtTnsVbvm2Op-4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:xZ6tY2WY3KKnHU_5hY-uZiwJ0-Ghu6zxIqRTU352ezsRPFmY22p_hA>
    <xmx:xZ6tYygN1-Cvd7iE_esYN76B52-B82kmOgNvfcjnn_JV57X63ZwoKQ>
    <xmx:xZ6tY2BOhv6gXLfzeYcH8AuUL07RtoJVjqHFdEiJfXuYvZgUQgDaPw>
    <xmx:x56tYwyReFwuuTl1NJpDYWxbHLvAVsNgIe4HVIfTPXeY81rOPYUL4w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B1E33B60086; Thu, 29 Dec 2022 09:05:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <bb350709-e29a-402c-8e7e-37fd9c452c6d@app.fastmail.com>
In-Reply-To: <Y55IQIxXw/twcxFx@spud>
References: <mhng-8b05b6cd-d8a1-4302-af24-2f64a4bf7c32@palmer-ri-x1c9a>
 <32cf0901-a4a0-48a7-bf42-f2cdb34d1ee7@app.fastmail.com>
 <Y55IQIxXw/twcxFx@spud>
Date:   Thu, 29 Dec 2022 15:05:37 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Conor Dooley" <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>, soc@kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Magnus Damm" <magnus.damm@gmail.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Samuel Holland" <samuel@sholland.org>, guoren <guoren@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Jisheng Zhang" <jszhang@kernel.org>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Philipp Tomsich" <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Christoph Hellwig" <hch@infradead.org>
Subject: Re: [PATCH v5 6/6] soc: renesas: Add L2 cache management for RZ/Five SoC
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022, at 23:52, Conor Dooley wrote:
> On Fri, Dec 16, 2022 at 09:04:20PM +0100, Arnd Bergmann wrote:
>> On Fri, Dec 16, 2022, at 17:32, Palmer Dabbelt wrote:
>> > On Thu, 15 Dec 2022 23:02:58 PST (-0800), Christoph Hellwig wrote:
>>
>> I don't particularly like drivers/soc/ to become more of a dumping
>> ground for random drivers. If there are several SoCs that have the
>> same requirement to do a particular thing, the logical step would
>> be to put them into a proper subsystem, with a well-defined interface
>> to dma-mapping and virtualization frameworks.
>> 
>> The other things we have in drivers/soc/ are usually either
>> soc_device drivers for identifying the system, or they export
>> interfaces used by soc specific drivers.
>
> Sounds like that's two "not in my back yard" votes from the maintainers
> in question..
> Doing drivers/cache would allow us to co-locate the RISC-V cache
> management bits since it is not just going to be the ax45mp l2 driver
> that will need to have them.
>
> Would it be okay to put this driver in soc/andestech for now & then move
> it, and the SiFive one, once we've got patches posted for cache
> management with that?

I actually had a look at both of these drivers now and
found that they do entirely different things, so I would
revise what I had said earlier. Sorry for not having paid
enough attention at first.

The Sifive L2 cache driver handles an interrupt from the
cache controller that is trigger by data corruption
(corectable or uncorrectable). This is used as an
implementation detail of drivers/edac/sifive_edac.c
and could probably just be merged into that file.

The Andes cache driver in this series on the other hand
does not do EDAC at all but instead handles cache maintenance
for the dma-mapping interface by hooking into the
inline-asm implementation details of arch/riscv/mm/dma-noncoherent.c
as an errata fix. If we expect more nonstandard ways
to manage cache controllers for this, I think this
needs a proper interface in arch/riscv or drivers/cache.

This could be done the same way as arch/arm/include/asm/cacheflush.h
with CPU specific cache management callback pointers, but
can't really be a separate device driver without interacting
with low-level architecture code.

     Arnd
