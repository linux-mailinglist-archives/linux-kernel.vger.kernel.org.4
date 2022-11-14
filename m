Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230AD627C85
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiKNLlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbiKNLky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:40:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE941A3A8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:40:53 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a14so17696321wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HD1FJFbm4qiZjnfWZv0nv02BdZLPwZIxvvXLBcQxcA0=;
        b=QmW79Pi/kv1ijN/1fegsnzJHDHy3kLhMK5xERnfBLW2M0pZRGeAj1t27J/Oitxj/7g
         SG4XgfHWHcYusKaWxzs8mbsyMyfKVyFe0rim95+XX5d9lj4SBjwRUG4vspeAn/Vw96bY
         /5oy1I22lKS0ag4QNAyM6CfxxyYrOAG2JgyF4f1uepWaW5gL1lw1V/46Zziglr4Iv4LT
         gn4UPpVWv5WeJXmDfwWgOJ8KQTBmhnOBjwc88b8/YvtKuy4cnImwecsto9d9Haovdvrq
         1WCMRLaGdNwVNcWxjeSGjndiK2bcshHuqv+WzxrzMLB4j6c1/1a3oqB4eiSDGjpJ050x
         IPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HD1FJFbm4qiZjnfWZv0nv02BdZLPwZIxvvXLBcQxcA0=;
        b=3fbOVC+08eURaJKKjmWeyUqdm3JVelIk8iovQDz0OL4ErGIFvZsmdIVbBEBbMXwT19
         HzcWMKoB8zttyjgS/NQWPa5SUDS5rFypBrTR5ZPL+7stCG63SZHc/jK3CAsnNBMpmV56
         m0UDgVB376uNMN9sKqVz4bG+upmRqmx8iN8ZI/cG/mmQe6t+3GJS4H9Qpm9PW50MdOom
         Aj0l8Z76zaiyKU2iRQGjOmny5mGa8qgFuDCHmI2Ks2xjMK7y5HDXAMoXEEkqpwYf5v4b
         alUchBCeVsVW3NzUNqXpxGEcxSrCy6MXmBSSmPo7eqFejD4xp2FM04QZ3xHs2sJ8gpp/
         lffQ==
X-Gm-Message-State: ANoB5pkTKq43xt655bp/P7ctWUE7LGsnLvQXGbGtK7uCO48gUVHy5Ayi
        gO0fvv0uzAwlwB2GCAnp1ZN6RQ==
X-Google-Smtp-Source: AA0mqf7w6FsqMHPLvaGe1VAW4QNqBhCJzebNX55AWaprvEM0JnmljxZjn1eeQRgPy1WX1yhoGrB/fQ==
X-Received: by 2002:adf:cd91:0:b0:241:695c:4eec with SMTP id q17-20020adfcd91000000b00241695c4eecmr7437995wrj.174.1668426052149;
        Mon, 14 Nov 2022 03:40:52 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id z15-20020a056000110f00b0022a3a887ceasm9327509wrw.49.2022.11.14.03.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 03:40:51 -0800 (PST)
Message-ID: <cf66aa8f-4bf7-d9c0-e2ae-b6fced7e4948@linaro.org>
Date:   Mon, 14 Nov 2022 11:40:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 10/10] ASoC: dt-bindings: qcom,q6apm: Add SM8450 bedais
 node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Lai <plai@qti.qualcomm.com>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>
References: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
 <20221111113547.100442-11-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221111113547.100442-11-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2022 11:35, Krzysztof Kozlowski wrote:
> On SM8450 and SC8280XP, the Q6APM is a bit different:

This is not specific to SM8450 or SC8280XP its part of AudioReach apm 
which deals with both backends and pcm.

In old Elite architecture we had a dedicated service AFE to deal with 
Backend dais, now APM does all.

Thanks,
Srini

> 1. It is used as a platform DAI link, so it needs #sound-dai-cells.
> 2. It has two DAI children, so add new "bedais" node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/sound/qcom,q6apm.yaml    | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
> index 7acb832aa557..cd434e8268ce 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
> @@ -18,14 +18,24 @@ properties:
>       enum:
>         - qcom,q6apm
>   
> +  bedais:
> +    type: object
> +    $ref: /schemas/sound/qcom,q6apm-lpass-dais.yaml#
> +    unevaluatedProperties: false
> +    description: Qualcomm DSP audio ports
> +
>     dais:
>       type: object
>       $ref: /schemas/sound/qcom,q6apm-dai.yaml#
>       unevaluatedProperties: false
>       description: Qualcomm DSP audio ports
>   
> +  '#sound-dai-cells':
> +    const: 0
> +
>   required:
>     - compatible
> +  - bedais
>     - dais
>   
>   unevaluatedProperties: false
> @@ -41,11 +51,17 @@ examples:
>           service@1 {
>               reg = <GPR_APM_MODULE_IID>;
>               compatible = "qcom,q6apm";
> +            #sound-dai-cells = <0>;
>               qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
>   
>               dais {
>                   compatible = "qcom,q6apm-dais";
>                   iommus = <&apps_smmu 0x1801 0x0>;
>               };
> +
> +            bedais {
> +                compatible = "qcom,q6apm-lpass-dais";
> +                #sound-dai-cells = <1>;
> +            };
>           };
>       };
