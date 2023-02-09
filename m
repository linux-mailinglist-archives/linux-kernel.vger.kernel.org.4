Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B169001F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjBIGC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBIGC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:02:56 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410AC12F1F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 22:02:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b5so1768523plz.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 22:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq6ffAocVRk2ZcWszPTKjr8Npi5WMgE905LQBVlYd7E=;
        b=NUbz+o3Gg0H2ZbSUYeSm9OgvkY6xBs6MyggnFllqVhxjVlRzACEN9LHU5AdhtXNQXa
         tQu0Zk75DHsbTEZEMmrzMfUjSmkFvj4il5n6oTyWS1O7PWf2czmKs6xe/t3nrs/q2sHp
         iTCj/ZAUOAE1hcbKbYYWcTHGfOd5RoaYbTGoDV8BlLMAXM0vAPT5LKMXMmuAUr3uBKGV
         7S53fq2iMxtFfUsyAJq0DIuQBtE7SITWT5XSEMAschJ9tIcykqJ46dK8p4FuLRnbjHe1
         evWgWWH6ZN1XJdCrPWtf2QLg7q96Y96KtCUuIakDwHWsW3s2SvIFYCPMuZ27nA6+DGDM
         If6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Aq6ffAocVRk2ZcWszPTKjr8Npi5WMgE905LQBVlYd7E=;
        b=TO0xB3A7MYHgcXPBSgQWhl5WEUs0bl7PLO7SGttzFSgQMtKYPAfLopOUeTOYrnxwzn
         rSM5p+Nr9p4cb2Awi1H60sPwkOuXQVJT2pHO6EDKKD8y/RwzOw4g+Be2KnAn5orZyTiw
         VvbxNX7lW1xcTGJNIGN7hr7FTx3J0gSNni5vQaq9yUOyq+OKlPGqmRW5ypj5bBEWF9US
         cxeGrTIj43LgpPesEA3X9M5/lzDkacJ+P6crk2Nhm01NDWDPNMYZY0mihqM0sqp5T1J3
         3GFjBI1CBNpSseCpbhJR9gVUNa690jNop3dNW0+YXPk7za0MN/rLN35H1+8T93QVvQ+P
         D54w==
X-Gm-Message-State: AO0yUKXVqCkLdjzAVAgyZW7u7Id08M6RSWVACmwoOmcJ2jGGDpT+CLtW
        D2hZNpVk1e2RcAk90E2mcjpM0A==
X-Google-Smtp-Source: AK7set9tfhgLpxzRPC95cbtbaqXS1WlbdQ3RvksOWz3D+C6j8rvGMTruKsVCMv9jX8VEWAt9XjOFDg==
X-Received: by 2002:a17:903:11c3:b0:195:e2cc:6f35 with SMTP id q3-20020a17090311c300b00195e2cc6f35mr10002950plh.59.1675922574628;
        Wed, 08 Feb 2023 22:02:54 -0800 (PST)
Received: from [10.3.144.50] ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709026b8b00b001992b8cf89bsm511872plk.16.2023.02.08.22.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 22:02:54 -0800 (PST)
Message-ID: <4a8f370a-4dcc-993c-a1fd-5f87e11c5a87@bytedance.com>
Date:   Thu, 9 Feb 2023 14:02:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/4] erofs: unify anonymous inodes for blob
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        zhujia.zj@bytedance.com
References: <20230209051838.33297-1-jefflexu@linux.alibaba.com>
 <20230209051838.33297-5-jefflexu@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20230209051838.33297-5-jefflexu@linux.alibaba.com>
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



在 2023/2/9 13:18, Jingbo Xu 写道:
> Currently there're two anonymous inodes (inode and anon_inode in struct
> erofs_fscache) for each blob.  The former was introduced as the
> address_space of page cache for bootstrap.
> 
> The latter was initially introduced as both the address_space of page
> cache and also a sentinel in the shared domain.  Since now the management
> of cookies in share domain has been decoupled with the anonymous inode,
> there's no need to maintain an extra anonymous inode.  Let's unify these
> two anonymous inodes.
> 
> Besides, in non-share-domain mode only bootstrap will allocate anonymous
> inode.  To simplify the implementation, always allocate anonymous inode
> for both bootstrap and data blobs.  Similarly release anonymous inodes
> for data blobs when .put_super() is called, or we'll get "VFS: Busy
> inodes after unmount." warning.
> 
> Also remove the redundant set_nlink() when initializing the anonymous
> inode, since i_nlink has already been initialized to 1 when the inode
> gets allocated.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/erofs/fscache.c  | 85 ++++++++++++++++++---------------------------
>   fs/erofs/internal.h |  7 ++--
>   fs/erofs/super.c    |  2 ++
>   3 files changed, 38 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index a6f030966147..a9498239163a 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -422,14 +422,14 @@ static int erofs_fscache_register_domain(struct super_block *sb)
>   	return err;
>   }
>   
> -static
> -struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
> -						   char *name,
> -						   unsigned int flags)
> +static struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
> +						char *name, unsigned int flags)
>   {
>   	struct fscache_volume *volume = EROFS_SB(sb)->volume;
>   	struct erofs_fscache *ctx;
>   	struct fscache_cookie *cookie;
> +	struct super_block *isb;
> +	struct inode *inode;
>   	int ret;
>   
>   	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> @@ -445,33 +445,32 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
>   		ret = -EINVAL;
>   		goto err;
>   	}
> -
>   	fscache_use_cookie(cookie, false);
> -	ctx->cookie = cookie;
> -
> -	if (flags & EROFS_REG_COOKIE_NEED_INODE) {
> -		struct inode *const inode = new_inode(sb);
> -
> -		if (!inode) {
> -			erofs_err(sb, "failed to get anon inode for %s", name);
> -			ret = -ENOMEM;
> -			goto err_cookie;
> -		}
> -
> -		set_nlink(inode, 1);
> -		inode->i_size = OFFSET_MAX;
> -		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
> -		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> -		inode->i_private = ctx;
>   
> -		ctx->inode = inode;
> +	/*
> +	 * Allocate anonymous inode in global pseudo mount for shareable blobs,
> +	 * so that they are accessible among erofs fs instances.
> +	 */
> +	isb = flags & EROFS_REG_COOKIE_SHARE ? erofs_pseudo_mnt->mnt_sb : sb;
> +	inode = new_inode(isb);
> +	if (!inode) {
> +		erofs_err(sb, "failed to get anon inode for %s", name);
> +		ret = -ENOMEM;
> +		goto err_cookie;
>   	}
>   
> +	inode->i_size = OFFSET_MAX;
> +	inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
> +	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> +	inode->i_private = ctx;
> +
> +	ctx->cookie = cookie;
> +	ctx->inode = inode;
>   	return ctx;
>   
>   err_cookie:
> -	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
> -	fscache_relinquish_cookie(ctx->cookie, false);
> +	fscache_unuse_cookie(cookie, NULL, NULL);
> +	fscache_relinquish_cookie(cookie, false);
>   err:
>   	kfree(ctx);
>   	return ERR_PTR(ret);
> @@ -482,18 +481,13 @@ static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
>   	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
>   	fscache_relinquish_cookie(ctx->cookie, false);
>   	iput(ctx->inode);
> -	iput(ctx->anon_inode);
>   	kfree(ctx->name);
>   	kfree(ctx);
>   }
>   
> -static
> -struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
> -						       char *name,
> -						       unsigned int flags)
> +static struct erofs_fscache *erofs_domain_init_cookie(struct super_block *sb,
> +						char *name, unsigned int flags)
>   {
> -	int err;
> -	struct inode *inode;
>   	struct erofs_fscache *ctx;
>   	struct erofs_domain *domain = EROFS_SB(sb)->domain;
>   
> @@ -503,35 +497,23 @@ struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
>   
>   	ctx->name = kstrdup(name, GFP_KERNEL);
>   	if (!ctx->name) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> -
> -	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
> -	if (!inode) {
> -		err = -ENOMEM;
> -		goto out;
> +		erofs_fscache_relinquish_cookie(ctx);
> +		return ERR_PTR(-ENOMEM);
>   	}
>   
> +	refcount_inc(&domain->ref);
>   	ctx->domain = domain;
> -	ctx->anon_inode = inode;
>   	list_add(&ctx->node, &erofs_domain_cookies_list);
> -	inode->i_private = ctx;
> -	refcount_inc(&domain->ref);
>   	return ctx;
> -out:
> -	erofs_fscache_relinquish_cookie(ctx);
> -	return ERR_PTR(err);
>   }
>   
> -static
> -struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
> -						   char *name,
> -						   unsigned int flags)
> +static struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
> +						char *name, unsigned int flags)
>   {
>   	struct erofs_fscache *ctx;
>   	struct erofs_domain *domain = EROFS_SB(sb)->domain;
>   
> +	flags |= EROFS_REG_COOKIE_SHARE;
>   	mutex_lock(&erofs_domain_cookies_lock);
>   	list_for_each_entry(ctx, &erofs_domain_cookies_list, node) {
>   		if (ctx->domain != domain || strcmp(ctx->name, name))
> @@ -546,7 +528,7 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>   		mutex_unlock(&erofs_domain_cookies_lock);
>   		return ctx;
>   	}
> -	ctx = erofs_fscache_domain_init_cookie(sb, name, flags);
> +	ctx = erofs_domain_init_cookie(sb, name, flags);
>   	mutex_unlock(&erofs_domain_cookies_lock);
>   	return ctx;
>   }
> @@ -585,7 +567,7 @@ int erofs_fscache_register_fs(struct super_block *sb)
>   	int ret;
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   	struct erofs_fscache *fscache;
> -	unsigned int flags;
> +	unsigned int flags = 0;
>   
>   	if (sbi->domain_id)
>   		ret = erofs_fscache_register_domain(sb);
> @@ -604,7 +586,6 @@ int erofs_fscache_register_fs(struct super_block *sb)
>   	 *
>   	 * Acquired domain/volume will be relinquished in kill_sb() on error.
>   	 */
> -	flags = EROFS_REG_COOKIE_NEED_INODE;
>   	if (sbi->domain_id)
>   		flags |= EROFS_REG_COOKIE_NEED_NOEXIST;
>   	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, flags);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 8358cf5f731e..50cd257d04e3 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -107,8 +107,7 @@ struct erofs_domain {
>   
>   struct erofs_fscache {
>   	struct fscache_cookie *cookie;
> -	struct inode *inode;
> -	struct inode *anon_inode;
> +	struct inode *inode;	/* anonymous indoe for the blob */
>   
>   	/* used for share domain mode */
>   	struct erofs_domain *domain;
> @@ -450,8 +449,8 @@ extern const struct file_operations erofs_dir_fops;
>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>   
>   /* flags for erofs_fscache_register_cookie() */
> -#define EROFS_REG_COOKIE_NEED_INODE	1
> -#define EROFS_REG_COOKIE_NEED_NOEXIST	2
> +#define EROFS_REG_COOKIE_SHARE		0x0001
> +#define EROFS_REG_COOKIE_NEED_NOEXIST	0x0002
>   
>   void erofs_unmap_metabuf(struct erofs_buf *buf);
>   void erofs_put_metabuf(struct erofs_buf *buf);
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 715efa94eed4..19b1ae79cec4 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -968,6 +968,8 @@ static void erofs_put_super(struct super_block *sb)
>   	iput(sbi->packed_inode);
>   	sbi->packed_inode = NULL;
>   #endif
> +	erofs_free_dev_context(sbi->devs);
> +	sbi->devs = NULL;
>   	erofs_fscache_unregister_fs(sb);
>   }
>   
