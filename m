Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8076E7164
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjDSDCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDSDCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:02:32 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2082.outbound.protection.outlook.com [40.107.13.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF82E30E0;
        Tue, 18 Apr 2023 20:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXy8FpBAtJ5xwTanab0dBDSwom5MuHwn0jNZQtz5rFmiRLz6ZFcjkjD8dKZziT2JyO/iXX5Q/YLQiqBiMkjQQ8+t0yoNHMuucG0KYx5vCw26xR3TGh7GO2+4GaXp+Fbxvl6xqAuUPZYGDNK/lJxMbsCt33/sYBO/1oyCilXWn9KRVadPgBuQgvgUARi60uNFauITXs+zzejpjxG+bCQ7N34cgEvrDjNbGiV3pPUw9CUf7TvdhCVc0+5tNwD1dSEDDvTvCAYi05WCYOOEztmtuWvzwXusfEdCcn9LqHDjKPYjRE+lMmL50LKH+qmIPMwb7ke2utRlXHwZp47mS9lZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YBThMo9yYrMUojgtgi3ooDZoc2WeDKibDkJ7K9QYsU=;
 b=fARlR7fguU8GZA4of12m/cJ1ObILX/zSZeuoMWWpIiql86+NMD3QI1UzhvlCNLdqckB4WEordXRgfZffVUF/BsmdXC3Yem52ci/ZyCX5UlC+fOkbV/qogmtFHPE3nINIl7G7tv9rL9RzRvEZ+XktJdVeeiHaQQ/1Ybv6ekc09pD+rzlJzIwD9jCrpUH6/e2PB0wJg6bsvzAiQP4ojWdkiCzymrNGANF4RIddCE3/BWNnoXyd7qn7vLuXehBDBmn4lyK7SY7fyjbSt3Qoj/gbO0UhogK+gl6eoNVe94VrXv1atLR6NJ3IRiQ9AuZ6/+TH2dAq/0Uzve9BkH59BNPVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YBThMo9yYrMUojgtgi3ooDZoc2WeDKibDkJ7K9QYsU=;
 b=LIqbqU3r3hzF2845yBcDaswmdx4xoWyIOXidT7M4S0/xjgtkP5rd6r2CvrckuXPZcvtKAh/aYEAWlTNW2UnbID5R0uJpsuYAsVY26KB2h+o7AiNlp1P5MSbgrualYg32WrAqWY0ZooNS1aRa6sj492oop85zeRnQd92dkRt58YY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8628.eurprd04.prod.outlook.com (2603:10a6:20b:42b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 03:02:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 03:02:27 +0000
Message-ID: <8f5a63f8-0ac1-7674-25e7-705ace588e84@oss.nxp.com>
Date:   Wed, 19 Apr 2023 11:02:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
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
        NXP Linux Team <linux-imx@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Cc:     hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230418113451.151312-1-kaima@hust.edu.cn>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230418113451.151312-1-kaima@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8628:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a2bbe8-f149-4cba-b6d6-08db408281a9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6TF7fHnNxBn3dMUuhnFNpJYoT7jgNY2zo9PvKcLdu/LFUQKjvNSmf/IEw6ecrkqItPxwshL52aap7WctceVIuXoJOM4ODg93qJbYwNZkdfWK2wud30rswsP9MfmkmiZqTLfONZmb/3faAkfXpwNPRbTKPdjc33s7+l8rwwXSyUuRxCxsR+OgYhHaEMe6IIWm3FBWkQR38yPZGk8R7JnRnD5jh11Tn4joBqq76XJUapAQrXGB/xsVDtShJf28WCeGkY201Y57MNduKnU+gZcx1NFzdcewBqddbDU6h7H9/Zp1sMSZG2cDc8o2iixf0mUK33aS/HkGPUa0tRUtTGIWKjF8isbpq9q1/Rt5o8bhgDsXXg4ZS1eQeQR1uS1mS/k9K+H7my/OJk+wWUKi24uSJpBW0ej23Js8WxI8y+mqL1n/TTNuH/bULdveExNBg4W3XKCZYQGJIzN60JO4OIlfCcZoZcOJCrKUtc2B8RKrxsAk5B9WNHhpbhprw6AZ5weNqchwHMannP27mgJfr0SKA3e9f7xiyvGiQMJ7G8lxyxCFxJAo8cTn6yjbvBb7pusIFHvmr8iS9Zx0jr5CGG38Wh2X1OqR/81qRQiaMm7mmBLN2NE3qRtZW/MQvqwOoOfcOpU1cPq4lsM5UNe7WkzDd4mhhu2irJoQUssyXozbY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(44832011)(7416002)(2906002)(8936002)(5660300002)(8676002)(41300700001)(921005)(86362001)(31696002)(38100700002)(31686004)(478600001)(110136005)(2616005)(316002)(53546011)(26005)(6506007)(6512007)(186003)(6666004)(6486002)(4326008)(66476007)(66556008)(66946007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnVWVkd6MXBFM0c0MXpSbVB1QU9pZVJEVXJ0Z2FTL29NR2xFYm9lUnhudVJJ?=
 =?utf-8?B?WnJENnNqSVhscXF6U0ZSMXNyeU1oTzJaTEZBSm0xamxhUVZZL1dRQmo1RjJY?=
 =?utf-8?B?SFdYRmFEZm8vbzV6U1FnQy9EZ2JjYXF1R1RlNE5veG52L0FGbzRFdjdwQUo2?=
 =?utf-8?B?RC9iZVh0UHpYNkx5aEhodGVJeFRKSVZNM1ExMkh1VERDMGlBQzRBeGsvMXdG?=
 =?utf-8?B?Z0I2bVd6QktxaHc4OG9sTG9MTUZ4NFI1cmNJQjVhRWxPTGdPS3drbTAvRTJF?=
 =?utf-8?B?WHc5aEc2bnBhMGhTcTliTGgrd3pLemFYWFAxVFgwNXpkU0JOdWhjcnc0c3NC?=
 =?utf-8?B?R2FHUkYrNnZLU1pFSU5QS2JsTGhvWE4wSzUrNUZwMVIzL2tnVXVvM3FDc2ZK?=
 =?utf-8?B?V0NUOEdNektBN0RyNk11eHJRSHRISk1KeC82R09JL2xoakFyR1BiTDEwelg0?=
 =?utf-8?B?RFpoUDFRMDB4ZEdMSnB3SkhkUU1oT1dhZXFjYzhVNU1PbmphUTRPZnk2Mm1P?=
 =?utf-8?B?SjdYV0pWMyswZHJJRkFCQi92MnhhZlJHM2lXc1JOWWV3aUVJSkJnbEJzNzZl?=
 =?utf-8?B?SW9ldVU0UGpQUlc2ZytzYkxCTWRreWNYaVNUMWVYWGlSTXM2Z0xiU1Q4SDBF?=
 =?utf-8?B?MEpML2lTeGQydDFWY0xQTGZ1d3hpUEh4VXFCaDNuaDc3cnFpYTdLU2VJMUZC?=
 =?utf-8?B?MHd4TVFpODlNbSszSU01c2FoMVFPbnM2Vk1ZdXNvRGpIZ1kwTWdmL0RiUURH?=
 =?utf-8?B?VlZPZE80TFRJN0pvdk5XYmUxQ2h4TGZlTUZ2UWJsTEoxdHh0U0tzNlVZQTdu?=
 =?utf-8?B?eCtpMFlxMVhmSm1YNWtSTHhNc2Y0T00zKzlRaDd0WlZ0Z2hLa3lzY2NNS3Bi?=
 =?utf-8?B?WWRoQ0VOYnVSWGt2UHJ4bGE2M1Z4MzNqNmR2TWFnelViTDBOelRkQmNRQzFp?=
 =?utf-8?B?S2JDQkYyRFFGMWNMRnduemZ1WEFLQjBvNWkzeTlzYXFwOE1ubldwU09hZ08r?=
 =?utf-8?B?VTRBTDRYWjBLWUJURGplZmcydzYxTGFNY0xyYUkxREZHSkRXN0VOb3JJWHFi?=
 =?utf-8?B?MllWZVNvaFEzRE1acmpZZTJJdjFsQ0VNcEgvK3RwaVgxWFZPc2hnYUtHVnZL?=
 =?utf-8?B?em94L2o5cVFEdFdtSmhpOVVxL3phR3BVdUdQRGozdDdWUEwvZSs4MGlXcGJu?=
 =?utf-8?B?d0VCdzRHRWR2NUFFbmVkZjYvU04xRHlpTmJIbGRGNFozajlkRGNHQlRlUWJq?=
 =?utf-8?B?Q25Pc3B1YUs4VkxWcXNJQmJ6anJiaWxqN2RhL0ZTUGU2emdrMENudlVoUlBJ?=
 =?utf-8?B?TVV0MEFzK0VicE1KNmVjMUppUEhtMng5MHp1WGF2dzRQNG1SVWJrcC9lSXNI?=
 =?utf-8?B?NjUyUjk4d0liSWJQTmtnR1pxMjQvcVVXUVNDblNPQVdWam90VHBRelloTTJG?=
 =?utf-8?B?bzN0RHM0UjJacEJaTUtyUzVpWFNjdlFMQlVYb25kV0Z2emhHZnJLcUFqQmlL?=
 =?utf-8?B?ZFRpVzRxenhiU0xtSFZsYmtMaXNtdVF3aUUwOFcwL3ZseE52NjE0MGwya3BG?=
 =?utf-8?B?QmRxQWQ2eHpqK1hEUFR0YjljOWwxREhBYmVmS0kyaUdESkd4bDF1MmU4THRK?=
 =?utf-8?B?RFNzMngyLytZcis1b1pES0hrSUxzQi8wREs2N0UyN01MVjZmZzNkZEV1ZzRW?=
 =?utf-8?B?TFM3YmlyV1hqV1BRMFZpbmVHM3ZIQllxYzcvYlJkWUhLWDJRaXU5MU9PTzZ6?=
 =?utf-8?B?ZXNITU1sV0g4amZha25qT2tFZkk0T2JHOFdjZ0VXRjRGREljUmd0UEpWS1Ja?=
 =?utf-8?B?U3FwUzNiamxpMVVMWTBaVXpaVFQ4c2drMzhoWXkvdnVJN1pQdHRncFdqMmhp?=
 =?utf-8?B?L0EvVytIT04zMzA3QnRLd0Q3UHlvZS9BTEtyL1BzTE1HcGVWbHlWUW1tb1R0?=
 =?utf-8?B?bllXUGF5Ulg1UXN5TWpoYXFDNEQ5dmVXL3JpaVlJSWhvZkkzd2pWMzdJNXJV?=
 =?utf-8?B?U3dRUklwZzhYNWFIbVhSZ0MySU8vMnpMTXQyV3k2b3hUVUliUS9CTnR4OUZZ?=
 =?utf-8?B?OGtwek1naU5FRWJsc1I2bWU3dFRUdG1ld0l1aGNXZDY2cHNpbWdCandGcTZR?=
 =?utf-8?Q?HnHLzijp0qiSysC/D3Nx1n2//?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a2bbe8-f149-4cba-b6d6-08db408281a9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 03:02:27.2592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xueecpQr63c6YuQlbr+DQASPkkAi2PqUdTuv/xRu2VqBOTs2+76P4o+umXo0C0YhWtSqyCgg473r4gA92W+ecw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8628
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/2023 7:34 PM, Kai Ma wrote:
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

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
> The issue is found by static analysis and remains untested.
> ---
>   drivers/clk/imx/clk-imxrt1050.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
> index fd5c51fc92c0..08d155feb035 100644
> --- a/drivers/clk/imx/clk-imxrt1050.c
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -42,7 +42,7 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>   	struct device_node *anp;
>   	int ret;
>   
> -	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
> +	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
>   					  IMXRT1050_CLK_END), GFP_KERNEL);
>   	if (WARN_ON(!clk_hw_data))
>   		return -ENOMEM;
> @@ -53,10 +53,12 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>   	hws[IMXRT1050_CLK_OSC] = imx_get_clk_hw_by_name(np, "osc");
>   
>   	anp = of_find_compatible_node(NULL, NULL, "fsl,imxrt-anatop");
> -	pll_base = of_iomap(anp, 0);
> +	pll_base = devm_of_iomap(dev, anp, 0, NULL);
>   	of_node_put(anp);
> -	if (WARN_ON(!pll_base))
> -		return -ENOMEM;
> +	if (WARN_ON(IS_ERR(pll_base))) {
> +		ret = PTR_ERR(pll_base);
> +		goto unregister_hws;
> +	}
>   
>   	/* Anatop clocks */
>   	hws[IMXRT1050_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0UL);
> @@ -104,8 +106,10 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>   
>   	/* CCM clocks */
>   	ccm_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (WARN_ON(IS_ERR(ccm_base)))
> -		return PTR_ERR(ccm_base);
> +	if (WARN_ON(IS_ERR(ccm_base))) {
> +		ret = PTR_ERR(ccm_base);
> +		goto unregister_hws;
> +	}
>   
>   	hws[IMXRT1050_CLK_ARM_PODF] = imx_clk_hw_divider("arm_podf", "pll1_arm", ccm_base + 0x10, 0, 3);
>   	hws[IMXRT1050_CLK_PRE_PERIPH_SEL] = imx_clk_hw_mux("pre_periph_sel", ccm_base + 0x18, 18, 2,
> @@ -149,8 +153,12 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>   	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
>   	if (ret < 0) {
>   		dev_err(dev, "Failed to register clks for i.MXRT1050.\n");
> -		imx_unregister_hw_clocks(hws, IMXRT1050_CLK_END);
> +		goto unregister_hws;
>   	}
> +	return 0;
> +
> +unregister_hws:
> +	imx_unregister_hw_clocks(hws, IMXRT1050_CLK_END);
>   	return ret;
>   }
>   static const struct of_device_id imxrt1050_clk_of_match[] = {
