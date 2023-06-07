Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F2B725CFB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbjFGLX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbjFGLXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:23:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3521A10DE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:23:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so8861902e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686137002; x=1688729002;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYWjVSSUNQy2OIvRzT+DCkE2WygimSZ/7ktVYRvNicw=;
        b=ut1l0xhdvA0jDNgaIFbJL6WY0litUWHGkN3/F7y+kRqLwEKWv1DEhaQBr4U6mVlK/+
         BGgF6RQIMKuHXnZnPgCLP66k45lwaHR9sK5ZdZT2yogZoSZ/PrgcWuBo5z2C0ySNOtmR
         3bogr32wDzzLCqrjcOjMaZnayYP71zrKMRypXK/a+ES13Esh6mEC5TNEztHTzawv0OGJ
         3+9BvEJPMj1M9imHdq5CHtRNHoazHEjRVTOY9qE2X+JRK9RaJpWYyvjAt5qY7hiPfCjx
         lLyHyEuoatjWEVkJhvTPk+nE6aH0uxNFMzdfBbThIZbiM7C8nGHZ+AoNYa1mxbVQpPGp
         A7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686137002; x=1688729002;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYWjVSSUNQy2OIvRzT+DCkE2WygimSZ/7ktVYRvNicw=;
        b=THck3rwW3ZABYvjbw+VJFbgFijm0Tu+j7NiLBBhLP+7xJ6fTLMRZXgovM2KPb3HjV0
         9WlCf/CbLo/VI0jFksUNL2byHNgOhqq4pYW6XiVISAf2Y4Lv7O0cMK4yf3dn8Sn6vnqJ
         AX8TjFbY1by9pczT39Se8G6M1B31HPkFwfLtpTuVvmG419YnCMruVvTTe/UqssFvuRyh
         Jj2/IPbatyLDk//dwWbzixW87hwSvJAwsXSiqQobE8rXy1nRc+CAP7KfTzeUXlDo9jXL
         5Iv+0pnPR6v2VxWHCXEmPvxvW40PyG4NfZu7pJVfkyQZ+zOWWHQaqO+eR+OuKJIXCbxA
         AkrA==
X-Gm-Message-State: AC+VfDwDTAUUhooK9Yyn+OHRRDjBzRs3Av3jbhvu86IUEdlf3ANyDk3k
        1vSc1JG9e97INCTJyzL9okS+BQ==
X-Google-Smtp-Source: ACHHUZ4aydeqTRm2woMwjuX3xGYPzWA8qO84H3tMVn0lkLC1A1gjqkq20mduf4N1CkRL+Px2KE7u7g==
X-Received: by 2002:ac2:4a7a:0:b0:4f2:6bc3:5e33 with SMTP id q26-20020ac24a7a000000b004f26bc35e33mr1969465lfp.9.1686137002414;
        Wed, 07 Jun 2023 04:23:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q11-20020ac2514b000000b004f63739e2f1sm552855lfd.255.2023.06.07.04.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 04:23:21 -0700 (PDT)
Message-ID: <8e21fef3-5ae4-673a-dce2-4ebf1dd0eb66@linaro.org>
Date:   Wed, 7 Jun 2023 14:23:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/9] arm64: dts: qcom: ipq5332: Add USB related nodes
Content-Language: en-GB
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, arnd@arndb.de, geert+renesas@glider.be,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, rafal@milecki.pl, quic_srichara@quicinc.com,
        quic_varada@quicinc.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <1b48e737aa14f5b5539cbf04d473182121d5b1ad.1686126439.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1b48e737aa14f5b5539cbf04d473182121d5b1ad.1686126439.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 07/06/2023 13:56, Varadarajan Narayanan wrote:
> Add USB phy and controller nodes
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 55 +++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index c2d6cc65..3183357 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -383,6 +383,61 @@
>   				status = "disabled";
>   			};
>   		};
> +
> +		usb_0_m31phy: hs_m31phy@7b000 {
> +			compatible = "qcom,ipq5332-m31-usb-hsphy";
> +			reg = <0x0007b000 0x12C>,
> +			      <0x08af8800 0x400>;
> +			reg-names = "m31usb_phy_base",
> +				    "qscratch_base";
> +			phy_type= "utmi";
> +
> +			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> +			reset-names = "usb2_phy_reset";
> +
> +			status = "okay";
> +		};
> +
> +		usb2: usb2@8a00000 {
> +			compatible = "qcom,ipq5332-dwc3", "qcom,dwc3";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			reg = <0x08af8800 0x100>;
> +
> +			clocks = <&gcc GCC_USB0_MASTER_CLK>,
> +				<&gcc GCC_SNOC_USB_CLK>,
> +				<&gcc GCC_USB0_SLEEP_CLK>,
> +				<&gcc GCC_USB0_MOCK_UTMI_CLK>;

Please indent these values.

> +
> +			clock-names = "core",
> +				"iface",
> +				"sleep",
> +				"mock_utmi";

Please indent these values.

> +
> +			interrupts-extended = <&intc GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;

No PHY IRQs?

> +			interrupt-names = "pwr_event";
> +
> +			resets = <&gcc GCC_USB_BCR>;
> +
> +			qcom,select-utmi-as-pipe-clk;
> +
> +			usb2_0_dwc: usb@8a00000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x08a00000 0xe000>;
> +				clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +				clock-names = "ref";
> +				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +				usb-phy = <&usb_0_m31phy>;
> +				tx-fifo-resize;
> +				snps,is-utmi-l1-suspend;
> +				snps,hird-threshold = /bits/ 8 <0x0>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_u3_susphy_quirk;
> +				snps,ref-clock-period-ns = <21>;
> +			};
> +		};
>   	};
>   
>   	timer {

-- 
With best wishes
Dmitry

