Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFC46D33E1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 22:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjDAUpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 16:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDAUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 16:45:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251671A964
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 13:45:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y14so25671661wrq.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 13:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680381899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KONinrexyPA8SiAQ6l9QCfRBjG7yQZ71bHl8TR878bs=;
        b=wUx6wdiaq+ifAjSRUHV71Nk0jQv97vVjCIkEYOV6vDYw4kjF0OkhX9yZ3WfGootrJd
         QiHF4QKJkaYU9eEEvWBywj7a+CPipzKhkJZunmL48GKtWQx6XtNFlBeeuhVqFb6ZxYe/
         5TdDbOq7k+bWktvmviGlmrDPoFyB89NpJrxW/v5nc1fU4MlqaMsFRK5E2BOlE9MgqJij
         d93fXcGUgnB8TDPKqyhshl4nlNiA1hoMVXISicMS4AsBCw1CDGEBfVgx2tOyh5OcX6Yk
         oGb73f1sY3CesYOmbBh0ut+Camc8fOCOqdXuAqrPcZx44VePabOzerEhmc/3uSHP0a+o
         jcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680381899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KONinrexyPA8SiAQ6l9QCfRBjG7yQZ71bHl8TR878bs=;
        b=tIAcdDJka/ESDvpLyE6cfFPQmuYsc3W2DeTLFGNAQzUTMFRa1WzOwcI0MWOKbYQZHn
         +iAqMcqVPxBUwtAisIdMYYWebVRk4dS5pGiYGxR3ygl5nugzRu8vKfNSl3GnSx2Pnvu9
         Nnfqe22cJkh09PrkhYO4NpGwuO3ljgQPAOHIu4q3kbtn30SDYZ3VQirBmoA+4R4TJ9Q4
         K4yLTRRVLjXo7ejFhOPdSDiFi1sPm9Zq3NBR0kjQyjP/Ww0Pzq8EzFqWHMpLk58smQAM
         bVnqBrq/YtwYNLcItH0G1OoNtJ/fXZCrMz1b/ncOzoRKqGRSzCO9h7B+ia1q1xMWoU2K
         VJ4g==
X-Gm-Message-State: AAQBX9el97RpkVxahZ7LgcmEqCABfiihRcK5Z89agjEN186CscP6oYB4
        79k/AaMTihYooN1hHZ1SnPzB4Q==
X-Google-Smtp-Source: AKy350YRcO2YKorYD1bzrlgh5I0ovcJIC7tfeW6/K2/joExCi2t/tOinGrstLIM4hrLi/VWtoQrIFA==
X-Received: by 2002:a05:6000:1b92:b0:2e5:820b:9289 with SMTP id r18-20020a0560001b9200b002e5820b9289mr5530780wru.64.1680381899523;
        Sat, 01 Apr 2023 13:44:59 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b36a:1186:309c:1f9a? ([2a05:6e02:1041:c10:b36a:1186:309c:1f9a])
        by smtp.googlemail.com with ESMTPSA id c13-20020adffb0d000000b002e5e7ee11besm5232558wrr.94.2023.04.01.13.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 13:44:59 -0700 (PDT)
Message-ID: <3dbb630f-abf9-4d09-f1fd-b2b05013c5dd@linaro.org>
Date:   Sat, 1 Apr 2023 22:44:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1] thermal: core: Clean up thermal_list_lock locking
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2696911.mvXUDI8C0e@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2696911.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 20:34, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Once thermal_list_lock has been acquired in
> __thermal_cooling_device_register(), it is not necessary to drop it
> and take it again until all of the thermal zones have been updated,
> so change the code accordingly.
> 
> No expected functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Looks good to me, shall I pick it in my branch ?


>   drivers/thermal/thermal_core.c |    8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -826,8 +826,6 @@ static void bind_cdev(struct thermal_coo
>   	const struct thermal_zone_params *tzp;
>   	struct thermal_zone_device *pos = NULL;
>   
> -	mutex_lock(&thermal_list_lock);
> -
>   	list_for_each_entry(pos, &thermal_tz_list, node) {
>   		if (!pos->tzp && !pos->ops->bind)
>   			continue;
> @@ -854,8 +852,6 @@ static void bind_cdev(struct thermal_coo
>   			       tzp->tbp[i].weight);
>   		}
>   	}
> -
> -	mutex_unlock(&thermal_list_lock);
>   }
>   
>   /**
> @@ -933,17 +929,17 @@ __thermal_cooling_device_register(struct
>   
>   	/* Add 'this' new cdev to the global cdev list */
>   	mutex_lock(&thermal_list_lock);
> +
>   	list_add(&cdev->node, &thermal_cdev_list);
> -	mutex_unlock(&thermal_list_lock);
>   
>   	/* Update binding information for 'this' new cdev */
>   	bind_cdev(cdev);
>   
> -	mutex_lock(&thermal_list_lock);
>   	list_for_each_entry(pos, &thermal_tz_list, node)
>   		if (atomic_cmpxchg(&pos->need_update, 1, 0))
>   			thermal_zone_device_update(pos,
>   						   THERMAL_EVENT_UNSPECIFIED);
> +
>   	mutex_unlock(&thermal_list_lock);
>   
>   	return cdev;
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

