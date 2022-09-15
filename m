Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09425B9585
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIOHjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIOHjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:39:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5171D89930
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:38:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0B9B95CEDA;
        Thu, 15 Sep 2022 07:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663227538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TUTn+3IKELwrL18ONW8FbXabDVSGLwZ+kOCiDmQzLsw=;
        b=eWvoVjda073CwhGyDL5Dnpq4emHru90vr3ozC3wfVS9Af0gNe2FqigIgzh44wJylHnEyc/
        acrcoAE28NUOH1e5H8Hr2ZRdbZOmhbUr8cRc7JQt/zYE5hiJmRjVYA6HDkxG0E45Yniybu
        ScT9S/DdzSnC4C2kwbujCZOmx8nHz2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663227538;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TUTn+3IKELwrL18ONW8FbXabDVSGLwZ+kOCiDmQzLsw=;
        b=o0EeACMOD6WBpd4tluWlGsCjwOW8ZBjI7YrT1VpxJoJFooAs9aRhFTg4dHlJwVWLoNtdKz
        aEdTDQ+6TcqjhYDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A64AB133A7;
        Thu, 15 Sep 2022 07:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h17jJZHWImOIZgAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 15 Sep 2022 07:38:57 +0000
Date:   Thu, 15 Sep 2022 09:38:55 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/16] mm/page_alloc: make boot_nodestats static
Message-ID: <YyLWjwwocpMb4tsX@localhost.localdomain>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-12-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092451.24883-12-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:24:46PM +0800, Miaohe Lin wrote:
> It's only used in mm/page_alloc.c now. Make it static.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/internal.h   | 2 --
>  mm/page_alloc.c | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 2424fcde6538..43a441d35baf 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -864,8 +864,6 @@ int migrate_device_coherent_page(struct page *page);
>   */
>  struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
>  
> -DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
> -
>  extern bool mirrored_kernelcore;
>  
>  static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3417232afa45..7a8a6bb08a15 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6571,7 +6571,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
>  #define BOOT_PAGESET_BATCH	1
>  static DEFINE_PER_CPU(struct per_cpu_pages, boot_pageset);
>  static DEFINE_PER_CPU(struct per_cpu_zonestat, boot_zonestats);
> -DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
> +static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>  
>  static void __build_all_zonelists(void *data)
>  {
> -- 
> 2.23.0
> 

-- 
Oscar Salvador
SUSE Labs
