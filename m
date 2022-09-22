Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBBB5E6FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiIVWqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIVWqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:46:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CBBEFF75
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:46:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso1708585wmk.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ltYapkC4HEBqKjWDViSVjlQMW2DX4S8eveyX3l0P/5c=;
        b=G9W6En7uyuKdNbxwzw6cBEYBnJzigpgiRDHcQLoIBzimpoUBp/JwfY4Atk0L7QlkXL
         i1UaV/K5F5qcv/B4fPMbems6DwV/bFs5KqJWwPw9bHJqtFBqtCZMga7gTVFC6Lvryu7V
         uneDBbV0quDX7i5cC3pFQDUQIayQ/eybZ5FQQuVJFO8d/xTPyKrcgqliqBqy3lVLgpNz
         EczuxYDt4NZ0p4QjOA7JSY4YVEQov+S5insBwLbmmwThDRzvL7fB9bBPlmBozeqhRFBX
         gVkoKuL7eWTqSKBo+ay7ETLyeTP2GWrk0j18Fhs4ex/p6rqWXYvP8CCaAXoNXTM7xkUG
         n22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ltYapkC4HEBqKjWDViSVjlQMW2DX4S8eveyX3l0P/5c=;
        b=jE2OJQGMFmx35YYNfaLDhd784QhrhrT4W0CCljdLiB2NElI3V1Z6WxMjFyLeCS5nbY
         oDTcboQ3E6FkpF4MGn9MjLDkoktv0t3cC3wa1Z1cyX1/J8tK2iD0vcc9AiaCxbmvBz50
         eoXPjz1mu7inTBNNek+Iubk/3fJuvTFUi4eDZ5tPY+tzdIO5mlOxmyzKJ+A75Gd2n771
         GX4cp1XbG007ctvoHu5zZNntc+raJL8RbZsJJV6syglUZzTiMVZyKW+QcGukxkHKqsH9
         BfUg+kMZl1x5B9+VsfpLlPm3bOW4loUVzK34QZqovC2CVFCJJFJe3WL8tWnyUDkIcilS
         9qSw==
X-Gm-Message-State: ACrzQf0GTYunjh0QaAWkUa1bg3787JyFmKaBvMbPNoXn3Pog7AJ3RsBF
        seXQZFB2DhV6+c+ZJHTxn01x1Q==
X-Google-Smtp-Source: AMsMyM6UtONCf1PBYt31tN03JHyVUgivr2gCgw/qVochMXs9/wGLnXQvd7RyJGYB49cW7AtCJzKshQ==
X-Received: by 2002:a05:600c:198d:b0:3b4:b6b6:6fa with SMTP id t13-20020a05600c198d00b003b4b6b606famr11039067wmq.110.1663886794380;
        Thu, 22 Sep 2022 15:46:34 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id l20-20020a05600c089400b003a845621c5bsm661523wmp.34.2022.09.22.15.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 15:46:33 -0700 (PDT)
Message-ID: <e4bd1b5c-2676-3cd7-db3b-1f34a305e9ec@linaro.org>
Date:   Thu, 22 Sep 2022 23:46:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] misc: fastrpc: Fix use-after-free and race in
 fastrpc_map_find
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ola Jeppsson <ola@snap.com>
References: <20220902151423.3351414-1-abel.vesa@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220902151423.3351414-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/2022 16:14, Abel Vesa wrote:
> Currently, there is a race window between the point when the mutex is
> unlocked in fastrpc_map_lookup and the reference count increasing
> (fastrpc_map_get) in fastrpc_map_find, which can also lead to
> use-after-free.
> 
> So lets merge fastrpc_map_find into fastrpc_map_lookup which allows us
> to both protect the maps list by also taking the &fl->lock spinlock and
> the reference count, since the spinlock will be released only after.
> Add take_ref argument to make this suitable for all callers.
> 
> Fixes: 8f6c1d8c4f0c ("misc: fastrpc: Add fdlist implementation")
> Co-developed-by: Ola Jeppsson <ola@snap.com>
> Signed-off-by: Ola Jeppsson <ola@snap.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   drivers/misc/fastrpc.c | 41 +++++++++++++++++++++--------------------
>   1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 93ebd174d848..0c816a11eeec 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -333,30 +333,31 @@ static void fastrpc_map_get(struct fastrpc_map *map)
>   
>   
>   static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
> -			    struct fastrpc_map **ppmap)
> +			    struct fastrpc_map **ppmap, bool take_ref)
>   {
> +	struct fastrpc_session_ctx *sess = fl->sctx;
>   	struct fastrpc_map *map = NULL;
> +	int ret = -ENOENT;
>   
> -	mutex_lock(&fl->mutex);
> +	spin_lock(&fl->lock);
>   	list_for_each_entry(map, &fl->maps, node) {
> -		if (map->fd == fd) {
> -			*ppmap = map;
> -			mutex_unlock(&fl->mutex);
> -			return 0;
> -		}
> -	}
> -	mutex_unlock(&fl->mutex);
> -
> -	return -ENOENT;
> -}
> +		if (map->fd != fd)
> +			continue;
>   
> -static int fastrpc_map_find(struct fastrpc_user *fl, int fd,
> -			    struct fastrpc_map **ppmap)
> -{
> -	int ret = fastrpc_map_lookup(fl, fd, ppmap);
> +		if (take_ref) {
> +			ret = fastrpc_map_get(map);
> +			if (ret) {
> +				dev_dbg(sess->dev, "%s: Failed to get map fd=%d ret=%d\n",
> +					__func__, fd, ret);
> +				break;
> +			}
> +		}
>   
> -	if (!ret)
> -		fastrpc_map_get(*ppmap);
> +		*ppmap = map;
> +		ret = 0;
> +		break;
> +	}
> +	spin_unlock(&fl->lock);
>   
>   	return ret;
>   }
> @@ -703,7 +704,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
>   	struct fastrpc_map *map = NULL;
>   	int err = 0;
>   
> -	if (!fastrpc_map_find(fl, fd, ppmap))
> +	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
>   		return 0;
>   
>   	map = kzalloc(sizeof(*map), GFP_KERNEL);
> @@ -1026,7 +1027,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>   	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
>   		if (!fdlist[i])
>   			break;
> -		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap))
> +		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
>   			fastrpc_map_put(mmap);
>   	}
>   
