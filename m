Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84AC5F82F4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 06:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJHEi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 00:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJHEiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 00:38:55 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E8FF88D5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 21:38:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y8so6493945pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 21:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=knSy7HMcW9hIxtzP/QHqpkjPX5uvUVeEAsZZrCBYftM=;
        b=FZq7MetQyUKFfEwcL1sCK+u+TIBWXMPgmMOzjw+aiOcDxpXDaA9XfkBdEFYZugPX+w
         8ijnSUaY+1582TA1w6/yeIJsW7xVgVmt6yhODXDoX/JOz5e4z1OY/ZTRB3dAnk8Zvrin
         iCHxrLrDvM4RAQeLImS5PexVJnJcupRXM7oHgN6xmfk99d/hrqCBQWLu2sKugMbqwhds
         qKftxNDQfON7cJIiSeQ+r7R18ic2fAfAVgRRpVXWPW/HQHbMarvEoA7Wor9hcJE5yQWT
         btIoSFm17ZAmvAtEK2ludpJn7AJYt4ykEV2QgFyMDTwwVuV77sJVWhnXlWuX/Xz2ZW3A
         K92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knSy7HMcW9hIxtzP/QHqpkjPX5uvUVeEAsZZrCBYftM=;
        b=pbaNOwX1KNP10bGDi1gWf10NElkA/zczb1nskKqxEGaK2O0hY6Xz525az3amDv8NSb
         MInqkYWBtKT6FR5os1K829iVNJWNvh9m1PTcPx/VUuiWHd0vSgyGjZeLYk6cJ4e4sD85
         OdhrvHYWMm2ysgkY8+UrIV2GoDrLsz5TiRdwXCu9fUlQ0+zmFhDh2wb+u0KvWLXeJ/pi
         6msvZp6CvHX91nBcS4UD7Jf2WsBm+J/if0z+hmQXvNd4Vsnc7zMHxpLOvg/yPFbxnL81
         AS2TsK9nep6xFM2KvogILUQbcn4x/TiubNLZCNc/a114rVjeZHJrb55TfZPjtEXeF2px
         WiAQ==
X-Gm-Message-State: ACrzQf12MaLa/QTFdOr1aQXhWFGbhTsmdK2ldWyq/6LU+mqgl2rNDmVo
        x5uPqmmX49B5kpfVe2VGENA=
X-Google-Smtp-Source: AMsMyM6dMrfJHPQGVen9cJacv4Rm9dU1784g4PuV2+RhUSXl9rTsm4n+ngPuL7ehdjL14Joz/JkaYw==
X-Received: by 2002:a63:4507:0:b0:43c:9cf4:f1d6 with SMTP id s7-20020a634507000000b0043c9cf4f1d6mr7674900pga.316.1665203933858;
        Fri, 07 Oct 2022 21:38:53 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903124d00b0017f80305239sm2348032plh.136.2022.10.07.21.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 21:38:52 -0700 (PDT)
Date:   Sat, 8 Oct 2022 13:38:47 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH] mm: slab: comment __GFP_ZERO case for kmem_cache_alloc
Message-ID: <Y0D+1wAMu6HhPmBG@hyeyoo>
References: <20221008020312.1932347-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008020312.1932347-1-aahringo@redhat.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 10:03:12PM -0400, Alexander Aring wrote:
> This patch will add a comment for the __GFP_ZERO flag case for
> kmem_cache_alloc(). As the current comment mentioned that the flags only
> matters if the cache has no available objects it's different for the
> __GFP_ZERO flag which will ensure that the returned object is always
> zeroed in any case.
> 
> I have the feeling I run into this question already two times if the
> user need to zero the object or not, but the user does not need to zero
> the object afterwards. However another use of __GFP_ZERO and only zero
> the object if the cache has no available objects would also make no
> sense.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  mm/slab.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 10e96137b44f..7a84c2aae85a 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3482,7 +3482,8 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
>   * @flags: See kmalloc().
>   *
>   * Allocate an object from this cache.  The flags are only relevant
> - * if the cache has no available objects.
> + * if the cache has no available objects. Except flag __GFP_ZERO which
> + * will zero the returned object.
>   *
>   * Return: pointer to the new object or %NULL in case of error
>   */
> -- 
> 2.31.1
> 

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

-- 
Thanks,
Hyeonggon
