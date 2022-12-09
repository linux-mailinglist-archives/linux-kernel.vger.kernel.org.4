Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DB4648AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 23:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiLIWWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 17:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIWWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 17:22:44 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D429212D0B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 14:22:42 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so9605256pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 14:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ReHKPYHQZTteLwT0As2JQVVBmkWDUyL/DLK/qSWjsM0=;
        b=NL0NAV0RdzuWBOp2ztZtcwpxd0baUkzJPflsSIUOYyOJkDtDNQw7zaldPmUIqfROgG
         eqjdZ61AFx+xo4O1hoZGcm9VBA5buBbjkDYHw0gfVD9ImWiW5y6JE8LYfwUhobHia7pF
         3FgMiIeLemdaXd9YSjsmWT+hdsdDWNhUh68NHnXGGq3j0zzNCvNRMmtC1265TxMIo0BY
         R/ICPspwjQszq6cZAkmmnE6QJtOuG+bkJH8B8TAPNRtU3DjktIFydHTdtDZZ7VwQvgjW
         FR+BRD7LBKzXIN3yNsqbc4ObOnyRObK314QuOr5U/sIxypKLAgijROJ+sC6/dNZn2oVx
         QwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReHKPYHQZTteLwT0As2JQVVBmkWDUyL/DLK/qSWjsM0=;
        b=TEDZHKF/YEmjtRl9HSr+63n9wmGCIgFCcpXQ0XO68EHSnkLS1sizGD187u3zz1Ogiq
         GW88r4qtmPweJvOsE4AoPj1lMyoIJV9EigFqPC6TKybze2DYCwtT2PMuFluruJ80y3Nx
         M63lFlx2rDVtXu62CsrshTsroghMoyCv/pAUEYb9ON64pmi43AmvhHw/IBInxdCFs8cm
         CGqEY0UhSG0/UK7AZRKB70413muWLTVddlOjBN+K4eIoT2wQAFfjRJWj2iouqRsV1L3a
         5EXakWpsAwxkWGqKf6E1lmDdHcJajuRSTyep/j8LcdoEKFvV59oPqTKpMrwI/WGUiX3k
         M8kA==
X-Gm-Message-State: ANoB5pk6Or5BXLbaK7eib7HCKLlQiSDFddJnKH82/GBarpgqQ28OVzLt
        hXikRs4gm3p0mSJUS2JjUp5oGA==
X-Google-Smtp-Source: AA0mqf6aScZwgCPYfMRSa5E8XNfnCmiGLZwxfPrkfh+4XDjSInpYt0kGjwi4Vh98kjkFu/B0H6f59Q==
X-Received: by 2002:a17:902:b087:b0:189:e81b:d25f with SMTP id p7-20020a170902b08700b00189e81bd25fmr7356933plr.56.1670624562233;
        Fri, 09 Dec 2022 14:22:42 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902d0d400b00189348ab156sm1754985pln.283.2022.12.09.14.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 14:22:41 -0800 (PST)
Date:   Fri, 9 Dec 2022 14:22:37 -0800
From:   David Matlack <dmatlack@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH 1/7] KVM: x86/MMU: Move pte_list operations to rmap.c
Message-ID: <Y5O1LbbeI7XXeaT2@google.com>
References: <20221206173601.549281-1-bgardon@google.com>
 <20221206173601.549281-2-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206173601.549281-2-bgardon@google.com>
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

On Tue, Dec 06, 2022 at 05:35:55PM +0000, Ben Gardon wrote:
> In the interest of eventually splitting the Shadow MMU out of mmu.c,
> start by moving some of the operations for manipulating pte_lists out of
> mmu.c and into a new pair of files: rmap.c and rmap.h.
> 
> No functional change intended.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
[...]
> diff --git a/arch/x86/kvm/mmu/rmap.h b/arch/x86/kvm/mmu/rmap.h
> new file mode 100644
> index 000000000000..059765b6e066
> --- /dev/null
> +++ b/arch/x86/kvm/mmu/rmap.h
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef __KVM_X86_MMU_RMAP_H
> +#define __KVM_X86_MMU_RMAP_H
> +
> +#include <linux/kvm_host.h>
> +
> +/* make pte_list_desc fit well in cache lines */
> +#define PTE_LIST_EXT 14
> +
> +/*
> + * Slight optimization of cacheline layout, by putting `more' and `spte_count'
> + * at the start; then accessing it will only use one single cacheline for
> + * either full (entries==PTE_LIST_EXT) case or entries<=6.
> + */
> +struct pte_list_desc {
> +	struct pte_list_desc *more;
> +	/*
> +	 * Stores number of entries stored in the pte_list_desc.  No need to be
> +	 * u64 but just for easier alignment.  When PTE_LIST_EXT, means full.
> +	 */
> +	u64 spte_count;
> +	u64 *sptes[PTE_LIST_EXT];
> +};
> +
> +static struct kmem_cache *pte_list_desc_cache;

The definition of pte_list_desc_cache needs to go in a C file since it's
a global variable. Since it now needs to be accessed by more than once C
file, drop the static. Then it can be accessed with extern.

Since most of the code that sets up and deals with pte_list_desc_cache
is still in mmu.c, my vote is to keep the definition there.

i.e.

mmu.c:

  struct kmem_cache *pte_list_desc_cache;

rmap.c

  extern struct kmem_cache *pte_list_desc_cache;

And no need for anything in rmap.h.
