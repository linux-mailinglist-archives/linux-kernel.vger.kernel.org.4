Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0237060F226
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiJ0IVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbiJ0IVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:21:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A596C12F;
        Thu, 27 Oct 2022 01:21:11 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4A0C266028C0;
        Thu, 27 Oct 2022 09:21:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666858870;
        bh=J7K7i04eVT2PIfwxr81wlM3HFvdF43HmhvXykO4DStA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WHFnE0yz/vwKClukYr820fflZVz9Ph9B1SoUAjrAVzya5Hk/7ISavMuQo4BYgaekl
         /HWmJnPAWg2qqfZZpyVhmyKi2yG909VaTOVQmwlJY0P9xRYEbvwNge027sRkKFZEyY
         ht3gjwrUDgKweeb+dZwrVvcjejMZVfD7FR/0QKzOM1VHu6oW95m3ecEDpM3wXSquqJ
         w/MZR2+4U1HpXvZpoO/GMC24tMJpqhvHH2R4XKJAwQW3FQpgUec3rJe5YYtsYojw71
         gwNrmiX8VRSvETbtDItfaTQeU84EX7AMPRE/acPSKCf4MNLNW87tJhD8lF6XXwxrCh
         UNcQOe/ccW5cw==
Message-ID: <1dbba01b-157d-c04b-8f06-4d9ec79b1d5c@collabora.com>
Date:   Thu, 27 Oct 2022 10:21:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 02/19] clk: mediatek: Add MT8188 apmixedsys clock
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
 <20221024094254.29218-3-Garmin.Chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024094254.29218-3-Garmin.Chang@mediatek.com>
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
> Add MT8188 apmixedsys clock controller which provides Plls
> generated from SoC 26m and ssusb clock gate control.
> 
> Signed-off-by: Garmin.Chang <Garmin.Chang@mediatek.com>
> Change-Id: I3b1b44155cc5bfe5ba6e860de857e7e9f48b66a7
> ---
>   drivers/clk/mediatek/Kconfig                 |  11 ++
>   drivers/clk/mediatek/Makefile                |   1 +
>   drivers/clk/mediatek/clk-mt8188-apmixedsys.c | 153 +++++++++++++++++++
>   3 files changed, 165 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-mt8188-apmixedsys.c
> 

..snip..

> diff --git a/drivers/clk/mediatek/clk-mt8188-apmixedsys.c b/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
> new file mode 100644
> index 000000000000..f09e11d0261e
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8188-apmixedsys.c

..snip..

> +
> +static int clk_mt8188_apmixed_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	int r;
> +
> +	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
> +	if (r)
> +		goto free_apmixed_data;
> +
> +	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);

Please use mtk_clk_register_gates_with_dev().

Regards,
Angelo
