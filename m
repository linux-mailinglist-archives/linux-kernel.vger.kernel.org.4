Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3381168FD4F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjBICsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjBICq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:46:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BAE1BFD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:43:33 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id f6so1349619pln.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 18:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6iXDCmEIe8YwpqTZfUQ4aqLxhpWrn73JNMNernn3kk=;
        b=Mk8Yc+aEdxHXckXYsM8d6w5yMom9HAJTqxnJNCq9tOI5xxqq653wJt6aU1arFIS9vo
         RkG0iMquvJAyzeD+zZqYVaaLL6QOqLfcDvlGQYsxxefgsy2lTOojNdqMe5tSAxyCXj0U
         AyZSMJn1RYmOTwRYC3PVDQOLZTpUNKf8v4V0jZ4hhl63+gqPr2r1dHCC/lqdyPO+sEL8
         klRyGhswrSkHM2tt9IQJUPTfXjdnZYAkxHoAoAfM+IKj5LVI0grH6YXnuMnuiXmbiaUF
         m8eVo3nl929QIuwtQH8mF0zXOGCKHGH/MWVAiaN48vKUFsQAtrIJjW1kGvDZ8q7Q7WW7
         LlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/6iXDCmEIe8YwpqTZfUQ4aqLxhpWrn73JNMNernn3kk=;
        b=d+n+CAdevB5jk2ROv/gUJCUsPlhP4QD4g2ti95no8RctuEFVxMv3Lod7b365LZoxUN
         WGqJXLzgvsHtLSDnPvMYULGy0BjllDnuyJWWkUFmg+8tj3yPcJnl8ciL5PMLxtGPfWQn
         vVoO8Z/4y+UETsLDcF/1LG3TesFB4JxkiNc7yS4rpmRANDyTLvI3tVWIWpCq68XDlf9W
         acynza/a1SElWI8kg/6DsYZCIlq6riK8NzteYuF/DrDmtR1SFg2NUw9APawxO112R7UD
         tY3Z4h/neDUvhJxUMsw9ktMMej5i3xedGQRT6KhYZMoeLaSMPlDjTuaQ/BI7WE9cYDaa
         xCNQ==
X-Gm-Message-State: AO0yUKWEh0mEg6KqaSTR45igkXwY9dErXLmxV1HYOIHqy5AMgfpaACAL
        TRIqsqhtUO0C/Zr3ZuHMz9+LVg==
X-Google-Smtp-Source: AK7set+w7OSDqHLMhPECQU84Ihi0UG+DORJcjKgr98v3nxJqaiAUeq40TDrwYGZIvysMZVkwUm2fTg==
X-Received: by 2002:a17:902:f548:b0:199:2f53:4d95 with SMTP id h8-20020a170902f54800b001992f534d95mr10320393plf.50.1675910613291;
        Wed, 08 Feb 2023 18:43:33 -0800 (PST)
Received: from [10.3.144.50] ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id x5-20020a654145000000b004a737a6e62fsm220961pgp.14.2023.02.08.18.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 18:43:32 -0800 (PST)
Message-ID: <ce11c1b5-b83e-5c5d-5e03-ea3278059efb@bytedance.com>
Date:   Thu, 9 Feb 2023 10:43:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] erofs: simplify the name collision checking in share
 domain mode
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org, houtao1@huawei.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        zhujia.zj@bytedance.com
References: <cover.1675840368.git.jefflexu@linux.alibaba.com>
 <489d47915bcc71ef3c3ec7b8a437ec6e09c4c3db.1675840368.git.jefflexu@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <489d47915bcc71ef3c3ec7b8a437ec6e09c4c3db.1675840368.git.jefflexu@linux.alibaba.com>
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



在 2023/2/8 15:17, Jingbo Xu 写道:
> When share domain is enabled, data blobs can be shared among filesystem
> instances in the same domain for data deduplication, while bootstrap
> blobs are always dedicated to the corresponding filesystem instance, and
> have no need to be shared.
> 
> In the initial implementation of share domain (commit 7d41963759fe
> ("erofs: Support sharing cookies in the same domain")), bootstrap blobs
> are also in the share domain, and thus can be referenced by the
> following filesystem instances.  In this case, mounting twice with the
> same fsid and domain_id will trigger warning in sysfs.  Commit
> 27f2a2dcc626 ("erofs: check the uniqueness of fsid in shared domain in
> advance") fixes this by introducing the name collision checking.
> 
> This patch attempts to fix the above issue in another simpler way.
> Since the bootstrap blobs have no need to be shared, move them out of
> the share domain, so that one bootstrap blob can not be referenced by
> other filesystem instances.  Attempt to mount twice with the same fsid
> and domain_id will fail with info of duplicate cookies, which is
> consistent with the behavior in non-share-domain mode.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/erofs/fscache.c  | 36 ++++++++----------------------------
>   fs/erofs/internal.h |  4 ++--
>   fs/erofs/super.c    |  2 +-
>   3 files changed, 11 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 8353a5fe8c71..8da6e05e9d23 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -505,25 +505,18 @@ struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
>   
>   static
>   struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
> -						   char *name,
> -						   unsigned int flags)
> +						   char *name)
>   {
>   	struct erofs_fscache *ctx;
>   	struct erofs_domain *domain = EROFS_SB(sb)->domain;
>   
>   	mutex_lock(&erofs_domain_cookies_lock);
>   	list_for_each_entry(ctx, &erofs_domain_cookies_list, node) {
> -		if (ctx->domain != domain || strcmp(ctx->name, name))
> -			continue;
> -		if (!(flags & EROFS_REG_COOKIE_NEED_NOEXIST)) {
> +		if (ctx->domain == domain && !strcmp(ctx->name, name)) {
>   			refcount_inc(&ctx->ref);
> -		} else {
> -			erofs_err(sb, "%s already exists in domain %s", name,
> -				  domain->domain_id);
> -			ctx = ERR_PTR(-EEXIST);
> +			mutex_unlock(&erofs_domain_cookies_lock);
> +			return ctx;
>   		}
> -		mutex_unlock(&erofs_domain_cookies_lock);
> -		return ctx;
>   	}
>   	ctx = erofs_fscache_domain_init_cookie(sb, name);
>   	mutex_unlock(&erofs_domain_cookies_lock);
> @@ -531,11 +524,10 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>   }
>   
>   struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -						    char *name,
> -						    unsigned int flags)
> +						    char *name)
>   {
>   	if (EROFS_SB(sb)->domain_id)
> -		return erofs_domain_register_cookie(sb, name, flags);
> +		return erofs_domain_register_cookie(sb, name);
>   	return erofs_fscache_acquire_cookie(sb, sb, name);
>   }
>   
> @@ -564,7 +556,6 @@ int erofs_fscache_register_fs(struct super_block *sb)
>   	int ret;
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   	struct erofs_fscache *fscache;
> -	unsigned int flags = 0;
>   
>   	if (sbi->domain_id)
>   		ret = erofs_fscache_register_domain(sb);
> @@ -573,19 +564,8 @@ int erofs_fscache_register_fs(struct super_block *sb)
>   	if (ret)
>   		return ret;
>   
> -	/*
> -	 * When shared domain is enabled, using NEED_NOEXIST to guarantee
> -	 * the primary data blob (aka fsid) is unique in the shared domain.
> -	 *
> -	 * For non-shared-domain case, fscache_acquire_volume() invoked by
> -	 * erofs_fscache_register_volume() has already guaranteed
> -	 * the uniqueness of primary data blob.
> -	 *
> -	 * Acquired domain/volume will be relinquished in kill_sb() on error.
> -	 */
> -	if (sbi->domain_id)
> -		flags |= EROFS_REG_COOKIE_NEED_NOEXIST;
> -	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, flags);
> +	/* acquired domain/volume will be relinquished in kill_sb() on error */
> +	fscache = erofs_fscache_acquire_cookie(sb, sb, sbi->fsid);
>   	if (IS_ERR(fscache))
>   		return PTR_ERR(fscache);
>   
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 125e4aa8d295..fded736bc3d5 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -570,7 +570,7 @@ int erofs_fscache_register_fs(struct super_block *sb);
>   void erofs_fscache_unregister_fs(struct super_block *sb);
>   
>   struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -					char *name, unsigned int flags);
> +						    char *name);
>   void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
>   #else
>   static inline int erofs_fscache_register_fs(struct super_block *sb)
> @@ -581,7 +581,7 @@ static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
>   
>   static inline
>   struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -					char *name, unsigned int flags)
> +						    char *name)
>   {
>   	return ERR_PTR(-EOPNOTSUPP);
>   }
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 19b1ae79cec4..8706ca34f26a 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -244,7 +244,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   	}
>   
>   	if (erofs_is_fscache_mode(sb)) {
> -		fscache = erofs_fscache_register_cookie(sb, dif->path, 0);
> +		fscache = erofs_fscache_register_cookie(sb, dif->path);
>   		if (IS_ERR(fscache))
>   			return PTR_ERR(fscache);
>   		dif->fscache = fscache;
