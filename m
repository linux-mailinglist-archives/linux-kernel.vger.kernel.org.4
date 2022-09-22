Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110E65E6FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiIVWqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIVWq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:46:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21EBEEB40
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:46:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id iv17so3071856wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9NBOmFwgDwIdBLiWSI0vBgFaF0v0AI90lxVKJOJ5Ing=;
        b=gIqzT0NTDMVsZAZhX+AYLhrA/sESmquVV0GrhxVDC6enW2fSgXB13bZ5kjxb16gDaW
         UEhKkrc06/3NzeszcAyZSFZCaOsGArqxgY28ce6hz08+RaNK/OUBXvJrS6yQVCK25gEX
         /qXlv4UfMEq755VwRGHAOeYyGj4FmeIe6E5UYO9mdICwyq2BqEGAbPMwN4w7NXk7FlA2
         dEPOC5BDXVYVX7JnJgZAlDVTFfaWvBRsVz3UfK0WQIUCz8HkgDgtAUs9ETtORsIdCAPH
         /RAMjhRHHvF/WYUZ9PjbjkOSUuzQOJ6Dq0+icePqqZs84+FJEZiPSLRuHbP2Q84YBva5
         B5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9NBOmFwgDwIdBLiWSI0vBgFaF0v0AI90lxVKJOJ5Ing=;
        b=DSFpP2tDz5IRNRImmJtTnLi2k4vn9EA6ZpHYCmfBaHEYAsZVjgk1bS3qrnLElhOHK8
         9XLRhyO2flZg9gx6wgt/h/08f8jFol7RgG3FNI/tATKRUdyaH5u29rJT/8Fvw+POXY6r
         vnhDYPAQnUyxz1t1DSrrFBCFq+ti1pfJC/oYyJZMzDv3oCX6Haf4hgxhlFeJyzm4CcnJ
         zV0bc9xjA/HpKs/uXTSZfgfwzA5PF+LzSZnHXSz6hh6IM/+YkWTElplq4VTIWieQsY5Z
         WjTjHYZ0lqEfxGubsOU/9Em7inEg7SRD+pIHfiQ6Y4H+1nADS3th4xU2PkU1VsyexhQi
         QcPQ==
X-Gm-Message-State: ACrzQf2wGX3nWmtGLmBvHQYYsg+52vG7/v29U/2E4HEtaQZQKMUrYcVm
        gtosuQTU6kxJuZ5JoFxIYDOmsQ==
X-Google-Smtp-Source: AMsMyM65ZCCXDuvwFblml7L1ikCPk7sKLZy9MUJgq57DjgG2vmc/jvtSJpghWJw4XCnMN0goFO4S1A==
X-Received: by 2002:a05:600c:3d8e:b0:3b4:a61c:52cc with SMTP id bi14-20020a05600c3d8e00b003b4a61c52ccmr11438448wmb.7.1663886784439;
        Thu, 22 Sep 2022 15:46:24 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id bn27-20020a056000061b00b0022762b0e2a2sm6704105wrb.6.2022.09.22.15.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 15:46:23 -0700 (PDT)
Message-ID: <92b58775-2a2c-b6be-557d-10e3852a9e80@linaro.org>
Date:   Thu, 22 Sep 2022 23:46:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] misc: fastrpc: Don't remove map on creater_process
 and device_release
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
 <20220902151423.3351414-2-abel.vesa@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220902151423.3351414-2-abel.vesa@linaro.org>
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
> Do not remove the map from the list on error path in
> fastrpc_init_create_process, instead call fastrpc_map_put, to avoid
> use-after-free. Do not remove it on fastrpc_device_release either,
> call fastrpc_map_put instead.
> 
> The fastrpc_free_map is the only proper place to remove the map.
> This is called only after the reference count is 0.
> 
> Fixes: b49f6d83e290f ("misc: fastrpc: Fix a possible double free")
> Co-developed-by: Ola Jeppsson <ola@snap.com>
> Signed-off-by: Ola Jeppsson <ola@snap.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   drivers/misc/fastrpc.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 0c816a11eeec..50c17f5da3a8 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -316,6 +316,13 @@ static void fastrpc_free_map(struct kref *ref)
>   		dma_buf_put(map->buf);
>   	}
>   
> +	if (map->fl) {
> +		spin_lock(&map->fl->lock);
> +		list_del(&map->node);
> +		spin_unlock(&map->fl->lock);
> +		map->fl = NULL;
> +	}
> +
>   	kfree(map);
>   }
>   
> @@ -1266,12 +1273,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>   	fl->init_mem = NULL;
>   	fastrpc_buf_free(imem);
>   err_alloc:
> -	if (map) {
> -		spin_lock(&fl->lock);
> -		list_del(&map->node);
> -		spin_unlock(&fl->lock);
> -		fastrpc_map_put(map);
> -	}
> +	fastrpc_map_put(map);
>   err:
>   	kfree(args);
>   
> @@ -1347,10 +1349,8 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
>   		fastrpc_context_put(ctx);
>   	}
>   
> -	list_for_each_entry_safe(map, m, &fl->maps, node) {
> -		list_del(&map->node);
> +	list_for_each_entry_safe(map, m, &fl->maps, node)
>   		fastrpc_map_put(map);
> -	}
>   
>   	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
>   		list_del(&buf->node);
