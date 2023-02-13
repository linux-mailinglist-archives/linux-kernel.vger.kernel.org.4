Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A14693FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBMIsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjBMIsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:48:10 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2050.outbound.protection.outlook.com [40.107.249.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758B56E93;
        Mon, 13 Feb 2023 00:48:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjachhBxsmO/nMkES3699HfB2Y4kOz4DJRWP236ok+3Sln5RQG7c7cyaK4A7Rp6876t77v94Cx4WUmJvvRO3FVcuJts5526o8mCMuoRKRjdBVNbPDs3LrIOnLydol9CIFZxIUofOlg9LxiKcSesfBkNGOTWO6z0OX+3KOKqWscPEWk51/NDujrB5H84cohxOhCcAkD2Gt/CjLvwrpzWGYTnGU3yYATCQAaiYXpb6PouxXCyl3RHKf4Hr3Nyd4naNnAKjlSR2XHGfAUOzsSIo3vEwi0xqhMDjXYXpykO1M61MKQNU506TMiwV6+Q3IzIQRCI8S0GnZodM75S0AiOjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uUH710WJMBChzrJt/PG2BxC8x+hpb79WTmacERFf8U=;
 b=aFI0t7Ib4dwWhsmu7B/vh9BqKDbJly7ixMsF5SUQzxAxFM4Yr1ldxy4sT4mNzZ/yS2Y2CNZE6YIyL6CtA3mdw+TSZtk3/nS+QRzHiUgEh7xhPpresziMb+XVz1FedXExobpuprLDXVj0jvtBfLlTL8lifED/48y1dl2KfFs3BH6KdELfWkxSLHtdv5TyI/24fhOgtaY1Slvk9dJjlC7mFdk3q55Xtsb+HAOEL8Qzr6VpIeqD22eUW+69E2XeEl0thH2WuT5QRlg5bMplAkMw8LYAGFipfnGN1QkAOZI3krjfRUkNKLbg1c1q+uzMCbJJXjOOAISS5UJ7tnTHfUV0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uUH710WJMBChzrJt/PG2BxC8x+hpb79WTmacERFf8U=;
 b=IR6e0edMMFYL53q4OP1nQLnjVAtJsSt2zZ/Fz+Mi2FRRxJpqGBTS2e+uUXQmb/Kv0ELwsKNjshAXadGN/woeSHea673znFrXhYP1NUam/VlCgstp4C7NnhDPi3jbyb4bAjSwWluwLFClbC38i24KRBp5oDxaLTMJ5nmSouTb0rE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 08:48:06 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6086.022; Mon, 13 Feb 2023
 08:48:06 +0000
Message-ID: <ec674bf1-95e6-a238-4a40-721f004a6161@nxp.com>
Date:   Mon, 13 Feb 2023 10:46:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] serial: imx: remove a redundant check
To:     Tom Rix <trix@redhat.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230211154550.2130670-1-trix@redhat.com>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20230211154550.2130670-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:200:89::18) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|AS8PR04MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa05b8e-9b70-4b1f-4f25-08db0d9f0665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wvi/IIkWljAgQz6YfPQU1X+gBDi9ryKt0IEn0na+Xxgfu8IlOUXoV077s7JnqPiRd1vofmqh5+fPSlhLidPbTKs2oUWZRwhHp+UzTJuHNbe9imuGy63m8JFW/dzcxFVKGBaowvttuCI0b60D4Xe3eexNEpIMopubHy5gVIlfyZSX9gJukBfZpGhDJrxsqsX/CMwfA+yPxUTWAuNx2XfhrxYWlStlcdpk1wFlYzS9yqqJ74XbtG0utwoQ3TVOGNuhQNlAKVTMpHVuA4wXGwkCRR3TLqZBHtL54qhjEHSTEamLjBEIxCdt7eugFiZLBZBpBLS8B/vM3r9RgNFnR5ishi5LbaeU60zDymFQt953OOLd/e+9iVxRM5hup1/Arh3iL35h7Szle7AkONMkVCe+9jJ3qRS4YwEEGkQJKFn1vzGwEwcvAzlj00sd7pX/3j8+YXptKpUxOW17UqNPQz7BId7nSJnIqdB+VTSFECcRdAFtjQfBXKFhy43tJq3n0eenKcVkFvwPTQuNrUHRCbYzZyaGs63oYQsifmhsQpmQsfJN43q5XBXfzKkEHZClo8Yu3nuW/sJvmIB4Olcsc9dWNZsvp79AYFsTi7EYBM5b9Px5DHcF8/EfFv8nmqJAuR2Vm25nGxB8csZzmovTimgOw53hz4FIANl0Nn9c+rPJMZXyw5ka5Dz1oQCtLqza9A4mw3fpRatwpJjACGs7kSiVwJG1JRcD9q/4fhivx+igHMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199018)(2906002)(44832011)(36756003)(53546011)(55236004)(186003)(6512007)(26005)(38100700002)(6506007)(83380400001)(66946007)(2616005)(4326008)(8676002)(66556008)(316002)(5660300002)(8936002)(7416002)(41300700001)(66476007)(478600001)(6636002)(6666004)(31696002)(86362001)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUE1RC9EelNZM3VBc2ZPYUFsNFg4cWNKS1lvZS90MUZzQi9IMFFQWmJqNkda?=
 =?utf-8?B?WU1xdlpGU0JlVTdNNXlEZzVjUVhUN3MyeUU4NHdXdWRWY2pyOVdLWUNGYjR3?=
 =?utf-8?B?bnJpT0YvMnZSemZkMGRBRGtVOWh0Vk1uaVYvRU5LU2tKZUdiY2hJUEp5czZo?=
 =?utf-8?B?OE8vTXBKOFhEVCs5ejNlRllXVC9hSndoUVNRZFB4dEhORVkrUDlxMGs0RUdn?=
 =?utf-8?B?VWFwb1JDc3pnZlpwSVFJbTdRdXZsVmtXNFZGNGMvcVdNWU9qY0JqUDF3Y20v?=
 =?utf-8?B?OXJmMVdUYU5ZemFZcGNIZzJTRWJhWXRrNGVEcVF4WUNSYkhZYmczdlJwYTh4?=
 =?utf-8?B?bzFaMjhORTU4TkVXUndEbWxPdHFmc25RdDFIZ0FSVHdmc1hLZ0hZVkN3TUdK?=
 =?utf-8?B?ZmFXUEx4T0dwOUNSRUZxTFN3QzNqSkJ6RmhkU1hBSkx6R1VlNld0dUF2Zzh0?=
 =?utf-8?B?cUkzZC9qQkhRSUxaVk5rdHFTRTJjclhPM20vTlhUUTlMZHlwOUxVSFJIZk8w?=
 =?utf-8?B?MmxxM1lZUERBN2ZONENLRWlZTEZVQkhpR29FRHc0ZGFoV2VKTVdaYkMzVWpm?=
 =?utf-8?B?SGRtSW5mMTcwd1ZLN040Mm5xS2tndTRQNW9SNWkwZm1yZFkvQ2hXaXl1MHRo?=
 =?utf-8?B?UkQxK002ZE1JZ2V2N1JRZUZFWTlwNW0xcDNSeW4vZURuK3llRFlhRjUwTjZv?=
 =?utf-8?B?aFErTEhoYXVValhOanVHd01TZFpFNFI0LzZlU1lGRGt3TjZIN3M3alAwUTFy?=
 =?utf-8?B?UGdNUWh5bUxYRndNMkpYSmxzaXc5SmlLdWc5ajdteHNGd1JSdlhOR0VpRTBq?=
 =?utf-8?B?enZReG1zNXkrKzdEdVRGOTJXNkIxaVkvR1JxZFNjY3ptZ0xxM1lReGVoYi9F?=
 =?utf-8?B?MjJWWnhRQnlRY1k5TFJxRFR2cS9wdmlmMnlFL01jMVFQZDFzTVNOM2xKOWxz?=
 =?utf-8?B?b1ByV1NaRktkcFNDNzhwSXpGYTVKYjZicWxVNkx6SzRDSkdSTTJZWndzNUhJ?=
 =?utf-8?B?b21HdHN1dXlWMFUzMEVQcEx0c3lTRGQzRXF2QnNlV3NPTG9KTEZhc1FIWlQy?=
 =?utf-8?B?aWJ4b2lRUjQ0eE9UNExSOTUyVnRMVm1yaXE0RUR6T0FuY1FSZVhqT3N3VkFw?=
 =?utf-8?B?N1Jpamlzd0dzWDVXdWFYTEUxT016aS9VQ0RodzZjQXkwTWZERDlNOHBnYkZT?=
 =?utf-8?B?OGEzWVZnejMwSy96TndpMzcybkpRWFlHaEtzTlhoSDZaUStxVVEyRWRwU0V6?=
 =?utf-8?B?NFBDYzJZcUxTa3k2VGdvQWxBTm1JbjJFTUZWeTArdDBpWEhBQ05RR2Z2M09B?=
 =?utf-8?B?UUdGTFVaTndZRmhhbGtVaStvcmYxRzBXSkZITmtGT2FEdm5zNjBEd3FnMzRP?=
 =?utf-8?B?NGV4K09pUzV3anlLaFlPNU81ZVpWaWNIYW1BM1JmZVo0aTNGS2tyOHdVdUFa?=
 =?utf-8?B?Q1dYMXRhTjUzNFJPT1pVS1FMWG52UUxVb0YzT2x1OXVPS1dwWE5PSGdRMGln?=
 =?utf-8?B?SXllbElHLzdJTFQxQ0VBUW9tQXdzeGdQQnpXWVNCdHo5NmUwY3RQS2VCNjJW?=
 =?utf-8?B?eUNscWdsY093S2JKSkFLZG4rOE43NXBqVW14UG5YNmU0ZHl2RE9VRkRVclA1?=
 =?utf-8?B?aDZKYmNVOFdvUkREMzhBdVE5S0U4ZmtkR1lZYkduTHRpeHpwTjhhZnJVSU1o?=
 =?utf-8?B?ejNpcUdQS01OU3VHczg1SUxqZHVpYTFrNTllSVJiKzc0bmY0VkN4TzA5VjlF?=
 =?utf-8?B?cDZlaFg5TzVYVjhSYVJIclB5S25HRk5UajV4eWFGalhGQVFzeDZVZ2dIY3l5?=
 =?utf-8?B?b0NOZXorTGFGZUNTN05rTWtzb2p2cWJGQmlvRm40c21uaUN4RmhzV3FRb0li?=
 =?utf-8?B?N2tLcXBsT2d5dXFjMXBTYWZvWGtHVGEvY0hrbkxlbWlZSmd3a2F6U05KS3lT?=
 =?utf-8?B?UjNzZmlLeXVCL3AzdkdXamNjTXA0TDdCZnNqYlhHdWt1WDVhRVRNTkY4cHd6?=
 =?utf-8?B?Q0JPVU1CaCtHNnJpSStyUC9XUE5FVzh0T1lQWStySUlKdThJRmw2K1NYWTF2?=
 =?utf-8?B?V2tOQjJpUHVnNlJwTUlDNFUrdnpFR01oVGEyL2hsVVhxb2JCZk8zdUxCV1hI?=
 =?utf-8?B?bC9FcnN3NEFtS0t3Rm5kQnNocGV0Z1A3RWJleFJZUEYwaE5UZmRyS1NSbVlk?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa05b8e-9b70-4b1f-4f25-08db0d9f0665
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 08:48:06.2570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXORZ1aiX0QqS8mMb4Q7gV5b5ddPPhEgEwPWT7dbTtUlwyzMRBSDdlREWwu2l6qfMYpNQ4Mtsx7gFYjkrGGm5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/2023 5:45 PM, Tom Rix wrote:
> cpp_check reports
> drivers/tty/serial/imx.c:1207:15: style: Condition 'r_bytes>0' is always true [knownConditionTrueFalse]
>    if (r_bytes > 0) {
>
> r_byte is set to
>    r_bytes = rx_ring->head - rx_ring->tail;
>
> The head - tail calculation is also done by the earlier check
>    if (rx_ring->head <= sg_dma_len(sgl) &&
>        rx_ring->head > rx_ring->tail) {
>
> so r_bytes will always be > 0, so the second check is not needed.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

> ---
>   drivers/tty/serial/imx.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 363c77a140f0..523f296d5747 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1204,11 +1204,9 @@ static void imx_uart_dma_rx_callback(void *data)
>   		r_bytes = rx_ring->head - rx_ring->tail;
>   
>   		/* If we received something, check for 0xff flood */
> -		if (r_bytes > 0) {
> -			spin_lock(&sport->port.lock);
> -			imx_uart_check_flood(sport, imx_uart_readl(sport, USR2));
> -			spin_unlock(&sport->port.lock);
> -		}
> +		spin_lock(&sport->port.lock);
> +		imx_uart_check_flood(sport, imx_uart_readl(sport, USR2));
> +		spin_unlock(&sport->port.lock);
>   
>   		if (!(sport->port.ignore_status_mask & URXD_DUMMY_READ)) {
>   
