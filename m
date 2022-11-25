Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11CC638529
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKYIZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKYIZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:25:32 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ABD303FC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:25:26 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id a1-20020a17090abe0100b00218a7df7789so7034040pjs.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ckKGwJItp+SltDNJaOjW/8VjFs3SCiZgPtFRo/FP9A=;
        b=gmolE/ImKu/yWiNnyFdSYS1Qa+yIv3Ra1VJ94E4GdV/YSUN7GGX0NoxF5QG0TiILQp
         vqU18uGlSPApxRR+axXg3tYEBWFKIwcmRoUslhH+xVEQVHG86FsXz3985viy+1Qt+zjX
         NI8BVa2HKD5lNi6cs02soxlum1kzdQeQheQIE2wMcM8XDmG69JKug4D3h67AKMvEDw8/
         11GP7bV4RNltvOXmoGAvIBXTsAz637h/hg+ZOQwaMTSEkN5sNHQ1n6P6j7U1z+mokWLR
         HpUBnL7xV8mX2Et2AAzoFzGtavg9PYoiOiydU5Xa7gs6CSG/pqLUDubyrWhSNzmlt3l9
         7yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ckKGwJItp+SltDNJaOjW/8VjFs3SCiZgPtFRo/FP9A=;
        b=2wFEX0fJ2Ms17hSJc7PRnkS5NtF4pMn4FYFsJVtf0wXmHIy2NLsb+7T4wCqp2+MIE7
         ygvBC00TFw5vfxHxBs44CI7HLvBbgDAP88KXndH25Z777xw6CQa0urCGYK1HYO1NmdlT
         0hOIGTomBMhYio+N43QzbVPmt3NGjJ2w9tL9Dio4Jm2z+/ngSFgbemreV6wUF2yCMaID
         SUTBgLWx4pn5BwDDuqkr8P63k30+4L1BtfRu2jG8EqNVroyYrOnUUTpwPlf5w2QRo50Y
         1Rct59TDybvNts1MVKBz4De8AMAP+kD5XP71OS0uiw3aMVKSj/AQobTQfDH+tj8IknPT
         sbRQ==
X-Gm-Message-State: ANoB5pl0ONwaDcwGnpFePiLjsUUOl8JL6DnEazAgIPTXZ+ERQCZF8OHs
        TCz1DwLsXxSa55+sFu3+8Amc3g==
X-Google-Smtp-Source: AA0mqf7lOPP1H9YCm6gBWQZbay2BLn6IZn5uQwQw/6gUonIRDHrlYSWowCxVjDTsL4CpDCsSbCsPww==
X-Received: by 2002:a17:902:cf02:b0:186:c372:72d6 with SMTP id i2-20020a170902cf0200b00186c37272d6mr30249980plg.25.1669364725504;
        Fri, 25 Nov 2022 00:25:25 -0800 (PST)
Received: from [10.4.233.38] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id q2-20020a63cc42000000b0047712e4bc51sm2158828pgi.55.2022.11.25.00.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:25:25 -0800 (PST)
Message-ID: <49b2b8e4-39d0-983c-23c6-f18232a7dff3@bytedance.com>
Date:   Fri, 25 Nov 2022 16:25:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [External] [PATCH] erofs: check the uniqueness of fsid in shared
 domain in advance
To:     Hou Tao <houtao@huaweicloud.com>, linux-erofs@lists.ozlabs.org
Cc:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, houtao1@huawei.com,
        linux-kernel@vger.kernel.org
References: <20221125074057.2229083-1-houtao@huaweicloud.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20221125074057.2229083-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,
We've noticed this warning during development. It seems not a bug, so
I ignored that.
Many thanks for cacthing and clearing up the annoying warning.

在 2022/11/25 15:40, Hou Tao 写道:
> From: Hou Tao <houtao1@huawei.com>
> 
> When shared domain is enabled, doing mount twice with the same fsid and
> domain_id will trigger sysfs warning as shown below:
> 
>   sysfs: cannot create duplicate filename '/fs/erofs/d0,meta.bin'
>   CPU: 15 PID: 1051 Comm: mount Not tainted 6.1.0-rc6+ #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x38/0x49
>    dump_stack+0x10/0x12
>    sysfs_warn_dup.cold+0x17/0x27
>    sysfs_create_dir_ns+0xb8/0xd0
>    kobject_add_internal+0xb1/0x240
>    kobject_init_and_add+0x71/0xa0
>    erofs_register_sysfs+0x89/0x110
>    erofs_fc_fill_super+0x98c/0xaf0
>    vfs_get_super+0x7d/0x100
>    get_tree_nodev+0x16/0x20
>    erofs_fc_get_tree+0x20/0x30
>    vfs_get_tree+0x24/0xb0
>    path_mount+0x2fa/0xa90
>    do_mount+0x7c/0xa0
>    __x64_sys_mount+0x8b/0xe0
>    do_syscall_64+0x30/0x60
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> The reason is erofs_fscache_register_cookie() doesn't guarantee the primary
> data blob (aka fsid) is unique in the shared domain and
> erofs_register_sysfs() invoked by the second mount will fail due to the
> duplicated fsid in the shared domain and report warning.
> 
> It would be better to check the uniqueness of fsid before doing
> erofs_register_sysfs(), so adding a new flags parameter for
> erofs_fscache_register_cookie() and doing the uniqueness check if
> EROFS_REG_COOKIE_NEED_NOEXIST is enabled.
> 
> After the patch, the error in dmesg for the duplicated mount would be:
> 
>   erofs: ...: erofs_domain_register_cookie: XX already exists in domain YY
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   fs/erofs/fscache.c  | 47 +++++++++++++++++++++++++++++++++------------
>   fs/erofs/internal.h | 10 ++++++++--
>   fs/erofs/super.c    |  2 +-
>   3 files changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index af5ed6b9c54d..6a792a513d6b 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -494,7 +494,8 @@ static int erofs_fscache_register_domain(struct super_block *sb)
>   
>   static
>   struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
> -						    char *name, bool need_inode)
> +						   char *name,
> +						   unsigned int flags)
>   {
>   	struct fscache_volume *volume = EROFS_SB(sb)->volume;
>   	struct erofs_fscache *ctx;
> @@ -516,7 +517,7 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
>   	fscache_use_cookie(cookie, false);
>   	ctx->cookie = cookie;
>   
> -	if (need_inode) {
> +	if (flags & EROFS_REG_COOKIE_NEED_INODE) {
>   		struct inode *const inode = new_inode(sb);
>   
>   		if (!inode) {
> @@ -554,14 +555,15 @@ static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
>   
>   static
>   struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
> -		char *name, bool need_inode)
> +						       char *name,
> +						       unsigned int flags)
>   {
>   	int err;
>   	struct inode *inode;
>   	struct erofs_fscache *ctx;
>   	struct erofs_domain *domain = EROFS_SB(sb)->domain;
>   
> -	ctx = erofs_fscache_acquire_cookie(sb, name, need_inode);
> +	ctx = erofs_fscache_acquire_cookie(sb, name, flags);
>   	if (IS_ERR(ctx))
>   		return ctx;
>   
> @@ -589,7 +591,8 @@ struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
>   
>   static
>   struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
> -						   char *name, bool need_inode)
> +						   char *name,
> +						   unsigned int flags)
>   {
>   	struct inode *inode;
>   	struct erofs_fscache *ctx;
> @@ -602,23 +605,30 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>   		ctx = inode->i_private;
>   		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
>   			continue;
> -		igrab(inode);
> +		if (!(flags & EROFS_REG_COOKIE_NEED_NOEXIST)) {
> +			igrab(inode);
> +		} else {
> +			erofs_err(sb, "%s already exists in domain %s", name,
> +				  domain->domain_id);
> +			ctx = ERR_PTR(-EEXIST);
> +		}
>   		spin_unlock(&psb->s_inode_list_lock);
>   		mutex_unlock(&erofs_domain_cookies_lock);
>   		return ctx;
>   	}
>   	spin_unlock(&psb->s_inode_list_lock);
> -	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
> +	ctx = erofs_fscache_domain_init_cookie(sb, name, flags);
>   	mutex_unlock(&erofs_domain_cookies_lock);
>   	return ctx;
>   }
>   
>   struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -						    char *name, bool need_inode)
> +						    char *name,
> +						    unsigned int flags)
>   {
>   	if (EROFS_SB(sb)->domain_id)
> -		return erofs_domain_register_cookie(sb, name, need_inode);
> -	return erofs_fscache_acquire_cookie(sb, name, need_inode);
> +		return erofs_domain_register_cookie(sb, name, flags);
> +	return erofs_fscache_acquire_cookie(sb, name, flags);
>   }
>   
>   void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
> @@ -647,6 +657,7 @@ int erofs_fscache_register_fs(struct super_block *sb)
>   	int ret;
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   	struct erofs_fscache *fscache;
> +	unsigned int flags;
>   
>   	if (sbi->domain_id)
>   		ret = erofs_fscache_register_domain(sb);
> @@ -655,8 +666,20 @@ int erofs_fscache_register_fs(struct super_block *sb)
>   	if (ret)
>   		return ret;
>   
> -	/* acquired domain/volume will be relinquished in kill_sb() on error */
> -	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, true);
> +	/*
> +	 * When shared domain is enabled, using NEED_NOEXIST to guarantee
> +	 * the primary data blob (aka fsid) is unique in the shared domain.
> +	 *
> +	 * For non-shared-domain case, fscache_acquire_volume() invoked by
> +	 * erofs_fscache_register_volume() has already guaranteed
> +	 * the uniqueness of primary data blob.
> +	 *
> +	 * Acquired domain/volume will be relinquished in kill_sb() on error.
> +	 */
> +	flags = EROFS_REG_COOKIE_NEED_INODE;
> +	if (sbi->domain_id)
> +		flags |= EROFS_REG_COOKIE_NEED_NOEXIST;
> +	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, flags);
>   	if (IS_ERR(fscache))
>   		return PTR_ERR(fscache);
>   
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 05dc68627722..a5f8c8fcdd17 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -604,13 +604,18 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
>   }
>   #endif	/* !CONFIG_EROFS_FS_ZIP */
>   
> +/* flags for erofs_fscache_register_cookie() */
> +#define EROFS_REG_COOKIE_NEED_INODE 1
> +#define EROFS_REG_COOKIE_NEED_NOEXIST 2
How about using TAB to align the columns?
Apart from this, LGTM.
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Thanks.
> +
>   /* fscache.c */
>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>   int erofs_fscache_register_fs(struct super_block *sb);
>   void erofs_fscache_unregister_fs(struct super_block *sb);
>   
>   struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -						     char *name, bool need_inode);
> +						    char *name,
> +						    unsigned int flags);
>   void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
>   
>   extern const struct address_space_operations erofs_fscache_access_aops;
> @@ -623,7 +628,8 @@ static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
>   
>   static inline
>   struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -						     char *name, bool need_inode)
> +						     char *name,
> +						     unsigned int flags)
>   {
>   	return ERR_PTR(-EOPNOTSUPP);
>   }
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 1c7dcca702b3..481788c24a68 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -245,7 +245,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   	}
>   
>   	if (erofs_is_fscache_mode(sb)) {
> -		fscache = erofs_fscache_register_cookie(sb, dif->path, false);
> +		fscache = erofs_fscache_register_cookie(sb, dif->path, 0);
>   		if (IS_ERR(fscache))
>   			return PTR_ERR(fscache);
>   		dif->fscache = fscache;
