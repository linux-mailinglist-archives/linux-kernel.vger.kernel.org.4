Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7085EC1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiI0L5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiI0L5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:57:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B6B1559C8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:57:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso2798494pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=y5lmTrzqdWHymKvsEYqPOE/O0/LRx2Cwl9fmLMzEmOQ=;
        b=BThqsMAiTHAnOAKVC/i+CHSTU6KtShcmnXaP4LpOMeXOwGdpcrWDd38R5Rg19ZTRUa
         nUiYKiWCANS7+odPqhmCZocOADyN9O2uDen3os/Rg9DgiOlp+7YOdOh4Q+glqiAxfd56
         P4+TU1fqGASnTAp9myIlJljxBXbWN0JdX/8U6ACnRvAX0sk+FQFXnnQJRoylbIv2lZMM
         E1T8KyxvFDT/hBQeI4Fw/JjZxC0LzmqyRzdUQvltdLoUMRF5+zX/p+ElNcJ1YXWDZFa+
         YuUGPZ83QOpk7mAerRhL8P8lQJNUuLFHSK3jRHBRdOFXiTJmiZoBlR1Tpqaw98pUky/4
         wFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=y5lmTrzqdWHymKvsEYqPOE/O0/LRx2Cwl9fmLMzEmOQ=;
        b=IpLMmgDstPPi0aHy8UL7g0FnWRRPUuBiOOI7xrkx+KG3sHPHfHsj5kWfidn0W4Bf1f
         tmMC2IEcqUQSKiMRx6ikJyimFcUTShbnU+IKAq5elz+fot23s78AUHk1I1OGirgYQWu+
         NzxOSadrtZ19kSRgPfFdmgAC8GArfO70Gu8GjJNXJ1Dteu6cbqDILqElH4f9ybvrrVYZ
         9pFFS4g+3Qza6shyiw18ipHCbcYzllaAzraLtcLloVhTGLOJcMjYXmOptRmcsfaGg43w
         UAITemOnKb9ZDPckRZHkbwacjI10CuuIdDh495LELlegQ6+e3aU06ND7KX5G6/tjEyBO
         JoBg==
X-Gm-Message-State: ACrzQf2CtNNZOOeBxMcur+m8jTMlSS5qQsbb+7HGYqejS69em4UdxWR7
        fZQYGGWTvTluHXMSs70+zSojWA==
X-Google-Smtp-Source: AMsMyM49WoPc4bVyIwg87F9mP1+nafrShy23pDex1lW27GK8scNP2rHA7ZFu84eJ+8073+3X8LC1ng==
X-Received: by 2002:a17:902:bd02:b0:178:1a1c:889 with SMTP id p2-20020a170902bd0200b001781a1c0889mr26716846pls.107.1664279857355;
        Tue, 27 Sep 2022 04:57:37 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:3adb:24f8:ac24:2282:1dc7? ([2401:4900:1f3b:3adb:24f8:ac24:2282:1dc7])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b00176a579fae8sm1302814pli.210.2022.09.27.04.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 04:57:36 -0700 (PDT)
Message-ID: <96ef23e9-4bf8-a92a-ea14-990621dfd3ef@linaro.org>
Date:   Tue, 27 Sep 2022 17:27:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5] dt-bindings: qcom: document preferred compatible
 naming
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
References: <20220720073326.19591-1-krzysztof.kozlowski@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20220720073326.19591-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/20/22 1:03 PM, Krzysztof Kozlowski wrote:
> Compatibles can come in two formats.  Either "vendor,ip-soc" or
> "vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
> DT schema file documenting preferred policy and enforcing it for all new
> compatibles, except few existing patterns.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Depends on:
> https://lore.kernel.org/all/20220627143340.477120-1-krzysztof.kozlowski@linaro.org/
> https://lore.kernel.org/all/20220628092253.21905-1-krzysztof.kozlowski@linaro.org/
> 
> Changes since v4:
> 1. Add qcm.
> 2. Add more qcom,ipq806x exceptions.
> 3. Add Rob's tag.
> 
> Changes since v3:
> 1. Add qcom,kpss-wdt-xxx to pattern for exceptions.
> 2. Add ipq806x entries to list of exceptions.
> 
> Changes since v2:
> 1. Narrow the expected pattern to be followed by dash '-' after model
>     number (msm8996-) or by two letters and a dash (sc8280xp-).
> 2. Add qcom,apss-wdt-xxx to list of exceptions.
> 3. Use comment instead of description in the oneOf list.
> 
> Changes since v1:
> 1. Add schema instead of readme (Rob).
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Alex Elder <elder@linaro.org>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   .../devicetree/bindings/arm/qcom-soc.yaml     | 65 +++++++++++++++++++
>   1 file changed, 65 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/qcom-soc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> new file mode 100644
> index 000000000000..9918b20e4478
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/qcom-soc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SoC compatibles naming convention
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>

Please use Bjorn's new email id.

> +
> +description: |
> +  Guidelines for new compatibles for SoC blocks/components.
> +  When adding new compatibles in new bindings, use the format::
> +    qcom,SoC-IP
> +
> +  For example::
> +   qcom,sdm845-llcc-bwmon
> +
> +  When adding new compatibles to existing bindings, use the format in the
> +  existing binding, even if it contradicts the above.
> +
> +select:
> +  properties:
> +    compatible:
> +      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      # Preferred naming style for compatibles of SoC components:
> +      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+-.*$"
> +      - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
> +
> +      # Legacy namings - variations of existing patterns/compatibles are OK,
> +      # but do not add completely new entries to these:
> +      - pattern: "^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +      - pattern: "^qcom,gcc-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +      - pattern: "^qcom,mmcc-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +      - pattern: "^qcom,pcie-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +      - pattern: "^qcom,rpm-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +      - pattern: "^qcom,scm-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +      - enum:
> +          - qcom,gpucc-sdm630
> +          - qcom,gpucc-sdm660
> +          - qcom,lcc-apq8064
> +          - qcom,lcc-ipq8064
> +          - qcom,lcc-mdm9615
> +          - qcom,lcc-msm8960
> +          - qcom,lpass-cpu-apq8016
> +          - qcom,usb-ss-ipq4019-phy
> +          - qcom,usb-hs-ipq4019-phy
> +          - qcom,vqmmc-ipq4019-regulator
> +
> +      # Legacy compatibles with wild-cards - list cannot grow with new bindings:
> +      - enum:
> +          - qcom,ipq806x-gmac
> +          - qcom,ipq806x-nand
> +          - qcom,ipq806x-sata-phy
> +          - qcom,ipq806x-usb-phy-ss
> +          - qcom,ipq806x-usb-phy-hs
> +
> +additionalProperties: true

Otherwise, LFTM, so:

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
