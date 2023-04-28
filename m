Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069266F12ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345828AbjD1H4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345817AbjD1H4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:56:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2048.outbound.protection.outlook.com [40.107.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351D52689;
        Fri, 28 Apr 2023 00:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zw63doySFtOQdUI0x3XdvU2aK+aMRqVZRG5gEVlGWlfyX9tmiUeYNG6LssckuwMh5pmBXgjZrumy4oh0BHKtGctQ93rA8eswriPIYhTsuxx0/tPDREpPcvKwdxiQJgldmAXx2dTvK1t2+9Kd7bTkqo9zUskthv5sDIXIQhO21Z6yRX+A77TgMes0zfzsO1X8Vm7qIvx1SGJXMRXtN+dGAyJs8G77/aXGh8VDb6O/NZPvapfOndx3Ha4GG5m6XHWsZL/e4XP3PL6bVG129nxh/NZo0ny4Lj+/LUi+Zfdo0ouBKxsBG38GC/nZJabEPpH8xB9wMfYofTUspLKGa0nDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKZ4XkyPeSQEq+jctXRx8+EK8S0DeDJAkY0KzQluAWM=;
 b=XhZ2z3TGrxzJ5dL01oPiiPU2hdCYLDSaUOXs7YJHU0mpoNrcw0s8KN3wl1nHrx4r/KLxvR5ahkFuXZbeY0hirIoj2KWeo5NEuJGEJ8y+nu9T75WUlLqhjJ3PYj2evUnGjh27bwkxhIXlUO/5e1Chg68GZwoHpuyjmgqFFav2YB4HLKk8uaa+MFFUiv8feLZRUU3HvtwJdjihQ3cFE6SFqkllrRSOXaTn1YjVV3rxzDs3f6QCiqLtD7ulOGrUWhIhC7zI2OxNBigXygciT+zPpHL9YLY5wgEFSbMwH6qb6QQnR1XHrtqVSP/RxdAKlXOyYiQSfl3GnbyHVnr68Gv8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKZ4XkyPeSQEq+jctXRx8+EK8S0DeDJAkY0KzQluAWM=;
 b=FuRVuQ8doS4nyp/JdaRLYdQD7Wmo/VoPOMzD/2baIj9Wv7/DPQDpQ26ldf89e89XDE97Jhj1pGrAqjuDrNswsnCi/bdwKAxFwU2mvfk6CSpqKjdSqL3c0qK/NGHxYk+BOXCVuZRAXUiswAJYpR7cnIQ9+XFYalCfliI25anlu3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8876.eurprd04.prod.outlook.com (2603:10a6:20b:40b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 07:55:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 07:55:43 +0000
Message-ID: <ff56e0f0-bdf8-6914-443a-d463fe863bb7@oss.nxp.com>
Date:   Fri, 28 Apr 2023 15:55:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] clk: imx: clk-imx8mp: add error handling of
 of_clk_add_hw_provider
To:     Yuxing Liu <lyx2022@hust.edu.cn>, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230424092411.124706-1-lyx2022@hust.edu.cn>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230424092411.124706-1-lyx2022@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6072aa-50ed-4c54-ce66-08db47bdf7ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xGYDzuznICsqGrhRJ6DLCuGPziiD0kVFhI/V0CUA6nE2DCcEbT4m23QrhJXnHsdkoX8c162+ERcAmxnR/5sZsgDkwQraLM08B/MhQdkjo00xp++bkyXYWA5I9nHQ6lbpHn5RBeDKsYIUO2jzbYO3sg0voq/atHn5am2gCeCINe0X0rVFMp1PUjRxYRDKCQWHnQiz6Kw8ahkaMhK+l3YDGVFQyiHovg5Z4jE2mdU7ClCb3KBoIxsEY2vE0E7kyCBXKMF19aKqNxItMMtO2wlvyeEEwu0xUYi3K0p2J/obEFmVuDLloL4UBRoP+3f+x9ZPMtcsHzrhYCfHLhGFVhFIMBdwOZ0h1OpqXM6iaRhxkrf3OFoQoo0gYSfmZgZhOIrEu1P/7i4UwyUfPKrYwOr8ReOltBEPooSFW32pNKNmZfs2RViQIKfpjW2EZqqSxy4pM0OIIjxeuKqb6UqqxYCHgGN8G6FduTLFyFP5gaD6/hOW2dv54yt/VGEhWA2T44c6A26wwuSVWoS2qs73KGPfpbSv0uiUmt4ZPmcbMRfwMJ6X1jxtaGRdZKjHaIKGtgjOV8SlD1ZMmzogXOTn8zeGkFh6618Gz03oXuEmAjfq7mdEpm2KR0Z9+FgrPzykF4zeutbzynqTJ4FL3ixRSkWNGwnu9iIidRXXonGkGA8Oy+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(2616005)(186003)(5660300002)(31696002)(8676002)(8936002)(7416002)(83380400001)(86362001)(44832011)(31686004)(41300700001)(6666004)(53546011)(6486002)(316002)(478600001)(6512007)(6506007)(26005)(66946007)(66476007)(66556008)(38100700002)(2906002)(4326008)(110136005)(921005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVl3ZHM1anRWd2pNWFFFRmRkU2pJVTFIQzF5cyt4Sy9Gck1ZdDVEUGlqRm9r?=
 =?utf-8?B?b2RFQjZtV0JqVUxvdUYxMGkyMHUvdUNtbUk3VFBOV2piNTVUTnNhS1g1T0t0?=
 =?utf-8?B?RURPbjhoQjVsMkhpS0VsT0R4RnV1a1BwbVBMMERyQUphREtjcEtBRVBXSllT?=
 =?utf-8?B?ZjR5OWlKa3FyUVd2aXBwOTJxaXgvK1hDUnVTUDhROXh3UTVjODNLSWdnMk5z?=
 =?utf-8?B?Yjg5TTJrdy9odnVLSUFad2lvTVh6R2FLem9HaFN6MUtSTjRGaG9lTk15a28y?=
 =?utf-8?B?ckh2TWVxZGx2a3JyaWV2QkdpU0dMVnJlTExIVjl0YkJJSlZXMFNLMWFTcCsx?=
 =?utf-8?B?cTdkejlhZnAvcEZvQUYrWnc2Uk4wcVFIZ2lPWWxNcnk0UDM5N0VBYXlIK1Fs?=
 =?utf-8?B?M0xpcjhOM2g4dHd4SEY4N3JsQ2lrZmdlSFdWNmFYQWVRbU9ST3hyVSt3Y1l6?=
 =?utf-8?B?ZHB0aTJ5QWs3dnloK09IVDZRVUJ5WnpLdzRocGx4eXhWcE55ZjFOWHFCcm5L?=
 =?utf-8?B?ajh3MVhNNWNONUNoaG5YNUM0cXFPektPcmg3WFRIWGdJOFY3WkszZy9kY1V1?=
 =?utf-8?B?akl1NEVWTXNHaXdqRGpIRFVGVHhNYTdQNlM1NjViVHM1c2FxTCtnVkpwS3FX?=
 =?utf-8?B?WHl4TndRL3RnTlRad2IxRUxIM0VRMDFpZlFVUEF0TDZ4a1NVUFFWZEp4QUVB?=
 =?utf-8?B?ZnVoN1JUcHcyc3hHZGMxbVFuUldpR1ZFL0QrVUxZNXpVUTFoRFl3d1FzNXRv?=
 =?utf-8?B?NVVZTkJjdGo5blZUbnVaTWpldzh5d1pEQTgxMVIvK3hwRFQ3ak5Yd1IwQ2FI?=
 =?utf-8?B?K01mQTVEYTRHOE5ndlNmOFN3Qk40OHRBR3B3MkpCSTFLUU1Jdm5Td2tZTEhC?=
 =?utf-8?B?ekV0cDdQVkIrdURXajNGRkFGNGVwWUFEaHlGYWNwWnVnV1UzTXR4TUZ3VDUx?=
 =?utf-8?B?UzFjR2JHWUxhUGN0U1pMQ05tc2h3RWpBckVoVXNSd1I4RUtYeEhVOWxGUk9L?=
 =?utf-8?B?Q212NHBQejJkbFd6eG5vWXlKWTlmd2ZjTWdwajRYdzZrdDV3aDc3QVN5U2tC?=
 =?utf-8?B?a2F3Y3JveU9VZXlFVnZHYzZkaExoc05FQWdIenZTZ1M2TlJhRThjSUlBeXR5?=
 =?utf-8?B?UE0rMkRyaVJLQU5RU2NYVElpRjM0dHdiRjVySHV3cTNVc0gxaDJmMCtpeGFI?=
 =?utf-8?B?R0IzMEVKS3UzY3FEMUc2RXpmbjdFQ2E1M1Q0OFY2L3U1YWFCbCs1c0lxaW1m?=
 =?utf-8?B?WGd2a01HOTBnRUNTTU1FVTArdkNIV2ZYMVpuR1R1Mzh3SEpmdytiUGY1YlR6?=
 =?utf-8?B?WkZpbUU1R05MUnZ2UUV6RjQ1a3psUnhRVnA5dlUrNzZ5U29wWVN6cFlxYzQr?=
 =?utf-8?B?a3VzcVhGcmVKWWhRLzFsMjhYVVhQRDM2NUJRK1pPMzRQNm1oUFc3czVtblVF?=
 =?utf-8?B?ZysrcUw0WldYY1N6eHRXNkxvbXpkZkZWa25HeEhZQWRlSVhvT2xzdWZuNDMz?=
 =?utf-8?B?YTNaNXlSSHlqYmZZWWJ6dmhqNTFHdG4rcUIxaWdOVUlKUzVLZjdxMkI1NFNJ?=
 =?utf-8?B?ZHlBb1pKcmp2YUkyd0wxTlhKU2tMcWlheEpnWW1ZNU5JU1NvNDhOMGtpbGVX?=
 =?utf-8?B?cGd5YTJKcW02bk5PNzlUbjV5bjl5cWhVbVpqd0pOYU53dmFZUHdBempzWERk?=
 =?utf-8?B?a1Z2bTlIVGNCRTU5NXovVXh5OEVVZkhVVGJGUHArVjhhUGNraGRBYzlTQW81?=
 =?utf-8?B?QXJrNW00c1Q4dTZFRDJJbHNQWjlUeUtqRnUvWGR5RG5BSk4zYlArQ1BuTlMr?=
 =?utf-8?B?WkJaTjdXcnoycFUwaTRjajAzNXRGM2JMRmx1QXlDa085N0s1ZlcyREkvbmxy?=
 =?utf-8?B?VkYvT2NZM2syUVpRaGVzNXNNRTJPUkFkaE9ySGdyT2U1K0dvRzR2WmpTMG1w?=
 =?utf-8?B?V2NWb2pSZzQyWjJPWVA3THJNQUpSMkt6bzgwQ0U0WElxN1pLditVSC9WK3hR?=
 =?utf-8?B?cG9qVG1zOGVNcVlDYkpJS0xqUXplbkpuWUFXQUd1Mi8rK005dUtmdy9jVC9Q?=
 =?utf-8?B?dnBXRVRYYmNya3h0aTVVcDN3M1J4YVhmZ1g0dTE4TGNSMWJHaUpYaUx5L2pO?=
 =?utf-8?Q?rD4X5H+mXYXXd8QuGwufYVjiy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6072aa-50ed-4c54-ce66-08db47bdf7ae
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 07:55:43.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIeREhHp61FH4/UXNCeZR0ke76XL4mdRsGNpaQ8S3McAG36IgcoIF5sfAzhi1pEk4P4TsHo3sZuGL3yz+SAVYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8876
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/2023 5:24 PM, Yuxing Liu wrote:
> Referring to clk-imx8mq.c, check the return code of of_clk_add_hw_provider,
> if it returns negtive, print error info and unregister hws,
> which makes the program more robust.

Patch 1 & 2 merged into 1 patch, no need seperate.

Regards,
Peng.

> 
> Signed-off-by: Yuxing Liu <lyx2022@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> This patch is untested on real device.
> ---
>   drivers/clk/imx/clk-imx8mp.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 353d58b665f9..de7d2d2176be 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -414,6 +414,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np;
>   	void __iomem *anatop_base, *ccm_base;
> +	int err;
>   
>   	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
>   	anatop_base = devm_of_iomap(dev, np, 0, NULL);
> @@ -717,7 +718,12 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>   
>   	imx_check_clk_hws(hws, IMX8MP_CLK_END);
>   
> -	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +	if (err < 0) {
> +		dev_err(dev, "failed to register hws for i.MX8MP\n");
> +		imx_unregister_hw_clocks(hws, IMX8MP_CLK_END);
> +		return err;
> +	}
>   
>   	imx_register_uart_clocks();
>   
