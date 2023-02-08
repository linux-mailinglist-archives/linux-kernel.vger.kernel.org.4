Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB3F68E8DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjBHHVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjBHHVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:21:47 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFFF3598
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:21:24 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id v23so18339863plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 23:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnQlhoNYMIV2+tPGF0jfk+u/gLKVHE9+bmnI1kjJ9n8=;
        b=7Coj5NK2+px3MdXfVaXjjriO6mBmLQj4BgF15WCpKicFq3eLsaL2MKmI36JutdzESZ
         7gnG0bzZPj5M3xwBq1uDlsPRIGllENqNT/mI8ol8aVHYNfaKg3H9v1doGu0r8H+UO0Vh
         lFS23Py4+jCFC80nahEE4pap+BbKOplsVj88gZLUP6AKdU0tr+ihCANq+nFWCYjaacFt
         4LtRVwKNNBNTIsGSZj9krVFu713EDbZCbpAxJGQuK71SzzTT8VVhs76ybrVyq+atxWeO
         Mcyvb+0UKSmHC/KZzgVg6VwsEXhYHxdA0bBlfiVmyoZR33yCKLgy6mzpVWclOL5DD87c
         xCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QnQlhoNYMIV2+tPGF0jfk+u/gLKVHE9+bmnI1kjJ9n8=;
        b=F0Ug8Dlsr4GGk1H1FNE6K1HvO1kxkl3kLymREjgBYQY++Xx+wTLMxqwhUiB93J2iXV
         8m8Mxx6nFBfMcX6vlvc/H+RRN2a/9KFrS2lvkwtfEf7Mo86VuXLBqtvCpxGQO03cMRZ5
         aGUN0044XZOWRx++Lmhfmhzk31MGwfFAW0cXLn586ofR6fYmZqM/O8TGtzBXGnD5Ft0i
         d+TqvGDKJJzT+4ZMHVyANR2slGVze4AKm6Gbc74Jk/HCkCQ0ZvIpPKKamSly/42gg5CM
         CEjcFAnwdlRh2usJ+Wcygw8R6JnQFSCP758JHr6EXm5O3AaxQ+jtGcR1V90pKcrO4khf
         qx/g==
X-Gm-Message-State: AO0yUKVpCEZw+1aO7aXFI1UEyDbMWEpzTlUe1t8g2Ul5wS9HGTbKnk5Q
        KYc217AVf+85Sv1nBLIUE3JKuw==
X-Google-Smtp-Source: AK7set9wzjN75WoOlnhsYSX3I0lzKSyFktywX6IgtJNMFLJ7itZa+IX/jGYO653vXPTegzI8p8GaKQ==
X-Received: by 2002:a17:902:e751:b0:198:e8f3:6a48 with SMTP id p17-20020a170902e75100b00198e8f36a48mr7733926plf.9.1675840884028;
        Tue, 07 Feb 2023 23:21:24 -0800 (PST)
Received: from [10.3.144.50] ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090331cd00b00198f1de408csm8057070ple.268.2023.02.07.23.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 23:21:23 -0800 (PST)
Message-ID: <c733fc59-ed5e-276d-35c0-1a45257654f0@bytedance.com>
Date:   Wed, 8 Feb 2023 15:21:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [External] [PATCH 1/4] erofs: remove unused device mapping in
 meta routine
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
References: <cover.1675840368.git.jefflexu@linux.alibaba.com>
 <404848a1e43ff2d585c91e222beae4de8b9fb5f3.1675840368.git.jefflexu@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <404848a1e43ff2d585c91e222beae4de8b9fb5f3.1675840368.git.jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/2/8 15:16, Jingbo Xu 写道:
> Currently metadata is always on bootstrap, and thus device mapping is
> not needed so far.  Remove the redundant device mapping in the meta
> routine.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/erofs/fscache.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 014e20962376..03de4dc99302 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -164,18 +164,8 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
>   static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>   {
>   	int ret;
> -	struct super_block *sb = folio_mapping(folio)->host->i_sb;
> +	struct erofs_fscache *ctx = folio_mapping(folio)->host->i_private;
>   	struct erofs_fscache_request *req;
> -	struct erofs_map_dev mdev = {
> -		.m_deviceid = 0,
> -		.m_pa = folio_pos(folio),
> -	};
> -
> -	ret = erofs_map_dev(sb, &mdev);
> -	if (ret) {
> -		folio_unlock(folio);
> -		return ret;
> -	}
>   
>   	req = erofs_fscache_req_alloc(folio_mapping(folio),
>   				folio_pos(folio), folio_size(folio));
> @@ -184,8 +174,8 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>   		return PTR_ERR(req);
>   	}
>   
> -	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> -				req, mdev.m_pa, folio_size(folio));
> +	ret = erofs_fscache_read_folios_async(ctx->cookie, req,
> +				folio_pos(folio), folio_size(folio));
>   	if (ret)
>   		req->error = ret;
>   
> @@ -469,6 +459,7 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
>   		inode->i_size = OFFSET_MAX;
>   		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
>   		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> +		inode->i_private = ctx;
>   
>   		ctx->inode = inode;
>   	}
