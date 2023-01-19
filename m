Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456BE673DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjASPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjASPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:50:38 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A5E893D1;
        Thu, 19 Jan 2023 07:50:04 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id g10so1893384wmo.1;
        Thu, 19 Jan 2023 07:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wVQPucPn/4N6eq7dGZ6TeO17YnTENvcpUYFEdBhnrI=;
        b=GzoWLUXDhcBm7VPBAEoLLYRp0qB+EENNjncD/NH+TYq+KLoxPQtSSBFn9C71UzjAbP
         GYP1N8R/btP0DFxy6clir06OFnlxDspd7Dn6NlnkqnWGCknbHvhwftnKzqxE/+0PtL9S
         Jp/9fIsz/ibzXrKAqmOw0XuVTwbV8QWLK6GMfYIrpxN5QsGzXbbnHt06bz95+Twg2vsR
         UECr1gkrnwRmxbvI/2xo1z8oWKVCw7z9tErSMhU4fYDE7N6CkYgNC6saM7nZzu51Y5E9
         6bSDTkvrm3VOXWM3AUHpU6AcVCMclr530fkuhJ7WZrfb7aygxTVUVy0/pntoW1kA29S1
         numA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wVQPucPn/4N6eq7dGZ6TeO17YnTENvcpUYFEdBhnrI=;
        b=I4AKKXbA6400NDAenV8mvHRmlSfItqFdQfy4W9lMQiXXvD+lC73OWeQT343akA0CNs
         bAbOypAUmlUv83b2ovlK3FavxMa1WMxFKXV1oTVgzwxyZ8CZUPwCiaKMBC9qJswrZt7b
         TNsfy++BFj8w0iamoxw8XPSYg+sAGgkdE54vZb4fG4k/y4Wr0vvhk/Yl9rfK3Vf9NHIc
         5Y3U4O9tc6HlDQ/1eocp6esl05iKMjnBuBIO6SRiSWcGc4hIE3brgTkzUStvJf7uukrV
         Qon0GGgb/1Ki3dMfXkqgOvUiBsxd9/fNiyK9j0qXbi4Zl1cFz+0io/h4U6O7jFc+1nwr
         Me0A==
X-Gm-Message-State: AFqh2krdIcffRJa+gi6Jizgt/oTela8G3qULmsH2aCdipblDJg78fza1
        pltoqB5CGVrqSqIBo8DsHF0=
X-Google-Smtp-Source: AMrXdXsvPxP5GAgFiwZRv2Fpgnrwc9rnvZyLzAJChkNt06zUWqu4L+MVDkX3aIGYEefydWUx4Puoiw==
X-Received: by 2002:a05:600c:a13:b0:3db:1de2:af31 with SMTP id z19-20020a05600c0a1300b003db1de2af31mr3088765wmp.37.1674143402986;
        Thu, 19 Jan 2023 07:50:02 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c4f9300b003d1d5a83b2esm5829981wmq.35.2023.01.19.07.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 07:50:02 -0800 (PST)
Message-ID: <1503b3b8-261d-a434-cfd7-2a5db4d0d2a1@gmail.com>
Date:   Thu, 19 Jan 2023 16:50:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 3/4] clk: mediatek: remove MT8195 vppsys/0/1
 simple_probe
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230118031509.29834-1-moudy.ho@mediatek.com>
 <20230118031509.29834-4-moudy.ho@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230118031509.29834-4-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2023 04:15, Moudy Ho wrote:
> MT8195 VPPSYS0/1 will be probed by the compatible name in
> the mtk-mmsys driver and then probe its own clock driver as
> a platform driver.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/clk/mediatek/clk-mt8195-vpp0.c | 58 +++++++++++++++++++-------
>   drivers/clk/mediatek/clk-mt8195-vpp1.c | 58 +++++++++++++++++++-------
>   2 files changed, 86 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
> index bf2939c3a023..6d5800f69f6c 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
> @@ -86,26 +86,54 @@ static const struct mtk_gate vpp0_clks[] = {
>   	GATE_VPP0_2(CLK_VPP0_WARP1_MDP_DL_ASYNC, "vpp0_warp1_mdp_dl_async", "top_wpe_vpp", 3),
>   };
>   
> -static const struct mtk_clk_desc vpp0_desc = {
> -	.clks = vpp0_clks,
> -	.num_clks = ARRAY_SIZE(vpp0_clks),
> -};
> +static int clk_mt8195_vpp0_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->parent->of_node;
> +	struct clk_onecell_data *clk_data;
> +	int r;
>   
> -static const struct of_device_id of_match_clk_mt8195_vpp0[] = {
> -	{
> -		.compatible = "mediatek,mt8195-vppsys0",
> -		.data = &vpp0_desc,
> -	}, {
> -		/* sentinel */
> -	}
> -};
> +	clk_data = mtk_alloc_clk_data(CLK_VPP0_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	r = mtk_clk_register_gates(node, vpp0_clks, ARRAY_SIZE(vpp0_clks), clk_data);
> +	if (r)
> +		goto free_vpp0_data;
> +
> +	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +	if (r)
> +		goto unregister_gates;
> +
> +	platform_set_drvdata(pdev, clk_data);
> +
> +	return r;
> +
> +unregister_gates:
> +	mtk_clk_unregister_gates(vpp0_clks, ARRAY_SIZE(vpp0_clks), clk_data);
> +free_vpp0_data:
> +	mtk_free_clk_data(clk_data);
> +	return r;
> +}
> +
> +static int clk_mt8195_vpp0_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->parent->of_node;
> +	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_gates(vpp0_clks, ARRAY_SIZE(vpp0_clks), clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
>   
>   static struct platform_driver clk_mt8195_vpp0_drv = {
> -	.probe = mtk_clk_simple_probe,
> -	.remove = mtk_clk_simple_remove,
> +	.probe = clk_mt8195_vpp0_probe,
> +	.remove = clk_mt8195_vpp0_remove,
>   	.driver = {
>   		.name = "clk-mt8195-vpp0",
> -		.of_match_table = of_match_clk_mt8195_vpp0,
>   	},
>   };
>   builtin_platform_driver(clk_mt8195_vpp0_drv);
> diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
> index ffd52c762890..3b88c69e96c9 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
> @@ -84,26 +84,54 @@ static const struct mtk_gate vpp1_clks[] = {
>   	GATE_VPP1_1(CLK_VPP1_VPP_SPLIT_26M, "vpp1_vpp_split_26m", "clk26m", 26),
>   };
>   
> -static const struct mtk_clk_desc vpp1_desc = {
> -	.clks = vpp1_clks,
> -	.num_clks = ARRAY_SIZE(vpp1_clks),
> -};
> +static int clk_mt8195_vpp1_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->parent->of_node;
> +	struct clk_onecell_data *clk_data;
> +	int r;
>   
> -static const struct of_device_id of_match_clk_mt8195_vpp1[] = {
> -	{
> -		.compatible = "mediatek,mt8195-vppsys1",
> -		.data = &vpp1_desc,
> -	}, {
> -		/* sentinel */
> -	}
> -};
> +	clk_data = mtk_alloc_clk_data(CLK_VPP1_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	r = mtk_clk_register_gates(node, vpp1_clks, ARRAY_SIZE(vpp1_clks), clk_data);
> +	if (r)
> +		goto free_vpp1_data;
> +
> +	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +	if (r)
> +		goto unregister_gates;
> +
> +	platform_set_drvdata(pdev, clk_data);
> +
> +	return r;
> +
> +unregister_gates:
> +	mtk_clk_unregister_gates(vpp1_clks, ARRAY_SIZE(vpp1_clks), clk_data);
> +free_vpp1_data:
> +	mtk_free_clk_data(clk_data);
> +	return r;
> +}
> +
> +static int clk_mt8195_vpp1_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->parent->of_node;
> +	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_gates(vpp1_clks, ARRAY_SIZE(vpp1_clks), clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
>   
>   static struct platform_driver clk_mt8195_vpp1_drv = {
> -	.probe = mtk_clk_simple_probe,
> -	.remove = mtk_clk_simple_remove,
> +	.probe = clk_mt8195_vpp1_probe,
> +	.remove = clk_mt8195_vpp1_remove,
>   	.driver = {
>   		.name = "clk-mt8195-vpp1",
> -		.of_match_table = of_match_clk_mt8195_vpp1,
>   	},
>   };
>   builtin_platform_driver(clk_mt8195_vpp1_drv);
