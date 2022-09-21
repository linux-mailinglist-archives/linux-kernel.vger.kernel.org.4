Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9585BF005
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiITWUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiITWUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:20:11 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2704CA20;
        Tue, 20 Sep 2022 15:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPUPrQF6OorVZ6fYr/PdII+DibIOL/grXcDMHCF92Y7yALohbyQtDpjhZ7lyZoJ8c3aF5frvj1WurlJUaKOBqz1rSyhLNT1MG9eu8DJg82BCE9CRpo+5r2/ctNgrERFECYU0C/rx7tgHh1UndmrF7OpD6I0RkfhDZ1w083jT3pHVvlLac69zaMZg2/bqKyOrKXZQ2D/A9uFdCc6RvlqKeRRII6gMca+0thncKcO6lTTm1XZYSRQS4RXX4da+a/2AuKCW6i14ZF95iwyaOM5zNCvadudBnEyzUteu4eEOBr/5tGFhDZvy5aUlrBl6XKl+gwqllsMGvU/ibCu87U3v8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtTIr7DmAK3+7G/nXkaJiUYhdqxxGWVkOyBOC3J75gs=;
 b=YJdR65xkICdQNXbQtW5yxWAEc/HZx4GnHq+4ED9ud0XeBMNoICcHwIwNxw4K/UMpmKVXU7INk3ocornWl318Cxnkvibo+DKPidBhDeJAOGycFRxoQWJOaxXCvpBUIFtYLVtLpvkESptHTddGXKzQrnS7mkrfGhh7nSdDooG2HskED09y2ofZm0tzqW3sXmBTiuS6ed7JTZQMEXU7/Gf6YKf4uXuu55KhPCiwt1vkNrhnonApfdFFjOMrttF3CY5dFqv1hKjeT5jHOKH26zFzm2IjqbGiRBxZCJvmg0UsFZqd0PXIexc8F3B/kIYUFDEYSgVYsotZCy8WJMbURW6dqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtTIr7DmAK3+7G/nXkaJiUYhdqxxGWVkOyBOC3J75gs=;
 b=TZEJpPGsc2zGTyoV2xfo2qj7Dx1MiTsvNBUndxtzSc8+FDthb+6WhSPN3dCcTb2tB3s3+Z/JbBNdCm5IVSSQkHNcM+Jm4jVvTZckT5kxk1sXSdQ2tDiM4KW+JdKFe9OxQyTIBrXw95f3Igc5U9QkJI+UPeUk2VrXhMI+q4n+OgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by PAXPR04MB9572.eurprd04.prod.outlook.com (2603:10a6:102:24f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 22:20:03 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::b12a:c89a:1592:8a23]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::b12a:c89a:1592:8a23%3]) with mapi id 15.20.5654.016; Tue, 20 Sep 2022
 22:20:03 +0000
Message-ID: <a8d22a70-38a0-1b2e-fc55-d66073997246@oss.nxp.com>
Date:   Wed, 21 Sep 2022 01:19:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] media: imx-jpeg: Implement g_selection and
 s_selection
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1659349092.git.ming.qian@nxp.com>
 <4dc6db09e35ee1cfd05d548607f8a79ab5bb0ec4.1659349092.git.ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <4dc6db09e35ee1cfd05d548607f8a79ab5bb0ec4.1659349092.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:200:89::14) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9244:EE_|PAXPR04MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b116302-3613-4c72-c3c3-08da9b5643a6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iiaHyWtp66pO4Zk/ELYio8vA0f5sOa4m+WnSg4iuatl7hfm1dCPvCB1vOQOKD3C3udTn8CKpT6ZlJBQXwzAbTwp7j3o9p1eUBfOoPCebbxRa8p7uK9UFjgKRza9qKWEJDOeCPE5tHUk6IP14qWB3geLMWa+nfcJ1G4DQwb4KqqEmdjR7meq9upqrKiNmsCoeAuepPo0uXlnypQ4cuVUATj9eRn3QU4s9nzwAUyHmeAfFsNtkoFR0dQwYPlMzwNtEQZoR40wVmhuYNhY3MFGczyKexITa8knbdFLe+BBV61MzE5D/LmPYxVvwsXsMnp382Rm/tV+08r+ROqg0npNTvMdyZUJPS0mdcWEoop+ADsU7XMFsSjCnF79Pw6ukEogKefTiKWInLswtIDTsv6hw6ltggcc1gMJX25tSAXiiYLGQb7xl5rgnbCYxv0enidubY6KJCESbLjReja9kUiAoPSStL88Is1/1ke4njQAeeeaLD5hz3NCDjojZ1/98c/UqQbf5ylK++rL/Ybhlzt7nef36i748EpbOVtwv/3l0xY3P/+ariARJi2HR80Ab/xLi4rA/N6kjLwE3qUhhJSQg+THfjILStE59DLZzWNpF0hcuB+OHLuz11ZQrWXHgEXsELuCSEw0sGFl3DHR73gcKWKsbxN4WGpwCi5UzgCmZtTF9Xgjo24xWamV7D0slZaYDDN8z5yf0a/IPVGBL+zbCosuhdtxLg28H68L3wVTYsTV/B+GWxrE+/SuVJq/oHqFpVgitzDBP/NYBDWDY/DUOVDTliHpbEFNfg8FAGpYcz3vDgkL/sGl/KH9AeDGzz91LKgS1Qdn7cMCRdxwgDgDVD5uqn8Synr2ZyVONWX9e3v+F2FjWeV2u5vBtCoqaAr9x5DSPcb9vMXFQv2vNF4kDKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(66476007)(66946007)(30864003)(66556008)(52116002)(53546011)(26005)(6506007)(4326008)(86362001)(5660300002)(41300700001)(6512007)(83380400001)(8936002)(8676002)(7416002)(6666004)(2906002)(2616005)(31686004)(38100700002)(38350700002)(31696002)(186003)(478600001)(966005)(6486002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnpXdE5hSnNJRE9VVWdpQ1NuT1Q3a2RDNStXUkE2YXFKUXVVaHJPUnVmeDhp?=
 =?utf-8?B?WlVuV3BuM2QxbHBpdUpLSzdpdE80eC9vNWJRY2hLaFZXMTJhQk90TnVqKyto?=
 =?utf-8?B?Q090NG81cEp2QWlUbXpPSVNiekUreVBCajZBSlNTVDFuVlhwMk5PZk1JbEd5?=
 =?utf-8?B?Yjc2MFgxQ3diamF1Q0F0TE1vN3R0QktMS0kzYkxRK3pWS2RJeDRTRzZJYUU0?=
 =?utf-8?B?NWtQc3Z0Z1NnR1duR0xFbTljdzhPWGJKbWp3bytWalR0M2RDV2pBZWMvN3Qr?=
 =?utf-8?B?MGtuMmlpVmlvZEc4OFkxSWFuckJNckE2ZlFhYUtJWUhINjA0ZDl2N3FMSkZx?=
 =?utf-8?B?WHFhOUlBcW53YzQxYkNlckMyQ3lPNkZiTHJxZytVMHFYdWdHZVhMVXhBQTRJ?=
 =?utf-8?B?WUJCMEhCc1dyazNwckNWNFJHMWdtenh1WElGbHlGMTF1blNlc0c5a2JSaUNu?=
 =?utf-8?B?WUdMeVF3TUZKbzRsSXFxRHJiVTh5QU1wV0NBSXZXYkd1NldhODZlbldmSWk0?=
 =?utf-8?B?ZEI0aHJ0SnhlVy83SjhZMXZLdWc1WVVVYktKVmF0c1VScXhQRFU0V1h5OTA1?=
 =?utf-8?B?V2NGaXVMak9WNDJHRzNpb3d0Yzh5bjJteHNLaXpHOEcwQjZZK2xLTHpJenlj?=
 =?utf-8?B?VmFMVDUvTXVVOStETHRPaWhFQ282M1hSYkZ1ZFp0ZXNrM0g2VkFqckovMC9s?=
 =?utf-8?B?ZWg0cEVyV0VDSytlQlR5TzVmeG1weXVOdUVOZUJGZS9XZkVoeWJjMlU2a09z?=
 =?utf-8?B?UklhWmIxRmhOU3BlR3pnb3N6VUlpTU1wc0duT3FCRnMyU1BmRkhuQXNTZEE3?=
 =?utf-8?B?WmNvN0p4RW5PcUZPYlMyZTliUjdJeHRxVnBEL2JGZVB1TnAvZEJmbTZwSTNM?=
 =?utf-8?B?eVRPVG9GRmcwSUxxVU9WY0ZCWGV2SlQ1Z004QklMZERvTHZpZXd3YnNoWlNL?=
 =?utf-8?B?STE0RE5Dc2o5eEo5UllNcUpxblArZTFXNzNaTXpjVlpsZDRSMlBhVkg4TE8v?=
 =?utf-8?B?WmZzOUJPWXUyTjNZZFJlSXRQVmxKN1VFWVA3cUxHMEcyZUZ2RTVLYmhIdUpS?=
 =?utf-8?B?bTIxaC8vZEZaYmRaTm1qd1c0S2dNSVp5dzl5VG9WZTZVZTFCZTM3M0xINStX?=
 =?utf-8?B?ZWVxM01iemVHcVZ1NHk4UW4xdnZEVEdDdCtFY1cxUzFBRGhRNUpOMjFiSFNW?=
 =?utf-8?B?NFQvUEtaa2VFQjlRNldNUTFvQTJNVThqclpJUHRUdm5PaHRJRjJXM2lCWFQz?=
 =?utf-8?B?VEtkbWJEMDB1S1g2MFBJbkI5bmxQUE9meTVaVk4zSTNNL2VPYkNFeHE1cGJV?=
 =?utf-8?B?anZhcGpienhyU2dvRVlkRU5IRDJqTjF6dnpFcmVMZjlwajgrTHhhbEdHNys4?=
 =?utf-8?B?WnoyNEhadjd5UmlEQ3h3NHYxb2Zvc3lmZFMybXB4RXlTeGVmZDZVUitOd0Rq?=
 =?utf-8?B?c05SL0dDa20rUHZZdlVnK1J3QmFsNERyVEo3ZUJ4ZnRIcnVSSitpTzZLbldo?=
 =?utf-8?B?b2swVjJzLzFkbFlKQ2R3MHRVa0ptMGdybDVZUE1qbXdTYjIzWFNsWG5POHpy?=
 =?utf-8?B?aFFqSEc5SXBsUld2UkUyYVljdDZldzA3aGs2RzJvRWhzMUNmQkxCV2xvWVFG?=
 =?utf-8?B?b20yQ2xldjhMMGFSWXRTS3VJaDhRRUdKTWQxKzQxTTh5cWtBeHRxU1diMU5q?=
 =?utf-8?B?UXBqcDdIOUdHRUJZa2pGQlAwZkFZaXZxMmhaWkcrOGh2OGMySGJSZld6L3pR?=
 =?utf-8?B?OW1ZWEZodmtXUEFwSG1PZVg4STlLMHQ3NW9zeC9rMThwUVJhc1BRMHJqMHpC?=
 =?utf-8?B?TXJranlVOTN6SmNhekhQYVlXNmFiNTZ6YXF4N0hvdHVTTlpRWTlqU0Iza1My?=
 =?utf-8?B?L1RKNzJQY3p6WHYzbWh2LzNNWnNPS20wZVFENVdQZVlrRlY5ME5EajIzNnhl?=
 =?utf-8?B?NWdYbGpqYjVyUHhFRisveGh2SlZRL1doOUltaGNwQWduTHd2OEtoZHY2VWs0?=
 =?utf-8?B?Rk1kcUR5LzU2ZWYvQ0cvd012UDJKbEZiNDFFRW9hcTI1dkNuMUM3MEI1UkJO?=
 =?utf-8?B?ZWJNMnMvVi9LUXNnQjJQK3V2VHB3SFRtdE80cTZ0UTdpTVJJZExaZ2s3bno2?=
 =?utf-8?B?U2JJRmEyamk3TE1GajhaR09MZzVRUWs2YzVjWFEyS005R0xacXZzMUc5RUk3?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b116302-3613-4c72-c3c3-08da9b5643a6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 22:20:03.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckQig1rtd2QVQv/gDBwXaGB/zIfjQX0K7sc7fI/MA+zpSOV+m+mVVLkzr6Mnh7/F9h7wXG0pjUC3IPJqx6u1QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9572
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,T_PDS_OTHER_BAD_TLD,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On 01.08.2022 13:29, Ming Qian wrote:
> The codec can support any image size WxH,
> with arbitrary W (image width) and H (image height) dimensions.
> 
> But it requires buffer alignment,
> so driver can report the aligned resolution through the g_fmt,
> and report the actual resolution through the g_selection.
> 
> For encoder, it even support to encode a smaller jpeg
> than the original picture through s_selection api.

Please add a mention here that "For the decoder, we do not support 
cropping a portion smaller than the original picture, due to hardware 
limitations (wrapper side)."

> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 327 +++++++++++-------
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   1 +
>   2 files changed, 208 insertions(+), 120 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index ec13394bdddd..89f432b8c6df 100644
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
> +	mxc_jpeg_set_bufsize(desc, q_data->sizeimage[0]);
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

This is an undo from patch "Align upwards buffer size", so please add a 
"Fixes:..." for it in the commit description.

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

Lots of changes here, looks cleaner like this, less code duplication. 
Regression tests look ok, hope we did not miss anything.

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
> +	pix_mp->pixelformat = pix_mp->pixelformat;

What's the purpose of the above line? Was it meant to be 
q_data_cap->fmt->fourcc?

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

Acording to:
https://linuxtv.org/downloads/v4l-dvb-apis/userspace-api/v4l/dev-decoder.html?highlight=v4l2_sel_tgt_compose_padded

The following selection targets are supported on CAPTURE:

V4L2_SEL_TGT_CROP_BOUNDS - corresponds to the coded resolution of the 
stream.

V4L2_SEL_TGT_CROP_DEFAULT - the rectangle covering the part of the 
CAPTURE buffer that contains meaningful picture data (visible area); 
width and height will be equal to the visible resolution of the stream.

V4L2_SEL_TGT_CROP - the rectangle within the coded resolution to be 
output to CAPTURE; defaults to V4L2_SEL_TGT_CROP_DEFAULT; read-only on 
hardware without additional compose/scaling capabilities.

> +	case V4L2_SEL_TGT_COMPOSE:
> +	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
> +	case V4L2_SEL_TGT_COMPOSE_PADDED:

V4L2_SEL_TGT_COMPOSE_PADDED should also contain paddings, so move it 
below, as discussed internally.

Regards,
Mirela

> +		s->r = q_data_cap->crop;
> +		break;
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
