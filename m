Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD569F945
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjBVQqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjBVQqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:46:45 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FEF3B67C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:46:44 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p14-20020a170902e74e00b0019ad833d8a4so3924151plf.15
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+QiiW3N8MUbaTaxsJfApLiTX1buSoqhASLC/z4dapy4=;
        b=GobH1TaO+hYYJacM6Zcvpe66sOC21cqykazSq1J2VfB2XNkfb8K4cNmC52EfF6Z37B
         X/l+vH0NKlIokAokN2fXuTFzzWhDTEKr7tMXYW3pa7hSQOmKfbAhJNUbcB2jjoTwXzp6
         0xLALS7YWBhjLRhxGN4q//qHxIsoxv4DfkbQc6QMnX6XvoK5g6T6DBxuZsOV8PFm2iPc
         72xnsXo1pe9eLjdfopbVKdv14jkZ/WOabj8F6bRV4Csjv/BYNrLVkA1roRJyk5zG84+N
         ni3li+3bYraWKXhBBMTFlSagZ5sGcL5sbjpijXsSNxvXzWJ3TUKJ4RmM6O0s/QOPiI1q
         lFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QiiW3N8MUbaTaxsJfApLiTX1buSoqhASLC/z4dapy4=;
        b=Rq5vIsaP+aMvrXV/BwdJ2TCJlrmuRzqWY60atI7ro7hHT2dE7eNjGNvNrZ7+p5VNkp
         qNUX/RUVKr7Kxxt8hQ/Frrm86cMWSLbxdujWpNdrVWuBjjhhTWdyK8kZa3N8Iq9EHHMc
         f8+f2q0BtnNVm6jqsNqqU5iuHtxi7jG2kt7CSQfkpsURrv6hqgSw4PPU0ogok4UR2/yp
         jFdktXhLakpZ8JaO7jOdkiHgbHKKJRKco6BJvoQHjpuXmb24m122nGJ47L/clmDIzuzG
         YM+R3su2/eQFDqtWtdXD+QSOaMVD/3gvOJBjix4lPkQy1EURJFL0O90Y0zUukb3Nx2n2
         mT2Q==
X-Gm-Message-State: AO0yUKVcHATTblg7S1i9CIfqAPa/vShTuXBFpMgGJzFhIOMQ5dGiQefe
        bTSxVO4E9867IlkcKYSuy4wYcDfywV0=
X-Google-Smtp-Source: AK7set9R2NDRkVHaXW1B/ByU6rTiQWFnudxLqy4CssEn+ehoejPBUN4E1Wtt4AllhbB1WTLfsFep+7k793Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:7556:0:b0:4fb:9902:fc4a with SMTP id
 f22-20020a637556000000b004fb9902fc4amr1146164pgn.10.1677084403857; Wed, 22
 Feb 2023 08:46:43 -0800 (PST)
Date:   Wed, 22 Feb 2023 08:46:42 -0800
In-Reply-To: <20230222162511.7964-1-rdunlap@infradead.org>
Mime-Version: 1.0
References: <20230222162511.7964-1-rdunlap@infradead.org>
Message-ID: <Y/ZG8u6/aUtpsVDa@google.com>
Subject: Re: [PATCH v2] KVM: SVM: hyper-v: placate modpost section mismatch error
From:   Sean Christopherson <seanjc@google.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023, Randy Dunlap wrote:
> modpost reports section mismatch errors/warnings:
> WARNING: modpost: vmlinux.o: section mismatch in reference: svm_hv_hardware_setup (section: .text) -> (unknown) (section: .init.data)
> WARNING: modpost: vmlinux.o: section mismatch in reference: svm_hv_hardware_setup (section: .text) -> (unknown) (section: .init.data)
> WARNING: modpost: vmlinux.o: section mismatch in reference: svm_hv_hardware_setup (section: .text) -> (unknown) (section: .init.data)
> 
> Marking svm_hv_hardware_setup() as __init fixes the warnings.
> 
> I don't know why this should be needed -- it seems like a compiler
> problem to me since the calling function is marked as __init.

It's not a compiler issue.  __initdata is freed after init and so must not be
accessed by __init-less functions.

This as a changelog?

  Tag svm_hv_hardware_setup() with __init to fix a modpost warning as the
  non-stub implementation accesses __initdata (svm_x86_ops), i.e. would
  generate a use-after-free if svm_hv_hardware_setup() were actually invoked
  post-init.  The helper is only called from svm_hardware_setup(), which is
  also __init, i.e. other than the modpost warning, lack of __init is benign.

With that (in case Paolo grabs this directly):

Reviewed-by: Sean Christopherson <seanjc@google.com>
  
> This "(unknown) (section: .init.data)" all refer to svm_x86_ops.
> 
> Fixes: 1e0c7d40758b ("KVM: SVM: hyper-v: Remote TLB flush for SVM")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vineeth Pillai <viremana@linux.microsoft.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: kvm@vger.kernel.org
> ---
> v2: also make the empty stub function be __init (Vitaly)
> 
>  arch/x86/kvm/svm/svm_onhyperv.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -- a/arch/x86/kvm/svm/svm_onhyperv.h b/arch/x86/kvm/svm/svm_onhyperv.h
> --- a/arch/x86/kvm/svm/svm_onhyperv.h
> +++ b/arch/x86/kvm/svm/svm_onhyperv.h
> @@ -30,7 +30,7 @@ static inline void svm_hv_init_vmcb(stru
>  		hve->hv_enlightenments_control.msr_bitmap = 1;
>  }
>  
> -static inline void svm_hv_hardware_setup(void)
> +static inline __init void svm_hv_hardware_setup(void)
>  {
>  	if (npt_enabled &&
>  	    ms_hyperv.nested_features & HV_X64_NESTED_ENLIGHTENED_TLB) {
> @@ -84,7 +84,7 @@ static inline void svm_hv_init_vmcb(stru
>  {
>  }
>  
> -static inline void svm_hv_hardware_setup(void)
> +static inline __init void svm_hv_hardware_setup(void)
>  {
>  }
>  
> 
