Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5709E72FC81
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244028AbjFNLfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244021AbjFNLfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:35:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D0910D5;
        Wed, 14 Jun 2023 04:35:27 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BF1A06606F13;
        Wed, 14 Jun 2023 12:35:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686742526;
        bh=q2K1vIsngfpFoBXIzj71OjECfV67+TJ2UobDpqFbXGE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GldcbasR/fV8RMce3DJNEifzAY+VKBigfY/CytnwlgbGbiFZhflXLV4S290FQz0W8
         oQaNKK6vj9xFqucXBx99x0Dr3VfGA+yoPWCo2vRnCuhQg+ZcBK/LUAyF1erhVsvZ1O
         4idRs/mZgGhXbxSnq7LEBfU4zV6ExnORRHaOsTuVvm0ImYBfnJfz04hmDdEmjTgr/s
         WRaWPwn9oNLoIRt6zF0C8rr9CB6wfLI7RdYGP8fQ9+s+JwyOi5bhewxwyVwtBPFyCC
         rJ/+YxS9ykWT3ylbAniA9LecIzLJHERM3veqvRPZ0ynWWFoCum9S6yDCu5sh+ZAlvV
         bZjE7Fdt60vVQ==
Message-ID: <e4f98dc5-0fa6-14aa-f8d0-e4bf30ecca5c@collabora.com>
Date:   Wed, 14 Jun 2023 13:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 12/15] soc: mediatek: Add MT8188 VDO1 reset bit map
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
 <20230614073125.17958-13-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230614073125.17958-13-shawn.sung@mediatek.com>
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

Il 14/06/23 09:31, Hsiao Chien Sung ha scritto:
> Add MT8188 VDO1 reset bit map.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   drivers/soc/mediatek/mt8188-mmsys.h | 57 +++++++++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-mmsys.c    |  3 +-
>   2 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mt8188-mmsys.h b/drivers/soc/mediatek/mt8188-mmsys.h
> index c3e3c5cfe931..208d4dfedc1a 100644
> --- a/drivers/soc/mediatek/mt8188-mmsys.h
> +++ b/drivers/soc/mediatek/mt8188-mmsys.h
> @@ -144,6 +144,63 @@ static const u8 mmsys_mt8188_vdo0_rst_tb[] = {
>   	[MT8188_VDO0_RST_DISP_RSZ0]	= 31,
>   };
> 
> +static const u8 mmsys_mt8188_vdo1_rst_tb[] = {
> +	[MT8188_VDO1_RST_SMI_LARB2]			= 0,
> +	[MT8188_VDO1_RST_SMI_LARB3]			= 1,
> +	[MT8188_VDO1_RST_GALS]				= 2,
> +	[MT8188_VDO1_RST_FAKE_ENG0]			= 3,
> +	[MT8188_VDO1_RST_FAKE_ENG1]			= 4,
> +	[MT8188_VDO1_RST_MDP_RDMA0]			= 5,
> +	[MT8188_VDO1_RST_MDP_RDMA1]			= 6,
> +	[MT8188_VDO1_RST_MDP_RDMA2]			= 7,
> +	[MT8188_VDO1_RST_MDP_RDMA3]			= 8,
> +	[MT8188_VDO1_RST_VPP_MERGE0]			= 9,
> +	[MT8188_VDO1_RST_VPP_MERGE1]			= 10,
> +	[MT8188_VDO1_RST_VPP_MERGE2]			= 11,
> +	[MT8188_VDO1_RST_VPP_MERGE3]			= 32 + 0,

Works, but there's a better way.

32 + 0 means that you're using reset SW1 register, so you can do

#define MT8188_MMSYS_RST_NR_PER_BANK	32
#define MT8188_RST_SW1_OFFSET		MT8188_MMSYS_RST_NR_PER_BANK
#define MT8188_RST_SW2_OFFSET		MT8188_MMSYS_RST_NR_PER_BANK * 2

[MT8188_VDO1_RST_VPP_MERGE3] = MT8188_RST_SW1_OFFSET + 0
[MT8188_VDO1_RST_VPP_MERGE4] = MT8188_RST_SW1_OFFSET + 0
.......
[MT8188_VDO1_RST_HDR_VDO_FE0] = MT8188_RST_SW2_OFFSET + 0
...etc

Reading this will make it clear that a certain reset bit is in a different
(sequential or not) register.

P.S.: If the RST_NR_PER_BANK is *not* MT8188 specific (as in, all reset registers
for all SoCs are always 32 bits, which I believe is true), you could move that
definition to mtk-mmsys.h as
       #define MMSYS_RST_NR_PER_BANK	32
and then define the offsets in mt8188-mmsys.h as
       #define MT8188_RST_SW1_OFFSET MMSYS_RST_NR_PER_BANK
       .... etc

Thanks,
Angelo


