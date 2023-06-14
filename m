Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02C872FB67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbjFNKm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239824AbjFNKmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:42:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0C81BC3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:42:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f6170b1486so7984871e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686739337; x=1689331337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8BdObspS5BxkxC/OI6lX9UiNPUzQKnEU5QQRROfFatk=;
        b=mrxLjq0NEPf/iAA9wsvTF32mf0Tmcym8O/wlI9GtFplFmwrA1XLaX2ltaF8gRtH7mX
         Bx4Vd4UVWuZvlqZNDM+y0+8ehUisPxNgl77pE4h3nUUDwT3Jqi1GVimqddJ+4jbnj67B
         BMKs28xfcepn+t4tiD0WsyoyEDLQIZKxeDSVvrBMfJhjzwg+bONbYJh9SVH1YwThMjO9
         hJxnifBApj+bmQTo0Dnc/pOEvIUJiB+1KXlKRGjs03huSRNHVkU2mEZy0SvYjvHMrOXS
         e21+QpT6u8xwAlyjIAUb87sD7Ei+td1dnwNjwXumdaj4Op+cdHYA3WNy+TXYIr7lcVzO
         ma+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686739337; x=1689331337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BdObspS5BxkxC/OI6lX9UiNPUzQKnEU5QQRROfFatk=;
        b=D67giBU+e2oxQm/llbcOcoGw4kObfticYhDoiBdvIOJPnKVAZomH4Sw6LiXcHovOql
         G1N3Pea8dMByqsRTVSIKPYR5X2YmjCiGLsPsVqTMrGklxGn8GEOjLwoll2nAUvOUPxoC
         dhioITQ6LGFKNvrhEFgtm3fUwQUnarJxKZUK+6bltmQv+b43Zi1yUbTQHnvOzrdx23kV
         ImadTEEIgjtaq63MnWSCCYRmarQgugbxq0wWB0JyHMElJ6estlFoNoRaOVUaoZkLXcPd
         NMZcoFHacLDdqrnQxLCGJpCfhhmHpN332qTP1RtSXPMsGRcTiaJqBiWhEcXvBYDlVx4Y
         YLCg==
X-Gm-Message-State: AC+VfDxJfomJfWSJXXEBlmuWiNnpWVLd5WRmsE3eT3LP66khDQ6vg9g8
        BkUUQksdeps6NcwT6sFqG/LthQ==
X-Google-Smtp-Source: ACHHUZ7JPqaMDRJGSQGuc9HmVqm0CEsgMoUjGzFM21devLvWuyGM5l3Qy2RMfxGtr7CDrw83CzVvlQ==
X-Received: by 2002:a05:6512:39d1:b0:4f3:7889:7603 with SMTP id k17-20020a05651239d100b004f378897603mr422659lfu.24.1686739336794;
        Wed, 14 Jun 2023 03:42:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v27-20020ac2561b000000b004f2391fe9a6sm36702lfd.266.2023.06.14.03.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 03:42:16 -0700 (PDT)
Message-ID: <4dede8d5-e665-1cf4-ea27-b2ba99f820e2@linaro.org>
Date:   Wed, 14 Jun 2023 12:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq9574: Enable WPS buttons
Content-Language: en-US
To:     Anusha Rao <quic_anusha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_poovendh@quicinc.com
References: <20230614085040.22071-1-quic_anusha@quicinc.com>
 <20230614085040.22071-3-quic_anusha@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230614085040.22071-3-quic_anusha@quicinc.com>
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



On 14.06.2023 10:50, Anusha Rao wrote:
> Add support for wps buttons on GPIO 37.
> 
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---
>  .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> index 999902bc70bd..fd5326dc1773 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> @@ -8,6 +8,8 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>  #include "ipq9574.dtsi"
>  
>  / {
> @@ -18,6 +20,20 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&gpio_keys_default>;
> +		pinctrl-names = "default";
> +
> +		button-wps {
> +			label = "wps";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&tlmm 37 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <1>;
This line is unnecessary, it's set to 'key' by default. With that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +			debounce-interval = <60>;
> +		};
> +	};
>  };
>  
>  &blsp1_spi0 {
> @@ -114,6 +130,13 @@
>  		drive-strength = <8>;
>  		bias-disable;
>  	};
> +
> +	gpio_keys_default: gpio-keys-default-state {
> +		pins = "gpio37";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
>  };
>  
>  &xo_board_clk {
