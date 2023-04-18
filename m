Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D986E6568
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjDRNHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDRNHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:07:35 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB06A3581;
        Tue, 18 Apr 2023 06:07:32 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id m16so17135561qvx.9;
        Tue, 18 Apr 2023 06:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681823252; x=1684415252;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qj/ICS6hhIk4a1NquMOIeTqnnyYW5sgIMFbGIy85Z0I=;
        b=ckbJE+LT0xQyyCMznQ7MZhnCye8WSGm/zHa5db1cnhPcQtUv8reSCXxbvMMFpShGpN
         91qKzQANqfmg8LVWvmDkmZGl2r+yv56KoxHtXRp7vgKu9a9SHxoCakRtd0iUyvngsdlM
         d/6yVLTAt5Uw7wX8XrdoofK4g+DVtOOpycuVqsVb5ovRKGi5HRwT8qdEodIT5yErxHFj
         h0fqN0fbTNagZNmDjSWat8sYHJvb3JaXDQzxr85ff9VxNBlACA5SEjUea5E3BALiTWn+
         6eqLaKgtj4Trq/JG4Cd47T3zpVa0+4Hc1rZftHY9VYewXJDstKzE8UJDT2k66k5brE1n
         wKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681823252; x=1684415252;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qj/ICS6hhIk4a1NquMOIeTqnnyYW5sgIMFbGIy85Z0I=;
        b=V65kuVjSY52K8bQooPAk4hvhLCmqmtzYvfre3WopeLd50VZdKzu0YTZmZniZ6mUXLT
         W8O/N3tr6Ny21f+7Z8fz9O5dbX3YgDL5uU6MbCHPIVPrEbGfem9MrSB9DdF7Cg3k6K/e
         oKyImUxhJzUEJpxA3vEvPBC1MK9D4LRkdQ2V9J1Vq9+cU8K97kJ3U8SBTgR3ZlA6off0
         SdE2prRLBh4WzOtG/Sj1m9tm5gKVdjWzcXfWEOEWVpHrCDpbhl74muOWy3U1vNvJo9F1
         +2Pd30/JGeKg1ndZlwJARzXy80fi3B3b5OLRsNpcNBQoSsfj68bV0ZBB3Uw7aVPIS69o
         IXyA==
X-Gm-Message-State: AAQBX9cN7/JFZgTXLRplHSgj2ecGGIopsJx9mtSBQa3F6fdlehYauBbl
        pYj/kvQEy1Fz9SbgKUaMmEk=
X-Google-Smtp-Source: AKy350ZXkVje20+rK7o1OUXV3gohyAeLuzoo+/ikkNQEkWd1GoQ+MQ6E8NXwVhpxd8ywvFSlHl/CAA==
X-Received: by 2002:a05:6214:1301:b0:5ac:d562:4ea8 with SMTP id pn1-20020a056214130100b005acd5624ea8mr21972965qvb.9.1681823251900;
        Tue, 18 Apr 2023 06:07:31 -0700 (PDT)
Received: from [10.248.29.213] ([129.63.248.16])
        by smtp.gmail.com with ESMTPSA id q1-20020ad44341000000b005ef817d14casm1086641qvs.83.2023.04.18.06.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 06:07:22 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
Message-ID: <9a2ab7ec-07ee-255f-a143-9b6c8df7c1e2@gmail.com>
Date:   Tue, 18 Apr 2023 09:07:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] clk: imx: clk-imxrt1050: fix memory leak in
 imxrt1050_clocks_probe
To:     Kai Ma <kaima@hust.edu.cn>, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230418113451.151312-1-kaima@hust.edu.cn>
Content-Language: en-US
In-Reply-To: <20230418113451.151312-1-kaima@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/23 07:34, Kai Ma wrote:
> Use devm_of_iomap() instead of of_iomap() to automatically
> handle the unused ioremap region. If any error occurs, regions allocated by
> kzalloc() will leak, but using devm_kzalloc() instead will automatically
> free the memory using devm_kfree().
> 
> Also, fix error handling of hws by adding unregister_hws label, which
> unregisters remaining hws when iomap failed.
> 
> Fixes: 7154b046d8f3 ("clk: imx: Add initial support for i.MXRT1050 clock driver")
> Signed-off-by: Kai Ma <kaima@hust.edu.cn>
> ---
> The issue is found by static analysis and remains untested.
> ---
>  drivers/clk/imx/clk-imxrt1050.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
> index fd5c51fc92c0..08d155feb035 100644
> --- a/drivers/clk/imx/clk-imxrt1050.c
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -42,7 +42,7 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>  	struct device_node *anp;
>  	int ret;
>  
> -	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
> +	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
>  					  IMXRT1050_CLK_END), GFP_KERNEL);
>  	if (WARN_ON(!clk_hw_data))
>  		return -ENOMEM;
> @@ -53,10 +53,12 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>  	hws[IMXRT1050_CLK_OSC] = imx_get_clk_hw_by_name(np, "osc");
>  
>  	anp = of_find_compatible_node(NULL, NULL, "fsl,imxrt-anatop");
> -	pll_base = of_iomap(anp, 0);
> +	pll_base = devm_of_iomap(dev, anp, 0, NULL);
>  	of_node_put(anp);
> -	if (WARN_ON(!pll_base))
> -		return -ENOMEM;
> +	if (WARN_ON(IS_ERR(pll_base))) {
> +		ret = PTR_ERR(pll_base);
> +		goto unregister_hws;
> +	}
>  
>  	/* Anatop clocks */
>  	hws[IMXRT1050_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0UL);
> @@ -104,8 +106,10 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>  
>  	/* CCM clocks */
>  	ccm_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (WARN_ON(IS_ERR(ccm_base)))
> -		return PTR_ERR(ccm_base);
> +	if (WARN_ON(IS_ERR(ccm_base))) {
> +		ret = PTR_ERR(ccm_base);
> +		goto unregister_hws;
> +	}
>  
>  	hws[IMXRT1050_CLK_ARM_PODF] = imx_clk_hw_divider("arm_podf", "pll1_arm", ccm_base + 0x10, 0, 3);
>  	hws[IMXRT1050_CLK_PRE_PERIPH_SEL] = imx_clk_hw_mux("pre_periph_sel", ccm_base + 0x18, 18, 2,
> @@ -149,8 +153,12 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>  	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to register clks for i.MXRT1050.\n");
> -		imx_unregister_hw_clocks(hws, IMXRT1050_CLK_END);
> +		goto unregister_hws;
>  	}
> +	return 0;
> +
> +unregister_hws:
> +	imx_unregister_hw_clocks(hws, IMXRT1050_CLK_END);
>  	return ret;
>  }
>  static const struct of_device_id imxrt1050_clk_of_match[] = {
Looks good! The fix seems to be similar to how clk-imx8mn.c does this.

Acked-by: Jesse Taube <Mr.Bossman075@gmail.com>

A similar issue seems to also be in drivers/clk/imx/clk-imx8mm.c,clk-imx93.c,clk-imx8mp.c.
Sorry for recreating the issue :(.

Thanks,
Jesse Taube
