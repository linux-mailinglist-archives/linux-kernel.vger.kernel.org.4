Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3288F69E7E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBUSw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBUSwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:52:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA89C2A6EE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DEA6B810A7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EB7C43443
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677005541;
        bh=/mXtFXGJ81exw6kuNtVXE+p3M/XZezk3bPQ8kT5cbJI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FYzE3XoIfBxFT6a35t1WfVYtyoM/fnd3FGO+y1tzGknnOa3Q5x49ydQjXzbAXgQpd
         48gqtfeff/mekcAn015XBdrs6MjtGv7pD5mA64CnWfaLW0tAR2mFS8RaqPh2AYLYBu
         drN6ZaiyzGUm1ud8gW9IT6WcBUt0WM1+v1iOl1xRHXfe32uvE/qVATV0Ir0/qcgSC7
         f1OnaecaGhkMpLB3wbPf1IH7TFF2oSSqMCjXfPJ1wwQnyv58QxlHtsYTGOrYxLJl2O
         irE1CEkzzGsl0K3IrR8k7nh7iaSEOaNPaZU2cz7tGO5TgMAfum3uVf79BeXmVDnnbm
         8GWN1Ktp4F+3Q==
Received: by mail-ed1-f41.google.com with SMTP id ee7so6131511edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:52:20 -0800 (PST)
X-Gm-Message-State: AO0yUKUnxtPv6HXo+HonyC0lAcagpTJyqi6HuMNB5HLQkECrQWo5d23F
        DLu8SAaA4EQYgVMm1go+lNA748Dv+Jor11Bj9QeDuA==
X-Google-Smtp-Source: AK7set/FHz7eL5bS7ffeak7FH8S5Zv/GCP8RRPw/9WXHI+FVHUcKljHvREOXJpmZLIc7eamBPDN4IneaMtA9DGf1qwU=
X-Received: by 2002:a17:906:938b:b0:8a5:c8bd:4ac4 with SMTP id
 l11-20020a170906938b00b008a5c8bd4ac4mr6040686ejx.15.1677005539117; Tue, 21
 Feb 2023 10:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20230220120127.1975241-1-kpsingh@kernel.org> <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <Y/OETPFTJbGtCADM@zn.tnic> <3a65d18f-b218-60e7-4748-f1609eb76fd5@citrix.com>
 <Y/PhxDIVsa4WU5gu@zn.tnic> <50231372-2d6d-e4af-be88-5fe45e0c210d@citrix.com> <CACYkzJ6k+Gm5NogQ6u4kLcHYfhyvNOtL3RvmDoJYq9KH5c4eqw@mail.gmail.com>
In-Reply-To: <CACYkzJ6k+Gm5NogQ6u4kLcHYfhyvNOtL3RvmDoJYq9KH5c4eqw@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 21 Feb 2023 10:52:08 -0800
X-Gmail-Original-Message-ID: <CACYkzJ6NaU29uULf9q+DjrgCfQsUH0bAFjBZbkUBRmPR_Ep_3A@mail.gmail.com>
Message-ID: <CACYkzJ6NaU29uULf9q+DjrgCfQsUH0bAFjBZbkUBRmPR_Ep_3A@mail.gmail.com>
Subject: Re: [PATCH RESEND] x86/speculation: Fix user-mode spectre-v2
 protection with KERNEL_IBRS
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, pjt@google.com, evn@google.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
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

On Mon, Feb 20, 2023 at 3:45 PM KP Singh <kpsingh@kernel.org> wrote:
>
> On Mon, Feb 20, 2023 at 3:31 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> >
> > On 20/02/2023 9:10 pm, Borislav Petkov wrote:
> > > On Mon, Feb 20, 2023 at 07:57:25PM +0000, Andrew Cooper wrote:
> > >> I think we're discussing the legacy IBRS case here.  i.e. what was
> > >> retrofitted in microcode for existing parts?
> > > Any IBRS actually. The one which is *not* the automatic, fire'n'forget
> > > thing.
> >
> > /sigh so we're still talking about 3 different things then.
> >
> > 1) Intel's legacy IBRS
> > 2) AMD's regular IBRS
> > 3) AMD's AutoIBRS
> >
> > which all have different relevant behaviours for userspace.  Just so
> > it's written out coherently in at least one place...
> >
> > When SEV-SNP is enabled in firmware, whether or not it's being used by
> > software, AutoIBRS keeps indirect predictions inhibited in all of
> > ASID0.  That's all host userspace to the non-hypervisor devs reading
> > this thread.
> >
> > For any AMD configuration setting STIBP, there must be an IBPB after
> > having set STIBP.   Setting STIBP alone does not evict previously
> > created shared predictions.  This one can go subtly wrong for anyone who
> > assumes that Intel STIBP and AMD STIBP have the same behaviour.
>
> This is very useful, but I think this is also why the STIBP and IBPB's
> conditionals seemed to be tangled together. The prctl / seccomp code
> should set STIBP and trigger an IBPB.
>
> I took a stab at the documentation piece, Andrew and others could you
> help me with a review and suggestions?
>
> diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst
> b/Documentation/admin-guide/hw-vuln/spectre.rst
> index c4dcdb3d0d45..d7003bbc82f6 100644
> --- a/Documentation/admin-guide/hw-vuln/spectre.rst
> +++ b/Documentation/admin-guide/hw-vuln/spectre.rst
> @@ -479,8 +479,17 @@ Spectre variant 2
>     On Intel Skylake-era systems the mitigation covers most, but not all,
>     cases. See :ref:`[3] <spec_ref3>` for more details.
>
> -   On CPUs with hardware mitigation for Spectre variant 2 (e.g. Enhanced
> -   IBRS on x86), retpoline is automatically disabled at run time.
> +   On CPUs with hardware mitigation for Spectre variant 2 (e.g. IBRS
> +   or enhanced IBRS on x86), retpoline is automatically disabled at run time.
> +
> +   Setting the IBRS bit implicitly enables STIBP which guards against
> +   cross-thread branch target injection on SMT systems. On systems
> with enhanced
> +   IBRS, the kernel sets the bit once, which keeps cross-thread protections
> +   always enabled, obviating the need for an explicit STIBP. On CPUs
> with legacy
> +   IBRS, the kernel clears the IBRS bit on returning to user-space, thus also
> +   disabling the implicit STIBP. Consequently, STIBP needs to be explicitly
> +   enabled to guard against cross-thread attacks in userspace.
> +
>
>     The retpoline mitigation is turned on by default on vulnerable
>     CPUs. It can be forced on or off by the administrator
> @@ -504,9 +513,12 @@ Spectre variant 2
>     For Spectre variant 2 mitigation, individual user programs
>     can be compiled with return trampolines for indirect branches.
>     This protects them from consuming poisoned entries in the branch
> -   target buffer left by malicious software.  Alternatively, the
> -   programs can disable their indirect branch speculation via prctl()
> -   (See :ref:`Documentation/userspace-api/spec_ctrl.rst <set_spec_ctrl>`).
> +   target buffer left by malicious software.
> +
> +   On legacy IBRS systems where the IBRS bit is cleared and thus disabling the
> +   implicit STIBP on returning to userspace, the programs can disable their
> +   indirect branch speculation via prctl() (See
> +   :ref:`Documentation/userspace-api/spec_ctrl.rst <set_spec_ctrl>`).
>     On x86, this will turn on STIBP to guard against attacks from the
>     sibling thread when the user program is running, and use IBPB to
>     flush the branch target buffer when switching to/from the program.
>

I sent a new revision in
https://lore.kernel.org/lkml/20230221184908.2349578-1-kpsingh@kernel.org/T/#t
(I forgot to Cc Andrew, I would appreciate if you can have a look) and
I should not have added stable yet (mentioning it before it gets
called out)
