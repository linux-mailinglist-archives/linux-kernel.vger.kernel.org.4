Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BFD61E15C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiKFJjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiKFJjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:39:14 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0760CDF21
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:39:13 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id b2so23196219eja.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKAJ2/yLc4mvQdfJkZhUQUnQ0RrM/icpzhSE8dBo32s=;
        b=k+UXWFlnwbL6VZR8dqOWtWgxpGu7d1lRB1yzdOnGj2NAS4WYRb5fHpJ41NAdDIPX8m
         ZzlDEE0X9ViNHInCTVSqHrHwvGgCD0yeOPzyo6The2/IdDGLR5EulB/+sA1KdaGPbrTM
         WEgPSt1zENaohbhHlOKIU/eUotsqJ9DAod48n0qqCXeJNn5vfen0loEE9ZWO9jZpZxTN
         g44cTvQY/nmZ+OB6tA6GNLQ5ZdYpJQqTi+icLr/9vRHBiApDpgAWxjQR4f+7xlxovdeI
         8gg9q4/X56AX0a3pakZ8Vj0GZwowO2SNgGy54FSHw97ADJrJLtiR27G0CsYnvBxbhnK9
         5Gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKAJ2/yLc4mvQdfJkZhUQUnQ0RrM/icpzhSE8dBo32s=;
        b=izKQtu+kyPoopJGa0WKF5d7Lcm5mYqlqtb6kkfzRjAJ6abh9b8KD++NjJN3key3+F+
         lGjcsHQjXTBrW+cvErmclulVQCxlK4XztUZBNDdO7sztZH573YLOGE7rtZ3B6lo3AaDr
         yR8XyHrqjoywFo/3oNHoEW1gc0auNCQ40TTgOvrUsLh6XzUOZp2cc4O0gNyvinATxm2B
         GIc5TkT7TfisSvzsMLBGi8Wh8VUp0jA8JXzpJRynX/Tq/qjq163MZvI0s5vu7bovglfo
         vWJHV9+t+pqE2IljZ1dvOrSwVQgqu/2wnSnaZzF6Q9Kcj7OF1QMml0Cl6SQP3CZ4BrAn
         RUxA==
X-Gm-Message-State: ACrzQf2DRYFWxVOUjzZ4j7qlK8gKCqBS2gLqyDPrHJM/RKKK7ssV11MG
        mKyGbjrhPlSFMB/SA3P3EEA=
X-Google-Smtp-Source: AMsMyM5JNVAaJ1ne6Dj66pp0golYRCcgZmAIUlpITdvVPTs8mboXO+UEZ+QF6TPasmR/6pXbfYrbYQ==
X-Received: by 2002:a17:907:320a:b0:741:72ee:8f3 with SMTP id xg10-20020a170907320a00b0074172ee08f3mr43628756ejb.168.1667727551554;
        Sun, 06 Nov 2022 01:39:11 -0800 (PST)
Received: from [192.168.0.101] (ip5f5abba7.dynamic.kabel-deutschland.de. [95.90.187.167])
        by smtp.gmail.com with ESMTPSA id i24-20020a05640200d800b00463c367024bsm2351937edu.63.2022.11.06.01.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 01:39:11 -0800 (PST)
Message-ID: <22bea152-2591-b381-11d5-fe8b94498d31@gmail.com>
Date:   Sun, 6 Nov 2022 10:39:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] staging: r8188eu: convert three functions to bool
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221105093916.8255-1-straube.linux@gmail.com>
 <6ca906bd81be7c6700068a5c9ba7354e14280619.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <6ca906bd81be7c6700068a5c9ba7354e14280619.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/22 09:58, Joe Perches wrote:
> On Sat, 2022-11-05 at 10:39 +0100, Michael Straube wrote:
>> The functions
>>
>> is_client_associated_to_ap()
>> is_client_associated_to_ibss()
>> is_IBSS_empty()
>>
>> return boolean values. Convert their return type to bool and replace
>> _FAIL, which is defined as 0, with false. Another step to get rid of
>> _SUCCESS / _FAIL.
> 
> yay.
> 
>> diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> []
>> +bool is_client_associated_to_ap(struct adapter *padapter)
>>   {
>>   	struct mlme_ext_priv	*pmlmeext;
>>   	struct mlme_ext_info	*pmlmeinfo;
>>   
>>   	if (!padapter)
>> -		return _FAIL;
>> +		return false;
>>   
>>   	pmlmeext = &padapter->mlmeextpriv;
>>   	pmlmeinfo = &pmlmeext->mlmext_info;
>>   
>>   	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE))
>>   		return true;
>> -	else
>> -		return _FAIL;
>> +
>> +	return false;
> 
> instead of
> 
> 	if (foo)
> 		return true;
> 	return false;
> 
> These could be:
> 
> 	return (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) &&
> 	       ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE);
> 
>> +bool is_client_associated_to_ibss(struct adapter *padapter)
>>   {
>>   	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
>>   	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>>   
>>   	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE))
>>   		return true;
>> -	else
>> -		return _FAIL;
>> +
>> +	return false;
> 
> and
> 
> 	return (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) &&
> 	       ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE);
> 
> 

I'll keep this in mind for a future patch.

Thanks,
Michael
