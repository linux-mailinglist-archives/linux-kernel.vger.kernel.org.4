Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EE3658B37
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiL2Jta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiL2JrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:47:02 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D79113B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:45:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso12862429wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JlwudR1yq0j8l6dXe2FNX5uZ434yQGNV8t9LPJL/6tM=;
        b=nUHwdBrBS6LeYbs+YS3gdxxv7I3AORr8iVEX+sIMxjgK+nNK2hcm/m+/NZyGz55W4m
         /2WiPf7rALiIl1XNGy8oNlYm3TqHrEVPzEiTZ3vAbqnFGu8msb4hHSMsifMUHYyNlYEv
         yxE42J1SHiOffhA8G4tZzerRzzqj0unHksAtNmudLgbPN6z6KmoxOpU7iaqiNm2hUQKu
         cTy2fPBgJQCZfabMZt1p+wQ6DrToheWRi6o8OKVPf9/NHBFNusYwYRdyMSZvkOjCTo+D
         vAASc9hQuRqsAGS4kON3vXrPQ8HnrkOjkRy+aADHt6hRcORxzbzhyInPK3wrKpze5Z00
         Gb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlwudR1yq0j8l6dXe2FNX5uZ434yQGNV8t9LPJL/6tM=;
        b=IDFLOjpIWzeYpZ1U5Ba0dgPjVD2/n/8etk7AelxyoGrv/WawjvcqoBE5J59pd7eq1T
         jePC6W/12fKg9s721JxDc6RZATq83JYBqqHR1tI7BzBaYpXlsw81wXOqfnruoy5HYXQt
         1lupOLAd9+a6IX/7Z4i9YgBxLgQjR8GRs51iObLpqF3tYMXbvRYJXAnfzB37nSR16eYl
         lUDd3bbzB3kMW+01vjDNl2PYVkRqYRx5+jgnVOedYU+HRWfUxR/GpfwIBLPWhNL0ZQNm
         z6mPwzHmcScVtb90G/1sOherp0F/4DjIqPaDe52BA1+1RZ9/yE4VV3ROCaMzkCa5FuAI
         KCzw==
X-Gm-Message-State: AFqh2kqH0g5KAlWwxB7AqXXBxDTp/TCkEWAyjA009hg4TCr/HWGVUJhx
        pe7O8pXyj8RdmnGpAXg5pAM=
X-Google-Smtp-Source: AMrXdXs5lANX27sWsHHeOuHvhjwBNhps7lPfjmKuE+KRWec7tXPH6Us7T2cE1di2Y7ptz7971G9M7w==
X-Received: by 2002:a1c:5442:0:b0:3cf:7385:677f with SMTP id p2-20020a1c5442000000b003cf7385677fmr19294169wmi.35.1672307114296;
        Thu, 29 Dec 2022 01:45:14 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c354200b003d35acb0fd7sm31043399wmq.34.2022.12.29.01.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 01:45:13 -0800 (PST)
Date:   Thu, 29 Dec 2022 12:45:10 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     yang.yang29@zte.com.cn
Cc:     gustavoars@kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] staging: ks7010: use strscpy() to instead of
 strncpy()
Message-ID: <Y61hpuMcp3NKbqL5@kadam>
References: <202212261903245548969@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212261903245548969@zte.com.cn>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 07:03:24PM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---
>  drivers/staging/ks7010/ks_wlan_net.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
> index 044c807ca022..e03c87f0bfe7 100644
> --- a/drivers/staging/ks7010/ks_wlan_net.c
> +++ b/drivers/staging/ks7010/ks_wlan_net.c
> @@ -382,8 +382,7 @@ static int ks_wlan_get_nick(struct net_device *dev,
>  		return -EPERM;
> 
>  	/* for SLEEP MODE */
> -	strncpy(extra, priv->nick, 16);
> -	extra[16] = '\0';
> +	strscpy(extra, priv->nick, 17);

I think this code is a buffer overflow.  This is an implementation of
SIOCGIWNICKN.

net/wireless/wext-core.c
   169          [IW_IOCTL_IDX(SIOCGIWNICKN)] = {
   170                  .header_type    = IW_HEADER_TYPE_POINT,
   171                  .token_size     = 1,
   172                  .max_tokens     = IW_ESSID_MAX_SIZE,
   173          },

As you can see there is a .max_tokens but no .min_tokens.  It is called
from ioctl_standard_iw_point().  So if the user specifies something
smaller than 17 it leads to a buffer overflow.

Your patch is mechanically correct, but now that we have eyes on the
code we should fix the security bug instead making checkpatch happy or
whatever.

regards,
dan carpenter

