Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D8E6FA23E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjEHI2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEHI2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:28:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD15A12C;
        Mon,  8 May 2023 01:28:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3078c092056so955069f8f.1;
        Mon, 08 May 2023 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683534514; x=1686126514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7KgIL1bMV9kYL6OUESBCGrqm4t03uZIWLLU9sCoPjw=;
        b=B2KkoLBCmCtSbdt1Q5rIDtJSSufo1t3n8mdHWvWN3sE/9SprGq2UOFKR1dRcn6hwb0
         o2Mzazpch1+0HgGshEVuAZr6gn6iZthTGLKMIou8i9QwxMhzphVpeJjivRq48cR0CTFN
         wwaQI7PMqV7NgZsnTUdoCdbQY2xxLmPxFhxLdn1X8t7i7ms7Ix6YWkOdkE8WvoOK3RhF
         jOcy2eGvrQbH4kTwygUf0nzjqIH1BseTaiYnNxTF2/MlgNVSjj2wnoxtL4QfPitnCYTZ
         gQQgPohn2nY4gKdzzgS7FL63p7Tr67Wf9b69xFC4Nw5NZPmrWxkRJqUVQlHV9DGXNhFM
         PfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683534514; x=1686126514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7KgIL1bMV9kYL6OUESBCGrqm4t03uZIWLLU9sCoPjw=;
        b=XhbrtFw9Ul2uOekJZW0r73U6m4qoe2LdQEevPRlEhdpMvQd5XmTf9rOwb0g23yRFnH
         XbQkTN35oNXV524kar1Bx/rJeiMH4QT/lRy7dApZq0w/cGW9YAwMjOdWsolCt7wECi2S
         /sa1ddtxJO9C4Rp5r25tF/9kuczs3KZOfcRHFTK1/weqaHQAoGMzhpsFQlAFZVg5ZtJ8
         +xvPU3QhNNroFMvGPq4Ajnp1hXRDuzrtiIJtNzpn4zJAcQbWAqPoXDLrSfG8O0kYDfu+
         2NCWNBS5/3nU7HunSv1WrQjeJM9QzZsbL+3xMjcOW6H1RsYsnU7OpErS0Ea8rfaBC0PU
         ao9A==
X-Gm-Message-State: AC+VfDzKD7TqJiOd5H0Zhl6keWDP62cfCCrlsLcs0FI3fKSOcadCZlEm
        rptBqOhVB1FF1tn/loxFD4ak6DPzZsw=
X-Google-Smtp-Source: ACHHUZ51K1Qt32Y5HxtLEL/tHhJR/egwHhejes+cPP7TGh+HO6HCpEqoOgRPPAMpaotCvenqtq38Pw==
X-Received: by 2002:adf:fe10:0:b0:2d5:39d:514f with SMTP id n16-20020adffe10000000b002d5039d514fmr6182575wrr.65.1683534513760;
        Mon, 08 May 2023 01:28:33 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4bd2000000b003078bb639bdsm6296957wrt.68.2023.05.08.01.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 01:28:32 -0700 (PDT)
Message-ID: <6ee0165d-ca39-a350-d31d-4b16a011e9ea@gmail.com>
Date:   Mon, 8 May 2023 10:28:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] clk: mediatek: mux: Stop forcing CLK_SET_RATE_PARENT
 flag
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
 <20230505093733.221922-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230505093733.221922-2-angelogioacchino.delregno@collabora.com>
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
> The clk-mux driver was forcing the CLK_SET_RATE_PARENT flag even for
> the GATE_CLK_SET_UPD_FLAGS() macro, as in mtk_clk_register_mux() the
> flag was unconditionally added.
> 
> In preparation for a change on MSDC clock muxes, stop forcing this
> flag and, where necessary, update clock drivers to add it so that
> with this commit we introduce no functional changes for the currently
> supported SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>


> ---
>   drivers/clk/mediatek/clk-mt6765.c          |  8 +++---
>   drivers/clk/mediatek/clk-mt6779.c          |  6 ++---
>   drivers/clk/mediatek/clk-mt8183.c          |  6 +++--
>   drivers/clk/mediatek/clk-mt8186-topckgen.c | 12 ++++-----
>   drivers/clk/mediatek/clk-mt8188-topckgen.c | 24 +++++++++++------
>   drivers/clk/mediatek/clk-mt8192.c          |  6 ++---
>   drivers/clk/mediatek/clk-mt8195-topckgen.c | 30 ++++++++++++++--------
>   drivers/clk/mediatek/clk-mux.c             |  2 +-
>   8 files changed, 58 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
> index fa7948ef1e68..4f028df6c0a9 100644
> --- a/drivers/clk/mediatek/clk-mt6765.c
> +++ b/drivers/clk/mediatek/clk-mt6765.c
> @@ -367,10 +367,12 @@ static const struct mtk_mux top_muxes[] = {
>   	/* CLK_CFG_0 */
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, "axi_sel", axi_parents,
>   			      CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR,
> -			      0, 2, 7, CLK_CFG_UPDATE, 0, CLK_IS_CRITICAL),
> +			      0, 2, 7, CLK_CFG_UPDATE, 0,
> +			      CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MEM_SEL, "mem_sel", mem_parents,
>   			      CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR,
> -			      8, 2, 15, CLK_CFG_UPDATE, 1, CLK_IS_CRITICAL),
> +			      8, 2, 15, CLK_CFG_UPDATE, 1,
> +			      CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_MM_SEL, "mm_sel", mm_parents, CLK_CFG_0,
>   			CLK_CFG_0_SET, CLK_CFG_0_CLR, 16, 3, 23,
>   			CLK_CFG_UPDATE, 2),
> @@ -459,7 +461,7 @@ static const struct mtk_mux top_muxes[] = {
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_PWRAP_ULPOSC_SEL, "ulposc_sel",
>   			      ulposc_parents, CLK_CFG_7, CLK_CFG_7_SET,
>   			      CLK_CFG_7_CLR, 0, 3, 7, CLK_CFG_UPDATE, 28,
> -			      CLK_IS_CRITICAL),
> +			      CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTM_SEL, "camtm_sel", camtm_parents,
>   			CLK_CFG_7, CLK_CFG_7_SET, CLK_CFG_7_CLR, 8, 2, 15,
>   			CLK_CFG_UPDATE, 29),
> diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
> index 1f5ea1508f61..ada927a61309 100644
> --- a/drivers/clk/mediatek/clk-mt6779.c
> +++ b/drivers/clk/mediatek/clk-mt6779.c
> @@ -640,7 +640,7 @@ static const struct mtk_mux top_muxes[] = {
>   	/* CLK_CFG_0 */
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI, "axi_sel", axi_parents,
>   				   0x20, 0x24, 0x28, 0, 2, 7,
> -				   0x004, 0, CLK_IS_CRITICAL),
> +				   0x004, 0, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_MM, "mm_sel", mm_parents,
>   			     0x20, 0x24, 0x28, 8, 3, 15, 0x004, 1),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_SCP, "scp_sel", scp_parents,
> @@ -710,7 +710,7 @@ static const struct mtk_mux top_muxes[] = {
>   			     0x90, 0x94, 0x98, 0, 2, 7, 0x004, 28),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SSPM, "sspm_sel", sspm_parents,
>   				   0x90, 0x94, 0x98, 8, 3, 15,
> -				   0x004, 29, CLK_IS_CRITICAL),
> +				   0x004, 29, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_DPI0, "dpi0_sel", dpi0_parents,
>   			     0x90, 0x94, 0x98, 16, 3, 23, 0x004, 30),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_SCAM, "scam_sel", scam_parents,
> @@ -727,7 +727,7 @@ static const struct mtk_mux top_muxes[] = {
>   			     16, 2, 23, 0x008, 3),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM, "spm_sel", spm_parents,
>   				   0xa0, 0xa4, 0xa8, 24, 2, 31,
> -				   0x008, 4, CLK_IS_CRITICAL),
> +				   0x008, 4, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	/* CLK_CFG_9 */
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C, "i2c_sel", i2c_parents,
>   			     0xb0, 0xb4, 0xb8, 0, 2, 7, 0x008, 5),
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> index 2336a1b69c09..95786b0c2d5f 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -451,7 +451,8 @@ static const char * const aud_2_parents[] = {
>   static const struct mtk_mux top_muxes[] = {
>   	/* CLK_CFG_0 */
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_AXI, "axi_sel",
> -		axi_parents, 0x40, 0x44, 0x48, 0, 2, 7, 0x004, 0, CLK_IS_CRITICAL),
> +		axi_parents, 0x40, 0x44, 0x48, 0, 2, 7, 0x004, 0,
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_MM, "mm_sel",
>   		mm_parents, 0x40, 0x44, 0x48, 8, 3, 15, 0x004, 1),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_IMG, "img_sel",
> @@ -518,7 +519,8 @@ static const struct mtk_mux top_muxes[] = {
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_SSUSB_TOP_XHCI, "ssusb_top_xhci_sel",
>   		ssusb_top_xhci_parents, 0xb0, 0xb4, 0xb8, 16, 2, 23, 0x004, 30),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_SPM, "spm_sel",
> -		spm_parents, 0xb0, 0xb4, 0xb8, 24, 1, 31, 0x008, 0, CLK_IS_CRITICAL),
> +		spm_parents, 0xb0, 0xb4, 0xb8, 24, 1, 31, 0x008, 0,
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	/* CLK_CFG_8 */
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_I2C, "i2c_sel",
>   		i2c_parents, 0xc0, 0xc4, 0xc8, 0, 2, 7, 0x008, 1),
> diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
> index 1a0340a20beb..669806212073 100644
> --- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
> @@ -504,10 +504,10 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	 */
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI, "top_axi", axi_parents,
>   				   0x0040, 0x0044, 0x0048, 0, 2, 7, 0x0004, 0,
> -				   CLK_IS_CRITICAL),
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SCP, "top_scp", scp_parents,
>   				   0x0040, 0x0044, 0x0048, 8, 3, 15, 0x0004, 1,
> -				   CLK_IS_CRITICAL),
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_MFG, "top_mfg",
>   		mfg_parents, 0x0040, 0x0044, 0x0048, 16, 2, 23, 0x0004, 2),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG, "top_camtg",
> @@ -559,7 +559,7 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   		disp_pwm_parents, 0x0090, 0x0094, 0x0098, 8, 3, 15, 0x0004, 21),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SSPM, "top_sspm", sspm_parents,
>   				   0x0090, 0x0094, 0x0098, 16, 3, 23, 0x0004, 22,
> -				   CLK_IS_CRITICAL),
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_DXCC, "top_dxcc",
>   		dxcc_parents, 0x0090, 0x0094, 0x0098, 24, 2, 31, 0x0004, 23),
>   	/*
> @@ -570,10 +570,10 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   		usb_parents, 0x00a0, 0x00a4, 0x00a8, 0, 2, 7, 0x0004, 24),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SRCK, "top_srck", srck_parents,
>   				   0x00a0, 0x00a4, 0x00a8, 8, 2, 15, 0x0004, 25,
> -				   CLK_IS_CRITICAL),
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM, "top_spm", spm_parents,
>   				   0x00a0, 0x00a4, 0x00a8, 16, 2, 23, 0x0004, 26,
> -				   CLK_IS_CRITICAL),
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C, "top_i2c",
>   		i2c_parents, 0x00a0, 0x00a4, 0x00a8, 24, 2, 31, 0x0004, 27),
>   	/* CLK_CFG_7 */
> @@ -627,7 +627,7 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	 */
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_DVFSRC, "top_dvfsrc", dvfsrc_parents,
>   				   0x0100, 0x0104, 0x0108, 0, 1, 7, 0x0008, 17,
> -				   CLK_IS_CRITICAL),
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_DSI_OCC, "top_dsi_occ",
>   		dsi_occ_parents, 0x0100, 0x0104, 0x0108, 8, 2, 15, 0x0008, 18),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPMI_MST, "top_spmi_mst",
> diff --git a/drivers/clk/mediatek/clk-mt8188-topckgen.c b/drivers/clk/mediatek/clk-mt8188-topckgen.c
> index c56ec42cb15f..7c99244d997e 100644
> --- a/drivers/clk/mediatek/clk-mt8188-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8188-topckgen.c
> @@ -954,13 +954,17 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	 * spm_sel and scp_sel are main clocks in always-on co-processor.
>   	 */
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI, "top_axi", axi_parents,
> -				   0x020, 0x024, 0x028, 0, 4, 7, 0x04, 0, CLK_IS_CRITICAL),
> +				   0x020, 0x024, 0x028, 0, 4, 7, 0x04, 0,
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM, "top_spm", spm_parents,
> -				   0x020, 0x024, 0x028, 8, 4, 15, 0x04, 1, CLK_IS_CRITICAL),
> +				   0x020, 0x024, 0x028, 8, 4, 15, 0x04, 1,
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SCP, "top_scp", scp_parents,
> -				   0x020, 0x024, 0x028, 16, 4, 23, 0x04, 2, CLK_IS_CRITICAL),
> +				   0x020, 0x024, 0x028, 16, 4, 23, 0x04, 2,
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_BUS_AXIMEM, "top_bus_aximem", bus_aximem_parents,
> -				   0x020, 0x024, 0x028, 24, 4, 31, 0x04, 3, CLK_IS_CRITICAL),
> +				   0x020, 0x024, 0x028, 24, 4, 31, 0x04, 3,
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	/* CLK_CFG_1 */
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_VPP, "top_vpp",
>   			     vpp_parents, 0x02C, 0x030, 0x034, 0, 4, 7, 0x04, 4),
> @@ -1078,7 +1082,8 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM, "top_pwm",
>   			     pwm_parents, 0x0BC, 0x0C0, 0x0C4, 8, 4, 15, 0x08, 21),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MCUPM, "top_mcupm", mcupm_parents,
> -				   0x0BC, 0x0C0, 0x0C4, 16, 4, 23, 0x08, 22, CLK_IS_CRITICAL),
> +				   0x0BC, 0x0C0, 0x0C4, 16, 4, 23, 0x08, 22,
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPMI_P_MST, "top_spmi_p_mst",
>   			     spmi_p_mst_parents, 0x0BC, 0x0C0, 0x0C4, 24, 4, 31, 0x08, 23),
>   	/*
> @@ -1088,7 +1093,8 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPMI_M_MST, "top_spmi_m_mst",
>   			     spmi_m_mst_parents, 0x0C8, 0x0CC, 0x0D0, 0, 4, 7, 0x08, 24),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_DVFSRC, "top_dvfsrc", dvfsrc_parents,
> -				   0x0C8, 0x0CC, 0x0D0, 8, 4, 15, 0x08, 25, CLK_IS_CRITICAL),
> +				   0x0C8, 0x0CC, 0x0D0, 8, 4, 15, 0x08, 25,
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_TL, "top_tl",
>   			     tl_parents, 0x0C8, 0x0CC, 0x0D0, 16, 4, 23, 0x08, 26),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_AES_MSDCFDE, "top_aes_msdcfde",
> @@ -1164,9 +1170,11 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPINOR, "top_spinor",
>   			     spinor_parents, 0x0128, 0x012C, 0x0130, 0, 4, 7, 0x0C, 24),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_ULPOSC, "top_ulposc", ulposc_parents,
> -				   0x0128, 0x012C, 0x0130, 8, 4, 15, 0x0C, 25, CLK_IS_CRITICAL),
> +				   0x0128, 0x012C, 0x0130, 8, 4, 15, 0x0C, 25,
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SRCK, "top_srck", srck_parents,
> -				   0x0128, 0x012C, 0x0130, 16, 4, 23, 0x0C, 26, CLK_IS_CRITICAL),
> +				   0x0128, 0x012C, 0x0130, 16, 4, 23, 0x0C, 26,
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   };
>   
>   static const struct mtk_composite top_adj_divs[] = {
> diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
> index aa11291463f7..8a9e6d5f85b4 100644
> --- a/drivers/clk/mediatek/clk-mt8192.c
> +++ b/drivers/clk/mediatek/clk-mt8192.c
> @@ -549,15 +549,15 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	/* CLK_CFG_0 */
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, "axi_sel",
>   				   axi_parents, 0x010, 0x014, 0x018, 0, 3, 7, 0x004, 0,
> -				   CLK_IS_CRITICAL),
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM_SEL, "spm_sel",
>   				   spm_parents, 0x010, 0x014, 0x018, 8, 2, 15, 0x004, 1,
> -				   CLK_IS_CRITICAL),
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_SCP_SEL, "scp_sel",
>   			     scp_parents, 0x010, 0x014, 0x018, 16, 3, 23, 0x004, 2),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_BUS_AXIMEM_SEL, "bus_aximem_sel",
>   				   bus_aximem_parents, 0x010, 0x014, 0x018, 24, 3, 31, 0x004, 3,
> -				   CLK_IS_CRITICAL),
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	/* CLK_CFG_1 */
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_SEL, "disp_sel",
>   			     disp_parents, 0x020, 0x024, 0x028, 0, 4, 7, 0x004, 4),
> diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> index 3c2174c3e742..3acbd1c907ab 100644
> --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> @@ -862,13 +862,17 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	 * top_spm and top_scp are main clocks in always-on co-processor.
>   	 */
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI, "top_axi",
> -		axi_parents, 0x020, 0x024, 0x028, 0, 3, 7, 0x04, 0, CLK_IS_CRITICAL),
> +		axi_parents, 0x020, 0x024, 0x028, 0, 3, 7, 0x04, 0,
> +		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM, "top_spm",
> -		spm_parents, 0x020, 0x024, 0x028, 8, 2, 15, 0x04, 1, CLK_IS_CRITICAL),
> +		spm_parents, 0x020, 0x024, 0x028, 8, 2, 15, 0x04, 1,
> +		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SCP, "top_scp",
> -		scp_parents, 0x020, 0x024, 0x028, 16, 3, 23, 0x04, 2, CLK_IS_CRITICAL),
> +		scp_parents, 0x020, 0x024, 0x028, 16, 3, 23, 0x04, 2,
> +		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_BUS_AXIMEM, "top_bus_aximem",
> -		bus_aximem_parents, 0x020, 0x024, 0x028, 24, 3, 31, 0x04, 3, CLK_IS_CRITICAL),
> +		bus_aximem_parents, 0x020, 0x024, 0x028, 24, 3, 31, 0x04, 3,
> +		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	/* CLK_CFG_1 */
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_VPP, "top_vpp",
>   		vpp_parents, 0x02C, 0x030, 0x034, 0, 4, 7, 0x04, 4),
> @@ -951,7 +955,8 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_ATB, "top_atb",
>   		atb_parents, 0x08C, 0x090, 0x094, 8, 2, 15, 0x08, 5),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_PWRMCU, "top_pwrmcu",
> -		pwrmcu_parents, 0x08C, 0x090, 0x094, 16, 3, 23, 0x08, 6, CLK_IS_CRITICAL),
> +		pwrmcu_parents, 0x08C, 0x090, 0x094, 16, 3, 23, 0x08, 6,
> +		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_DP, "top_dp",
>   		dp_parents, 0x08C, 0x090, 0x094, 24, 4, 31, 0x08, 7),
>   	/* CLK_CFG_10 */
> @@ -1020,7 +1025,8 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM, "top_pwm",
>   		pwm_parents, 0x0E0, 0x0E4, 0x0E8, 16, 1, 23, 0x0C, 2),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MCUPM, "top_mcupm",
> -		mcupm_parents, 0x0E0, 0x0E4, 0x0E8, 24, 2, 31, 0x0C, 3, CLK_IS_CRITICAL),
> +		mcupm_parents, 0x0E0, 0x0E4, 0x0E8, 24, 2, 31, 0x0C, 3,
> +		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	/*
>   	 * CLK_CFG_17
>   	 * top_dvfsrc is for internal DVFS usage, should not be handled by Linux.
> @@ -1030,7 +1036,8 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPMI_M_MST, "top_spmi_m_mst",
>   		spmi_parents, 0x0EC, 0x0F0, 0x0F4, 8, 4, 15, 0x0C, 5),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_DVFSRC, "top_dvfsrc",
> -		dvfsrc_parents, 0x0EC, 0x0F0, 0x0F4, 16, 2, 23, 0x0C, 6, CLK_IS_CRITICAL),
> +		dvfsrc_parents, 0x0EC, 0x0F0, 0x0F4, 16, 2, 23, 0x0C, 6,
> +		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_TL, "top_tl",
>   		tl_parents, 0x0EC, 0x0F0, 0x0F4, 24, 2, 31, 0x0C, 7),
>   	/* CLK_CFG_18 */
> @@ -1141,11 +1148,14 @@ static const struct mtk_mux top_mtk_muxes[] = {
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_DVIO_DGI_REF, "top_dvio_dgi_ref",
>   		dvio_dgi_ref_parents, 0x017C, 0x0180, 0x0184, 0, 3, 7, 0x010, 20),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_ULPOSC, "top_ulposc",
> -		ulposc_parents, 0x017C, 0x0180, 0x0184, 8, 2, 15, 0x010, 21, CLK_IS_CRITICAL),
> +		ulposc_parents, 0x017C, 0x0180, 0x0184, 8, 2, 15, 0x010, 21,
> +		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_ULPOSC_CORE, "top_ulposc_core",
> -		ulposc_core_parents, 0x017C, 0x0180, 0x0184, 16, 2, 23, 0x010, 22, CLK_IS_CRITICAL),
> +		ulposc_core_parents, 0x017C, 0x0180, 0x0184, 16, 2, 23, 0x010, 22,
> +		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SRCK, "top_srck",
> -		srck_parents, 0x017C, 0x0180, 0x0184, 24, 1, 31, 0x010, 23, CLK_IS_CRITICAL),
> +		srck_parents, 0x017C, 0x0180, 0x0184, 24, 1, 31, 0x010, 23,
> +		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	/*
>   	 * the clocks in CLK_CFG_30 ~ 37 are backup clock source, no need to handled
>   	 * by Linux.
> diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> index c8593554239d..c93bc7f926e5 100644
> --- a/drivers/clk/mediatek/clk-mux.c
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -168,7 +168,7 @@ static struct clk_hw *mtk_clk_register_mux(struct device *dev,
>   		return ERR_PTR(-ENOMEM);
>   
>   	init.name = mux->name;
> -	init.flags = mux->flags | CLK_SET_RATE_PARENT;
> +	init.flags = mux->flags;
>   	init.parent_names = mux->parent_names;
>   	init.num_parents = mux->num_parents;
>   	init.ops = mux->ops;
