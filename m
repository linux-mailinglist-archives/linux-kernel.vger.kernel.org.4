Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E7C60F23D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiJ0IWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiJ0IWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:22:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB14113C3D0;
        Thu, 27 Oct 2022 01:22:27 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F16CE66028BE;
        Thu, 27 Oct 2022 09:22:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666858946;
        bh=JtEUOLR2EgDz232JYBT0aoeVDFCeQIPLjyQdNecDcaQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V1npCHGRLgGjVicy2SdACvdAX5ZHEezSbWPJ8t0wK0SMv0QX1Lku39eJExLZso573
         KLrkmy+ohl87wTvJ1GN9Jh9wE89C3k5XEanW27kP6A8H2UjS0d9k3hLBrh8gVHCWNH
         jWEqbWt65KNhZajPnUa0pyB9IHa/0uaH66OMwyuHaym4+CpoI9QKy2/vS7XRYGi/k9
         LlffUpGuBBsREhPmz7NViiOqAHvXqkGBQ4cs0YWTD1679z4UvkmQILBIaemUDVztKX
         VeXRHz9RlWqrOe1BRwc+h5vx7XoGA8rEtSjIQ6KRg/sV7cz+HMlR55lE8gQgCQIq81
         V4d32mWnLJ1Lg==
Message-ID: <8c0da3f2-0e77-e960-dab4-0a1d02e0d21e@collabora.com>
Date:   Thu, 27 Oct 2022 10:22:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 04/19] clk: mediatek: Add MT8188 peripheral clock
 support
Content-Language: en-US
To:     "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221024094254.29218-1-Garmin.Chang@mediatek.com>
 <20221024094254.29218-5-Garmin.Chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024094254.29218-5-Garmin.Chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/10/22 11:42, Garmin.Chang ha scritto:
> Add MT8188 peripheral clock controller which provides clock
> gate control for ethernet/flashif/pcie/ssusb.
> 
> Signed-off-by: Garmin.Chang <Garmin.Chang@mediatek.com>

..snip..

> +
> +static const struct of_device_id of_match_clk_mt8188_peri_ao[] = {
> +	{
> +		.compatible = "mediatek,mt8188-pericfg_ao",
> +		.data = &peri_ao_desc,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +

Here and for all of the other drivers that you're introducing with this series...

please compress this array to one line per entry, like so:

static const struct of_device_id of_match_clk_mt8188_peri_ao[] = {
	{ .compatible = "mediatek,mt8188-pericfg_ao", .data = &peri_ao_desc },
	{ /* sentinel */ }
};

Regards,
Angelo

