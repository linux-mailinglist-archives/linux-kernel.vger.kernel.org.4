Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E6E6005A3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiJQDPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiJQDPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:15:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5850015738
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:15:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gf8so9781839pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yjvq6ezitsrSNTf32OzUxI3sqOLN/GKGXF5ya2pTxI=;
        b=zzva/m9mkPAow1cTOKd0/1bN6IXydDAidItnSBz64dBJGx3AiZmzDKfDJ8ds0zhF08
         nc3ZqgByhUstI9PV3SZ3JQfhQLgiSVrsZBJx/Tgy+MBvdMvL1vYQPtnd/Kjy5Kj6wjX4
         4Zf6ngwEIHYPr5y6lgmGGv3dWC+L5oUnSgcuC7+wStwi38zrAMea/Xc5Ku3mfti2uG8W
         Hvp4QyioIjxrKLCziAd2eSJc7HKDqfl+1MpcvlxRGeFu6DkZwFA6eZERFt514EuOWpWP
         WD0CDKIxMiRf2Osd8sWqVZhl6cOtJmC0/mCNQRjP23LfRCmINnEEdwW6ljnunNjDQw/w
         o1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2yjvq6ezitsrSNTf32OzUxI3sqOLN/GKGXF5ya2pTxI=;
        b=UFgQVzj5IPux+gyQzN3+0iPsIOPBFcwEqCvEaNkT5vIpjLeDB4cSnWEv8pWYyKiLes
         3mGyPwVx7thwzXb6F00WGhYINGeN6WHy9ezaR0DcxW2x4KwglpI/kNmJxV3PMalVbiSN
         DM7pXqsmQ0mt9iAqn4A8XyQQv2XQCihgl9BRlEzC3OEkGKqavu31PUBm5ENFUlTbSePH
         LnrjG+J6h6/v5qEWDHKYG59Z/TTJXpFl+wDZEfGbNs9W9HuzEWnKPhnn3CFmBdt0qWKD
         8AynT3pW47p+mrzaE5/uuyavwyslaAkspFuDXubBbP0jdZ1Fk3wU51lXQ1oqwI+M53NT
         q6IA==
X-Gm-Message-State: ACrzQf10lRp/eZEDS/oreT+dWL7YtaQN5rmSTc5BN7ZZ0w6aEoD+XmF9
        YGx6LNV9+iKzKRDYFAKqzkIJ0A==
X-Google-Smtp-Source: AMsMyM4d/EMY4URnAhNGwukqPgoOU94si0M55eodhKPC+1e8j+6xryVsz0EEtEF11YBnHEoP9JhoqA==
X-Received: by 2002:a17:90b:19d0:b0:20b:1d66:8a17 with SMTP id nm16-20020a17090b19d000b0020b1d668a17mr11431532pjb.2.1665976498701;
        Sun, 16 Oct 2022 20:14:58 -0700 (PDT)
Received: from [10.3.156.122] ([63.216.146.185])
        by smtp.gmail.com with ESMTPSA id oj5-20020a17090b4d8500b001f262f6f717sm8918341pjb.3.2022.10.16.20.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 20:14:58 -0700 (PDT)
Message-ID: <80e1f65f-e051-adbf-946f-ef2a27ff55f9@bytedance.com>
Date:   Mon, 17 Oct 2022 11:14:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [External] [PATCH v2] erofs: protect s_inodes with
 s_inode_list_lock
To:     Dawei Li <set_pte_at@outlook.com>, xiang@kernel.org,
        chao@kernel.org
Cc:     huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
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



在 2022/10/17 09:55, Dawei Li 写道:
> s_inodes is superblock-specific resource, which should be
> protected by sb's specific lock s_inode_list_lock.
> 
> v2: update the locking mechanisim to protect mutual-exclusive access
> both for s_inode_list_lock & erofs_fscache_domain_init_cookie(), as the
> reviewing comments from Jia Zhu.
> 
> v1: https://lore.kernel.org/all/TYCP286MB23237A9993E0FFCFE5C2BDBECA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
> 
> base-commit: 8436c4a57bd147b0bd2943ab499bb8368981b9e1
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>   fs/erofs/fscache.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 998cd26a1b3b..fe05bc51f9f2 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -590,14 +590,17 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>   	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
>   
>   	mutex_lock(&erofs_domain_cookies_lock);
> +	spin_lock(&psb->s_inode_list_lock);
>   	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
>   		ctx = inode->i_private;
>   		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
>   			continue;
>   		igrab(inode);
> +		spin_unlock(&psb->s_inode_list_lock);
>   		mutex_unlock(&erofs_domain_cookies_lock);
>   		return ctx;
>   	}
> +	spin_unlock(&psb->s_inode_list_lock);
>   	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
>   	mutex_unlock(&erofs_domain_cookies_lock);
>   	return ctx;
LGTM
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
