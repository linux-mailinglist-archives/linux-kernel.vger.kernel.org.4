Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB4169EC58
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjBVB0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBVB0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:26:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0727B2CFE2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:26:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89F46B811BB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F80C433D2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677029204;
        bh=jdNBJrH5S05ctm1EF6plCEag6jotcj0Ls4KS/iSBGhk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HdP5eCWxo1MDh33/Aw6UboNfO22jKqo/AKQGZlSTC4X9nPMu7rPBlrcBaiGavFhlp
         YUspvr1TJdqFocbRXefNtVKojGxhrSXu86C5onXBocH4uVkWK9p2ajOIuh06yfUkw+
         WHSNm7XlX6pPwOFgqNEYpHx26l9nD6hJ2mUYM1Bf9b5w/Fwz+UuA0Gv/J4j7jo96/O
         vFkiB9aOq3+o378RZRCLUDvaNEmtESpAP1/m0xVAwzs2yh3AiI/96y2sRJxQN2qboE
         y3Pf8Jju4vJn90zr4jhK42jVaC4QuNugYBAuE3gZfKQiFbfMYj8TsyFeSbY7iqzaJe
         GB0GAZmwri4ag==
Received: by mail-ed1-f45.google.com with SMTP id eg37so20580996edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:26:44 -0800 (PST)
X-Gm-Message-State: AO0yUKUvWBzFgya5Q6BCYLc6j45Kg/1kxrgjTVc0WpHG4rFl1R8yppyg
        sWIx2w8m9dbDIZA6yjxogwpsL8x6mjC6IlQhVioS4A==
X-Google-Smtp-Source: AK7set+avMij1/ZgszkDgBp2QGrMpYm8V5kTz3IlVQb2ktA+Mmu6lD7Dv/1ZtAxd1Lf8mp4s0JjWdDLPHU+Ni5kHNEo=
X-Received: by 2002:a17:906:b746:b0:88d:64e7:a2be with SMTP id
 fx6-20020a170906b74600b0088d64e7a2bemr7010721ejb.15.1677029202361; Tue, 21
 Feb 2023 17:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20230220121350.aidsipw3kd4rsyss@treble> <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <20230220163442.7fmaeef3oqci4ee3@treble> <Y/Ox3MJZF1Yb7b6y@zn.tnic>
 <20230220175929.2laflfb2met6y3kc@treble> <CACYkzJ71xqzY6-wL+YShcL+d6ugzcdFHr6tbYWWE_ep52+RBZQ@mail.gmail.com>
 <20230220182717.uzrym2gtavlbjbxo@treble> <Y/O9U4KFtXE8Yoyt@zn.tnic>
 <20230220190908.gfd2c4tuzeb7cft6@treble> <20230222012009.bilnxhbm4lqyhhuy@desk>
In-Reply-To: <20230222012009.bilnxhbm4lqyhhuy@desk>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 21 Feb 2023 17:26:31 -0800
X-Gmail-Original-Message-ID: <CACYkzJ7_jYpg985GgGK17TLMJhUj0wxbSor5HE-ndN0nVgmhWw@mail.gmail.com>
Message-ID: <CACYkzJ7_jYpg985GgGK17TLMJhUj0wxbSor5HE-ndN0nVgmhWw@mail.gmail.com>
Subject: Re: [PATCH] x86/bugs: Allow STIBP with IBRS
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        pjt@google.com, evn@google.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?UTF-8?Q?Jos=C3=A9_Oliveira?= <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 5:20 PM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Mon, Feb 20, 2023 at 11:09:08AM -0800, Josh Poimboeuf wrote:
> > On Mon, Feb 20, 2023 at 07:34:59PM +0100, Borislav Petkov wrote:
> > > Drop stable@ again.
> > >
> > > On Mon, Feb 20, 2023 at 10:27:17AM -0800, Josh Poimboeuf wrote:
> > > > IBRS is only enabled in kernel space.  Since it's not enabled in user
> > > > space, user space isn't protected from indirect branch prediction
> > > > attacks from a sibling CPU thread.
> > > >
> > > > Allow STIBP to be enabled to protect against such attacks.
> > > >
> > > > Fixes: 7c693f54c873 ("x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS")
> > >
> > > Yah, look at that one:
> > >
> > > commit 7c693f54c873691a4b7da05c7e0f74e67745d144
> > > Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > Date:   Tue Jun 14 23:15:55 2022 +0200
> > >
> > >     x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS
> > >
> > >     Extend spectre_v2= boot option with Kernel IBRS.
> > >
> > >     [jpoimboe: no STIBP with IBRS]
> > >     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >
> > > I'm assuming this was supposed to mean no STIBP in *kernel mode* when
> > > IBRS is selected?
> >
> > No it was supposed to be "no STIBP with *eIBRS*".
>
> Maybe not, "no STIBP with eIBRS" was the state before the said patch.
>
> In an offlist discussion during Retbleed embargo(copied below), it
> appears to mean "no STIBP *in kernel* with IBRS". But anyways, we missed
> to consider userspace.
>
> (BTW replying late because yesterday was a holiday in my geo).
>
> ---
> > > Subject: [PATCH v5 26/30] x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS
> > >
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > > From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > >
> > > The "spectre_v2=" boot option is extended to enable Kernel IBRS.
> > >
> > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  Documentation/admin-guide/kernel-parameters.txt |    1
> > >  arch/x86/include/asm/nospec-branch.h            |    1
> > >  arch/x86/kernel/cpu/bugs.c                      |   29 ++++++++++++++++++++++--
> > >  3 files changed, 29 insertions(+), 2 deletions(-)
> > >
> > > @@ -1163,6 +1182,10 @@ static void __init spectre_v2_select_mit
> > >     case SPECTRE_V2_EIBRS:
> > >             break;
> > >
> > > +   case SPECTRE_V2_IBRS:
> > > +           setup_force_cpu_cap(X86_FEATURE_KERNEL_IBRS);
> > > +           break;
> >
> > Don't we also need to set SPEC_CTRL_IBRS in x86_spec_ctrl_base?
>
> Also, STIBP isn't needed with IBRS.  Suggested changes:
>
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 344ab7c9a4e2..498cb36587a3 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -897,11 +897,13 @@ spectre_v2_parse_user_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
>         return SPECTRE_V2_USER_CMD_AUTO;
>  }
>
> -static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)
> +static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
>  {
> -       return (mode == SPECTRE_V2_EIBRS ||
> -               mode == SPECTRE_V2_EIBRS_RETPOLINE ||
> -               mode == SPECTRE_V2_EIBRS_LFENCE);
> +
> +       return spectre_v2_mode == SPECTRE_V2_IBRS
> +              spectre_v2_mode == SPECTRE_V2_EIBRS ||
> +              spectre_v2_mode == SPECTRE_V2_EIBRS_RETPOLINE ||
> +              spectre_v2_mode == SPECTRE_V2_EIBRS_LFENCE;
>  }
>
>  static void __init
> @@ -966,12 +968,12 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
>         }
>
>         /*
> -        * If no STIBP, enhanced IBRS is enabled or SMT impossible, STIBP is not
> -        * required.
> +        * If no STIBP, IBRS or enhanced IBRS is enabled, or SMT impossible,
> +        * STIBP is not required.
>          */
>         if (!boot_cpu_has(X86_FEATURE_STIBP) ||
>             !smt_possible ||
> -           spectre_v2_in_eibrs_mode(spectre_v2_enabled))
> +           spectre_v2_in_ibrs_mode(spectre_v2_enabled))
>                 return;
>
>         /*
> @@ -1171,7 +1173,7 @@ static void __init spectre_v2_select_mitigation(void)
>         if (mode == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
>                 pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
>
> -       if (spectre_v2_in_eibrs_mode(mode)) {
> +       if (spectre_v2_in_ibrs_mode(mode)) {

Pawan can you review the v2 that I sent out here:

https://lore.kernel.org/lkml/20230221184908.2349578-1-kpsingh@kernel.org/T/#t

>                 /* Force it so VMEXIT will restore correctly */
>                 x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
>                 wr_spec_ctrl(x86_spec_ctrl_base, true);
> @@ -1212,19 +1214,17 @@ static void __init spectre_v2_select_mitigation(void)
>         pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
>
>         /*
> -        * Retpoline means the kernel is safe because it has no indirect
> -        * branches. Enhanced IBRS protects firmware too, so, enable restricted
> -        * speculation around firmware calls only when Enhanced IBRS isn't
> -        * supported or kernel IBRS isn't enabled.
> +        * Retpoline protects the kernel, but doesn't protect firmware.  IBRS
> +        * and Enhanced IBRS protect firmware too, so enable IBRS around
> +        * firmware calls only when IBRS / Enhanced IBRS aren't otherwise
> +        * enabled.
>          *
>          * Use "mode" to check Enhanced IBRS instead of boot_cpu_has(), because
>          * the user might select retpoline on the kernel command line and if
>          * the CPU supports Enhanced IBRS, kernel might un-intentionally not
>          * enable IBRS around firmware calls.
>          */
> -       if (boot_cpu_has(X86_FEATURE_IBRS) &&
> -           !boot_cpu_has(X86_FEATURE_KERNEL_IBRS) &&
> -           !spectre_v2_in_eibrs_mode(mode)) {
> +       if (boot_cpu_has(X86_FEATURE_IBRS) && !spectre_v2_in_ibrs_mode(mode)) {
>                 setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
>                 pr_info("Enabling Restricted Speculation for firmware calls\n");
>         }
> @@ -1937,7 +1937,7 @@ static ssize_t tsx_async_abort_show_state(char *buf)
>
>  static char *stibp_state(void)
>  {
> -       if (spectre_v2_in_eibrs_mode(spectre_v2_enabled))
> +       if (spectre_v2_in_ibrs_mode(spectre_v2_enabled))
>                 return "";
>
>         switch (spectre_v2_user_stibp) {
