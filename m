Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096336A0597
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjBWKGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjBWKGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:06:12 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1370037726;
        Thu, 23 Feb 2023 02:06:11 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 69D505C00F8;
        Thu, 23 Feb 2023 05:06:10 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 23 Feb 2023 05:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677146770; x=1677233170; bh=lqOjciWNUa
        TbPpSK8T8cQbiQqBz956A9nanEyGupbck=; b=ljw/thsfIRiehOYm8HAtskNISx
        kzERBwBxp1e1n1gj+Voqu5B6kbILBeXDeAYok9KkZcTEi+x1eZOZwETx4JW9CQad
        7rUh6qHhd3hIeNhKLU3PGnqA3jekEJc04GvDsrlsUHOaV/RaTEZietG4OgZQwEJd
        pByQPJS5kv05iNvniiiEnbSSwjkqF/PRwXDH4c2Amp23ajAnmrI/8PEIkGu4US2H
        /NjCs/GTEAd3vu7DKOktRWxfYMiilqMzKSqw+O6V7MfkUyV6VhU4eX9w+8EWBxnU
        xBfEXTtz5xGhFGXjvxBYx7S4NJpFZvZv3R5UJvoEpqDcTLfURZOAq6bvF15g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677146770; x=1677233170; bh=lqOjciWNUaTbPpSK8T8cQbiQqBz9
        56A9nanEyGupbck=; b=pmfFGQOYPCPVrNb7YXtteVcO/pXfx/iF8RMeyfvsgtNi
        T+8Vg1CWTnGIBeDpRuwbozW4We4OabRfaHh6ZOSAcvDGyItI68X9soMg91tkFfKs
        MxrtQizscSVJQtJe1i+HanJ/7gxgd9KN9p7GsR8WvJQhnYeav5SndvgvJdxjmrMK
        Sj99TCF2JSNmdSg/4nYpjdeqNMP5Wj0u+yVBBoMptey2ebN3R78/fihLW/pdQ4aV
        Nidu+J0wLwwjR/hCye59VUcUyPkhPmso+DXS0rrhsUTM0lFYo10NkYl/8uvrpfxO
        e/e+WEcWLaCIPc/eNiD1R2cGnAx+LOlPoLXYzNTt/Q==
X-ME-Sender: <xms:kTr3Y5APWDxGxO1x3t0YYzj8Ec9ZKZRDqcg5j69lmxnopFwtaC3Fiw>
    <xme:kTr3Y3gcMFC1Pc6gpNdzpDrv5Mcu5smfSRiUfpmh-G8J7fMxuZ_hGfI9FA232tJNx
    1IOtQ_fIcgNVPn3bxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kTr3Y0lHEKTj2EQurzOdA-gyZyc0bcNO_prdbhdZN6zljBpXeX62ew>
    <xmx:kTr3YzxcKcWciGMpR_e3ASgEsdx8e8ORKk1zQPAQA16Vf4QpmikAQQ>
    <xmx:kTr3Y-TxDWfYrwAWmVga6OO1Fs4Vju5aRCLpyQ2SX8mz6O4YNVft9A>
    <xmx:kjr3Y3CoVDqB_eZoZe10LaR2aRZJqCyMgdQHbKgx_cyaVgI_H5dNoQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9D021B60086; Thu, 23 Feb 2023 05:06:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <605fb2fd-bda2-4922-92bf-e3e416d54398@app.fastmail.com>
In-Reply-To: <20230221190858.3159617-3-evan@rivosinc.com>
References: <20230221190858.3159617-1-evan@rivosinc.com>
 <20230221190858.3159617-3-evan@rivosinc.com>
Date:   Thu, 23 Feb 2023 11:06:11 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Evan Green" <evan@rivosinc.com>,
        "Palmer Dabbelt" <palmer@rivosinc.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Conor Dooley" <conor@kernel.org>, slewis@rivosinc.com,
        "Vineet Gupta" <vineetg@rivosinc.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Andrew Bresticker" <abrestic@rivosinc.com>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Celeste Liu" <coelacanthus@outlook.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        guoren <guoren@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        "Niklas Cassel" <niklas.cassel@wdc.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Ruizhe Pan" <c141028@gmail.com>,
        "Sunil V L" <sunilvl@ventanamicro.com>,
        "Tobias Klauser" <tklauser@distanz.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/7] RISC-V: Add a syscall for HW probing
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023, at 20:08, Evan Green wrote:
> We don't have enough space for these all in ELF_HWCAP{,2} and there's no
> system call that quite does this, so let's just provide an arch-specific
> one to probe for hardware capabilities.  This currently just provides
> m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> the future.
>
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>

I'm still skeptical about the need for a custom syscall interface here.
I had not looked at the interface so far, but there are a few things
that stick out:

> +RISC-V Hardware Probing Interface
> +---------------------------------
> +
> +The RISC-V hardware probing interface is based around a single 
> syscall, which
> +is defined in <asm/hwprobe.h>::
> +
> +    struct riscv_hwprobe {
> +        __s64 key;
> +        __u64 value;
> +    };

The way this is defined, the kernel will always have to know
about the specific set of features, it can't just forward
unknown features to user space after probing them from an
architectured hardware interface or from DT.

If 'key' is just an enumerated value with a small number of
possible values, I don't see anything wrong with using elf
aux data. I understand it's hard to know how many keys
might be needed in the long run, from the way you define
the key/value pairs here, I would expect it to have a lot
of the same limitations that the aux data has, except for
a few bytes to be copied.

> +    long sys_riscv_hwprobe(struct riscv_hwprobe *pairs, size_t 
> pair_count,
> +                           size_t cpu_count, cpu_set_t *cpus,
> +                           unsigned long flags);

The cpu set argument worries me more: there should never be a
need to optimize for broken hardware that has an asymmetric set
of features. Just let the kernel figure out the minimum set
of features that works across all CPUs and report that like we
do with HWCAP. If there is a SoC that is so broken that it has
important features on a subset of cores that some user might
actually want to rely on, then have them go through the slow
sysfs interface for probing the CPUs indidually, but don't make
the broken case easier at the expense of normal users that
run on working hardware.

> +asmlinkage long sys_riscv_hwprobe(uintptr_t, uintptr_t, uintptr_t, 
> uintptr_t,
> +				  uintptr_t, uintptr_t);

Why 'uintptr_t' rather than the correct type?

       Arnd
