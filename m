Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED97D60D291
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiJYRfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJYRfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:35:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464312DFE;
        Tue, 25 Oct 2022 10:35:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id f27so3923263eje.1;
        Tue, 25 Oct 2022 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d1cd8/NWjgbm6/tO2cUdBfWpIFFstc01MVYIyopAQQU=;
        b=LXCSVnzlNDZDIRsuW9DaO/y+bV1tFbC7e6MHKoPhCmSHCvCroOUvnoqvwP8nCWH2wf
         Nls62CGMpz3RKZFTlNf87EOaHDJTNp4C2+BG8Tg3dzDMPdgLrmUM0F3tabl4wCHV7Xgz
         GA7LhUMR7krQ04F8XYWr/gOvtT2VpTDoMSyG8b+YKz9cSCELb3mlzHTkah67+w1gAJEb
         mVvADdTFs7oy6d8ULCQIhbItnOw4fbuhDT8ArMC4uOz91Lwmu6QhsWEFf7oEKouyr8QM
         ui7qN5XHWiWYtZobDqzCy7ghobQkMR+ygdh+O3Eg6uqs+m/75SPwNVU7kHsBQmjhz/7j
         4Z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1cd8/NWjgbm6/tO2cUdBfWpIFFstc01MVYIyopAQQU=;
        b=IsxyuuTL70jCM5DnZTrgLKfq77eAqaqwZSCCbIoFrFAJBoLh6d44Q2Ju9LJ5gM83VG
         mvLuS88d40Sa3hroR5n82Hid7JqUJzKsPslWNFOUgT4uAOW9ZEMxEhQMiZZIudTI8DGG
         jvIwQd9aaldaj4jhkG6EqW/3plzVUkQlNGasK8vcY79adqGTza5ONrA7p5IvRsG1Ya8s
         GbHFY4TBFlzDSGYxjXM6Oa2UoxM4ntFVE8ug60kmWCoi8PetOyVIcMy39/cyP27FiLrp
         y7qABGsUYkGZsm850ZsT+zFG/JCdV0CInmSOWZOggYW/ssh4n4eYSYrsfIKYCCm281DR
         rKsg==
X-Gm-Message-State: ACrzQf1GDlTfk79+wddUQkvVxvFpbATEtyQMv4r0nBU67ZKsmMlfvo7q
        jAzQjqo7VnRSVygR2GzkTkI=
X-Google-Smtp-Source: AMsMyM5kPNRY8ehQaII4UakT7mDg5cwoCSVLgCFvxHnyTdolB4Iqai/E90rZd0klrt6sPGfLIdP61A==
X-Received: by 2002:a17:907:2cf1:b0:78d:cafc:caba with SMTP id hz17-20020a1709072cf100b0078dcafccabamr33887607ejc.154.1666719309845;
        Tue, 25 Oct 2022 10:35:09 -0700 (PDT)
Received: from [192.168.1.100] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id eq9-20020a056402298900b0045b4b67156fsm1975141edb.45.2022.10.25.10.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 10:35:09 -0700 (PDT)
Message-ID: <f0b755d2-6d73-5b04-e013-59f622e143da@gmail.com>
Date:   Tue, 25 Oct 2022 19:35:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] staging: rtl8192e: remove bogus ssid character sign
 test
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
        kvalo@kernel.org, linux-wireless@vger.kernel.org
References: <Y1e+SmS3O2ZaPVoe@kroah.com>
 <20221025122150.583617-1-Jason@zx2c4.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221025122150.583617-1-Jason@zx2c4.com>
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

On 10/25/22 14:21, Jason A. Donenfeld wrote:
> This error triggers on some architectures with unsigned `char` types:
> 
> drivers/staging/rtl8192e/rtllib_softmac_wx.c:459 rtllib_wx_set_essid() warn: impossible condition '(extra[i] < 0) => (0-255 < 0)'
> 
> But actually, the entire test is bogus, as ssids don't have any sign
> validity rules like that. So just remove this check look all together.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v1->v2:
> - Remove ssid sign test entirely rather than casting to `s8 *`.
> 
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> index f9589c5b62ba..1e5ad3b476ef 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> @@ -439,7 +439,7 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
>   			union iwreq_data *wrqu, char *extra)
>   {
>   
> -	int ret = 0, len, i;
> +	int ret = 0, len;
>   	short proto_started;
>   	unsigned long flags;
>   
> @@ -455,13 +455,6 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
>   		goto out;
>   	}
>   
> -	for (i = 0; i < len; i++) {
> -		if (extra[i] < 0) {
> -			ret = -1;
> -			goto out;
> -		}
> -	}
> -
>   	if (proto_started)
>   		rtllib_stop_protocol(ieee, true);

This patch cannot be applied on:
[PATCH] staging: rtl8192e: use explicitly signed char
On 10/24/22 18:30, Jason A. Donenfeld
As line 456 was changed.

Bye Philipp

>   


