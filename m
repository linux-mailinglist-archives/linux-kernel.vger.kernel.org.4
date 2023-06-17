Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76F37342E9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjFQSMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQSMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:12:16 -0400
Received: from box.trvn.ru (unknown [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA5B9;
        Sat, 17 Jun 2023 11:12:14 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 981DA403BF;
        Sat, 17 Jun 2023 23:11:56 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1687025517; bh=IjVU42ZmlI0jo9ZkZhIvMFWzUafA1AiR/an4I5BPa/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BZjH1GyX33NEZWDIacdDnsThTuO0i3XONlHw6xKCP3dhj0OPxWsZ/loFAI6M7a1Yo
         M7tMxm3HuYez4TCZ0GX74OWZVR23RHt1Yo4erSWCqWJ3EcbYbplx9breJjEfJ9ViP4
         YRNQNL+nUzJaOsS9HNJhvyZVC2pLWzPMJHhi2/qeVOPqkgiJAGdC6LPZ/Rv+nh2ley
         7AOlYxMS/h5eQ4Pqf3iS6yx2IRC+6mykmhU2rk0lQgV9HGdDNF8QyRp+zOEnZLPvJQ
         gQg6PEUIEM+cZpoWfXDZWJ1sPS36owJxalTRbFK8J77cGkZeAlNRII8KzT5S6C9XLI
         ecoR4r/t1zIWA==
MIME-Version: 1.0
Date:   Sat, 17 Jun 2023 23:11:55 +0500
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
Subject: Re: [PATCH 08/15] arm64: dts: qcom: sc7180-aspire1: use generic ADC
 channel node names
In-Reply-To: <20230617171541.286957-8-krzysztof.kozlowski@linaro.org>
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
 <20230617171541.286957-8-krzysztof.kozlowski@linaro.org>
Message-ID: <3b7f6b2677608fad438e4338779f2c1a@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski писал(а) 17.06.2023 22:15:
> ADC channel node names were changed to require generic 'channel'.  The
> user-visible part is defined via label.
> 
>   sc7180-acer-aspire1.dtb: adc@3100: 'charger-thermistor@4f', 'thermistor@4e' do not match any of the regexes: '^channel@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for fixing this up!

Reviewed-by: Nikita Travkin <nikita@trvn.ru>

> ---
>  arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
> index b637b4270f88..dbb48934d499 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
> @@ -314,16 +314,18 @@ &mdss_dsi0_phy {
>  };
>  
>  &pm6150_adc {
> -	thermistor@4e {
> +	channel@4e {
>  		reg = <ADC5_AMUX_THM2_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "thermistor";
>  	};
>  
> -	charger-thermistor@4f {
> +	channel@4f {
>  		reg = <ADC5_AMUX_THM3_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "charger_thermistor";
>  	};
>  };
