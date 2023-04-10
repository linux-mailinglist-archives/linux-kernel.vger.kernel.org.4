Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B76F6DCE13
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDJX3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDJX3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:29:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B18B4;
        Mon, 10 Apr 2023 16:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jn75CB6IHMCnTsa7cYxkXtNK7lE5KHp6KVfcCOjh3IIHoq+R/THTY5b8btdHBi8E2pPaP4360NlaLkglv1ZaGFBP1TwM1tozPps98rIJaPYa4q/ZDez9r6EPYgDDmBmHXIsUnFJTxu4QcqIy1nh3dld4LkbmiABEMR+IYp2y8BpcEniWqg/j/vQgt5vjvcif90Nu/3+drav0vrkrdeG2taI1zAIEKOkD4pWNHB0zjr4uyW5jyQ8k9xINwqBg+BCVyiTpuy0vdiu0PmLg4yXcq8UqZbv7GohZYcLL9Kee0K0SFMNLa5uPpQ8rxfA+ips2gFkQFPOsilECAhADpc1FHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/RI3l8mhCCZfKcewxVnNnI0sNUtr58OFJViO+kWASc=;
 b=CoKN6HIf1JzS16CmlrNabzRzs3kOFwqFp42SXF3q5ZJQdVRTVBsg3+QejrcrhIh8Jc/vIFuo4XxvdG9SYOZGHvI7mm9g040+5xPHQiWlQiElX/uGq8W+AFHzBNXgFKzVgF0TcQvIFavUs5nqwKJiZKl36O43mzoh/l32cpeqmxK5kSeqee9tltr0JC5X10vr2f5ZJXjWI2B69U9HnboX0Q/SAFxKqLCvnRYYbzO7DMwHKL7JpZrlunqny4IgZ/p+IFcs7GbjClsC1eAeWmaSUEG4PczuU+Y7P5ugYjtgocsQeafA0JpWTObcZ+qMinv/aGw4EarymTHmT80tZTxNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/RI3l8mhCCZfKcewxVnNnI0sNUtr58OFJViO+kWASc=;
 b=Ls/jzXz/x4g8deQrcJq0LN7PQbr5e68adKF/iIReNItmKCEqnpNC+jb/fvM4vAS9FQtvHa0lg4ex5ZdrqVUCo/AsR5qKmfVN97LjBemEXez0KnKgwdxGDbsxli1Ot5O03u2gfhkcqRzsAOoungKSS9+rQHDznvmoWOzDpMMWuGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by PAWPR04MB9808.eurprd04.prod.outlook.com (2603:10a6:102:383::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 23:29:16 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::b6a5:b35f:94f8:ff53]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::b6a5:b35f:94f8:ff53%9]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 23:29:16 +0000
Message-ID: <bbd3ad38-6a2d-e81f-0d72-7181674fafb5@nxp.com>
Date:   Tue, 11 Apr 2023 02:28:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] remoteproc: imx_dsp_rproc: Fix kernel test robot sparse
 warning
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, andersson@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230407161429.3973177-1-mathieu.poirier@linaro.org>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20230407161429.3973177-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0005.eurprd04.prod.outlook.com
 (2603:10a6:208:122::18) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|PAWPR04MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 004f8169-ee96-4edb-024c-08db3a1b662b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANxZEpIpKPu88eR2MNQDuLMKaBBCv6amDnsJJ5Z8GE+Rn5bvCWSyP5DPq/jlJG20sQDHPVuf31X00yfS5icWxzl/ImXz0ba6HNj579fy2G2h0oEa9u9/z8hdocU9owLHJ49GidwG7dA1JxVOQM3KPbWRnYr+a5aqsrQnGwVSc8fr7CVWTT7F9eAB0Lh5987TtuO0ER1pBKQzFrGyYkvAg+bfwBnsG7E4bSiPxjQRAweeYLxGRsD3kCpWjbTzgYMgQ6I5GQpBatwDs6r9TIwo1Prh+k+mNHYEtaLrS57YN1LrEAhkJwD+/NkAot2qOsPpWu2RnRC8RjFd83zduD4cu01/cRcTy+hgCeLWz+bhz5ecTmr0OR9UzHPLrwq1YTQLMkAoIevJHXdTRLD273csVF40cdSmYp629s/44pDsaJtLsJZE3WOgxRhZOGs9+sbKit2pOp6nRqXnsXdENdwOGVi4W+7dIOJz7eUkgbd+nRXBeYaniTvp9JYUGPXq11Oo9ZSAZ82VcrKI85A358QPan8B74cWGd0jj1VMIBhyUCoEKKtcRnY/5MHYxmwU/qCAwAYdHWODM6vkMVHqSW8jcYYa1nZNypvX8WQpj5RzoTgGJh4HGTL5jdN8Y2PjyYkmEvH+S6qOOohd/9HV+Z9eyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(31686004)(478600001)(86362001)(83380400001)(31696002)(36756003)(38100700002)(2616005)(6666004)(6486002)(966005)(2906002)(53546011)(6512007)(316002)(186003)(26005)(55236004)(6506007)(44832011)(66476007)(41300700001)(8676002)(66556008)(8936002)(5660300002)(66946007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enVXMjZ5QmZmV2VIMXdLbjJUL3dueE9HbUY5Rk01K1RYLzVQZmxXMWF4Uk00?=
 =?utf-8?B?YllRaFdGS3VYcTM5aXJiTHJCc09pRXllSkxBTmVyWDVHSHJha1R3OVlFSEVy?=
 =?utf-8?B?YkpXQlgvRGdMQk95ODdXRi85Qm5kaGhkalpaWVVmMHQ2akI5QkZJcEw2bWNN?=
 =?utf-8?B?dHlPbjFPdkRvaFRkZHVEdlBuOSt3OUpDNmM1MWQwMVA2bE5RNXpkd1JpRCtU?=
 =?utf-8?B?WGFvUncwTDJQSWErMlRlRTh0VHBDZnh3WDFPa0g3dzFDNDRzTHE4MkhBcUkw?=
 =?utf-8?B?eHNwbHNvU0dKQUQ1QVlqcUM3TGkyc3hyM0V0QjVqZXRWeTl4eXA0K1hRM3F3?=
 =?utf-8?B?eVJaWlJScnkreFB0UTkyWWZWK1NxZUFZK043Q1J0OU9oQzR3UE10RUZQdC92?=
 =?utf-8?B?RDQvQnVxMDQ2dkhVZ2g1ZEhTMUxXakZxY1VjaHBuSUE3N3QydXFIa21RcUly?=
 =?utf-8?B?U3NQY2x6RFdRMVJSZjF4MVpvbjZsMmdMUTZjVFo5L2ZCaThyVWZXb1VtUGxR?=
 =?utf-8?B?dHMzY2NQSGliZUU0QThabDAvZm1RbG93Mk9zRVRqcVhzeTJWWUJ4eWZJSUtN?=
 =?utf-8?B?Y0hoNFlpZVJuWnVwcitLSkwrVVdLdnlzd1RjQXdtNVBFRXpVL1V6TEIyeW43?=
 =?utf-8?B?RGhheDBWMGxVUWVEMG01cm1MWTlkSmJUamNJNVB1T3R0OHRoSDZCaTI3TGVH?=
 =?utf-8?B?VTZla0o1THR3S2ZhdUVCSXJmaDlHdGdqOHVuVnkzNmpJQlJQRGQvQ1piZ2ZY?=
 =?utf-8?B?TzhqbWtySUowTHBuUFJvQkNHRjR5OU9mUjlWWUVoMk9FZXk3K0FKWEdINTdo?=
 =?utf-8?B?NWZnNXVoNFRUS2pxcjhQdHV5bldlOVFUSGtYclY5ZWJ1T29FUGR3WG16Rzdp?=
 =?utf-8?B?eWY5cVV6N3RUcWVEeExtbnpxbFRxUU1TdkY3QUNHTU51WWdLV0lqNS9jQ1hW?=
 =?utf-8?B?VHVBdmpPM2tnZGE4dWRRcFN1dHgxbVF2R0lDbm9KRnAyZ2JvbXpGaFI2UGVT?=
 =?utf-8?B?VkVNZGhEdzBzRkg4TjN2ajV3WWhxcnVDUW9HU2xvRzMzc05CQXFEWjRFZ0Zp?=
 =?utf-8?B?ZE9vaWZiUHVhQ3ZCblpTNUtJWGtXZzM0WHlsTncxYlR2M0tqRkpEM21DOE1C?=
 =?utf-8?B?Qkk5WGxEWW1tUEI2eVUwdExEVjI0L3VEWElkRE0rNlJSM0NBREhOWXZGRjJm?=
 =?utf-8?B?UnM1TXplbnd4UWdzMjZ0YzJjZGxxWGc3VjhoV3A2dVVLV2tWNWJDK2ZzTnRE?=
 =?utf-8?B?UDJrcUpPb01kbzc1SXBqWlJUUjI3V2t0TDhCZXlGVDhlS3FYc3VSYXg3MWZB?=
 =?utf-8?B?MFAyMTJobGtZOHovL1VXblg5RjdJMkl2ek5qT1B0MkJIV0UwcUs2Ky9JSkJC?=
 =?utf-8?B?dnBheDlNWE83TE9MRU1TRmFFa0h2aWV6V1hRdTg2VWhxR2EyVHBlWlVWdUxI?=
 =?utf-8?B?NWNKZ2lCcjBrTXNSeU1aYUJOQUhSZWU2bUNxeU9YT3BsNjludFQrejByTHVZ?=
 =?utf-8?B?ZU1rZHZKNTNZWTBVbHNka2orWTFybXg0U0owUGZlOHlyU0dyb3VYQU9uekQy?=
 =?utf-8?B?SXA4ZEpqQjNtZFFKVzNzR0UzSWZna2szRUpadWxHYzBXTDFhY043dEFzL2Vs?=
 =?utf-8?B?ejljM1FLOEF6c1lhRkd3N2pTVElYa1Z3cHN1ZHZOMlpCQ3l0THZUQ0pRSXUr?=
 =?utf-8?B?VGJjc29MdVJyNytDZ3czeXlXOGk3c2lCMWUreG11REtGdHpKVmFEWkI5dTlW?=
 =?utf-8?B?UHNlNE5BcUhjM3lkNm8rVjZWa2lLdlFHYmRkMjd0U3p6S2dHU2NKaWVzd3FJ?=
 =?utf-8?B?amJ3ZzRJRVJ6TG1oNmdtMzFYYUZpN2N6VHB0YmZqQjNFTDh0Zmc4ZWhKTmFx?=
 =?utf-8?B?UDg2TjRwWFBlcWxkckpBM0JMdklrZHFabzErWkQ0VzhSOEtieEdkOHloRU16?=
 =?utf-8?B?cXFQZ1o2bklNNXAxOG81WVVyVklMNW5LMGkwbi9XVENycVBZeHRkWFpqWDZq?=
 =?utf-8?B?MTA4VmI1TUxWeGxrdlhwaGFIQ1c2dDRndGlqVWtEdXRhM3Z6M2ttK0kzMksz?=
 =?utf-8?B?MmRzNWExTTdsVXJZNTF0RXYvWXNxYXNFS2J0MFFKU2xFVVR3V2NaZnBoaU02?=
 =?utf-8?B?SzR6dG4rMzhycE95bTJ1VXNDL3pkb2xEWjhFUlNPUlZZUzB2Vm1OMENWWVFT?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004f8169-ee96-4edb-024c-08db3a1b662b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 23:29:15.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0x9gVMZlA1kd7OuHsNDGR9HVxLuRD8tN30GrPwXA8SwU24qW0MAp1skUE7MQT0txL7w90wzt+N2i1AhivRX/fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9808
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/2023 7:14 PM, Mathieu Poirier wrote:
> This patch fixes the kernel test robot warning reported here:
>
> https://lore.kernel.org/bpf/642f916b.pPIKZ%2Fl%2F%2Fbw8tvIH%25lkp@intel.com/T/
>
> Fixes: 408ec1ff0caa ("remoteproc: imx_dsp_rproc: Add custom memory copy implementation for i.MX DSP Cores")
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Tested-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia


> ---
>
> Iuliana - please thest this on your side
>
> ---
>   drivers/remoteproc/imx_dsp_rproc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 21759d9e5b7b..c805cb83cacc 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -750,12 +750,12 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
>    * The IRAM is part of the HiFi DSP.
>    * According to hw specs only 32-bits writes are allowed.
>    */
> -static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
> +static int imx_dsp_rproc_memcpy(void *dst, const void *src, size_t size)
>   {
> +	void __iomem *dest = (void __iomem *)dst;
>   	const u8 *src_byte = src;
>   	const u32 *source = src;
>   	u32 affected_mask;
> -	u32 *dst = dest;
>   	int i, q, r;
>   	u32 tmp;
>   
> @@ -768,7 +768,7 @@ static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
>   
>   	/* copy data in units of 32 bits at a time */
>   	for (i = 0; i < q; i++)
> -		writel(source[i], &dst[i]);
> +		writel(source[i], dest + i * 4);
>   
>   	if (r) {
>   		affected_mask = GENMASK(8 * r, 0);
> @@ -799,8 +799,8 @@ static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
>    */
>   static int imx_dsp_rproc_memset(void *addr, u8 value, size_t size)
>   {
> +	void __iomem *tmp_dst = (void __iomem *)addr;
>   	u32 tmp_val = value;
> -	u32 *tmp_dst = addr;
>   	u32 affected_mask;
>   	int q, r;
>   	u32 tmp;
