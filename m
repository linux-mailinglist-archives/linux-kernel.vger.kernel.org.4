Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDAD60B539
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiJXSQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbiJXSP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:15:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F480270832
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:57:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i3so9427490pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIODV4k/CxyWqDrn3BTYro+Cv7bqOVAWuIcvp79HhCE=;
        b=jN55x9zsMPI2rUQpjifjX/3sJ9xj3gp2PqWasnMN4sE/jMAUZiVdqlhijgOCLuMbkm
         M+/IDRXbHk66iOIJxaKfDkdYgozVSECwM2t210g59bvo3rlKcZN+U/6XPBegwzEtTEt2
         sHYnwFcUdzhf7bbRDDEfsbjedSwcJSJL9V1OTjmVNXm0xtQ5UaRdGgIs05rB1P6xj4Rf
         BuLTQXE8wlTk4PF51qg4CqL8PL2BZ0iyoyGwIdfGdbuB6LeC11ckWUWrkNqGIZZPhlzm
         /Nk26g2enHELEkexKmK7qU4dV4ip0Nept/x+fNj/Ibqy1UoFBCHAnt+vvTDpM7kZGarE
         bnKA==
X-Gm-Message-State: ACrzQf3awPw13nQKWGVXcu8zWUHHSpxjHxuzjlclXkcplwdCrQBg4lZU
        NP/REd9jerVA7Cu32gal5ogaNHd1UPs=
X-Google-Smtp-Source: AMsMyM5c2yAMlKT6ppP55adKTTI1IbDFN45o4qH3Q2phSQCzf7CiMRhyLDyABC07sAI/azek2lLnug==
X-Received: by 2002:a63:8a42:0:b0:460:58ec:cc66 with SMTP id y63-20020a638a42000000b0046058eccc66mr28924890pgd.195.1666630448231;
        Mon, 24 Oct 2022 09:54:08 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902e94500b001868da70685sm4097249pll.235.2022.10.24.09.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:54:07 -0700 (PDT)
Date:   Mon, 24 Oct 2022 09:54:05 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 3/8] mm/percpu: Update the code comment when creating new
 chunk
Message-ID: <Y1bDLRVt9yRUCQJG@fedora>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024081435.204970-4-bhe@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 04:14:30PM +0800, Baoquan He wrote:
> The lock pcpu_alloc_mutex taking code has been moved to the beginning of
> pcpu_allo() if it's non atomic allocation. So the code comment above

Typo here ^ pcpu_alloc().

> above pcpu_create_chunk() callsite need be updated.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/percpu.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index a3fde4ac03a4..a8121302a79c 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1817,16 +1817,12 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  
>  	spin_unlock_irqrestore(&pcpu_lock, flags);
>  
> -	/*
> -	 * No space left.  Create a new chunk.  We don't want multiple
> -	 * tasks to create chunks simultaneously.  Serialize and create iff
> -	 * there's still no empty chunk after grabbing the mutex.
> -	 */
>  	if (is_atomic) {
>  		err = "atomic alloc failed, no space left";
>  		goto fail;
>  	}
>  
> +	/* No space left.  Create a new chunk. */
>  	if (list_empty(&pcpu_chunk_lists[pcpu_free_slot])) {
>  		chunk = pcpu_create_chunk(pcpu_gfp);
>  		if (!chunk) {
> -- 
> 2.34.1
> 
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
