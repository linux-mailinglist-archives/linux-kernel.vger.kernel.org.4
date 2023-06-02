Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA5871FD95
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjFBJWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjFBJVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:21:23 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530281A8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:19:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af1822b710so26171901fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685697589; x=1688289589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46Ohrt9OBahdlI2qNoiFK8GGZ2eKRD3gp+lBC35062Y=;
        b=IR+o8Q829f95x2RTa7Sj21egQu3udQghAPLr8x77hMXt9oRoFyP5VguEcy6VjngZ5X
         iHSBZKSEO6vdIZzhlM8K5wF9GX/vgSxK1wfHLzBdpc7uxwo/ArltMRfqQvxPVCprVGlP
         2lamztx+RRkyVm16elG0r2/ZauS9vCB6PZWtKUNtN9fZuwiowO8uJV3f66yrRqcnY9eV
         Dw3B0Ih/NClxMaSBL3GjQnFudrbm8t531shZE3HEZszpZHiGkAapDI9680Rj/UUdySqz
         HJq8QTBaZjIJ37KvIoPvgrn8JmcMfbJeBzIgdi1zCg58ZSFZSJwXhbUyBWv9+4Us37Ko
         Uw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685697589; x=1688289589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46Ohrt9OBahdlI2qNoiFK8GGZ2eKRD3gp+lBC35062Y=;
        b=PUhI6Iz/YO5r4TMtaF043AjRe0ZxCfFNJxW0b3GMvHwxJ6qgNaIG9N3fzgrgPK4N+F
         ZNErGqI/jxrsbTnes2A+OTOsN4NxyR9STYMfKrVeez6gIXxlluBJMpFv48Uuqzz5MqXV
         cqqTxqvidWoNUiQThFD2Mi6MAfa16elTaJkGdfpROkxiY9jMkP2oNSwvhFyAe/4VMw/u
         nPTW2tayVi/aDecueEJ1AGTHVegEj1XVKUI17jQfnXoLZjCKkMQabVWvv8fpcMLM9j5X
         SzgEPjgIch0mU6pWTpdKp22AK0nDrGrUGrTx2sAtY37cV/40DxpY+dKOlZ8cgq6VbpIk
         3RHQ==
X-Gm-Message-State: AC+VfDz04xVZgG9n7u7YsimQqMEkxYIkTMJQSfxbM22jz4HdL+2Iy+42
        J3bWdp1kcVOcShi02Qb9a0wedg==
X-Google-Smtp-Source: ACHHUZ5zO9XAjHQqTn5yPaDNOlTB0ABkRiSutttDJu4wXhqJrE9vRJlsqccUlPrfQpzDbdez+Du+kA==
X-Received: by 2002:a2e:8903:0:b0:2a6:18c0:2b35 with SMTP id d3-20020a2e8903000000b002a618c02b35mr1340365lji.0.1685697589520;
        Fri, 02 Jun 2023 02:19:49 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id s8-20020a2e81c8000000b002a76bb6bce0sm154143ljg.37.2023.06.02.02.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:19:49 -0700 (PDT)
Message-ID: <4ae010f7-fee5-5347-b9da-666a267559cf@linaro.org>
Date:   Fri, 2 Jun 2023 11:19:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: sm8150: Add missing interconnect
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
 <20230602062016.1883171-2-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230602062016.1883171-2-abel.vesa@linaro.org>
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
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 50a21062ea24..18c822abdb88 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3595,6 +3595,10 @@ usb_1: usb@a6f8800 {
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
> @@ -3644,6 +3648,10 @@ usb_2: usb@a8f8800 {
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
