Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1025FBB80
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJKTrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJKTrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:47:14 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD65060515;
        Tue, 11 Oct 2022 12:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghcyRhZtHVZ+eOsHCwT6TK3YYu+yuQBw4ppCjkEkrL6JPxT41Sns+7tUoC6bXoNM0L3Q4ONF5qAc0sPnMiTEpWNY0oZ2ZRpMdGDygl02S4/1iKViJ+7PKOG52jaYKJGCE+pYyohtGw18p3/xmUm0VHhdGPuzLerd6yXplxenRouWbSXaxoNMw53avT1TNE7FD7Sjum7lofhVmPWPlmY05Gyh4pJcjC2nIIkZIbmNwyOR4BHjst0CbdQHkwALgAE2p4pFeDUZ7Jaz1TB+6BAdKPhpjPFFsvsrNUu+GHXtTJsZfNKCpqY8TXjHrzhHOt2dYgsV8aPWBnhIZWU5eJXhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qu+Wvq/+DouBPiolvrqIfq3ko5+jXl30IYBOOU178GY=;
 b=dZ3XcOnWBDMDh9YSQvr53/GaLcP6Sa0Q1y2U9ufLOZgXyAz5YqAoyK9Kb0JEeRTYw6IjdqmsCRedd+jgTa/XOZksYSzEH5ab5lAAX5/0Pj94jvdsD8jviseCAy3KT4xn6jOjck7ytnrTZ353JPAFXSCY0z181WxkML7pyhfEUy7AhKtSOGdB86W+FmT3w/MROoDLk+TuZdXvR4a0lN4GmRhOAVBa8vZ0eUd/SlNpwuNLhgTAORDbyFmr9kXy5kp9u0P/zKowSIUXpctZUX+K8kGNV7aSXRwfRrUAM19Yh5xDyQxpi0Yy1hB9SoTZkYjqCYyXRjm62dYjGzWBr4eD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu+Wvq/+DouBPiolvrqIfq3ko5+jXl30IYBOOU178GY=;
 b=URhbh1aMcR8cIH2NL2g9XU+EhyPu5WEPH969/ciCiBkNoIR1FjoSvhvIp26c9gNERC1Mi2Zrqatz3njsDrhdvZm6kxXp96FGI9flWrX93E+YWpWO4CeeaG8Am9+kDyujfugAz5vFcb5Qvf1S0rBPP0GDWcq8KdNq7TAzL2X4Qtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 19:47:08 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::a1ae:2f3c:6a54:fb24]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::a1ae:2f3c:6a54:fb24%4]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 19:47:07 +0000
Message-ID: <2352fd90-6a0b-dad7-e4d8-dd4519635f34@oss.nxp.com>
Date:   Tue, 11 Oct 2022 22:47:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/2] media: imx-jpeg: Implement g_selection and
 s_selection
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1664247957.git.ming.qian@nxp.com>
 <8a97ec549df3a8a6df7e52bf7174d91bdacb4ddc.1664247957.git.ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <8a97ec549df3a8a6df7e52bf7174d91bdacb4ddc.1664247957.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0006.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::18) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9244:EE_|DBBPR04MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: cefc1a05-b828-45e5-874c-08daabc16138
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DoPACs6eVbK/OBwj/ZdNC1PqGSYZ64Zv61qFY2hk0E2ZPdvQGTSh4E/c8qRPQ3MQaha0LaHHaC5xjk33fpLMhkvcCxxfrgnddp3NGFoHENP0VY+Lsodt2bKNhYrKj6HdbRIPG/KhL2l+ZbOEwUEd6ObmtDCQUP44nrtGhi46pKcxeHKx+Q95MvGHVY9O97ZjJ2ms5XXcJR/0ISXYjtp6EGbpYpwEEXkBbg7jl9ad+fnC32mfrWC9mxfsBsIn66SH7g9fULWAySYyHF81f4GZbCU92bGFS4BMNk6RbWQ6YLgG2+UbQoBewaBvXdCpfRtm5WjKJtv2OduP8B3s1NKxCz3PDi0Xdirlm8ISIekVTTkcCqVg4tPmeJ94suxL8EwPKLHBmFIXM+mQsTtJHlN3rLnIkH4okIzTsdqsWa4eAT694hdfpVz+tcC7KMmw18sYLxdBSP4fPMfsveFBMgbpg/DELVnm0ziHMuP5TO1LzlXI9HlJ903lxNeIeNAlpgPRDh3ca9ZQM4RgqWlIj7nxV7sgow7dsvYtauy/4H8GxrZOXZHjpL3hl+B0g8oB6ckifo9p8/TvA5uaM1BAarM/5iYmiYdSCsqC++umt8mdzhZ1Hnt8hH4nOe2/mEWUTRFDUlCTHQwmvqKSCHTolOVcQNp0CGA7LNH6b7CCn9G2sdGyqkShwz1sMJY4F71JzmLCztqxSqyedxR8T96LCe+1odWQn37/H9ZRzyRLPQpdpsdeTXGPNh87ucnp8Tn6sg7SNmOZoEBYs4QdFs7DCIsUWXWO3n76tYdtioOzcKeccZeVZhmhKqb0Q/ESx37gDE0h3wlZLXMjvn80PfY3nAG/ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(31686004)(66899015)(86362001)(31696002)(83380400001)(30864003)(5660300002)(7416002)(38100700002)(38350700002)(2616005)(186003)(53546011)(26005)(6506007)(6512007)(6666004)(41300700001)(52116002)(6486002)(478600001)(8676002)(316002)(66946007)(66556008)(66476007)(8936002)(2906002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDI5cWM5dmN2SnZaSzJhc0R1RlEwWU1pUHNTa3FhcWZSMkt4NlllREorcWFP?=
 =?utf-8?B?RzhRMXRKSGNRMU5VeE81VVdQT01tRWd0NU40Yll0UmtQdFBzb3Y2UFlGS0pO?=
 =?utf-8?B?NUtjL0dXUzYrd25FYjNTMDR6bjNtbysxWTExb21YclgwT0tRSzVhdkp5WkFt?=
 =?utf-8?B?YXp5cTdBSWtUczZTSm01c0U2K3ovK2JDNmlXTXNLUlI5NnNqbnVNUlYxQXh0?=
 =?utf-8?B?cXgrT2NIeEZ0Tm04c2VlTU9oUlZHOUxvc01nZlVvUHU5ZzdZL2JhUGdDaGgz?=
 =?utf-8?B?bjgwVGlRRHZ6eFFZbjdZa1l0QmdDekJ3OGJmM0RuL091YnhuUHJBQ1VzR3or?=
 =?utf-8?B?NCt4VVdSSFV2dGxKN1NMRFd0M2wzMDhVbUw0MWdWMm5nQUViS2JFV3NjUklp?=
 =?utf-8?B?a29FN250MHV0QkNGeUtvakNhOTMyaVNOblZlMEdXdTFFaXMvdXUrNlhMK2VJ?=
 =?utf-8?B?bTZLZmwwZVVjWmlOeU1iaVdaU1gwK1lpNzlrd3dtOXVFNEdSODBsdWZGcnFa?=
 =?utf-8?B?VUVYeXE2ZHJZbzZQUk5Nek00bldHbU1Oci9LbFVQU3pxdWZIVEZOZ010aUJi?=
 =?utf-8?B?NEoyU0dtdTdMdlpSZTJWWlBncFJlaU5FdmNnRnV1SXZDeGFhN3ZLZDdQb25u?=
 =?utf-8?B?dnB5dlEvMXh2eTVHdHpuL0plUDVTYWFkcFZqNlBXd1NMN283MnVBVlEyTTgw?=
 =?utf-8?B?dlpuUEJxL2pZNlpLeDJLRldkM3UyM1ZkZ3RkWE52cFQzV09mamZIdFZReFBO?=
 =?utf-8?B?bStRbGU1bWdzYm9DL291cWhVekFic3hNUXRqWk1kejMxQVRwdkNPMFB0S0xF?=
 =?utf-8?B?Vlg5RSs5UkQwMTBVYys4aVQ3K2h2amtNK0FLY2JiUFRCNkI5bWphS01lOEI5?=
 =?utf-8?B?aEFuQ1FsMTVUZkFFRUlWRW12ekJWSzdoN0M4VWs2RS9WVlo2UkdONG5MMW0w?=
 =?utf-8?B?bVN6SUxSTTBCTDZhbGd1Y0ZiaDVZNS9PTksxT2ZxRDYvakpTT1lnNzQ5V3lz?=
 =?utf-8?B?TnhIMU5uYTlVeiswaXF6TVM0bDR3YTg1cnRJdCtEWCtUcGJUUVlvYmhoYVIw?=
 =?utf-8?B?cEk5RTJxNE1yK2M0Y3M1dU1rYWs0dkNIYjhpQll4dXdnMjFvYmdlaUQ0MThE?=
 =?utf-8?B?NVpPZjIveFE2ZU92N2xRcEZ4NjJma2MzdTFsL3NwOW5vY1NOSU5DNXZEUjhQ?=
 =?utf-8?B?VWJvaGU0dmt0V1hvSWQzcHU0eVFpOHI1b29LQkpCRWtIRXgzeU91aE5DOW56?=
 =?utf-8?B?Q05KcW1BejE1cGZkdVBZaGl5K3RVWS8vZXJ4bzBENUtaLzdyWEY4dzJYRE5t?=
 =?utf-8?B?ak1ZK2hmSE16WjlTa1ZDT01EeW85cXVZS1FUQ29VV21qd094VUhsVGNFcU5q?=
 =?utf-8?B?NlBRYWVJbUozbWY0NmV3MTZJVEpvcW93WkUyWkliRDU5T2FFYjg2TmFIYlFP?=
 =?utf-8?B?OWRhMjl4WmhPZWlDQ21EN3YyMDhGUjRuQjNkbG9tOHpucDJDQUNTT05xVCtt?=
 =?utf-8?B?eWxuUTZIWEtVYUhzN1FvNFgrWndpcVc1U0w4YXlhdyt4Q3Nib1lXWDUvalFI?=
 =?utf-8?B?aU5tSlh5SjFRVUJ6TjdOOGo4WUNDUzNrcXZpQ1BFMUFNZFhUaEJRV2tiR1NI?=
 =?utf-8?B?UzZublpnWWN3WmFxWmJSKzVKeXdwY2IyUjlQM2ZUSWlqRTVPRlc4emdEZEhw?=
 =?utf-8?B?d3AySU45NHREMk5qNmhsZTVsRTQvdkY2cXRhT2NTV1NCZTRpTjkxclByN2sv?=
 =?utf-8?B?YjBIbFlpbUVTYWZmMnJjTXBsNWI5bGc4RjBEaFQzR1Q5dTEwMEpvdkp4d3pm?=
 =?utf-8?B?cC9sZHFGdndPTStwVU56aDRvdFh2bFFSUDk3cTVjWEtxckRsQVFld1BlaElh?=
 =?utf-8?B?RENoZjdMcThDOWxDbHoxSzBNV3F6bUZ5clNGczNBR28wZkhlTCtIQi83TEVp?=
 =?utf-8?B?eFljYWxQcC9LUFBnME9IbVdGUVNQZkUrWVlodWdKT3p1amU0VTJjUUlGNGRp?=
 =?utf-8?B?bWxKRVlvdTBVQWU0N0dyeXZ2Wmh4aGE4Q2JaMnR5NURZSUJ4clQ2ZXgyZzl1?=
 =?utf-8?B?WEJhNm9XaWgvSEI1ZXhONTMyMkgxTWFISVBadFdwa2dEUTJmR0VaR2VyQ1dh?=
 =?utf-8?B?aTEvZVY4eFZNRU56eVh5MGtwTUVqQ0pFUWJKTUFFcW0rOW5pbmx1MzJSNjUz?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefc1a05-b828-45e5-874c-08daabc16138
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 19:47:07.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2vRIpj47I44dzrArnHsjbAZKzuIMr28LyanmvB1AUoqB02W9bWuxHVijlUjj/ZP9Am7Yjraz6xSgqifgleYTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.09.2022 06:12, Ming Qian wrote:
> The codec can support any image size WxH,
> with arbitrary W (image width) and H (image height) dimensions.
> 
> But it requires buffer alignment,
> so driver can report the aligned resolution through the g_fmt,
> and report the actual resolution through the g_selection.
> 
> For encoder, it even support to encode a smaller jpeg
> than the original picture through s_selection api.
> 
> For the decoder, we do not support cropping a portion smaller
> than the original picture, due to hardware limitations (wrapper side).
> 
> Fixes: 9e7aa76cdb02 ("media: imx-jpeg: Align upwards buffer size")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
Tested-by: Mirela Rabulea <mirela.rabulea@nxp.com>

> ---
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 327 +++++++++++-------
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   1 +
>   2 files changed, 208 insertions(+), 120 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index ec13394bdddd..1bbf560a6341 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -924,8 +924,8 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
>   	jpeg->slot_data[slot].cfg_stream_size =
>   			mxc_jpeg_setup_cfg_stream(cfg_stream_vaddr,
>   						  q_data->fmt->fourcc,
> -						  q_data->w,
> -						  q_data->h);
> +						  q_data->crop.width,
> +						  q_data->crop.height);
>   
>   	/* chain the config descriptor with the encoding descriptor */
>   	cfg_desc->next_descpt_ptr = desc_handle | MXC_NXT_DESCPT_EN;
> @@ -942,11 +942,13 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
>   	desc->next_descpt_ptr = 0; /* end of chain */
>   
>   	/* use adjusted resolution for CAST IP job */
> -	w = q_data->w_adjusted;
> -	h = q_data->h_adjusted;
> +	w = q_data->crop.width;
> +	h = q_data->crop.height;
> +	v4l_bound_align_image(&w, w, MXC_JPEG_MAX_WIDTH, q_data->fmt->h_align,
> +			      &h, h, MXC_JPEG_MAX_HEIGHT, q_data->fmt->v_align, 0);
>   	mxc_jpeg_set_res(desc, w, h);
> -	mxc_jpeg_set_line_pitch(desc, w * (q_data->fmt->depth / 8));
> -	mxc_jpeg_set_bufsize(desc, desc->line_pitch * h);
> +	mxc_jpeg_set_line_pitch(desc, q_data->bytesperline[0]);
> +	mxc_jpeg_set_bufsize(desc, ALIGN(vb2_plane_size(dst_buf, 0), 1024));
>   	img_fmt = mxc_jpeg_fourcc_to_imgfmt(q_data->fmt->fourcc);
>   	if (img_fmt == MXC_JPEG_INVALID)
>   		dev_err(jpeg->dev, "No valid image format detected\n");
> @@ -995,6 +997,10 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
>   		q_data_cap->fmt = jpeg_src_buf->fmt;
>   		q_data_cap->w_adjusted = q_data_cap->w;
>   		q_data_cap->h_adjusted = q_data_cap->h;
> +		q_data_cap->crop.left = 0;
> +		q_data_cap->crop.top = 0;
> +		q_data_cap->crop.width = jpeg_src_buf->w;
> +		q_data_cap->crop.height = jpeg_src_buf->h;
>   
>   		/*
>   		 * align up the resolution for CAST IP,
> @@ -1007,7 +1013,7 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
>   				      &q_data_cap->h_adjusted,
>   				      q_data_cap->h_adjusted, /* adjust up */
>   				      MXC_JPEG_MAX_HEIGHT,
> -				      0,
> +				      q_data_cap->fmt->v_align,
>   				      0);
>   
>   		/* setup bytesperline/sizeimage for capture queue */
> @@ -1016,6 +1022,7 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
>   		notify_src_chg(ctx);
>   		ctx->source_change = 1;
>   	}
> +
>   	return ctx->source_change ? true : false;
>   }
>   
> @@ -1201,30 +1208,18 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
>   {
>   	struct mxc_jpeg_ctx *ctx = vb2_get_drv_priv(q);
>   	struct mxc_jpeg_q_data *q_data = NULL;
> -	struct mxc_jpeg_q_data tmp_q;
>   	int i;
>   
>   	q_data = mxc_jpeg_get_q_data(ctx, q->type);
>   	if (!q_data)
>   		return -EINVAL;
>   
> -	tmp_q.fmt = q_data->fmt;
> -	tmp_q.w = q_data->w_adjusted;
> -	tmp_q.h = q_data->h_adjusted;
> -	for (i = 0; i < MXC_JPEG_MAX_PLANES; i++) {
> -		tmp_q.bytesperline[i] = q_data->bytesperline[i];
> -		tmp_q.sizeimage[i] = q_data->sizeimage[i];
> -	}
> -	mxc_jpeg_sizeimage(&tmp_q);
> -	for (i = 0; i < MXC_JPEG_MAX_PLANES; i++)
> -		tmp_q.sizeimage[i] = max(tmp_q.sizeimage[i], q_data->sizeimage[i]);
> -
>   	/* Handle CREATE_BUFS situation - *nplanes != 0 */
>   	if (*nplanes) {
>   		if (*nplanes != q_data->fmt->colplanes)
>   			return -EINVAL;
>   		for (i = 0; i < *nplanes; i++) {
> -			if (sizes[i] < tmp_q.sizeimage[i])
> +			if (sizes[i] < q_data->sizeimage[i])
>   				return -EINVAL;
>   		}
>   		return 0;
> @@ -1233,7 +1228,7 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
>   	/* Handle REQBUFS situation */
>   	*nplanes = q_data->fmt->colplanes;
>   	for (i = 0; i < *nplanes; i++)
> -		sizes[i] = tmp_q.sizeimage[i];
> +		sizes[i] = q_data->sizeimage[i];
>   
>   	return 0;
>   }
> @@ -1366,17 +1361,17 @@ static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q, u32 precision)
>   		 * applies to the first plane and is divided by the same factor
>   		 * as the width field for the other planes
>   		 */
> -		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8);
> +		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8);
>   		q->bytesperline[1] = q->bytesperline[0];
>   	} else if (q->fmt->subsampling == V4L2_JPEG_CHROMA_SUBSAMPLING_422) {
> -		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8) * 2;
> +		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8) * 2;
>   		q->bytesperline[1] = 0;
>   	} else if (q->fmt->subsampling == V4L2_JPEG_CHROMA_SUBSAMPLING_444) {
> -		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8) * q->fmt->nc;
> +		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8) * q->fmt->nc;
>   		q->bytesperline[1] = 0;
>   	} else {
>   		/* grayscale */
> -		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8);
> +		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8);
>   		q->bytesperline[1] = 0;
>   	}
>   }
> @@ -1395,7 +1390,7 @@ static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q)
>   		/* jpeg stream size must be multiple of 1K */
>   		q->sizeimage[0] = ALIGN(q->sizeimage[0], 1024);
>   	} else {
> -		q->sizeimage[0] = q->bytesperline[0] * q->h;
> +		q->sizeimage[0] = q->bytesperline[0] * q->h_adjusted;
>   		q->sizeimage[1] = 0;
>   		if (q->fmt->fourcc == V4L2_PIX_FMT_NV12M)
>   			q->sizeimage[1] = q->sizeimage[0] / 2;
> @@ -1619,6 +1614,10 @@ static void mxc_jpeg_set_default_params(struct mxc_jpeg_ctx *ctx)
>   		q[i]->h = MXC_JPEG_DEFAULT_HEIGHT;
>   		q[i]->w_adjusted = MXC_JPEG_DEFAULT_WIDTH;
>   		q[i]->h_adjusted = MXC_JPEG_DEFAULT_HEIGHT;
> +		q[i]->crop.left = 0;
> +		q[i]->crop.top = 0;
> +		q[i]->crop.width = MXC_JPEG_DEFAULT_WIDTH;
> +		q[i]->crop.height = MXC_JPEG_DEFAULT_HEIGHT;
>   		mxc_jpeg_bytesperline(q[i], q[i]->fmt->precision);
>   		mxc_jpeg_sizeimage(q[i]);
>   	}
> @@ -1786,55 +1785,84 @@ static int mxc_jpeg_enum_fmt_vid_out(struct file *file, void *priv,
>   	return 0;
>   }
>   
> -static int mxc_jpeg_try_fmt(struct v4l2_format *f, const struct mxc_jpeg_fmt *fmt,
> -			    struct mxc_jpeg_ctx *ctx, int q_type)
> +static u32 mxc_jpeg_get_fmt_type(struct mxc_jpeg_ctx *ctx, u32 type)
> +{
> +	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE)
> +		return V4L2_TYPE_IS_OUTPUT(type) ? MXC_JPEG_FMT_TYPE_ENC : MXC_JPEG_FMT_TYPE_RAW;
> +	else
> +		return V4L2_TYPE_IS_CAPTURE(type) ? MXC_JPEG_FMT_TYPE_ENC : MXC_JPEG_FMT_TYPE_RAW;
> +}
> +
> +static u32 mxc_jpeg_get_default_fourcc(struct mxc_jpeg_ctx *ctx, u32 type)
>   {
> +	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE)
> +		return V4L2_TYPE_IS_OUTPUT(type) ? V4L2_PIX_FMT_JPEG : MXC_JPEG_DEFAULT_PFMT;
> +	else
> +		return V4L2_TYPE_IS_CAPTURE(type) ? V4L2_PIX_FMT_JPEG : MXC_JPEG_DEFAULT_PFMT;
> +}
> +
> +static int mxc_jpeg_try_fmt(struct v4l2_format *f,
> +			    struct mxc_jpeg_ctx *ctx, struct mxc_jpeg_q_data *q_data)
> +{
> +	const struct mxc_jpeg_fmt *fmt;
>   	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
>   	struct v4l2_plane_pix_format *pfmt;
> +	u32 fourcc = f->fmt.pix_mp.pixelformat;
>   	u32 w = (pix_mp->width < MXC_JPEG_MAX_WIDTH) ?
>   		 pix_mp->width : MXC_JPEG_MAX_WIDTH;
>   	u32 h = (pix_mp->height < MXC_JPEG_MAX_HEIGHT) ?
>   		 pix_mp->height : MXC_JPEG_MAX_HEIGHT;
>   	int i;
> -	struct mxc_jpeg_q_data tmp_q;
> +
> +	fmt = mxc_jpeg_find_format(ctx, fourcc);
> +	if (!fmt || fmt->flags != mxc_jpeg_get_fmt_type(ctx, f->type)) {
> +		dev_warn(ctx->mxc_jpeg->dev, "Format not supported: %c%c%c%c, use the default.\n",
> +			 (fourcc & 0xff),
> +			 (fourcc >>  8) & 0xff,
> +			 (fourcc >> 16) & 0xff,
> +			 (fourcc >> 24) & 0xff);
> +		fourcc = mxc_jpeg_get_default_fourcc(ctx, f->type);
> +		fmt = mxc_jpeg_find_format(ctx, fourcc);
> +		if (!fmt)
> +			return -EINVAL;
> +		f->fmt.pix_mp.pixelformat = fourcc;
> +	}
> +	q_data->fmt = fmt;
>   
>   	memset(pix_mp->reserved, 0, sizeof(pix_mp->reserved));
>   	pix_mp->field = V4L2_FIELD_NONE;
>   	pix_mp->num_planes = fmt->colplanes;
>   	pix_mp->pixelformat = fmt->fourcc;
>   
> -	pix_mp->width = w;
> -	pix_mp->height = h;
> -	v4l_bound_align_image(&w,
> +	q_data->w = w;
> +	q_data->h = h;
> +	q_data->w_adjusted = w;
> +	q_data->h_adjusted = h;
> +	v4l_bound_align_image(&q_data->w_adjusted,
>   			      w, /* adjust upwards*/
>   			      MXC_JPEG_MAX_WIDTH,
>   			      fmt->h_align,
> -			      &h,
> +			      &q_data->h_adjusted,
>   			      h, /* adjust upwards*/
>   			      MXC_JPEG_MAX_HEIGHT,
> -			      0,
> +			      fmt->v_align,
>   			      0);
> -
> -	/* get user input into the tmp_q */
> -	tmp_q.w = w;
> -	tmp_q.h = h;
> -	tmp_q.fmt = fmt;
>   	for (i = 0; i < pix_mp->num_planes; i++) {
>   		pfmt = &pix_mp->plane_fmt[i];
> -		tmp_q.bytesperline[i] = pfmt->bytesperline;
> -		tmp_q.sizeimage[i] = pfmt->sizeimage;
> +		q_data->bytesperline[i] = pfmt->bytesperline;
> +		q_data->sizeimage[i] = pfmt->sizeimage;
>   	}
>   
> -	/* calculate bytesperline & sizeimage into the tmp_q */
> -	mxc_jpeg_bytesperline(&tmp_q, fmt->precision);
> -	mxc_jpeg_sizeimage(&tmp_q);
> +	/* calculate bytesperline & sizeimage */
> +	mxc_jpeg_bytesperline(q_data, fmt->precision);
> +	mxc_jpeg_sizeimage(q_data);
>   
>   	/* adjust user format according to our calculations */
>   	for (i = 0; i < pix_mp->num_planes; i++) {
>   		pfmt = &pix_mp->plane_fmt[i];
>   		memset(pfmt->reserved, 0, sizeof(pfmt->reserved));
> -		pfmt->bytesperline = tmp_q.bytesperline[i];
> -		pfmt->sizeimage = tmp_q.sizeimage[i];
> +		pfmt->bytesperline = q_data->bytesperline[i];
> +		pfmt->sizeimage = q_data->sizeimage[i];
>   	}
>   
>   	/* fix colorspace information to sRGB for both output & capture */
> @@ -1848,6 +1876,16 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f, const struct mxc_jpeg_fmt *fm
>   	 */
>   	pix_mp->quantization = V4L2_QUANTIZATION_FULL_RANGE;
>   
> +	if (fmt->flags == MXC_JPEG_FMT_TYPE_RAW) {
> +		q_data->crop.left = 0;
> +		q_data->crop.top = 0;
> +		q_data->crop.width = q_data->w;
> +		q_data->crop.height = q_data->h;
> +	}
> +
> +	pix_mp->width = q_data->w_adjusted;
> +	pix_mp->height = q_data->h_adjusted;
> +
>   	return 0;
>   }
>   
> @@ -1857,29 +1895,14 @@ static int mxc_jpeg_try_fmt_vid_cap(struct file *file, void *priv,
>   	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
>   	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
>   	struct device *dev = jpeg->dev;
> -	const struct mxc_jpeg_fmt *fmt;
> -	u32 fourcc = f->fmt.pix_mp.pixelformat;
> -
> -	int q_type = (jpeg->mode == MXC_JPEG_DECODE) ?
> -		     MXC_JPEG_FMT_TYPE_RAW : MXC_JPEG_FMT_TYPE_ENC;
> +	struct mxc_jpeg_q_data tmp_q;
>   
>   	if (!V4L2_TYPE_IS_MULTIPLANAR(f->type)) {
>   		dev_err(dev, "TRY_FMT with Invalid type: %d\n", f->type);
>   		return -EINVAL;
>   	}
>   
> -	fmt = mxc_jpeg_find_format(ctx, fourcc);
> -	if (!fmt || fmt->flags != q_type) {
> -		dev_warn(dev, "Format not supported: %c%c%c%c, use the default.\n",
> -			 (fourcc & 0xff),
> -			 (fourcc >>  8) & 0xff,
> -			 (fourcc >> 16) & 0xff,
> -			 (fourcc >> 24) & 0xff);
> -		f->fmt.pix_mp.pixelformat = (jpeg->mode == MXC_JPEG_DECODE) ?
> -				MXC_JPEG_DEFAULT_PFMT : V4L2_PIX_FMT_JPEG;
> -		fmt = mxc_jpeg_find_format(ctx, f->fmt.pix_mp.pixelformat);
> -	}
> -	return mxc_jpeg_try_fmt(f, fmt, ctx, q_type);
> +	return mxc_jpeg_try_fmt(f, ctx, &tmp_q);
>   }
>   
>   static int mxc_jpeg_try_fmt_vid_out(struct file *file, void *priv,
> @@ -1888,88 +1911,55 @@ static int mxc_jpeg_try_fmt_vid_out(struct file *file, void *priv,
>   	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
>   	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
>   	struct device *dev = jpeg->dev;
> -	const struct mxc_jpeg_fmt *fmt;
> -	u32 fourcc = f->fmt.pix_mp.pixelformat;
> -
> -	int q_type = (jpeg->mode == MXC_JPEG_ENCODE) ?
> -		     MXC_JPEG_FMT_TYPE_RAW : MXC_JPEG_FMT_TYPE_ENC;
> +	struct mxc_jpeg_q_data tmp_q;
>   
>   	if (!V4L2_TYPE_IS_MULTIPLANAR(f->type)) {
>   		dev_err(dev, "TRY_FMT with Invalid type: %d\n", f->type);
>   		return -EINVAL;
>   	}
>   
> -	fmt = mxc_jpeg_find_format(ctx, fourcc);
> -	if (!fmt || fmt->flags != q_type) {
> -		dev_warn(dev, "Format not supported: %c%c%c%c, use the default.\n",
> -			 (fourcc & 0xff),
> -			 (fourcc >>  8) & 0xff,
> -			 (fourcc >> 16) & 0xff,
> -			 (fourcc >> 24) & 0xff);
> -		f->fmt.pix_mp.pixelformat = (jpeg->mode == MXC_JPEG_ENCODE) ?
> -				MXC_JPEG_DEFAULT_PFMT : V4L2_PIX_FMT_JPEG;
> -		fmt = mxc_jpeg_find_format(ctx, f->fmt.pix_mp.pixelformat);
> -	}
> -	return mxc_jpeg_try_fmt(f, fmt, ctx, q_type);
> +	return mxc_jpeg_try_fmt(f, ctx, &tmp_q);
> +}
> +
> +static void mxc_jpeg_s_parsed_fmt(struct mxc_jpeg_ctx *ctx, struct v4l2_format *f)
> +{
> +	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> +	struct mxc_jpeg_q_data *q_data_cap;
> +
> +	if (ctx->mxc_jpeg->mode != MXC_JPEG_DECODE || !V4L2_TYPE_IS_CAPTURE(f->type))
> +		return;
> +	if (!ctx->header_parsed)
> +		return;
> +
> +	q_data_cap = mxc_jpeg_get_q_data(ctx, f->type);
> +	pix_mp->pixelformat = q_data_cap->fmt->fourcc;
> +	pix_mp->width = q_data_cap->w;
> +	pix_mp->height = q_data_cap->h;
>   }
>   
>   static int mxc_jpeg_s_fmt(struct mxc_jpeg_ctx *ctx,
>   			  struct v4l2_format *f)
>   {
>   	struct vb2_queue *vq;
> -	struct mxc_jpeg_q_data *q_data = NULL;
> -	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
>   	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
> -	int i;
>   
>   	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
>   	if (!vq)
>   		return -EINVAL;
>   
> -	q_data = mxc_jpeg_get_q_data(ctx, f->type);
> -
>   	if (vb2_is_busy(vq)) {
>   		v4l2_err(&jpeg->v4l2_dev, "queue busy\n");
>   		return -EBUSY;
>   	}
>   
> -	q_data->fmt = mxc_jpeg_find_format(ctx, pix_mp->pixelformat);
> -	q_data->w = pix_mp->width;
> -	q_data->h = pix_mp->height;
> -
> -	q_data->w_adjusted = q_data->w;
> -	q_data->h_adjusted = q_data->h;
> -	/*
> -	 * align up the resolution for CAST IP,
> -	 * but leave the buffer resolution unchanged
> -	 */
> -	v4l_bound_align_image(&q_data->w_adjusted,
> -			      q_data->w_adjusted,  /* adjust upwards */
> -			      MXC_JPEG_MAX_WIDTH,
> -			      q_data->fmt->h_align,
> -			      &q_data->h_adjusted,
> -			      q_data->h_adjusted, /* adjust upwards */
> -			      MXC_JPEG_MAX_HEIGHT,
> -			      q_data->fmt->v_align,
> -			      0);
> -
> -	for (i = 0; i < pix_mp->num_planes; i++) {
> -		q_data->bytesperline[i] = pix_mp->plane_fmt[i].bytesperline;
> -		q_data->sizeimage[i] = pix_mp->plane_fmt[i].sizeimage;
> -	}
> +	mxc_jpeg_s_parsed_fmt(ctx, f);
>   
> -	return 0;
> +	return mxc_jpeg_try_fmt(f, ctx, mxc_jpeg_get_q_data(ctx, f->type));
>   }
>   
>   static int mxc_jpeg_s_fmt_vid_cap(struct file *file, void *priv,
>   				  struct v4l2_format *f)
>   {
> -	int ret;
> -
> -	ret = mxc_jpeg_try_fmt_vid_cap(file, priv, f);
> -	if (ret)
> -		return ret;
> -
>   	return mxc_jpeg_s_fmt(mxc_jpeg_fh_to_ctx(priv), f);
>   }
>   
> @@ -1983,10 +1973,6 @@ static int mxc_jpeg_s_fmt_vid_out(struct file *file, void *priv,
>   	enum v4l2_buf_type cap_type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
>   	struct v4l2_format fc;
>   
> -	ret = mxc_jpeg_try_fmt_vid_out(file, priv, f);
> -	if (ret)
> -		return ret;
> -
>   	ret = mxc_jpeg_s_fmt(mxc_jpeg_fh_to_ctx(priv), f);
>   	if (ret)
>   		return ret;
> @@ -2032,6 +2018,10 @@ static int mxc_jpeg_g_fmt_vid(struct file *file, void *priv,
>   	pix_mp->width = q_data->w;
>   	pix_mp->height = q_data->h;
>   	pix_mp->field = V4L2_FIELD_NONE;
> +	if (q_data->fmt->flags == MXC_JPEG_FMT_TYPE_RAW) {
> +		pix_mp->width = q_data->w_adjusted;
> +		pix_mp->height = q_data->h_adjusted;
> +	}
>   
>   	/* fix colorspace information to sRGB for both output & capture */
>   	pix_mp->colorspace = V4L2_COLORSPACE_SRGB;
> @@ -2048,6 +2038,100 @@ static int mxc_jpeg_g_fmt_vid(struct file *file, void *priv,
>   	return 0;
>   }
>   
> +static int mxc_jpeg_dec_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
> +{
> +	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
> +	struct mxc_jpeg_q_data *q_data_cap;
> +
> +	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE && s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> +		return -EINVAL;
> +
> +	q_data_cap = mxc_jpeg_get_q_data(ctx, s->type);
> +
> +	switch (s->target) {
> +	case V4L2_SEL_TGT_COMPOSE:
> +	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
> +		s->r = q_data_cap->crop;
> +		break;
> +	case V4L2_SEL_TGT_COMPOSE_PADDED:
> +	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
> +		s->r.left = 0;
> +		s->r.top = 0;
> +		s->r.width = q_data_cap->w_adjusted;
> +		s->r.height = q_data_cap->h_adjusted;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mxc_jpeg_enc_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
> +{
> +	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
> +	struct mxc_jpeg_q_data *q_data_out;
> +
> +	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> +		return -EINVAL;
> +
> +	q_data_out = mxc_jpeg_get_q_data(ctx, s->type);
> +
> +	switch (s->target) {
> +	case V4L2_SEL_TGT_CROP_DEFAULT:
> +	case V4L2_SEL_TGT_CROP_BOUNDS:
> +		s->r.left = 0;
> +		s->r.top = 0;
> +		s->r.width = q_data_out->w;
> +		s->r.height = q_data_out->h;
> +		break;
> +	case V4L2_SEL_TGT_CROP:
> +		s->r = q_data_out->crop;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mxc_jpeg_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
> +{
> +	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
> +
> +	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE)
> +		return mxc_jpeg_dec_g_selection(file, fh, s);
> +	else
> +		return mxc_jpeg_enc_g_selection(file, fh, s);
> +}
> +
> +static int mxc_jpeg_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
> +{
> +	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
> +	struct mxc_jpeg_q_data *q_data_out;
> +
> +	if (ctx->mxc_jpeg->mode != MXC_JPEG_ENCODE)
> +		return -ENOTTY;
> +
> +	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> +		return -EINVAL;
> +	if (s->target != V4L2_SEL_TGT_CROP)
> +		return -EINVAL;
> +
> +	q_data_out = mxc_jpeg_get_q_data(ctx, s->type);
> +	if (s->r.left || s->r.top)
> +		return -EINVAL;
> +	if (s->r.width > q_data_out->w || s->r.height > q_data_out->h)
> +		return -EINVAL;
> +
> +	q_data_out->crop.left = 0;
> +	q_data_out->crop.top = 0;
> +	q_data_out->crop.width = s->r.width;
> +	q_data_out->crop.height = s->r.height;
> +
> +	return 0;
> +}
> +
>   static int mxc_jpeg_subscribe_event(struct v4l2_fh *fh,
>   				    const struct v4l2_event_subscription *sub)
>   {
> @@ -2077,6 +2161,9 @@ static const struct v4l2_ioctl_ops mxc_jpeg_ioctl_ops = {
>   	.vidioc_g_fmt_vid_cap_mplane	= mxc_jpeg_g_fmt_vid,
>   	.vidioc_g_fmt_vid_out_mplane	= mxc_jpeg_g_fmt_vid,
>   
> +	.vidioc_g_selection		= mxc_jpeg_g_selection,
> +	.vidioc_s_selection		= mxc_jpeg_s_selection,
> +
>   	.vidioc_subscribe_event		= mxc_jpeg_subscribe_event,
>   	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
>   
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> index 8104ee4a3b7a..f75dfc89ff6d 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> @@ -84,6 +84,7 @@ struct mxc_jpeg_q_data {
>   	int				h;
>   	int				h_adjusted;
>   	unsigned int			sequence;
> +	struct v4l2_rect		crop;
>   };
>   
>   struct mxc_jpeg_ctx {
