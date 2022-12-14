Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092D864CBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiLNOPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbiLNOPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:15:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78E110C0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:15:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so10686399wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8I9fpa0h/Xtdec1pPADK+rW1eXfIYJbi/7+lsXWKshc=;
        b=mqwC4AsXWnBdyvmy1Zh7/B6UDRXSFzEkk8TRt28/H59WOEqu5tVF+rNE4UbP00C32b
         0TiJ9W/cldHdN8BcsOMbUle3ZsPX4hiJTUwBu6LcaxdpzdRJafAzi83J/34PSFLKa78g
         r6uW3t5iwOQ6V9sslABeZiazk6CjsiCmTGO81o6/PabJBNRY/dHEKofkpATipsAu1oLa
         qexxRKchqfHX3JXqwo0v1jchfJJH1iGsVG61/avUx3YhaJ/U39td3iR5UuQ/V03mNJ65
         AA6XJcxr5lsV8topUViJ0q/4aiSTdf/LAsdaEPh6WoLLh5cDecA2XUW+e3AwTsYMkUaw
         7bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8I9fpa0h/Xtdec1pPADK+rW1eXfIYJbi/7+lsXWKshc=;
        b=rFlJEh16Gu0/YJDvrhDvf4aW/L2UIeXFHirayaLvoQUb8XTCkk0HZO+4cd764DSDCn
         sFC/4hT4JGvmjQVvxSwRbLivdTjjCwHl4gam8lV8x+TEaHRYi1CpfIQoffVeRlG1hYKe
         Se83aAgLA7V4hvc8PRJQ3f8DrsM0lmqTancsORrKhR3Og9cws34/yvJakhAgYV5R8t1f
         C5Z8zN0AV7uw0dRDUtTKxUnak89wwRURBeVpSo5PiGcXaqaj9f05HUtlMaLPNZLVhzsc
         mh8f2rwtIaVOF2UUzmmWJnT0lNE0saak1GnMV0kmRkTOG31enbEKGexcQLGD6pbqbONJ
         K/tw==
X-Gm-Message-State: ANoB5pl27ePhEQDG2IuhJtI54ok0IJBdc55o8C6LCRp313xlmSV4vu7Q
        lFNgI4ZFAObnlWDPSd6tzP8KLwjTuS8vOinZWY8=
X-Google-Smtp-Source: AA0mqf7iPboYYtpCZd2hu9ktE3TAxbzQTs/ESF1byMN4kyHK1MDPTxdhjYjOV9VkE+tJTme/oZsl2g==
X-Received: by 2002:a05:600c:1f14:b0:3c9:2598:d1c5 with SMTP id bd20-20020a05600c1f1400b003c92598d1c5mr19723107wmb.7.1671027342505;
        Wed, 14 Dec 2022 06:15:42 -0800 (PST)
Received: from [192.168.1.25] ([84.76.199.78])
        by smtp.gmail.com with ESMTPSA id d1-20020adffd81000000b0023662d97130sm2985695wrr.20.2022.12.14.06.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 06:15:42 -0800 (PST)
Message-ID: <453ff357-a91b-192b-00a1-502cc273870d@linaro.org>
Date:   Wed, 14 Dec 2022 15:15:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] hwspinlock: Use device_match_of_node()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, andersson@kernel.org
Cc:     ohad@wizery.com, baolin.wang@linux.alibaba.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202211251544369078587@zte.com.cn>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <202211251544369078587@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/22 08:44, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with device_match_of_node().
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/hwspinlock/hwspinlock_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


