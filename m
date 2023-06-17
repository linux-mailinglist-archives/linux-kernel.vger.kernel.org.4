Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11637342F6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346386AbjFQSOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjFQSOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:14:52 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE4D1BC9;
        Sat, 17 Jun 2023 11:14:48 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 830CE403BF;
        Sat, 17 Jun 2023 23:14:45 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1687025685; bh=bXvOEqjNtGU0blHiRWmamyy/+/Nx8cAiMiBZhK4j2Q4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2YyVVXMwL4tWNL5ThDmaUx78P2sFl4Ffe4xYxRaOC2t2hqCvHTY8iRAQKHH1zoChi
         sjtobAo/9gBw+XQhx6t4qpRNLR0WdOVdVRunHDtFixGTCL9DaLrAlhVGOHfWLq8DAp
         UEpt+T5o5KbF9hCl2QQcTfVyuxyZjD6xAIBFYBBUYDKDOQTDYQvut6iFFu8rI+7xiP
         n8E4PaFtACPFEHil9ikkt84pDDBmSACM2aWeld4Fhv6Gn4B0x1ujY2xUHAjQeijO15
         n/Ijt6IebcVrSozjZeM4MN98ZFjG4HLmRpM3xuP158Jukk18eP5MCSpzbHUwq3n5Dn
         IJhjDKm5qToTg==
MIME-Version: 1.0
Date:   Sat, 17 Jun 2023 23:14:43 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] arm64: dts: qcom: msm8916-l8150: correct light
 sensor VDDIO supply
In-Reply-To: <20230617171541.286957-2-krzysztof.kozlowski@linaro.org>
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
 <20230617171541.286957-2-krzysztof.kozlowski@linaro.org>
Message-ID: <7f1f9053cbd84dbc8aa060b6b191a497@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski писал(а) 17.06.2023 22:15:
> liteon,ltr559 light sensor takes VDDIO, not VIO, supply:
> 
>   msm8916-longcheer-l8150.dtb: light-sensor@23: 'vio-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Fixes: 3016af34ef8d ("arm64: dts: qcom: msm8916-longcheer-l8150: Add light and proximity sensor")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Oops, thanks for noticing!

Reviewed-by: Nikita Travkin <nikita@trvn.ru>

> ---
>  arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> index 97262b8519b3..3892ad4f639a 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> @@ -165,7 +165,7 @@ light-sensor@23 {
>  		pinctrl-0 = <&light_int_default>;
>  
>  		vdd-supply = <&pm8916_l17>;
> -		vio-supply = <&pm8916_l6>;
> +		vddio-supply = <&pm8916_l6>;
>  	};
>  
>  	gyroscope@68 {
