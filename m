Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA176694BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjBMPyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjBMPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:54:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0503A17148
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:54:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id fi26so13523034edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KfZZZ7pG5QyK89tWcZZMAGkA5IayYu+p3Tr5HuPXiUQ=;
        b=AdQ0spNpvZO2a1rdXtFQKQz2a5nIbm1TP0nlRNVEw0a20VQsi4P2TewXf3rcx59UHK
         JBnJk0T5H9vMttktZQt5rRUgetkcXFJAOSz19WoAM8vq5qge57WOwoka8FiZJrUE1Ja2
         GoWqE0CAilTX2E4o4EbrveWM+Z+6PiNYA1pmBDv2EwoB1C50Kqe8TLMM8ZF26zcM8hgS
         KNa5bJQT5+rg4V6OeKRrl3A8T3Ovdr652BEOONFJJRVMBYpXNInKBRTAODeD6GsbNjNw
         VzXTm+t87B7XrdydF30bBjZawimeVaBcap2kAM5Ztc5Zq34HK73VQsGIaofC2uzirgpg
         6TAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfZZZ7pG5QyK89tWcZZMAGkA5IayYu+p3Tr5HuPXiUQ=;
        b=MOidY9tnQToO4ScsEdFA9KjQwqpsxQciW946OTRPeGnSehEcWGi2cLNB3pSMDZFWKb
         h02iC6BOAr2vww5BBUKRqlFD017YJlkVkJ8Uu99lGOanGnOO4OP3fiEQSl4PD3P4uSKz
         mzSLOjJSJfSUaeaFT/mniKfDwqyumrWQOkdrcWfnqRAb4rV1/Imo8MxlL+HgBRajyqyn
         uXtS/c6QwMTLxC++M/e/2tRrvrfIzAYEe4gPP7SRJs9oCq9T2P15sg9h+5grIjji5JUh
         aUqtLDr6vXBMFbcEfURZPCLATteTtUnyX5slZWKwLtQ6xRTV6w1Mppa8aUiGxFsOs1F0
         mwfA==
X-Gm-Message-State: AO0yUKXz1wk+nXArzGUl2tN0rfzJfqUqs711K+BlP47Rq/7Zu/H5eCKI
        b7LBNbPthk96tILxRv6jmKxE3w==
X-Google-Smtp-Source: AK7set85G84Uc4/3S+BRufNyk4XF+mPrWyiWP+4v7igsCC0787RDUVcRHp/X2rzmloeF4VfNmt983Q==
X-Received: by 2002:a50:d64e:0:b0:4ab:4ad1:a381 with SMTP id c14-20020a50d64e000000b004ab4ad1a381mr9872423edj.10.1676303665506;
        Mon, 13 Feb 2023 07:54:25 -0800 (PST)
Received: from jade (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id s6-20020a50d486000000b004aab36ad060sm6803430edi.92.2023.02.13.07.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:54:25 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:54:23 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/4] tee: Remove vmalloc page support
Message-ID: <Y+pdL2g4k0Ek2iN+@jade>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
 <20230203-get_kernel_pages-v2-2-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230203-get_kernel_pages-v2-2-f1dc4af273f1@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 08:06:33PM -0800, Ira Weiny wrote:
> The kernel pages used by shm_get_kernel_pages() are allocated using
> GFP_KERNEL through the following call stack:
> 
> trusted_instantiate()
> 	trusted_payload_alloc() -> GFP_KERNEL
> 	<trusted key op>
> 		tee_shm_register_kernel_buf()
> 			register_shm_helper()
> 				shm_get_kernel_pages()
> 
> Where <trusted key op> is one of:
> 
> 	trusted_key_unseal()
> 	trusted_key_get_random()
> 	trusted_key_seal()
> 
> Remove the vmalloc page support from shm_get_kernel_pages().  Replace
> with a warn on once.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/tee/tee_shm.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)

Added to https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=get_kernel_pages-for-v6.4

Thanks,
Jens

> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 27295bda3e0b..527a6eabc03e 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -24,37 +24,25 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>  static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>  				struct page **pages)
>  {
> +	struct kvec *kiov;
>  	size_t n;
>  	int rc;
>  
> -	if (is_vmalloc_addr((void *)start)) {
> -		struct page *page;
> -
> -		for (n = 0; n < page_count; n++) {
> -			page = vmalloc_to_page((void *)(start + PAGE_SIZE * n));
> -			if (!page)
> -				return -ENOMEM;
> -
> -			get_page(page);
> -			pages[n] = page;
> -		}
> -		rc = page_count;
> -	} else {
> -		struct kvec *kiov;
> -
> -		kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> -		if (!kiov)
> -			return -ENOMEM;
> +	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start)))
> +		return -EINVAL;
>  
> -		for (n = 0; n < page_count; n++) {
> -			kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> -			kiov[n].iov_len = PAGE_SIZE;
> -		}
> +	kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> +	if (!kiov)
> +		return -ENOMEM;
>  
> -		rc = get_kernel_pages(kiov, page_count, 0, pages);
> -		kfree(kiov);
> +	for (n = 0; n < page_count; n++) {
> +		kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> +		kiov[n].iov_len = PAGE_SIZE;
>  	}
>  
> +	rc = get_kernel_pages(kiov, page_count, 0, pages);
> +	kfree(kiov);
> +
>  	return rc;
>  }
>  
> 
> -- 
> 2.39.1
