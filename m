Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659795FD87B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJMLhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJMLhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:37:02 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9C6501B8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:37:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so1636358pjl.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cqDPnIa3E4nT6SdR1MGixuJIFTI1i+Jop05/0C73LOE=;
        b=jw8ieudDOujw3+GuCeszx67fYxZWWskmFY6JFLdXjZXwqkF0+jdczth67T/2M6Ichp
         ZFBzLQmoWwVpwpQS+TVUNhsZttKB/Iz0n5L0osuBrnCv0fNe8Ll4DSK2aAQ3AuIvZoRI
         a59ykrjG7WO1/7kZM3fFC3bkNNp9UCHI1YCBqoP5acHWWdaIpT3GefLGT1J9LE/a1JBd
         k3tGVg/83TrcGAHlqs+jRO/x7fcjYnaOXTqJ2lgoKxikFJQK5TT7BE03xkMELG7rAPzI
         +/FNP76+ELUHYnrLxWPh/p/scwE0qyHKead7bsD1gBqVbhToO1g4EUe18H7eRpQPhtuU
         zMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqDPnIa3E4nT6SdR1MGixuJIFTI1i+Jop05/0C73LOE=;
        b=xmuMqXf9xoUYMvlBO1x2Dx3DKMKg8DtFHnoLL8LZ6j0/WsmA9tPidNUgYVzd/qP0hJ
         VfR9zlpk8Hh4bd7LTqknrmlAUfX2QgQoaPPSOJJBT517OxARAZ8LTq6dxm/vYXWM2+TF
         kW5ddlyuhyTf+FrVvcLMa9tMFwwIFmV2pJ+3RPnQK4y/ekV6HbMikPGKFCn+D09Fhj8V
         qdqV8XhRYkQfqTzSrvBBbYxmzYilUDqDtQ6GCcxJOv33Qpc5nigG1YIBZ6KKN5c4/+1y
         rfGdE2uWbNFi4DGrGLxdoXme0hKq5Lda+k+dSH7FpzoBnTgCJTDTMu+TtKhpixy6jMEu
         w32Q==
X-Gm-Message-State: ACrzQf1wIKHpaNrViuw9tYhSFRycxpp2+Ao58aumlrfvCSrMwW80qDw1
        fXLuMFkZNpQA1AKfJbvHchszzBxTDaz3CTVvOta3Bd6/iq0=
X-Google-Smtp-Source: AMsMyM4LEIGPtreKXLHPGxp3Me6WkdoZ939ESaLO0ESZc+omMKXdsQzFpOo9bbXBEqdbVYaYKSPDIRRMoEXqUciOosI=
X-Received: by 2002:a17:90a:a503:b0:20a:d877:638 with SMTP id
 a3-20020a17090aa50300b0020ad8770638mr10550334pjq.176.1665661020041; Thu, 13
 Oct 2022 04:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-4-vannapurve@google.com> <Yyt586xOWrNEoCYF@google.com>
 <CAGtprH8=wjQAhpr97KNsziT_jAqSS6sMTb5=gzgbhssNPm8q_Q@mail.gmail.com>
 <YzsC4ibDqGh5qaP9@google.com> <CAGtprH-YuA=b-oJDZnvZ5u1EfNPuwUvrbYE0fU2L2KHzu5Af_g@mail.gmail.com>
 <YzyTPXbuMot2Y0vf@google.com>
In-Reply-To: <YzyTPXbuMot2Y0vf@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Thu, 13 Oct 2022 17:06:48 +0530
Message-ID: <CAGtprH90KZ6WREannJs2KtKFNn6LW_4hzcngQLFLe74gXKKang@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 1:40 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Oct 03, 2022, Vishal Annapurve wrote:
> > On Mon, Oct 3, 2022 at 8:42 AM Sean Christopherson <seanjc@google.com> wrote:
> > > Even better, call it from __vm_create() and name it something like
> > > kvm_arch_vm_post_create().  Like David said, while the hook has a dependency on
> > > being called after loading the ELF image, the action that arch code is expected
> > > to take doesn't have anything to do with loading the ELF image.
> > >
> > > And then instead of introducing an arch hook with no implementation, the patch that
> > > adds the hook can instead use it to replace the x86-64 #ifdef in __vm_create().
> > >
> >
> > Today upstream kernel selftests don't have scenarios where
> > kvm_vm_elf_load can get called directly outside ___vm_create but there
> > are selftests that are up for review [1], [2] that may call
> > kvm_vm_elf_load directly. Above suggestion will not work in this
> > scenario, is it suitable to assume that all the callers of
> > kvm_vm_elf_load will eventually execute kvm_arch_vm_post_create?
>
> No, but that's irrelevant.  And actually, in any reasonable hypothetical situation
> I can think of, it's actually undesirable to always call kvm_arch_vm_post_create()
> after kvm_vm_elf_load().
>
> Hypothetically, if there were a use case where kvm_vm_elf_load() is called multiple
> times, then stuffing the "Intel vs. "AMD" flag should only be done for the binary
> that actually defines that flag.  The flag is defined by the library's processor.c,
> and so the hook should be tied to the library's loading of its binary, i.e. to the
> creation of the VM.
>
> If a test were loading multiple binaries, and the test wanted to tweak things
> specific to a binary after loading said binary, then the test can and should do
> that without needed a library arch hook.
>
> If the arch hook was to take action specific to loading _any_ binary, than yes, a
> hook in kvm_vm_elf_load() would be in order, but this hook is about taking action
> when creating a VM, not to loading a binary.
>
> But this is all very, very hypothetical.  I can't think of a scenario where
> loading multiple binaries would be less complex than solving whatever hypothetical
> problem makes it difficult to link everything into a single binary.
>
> And if a test manually loads a binary _and_ wants to actually run the guest after
> doing vm_create_barebones() or ____vm_create(), then the test is doing it wrong,
> as those low level APIs are provided _only_ for cases where a test doesn't need
> to run vCPUs.

Ack, will update this patch as per the feedback here.
