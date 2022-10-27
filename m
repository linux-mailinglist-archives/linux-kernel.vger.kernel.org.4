Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DCA60F014
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiJ0G0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ0G0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:26:17 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E9D158D78;
        Wed, 26 Oct 2022 23:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyItbOG2zxMGY9kju8PZYX8yoOnZi5PEZUwHaSgxMmblORuyzbQ7E+QvU33MF8Gpf87Ltox8AuRLMvq80tV+0WrmDYyTqHvA1Gk1THz2mEA+vUX5LuK3kRez/9l8kikqMAvzM0srhPlJqpjWxuYNG3iCLK5F9jCBuqaFNFYIo5Elw55K+KrgTPtMsGv/SR3glcfYDbrczEzWt3l64bTXlXKPv7/2SIQ42yE3euOQ/icm+I6XsDt3fkpxElKN/eN0uv4wINKnA9p6IbvX0mBjWgJ1WAnORwJSaaBs/icckn4RI17stWlZ5T6lEckUjvW2spVp65SqG+N+Me2fkRey2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT5DAyqOCQTkC3OEf7UHo4GXnrfsnlhhjhhOC0x6l/A=;
 b=FrL7U+PaZdL+ckKVTcBUIcdyqHbTUbJH94DNkW0nxyb7IrXDk7u6pdMYz+DOqeRre9CR5Azh7Ek+pGaPD/S+Q2jSNQrNa439hH1xJ0eRR0vHfEflqDrG3JA4Ahr1wlBbh08+al2zRQLoRcAGZZEsYHSVhyXtsApseMjcdNlK05ab0Ae6yACnMbgwvMmFfqcFV3VYxSwt/CCu37/5cQjdSJhqKMGEUjAyNChO2tWNyhb1sSgsoRfNUNCqomS5IcFXEBdlkBXxqxR1FMczT8ic/6SJ/1xA4Ew4cAFYpHu7KbP/xma9SORhUJrXf9ieFjsBpQYc8VigDxPrGK0Mz0b+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT5DAyqOCQTkC3OEf7UHo4GXnrfsnlhhjhhOC0x6l/A=;
 b=WJv1F8iKcBwq45aMtI7GRIyY4CR74UGY3fv9T/vz+fH55Sy2r6JsbFY/mU4ONX9XKY2HtAiogZXR/LjO6j+nruon4km4O8jIDFiSRDvopoBNONEZNg+yK+GPCXxKpaFfdGD05g2bBz1Lf4Lr9fLx71l1plMuolGyvcQjVxgIfmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7063.eurprd04.prod.outlook.com (2603:10a6:20b:11e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 06:26:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 06:26:11 +0000
Message-ID: <394fb4e9-72ea-5323-1493-5149fd20f142@oss.nxp.com>
Date:   Thu, 27 Oct 2022 14:25:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v2 2/2] clk: imx8mp: Add audio shared gate
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, shengjiu.wang@gmail.com,
        abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de
References: <1666834442-5609-1-git-send-email-shengjiu.wang@nxp.com>
 <1666834442-5609-2-git-send-email-shengjiu.wang@nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <1666834442-5609-2-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: a1cad6b9-90d0-47eb-d925-08dab7e42433
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYeGCJLyTP1BYVQOczYcvyULS/WQD+aCS3R2u9kvdodlUZnLH+feOiV5OL5cP2X+aEVyuny2jQnn01F3xiVnBOhkNhRDuxh8XoGp7Q0sa8GXaGyJf7RmTAdk3bxjalPQ0Vl75y238Q3Es76eu3WCM0hNpkl8/Xpu6KzT9yHcKwHBNmo56PcvBscPOzw6Ce0qjMYea0TB9qr4o0JG+MUWNOTYKRBQXj/+mAaHROCbaIizMNrJ9xpwVajUOjAJE5uU+RSDrftPl/K9yP4ddwF9yM2JGnIPpccdcPA2aTx/pzPGm2kFjseNqhs0lR5c11OJjS2FmIQU9JUWBBuQ8ZF7MJE1dOTPkGEEVNsmuNubZ8ZBDjnF1OKKh1QXqG1iiBYxxxxBw7ZX5hcFGQO+vEKyhfAuB28SZJ8a4hyz+GyO+EfzmUsPeQ/D0UtGylBNH2L9rgEqiaHWoPZR1KtMZ/w44AZJ18fyV6cefAeOFgPeHnQINY/FkGTzvyVZHld+qLbp01eC6lOUoIJD/9IXERuoKWCNB4TfacF5pi4N34xoB+Kc2oZQV5UIsHgAiwojMps5xrzSyAMbfhltEg3ezmJQQeyf6bbsoEHYhoXj//4cuX/bDQ1OC6IXCHuSOPqvCAYuXv4WpxiyLpSZu6VQfpNWt1pdnLJ9u74K7xy+Nm4VQyNdKrni5PKQUbADKl3TJc4iWFdeRp2x1XCjJwbzRSqZ38Y5Bix41BtQlUXvYnacngUlm/a9UvBe3jeGWQjcl/sSlHupa/eXZMH8+Zc39xo36RDWusN7OPJ3VRf/zGPDR18W8nZxQQMn7oarw1tsZXDVvYKX/mXTzIX196i21aQY/7ayeFV0oJKszSlOM+mIyNQw2EmvexMEXFtbe2lO56ZG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(38100700002)(6666004)(86362001)(31696002)(7416002)(83380400001)(8936002)(5660300002)(186003)(2906002)(44832011)(2616005)(6506007)(8676002)(52116002)(53546011)(66556008)(41300700001)(26005)(66476007)(6512007)(66946007)(921005)(6486002)(478600001)(31686004)(316002)(38350700002)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N25MM0hTTldHUU5pa2lGcm1sdFlzZjU1R1Y5OHR0NDRSQnl5Q2kwNnhTUCtv?=
 =?utf-8?B?TnNMTXhiYkNpU3lialZaWjhWWE1iYXBYYm95Wm5DTlZkMmR3WUoyV1dwa0VV?=
 =?utf-8?B?Zml6dEwxTEdTU1U2elhWWjAxQi8vOHI5YnhLbzRuRkJ1QnI5QU1rREpyTlg4?=
 =?utf-8?B?SjBvVVdQMlllT2Vab0I5bjFSREdMblJFWWZiQmZHNHpJWXQ4VlJDSjJhL2hV?=
 =?utf-8?B?MGtEM3A3ZlZVcWVsZWxMY1ZLSkFTWHl4TGRNcC9tTElOTEV4WVJUTXdjejNG?=
 =?utf-8?B?R3E0WkcydSt2Zi8zL0U2NDQyR0IvMFRPNGl0blBNVjA4YWxRNFVPeXlWWDRV?=
 =?utf-8?B?d1JmZW5naHRRU2pZRkU4QWd1ZE1tMmRNbkkyVjE2U3Q5dllmSFpqMDY4RXN3?=
 =?utf-8?B?dXRHa2tDY2tLekNFTWJpWmZUaGs1Q3VOU3hhbEErK0Q4QWVETWpZbHVXQWhK?=
 =?utf-8?B?VGxMRlFtN3lWYXE0ekpFc1NQQ2tNWDExZ2x0Zk5zaC9aVkxncFAzamx5S2M5?=
 =?utf-8?B?bEhISlVpYk4xYUl4Y3hmK0E0amVOUmpodEZkTDNnd05vNFZRMlNIWUVGOHQw?=
 =?utf-8?B?MXQ0S1pVQjhrRklxTDFnbGVBSmtMR3o4TDg5NS8xNENmcjRBODJNaWdNOUZk?=
 =?utf-8?B?YXgwQ1hIRE9tQ1hBczhBNVNRZGpZL24yRkUzZ1NtRmN6eFYyeXQ4VkpPemlY?=
 =?utf-8?B?T0tVbW9mbFFmaG41QUZWT0YyRGZWdWh4ZnI3YmJNUWxvZml0ak5WYTZQMTVy?=
 =?utf-8?B?WHZiSDg0TDE0QmpMWnBFSTB4dTM0THpWU1NsREFYaFhhUkxEQXBWcEFJOHF2?=
 =?utf-8?B?NEpiclJWZTJNaldhWEhtTEpWQWZ4ZkVMNEdPeWEwdDc5MVRHdmFZWXNsMHY3?=
 =?utf-8?B?ckZZcjZpODIzZkhnU0NPdVd2OEZBNjF1SWxyUExiamJONEYzaDV6OUhEdDNH?=
 =?utf-8?B?dktmUkJWTVQ0QkRFMjA1aUhQRndQWkw5aWRSaWhpZ21ld3c2RXI2cWl2Z29X?=
 =?utf-8?B?OHIxOUEyR211VGJWQTZNMXJqeXRlZ3FvdUcyV0s4c3UyZHliZkRJd1B1Y0la?=
 =?utf-8?B?WGJyZXhvRG16U3B6bW5nbFZBVWNoZnVZT3ZXVWhVejZQemtzUHlmcW1QWWcy?=
 =?utf-8?B?Y083VXNRYWtYZ0w2cy9vdVdKOEdjVGN1OFV1d1dKZU5KVHN2dkxZeUJQOHdT?=
 =?utf-8?B?Tm9BQ2NualV1VnpDcXJLOHNlMHhLMHZEMXpFZThMTnBOaXRiTWpsRnB4SjMv?=
 =?utf-8?B?MXZQWXN0WHBPekpxOE5tR2RvVnVTOFF3WW54YXlKZmE5elV0T1lBM0oyZGIz?=
 =?utf-8?B?OERQaXNEMVNrbHVuSWFRT3ZZSWxWVGl4NWlKOWErRFBvRXJwdHZTRzlCUVZ4?=
 =?utf-8?B?dDNYUnJPMDE4eXR6VnNMNmpLUVVRVS9kTWU2UHY2ZXhzT0IvbUF4Z1l2NzZV?=
 =?utf-8?B?U2xiV0NldE1uV0NqT0gvSnhnSUpkcXV4aVU3VU85cUZjVDk0bWNxSzQweC9C?=
 =?utf-8?B?ei9BYmZnVlY0VWMyWE9RRGVBNFFwcSt2SWE5ODJJUVQxejBtcHY4YXJ3cWtp?=
 =?utf-8?B?VHpSaHhMVkpqRm5JZTh6Q20xelFoZVFYNUxYQnpzaHFnWXdwV0NpY3VjUUlm?=
 =?utf-8?B?MVhHMForZk1DSTRVZGU1ei9PSFhHdWdGSWIwTkFJdU5nL1R0YnI5Q2hvM2ZO?=
 =?utf-8?B?K29RRlVwak9FakhBcjZNMVNoOGFDK2h1UXlNR1ZVYTRKZ1NuV3NqUHNWSmFu?=
 =?utf-8?B?bkw0ZGxkNmNUS2lGZ0R3WnBTM1czZjVtakpqeFhHekhEUDBXOTdibmFKNVpM?=
 =?utf-8?B?clNVNXJlODZldHpscFhyYzBaNEpCRFh2NDJnem0vSUt0Wm5hNC84UGdFRStZ?=
 =?utf-8?B?Y3hIaStoV1NWcEViNlM2Tlp1RXp6SDB1bDh6a3VqRjQ1SUxKazJDa2tmTG9i?=
 =?utf-8?B?bno2Yk9KRjBtNi9kaEh3SkZ3cG1ySTBBa0pUVjdRdTNmWWtEVklJcmIxcnNa?=
 =?utf-8?B?aG44Mk1wNWVMMCt6eXVNQXlJdEY4d2FrM1d5cVhWeWduWXdIOFlWNk5Ra0hQ?=
 =?utf-8?B?eituaVgyZXpPWml6ZVlnZGRKRVVndDUreWE5ckY3Q3pTSWFqNU84Zmg2N09S?=
 =?utf-8?Q?MQlp86Ocz5Hyn1rz7jYhRRVo4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cad6b9-90d0-47eb-d925-08dab7e42433
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 06:26:11.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzdTO0Bub1HPAXVyon09f+vNqaESQL4haYB3SCtxspOHCCiONZqshI3isFJgTnoRVKezBgqE3VK1q25fcu6XyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7063
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2022 9:34 AM, Shengjiu Wang wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> According to the RM, the CCGR101 is shared for the following root clocks:
> - AUDIO_AHB_CLK_ROOT
> - AUDIO_AXI_CLK_ROOT
> - SAI1_CLK_ROOT
> - SAI2_CLK_ROOT
> - SAI3_CLK_ROOT
> - SAI5_CLK_ROOT
> - SAI6_CLK_ROOT
> - SAI7_CLK_ROOT
> - PDM_CLK_ROOT
> 
> And correct clock MX8MP_CLK_AUDIO_ROOT to be IMX8MP_CLK_AUDIO_AHB_ROOT.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2:
> - split dt-binding to separate patch
> 
>   drivers/clk/imx/clk-imx8mp.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 652ae58c2735..0ae3bc7bf8a1 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -17,6 +17,7 @@
>   
>   static u32 share_count_nand;
>   static u32 share_count_media;
> +static u32 share_count_audio;
>   
>   static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
>   static const char * const audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
> @@ -699,7 +700,15 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>   	hws[IMX8MP_CLK_HDMI_ROOT] = imx_clk_hw_gate4("hdmi_root_clk", "hdmi_axi", ccm_base + 0x45f0, 0);
>   	hws[IMX8MP_CLK_TSENSOR_ROOT] = imx_clk_hw_gate4("tsensor_root_clk", "ipg_root", ccm_base + 0x4620, 0);
>   	hws[IMX8MP_CLK_VPU_ROOT] = imx_clk_hw_gate4("vpu_root_clk", "vpu_bus", ccm_base + 0x4630, 0);
> -	hws[IMX8MP_CLK_AUDIO_ROOT] = imx_clk_hw_gate4("audio_root_clk", "audio_ahb", ccm_base + 0x4650, 0);
> +	hws[IMX8MP_CLK_AUDIO_AHB_ROOT] = imx_clk_hw_gate2_shared2("audio_ahb_root", "audio_ahb", ccm_base + 0x4650, 0, &share_count_audio);
> +	hws[IMX8MP_CLK_AUDIO_AXI_ROOT] = imx_clk_hw_gate2_shared2("audio_axi_root", "audio_axi", ccm_base + 0x4650, 0, &share_count_audio);
> +	hws[IMX8MP_CLK_SAI1_ROOT] = imx_clk_hw_gate2_shared2("sai1_root", "sai1", ccm_base + 0x4650, 0, &share_count_audio);
> +	hws[IMX8MP_CLK_SAI2_ROOT] = imx_clk_hw_gate2_shared2("sai2_root", "sai2", ccm_base + 0x4650, 0, &share_count_audio);
> +	hws[IMX8MP_CLK_SAI3_ROOT] = imx_clk_hw_gate2_shared2("sai3_root", "sai3", ccm_base + 0x4650, 0, &share_count_audio);
> +	hws[IMX8MP_CLK_SAI5_ROOT] = imx_clk_hw_gate2_shared2("sai5_root", "sai5", ccm_base + 0x4650, 0, &share_count_audio);
> +	hws[IMX8MP_CLK_SAI6_ROOT] = imx_clk_hw_gate2_shared2("sai6_root", "sai6", ccm_base + 0x4650, 0, &share_count_audio);
> +	hws[IMX8MP_CLK_SAI7_ROOT] = imx_clk_hw_gate2_shared2("sai7_root", "sai7", ccm_base + 0x4650, 0, &share_count_audio);
> +	hws[IMX8MP_CLK_PDM_ROOT] = imx_clk_hw_gate2_shared2("pdm_root", "pdm", ccm_base + 0x4650, 0, &share_count_audio);
>   
>   	hws[IMX8MP_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
>   					     hws[IMX8MP_CLK_A53_CORE]->clk,

Reviewed-by: Peng Fan <peng.fan@nxp.com>
