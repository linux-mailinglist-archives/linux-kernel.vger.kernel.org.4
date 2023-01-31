Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A625F68297B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjAaJu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjAaJuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:50:18 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040611A8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:50:17 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id y8so15506880vsq.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ay4JjzFOi8u8tMMqeo9ypRaHpCzMeD1s8ySg55sDfvA=;
        b=X7qkWyQt8Nmpyd8tODNC6MVvJAs6pPWPg4+UGaJtcp92pV5yFejhXVMlk9N6Ne0O/x
         sJDx+ymPit1ElxTDAPp2M2NaD+94yYbcjDeTJeHkBQndJoaPQzDoh/O0k5kga8a0/02c
         rvzmD7VHZTbrwQPOdYeJNYWMApcfFEkMQ96vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ay4JjzFOi8u8tMMqeo9ypRaHpCzMeD1s8ySg55sDfvA=;
        b=OjukmM6TjIJf8NpidawUXfPjI1t8iiZfhNPsOHmrlJkQhjgzwKCT8oIje+PlzVmD7b
         jkqcF+F/2NPbhYPXLxvYycvjvrlz4U60fa9hTfEahNXlcGjirgNfw1VcieyAjGqE5rGF
         sqDYEtwELEOVPICvQovF/wuOz0zCv3ysB4spcLisBPyjLQzhCYgGrya+mK/3ZQLMifhZ
         FfiVxYL6lQSIIuCgqBKhurHUOulueAGFhOE3cC1OvefPYLHD6xy8x16+dx1si0OLSM9R
         X7YebQ3sRtEVtn8G+B8tDTflNdLKUq3ehVRAQu1ZNR1dl6QgiZadD7kpgPk3OKVmYMtC
         jrug==
X-Gm-Message-State: AO0yUKX1bAUWXzgQyQ4X42q66zJGWGS7LfT74BjZObRcLewD4+rJGc+Z
        +PGoiT4JTMaRrffbk3I6io1ayEv03pow95Jsf0sB2A==
X-Google-Smtp-Source: AK7set+/qcQFjgwbi+Ocj+LtBVuICC7AYNVeLlyhaPp038xPLhOSZqARwYUNLiyEVrFfSwlzmO4Suik/9e/bTguM2EY=
X-Received: by 2002:a67:d294:0:b0:3ed:89c7:4bd2 with SMTP id
 z20-20020a67d294000000b003ed89c74bd2mr2766641vsi.26.1675158616078; Tue, 31
 Jan 2023 01:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20230118031509.29834-1-moudy.ho@mediatek.com> <20230118031509.29834-4-moudy.ho@mediatek.com>
In-Reply-To: <20230118031509.29834-4-moudy.ho@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 31 Jan 2023 17:50:05 +0800
Message-ID: <CAGXv+5Gid0xT=Ru0G3d-z+ED_wKWpGYSbhwiFXRv5jqJL0vC_A@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] clk: mediatek: remove MT8195 vppsys/0/1 simple_probe
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:16 AM Moudy Ho <moudy.ho@mediatek.com> wrote:
>
> MT8195 VPPSYS0/1 will be probed by the compatible name in
> the mtk-mmsys driver and then probe its own clock driver as
> a platform driver.
>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt8195-vpp0.c | 58 +++++++++++++++++++-------
>  drivers/clk/mediatek/clk-mt8195-vpp1.c | 58 +++++++++++++++++++-------
>  2 files changed, 86 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
> index bf2939c3a023..6d5800f69f6c 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
> @@ -86,26 +86,54 @@ static const struct mtk_gate vpp0_clks[] = {
>         GATE_VPP0_2(CLK_VPP0_WARP1_MDP_DL_ASYNC, "vpp0_warp1_mdp_dl_async", "top_wpe_vpp", 3),
>  };
>
> -static const struct mtk_clk_desc vpp0_desc = {
> -       .clks = vpp0_clks,
> -       .num_clks = ARRAY_SIZE(vpp0_clks),
> -};
> +static int clk_mt8195_vpp0_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *node = dev->parent->of_node;
> +       struct clk_onecell_data *clk_data;

mtk_alloc_clk_data() API changed a couple releases back. So:

          struct clk_hw_onecell_data

> +       int r;
>
> -static const struct of_device_id of_match_clk_mt8195_vpp0[] = {
> -       {
> -               .compatible = "mediatek,mt8195-vppsys0",
> -               .data = &vpp0_desc,
> -       }, {
> -               /* sentinel */
> -       }
> -};
> +       clk_data = mtk_alloc_clk_data(CLK_VPP0_NR_CLK);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       r = mtk_clk_register_gates(node, vpp0_clks, ARRAY_SIZE(vpp0_clks), clk_data);

API changed.

> +       if (r)
> +               goto free_vpp0_data;
> +
> +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);

              of_clk_add_provider(node, of_clk_hw_onecell_get, clk_data);

Same for the other driver.


ChenYu

> +       if (r)
> +               goto unregister_gates;
> +
> +       platform_set_drvdata(pdev, clk_data);
> +
> +       return r;
> +
> +unregister_gates:
> +       mtk_clk_unregister_gates(vpp0_clks, ARRAY_SIZE(vpp0_clks), clk_data);
> +free_vpp0_data:
> +       mtk_free_clk_data(clk_data);
> +       return r;
> +}
> +
> +static int clk_mt8195_vpp0_remove(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *node = dev->parent->of_node;
> +       struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +       of_clk_del_provider(node);
> +       mtk_clk_unregister_gates(vpp0_clks, ARRAY_SIZE(vpp0_clks), clk_data);
> +       mtk_free_clk_data(clk_data);
> +
> +       return 0;
> +}
>
>  static struct platform_driver clk_mt8195_vpp0_drv = {
> -       .probe = mtk_clk_simple_probe,
> -       .remove = mtk_clk_simple_remove,
> +       .probe = clk_mt8195_vpp0_probe,
> +       .remove = clk_mt8195_vpp0_remove,
>         .driver = {
>                 .name = "clk-mt8195-vpp0",
> -               .of_match_table = of_match_clk_mt8195_vpp0,
>         },
>  };
>  builtin_platform_driver(clk_mt8195_vpp0_drv);
> diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
> index ffd52c762890..3b88c69e96c9 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
> @@ -84,26 +84,54 @@ static const struct mtk_gate vpp1_clks[] = {
>         GATE_VPP1_1(CLK_VPP1_VPP_SPLIT_26M, "vpp1_vpp_split_26m", "clk26m", 26),
>  };
>
> -static const struct mtk_clk_desc vpp1_desc = {
> -       .clks = vpp1_clks,
> -       .num_clks = ARRAY_SIZE(vpp1_clks),
> -};
> +static int clk_mt8195_vpp1_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *node = dev->parent->of_node;
> +       struct clk_onecell_data *clk_data;
> +       int r;
>
> -static const struct of_device_id of_match_clk_mt8195_vpp1[] = {
> -       {
> -               .compatible = "mediatek,mt8195-vppsys1",
> -               .data = &vpp1_desc,
> -       }, {
> -               /* sentinel */
> -       }
> -};
> +       clk_data = mtk_alloc_clk_data(CLK_VPP1_NR_CLK);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       r = mtk_clk_register_gates(node, vpp1_clks, ARRAY_SIZE(vpp1_clks), clk_data);
> +       if (r)
> +               goto free_vpp1_data;
> +
> +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +       if (r)
> +               goto unregister_gates;
> +
> +       platform_set_drvdata(pdev, clk_data);
> +
> +       return r;
> +
> +unregister_gates:
> +       mtk_clk_unregister_gates(vpp1_clks, ARRAY_SIZE(vpp1_clks), clk_data);
> +free_vpp1_data:
> +       mtk_free_clk_data(clk_data);
> +       return r;
> +}
> +
> +static int clk_mt8195_vpp1_remove(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *node = dev->parent->of_node;
> +       struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +       of_clk_del_provider(node);
> +       mtk_clk_unregister_gates(vpp1_clks, ARRAY_SIZE(vpp1_clks), clk_data);
> +       mtk_free_clk_data(clk_data);
> +
> +       return 0;
> +}
>
>  static struct platform_driver clk_mt8195_vpp1_drv = {
> -       .probe = mtk_clk_simple_probe,
> -       .remove = mtk_clk_simple_remove,
> +       .probe = clk_mt8195_vpp1_probe,
> +       .remove = clk_mt8195_vpp1_remove,
>         .driver = {
>                 .name = "clk-mt8195-vpp1",
> -               .of_match_table = of_match_clk_mt8195_vpp1,
>         },
>  };
>  builtin_platform_driver(clk_mt8195_vpp1_drv);
> --
> 2.18.0
>
