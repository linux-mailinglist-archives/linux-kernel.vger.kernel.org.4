Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D375A749C89
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjGFMtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjGFMtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:49:41 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBBC1BF2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:49:18 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4036bd4fff1so296361cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688647755; x=1691239755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgkDImFEyghyk2ypFc1LD9/ccRdJBg7fDz28+FakHtQ=;
        b=EgaUHQQy5P0DZ6p4/+eM2CHSnSPzjYgnWqMcVfHjD3W5IWk11v2XWEyRrDrzCl/aJs
         A/5GBg5qD9kol1/xFhQ6DBV45oupwcqiciaj3MoqykS38Nc2wcFoLzVWCTz+kIlKsAMC
         rA7w5+gOKABPTuCabqAq6eSlcn8eJKxOJ2L08nWAjyj7TOsLrajARw5+v9WI2qJU5MAT
         fO1KOKf4CooZ2vDuDfq3ZzRkTiOU5AkH/RgK0C9F8HLUjekJ/60i1qtMzj2LU2DcXKAK
         b0paoCZ8krLxJ5RtuD3mHgYGc8NqShHWIFcpEHffxpqq754ZySwqzlf9rN5UzcNGC7M6
         6Yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688647755; x=1691239755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgkDImFEyghyk2ypFc1LD9/ccRdJBg7fDz28+FakHtQ=;
        b=YrsIkLOglHtrQTIYrBIxwXvlkvzb6Le1y+MUSArtdtJrYx6+Q/ijqjgeuBmyq12o04
         Cj/n/mLgp1k7ccuCLw3azM1a8IG4/3U9dxakjXohxb7BLsYu26b9d9UevOi3hawpbM2B
         7V7m20s3R6DRkf1fI3SUeHAH7N32C6Uzqtlc8MNzfvTep/tlwTBemLngGZJOcVafanSN
         tUvp64RvEp4BxEK66gKvaUrQLrun0mkZBXWfXvqHBoDYr507lHYgbZB4bkUk4oMyqUNk
         Ig4pO6EGffBKBpIHIZ8kc3JqihYHcCYK4rHe0BNMh9f9bxnIZo88IU6/zrfiCkDA3DLk
         apyg==
X-Gm-Message-State: ABy/qLZ/ucMb9BfgEhaIpEN6SUCYugXCrKV274q8WBCzXA46yvQHS4U9
        AUQTux1MyS3rDDR89XnrA+iV/FlyXwtluCxjVM4Jqg==
X-Google-Smtp-Source: APBJJlEOJDcbZO1BqMBx+teVn9MYOGVnrXIIaero4fqwyVhFN0PsFRgg1ubRdKxdtD/r8fzen1JNp+c7dX79kAngQ+s=
X-Received: by 2002:a05:622a:355:b0:3ef:5f97:258f with SMTP id
 r21-20020a05622a035500b003ef5f97258fmr220718qtw.16.1688647754895; Thu, 06 Jul
 2023 05:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230530150845.2856828-1-smostafa@google.com> <20230704134136.a5znw4jupt5yp5kg@bogus>
 <ZKQqIYRrckLlXqkx@google.com> <20230704143339.cqrvntq7rmmb2on3@bogus>
 <ZKRIWJKn7aVSOvjd@google.com> <20230704192529.d4x2p7ndz2dc4q52@bogus> <ZKWSkB1/5Zlm7mdR@google.com>
In-Reply-To: <ZKWSkB1/5Zlm7mdR@google.com>
From:   Mostafa Saleh <smostafa@google.com>
Date:   Thu, 6 Jul 2023 13:49:04 +0100
Message-ID: <CAFgf54rQmBMgvRWj2yqQ90=12x-Tm1BkHj_-pf+ZBYPmBU_Swg@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: arm64: Use BTI for nvhe
To:     oliver.upton@linux.dev, maz@kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, tabba@google.com, qperret@google.com,
        will@kernel.org, catalin.marinas@arm.com, yuzenghui@huawei.com,
        suzuki.poulose@arm.com, james.morse@arm.com, bgardon@google.com,
        gshan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc and Oliver,

I was double checking that nothing else was missed.

I found there is another problem for hw that has BTI and is affected
by specterv3a.

"br'' instructions are generated at runtime for the vector
table(__bp_harden_hyp_vecs).
These branches would land on vectors in __kvm_hyp_vector at offset 8.

As all the macros are defined with valid_vect/invalid_vect, it is
sufficient to add "bti j"
there at the correct offset.

I am not sure if such hardware exists. I tested this with a stubbed
"has_spectre_v3a" which
confirms the issue and the fix.

Please let me know if this fix suitable, I can include it with the other fi=
x in
"[PATCH] KVM: arm64: Add missing BTI instruction in kvm_host_psci_cpu_entry=
"

diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.=
S
index 8f3f93fa119e..175c030379e3 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -154,6 +154,12 @@ SYM_CODE_END(\label)
  esb
  stp x0, x1, [sp, #-16]!
 662:
+ /*
+ * Specter vectors __bp_harden_hyp_vecs generate br instructions at runtim=
e
+ * that jump at offset 8 at __kvm_hyp_vector.
+ * As hyp .text is guarded section, it needs bti j.
+ */
+ bti j
  b \target

 check_preamble_length 661b, 662b
@@ -165,6 +171,8 @@ check_preamble_length 661b, 662b
  nop
  stp x0, x1, [sp, #-16]!
 662:
+ /* Check valid_vect */
+ bti j
  b \target

 check_preamble_length 661b, 662b

--
Thanks,
Mostafa




On Wed, Jul 5, 2023 at 4:56=E2=80=AFPM Mostafa Saleh <smostafa@google.com> =
wrote:
>
> Hi Sudeep,
>
> On Tue, Jul 04, 2023 at 08:25:29PM +0100, Sudeep Holla wrote:
> > On Tue, Jul 04, 2023 at 04:27:04PM +0000, Mostafa Saleh wrote:
> > > Hi Sudeep,
> > >
> > > On Tue, Jul 04, 2023 at 03:33:39PM +0100, Sudeep Holla wrote:
> > > > Hi Mostafa,
> > > >
> > > > On Tue, Jul 04, 2023 at 02:18:09PM +0000, Mostafa Saleh wrote:
> > > > > Hi Sudeep,
> > > > >
> > > > > On Tue, Jul 04, 2023 at 02:41:36PM +0100, Sudeep Holla wrote:
> > > > > > On Tue, May 30, 2023 at 03:08:45PM +0000, Mostafa Saleh wrote:
> > > > > > > CONFIG_ARM64_BTI_KERNEL compiles the kernel to support ARMv8.=
5-BTI.
> > > > > > > However, the nvhe code doesn't make use of it as it doesn't m=
ap any
> > > > > > > pages with Guarded Page(GP) bit.
> > > > > > >
> > > > > > > kvm pgtable code is modified to map executable pages with GP =
bit
> > > > > > > if BTI is enabled for the kernel.
> > > > > > >
> > > > > > > At hyp init, SCTLR_EL2.BT is set to 1 to match EL1 configurat=
ion
> > > > > > > (SCTLR_EL1.BT1) set in bti_enable().
> > > > > > >
> > > > > > > One difference between kernel and nvhe code, is that the kern=
el maps
> > > > > > > .text with GP while nvhe maps all the executable pages, this =
makes
> > > > > > > nvhe code need to deal with special initialization code comin=
g from
> > > > > > > other executable sections (.idmap.text).
> > > > > > > For this we need to add bti instruction at the beginning of
> > > > > > > __kvm_handle_stub_hvc as it can be called by  __host_hvc thro=
ugh
> > > > > > > branch instruction(br) and unlike SYM_FUNC_START, SYM_CODE_ST=
ART
> > > > > > > doesn=E2=80=99t add bti instruction at the beginning, and it =
can=E2=80=99t be modified
> > > > > > > to add it as it is used with vector tables.
> > > > > > > Another solution which is more intrusive is to convert
> > > > > > > __kvm_handle_stub_hvc to a function and inject =E2=80=9Cbti j=
c=E2=80=9D instead of
> > > > > > > =E2=80=9Cbti c=E2=80=9D in SYM_FUNC_START
> > > > > > >
> > > > > >
> > > > > > I was chasing a bug in linux-next yesterday with protected nVHE=
(pKVM) and
> > > > > > cpuidle enabled. The system fails to boot. I just bisected the =
issue to this
> > > > > > patch and also saw this patch landed in the linus tree yesterda=
y/today.
> > > > >
> > > > > One of the challenges of BTI is that we need to add explicit BTI =
instructions
> > > > > for assembly code. I checked the code to make sure that nothing w=
as missing,
> > > > > but maybe this is not the case.
> > > > > Can you please share more about the issue (is ESR a Branch Target=
 Exception,
> > > > > call stack...) if possible.
> > > >
> > > > I haven't debugged it any further, just reported it as soon as I bi=
sected it.
> > > > Reverting this get back the booting system. I am not sure if anythi=
ng is going
> > > > wrong when the CPU is entering suspend(highly unlikely in normal sc=
enario but
> > > > I am not so sure with pKVM trapping these PSCI calls now) or when i=
t is woken
> > > > up and resuming back. IIUC this now will happen via kvm_hyp_cpu_res=
ume->
> > > > __kvm_hyp_init_cpu->___kvm_hyp_init.
> > >
> > > Thanks a lot for the information.
> > >
> > > I checked this now, and I believe I found an issue. I see that __kvm_=
hyp_init_cpu
> > > calls kvm_host_psci_cpu_entry indirectly and there is no BTI there.
> > > I think this is the only C function that needs special handling.
> > >
> >
> > So it is in the wake up path. Thanks for the description, now I underst=
and
> > the issue and fix better.
> >
> > > Can you please check if this solves the issue?
> > >
> >
> > Yes, the below patch fixed the issue. Feel free to add when you post th=
e
> > formal patch.
> >
> > Reported-and-Tested-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Thanks for testing the patch, I will post it on the list.
>
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe=
/host.S
> > > index c87c63133e10..7df63f364c3c 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/host.S
> > > +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> > > @@ -297,3 +297,8 @@ SYM_CODE_START(__kvm_hyp_host_forward_smc)
> > >
> > >         ret
> > >  SYM_CODE_END(__kvm_hyp_host_forward_smc)
> > > +
> > > +SYM_CODE_START(kvm_host_psci_cpu_entry)
> > > +       bti j
> > > +       b __kvm_host_psci_cpu_entry
> > > +SYM_CODE_END(kvm_host_psci_cpu_entry)
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hy=
p/nvhe/psci-relay.c
> > > index 08508783ec3d..24543d2a3490 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> > > @@ -200,7 +200,7 @@ static int psci_system_suspend(u64 func_id, struc=
t kvm_cpu_context *host_ctxt)
> > >                          __hyp_pa(init_params), 0);
> > >  }
> > >
> > > -asmlinkage void __noreturn kvm_host_psci_cpu_entry(bool is_cpu_on)
> > > +asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
> > >  {
> > >         struct psci_boot_args *boot_args;
> > >         struct kvm_cpu_context *host_ctxt;
> > >
> > >
> > > > > Also, is this with CONFIG_ARM_PSCI_CPUIDLE?
> > > >
> > > > Yes, basically the cpus can enter cpu_suspend which IIUC pKVM traps=
 and
> > > > handle for the host.
> > >
> > > My current setup has no CONFIG_ARM_PSCI_CPUIDLE?, I will try to find
> > > something I can test with.
> > >
> >
> > No worries, I can help until you find one.
> >
> >
> > > > >
> > > > > > Not sure if this is something to do with the fact that pKVM ski=
ps to
> > > > > > __kvm_handle_stub_hvc in __host_hvc.
> > > >
> > > > Sorry, my bad. I meant pKVM skips calling __kvm_handle_stub_hvc in =
__host_hvc
> > > > and jumps to __host_exit directly. Sorry for that, one wrong "to" c=
hanged the
> > > > whole meaning.
> > >
> > > I don't see an issue in this, as this path has no indirect branches.
> > >
> >
> > Understood.
>
> Thanks,
> Mostafa
>
