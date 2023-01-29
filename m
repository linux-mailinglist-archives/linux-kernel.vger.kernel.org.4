Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BE6680021
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 17:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjA2QBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 11:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjA2QBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 11:01:38 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2616D1F92B
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:01:35 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso1626868wms.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VaYQWv6xZ5TTyHoxaDqQOnl6+vxxWnFWLnikW3QAHTs=;
        b=kk43o2FzJhQJ7hemG1HCrwhbWsQx3yXbIjyvGRa1pDOcYHaIK/MWoOAAc4k/LebWoC
         JISrDyd2MM4KJTtVHcmQeiXcoF93eCcwt8uARRftYYhMD3TF6cz/LsDaBdDX2LnfRHP/
         ysCeiWE8JF37GtafWbroiSir7rdZfI/wxVOzduAcc7CmijWeBoIWWYmoXwa4rXNJi0yX
         y35V1m4T5LYtO1C1ct+EJQ0XUOMiRbiZs2bgvLZwkoZG26JXskX0yjrNFIFkf8kqKsHu
         p3WP+qxkeNfKwpDESV3fADdF73/8v/6Gvp+HztEt6qC2buMWt1lecEi04sav/JGQZ3wk
         S17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VaYQWv6xZ5TTyHoxaDqQOnl6+vxxWnFWLnikW3QAHTs=;
        b=Yjn7HBmXvQhTtc6yvGRwUCdGaSLVKIJqpcT9L5ClBATc9xTacdmni12ZmkOi1FdGjN
         43aI0WU/ir9bmnJKHj9owph9xcTa3p+dWeQqTorwEMR/J60qrCNtOd25RR2INJ8dbsiR
         Hnw3r6GZdhZa1K1lL/Xvd4rkmiSyYWZ93pE4UNxu3Fax2f31QlSjfn1CeLQVf9dPTcmf
         iyS7aKvUHBJUMKbJ1d1+8OrP+ge7zvsB/JnjS1dQwL/M2SBqVTMdHrPegmz2291Cyx7P
         bkfglnEPrZLcbFEvvevzIUHQFZvmUOESbSv52Kbh9zlXmnNMWxp9LFmRjamBthEiiZYN
         ScTw==
X-Gm-Message-State: AO0yUKV37ue8uTU+K+l+WPrPq6yR+x37qmDJEe7LK9eivs3Hoo+VXhtb
        1F5ynHz1tBFBWY5WPVgAcjIGLg==
X-Google-Smtp-Source: AK7set+6G9+19ovGlu+q2bRz/VGxfdK6a4Il3tekS0A66i+VUB4hNQIEctoGZkAxQZoo1P7L70Q2Ww==
X-Received: by 2002:a7b:c44a:0:b0:3dc:4871:7b66 with SMTP id l10-20020a7bc44a000000b003dc48717b66mr5263226wmi.29.1675008093699;
        Sun, 29 Jan 2023 08:01:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b003a84375d0d1sm14862013wms.44.2023.01.29.08.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 08:01:33 -0800 (PST)
Message-ID: <3c5b6ae1-387f-143c-691f-92b96fe78270@linaro.org>
Date:   Sun, 29 Jan 2023 17:01:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] gpio: mmio: Use new flag BGPIOF_NO_INPUT
Content-Language: en-US
To:     nl250060@ncr.com, Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
 <20230126-gpio-mmio-fix-v1-3-8a20ce0e8275@ncr.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126-gpio-mmio-fix-v1-3-8a20ce0e8275@ncr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 11:17, Niall Leonard via B4 Submission Endpoint wrote:
> From: Niall Leonard <nl250060@ncr.com>
> 
> Use the existing shadow data register 'bgpio_data' to allow
> the last written value to be returned by the read operation
> when BGPIOF_NO_INPUT flag is set.
> 

(...)

>  	if (gc->set == bgpio_set_set &&
>  			!(flags & BGPIOF_UNREADABLE_REG_SET))
>  		gc->bgpio_data = gc->read_reg(gc->reg_set);
> @@ -711,6 +723,9 @@ static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
>  	if (of_property_read_bool(pdev->dev.of_node, "no-output"))
>  		*flags |= BGPIOF_NO_OUTPUT;
>  
> +	if (of_property_read_bool(pdev->dev.of_node, "no-input"))

As pointed, this brings undocumented property to two other bindings.
This needs to be fixed.

Best regards,
Krzysztof

