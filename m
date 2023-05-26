Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC380713060
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 01:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjEZXay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 19:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjEZXax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:30:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF8813A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:30:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f122ff663eso1392854e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685143848; x=1687735848;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+M2DJSnDqWWPeYg5/WUCxic9WjBCf1zdNnp12o5U7f8=;
        b=fM29H5ZBRNCUDmA3EedA1+baSwOKI6DmGr1QhsFZmO9QuUr24riFfFiiiKDr4v2mxX
         ZqbXqJDGGuVEic3mUguoYn/2atvtXfjloY8TsZqLCehBPHzjMjhs8bNnhpki4DZcFQJt
         MhZALj2SDT1tM1r288fkm1WMavJVLPIJlysc4pNqP6aKa0L6eZZXh3iNOPXngsQ+jX23
         1in6q00RbW0mPxgKFAXTANwAiIe2spvnxr6cvMKtvjlO8loUyuL0LiOZimPbisO7QuVy
         rTuGiYLjvCTGi1Rl1WnxJMLUIpQzOiDVNIVs4K0SPEZBvzGUzfkQV4dJWlYKXC+dsE2L
         GHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685143848; x=1687735848;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+M2DJSnDqWWPeYg5/WUCxic9WjBCf1zdNnp12o5U7f8=;
        b=Czg/UPIdw919lEmIFZIKkML/QmbGKv/zkO+DVcoQHQQMpG+DsotyUeFL0XVwpxN+QA
         lIMhgemc+KMmgKjI5wqHmsCsJkyUvQ1lK1v7HqBd1NUxLN/UbRzEESIOWI2r/vMNbFtG
         n1g/tZngl2cxXg4zSkvJAm4LnpZJ9pd/pZh+ChjapPCpLol8aCJpezWdEzpkJhSSjRMS
         h+Z2/P99hUVdBdpaJSN4t+3KmzB8Ku8BJMMGtyekvCnuMLImGOixTPcyZ8XAsBYJ0q/N
         58EYP+fTQwePNPAIL5R8DYFvaFnL3i3JHp5LdLx4ROxG8TQS6z4WhA00NvLIXq/BZyNh
         IDIQ==
X-Gm-Message-State: AC+VfDzV5C8ryvcVVFSOa1lvEkaxaK+j/HDsAgBGmq5IS3cX/liLsZdO
        6YLOrpt9bXLtWdH9mNau6fh3HQ==
X-Google-Smtp-Source: ACHHUZ66BaAb39CSpLT2wJ8xQepZ7pM+VPEpmbazF2GkTgNf19TdqBSREDx4j07NmBHcHTfdO2RRZg==
X-Received: by 2002:ac2:4e62:0:b0:4f4:b806:4b5f with SMTP id y2-20020ac24e62000000b004f4b8064b5fmr672955lfs.57.1685143848444;
        Fri, 26 May 2023 16:30:48 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id r2-20020ac24d02000000b004f3b520e0adsm828207lfi.107.2023.05.26.16.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 16:30:48 -0700 (PDT)
Message-ID: <7f40f870-c11f-3105-f016-445a22fe258f@linaro.org>
Date:   Sat, 27 May 2023 01:30:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Rudraksha Gupta <guptarud@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     david@ixit.cz, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230524230459.120681-1-guptarud@gmail.com>
 <20230524230459.120681-4-guptarud@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 4/5] ARM: Blindly copy the usb node from apq8064.dtsi
In-Reply-To: <20230524230459.120681-4-guptarud@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.05.2023 01:04, Rudraksha Gupta wrote:
> apq8064 and msm8960 are extremely similar SoCs. Therefore copying this
> from the apq8064 dtsi file should not be a problem. Tested this on the
> Samsung Galaxy Express and this works.
> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
Well admitting to this upfront doesn't sound very good :P

Please reword the message to something like:

ARM: dts: qcom-msm8960: Add USB

Add the required nodes to support USB on MSM8960.
As it's very similar to APQ8064, the setup is almost identical



As for the contents itself, I tried taking a brief peek into the
swamp that are the msm-3.0 boardfiles, but I barely managed to
escape before getting drawn into the quicksands of 13yo legacy..

I am however inclined to believe that the setup may in fact be
identical(or close to) on these two SoCs..

Konrad

>  arch/arm/boot/dts/qcom-msm8960.dtsi | 33 +++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
> index a4d8dd2d24a6..b11e606440cd 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -3,6 +3,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-msm8960.h>
> +#include <dt-bindings/reset/qcom,gcc-msm8960.h>
>  #include <dt-bindings/clock/qcom,lcc-msm8960.h>
>  #include <dt-bindings/mfd/qcom-rpm.h>
>  #include <dt-bindings/soc/qcom,gsbi.h>
> @@ -370,5 +371,37 @@ gsbi1_spi: spi@16080000 {
>  				status = "disabled";
>  			};
>  		};
> +
> +		usb1: usb@12500000 {
> +			compatible = "qcom,ci-hdrc";
> +			reg = <0x12500000 0x200>,
> +			      <0x12500200 0x200>;
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc USB_HS1_XCVR_CLK>, <&gcc USB_HS1_H_CLK>;
> +			clock-names = "core", "iface";
> +			assigned-clocks = <&gcc USB_HS1_XCVR_CLK>;
> +			assigned-clock-rates = <60000000>;
> +			resets = <&gcc USB_HS1_RESET>;
> +			reset-names = "core";
> +			phy_type = "ulpi";
> +			ahb-burst-config = <0>;
> +			phys = <&usb_hs1_phy>;
> +			phy-names = "usb-phy";
> +			status = "disabled";
> +			#reset-cells = <1>;
> +
> +			ulpi {
> +				usb_hs1_phy: phy {
> +					compatible = "qcom,usb-hs-phy-msm8960",
> +						     "qcom,usb-hs-phy";
> +					clocks = <&sleep_clk>, <&cxo_board>;
> +					clock-names = "sleep", "ref";
> +					resets = <&usb1 0>;
> +					reset-names = "por";
> +					#phy-cells = <0>;
> +				};
> +			};
> +		};
> +
>  	};
>  };
