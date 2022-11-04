Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC5C619FD2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiKDS0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiKDS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:26:03 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950972CDC7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:26:00 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id l15so3535631qtv.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfL7V4DF1mS3vb8oqJLZ9Gcqha+6hsSCkIaoJBiXjNs=;
        b=hZ45UrgvnMBkKwFxLXOJAK+Zy5Hr7AbMOYWwGcaKxaqQAnUKiYIgA4ALSxrpqbU26l
         ntDqmGq7VJz4XT0ewcP/7fmiiOxSg5lh52S7U7uM1RsPJYrdWPKgQ1jx/tQLJ3qHjkjx
         dx6WtS3nL5P6k3AGtYXIiODXLADcY753QzH7Y2IQB0Mx5aPGWUCFkXeRSG38Yw+WCQGd
         4/rBputwHFKyYP0/o9mQWhDOQUqB8ntM3e7zIrBkIpmFGbECI/kvstRaaOc9gxT42OU3
         6Z/DCZZgLroiFPdodxEwdJeCoE8HZrruEQjLhiG5fEiuRt2JG79OGLmnrGq55bN4ZKdy
         c9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfL7V4DF1mS3vb8oqJLZ9Gcqha+6hsSCkIaoJBiXjNs=;
        b=NI+zGdyx7wDNAHStN6dETPWeW+V0xBlvV64dHT9AFFW8v8yRyeA6JIZtbKkgIocDmN
         j7M1dH7nz5fRyK9HfvVXzC9sddGnuGG4MJNlixh5421yLfRr/ON/3iYb7uOMjke1tYCL
         wDIgc6g4MIq3f5IzNLui1xz9K8H5r3w0VyVF7CEqK9AQaDGfHdFmXwCCwnXYNAl2mCwx
         4H0KwJNXO1QEkBlo+OiacQe2r58CYKD5Nt0hsuAmxzgAVqPxy/9ZWl9pTe8Ok2qwKV3G
         SVP+0siGwrTs+ck3DXi4UI/04cTxo0QrURbAq5kRMf19iWiXOFe9vOYMfzlOY4NQ3qPR
         urJw==
X-Gm-Message-State: ACrzQf2TJhYdy0oG+2rKN3i6GP4uCiJ1R+FJt5I3FvC7qoevJWIa0ZXP
        zhPOAh//ej+Z8xZcLh5o6tECJA==
X-Google-Smtp-Source: AMsMyM7ETgFuQuJS4Pf7TVNZ2lJ1PI/dtDHKr3X3V2+0ESFbqR4ytfCG99oiYQzezcRbWGyXJcB/PQ==
X-Received: by 2002:ac8:7d07:0:b0:3a5:723d:9de4 with SMTP id g7-20020ac87d07000000b003a5723d9de4mr2021169qtb.558.1667586359765;
        Fri, 04 Nov 2022 11:25:59 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a44d300b006fa2dde9db8sm3408762qkp.95.2022.11.04.11.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 11:25:59 -0700 (PDT)
Message-ID: <c904b95c-f686-0a54-f697-ef0d35e37102@linaro.org>
Date:   Fri, 4 Nov 2022 14:25:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/9] dt-bindings: nvmem: Add compatible for MSM8976
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
 <20221104172122.252761-3-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104172122.252761-3-angelogioacchino.delregno@collabora.com>
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

On 04/11/2022 13:21, AngeloGioacchino Del Regno wrote:
> From: Marijn Suijten <marijn.suijten@somainline.org>
> 
> Document generic QFPROM compatibility on MSM8976.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> index 2eab2f46cb65..cac7be59c3cd 100644
> --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> @@ -22,6 +22,7 @@ properties:
>            - qcom,msm8974-qfprom
>            - qcom,msm8916-qfprom
>            - qcom,msm8996-qfprom
> +          - qcom,msm8976-qfprom

Put it before msm8996, although order is already broken.

>            - qcom,msm8998-qfprom
>            - qcom,qcs404-qfprom
>            - qcom,sc7180-qfprom

Best regards,
Krzysztof

