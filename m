Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE616AB11E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 15:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCEOwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 09:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCEOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 09:52:07 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E60D532
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 06:52:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a25so28879590edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 06:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678027923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBZSdN0DyHSO54HE9hS1dDLmyIrE4P9z0Pt6ulnNjQg=;
        b=UJsE7qIVwTaD8wsBWGkcvFux/apLI9B2J7s1V02XolGy2yvqrpwKbl8mmKSi4CLI8a
         PCjDQYEPRlDwboQ4P/ms0X8+9zCN9uUT+ik6FFoyGmAzn/zYRaxeDZtva1J2zt+ZwARa
         TYI7FH5a0WYD5ggbvcS4SpIQX2cPEF/uFG5udi9hHxIeVvF69S8MnyhDIKmRAB8YjsWD
         0/Jtt6lotbRgENoYJWdm4IyVslnRdZmiuWOQk42mKIFvhz0Qs1sE8NShTN1Lu3HDrYiN
         GkEYb3hKoi69QRXmnR8i+a7tSW3VlO1dyJ7tTlo/MtZhRZoh5GbIFJdf/bbP8VSROpbj
         h/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678027923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBZSdN0DyHSO54HE9hS1dDLmyIrE4P9z0Pt6ulnNjQg=;
        b=bGIML/J2S4cnKYt8oDQBE0LPaoGt3auhTurr13EWmacXBgVRKh5WhCVRst9V5IjmFO
         4En3g6s00464fM0o9o3udfXkoRNrxUOmvN9D1bFVop559sVco2BVtonuCHACjsUTRD5L
         dsGNmAJLWHLr9V7Va9njdzVS/opEZEhD2BSly4xPQbHzQhtGNHHUs/PEaqSV6tqIyS1i
         EVf3i2boEbSd2ioq5S8laNLbqAziaqOIjl21WG7EsL31D9ZirQnfeuzYJ6MjRChkPC20
         S30FT8e+Qm14ljtLKii8N5ClrzdVauR1fyzXGoVacj9P2mS2VyI1/susuHU4Vhqm5l0J
         qrzg==
X-Gm-Message-State: AO0yUKWkQIfySgW46W+I80tj3xVnty/7pXuyzhLgK0U9hjC0tUwxSfss
        XL2Tv/6x56xIm/hINWf/nuur8w==
X-Google-Smtp-Source: AK7set/F+sXy8LkpD8XCOmy+yyZa+HkKpCcFPKUsnRhHZqgS2BvgLkz6K9jC7HKFnuxsXl0H1EjGHA==
X-Received: by 2002:aa7:df93:0:b0:4ab:5ce9:9f83 with SMTP id b19-20020aa7df93000000b004ab5ce99f83mr7850828edy.23.1678027923659;
        Sun, 05 Mar 2023 06:52:03 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:71e7:13d:1c29:505f? ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id hy3-20020a1709068a6300b008e57b5e0ce9sm3302506ejc.108.2023.03.05.06.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 06:52:03 -0800 (PST)
Message-ID: <0e74ad9a-2333-ea9e-b569-1bf8c965b217@linaro.org>
Date:   Sun, 5 Mar 2023 15:52:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 global registers
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
 <20230304-topic-ddr_bwmon-v1-1-e563837dc7d1@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v1-1-e563837dc7d1@linaro.org>
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
> The BWMON has two sets of registers: one for handling the monitor itself
> and one called "global", which we didn't care about before, as on newer
> SoCs it was made contiguous with (but not the same as) the monitor's
> register range. Describe it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/interconnect/qcom,msm8998-bwmon.yaml  | 28 ++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index 12a0d3ecbabb..6dd0cb0a1f43 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -49,9 +49,13 @@ properties:
>      type: object
>  
>    reg:
> -    # BWMON v4 (currently described) and BWMON v5 use one register address
> -    # space.  BWMON v2 uses two register spaces - not yet described.
> -    maxItems: 1
> +    # BWMON v5 uses one register address space, v1-v4 use one or two.
> +    minItems: 1
> +    maxItems: 2
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
>  
>  required:
>    - compatible
> @@ -63,6 +67,21 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: qcom,msm8998-bwmon
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +
> +        reg-names:
> +          items:
> +            - const: monitor
> +            - const: global

else:
  reg:
    maxItems: 1

and either disallow reg-names or move it to the top-level.

> +
>  examples:
>    - |
>      #include <dt-bindings/interconnect/qcom,sdm845.h>
> @@ -70,7 +89,8 @@ examples:
>  
>      pmu@1436400 {
>          compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
> -        reg = <0x01436400 0x600>;
> +        reg = <0x01436400 0x600>, <0x01436300 0x200>;

That's not correct for sdm845. It's only one address space for sdm845.


Best regards,
Krzysztof

