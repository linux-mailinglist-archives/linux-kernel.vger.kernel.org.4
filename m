Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD2748F89
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjGEVIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:08:14 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4846819A0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:08:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-263036d54b9so86108a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688591293; x=1691183293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ug73FggPnbwdd1VaI/h85Jqlh9rWzsohKtgG2/gb7Z0=;
        b=IFNOV4ZEPbH0J7ufVwembvtKuwugzRGT0taaw/ZrLwCiQHr92VrBulxkGJ4TK/gd83
         zPM5qvFSxmaP/2MudSKJG+aGnlR0QuiW97FKCvzeSmLETNIJJkE65jMJPTuJu/pTJaTE
         iXAqFJoBzZZrjQbyBFsPvGz7xeSpFZtnBx4ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688591293; x=1691183293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug73FggPnbwdd1VaI/h85Jqlh9rWzsohKtgG2/gb7Z0=;
        b=NUg8bcrdhd99cgMkpu1vb2dGOc+8WzAHOjC6lqQaeEdGF9zD8i/ZTsQWmRKtfDT/QZ
         zWQ+qpGgClwKOJwIQSZGjw4ehcb+gSeg7tqP2t1bnZTz1dUpL/8DoQEN3t4+XVg7XF46
         bN9PnCFXGvYFFl7nHtdBvbeAiKG5qC++yVNZn3yVYR7Aqmdsu+JlSWQ5DPkK41bOY20S
         +WZXzyQqN7Egpe63Pj/YiwxpPQ/2Nc/J7JNFY6BhclMkWzzsTrNbtsmielxP21UjXI62
         kCgEcxXV4bkTpCCdu8CyEFW4wC0Sk0vfNlK0ps08L/w3tRxPQl+96uUcXh8AQ8iYNKcQ
         0N/w==
X-Gm-Message-State: ABy/qLYkjDC6hbJkyRVBTuW3mYZ7mkDddBn+XeeYP0a8gXemevbemo73
        MTPzkrrcKOA0uhYGYuee1sIT9GkL39kg2Kry/ow=
X-Google-Smtp-Source: APBJJlEaIv/sTfl7OmBOeeEHSIo6/1kWdH6bBSD96cPSluFsMWjo9kBujHQEFtQf0dJEt3j/VamBsA==
X-Received: by 2002:a17:90a:358:b0:263:e804:3988 with SMTP id 24-20020a17090a035800b00263e8043988mr5089443pjf.1.1688591292720;
        Wed, 05 Jul 2023 14:08:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cx3-20020a17090afd8300b00263987a50fcsm1815914pjb.22.2023.07.05.14.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 14:08:11 -0700 (PDT)
Date:   Wed, 5 Jul 2023 14:08:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <kees@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: CONFIG_UBSAN_TRAP #UD error message on x86 [was: Re:
 [CRASH][BISECTED] 6.4.1 crash in boot]
Message-ID: <202307051405.E746464@keescook>
References: <2b1a4f49-ba18-0246-af09-4e4133814411@alu.unizg.hr>
 <202307022230.6121D6896@keescook>
 <ed3e4315-b149-2f9e-70d4-45d7f83b9922@alu.unizg.hr>
 <202307031149.823F9A3@keescook>
 <202307031606.3FD9D0D@keescook>
 <fbf4103b-6471-1f06-34a8-4aa227f5e091@alu.unizg.hr>
 <3CDD1188-7B2A-4D53-9B8F-C07BC39844E9@kernel.org>
 <19d0e63c-db47-8f02-2f79-0923f675898c@alu.unizg.hr>
 <DA3FEB08-DF39-406B-89CC-9076CFCF597A@kernel.org>
 <CAG48ez0kmSqS_WJ1=neKpxKmMMkPYgNHfBD6ZSif_EWnso84wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0kmSqS_WJ1=neKpxKmMMkPYgNHfBD6ZSif_EWnso84wQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 05:16:36PM +0200, Jann Horn wrote:
> On Wed, Jul 5, 2023 at 4:10 AM Kees Cook <kees@kernel.org> wrote:
> > On July 4, 2023 4:15:20 PM PDT, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> wrote:
> > >On 7/4/23 23:36, Kees Cook wrote:
> > >> On July 4, 2023 10:20:11 AM PDT, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> wrote:
> > >>> all Wayland and X11.org GUI applications fail to start, with errors like this one:
> > >>>
> > >>> Jul  4 19:09:07 defiant kernel: [   40.529719] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > >>
> > >> Hmm, is CONFIG_UBSAN_TRAP set?
> > >
> > >marvin@defiant:~/linux/kernel/linux_torvalds$ grep CONFIG_UBSAN_TRAP .config
> > >CONFIG_UBSAN_TRAP=y
> >
> > Ah-ha! Turn that off please. With it off you will get much more useful reports from USBAN.
> 
> It might be useful if the x86 code under handle_invalid_op() at least
> printed a warning about this when the kernel crashes with #UD on a
> system with CONFIG_UBSAN_TRAP=y? It seems pretty unintuitive and
> unhelpful that the kernel just crashes itself with a #UD and no
> further information in this configuration.
> 
> Even just a "WARNING: CONFIG_UBSAN_TRAP active, #UD might be caused by
> that" on every #UD that does not come from a known BUG() location or
> such might be better than nothing...

I've considered it, but usually CONFIG_UBSAN_TRAP isn't accidentally
set. Also, the crash info is something we can get help from on the
compiler side, to mark up where the traps are, similar to what we do
with KCFI, but it hasn't happened yet for x86. For example, arm64
already encodes the details in the trap instruction itself:
https://git.kernel.org/linus/25b84002afb9dc9a91a7ea67166879c13ad82422

> And maybe the Kconfig help text could be clearer on this, too.
> Currently it does say that this turns warnings into "full exceptions
> that abort the running kernel code" but it does not say that the
> exception reporting will become pretty unhelpful, so it's probably not
> really what you'd want for debugging.

Yeah, that's a reasonable change to make. Can you send a patch for this?
I can carry it.

Thanks!

-- 
Kees Cook
