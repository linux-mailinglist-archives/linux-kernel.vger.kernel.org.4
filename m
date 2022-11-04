Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4AB61A027
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiKDSjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiKDSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:39:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA8310FFC;
        Fri,  4 Nov 2022 11:39:02 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r14so8893448edc.7;
        Fri, 04 Nov 2022 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7vZbtWN4TJpeUP01QHtRPe6BwCu9t56UDEKfIgoRew=;
        b=bkgBCvb/LgaAtdLclS9aH+Hw2vEiCnfLRSyNfKpGZM8A4NxTH+TP9DV+fFElh7Q9nr
         JcYEUUziu8n8s9YOd6npPKrPymLv0HLva+vXts0VjEaeTTJ4iXELOW+53BI6OT2/Grc3
         bO7NXj8WTkTF7DhIkzSx8We3JKAiG6J6ONVuW9wN/qIYmTIAWOT0ciVxDXAPBH4rerue
         nDt0yhN9SgQtwIVRAMletqmcsjgRPAzOlUB+5I2CANCD/lVWzraU1k+IkRNlnkFoF+Eh
         U8HUcPTc3nFR35JT0bz7viPws5KACNfy2rG4bc8MADdQ79H82uBqdwLPNUDmLfSQ0DZw
         QlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7vZbtWN4TJpeUP01QHtRPe6BwCu9t56UDEKfIgoRew=;
        b=NmJ/2eG5z5NkGzMLt+0WqGwNsIWVTTyw3WYtQAyE6XVH4mdk9qZqrlgqBVIo/EbcOR
         Vw+PgDfsXj1ClDxrOJA3+Z5RouScQThQtMCiG82k8S+vYKyTcfA8dkDCAWfcTtF3+qp9
         w4rPZ+ZnJDRHC+Bhw7q9zn/64aZAszotzCKPs3vxtfkJR+i6wiBTfBaW+49BCjpgJ4vv
         8LT/9gIHRVqKsidwS5HMvOs0z0Rpku7X7n7reDUyqHMwhNOR4uh0wflTuWp9wAjLYEFB
         OrhiDVyAsCeXjfqdHGHFDwp+ZD2QvrrPFB9cjTDZwGzcyD5fdPjQnhGS35S7VUYXc6LG
         IDXg==
X-Gm-Message-State: ACrzQf3qxL4wW0kVUYh6flVjMvRBIk7XwYt+AaivRujTDg28V6GRwOSx
        qi0CmkrjGO04beKcg+RICK61SL5TvqA=
X-Google-Smtp-Source: AMsMyM7n+t29zH760mwz3Q5qmK+CTBNKW2qBI0md92GToaX13nrJ/jyMKioacxfaf6ufGzS19bPbPA==
X-Received: by 2002:a05:6402:5024:b0:440:e4ad:f7b6 with SMTP id p36-20020a056402502400b00440e4adf7b6mr9319798eda.358.1667587141474;
        Fri, 04 Nov 2022 11:39:01 -0700 (PDT)
Received: from [192.168.1.101] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b007ade5cc6e7asm2175915ejc.39.2022.11.04.11.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 11:39:01 -0700 (PDT)
Message-ID: <0bd7b528-761f-6a93-ff97-5aa419b4f336@gmail.com>
Date:   Fri, 4 Nov 2022 19:38:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] staging: rtl8192e: Fix divide fault when calculating
 beacon age
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20221104012750.2076-1-Larry.Finger@lwfinger.net>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221104012750.2076-1-Larry.Finger@lwfinger.net>
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

On 11/4/22 02:27, Larry Finger wrote:
> When the configuration parameter CONFIG_HZ is less that 100, the compiler
> generates an error as follows:
> 
> ../drivers/staging/rtl8192e/rtllib_wx.c: In function 'rtl819x_translate_scan':
> ../drivers/staging/rtl8192e/rtllib_wx.c:220:57: warning: division by zero [-Wdiv-by-zero]
>    220 |      (jiffies - network->last_scanned) / (HZ / 100));
>        |                                                         ^
> In file included from ../include/linux/skbuff.h:45,
>                   from ../include/linux/if_ether.h:19,
>                   from ../include/linux/etherdevice.h:20,
>                   from ../drivers/staging/rtl8192e/rtllib_wx.c:18:
> ../drivers/staging/rtl8192e/rtllib_wx.c: In function 'rtllib_wx_get_scan':
> ../drivers/staging/rtl8192e/rtllib_wx.c:261:70: warning: division by zero [-Wdiv-by-zero]
>    261 |      (jiffies - network->last_scanned) /
>        |
> 
> In fact, is HZ is not a multiple of 100, the calculation will be wrong,
> but it will compile correctly.
> 
> The fix is to get rid of the (HZ / 100) portion. To decrease any round-off
> errors, the compiler is forced to perform the 100 * jiffies-difference
> before dividing by HZ. This patch is only compile tested.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
> v2 - some commit log lines are shortened
>     - add space after * operator
> ---
>   drivers/staging/rtl8192e/rtllib_wx.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> index da2c41c9b92f..217426ee2e92 100644
> --- a/drivers/staging/rtl8192e/rtllib_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> @@ -217,7 +217,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
>   	p = custom;
>   	p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom),
>   		      " Last beacon: %lums ago",
> -		      (jiffies - network->last_scanned) / (HZ / 100));
> +		      (100 * (jiffies - network->last_scanned)) / HZ);
>   	iwe.u.data.length = p - custom;
>   	if (iwe.u.data.length)
>   		start = iwe_stream_add_point_rsl(info, start, stop,
> @@ -258,8 +258,8 @@ int rtllib_wx_get_scan(struct rtllib_device *ieee,
>   				   escape_essid(network->ssid,
>   						network->ssid_len),
>   				   network->bssid,
> -				   (jiffies - network->last_scanned) /
> -				   (HZ / 100));
> +				   (100 * (jiffies - network->last_scanned)) /
> +				   HZ);
>   	}
>   
>   	spin_unlock_irqrestore(&ieee->lock, flags);


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
