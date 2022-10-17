Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8281600853
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJQIGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiJQIGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:06:34 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AEFFD08;
        Mon, 17 Oct 2022 01:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO6zyeGWzYMtsa9n2AD2t3RHrhXJnetzwRrcHIQG6+ya2VU/j+p6ExIXDrVYsL1JktXlSz0iSNJFp/3bzJx7ZxXzM9NgQg4iUqB5ac1kPXC2q7WVFuPqrBfV0N3RSx2ywCFjc2uTR4JTJEsom+e78mZk8C4kUuyNpQNvgWNRpJZVyEqyo7z8kbiWy4rGhokbsFDqANs7S+U+xYoxYOSvbOnIp5/4Ap9a1bgtynRbxX+o1NM2q4R8CpS9ubgv/saQLzMxTZ2sX0QA0YppqRIC0BPazp9xK9NlnKTAJndn+NLgIoGHD2iyRy8RNxhDayOplkXwkVKylYkZjYGfH/yU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUAD1/ZH6u2KJcMY225NQysPxutYvjbrjZuMqaVonRI=;
 b=c/8Zw25hZMQXFUeOVcxWtKcqLtaxWnOR6gFYZ2OmrQmyBVm9j2bZ87gAzc+6KMvMAoxEH9FlkKnfWkwSBBrL6T2rWdNgvoqZPst185iBB1C10QjwOUNrULm8OTsdIBh57EXOMGMUxHSDLG2PNSwE3jsJnPxTaHecm5KLQtpmWz6oHeQGwzRLaDBGbk2hHhDGbXV6lHVmg/GNVD8f6RkB4i+luw2RVfm96motN/hca+xOsdUPIHgPLAiYEIGPkF9rJ6+JhCWT3Lhn1/eNupgxJPPnE/YsDhnB8ErWsTVCb1Jlc9hatZlwQhYTiRVN9onrxdzUGYkbM1otAv8mxR8hUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUAD1/ZH6u2KJcMY225NQysPxutYvjbrjZuMqaVonRI=;
 b=N/uYYoq4/4YMshdB6EJewaFYbEsBHtPpJTHzsivF7xisUbxM0ucW+GZ+Y5T5xHrowi7WvXYq8chW+HUPufnDgOTuRwYMiuklAVLA5A1GxOB5TWIHcv8fLShZISnAp+TygjXdw9ne7K1A2ZOwLOpMKvsRrrPzJ0KOi+kx/VF2Tk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9193.eurprd04.prod.outlook.com (2603:10a6:10:2f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 08:06:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 08:06:29 +0000
Message-ID: <a1ac4e2c-f572-7505-5662-276d1c42acb8@oss.nxp.com>
Date:   Mon, 17 Oct 2022 16:06:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v3] thermal: imx8mm_thermal: validate temperature range
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221014073507.1594844-1-marcus.folkesson@gmail.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20221014073507.1594844-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: a11240f0-9bfc-4f3a-e011-08dab0167f14
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XoTUmn/DlJSSaXK6fK3ztOCh/W4Ws3gdvjxmM02duLodmRtnTHUFP9arf+fBHOkcTszL5CenOFYYZK9GXzQA1r9LcDZJabVcXcxUFni7I4yU6C4T4e1BHV1SIqNuYU4oGoXxWd+LtvAycI63gG57l+9/xrrWy4AuIK4Ex7eTxtVEKYRXNl1Gm8ciI1sJ5Q2aI3IFm+knRUbYLoS1qrD46gTxk1KMl3EfGKb0M88rjneKHKBfdPh2KYQA9YcaDjqpV4JirfHOcGINhyCmxgXu6AqJm+pGeJlr8NFeRyKJpys5AtEjmpcGCXhcZKxiV4L0J5WH+agpU9dDbi+9dSecJoe/823/RbL6JztpFA87uOvtsc1dtlLjU/LcWDvfh0gWwe09rrUoS2bWYe8Z2rITKkjyNOxoUU5MQEGt4+zjnpjplClSPm/KvvGZ2g17xYC9IwvD5T2uCakHD52lDSyJVIQ9J1b2QDuTH8Ska3bdOQ51xj4KlicoP0jrij9ZjZIMs/QdtzGdaAT42ypECQoaNLR3rT90CX1Bcjbugb2teQXd5eDNOgl+sqk7l/DMg2RgCWXls4kzmLIYHb7Mg2Z3snMjryqMrZGnkPZxXIIOcEbHpLwfXPB78ye/vlT8O7iC9ULB3LoAscshAyT2NUCY0Hik5lBQ/x6OzOeq/r2v7xS0K5nSAzULWA18QtQAfV9cbIuWxlvf/2XG4mU0JIjWMyFPtmnw3nSxiIOjbN7+iyKPdwTLD9X1rJPlhH35f6uNRI6HOHQnjkZz1AHyqrhyzvcj5Hmmlm1IKWdGcBbcNYHSLTyfUPovUZ/PtDuwYxZ1O7hCPsa6SjsUR2HoY/9Jcpre47pF0S13ZSHtl0us6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199015)(31686004)(41300700001)(83380400001)(66476007)(86362001)(8936002)(110136005)(6512007)(31696002)(8676002)(66556008)(66946007)(2616005)(186003)(53546011)(52116002)(4326008)(26005)(38350700002)(2906002)(921005)(316002)(6486002)(15650500001)(44832011)(6506007)(6666004)(7416002)(38100700002)(5660300002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkJlSEFPbHM1R3R6eXZwQ3NVRTRmVytkRzA5d2lzZkJ2eExnSDZyamErSHJ0?=
 =?utf-8?B?bzBoclRvcnJkL08zVkVXYlJHZ3V0c2JoK3NrNFc4blVUQlVTc1ZUeUJNb2V3?=
 =?utf-8?B?ZFdjbjJqOGtBcWYrUXRxT1RQTzk5M1gxV3Q4RDFwNnM0WDM5b0tuclJId3dj?=
 =?utf-8?B?VTJMRnFHY3RLUjNoQllZSHQ5QlBiZ2Vza3NDQ3pwZjB6aXQyekVBSmtWYkx5?=
 =?utf-8?B?WWprNk9UYXJsWDRwWjlVOFNyL3VWTHJZa2UzK0haOEEzemZ6bzRUOUdJU1Nj?=
 =?utf-8?B?R0tNYjFWVE5mMFFZUFN4dk1MV0xvYnBIMzQ0dS85NHJ0ZU1zYmNqajZ1Tzh0?=
 =?utf-8?B?QjJoRWpCcFhnaGEwMmEyNmk2OVR0TVJiTE5QMHlLVDg0aWg0NFVUMDVqai9v?=
 =?utf-8?B?QjIzTWdUd0dleUlRSlgzSDFhY3MvUTlJMDE3MnlISER3ZkRiMkRHbE81YlBR?=
 =?utf-8?B?VGFXWnhXZGlaWEhsR3E3Ymg5b1o0Q1daTXlWMFY0aW9EN2VGMGFlRUtaVmpZ?=
 =?utf-8?B?UHdrNlJpQkhpME1ZaFA0UTY5eVRGOFcvU3VaR3J2c1oxSFBESTI2cGxORkYz?=
 =?utf-8?B?R3Y4S1kzbTk5T09aR0NRQXM5UWx3M3ZnMkxna1hZZnRqTk4zZngycjFwQjJx?=
 =?utf-8?B?TkMvVWEvUDlLeFdsR092QWR1cjlZVzM1dy9ZdFB4bDFDY1RpZXkwdW11U0ZC?=
 =?utf-8?B?bmJTY1ZTOFU2L2greHdVNUVhcHFNQVVaRGg1STMvSEh2dlYyQzRhaDIvQUVO?=
 =?utf-8?B?YkpjVXI3Mnl4K0M3eTlZQ2xHU1E2SUVVdHhFMXEya3RZbXpIb2thdDlCMUNO?=
 =?utf-8?B?Mkl1aFFPblVZMjhTRXFMckd5L25XZWxwU2tRUVF6VHRtNDJ6Zm9YWmlLcW9R?=
 =?utf-8?B?WFVNRWlrb2NYWVVqck9hYnh0Qit5bzVpcUU0T2VPN3p3SksybEYweFNoazlk?=
 =?utf-8?B?NzhPNkpsTUd4dWNqYXFSYWRJZnZuaHFWVlEvWVhzWlhtcEVuVit5VnJWVy9W?=
 =?utf-8?B?M2hNdGRRUkpPUzZGU09KVzVCeUNYQndYanJmRHU4QnRHQ2FSTXkvUWx2WGpo?=
 =?utf-8?B?ZU9KWTJrZ3ZZZjM1V29XZ0Z6NCs2MlVpL1crSlYxeS82M3J0alhJSDlJeUdW?=
 =?utf-8?B?OEFSV0pPcmVEUHNuam5xanNmZ3N0SmcvaUFZSTRQTkdtai9ja0NLK0Y3eEFL?=
 =?utf-8?B?MzNVV20zL0RZNUpjLzVmcWRXa0JlSGkyQm9pY3ZsOTc0VTY4b2g5R1B1dWMr?=
 =?utf-8?B?QUxWLzB4eHZoa01BQTk5ak80ZUYxSHdzd2gzTmU0OUlDdnl0Q3J5MjUwbVIy?=
 =?utf-8?B?N0NsQ3RNZXg1UVRFYk9LZW92OUFIaUlSV3JlMFVBTVhRcXlhVTMrei90eFdw?=
 =?utf-8?B?ZnNSNjZSbmxZREQzTHBKeUdoVlk2QmdqZ2VkV2RKOGRNczFTR05RMU5VMGQ4?=
 =?utf-8?B?R3prRE9CSlZHLzF5U0dmUVdhMHJjeCtDNkU1QlZjNUZpMzJuTE9vQmwxR2Mz?=
 =?utf-8?B?U3dHS3pqM081L0RtMXA5THdzbTJIaFArMDI1azdHTW1wUE5YUUhlc2hSdHhp?=
 =?utf-8?B?MkN2VnIxZWUrbGh2aHk4anl3ekhsOU9HWUZJbGtXbUdIbEJBdW1Ld284WXEr?=
 =?utf-8?B?VTdsYStoMlZBSmNvT1g3NXJyZmhiZlJOUnV5Z0I3NnZkUUhRN3FRby9rUzhE?=
 =?utf-8?B?YlNhaTFITkl4eHVnbWlvY3c2MVgxczZJQldBVGNaUGZ5RG5zb3YxN2wxQWNN?=
 =?utf-8?B?Y09BR09jRHhDQ1RIQlo4aGttZlRyZXhJZWg1U2VuKzdQenJpdVpQMC8vR25W?=
 =?utf-8?B?MDhVWFRvTm1Ua0ViaStoK1lVTGV4K0RKV2dtQjNMdnpUZENSWnZmaWhKc3ov?=
 =?utf-8?B?RHVibWZFRVBYREJTcjUwd2dtQ1VBOFhiTVlTaUQyTTVRNDB3QXNiaUNCMTNa?=
 =?utf-8?B?UXdpZXlGTXNKZkIvMEJyZG9GdEE1NkwyR0N0L3JJRjBuVUhoL3pTY3lYcGRo?=
 =?utf-8?B?ZjhxTjBjZXNRZkk2dW5zckJjMmR3a3kxWElpTXJnOTJnbHFITnd3SDU2OWdu?=
 =?utf-8?B?bG0zaVc0NU9heVdMTFcwQW82clFIem0yNHhuYVYrNTBWbTlvbDU2b0QvZkxZ?=
 =?utf-8?Q?+aqTrPUvHvBdNyYt15SNiqiLM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11240f0-9bfc-4f3a-e011-08dab0167f14
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 08:06:29.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HfaAaQr2Aa3Mk3KVF471xSXpqtGTDvTpQuh6O2/sq34byoGFkNIEpDggy/fJaOV7i8POkIR6dri6bRam1fkLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9193
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2022 3:35 PM, Marcus Folkesson wrote:
> Check against the upper temperature limit (125 degrees C) before
> consider the temperature valid.
> 
> Fixes: 5eed800a6811 ("thermal: imx8mm: Add support for i.MX8MM thermal monitoring unit")
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> 
> Notes:
>      v2: Also invalidate if temperature > max (125 degrees C)
>      v3: Only check temperature range as the valid bit is invalid.
> 
>   drivers/thermal/imx8mm_thermal.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
> index af666bd9e8d4..c5cd873c6e01 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -65,8 +65,14 @@ static int imx8mm_tmu_get_temp(void *data, int *temp)
>   	u32 val;
>   
>   	val = readl_relaxed(tmu->base + TRITSR) & TRITSR_TEMP0_VAL_MASK;
> +
> +	/*
> +	 * Do not validate against the V bit (bit 31) due to errata
> +	 * ERR051272: TMU: Bit 31 of registers TMU_TSCR/TMU_TRITSR/TMU_TRATSR invalid
> +	 */
> +
>   	*temp = val * 1000;
> -	if (*temp < VER1_TEMP_LOW_LIMIT)
> +	if (*temp < VER1_TEMP_LOW_LIMIT || *temp > VER2_TEMP_HIGH_LIMIT)
>   		return -EAGAIN;
>   
>   	return 0;

Reviewed-by: Peng Fan <peng.fan@nxp.com>
