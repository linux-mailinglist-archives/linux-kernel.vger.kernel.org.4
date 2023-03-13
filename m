Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571C46B7B88
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCMPJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCMPI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:08:57 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6491A1EFCB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:08:35 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id p39-20020a056a0026e700b0062315c420d6so2707621pfw.21
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678720115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxVtFxj5uIOOrP7E5ckXz59l5LUm4FTXlW2JIMeCZC4=;
        b=lbU3RYJo7s2aZnku7crrKpLwQN66z0CQKamdFxZyBvXHpfPHa8kylP7pfqZ73mh7J9
         P8myWTj3MzzXvIwT0n9M7Hyj2SdHLh1xBeUuPZLIczgpkh4oM/AaV9oVKLz4u6Qu7D/T
         Cf01LzFd4uEHzo/BlRgMedg08jFu6VfyrEXRgReh6CcItRBytxTMmKV1xfBlvs3qhJM1
         qEcqXiOwgudVfn3oIjJkVzJwhXzhfXlLyvCfZcSmhNX7r2RmpRZd7SQyjhdtmAxirriT
         GHVd2V4tA0V+wMEezeyRpVMpQjZc16CLECIGBThoO7sPuX+4zNIoQIDmovLqGMuVDiq2
         w/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678720115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxVtFxj5uIOOrP7E5ckXz59l5LUm4FTXlW2JIMeCZC4=;
        b=TEw3Hyk8kJbR3x3ur0cepWaJikcviUlHUUQAbe0HuPFASqBf+yfErgEpc55MWzBaBs
         PG1cmGyp+eOOCrg+XzRLss+IMJSDmb2l9C9eeOVkGteP1KE6YzQ8rXOrDzT1L+7SYI76
         7ebYcgXXPn0M5GSj1rHumf0N5VETT9gWQPvTN7vrpCiNv59Jnku/gyFSIiDIKnsAI32i
         1Nd0tvsJ0C1jcwOKzDPUHS1aVYxHUYffgVLdvGgows91ApNTZkE6XWPwy0z8K+pfwx14
         xV/dk4NK3mWZtIXvvmAlkQTZxuOPDrLhSv0zo/M8no7gqZ8B0A3WAR3dkUc7Mp9DTkMG
         TJhQ==
X-Gm-Message-State: AO0yUKXXVMffUGJxpaZu7NvSSDHiiEQUqo0r0YPssbY8ZZMLo8C9hJF0
        ajoYk2vs//wTVSaf5RGRdtqj4Yp/EU0=
X-Google-Smtp-Source: AK7set/ypfmiMHKiQWM0Mr5K258qJZo5qN/vPg3C/rQu5ihDKnRH/PNe8kDR9buo0iugWL9UiE7JrRt/LxI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:66c6:0:b0:4fc:2a22:898a with SMTP id
 c6-20020a6566c6000000b004fc2a22898amr11206098pgw.3.1678720114907; Mon, 13 Mar
 2023 08:08:34 -0700 (PDT)
Date:   Mon, 13 Mar 2023 08:08:33 -0700
In-Reply-To: <20230312151731.GB1757905@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
References: <cover.1678474914.git.jpoimboe@kernel.org> <016c1e9cbdf726a885a406ff6baed85087ad1213.1678474914.git.jpoimboe@kernel.org>
 <20230310205926.GB1605437@hirez.programming.kicks-ass.net>
 <20230311012004.vyc4kdlqjsv4zliw@treble> <20230312151731.GB1757905@hirez.programming.kicks-ass.net>
Message-ID: <ZA88cQ58/qW0D0TZ@google.com>
Subject: Re: [RFC][PATCH 1/5] static_call: Make NULL static calls consistent
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023, Peter Zijlstra wrote:
> On Fri, Mar 10, 2023 at 05:20:04PM -0800, Josh Poimboeuf wrote:
> > On Fri, Mar 10, 2023 at 09:59:26PM +0100, Peter Zijlstra wrote:
> > > > -#define __static_call_cond(name)					\
> > > > -({									\
> > > > -	void *func = READ_ONCE(STATIC_CALL_KEY(name).func);		\
> > > > -	if (!func)							\
> > > > -		func = &__static_call_nop;				\
> > > > -	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
> > > > -})
> > > 
> > > So a sufficiently clever compiler can optimize the above to avoid the
> > > actual indirect call (and resulting CFI violation, see below), because
> > > __static_call_nop() is inline and hence visible as an empty stub
> > > function. Currently none of the compilers are that clever :/
> > 
> > I won't hold my breath waiting for theoretical optimizations.
> 
> Well, I'm thinking the clang folks might like this option to unbreak the
> arm64 build. At least here they have a fighting chance of actually doing
> the right thing.
> 
> Let me Cc some actual compiler folks.

+Will and Kees too for the arm64+CFI mess.

https://lore.kernel.org/all/YfrQzoIWyv9lNljh@google.com

> > > This will break ARM64 I think, they don't HAVE_STATIC_CALL but do have
> > > CLANG_CFI, which means the above will end up being a runtime indirect
> > > call to a non-matching signature function.
> > > 
> > > Now, I suppose we don't actually have this happen in current code by the
> > > simple expedient of not actually having any static_call_cond() usage
> > > outside of arch code.
> > > 
> > > (/me git-grep's some and *arrrggh* trusted-keys)
> > > 
> > > I really don't think we can do this though, must not promote CFI
> > > violations.
> > 
> > Ouch, so static_call_cond() and __static_call_return0() are broken today
> > on CFI_CLANG + arm64.
> 
> Yes. Now __static_call_return0() should really only happen when
> HAVE_STATIC_CALL per the definition only being available in that case.
> 
> And static_call_cond() as implemented today *might* just be fixable by
> the compiler.
> 
> > Some ideas:
> > 
> >   1) Implement HAVE_STATIC_CALL for arm64.  IIRC, this wasn't worth the
> >      effort due to restricted branch ranges and CFI fun.
> 
> The powerpc32 thing did it, iirc a similar approach could work for arm.
> But this would basically mandate HAVE_STATIC_CALL for CFI_CLANG.
> 
> > 
> >   2) Create yet another "tier" of static call implementations, for
> >      arches which can have the unfortunate combo of CFI_CLANG +
> >      !HAVE_STATIC_CALL.  CONFIG_ALMOST_DONT_HAVE_STATIC_CALL?
> > 
> >      The arch can define ARCH_DEFINE_STATIC_CALL_NOP() which uses inline
> >      asm to create a CFI-compliant NOP/BUG/whatever version of the
> >      function (insert lots of hand-waving).  Is the kcfi hash available
> >      to inline asm at build time?
> 
> Yes, clang creates magic symbol for everything it sees a declaration
> for. This symbols can be referenced from asm, linking will make it all
> work.
> 
> And yes, C sucks, you can't actually create a function definition from a
> type :/ Otherwise this could be trivially fixable.
> 
> >   3) Use a jump label to bypass the static call instead of calling
> >      __static_call_nop().  NOTE: I couldn't figure out how to do this
> >      without angering the compiler, unless we want to change
> >      static_call() back to the old-school interface:
> > 
> >         static_call(foo, args...)
> > 
> > Is it Friday yet?
> 
> Always right :-)
> 
> And yes, the whole premise of all this is that we let the compiler
> generate the actuall CALL and then have objtool scan the output and
> report the locations of them. There is no way to intercept this at the
> compiler level.
