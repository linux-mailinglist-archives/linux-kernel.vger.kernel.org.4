Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F63B71FDB1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjFBJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjFBJWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:22:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C947A170A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:20:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f3b314b1d7so2350005e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685697648; x=1688289648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7Drlf6d0eSvdkz521tEpg/R4nVgFN4pBANk8O7IVXo=;
        b=fWDu+PB94bBQ8IVnM30BixX+jarI/2av8LptQBYAAJT+UuLUF+/L+ar0Qp9SDGOhUd
         ZtYLxjpm+hgsJsDzPRJSJlfB9butJpnVGK4RAc+sU/fnHSes5GJxqMgLbFVEY5+9Oe1s
         yvETh/loiAYPGA5/UeHFw6mAQm6yhydSZjgOhZLrOXzSLtCd0FDRjatxyhV1Bem8H5sc
         L9gEUO+866xafmkSVdPjLmIvSuKtls9zfNJa+1W9Sc6XGSRiNs/Z09Pd9jqijlrDNjVV
         dJmlJwLPXm4AFxFmBxuIntPXeJuEZgcz/GW5kjTKx4v6iTaU+w41GDH/g3luU7qLdEO5
         9dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685697648; x=1688289648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7Drlf6d0eSvdkz521tEpg/R4nVgFN4pBANk8O7IVXo=;
        b=c5GAOls8eKk25YefgOn52oF1ENLqNMihvYGlhJ41C2fncKaMFfiYv9h4XqRsImT9zg
         Rv/g9xrSNIiPtNh7o8fjWjTtp89OcEAXZA2HPNwROXiA0giHBrPQAy6vEtOsLZJnEoWK
         avl6cHHHoZxATLKFi8APbvUSx4DsX/Xg++9dYVhtd60FCgH4Yt4lkYKGciYIPLS5or60
         7EJ5EsfrEC6o2o1W37/koSBp/scq74RqOF7An+THoK4e3hb7RnsCItb96e3geVhYeNnI
         tRuzI340lAEr308d1uTck/pjLzyfW/lw9PEc9y2kqT7TCv1/1QEZO0wEApAJvBuUWcb3
         /KjA==
X-Gm-Message-State: AC+VfDzdNNAReLNm75tUdU8bgrEhmiVW1Tytts2rrZkRXUTP/7OJsvEU
        KLer39B1Eq6+2OGbrE+nd5tnHg==
X-Google-Smtp-Source: ACHHUZ4EYz1HyZloJ+9zE+uQrhFGGv98qfYWPJ97kHwe1Oz1FMC4Dbia+nxn7ICJC2XZU5lOqEid3g==
X-Received: by 2002:ac2:4578:0:b0:4ed:b4f9:28c7 with SMTP id k24-20020ac24578000000b004edb4f928c7mr1478901lfm.6.1685697648187;
        Fri, 02 Jun 2023 02:20:48 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id z7-20020a056512376700b004f3b4d17114sm100286lft.144.2023.06.02.02.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:20:47 -0700 (PDT)
Message-ID: <87ae0199-be94-b199-e043-55aa74520f0b@linaro.org>
Date:   Fri, 2 Jun 2023 11:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sm8250: Add missing interconnect
 paths to USB HCs
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230602062016.1883171-1-abel.vesa@linaro.org>
 <20230602062016.1883171-4-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230602062016.1883171-4-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.06.2023 08:20, Abel Vesa wrote:
> The USB HCs nodes are missing the interconnect paths, so add them.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
>  * None.
> 
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index c5787489b05c..08ea6396d364 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -3750,6 +3750,10 @@ usb_1: usb@a6f8800 {
>  
>  			resets = <&gcc GCC_USB30_PRIM_BCR>;
>  
> +			interconnects = <&aggre1_noc MASTER_USB3 0 &mc_virt SLAVE_EBI_CH0 0>,
> +					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3 0>;
> +			interconnect-names = "usb-ddr", "apps-usb";
> +
>  			usb_1_dwc3: usb@a600000 {
>  				compatible = "snps,dwc3";
>  				reg = <0 0x0a600000 0 0xcd00>;
> @@ -3810,6 +3814,10 @@ usb_2: usb@a8f8800 {
>  
>  			resets = <&gcc GCC_USB30_SEC_BCR>;
>  
> +			interconnects = <&aggre1_noc MASTER_USB3_1 0 &mc_virt SLAVE_EBI_CH0 0>,
> +					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3_1 0>;
> +			interconnect-names = "usb-ddr", "apps-usb";
> +
>  			usb_2_dwc3: usb@a800000 {
>  				compatible = "snps,dwc3";
>  				reg = <0 0x0a800000 0 0xcd00>;
