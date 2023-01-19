Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5675F673F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjASQiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjASQiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:38:46 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AE05B5B2;
        Thu, 19 Jan 2023 08:38:43 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so1698555wms.2;
        Thu, 19 Jan 2023 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0slJfIkfgwvD8lh/pis0V9NYOil7tR0HxrPnP9BoIwE=;
        b=k7UWOs+6M5ArKaJgegqKue7r+QBDKtPkGskRueABG8LL7u2ULgM2BJbuPa/hTDQvp2
         iP2/iX8F/AWIHyJTY9MZXzDjHkx10jtMjJh2HWQpsIeXTbtP9gW6QoLfTxwlpkKeD4cj
         NOSOUHtnEfOM+4SDmygniyFPREWdH5V1aex+fGv5SFNXAsOd3LOnW/7owmMsH+ejtDDM
         zevyOvlOExntk2Bnljh6oAI91zf8YZlrPiqYScFwqx0NVOwLvx6v9qJ9fpu7OId6yetO
         5RFDcR0jXXpuqACDUBFNc2oCGRb7Y4wfqEQtWafeHR0lIQ2CPab11bQGrGFZCfqz9G8X
         Qdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0slJfIkfgwvD8lh/pis0V9NYOil7tR0HxrPnP9BoIwE=;
        b=7xLh3jxoNhHUURcfFftl3Wu9QYiO9kwGwWTq8tSoeY0DtXmLAucGybDKw9ZRx4QLzE
         8qFWtPIJbXCbc4F0aIcKkYJ75y+MJWML8pags14F9oQdCiO6Fddgvx628hoxkboSGiZq
         r2l3l1Ypk34DWGxl6FjhJWHVrAybRpJrm0PCIW3HkV3Jz8XnUes9AX96WBh2y0FarLsB
         zI3sspnq/KYe+NflS9Bhl2MKsYOSh2Lv6nIWFFcyErhbrh+HNyc4y5COrgZK9PTn0ek/
         SfvT9KCI6d7cTXNrtu29bdrt3iEIIdR7bDkaxJbiw46KAevi7ORCnEK4p6GJ2wsXT4Ym
         uGuA==
X-Gm-Message-State: AFqh2kojaJb0aq5B9uA6Cdj+B574Onoqltgn1CeqdVIdYUXe2ASvEKKI
        vKlSWv2W4JBiNFrhebWN8u8=
X-Google-Smtp-Source: AMrXdXu+TekjvaDZa8mjuAEjOJ3qFNlqOjS/CUEL7bKLsuC9Tp0fbOD/XAXq15Gb8Rvn8ZYgbmuB1A==
X-Received: by 2002:a05:600c:4a27:b0:3da:fae5:7e2f with SMTP id c39-20020a05600c4a2700b003dafae57e2fmr11095256wmp.3.1674146322150;
        Thu, 19 Jan 2023 08:38:42 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f24-20020a05600c491800b003d9e74dd9b2sm5051560wmp.9.2023.01.19.08.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 08:38:41 -0800 (PST)
Message-ID: <6289067c-1a4b-cc0d-9a9c-431f0cd639bf@gmail.com>
Date:   Thu, 19 Jan 2023 17:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/9] arm64: dts: mediatek: mt8186: Add audio controller
 node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20230118091829.755-1-allen-kh.cheng@mediatek.com>
 <20230118091829.755-7-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230118091829.755-7-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2023 10:18, Allen-KH Cheng wrote:
> Add audio controller node for MT8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 62 ++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index 2700c830316f..c52f9be1e750 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -998,6 +998,68 @@
>   			};
>   		};
>   
> +		afe: audio-controller@11210000 {
> +			compatible = "mediatek,mt8186-sound";
> +			reg = <0 0x11210000 0 0x2000>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_AUDIO>,
> +				 <&infracfg_ao CLK_INFRA_AO_AUDIO_26M_BCLK>,
> +				 <&topckgen CLK_TOP_AUDIO>,
> +				 <&topckgen CLK_TOP_AUD_INTBUS>,
> +				 <&topckgen CLK_TOP_MAINPLL_D2_D4>,
> +				 <&topckgen CLK_TOP_AUD_1>,
> +				 <&apmixedsys CLK_APMIXED_APLL1>,
> +				 <&topckgen CLK_TOP_AUD_2>,
> +				 <&apmixedsys CLK_APMIXED_APLL2>,
> +				 <&topckgen CLK_TOP_AUD_ENGEN1>,
> +				 <&topckgen CLK_TOP_APLL1_D8>,
> +				 <&topckgen CLK_TOP_AUD_ENGEN2>,
> +				 <&topckgen CLK_TOP_APLL2_D8>,
> +				 <&topckgen CLK_TOP_APLL_I2S0_MCK_SEL>,
> +				 <&topckgen CLK_TOP_APLL_I2S1_MCK_SEL>,
> +				 <&topckgen CLK_TOP_APLL_I2S2_MCK_SEL>,
> +				 <&topckgen CLK_TOP_APLL_I2S4_MCK_SEL>,
> +				 <&topckgen CLK_TOP_APLL_TDMOUT_MCK_SEL>,
> +				 <&topckgen CLK_TOP_APLL12_CK_DIV0>,
> +				 <&topckgen CLK_TOP_APLL12_CK_DIV1>,
> +				 <&topckgen CLK_TOP_APLL12_CK_DIV2>,
> +				 <&topckgen CLK_TOP_APLL12_CK_DIV4>,
> +				 <&topckgen CLK_TOP_APLL12_CK_DIV_TDMOUT_M>,
> +				 <&topckgen CLK_TOP_AUDIO_H>,
> +				 <&clk26m>;
> +			clock-names = "aud_infra_clk",
> +				      "mtkaif_26m_clk",
> +				      "top_mux_audio",
> +				      "top_mux_audio_int",
> +				      "top_mainpll_d2_d4",
> +				      "top_mux_aud_1",
> +				      "top_apll1_ck",
> +				      "top_mux_aud_2",
> +				      "top_apll2_ck",
> +				      "top_mux_aud_eng1",
> +				      "top_apll1_d8",
> +				      "top_mux_aud_eng2",
> +				      "top_apll2_d8",
> +				      "top_i2s0_m_sel",
> +				      "top_i2s1_m_sel",
> +				      "top_i2s2_m_sel",
> +				      "top_i2s4_m_sel",
> +				      "top_tdm_m_sel",
> +				      "top_apll12_div0",
> +				      "top_apll12_div1",
> +				      "top_apll12_div2",
> +				      "top_apll12_div4",
> +				      "top_apll12_div_tdm",
> +				      "top_mux_audio_h",
> +				      "top_clk26m_clk";
> +			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,apmixedsys = <&apmixedsys>;
> +			mediatek,infracfg = <&infracfg_ao>;
> +			mediatek,topckgen = <&topckgen>;
> +			resets = <&watchdog MT8186_TOPRGU_AUDIO_SW_RST>;
> +			reset-names = "audiosys";
> +			status = "disabled";
> +		};
> +
>   		mmc0: mmc@11230000 {
>   			compatible = "mediatek,mt8186-mmc",
>   				     "mediatek,mt8183-mmc";
