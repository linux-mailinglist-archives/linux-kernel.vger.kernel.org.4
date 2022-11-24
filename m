Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AB06374D8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKXJKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKXJKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:10:09 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E39C4C34
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:10:09 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d6so947276pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d7AMntFoCTbaF7u0FxUzgKfkJmKiQktIj1df1EHq8pU=;
        b=1S2l4+owYsD6IrHxF9YOfpJi6VcRr1zuzHv5hwjzVJx8ggKZZcYCuJfFtrBEYkJ4J9
         1UAsRy1WzWayp7b4qCwbAFAzggFuBtbpP9VfjPbfyas20VgiSPDK20VjlBYKjarAUhG2
         9eEzUAHlB55RHaQTSlbuJkfagGnuMQ87x98O2FIiOiaQ2jsiTY4di26D9ChmnEA8Y246
         8R+gMXRQqAQ3kzV9Y93rNP0yyt4MZ+rSvhKg4qqMwBmVxChrFAR2/X9j4NYPZHlTBC/Z
         G6ggEPtVNmVFBULxaDTHw8fMQhGUp/V/Gxc0ffu7+6oLqFFFw/Bhztw+NugmxMLkYOdG
         rFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7AMntFoCTbaF7u0FxUzgKfkJmKiQktIj1df1EHq8pU=;
        b=rXbvglPUMFlpQtru3otRWr+vU0MUqI3tXYe5WnyUD264v6cMdiTOwf/jqTgvSKNWJj
         5aOGpJGILuKRWx/MxN5BEax/OrFDmACy9F8gMXwEALb1qMxQOU05ruuy+EQH1dr3AX13
         p+oHAYySBxvNwTqECJC3Qk/znPJqgs1g7s9hy4csiKLJLMf67OqGGP8Sya+nYGMEo+E2
         KB6NkW2zo4J77gVqjoOcRZElMEDOr1gi5T7iyeDO2XK1USurU4l1uLXmkpOYK/NYofVJ
         JEOBYviGuVlTei7Qyts0mHagTcQhGAS0p37bOtAVMfpGZNpmKiSG8LDVwWfO/yQ0H4I0
         9Q3A==
X-Gm-Message-State: ANoB5pmq4nKcP0UByiw3pZfUrVnuhrtxBD7VktXKzdo5DMPuuJMQS9wE
        I90p4A7uxQTlan4wbfkLSyUxVQ==
X-Google-Smtp-Source: AA0mqf42LcyoRzWh9McsWHPxstgGrkf+OE0vINQkkhl36i06YZUTlxob6EKRoCvgVfaoQuZSbV9S7A==
X-Received: by 2002:a17:90a:5909:b0:214:291f:87b5 with SMTP id k9-20020a17090a590900b00214291f87b5mr34624200pji.115.1669281008755;
        Thu, 24 Nov 2022 01:10:08 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 22-20020a621616000000b0053e468a78a8sm672742pfw.158.2022.11.24.01.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 01:10:08 -0800 (PST)
Date:   Thu, 24 Nov 2022 01:10:06 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Guo Ren <guoren@kernel.org>, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH] riscv: VMAP_STACK overflow detection thread-safe
Message-ID: <20221124091006.GC1896875@debug.ba.rivosinc.com>
References: <20221124005006.1788315-1-debug@rivosinc.com>
 <CAJF2gTQ=Vr6neABtz9JSCei6oPEsyWTpb-Y=Rxt5jy6n1VEtGA@mail.gmail.com>
 <CAKC1njRfxNx8r5SP7qsbouCFfb1L4w63paQibb=cFCBhWDXNXA@mail.gmail.com>
 <CAJF2gTRC-qm76=aaLh75amO0JJLO2P4eZaJXH-TBSV0c7iqUBA@mail.gmail.com>
 <20221124071022.GA1149630@debug.ba.rivosinc.com>
 <Y38ydMoqmqOPfBs0@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y38ydMoqmqOPfBs0@wendy>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 08:59:32AM +0000, Conor Dooley wrote:
>On Wed, Nov 23, 2022 at 11:10:22PM -0800, Deepak Gupta wrote:
>> On Thu, Nov 24, 2022 at 02:31:25PM +0800, Guo Ren wrote:
>> > On Thu, Nov 24, 2022 at 1:57 PM Deepak Gupta <debug@rivosinc.com> wrote:
>
>> > > On Wed, Nov 23, 2022 at 5:28 PM Guo Ren <guoren@kernel.org> wrote:
>
>> > > > On Thu, Nov 24, 2022 at 8:50 AM Deepak Gupta <debug@rivosinc.com> wrote:
>
>> > > >> Fixes: 31da94c25aea835ceac00575a9fd206c5a833fed
>> > > >
>> > > > The patch gives more significant change than the Fixes, and Fixes would expand to the previous stable versions. Please don't set it as a Fixes, but an improved OVERSTACK dead path performance feature.
>> > > >
>> > >
>> > > Not a performance feature but more like correctness.
>> > > If kernel died and two CPUs raced to kernel stack overflow,
>> > > death post-mortem should be straightforward.
>> > We already have had a fixup, and your patch likes a feature with a
>> > significant change.
>> > https://lore.kernel.org/linux-riscv/20221030124517.2370-1-jszhang@kernel.org/
>> > If it is for correctness, the simple lock is enough.
>>
>> Sure lock is enough. It's different way to solve the problem. But I don't
>> think it qualifies as significant change.
>
>Something to bear in mind is where in the cycle we are - there's likely
>just over a week left before v6.1.
>Since the lock is sufficient to fix the problem for v6.1, it's easy to
>view this patch as an optimisation or improvement that should go on top
>of that, smaller, patch.
>Especially when you have some questions yourself about the correctness
>for 32 bit!

Yes I'll have to revise the patch to accomodate 32bit.

>I've got no technical comment to make about the discussion here, but
>looking in from the "outside", that's the easy conclusion to jump to.
>
>
>>	REG_S x31, TASK_TI_SPILL_REG(tp)
>>	asm_per_cpu sp, overflow_stack, x31
>>	li x31, OVERFLOW_STACK_SIZE
>>	add sp, sp, x31
>>	REG_L x31, TASK_TI_SPILL_REG(tp)
>
>btw, for this sort of thing, could you please use some whitespace to
>align the operands? Makes things significantly more readable.
>

Noted. I'll do that.

>Thanks,
>Conor.
>
