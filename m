Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4515E5F3A49
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiJDACm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJDACk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:02:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C43AE43
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:02:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so16786350pjs.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cKEaTPB4TstuN0N6KGC5ZTChdAnFmWfuJQUnW1F7Pr0=;
        b=XS12QK49zso7r1llsnn6fXyyTXphyYv5Dp8xvSMDQhrJyOfkt75lWqVbYyFvzw19Oa
         tU+i4K3jdF6PbAMXgMEVnEreFLPZK8TxwhNgmMaL9r3PrlkOPV7equ4M8bPekRW3UmNu
         DbqxKWlc5X5NjULybGRbJFifGmx/NwBtfzRzsPh7e9Us4RAHExhGw9pM1gHevlaEXP3Y
         fXVfZA560vf014w0SYLVKE+W2sAVTpiFtxm5SK7hlBK4//BwP2zEEveq+AcGpn5a+rzs
         FgDSnhCngq3S5qy6J8QYf+B387aoPoIHuxJbKBxG4/zXhvB6pgXAHlFDueslzb2vax+y
         xsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cKEaTPB4TstuN0N6KGC5ZTChdAnFmWfuJQUnW1F7Pr0=;
        b=pz+AFdJKvW0nsaGj96aTk+vgwpdLTPk0lpZ21FkgiZja8wuJsepn+QLFsbEt1+aiTr
         LBDK2ETvsQl3akkDR8glug8LoZC1MIJUz1Cs5fHNypQ8nHCx78YgkUW/x0jKFE53iPtp
         pivzz/WK3nPvWTVTbNrCewPjS9cOrm8zbrarxNn+bLO++E95jKMsme/58X+LsVQDi9TN
         LARlwR6uu85SKX4hfXqcOvr0uVm2OsP6Kae5BjTWymMtsYJYxdQ1wwpHk57Gl6CJHEjh
         LKsQAgkuIN0iM+fnoSSePSDrybijlXEoO+yGqV9v4Ur9uylGfLRx0kSFgJf4IFPaTyQg
         W6ww==
X-Gm-Message-State: ACrzQf1qPU8M3sY0bGC3R8VclRacwhcLutjYxRbQ/his1eSchHoY/1Di
        RCVbMB6Z4bweduRpRbHQ9Ph30cVTWvbmhgPBpTondQ==
X-Google-Smtp-Source: AMsMyM47Xx9aPljKNicraDhTtewm9C86wmw9och3xikp1rK+wnuurke3HKVwwW0Wk3qQbYfJ/vISYrlZnhTmB4fpxXw=
X-Received: by 2002:a17:90a:a503:b0:20a:d877:638 with SMTP id
 a3-20020a17090aa50300b0020ad8770638mr326473pjq.176.1664841758343; Mon, 03 Oct
 2022 17:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-4-vannapurve@google.com> <Yyt586xOWrNEoCYF@google.com>
 <CAGtprH8=wjQAhpr97KNsziT_jAqSS6sMTb5=gzgbhssNPm8q_Q@mail.gmail.com> <YzsC4ibDqGh5qaP9@google.com>
In-Reply-To: <YzsC4ibDqGh5qaP9@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Mon, 3 Oct 2022 17:02:27 -0700
Message-ID: <CAGtprH-YuA=b-oJDZnvZ5u1EfNPuwUvrbYE0fU2L2KHzu5Af_g@mail.gmail.com>
Subject: Re: [V2 PATCH 3/8] KVM: selftests: Add arch specific post vm load setup
To:     Sean Christopherson <seanjc@google.com>
Cc:     David Matlack <dmatlack@google.com>, x86 <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Mon, Oct 3, 2022 at 8:42 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Sep 26, 2022, Vishal Annapurve wrote:
> > On Wed, Sep 21, 2022 at 1:54 PM David Matlack <dmatlack@google.com> wrote:
> > >
> > > On Thu, Sep 15, 2022 at 12:04:43AM +0000, Vishal Annapurve wrote:
> > > > diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > > > index 98edbbda9f97..73cfee3ebd76 100644
> > > > --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> > > > +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > > > @@ -839,4 +839,8 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
> > > >   */
> > > >  void kvm_selftest_arch_init(void);
> > > >
> > > > +/*
> > > > + * API to execute architecture specific setup after loading the vm elf.
> > >
> > > It's not a "vm elf" per-se, it's "loading the elf into the VM". How
> > > about:
> > >
> > > /*
> > >  * API to execute arch-specific logic after loading the selftest ELF image
> > >  * into the VM.
> > >  */
> > >
> >
> > Ack. Will update this in the next series.
>
> Even better, call it from __vm_create() and name it something like
> kvm_arch_vm_post_create().  Like David said, while the hook has a dependency on
> being called after loading the ELF image, the action that arch code is expected
> to take doesn't have anything to do with loading the ELF image.
>
> And then instead of introducing an arch hook with no implementation, the patch that
> adds the hook can instead use it to replace the x86-64 #ifdef in __vm_create().
>

Today upstream kernel selftests don't have scenarios where
kvm_vm_elf_load can get called directly outside ___vm_create but there
are selftests that are up for review [1], [2] that may call
kvm_vm_elf_load directly. Above suggestion will not work in this
scenario, is it suitable to assume that all the callers of
kvm_vm_elf_load will eventually execute kvm_arch_vm_post_create?

[1] https://lore.kernel.org/lkml/20220810152033.946942-12-pgonda@google.com/
[2] https://lore.kernel.org/lkml/20220819174659.2427983-1-vannapurve@google.com/T/#u

> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index dafe4471a6c7..593dfadb662e 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -298,9 +298,8 @@ struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
>
>         kvm_vm_elf_load(vm, program_invocation_name);
>
> -#ifdef __x86_64__
> -       vm_create_irqchip(vm);
> -#endif
> +       kvm_arch_vm_post_create(vm);
> +
>         return vm;
>  }
>
>
