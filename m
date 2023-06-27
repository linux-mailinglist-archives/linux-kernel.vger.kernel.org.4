Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD2673FF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjF0P1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjF0P1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:27:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C10296E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:27:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bfee5fd909aso5265316276.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687879628; x=1690471628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6NLijTf2/sAC4laqIOL04JiF4+eWg1Jct/Be4UNkg/8=;
        b=h7dLn/JHC61OpxZkFCi0H/sZEf1OZKmomvPgBMpGOtp16lAe+cimobKk7EWvEWW/6H
         wgE+9uoDHs81ikq5WeMQrbgHJpf5d1dMt/wSBjhmqhwt5q9L4IF6Xy3ABlbuhflKV7HD
         TVbYVV/AXse5BC874QxxAuX/40RP0YGWwKpK17JvXSVs7BENTQ4FnOeMtJGW/aAR8XXZ
         7HYbxobmgCjQ5TkMlh+wU9k5fjk7+nRT15EhHD9u8Je8YvpfghDghf4ijIuSjlQto0aq
         3KIPyM6rMrCdW73nbjcJFJvaNMhCKL2wevpOX4SibfGlA0H63y6avDw1V8Y72zogOCCQ
         Wgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687879628; x=1690471628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NLijTf2/sAC4laqIOL04JiF4+eWg1Jct/Be4UNkg/8=;
        b=Jn/xF/y1Zi1uTl6+W8UR3PDZOQ3/FQ3oJsA5uRURfITbLXlojSEr3RIMclKYBBkg/f
         dh8Hxsue3CJDWIkNwHn0uFwVRm6I0f09z91CYgxNbAmmeBFK5yc9n1GSHoyzmGlZLI9g
         iCX2B/bifNHTfIZjL3n7Pg0F2zl2fXDIQNa1Eq5IzrydH+TIcflwFe3Fj2+hg1DrOsql
         ICO+Z4E8jhkqZ0lxSrnuGkd5KsdYgS5opKspwvdIh0kWt9poZufj1s9PVhBtAI+vxOoe
         vjE4Dlx4cAjrdU5RHlVCmecWJJZtdCLtgy5LhJ9oaVU8xkd9E3wVwIPbwDrfB/OLw2vU
         Zc/w==
X-Gm-Message-State: AC+VfDwhDb1bhk/H5Im+pRzCKdT5beZcKy85a/CiJgATCrZgV/HhKYIC
        h6C0uMeI3iHJjfIj7kvVxi0oirhW6hM=
X-Google-Smtp-Source: ACHHUZ6i9hxC0rpjX5e7D79bFHnK4/ftIrY9mY8lDIyIZWpW2pWwCE/PWfmXYEC2brZukFVKZmR1nCyrUnw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6945:0:b0:c1f:6862:d907 with SMTP id
 e66-20020a256945000000b00c1f6862d907mr4104679ybc.10.1687879628566; Tue, 27
 Jun 2023 08:27:08 -0700 (PDT)
Date:   Tue, 27 Jun 2023 08:27:06 -0700
In-Reply-To: <20230626182016.4127366-4-mizhang@google.com>
Mime-Version: 1.0
References: <20230626182016.4127366-1-mizhang@google.com> <20230626182016.4127366-4-mizhang@google.com>
Message-ID: <ZJr/yoWzV7gHMuaG@google.com>
Subject: Re: [PATCH v2 3/6] KVM: Documentation: Add the missing description
 for ptep in kvm_mmu_page
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>, Xu Yilun <yilun.xu@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023, Mingwei Zhang wrote:
> Add the missing description for ptep in kvm_mmu_page description. ptep is
> used when TDP MMU is enabled and it shares the storage with parent_ptes.
> Update the doc to help readers to get up-to-date info.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  Documentation/virt/kvm/x86/mmu.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/x86/mmu.rst b/Documentation/virt/kvm/x86/mmu.rst
> index 4c9044b4dc6c..5cd6cd5e8926 100644
> --- a/Documentation/virt/kvm/x86/mmu.rst
> +++ b/Documentation/virt/kvm/x86/mmu.rst
> @@ -237,6 +237,11 @@ Shadow pages contain the following information:
>      parent_ptes points at this single spte, otherwise, there exists multiple
>      sptes pointing at this page and (parent_ptes & ~0x1) points at a data
>      structure with a list of parent sptes.
> +  ptep:
> +    The reverse mapping for the pte pointing at this page's spt. This field is

I don't think describing "reverse mapping" is necessary, and it's arguably even
misleading.  A "reverse mapping" typically provides a way to find mappings given
a (guest) physical address.  The TDP MMU doesn't bother with reverse mappings
because there is exactly one possible mapping for any given gfn.  The "ptep" exists
specifically to expedite zapping a single TDP MMU shadow page, i.e. allows zapping
without having to traverse the paging tree.

The ptep field is just a pointer at the SPTE, no more no less.  Something like
this?

  ptep:
    The kernel virtual address of the SPTE that points at this shadow page.
    Used exclusively by the TDP MMU, this field is a union with parent_ptes.

> +    used in replace of parent_ptes when TDP MMU is used. In TDP MMU, each
> +    non-root shadow page will have one parent, while each root shadow page has
> +    no parent. Note that this field is a union with parent_ptes.
>    unsync:
>      If true, then the translations in this page may not match the guest's
>      translation.  This is equivalent to the state of the tlb when a pte is
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
