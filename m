Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4937009F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbjELOHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241230AbjELOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:07:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667B3198E;
        Fri, 12 May 2023 07:07:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f435658d23so39150965e9.3;
        Fri, 12 May 2023 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683900428; x=1686492428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBK7MtjywAeGn+dXgdBRN46DBOY/1h28sVdTEkwe97Q=;
        b=MXezRAlnkuTV5pIpjNtJgwSMWk2ZtW3qENIEJCAHbuk0aVXOIC8odl/Fnb4T7vZUci
         xu5Bh9Q3uH3CwzGETOxyeotYE1aC8So6ucFo8znyX0R8a6Tj/o1efJt7rcgpm4mMmvMT
         aDzBHHyYWeT/RoTLjo1kPjCCqYsYDx6HCj3+yXL6jqbrk3HhukLzcCOL5KIQokSZ3zn7
         AfkHtj/ZIPOHX/v/h7RdPAfeBTjShXG1H06NsI4d0RDhklGJiV28ctasKVKjOc1yzaVg
         rLwlChOeVn8LXOrCaW/s0dRV4TdHYxoPy5H0Ix+pjPIuv+PHp9t+/FCbBaumrLCrHcml
         3NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683900428; x=1686492428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBK7MtjywAeGn+dXgdBRN46DBOY/1h28sVdTEkwe97Q=;
        b=TFQh1uId8LMuoHbfoltFIMD8T0HRrORY6i3MOD6Lzea8cyRNj/Kg2ShSrYyeKacUQr
         5+rTw1wCxb7Qu3N0tlkahhNJql0Iq0ZD18gNWU6kyG8aSRBPgbBoDrX/ExC0kURv0SUe
         +xUAk8FIvtdLXMP2ZH9XdRZ82C7DUuv/AJmnxRefz5WXAx8T57U+wHSZ7uPLcRhXfNKi
         YlsdvZS4lnfRVxmeYfMMTJBivuPyL+jX0v7yxkiGujbyQhGZ+GH8bcQI0RR89WVeVHz7
         Rd17as3oPsjSIW0UGQAJaiToyiZyUJ6BM1DOCsq6NBuf84mNzpUmNcn8ML35Ao3eSV2j
         dhBg==
X-Gm-Message-State: AC+VfDzMCjQbpv6daFcBNgot6Vv/7Rj0KK1Wq1AXEegfZ8S+qwdFn32A
        Ps4Ixm7G6RFOD32r2Jn+8V4=
X-Google-Smtp-Source: ACHHUZ466uoppPjkd165GZeEqdb991Ed9InTgjqBaF1UTbDVf5K/JhK+r1n2dr8zXlAuq8GT95qpZw==
X-Received: by 2002:a05:600c:2283:b0:3f4:2254:bd86 with SMTP id 3-20020a05600c228300b003f42254bd86mr14567795wmf.8.1683900427563;
        Fri, 12 May 2023 07:07:07 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003f41bb52834sm19323160wmi.38.2023.05.12.07.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 07:07:06 -0700 (PDT)
Message-ID: <5d330bb9-0034-72eb-37bf-3c1bd33e0f2e@gmail.com>
Date:   Fri, 12 May 2023 16:07:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v11 04/11] remoteproc: mediatek: Add MT8195 SCP core 1
 operations
Content-Language: en-US, ca-ES, es-ES
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230510063749.5127-1-tinghan.shen@mediatek.com>
 <20230510063749.5127-5-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230510063749.5127-5-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2023 08:37, Tinghan Shen wrote:
> The SCP rproc driver has a set of chip dependent callbacks for
> boot sequence and IRQ handling. Implement these callbacks for MT8195
> SCP core 1.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/remoteproc/mtk_common.h |  9 ++++++
>   drivers/remoteproc/mtk_scp.c    | 56 +++++++++++++++++++++++++++++++++
>   2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index ea6fa1100a00..c0905aec3b4b 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -47,6 +47,7 @@
>   #define MT8192_SCP2SPM_IPC_CLR		0x4094
>   #define MT8192_GIPC_IN_SET		0x4098
>   #define MT8192_HOST_IPC_INT_BIT		BIT(0)
> +#define MT8195_CORE1_HOST_IPC_INT_BIT	BIT(4)
>   
>   #define MT8192_CORE0_SW_RSTN_CLR	0x10000
>   #define MT8192_CORE0_SW_RSTN_SET	0x10004
> @@ -56,6 +57,14 @@
>   
>   #define MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS		GENMASK(7, 4)
>   
> +#define MT8195_CPU1_SRAM_PD			0x1084
> +#define MT8195_SSHUB2APMCU_IPC_SET		0x4088
> +#define MT8195_SSHUB2APMCU_IPC_CLR		0x408C
> +#define MT8195_CORE1_SW_RSTN_CLR		0x20000
> +#define MT8195_CORE1_SW_RSTN_SET		0x20004
> +#define MT8195_CORE1_MEM_ATT_PREDEF		0x20008
> +#define MT8195_CORE1_WDT_CFG			0x20034
> +
>   #define SCP_FW_VER_LEN			32
>   #define SCP_SHARE_BUFFER_SIZE		288
>   
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index e1d93e63d7df..2bf66b1a8d80 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -176,6 +176,16 @@ static void mt8192_scp_reset_deassert(struct mtk_scp *scp)
>   	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_CLR);
>   }
>   
> +static void mt8195_scp_c1_reset_assert(struct mtk_scp *scp)
> +{
> +	writel(1, scp->reg_base + MT8195_CORE1_SW_RSTN_SET);
> +}
> +
> +static void mt8195_scp_c1_reset_deassert(struct mtk_scp *scp)
> +{
> +	writel(1, scp->reg_base + MT8195_CORE1_SW_RSTN_CLR);
> +}
> +
>   static void mt8183_scp_irq_handler(struct mtk_scp *scp)
>   {
>   	u32 scp_to_host;
> @@ -212,6 +222,18 @@ static void mt8192_scp_irq_handler(struct mtk_scp *scp)
>   	}
>   }
>   
> +static void mt8195_scp_c1_irq_handler(struct mtk_scp *scp)
> +{
> +	u32 scp_to_host;
> +
> +	scp_to_host = readl(scp->reg_base + MT8195_SSHUB2APMCU_IPC_SET);
> +
> +	if (scp_to_host & MT8192_SCP_IPC_INT_BIT)
> +		scp_ipi_handler(scp);
> +
> +	writel(scp_to_host, scp->reg_base + MT8195_SSHUB2APMCU_IPC_CLR);
> +}
> +
>   static irqreturn_t scp_irq_handler(int irq, void *priv)
>   {
>   	struct mtk_scp *scp = priv;
> @@ -453,6 +475,19 @@ static int mt8195_scp_before_load(struct mtk_scp *scp)
>   	return 0;
>   }
>   
> +static int mt8195_scp_c1_before_load(struct mtk_scp *scp)
> +{
> +	scp_sram_power_on(scp->reg_base + MT8195_CPU1_SRAM_PD, 0);
> +
> +	/* hold SCP in reset while loading FW. */
> +	scp->data->scp_reset_assert(scp);
> +
> +	/* enable MPU for all memory regions */
> +	writel(0xff, scp->reg_base + MT8195_CORE1_MEM_ATT_PREDEF);
> +
> +	return 0;
> +}
> +
>   static int scp_load(struct rproc *rproc, const struct firmware *fw)
>   {
>   	struct mtk_scp *scp = rproc->priv;
> @@ -625,6 +660,15 @@ static void mt8195_scp_stop(struct mtk_scp *scp)
>   	writel(0, scp->reg_base + MT8192_CORE0_WDT_CFG);
>   }
>   
> +static void mt8195_scp_c1_stop(struct mtk_scp *scp)
> +{
> +	/* Power off CPU SRAM */
> +	scp_sram_power_off(scp->reg_base + MT8195_CPU1_SRAM_PD, 0);
> +
> +	/* Disable SCP watchdog */
> +	writel(0, scp->reg_base + MT8195_CORE1_WDT_CFG);
> +}
> +
>   static int scp_stop(struct rproc *rproc)
>   {
>   	struct mtk_scp *scp = rproc->priv;
> @@ -991,6 +1035,18 @@ static const struct mtk_scp_of_data mt8195_of_data = {
>   	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
>   };
>   
> +static const struct mtk_scp_of_data mt8195_of_data_c1 = {
> +	.scp_clk_get = mt8195_scp_clk_get,
> +	.scp_before_load = mt8195_scp_c1_before_load,
> +	.scp_irq_handler = mt8195_scp_c1_irq_handler,
> +	.scp_reset_assert = mt8195_scp_c1_reset_assert,
> +	.scp_reset_deassert = mt8195_scp_c1_reset_deassert,
> +	.scp_stop = mt8195_scp_c1_stop,
> +	.scp_da_to_va = mt8192_scp_da_to_va,
> +	.host_to_scp_reg = MT8192_GIPC_IN_SET,
> +	.host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
> +};
> +
>   static const struct of_device_id mtk_scp_of_match[] = {
>   	{ .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
>   	{ .compatible = "mediatek,mt8186-scp", .data = &mt8186_of_data },
