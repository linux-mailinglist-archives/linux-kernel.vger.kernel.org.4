Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292AD721918
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 20:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjFDSEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 14:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjFDSET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 14:04:19 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CABCD
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 11:04:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1adf27823so30805221fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685901857; x=1688493857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E6DdRLr2TjxHy9a+2vdxjdHBWvlVPaRau3klIPrpWlM=;
        b=p8kHwcK4JTrNT73H1DYZCvuIAcSrhjn54ADwSLe2SeDuzY8oXFG3X1QlAdW0pVJ7BF
         S74lQ25JtK7FT86yD066D3R1wbWqOfSmC7KJQ52k046x/Frtwwowk+m4L1WwRLzhvrJe
         YjuP9OrCbqKSrpa6FDi/5sWB0yYjFH8LVyR/jOijCNjciNPNHrz33AMIkD6ITCTBEJAI
         HR0cBQTqCwvSqk9f5FYhhFkfq68WzmBHEG3MaNfmdiPe3LfpoJBFJPVhFbXwlPAlBHnG
         GWQ57BMeHLUZCAVfFHOK8i3axjCFm5nZQUVlowlKiuQOJoDT0f4WLe74Qimjv02IWEeC
         g+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685901857; x=1688493857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6DdRLr2TjxHy9a+2vdxjdHBWvlVPaRau3klIPrpWlM=;
        b=TneR1CdDvLizTJQpGcJzHrN2j0Td1/UIjKHO6zzE7zMxWEqsEOlGuk6Jw3HCr7HWMN
         ghKGaWpDYC6Nr281bthq2NrPX5fbgbfay4RtdjTDDpWjlklEBDwBd+H4yzuRWuuUrhGK
         ieHzgVv24MVIcRiq09k77hDTmzEpA7alCicwrEgug6nkpZjm0DjZnvDgqCadzhDLAEef
         CO4Y0vwTKYEmJLd2O9b7pEI6aFYRAox83bZJo42CU7M8qZeNt821Li3nRbsWbqQOOA6g
         rfgJMWMrJx/GNsrt5EqkvA6nC4kpMuWl+kq+iQi2j+x98KMZDej9P4IYzK7Kl/gCynEI
         6slA==
X-Gm-Message-State: AC+VfDwhS99HJDpJ9PFlXegOqCKmgGoDAQAkdjEmMwtjPbbUVcmYrfEg
        idSVDBpY7pAfpWhotBP6bTf0vg==
X-Google-Smtp-Source: ACHHUZ46X3lru4R/WJZfQWHDGHtTgyak4bbLArH7wZzk6XasZj7cIWrOhk04VqIPmV3EU+NsbEoS2A==
X-Received: by 2002:a2e:2419:0:b0:2ad:d6cd:efdd with SMTP id k25-20020a2e2419000000b002add6cdefddmr2538240ljk.32.1685901856667;
        Sun, 04 Jun 2023 11:04:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709064e4600b00965b416585bsm3286670ejw.118.2023.06.04.11.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 11:04:16 -0700 (PDT)
Message-ID: <e9da7236-5915-b9df-59dc-c2baa960f52b@linaro.org>
Date:   Sun, 4 Jun 2023 20:04:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 05/12] dt-bindings: display/msm: Add SM6375 MDSS
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v5-5-998b4d2f7dd1@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v5-5-998b4d2f7dd1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 09:46, Konrad Dybcio wrote:
> Document the SM6375 MDSS.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 216 +++++++++++++++++++++
>  1 file changed, 216 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
> new file mode 100644
> index 000000000000..3aa4f0470c95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
> @@ -0,0 +1,216 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,sm6375-mdss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM6375 Display MDSS
> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +
> +description:
> +  SM6375 MSM Mobile Display Subsystem (MDSS), which encapsulates sub-blocks
> +  like DPU display controller, DSI and DP interfaces etc.
> +
> +$ref: /schemas/display/msm/mdss-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,sm6375-mdss
> +

Same as 6350 - drop items.

Similar concern about interconnects, although we don't have header file
for them, so I assume we will fill it up later.

Best regards,
Krzysztof

