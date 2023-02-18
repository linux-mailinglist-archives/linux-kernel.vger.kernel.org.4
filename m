Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DDC69BD28
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBRVvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBRVvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:51:13 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7491B13538;
        Sat, 18 Feb 2023 13:51:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDrvuBbRRk5IfQHCLp3XYIMuY55C9dBdYx+2oDEgrRb3dHaxAJi3WOnDyFL1k5jUFMnupYXheHo/Ca2Xjk29Hb8vttToB79utYRuwJzp6VTsk5IYtwxrd8sVLNM2RLqyqZm+/Hlm/MJCKzfVSrXlRyS7Mo8Bl973McVxyOly3CgzT6DypDUGilUq1/v1QP3D0A+U8Z6H3tg7HSK1w617DsyHXB19vD5BfXLCy1eLxifhYRe5vvwTCk11O/7aVBtDvAVXfKl26Gs5c4Itzcj8qXIfUvxdDY2jeZ0t17YyWsM4jC7kBVFbN9VVc132X2+J08C+9mKMsj/cpHrSUBl9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwZ6ym/Ynwbo0O4hQVnCMDocwjmGE9tQnh6QCUxHl+U=;
 b=QAw4ckmskEZNX24MmcBZyZLE9qcF2RxFzeDsg40UlquJS/vapVmjLhtxwhGOAPaXewdVdQXZpkOynCVnCOX8i4KhMk/hAKDZFBqtNTyrXOUR6yGy13SRhhqNbtGITsDM3reo70aesPXP/q67xNGhhBHknotIceCKZ1Iy75wj0bnCoSNBt6ViopdjiBsNAdidVXnUOQ7ADbdrXD34ViWN9/9AW6jHi5oUKRpTjL4P+6rGflVmre6zWSCfmXCMdH3dAgOa5DTeAtyN+YiZEG/1SCFZ2OLCzLvvqS4z025EIsQh5oedRB/8yJonzDznBA3RUOnHLsW/iz8Xor2TN7P+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwZ6ym/Ynwbo0O4hQVnCMDocwjmGE9tQnh6QCUxHl+U=;
 b=A2zXHQXQBSRcQ4ih1ni5BJbSZvW9G1Kxih0UoOQk6dRy5nEwAGKOI96oh/jQ34RU5BWvx9l84Ypttp+IjX5yCiTMuyTlaBB0RpKCq9aWSgkJyFVgMpjbim0517bXcMNmupZByhfNjsBCYzxR5OYLgiVp9Sm9eyAOlMrUNzKJs0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sat, 18 Feb
 2023 21:51:07 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::d71c:fd55:d8cf:4fc0]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::d71c:fd55:d8cf:4fc0%3]) with mapi id 15.20.6111.013; Sat, 18 Feb 2023
 21:51:06 +0000
Message-ID: <44dda824-c18a-afb6-d802-bfb87f069f04@oss.nxp.com>
Date:   Sat, 18 Feb 2023 23:50:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] media: v4l2-jpeg: ignore the unknown APP14 marker
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221216090844.27262-1-ming.qian@nxp.com>
Content-Language: en-US
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <20221216090844.27262-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR03CA0060.eurprd03.prod.outlook.com
 (2603:10a6:207:5::18) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9244:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d33fe03-9cb8-41b4-1737-08db11fa3c93
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w195hlJlv6UGmQIkLx4mvoMDa2BHQvstUHqH41Jewpp063NBLJ7BgF3/UJzFSj0kw/4SjeRWiLM22yvS/zpG3qmky2rUEKZqxBxqVZScxKn/lx+aDOM8NTqcBtdp18w5wFOBCGUNjjZhH1jWWN7duTTrRq0LHnw25I2nJ467+f5U+nKKl69csju5IEYSqfTvY2g1IsOiB3/cnI4VnMZzDv9V0sUEqzYGnW7bILRTVUWtMNXjZbIkr6ON+FkoyJs6+BnzaUYGkOknl25TQA7eYvOg6vkv2mD6pXpx1SmcP9rFE1aWdbyt+wOl/cTBNFXMM3ypRgWNEPrsY4XE5c5iGgP4cqxE1ylqsFwvA4fXJy1BqAcYAKaaBxymonOy47/UEvyiKohrMYuR0ORBNvJnpd7vYzRZ9rJ1fJt+61qe6C/sFXsrmXr7ytYHy+LPcEXEDUMzFkSMZygz5CVBkYoqJeBEhxAopvKBYUvCPjRUJuI+899OB+IFKzbHz/7XKyRCuCqmaxCH80VafQ1wL4QANO8Zk5wTUVQ04V4xMTmaetzOfKEGRcx34VCpsDLxWtmq844bpwESDSayio36tJrehFhzTRsg69GOSKOYN1KGF3W+VJ/OzkyGtF18Tw/wGsmbJ4PPyrMYJjcY1rrVwQWttue8qkS4vvQU5qBdEYFFzmyq92a6QfrMUczZtUHUmS539iCKuN6j0v1PG+GfwPG6RhZ0WBjJ0seLY/kK7kjAJttxBVSQvWgWSd8Ev2XwaxZAqBQNDhy7ug1ByX2Ybg5Vaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199018)(52116002)(31686004)(31696002)(6486002)(86362001)(316002)(6666004)(4326008)(8676002)(66556008)(66946007)(66476007)(6512007)(6506007)(186003)(26005)(478600001)(53546011)(41300700001)(8936002)(7416002)(5660300002)(2906002)(38100700002)(2616005)(83380400001)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUlhQzVwbEtTRytlWFZ0M3pKZTBGa1UrK1F1aGxTenVsTzBqTzNodXRGM25r?=
 =?utf-8?B?ajJMQ0NkVzBBN0p1RE9nYlNWNm14TWhTQkZCRkp5U0RhUFhabFFSc0JRek9E?=
 =?utf-8?B?SzVPM0ZRSGRaU2pnSzhXbFNaWXpLQmpKME53UEdrR3JXMExITVRycnZaMURF?=
 =?utf-8?B?bERTUlNLUDRRKzh5TWhESXRtS2swQ1ZVakd0THhOQ3ZFcFFrUTRqWHlVNnFr?=
 =?utf-8?B?YlNzMk5yMDhVYkNuVHBQZW1BczFGOXNjQmVYMDR3REc1dXNlZysyL0hiczRC?=
 =?utf-8?B?WWd0a20rMXV1SFFHcEY0QnVXZUFSdTYycU9lMUhqN2ZvYzliNHpIQ1pFd3Na?=
 =?utf-8?B?b3I3N3l1LzlUcW00YTFwTDZYQzRaaHZGc095YWtjeGRYckJwQWdxWjM5UFVQ?=
 =?utf-8?B?N3BNbDFmWmVxMG00SjlSRmxuV1dLZFNSU1loMHlyQVg2Mjh1OGZNTkRLWVhP?=
 =?utf-8?B?V2VRZWluWkZrdG41RWh0Y0ZPbDN6ZnN0LzkxWnJYMWpneDhVR2FnazdUVElu?=
 =?utf-8?B?d1YwZDNvZE9NRkdqazZ6SFpSenYySXk0VDZsdkhlbXpORXBuV2l2QVJ4c3ZZ?=
 =?utf-8?B?N1V0SXVCdkw1cE5lR2JFbk1WZGJBNERpQjM4MDZqbE50dUtiK2xTbXdGc21z?=
 =?utf-8?B?eWF3dnl4eHArUmttRG4yUExLVUFFalZoaENteFRGQ3RFbkVBTncvdzlNTU1V?=
 =?utf-8?B?NUpycnhRWmV5L3RRcWpMVHFqTUFuK1hzNlIrd0tJTnJvWWlQMk0xZG9SU1d3?=
 =?utf-8?B?TkorMm5JQk43cG5RZFplU0tNZlRiNEljUnJySkJaWHpCdGVDTU1vcDZva3By?=
 =?utf-8?B?TkwwejJBc0VWdXVoVndzalltTVd2UHczQktFb2l2NDVyalRJUUNPWHRwR1ha?=
 =?utf-8?B?bXRDUHh0T0V2eDJjRTEwZnF6bnN3dHhvUzU4L1lBd2p2ZUV0RG9CQmZ5WC9r?=
 =?utf-8?B?SEk5bjJBWWRneFBqZnZLOWRBYk1QY29HQ1I3ZERDR09rTm50dkEvc0RtME9k?=
 =?utf-8?B?RnJjck95WnBUTzAxZUxQZHJxNU9xSWZROFVpVy9YeTJ3d0xPR1lVZWFjdW5P?=
 =?utf-8?B?QWNOd0llcmNFcnJ0VGcxNFM0WFZlekZ0dGhwb2pVSk5GZ1IzbjJ1cm9vVlpr?=
 =?utf-8?B?TGVXU2ZpMkI5eHkyWU5lREVweWpyNkpiUmdiU29mZS9FTXplTEtCK3JIV0ZT?=
 =?utf-8?B?SmZhNUxHRGNqVlZoanJ2bVFwNHFmMURaOTVTVU1RcjdXem9Jc3p6SzJvM3hX?=
 =?utf-8?B?UzVkV3E5a05XU0ZMK2w5OWxOWG1lR3FUYVNHN0Z5eGpCNGY1dUFUb1d5a0xr?=
 =?utf-8?B?TVJDcHJwVkxOcllFaTBDZ1hRS0E2SzBDR0tYcDF6NitxbXNncTByVDhnTU9a?=
 =?utf-8?B?QUp2TndCb2VVTWZhc0MzM2Rua2tManRvR0FEQ3k0UTZnT09LZVlOWkdMcEcw?=
 =?utf-8?B?ZGxlMTZjSHFEdVpYUm4wZk15ODZXMzZFUm4vRCtJYm12cTA2SHBMaUFzMURT?=
 =?utf-8?B?ZEI3enNZWjZ1RFpPK0hTUFVPeVNzcWdJMnJQZzZJRm1WSDlGWHg5amNCcnpv?=
 =?utf-8?B?N3pTTUNRQy9hMzFUb2lQcnVVWFFTNzlQWHloeEJ3UGdnQ1hIdFJ0SFpLU29a?=
 =?utf-8?B?eEh3WXdRNi94SzRjeUdFa0tEajFsbForU2dMUXZqV2hoeWw2MUc5RVU1Q01m?=
 =?utf-8?B?QXRwT2psTlhoaHRkZjVHUS9oVEdjNW1jSzlSZ1VEcUV3cmxDZ0YycEp5WDV2?=
 =?utf-8?B?anhsaDloZnpyZU9sdW5rWDc0bWVhMERaem9GSWNDRmE5Q1hhRk9nWXIxSXFM?=
 =?utf-8?B?UzFlU1Y3Ky9mNlFPSFR5RG9sdHpWc0p0SXBxS28vRWw2TGVhWTV2RFErVUdq?=
 =?utf-8?B?emdqbk4yQmI3YUFPL2doYkVpY3M1QXlXZnFQMVdtTkIzWkZiT0Z4ZDh3aXFM?=
 =?utf-8?B?WlR6Z2x6WFd5eFV2azNpckZ5NmJBYUVVa2lVQ1YwU0lKdWJ3NENJTm1OT2Rp?=
 =?utf-8?B?MkVQeHB1MWdpRFR4TUgzWWptdDlCbVFHMm9tbDBQZXN3ZENzb2NpdWU1RSth?=
 =?utf-8?B?dktTTkxQRjQ1ZXBuc0ZVcS9qaktuWWpLaTkvS0tTNEtwb2dERWwzc3A3cVdO?=
 =?utf-8?B?TThYRHA4dlV1eTdxSVVmYk9UOHBQQWVTTEFaaUZHb3NkdHBKTkw5a1VDZnkr?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d33fe03-9cb8-41b4-1737-08db11fa3c93
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 21:51:06.3200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qc6Nlmu/M/cPMtao2gdNMHX4WFvZVWLpnVIBET3Pd+Ds97JjiNkWXJNQDrbGCJwo/onIj+Mey7oXK7/CLavLRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16.12.2022 11:08, Ming Qian wrote:
> The legal identifier of APP14 is "Adobe\0",
> but sometimes it may be
> "This is an unknown APP marker . Compliant decoders must ignore it."
> In this case, just ignore it.
> It won't affect the decode result.

I'm not sure, based on the specs only, what the decoders should do if 
the segment does not follow the definition.

I only found this in T.81:
"The APPn (Application) segments are reserved for application use. Since 
these segments may be defined differently for
different applications, they should be removed when the data are 
exchanged between application environments."

And in T.872, the mention about "Adobe\0".

But, I agree ignoring it is more robust, and I confirm imx-jpeg can 
decode such jpegs.

Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>

> 
> Fixes: b8035f7988a8 ("media: Add parsing for APP14 data segment in jpeg helpers")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>   drivers/media/v4l2-core/v4l2-jpeg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-jpeg.c b/drivers/media/v4l2-core/v4l2-jpeg.c
> index 75c2af763d55..94435a7b6816 100644
> --- a/drivers/media/v4l2-core/v4l2-jpeg.c
> +++ b/drivers/media/v4l2-core/v4l2-jpeg.c
> @@ -460,7 +460,7 @@ static int jpeg_parse_app14_data(struct jpeg_stream *stream,
>   	/* Check for "Adobe\0" in Ap1..6 */
>   	if (stream->curr + 6 > stream->end ||
>   	    strncmp(stream->curr, "Adobe\0", 6))
> -		return -EINVAL;
> +		return jpeg_skip(stream, lp - 2);
>   
>   	/* get to Ap12 */
>   	ret = jpeg_skip(stream, 11);
