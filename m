Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892235F5222
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJEJ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJEJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:58:24 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71336EF34;
        Wed,  5 Oct 2022 02:58:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id B466F580390;
        Wed,  5 Oct 2022 05:58:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 05 Oct 2022 05:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664963900; x=1664967500; bh=MxxMRDfEHO
        Qi5+nDumNVbTgRThG0gUKh/x3oMnocNco=; b=mG+OYpQFz6324WqipXqg6d0xeZ
        sOq4/cKAkQH8uMWu7ERXlX8iP1Ccrr/uOmLRnO4STFcbI8UOsVMmKR+Mlq6PVMDb
        7jV0TmdAG060BvIT2ovC/7OJqIi1T25dGQ0poIeHjAHC3gf+CJgtfYHhDVveNWbB
        DNSnTXnQcBS5x2UWo4L43Emmx9bq2PDeyaj6fh+izC0Rj0Z0ms7HGEedp9xFRJRT
        IdleXCv/KYBMWtSLdzVZqmI6UqC3Am1OdlEB6c0ShG0ZPd6l0oSoq3MYdxL8bF0M
        Ov+gd2C+VGRFCfGX579aS1NNGEYeMepl06UpC2pdW3NSJoAMVSxSfwjINqNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664963900; x=1664967500; bh=MxxMRDfEHOQi5+nDumNVbTgRThG0
        gUKh/x3oMnocNco=; b=k/LgWYEQ4plZKY81euqM1y9WWeZpyTgDh+Utx34fiWcH
        tueYqOx5ygZOjcRzXtNynTSKRum33aGLXXYtpWzAsiyR4KG0rClWluF7MG3i4CTc
        pwANzyzUR1uO0zMrqE6l78D8A7QLD8ylv7V1vzM1SdapxxFE/qsqdWgWUvvoX1t4
        UOvy4qeEWoYZkjxQTfhuJ/Fshddg2fA9iCKgLsAFgDTLXoBeH2noSZ8ALEQDtLtP
        26DvVFoQ7dHTRuL3yNpBlN69M0gTX8IxnGvy9JZg0YWD4LM2iHIXNES/XOPVQKrt
        VF6PMWY1KO8yK3qVWtvxh4+Ywj1IyxC0PTBNsbKIig==
X-ME-Sender: <xms:OlU9Y3Xkyc3wvk78mSeW9XNVvuoQcdHfEvKVorRz4Q5Dk2Odmx69Zw>
    <xme:OlU9Y_l_CVx44Emjsgq-GpNd4pueoGuCVgOPZHzAl8jSQQjOD4rz101njXovurXoG
    1PqJ-Tqr77G6BuWLBs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeifedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:OlU9YzaL8Zdmnb1Ruh3YAWIBoX_Q0Bhd0axAZaSORn9lTQyhVIQ4TQ>
    <xmx:OlU9YyU2liM2dW_2DzP4U8zRZpFu7pQVHWixgZAWihjjnIyriFRBCA>
    <xmx:OlU9YxkQ-lf95koBJOcUhrGcT9MizbuYjlhynvsa0ZS3T-2ZxAk1Xg>
    <xmx:PFU9Y7pUafo5ZcQnzVLJou_wEcv5ZuS6vKgr_fOghsMP70Ldtpt4XQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D5467B60086; Wed,  5 Oct 2022 05:58:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <e7340230-9a5b-4caf-a7b0-d048cc335994@app.fastmail.com>
In-Reply-To: <YzxwoELNBctbhjJb@spud>
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YzxwoELNBctbhjJb@spud>
Date:   Wed, 05 Oct 2022 11:57:58 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Conor Dooley" <conor@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc:     "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Magnus Damm" <magnus.damm@gmail.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Philipp Tomsich" <philipp.tomsich@vrull.eu>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Anup Patel" <apatel@ventanamicro.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [RFC PATCH v2 2/2] soc: renesas: Add L2 cache management for RZ/Five SoC
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022, at 7:42 PM, Conor Dooley wrote:
> On Mon, Oct 03, 2022 at 11:32:22PM +0100, Prabhakar wrote:
>> 
>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> ---
>>  arch/riscv/include/asm/cacheflush.h    |   8 +
>>  arch/riscv/include/asm/errata_list.h   |   2 +
>>  arch/riscv/include/asm/sbi.h           |   1 +
>>  arch/riscv/mm/dma-noncoherent.c        |  20 ++
>
> Stupid question maybe, but I assume you mixed the driver addition and
> the changes to arch/riscv for the sake of easily creating the RFC?
>
>>  drivers/soc/renesas/Makefile           |   4 +
>>  drivers/soc/renesas/rzf/Makefile       |   3 +
>>  drivers/soc/renesas/rzf/ax45mp_cache.c | 365 +++++++++++++++++++++++++
>>  drivers/soc/renesas/rzf/rzf_sbi.h      |  27 ++

My feeling is that L2 cache behavior should live in arch/riscv
rather than drivers/soc/, since this is not specific to a SoC
family but rather the CPU core. I would also expect that the
actual implementation and DT binding can be shared with
non-renesas SoCs using the same CPU core.


    Arnd
