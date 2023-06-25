Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BA773D14C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjFYOH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjFYOHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:07:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0346BE5A
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:07:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a52fff2f0so598862a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687702070; x=1690294070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KAgxZ0e/Mp+Alk75/mq17h2w55B+c/Iz4lU0v72Yh4=;
        b=PFp3EHAt2PBxlImJsgnh+F8Xx+hMxzHe9RhLPTiZP0MHwIu5RsP+NjKY1O/2cvatUD
         AjYe6pdQaMUEEr8Mg3sTpAn7Y8LJalbxGSK6rgX9CAXRzeJhOPPUuHmkUtplO9I7wmsl
         +cC+cnRVSXRHrA+MQUdOWPlIRU7SNMiUA8Sj5Q6+MRb0xiZowHcA4KsZw4yqgk20gG4H
         hrcc/IpzfUUYSfvgEiRSWkSY8sLuEdaNLuJZY8jlPLX7al3SRSbyoFz/PKxvhhwbEU9v
         lYUyDHTpZgsfLsWRHa6bT8tXJZSS2riJbKFAwJ+fmVgimrtNf8uI0ibF2ApwyirYSReZ
         kXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687702070; x=1690294070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KAgxZ0e/Mp+Alk75/mq17h2w55B+c/Iz4lU0v72Yh4=;
        b=Ddn6GH65y2TVPWgU48w3drJykc/wv2NxSzcwh9EJt7vUT5FvKKxV2PoN8rmHLJNgx3
         G8uXVqILqYqIWEplasDTsIovMaFIhhwWx2yvJYH3jgyGXmc7eCHf2UwfSagkhNIWNZzX
         Cnc4byPD8ZNFHWmyodYiyHO5JTdmFA6wle/W3hvnnoGeGyR6xSp5M2Nw0HWTczzGcQYj
         XmmoG17STEG4Cag4bpFk6D+SHI1jgYaz9T9lNe/GpWvRx2Zj6MTlPXqF1lvpBFRan0qU
         aKjYT/gYNdZipnj7uldI08PibL/3S1yHCFistKfMev7vOw6DnwNhb9Hm3wfjs29E/QR+
         RUoA==
X-Gm-Message-State: AC+VfDzQMK0htQM+buily1DeN6drO0H54RZ8fqWvk1vkGzLRBSvzJ/cO
        fCSf8k4CKkRhNeBOw4vXp3Q=
X-Google-Smtp-Source: ACHHUZ6PHGAqmN3NnuYXAL4lX7muOsXomV/604xi3w5sRHNlXFpa+ue5yDJP1FuYYRrWx7rtjrCy/A==
X-Received: by 2002:a05:6402:27c8:b0:51d:9611:db3d with SMTP id c8-20020a05640227c800b0051d9611db3dmr1093359ede.2.1687702070294;
        Sun, 25 Jun 2023 07:07:50 -0700 (PDT)
Received: from [192.168.0.101] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id w3-20020aa7d283000000b0051a2edb49b0sm1783713edq.63.2023.06.25.07.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 07:07:49 -0700 (PDT)
Message-ID: <ec2fcc62-90b8-f106-958a-7e1eb27009e3@gmail.com>
Date:   Sun, 25 Jun 2023 16:07:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] staging: rtl8192e: Rename function HTIOTPeerDetermine to
 ht_iot_peer_determine
Content-Language: en-US
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        dan.carpenter@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <ZJdagUiGPqzb5lp+@tacos.darkphysics>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZJdagUiGPqzb5lp+@tacos.darkphysics>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/23 23:05, Tree Davies wrote:
> Rename function HTIOTPeerDetermine to ht_iot_peer_determine in order to
> fix checkpatch warning: Avoid CamelCase
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index f9fa3f2bb728..33fac7d9ada8 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -164,7 +164,7 @@ bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
>   	return retValue;
>   }
>   
> -static void HTIOTPeerDetermine(struct rtllib_device *ieee)
> +static void ht_iot_peer_determine(struct rtllib_device *ieee)
>   {
>   	struct rt_hi_throughput *ht_info = ieee->ht_info;
>   	struct rtllib_network *net = &ieee->current_network;
> @@ -720,7 +720,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
>   			ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
>   		}
>   
> -		HTIOTPeerDetermine(ieee);
> +		ht_iot_peer_determine(ieee);
>   
>   		ht_info->iot_action = 0;
>   		bIOTAction = HTIOTActIsDisableMCS14(ieee, pNetwork->bssid);


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
