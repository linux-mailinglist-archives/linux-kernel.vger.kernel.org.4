Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5836E9082
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjDTKmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjDTKlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:41:52 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95658694
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:40:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4eed764a10cso476882e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987229; x=1684579229;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvpctlVTJ1U3NkaamvHUx4lltTx2+8ORxLeM8FtUVpM=;
        b=ApAKhT1sM3KPSUG0xc4B8WNojVMTwaVEy8yQ0NtoSlWtHiLV508ALD+W2+LyBqkcmV
         BJ10MPqeCcGHLEYrixfR5Hg/+TB2IA++Cih2ntgQVHQ8VZCSEk0+SLy89+kqMERRDlyG
         G/4KymO6c6wq/ahstnZVmmVqEKiB3X977c8LhhO1uz2lN2huNAT+OBUQDkpse6jKeIjh
         GAjCG3uiTdspE5kMf2hrxiEbnzsS6WJ1z4GArqBzeGh0cQBtVl8OhG/sHFug+9sGHurp
         Yg89E7oKGLrdvwis6NpIH7dZmkjfzc+b+C40/JVB+FLSypcrPXIyHEQV7de46Rc1if5B
         myjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987229; x=1684579229;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvpctlVTJ1U3NkaamvHUx4lltTx2+8ORxLeM8FtUVpM=;
        b=dPCP7PxJXAYvvgeZ/tvnT9BY7q4ysxDd8inQxqZEWKGoBhxxlSqCpRWBpCaqPALdVq
         Le7uRu0j9lgqWFKRMQlPkVtn3anHHyWTEcBAheYcu8Xp/jx0w7j3C11dBK5QhrAn1gW9
         hE0XtTVvEcQFyJVZ7SdutWfczJfWSqaTw/ZZdHZu2NYilpPD99qlRyl5W1+tSxk1Oc6M
         WKRLbBShZUfdMENiiHty2j+N7InVrnsmwcQO8WP9OkpKuphq+0KQDM5Wjt9QQUtvwZ5c
         ta/PND/rawi1Omx22wR7pq0TG4df61cRcyaJm+uux8KwIsEWG0yJAxqxz4pBaqy/eOZN
         5oKw==
X-Gm-Message-State: AAQBX9djy48X4oM2kXlc96fXAVgnuJ6pebHeXeRhn0o5DaqhYkZqvGcq
        IuN1pd1EkvRDK3adAlAyLq4B8A==
X-Google-Smtp-Source: AKy350bo4obzA3arKwwe6MWk7x6ej3rKRw0ia25dayIgHfP2h0gbpHYkQFjPBSqTrtkH/QImfQa61g==
X-Received: by 2002:a19:a40a:0:b0:4eb:5305:a70f with SMTP id q10-20020a19a40a000000b004eb5305a70fmr272344lfc.50.1681987228751;
        Thu, 20 Apr 2023 03:40:28 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id d25-20020ac25459000000b004eae73a0530sm176472lfn.39.2023.04.20.03.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:40:28 -0700 (PDT)
Message-ID: <bb28a19d-a6a4-89a2-1d7b-99146220d923@linaro.org>
Date:   Thu, 20 Apr 2023 12:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] media: dt-bindings: qcom: camss: correct unit address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420072442.36308-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230420072442.36308-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.04.2023 09:24, Krzysztof Kozlowski wrote:
> Match unit-address to first reg entry.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml | 2 +-
>  Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml | 2 +-
>  Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml  | 2 +-
>  Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
> index 12ec3e1ea869..abd444e12d05 100644
> --- a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
> @@ -155,7 +155,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/clock/qcom,gcc-msm8916.h>
>  
> -    camss: camss@1b00000 {
> +    camss: camss@1b0ac00 {
>        compatible = "qcom,msm8916-camss";
>  
>        clocks = <&gcc GCC_CAMSS_TOP_AHB_CLK>,
> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> index 6aeb3d6d02d5..db2604802d51 100644
> --- a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> @@ -221,7 +221,7 @@ examples:
>      #include <dt-bindings/clock/qcom,gcc-msm8996.h>
>      #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
>  
> -    camss: camss@a00000 {
> +    camss: camss@a34000 {
>        compatible = "qcom,msm8996-camss";
>  
>        clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
> diff --git a/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
> index b28c8e17f158..2f23baf32b61 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
> @@ -227,7 +227,7 @@ examples:
>      #include <dt-bindings/clock/qcom,gcc-sdm660.h>
>      #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
>  
> -    camss: camss@ca00000 {
> +    camss: camss@ca00020 {
>        compatible = "qcom,sdm660-camss";
>  
>        clocks = <&mmcc CAMSS_AHB_CLK>,
> diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
> index f9a003882f84..8f5c9aff37fb 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
> @@ -219,7 +219,7 @@ examples:
>        #address-cells = <2>;
>        #size-cells = <2>;
>  
> -      camss: camss@a00000 {
> +      camss: camss@acb3000 {
>          compatible = "qcom,sdm845-camss";
>  
>          clocks = <&clock_camcc CAM_CC_CAMNOC_AXI_CLK>,
