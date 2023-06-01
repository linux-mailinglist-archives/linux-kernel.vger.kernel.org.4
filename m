Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C4B719C03
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjFAMXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjFAMXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:23:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB509119
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:23:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f3b9c88af8so904434e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685622215; x=1688214215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6EO4znPlGyPioDpISoDQQKhy8b33gnVoI3J9XkVoqI4=;
        b=oUg4qvp8oLqzJnjoL3K9BcS30EdCA9l4T1upxsgGfO6KoVOumBQLjxS7C4NjMLLc1q
         ummZQIwIVQROr4RsKJ3uuU9ST9tkNXA1b/DvPD4cZKyirgnaR6n5pRqU42dwD0zwcM/g
         CSeaE/5+yjh2v4HPyYp9GevEA0cboqcL23j/lBhIYo24CuUUKqczEaNmgxZUvGr/TEQl
         2P5B943twhasFdeAdQJsxG0MQZQdKABcHvu7NbsHzoV+oG8s6+W/3s11UrY3yH3iNAYr
         6FOwEf+wFjTKQteNZZLTAchD95BqbLyYT563ERomkhBwRt+YI/LGV/Xad/iuOPc52xJ4
         SXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685622215; x=1688214215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EO4znPlGyPioDpISoDQQKhy8b33gnVoI3J9XkVoqI4=;
        b=bUDqrAv2Xh4jbcGHnTjbpGk55IZ0gvfeQraStLLtHZODlQr8MZ3/eTvn4dkP+Ea+Lf
         1cczBejJ+bNURSCyh66soDZfQx+KR6ZDtOXN4xGtY5NilvKl6NJE0VrcpD56sykiWiGR
         h4aX2dJ5zXkqSaoGZuI2Mi/U+UIiEkRnFgsQBfwEksuHZdEbyC3CuoTQtAz+XojSSDOc
         hSUzQJXRokwQe1oFTsQvFRxB8UwrR5b7z0BWXVaTS9+JRTJOQBOjGfnG/mrKPZ33oGro
         x2fnzrF8YLdDT7NyQzkw0pNIYlFmNz6AMIrM7/PTvi4NY1ccvGZNK50EioK7mYJN1K6o
         22VA==
X-Gm-Message-State: AC+VfDw3vh80MUMcta3alPOfodNS8IejhlXA2Sqz8yH/9tmKWR2aah7y
        M8b1Q4PD1Zafu5oxGZYQhSY1mw==
X-Google-Smtp-Source: ACHHUZ5MuICtOxcLaiP3bFamo3/X2G5wiI2qLOKcLbRIJjwqVGMyUXDe4MxvDnMctwm5C64PfLbPNQ==
X-Received: by 2002:a19:ae04:0:b0:4f2:5ef9:45fb with SMTP id f4-20020a19ae04000000b004f25ef945fbmr1205725lfc.52.1685622215115;
        Thu, 01 Jun 2023 05:23:35 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u4-20020ac248a4000000b004f3b5af3971sm1073849lfg.104.2023.06.01.05.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 05:23:34 -0700 (PDT)
Message-ID: <a19b7ff8-d253-f021-0987-f9ff13cddf93@linaro.org>
Date:   Thu, 1 Jun 2023 14:23:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sm8350: Add missing interconnect
 paths to USB HCs
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230601120029.38859-1-abel.vesa@linaro.org>
 <20230601120029.38859-3-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601120029.38859-3-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 14:00, Abel Vesa wrote:
> The USB HCs nodes are missing the interconnect paths, so add them.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 2798a5d6e5f7..88ef478cb5cc 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -2304,6 +2304,10 @@ usb_1: usb@a6f8800 {
>  
>  			resets = <&gcc GCC_USB30_PRIM_BCR>;
>  
> +			interconnects = <&aggre1_noc MASTER_USB3_0 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
> +			interconnect-names = "usb-ddr", "apps-usb";
> +
>  			usb_1_dwc3: usb@a600000 {
>  				compatible = "snps,dwc3";
>  				reg = <0 0x0a600000 0 0xcd00>;
> @@ -2373,6 +2377,10 @@ usb_2: usb@a8f8800 {
>  
>  			resets = <&gcc GCC_USB30_SEC_BCR>;
>  
> +			interconnects = <&aggre1_noc MASTER_USB3_1 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
> +			interconnect-names = "usb-ddr", "apps-usb";
> +
>  			usb_2_dwc3: usb@a800000 {
>  				compatible = "snps,dwc3";
>  				reg = <0 0x0a800000 0 0xcd00>;
