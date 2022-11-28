Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B4563AA31
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiK1N42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiK1N4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:56:17 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00B3FD9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:56:14 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b21so10198960plc.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN7rQQJkZzGKEVRkng3QEGcqHp0wQ4sozNyGRC6tD9w=;
        b=lZ2i6PZY8eyhSsYyjh+6s0/zQ9/Vo5vtrWFoEW6ECVeZX4emyOz/m78YMnU67H6nky
         jvR9VAX6So1YT6twa/x4ODb9WhBUPTubbTAn3594Ee6GrTcrH2730TOLcqbvRkGBhXVN
         scbhIYD5DtEzyPF5/5zg1dU0vN4OYbImSS6Gc9yTO4e654DhB/3xywxoBsCRZuJVrbrS
         a0hZONlpgUDOxz3VGCVh7Er7e2AYLYdaKH/q4H5vs/q9zaWcecAnO9BbgVjFx5XDbm3+
         z3l9UEwylLYWMwrPsP26ctDFOc6GCvCxpGjLIU12Gclz9d8Ye6bKrQ0C9V9hLUO/dMeQ
         +VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EN7rQQJkZzGKEVRkng3QEGcqHp0wQ4sozNyGRC6tD9w=;
        b=uqw5wta01tF31uynEQYF06ffnGJreO5NE7xdlh9OCYckVaVkVOpMjPfVWkL0pRREio
         6zZ9zHkoMEhTxBZkkFMFa2WSipwHqfvN54DEXLRvnvGc6gDyGW5zhjPQ4xRmr9ymfm4u
         DuUor459NeSZ4o68eKtiIKipK2c7LJupPlXNRudHlWXRFmGkM0c9w+jnX5RkIFbUhkC5
         v5qD3rWnNVuj/wJ2xezxbs+cQ5xkzObAMt2D9xea/FSdFton+PaNBXiMMVTgb2NG2m4H
         gf4Nz1SXoLFk03RU/5D+FUzJizk4cb5NkKf32iJT9su89VG7rDhhhov5NFEWRHqHEWHr
         +R1w==
X-Gm-Message-State: ANoB5pl0r2X6HgQXZnOxC821hWschNaEuj8LsuJAWbyOzdxbU5XxPzIW
        CIDYX24g8np+SodkAzIaHm6rjA==
X-Google-Smtp-Source: AA0mqf4sjfA9knsCcA5y2f2dZ75SzSmtPB28mKVwtEXzFIdeq4+vIwlvPJsPzGmlyJEbi5cz5RpW1g==
X-Received: by 2002:a17:90a:9904:b0:213:6442:232a with SMTP id b4-20020a17090a990400b002136442232amr61073250pjp.117.1669643774308;
        Mon, 28 Nov 2022 05:56:14 -0800 (PST)
Received: from [10.255.134.244] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001869ba04c83sm8873745plg.245.2022.11.28.05.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:56:14 -0800 (PST)
Message-ID: <042ebc25-f9ab-b407-033b-86d6fe5fda98@bytedance.com>
Date:   Mon, 28 Nov 2022 21:56:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [Phishing Risk] [External] [PATCH v2 2/2] erofs: enable large
 folios for fscache mode
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20221128025011.36352-1-jefflexu@linux.alibaba.com>
 <20221128025011.36352-3-jefflexu@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20221128025011.36352-3-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/28 10:50, Jingbo Xu 写道:
> Enable large folios for fscache mode.  Enable this feature for
> non-compressed format for now, until the compression part supports large
> folios later.
> 
> One thing worth noting is that, the feature is not enabled for the meta
> data routine since meta inodes don't need large folios for now, nor do
> they support readahead yet.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

Thanks.
> ---
>   fs/erofs/inode.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index e457b8a59ee7..85932086d23f 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -295,8 +295,7 @@ static int erofs_fill_inode(struct inode *inode)
>   		goto out_unlock;
>   	}
>   	inode->i_mapping->a_ops = &erofs_raw_access_aops;
> -	if (!erofs_is_fscache_mode(inode->i_sb))
> -		mapping_set_large_folios(inode->i_mapping);
> +	mapping_set_large_folios(inode->i_mapping);
>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>   	if (erofs_is_fscache_mode(inode->i_sb))
>   		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
