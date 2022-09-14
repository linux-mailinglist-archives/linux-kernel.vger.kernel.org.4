Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABA65B7DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 02:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiINAg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 20:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiINAgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:36:24 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C3B6716B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzgGMp26NcFvUqf6ckT1AEV81XiG9U6CCsgVG5yTrzjfYAtP4iesatpd5gQKFPNjX4pr/N7Vkui7FnjeKTU9XWAoUQG29FR4t85vUN8WM5v0JmGpO5f8rdeDxBds740dBovbR7cjMfBpWtArGKRsjY3Nlz+yNiGv2PkWeXh/35/Q0iYz56657l/wD2IJmRXXt0xxnpcjTZMs5RYICcK9dC+MH2jp6nA3J4+Hu9yhXJWpqmZK9ixP7x0ZH0AqU1g+t+6357iAAmFuL/Lw3NhVXmAAJ6IlbVnarDVWTWT+wgd3LgHB4Os9Nu60ALMgRJtPiSBsjt8Hfues/TVw5r5CEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfiyNaEKdTOOpooVKMbnRK9taORlUU+l+FVmSkX9WyA=;
 b=XJlrSv3YBDsXgJEW0eBOSZQxBkh9rM2DXtjsXp7Riq0W5RCPqBpe0m32bHDFHdhUSN92YepK1Pn3Daj++y9MbDIbvMRcKrItZmZvSRL93yRSmsn93nRUmwe2scJDl4uygDbRM9qxnIUdrSLjnaFT78mdb0JwjBb2vg+uUzCVkHXpGV+smS7PKkufeRmHVwTvSfQnKGhdaMQloNwVND5IVfpRRKLE1he1vsab1Gq8MiMK7RxireIzU4c4kdn/qAxDuG9ziGuQbxEwf1BVmyWAHIeX0IE4LUIvvx6N+PTjjLikbC3u+GhhwniW7/DJl3kzgHdm4dgDTvEZmqMTkOsbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfiyNaEKdTOOpooVKMbnRK9taORlUU+l+FVmSkX9WyA=;
 b=Wg+HhEK5fRcwBfN2vdziS88+4obNUvIU7FRqe9bqhXAijJicMTgpIafAAMqfBA8zwuYABbzO+sbdlFmvbeKDvlrCQC1S/erBTVPm2sVWniKAqN+fCkmOVaFMVMsWGQvxxiFNjyduzbizZ4uIumFlwc5z4vTWN7OpFYqiyjADKIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8479.eurprd04.prod.outlook.com (2603:10a6:10:2c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 00:36:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 00:36:18 +0000
Message-ID: <cee07cc1-4972-df69-0451-1f345c0d16f3@oss.nxp.com>
Date:   Wed, 14 Sep 2022 08:36:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] mailbox: imx: fix RST channel support
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>
References: <20220829033743.2698606-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220829033743.2698606-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f40667b-b9fc-4d79-273b-08da95e92345
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYemiDQ0PE1zPCVRNheMXltl+CXP7vNWH2LXGB7BRauOd2Htbh/OePCyVH48RRRdvfVNJveQ1jYutOJxyRloQX4TzJ2ilrDUiSjTbmODnFXHnNF/WUvsW5/cTwfRvpbhlzB92u2O9No+lIIc7ScZB6Gu/XDkJwdB52y/tR7klZLGCXEjSXbDYE6suFNO1Xy0L3qhzfkJzacKYI3R2Fj4cMaB5z50fCeekrLp879lIqdmW0Bn1BEX5AJ6uWxmz2VKf54+w2kndN2tKa/crX2hdimzd6epB0Linf6t05g360PCAAiEI77lDczysmXBfEbTk8zzpJ1sa5DHDhGBMbTwfhf073Gv/bxuU3tVl/o73bm1MZ1pKjD2EJCns+zzlJ2xLA77IOiKGGiFGeEsrrJExuxroOKm7ek0psnzttRHzY61bkcJSME+S/niKeyd0aclmQ6m6EbYPQ9Ld91rzBhN0SdlbAwSK7S1zPrxwEmnwYddfEiofbqcyObRidmcQ8BrNAK7dU9H1SNjfKhX+kh536dHFr0dlZbdpu/rvEphlYsAZqH+Irjb1opIRPBXm+MX7vt8YQVGujoejc/Jynnx8IngDKRNyZ1iiexlIWJBIzj62qwj9b9MDouAqE3rVZ9t4TXn/yMG5hZsldwCSgrbI0+ULxivmqIVbOLcTRsJJNDN9XT36YrOT8x0fOCEOMWVnw+A9/GrbmSPrHtUR7e4FK1is+wYngaxP40uw+4fxqqqOu7pdvH8+5sq/RLIZAzqNsQaWVEhqNCCTKJSMxHxN+dM1BQMHWlbyh4HkVB98XY8Yrb9B0kz+/MuKW+AdKtQCV0sxivN/9dGQopaI9TCLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199015)(66946007)(52116002)(6506007)(31696002)(53546011)(5660300002)(66556008)(66476007)(54906003)(86362001)(6666004)(4326008)(44832011)(41300700001)(2906002)(31686004)(26005)(6512007)(38100700002)(478600001)(15650500001)(316002)(38350700002)(8936002)(83380400001)(6486002)(8676002)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHdCMDExMkt3TGc3T2RWcEVRMEoyeXFnSXJLVE1uWjZlYzhVQ1FwWit0TmNV?=
 =?utf-8?B?d3FlbENwQzN5MWg4NGhwVDV0cy9EZFZqMnRHY1FwZlZWVE9yMnVNQW1iY0Jp?=
 =?utf-8?B?c2VyUmxkQlJ1VUpLR2dmRUk2S3BHejdzQ0FRQUdzVXRjMC9YM0hjUTBmdGhG?=
 =?utf-8?B?M1pvL2ZlM3pVK2orUnFQSVVxSzJhUEYwd0hnenJERTZBYWlQK1IwSzdaMElG?=
 =?utf-8?B?NFNJTTQyM3QyMXNrS2ZRYXJueGtXL1FkU2RoU2dLZG83ME5FaXBmUW1FVVZW?=
 =?utf-8?B?MFlYZEdLYTBGWFZFb0lZaFFmSDVOQmVLaU4wbUlIaDFKUVRydmlSWmJ4SVVX?=
 =?utf-8?B?UEIyWXZYV2tmYjdvV2ljUWdtWWVsTEVZSTMvQ1AwWmxOVUYxQkVWLzl3TGxj?=
 =?utf-8?B?RkNJR2lnQjN2aHZMdzNNU2ozSnVMNVljaVRtbGMvbkJhdzZBTUZFdm9yUE1M?=
 =?utf-8?B?eW9TcmhyYzlQRml6ZEVTK2xhM2VtcC9pN0c2RDBoaWN2YUZueWRpTldxVm1S?=
 =?utf-8?B?L0RiTkZDNGlyZUhJN0dKZlR0T1huTmpZbVdIWk5MZkticWVwejVvUmNyUDlF?=
 =?utf-8?B?aG10TmtrQ0s2amxUM0ZWajU3TzNWU01TelRhUEd2WEIva05HT29Lam51b3FK?=
 =?utf-8?B?VEpHTHdRMHpjL0Npa0RvNndnaXZCMzBjdTM3NmgxeUNnQXZEQzR3Zmw0NmxR?=
 =?utf-8?B?UGN6eDhmcUVMMzlrU25qOFJIYjRBREVoaUxpRDc2bHRwUzlFUW92NVVuaWpH?=
 =?utf-8?B?Nkw2cnpwcWN3dkk2ZURvaVhzNmg4dmVPeEhqZmVRbXhFeXZsOGh0a0FwNWRx?=
 =?utf-8?B?M1ZGTXV2MTNIK3l3QnpPbXluYVFQQmVacjRXMnZtbXp4bW1lZUJ0YU5Ebkxp?=
 =?utf-8?B?cFlrTmEvenh3a0gzZHRVOFdIaUZqUCtNc2FvOWtmdEhxQzEyL0xkeXI5TjEw?=
 =?utf-8?B?QWo1eGovTk13aC9kSzZ0eTk5aDVyVDI1QWxnL0loZk9ZZG9QeWhXckpGVmgr?=
 =?utf-8?B?aURkWGpBeC9lZXpGZEVYMXhBYVdvK0RxdkxXaXkwYnpNVnBKNi81V3l0eTZT?=
 =?utf-8?B?MVVXeS96dDg0Mzl5OFBvTTVLZnc4YnVReHI3RlRCdzhwM3ZQbjdRditaVVVD?=
 =?utf-8?B?bFlKbGlOSWpQcWk4TVRBL0tpQWoxWUo4bE1jdlBXZ1h1YmxEblo1Q3h1a3hN?=
 =?utf-8?B?Ukw3bXlJay9XOGU4VzdSOEVibndraXBhZENaczJ4a2twUi8wVXlNRlFYMXBJ?=
 =?utf-8?B?TjlmTTBtQ1E1TnpEcUg4MUNPUjVMSEtuVVNBdXYvOXNFcGxvRVR3aXJsWnF0?=
 =?utf-8?B?RDJkLzVtUmtEdjJySDlvUDJFSy93Qk1WK1ZjVjdvQ1BCUnE5MkwvYnlPbE5P?=
 =?utf-8?B?WnlvYmFpOE9YaU9SOGd1OUpDU0RwQnovbWtOMXNYcmVFUUMvM0thenFjYmY0?=
 =?utf-8?B?MVU2aUZHMFBhOVlaS1NUUGlFUHpSTnZrblBudCtucXNnQ0JjR0dKS2ZFY015?=
 =?utf-8?B?eEdNcEdjUXVBZzZyZG1XcGRBZG5aOTE5dDRyQjBwcWw4TVN0cmFDaXMzaUFO?=
 =?utf-8?B?NXgzdVZXbVBON3VxR2ZLUm4wWWd3N3RKK0NVNEIzTXIzMlpGdjRrMlB3V25F?=
 =?utf-8?B?alFCWi8zcW9KWkI0YmJVZmtoK0c0dGFsY01oN3JBeGlDNmFROHZTL21kL2hm?=
 =?utf-8?B?cDNORlJ4M0VtVXdVdHVYbDBKaEZwR253OHllUnpXMU1OeXNGOXd2Y0dYditN?=
 =?utf-8?B?M3RnOFdsb1J6WkRtNEVmYU9CNWlnQk5jYTJZbUdvT1Q2SjR3SUIwN0drSmUy?=
 =?utf-8?B?M0RlOXZjK0ovT2Z3Q1oyOWtyTWM1WVNBbXJhWDJRTmZERjZUSW0raytmRHNT?=
 =?utf-8?B?TTFBcmpvdWZxdWJvaG91Sy8zT1M4bERrcWtMU1hPV3FhVUpsS2Y0S0RHUkZS?=
 =?utf-8?B?L2VUUHdUaTJyU3o1bXRUc1JwNStaWHN0d3EwQ3ZBM1Vob2FqVDVFUHZpYllk?=
 =?utf-8?B?VXhwd3BjWXBNUG5rZUJ4RklVNFk2UGcrS053SXZSNVkvc01LRzllMzVpTlNn?=
 =?utf-8?B?TnFROTBQZXB2MEwzVmJzOGVTN05kcUpnS1VUa0NZSEd6UnVJQ1pFWkNNbTNY?=
 =?utf-8?Q?GyqfTcHFYm6sCFMsS3CNf9Xyg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f40667b-b9fc-4d79-273b-08da95e92345
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 00:36:18.1280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D433rwWhSW2RxEXbHHx0Y0TtNqmT6BlZbOzT28Z0jf0OWkk/bJMlolEXDeEWquC7P5g/bdjN1nquNYv2GU5Sig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8479
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

On 8/29/2022 11:37 AM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Because IMX_MU_xCR_MAX was increased to 5, some mu cfgs were not updated
> to include the CR register. Add the missed CR register to xcr array.
> 
> Fixes: 3d38ac9c40bd ("mailbox: imx: fix RST channel support")
> Reported-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Would you pick up this patch for 6.0 release?

Thanks,
Peng.

> ---
> 
> V1:
>   Tested on i.MX93/8ULP/8QXP/7ULP
> 
>   drivers/mailbox/imx-mailbox.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 02922073c9ef..20f2ec880ad6 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -904,7 +904,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
>   	.xTR	= 0x20,
>   	.xRR	= 0x40,
>   	.xSR	= {0x60, 0x60, 0x60, 0x60},
> -	.xCR	= {0x64, 0x64, 0x64, 0x64},
> +	.xCR	= {0x64, 0x64, 0x64, 0x64, 0x64},
>   };
>   
>   static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
> @@ -927,7 +927,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
>   	.xTR	= 0x200,
>   	.xRR	= 0x280,
>   	.xSR	= {0xC, 0x118, 0x124, 0x12C},
> -	.xCR	= {0x110, 0x114, 0x120, 0x128},
> +	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
>   };
>   
>   static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 = {
> @@ -938,7 +938,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 = {
>   	.xTR	= 0x200,
>   	.xRR	= 0x280,
>   	.xSR	= {0xC, 0x118, 0x124, 0x12C},
> -	.xCR	= {0x110, 0x114, 0x120, 0x128},
> +	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
>   };
>   
>   static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
> @@ -949,7 +949,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
>   	.xTR	= 0x0,
>   	.xRR	= 0x10,
>   	.xSR	= {0x20, 0x20, 0x20, 0x20},
> -	.xCR	= {0x24, 0x24, 0x24, 0x24},
> +	.xCR	= {0x24, 0x24, 0x24, 0x24, 0x24},
>   };
>   
>   static const struct imx_mu_dcfg imx_mu_cfg_imx8_seco = {
> @@ -960,7 +960,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_seco = {
>   	.xTR	= 0x0,
>   	.xRR	= 0x10,
>   	.xSR	= {0x20, 0x20, 0x20, 0x20},
> -	.xCR	= {0x24, 0x24, 0x24, 0x24},
> +	.xCR	= {0x24, 0x24, 0x24, 0x24, 0x24},
>   };
>   
>   static const struct of_device_id imx_mu_dt_ids[] = {
