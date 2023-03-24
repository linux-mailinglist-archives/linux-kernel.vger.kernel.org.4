Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34E46C806C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjCXOyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjCXOye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:54:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F50655BF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:54:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p12-20020a25420c000000b00b6eb3c67574so1994614yba.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679669671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1tdduUjnbl5Irm88tn5dVUB6CbalAoO8z08+lwGIaDg=;
        b=CEflalfNT5WbsGFeoH8gg6VEAAadHtcYs8WYSCXURFrBKwsheHe3zB2potVnwjx43e
         +fALJ2qsZIsVKKeXkp2EVUfB/baquLYOM4oOUPIviLywV4O+0rKe5pTgBr2Yu889FgUs
         bM4afylwOdYAIZ1GK04FPsAn6bAQmz8uQ0tK+JHIw+o+JWyBmyauBi20mi+UARrCK9iY
         ZAKcROIHdF8Nyq3ezfHfcLHR5ZU8WY3tKjixpo4D+nCDVibvCYWYRV5lBcd5paaNr0h8
         vRB9kmq26m+maOHFCERXbZXPlfjyxBPwwVHXM9NNeMY9vpcHwpX22RkBEXUgW7L7I967
         CQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679669671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tdduUjnbl5Irm88tn5dVUB6CbalAoO8z08+lwGIaDg=;
        b=v6+7BFpJD/bq/IJX7oy2lG+uA72dE2hzlbM7Na1pqIGNAP3ew5npGK7OzhR6cAoYmH
         MV6nlU9a3meoU0mXwoD3NhYAyTz0mHI791SBR9CiP7qmr1K05Gnlpsw0Ws5CZL7IeanM
         EcSClLFtOVxlftCICjv7Kw5N+NrSSdnNni2JzxgtteSqOblZ//F1L9Fbf55LKr+OIL3H
         z+EahaUg4eNdq3fGcZR5EtStLw1+XK7GQq6siVrOKLHoLZbprZUsx8qeGAq0neBY/ufR
         V3Uk1KQAyiMyalHmwzzU+rHgeEgTnUNXn6Dwp3GwbUJ6N9FCLwYXrPaudREUu0QK1J05
         HXzA==
X-Gm-Message-State: AAQBX9f7AMo8OpZyio3EzX8Xb20D/nNX0SOI4oWT4REi76BMWlqbQNR7
        D/zoH4nXAFfmw1HTLxDDlbzi1bHv8hs=
X-Google-Smtp-Source: AKy350aJfEGvkZPhmfJLRXnNK4rQPK8XcItoEz+NEjg78U9SdF52B0KpfQ0EEBavmZctl90sz8X/nsCpexY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1586:b0:b69:fab9:de39 with SMTP id
 k6-20020a056902158600b00b69fab9de39mr1289438ybu.2.1679669671419; Fri, 24 Mar
 2023 07:54:31 -0700 (PDT)
Date:   Fri, 24 Mar 2023 07:54:29 -0700
In-Reply-To: <20230223052851.1054799-1-jun.miao@intel.com>
Mime-Version: 1.0
References: <20230223052851.1054799-1-jun.miao@intel.com>
Message-ID: <ZB25pR7cv3mjnn4s@google.com>
Subject: Re: [PATCH v2] KVM: Fix comments that refer to the non-existent install_new_memslots()
From:   Sean Christopherson <seanjc@google.com>
To:     Jun Miao <jun.miao@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023, Jun Miao wrote:
> The function of install_new_memslots() was replaced by kvm_swap_active_memslots().
> In order to avoid confusion, fix the comments that refer the non-existent name of
> install_new_memslots which always be ignored.
> 
> Fixes: a54d806688fe ("KVM: Keep memslots in tree-based structures instead of array-based ones")
> Signed-off-by: Jun Miao <jun.miao@intel.com>

Two nits, but I'll fix them up when applying.  Thanks!

> ---
>  Documentation/virt/kvm/locking.rst |  2 +-
>  include/linux/kvm_host.h           |  4 ++--
>  virt/kvm/kvm_main.c                | 10 +++++-----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
> index 14c4e9fa501d..6e03ad853c27 100644
> --- a/Documentation/virt/kvm/locking.rst
> +++ b/Documentation/virt/kvm/locking.rst
> @@ -21,7 +21,7 @@ The acquisition orders for mutexes are as follows:
>  - kvm->mn_active_invalidate_count ensures that pairs of
>    invalidate_range_start() and invalidate_range_end() callbacks
>    use the same memslots array.  kvm->slots_lock and kvm->slots_arch_lock
> -  are taken on the waiting side in install_new_memslots, so MMU notifiers
> +  are taken on the waiting side in kvm_swap_active_memslots(), so MMU notifiers

This isn't accurate, kvm_swap_active_memslots() isn't what actually acquires
those locks.  I don't see any reason to be super precise, the key takeaway is
that modifying memslots takes the locks _and_ is the waiter.  I'll tweak this to:

  are taken on the waiting side when modifying memslots, so MMU notifiers

> @@ -1810,11 +1810,11 @@ static int kvm_set_memslot(struct kvm *kvm,
>  	int r;
>  
>  	/*
> -	 * Released in kvm_swap_active_memslots.
> +	 * Released in kvm_swap_active_memslots().
>  	 *
>  	 * Must be held from before the current memslots are copied until
>  	 * after the new memslots are installed with rcu_assign_pointer,
> -	 * then released before the synchronize srcu in kvm_swap_active_memslots.
> +	 * then released before the synchronize srcu in kvm_swap_active_memslots().

This block can be massaged slightly to avoid running past 80 chars:

	 * Must be held from before the current memslots are copied until after
	 * the new memslots are installed with rcu_assign_pointer, then
	 * released before the synchronize srcu in kvm_swap_active_memslots().

>  	 *
>  	 * When modifying memslots outside of the slots_lock, must be held
>  	 * before reading the pointer to the current memslots until after all
> -- 
> 2.32.0
> 
