Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D2765FF83
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjAFLZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjAFLZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:25:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96187687BB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:25:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso858979wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 03:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEHozJpeDSITrolZfda9kBorCG4BMYLVcfyRfiEVHcA=;
        b=EWtntYIGB97P2YONH+AFFo5OBGyyn1w/w5VV9crkBUSErhIN09Q/gO/H0BoWEoUS/9
         ShCO967WOVcvfkA4/WsDoSMAcGTNupx5Owc1RAFiGD4iaJ7QMzvo5+GdIaQoxikvtwv1
         o8Ib5mbJdqM/aJA/U/1gwaMY0NPiEFO4js9gFUakX3PSFwv/3nSgyF9vCuNBBGr1YIPg
         B+WLyV0XyW2ncKpUlUqyRO0h1882RgUiXLM7bNAxyoSoIpc8yrz3NIdCi/27fBBkALM3
         NJepV3yjYJYK48Bp/aHxEmyXIWAGcgeF4rV+13muLSA+uNpZ3Q0Z/70vZ8MYBM+i2qhS
         jtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEHozJpeDSITrolZfda9kBorCG4BMYLVcfyRfiEVHcA=;
        b=BKqBGpX2wJ5MOjqnHTsyEgFIv8hbi1KeDHxBkY1qLhQiCRedMR2qdY1RihBVNTyedh
         Ucb8+/c+tfRcN1d9Rq3lP9CKIOEpccPj2WVCkUv5azCY1kdw1NI0tIYtVrOoum6Q7xX3
         R+eEWOgyDuibplQiDu5/vnOsO9PGLZwP+9/R7riDP4Y5jyiqn0VYFM1z82AXKAjvNV7G
         jdAnvj7VydHCbk0hOm2jyBiP6SCNnxn/HC7AJhDCSf7ylpgfQMvgfDKnXPrJp8g2sSlo
         /gwNeiWL3ZcbM/OHMPRxM6++TwzpSxINzpvNJqcNEWIiAPhLAkHbC81m7toKN+wZYAWj
         lUVw==
X-Gm-Message-State: AFqh2kqsQm2oTQdR7cZyPKVvcIeT6ZS0VuMRRoZNtLcZhMGyajScDJFO
        9J8iDLh8Y7axwvD8nG9GopreCA==
X-Google-Smtp-Source: AMrXdXtgPYIvf8wFtTpwdRu3Fsq3233U22wehlRm4vsTYnSmPzyTOgcG8BVLIpwwaWtC3BqpY5FOow==
X-Received: by 2002:a05:600c:3ca2:b0:3d9:a5a2:65fa with SMTP id bg34-20020a05600c3ca200b003d9a5a265famr17977330wmb.7.1673004335186;
        Fri, 06 Jan 2023 03:25:35 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e18-20020a05600c4e5200b003d9876aa04asm1579012wmq.41.2023.01.06.03.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 03:25:34 -0800 (PST)
Message-ID: <b94fa5d6-7aa7-a6a3-e024-eed0dbf0f4b4@linaro.org>
Date:   Fri, 6 Jan 2023 12:25:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/8] arm64: dts: qcom: msm8916-samsung-gt58: Add Vibrator
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
 <20230105123240.1089375-4-nikita@trvn.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230105123240.1089375-4-nikita@trvn.ru>
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
> From: Siddharth Manthan <siddharth.manthan@gmail.com>
> 
> Motor is powered by VPH_PWR (aka Vbat) and controlled by GPIO.
> 
> Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  .../boot/dts/qcom/msm8916-samsung-gt58.dts     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

You just added this file in previous patch, so this should be squashed.
Patches should be organized logically and logical change is "new board XYZ".

Best regards,
Krzysztof

