Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A82F714B39
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjE2N50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjE2N5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:57:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF95E61;
        Mon, 29 May 2023 06:56:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30aa1eb95a0so3256557f8f.1;
        Mon, 29 May 2023 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685368533; x=1687960533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTPwRcU9/1owFrxG0zY81x47hBDLk9OGUJzI1r232yU=;
        b=LWr/g27RUnLmjW3T0TzziGpJ6dU3yFMD0ZkbRXguiTeMWWNxRMcii3JVD3SdkYxLSL
         Q2zJc/hK+eVilxyWDq9VWLGOiwv2+OtPXq+Btm7uYOf86seEzZF0YIeCX+yjMSboiI2c
         88KAAH9HIiP8mIksgsZp+PAj4ru1k2qAoBwvknLWWIaxLiYqCPXrfpQdR3t64Yo/smWw
         mssYTEQkhqQzqJUIQIGqE8ovS1Q8LVE8onl+dSfriT/vuzqlQjQ1KBty0AmTEQCfA9PE
         kRsrsF9w1ILVCA088Hb4AdoGwDJATkxgpNUDeaRcHGpXzc9qAEwwwGArtJWsIkXf3ISB
         x31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368533; x=1687960533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTPwRcU9/1owFrxG0zY81x47hBDLk9OGUJzI1r232yU=;
        b=VGvXJ4DBX9usLYPPXQFAtlezevndmzyAw1YP2ydxRF9G7E6+G79bL0nFbRl8jhPBSv
         37UvmftwdaR4xzxLatVqI2dA4Zf6GkUaibuE4ywlaKGresMjHiYsuYAicdtHtieU6rMI
         xzg9/Si7cL8cBcVXnBKAjhU/df9Sq08gFCE4cUkbwifYh6u2+GtWtp4jkM9gOCDLubkm
         u96F4pf1ITF9LZyBg3MnncwOFRJF4jYb8ZqEMWVlE5lGvVOo1jx89bCvfE3DFEAXqT28
         F1LWAr4x+P+OlZt86+uDwMNOWGsbhuOnH/pVxACvaXihqSjAKIFG6L0BMX88KMDvkZ0t
         Gb0A==
X-Gm-Message-State: AC+VfDxjpVlZxoWieTtHBS1hOEk8ohl9a2DZQx1aClRrCxeqBB0dfQ28
        tezri3Ttr2KwqcRFByA7bKQ=
X-Google-Smtp-Source: ACHHUZ5eSkNEsDiTtiEBDzlhzfIK9hH43HFqaSiCjMt3hgF///ZXBnNz6oeXz1iWZkcB2H6r75yy/A==
X-Received: by 2002:a5d:4143:0:b0:30a:ec3b:58d8 with SMTP id c3-20020a5d4143000000b0030aec3b58d8mr1939358wrq.3.1685368533466;
        Mon, 29 May 2023 06:55:33 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d5344000000b00307acec258esm74633wrv.3.2023.05.29.06.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:55:32 -0700 (PDT)
Message-ID: <86a96f9d-196a-8592-41ac-f3b8303d55c6@gmail.com>
Date:   Mon, 29 May 2023 15:55:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 17/27] arm64: dts: mediatek: mt6795: Add MMSYS node for
 multimedia clocks
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-18-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-18-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add the MultiMedia System node, providing clocks for the multimedia
> hardware blocks and their IOMMU/SMIs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt6795.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> index 99cc4918e6ba..a8b2c4517e79 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> @@ -635,6 +635,19 @@ mmc3: mmc@11260000 {
>   			status = "disabled";
>   		};
>   
> +		mmsys: syscon@14000000 {
> +			compatible = "mediatek,mt6795-mmsys", "syscon";
> +			reg = <0 0x14000000 0 0x1000>;
> +			power-domains = <&spm MT6795_POWER_DOMAIN_MM>;
> +			assigned-clocks = <&topckgen CLK_TOP_MM_SEL>;
> +			assigned-clock-rates = <400000000>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
> +				 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
> +		};
> +
>   		vdecsys: clock-controller@16000000 {
>   			compatible = "mediatek,mt6795-vdecsys";
>   			reg = <0 0x16000000 0 0x1000>;
