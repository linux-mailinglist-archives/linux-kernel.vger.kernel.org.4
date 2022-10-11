Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697A05FBB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJKTzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJKTzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:55:47 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AB174BA3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:55:46 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id t25so2146202qkm.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ss0HZNXbaBlRsDGVHZxLf0e+LjVtH8J66SlzaV39VFg=;
        b=RI6G4Kub0A2958/mWKsFwhr4EB9R3R3b8zX7dA/n0HvwKihz/TRp2NJxR3qeJ7od5m
         QedvEyL9p3AIO/BVt5YYwjvg7RMnkPKcBHifx7yoHSTrAgLHIeVfIt9fhF1UC89ojIvt
         pVD6SGxRpuTV/19wiBCWOSvXEsOQQVDo9SvRQI3tstjn9xzxiDxQVR/NgPubwz5kGflL
         oaDErNOVrCNkyS2zjuQ9eHOY7N9K5w1Lld+WA7+/oDEl4G7zNIObomS5Vc+PPrtL9kVI
         jJJlfyaHFH7snOsRYWrfOih+rJvdcN/KG8R6t93BHC2d4FS7xJHOSfYSVLQA7KVpki1m
         cdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss0HZNXbaBlRsDGVHZxLf0e+LjVtH8J66SlzaV39VFg=;
        b=knJIulyDFaa4cLe2ytskMBSTu4XwPFOe9taEUnNKrJyCARo+hvQnqwiH9rOGSAFQ80
         SDi0njG/zJaKkfTUfRssM2+gpXl/Y1EcWr/CHptDbzVxr7Tl8mhwpvH837BB1hD1lSdD
         G3lCU+LZyGwGsaa0vvQ3M2ZXBXGhhRUVAmkmfjtVdObJsdchQq8PQvmEzVEDFLcokG8h
         oTCOxRpEh0AYvKhp+7q4rfAOSi6dGOXvjUpvmm5RJOXpZb/HXrXkPXdK6MlZjsVpEP9p
         YzogGFoBxM9qUTBUDL439+aMjpv4WL0Oh2HNPh2f3+6NqhIUaOk3UH1ZTbiMuatHkTlC
         4dpQ==
X-Gm-Message-State: ACrzQf1M9mLT0m5R5WefFtzRzMMzz2lqYLMOHruTTE8Dg1AP8chHMVLZ
        SnvL4WQM7lJJBJ88jz0QEjW7ZA==
X-Google-Smtp-Source: AMsMyM7D2VeB+d6vTssoh5MSAciecMJc8W8AMfT5JPq20ykCBGVBwyOk8aJq91NaZilpPYxU5D3UnA==
X-Received: by 2002:a05:620a:4054:b0:6ec:56e0:bb87 with SMTP id i20-20020a05620a405400b006ec56e0bb87mr9557470qko.782.1665518145104;
        Tue, 11 Oct 2022 12:55:45 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a034300b006ecdfcf9d81sm6050560qkm.84.2022.10.11.12.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 12:55:44 -0700 (PDT)
Message-ID: <1cda400d-7ca1-9dcc-1d33-427dfd4ec92b@linaro.org>
Date:   Tue, 11 Oct 2022 15:53:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 3/5] ARM: dts: hpe: Add PLREG/SPI Support
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-4-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011185525.94210-4-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 14:55, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Adding support for the Programmable Logic Register driver in the HPE GXP
> SoC. Additionally adding support for the SPI driver that has already
> been committed to linux (See: drivers/spi/spi-gxp.c).
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  arch/arm/boot/dts/hpe-bmc-dl360gen10.dts | 275 +++++++++++++++++++++++
>  arch/arm/boot/dts/hpe-gxp.dtsi           |  28 ++-
>  2 files changed, 302 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> index 3a7382ce40ef..c97b052c4868 100644
> --- a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> +++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> @@ -23,4 +23,279 @@
>  		device_type = "memory";
>  		reg = <0x40000000 0x20000000>;
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-power {
> +			gpios = <&plreg 6 0>;
> +			default_state = "off";

Use generic properties for color and function. Same applies to other nodes.

> +		};
> +
> +		led-heartbeat {
> +			gpios = <&plreg 7 0>;
> +			default_state = "off";
> +		};
> +
> +		led-identify {
> +			gpios = <&plreg 56 0>;
> +			default-state = "off";
> +		};
> +
> +		led-health_red {
> +			gpios = <&plreg 57 0>;
> +			default_state = "off";
> +		};
> +
> +		led-health_amber {
> +			gpios = <&plreg 58 0>;
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&spifi {
> +	status = "okay";

Blank line

> +	flash@0 {
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			u-boot@0 {
> +				label = "u-boot";
> +				reg = <0x0 0x60000>;
> +			};
> +
> +			u-boot-env@60000 {
> +				label = "u-boot-env";
> +				reg = <0x60000 0x20000>;
> +			};
> +
> +			kernel@80000 {
> +				label = "kernel";
> +				reg = <0x80000 0x4c0000>;
> +			};
> +
> +			rofs@540000 {
> +				label = "rofs";
> +				reg = <0x540000 0x1740000>;
> +			};
> +
> +			rwfs@1c80000 {
> +				label = "rwfs";
> +				reg = <0x1c80000 0x250000>;
> +			};
> +
> +			section@1ed0000{
> +				label = "section";
> +				reg = <0x1ed0000 0x130000>;
> +			};
> +		};
> +	};

Blank line


> +	flash@1 {
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			host-prime@0 {
> +				label = "host-prime";
> +				reg = <0x0 0x02000000>;
> +			};
> +
> +			host-second@2000000 {
> +				label = "host-second";
> +				reg = <0x02000000 0x02000000>;
> +			};
> +		};
> +	};
> +};
> +
> +&plreg {
> +	gpio-controller;
> +	#gpio-cells = <2>;
> +	gpio-line-names =
> +	"", "", "", "", "",

Messed indentation.

> +	"", "POWER", "HEARTBEAT", "FAN1_INST", "FAN2_INST",
> +	"FAN3_INST", "FAN4_INST", "FAN5_INST", "FAN6_INST", "FAN7_INST",
> +	"FAN8_INST", "FAN9_INST", "FAN10_INST", "FAN11_INST", "FAN12_INST",
> +	"FAN13_INST", "FAN14_INST", "FAN15_INST", "FAN16_INST", "FAN1_FAIL",
> +	"FAN2_FAIL", "FAN3_FAIL", "FAN4_FAIL", "FAN5_FAIL", "FAN6_FAIL",
> +	"FAN7_FAIL", "FAN8_FAIL", "FAN9_FAIL", "FAN10_FAIL", "FAN11_FAIL",
> +	"FAN12_FAIL", "FAN13_FAIL", "FAN14_FAIL", "FAN15_FAIL", "FAN16_FAIL",
> +	"", "", "", "", "",
> +	"", "", "", "", "",
> +	"", "", "", "", "",
> +	"", "IDENTIFY", "HEALTH_RED", "HEALTH_AMBER", "POWER_BUTTON",
> +	"", "SIO_POWER_GOOD", "NMI_BUTTON", "RESET_BUTTON", "SIO_S5",
> +	"SIO_ONCONTROL", "", "", "", "",
> +	"", "", "", "", "",
> +	"", "", "", "", "",
> +	"", "", "", "", "",
> +	"", "", "", "", "",
> +	"", "", "", "", "",
> +	"", "", "", "", "";
> +	fan1 {

fan-1? Difficult to suggest as you did not explain this in the binding.

> +		inst = <0x27>;
> +		fail = <0x29>;
> +		id = <0x2B>;
> +		bit = <0x01>;
> +	};
> +	fan2 {
> +		inst = <0x27>;
> +		fail = <0x29>;
> +		id = <0x2B>;
> +		bit = <0x02>;
> +	};
> +	fan3 {
> +		inst = <0x27>;
> +		fail = <0x29>;
> +		id = <0x2B>;
> +		bit = <0x04>;
> +	};
> +	fan4 {
> +		inst = <0x27>;
> +		fail = <0x29>;
> +		id = <0x2B>;
> +		bit = <0x08>;
> +	};
> +	fan5 {
> +		inst = <0x27>;
> +		fail = <0x29>;
> +		id = <0x2B>;
> +		bit = <0x10>;
> +	};
> +	fan6 {
> +		inst = <0x27>;
> +		fail = <0x29>;
> +		id = <0x2B>;
> +		bit = <0x40>;
> +	};
> +	fan7 {
> +		inst = <0x27>;
> +		fail = <0x29>;
> +		id = <0x2B>;
> +		bit = <0x40>;
> +	};
> +	fan8 {
> +		inst = <0x27>;
> +		fail = <0x29>;
> +		id = <0x2B>;
> +		bit = <0x80>;
> +	};
> +	fan9 {
> +		inst = <0x28>;
> +		fail = <0x2A>;
> +		id = <0x2C>;
> +		bit = <0x01>;
> +	};
> +	fan10 {
> +		inst = <0x28>;
> +		fail = <0x2A>;
> +		id = <0x2C>;
> +		bit = <0x02>;
> +	};
> +	fan11 {
> +		inst = <0x28>;
> +		fail = <0x2A>;
> +		id = <0x2C>;
> +		bit = <0x04>;
> +	};
> +	fan12 {
> +		inst = <0x28>;
> +		fail = <0x2A>;
> +		id = <0x2C>;
> +		bit = <0x08>;
> +	};
> +	fan13 {
> +		inst = <0x28>;
> +		fail = <0x2A>;
> +		id = <0x2C>;
> +		bit = <0x10>;
> +	};
> +	fan14 {
> +		inst = <0x28>;
> +		fail = <0x2A>;
> +		id = <0x2C>;
> +		bit = <0x20>;
> +	};
> +	fan15 {
> +		inst = <0x28>;
> +		fail = <0x2A>;
> +		id = <0x2C>;
> +		bit = <0x40>;
> +	};
> +	fan16 {
> +		inst = <0x28>;
> +		fail = <0x2A>;
> +		id = <0x2C>;
> +		bit = <0x80>;
> +	};
> +	healthled {
> +		red = <0x0D 0x20>;
> +		amber = <0x0D 0x30>;
> +		green = <0x0D 0x10>;
> +	};
> +	iopled1 {
> +		on = <0x04 0x01>;
> +	};
> +	iopled2 {
> +		on = <0x04 0x02>;
> +	};
> +	iopled3 {
> +		on = <0x04 0x04>;
> +	};
> +	iopled4 {
> +		on = <0x04 0x08>;
> +	};
> +	iopled5 {
> +		on = <0x04 0x10>;
> +	};
> +	iopled6 {
> +		on = <0x04 0x20>;
> +	};
> +	iopled7 {
> +		on = <0x04 0x40>;
> +	};
> +	iopled8 {
> +		on = <0x04 0x80>;
> +	};
> +	identifyled {
> +		on = <0x05 0xC0>;
> +		off = <0x05 0x40>;
> +	};
> +	acm {
> +		forceoff = <0x0A 0x01>;
> +		removed = <0x0A 0x02>;
> +		unlatchreq = <0x0A 0x04>;
> +	};
> +	serverid {
> +		lower = <0x01 0xFF>;
> +		upper = <0x02 0xFF>;
> +	};
> +	sideband {
> +		disabled = <0x40 0x03>;
> +		embedded = <0x40 0x02>;
> +		adaptive = <0x40 0x01>;
> +	};
> +	grp5intflag {
> +		ack = <0xB0 0xFF>;
> +		pwrbtn = <0xB0 0x01>;
> +		uidpress = <0xB0 0x02>;
> +		slpint = <0xB0 0x04>;
> +	};
> +	grp5intmask {
> +		pwrbtn = <0xB1 0x01>;
> +		slpint = <0xB1 0x40>;
> +	};
> +	grpintsmasks {
> +		grp5 = <0x88 0x10>;
> +	};
> +	grpintsflags {
> +		grp5 = <0x8C 0x10>;
> +	};
> +	pwrbtn {
> +		latch = <0x0F 0xFF 0x04>;
> +	};
>  };
> diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
> index cf735b3c4f35..96003667bebe 100644
> --- a/arch/arm/boot/dts/hpe-gxp.dtsi
> +++ b/arch/arm/boot/dts/hpe-gxp.dtsi
> @@ -56,9 +56,28 @@
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			ranges = <0x0 0xc0000000 0x30000000>;
> +			ranges = <0x0 0xc0000000 0x40000000>;
>  			dma-ranges;
>  
> +			spifi: spi@200 {
> +				compatible = "hpe,gxp-spifi";
> +				reg = <0x200 0x80>, <0xc000 0x100>, <0x38000000 0x8000000>;
> +				interrupts = <20>;
> +				interrupt-parent = <&vic0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";

Blank line.

> +				flash@0 {
> +					reg = <0>;
> +					compatible = "jedec,spi-nor";
> +				};
> +
> +				flash@1 {
> +					reg = <1>;
> +					compatible = "jedec,spi-nor";
> +				};
> +			};
> +
>  			vic0: interrupt-controller@eff0000 {
>  				compatible = "arm,pl192-vic";
>  				reg = <0xeff0000 0x1000>;
> @@ -122,6 +141,13 @@
>  				interrupts = <6>;
>  				interrupt-parent = <&vic0>;
>  			};
> +
> +			plreg: plreg@d1000000 {

Use same node name as in bindings example...

> +				compatible = "hpe,gxp-plreg", "simple-mfd", "syscon";
> +				reg = <0xd1000000 0xff>;
> +				interrupts = <26>;
> +				interrupt-parent = <&vic0>;
> +			};
>  		};
>  	};
>  };

Best regards,
Krzysztof

