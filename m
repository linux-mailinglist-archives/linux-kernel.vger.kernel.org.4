Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECBD735694
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjFSMUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjFSMUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:20:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7B3E65
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:20:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-988b204ce5fso118870166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687177214; x=1689769214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r8IkgjCbYZ6ybcsI1GkHhRXG+M118R7BE1wtTAsnJr8=;
        b=ClBnqG9Gjo9yzp03JC2sB9Tl5OykGEG0MCJfr1gRTiPcMlb2sUa63W1A/h/3FcWLZ6
         Oy+I69ZWHgkwChDAddgOpSJnOFM9+abTF6e1r5FBj+O42kaBoGYG0U0mC7k920HYfGIF
         FAQh/w9ifmvIm7waigd8Lj1Y4DeFo1UeUkH8y2Lgf0RZYTSMy9fabS9jneySUICduSAY
         wMB/lz9ssGuuLUzSwZuB8bSDc+sZMiRDCHVvS3SSpsbJYgUQkDKp5xuBM7QUy0586W4B
         sy3v8JwtknzXVgYmQgfnckuUpNmuLUpsd+2aCcn03JLheYs9kqu0H6wjdMY2qpPD1A24
         +J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687177214; x=1689769214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8IkgjCbYZ6ybcsI1GkHhRXG+M118R7BE1wtTAsnJr8=;
        b=WncvYF5nu29pRgmO+OnYTNXuUWtvWDr0fhnb2JOgj1rOwsTGYdJlOyXjBo1BSGKqeK
         sOI+QqDEEZWwEZ1a/MVbms97yakAS1YVyqRiln4o0Fpoy/0ChnVQvbOXyF2bYxgtnDRq
         f9yNBZ+4WvqPQxC5U7E8qXsa26hldJANvZ8fLxj5s+lh42i/1UaAkV8NXoA6hE0YKQbc
         XqdlVnoOD+5/IOiJsgN/dp8a9DFOXaDaynUI71hQHNHaz5sajgDNBaojQbxhLgzWlir0
         fXrEBvafWZepQHF5ThfjsaIS+cEufUwi/h9AT2csbR7NvGTVEIWnLH95Kk6sdrrJf9y0
         BewA==
X-Gm-Message-State: AC+VfDwoyg3usz48/SNIpzxhy9pZm7fu1w89kM7t6JSaB/WTMOBIINL8
        uj3zf7ZjmjKcE6wPs8SrwED4QA==
X-Google-Smtp-Source: ACHHUZ47zEpJ6DeZD7uVxLdbu7k9xsdXjPX7y1tBu5kP3TPtRM2Jk60R/mDNGae7578PNVPH21KORg==
X-Received: by 2002:a17:907:7d86:b0:978:8790:9103 with SMTP id oz6-20020a1709077d8600b0097887909103mr9499787ejc.70.1687177214016;
        Mon, 19 Jun 2023 05:20:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id c21-20020a170906341500b00985bdb7dd5fsm4805480ejb.201.2023.06.19.05.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 05:20:13 -0700 (PDT)
Message-ID: <7b7694da-8b40-d76a-adca-4cf9aa206ff4@linaro.org>
Date:   Mon, 19 Jun 2023 14:20:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: Add QSPI controller node for
 StarFive JH7110 SoC
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230619083517.415597-1-william.qiu@starfivetech.com>
 <20230619083517.415597-4-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230619083517.415597-4-william.qiu@starfivetech.com>
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

On 19/06/2023 10:35, William Qiu wrote:
> Add the quad spi controller node for the StarFive JH7110 SoC.
> 
> Co-developed-by: Ziv Xu <ziv.xu@starfivetech.com>
> Signed-off-by: Ziv Xu <ziv.xu@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 32 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 18 +++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 2a6d81609284..22212c1150f9 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -126,6 +126,38 @@ &i2c6 {
>  	status = "okay";
>  };
>  
> +&qspi {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	nor_flash: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg=<0>;

Missing spaces.

> +		cdns,read-delay = <5>;
> +		spi-max-frequency = <12000000>;
> +		cdns,tshsl-ns = <1>;
> +		cdns,tsd2d-ns = <1>;
> +		cdns,tchsh-ns = <1>;
> +		cdns,tslch-ns = <1>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			spl@0 {
> +				reg = <0x0 0x20000>;
> +			};
> +			uboot@100000 {
> +				reg = <0x100000 0x300000>;
> +			};
> +			data@f00000 {
> +				reg = <0xf00000 0x100000>;
> +			};
> +		};
> +	};
> +};
> +
>  &sysgpio {
>  	i2c0_pins: i2c0-0 {
>  		i2c-pins {
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 4c5fdb905da8..0b24f9e66e67 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -440,6 +440,24 @@ i2c6: i2c@12060000 {
>  			status = "disabled";
>  		};
>  
> +		qspi: spi@13010000 {
> +			compatible = "starfive,jh7110-qspi", "cdns,qspi-nor";
> +			reg = <0x0 0x13010000 0x0 0x10000
> +				0x0 0x21000000 0x0 0x400000>;

This should be two items so <>, <>. Not one item.

Best regards,
Krzysztof

