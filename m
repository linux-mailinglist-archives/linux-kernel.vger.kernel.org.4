Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8F7600060
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJPPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJPPFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:05:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E0641D2B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:05:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 67so8998416pfz.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmYYl0FFmCnwl0KsAmJQDcMF16Y99ygtOLlyuQkR5oE=;
        b=OYCMy3DFE7lVaXiyI5ZELZyEyVfycxTpeZSGDZSa9y0ewZxOjzgMOWmV+dGt4hkdhA
         XNZVEo4AiCpeAUyVvJjI9Bqd7R2l95HmVPRKN/I1JpQgL2l4xdKd8+YcJfN1xK/8+hy8
         wo+sqiWSjwemvjeHIM7p/ju4Oj2x87roDMDysen2ylOQe/1tYMTrJGlJx8H7a4t9lS2i
         rtJYiH0nSDAGbOU93UCDifsEcSA4K/KFRpTT6YIn1ue1fNNVaPmnsuxWryHV6p0ohD6O
         HxnyhoZZHJY3a8OQOYuPBba4S/07m4FQwaIKkHu00xa5/wyHX6Xt5K8OcWqN5uoFkQrB
         TQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dmYYl0FFmCnwl0KsAmJQDcMF16Y99ygtOLlyuQkR5oE=;
        b=tl+SpAW2Bnnmj85xBl8E3p0ucVQZDIlawEb5U3yWqKRBoe35sXH1nVPEFWgG4vz7DU
         KiIfA68o/UvmozKF2j+dUmLVjL4b+YHy0VchDI9OVbjrDv4jcnTfUUpVtjoE9ATfzgUT
         yJVR/CqvxlumoreIXZMSwCdwgQU1JJi7IQ9UnYoVbps2QIqzL7nXnKFFwVOAnoO68mG3
         iDU7OsFvmiEcMpEXnn4wLaZfx5OB1bkEbVgAlcfygu8QFTVcCGtJz2a73Pj4yc/Jy7m6
         Wbg50F0uZxlNFgcFqWrFXb3NKdJk7eJVwxcieGSu7N61E0meDreATF/LHdeZcBf4qZFe
         ZWTw==
X-Gm-Message-State: ACrzQf0Z1gJDQlHMYY3VUvq7X/wVBUA8DVIh/Q/wu6O9yVRkfNOdvcH9
        UFArV6fkQOpxZUS8Y/ti/itlGw==
X-Google-Smtp-Source: AMsMyM4oey+NsfzkhAme+/KRCBVrkUHGqTIbG+ul3+f8FjK+gmTZXT9d5fudwDd8RYSRCsBB5ru34w==
X-Received: by 2002:a05:6a00:1a07:b0:541:6060:705d with SMTP id g7-20020a056a001a0700b005416060705dmr7983085pfv.61.1665932744304;
        Sun, 16 Oct 2022 08:05:44 -0700 (PDT)
Received: from [10.254.211.51] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id i6-20020a628706000000b00553b37c7732sm5125757pfe.105.2022.10.16.08.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 08:05:43 -0700 (PDT)
Message-ID: <4fc164e8-f307-0217-3977-39f3fa412a21@bytedance.com>
Date:   Sun, 16 Oct 2022 23:05:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [External] [PATCH] erofs: protect s_inodes with s_inode_list_lock
To:     Dawei Li <set_pte_at@outlook.com>, xiang@kernel.org,
        chao@kernel.org
Cc:     huyue2@coolpad.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, zhujia.zj@bytedance.com
References: <TYCP286MB23237A9993E0FFCFE5C2BDBECA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <TYCP286MB23237A9993E0FFCFE5C2BDBECA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
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

在 2022/10/16 20:37, Dawei Li 写道:
> s_inodes is superblock-specific resource, which should be
> protected by sb's specific lock s_inode_list_lock.
>  > base-commit: 8436c4a57bd147b0bd2943ab499bb8368981b9e1
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>   fs/erofs/fscache.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 998cd26a1b3b..bbf5268440df 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -589,15 +589,18 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>   	struct erofs_domain *domain = EROFS_SB(sb)->domain;
>   	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
>   
> -	mutex_lock(&erofs_domain_cookies_lock);
Hi Dawei,
Thanks for catching this.

I would suggest holding this mutex lock during inode searches and
inserts to avoid the following case:

P1				P2
lock inode_list lock
traverse sb->s_inodes
unlock inode_list lock
				lock inode_list
				traverse sb->s_inodes
				unlock inode_list
				domain_init_cookie
domain_init_cookie

Thanks,
Jia
> +	spin_lock(&psb->s_inode_list_lock);
>   	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
>   		ctx = inode->i_private;
>   		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
>   			continue;
>   		igrab(inode);
> -		mutex_unlock(&erofs_domain_cookies_lock);
> +		spin_unlock(&psb->s_inode_list_lock);
>   		return ctx;
>   	}
> +	spin_unlock(&psb->s_inode_list_lock);
> +
> +	mutex_lock(&erofs_domain_cookies_lock);
>   	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
>   	mutex_unlock(&erofs_domain_cookies_lock);
>   	return ctx;
