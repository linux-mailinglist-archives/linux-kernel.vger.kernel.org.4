Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4EA72FC59
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243666AbjFNL1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243617AbjFNL1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:27:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872C41FF7;
        Wed, 14 Jun 2023 04:27:28 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 943076606F20;
        Wed, 14 Jun 2023 12:27:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686742047;
        bh=r2JV/iN8hgR8w3RF8LE24TB8mgVbtvdjIPIQ7WunkM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XmsYrfyqnIpUoqKWF4zJZgk+A2z5K/cq0qOnsnic/Lj6khoqMFrNB1oKlFaRtwA+p
         hJznMJnTgjVFI8sjiLhVkgWBP5ik04y1nFbbW5bc0uKpUO2L5BpElQ9PlkXDkjiNHV
         hSy9/WZy51NUwg6kb/nK6RGDxy645lEl7HmxHANYbEujYpP0KMeP/S6kADYb6k14jd
         62WiO1DFjA7uFhsmPeF97cNyU2bCCI7swzxhoT64pvd45LjVFpyjny2AZTWMPmM72/
         c0n9Erw9YCeGd4Iqq01RJA0tlaU4DkvYrdIWN3ZQcA5s67umucH2jHN5BnB2D64hv9
         oYX9HGJq/5JQA==
Message-ID: <4a831086-9c0f-aa7a-3961-63df41752d7c@collabora.com>
Date:   Wed, 14 Jun 2023 13:27:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 06/15] dt-bindings: reset: mt8188: Add VDOSYS0 reset
 control bits
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
 <20230614073125.17958-7-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230614073125.17958-7-shawn.sung@mediatek.com>
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
> Add MT8188 VDOSYS0 reset control bits.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Now they're sequential and starting from 0. Totally valid.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   include/dt-bindings/reset/mt8188-resets.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt8188-resets.h b/include/dt-bindings/reset/mt8188-resets.h
> index 377cdfda82a9..1d92759dc67d 100644
> --- a/include/dt-bindings/reset/mt8188-resets.h
> +++ b/include/dt-bindings/reset/mt8188-resets.h
> @@ -33,4 +33,24 @@
> 
>   #define MT8188_TOPRGU_SW_RST_NUM               24
> 
> +#define MT8188_VDO0_RST_DISP_OVL0		0
> +#define MT8188_VDO0_RST_FAKE_ENG0		1
> +#define MT8188_VDO0_RST_DISP_CCORR0		2
> +#define MT8188_VDO0_RST_DISP_MUTEX0		3
> +#define MT8188_VDO0_RST_DISP_GAMMA0		4
> +#define MT8188_VDO0_RST_DISP_DITHER0		5
> +#define MT8188_VDO0_RST_DISP_WDMA0		6
> +#define MT8188_VDO0_RST_DISP_RDMA0		7
> +#define MT8188_VDO0_RST_DSI0			8
> +#define MT8188_VDO0_RST_DSI1			9
> +#define MT8188_VDO0_RST_DSC_WRAP0		10
> +#define MT8188_VDO0_RST_VPP_MERGE0		11
> +#define MT8188_VDO0_RST_DP_INTF0		12
> +#define MT8188_VDO0_RST_DISP_AAL0		13
> +#define MT8188_VDO0_RST_INLINEROT0		14
> +#define MT8188_VDO0_RST_APB_BUS			15
> +#define MT8188_VDO0_RST_DISP_COLOR0		16
> +#define MT8188_VDO0_RST_MDP_WROT0		17
> +#define MT8188_VDO0_RST_DISP_RSZ0		18
> +
>   #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8188 */
> --
> 2.18.0
> 


