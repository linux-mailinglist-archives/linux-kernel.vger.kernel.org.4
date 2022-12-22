Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9134654809
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiLVVrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiLVVrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:47:10 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2062.outbound.protection.outlook.com [40.107.103.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFED27155;
        Thu, 22 Dec 2022 13:47:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI5DqheLcyqo7VIj6yoSLqCGQIz/WZed+tPTB/TKCJP2cPaRyPmlfCYwVfZTxX7qmrt/DjgTs5ViQat0Ez0QqtZDzMK2YbW3Ep4sSYOw41+9ifVB1L6RdM475w/4EtVBLP3xsaz6zXqJr63L69n5LX2dukHAT0NwWBp7lozdBeyBaclbcH6I2xMQu9eguuH4nKJ25+JCt9rw4B8Fmy1NTH5DBPG2CcFREjSpX8O4b590EHeustRdVSlimu1kt64YuW1mh25b8FCobKHb4ijz3lH44TWnjZ2uJdQUyYSccF3qtDegyiOJDq6zcMpO8UkXat+I2KGAb2GEV+TpR3YwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hjyi/ntZUuNJmFW2aiHRymVu5VoqXxlnCLgqln/hPoQ=;
 b=WrIgwpo2xFasu8NtMH9G5X30iGxOV61xPwlsz4id1VYsp9asU4GkR/SCLAVDcmfvN/HrPAeTcFQg3t2/gIx33UZKevwniWq3s74DiCQWGVQNfVnFivrEDb0L+WroON2JTur2PcG7TgMoSp9rjxF2OIKc/sGeIgUozIFJk1j9nKUBPRhYnMxcLrkjqUSZsvJbb8v9q7aCWzSoEckmsoqWqsiJhSOfzlVq7/4Lb+LLj7jDEM5pPfEJQER6DeM8oE22Tvi608EEzYVhHqbTbGSNOUQGFC3UWdebkHInqPH7RS8CwNvhnevH705Ij+bCmj+XKzrnkztYGY+0mXt3qjjtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hjyi/ntZUuNJmFW2aiHRymVu5VoqXxlnCLgqln/hPoQ=;
 b=mxdoE/TCAd4TX6ODFFsxxLbiKzqND4bt8dd1/cRIaUlqffJQ2eDsDeSkcl3stoM8Q1mFJZ2Rmo5SfgcnYDJe5nfYOEjLVLc3ZXCkvMTu1349V8T5dkEfcP0pZ0PR8d1kX8v7u/9U+zOHnxutNDgGnh9Z2SzUwWMLoH3K/4HnIJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by DB8PR04MB7100.eurprd04.prod.outlook.com (2603:10a6:10:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.6; Thu, 22 Dec
 2022 21:47:04 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::fe80:dcff:38e0:ed15]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::fe80:dcff:38e0:ed15%9]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 21:47:03 +0000
Message-ID: <281a508b-fb88-4bd4-c473-d329aaa3e332@oss.nxp.com>
Date:   Thu, 22 Dec 2022 23:47:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/10] media: imx-jpeg: Add support for 12 bit extended
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1671071730.git.ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <cover.1671071730.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0124.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::26) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9244:EE_|DB8PR04MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: ce12dce5-d6a6-4aea-fab6-08dae4661028
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OaffgsFX30WPE9AmWPgVyibhvAbw8KMGNT+YXH6PnOiV+hgYjydlryPz26BnahM3Ghr4vvEeBYJzFiopJ9NUHGGQsoOy2wrX4T/KfxlaAifecljeTlfGbDbhG0IrMf+sXZ8tFxlfUU6IGxDPj6excIvINgC22zw6VPxcqqjwfSZHKUo7W2raT76MHKwffBQflOhPAkKy8CBjYmKlu54FZ4f0/2tjkPBUK/aZhS0/Y81RQksqt1aVvJYdqizFUCKlZXMayD9p+tfFCYR45uBW8r3pCLaPWLbTgiprfw0b5MNnEA2X9BE1OittC2EcgxF9A4esHWapiWAy37az7yGbJkT/gYlmTsSSjp9P7o3oV8RMYFznotQ07kidxt0qx4ux0TCuQ43oeRyjxIrGEI5UvOZRJTbReSeYXjZAoS5lzWDszuWsWpHFphra4kCtuCjxiufVpZWfgN+JNtSIQO1bWjtPEvBgGKC6RDFxkVDBSEklZkmBrM9Ot0ur3nnfhM3agyWvuvWVqNG+ZIhehDSfnal7pbDB5rW7eJiFVPyPGNs3xy0Hbkgl0+6sm0yiZL+ztdAN9dhYLMlHAElu/OdmzSgV6DLdooI/fy1HwfAtIfe8TzBjO09GuM+Ca784SRVfppgwGVKHcyo+JyynxWswWv5a+foG1c8Ar3uC4KEWl8mDXm7bTWuCmqTmz8smqFDnIfIMDnuosQ0zM8qC/ixL685UwmIiqfacFNUpCYm+VlNLZ/Qb/s3lyVm7CpOMnRJPvsOAzdw24I7gaVAI199Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(31686004)(478600001)(6486002)(53546011)(6506007)(66556008)(26005)(6512007)(186003)(52116002)(2616005)(316002)(38350700002)(66476007)(66946007)(4326008)(8676002)(38100700002)(8936002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djE0am9HQU1LR2NDNWFKMk1yR0NaVEZsUjBidXdwc1pLTGtVWStlZ1BTY2c3?=
 =?utf-8?B?Z0F0bzJMUWk0WXF2MWU2bDNaQXhyUUhFQlZGbEp4ZHpheHFrM1lTYURqblpW?=
 =?utf-8?B?eVEzM1JESGFZSWg2M2FERGxXaEZ6eWhCV29YL0J1VjhFRXVlKzErZEhuR2hV?=
 =?utf-8?B?NHRXMGY2S0Q1WGJyd09BM3g0UHFNMHRYTmluSFNUMGNiOEluZENpQjZoYTRY?=
 =?utf-8?B?R1M3ZU1Xa09RRnNGc0M4Z2pNNWcyVG1CSVJUWitsLzFWbTlBSVN6WkVCYXI2?=
 =?utf-8?B?amNQZzBld2FqQkplOXVkWWM4THQyWXVhalNYdjZZSWE3UDJvMDFSRE1NdFFB?=
 =?utf-8?B?Y0UvYUdEWFlCVmlwdkN6VFQ4a25COTBjekNPcWI1UWpYZ0lnOHFZeUhOM2lw?=
 =?utf-8?B?WkRmWVJzN0Z5Znk1QXRIQ1Y4d0FSaCszdVFUZW9zaUVQdjRNbHBtb0RCTkVa?=
 =?utf-8?B?NmgxV25TMFBoYW5GTVpFZ1dCQ0RyeG8xWnNpQ0pveU9LeDBVdW1odW1ka0FW?=
 =?utf-8?B?V2xXalBQWEQxK0NDcDBtKzFTbEtUbTNoTDRGaHZ4MTdabHh1SCtKNksyMXVl?=
 =?utf-8?B?NThWT2dDN25BYnA0SUJHdW4zTndQQWt4TU1mVjN3QkdxREtVYWowQ05RVGE4?=
 =?utf-8?B?MTN0MlluaGRNVDVWWDlWWDg5RWV4Y0xkU3FCTmlKSUtMcllvcDRSZmhwTk1B?=
 =?utf-8?B?WHR4R3JnWjFFUVdremhZZ0dBeS81YmtsWkVGTDdNT1h2d1FkQUZQc3FjMkV6?=
 =?utf-8?B?ZzE3SEtnRVZyTFRiRlN6YW4rUEVFeFN5R3lvWTc0TVNzckdzamZ2aGNOd004?=
 =?utf-8?B?WjRtOFNaMVBxT1BIcEYxOUJ0T1E1azRqc0drZS8rSi9jemtza21wK0NBY0xu?=
 =?utf-8?B?VmFpV2tXUVd0bHIwbkQ0aG5HNlRYbVVmdTVtZmNaVDVKUENoTy9oK3B6N2dh?=
 =?utf-8?B?bG1Dak01NGY4aVdWQS96VEt1WjNyMXVDTmxBTm9YWlZ1d1A1OUQwZms3REtx?=
 =?utf-8?B?WnYyOHh6S0U1bzBPa21PQmR1bGpxK2RHbVdKZjVmeFJ3UmRrRXdmeGsrRjRv?=
 =?utf-8?B?eDZSVWxtOUVWS2orRlNGS0twQ1djRnpHblpLTDBXc3Q5dFhJaHkyUzFLdU8x?=
 =?utf-8?B?QXhrSnF2VnVxUHdhaTVyZCs0bHdzdkQwdWVyNlFvQk1XY2Fud0prY2FBY3FN?=
 =?utf-8?B?bGFnN2JBUlBHeTBFcTVPZW1hY2IxMGJ3WUV1QTRTODkvcWVzaHhZa1FsMTdR?=
 =?utf-8?B?RmtlSU9ETzcvVTh0cHl2cnVoUVJhZm4zeVp2b25BMzEzN3NoNXhpV1YrN3VR?=
 =?utf-8?B?bnFnRDc2NGJ1MzhEdXZSNzVydStITUZyazJ1emdHUHdBdDNYL0NkUGlXOXBD?=
 =?utf-8?B?Y0I2WGRmNkhNamUyOG94L3YyamhLbTQ3VkJkQ2dZS3BtcG9lYUhSTFZlY3hV?=
 =?utf-8?B?Mmg0SEI2QzkrWUpJK2VmNVlTMGxUYmdiS0gveC8vVEQxMWF5VGZHblZTcW1S?=
 =?utf-8?B?eE4rOEhjbXpOQVNYUC9sdmM2elFSTCtsSFpDU3RIRk1WYVJ5Zk5RSGlHRzJS?=
 =?utf-8?B?TTB2ZTVJVW5lWkdVTnlDWUxOTDE0ZDg2dGhTY2grWG1YYmhnbEtJMFFRMnBY?=
 =?utf-8?B?dGZXTGF5T3pRZG4xbnZOS2tJWXVOWWNHeW1NTERSamw4R251WTZqbHUzQW85?=
 =?utf-8?B?Lzc0NVhtNWkwZk1ZRml0QnBzWlNobS9tWlUvSGVHYUZTSG9QekhRcWxLS3NY?=
 =?utf-8?B?djlkTFozdzVpRVJVTloybWJEYlJMeVl6M1E3ZEREcmZTTFMzRUt1bEhYWVNM?=
 =?utf-8?B?UWNXMUJuMkVXNkNEdGRSalJxWmRFZTRrelFhUWtQb1U2TUoxWU9QN09mSzU2?=
 =?utf-8?B?TEFERXovTTJDNUd6WVNFM3dDcjFKK1N1bk9yZE1qYStORnRSM0tpY2t3SXJC?=
 =?utf-8?B?alRwTzI3NGhkeXB1S2YvamtlcjcyR2N6WUtBQm9GREtsTElsR3ZwQkNMY1Rs?=
 =?utf-8?B?djYvdWZiWHVCTUxFa3FkV0hxUm94aDcyZ3NmbUs0aHBNMDc1SHNad1lhRzBo?=
 =?utf-8?B?NmJtR2l6dml3Njd3aUkxVTBqZlpodTZXZFRrMVF0OUVNWVFqMm5sT1NNZzlm?=
 =?utf-8?B?VklwWHFEdi9LTDlPMjdEanpZRTNnNEtBMTFhTnUzeHl0eUJrTjFBYno2YWw5?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce12dce5-d6a6-4aea-fab6-08dae4661028
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 21:47:03.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBTFTnoDpJiI+5f842Ty+UdiXgURVC4SotlqvWMNvNopj8gSje8ODawKDGfiF6vU3isUnNjftqrFNn1tS4WivA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7100
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
for the patches in the imx-jpeg driver, in the commit description, 
sentences should begin with capital letter.

Other than that, for the entire patch-set:
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
Tested-by: Mirela Rabulea <mirela.rabulea@nxp.com>

Regards,
Mirela

On 20.12.2022 05:11, Ming Qian wrote:
> the imx8 jpeg codec support ISO/IEC 10918-1 Standard Baseline and
> Extended Sequential DCT modes.
> it can support 8-bit and 12-bit per color samples.
> Currently we only enable the 8-bit jpeg,
> and we can enable the 12-bit extended jpeg
> with the new defined 12 bit pixel format.
> 
> 
> Ming Qian (10):
>    media: Add P012 and P012M video format
>    media: Add Y012 video format
>    media: Add Y212 video format
>    media: Add Y312 video format
>    media: Add B312 video format
>    media: Add B412 video format
>    media: imx-jpeg: Refine the function mxc_jpeg_find_format
>    media: imx-jpeg: Clear slot next desc ptr if config error
>    media: imx-jpeg: Decoder add support for 12bit jpeg
>    media: imx-jpeg: Encoder add support for 12bit jpeg
> 
>   .../media/v4l/pixfmt-packed-yuv.rst           |  70 ++++
>   .../userspace-api/media/v4l/pixfmt-rgb.rst    |  44 +++
>   .../media/v4l/pixfmt-yuv-luma.rst             |  11 +
>   .../media/v4l/pixfmt-yuv-planar.rst           |  94 +++++
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c |  19 +-
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |   5 +-
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 326 ++++++++++++++++--
>   drivers/media/v4l2-core/v4l2-common.c         |   6 +
>   drivers/media/v4l2-core/v4l2-ioctl.c          |   7 +
>   include/uapi/linux/videodev2.h                |   9 +
>   10 files changed, 565 insertions(+), 26 deletions(-)
> 
