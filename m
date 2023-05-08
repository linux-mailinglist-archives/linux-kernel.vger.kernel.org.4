Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DEF6FA268
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjEHIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjEHIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:37:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C9A100EB;
        Mon,  8 May 2023 01:37:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f41dceb93bso10526855e9.1;
        Mon, 08 May 2023 01:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683535067; x=1686127067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Lyi4hsZXlJKHoU/2Rw0a7crCUT5tHttNvmlvjISzlI=;
        b=ZA4vl7OzkG+dsoXEScLZXnUv2EwsRtU6DdXAa5q1OPpG2AmzuB1KFMj2d3wjE8/jyp
         cYkn/CDkdPMbzHfSTH+ySh7sKvgKGsp7NsUYVZ03G1dPqzHlYCURzmDZDHvJgN5rmhVQ
         ghWFC1xJvBVQipdlesPoOWcEtwroikXYtwELI9ImR8rnI3R9dHpqLl8bMo7TUBhx+TQJ
         wWw4T7MDE4PjhRfCC0fyFUyXQwjpAz57P0WbLsy5GeDhaqvH3TGtzFb3QqBjq2GyZ3bf
         sKGdsArGW7ASRHLZQg20fA6MH0S6Yjil3J8PFY+fUsCQ9A5o2MxQsIPUm9uT080TGspl
         96dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683535067; x=1686127067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Lyi4hsZXlJKHoU/2Rw0a7crCUT5tHttNvmlvjISzlI=;
        b=F99sBD4ZAx3Z0JcPf5Jr2hwTuMPR7HMysEhUBTW320SZ8aPmF78Zuh8xCLX9dEARot
         NNV4ABxpmFdjNad816MlAhZvaxVK08qGQDmaKgCBhsdQ3wIvuAefMBDVJ5mu43Fw76rD
         Aqrg0b9VXPWqbUHqhu0qEqYHyLWYrpHpLJKjjWnxzOCJ1gtaXNGyHrc0VQZsf84QxSL0
         MjU//DIWUcxeUKYnCQFJcrG+FS/vobe11RPtQ+4jT3vmFJAfBbWu3D/Il8FOSJnOjSHh
         iBj0ipWgvPhD2lpoZgXg6GFCfsklUXCY5bGZVFF/gpZAjla+1Uqfmrr5c++4MJAB0etR
         Y6OA==
X-Gm-Message-State: AC+VfDzpZaFtfdoYkmpBwCE8evAnYHbqWo/ki193rj0QX0usCbK9metJ
        uNrHi489xyOZGzOmnm+zZ3Y=
X-Google-Smtp-Source: ACHHUZ7lG6UJaf61g10OwTgZwCFcdh3/2kaonc0iW0Me7mOwer5M3n+2lpO9lxo7HHL8+R98b0631w==
X-Received: by 2002:a5d:4004:0:b0:2fa:631a:9f23 with SMTP id n4-20020a5d4004000000b002fa631a9f23mr6742518wrp.2.1683535066591;
        Mon, 08 May 2023 01:37:46 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d4091000000b003078a3f3a24sm6778733wrp.114.2023.05.08.01.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 01:37:45 -0700 (PDT)
Message-ID: <13f4b7ec-182d-5bdd-de92-99cb1b910423@gmail.com>
Date:   Mon, 8 May 2023 10:37:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] clk: mediatek: Remove CLK_SET_PARENT from all MSDC
 core clocks
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Cc:     sboyd@kernel.org, wenst@chromium.org, chun-jie.chen@mediatek.com,
        mandyjh.liu@mediatek.com, miles.chen@mediatek.com,
        zhaojh329@gmail.com, daniel@makrotopia.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        Garmin.Chang@mediatek.com, msp@baylibre.com,
        yangyingliang@huawei.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230505093733.221922-1-angelogioacchino.delregno@collabora.com>
 <20230505093733.221922-3-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230505093733.221922-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2023 11:37, AngeloGioacchino Del Regno wrote:
> Various MSDC core clocks, used for multiple MSDC controller instances,
> share the same parent(s): in order to add parents selection in the
> mtk-sd driver to achieve an accurate clock rate for all modes, remove
> the CLK_SET_RATE_PARENT flag from all MSDC clocks for all SoCs: this
> will make sure that a clk_set_rate() call performed for a clock on
> a secondary controller will not change the rate of a common parent,
> which would result in an overclock or underclock of one of the
> controllers.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/clk/mediatek/clk-mt6765.c          | 12 +++++------
>   drivers/clk/mediatek/clk-mt6779.c          | 18 ++++++++--------
>   drivers/clk/mediatek/clk-mt7981-topckgen.c | 12 +++++------
>   drivers/clk/mediatek/clk-mt7986-topckgen.c | 12 +++++------
>   drivers/clk/mediatek/clk-mt8173-topckgen.c | 24 +++++++++++-----------
>   drivers/clk/mediatek/clk-mt8183.c          | 16 +++++++--------
>   drivers/clk/mediatek/clk-mt8186-topckgen.c | 12 +++++------
>   drivers/clk/mediatek/clk-mt8188-topckgen.c | 16 +++++++--------
>   drivers/clk/mediatek/clk-mt8192.c          | 17 +++++++--------
>   drivers/clk/mediatek/clk-mt8195-topckgen.c | 16 +++++++--------
>   10 files changed, 78 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
> index 4f028df6c0a9..0377e6dd3206 100644
> --- a/drivers/clk/mediatek/clk-mt6765.c
> +++ b/drivers/clk/mediatek/clk-mt6765.c
> @@ -406,15 +406,15 @@ static const struct mtk_mux top_muxes[] = {
>   			CLK_CFG_2_SET, CLK_CFG_2_CLR, 24, 2, 31,
>   			CLK_CFG_UPDATE, 11),
>   	/* CLK_CFG_3 */
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK_SEL, "msdc5hclk",
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HCLK_SEL, "msdc5hclk",
>   			msdc5hclk_parents, CLK_CFG_3, CLK_CFG_3_SET,
> -			CLK_CFG_3_CLR, 0, 2, 7, CLK_CFG_UPDATE, 12),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel",
> +			CLK_CFG_3_CLR, 0, 2, 7, CLK_CFG_UPDATE, 12, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel",
>   			msdc50_0_parents, CLK_CFG_3, CLK_CFG_3_SET,
> -			CLK_CFG_3_CLR, 8, 3, 15, CLK_CFG_UPDATE, 13),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel",
> +			CLK_CFG_3_CLR, 8, 3, 15, CLK_CFG_UPDATE, 13, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel",
>   			msdc30_1_parents, CLK_CFG_3, CLK_CFG_3_SET,
> -			CLK_CFG_3_CLR, 16, 3, 23, CLK_CFG_UPDATE, 14),
> +			CLK_CFG_3_CLR, 16, 3, 23, CLK_CFG_UPDATE, 14, 0),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO_SEL, "audio_sel", audio_parents,
>   			CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR,
>   			24, 2, 31, CLK_CFG_UPDATE, 15),
> diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
> index ada927a61309..555e937e9430 100644
> --- a/drivers/clk/mediatek/clk-mt6779.c
> +++ b/drivers/clk/mediatek/clk-mt6779.c
> @@ -687,16 +687,16 @@ static const struct mtk_mux top_muxes[] = {
>   			     0x70, 0x74, 0x78, 0, 1, 7, 0x004, 20),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI, "spi_sel", spi_parents,
>   			     0x70, 0x74, 0x78, 8, 2, 15, 0x004, 21),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK, "msdc50_hclk_sel",
> -			     msdc50_hclk_parents, 0x70, 0x74, 0x78,
> -			     16, 2, 23, 0x004, 22),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0, "msdc50_0_sel",
> -			     msdc50_0_parents, 0x70, 0x74, 0x78,
> -			     24, 3, 31, 0x004, 23),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HCLK, "msdc50_hclk_sel",
> +				   msdc50_hclk_parents, 0x70, 0x74, 0x78,
> +				   16, 2, 23, 0x004, 22, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0, "msdc50_0_sel",
> +				   msdc50_0_parents, 0x70, 0x74, 0x78,
> +				   24, 3, 31, 0x004, 23, 0),
>   	/* CLK_CFG_6 */
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1, "msdc30_1_sel",
> -			     msdc30_1_parents, 0x80, 0x84, 0x88,
> -			     0, 3, 7, 0x004, 24),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1, "msdc30_1_sel",
> +				   msdc30_1_parents, 0x80, 0x84, 0x88,
> +				   0, 3, 7, 0x004, 24, 0),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD, "audio_sel", audio_parents,
>   			     0x80, 0x84, 0x88, 8, 2, 15, 0x004, 25),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_INTBUS, "aud_intbus_sel",
> diff --git a/drivers/clk/mediatek/clk-mt7981-topckgen.c b/drivers/clk/mediatek/clk-mt7981-topckgen.c
> index 3aba1a9b9a36..ac015a68674c 100644
> --- a/drivers/clk/mediatek/clk-mt7981-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt7981-topckgen.c
> @@ -310,12 +310,12 @@ static const struct mtk_mux top_muxes[] = {
>   			     pextp_tl_ck_parents, 0x010, 0x014, 0x018, 24, 2, 31,
>   			     0x1C0, 7),
>   	/* CLK_CFG_2 */
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_EMMC_208M_SEL, "emmc_208m_sel",
> -			     emmc_208m_parents, 0x020, 0x024, 0x028, 0, 3, 7,
> -			     0x1C0, 8),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_EMMC_400M_SEL, "emmc_400m_sel",
> -			     emmc_400m_parents, 0x020, 0x024, 0x028, 8, 2, 15,
> -			     0x1C0, 9),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_EMMC_208M_SEL, "emmc_208m_sel",
> +				   emmc_208m_parents, 0x020, 0x024, 0x028, 0, 3, 7,
> +				   0x1C0, 8, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_EMMC_400M_SEL, "emmc_400m_sel",
> +				   emmc_400m_parents, 0x020, 0x024, 0x028, 8, 2, 15,
> +				   0x1C0, 9, 0),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_F26M_SEL, "csw_f26m_sel",
>   				   csw_f26m_parents, 0x020, 0x024, 0x028, 16, 1, 23,
>   				   0x1C0, 10,
> diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
> index fbca3feded8f..536655bede26 100644
> --- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
> @@ -193,12 +193,12 @@ static const struct mtk_mux top_muxes[] = {
>   			     pextp_tl_ck_parents, 0x010, 0x014, 0x018, 24, 2,
>   			     31, 0x1C0, 7),
>   	/* CLK_CFG_2 */
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_EMMC_250M_SEL, "emmc_250m_sel",
> -			     emmc_250m_parents, 0x020, 0x024, 0x028, 0, 1, 7,
> -			     0x1C0, 8),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_EMMC_416M_SEL, "emmc_416m_sel",
> -			     emmc_416m_parents, 0x020, 0x024, 0x028, 8, 1, 15,
> -			     0x1C0, 9),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_EMMC_250M_SEL, "emmc_250m_sel",
> +				   emmc_250m_parents, 0x020, 0x024, 0x028, 0, 1, 7,
> +				   0x1C0, 8, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_EMMC_416M_SEL, "emmc_416m_sel",
> +				   emmc_416m_parents, 0x020, 0x024, 0x028, 8, 1, 15,
> +				   0x1C0, 9, 0),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_F_26M_ADC_SEL, "f_26m_adc_sel",
>   			     f_26m_adc_parents, 0x020, 0x024, 0x028, 16, 1, 23,
>   			     0x1C0, 10),
> diff --git a/drivers/clk/mediatek/clk-mt8173-topckgen.c b/drivers/clk/mediatek/clk-mt8173-topckgen.c
> index baa8fd6cb312..42c37541cebb 100644
> --- a/drivers/clk/mediatek/clk-mt8173-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8173-topckgen.c
> @@ -547,17 +547,17 @@ static const struct mtk_composite top_muxes[] = {
>   	MUX_GATE(CLK_TOP_USB20_SEL, "usb20_sel", usb20_parents, 0x0060, 24, 2, 31),
>   	/* CLK_CFG_3 */
>   	MUX_GATE(CLK_TOP_USB30_SEL, "usb30_sel", usb30_parents, 0x0070, 0, 2, 7),
> -	MUX_GATE(CLK_TOP_MSDC50_0_H_SEL, "msdc50_0_h_sel", msdc50_0_h_parents,
> -		 0x0070, 8, 3, 15),
> -	MUX_GATE(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel", msdc50_0_parents,
> -		 0x0070, 16, 4, 23),
> -	MUX_GATE(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel", msdc30_1_parents,
> -		 0x0070, 24, 3, 31),
> +	MUX_GATE_FLAGS(CLK_TOP_MSDC50_0_H_SEL, "msdc50_0_h_sel", msdc50_0_h_parents,
> +		 0x0070, 8, 3, 15, 0),
> +	MUX_GATE_FLAGS(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel", msdc50_0_parents,
> +		 0x0070, 16, 4, 23, 0),
> +	MUX_GATE_FLAGS(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel", msdc30_1_parents,
> +		 0x0070, 24, 3, 31, 0),
>   	/* CLK_CFG_4 */
> -	MUX_GATE(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel", msdc30_2_parents,
> -		 0x0080, 0, 3, 7),
> -	MUX_GATE(CLK_TOP_MSDC30_3_SEL, "msdc30_3_sel", msdc30_3_parents,
> -		 0x0080, 8, 4, 15),
> +	MUX_GATE_FLAGS(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel", msdc30_2_parents,
> +		 0x0080, 0, 3, 7, 0),
> +	MUX_GATE_FLAGS(CLK_TOP_MSDC30_3_SEL, "msdc30_3_sel", msdc30_3_parents,
> +		 0x0080, 8, 4, 15, 0),
>   	MUX_GATE(CLK_TOP_AUDIO_SEL, "audio_sel", audio_parents,
>   		 0x0080, 16, 2, 23),
>   	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, "aud_intbus_sel", aud_intbus_parents,
> @@ -595,8 +595,8 @@ static const struct mtk_composite top_muxes[] = {
>   	MUX_GATE(CLK_TOP_DPILVDS_SEL, "dpilvds_sel", dpilvds_parents,
>   		 0x00c0, 24, 3, 31),
>   	/* CLK_CFG_13 */
> -	MUX_GATE(CLK_TOP_MSDC50_2_H_SEL, "msdc50_2_h_sel", msdc50_2_h_parents,
> -		 0x00d0, 0, 3, 7),
> +	MUX_GATE_FLAGS(CLK_TOP_MSDC50_2_H_SEL, "msdc50_2_h_sel", msdc50_2_h_parents,
> +		 0x00d0, 0, 3, 7, 0),
>   	MUX_GATE(CLK_TOP_HDCP_SEL, "hdcp_sel", hdcp_parents, 0x00d0, 8, 2, 15),
>   	MUX_GATE(CLK_TOP_HDCP_24M_SEL, "hdcp_24m_sel", hdcp_24m_parents,
>   		 0x00d0, 16, 2, 23),
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> index 95786b0c2d5f..dc1a24f0046f 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -487,14 +487,14 @@ static const struct mtk_mux top_muxes[] = {
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_SPI, "spi_sel",
>   		spi_parents, 0x70, 0x74, 0x78, 24, 2, 31, 0x004, 15),
>   	/* CLK_CFG_4 */
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_MSDC50_0_HCLK, "msdc50_hclk_sel",
> -		msdc50_hclk_parents, 0x80, 0x84, 0x88, 0, 2, 7, 0x004, 16),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_MSDC50_0, "msdc50_0_sel",
> -		msdc50_0_parents, 0x80, 0x84, 0x88, 8, 3, 15, 0x004, 17),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_MSDC30_1, "msdc30_1_sel",
> -		msdc30_1_parents, 0x80, 0x84, 0x88, 16, 3, 23, 0x004, 18),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_MSDC30_2, "msdc30_2_sel",
> -		msdc30_2_parents, 0x80, 0x84, 0x88, 24, 3, 31, 0x004, 19),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_MSDC50_0_HCLK, "msdc50_hclk_sel",
> +		msdc50_hclk_parents, 0x80, 0x84, 0x88, 0, 2, 7, 0x004, 16, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_MSDC50_0, "msdc50_0_sel",
> +		msdc50_0_parents, 0x80, 0x84, 0x88, 8, 3, 15, 0x004, 17, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_MSDC30_1, "msdc30_1_sel",
> +		msdc30_1_parents, 0x80, 0x84, 0x88, 16, 3, 23, 0x004, 18, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_MSDC30_2, "msdc30_2_sel",
> +		msdc30_2_parents, 0x80, 0x84, 0x88, 24, 3, 31, 0x004, 19, 0),
>   	/* CLK_CFG_5 */
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_AUDIO, "audio_sel",
>   		audio_parents, 0x90, 0x94, 0x98, 0, 2, 7, 0x004, 20),
> diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
> index 669806212073..b8a619e98da0 100644
> --- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
> @@ -531,12 +531,12 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI, "top_spi",
>   		spi_parents, 0x0060, 0x0064, 0x0068, 24, 3, 31, 0x0004, 11),
>   	/* CLK_CFG_3 */
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK, "top_msdc5hclk",
> -		msdc5hclk_parents, 0x0070, 0x0074, 0x0078, 0, 2, 7, 0x0004, 12),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0, "top_msdc50_0",
> -		msdc50_0_parents, 0x0070, 0x0074, 0x0078, 8, 3, 15, 0x0004, 13),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1, "top_msdc30_1",
> -		msdc30_1_parents, 0x0070, 0x0074, 0x0078, 16, 3, 23, 0x0004, 14),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HCLK, "top_msdc5hclk",
> +		msdc5hclk_parents, 0x0070, 0x0074, 0x0078, 0, 2, 7, 0x0004, 12, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0, "top_msdc50_0",
> +		msdc50_0_parents, 0x0070, 0x0074, 0x0078, 8, 3, 15, 0x0004, 13, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1, "top_msdc30_1",
> +		msdc30_1_parents, 0x0070, 0x0074, 0x0078, 16, 3, 23, 0x0004, 14, 0),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO, "top_audio",
>   		audio_parents, 0x0070, 0x0074, 0x0078, 24, 2, 31, 0x0004, 15),
>   	/* CLK_CFG_4 */
> diff --git a/drivers/clk/mediatek/clk-mt8188-topckgen.c b/drivers/clk/mediatek/clk-mt8188-topckgen.c
> index 7c99244d997e..8699b87b130d 100644
> --- a/drivers/clk/mediatek/clk-mt8188-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8188-topckgen.c
> @@ -1015,15 +1015,15 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   			     uart_parents, 0x068, 0x06C, 0x070, 0, 4, 7, 0x04, 24),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI, "top_spi",
>   			     spi_parents, 0x068, 0x06C, 0x070, 8, 4, 15, 0x04, 25),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK, "top_msdc5hclk",
> -			     msdc5hclk_parents, 0x068, 0x06C, 0x070, 16, 4, 23, 0x04, 26),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0, "top_msdc50_0",
> -			     msdc50_0_parents, 0x068, 0x06C, 0x070, 24, 4, 31, 0x04, 27),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HCLK, "top_msdc5hclk",
> +				   msdc5hclk_parents, 0x068, 0x06C, 0x070, 16, 4, 23, 0x04, 26, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0, "top_msdc50_0",
> +				   msdc50_0_parents, 0x068, 0x06C, 0x070, 24, 4, 31, 0x04, 27, 0),
>   	/* CLK_CFG_7 */
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1, "top_msdc30_1",
> -			     msdc30_1_parents, 0x074, 0x078, 0x07C, 0, 4, 7, 0x04, 28),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2, "top_msdc30_2",
> -			     msdc30_2_parents, 0x074, 0x078, 0x07C, 8, 4, 15, 0x04, 29),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1, "top_msdc30_1",
> +				   msdc30_1_parents, 0x074, 0x078, 0x07C, 0, 4, 7, 0x04, 28, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_2, "top_msdc30_2",
> +				   msdc30_2_parents, 0x074, 0x078, 0x07C, 8, 4, 15, 0x04, 29, 0),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_INTDIR, "top_intdir",
>   			     intdir_parents, 0x074, 0x078, 0x07C, 16, 4, 23, 0x04, 30),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_INTBUS, "top_aud_intbus",
> diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
> index 8a9e6d5f85b4..55fc6fc3c467 100644
> --- a/drivers/clk/mediatek/clk-mt8192.c
> +++ b/drivers/clk/mediatek/clk-mt8192.c
> @@ -601,15 +601,16 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   			     uart_parents, 0x070, 0x074, 0x078, 8, 1, 15, 0x004, 25),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI_SEL, "spi_sel",
>   			     spi_parents, 0x070, 0x074, 0x078, 16, 2, 23, 0x004, 26),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_H_SEL, "msdc50_0_h_sel",
> -			     msdc50_0_h_parents, 0x070, 0x074, 0x078, 24, 2, 31, 0x004, 27),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_H_SEL, "msdc50_0_h_sel",
> +				   msdc50_0_h_parents, 0x070, 0x074, 0x078, 24, 2,
> +				   31, 0x004, 27, 0),
>   	/* CLK_CFG_7 */
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel",
> -			     msdc50_0_parents, 0x080, 0x084, 0x088, 0, 3, 7, 0x004, 28),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel",
> -			     msdc30_parents, 0x080, 0x084, 0x088, 8, 3, 15, 0x004, 29),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel",
> -			     msdc30_parents, 0x080, 0x084, 0x088, 16, 3, 23, 0x004, 30),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel",
> +				   msdc50_0_parents, 0x080, 0x084, 0x088, 0, 3, 7, 0x004, 28, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel",
> +				   msdc30_parents, 0x080, 0x084, 0x088, 8, 3, 15, 0x004, 29, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel",
> +				   msdc30_parents, 0x080, 0x084, 0x088, 16, 3, 23, 0x004, 30, 0),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO_SEL, "audio_sel",
>   			     audio_parents, 0x080, 0x084, 0x088, 24, 2, 31, 0x008, 0),
>   	/* CLK_CFG_8 */
> diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> index 3acbd1c907ab..f4b3d8ba9ff4 100644
> --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> @@ -930,15 +930,15 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	/* CLK_CFG_7 */
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPIS, "top_spis",
>   		spis_parents, 0x074, 0x078, 0x07C, 0, 3, 7, 0x04, 28),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK, "top_msdc50_0_hclk",
> -		msdc50_0_h_parents, 0x074, 0x078, 0x07C, 8, 2, 15, 0x04, 29),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0, "top_msdc50_0",
> -		msdc50_0_parents, 0x074, 0x078, 0x07C, 16, 3, 23, 0x04, 30),
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1, "top_msdc30_1",
> -		msdc30_parents, 0x074, 0x078, 0x07C, 24, 3, 31, 0x04, 31),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HCLK, "top_msdc50_0_hclk",
> +		msdc50_0_h_parents, 0x074, 0x078, 0x07C, 8, 2, 15, 0x04, 29, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0, "top_msdc50_0",
> +		msdc50_0_parents, 0x074, 0x078, 0x07C, 16, 3, 23, 0x04, 30, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1, "top_msdc30_1",
> +		msdc30_parents, 0x074, 0x078, 0x07C, 24, 3, 31, 0x04, 31, 0),
>   	/* CLK_CFG_8 */
> -	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2, "top_msdc30_2",
> -		msdc30_parents, 0x080, 0x084, 0x088, 0, 3, 7, 0x08, 0),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_2, "top_msdc30_2",
> +		msdc30_parents, 0x080, 0x084, 0x088, 0, 3, 7, 0x08, 0, 0),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_INTDIR, "top_intdir",
>   		intdir_parents, 0x080, 0x084, 0x088, 8, 2, 15, 0x08, 1),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_INTBUS, "top_aud_intbus",
