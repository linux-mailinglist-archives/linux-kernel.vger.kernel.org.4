Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF76F1E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346521AbjD1Svq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjD1Svn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:51:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DE12128;
        Fri, 28 Apr 2023 11:51:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b60365f53so437107b3a.0;
        Fri, 28 Apr 2023 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682707902; x=1685299902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQE0ZDAye3LXt+mgLSmR0DtH55ydDdpXrI8q4xIkhu8=;
        b=LcGe3fqVeiCOmnY3UM0CsgbZaX+AvnqQWl7tOhjteohNqE6RamVTGzkkOCf2Xgr+RR
         WBRkch3Sn8x1ftGIUO2x2OM2TrrnJ5yH7A6Hv1bX97KVNzjqGgvY9FLLb08/NFEDngjU
         6jP/tZL7cwJ9J4zBl2wCPFJQf4CXc1eJsU3ev5bZoL2HE7SYvX74L+5rLXDJBPqNqU/N
         j1Owr/9SmLhZtP4KFgOtDe2iWMTeX6rlDN8DNPL8O1aGuRNzV/JT8uM1BvAE1YVihJnt
         vZi9qI0DzeYPGbPfArhnCPks5NkqU0FuNOxF6jdpiwXwoyR/hbeHNZmwRs08MqzNhkUA
         kUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682707902; x=1685299902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQE0ZDAye3LXt+mgLSmR0DtH55ydDdpXrI8q4xIkhu8=;
        b=lqEoIB+hI5l8PRhGVko7r/mQ29nPCbvkRZ418HnBrISyVQ4gK9Zy7BmJ9W2meTGtXi
         hxZFLsY6dfVg+9OJd1y3j0eg+/EbtMwCv/pYK6wJsKaaMoznbdXv3jtLG5hDqEk6Z3PA
         9RFz2xOmX+hGXGx5xj4ZnOljow/cUsgVFeSNRUK/tQ38CPipEmeowyuhtdcyESD6et/5
         16COJhX0RAffIRalYZ7LMM2uCCZW03C7jUjUwuJPwLnRXrNlbg8K9+CvdJ1i+uGHXOfg
         KaP5WB4SuWhQ2ydT/8pGj5Va78A8KRVyqzeD9oP4SDg9Ou+hkcsamYvRtd2PFd5+TzJ9
         cYbA==
X-Gm-Message-State: AC+VfDwiAUNOU0csraPK6lGrZOaRZdhY+NCcPyqjytGXu0eS9JuFGU3+
        r5Yvn9FIiwyhQR3SulfJrc1NYc38Rh8=
X-Google-Smtp-Source: ACHHUZ7Y7RwJdejJFVgm27RRKkCninEO0tGK6dOLqE+hk90G9f+KCdSDQh1uNbAkRXdYys+ff5gAgA==
X-Received: by 2002:a05:6a00:b84:b0:63d:3a18:4a03 with SMTP id g4-20020a056a000b8400b0063d3a184a03mr9142863pfj.5.1682707902150;
        Fri, 28 Apr 2023 11:51:42 -0700 (PDT)
Received: from [10.230.191.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22-20020a056a000c9600b0062dd9a8c1b8sm15580389pfv.100.2023.04.28.11.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 11:51:41 -0700 (PDT)
Message-ID: <5be7e9de-a81b-c0c8-2231-06144ff3cdea@gmail.com>
Date:   Fri, 28 Apr 2023 11:51:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -next] gpio: brcmstb: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, linus.walleij@linaro.org
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230428061109.102343-1-yang.lee@linux.alibaba.com>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <20230428061109.102343-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/2023 11:11 PM, Yang Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/gpio/gpio-brcmstb.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
> index c55b35da61a0..6566517fe0d8 100644
> --- a/drivers/gpio/gpio-brcmstb.c
> +++ b/drivers/gpio/gpio-brcmstb.c
> @@ -609,8 +609,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, priv);
>   	INIT_LIST_HEAD(&priv->bank_list);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	reg_base = devm_ioremap_resource(dev, res);
> +	reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>   	if (IS_ERR(reg_base))
>   		return PTR_ERR(reg_base);
>   
Acked-by: Doug Berger <opendmb@gmail.com>
