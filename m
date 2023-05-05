Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F3C6F869F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjEEQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjEEQYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:24:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2691891B
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:24:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9659e9bbff5so349198766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683303859; x=1685895859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOsC+7mQ12H8XAMAhE003bPySwrUQw/0QUxgIIw8mBQ=;
        b=EFL1cEjgNv1aConkpEiyPVcWGo1k8EG/5+VARBE/GofKOULWCTltGLl2HRGRRJd5Nt
         0dfvvn5O6whQhX2bdMnEqawUNWL4/172KqTZuheMFMc5vQynV7OmGFUSVH/PaD3YCNJL
         EVDrgMQx99BdvoBelTl9aJwpiwB+lDqSijIctxgX2kf1XCKAc0GaY23J4lgT4uvuNQbH
         kLZXC1hB9ctSGxtf2F91MhAErahxcu18ZaJ/81jmALFF1mZw4BtUk9pV0fecHo4xb0x2
         reXq3KcZdT1BPirUGrUeg4351OL2t0d/qkeRxrkCOfHXbVIQukrRFxaCikPdzU6T1/d8
         l+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683303859; x=1685895859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOsC+7mQ12H8XAMAhE003bPySwrUQw/0QUxgIIw8mBQ=;
        b=decXK1RXjL8tzRslDxNjbdeeAsbt9WycOhV9lunGTdFzh3YrCxdy2ZGryKD28ZF0zM
         Ly1mAhTBuZqXk9kWC447PH4GEny65A5QrrrZOLjY/Pz+XjmCnHN8VWLuHfPfwPMPqkHb
         Wp+OMkr+MsdiEwpsvdSo73ejvAhXBGY/yQG4wO0QMlKIKN6MSSqzdwyrUZbngWHqvdwV
         xC7pKUb59jyGt5CSoUSz3ntDGye/YRl4q2A8kb4cnASZDef4K9JnnVg1W+YyD76GtgyL
         PZ5HB2KJkpfdjrVv6rC2zuWYyln7vrF9mBOV3NPlsXqDtxjbZn02e4wkVT0asxuGpveE
         tYaA==
X-Gm-Message-State: AC+VfDzSSt4tkffuMJLCvUGZB/7BoQJlRn5pOfe74Xd4T0x8Q0ZA1BDU
        hmQBYb/QAFb2iLAp/UYBOXD98dgxd9UwKnogbAZCVw==
X-Google-Smtp-Source: ACHHUZ59msLJ2mB6dF6aa/iMQi768x0mvN63nnwgqTzVM2vQRUMx/o8H4Yxd7vLs+bi9Cgd2ybWu8A==
X-Received: by 2002:a17:906:4787:b0:94a:658e:1180 with SMTP id cw7-20020a170906478700b0094a658e1180mr2061781ejc.26.1683303859473;
        Fri, 05 May 2023 09:24:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id u3-20020aa7db83000000b0050c04bcc3b2sm1914373edt.64.2023.05.05.09.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:24:18 -0700 (PDT)
Message-ID: <fe326d38-ee52-b0a4-21d8-f00f22449417@linaro.org>
Date:   Fri, 5 May 2023 18:24:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/5] dt-bindings: soc: qcom: eud: Add SM6115 / SM4250
 support
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
 <20230505064039.1630025-3-bhupesh.sharma@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505064039.1630025-3-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 08:40, Bhupesh Sharma wrote:
> Add dt-bindings for EUD found on Qualcomm SM6115 / SM4250 SoC.
> 
> On this SoC (and derivatives) the enable bit inside 'tcsr_check_reg'
> needs to be set first to 'enable' the eud module.
> 
> So, update the dt-bindings to accommodate the third register
> property (TCSR Base) required by the driver on these SoCs.
> 
> Also for these SoCs, introduce a new bool property
> 'qcom,secure-mode-enable', which indicates that the mode manager
> needs to be accessed only via the secure world.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,eud.yaml   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> index f2c5ec7e6437..3b92cdf4e306 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> @@ -18,17 +18,33 @@ properties:
>      items:
>        - enum:
>            - qcom,sc7280-eud
> +          - qcom,sm6115-eud
>        - const: qcom,eud
>  
>    reg:
> +    minItems: 2
>      items:
>        - description: EUD Base Register Region
>        - description: EUD Mode Manager Register
> +      - description: TCSR Base Register Region
> +
> +  reg-names:
> +    minItems: 2
> +    items:
> +      - const: eud-base
> +      - const: eud-mode-mgr
> +      - const: tcsr-base
>  
>    interrupts:
>      description: EUD interrupt
>      maxItems: 1
>  
> +  qcom,secure-mode-enable:
> +    type: boolean
> +    description:
> +      Indicates that the mode manager needs to be accessed only via the secure
> +      world (through 'scm' calls).

I understood tcsr-base aplies only to SM6115, so this should be further
constrained in allOf:if:then:.

Best regards,
Krzysztof

