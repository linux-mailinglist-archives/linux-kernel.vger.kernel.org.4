Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551E565D26A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbjADMVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbjADMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:20:26 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74EA3B928;
        Wed,  4 Jan 2023 04:19:11 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1AFD75C016C;
        Wed,  4 Jan 2023 07:19:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 04 Jan 2023 07:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672834748; x=1672921148; bh=PKp//PUcPl
        ATzvWVd6Xv2r7lr60JNRd0OJM9+iZsPUo=; b=TzdKUjktPVF29RGzt79d4JMhWU
        RLeXQbUAmaZIfjooDAmWrX/xV3HlmYGb6w99qWzC1jsXWPlkbXJGbGjbmbispKAL
        jkWOi+zyoK9Go03dJ7ZZXn6P9HaJxW/lL6ViMABml566QZe/I5WyVJgZHBDKLoDP
        8BbWhji+6KtVJ+qX53VyK0kEB4I9GyovHPo+j8AXSa9/xw17g2QrVM5brKqJPNQH
        0cISFbbFtyL6lw8BNnJMw74JAiHU6VHMl4WWyaJEdzFEpdmv12t25X+zucpvpY7m
        b4gclV3TpHtk/niVI+jQHX9JHxwSuKqlh8/5Qx6LdKA/MqqHKM/BTfBxQD2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672834748; x=1672921148; bh=PKp//PUcPlATzvWVd6Xv2r7lr60J
        NRd0OJM9+iZsPUo=; b=RxKXxfp863lPw897yGPAfp3FxiKDhweFKNrdC1umzkio
        wiSZvG2aggiTGe97fVKZORNaDSKYfyQ+MBaVk++UGQlJ4Q1oTdewas0y//oz0Djb
        pQ1YOofViasq/pIbiXh4YZU9Wtwl8mPaQf+LmbAFFUmwFXELY0vl00yXWi63Y0GQ
        lCt4T6Pzn8ZXSC0aJ62d8kPMqvfstftfXQlSaDiNo1YHZm8Jewc7joE4heocmfni
        WYAI3PXCwGtWfqnuqkQTdBV1sToW73kiUB4f7OkJaziJ78hlEMk9ERbEJ6Ze0Mlr
        +9IMM3ou2tPMuU88lldIEShNe8/HTFdWZS8Ve978Tw==
X-ME-Sender: <xms:um61Y508ghAtjmy6Hhz68qG1SmugkRepMcCLDP3X_bX2-VnJtF5cNQ>
    <xme:um61YwH5mlh-FwnxnLhiLK2JSOb50HcqBcHLLaRD8_gemvQrF46wMa3HHqN5NCuqP
    WsDVUIISyJRqP5USpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:um61Y55D_1dKvjVnaRGEa-pdQMDXFxz4zM0lSL6JvhVyEq_e0KGyYA>
    <xmx:um61Y20q-2wOMSaool21cqweprgJJ-HfED1Q8Jrppb7O1m5zWTFjtQ>
    <xmx:um61Y8HCzu1udqIAWkUeIdN82vnG8DNilXdC2rZoxy2pbULU6fRSGg>
    <xmx:vG61Y9tqKQEJX0G3uqfBDZRWaRB69NNwS_vNl1AvROTT3EidLaCgvA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 20FCCB60086; Wed,  4 Jan 2023 07:19:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <1b7d4caa-2c9c-4aef-81ac-47288d3a652c@app.fastmail.com>
In-Reply-To: <Y7VpeK48nslxklkF@spud>
References: <Y62nOqzyuUKqYDpq@spud>
 <20230103210400.3500626-10-conor@kernel.org>
 <b5712732-40a2-4e29-b29f-e0ab5516d518@app.fastmail.com>
 <Y7TBh+CJdZPJ6Xzl@spud>
 <ed198390-1bde-44ec-9f3f-b0e016b4b24c@app.fastmail.com>
 <CFB874A3-3E6F-4C5B-B47D-381EB1E07C02@kernel.org>
 <43aee000-5b89-4d94-98d2-b37b1a18a83e@app.fastmail.com>
 <Y7VpeK48nslxklkF@spud>
Date:   Wed, 04 Jan 2023 13:18:45 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Conor Dooley" <conor@kernel.org>
Cc:     "Palmer Dabbelt" <palmer@dabbelt.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        guoren <guoren@kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        "Magnus Damm" <magnus.damm@gmail.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Philipp Tomsich" <philipp.tomsich@vrull.eu>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Samuel Holland" <samuel@sholland.org>, soc@kernel.org,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: Re: [RFC v5.1 9/9] [DON'T APPLY] cache: sifive-ccache: add cache flushing
 capability
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

On Wed, Jan 4, 2023, at 12:56, Conor Dooley wrote:
> On Wed, Jan 04, 2023 at 11:19:44AM +0100, Arnd Bergmann wrote:
>> On Wed, Jan 4, 2023, at 10:23, Conor Dooley wrote:
>> I would try to replace both of these indirections and instead
>> handle it all from C code in arch_sync_dma_for_device() directly,
>> for the purpose of readability and maintainability.
>> static inline void dma_cache_clean(void *vaddr, size_t size)
>> {
>>         if (!cache_maint_ops.clean)
>>                zicbom_cache_clean(vaddr, size, riscv_cbom_block_size);
>
> And I figure that this function is effectively a wrapper around ALT_CMO_OP()?
>
>>         else
>>                cache_maint_ops.clean(vaddr, size, riscv_cbom_block_size);
>
> And this one gets registered by the driver using an interface like the
> one I already proposed, just with the cache_maint_ops struct expanded?

Yes, exactly.

> Extrapolating, with these changes having an errata would not even be
> needed in order to do cache maintenance.
> Since the ALT_CMO_OP() version would only be used inside
> zicbom_cache_clean(), assuming I understood correctly, a driver could
> just register cache_maint_ops for a given platform without having to
> muck around with errata.

That is the idea, and ALT_CMO_OP() itself can just go away
as by just putting the inline asm without the alternative into
the zicbom_cache_clean() version, making the THEAD branch yet
another cache_maint_ops instance.

>> which then makes it very clear what the actual code path
>> is, while leaving the zicbom case free of indirect function
>> calls. You can still use a static_branch() to optimize the
>> conditional, but I would try to avoid any extra indirection
>> levels or errata checks.
>
> The other thing that I like about this is we can then remove the various
> calls to ALT_CMO_OP() that are scattered around arch/riscv now & replace
> them with functions that have more understandable names.

I only see them in arch/riscv/mm/dma-noncoherent.c and arch/riscv/mm/pmem.c,
but yes, both of these should just call the new functions, whatever the
calling conventions end up being.

    Arnd
