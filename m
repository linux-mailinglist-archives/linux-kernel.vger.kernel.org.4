Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6535FBB86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJKTro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJKTrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:47:39 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F93C937B8;
        Tue, 11 Oct 2022 12:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVDmRTWDZADUNU0meb9gZYolg//2MDOTDfJUlbkVpDnZQ7CFHr+2SDvp/uc5sk1Yw/fsxZeQkDAWleZ0y6TIhlAwWC0WCNQtrFSARNMYou5u2fKs3Fxo+rIOyZOb+Zy4WRFHoJbU40e8mj7BkegPgWju5vCOP2o+yKCS2WJuYOZy0PMxZl4IFTkEELAxC1YbDZWo/NaOgoo1o7bsoSeEo5KVfE0yUbeuVwAacEGJzsFQQUUOGTzdEI2MVkUdo9BlvCIraQpPiTgPiMsPmqHCFjDOZ6FnzigHsysvuTi48tqTUjbts0tQAmJSNkYlLdTk6V9oDpYO9AK26EsMIHCMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6b6pooFmAo8mVLec7h1vYPF1DrKYBXMwyhtYqrABT0=;
 b=dns8f0eUpW46nyueV6faATE/Jw6npTHlgSrDH7qDY/TUtL8tSTH/zG6OaEbph9ERssC5rQu9bzlrnzX6Pcd7208Lm/rUMI8/Wsrsl6GW8ksDcRq9lKbdod/QfVY1y+xAjniZeBl2ZqyC4WDnm4FsGGPWReIXuEge6pUPBpF2Sp0xKwXUs0Dp5HpeKYw0cXzmydeejJs8i98e8M9NPTpVBIhN3/5Ssc3tng51d7GhuJRfBD5zecas2OyJ9rG5Ej1fFUyjhHP8pQe04sRDXNILOXqXbogIbih0yYexFVzJ9IT4Rf5oa/uilEtQAI6El7SVD6qaTaNL6/5AxRhdSal5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6b6pooFmAo8mVLec7h1vYPF1DrKYBXMwyhtYqrABT0=;
 b=jz38SZIBOsHU0vqqRfklYFML/Qe7a8SOB0+D3QQWcL/tqJa2lrZDu5yhLUlVpgb6nd7qtiYDZakK5JD4/NmTJ9Kdse4SBEfszwPDkbY8YHrk7sNUzhVCqYEt1UBWtmaEvJuyMcxbiQuz4h+jnYwVe8OgKbgHa/yJ7J1whP+ATtY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 19:47:30 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::a1ae:2f3c:6a54:fb24]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::a1ae:2f3c:6a54:fb24%4]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 19:47:30 +0000
Message-ID: <e0a6981e-3b6b-4f59-d0b6-b533dff386ca@oss.nxp.com>
Date:   Tue, 11 Oct 2022 22:47:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] media: imx-jpeg: Support contiguous and non
 contiguous format
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1664247957.git.ming.qian@nxp.com>
 <c2192eecac2a63c6c24d1cd5d35ee9d6a3503ec6.1664247957.git.ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <c2192eecac2a63c6c24d1cd5d35ee9d6a3503ec6.1664247957.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0002.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::14) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9244:EE_|DBBPR04MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: d000a487-8bd0-4bd0-95e3-08daabc16ea1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMpQ+o/SLXlS5EJsqIzU/B8mn5zozb2zuOU46cJ4tIROt9HEMdx2sQ19YNAQSuapJOlRDBRrYr36gKQWIN/S70jSnG+saDvxyNR0z5wFauW1jgOzlIwWYlHin+ypsvC99xis56cdkLVfpV7+SoVaNzH928H6Zp44EIT4BqFURvcA7oHCzi4cWyERvKjswwwYK/1AF2wC5d81MNeOEVojqcezyVssdtAyd/bzWjDnmDloDVN9nwj/qFjOPF6YsElvZ9A0UYGkUWXKHstsl3LntEJzQ+085PPAODQqyqBz79NmlKzEko3j5M7sVfo7r/64xxJ9HNC1n6BiFe+RGIJ0OfFBSYbaqARRRq2tVcbwSHeoK6DDEFwjozHw2tgezcH089PFzyJYO6OKMKFN5nRVJ4jSSGI+Yle/xj+57L5FGSRtWuqUBFsI9mpoACmn+duCPPvN3VJ5AJ7mmA0S3iONdtXpjYtoCNejl3FU9WVUazkieYjL7Y581n6Z9St5SZJUTTomaP3iYbKNWaaP2kYcJbtMDJ/zvBrKJVSCTt18ldX1gbp/37V4WYXpBJ2/uXYdodyUhxNjmRbcNQ9FMyLj0ANMU5eaiawBcXEcoh6EVWLtj3n0Q9VFUxjSVix1Q8a8KZW2jL52hCLNMTLZHo8Ky4tgstd+2Q6Hd4EsTxa1KgH9D7k4LEvDzyGaqAIctXmISCIEza6W1/G9ITx5onXKZAP2j7ttd2sz/GDMJ8p9iAsyjvmtfOEE63sAIF3ZsQHTIY0uz7uLR+SrmVVPRUXPZBxs/8VLhACdlthbWI/Hwh3r1+y42Q5iMUFtLytcXOivVVvfpZTYThD7OlInbu+KCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(31686004)(86362001)(31696002)(83380400001)(30864003)(5660300002)(7416002)(38100700002)(38350700002)(2616005)(186003)(53546011)(26005)(6506007)(6512007)(6666004)(41300700001)(52116002)(6486002)(478600001)(8676002)(316002)(66946007)(66556008)(66476007)(8936002)(2906002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnVObVVGK0dQZmtsWmRvQysxd0VGK0lvVm0xSWcyZGlJQnNNbzhjZitDWXAv?=
 =?utf-8?B?L3kveEZGSFQ1U0dqZ3ZvN3E3cUQxRE5YaSt0TUxEbkc0aHZVTTRndnpYRkxr?=
 =?utf-8?B?TWU3VWdMRS9JT1p6cmtqOEcveHJrZ09OQ0I5MHowN0FUTzVCaXhhSnBTZGJI?=
 =?utf-8?B?NmhpMjVkM1JETWdGeUtrV0FsRkhIN1hJNlhvN3UvUXRZK3hrUUY1WDNCaUdL?=
 =?utf-8?B?Uk95aVhGdXNWT3NvME91WXBxSGF6eUJzQUlpM1ZiU2JUdWFhSFN3WWt0TURC?=
 =?utf-8?B?SkRFdU1zZGhrNWo2R2JJSVNBcmpVY0FxM2FNQ1NIWENhektlK29CVHJ4TFBK?=
 =?utf-8?B?MnU4RFFKWnVvbkxaajZUZGJvaFhzMVRJMlphQ1J2KzhyUTFIcVdXc3NwaFp1?=
 =?utf-8?B?eHNqQllDd2xmQ2xSU3RoWEVXOHVHYXhqTUhjZVIrWVcxRm5KVVpJMnVNYXFI?=
 =?utf-8?B?a1lqN2NDVDA3SkkwR1Y3UjhmN09FSTU0S0pydUZBTHZpcjlkSVFIT0kxQmpN?=
 =?utf-8?B?VlJxc2FydlcrVHRsbko3UjNDTmZ1cmV3RTdWY0QzMTV4TjhSL1lBN2ExZlR6?=
 =?utf-8?B?ejlnb1ZHQkZBV0M1RGRHdEFZTmNEMnYwaGp1ZjBxVENLUkRHS3BKQU5haWxS?=
 =?utf-8?B?S1haMWdITzdlV0JVeGlRM2IvbWozVXZJVlVicmIvRVR0VjRaUlJXR04wejUy?=
 =?utf-8?B?T2ZUNUtveG9WT2E4VHEzNHFDOCtZV09qZ1lRYzJjeTVRQjhWaS8zMG8zenVm?=
 =?utf-8?B?QVo0OU1ybWRheWc0dzBXWEY2ZFNjMWRLTEZydlR0a0phTWxoVzR3V213S3Rt?=
 =?utf-8?B?bXlPVDRHOUtzYVdwbWZwQXVhTERxWWhQNmdybUdzTHRyNU5HKytYMk4wUVJI?=
 =?utf-8?B?a0dLVHhxWW01VVRCbnVHZkV5N3BwQXVCK2kvTlNWQStnY3BQa3hvTVdvMCsw?=
 =?utf-8?B?RkJqV2l2cXBFVnFqL1JDNDc1TUxHdTYxUERqRVVFd3NRNmRaSWJjSWkreUMv?=
 =?utf-8?B?WTJnVFA1SHlFVUJ3anM4ZFhHTk85K01QL0RpbWpERFFRNURySWVQYlg2RnRV?=
 =?utf-8?B?dCt0VTdFajVqWDZ0WC9rZEt1enpBOXA1b3YyWlVJRStpcHBkZklvd2lodmdn?=
 =?utf-8?B?bmNvbGlhdXpPZTFzb2l3dW5tcHZBL0QrQWMvdEhPaENsamxNSHBLRjZLY0ZL?=
 =?utf-8?B?emY3eEJNekdVZFZJZ3U5OXg5alVZRUNlUFF3ZURzYW16TktieWI0SndsUjQ5?=
 =?utf-8?B?QjNvNkdWUUhNQVJMbWpmemJxSC96UXVBbmdWZ1dNQ0lIeXowSlNNTzZkYUtr?=
 =?utf-8?B?U1JJTkxuamw3RE5TQlVsMkhSTFJpSUl1akY4TVhPMS84akxyY3VDNnNzbUlW?=
 =?utf-8?B?OTgxbjZwMUs0WU5sbE5lU1JZNW8weUpjTGJsV3BtMkY4cGxxc1hNcHEwaVZr?=
 =?utf-8?B?ajJ0NVRBZDRPRGpqUmlHV3hUZThYTzVLY25yNFpDQ3VLOCsyMjZwdXFwVDJZ?=
 =?utf-8?B?MDNwM0lEYTBONzB3NkFQMTdXaXF1eFNQaVNIZUcwWXJlQ3dHTlN5aEovM2FB?=
 =?utf-8?B?c0ZhaEZoWUVFVi9uREdacTI4cldJSHZzVnJJRFQ2bm0zQ1l6REhqWFJyeTdz?=
 =?utf-8?B?bUx1QnN4Z0lhbmZMUEVvQ0R2WnYwSDVrY0JXTUV6Wk5wNkF2K05sTkJDQ0RH?=
 =?utf-8?B?MUdFY1llellzTlJUWkp2YWZtZFhnZ0hyQk9nTm5iR3UrYkRyazRZWHk2cWV3?=
 =?utf-8?B?VkVXM3JDektieUIwNkIzcHdlTzZ0b0hCM1NKQnVkcVk2ckp5OTBVazNEcDhr?=
 =?utf-8?B?SjY5NWd6dUZwdHBRZy9pL1JuSlpOWm1aSlVveE9ZOHY0NTgwZU1kWFdqbDdK?=
 =?utf-8?B?dVpGNnIwT1pJUTFYNGFEWDhhaTYrUFhJMVBwT25CRjBmd2VHVG9uV2lUb2lj?=
 =?utf-8?B?OU5OT2x6T0hCOUVuZ0E0WEhjNzd1a2FGMnUzQ2wvdEFoVmF2ZXRPeFpuT1I4?=
 =?utf-8?B?UXBleTVSSDdzS1dTNndxck1jMmdZWXRLLzRoSktldnlqYUJwNzdVU0w4bDk0?=
 =?utf-8?B?T1pYRHVJSDROUTc0MWR2ZGNDVlA0UkpSaHB0ZEJvVng5L21jWC9VYVJaRllE?=
 =?utf-8?B?cDJwbzlUazgzTmlGMmtFcjk2OExtTUtaR1h5Z1M1VFgvU0NPNTUrdno2cW5i?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d000a487-8bd0-4bd0-95e3-08daabc16ea1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 19:47:30.0718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLlIl5XF3mYxBpx4zXwq7K49rUFwI14EjswZxK1F4oz+FYmFB4yVdfXIiMC1rnl19VwGXL0uBeQlxzeNqdCL5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.09.2022 06:12, Ming Qian wrote:
> mxc-jpeg supports non contiguous format nv12m,
> and in order to compatible with the devices
> that only support contiguous format nv12,
> jpeg can support nv12 and nv12m in the same time.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
Tested-by: Mirela Rabulea <mirela.rabulea@nxp.com>

> ---
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 226 ++++++++++++++----
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   7 +-
>   2 files changed, 185 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 1bbf560a6341..510d71a2b48f 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -69,7 +69,8 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
>   		.fourcc		= V4L2_PIX_FMT_JPEG,
>   		.subsampling	= -1,
>   		.nc		= -1,
> -		.colplanes	= 1,
> +		.mem_planes	= 1,
> +		.comp_planes	= 1,
>   		.flags		= MXC_JPEG_FMT_TYPE_ENC,
>   	},
>   	{
> @@ -78,11 +79,13 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
>   		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
>   		.nc		= 3,
>   		.depth		= 24,
> -		.colplanes	= 1,
> +		.mem_planes	= 1,
> +		.comp_planes	= 1,
>   		.h_align	= 3,
>   		.v_align	= 3,
>   		.flags		= MXC_JPEG_FMT_TYPE_RAW,
>   		.precision	= 8,
> +		.is_rgb		= 1,
>   	},
>   	{
>   		.name		= "ABGR", /* ABGR packed format */
> @@ -90,11 +93,13 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
>   		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
>   		.nc		= 4,
>   		.depth		= 32,
> -		.colplanes	= 1,
> +		.mem_planes	= 1,
> +		.comp_planes	= 1,
>   		.h_align	= 3,
>   		.v_align	= 3,
>   		.flags		= MXC_JPEG_FMT_TYPE_RAW,
>   		.precision	= 8,
> +		.is_rgb		= 1,
>   	},
>   	{
>   		.name		= "YUV420", /* 1st plane = Y, 2nd plane = UV */
> @@ -102,7 +107,21 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
>   		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_420,
>   		.nc		= 3,
>   		.depth		= 12, /* 6 bytes (4Y + UV) for 4 pixels */
> -		.colplanes	= 2, /* 1 plane Y, 1 plane UV interleaved */
> +		.mem_planes	= 2,
> +		.comp_planes	= 2, /* 1 plane Y, 1 plane UV interleaved */
> +		.h_align	= 4,
> +		.v_align	= 4,
> +		.flags		= MXC_JPEG_FMT_TYPE_RAW,
> +		.precision	= 8,
> +	},
> +	{
> +		.name		= "YUV420", /* 1st plane = Y, 2nd plane = UV */
> +		.fourcc		= V4L2_PIX_FMT_NV12,
> +		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_420,
> +		.nc		= 3,
> +		.depth		= 12, /* 6 bytes (4Y + UV) for 4 pixels */
> +		.mem_planes	= 1,
> +		.comp_planes	= 2, /* 1 plane Y, 1 plane UV interleaved */
>   		.h_align	= 4,
>   		.v_align	= 4,
>   		.flags		= MXC_JPEG_FMT_TYPE_RAW,
> @@ -114,7 +133,8 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
>   		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_422,
>   		.nc		= 3,
>   		.depth		= 16,
> -		.colplanes	= 1,
> +		.mem_planes	= 1,
> +		.comp_planes	= 1,
>   		.h_align	= 4,
>   		.v_align	= 3,
>   		.flags		= MXC_JPEG_FMT_TYPE_RAW,
> @@ -126,7 +146,8 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
>   		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
>   		.nc		= 3,
>   		.depth		= 24,
> -		.colplanes	= 1,
> +		.mem_planes	= 1,
> +		.comp_planes	= 1,
>   		.h_align	= 3,
>   		.v_align	= 3,
>   		.flags		= MXC_JPEG_FMT_TYPE_RAW,
> @@ -138,7 +159,8 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
>   		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_GRAY,
>   		.nc		= 1,
>   		.depth		= 8,
> -		.colplanes	= 1,
> +		.mem_planes	= 1,
> +		.comp_planes	= 1,
>   		.h_align	= 3,
>   		.v_align	= 3,
>   		.flags		= MXC_JPEG_FMT_TYPE_RAW,
> @@ -419,6 +441,7 @@ static enum mxc_jpeg_image_format mxc_jpeg_fourcc_to_imgfmt(u32 fourcc)
>   		return MXC_JPEG_GRAY;
>   	case V4L2_PIX_FMT_YUYV:
>   		return MXC_JPEG_YUV422;
> +	case V4L2_PIX_FMT_NV12:
>   	case V4L2_PIX_FMT_NV12M:
>   		return MXC_JPEG_YUV420;
>   	case V4L2_PIX_FMT_YUV24:
> @@ -445,12 +468,17 @@ static void mxc_jpeg_addrs(struct mxc_jpeg_desc *desc,
>   			   struct vb2_buffer *jpeg_buf, int offset)
>   {
>   	int img_fmt = desc->stm_ctrl & STM_CTRL_IMAGE_FORMAT_MASK;
> +	struct mxc_jpeg_ctx *ctx = vb2_get_drv_priv(raw_buf->vb2_queue);
> +	struct mxc_jpeg_q_data *q_data;
>   
> +	q_data = mxc_jpeg_get_q_data(ctx, raw_buf->type);
>   	desc->buf_base0 = vb2_dma_contig_plane_dma_addr(raw_buf, 0);
>   	desc->buf_base1 = 0;
>   	if (img_fmt == STM_CTRL_IMAGE_FORMAT(MXC_JPEG_YUV420)) {
> -		WARN_ON(raw_buf->num_planes < 2);
> -		desc->buf_base1 = vb2_dma_contig_plane_dma_addr(raw_buf, 1);
> +		if (raw_buf->num_planes == 2)
> +			desc->buf_base1 = vb2_dma_contig_plane_dma_addr(raw_buf, 1);
> +		else
> +			desc->buf_base1 = desc->buf_base0 + q_data->sizeimage[0];
>   	}
>   	desc->stm_bufbase = vb2_dma_contig_plane_dma_addr(jpeg_buf, 0) +
>   		offset;
> @@ -594,6 +622,28 @@ static void mxc_jpeg_job_finish(struct mxc_jpeg_ctx *ctx, enum vb2_buffer_state
>   		mxc_jpeg_sw_reset(reg);
>   }
>   
> +static u32 mxc_jpeg_get_plane_size(struct mxc_jpeg_q_data *q_data, u32 plane_no)
> +{
> +	const struct mxc_jpeg_fmt *fmt = q_data->fmt;
> +	u32 size;
> +	int i;
> +
> +	if (plane_no >= fmt->mem_planes)
> +		return 0;
> +
> +	if (fmt->mem_planes == fmt->comp_planes)
> +		return q_data->sizeimage[plane_no];
> +
> +	if (plane_no < fmt->mem_planes - 1)
> +		return q_data->sizeimage[plane_no];
> +
> +	size = q_data->sizeimage[fmt->mem_planes - 1];
> +	for (i = fmt->mem_planes; i < fmt->comp_planes; i++)
> +		size += q_data->sizeimage[i];
> +
> +	return size;
> +}
> +
>   static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
>   {
>   	struct mxc_jpeg_dev *jpeg = priv;
> @@ -673,11 +723,11 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
>   			payload);
>   	} else {
>   		q_data = mxc_jpeg_get_q_data(ctx, cap_type);
> -		payload = q_data->sizeimage[0];
> +		payload = mxc_jpeg_get_plane_size(q_data, 0);
>   		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, payload);
>   		vb2_set_plane_payload(&dst_buf->vb2_buf, 1, 0);
> -		if (q_data->fmt->colplanes == 2) {
> -			payload = q_data->sizeimage[1];
> +		if (q_data->fmt->mem_planes == 2) {
> +			payload = mxc_jpeg_get_plane_size(q_data, 1);
>   			vb2_set_plane_payload(&dst_buf->vb2_buf, 1, payload);
>   		}
>   		dev_dbg(dev, "Decoding finished, payload size: %ld + %ld\n",
> @@ -716,6 +766,7 @@ static int mxc_jpeg_fixup_sof(struct mxc_jpeg_sof *sof,
>   	_bswap16(&sof->width);
>   
>   	switch (fourcc) {
> +	case V4L2_PIX_FMT_NV12:
>   	case V4L2_PIX_FMT_NV12M:
>   		sof->components_no = 3;
>   		sof->comp[0].v = 0x2;
> @@ -752,6 +803,7 @@ static int mxc_jpeg_fixup_sos(struct mxc_jpeg_sos *sos,
>   	u8 *sof_u8 = (u8 *)sos;
>   
>   	switch (fourcc) {
> +	case V4L2_PIX_FMT_NV12:
>   	case V4L2_PIX_FMT_NV12M:
>   		sos->components_no = 3;
>   		break;
> @@ -967,6 +1019,32 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
>   	mxc_jpeg_set_desc(cfg_desc_handle, reg, slot);
>   }
>   
> +static const struct mxc_jpeg_fmt *mxc_jpeg_get_sibling_format(const struct mxc_jpeg_fmt *fmt)
> +{
> +	int i;
> +
> +	for (i = 0; i < MXC_JPEG_NUM_FORMATS; i++) {
> +		if (mxc_formats[i].subsampling == fmt->subsampling &&
> +		    mxc_formats[i].nc == fmt->nc &&
> +		    mxc_formats[i].precision == fmt->precision &&
> +		    mxc_formats[i].is_rgb == fmt->is_rgb &&
> +		    mxc_formats[i].fourcc != fmt->fourcc)
> +			return &mxc_formats[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static bool mxc_jpeg_compare_format(const struct mxc_jpeg_fmt *fmt1,
> +				    const struct mxc_jpeg_fmt *fmt2)
> +{
> +	if (fmt1 == fmt2)
> +		return true;
> +	if (mxc_jpeg_get_sibling_format(fmt1) == fmt2)
> +		return true;
> +	return false;
> +}
> +
>   static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
>   				   struct mxc_jpeg_src_buf *jpeg_src_buf)
>   {
> @@ -977,6 +1055,8 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
>   		return false;
>   
>   	q_data_cap = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
> +	if (mxc_jpeg_compare_format(q_data_cap->fmt, jpeg_src_buf->fmt))
> +		jpeg_src_buf->fmt = q_data_cap->fmt;
>   	if (q_data_cap->fmt != jpeg_src_buf->fmt ||
>   	    q_data_cap->w != jpeg_src_buf->w ||
>   	    q_data_cap->h != jpeg_src_buf->h) {
> @@ -1081,9 +1161,9 @@ static void mxc_jpeg_device_run(void *priv)
>   	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
>   
>   	jpeg_src_buf = vb2_to_mxc_buf(&src_buf->vb2_buf);
> -	if (q_data_cap->fmt->colplanes != dst_buf->vb2_buf.num_planes) {
> +	if (q_data_cap->fmt->mem_planes != dst_buf->vb2_buf.num_planes) {
>   		dev_err(dev, "Capture format %s has %d planes, but capture buffer has %d planes\n",
> -			q_data_cap->fmt->name, q_data_cap->fmt->colplanes,
> +			q_data_cap->fmt->name, q_data_cap->fmt->mem_planes,
>   			dst_buf->vb2_buf.num_planes);
>   		jpeg_src_buf->jpeg_parse_error = true;
>   	}
> @@ -1216,19 +1296,19 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
>   
>   	/* Handle CREATE_BUFS situation - *nplanes != 0 */
>   	if (*nplanes) {
> -		if (*nplanes != q_data->fmt->colplanes)
> +		if (*nplanes != q_data->fmt->mem_planes)
>   			return -EINVAL;
>   		for (i = 0; i < *nplanes; i++) {
> -			if (sizes[i] < q_data->sizeimage[i])
> +			if (sizes[i] < mxc_jpeg_get_plane_size(q_data, i))
>   				return -EINVAL;
>   		}
>   		return 0;
>   	}
>   
>   	/* Handle REQBUFS situation */
> -	*nplanes = q_data->fmt->colplanes;
> +	*nplanes = q_data->fmt->mem_planes;
>   	for (i = 0; i < *nplanes; i++)
> -		sizes[i] = q_data->sizeimage[i];
> +		sizes[i] = mxc_jpeg_get_plane_size(q_data, i);
>   
>   	return 0;
>   }
> @@ -1313,19 +1393,40 @@ static int mxc_jpeg_valid_comp_id(struct device *dev,
>   	return valid;
>   }
>   
> +static bool mxc_jpeg_match_image_format(const struct mxc_jpeg_fmt *fmt,
> +					const struct v4l2_jpeg_header *header)
> +{
> +	if (fmt->subsampling != header->frame.subsampling ||
> +	    fmt->nc != header->frame.num_components ||
> +	    fmt->precision != header->frame.precision)
> +		return false;
> +
> +	/*
> +	 * If the transform flag from APP14 marker is 0, images that are
> +	 * encoded with 3 components have RGB colorspace, see Recommendation
> +	 * ITU-T T.872 chapter 6.5.3 APP14 marker segment for colour encoding
> +	 */
> +	if (header->frame.subsampling == V4L2_JPEG_CHROMA_SUBSAMPLING_444) {
> +		u8 is_rgb = header->app14_tf == V4L2_JPEG_APP14_TF_CMYK_RGB ? 1 : 0;
> +
> +		if (is_rgb != fmt->is_rgb)
> +			return false;
> +	}
> +	return true;
> +}
> +
>   static u32 mxc_jpeg_get_image_format(struct device *dev,
>   				     const struct v4l2_jpeg_header *header)
>   {
>   	int i;
>   	u32 fourcc = 0;
>   
> -	for (i = 0; i < MXC_JPEG_NUM_FORMATS; i++)
> -		if (mxc_formats[i].subsampling == header->frame.subsampling &&
> -		    mxc_formats[i].nc == header->frame.num_components &&
> -		    mxc_formats[i].precision == header->frame.precision) {
> +	for (i = 0; i < MXC_JPEG_NUM_FORMATS; i++) {
> +		if (mxc_jpeg_match_image_format(&mxc_formats[i], header)) {
>   			fourcc = mxc_formats[i].fourcc;
>   			break;
>   		}
> +	}
>   	if (fourcc == 0) {
>   		dev_err(dev,
>   			"Could not identify image format nc=%d, subsampling=%d, precision=%d\n",
> @@ -1334,17 +1435,6 @@ static u32 mxc_jpeg_get_image_format(struct device *dev,
>   			header->frame.precision);
>   		return fourcc;
>   	}
> -	/*
> -	 * If the transform flag from APP14 marker is 0, images that are
> -	 * encoded with 3 components have RGB colorspace, see Recommendation
> -	 * ITU-T T.872 chapter 6.5.3 APP14 marker segment for colour encoding
> -	 */
> -	if (fourcc == V4L2_PIX_FMT_YUV24 || fourcc == V4L2_PIX_FMT_BGR24) {
> -		if (header->app14_tf == V4L2_JPEG_APP14_TF_CMYK_RGB)
> -			fourcc = V4L2_PIX_FMT_BGR24;
> -		else
> -			fourcc = V4L2_PIX_FMT_YUV24;
> -	}
>   
>   	return fourcc;
>   }
> @@ -1392,7 +1482,7 @@ static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q)
>   	} else {
>   		q->sizeimage[0] = q->bytesperline[0] * q->h_adjusted;
>   		q->sizeimage[1] = 0;
> -		if (q->fmt->fourcc == V4L2_PIX_FMT_NV12M)
> +		if (q->fmt->subsampling == V4L2_JPEG_CHROMA_SUBSAMPLING_420)
>   			q->sizeimage[1] = q->sizeimage[0] / 2;
>   	}
>   }
> @@ -1401,6 +1491,7 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
>   {
>   	struct device *dev = ctx->mxc_jpeg->dev;
>   	struct mxc_jpeg_q_data *q_data_out;
> +	struct mxc_jpeg_q_data *q_data_cap;
>   	u32 fourcc;
>   	struct v4l2_jpeg_header header;
>   	struct mxc_jpeg_sof *psof = NULL;
> @@ -1458,7 +1549,11 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
>   	if (!mxc_jpeg_valid_comp_id(dev, psof, psos))
>   		dev_warn(dev, "JPEG component ids should be 0-3 or 1-4");
>   
> -	fourcc = mxc_jpeg_get_image_format(dev, &header);
> +	q_data_cap = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> +	if (q_data_cap->fmt && mxc_jpeg_match_image_format(q_data_cap->fmt, &header))
> +		fourcc = q_data_cap->fmt->fourcc;
> +	else
> +		fourcc = mxc_jpeg_get_image_format(dev, &header);
>   	if (fourcc == 0)
>   		return -EINVAL;
>   
> @@ -1534,8 +1629,8 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *vb)
>   	q_data = mxc_jpeg_get_q_data(ctx, vb->vb2_queue->type);
>   	if (!q_data)
>   		return -EINVAL;
> -	for (i = 0; i < q_data->fmt->colplanes; i++) {
> -		sizeimage = q_data->sizeimage[i];
> +	for (i = 0; i < q_data->fmt->mem_planes; i++) {
> +		sizeimage = mxc_jpeg_get_plane_size(q_data, i);
>   		if (vb2_plane_size(vb, i) < sizeimage) {
>   			dev_err(dev, "plane %d too small (%lu < %lu)",
>   				i, vb2_plane_size(vb, i), sizeimage);
> @@ -1762,10 +1857,25 @@ static int mxc_jpeg_enum_fmt_vid_cap(struct file *file, void *priv,
>   		 * (more precisely what was propagated on capture queue
>   		 * after jpeg parse on the output buffer)
>   		 */
> -		if (f->index)
> -			return -EINVAL;
> -		f->pixelformat = q_data->fmt->fourcc;
> -		return 0;
> +		int ret = -EINVAL;
> +		const struct mxc_jpeg_fmt *sibling;
> +
> +		switch (f->index) {
> +		case 0:
> +			f->pixelformat = q_data->fmt->fourcc;
> +			ret = 0;
> +			break;
> +		case 1:
> +			sibling = mxc_jpeg_get_sibling_format(q_data->fmt);
> +			if (sibling) {
> +				f->pixelformat = sibling->fourcc;
> +				ret = 0;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +		return ret;
>   	}
>   }
>   
> @@ -1801,6 +1911,27 @@ static u32 mxc_jpeg_get_default_fourcc(struct mxc_jpeg_ctx *ctx, u32 type)
>   		return V4L2_TYPE_IS_CAPTURE(type) ? V4L2_PIX_FMT_JPEG : MXC_JPEG_DEFAULT_PFMT;
>   }
>   
> +static u32 mxc_jpeg_try_fourcc(struct mxc_jpeg_ctx *ctx, u32 fourcc)
> +{
> +	const struct mxc_jpeg_fmt *sibling;
> +	struct mxc_jpeg_q_data *q_data_cap;
> +
> +	if (ctx->mxc_jpeg->mode != MXC_JPEG_DECODE)
> +		return fourcc;
> +	if (!ctx->header_parsed)
> +		return fourcc;
> +
> +	q_data_cap = &ctx->cap_q;
> +	if (q_data_cap->fmt->fourcc == fourcc)
> +		return fourcc;
> +
> +	sibling = mxc_jpeg_get_sibling_format(q_data_cap->fmt);
> +	if (sibling && sibling->fourcc == fourcc)
> +		return sibling->fourcc;
> +
> +	return q_data_cap->fmt->fourcc;
> +}
> +
>   static int mxc_jpeg_try_fmt(struct v4l2_format *f,
>   			    struct mxc_jpeg_ctx *ctx, struct mxc_jpeg_q_data *q_data)
>   {
> @@ -1831,7 +1962,7 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f,
>   
>   	memset(pix_mp->reserved, 0, sizeof(pix_mp->reserved));
>   	pix_mp->field = V4L2_FIELD_NONE;
> -	pix_mp->num_planes = fmt->colplanes;
> +	pix_mp->num_planes = fmt->mem_planes;
>   	pix_mp->pixelformat = fmt->fourcc;
>   
>   	q_data->w = w;
> @@ -1862,7 +1993,7 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f,
>   		pfmt = &pix_mp->plane_fmt[i];
>   		memset(pfmt->reserved, 0, sizeof(pfmt->reserved));
>   		pfmt->bytesperline = q_data->bytesperline[i];
> -		pfmt->sizeimage = q_data->sizeimage[i];
> +		pfmt->sizeimage = mxc_jpeg_get_plane_size(q_data, i);
>   	}
>   
>   	/* fix colorspace information to sRGB for both output & capture */
> @@ -1902,6 +2033,9 @@ static int mxc_jpeg_try_fmt_vid_cap(struct file *file, void *priv,
>   		return -EINVAL;
>   	}
>   
> +	if (ctx->mxc_jpeg->mode != MXC_JPEG_DECODE && V4L2_TYPE_IS_CAPTURE(f->type))
> +		f->fmt.pix_mp.pixelformat = mxc_jpeg_try_fourcc(ctx, f->fmt.pix_mp.pixelformat);
> +
>   	return mxc_jpeg_try_fmt(f, ctx, &tmp_q);
>   }
>   
> @@ -1932,7 +2066,7 @@ static void mxc_jpeg_s_parsed_fmt(struct mxc_jpeg_ctx *ctx, struct v4l2_format *
>   		return;
>   
>   	q_data_cap = mxc_jpeg_get_q_data(ctx, f->type);
> -	pix_mp->pixelformat = q_data_cap->fmt->fourcc;
> +	pix_mp->pixelformat = mxc_jpeg_try_fourcc(ctx, pix_mp->pixelformat);
>   	pix_mp->width = q_data_cap->w;
>   	pix_mp->height = q_data_cap->h;
>   }
> @@ -2029,10 +2163,10 @@ static int mxc_jpeg_g_fmt_vid(struct file *file, void *priv,
>   	pix_mp->xfer_func = V4L2_XFER_FUNC_SRGB;
>   	pix_mp->quantization = V4L2_QUANTIZATION_FULL_RANGE;
>   
> -	pix_mp->num_planes = q_data->fmt->colplanes;
> +	pix_mp->num_planes = q_data->fmt->mem_planes;
>   	for (i = 0; i < pix_mp->num_planes; i++) {
>   		pix_mp->plane_fmt[i].bytesperline = q_data->bytesperline[i];
> -		pix_mp->plane_fmt[i].sizeimage = q_data->sizeimage[i];
> +		pix_mp->plane_fmt[i].sizeimage = mxc_jpeg_get_plane_size(q_data, i);
>   	}
>   
>   	return 0;
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> index f75dfc89ff6d..660dcaca8658 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> @@ -45,7 +45,8 @@ enum mxc_jpeg_mode {
>    * @subsampling: subsampling of jpeg components
>    * @nc:		number of color components
>    * @depth:	number of bits per pixel
> - * @colplanes:	number of color planes (1 for packed formats)
> + * @mem_planes:	number of memory planes (1 for packed formats)
> + * @comp_planes:number of component planes, which includes the alpha plane (1 to 4).
>    * @h_align:	horizontal alignment order (align to 2^h_align)
>    * @v_align:	vertical alignment order (align to 2^v_align)
>    * @flags:	flags describing format applicability
> @@ -57,11 +58,13 @@ struct mxc_jpeg_fmt {
>   	enum v4l2_jpeg_chroma_subsampling	subsampling;
>   	int					nc;
>   	int					depth;
> -	int					colplanes;
> +	int					mem_planes;
> +	int					comp_planes;
>   	int					h_align;
>   	int					v_align;
>   	u32					flags;
>   	u8					precision;
> +	u8					is_rgb;
>   };
>   
>   struct mxc_jpeg_desc {
