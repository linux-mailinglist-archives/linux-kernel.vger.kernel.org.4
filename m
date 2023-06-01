Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630FB719A04
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjFAKma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjFAKm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:42:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C1D7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:42:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso782663e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685616143; x=1688208143;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+470pxYI9g+zwhL70txOmxyrEQyx3w/ogxw7euLiFdc=;
        b=JMf+yJQmL5e9LnfDJdj/ansYBW7Vsljq1dWJlGbXnbzdXH+qcuPXBTmnPnm8B3VchD
         z1D8yShkk3juf2nPQ9WrKPDOkwmqEb8rxQa1CyPFc5wmDCTRdM5JCXNPbnblClkzO7Av
         tBk8AOJKixTW2EQ+8zmZqvLyfE4p/bGeFnI0nRtThukcqL/N4cK0DbThrmpoG8V8W/Xy
         yaZd6F9sS0cfQLpZ/7a33hFeojQwMKd+9SZOSRDMesfJYpSuvfD810hvSVDQ4283Vp01
         vTHHZf06wNTqedykL8gUuNZr8/eFf2VW3g2eIsMq7dpY4xXhE7a6bRaOO3LZkDGik0Ol
         vFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685616143; x=1688208143;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+470pxYI9g+zwhL70txOmxyrEQyx3w/ogxw7euLiFdc=;
        b=Wlg0AlAdnETTW/16p0vkzFbBPeIeYbHxu7A1dv2LY4huEa1OI5a0Polakp4MCXwVKb
         Fv29NoJaIoCX7M60Lz5IqiCtCj4E52U2tqFlVGTYBdCAxpyzSt03CZjQ6rmTdyEfa+4e
         DyqPS8GI24sDsvEJHhiPpgweykhcnlu0pN5YnUNQcmeSAsF9wbhXVlixFJQJGWrBckBe
         XYnx6xJL8ETR5F4egGQJ6CSoO/XVrsDigr7fGJ3TUHePwwwSDOwfCbM2j6RwuUbcsj8g
         9dfKriiBXCyf1u5vitNh47aum8hOviOPH0xu1McDyFulR++7sByCvJqYmzqDd3buM0F7
         nyGg==
X-Gm-Message-State: AC+VfDx3O5xGVXZkOAbjjeFXa2U4bAASrx6r03SoPXOEl4QZtdoCc3nD
        h/WVB1njpk7mTzoGZ+iJzSbr2w==
X-Google-Smtp-Source: ACHHUZ5nd/52a771+5ohgCwEV7w8W/JLI/qUDNCdwWEzJz24b6zSgEoFMQ/xxHyJiNqKekMcDXY1YA==
X-Received: by 2002:a05:6512:906:b0:4db:1e4a:74a1 with SMTP id e6-20020a056512090600b004db1e4a74a1mr978025lft.0.1685616143557;
        Thu, 01 Jun 2023 03:42:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id m20-20020a195214000000b004eed68a68efsm1048734lfb.280.2023.06.01.03.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:42:23 -0700 (PDT)
Message-ID: <34cd6db8-9f05-23cc-cd41-7fd48ec1a286@linaro.org>
Date:   Thu, 1 Jun 2023 12:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: Add missing interconnect path
 to USB HC
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230601103817.4066446-1-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601103817.4066446-1-abel.vesa@linaro.org>
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



On 1.06.2023 12:38, Abel Vesa wrote:
> The USB HC node is missing the interconnect paths, so add them.
> 
> Fixes: 7f7e5c1b037f ("arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes")
For context, it's a fix in the context of "we should prooobably have
this if we want to fix the icc driver to include sync state".
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>



sidenote:

on recent SoCs there's also an USB-IPA path:

aggre1_noc MASTER_USB3_0 <-> &config_noc SLAVE_IPA_CFG

I don't think we really make use of that upstream today or whether it
would make enabling IPA necessary (to enable the clocks and reach the
IPA hardware), but it's something to think about.

Konrad
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 75cd374943eb..4991b2e962d1 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2793,6 +2793,10 @@ usb_1: usb@a6f8800 {
>  
>  			resets = <&gcc GCC_USB30_PRIM_BCR>;
>  
> +			interconnects = <&aggre1_noc MASTER_USB3_0 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
> +			interconnect-names = "usb-ddr", "apps-usb";
> +
>  			status = "disabled";
>  
>  			usb_1_dwc3: usb@a600000 {
