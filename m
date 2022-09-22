Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6DC5E6FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiIVWqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIVWqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:46:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8872EED5D4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:45:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n12so17719780wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZwaWZ9+q930w2Z+D4l4wEUpicPaHvLHUkCpuJVX1lSs=;
        b=HR5h0HlIBivkLeQK9Yn0jmiW7Vwb0hf8HYNLDc8yrJ7nOpCwaRA8CyU6ZXgcPnebDF
         efdvTY/RfguLNjE7JJF/l5xu2JP0LzIY9Tqkacnc9LzSJNzXXTSQnLuol1LDXiWilGNQ
         dWei7JyYxVz6yield0yL0A4HOdfVZJuFBEYM5e0ZtVOOMMC3EJT08Hlmg3rAgL4JnRl9
         wHM47BC/jmf96cwqEpclGC1Rn4Va4sZ8p/aIKKDFR70RAkoAf8KPp6OdiGeNnnTkNKqQ
         v+AlICBwwiLcZoEYkL/xBTW5r5LqoLwcN6+JhZukra4IhXOmFB2ZQPmUmxbtARjnTMbi
         4TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZwaWZ9+q930w2Z+D4l4wEUpicPaHvLHUkCpuJVX1lSs=;
        b=YEZHHP6WrEN9pUigzXMdlAHxTY1obLY01oB+LXqhiB9CQdrwVqUaD1g4D0r8ijwd1W
         DZKxDxz08dLjjN7PKb6GHdO+lUaXeEWPqiD5RWx7uWTFE1CM0OvILTim8nzIG/iIYJCw
         LZTqEALM7KYkwqr7onCGOtnupOv0H3GDP/5iciXAG47A+GbEo52ENIu+NauQ2cE20Nho
         UPAOBc9l5kiHLlHBmplECSM7SZDIlCIx8SjqybdGtbyABkwl2b9bbRoRV1I5DTCxONSO
         It6PWAObE59kIDdhd+4+XL+Vu+DPP231kIbPzQ6O52MuHrLBB2HXV2HD5jqlzMZuYMiQ
         QGjw==
X-Gm-Message-State: ACrzQf1K9WKHAMo/KJJQYYrj4WhgKnFZi4VO0W9LddC0jNHkoWkTpCt7
        aYwzfojDPahf4lE1zQy3UCxdDQ==
X-Google-Smtp-Source: AMsMyM4kXt/hkMYvfjLaYhGwOl8u1b9sWYyTmm5pHqLKx0CcOPnC2oVTU3it/YbHEnOxxxGVRFTUOA==
X-Received: by 2002:adf:fb43:0:b0:22b:64:8414 with SMTP id c3-20020adffb43000000b0022b00648414mr3473116wrs.70.1663886755049;
        Thu, 22 Sep 2022 15:45:55 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id ay16-20020a5d6f10000000b0022af70874a1sm8062356wrb.36.2022.09.22.15.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 15:45:54 -0700 (PDT)
Message-ID: <437a562e-43e5-1c06-10cd-2af81b4ef8fa@linaro.org>
Date:   Thu, 22 Sep 2022 23:45:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] misc: fastrpc: Fix use-after-free race condition for
 maps
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
 <20220902151423.3351414-3-abel.vesa@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220902151423.3351414-3-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/2022 16:14, Abel Vesa wrote:
> From: Ola Jeppsson <ola@snap.com>
> 
> It is possible that in between calling fastrpc_map_get() until
> map->fl->lock is taken in fastrpc_free_map(), another thread can call
> fastrpc_map_lookup() and get a reference to a map that is about to be
> deleted.
> 
yes, there is a margin of window here.
Also am surprised to see the race for same map fd.

fastrpc_map_get() is always under a lock, have you tried adding locking 
for fastrpc_map_put().


> Rewrite fastrpc_map_get() to only increase the reference count of a map
> if it's non-zero. Propagate this to callers so they can know if a map is
> about to be deleted.
This will work but it would be better to fix the window of race.

--srini

> 
> Fixes this warning:
> refcount_t: addition on 0; use-after-free.
> WARNING: CPU: 5 PID: 10100 at lib/refcount.c:25 refcount_warn_saturate
> ...
> Call trace:
>   refcount_warn_saturate
>   [fastrpc_map_get inlined]
>   [fastrpc_map_lookup inlined]
>   fastrpc_map_create
>   fastrpc_internal_invoke
>   fastrpc_device_ioctl
>   __arm64_sys_ioctl
>   invoke_syscall
> 
> Fixes: c68cfb718c8f9 ("misc: fastrpc: Add support for context Invoke method")
> Signed-off-by: Ola Jeppsson <ola@snap.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/misc/fastrpc.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 50c17f5da3a8..58654d394d17 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -332,10 +332,12 @@ static void fastrpc_map_put(struct fastrpc_map *map)
>   		kref_put(&map->refcount, fastrpc_free_map);
>   }
>   
> -static void fastrpc_map_get(struct fastrpc_map *map)
> +static int fastrpc_map_get(struct fastrpc_map *map)
>   {
> -	if (map)
> -		kref_get(&map->refcount);
> +	if (!map)
> +		return -ENOENT;
> +
> +	return kref_get_unless_zero(&map->refcount) ? 0 : -ENOENT;
>   }
>   
>   
