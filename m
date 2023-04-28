Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7626F12E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345809AbjD1Hza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345744AbjD1Hyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:54:32 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438AB49C0;
        Fri, 28 Apr 2023 00:54:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxDtDOtctaIreeHUhJs/cQv3mZVpSN94lJVqX4eEPXkd2xWzLABhlU3gvWnpDJ19W2wOT01XrJqPHn3CR8siXX9AmMd4+mSOa3AbrFJqPJsZAIMFtNt8SJlSoGL9I5LIW5y66Yj3wBZYvo9f5zP6NcGPtxvuVpMXYOXqO7VwvzwTqjjWE8kjjrTfEdxWr5f2iLwTWAkODljTBciqgg2gngRTh1BFXjCx2DGCBtdqqctx0fvfXbRAXwp7bXWYKuNQ9SVGy1e/T+nPLuPERw7YjhwgZoAa/dML96N+vAQVRFjCXVoqBjKNUsVZ7xvjM31intiULInp+hAESoOEyiFP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgUqXWRSrZ/mbbTRqJfQsY4SRt1o5p+ytfKZuSOanlU=;
 b=doMmGd8KBoET7k3R5CzYoXyk7jHAV0xFEilC/iJ1A5aq+30m4UkK/W+ndb5BDjzI8aJmI0AZfM52DfLX4CbJRrzzKqVqdbFGrpWnOtUdxJPXsRO8WKu5acE12eJZBAGzn3/0g/1bc55HHd+wnJpzvLFOMLYtYmwJXAdmOspfGv96Xp1eW+qWYbIfCAP7/00ZUYbsYBFQYc41A6bd3/f6JE1dCZEtLaPbgOJThEcQA9NXM8IsbZqhrINJLgA97s3o1Fe5mscYUsUOCZ9dn+X8/Az6XQCEEX865xy9sIq8NnAj+XQ6sC2uo1/wO+OGVuY/CQi+w8yvWo+or0Z/MWQAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgUqXWRSrZ/mbbTRqJfQsY4SRt1o5p+ytfKZuSOanlU=;
 b=DuLPv1PEW8v8ekxFmTjfA8vJ09JmCY8YK35O3Dq/sXY9YA+HosS/2N2oaofEbqgfvbH/TOsDGMlJ4eomh6eTX1DjJZCzbdrgmiWhvea8qYBBRUn+Pq/s6WqrL3RBqa9sbGHj5+qOiMYeu7Q23V/98KQlapkabva1+adsOwH37u8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9257.eurprd04.prod.outlook.com (2603:10a6:10:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 07:53:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 07:53:57 +0000
Message-ID: <e336d1d4-74e9-282b-1b80-e5f5617fab06@oss.nxp.com>
Date:   Fri, 28 Apr 2023 15:53:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] clk: imx: clk-imx8mp: use dev_ managed memory to
 avoid memory leak in imx8mp_clocks_probe()
To:     Yuxing Liu <lyx2022@hust.edu.cn>, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230424092346.124509-1-lyx2022@hust.edu.cn>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230424092346.124509-1-lyx2022@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 4caae424-996c-41c7-5c30-08db47bdb82f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKk2qhkmA0QWjmjVTAH3mpR10LHrXPmxcCgEtdD3dyyLnXxKrSQx1VrPdNkZRMxPsNF7ZBgqPzz8cl8CYU1AeHp9SJf7Tn6c2E70maF2EtaSTwZZwT3Aw8DPWRta1CqDJbx9NrpE9xHv3hWLfUgxnaMa5KtH6A3xlgUywiQboQ1agHPF54X/ZNIkTU0st29kbXdGV3KGd3pCNGXZHJ9FOOe7RE0aG+sqBr86vhDyK4gVsH49RdcSuhWqXjGdHmLgyH7oE7lRHQmMMbZRcwfxR86G/iKy6ifwbOVV70la8QcjdzKwILTBJUIGVMz6BffhSZ6N5fomXlP+hJ/H7YV9r/PRsUALavYsHEf4sgRhg7bOK/pfvuYhHfV7sAvvxKbUOvg7ONy1jW+hL6axqfd7xgeLgkT8wlrmvlWHaNJXZrb0Psm0UtumWBXnCNHU2a88LjHlL3hIlSyaOLewn/EPhN6Aw/NANwtSsGx7Q28yuDatF/7fsiD9sEXa5Jv2c/Vt7FfI9987a2I44yyCDgPlevJsOskjtDynOUV9UXhw7iQDIjOLchbHqIOdcqaWj9xUl+x+X7Kko3oENJlMgEFpfcWWFBLJDpfPllk3HKwqwm3+7q7Agxhb833tvWc/Dr8gcmJY4qkCtUAmw36JWwmTrDMUaImWiTimg/+mGTcCKsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(2616005)(53546011)(86362001)(6666004)(6486002)(6506007)(6512007)(31696002)(26005)(186003)(110136005)(2906002)(478600001)(4326008)(66476007)(66556008)(66946007)(316002)(41300700001)(38100700002)(83380400001)(44832011)(921005)(5660300002)(7416002)(8936002)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODJraWQ3T0FqNFlGTnUzamtVQ0tiRXVRQUx6dGxvNXZrT3F3UHdpWWY0Z3RL?=
 =?utf-8?B?UVYvRHk2d2xqMFYvQkUweW9ER2lEbUZ0L0tTRjIxZW1uL0V6MXFQMmhxNHkx?=
 =?utf-8?B?OGlJOXY0WkQyQ0VYemxSb3lMeHo4bGk3WWREdlp1ak1aVW9GaWlabWtpQmNZ?=
 =?utf-8?B?dHZDMG5qaVNPdlVuNnk3V04vYzhWSlhib0gzRks1RW5ZZjI5VmluZmhRZ3Fp?=
 =?utf-8?B?RHpQZndKNlVDTEZuRHlIMXlOMGJ1bDladkwzZFB2SUZiT0F6K3lrSmtlbC9H?=
 =?utf-8?B?NmovcE1vRmJiQWNZOEE2aUlPWW5hUy9ZRzVJRlk2b2c3eG5jeVI0NzV4U3FI?=
 =?utf-8?B?R0o1MFlSTWVkdVpIb0l6WkxBSFBkNFhOUWFHRERwRXViLzkxdUR0VDE1N3Ru?=
 =?utf-8?B?YXZsTHo5NkthWGc5MTFCQUNJVHBQL0VDSlNRYm5QbUt6YWhGWlR5S29JSFFT?=
 =?utf-8?B?L3NkRTN1ekQvekJ5Uk1IOTBEZnQ3c2lCUFo2WW0yb2drcS91ek9ITlA5UUE5?=
 =?utf-8?B?d0xxOUtzbTc1WjBTbDFkbzdLSGtTYnR0N21JZXFSbUEwbTRYNWdWY05Renpm?=
 =?utf-8?B?cXljK3NsQ0h6bmpQVUpkMlcyT1pILytZdVNwZzNGSmxXZ1Q3bG95NlBTMUtp?=
 =?utf-8?B?TkgybmMwTXVqaUs4cWZoVDlxcHI3SkRLZmVvbkN0dzVYaE84dE0xbUxURHFG?=
 =?utf-8?B?U0RhTk9pVU13Vjkzb2JzTWJtNnpEbDZ6OXlaUVFIMi9lLyszS2V4ZGZrQXNN?=
 =?utf-8?B?WDhVUmtqVU4wYlVWTkV5VUNUcUVMZ0VUOWIzaW56aVFzNVhCRWZ1cG9lTHA5?=
 =?utf-8?B?SDl4SFRndWxHSEhjQ0pwUmhCZmRZWVVhRlA1ZVhLeFZ5Y0paOU1qOGFRNER1?=
 =?utf-8?B?QzRsa1JIQ2Z2SmkxSUJqWjNOTTQ0WC9tOHJ6dG92YlNBY002SXA0YkJSYTBZ?=
 =?utf-8?B?d1F5WHc4THlpL2NETlYrYThiMkdNMlY2K1lCU1Rhb2ZHcWNxeVFOZmlqVXY4?=
 =?utf-8?B?bWd6L3lrSzZrbkczMHFaUFBJNTJNY1QrTjhxOHQzZGpwZzQyU1A5VTM2VXA1?=
 =?utf-8?B?NmpqbW0vQklGbDloZUNBY3BSTXlOdE84dUhSUklPa01EdnhtcDBhVDRvYUN5?=
 =?utf-8?B?bXl6VkdEblEweDJaaWxzemFxZ1NadVB4Y3BzbHAyUmZCN3dtVUNDTXR6MkVp?=
 =?utf-8?B?cWlvMEpNNTNsdEhDRFJ2WWplNnV5TFFGNzhSL1dDQXFka1NxODdiZWhmZGx6?=
 =?utf-8?B?NDdOcEU4c0liV2d1VEtid2tXYWsrYzRlcG0vLzBUeG5sMHpZRWtBbGpnTEsz?=
 =?utf-8?B?SjVtRW5iL1NDWTdkeUxubndMRko5MG9rSExLREZpMTZaQ3g3NW05YjNXMHNt?=
 =?utf-8?B?bmhDZ2Zid0J1NGFnaG5rN3dwM2k5S2J1NFl4bGkzV2VIbjV0cEpDcVluR3BF?=
 =?utf-8?B?SDRGKzFUcDNvd1V5SHNqTzNlNUdXNCtqTUdsYitBRHEzYi9BQ3FWSWQyM290?=
 =?utf-8?B?MXhmUVE1UFFZUE1sWUI0Z0d6SjN3QVpnejBGeUdVNTBzMGF5NTVvU2tvcHpa?=
 =?utf-8?B?RjhBZTRMSVRlcEQ5NUlqZUlyODRXbVlyNnVKUk1OREZ1b3VtR2RtdGt6R1Vt?=
 =?utf-8?B?dzRpWGsvN2QwL0dSd1RFQm5vcmI1WStjcE16L0ZDbzJwZ01YWkNDanZyemVJ?=
 =?utf-8?B?YUx2WFhBZ3NHN1RqOVVKSW5mUlh5Tlo5S0RWYjFRSTIxWXArZk5wQnhranQy?=
 =?utf-8?B?eHFLVHJNR2tTYWxrRS9wdWZKQXdHM0JsZllNRDlFeW9qS3ZLSnc1Vk9VVWpF?=
 =?utf-8?B?UHp2ZjJlL2hyK0t2ZzZtNzh1YUZTclp0bkxOU25icWhVUDd1algzS1NvVWJt?=
 =?utf-8?B?Tm5PVWwyeXMyNFZOa1lSTzc5c0tzS2FrTWMxUWlVZ3lHMnpjNzg2Ui9xQThH?=
 =?utf-8?B?MlV4Q1lQd05ZcmFaZVdJbnJJdkxZMlkvZHJEZ28vY0NRYWFNSjJnakJYbnpS?=
 =?utf-8?B?MDNmZE81K3dTblFsSzQ3OGNwR2xWRVRaaHgwd0trb3N3blIvc01WVDRIR1Q4?=
 =?utf-8?B?VVRsVE5OYjRrWXh1NmZ2WXI4QVVDeXJNbGhrZWpORm56SXpIaDJUdHRFOUky?=
 =?utf-8?Q?HMLXuy4nFH366gqiPYt+2gDr7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caae424-996c-41c7-5c30-08db47bdb82f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 07:53:57.0457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmNctcrgZdhMbTj4rTm0gUgwH2aaR5YXPqUix5ZkTIwmDBFIz5I9PcKMu2z9173BbZy84ljYIPp7EUT3iQFKKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9257
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/2023 5:23 PM, Yuxing Liu wrote:
> Replace of_iomap() and kzalloc() with devm_of_iomap() and devm_kzalloc()
> which can automatically release the related memory when the device
> or driver is disassembled or unloaded to avoid potential memory leak.

What do you mean "disassembled"? The i.MX8MP is an SoC which has Clock
IP built in the device.

Regards,
Peng.

> 
> In this case,iounmap(anatop_base) in line 427,433 are removed
> as manual release is not required.
> 
> Fixes: 9c140d992676 ("clk: imx: Add support for i.MX8MP clock driver")
> Signed-off-by: Yuxing Liu <lyx2022@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> This issue is found by static analysis and remains untested.
> ---
>   drivers/clk/imx/clk-imx8mp.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 3253589851ff..353d58b665f9 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -416,23 +416,19 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>   	void __iomem *anatop_base, *ccm_base;
>   
>   	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
> -	anatop_base = of_iomap(np, 0);
> +	anatop_base = devm_of_iomap(dev, np, 0, NULL);
>   	of_node_put(np);
> -	if (WARN_ON(!anatop_base))
> -		return -ENOMEM;
> +	if (WARN_ON(IS_ERR(anatop_base)))
> +		return PTR_ERR(anatop_base);
>   
>   	np = dev->of_node;
>   	ccm_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (WARN_ON(IS_ERR(ccm_base))) {
> -		iounmap(anatop_base);
> +	if (WARN_ON(IS_ERR(ccm_base)))
>   		return PTR_ERR(ccm_base);
> -	}
>   
> -	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
> -	if (WARN_ON(!clk_hw_data)) {
> -		iounmap(anatop_base);
> +	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
> +	if (WARN_ON(!clk_hw_data))
>   		return -ENOMEM;
> -	}
>   
>   	clk_hw_data->num = IMX8MP_CLK_END;
>   	hws = clk_hw_data->hws;
