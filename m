Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC247650CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiLSNpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSNpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:45:19 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AB310074
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:45:18 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id g14so9101305ljh.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jWwojFcgvooRzwcY3kRRXotYy0Om3fIUII0d+MNiGwk=;
        b=DCX4oClnCIgAyv3gYJysFwGq+V35MxGf31bS2oPI+Qlj6V+ShxpjLS+fsVZGUJRIGB
         ePr5ErZB25VyS5xSovUXRmeinqXroS7xO0RPkn8q/4LjXjN2HMBNSZ+Tv/xI+t4wYe7F
         4ezcRe4auKulMdTwyLkDTG9i7X9UCqf0JJQqv9R2pgbzy1IRhaBSFnTkrXK7zGJ+RGUZ
         /RNfIaSJq65/UmxNw5IDqYswDIsPII8u5v8P1u7CKWN7PYjiyr5912bvTdMX2+9remoP
         0ZYn8CweqvMn8nep95lYI7tsfBxe9WpvYJIrKdGMfoS2E2tiiy/Ibcv7wdLeBOcCDZg/
         XViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWwojFcgvooRzwcY3kRRXotYy0Om3fIUII0d+MNiGwk=;
        b=daM1xuKOSVzcNmD9tNOvJfqfCvaU7JZZCuhUeJmINOItnwNEpQ/TTuvLCVkJojIAWP
         hZOdM1AmgVGFOCJzDiBgdWly1NQp2AVXCfd9gQAb2LMWlkM/5+6/PZw4bvcqgzUwB815
         UEYDSeitxuhFlnlhwajmZN9UNQ4Hje8pxRyo3+K/3np3gv6VjDej5nHGgTVhbSYJvxcZ
         F/3WGoWJl4zF2erI02SI3+MsdPIadsd5/Kk4tkqozwyezX076EmmmrNUerN3KMPRzqI7
         vkVEH+CnjUl8YUhfcCz2IEkL8+whXX5+hS5eON+3KjCmujnIS6p/V9Iot5V0UMtcJDdE
         yQcA==
X-Gm-Message-State: ANoB5pm51SAyu4UcXfZopTaGgPZ6637mlhYcOHV4DkPVDpMBDR2DUK5V
        1yxFNEsRTRjzUZTC5QOT2SQ=
X-Google-Smtp-Source: AA0mqf7+uq1OpLbr8wQHGFpw85OrlLg27KxT7NatFAHD95oOGfxFSNWgBz05V71hYkPc54ZhaW6EwA==
X-Received: by 2002:a05:651c:98e:b0:277:351f:8cf5 with SMTP id b14-20020a05651c098e00b00277351f8cf5mr10873377ljq.3.1671457516389;
        Mon, 19 Dec 2022 05:45:16 -0800 (PST)
Received: from pc636 (host-90-233-218-120.mobileonline.telia.com. [90.233.218.120])
        by smtp.gmail.com with ESMTPSA id g24-20020a2eb5d8000000b0027776efa48csm760923ljn.91.2022.12.19.05.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 05:45:16 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 19 Dec 2022 14:45:13 +0100
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] mm: vmalloc: correct use of __GFP_NOWARN mask in
 __vmalloc_area_node()
Message-ID: <Y6Bq6e7nEZYiOiQ7@pc636>
References: <20221219123659.90614-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219123659.90614-1-lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 12:36:59PM +0000, Lorenzo Stoakes wrote:
> This function sets __GFP_NOWARN in the gfp_mask rendering the warn_alloc()
> invocations no-ops. Remove this and instead rely on this flag being set
> only for the vm_area_alloc_pages() function, ensuring it is cleared for
> each of the warn_alloc() calls.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ca71de7c9d77..10fe83c24436 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3031,7 +3031,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	int ret;
> 
>  	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
> -	gfp_mask |= __GFP_NOWARN;
> +
>  	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
>  		gfp_mask |= __GFP_HIGHMEM;
> 
> --
> 2.39.0
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
