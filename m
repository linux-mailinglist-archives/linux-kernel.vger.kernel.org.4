Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B255F014B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiI2XVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiI2XVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:21:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3CD13072A;
        Thu, 29 Sep 2022 16:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZaSYVFwEWiom4z2ug5bswsHGgJT4nir3ALM6bZ9M3De7ZBf+Y8UBSJMN+i5dHLtY2LvVPxDkBKgloZ0QNOH8D/LQn8ECZEEiRaWF3sZAC/dJtWI0wX7snVBmGIR8bUpeYJa8fpwP58zSNp0P1RwGpRmSvZL5ijEhWJI0jjxmkDw3dxf+YbvZ6FhEt8m8cGi++Ejk0W0k/oN1Csg4dkyv+A1jVFWr6dje1WMJ1PRwwjUQ/M2ZWnWjhuN/rG/QdnoyG8sxmuPHX2xRfgBPWkj3nM1Yias4vcbQplp6xc31BH/EpM/iuKio0lcV1+qHQ9npBukGuc8UDbPJaFE9cQo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7KZWeTkqr34RDGWTzl31cD58iF9Rr2+8/U7Adh0aNA=;
 b=XTXvfcT+HzF2NO3KaziktPxzaxhixuYIBQXrpPEFAzbMv4P4WOZJcAsMCCMT66Kr25CzPuQ0DcU3cAkW0Ttkc66Rj8BJMyxRn2rlWRXPp7dEAfI/XPc1Dyqt9WhbgOqE4Ompw5n36kG/L6PRNB4FHWa0qoC5N7snowDLY7I0RUPe+pGtkiazrloHB83tzL0Tki1xHftPBG2ffY2IotGlpGoM7kqHqTQveqwZs3G+KIJP3FmQvhEiVAfhXBnPGSCVKTK9X4vjQP2GndQUqCRoJQNLjLGEEICovbMev34mYsuah4XVGB4Gh1vnAWcqPMKPLoaCWcteJ14ccMMFodI42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7KZWeTkqr34RDGWTzl31cD58iF9Rr2+8/U7Adh0aNA=;
 b=VFiSezVlmizLJWiiZwwWvdQ75h+foE5DzvskQSR4/8PhPfB6p2Ud1DSm4mVYeFXYoxkleKKzXvDczXMii3X64T7jdSaByNI3moVAvkHQwpG4uOCOnYcIXfeHh8LZti0ov74sukNdhfKuvG3hF6DrzBivx0wKjPaKjgFaqvOPtEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 23:21:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 23:21:01 +0000
Message-ID: <681bb324-a72b-440a-0893-44675a60e73e@oss.nxp.com>
Date:   Fri, 30 Sep 2022 07:20:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V6 7/7] remoteproc: imx_rproc: Enable attach recovery for
 i.MX8QM/QXP
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
 <20220929061704.1571746-8-peng.fan@oss.nxp.com>
In-Reply-To: <20220929061704.1571746-8-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: e09f5e56-f260-4665-2cf7-08daa27145b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53nvXeWRCyZOD9ZcjfXIubeFGyH//e2L3gOM4YfmRLHWSzjBP4KoZIftFYgRKUXWjX5sAHi/WLvCPriFrXWAVp4U/Itm64/wxCVKqBWXwZN1zkfwrdQRtCEAsQFFtPUU/pt2Tld2327S4NhQBB38Uc4E60SRo4ZtI4/HzedWkhWlVq/1eJm9BGvVyjVRZ3tqVKcq52uYuP6vzuPu1qF8G8epHNNy9zK6m7FenkVKhxFe75S9sLozf50m3Gz+xNTwDNLTwBWCsL3oeAGZJnDrFWFx7cI92KxQpPsJmUyufju1Z7E5WZBb1l56NrdFn8ondJUObDZtrbLgrxvYYRWqyerbRWgQ0sfUkVGp0QITmp5SdMZ50l4EyL1J7Mgw5LYmMCQ+LuUkSmwCQ+2axMsyz6sNZlfadqKhBcK/0ZKE6ontSwTeE1Iuk/P5ZNYot7n0iUQe8ImnvZxG/hHrTkjoEsddAm3ye7WzqNCuNcR9nXGy58xUsmRq95VNK6SLvFHy6qzgjeKFxfPyUyj+/yUA7b3ZZCg3wmnGxUea23DWxlZrPru0UbyaT2Mef29QBObVjOsqcHNE4xd+mb472fRc89MQlneO2lUmQcPoUKa/S/ngdpusF+MfQ0D3WMwl4qEvAbFj04a0iMK3fosPhFySTPEN5Pb1lXCZvEjhk/mcWop67JA5W+G3nCx5/zR14ZWIsVQyihsOliC3Sx+31tTUfef1lFxpCWcMpObhKc0fsxARXkUmnQBWifzFd+ej+Iqr1lilvqX7E5QbfH6tTgGGaE0QwWjK3wyfqvpxBydQKzOk8F6XnbRXFWoSv+qQL6WhooTTGHjjD0Xtkz5nNiGRyYHAF1f1lMVJgXaF176nQog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(86362001)(66476007)(31696002)(31686004)(44832011)(8936002)(7416002)(2616005)(4326008)(83380400001)(8676002)(186003)(38350700002)(38100700002)(53546011)(52116002)(478600001)(6666004)(6486002)(45080400002)(66946007)(66556008)(6512007)(6506007)(41300700001)(5660300002)(2906002)(26005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VytVRk9HZXhyQmxJQTJFMDlWV0hsLzlZcTRUNWlnbDU1cW91QituOWIrRU9P?=
 =?utf-8?B?dm5FZEh6ODlLTmNZRmVSVDdndHBYWTNsSzhiYkcyL2hvZFEwbmpKQ2hleDA3?=
 =?utf-8?B?aWRBWHBpMXJsTXA1V3dFdGlUWHl1bmZDc0xnQit4K3NWdXN4SDhvZVozemhs?=
 =?utf-8?B?RGlXUFRRQnlzZFMyMzZlNExZNUpGVDBoQWd2ZUVuWDVsRWI4VjB3YkpDem03?=
 =?utf-8?B?aGlMWmdIQUNQZHY5SDJhZW5HYWRSMXBHWHdQL2ZSeFlxNVhmakwvcjdOeGdy?=
 =?utf-8?B?dUxLS3g5RmFielBZV1pLdWJXcFgvZzhiOUdiMlJkcFYyYU5neSttRkNxUDZL?=
 =?utf-8?B?TktXd0VNNzQxeDZzY1dwY1hkTUJwczBiU3RCRk1UQm00U2ZoK00wdndRRkRM?=
 =?utf-8?B?N3NaT2h1VzZkd3cyZXJDbDlUNWpiVmFFOUxSNUdiUmJtOTc4WFozbCsvN0x0?=
 =?utf-8?B?S3o4RmdxL1BSTFZCTU1SOGRCU1hzeEVsQXUrM0VvVlR6UmVOY3N0MVFoSElJ?=
 =?utf-8?B?QmlmTWJJR2JBNTA4OUcybWVjdmUxTlE1RitRNFhCWmExbktPdWhVc0lSTDJi?=
 =?utf-8?B?VFpXdEFFQmJZZEt3LzF4YVd1UU1mU3NIVWlodzgzZmRlaE9uQTNielozUHJF?=
 =?utf-8?B?V2pZTWZUZldVSW5xMGVqY1VtYlVrUWZXNUp0aTg0ZnBHTEpHRUtCYVNHR1Jj?=
 =?utf-8?B?SWU2VGdtMW8rT3VmUzg4MmxiUUU5TWc3Q1Npak9scGZoU3NGaGlCVkRGSWly?=
 =?utf-8?B?YXVXM1BXUGFrT2poNk5KN3pGMEsybmVXOE9Zb28xb05qdDdTSnlBNUh2REFK?=
 =?utf-8?B?eitSdHg3akYyREFHNXlrOUFra2VZUjJHY25OSmV2aFdWWVVOU0MvSS82bWRV?=
 =?utf-8?B?QzQ4aEpzNzdMb0J6UHR3a1ZpUUlMVlFGdHFHVzk5STRxbTU2Y0t5bWZhMWlj?=
 =?utf-8?B?WVFFRkY4bGVNZVNiaHNybmFidVdPNlI3UjlkQjlkSENwK2NKR3ZEVGovOFVh?=
 =?utf-8?B?WXlORkp3c25jMFZoRmt2WWwvN3lJNDJ4Uy9uaEtQdXBlKzNkYzcweCtWeU1P?=
 =?utf-8?B?cXlNSU4ySzF6NnltUDRGSkxNMUNGNWRPdzRGM2xGNVlGN1kzQ3dlcXQ3blJ1?=
 =?utf-8?B?NnoxRnJERlZsUEtRUVc0V3hveGhaaDdPZXRUTDZQNGlHZThiZFlRb202bXBp?=
 =?utf-8?B?cm5vTXdDbDFHdmFsYXJpQTBkVVFHcnkzWi9ZVWd3ZTIvMmhXRHFDNFhKanl3?=
 =?utf-8?B?dDhLZHhzTy9nb1RIMlBwaXRieEVsRWozeVBCaXlLcURYbEVRWmcvSERrVG9X?=
 =?utf-8?B?cVNsRk5OWWJua1lIbk5qVzU0Mmg4UWJ5ZXA2N0pxRmdLZTh2UE44TkRZbTFK?=
 =?utf-8?B?bWZaSTAyK1NQek1laXpuVU9WRGxkVGlLRDg1OUROZXRpc1hIMnREdkdDbGMy?=
 =?utf-8?B?eUdNMDRCOHdzMTh5cVZGbVl5L0NNSzhSTitpTU81ZXhranRVMHc3SFN2cXND?=
 =?utf-8?B?cy9uU1dKWm56TlpkajNKbjdHK21wS2xnNUw4MzhKeGpyVEg0ZTBoZ3BNRzZu?=
 =?utf-8?B?Q3lkTVdCY1ZqVXJpWGxzM2xDVnBzQ0g5dDI5OU9DVGNmLzBJNmJUSE5qRzVt?=
 =?utf-8?B?OW44dlp1bGpGeEthK29Pd1RPTG5XMXJ3cS9yRUtBYzRBaDM1dGdPa0lnRjN4?=
 =?utf-8?B?SlBCQnczbXRKUkYzVm1rWVk4WGFFaGVqVXo4bG5keXAwWVJYUnNlb1U1YXVv?=
 =?utf-8?B?TFZCdytNMUZHSGNsYVNJR2U1MVVvOEhUZEhSRk50c0NBQWFhOHE0cmhWaGZZ?=
 =?utf-8?B?SVNnL1FVRGVuOEwzUndLU0x3NjEvZ1hOdFB1c0tHQWZxR1JZRUJLbXovVTVz?=
 =?utf-8?B?bHlzbktpZURTR29jQUNrZ3ZtQkFFWlU1d20xU2dWQ1VDM0U4VmxPYzBWTjZv?=
 =?utf-8?B?ZXk1ay9zTERTeXNMYWd3V0cvK051WmFKaEZyVTdhNTQvckRvb2h2Yk01a2xR?=
 =?utf-8?B?SXJTZklhcmZWT0UrdnlrRVpRNGowK2lzcElOYkpDYklnQjFXbStjbVpEUmNM?=
 =?utf-8?B?YjFYMXYrMGl4eUNTaVdnSyt2VDM5MVVHRXdyVlVMMTVDbnVrN3NHNmkvclBV?=
 =?utf-8?B?WE9sVE1PazZHUWRnazRjLzZrU0tKU25WS2lQZHNodmFiWW5ZMUVFakhmeWFP?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09f5e56-f260-4665-2cf7-08daa27145b5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 23:21:01.3351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oIYssZzAGsFF47oauyNUgLfLV0gUWQ56jjCtAFXVgUNPoEeB1Cz07V3Yw9BziZ27j5NDtDi/Io1JnBmqOipLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9176
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

This patch is an incremental patch that could ignored, if you not have 
time or think this patch is not in good shape. Patch 1-6 is
to achieve same as V5 patchset [1].

[1]https://lore.kernel.org/linux-remoteproc/DU0PR04MB941763C3EBF8AE9A9CD69445884C9@DU0PR04MB9417.eurprd04.prod.outlook.com/T/#md2af773bc7f251efbe8ca011b5a70ba2193b4c01

Thanks,
Peng.
On 9/29/2022 2:17 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8QM/QXP M4 could recover without help from Linux, so to support it:
>   - enable feature RPROC_FEAT_ATTACH_ON_RECOVERY
>   - add detach hook
>   - Since we have detach callback, we could move the free mbox operation
>   from partition reset notify to detach callback.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/remoteproc/imx_rproc.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index bece44b46719..4057d6f33813 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -603,6 +603,22 @@ static int imx_rproc_attach(struct rproc *rproc)
>   	return imx_rproc_xtr_mbox_init(rproc);
>   }
>   
> +static int imx_rproc_detach(struct rproc *rproc)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
> +
> +	if (dcfg->method != IMX_RPROC_SCU_API)
> +		return -EOPNOTSUPP;
> +
> +	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> +		return -EOPNOTSUPP;
> +
> +	imx_rproc_free_mbox(rproc);
> +
> +	return 0;
> +}
> +
>   static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
>   {
>   	struct imx_rproc *priv = rproc->priv;
> @@ -618,6 +634,7 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
>   static const struct rproc_ops imx_rproc_ops = {
>   	.prepare	= imx_rproc_prepare,
>   	.attach		= imx_rproc_attach,
> +	.detach		= imx_rproc_detach,
>   	.start		= imx_rproc_start,
>   	.stop		= imx_rproc_stop,
>   	.kick		= imx_rproc_kick,
> @@ -797,8 +814,6 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
>   	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
>   		return 0;
>   
> -	imx_rproc_free_mbox(priv->rproc);
> -
>   	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
>   
>   	pr_info("Partition%d reset!\n", priv->rproc_pt);
> @@ -916,7 +931,8 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>   		}
>   
>   		priv->rproc->state = RPROC_DETACHED;
> -		priv->rproc->recovery_disabled = true;
> +		priv->rproc->recovery_disabled = false;
> +		rproc_set_feature(priv->rproc, RPROC_FEAT_ATTACH_ON_RECOVERY);
>   
>   		/* Get partition id and enable irq in SCFW */
>   		ret = imx_sc_rm_get_resource_owner(priv->ipc_handle, priv->rsrc_id, &pt);
