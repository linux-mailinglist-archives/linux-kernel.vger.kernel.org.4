Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25E673FD23
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjF0Ns2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjF0Ns0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:48:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672812115
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:48:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313f1085ac2so2188575f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687873703; x=1690465703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHmv5a7vtRDJnKftyV1yMq3/FZi0Wc50lX3zPXh4vew=;
        b=q15gXvNdcoGPsuhtIPVUPwhhYZLPSk9DHjWzTS5RnX9WPVu1+YBdpgLoQvUwNTjMhG
         0JfLie5YqAn6HgZHGlzlGUNbjcCnE3qm1D/J8NL2M9Ir5yeOVYrrPAdCym3Q7385uoNt
         gKCqI+JX0DQO/4js6zQE/NG1dCNT+Ge7x5vjzK0+egGKHtuUYBP8d+gJwhoT5UGMruPR
         z170K/byG9Kk1MfSbGQ7Wn19i194qLgMZyXDgWfKHK2HwhdYsBVUDH3dLvnvcVrLS3Fn
         Z9gTn7E7l6/76HXLtAAClmx5RxHHu9gBOZ2YEAkrRje1KzEESDgAWMzsyQiwN7wGJ2SA
         LoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873703; x=1690465703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHmv5a7vtRDJnKftyV1yMq3/FZi0Wc50lX3zPXh4vew=;
        b=MPm8VyV37b+GVUtC17o9qguOpeKsWcGFid71oQJ3iuTO0jjFhF5uy6IjTbDMqRLHGx
         05CJWpXQjYQUf7UQsV2weWN6CzdZwUKSZe7+s8EorvCX1yYdx+SlbgmtZRCdTQNlpcA1
         0feXrvYKoSVr6s36sd5/t7jDtwgt+zxgcPUepsGMXDN2PZmWbR60pJM4tgD2NARbX6l7
         Oc1+TzAuFnZ3BbBkWozhDj3ljl6QO0muhfiq+I9dU8LMV3+JRpK1/R5WUn5/8mSYuzEr
         l3MW9qLdY8dqKrMJ7PAfOPvvfG0Nq8RtV4yrA1U4kk0s9h1VZcw7WOlHi+fkSwYYbT6h
         H8Wg==
X-Gm-Message-State: AC+VfDyR9qNTc0DAH6tiIRp3Ka95nlNT3P3JYbqA+jpwLfTTronQ4wHm
        o9J7lUZ1YYm8KdcXqTvYiIWqsg==
X-Google-Smtp-Source: ACHHUZ6BofGx5tSCY9fbVq7yGbhOMPzm0jzUcSltKHUnnN5DjgScXJMsT9mgREp2IjLRZMUVLpm/eA==
X-Received: by 2002:adf:f1c8:0:b0:30e:3f54:f8c9 with SMTP id z8-20020adff1c8000000b0030e3f54f8c9mr21895044wro.10.1687873702817;
        Tue, 27 Jun 2023 06:48:22 -0700 (PDT)
Received: from [10.1.3.59] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d50cd000000b0030647d1f34bsm10628660wrt.1.2023.06.27.06.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 06:48:22 -0700 (PDT)
Message-ID: <30fc2593-1d8e-286a-cc54-03ee250a37e7@baylibre.com>
Date:   Tue, 27 Jun 2023 15:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 13/14] drm/mediatek: Improve compatibility of display
 driver
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230627063946.14935-1-shawn.sung@mediatek.com>
 <20230627063946.14935-14-shawn.sung@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230627063946.14935-14-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/06/2023 08:39, Hsiao Chien Sung wrote:
> - Register functions to enable/disable clock and reuse them
>    to simplify the code
> - Check if the component is defined before using it since
>    some modules are MT8188 only (ex. PADDING)
> - Control components according to its type rather than ID
> - Use a for-loop to add/remove components in an arrays,
>    so we only has to maintain the array to make sure every
>    component will be initialized properly
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 154 +++++++-----------
>   drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       |  20 ++-
>   2 files changed, 79 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> index 38f389471f66..f73a558dcf93 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> @@ -51,7 +51,9 @@ enum mtk_ovl_adaptor_comp_id {
>   

...
snip
...

> +};
> +
>   static const struct ovl_adaptor_comp_match comp_matches[OVL_ADAPTOR_ID_MAX] = {
> -	[OVL_ADAPTOR_ETHDR0]	= { OVL_ADAPTOR_TYPE_ETHDR, 0 },
> -	[OVL_ADAPTOR_MDP_RDMA0]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 0 },
> -	[OVL_ADAPTOR_MDP_RDMA1]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 1 },
> -	[OVL_ADAPTOR_MDP_RDMA2]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 2 },
> -	[OVL_ADAPTOR_MDP_RDMA3]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 3 },
> -	[OVL_ADAPTOR_MDP_RDMA4]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 4 },
> -	[OVL_ADAPTOR_MDP_RDMA5]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 5 },
> -	[OVL_ADAPTOR_MDP_RDMA6]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 6 },
> -	[OVL_ADAPTOR_MDP_RDMA7]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 7 },
> -	[OVL_ADAPTOR_MERGE0]	= { OVL_ADAPTOR_TYPE_MERGE, 1 },
> -	[OVL_ADAPTOR_MERGE1]	= { OVL_ADAPTOR_TYPE_MERGE, 2 },
> -	[OVL_ADAPTOR_MERGE2]	= { OVL_ADAPTOR_TYPE_MERGE, 3 },
> -	[OVL_ADAPTOR_MERGE3]	= { OVL_ADAPTOR_TYPE_MERGE, 4 },
> +	[OVL_ADAPTOR_ETHDR0] = { OVL_ADAPTOR_TYPE_ETHDR, DDP_COMPONENT_ETHDR_MIXER, 0, &_ethdr },
> +	[OVL_ADAPTOR_MDP_RDMA0] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA0, 0, &_rdma },
> +	[OVL_ADAPTOR_MDP_RDMA1] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA1, 1, &_rdma },
> +	[OVL_ADAPTOR_MDP_RDMA2] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA2, 2, &_rdma },
> +	[OVL_ADAPTOR_MDP_RDMA3] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA3, 3, &_rdma },
> +	[OVL_ADAPTOR_MDP_RDMA4] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA4, 4, &_rdma },
> +	[OVL_ADAPTOR_MDP_RDMA5] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA5, 5, &_rdma },
> +	[OVL_ADAPTOR_MDP_RDMA6] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA6, 6, &_rdma },
> +	[OVL_ADAPTOR_MDP_RDMA7] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA7, 7, &_rdma },
> +	[OVL_ADAPTOR_MERGE0] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE1, 1, &_merge },
> +	[OVL_ADAPTOR_MERGE1] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE2, 2, &_merge },
> +	[OVL_ADAPTOR_MERGE2] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE3, 3, &_merge },
> +	[OVL_ADAPTOR_MERGE3] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE4, 4, &_merge },


The lines is > 80 columns.

https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings

>   };
>   
>   void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
> @@ -185,73 +202,34 @@ void mtk_ovl_adaptor_stop(struct device *dev)
>   
>   int mtk_ovl_adaptor_clk_enable(struct device *dev)
>   {
> -	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
> -	struct device *comp;
> -	int ret;


-- 
Regards,
Alexandre
