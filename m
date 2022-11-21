Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F141632B26
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKURhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKURhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:37:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F113CFBB1;
        Mon, 21 Nov 2022 09:37:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso10993187wmb.0;
        Mon, 21 Nov 2022 09:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIkBDnpyQ9y+KENz/sF2OAKsHCgd0+PXn4cIVvqeI/Y=;
        b=VCpAh7o0ylWUU++fJ4G9+saO7sZFZ0Ajy63SzjLnmf4vPNGe91vpnn1UMQHK9et8vB
         fSJncCdRPEvACeg0C9lIiXaSyzyoq7sdN4dtZ7NU+FVlWeFfwzj4uBD4FQDrtP3/BbAu
         pwipIG3M9+5+QUAAquwE6at8ajjQMcAomR1c7cp8h0279NGdj9fSjvz5Hzeii7ZuKSc6
         +Y8XbnAvJa3uDrXKtQDR1EcA8Ve2JS2jMdn1gm/4Pg6TfwYUKsgKmCbFruYk/KlMfg/h
         tBlSqoCzIdDfjHH7Ps2GBlQFE9ZePQ6kjQBHU5k/O/TrCrIgg9dh7Wr4XOjjoYYv3PL0
         XBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIkBDnpyQ9y+KENz/sF2OAKsHCgd0+PXn4cIVvqeI/Y=;
        b=mLtCto5ghU8+iaiEOul1zkexl3+mT6SdEztrnxLWV41QKG1gyfyvcQr35Nc+BCsvEw
         xDC2E8AEv+3HNvD+lacDoS7At+fPRpyavmEgS45xQzkKusFs9V843EYmt1/AP6FObWhb
         838pAxDdlKyIELS5yO/LR6wQnGN4S4g72QoRGgL88cOWcIYK6w87I+qSzrU9kfE64yHC
         Dhc6h/2g8kMSFvjYkNIeoMo8zOS46O+qx4caTESh8DiIbUwyOXL4/oiWHAWPWs+E59pg
         ICKrcwJLKe35eGJfW81eZbGsPmxotByvHwOsjW0rkNsTock40Z9mh8s555P5fObInuft
         T9bg==
X-Gm-Message-State: ANoB5pnkoyewCSI8BqP0I+Z/JjxTjSMmaUYmsjoShtQ3CToEIz2ejWji
        IXi6zoW/884uHzNIEL1VGV0=
X-Google-Smtp-Source: AA0mqf6cwsRs6JuwwWCtN0EdQGOktANhXKV6y1lFHVyruST9YnKJd5+WPjzw72vQ72wWVsSF2XEaGg==
X-Received: by 2002:a05:600c:4f10:b0:3b4:ff86:25af with SMTP id l16-20020a05600c4f1000b003b4ff8625afmr4544172wmq.68.1669052219455;
        Mon, 21 Nov 2022 09:36:59 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r13-20020a056000014d00b0024165454262sm11821208wrx.11.2022.11.21.09.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:36:58 -0800 (PST)
Message-ID: <2ae616be-bec8-3a5e-60a1-75b5397d0566@gmail.com>
Date:   Mon, 21 Nov 2022 18:36:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/3] phy: phy-mtk-hdmi: Add generic phy configure
 callback
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jitao shi <jitao.shi@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stuart.lee@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mac.shen@mediatek.com,
        linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20220919-v4-0-bdc21e1307e9@baylibre.com>
 <20220919-v4-2-bdc21e1307e9@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220919-v4-2-bdc21e1307e9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/11/2022 15:19, Guillaume Ranquet wrote:
> Some phys, such as mt8195, needs to have a configure callback defined.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/phy/mediatek/phy-mtk-hdmi.c | 12 ++++++++++++
>   drivers/phy/mediatek/phy-mtk-hdmi.h |  1 +
>   2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
> index b16d437d6721..32f713301768 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
> @@ -8,10 +8,12 @@
>   
>   static int mtk_hdmi_phy_power_on(struct phy *phy);
>   static int mtk_hdmi_phy_power_off(struct phy *phy);
> +static int mtk_hdmi_phy_configure(struct phy *phy, union phy_configure_opts *opts);
>   
>   static const struct phy_ops mtk_hdmi_phy_dev_ops = {
>   	.power_on = mtk_hdmi_phy_power_on,
>   	.power_off = mtk_hdmi_phy_power_off,
> +	.configure = mtk_hdmi_phy_configure,
>   	.owner = THIS_MODULE,
>   };
>   
> @@ -43,6 +45,16 @@ static int mtk_hdmi_phy_power_off(struct phy *phy)
>   	return 0;
>   }
>   
> +static int mtk_hdmi_phy_configure(struct phy *phy, union phy_configure_opts *opts)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = phy_get_drvdata(phy);
> +
> +	if (hdmi_phy->conf->hdmi_phy_configure)
> +		return hdmi_phy->conf->hdmi_phy_configure(phy, opts);
> +
> +	return 0;
> +}
> +
>   static const struct phy_ops *
>   mtk_hdmi_phy_dev_get_ops(const struct mtk_hdmi_phy *hdmi_phy)
>   {
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.h b/drivers/phy/mediatek/phy-mtk-hdmi.h
> index c7fa65cff989..f5aac9d352d8 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi.h
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi.h
> @@ -24,6 +24,7 @@ struct mtk_hdmi_phy_conf {
>   	const struct clk_ops *hdmi_phy_clk_ops;
>   	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
>   	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
> +	int (*hdmi_phy_configure)(struct phy *phy, union phy_configure_opts *opts);
>   };
>   
>   struct mtk_hdmi_phy {
> 
