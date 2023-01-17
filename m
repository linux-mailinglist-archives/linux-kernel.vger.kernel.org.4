Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81AE66DCFA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbjAQL5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbjAQL5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:57:09 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A9C21966
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:57:08 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y5so23255924pfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dANBMAp4RAENWRZ6t/H2cMtwy5dX1USGXnBc/Bo/Oe8=;
        b=VSJnHLh7s1iiaeu991QJc0cXzh0unkpWjDRrnufHZZ/NNedjiL1s7qgJkBvmrOHl30
         i1IM9SJQFmu0MIuhdOPR85sH+95e1Be8axjATAkD/eYuOFDPxAlGCzXuwSqM427jMT9S
         v5qDzAhJ4YJvQOmMEOHEIGoIqiJIZpmPET651leAmkdgrl839LfFB6ILWRrK0zFAlXKX
         skKHnQitn4iEU62djPMlj5G5WvUa4C9qBdj1O/W6nOYwn5+Jlf6dQobgk+zStP54SH/f
         X4MHxvbGtjcv1AS4B79BJylW57zocqALfhjRRjx1Jweo+RBsW/L7oXlovO44fjE0nL9w
         Q1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dANBMAp4RAENWRZ6t/H2cMtwy5dX1USGXnBc/Bo/Oe8=;
        b=bSCsqLeuu5BfxSpnxK/dSU5ZsHrXjtWPQJPwdcyuiogIsEk7h6pAVUR2zUkKcmJyfF
         GBcW1hxeGqkvOAyJW9kTbzC1ntdvScfB8mq249ff1QoQFDertVn2+vNKYJheWWiaahCr
         Y/lv7AahcD1dwFEoTv7Y4IgulfzH+r3b3X/rWmfQR7O3kh7hUWLx/xQK53gNsBcYRpbs
         tA2vKhZVvNNF1UD26r5W9rQ//PQG5CvOzttg/+Nm3+T+w2Be2ceygDYrtZo+itF91jXa
         q/wWkFAgOEywXxx6j76obqzWAVvwJj8pP4HgRFet/YRyHoDriaOzSLZKWVp/AC5VghuE
         zUvg==
X-Gm-Message-State: AFqh2krkBI4PfJZHf9mza3mAIvseUqDobqc/HiwJigZuvHXcP9pilGjm
        WjFbGVabp4XB2g1O7/+1+qM=
X-Google-Smtp-Source: AMrXdXsfsAPFEBXS0noewcd9K0vd1wBtAXFK4aZRGgMCXc+TGFLj77ymMookAnSv9l/iR4zJrPChGw==
X-Received: by 2002:aa7:8f1a:0:b0:586:2f39:495a with SMTP id x26-20020aa78f1a000000b005862f39495amr3614019pfr.15.1673956628142;
        Tue, 17 Jan 2023 03:57:08 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id b193-20020a621bca000000b005810c4286d6sm20066745pfb.0.2023.01.17.03.57.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2023 03:57:07 -0800 (PST)
Date:   Tue, 17 Jan 2023 19:57:02 +0800
From:   qixiaoyu <qxy65535@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, xiongping1@xiaomi.com,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: set *_data_age_threshold according to
 user_block_count
Message-ID: <20230117115702.GA12653@mi-HP-ProDesk-680-G4-MT>
References: <20230117103042.2509-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117103042.2509-1-frank.li@vivo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 06:30:42PM +0800, Yangtao Li via Linux-f2fs-devel wrote:
> Commit 71644dff4811 ("f2fs: add block_age-based extent cache")
> introduce age extent cache, which experimental data is based on
> a 128G storage device, and hot and warm data age threshold are
> set to 1G and 10G respectively. But it is unreasonable to set
> this value to 1G or 10G by default, which varies depending on
> the environment. For small storage devices, some storage devices
> do not even have 10G.
> 
> Let's change hot and warm data age threshold to 1% and 10% of
> user_block_count respectively.
> 

Hi Yangtao,

Thanks for your patch.

The block age here refers to total data blocks allocated of filesystem
between two consecutive updates. So, it has nothing to do with storage
size.

> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++----
>  fs/f2fs/extent_cache.c                  | 2 --
>  fs/f2fs/f2fs.h                          | 9 +++++----
>  fs/f2fs/super.c                         | 2 ++
>  4 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 75420c242cc4..c7952f1baf59 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -660,15 +660,13 @@ What:		/sys/fs/f2fs/<disk>/hot_data_age_threshold
>  Date:		November 2022
>  Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
>  Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
> -		the data blocks as hot. By default it was initialized as 262144 blocks
> -		(equals to 1GB).
> +		the data blocks as hot. By default it was initialized as 1% of user_block_count.
>  
>  What:		/sys/fs/f2fs/<disk>/warm_data_age_threshold
>  Date:		November 2022
>  Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
>  Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
> -		the data blocks as warm. By default it was initialized as 2621440 blocks
> -		(equals to 10GB).
> +		the data blocks as warm. By default it was initialized as 10% of user_block_count.
>  
>  What:		/sys/fs/f2fs/<disk>/fault_rate
>  Date:		May 2016
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 1daf8c88c09b..9c7e304d5660 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -1235,8 +1235,6 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
>  
>  	/* initialize for block age extents */
>  	atomic64_set(&sbi->allocated_data_blocks, 0);
> -	sbi->hot_data_age_threshold = DEF_HOT_DATA_AGE_THRESHOLD;
> -	sbi->warm_data_age_threshold = DEF_WARM_DATA_AGE_THRESHOLD;
>  }
>  
>  int __init f2fs_create_extent_cache(void)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f3c5f7740c1a..3b853c302a43 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -615,11 +615,12 @@ enum {
>  #define SAME_AGE_REGION			1024
>  
>  /*
> - * Define data block with age less than 1GB as hot data
> - * define data block with age less than 10GB but more than 1GB as warm data
> + * Define data block with age less than 1% of user_block_count as hot data
> + * Define data block with age less than 10% of user_block_count but more
> + * than 1% of user_block_count as warm data
>   */
> -#define DEF_HOT_DATA_AGE_THRESHOLD	262144
> -#define DEF_WARM_DATA_AGE_THRESHOLD	2621440
> +#define DEF_HOT_DATA_AGE_THRESHOLD	1
> +#define DEF_WARM_DATA_AGE_THRESHOLD	10
>  
>  /* extent cache type */
>  enum extent_type {
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 5fc83771042d..8333ea5b8ffd 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4088,6 +4088,8 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>  					BIT(F2FS_IPU_HONOR_OPU_WRITE);
>  	}
>  
> +	sbi->hot_data_age_threshold = sbi->user_block_count * DEF_HOT_DATA_AGE_THRESHOLD / 100;
> +	sbi->warm_data_age_threshold = sbi->user_block_count * DEF_WARM_DATA_AGE_THRESHOLD / 100;
>  	sbi->readdir_ra = true;
>  }
>  
> -- 
> 2.25.1
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
