Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13EA690D99
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjBIPvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjBIPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:51:09 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E80D656AD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:50:53 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so2194496wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 07:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y41lQosy76/yd9ref3+nY9Q/B9QUKYofOTeSAFeUKd8=;
        b=op7Ecgx+UGtYR0W7tsKb33AnkDioq7r+B763L2/dKL79TbMfnSRDVKtNNYl/Y5WHEg
         yKoeCU8emBxORGaZE13irxCi8wrsKhfuoFvkfcJPqerIyLvvpgrs3/ShXiB8FBmLcmkl
         KscxaMtFH43h2OPlKBvizUO30BAUgAWk8vc/qHLbqm7Y2xnaAwBdcE8TgWkyX0Jdwa7b
         2+q1JQUwZWFoukHaWJeLypMORBLSL4VoZLDvJ+cs+/CrwAHY6u/tkiVZDdHBbkb1Y3GE
         1hCOJPo8NrCPix003k2Fv2pyqDZkGFEIHkS1Zz4aOJ6nQyXL+OQiGbu1qf1BvTR5mLhb
         dChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y41lQosy76/yd9ref3+nY9Q/B9QUKYofOTeSAFeUKd8=;
        b=VQVVpLVHV0NRaymIZcp/pRxwacZ0uWSXPX59Pa0zecpaj1tLuA9VNCVM0uBhV/M6sK
         DFljf85/4zHSfI+NghRE/5AIjOFLs0aAv5xs26Z5Vro4bxxS3t4dOvemv+LZNC53bGcy
         QjnqOCewA/wkd1nthk91u/p6UTPrQuXlof+bzdY2v0baUPkAf6qfHuMl/wnARLdA3sa3
         trhGQ4t4gUzmPuSx1XUHI9RHOUbWnB6e4PZ0fj/SwtEktLAfKoEP5pVSR6OwoQxXeoW/
         C41y+zS9ZP7FM9xvCejZDuF2L7eJkd1MQuOip0qqkTN5+AafJeUPAQPjUtGCHfQ2WobV
         e8kg==
X-Gm-Message-State: AO0yUKVWMYun8bFx6VNXQB3frCbPENNQM4PCaq122zz+VKo7oZkgYCBj
        vochjIPkIgpxUeoqOCTydVCNxA==
X-Google-Smtp-Source: AK7set+rlrXad6Dg6sDEUQG+buCHs3h5raoC/DQhwWKs+hgdPlWUZxs2FHzaC/cvLHJAmhjTmmmjqw==
X-Received: by 2002:a05:6000:18cf:b0:2c4:8ea:bfd4 with SMTP id w15-20020a05600018cf00b002c408eabfd4mr3694049wrq.33.1675957851853;
        Thu, 09 Feb 2023 07:50:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d568d000000b002bfb8f829eesm1494122wrv.71.2023.02.09.07.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 07:50:51 -0800 (PST)
Message-ID: <6edc8fcd-d6d3-916d-c2f4-a44b8485ab77@linaro.org>
Date:   Thu, 9 Feb 2023 16:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] pinctrl: at91: adding new macros
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, ludovic.desroches@microchip.com,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, claudiu.beznea@microchip.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        manikandan.M@microchip.com
References: <20230209154544.535136-1-Ryan.Wanner@microchip.com>
 <20230209154544.535136-3-Ryan.Wanner@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230209154544.535136-3-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 16:45, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

> 
> Adding macros for sama7g drive strength.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  include/dt-bindings/pinctrl/at91.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
> index e8e117306b1b..fd0a389b2a0f 100644
> --- a/include/dt-bindings/pinctrl/at91.h
> +++ b/include/dt-bindings/pinctrl/at91.h
> @@ -42,8 +42,14 @@
>  #define AT91_PERIPH_C		3
>  #define AT91_PERIPH_D		4
>  
> -#define ATMEL_PIO_DRVSTR_LO	1

That's an ABI break, so no. You need to keep it.

> +#define ATMEL_PIO_DRVSTR_LO_0	0
> +#define ATMEL_PIO_DRVSTR_LO_1	1
>  #define ATMEL_PIO_DRVSTR_ME	2
>  #define ATMEL_PIO_DRVSTR_HI	3
>  
> +#define ATMEL_PIO_DRVSTR_LO_D 0
> +#define ATMEL_PIO_DRVSTR_HI_A 1
> +#define ATMEL_PIO_DRVSTR_LO_C 2
> +#define ATMEL_PIO_DRVSTR_LO_B 3

Explanation for all of these would be useful, it's a bit of cryptic.


Best regards,
Krzysztof

