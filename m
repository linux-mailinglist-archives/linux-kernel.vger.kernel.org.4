Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DF365FF89
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjAFL02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjAFL0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:26:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC285FFC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:26:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o15so848650wmr.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5l1OQud5PtBEYy3tKVwqWPj8C6sV/6VkPzpWrf+T4lU=;
        b=asrnv1tiLJumHwWO0FdvosKBbuEC+K3Sam8YpyOTYzKrHyuznnw+NGwxgOp0q9XvEl
         e/gYmPMIVo5jq8bFhHy+0MY0y1EGIoIsXcxbghGqHigQ80IZTFqS0cIO7S4UtkdpyR7D
         TZOnTOd4ZJGc6c1EQKUUQ040tLV+cY+IERclS7lo6w26MSvfc2uHGUgWkqehqcWmYlIX
         9i2+q6K5Ah556MB60rD+J1qfLRJTEkUkqR41xYVtlOd4XvBTO+lpp2yydBTc90Gi9nGc
         HewRufSKI9vTuVXoWlANrChj6HMi9sqCJuI2zkShE+WjB2dAuiuB3iAKRe+6059/odZY
         VDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5l1OQud5PtBEYy3tKVwqWPj8C6sV/6VkPzpWrf+T4lU=;
        b=aGPTugfItE2rZadqLiynZf2TnOHKVng85dK4Y3KOMqONvN3zU6BMtogAIFifS7fVVd
         g8EhmaKr3w7cJbaTKavmkmG7L2uP8JPDGDsnsqhQ1kxahCq1fE8xNUaVNfcqnGca/BdG
         r/xKJYlPimvWqRhNewiZd1M2870/spg+SMrp+BC6LLEIBX9tUQqeocYVWPRoip+aK+Cq
         flQBTFBot7hlAJneuf8w3n1pWiSEXzMhaUbhwlSrKsWg3HDRWcukb+tlGZ4x+m4RgtkW
         /yWRV281YwxqY0TX/0jfrRjMfQ+JHQAg5avKGfxFzmANzDJ0IZ7oXAngckBSCWJ/QdBG
         zvDQ==
X-Gm-Message-State: AFqh2krQM9PampONHAVVQ3RUgy8n8DMyfj74FjkTteLSDYv/cJRw0o8P
        yykWdRw49ZZGlhbJMT+EpuxzXw==
X-Google-Smtp-Source: AMrXdXuWNBHffDg8m5KIOd5FY7J7wKII0TVE+1Kkw5uXqH6Gjuopgs2RLnDT3biVkIhC6Xwcg4wrng==
X-Received: by 2002:a05:600c:4999:b0:3d3:4007:9c88 with SMTP id h25-20020a05600c499900b003d340079c88mr41144922wmp.18.1673004377916;
        Fri, 06 Jan 2023 03:26:17 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bi22-20020a05600c3d9600b003d208eb17ecsm1342821wmb.26.2023.01.06.03.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 03:26:17 -0800 (PST)
Message-ID: <2f9a150e-11bc-a963-f9b5-75b4ba3206bf@linaro.org>
Date:   Fri, 6 Jan 2023 12:26:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/8] arm64: dts: qcom: msm8916-samsung-gt510: Add Vibrator
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230105123240.1089375-1-nikita@trvn.ru>
 <20230105123240.1089375-5-nikita@trvn.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230105123240.1089375-5-nikita@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 13:32, Nikita Travkin wrote:
> gt510 uses a PWM controllable vibrator, that uses a general purpose
> clock output for it's control. Set up the pwm, supply and the vibrator.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  .../boot/dts/qcom/msm8916-samsung-gt510.dts   | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
> index e9916199e5a3..44d527b3f1f6 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
> @@ -8,4 +8,51 @@ / {
>  	model = "Samsung Galaxy Tab A 9.7 (2015)";
>  	compatible = "samsung,gt510", "qcom,msm8916";
>  	chassis-type = "tablet";
> +

Squash. One patch per adding GT510, one for GT58.

Best regards,
Krzysztof

