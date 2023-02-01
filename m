Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC494686815
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjBAOWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjBAOWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:22:31 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C22125B1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:22:29 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z11so17860460ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 06:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4lxdpaowO7ASMedJlKtZbh/kx5LEejmBeEu0y9isbk=;
        b=O5Nz0DKN/Uj80cHbuB1ldIMLdlH++UAgNcK0kkjJNulyHrdXo6+pAeLpUR70PJBEN7
         hjQQ5bx8cwCNqt4Su0lM+MtXWVlbxuAIpbhrNcGd2X0RV92WmX6UB0VFu07ddIi56ALV
         UISL4MAlRpsaPfV7JKoJyXDTXIVFt2nzZ6Hp+mtw2jCTRGnQu+q/hT2IAzE2p0GXu9bK
         HiiDKEKZv4Me9qJMmYDf1AM4lTJTWwfuCFR9olO46ATK8cla6cCFjkVrGYacaQZcuTUM
         Eo1XixW6OoH1T2fWHnjd2zPaRt9XBo5qN6pd84utv1nrXT7VnXeSnq5x/wB3oEQnCC1o
         CCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4lxdpaowO7ASMedJlKtZbh/kx5LEejmBeEu0y9isbk=;
        b=lE6nDrxUG6CctSO0m+xDvr349ZSNNZrL14Ch8hbPOUeI40Qsm0UYs2FU7zPq51w37I
         DZkXAEozYUaRPxcLaUUc+DWp5/bX+nNJmw1CpEZPqCcJei7O90kqbI4Z/SaGAzvK3WGJ
         UYoGwkKq9RG+tfPHKOkXPL4VlrfP5b857FIrWrubwb2ENit1zAIlYSg6ISxS5Qy+P8g5
         XwWIdl7XDJXTqky9ZKItx8sLFNIJffPpULok+Xd7ybX0YW4l0a2AZJwwQ6PMhNIdLzYD
         ++J8sUjQeDq5T9DlRXzLvBrEu5Y0J/7oSQEBM32Oo7o5suXXXhf1GYkKq+GHgrhoykfT
         9FSA==
X-Gm-Message-State: AO0yUKVU59J9/ISljdzhYSlKrd/jtU4ItWVnQP+J5WlTJBAcoKRfE8HZ
        iWmSqN/4gN7Vi51hTSVOgak=
X-Google-Smtp-Source: AK7set9HN5zAS4AQ4vvW+T4vXIBsk4axiLq2OXWR0+5+f2AU/tukwLwJojApbNl75d5of+aKaxxx3A==
X-Received: by 2002:aa7:c403:0:b0:46c:8544:42be with SMTP id j3-20020aa7c403000000b0046c854442bemr2190649edq.5.1675261348292;
        Wed, 01 Feb 2023 06:22:28 -0800 (PST)
Received: from pc636 (host-78-79-169-126.mobileonline.telia.com. [78.79.169.126])
        by smtp.gmail.com with ESMTPSA id dn10-20020a05640222ea00b00482b3d0e1absm9829665edb.87.2023.02.01.06.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:22:27 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Feb 2023 15:22:25 +0100
To:     Hyunmin Lee <hn.min.lee@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jeungwoo Yoo <casionwoo@gmail.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        Mike Rapoport <rppt@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4] mm/vmalloc: replace BUG_ON to a simple if statement
Message-ID: <Y9p1oS7OJiihCZ7O@pc636>
References: <20230201115142.GA7772@min-iamroot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201115142.GA7772@min-iamroot>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 08:51:42PM +0900, Hyunmin Lee wrote:
> As per the coding standards, in the event of an abnormal condition that
> should not occur under normal circumstances, the kernel should attempt
> recovery and proceed with execution, rather than halting the machine.
> 
> Specifically, in the alloc_vmap_area() function, use a simple if()
> instead of using BUG_ON() halting the machine.
> 
> Co-Developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Co-Developed-by: Jeungwoo Yoo <casionwoo@gmail.com>
> Co-Developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Signed-off-by: Hyunmin Lee <hn.min.lee@gmail.com>
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
> Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
> v1->v2 : Add commit description
> v2->v3 : Change WARN_ON() to if()
> v3->v4 : Use only one if() for three conditions
> ---
>  mm/vmalloc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 74afa2208558..3b7e8856be35 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1587,9 +1587,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	int purged = 0;
>  	int ret;
>  
> -	BUG_ON(!size);
> -	BUG_ON(offset_in_page(size));
> -	BUG_ON(!is_power_of_2(align));
> +	if (unlikely(!size || offset_in_page(size) || !is_power_of_2(align)))
> +		return ERR_PTR(-EINVAL);
>  
>  	if (unlikely(!vmap_initialized))
>  		return ERR_PTR(-EBUSY);
> -- 
> 2.25.1
> 
Makes sense to me.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
