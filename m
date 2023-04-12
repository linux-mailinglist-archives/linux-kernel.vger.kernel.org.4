Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B833C6DE9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 05:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDLDkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 23:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLDkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:40:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923113C3C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:40:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-633af513162so1068550b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681270834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agvz4oF+06+P1I3Dywr9vXf4P0PNC8SN/2J0BcuAGYw=;
        b=C1r+H+/TJLQD3G3y1Uc2gUP54iJey7FbM8Y3Gm/xyERny5GaNri/LXtyq38HwNrz0b
         Pa0gWw0rGBdA6G1lP+kNl6JiOaTIAYdLzyTvWCdTryURQ7BJsb6UwTEFBCkJcLlX7MTf
         xXQPuFiwwqFHuHJJ1+8G767XOQSqX+aY8XXqpG6mJFeE7UCRtNTrPL+nXRGccgOpuQmI
         PL55yVAJTkKrv37gDRQGu8F9BLogvFc3SMHCzQQYc4TA41L7IqJVAnNtf0DmKgWT60g+
         dsuqRJT/vUH+fQFrYIvzOnvVL1Ib6mzzhazM1tvqMWMBrVXCZdTdI6JhnFbyl4kyakAD
         46HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681270834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agvz4oF+06+P1I3Dywr9vXf4P0PNC8SN/2J0BcuAGYw=;
        b=p+GgWB+BYfd8xpK1UJ1iB+jqpSzXU70QgALZfqfr3Ve9WpFmoWmwN2BCOguAZSHY5T
         if/qs8lbw7MnsTdoMUolTk9Pg8pvBYHUbGiO6YsRgVNNk0ykQHIbkMIaRh1UsJ6cZcDS
         F0K8MfG9V7BJqGyVji9GaK0YnhR27GFPWZDKeTx+IPbcnTYy4HNElg6Hjc3CB6/gtOgJ
         5yMxh5TbB4ug2VrOiqQAqtT234m+3/Tqgc4LwIJkvTM/NuIfCS2JCvfqVWUKBxirXCVf
         4OZyT0lsfZHggTh+zsFNtZzUaYtjHwOkTYywKQjEHBeZmC7Gz1ZPnom8diGHNaGZtyR2
         PDCA==
X-Gm-Message-State: AAQBX9c+ccoB0Eme0Nd+sCAhkLMZUSssSd3cnjr6Sb4pM19znW0sh6vx
        cATsZ9GctKgN+7M5FqocMnk=
X-Google-Smtp-Source: AKy350YGKCIOXJlzRexDQnS68PFftOgkzTAPkuZvjCnCrzkBER0080Q2HRX/lQbnmV1z/rz6ONqgWA==
X-Received: by 2002:a62:5f06:0:b0:634:b231:d2ec with SMTP id t6-20020a625f06000000b00634b231d2ecmr13111740pfb.25.1681270833933;
        Tue, 11 Apr 2023 20:40:33 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id t15-20020a62ea0f000000b005a84ef49c63sm10485715pfh.214.2023.04.11.20.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 20:40:33 -0700 (PDT)
Message-ID: <aac1fa88-46bb-08ab-35e7-75e44b8d28b5@gmail.com>
Date:   Wed, 12 Apr 2023 10:40:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] mm: Fixed incorrect comment for _kmem_cache_create
 function
To:     zhaoxinchao <ChrisXinchao@outlook.com>
Cc:     akpm@linux-foundation.org, cl@linux.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz
References: <ZDQXl2wMk271w3xy@debian.me>
 <DM6PR22MB183653311FF3549B7D473020C59A9@DM6PR22MB1836.namprd22.prod.outlook.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <DM6PR22MB183653311FF3549B7D473020C59A9@DM6PR22MB1836.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 16:13, zhaoxinchao wrote:
> diff --git a/mm/slab.c b/mm/slab.c
> index edbe722fb..399daa4d0 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1893,7 +1893,12 @@ static bool set_on_slab_cache(struct kmem_cache *cachep,
>   * @cachep: cache management descriptor
>   * @flags: SLAB flags
>   *
> - * Returns a ptr to the cache on success, NULL on failure.
> + * Returns zero on success, nonzero on failure.
> + * This function has three return positions.
> + * In addition to successfully return 0, the
> + * first failed position will return - E2BIG,
> + * and the second position will return nonzero
> + * value for setup_cpu_cache function failure.
>   * Cannot be called within an int, but can be interrupted.
>   * The @ctor is run when new pages are allocated by the cache.
>   *

I don't see any visible changes in my htmldocs build (since the
kernel-doc is for inline version of kmem_cache_create()).
You will also need to update kernel-doc comment for
kmem_cache_create_usercopy() and kmem_cache_create() in
mm/slab_common.c. Since the latter function is actually a wrapper
on the former, the return value description (Return: field)
should be same on both.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

