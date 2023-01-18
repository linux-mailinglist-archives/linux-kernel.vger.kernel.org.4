Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BE6672086
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjARPFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjARPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:05:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7703252F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:05:15 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso1734478wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sy9FqaPskON5MA8I0+FqJ4Z9VJahIZ8FHzsydP66LsA=;
        b=EzfKz8WBnZ8u2u0ulDL+VpHXYEdT+jUt1JdhVpDIyiU+lKlKlNCgThRuQuvU7QziEF
         A8w717ibNv9S9bMN531O/JeikVT6XyT/5Ql/wZrtsMNdk8XhhNq3/pXy69DpUA2ZXMHI
         USDop2hSeGr4d/jqYd/ZlNqs7m3Nd6+zVsDxSBv0uIor/yoMHOiCHn4Bw9RanPtNCINZ
         EBALUequjrD8pb5EBfojehzDYA8fKbTPqze2SmoFhF6veoflzcLoGzA6X5VlzmMP/hYp
         WEgPNmhnZFsMeOtxMaW4yk+rZv+gljOVwcDnwGuZLqMTYA7hiTpimdVASafEkD/sQHvd
         tvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sy9FqaPskON5MA8I0+FqJ4Z9VJahIZ8FHzsydP66LsA=;
        b=fDStahyskZN8qkn2WK4TLgg4aVv7Awoa/ZDqQyyehiyxhY3rb3x1ChEIllnJPpAxEf
         VWb75JekkU3vnx3maSch2JBsj+d7wN3xGsViDURclzUlNsrKoxCeU7oUc5q32nyM+YLL
         v7StEDx6q7NTb4xVB44DSFXfwVQeLz4Tx3Dd3b84pX/LtUQBGpVVT5owscuy1Z2fAFqo
         Wg8VDLUNkB1SIJSI9WE05GV6F39ouz+Cgtts/QLSqEYB9oOBqpCSsza7tYbV6z/upxSt
         LCAYW4Qi4uihkNIMNx4xYe8E/jnbXTB19wmtdGb4kCqLFxo2KKi3hJdH+U6M+rvMLnMd
         QZFw==
X-Gm-Message-State: AFqh2kpLp61Abceq85J2NWyL0MdWsp1KqbJfLDtplqaU/SHaNbVXCrB0
        uKIg3a1I5VbBUfoTg/msh3CGDA==
X-Google-Smtp-Source: AMrXdXvlSfmfkb6rb42n86ovGFgnlYFhIh6UVJnQTf89DfwPrVph3fOYFhqTCUoNp2NyU+J5tv+x7g==
X-Received: by 2002:a05:600c:1d8e:b0:3d9:f9ef:3d23 with SMTP id p14-20020a05600c1d8e00b003d9f9ef3d23mr7327500wms.23.1674054313725;
        Wed, 18 Jan 2023 07:05:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:37dc:5071:959c:93e4? ([2a01:e0a:982:cbb0:37dc:5071:959c:93e4])
        by smtp.gmail.com with ESMTPSA id az9-20020a05600c600900b003b3307fb98fsm2345343wmb.24.2023.01.18.07.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 07:05:13 -0800 (PST)
Message-ID: <5ab38158-6e75-ea9c-f788-f3a2d77dbbe7@linaro.org>
Date:   Wed, 18 Jan 2023 16:05:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] dt-bindings: interconnect: qcom-bwmon: document SM8550
 compatibles
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-bwmon-v3-1-7d63d2ae6bce@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221114-narmstrong-sm8550-upstream-bwmon-v3-1-7d63d2ae6bce@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

On 09/01/2023 13:11, Neil Armstrong wrote:
> Document the compatibles used to describe the Bandwidth Monitors
> present on the SM8550 platform.
> 
> A BWMON v4 IP monitors the CPU bandwidth, and a v5 does the LLCC
> bandwidth monitoring.
> 
> This is described by adding "llcc" and "cpu" into the compatible
> strings to differentiate the BWMON IPs.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Gentle ping,
Neil

> ---
> --
> ---
> Changes in v3:
> - rebased on v6.2-rc1
> - Link to v2: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-bwmon-v2-0-20c555e3ba5d@linaro.org
> 
> Changes in v2:
> - Reworded commit message
> - Added Reviewed-by from Krzysztof
> - Link to v1: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-bwmon-v1-0-b6dd08927f35@linaro.org
> ---
>   Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index 0c720dbde36e..12a0d3ecbabb 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -27,11 +27,13 @@ properties:
>                 - qcom,sc7280-cpu-bwmon
>                 - qcom,sc8280xp-cpu-bwmon
>                 - qcom,sdm845-bwmon
> +              - qcom,sm8550-cpu-bwmon
>             - const: qcom,msm8998-bwmon
>         - const: qcom,msm8998-bwmon       # BWMON v4
>         - items:
>             - enum:
>                 - qcom,sc8280xp-llcc-bwmon
> +              - qcom,sm8550-llcc-bwmon
>             - const: qcom,sc7280-llcc-bwmon
>         - const: qcom,sc7280-llcc-bwmon   # BWMON v5
>         - const: qcom,sdm845-llcc-bwmon   # BWMON v5
> 
> ---
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> change-id: 20221114-narmstrong-sm8550-upstream-bwmon-a7c6227fab6d
> 
> Best regards,

