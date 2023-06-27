Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF70B740093
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjF0QNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjF0QNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:13:41 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B242946
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:13:39 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-548a11fc6d4so4009063a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687882419; x=1690474419;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ceVZorHhmYStREG2UsD951+Eh4dhlIfP0OrW78yohw=;
        b=4lFNYSd0wQ9ZN1yx7jpWiqFxIK0++uV1Md5r6JH0p5z7t4MeOk8i4qBP/n6MF/30WO
         ZEcWeJC5prd3YhEwiSlmG8+dOvudagvZwNNT1xizrq2H+1R4GMdOuERa26uGTQzlFHFu
         +KwqFisdTlZLmWIwqHXvzoiABPTpp5AIXNDZuYXEXlSwWMuFdFsr8/kG7yv3ufS+2BDQ
         Eh+C9vkbTCId5PBuHS/xEiDaRBZxKVh9cor/NvXYxtlQzds50rgq+tXyDkT9P97icmDe
         7u3hvjk9onthBfHbwJOhfm7y0JnhIP5GQ7TsK5uIrq9VoyNy8pGL7kxNc5RHtSprHHWj
         tJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687882419; x=1690474419;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ceVZorHhmYStREG2UsD951+Eh4dhlIfP0OrW78yohw=;
        b=eANlq9Sqo07PVcBmkUt6A81ZQxZfFrCNKQbKHn4toqPkRR0LaXEhvOW+JgxRm5TcRu
         FmBXzObHA+W6tUgcj6qaqpuakwQOPEf9i2hDGv9PX1TSH0pnu2mbWz0zUX2VL354JDzu
         r/vj13oyWUQEYVON1Mn9noATEkTwELspO0gVg5q9S091M3e0P92lWtIBepeUEH6r34U5
         EnAfmsd2WollYzTqCWf4OiXRE1BTIfXde7F+nVEPXrF0e864AgkFhFAF042/IMVqHVX5
         pvncLR0BVgIF2SrSPBmYRAZ2xFRHJ6Be1jk4qFpNNrg9NC7S4diwyiJL3lu5bwmHCT4C
         L8YQ==
X-Gm-Message-State: AC+VfDzNtOc5xduE9Y7aHC19z8UpDq3TRNANjTGBDgDG7Ze2PJRSX77N
        nC+AEaJNinYBNOr2dBMLDpCWwVXZchE=
X-Google-Smtp-Source: ACHHUZ5CnJbD18M1xNH6YOt86isMjDWxYGr0JW41cHxXT0fctiGXMGG8zapfRj56+bA/U18QBGZM2CDZ/Sw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c113:b0:1b8:d44:32aa with SMTP id
 19-20020a170902c11300b001b80d4432aamr805971pli.1.1687882418955; Tue, 27 Jun
 2023 09:13:38 -0700 (PDT)
Date:   Tue, 27 Jun 2023 09:13:37 -0700
In-Reply-To: <20230626182016.4127366-6-mizhang@google.com>
Mime-Version: 1.0
References: <20230626182016.4127366-1-mizhang@google.com> <20230626182016.4127366-6-mizhang@google.com>
Message-ID: <ZJsKsQNWVq4zNmGk@google.com>
Subject: Re: [PATCH v2 5/6] KVM: Documentation: Add the missing description
 for mmu_valid_gen into kvm_mmu_page
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023, Mingwei Zhang wrote:
> Add the description for mmu_valid_gen into kvm_mmu_page description.
> mmu_valid_gen is used in shadow MMU for fast zapping. Update the doc to
> reflect that.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> ---
>  Documentation/virt/kvm/x86/mmu.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/x86/mmu.rst b/Documentation/virt/kvm/x86/mmu.rst
> index 97d695207e11..cc4bd190c93d 100644
> --- a/Documentation/virt/kvm/x86/mmu.rst
> +++ b/Documentation/virt/kvm/x86/mmu.rst
> @@ -208,6 +208,10 @@ Shadow pages contain the following information:
>      The page is not backed by a guest page table, but its first entry
>      points to one.  This is set if NPT uses 5-level page tables (host
>      CR4.LA57=1) and is shadowing L1's 4-level NPT (L1 CR4.LA57=1).
> +  mmu_valid_gen:
> +    Used by comparing against kvm->arch.mmu_valid_gen to check whether the

This needs to explain what the generation is, and where it comes from.

  The MMU generation of this page, used to effect a "fast" zap of all MMU pages
  across all roots.  To zap all pages in all roots without blocking vCPUs, e.g.
  when deleting a memslot, KVM updates the per-VM valid MMU generation to mark
  all existing pages and roots invalid/obsolete.  Obsolete pages can't be used,
  e.g. vCPUs must load a new, valid root before re-entering the guest.

  The MMU generation is only ever '0' or '1', as slots_lock must be held until
  all obsolete pages are zapped and freed, i.e. there is exactly one valid
  generation and (at most) one invalid generation.

  Note, the TDP MMU doesn't use mmu_gen as non-root TDP MMU pages are reachable
  only from their owning root, whereas all pages for shadow MMUs are reachable
  via the hash map.  The TDP MMU uses role.invalid to track obsolete roots.

And then big bonus points if you add

  Page Role
  =========

to explain the purpose of the role, and how/when it's used in the shadow MMU versus
the TDP MMU.  The shadow MMU's use of a hash map is a fundemental aspect that really
should be documented here.

> +    shadow page is obsolete thus a convenient variable for fast zapping.
> +    Note that TDP MMU does not use mmu_valid_gen.
>    gfn:
>      Either the guest page table containing the translations shadowed by this
>      page, or the base page frame for linear translations.  See role.direct.
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
