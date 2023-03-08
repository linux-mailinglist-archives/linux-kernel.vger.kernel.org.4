Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163CA6B0F04
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCHQlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjCHQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:41:35 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F20FC70B9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:41:25 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h3so17185727lja.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678293683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9832/v8X8M7hZ4kxLo0cqXqRXWGID4c/HAam34gmROU=;
        b=I6NztF4j1CRNFU+b9la/tvVhkOGVhh55gYqFxUb5bc1f67hzxfoSPKfUW3EaC0zrNG
         gRmCIObGCz2VGdJt5wwqo7Bg3yIe2q6nKvFZxrtdRRX+D8p8qU9dIUevFV40pK8H8Fjv
         cJgNHXSTsBP1Ba9vj+tKQ7CQD1bH4BW1tsIB5GCiyhSr3eZvdwAcaCucWF+u4FuvRZrH
         9m7W9MsD524lqxWo2apGX4PKH9qxCc6V18NSXkFlSyN3Trbrz0FdzjHr/nUd1pjlb5Dn
         boE90XrpYfukW1EedVEcKe65KJvaOTRIP9hgtnNilgggpA1jpvZgy98l8FAoAbBVSUEC
         svhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678293683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9832/v8X8M7hZ4kxLo0cqXqRXWGID4c/HAam34gmROU=;
        b=7mFDxfnPXpotJRgNEpIrrZudAaPxiZtDjYn8Q5S193n6NpiK3GGzInFPPcrRyj5aSf
         L1OM3dSv0KAzUUxs+yn7VhSEkjIwRZkzAbUdYvQD4ZLn6HfceT7Xx/6UvBXFRiKOhheL
         5zd8t5VvPGL6auWS3H49XNSCMVbwBTt1VRw7moGp+fgolVKp6SQQ9TJzeGGl06q1Z4bU
         mhg7o/qkIQ0aWN7Bm1PF+5UlwfnbziyhI81orwYxCV8EAVpnbWvmIdqk6slMNcWr0w9J
         QyLfKITEu0srBrlvYaZvetIdmCHR5w3j+4SIK3vyGKnHkrve4WU9ZGbpONKYVTb9h/yy
         6MHg==
X-Gm-Message-State: AO0yUKWoHLAfuxnA1dtabxt5IPqAIBYraTlXjENc1vswe2NNpUOA+JS+
        c7ShHool3rKOdTkwNZU9HC+UiA==
X-Google-Smtp-Source: AK7set8xMvQqktf8PjdsFpxWiZhMvwquJGDBrVpMWcDf41uAlyKfFbFVk6ryRM3jkix8jdIoEturKQ==
X-Received: by 2002:a05:651c:446:b0:295:b0c7:b9a1 with SMTP id g6-20020a05651c044600b00295b0c7b9a1mr5512540ljg.51.1678293683368;
        Wed, 08 Mar 2023 08:41:23 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id b14-20020ac2562e000000b004dafe604c2esm2393856lff.211.2023.03.08.08.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 08:41:22 -0800 (PST)
Message-ID: <80b5867c-ea8f-f9d2-aee5-a5a3741e0694@linaro.org>
Date:   Wed, 8 Mar 2023 17:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 3/9] arm64: dts: qcom: sa8775p: add the i2c18 node
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230308104009.260451-1-brgl@bgdev.pl>
 <20230308104009.260451-4-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230308104009.260451-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.03.2023 11:40, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a disabled node for the I2C interface that's exposed on the
> sa8775p-ride development board.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 5efb3e4f2335..d65e7826f1d7 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2023, Linaro Limited
>   */
>  
> +#include <dt-bindings/interconnect/qcom,icc.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> @@ -502,6 +503,27 @@ qupv3_id_2: geniqup@8c0000 {
>  			clock-names = "m-ahb", "s-ahb";
>  			iommus = <&apps_smmu 0x5a3 0x0>;
>  			status = "disabled";
> +
> +			i2c18: i2c@890000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x0 0x00890000 0x0 0x4000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
These two should come right before statusdisabled, but I think
that's a leftover from 8280 standing out and us having discussions
about this and other stuff.. Not sure if we want to untie this
knot here on in a big separate commit

> +			

	interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
interrupts should come after reg

> +				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
> +				clock-names = "se";
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
> +						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
> +						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> +						 &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
> +						<&aggre2_noc MASTER_QUP_2 QCOM_ICC_TAG_ALWAYS
> +						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> +				interconnect-names = "qup-core",
> +						     "qup-config",
> +						     "qup-memory";
> +				power-domains = <&rpmhpd SA8775P_CX>;
> +				status = "disabled";
The node contents in general LGTM

Konrad
> +			};
>  		};
>  
>  		intc: interrupt-controller@17a00000 {
