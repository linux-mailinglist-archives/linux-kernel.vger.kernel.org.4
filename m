Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C578A6AB130
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 16:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCEPID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 10:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCEPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 10:08:00 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ED393CC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 07:07:58 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a25so28979032edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678028877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+neVuXVRnrANvFxVqN4SHPLgadpTjlAdNKyuMZJNRA=;
        b=RayjstsJL1gPx3R9RGNXSIZ0PnbJPEYWWPimaNREYn6RUGd/Xsut5FuB7DOmdiA8nF
         u3ajpokt2YQd+T8IWeFSazty3oy1eLHT2CK2+11JcP48Wog2E0tybzA0z6gQsnJdi/X1
         9fS59HiqlS9+SyfpcC07hyur7Jhm3RXU7qOitqpqKdOQk9tnS2daLAsCvXiUjO4lXo30
         61SwikKQjY/grr1eo1FeOjNzyRujuPubbz/iBCKSQ36OkgMU31G/bvLo/euCz2mzthrd
         dJq8OiKylmYUfDhdLDN+YP0+g+hHtJJr4CHy0PL7VreKCDx0eWLrGmV+SICBD1b/eIBP
         qD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678028877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+neVuXVRnrANvFxVqN4SHPLgadpTjlAdNKyuMZJNRA=;
        b=dv4o4npYqTm8PTcNS6PB/aZMAir6dcK2PB5iXxrgzsOfXdm2QB8PIxNrVryvKTLKVj
         6WP38JPSgvj7hOu77WNCyoWpdKAM+Vlm2v6+CSPph0OStDhTa4Yvy0k0/u2tn3jEjQT0
         2gvLiLzqWxMh0mgKHCgNRs1jDnGzl9Ks38HkQT5WxSqF05dd0HABGdAjGX9TamMKCLgi
         4b+pqE5OorqkahIlb82RkG1Zffbob1FBXLJ1p50TUDjPMLoHTpEh5MMhklHkdnQv1pUE
         Ait3pm04AaKtG4PEn4RLoiA21ak7PWnYgN4c/TKnxf8fdG72ClN5QQLDBW/D7LBd0aE0
         Gwjw==
X-Gm-Message-State: AO0yUKWjOnr6gULFx7ppPzh4Ez6yVnTPDEHzgysRYnle5pDLzD4SK+12
        ME6wTOZgCx4LSEeOGnxmYbyRIQ==
X-Google-Smtp-Source: AK7set/X8H/AMQ/7/DrgopAdxIsnjs/V7mzeTKaxNsdC4LObgLqe+GQEcRxM31OjDEMzvD31yusTdA==
X-Received: by 2002:a17:907:7da6:b0:8be:aba:e927 with SMTP id oz38-20020a1709077da600b008be0abae927mr9560756ejc.17.1678028877354;
        Sun, 05 Mar 2023 07:07:57 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:71e7:13d:1c29:505f? ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id h17-20020a170906399100b008d1dc5f5692sm3306201eje.76.2023.03.05.07.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 07:07:57 -0800 (PST)
Message-ID: <c4dc1d69-bb45-a75f-8b9f-095c0b627b7b@linaro.org>
Date:   Sun, 5 Mar 2023 16:07:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] soc: qcom: icc-bwmon: Remove unused struct member
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-ddr_bwmon-v1-0-e563837dc7d1@linaro.org>
 <20230304-topic-ddr_bwmon-v1-3-e563837dc7d1@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v1-3-e563837dc7d1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2023 16:39, Konrad Dybcio wrote:
> bwmon->regmap was never used, as the regmap for bwmon is registered
> through devres and accessed through bwmon's regmap_field members.
> Remove it
> 
> Fixes: ec63dcd3c863 ("soc: qcom: icc-bwmon: use regmap and prepare for BWMON v5")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/soc/qcom/icc-bwmon.c | 1 -
>  1 file changed, 1 deletion(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

