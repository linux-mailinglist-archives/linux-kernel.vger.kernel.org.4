Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF07659256
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 22:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiL2V74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 16:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiL2V7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 16:59:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ABE1704D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:59:52 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so20113454pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=geW/0jQPxkNteq/5lIrntIbPflDC3Cr4eCT6rvOprts=;
        b=nlRDT+PqfqeaoiD71h+mm713MCtHSrlqzWzMgQrm9hTQ8ozuPVFvVGyWQ9vsEpBpJO
         ntpmcZbq8ZNLjVW9acqnZLYKzUlTru8Yprrpc7FJvpvxM+9C6gEapOE4L2yyo+/k+SSX
         kK+ENwZkxwqt80OzktdyzB/8WL+7iEvvuuRLPgdbeKa0AoeYlGWmLQs2FkX2GBlzgLsz
         nMU0fYq/dKk/lPYN2PuEAzUAUa0QV1JlMydM4muQaMRthbBYdzFGdX4w7BOyrwZV1q+U
         sjC/T+0Mc5dCbIn5o40xhkT6hQujcXHKQ/fHEM5CNWdQOL3w3JWaRbnH4UUDcDrR/x0A
         pr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geW/0jQPxkNteq/5lIrntIbPflDC3Cr4eCT6rvOprts=;
        b=ScQfjI8mxAT2q038yJCz2hAaNGUjHcLcMXhw8AIle4TM934/D/DFepIddHMKbSJoRE
         yQd395IN8ZqBhceSYb/ZWVECmRn3abiZ8TCqQAnKW3x+Lqx+DxGnr0/WgUX7rTf7THZ1
         GJMamLlSKh8uG1nYzEVy6kI1Y3O16YHLCNF8nmQpZ/sJ1pxEvAAzqEWRByiYZdCHie7q
         ViATLNjd/oHBQhvONa1UzTcek5iWv1NLODJzWFqK2DbTkrwHTa4sZTQiu/Zc3pHTTt7k
         YzJLzGLbq1kEjQcYOgraJ/54Pv6FpOeOgC34ZfZvNLUzU7uBwpZxqV+BNR2xbFuTEpau
         xbZA==
X-Gm-Message-State: AFqh2koJ0xnju75rVEmhuWBHnztxFH9v9LhzsmZ/y+cc6Pddz3ABr0eJ
        xkmsuPJ102hV1HWqiIukAU+XPu3yMLqiX79e
X-Google-Smtp-Source: AMrXdXtnjY30+cR4/OCK2GVb8eAeQ38BS/QUexz+z5MOQh6yfw6UK/t3zgbz708AZS3DVyTU8KYx1A==
X-Received: by 2002:a05:6a20:d908:b0:ac:98db:d4cb with SMTP id jd8-20020a056a20d90800b000ac98dbd4cbmr38380545pzb.41.1672351191514;
        Thu, 29 Dec 2022 13:59:51 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id h15-20020a63f90f000000b0048f10379b46sm11103112pgi.68.2022.12.29.13.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 13:59:50 -0800 (PST)
Date:   Thu, 29 Dec 2022 13:59:47 -0800
From:   David Matlack <dmatlack@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 2/9] KVM: x86/mmu: Remove zapped_obsolete_pages from
 struct kvm_arch{}
Message-ID: <Y64N05SXYWf8IG+6@google.com>
References: <20221222023457.1764-1-vipinsh@google.com>
 <20221222023457.1764-3-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222023457.1764-3-vipinsh@google.com>
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

On Wed, Dec 21, 2022 at 06:34:50PM -0800, Vipin Sharma wrote:
> zapped_obsolete_pages list was used in struct kvm_arch{} to provide
> pages for KVM MMU shrinker. This is not needed now as KVM MMU shrinker
> has been repurposed to free shadow page caches and not
> zapped_obsolete_pages.
> 
> Remove zapped_obsolete_pages from struct kvm_arch{} and use local list
> in kvm_zap_obsolete_pages().
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  arch/x86/include/asm/kvm_host.h | 1 -
>  arch/x86/kvm/mmu/mmu.c          | 8 ++++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 89cc809e4a00..f89f02e18080 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1215,7 +1215,6 @@ struct kvm_arch {
>  	u8 mmu_valid_gen;
>  	struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
>  	struct list_head active_mmu_pages;
> -	struct list_head zapped_obsolete_pages;
>  	/*
>  	 * A list of kvm_mmu_page structs that, if zapped, could possibly be
>  	 * replaced by an NX huge page.  A shadow page is on this list if its
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 157417e1cb6e..3364760a1695 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5987,6 +5987,7 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
>  {
>  	struct kvm_mmu_page *sp, *node;
>  	int nr_zapped, batch = 0;
> +	LIST_HEAD(zapped_pages);

optional nit: The common name of this is invalid_list (see other callers
of __kvm_mmu_prepare_zap_page()).
