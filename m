Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4610F621F9E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKHW71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiKHW7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:59:24 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F086623A2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 14:59:23 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id e11-20020a4ab14b000000b0049be568062bso2246672ooo.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 14:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BksNmJr9/G65J0IUfruVbXUCosG4IvOng5/LXlEyWfc=;
        b=sP90Hxk8uTXToM6rA+n0zpJf4uCmThqIh4903RqZLnhC5dvBplEpETcRcMMDOhghLN
         FcbqjoX88LzuOcU2Kcahd5PpWUNrUYxOw4P04oNu0Be8nrVALqxMSV2EgNuU1nnkQId0
         gAHqYW+Z6K/788cFCxGeL5pM9Au59ZUxSnt6ufp68NBeTK5M2oRK2g36FB+v/GQKFiLI
         BDalbHYMSp/HVLxq++ub5yCc75h5UWJadDp8H/gyK+68DY0Zky2kLiWT4tjXxJ/rc1vm
         AqyNUm767N3cugAIRaLVTrDpqT4v551YbPWeqKY7fj9VUfDyFsVefGX9i6o8YR45eb4O
         /pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BksNmJr9/G65J0IUfruVbXUCosG4IvOng5/LXlEyWfc=;
        b=Up4/S7xJIsRzVT1sWo7QQ1/9ZN+gWF4QwdGksf0bkQ+Jy27k0cJI97lLSRzt80Y8aO
         4cJjD8AL3Bmx2AwAaxicVCedlz46LdKTEH0QK2YvZWTFRJOmW4d4UwwiEJyDOKbSBpAa
         qZq2Lne1A8z65Xdtzu/XgsZw1AjIzfyZxOSAy4uaSFSpLtaOpHt6J3f/wGWKp87m3F9/
         m7f0iugBLUIjZ42GIiZCcME39+Es3nxF3Mg4ZuwpYiN2yYnKswL+Ye6qyPO6Bq5jXFW9
         ny3HLAIqu+anX7Qoty7dhO9r85rJFVwDcblNh5PyOWormnsbu4hPL4/m/9wy4CRiiRNW
         aq/g==
X-Gm-Message-State: ACrzQf0SSa74Qgvtx8AuLnhyN7ihECpird+R3DYoY+KjFSIuSH5Ij26V
        vBvuCW0wylJvyDHhVk6tgq22kQxX0u0F0fAe+1fRUQ==
X-Google-Smtp-Source: AMsMyM5B2SF57F48P+yb2v9B3TLUan4HlNTgXnRYSW6AKC/5CgdIGauhtqTai63v8JxRJZx2o1bcy0tk3RgoPJM7MzI=
X-Received: by 2002:a4a:d8d4:0:b0:49c:e0de:ebbe with SMTP id
 c20-20020a4ad8d4000000b0049ce0deebbemr15766402oov.31.1667948362297; Tue, 08
 Nov 2022 14:59:22 -0800 (PST)
MIME-Version: 1.0
References: <20221104213651.141057-1-kim.phillips@amd.com> <20221104213651.141057-4-kim.phillips@amd.com>
 <CALMp9eSpKGCYK_1r3o326ui5RVoH73_RR5-LR2Div9Jm5zvk6A@mail.gmail.com>
 <f25152d2-7045-94f4-d5dc-69b609c0be6a@amd.com> <CALMp9eQF7iPXCNkafmaGHY5Dzg+opt0xp+Y8ceML8RTxFyCo7A@mail.gmail.com>
 <4c8945ae-62c4-7550-dc75-068cca99e678@amd.com>
In-Reply-To: <4c8945ae-62c4-7550-dc75-068cca99e678@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 8 Nov 2022 14:59:11 -0800
Message-ID: <CALMp9eRcLPpt-OuXiNFUQwrkyDxRXErY7U_U3PZE0qN_ep7wdw@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/speculation: Support Automatic IBRS under virtualization
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 2:48 PM Kim Phillips <kim.phillips@amd.com> wrote:
>
> On 11/7/22 4:42 PM, Jim Mattson wrote:
> > On Mon, Nov 7, 2022 at 2:29 PM Kim Phillips <kim.phillips@amd.com> wrote:
> >>
> >> On 11/4/22 5:00 PM, Jim Mattson wrote:
> >>> On Fri, Nov 4, 2022 at 2:38 PM Kim Phillips <kim.phillips@amd.com> wrote:
> >>>>
> >>>> VM Guests may want to use Auto IBRS, so propagate the CPUID to them.
> >>>>
> >>>> Co-developed-by: Babu Moger <Babu.Moger@amd.com>
> >>>> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> >>>
> >>> The APM says that, under AutoIBRS, CPL0 processes "have IBRS
> >>> protection." I'm taking this to mean only that indirect branches in
> >>> CPL0 are not subject to steering from a less privileged predictor
> >>> mode. This would imply that indirect branches executed at CPL0 in L1
> >>> could potentially be subject to steering by code running at CPL0 in
> >>> L2, since L1 and L2 share hardware predictor modes.
> >>
> >> That's true for AMD processors that don't support Same Mode IBRS, also
> >> documented in the APM.
> >>
> >> Processors that support AutoIBRS also support Same Mode IBRS (see
> >> CPUID Fn8000_0008_EBX[IbrsSameMode] (bit 19)).
> >>
> >>> Fortunately, there is an IBPB when switching VMCBs in svm_vcpu_load().
> >>> But it might be worth noting that this is necessary for AutoIBRS to
> >>> work (unless it actually isn't).
> >>
> >> It is needed, but not for kernel/CPL0 code, rather to protect one
> >> guest's user-space code from another's.
> >
> > The question is whether it's necessary when switching between L1 and
> > L2 on the same vCPU of the same VM.
> >
> > On the Intel side, this was (erroneously) optimized away in commit
> > 5c911beff20a ("KVM: nVMX: Skip IBPB when switching between vmcs01 and
> > vmcs02").
>
> Then why hasn't it been reverted?

Sometimes, the wheels turn slowly. See
https://lore.kernel.org/kvm/20221019213620.1953281-1-jmattson@google.com/.

> Does its rationale not make sense?:
>
>      The IBPB is intended to prevent one guest from attacking another, which
>      is unnecessary in the nested case as it's the same guest from KVM's
>      perspective.

No, it doesn't. IBRS promises to protect the host from the guest. To
properly virtualize IBRS, KVM has to provide that protection,
regardless of its "perspective."
