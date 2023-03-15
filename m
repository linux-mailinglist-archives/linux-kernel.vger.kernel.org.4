Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4C36BABB2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjCOJJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjCOJIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:08:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD21024BD9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:08:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h17so2582271wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678871303;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qSsckNSpK1c9n86p4aO+c/oJA0ycZxu7SJjrPE+HAQ8=;
        b=tmD+UjAkWr8b4XsqB22P78X5JUKvi1YiIAUkHzNKUDz9uIw8cl5dkhRRf1Q52iPRl+
         NpRzWkRVDz73h1W9Tsp4mwAXY0QStTNh1x0ueCYwTV010cngmmPZAhH37/5hJvYPIaO2
         yQ+7azjTlIF122DsaMci1HP0fY/hRzsiGfOju0Pn7gb1iRZjiOuCbjpYr3a/bRICH7+3
         rTkUFw73fmcrrsrueLMJLucDVk999FHjjZly8TbRJSlDd75zYikzavlRLGTzimDcdYQw
         VzfBiKbsQKFmkKVCkuSUVjlQHYkytLrcp5COcTm6Bgq/PBH9GcMFdtAFg5+zZpSe5I9j
         A8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678871303;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSsckNSpK1c9n86p4aO+c/oJA0ycZxu7SJjrPE+HAQ8=;
        b=V2w9wD+dpwHH8VoU05wr7RCS3b6415gm7GUeoWVpHzwNr4EMR8gy9BecFvtZmJfb9T
         ze6ff4xAbBi3nfxLqDr8Oyo5xF0VtsMLrFoUdyHR3F5q8F6OdN+8aTRGkccEKIZi3Fos
         odbfa5Aj8ukRkZgrBbZgWq3eOL5D98X5M0BraJKEB7ghdpETZJuLwXZPH663XBH0siZT
         /6Zf0HEcNsShCbnmv9SqJYNGEZp0OTJq7ilXc0aHaPcSI94mj/acuy1frtMy5yNCQQfm
         AsMPGPmVoqrArvFO391D2KuANPqmg0AqPbVQzlR91239rxWxOoqdUt8hhih/HbURane2
         JfCA==
X-Gm-Message-State: AO0yUKUBQEAUeM88jA70B2756ICcpRccRv66lP4pnJvPLdVOfAdAfFKb
        gSHYO946/9IeM7/rCtIDxfarYA==
X-Google-Smtp-Source: AK7set/VD7eCD1LIq0xwBIFKZji2Qq6fk458HtzGpOXLjPiHI+9hyptBnXREbMtiE96CAt3f1xsd8A==
X-Received: by 2002:a5d:4985:0:b0:2cf:f140:52e3 with SMTP id r5-20020a5d4985000000b002cff14052e3mr1263706wrq.9.1678871303389;
        Wed, 15 Mar 2023 02:08:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5d2d:8427:397b:8fe7? ([2a01:e0a:982:cbb0:5d2d:8427:397b:8fe7])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d550b000000b002bfd524255esm4121784wrv.43.2023.03.15.02.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 02:08:22 -0700 (PDT)
Message-ID: <d1eee7a0-8942-5f76-a3f0-74dcfddb95b5@linaro.org>
Date:   Wed, 15 Mar 2023 10:08:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: adv7511: fix race condition bug in
 adv7511_remove due to unfinished work
To:     Zheng Wang <zyytlz.wz@163.com>, dri-devel@lists.freedesktop.org
Cc:     andrzej.hajda@intel.com, jonas@kwiboo.se, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
References: <20230308173433.2788833-1-zyytlz.wz@163.com>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <20230308173433.2788833-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/03/2023 18:34, Zheng Wang wrote:
> In adv7511_probe, adv7511->hpd_work is bound with adv7511_hpd_work.
> If we call adv7511_remove with a unfinished work. There may be a
> race condition where bridge->hpd_mutex was destroyed by
> drm_bridge_remove and used in adv7511_hpd_work in drm_bridge_hpd_notify.
> 
> Fix it by canceling the work before cleanup in adv7511_remove.
> 

Can you add the relevant Fixes tag ?

Thanks,
Neil

> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index ddceafa7b637..9bf72dd6c1d3 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1349,6 +1349,7 @@ static void adv7511_remove(struct i2c_client *i2c)
>   {
>   	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
>   
> +	cancel_work_sync(&adv7511->hpd_work);
>   	adv7511_uninit_regulators(adv7511);
>   
>   	drm_bridge_remove(&adv7511->bridge);

