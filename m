Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C303866986D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjAMNZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241471AbjAMNZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:25:08 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E1A6A0C2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:16:53 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id v6so9241747ejg.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlCw+zZM+W0MIRuZZ9a+0t+5twIPtxY+d3mAecrMHG0=;
        b=aJ+qO/wntm5Sh3d2sH0EboaTSwBg43UeydQCepU9Dwcdfbnfk0bnxaVO4Tz1I2hpMM
         wmpAmaRxb/t0V45AOs/Og3rD3+pDn2nWgPF5K+rJtI9z27YH6fQjWh5h1rnh23/QE/Bw
         HAelQHtDb1IqC7Oba2euFvVTvi/KRovTaXZHgbeTl7If1knWpa4Zrgz070yc1vzmSneM
         jUv3TeFShdx5cF1NOWaRDNoRe249I/vk8J71D9YhRv6RA5CQUVvkg/jaNt/RaUD1jMmK
         x9qzjJtju6LpxTsL7TqMoY5mDf/aRI2PbUoA+ssjf8TVocwFvYvCj6RiBkTcUJB3NxFd
         F13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlCw+zZM+W0MIRuZZ9a+0t+5twIPtxY+d3mAecrMHG0=;
        b=jHuzOvjisX2zfTd6kON3SWgCoxV2RmjVdRCUC5WRWLMTjKTS/wvpPSQ+Gxq8yXKgef
         f1jhdhKHvTao/n5jsXToDH8k9fglFz1QXDBwJMGnhKYe1s58gjRE4UHjQzRhPTVllTzC
         erGpEVhBzllH8gTIM18ZbbameLdP1IUu/y0KvaR8J6VdIxwWlm+RtJjpeCi85rYnAnJ/
         kgO2y0uUNI45h/2VCoKEmypXo/u4kgQCn4P7xG2Bni1eiQS9DYPT027/f2cKrpYVJ0Gp
         bqnZ6VMyT03Yn0jagFnyGzyDfnaJtBpWm0PDO3RilL0OapkDMUlUdLXHSK1/UPa6ZkJh
         JpWw==
X-Gm-Message-State: AFqh2kqb1rDpCsXWLMaZRZQ/26q4i9RjB5aWi9eoKbHvc7GVrpRkCYZH
        Y0Ywsfp4Bp29fTgXQtQvei8=
X-Google-Smtp-Source: AMrXdXtNjIfcqueavthjwXjDEZYtukIwVQn1HNUGbds0mLX015YBewarJuZYaImpFSWzdBXfMsjSbw==
X-Received: by 2002:a17:906:9f07:b0:7ec:27d7:1838 with SMTP id fy7-20020a1709069f0700b007ec27d71838mr85275567ejc.22.1673615811828;
        Fri, 13 Jan 2023 05:16:51 -0800 (PST)
Received: from gmail.com ([31.46.242.235])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7dc1a000000b00499c3ca6a0dsm4114514edu.10.2023.01.13.05.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:16:50 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 13 Jan 2023 14:16:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com
Subject: Re: [RFC][PATCH 2/6] x86/power: Inline write_cr[04]()
Message-ID: <Y8FZvLq+MeQ7A+lI@gmail.com>
References: <20230112143141.645645775@infradead.org>
 <20230112143825.644480983@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112143825.644480983@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> Since we can't do CALL/RET until GS is restored and CR[04] pinning is
> of dubious value in this code path, simply write the stored values.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/power/cpu.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -208,11 +208,11 @@ static void notrace __restore_processor_
>  #else
>  /* CONFIG X86_64 */
>  	native_wrmsrl(MSR_EFER, ctxt->efer);
> -	native_write_cr4(ctxt->cr4);
> +	asm volatile("mov %0,%%cr4": "+r" (ctxt->cr4) : : "memory");

>  #endif
>  	native_write_cr3(ctxt->cr3);
>  	native_write_cr2(ctxt->cr2);
> -	native_write_cr0(ctxt->cr0);
> +	asm volatile("mov %0,%%cr0": "+r" (ctxt->cr0) : : "memory");

Yeah, so CR pinning protects against are easily accessible 'gadget' 
functions that exploits can call to disable HW protection features in the 
CR register.

__restore_processor_state() might be such a gadget if an exploit can pass 
in a well-prepared 'struct saved_context' on the stack.

Can we set up cr0/cr4 after we have a proper GS, or is that a 
chicken-and-egg scenario?

Thanks,

	Ingo
