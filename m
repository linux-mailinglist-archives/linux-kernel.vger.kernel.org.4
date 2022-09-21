Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245E35C056E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiIURqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiIURqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:46:02 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1CAA1D4C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:46:01 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-127d10b4f19so10134068fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IqpJMvr6QOojppOTB8iyTdKxCDEypFmvkfPtQjp1qN4=;
        b=VJGkBNovoBW0ZTmaa5yGPlkwJmYFhQzAx/ARWFo6YlaQIlgv6kf/6SUpnZkkgCZWie
         MvGcfQiYhg/Lvz9XWhbr36zuQNinQ4I62SqXS4zTJUaYxjtDNLZo8OCN/zS2TnLbj3Vf
         zhQtU29hU6oA+ofOTebj3Q0n7bpZrv6UOeCg0K+1tzoQq8EIg3qWmMEzVNj6zCA55quC
         QWhL/5Vg0nUmUFF/FbkBXFpn5EnACSBUj2XtgdyZoIWwkKhleDY5TZvf0f3KNcpQPYrq
         XOw3Xb4Fuxc/BRsxuHExsHSyJAFCqkIZ2rFHyUT9ubspbD4SAPjpqpVOhicJ2uAKW0OL
         EmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IqpJMvr6QOojppOTB8iyTdKxCDEypFmvkfPtQjp1qN4=;
        b=SQ5+j6pnKPAGzgjITLKtsBGhgdPqViGlHpQvc2jEYfC7tJZqvuhpR7/QpRbpObONrG
         jy1odK68BvwkXwvMzDmxnKNtrYLP+R5G3ZncTY46e6fRj1d/1ZRgY3yZUQJH+R16hKaU
         4zE6D5QtDHJWG6GRtrHKYdIAqWjkiUuRX7IjPJ4RBSHa37iwxp0byZT0X7ZMPx71grvh
         piXS/lIy5s3ec9UkMymaNh20SSWRneQQN8B9CR2cY3KEbCLCM/l8mQKmT/Tom/BTjoFy
         1Pb4KtbhOPS4QFVW7dwXA/D1HsgEK8WnHchTZDZMBm+FSkNpwJw8ltP6hNe5Lz+bmdHl
         9ccg==
X-Gm-Message-State: ACrzQf1IzUTiQdM/aI8lI+wpLfszUw4tzdaqtkBTeBh8csBJFG+N7xZ+
        iZcESTNUlo+O94gb2vttEYdQ3xQjrHvLihAcsI74yw==
X-Google-Smtp-Source: AMsMyM7ROHkOGtCBSmQoyiiffLBjCIuZK+Ww3QXBi3qLqjP1Nrp9cYq8j+CSIRrsediibkRzAh2IJhQWCfv/HEGo3SM=
X-Received: by 2002:a05:6870:580c:b0:12a:f136:a8f5 with SMTP id
 r12-20020a056870580c00b0012af136a8f5mr5635355oap.269.1663782360610; Wed, 21
 Sep 2022 10:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220920205922.1564814-1-jmattson@google.com> <Yyot34LGkFR2/j5f@zn.tnic>
 <CALMp9eQijCKS-E_OWJkxdqAur3BthciOWEtEPH5YKd0-HJiQQA@mail.gmail.com>
 <YyrZOLq8z+lIORvP@zn.tnic> <CALMp9eRG6g-95zCxTD1NnxpZ+Vm6VMTA0_uaHV=b-hDkeOYSuA@mail.gmail.com>
 <YysXeXKY36yXj68q@zn.tnic> <CALMp9eTuO79+NfHxLi8FnqdOpzXO7eQUntvN23EfR+shg+wg2Q@mail.gmail.com>
 <Yys2ikzV73upzlEj@zn.tnic> <CALMp9eQ-qkjBm8qPhOaMzZLWeHJcrwksV+XLQ9DfOQ_i1aykqQ@mail.gmail.com>
 <YytFzvQx0BbSCT7m@zn.tnic>
In-Reply-To: <YytFzvQx0BbSCT7m@zn.tnic>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 21 Sep 2022 10:45:49 -0700
Message-ID: <CALMp9eQgsONsRVwA+bnGvccUFd9YDDRF=4PCP4rVV24fTA--+A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] KVM: EFER.LMSLE cleanup
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 10:11 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 21, 2022 at 09:23:40AM -0700, Jim Mattson wrote:
> > AMD defined the 64-bit x86 extensions while Intel was distracted with
> > their VLIW science fair project. In this space, Intel produces AMD64
> > compatible CPUs.
>
> Almost-compatible. And maybe, just maybe, because Intel were probably
> and practically forced to implement AMD64 but then thought, oh well,
> we'll do some things differently.
>
> > The definitive specification comes from AMD (which is sad, because
> > AMD's documentation is abysmal).
>
> Just don't tell me the SDM is better...
>
> But you and I are really talking past each other: there's nothing
> definitive about a spec if, while implementing it, the other vendor is
> doing some subtle, but very software visible things differently.
>
> I.e., the theory vs reality point I'm trying to get across.

I get it. In reality, all of the reverse polarity CPUID feature bits
are essentially useless.

The only software that actually uses LMSLE is defunct. That software
predated the definition of CPUID.80000008:EBX.EferLmlseUnsupported and
is no longer being updated, so it isn't going to check the feature
bit. It's just going to fail with an unexpected #GP.

Maybe you think I'm being overly pedantic, but the code to do the
right thing is trivial, so why not do it?

This way, if anyone files a bug against KVM because an old VMware
hypervisor dies with an unexpected #GP, I can point to the spec and
say that it's user error.
