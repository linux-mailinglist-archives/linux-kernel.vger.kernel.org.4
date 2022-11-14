Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0111E62783F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiKNI4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbiKNI4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:56:52 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4C21CFF1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:56:51 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r12so18189415lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ri4akwZ0xvUVLQAp/5Ob5aHzDoTUSCyhLpmOby1nQCE=;
        b=h0T5rgIAh7mvHK11S0KL46dtaY+MFMB2vP/4rDFE8nbNRF9o2HKDLQiLTc+fpr20HZ
         42MO3SLavKuwlATTUzcKz/iskwa58jrXYPG9gcFxp/5gH/J5CrTX7TWAo3gImqqfaau7
         Rp/kyRoyJm3cPsXQkzLWftVKcoXrgoyH4PJ6q/Wf3s7X9afgrb0hSx0SDGFliSulr531
         alMKRkBsuwSbVbIaIq3FXG56Y2jl8s+GAuWz4ERBD/1652wG8euqJhC5V70rVA5BdxeQ
         wHrTwM9xOMojVKrM01tmgd7H/akeDt2g7QmYdEKSxtGGt9HfqTss+0l6NMNZn7QQqLAw
         JbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri4akwZ0xvUVLQAp/5Ob5aHzDoTUSCyhLpmOby1nQCE=;
        b=2uUFoTFWeNUraG974rskQ9YagBB9P7LG3a4CmE+9oFQDZsOY9DKgnPIBLNWunLioBX
         hxahvjznSx2yW9q+AnxN1jjwlnvI+jXPTxy6ZRhm8eovEdFC6ibygf7RXWV3c6CmbBra
         3LFAbPaW45nGKJyVSp1kaLXzqeca5amNUUk9luQbHAfELz5HLYy2xFjfFKRIn5YiXUW0
         bz8sFFc/guNX4ZE3zlh4c2luaAAUxSTH4ygzQ08JRzh1DfkAq7f6Si2i5jSxCJSQlNBP
         VGPIiaE7LkjvxlXROn1Lpscu8V3wp6FszSuV32WVw+cVHjRXJzidLjUHMKlrLrYMIEPm
         yUbg==
X-Gm-Message-State: ANoB5pnl9XLqpYagp9ylZVGFTehYEnxwpY+9Mxl/2fFMn4hC/vZxrIvy
        435N+N7vGM+zNv0HgSonZhZ7mg==
X-Google-Smtp-Source: AA0mqf7peKRHOfCrkrkLDpU9XwhXqp0/gEdWNtYaDrKgTLc4JGRKjljBQ9dpCMgBLUVQjztufP6+aw==
X-Received: by 2002:a05:6512:548:b0:4a2:253:715b with SMTP id h8-20020a056512054800b004a20253715bmr4121713lfl.315.1668416210027;
        Mon, 14 Nov 2022 00:56:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi36-20020a05651c232400b002771057e0e5sm1930786ljb.76.2022.11.14.00.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:56:49 -0800 (PST)
Message-ID: <69862090-6cf0-6a9d-7564-3bc375a4e6d2@linaro.org>
Date:   Mon, 14 Nov 2022 09:56:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V18 1/7] dt-bindings: Added the yaml bindings for DCC
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alex Elder <elder@ieee.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org
References: <cover.1668159970.git.quic_schowdhu@quicinc.com>
 <b3712e758f3c7bb91233d0cd330fc6616fc1f32d.1668159970.git.quic_schowdhu@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b3712e758f3c7bb91233d0cd330fc6616fc1f32d.1668159970.git.quic_schowdhu@quicinc.com>
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

On 11/11/2022 11:50, Souradeep Chowdhury wrote:
> Documentation for Data Capture and Compare(DCC) device tree bindings
> in yaml format.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,dcc.yaml     | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
> new file mode 100644
> index 0000000..15c56df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom,dcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Data Capture and Compare
> +
> +maintainers:
> +  - Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +
> +description: |
> +    DCC (Data Capture and Compare) is a DMA engine which is used to save
> +    configuration data or system memory contents during catastrophic failure
> +    or SW trigger. DCC is used to capture and store data for debugging purpose
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,sm8150-dcc
> +          - qcom,sc7280-dcc
> +          - qcom,sc7180-dcc
> +          - qcom,sdm845-dcc
> +      - const: qcom,dcc
> +
> +  reg:
> +    items:
> +      - description: DCC base register region
> +      - description: DCC RAM base register region

I propose to drop redundant "register region" from both. With this:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

