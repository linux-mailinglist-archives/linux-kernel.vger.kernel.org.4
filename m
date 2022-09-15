Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31955B93BA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 06:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIOErp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 00:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIOErn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 00:47:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00542915DA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 21:47:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B1AF05C9DD;
        Thu, 15 Sep 2022 04:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663217261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oyIUsk6sHUPZgVxXFtXQrzKmfZGdQ9Uug4BgQW8pjW4=;
        b=vNFFy42GO0d+iLV2boTsxMGM5d9oO6WnPxTRuNys6O9RSl5m6QTB8SlF+AjFqnwZXMK9LA
        Kp1d7/yy/8zo9AzFl879IfV2hzvrRhNmFUi2Ct/P2cQI7AOyFw88Cgh8XnzfLsgXxvGpsD
        9HZDIAhplK/Dkx6JvSNzn8I8ZqJuWVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663217261;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oyIUsk6sHUPZgVxXFtXQrzKmfZGdQ9Uug4BgQW8pjW4=;
        b=45Dr8e/qy9q8kjqsjkPxCa3Y/VdTI8y+qgP5QP59S4crqaCHHiT2W9aBxab+gIx4Hq4s7+
        1N9mRlU4J2QM6RCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C207139B3;
        Thu, 15 Sep 2022 04:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BOKoE22uImPnKwAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 15 Sep 2022 04:47:41 +0000
Date:   Thu, 15 Sep 2022 06:47:39 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/16] mm/page_alloc: remove obsolete comment in
 zone_statistics()
Message-ID: <YyKua3htQ6GgWhGI@localhost.localdomain>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092451.24883-5-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:24:39PM +0800, Miaohe Lin wrote:
> Since commit 43c95bcc51e4 ("mm/page_alloc: reduce duration that IRQs
> are disabled for VM counters"), zone_statistics() is not called with
> interrupts disabled. Update the corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/page_alloc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2deac2fe3372..c81f06d8a4f5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3671,8 +3671,6 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
>  
>  /*
>   * Update NUMA hit/miss statistics
> - *
> - * Must be called with interrupts disabled.
>   */
>  static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
>  				   long nr_account)
> -- 
> 2.23.0
> 

-- 
Oscar Salvador
SUSE Labs
