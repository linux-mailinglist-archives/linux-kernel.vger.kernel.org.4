Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9DA6B5584
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjCJXV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjCJXVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:21:51 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B222B112DDA;
        Fri, 10 Mar 2023 15:21:49 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-176d1a112bfso7619947fac.5;
        Fri, 10 Mar 2023 15:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678490509;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+4y9DSm8ynkkCS+XSEXgy/9eh94uAA62/oUDVLpYc6w=;
        b=BktmKXSzhgo6DPj6CTvH9qXgbBQmCy+2y9qI1RByiVWf0vFjG0MF+BO4C3ULs0WLmh
         NZnh+Bb/sbsm0Uad+sVYPxxACGD9mhIWlIYK2vdCmZm4iHz8zF90OxZGYSYCkVupYPou
         igL2AWcS3SYSkibrMxNxvLkap191TZQTrsrinotZqPsRZzdDc0GxEPou7MT2ravHUlVL
         utY9jFflL7ke5362MHxeYOW3u+YozXhK7xUMv2yFAk/hKKvQMB4WJIS94iZHAlfLs8ON
         /X+JI2rL6SzdvrtKTm3UQA8brJGzf2GM9ADmKTv4ywkYTFmd5mIwwVyjfU7qU+w2m7bE
         VplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678490509;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4y9DSm8ynkkCS+XSEXgy/9eh94uAA62/oUDVLpYc6w=;
        b=nIfT9Y+7YfQGsGk40n3moBdB3FfsHlc+eUYX9SpyEstvqwktbVbKh4x7QvkQqhZriC
         xu/OJ7lgV4ypwtCqn+GZuG2QMhztX7jDlrqdLDuo6uuitmk4Cc3cVA8LioydU6uhFmrz
         pZMrn/9rFgvmryarvDtjxpFyyRRCOMw7ezPyrBPBlZdhF2yL271qr8uZW9zjxXfssuGJ
         xHDSJYylP98B5E/+AobBwyPTsfrNH9uS1xjtRp56IjwuifhuyD31/ELjS/pMpUTBlNj+
         VeNq03iGXe2w7FxpIm0GOXeXMarh/3MPMYQaChirbmlsZMd+hbcljD+9lhyvM0FQ60KN
         i70Q==
X-Gm-Message-State: AO0yUKX5AcpqhARCoFU9BWmtvcgfWezbZLO8wHf+Y2XIS/Eyz0+ftMgL
        OCqD/5Dq15hQ2SvRCLDp60Y=
X-Google-Smtp-Source: AK7set+CbshHIW4LX3YgkJxz0P5eVsDphB+JZDhfWXPZq5ddCmq2K/A9fPdDXJg/FYqPq7UlGC+qhA==
X-Received: by 2002:a05:6870:1718:b0:16d:2b42:811a with SMTP id h24-20020a056870171800b0016d2b42811amr16027401oae.17.1678490509083;
        Fri, 10 Mar 2023 15:21:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z21-20020a056870515500b001728d38a41asm538474oak.55.2023.03.10.15.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 15:21:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5aaa5a5d-a5e2-0052-f840-67abe0ba6d47@roeck-us.net>
Date:   Fri, 10 Mar 2023 15:21:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] watchdog: aspeed: Drop of_match_ptr for ID table
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230310223012.315897-1-krzysztof.kozlowski@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230310223012.315897-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 14:30, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).
> 
>    drivers/watchdog/aspeed_wdt.c:56:34: error: ‘aspeed_wdt_of_table’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/aspeed_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index c1e79874a2bb..b72a858bbac7 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -465,7 +465,7 @@ static struct platform_driver aspeed_watchdog_driver = {
>   	.probe = aspeed_wdt_probe,
>   	.driver = {
>   		.name = KBUILD_MODNAME,
> -		.of_match_table = of_match_ptr(aspeed_wdt_of_table),
> +		.of_match_table = aspeed_wdt_of_table,
>   	},
>   };
>   

