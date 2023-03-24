Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D29D6C860A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjCXTjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXTjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:39:18 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF3314980
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:39:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-541888850d4so28321487b3.21
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679686756;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHFLM9u2tW1dB+QLTD/yCWI9MP1t6zTpNuPsL12SzBA=;
        b=nNBpNB/m+AGT/iTH7cXM98onEB/i7P3sP/z7FMxwTHGwskN7P8XV1ttfg4vWQptqWH
         5N9EhO6KxNBVAe1edIf++87SLur3PhER5vw8NzkVPycF8LhRUOmkBqkqXeu5vJ9yYHHs
         jYfcyuxwZ32Pbb4cllfVulKSwFuPiqI1u1fjC+RHModlzpWCeTJHyFvYWmpZFD8D9JQv
         EL+lJ1SVJdytws5iM2l9bxmDVmuO0fS5F/oQGyL+mKSylZGtXZ/nlQZWiytShaKaBWaw
         fc4lMUYi+Aaf2Lcz2HqCW20/RJXAnw8DFi/nOsVW7qSrKMH0cU+10vtQhGrlw4tWHs59
         Ugng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679686756;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tHFLM9u2tW1dB+QLTD/yCWI9MP1t6zTpNuPsL12SzBA=;
        b=R1sd3S/bPs3oPwB9MZIFwNeV6CQhTOW/8UTyTdDxz3HB/+YlRhjSIiYOPZXi9Y8m41
         9c8GQQ7q/CPnxSEmzAMXCVoeMFyG/YFihKBlIM9+yhg+1VN+RyWlhAgYVZt3Shnb0Kku
         PIOPKcKA7WieRjhx9U1XLh8if1/QrBwu6JwZMnxqQS/AB4K9VNohXCGr8VhCPrAznKWb
         UHTRpVX9ihXScbOQa6qPizKfJlTKfIvQKmscnPfuQH+OsPytzDSnto3KTnVcVyL6Tjwy
         CkH9MGoEh/SqTNwMJxjpgfdOoLFedngLlWEYqF4nt8I1dst/O1RwACKw6fHx2SzcaQZN
         bzig==
X-Gm-Message-State: AAQBX9f/JvJsqWWESS1vOKp8R8SA1MCVawrRuqDE3f16UYP4Gxd34MTd
        MYOhWax/BZzMiFegKWgz/yvk9mMh3+A=
X-Google-Smtp-Source: AKy350a1ioMkSJJqDbkXWX9+7xK8isrZrsY7LWa8ep0ySPAQa5UdgsF9zyuGcR6TXUND6zPo79ynSutd+gY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ad5d:0:b0:544:cd0e:2f80 with SMTP id
 l29-20020a81ad5d000000b00544cd0e2f80mr1576908ywk.8.1679686756669; Fri, 24 Mar
 2023 12:39:16 -0700 (PDT)
Date:   Fri, 24 Mar 2023 12:39:15 -0700
In-Reply-To: <CAL715W+a=og5f-v1o+56wTDmLJr1HitgFzmvL276BuomZvS7YA@mail.gmail.com>
Mime-Version: 1.0
References: <20230113122910.672417-1-jiangshanlai@gmail.com>
 <167934153606.1941128.1026865175616779306.b4-ty@google.com> <CAL715W+a=og5f-v1o+56wTDmLJr1HitgFzmvL276BuomZvS7YA@mail.gmail.com>
Message-ID: <ZB38Y2HpvD+aD9fm@google.com>
Subject: Re: [PATCH] kvm: x86/mmu: Simplify pte_list_{add|remove}
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023, Mingwei Zhang wrote:
> On Thu, Mar 23, 2023 at 3:51=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, 13 Jan 2023 20:29:10 +0800, Lai Jiangshan wrote:
> > > Simplify pte_list_{add|remove} by ensuring all the non-head pte_list_=
desc
> > > to be full and addition/removal actions being performed on the head.
> > >
> > > To make pte_list_add() return a count as before, @tail_count is also
> > > added to the struct pte_list_desc.
> > >
> > > No visible performace is changed in tests.  But pte_list_add() is no =
longer
> > > shown in the perf result for the COWed pages even the guest forks mil=
lions
> > > of tasks.
> > >
> > > [...]
> >
> > Applied to kvm-x86 mmu, thanks!  I added quite a few comments and a BUG=
_ON() to
> > sanity check that the head is never empty when trying to remove an entr=
y, but I
> > didn't make anything changes to the code itself.
> >
> > [1/1] kvm: x86/mmu: Simplify pte_list_{add|remove}
> >       https://github.com/kvm-x86/linux/commit/141705b78381
> >
>=20
> I am not sure if it is possible, but now spte_count is u32 so does
> tail_count. I wonder if an attacker could use the potential integer
> overflow to trigger this? E.g,: creating a huge number of little L1
> EPTs with the many nGPA-> one GPA? hmm, I think it could overflow
> tail_count? Please double check.

Heh, I had the same reaction and even started reworking the patch, but conv=
inced
myself that there are no new issues as __rmap_add() artificially limits the=
 number
of rmap entries to 1000.  But looking again, mmu_page_add_parent_pte() does=
n't
have the same safeguard, so in theory, a VM could overflow tail_count.

I'll stare at this some more next week, I'd really prefer to avoid taking o=
n any
amount of complexity in KVM to handle something that should never occur in
practice.  But being buried deep in __link_shadow_page() makes the error ha=
ndling
annoying.

> spte_count is u32, but assigned to an (signed) int j and BUG_ON(j <
> 0)? Please don't add more BUG_ON in KVM mmu... and please change
> either 'spte_count' to 'int' or 'j' to u32.

Why?  signed vs. unsigned doesn't change anything.  spte_count is can't be =
greater
than PTE_LIST_EXT, so overflow is not a concern.  The BUG_ON() is purely to=
 ensure
there's no underflow, i.e. that spte_count > 0, so that the array can be sa=
fely
accessed.

> In general, please, no BUG_ON(), at least no more BUG_ON() on our nested =
MMU...

In this case, the alternative is worse, as writing "head_desc->sptes[j]" wi=
th
"j < 0", i.e. a very large value if j is stored as an unsigned, would write
arbitrary kernel memory.

I completely agree that the BUG_ON() is gross, but that's an existing issue=
 that
needs to be remedied.  And to do that, I really want to resurrect and utili=
ze
the KVM_BUG_ON_DATA_CORRUPTION() idea[*].

[*] https://lore.kernel.org/all/Y5dax8XJV0F5adUw@google.com
