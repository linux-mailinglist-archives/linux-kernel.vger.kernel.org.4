Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF315B8A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiINORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiINORs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:17:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7C511C3F;
        Wed, 14 Sep 2022 07:17:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id cc5so16107645wrb.6;
        Wed, 14 Sep 2022 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DShOf4Gx+lzJmcnqegec2XN3Hsli13fi8jDcyucrTgE=;
        b=BqO62uCGa3bxc+fdhgYg7xWIqBrP8YKuUaBU24ihFbCa71d7IkF6AUQyknG3nP5YRw
         8iPw4S3PAbvadE64dJTV368Zq6PZsF/YkyjJDS/JVUIfhlI/R+qCWLZP+UI3vwZ/98Mv
         gSMR2iaVDrzxbUTH00W+hazjfeNJm441tIFWG7/OJ/NjL2JQuxgTTGjg+yfCzttBiiWd
         KQLjL3hoF7mUSKYsGYLWEvHPNg/zRNe4ql8mYUU9dgEiHOguppEdLm0Jbilnh0lomlB0
         p7K50/OMHm7TgjRQ8l+FuIj70f2LmWadJzqfCNzhFCxbPLqmeC3a1ncDpgZA6wgUuEbV
         DWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DShOf4Gx+lzJmcnqegec2XN3Hsli13fi8jDcyucrTgE=;
        b=Zr7B7ev1Ee6aVveIkAgFDFIdpURqgjUcXZWPsCztpLl4bxzZ97zihpFykUMj4555U+
         0Zt5tuijLPTHRmntLwemfiouM5oBZxzFqnECN6YMMQ9pPlUtvGKqcf/+YduOwvaNQzbN
         FmnQQdvt+dsxxesym37uNYeO5D6AOl+z0vCRS7R1cZ5IObMM9RVf+mo3p1FBlRz+UCuF
         dXUajQGQqwbUi/pYAn9XPoe2XdTyqQduxch2/6ezVY3paNx6yFFKsUpZF4QcYBVZiLxv
         59KLCVZHpSYlsbr7N4yoa76t6zKc5xhZnepOFlI8AY0iQeh3zOLcGmpmbaJH1RuK8ySx
         UMGg==
X-Gm-Message-State: ACgBeo23XEwnj4yBKEcBQ6sE65RzgqVXPh8qpv3kPm+nwCT6W/o1vlNM
        eOOJ5oxsIClpnsH3MQKKnS+oVsl0k/k=
X-Google-Smtp-Source: AA6agR5bsN/EY+8ioTAB2c4TXxV2H+z0kc6hhyTlPa+UwwzLDQRS2VxaaTwqi5P1XQYMoelWoojU0g==
X-Received: by 2002:a5d:4745:0:b0:228:d9ec:6b5d with SMTP id o5-20020a5d4745000000b00228d9ec6b5dmr22015748wrs.257.1663165065317;
        Wed, 14 Sep 2022 07:17:45 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c6-20020a056000104600b002252ec781f7sm13554846wrx.8.2022.09.14.07.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 07:17:44 -0700 (PDT)
Message-ID: <725668a0-b138-a60c-4c99-7c81599034a2@gmail.com>
Date:   Wed, 14 Sep 2022 16:17:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5] arm64: dts: mt7986: add built-in Wi-Fi device nodes
Content-Language: en-US
To:     Peter Chiu <chui-hao.chiu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220901130552.26234-1-chui-hao.chiu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220901130552.26234-1-chui-hao.chiu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/2022 15:05, Peter Chiu wrote:
> This enables built-in 802.11ax Wi-Fi support.
> 
> Reviewed-by: Sam Shih <sam.shih@mediatek.com>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> 

Now that the yaml file change was accpeted:

Applied to v6.0-next/dts64

Thanks!

> ---
> v2: add clocks and clock-names.
> v3: rename wmac to wifi and change underscores to dash in node names.
> v4: rebase to the latest codebase.
> v5: remove useless pins in wf_dbdc_pins node.
> ---
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 38 +++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 23 +++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 40 ++++++++++++++++++++
>   3 files changed, 101 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> index 882277a52b69..afe37b702eef 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> @@ -115,6 +115,13 @@
>   	status = "okay";
>   };
>   
> +&wifi {
> +	status = "okay";
> +	pinctrl-names = "default", "dbdc";
> +	pinctrl-0 = <&wf_2g_5g_pins>;
> +	pinctrl-1 = <&wf_dbdc_pins>;
> +};
> +
>   &pio {
>   	uart1_pins: uart1-pins {
>   		mux {
> @@ -129,4 +136,35 @@
>   			groups = "uart2";
>   		};
>   	};
> +
> +	wf_2g_5g_pins: wf-2g-5g-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_2g", "wf_5g";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
> +			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
> +			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
> +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
> +
> +	wf_dbdc_pins: wf-dbdc-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_dbdc";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index e3a407d03551..890ded0efc51 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -7,6 +7,7 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/clock/mt7986-clk.h>
> +#include <dt-bindings/reset/mt7986-resets.h>
>   
>   / {
>   	interrupt-parent = <&gic>;
> @@ -70,6 +71,11 @@
>   			reg = <0 0x43000000 0 0x30000>;
>   			no-map;
>   		};
> +
> +		wmcpu_emi: wmcpu-reserved@4fc00000 {
> +			no-map;
> +			reg = <0 0x4fc00000 0 0x00100000>;
> +		};
>   	};
>   
>   	timer {
> @@ -261,6 +267,23 @@
>   			#size-cells = <0>;
>   			status = "disabled";
>   		};
> +
> +		wifi: wifi@18000000 {
> +			compatible = "mediatek,mt7986-wmac";
> +			resets = <&watchdog MT7986_TOPRGU_CONSYS_SW_RST>;
> +			reset-names = "consys";
> +			clocks = <&topckgen CLK_TOP_CONN_MCUSYS_SEL>,
> +				 <&topckgen CLK_TOP_AP2CNN_HOST_SEL>;
> +			clock-names = "mcu", "ap2conn";
> +			reg = <0 0x18000000 0 0x1000000>,
> +			      <0 0x10003000 0 0x1000>,
> +			      <0 0x11d10000 0 0x1000>;
> +			interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
> +			memory-region = <&wmcpu_emi>;
> +		};
>   	};
>   
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> index 0f49d5764ff3..3443013b5971 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> @@ -98,3 +98,43 @@
>   		};
>   	};
>   };
> +
> +&wifi {
> +	status = "okay";
> +	pinctrl-names = "default", "dbdc";
> +	pinctrl-0 = <&wf_2g_5g_pins>;
> +	pinctrl-1 = <&wf_dbdc_pins>;
> +};
> +
> +&pio {
> +	wf_2g_5g_pins: wf-2g-5g-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_2g", "wf_5g";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
> +			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
> +			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
> +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
> +
> +	wf_dbdc_pins: wf-dbdc-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_dbdc";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
> +};
