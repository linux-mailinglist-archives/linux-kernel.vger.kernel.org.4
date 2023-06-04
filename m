Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A2E72191F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 20:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjFDSFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 14:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjFDSFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 14:05:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A12ACA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 11:04:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9745c5fed21so451194966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685901898; x=1688493898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihBL6TJ8C6mU92dx3ETVIyIXq8wWv0W19OQrtjTVS6E=;
        b=FI30/lnyqGkqjoM7lJFPYMooptVi/7DeeM1KS/E0KPhdJXv8U4Eow239gWj/7KQwc+
         /V02myVs6yai/PTWZ4tQHmE+oXtxhX/cb4AVwYcQC4+6KvkTKclOH4chqPK78JOhhSjk
         O1bW0TsyxsAPdLAaE0FwspvFT84WXU2OEHSZkWrNXa4DolOdbGqinLMfbpGTLuNJgIk4
         8Q+iGmfaMAuoLpO76CTFxPzJGtJ4VTmDGFIw5uVp9e41q0z56jjWnQNBf2Te8K/OKO+n
         hzjArDemAds0fl9w5QcqedUGh6NfUTl90unSsFR4mMr+Axl1lcDhJBrIXd3HWWrI7Vvj
         yqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685901898; x=1688493898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihBL6TJ8C6mU92dx3ETVIyIXq8wWv0W19OQrtjTVS6E=;
        b=SNSGyjVpmddymQLx00aXdB/Xx9RA+zLdRs9yViIYhwjDeWVDQPYlmR9E4MAcucHWng
         bnDPVDk2GlR51AS3+w3BCF+G9kEoY0VjkFIMz/IYyBRrNbOPWSnXtWux2RTKe7TBAXHw
         If+ER+arqD1q63lpSx5P/ClHiVgYz37nPawSrzXu8mLGBld93sDarDdX+dm1Hxl3bJGM
         Hh/ZdYVi0VkItmndvOIdlrC7Jl5AQgsKyVA9VXxqdHQNya+YSdrI4nlmOLd7/hViJfUb
         IRe015z/87zIrRLdSlg/FIeT/C6bwyOA6hTORVW0e+yGxAiUbXJFuRrwqtx8Fim5Z8ae
         8iBA==
X-Gm-Message-State: AC+VfDy99UYdgKcA3MqF2GH4GfGmJp0BesJX/J/8u0FlCeQUNWnl5UZb
        On4D8Nd6CE1ERiaVaCxi00molQ==
X-Google-Smtp-Source: ACHHUZ4+vFM/nr8fGvYX+DNeO5lxMdAF0enwX9IrUSUB6khhTQ6PAinPxZOCuZMqppzelTPW9qs6IQ==
X-Received: by 2002:a17:907:9444:b0:974:391f:ed7d with SMTP id dl4-20020a170907944400b00974391fed7dmr4950469ejc.49.1685901898018;
        Sun, 04 Jun 2023 11:04:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906924800b00977cc473b41sm1356087ejx.142.2023.06.04.11.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 11:04:57 -0700 (PDT)
Message-ID: <3fe03b31-0cab-82cf-cbdb-766fdf34c44d@linaro.org>
Date:   Sun, 4 Jun 2023 20:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 04/12] dt-bindings: display/msm: Add SM6350 MDSS
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
 <20230411-topic-straitlagoon_mdss-v5-4-998b4d2f7dd1@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v5-4-998b4d2f7dd1@linaro.org>
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
> Document the SM6350 MDSS.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6350-mdss.yaml     | 214 +++++++++++++++++++++
>  1 file changed, 214 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
> new file mode 100644
> index 000000000000..6674040d2172
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
> @@ -0,0 +1,214 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,sm6350-mdss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM6350 Display MDSS
> +
> +maintainers:
> +  - Krishna Manikandan <quic_mkrishn@quicinc.com>
> +
> +description:
> +  SM6350 MSM Mobile Display Subsystem (MDSS), which encapsulates sub-blocks
> +  like DPU display controller, DSI and DP interfaces etc.
> +
> +$ref: /schemas/display/msm/mdss-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:

Drop items. It's just const.


> +      - const: qcom,sm6350-mdss
> +
> +  clocks:
> +    items:
> +      - description: Display AHB clock from gcc
> +      - description: Display AXI clock from gcc
> +      - description: Display core clock
> +
> +  clock-names:
> +    items:
> +      - const: iface
> +      - const: bus
> +      - const: core
> +
> +  iommus:
> +    maxItems: 1
> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    maxItems: 2

Are you sure you have two interconnects? Example is missing them.



Best regards,
Krzysztof

