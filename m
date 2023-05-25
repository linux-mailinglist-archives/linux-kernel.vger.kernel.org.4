Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8C571077E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbjEYIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbjEYIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:32:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066B9E41;
        Thu, 25 May 2023 01:32:28 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C8926605835;
        Thu, 25 May 2023 09:32:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685003546;
        bh=k7/vQeCVs8X0P7remFwr5otkr++Shtwkoci6K9NhYW0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Isbhhwk9giCSw2ViZig4ubY/S59uih32qTe7tcxSI32LTgG8MusjOiNbORkGO9YAI
         aXBagtZfF/zARYJhYLYetZ/vAp2MZjw+P2n426xJsqtu/QcdHLnBmeqIzNyvOZN6MK
         3vvYn6zZ07LAD7j6LrLWW6FEg0bdIz7Bjq8sUjssKCTcQx4ndMMP2gV4EEztjw/vuj
         mnNRPtIy3iVC1sT9B6Ml2THj4V+ER/M3aBbtrxBKJAodHSS7LSV0X2QeVZgQxmJEhm
         ArHMJm6WC91cEi47wWZh5liegHexp0CfDC+nbi3znHaFsMonEnNwOeALzOm0rE57w7
         w1l6H2d7di1nw==
Message-ID: <2b20c9d7-e9b4-c70e-b59c-c504a2a74c52@collabora.com>
Date:   Thu, 25 May 2023 10:32:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/2] clk: mediatek: reset: add infra_ao reset support
 for MT8188
Content-Language: en-US
To:     Runyang Chen <runyang.chen@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20230525075011.7032-1-runyang.chen@mediatek.com>
 <20230525075011.7032-3-runyang.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230525075011.7032-3-runyang.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/05/23 09:50, Runyang Chen ha scritto:
> The infra_ao reset is needed for MT8188.
> - Add mtk_clk_rst_desc for MT8188.
> - Add register reset controller function for MT8188 infra_ao.
> - Add infra_ao_idx_map for MT8188.
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202305242320.AZzmINEa-lkp@intel.com/
> ---
>   drivers/clk/mediatek/clk-mt8188-infra_ao.c | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8188-infra_ao.c b/drivers/clk/mediatek/clk-mt8188-infra_ao.c
> index a38ddc7b6a88..f590178737cb 100644
> --- a/drivers/clk/mediatek/clk-mt8188-infra_ao.c
> +++ b/drivers/clk/mediatek/clk-mt8188-infra_ao.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <dt-bindings/clock/mediatek,mt8188-clk.h>
> +#include <dt-bindings/reset/mt8188-resets.h>
>   #include <linux/clk-provider.h>
>   #include <linux/platform_device.h>
>   
> @@ -176,9 +177,32 @@ static const struct mtk_gate infra_ao_clks[] = {
>   		       "infra_ao_aes_msdcfde_0p", "top_aes_msdcfde", 18),
>   };
>   
> +static u16 infra_ao_rst_ofs[] = {
> +	INFRA_RST0_SET_OFFSET,
> +	INFRA_RST1_SET_OFFSET,
> +	INFRA_RST2_SET_OFFSET,
> +	INFRA_RST3_SET_OFFSET,
> +	INFRA_RST4_SET_OFFSET,
> +};
> +
> +static u16 infra_ao_idx_map[] = {
> +	[MT8188_INFRA_RST1_THERMAL_MCU_RST] = 1 * RST_NR_PER_BANK + 2,
> +	[MT8188_INFRA_RST1_THERMAL_CTRL_RST] = 1 * RST_NR_PER_BANK + 4,
> +	[MT8188_INFRA_RST3_PTP_CTRL_RST] = 3 * RST_NR_PER_BANK + 5,
> +};
> +
> +static const struct mtk_clk_rst_desc infra_ao_rst_desc = {
> +	.version = MTK_RST_SET_CLR,
> +	.rst_bank_ofs = infra_ao_rst_ofs,
> +	.rst_bank_nr = ARRAY_SIZE(infra_ao_rst_ofs),
> +	.rst_idx_map = infra_ao_idx_map,
> +	.rst_idx_map_nr = ARRAY_SIZE(infra_ao_idx_map),
> +};
> +
>   static const struct mtk_clk_desc infra_ao_desc = {
>   	.clks = infra_ao_clks,
>   	.num_clks = ARRAY_SIZE(infra_ao_clks),
> +	.rst_desc = &infra_ao_rst_desc,
>   };
>   
>   static const struct of_device_id of_match_clk_mt8188_infra_ao[] = {

