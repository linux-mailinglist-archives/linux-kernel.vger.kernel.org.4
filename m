Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2629E685C26
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 01:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjBAA1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 19:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBAA1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:27:39 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2059.outbound.protection.outlook.com [40.107.13.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD2B44B6;
        Tue, 31 Jan 2023 16:27:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fr/KN1dIffCMvvTocH/s2bR7kScxSHtnZA1PseaJWiQ1mn9fCbZfQeuv9L8AsMFEvTLLMy6Sc3nwhFlMVr3560aWLen8yuiF/1Ah1b5YpFN+oLcx9panm2WlNdh68kiGv54/d1JHFdo09NPbkAJ/d4TlomMyp5ugUJQDc7kAj64rHrfzXKZWu4uN6WxKhKvI70xJsDtWmXq5/DmLQNTlvYzCVVwXArpLhGBXE/pSbnUvbyG8uahlNeyeMoqxkVRknSSPjssgtf/Jy5HN4ABSEA67D21DpgEN9P4SPBhnltN5yhuQ92ukvgbn39u10LXW9kpRGemwdwMH2Z2PSnHOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0O0szHPTeNzDhZY0ZuZaosiGgCR8Natla93Lix5ndmU=;
 b=R9hGU/HhvKxJzs2ts+U3bAchjkkXuYyblpV7P2Cghs5IHLOgcnKYDQZzwbq6iU3tYrVJUVOply27fpsEkiNNNvstqlfoRcmnbOyffA3JKTLUv3hEOco+Q6hIaiQjPNGQOyjDsqH2Nrxx0vg5vp68ZdixZ1+kMxrk7uNTZkLSiomNbvB2cMyppemVC+U4VkndbGzDc++itnhlRLKk3wY+CUojry6txYOuXNO773iGZaHvaDBEi3Pre3yNr7Fm+rvqgdZnSJwOKZHWx94DEozoiA165EOKyjZI2SOJphOMxa7jDhSKYbkAQ3Mg4ZNK+44wARHT6fAqgbgX+uqLS0VheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O0szHPTeNzDhZY0ZuZaosiGgCR8Natla93Lix5ndmU=;
 b=YwTDvgsdUFEcw3k+r0GlQ1sreojw+Q9YPk6bR914qr0VDma6zur0OiuhHxlcASMFJ0pQhM01ZmPrPxUWvUtemT8SsM30UIQgkV8Sfs8UIJZXvVh3xml6oQ+NY6YTrdEnU1ckiaoCL7hk7meHHpIRUkdVabMH4mF3E06NCUBwo+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7239.eurprd04.prod.outlook.com (2603:10a6:10:1a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 00:27:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Wed, 1 Feb 2023
 00:27:34 +0000
Message-ID: <abd74bb6-9131-3769-513f-954234981403@oss.nxp.com>
Date:   Wed, 1 Feb 2023 08:27:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v2] remoteproc: imx_dsp_rproc: add custom memory copy
 implementation for i.MX DSP Cores
Content-Language: en-US
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20230131170436.31280-1-iuliana.prodan@oss.nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230131170436.31280-1-iuliana.prodan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bdd0e20-5ee8-4de0-32a9-08db03eb1cef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbSWU62VipB/aPDaREJZWVZtJKiH+rT0vRx0x0+7npNLh8xlQY+uWqhGwPjrok1aCSmmNVAfAzpWdo/Sx3TWmQTGXwrUzTmCHog6hBF6Tstj1DHdACL1ACupnG7Z8pz/87kvCq2eenGc1GwVUxEXy+4lG9YZ4yvExVgI7r0O6x/f8GYvyaiCepHi+xEXOqqLcIpLdy1v6yKz3xk7dpCni57OQJJ4aiW/OP8mgETtI7us37lOpqKKdkHv0qVI8cb7/pjRYmO/UV7afpVnUPEFVPEsbUWfaojOBRh2ORt6YbNprX9ljHvzzVq34W5m5gVQLEu1hxJv4a/wXbxCkmsspPbbWEMod29givE/12vDqkCZiQRFdUm5Ohjr+H5zumFCEAON+F0QiSFj8idFpyqqPQud45VqtHznYNUkRduytdtLFphW7zmeivVWBoV+J5k8K7l7GpGZdcCHC4vpdJCRMXem3BMcM/ximDHyvZLm3AFfFXEbQdEQrAYX/u3MLfxZ6JZrhK1SldcNpi5MIR9ytnAAi9YakTtyuNaUQOfvmu+HLc65QZGHuQFxmPqs+RjvXseCUUTzMOoYxh3DJVVAY6okB6wJ8sZSo6mXlmPJUS2Je7yGU7bZVTbgrmDspPECebeIVsS2Vpl8V/7myuJ/O7D25PEv2MQ3Lbm7+446/Hw0buQBwKuZmx1MxHdkC1pWHer/tm8hqxVTt2bBvlmZ05D1kOWsajB/ActFvhpP/cUzM/fZ8CjCbwo3+/1K9whTrCRW4hpro2msabUWKinXCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199018)(31686004)(66899018)(110136005)(8936002)(54906003)(316002)(4326008)(41300700001)(66946007)(66476007)(66556008)(86362001)(921005)(31696002)(8676002)(38100700002)(38350700002)(53546011)(6506007)(6486002)(52116002)(26005)(6512007)(186003)(2906002)(44832011)(5660300002)(6666004)(478600001)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEtpK1hRblRhRGVIRUpnS1JqeWZzR3FSM0tCMERmb3pyK0FTVW4vZ0dVemhz?=
 =?utf-8?B?OHJ5RXZnMTFFYjZFb0NBTFRqSnRhd2ZjRkd5bHlmY0dsU2Uyb1M1dVYxUEZ2?=
 =?utf-8?B?Sk9ReUZuWWJzZGF2SG1DQ1RaSTBhZ1R6aFByTUJZVWZSd3lPWk9HdkZHQ09r?=
 =?utf-8?B?ZWx2bXl1RFlpbzRKN2hab1QvblJnZDMxSVZWRFYyV000WVZXQTkxTk52SHhO?=
 =?utf-8?B?c0ZTYURqYm8wWEVzUCs2dDg1RDROTmM5czhvL3lFZzYwK0VsbFlXbE1Yelgx?=
 =?utf-8?B?eE9DK0VOMHJTSytJOEVNdTVmNzBkYjB0YmNTaEd3Ty9HM2EzSUNkd2wwRk1M?=
 =?utf-8?B?VVJkbEJjeUJPQStrUjl2UDg1clljbk1NNkg2eTYyekFjTk41cE8vaUxCS0lY?=
 =?utf-8?B?alkzMVhMMUxMSDJsSzhJbTc4bCs3cHRpQ3U2NlEvb280aE1naEViNlVieGFZ?=
 =?utf-8?B?VytiSmUwK0Z2cGdqcFJKTElnL0Zkd2xGVTJ4T09NK21zZENQdUtORHA3ejFi?=
 =?utf-8?B?Vk5WMGpTU2dXNHlhcGk3eHJMTk1namRKWjhTeG9Ra3hBZ1hzZWgzcjNmbHdh?=
 =?utf-8?B?MWd2Z3NpR2R2UFFtYWFRNXRIaUtKL25seVB1VWVieVpWSmhkRlQraFdBTnMx?=
 =?utf-8?B?S3YzNnU5YUR4OGxmZTZxM1QyNVRHWVNrREhBK3VEZTVrZ1p4Q3prTm1yYjRL?=
 =?utf-8?B?aWx4T0FDcXVJS3BRNWlmWUd6T2JwK2FmS2Z3WUtMeEFnM0k4a0g0UWxQeWtS?=
 =?utf-8?B?Rkc0aE5ZVFhHdE05cjlDTUYzUUJudW9wcmVLT3ZyR05RdjVBRk1rOEYrY2RC?=
 =?utf-8?B?Z0RGbXo1eHc4TlFWdmZLZEIvRmFSNmNWY3djNUdTQlRZZ1NIQ0x2UUo4d05n?=
 =?utf-8?B?V1Y0YURwVFNFQ3AwOGVpUWxseWp4T0xLN1MxNU5kNENNSnMwNGNpanoreUxT?=
 =?utf-8?B?bUZvdXdGcUJwNUY3UTFyb1NUMjZTcnlLQ0FDdzhXZlNGYWx3NFVod3ZqaFBH?=
 =?utf-8?B?ajZTOU1kWGk0MVp0L2xqamQxTWQweldmVkxWOHVMSzNOdWdWd21WVmJJY0kv?=
 =?utf-8?B?Q0QwVnV2YloyQU1KSWVkU1NUcmE0cUpyYmRjdVVKRVpoZ1Jlcm9wZnJ6TUIw?=
 =?utf-8?B?V010KzhqSHhjZFQ3czBMNm52SEI0MDBjQ2FsZGdycDBZcHdRM0t4Q2NWalZ5?=
 =?utf-8?B?bURCd3pBdk9tUytVbGI3eGZ1WS9mZVhTSThCeXR3SWpTVXpESy82WDMvbldy?=
 =?utf-8?B?eHo0L0NRMzRZVUlzb1lQQ2xya3RkdFQzYWhWLzBidkdVZVJ2UjN2K2VDTTha?=
 =?utf-8?B?dUZGQTdiUG50UERYNlVGZ1NqaHA1R0JrSmI4MklFY1B1d1phUnlZUGhWSDdU?=
 =?utf-8?B?UEg5TWxMclRtN0xtVWtLMFVvcXhBeWUrUno5ZjFzOTBuN05iN2hyWEp3WmNx?=
 =?utf-8?B?VzJzSUxBYnBsVXcxQkF3c1VBZHBBRytTMHJ1N3k0ZkFJazMrcjlkNnd4bDl6?=
 =?utf-8?B?UmF6NTJzaXJES1RieVdrUzd1MmNhVERnV0RxbHNSNWFRQ2d6VG1mVmN6bEhO?=
 =?utf-8?B?M0hZL2FJMkpiOWtEaGdWcVFnUGh2QWIzYzAzMm4raEx3ZnllZXRQVUwrRzRV?=
 =?utf-8?B?ODIxMnFzL3o3Z0Ivc3VtTmd1N3JKeEtqdFpIWTFLaDVMNzhIbTgwY21HelJs?=
 =?utf-8?B?dm1oWFlYaEZ0Wm9Rem1aLzVQVEJ6ZC9YYWRhQXlveER1VlloU29VVVJGMXA2?=
 =?utf-8?B?L0lRKzdBYXd0ZThoWi9salJ5cEZrQThuaWczMGp1RSs3NGg2ckxTeUYyV3lv?=
 =?utf-8?B?c25PWlJ3dUlkMVZ2RnVvWmhVd1RJUmFNbHQzTE00anJsRzNTdnV5QzFCZzA2?=
 =?utf-8?B?dklDVjhlWEdYUjNlWk5qMGZCelRQSWJ2VHMybW5zUVdFell6Tm9makZ4dlpz?=
 =?utf-8?B?bFBlc0RHN2hkeW80amsvWlh1dXpDNjVpNlJjQjJQNmEwS1N2VmdoOGVtanpZ?=
 =?utf-8?B?OVFRU1hqbFpKeEdqL1lNUFFwMzJWZGVtNGhSQVZIRmNGRjltU3Vhcy9hNGEx?=
 =?utf-8?B?YU1xY3dPTHlHZjVuZWlzNHA3V3JBM0FHOWExdjVpay9KN2FzSmxYWUdNWW0r?=
 =?utf-8?Q?C94VtZVOC5ye49E2JyEHnFERK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdd0e20-5ee8-4de0-32a9-08db03eb1cef
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 00:27:34.4455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evywHDs6rxbTZ6ipKLuW0ySXC/5flUdm004lqNum4E2cQgynU49vblH7cRCVv0tfLrkD9Eg6xj1SMRK2zCHcJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7239
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/2023 1:04 AM, Iuliana Prodan (OSS) wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> The IRAM is part of the HiFi DSP.
> According to hardware specification only 32-bits write are allowed
> otherwise we get a Kernel panic.
> 
> Therefore add a custom memory copy and memset functions to deal with
> the above restriction.

Which platform has this limitation? This driver has been landed for
quite some time, is there any specific condition to trigger the issue?

Regards,
Peng.


> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> ---
> Changes since v1
> - added missing check for cases when the memory slot is bigger than the file size;
> - added a custom memset function
> - removed is_iomem flag since is not used here
> - updated custom memcpy function to avoid reading after end of source
> ---
>   drivers/remoteproc/imx_dsp_rproc.c | 181 ++++++++++++++++++++++++++++-
>   1 file changed, 180 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index e4b1e962d56ad..d0dcc0820fadd 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -715,6 +715,185 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
>   		dev_err(dev, "%s: failed (%d, err:%d)\n", __func__, vqid, err);
>   }
>   
> +/*
> + * Custom memory copy implementation for i.MX DSP Cores
> + *
> + * The IRAM is part of the HiFi DSP.
> + * According to hw specs only 32-bits writes are allowed.
> + */
> +static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
> +{
> +	const u8 *src_byte = src;
> +	u32 affected_mask;
> +	u32 tmp;
> +	int i, q, r;
> +
> +	/* destination must be 32bit aligned */
> +	if (!IS_ALIGNED((u64)dest, 4))
> +		return -EINVAL;
> +
> +	q = size / 4;
> +	r = size % 4;
> +
> +	/* __iowrite32_copy use 32bit size values so divide by 4 */
> +	__iowrite32_copy(dest, src, q);
> +
> +	if (r) {
> +		affected_mask = (1 << (8 * r)) - 1;
> +
> +		/* first read the 32bit data of dest, then change affected
> +		 * bytes, and write back to dest.
> +		 * For unaffected bytes, it should not be changed
> +		 */
> +		tmp = ioread32(dest + q * 4);
> +		tmp &= ~affected_mask;
> +
> +		/* avoid reading after end of source */
> +		for (i = 0; i < r; i++)
> +			tmp |= (src_byte[q * 4 + i] << (8 * i));
> +
> +		iowrite32(tmp, dest + q * 4);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Custom memset implementation for i.MX DSP Cores
> + *
> + * The IRAM is part of the HiFi DSP.
> + * According to hw specs only 32-bits writes are allowed.
> + */
> +static int imx_dsp_rproc_memset(void *addr, u8 value, size_t size)
> +{
> +	u32 affected_mask;
> +	u32 tmp_val = value;
> +	u32 *tmp_dst = addr;
> +	u32 tmp;
> +	int q, r;
> +
> +	/* destination must be 32bit aligned */
> +	if (!IS_ALIGNED((u64)addr, 4))
> +		return -EINVAL;
> +
> +	tmp_val |= tmp_val << 8;
> +	tmp_val |= tmp_val << 16;
> +
> +	q = size / 4;
> +	r = size % 4;
> +
> +	while (q--)
> +		iowrite32(tmp_val, tmp_dst++);
> +
> +	if (r) {
> +		affected_mask = (1 << (8 * r)) - 1;
> +
> +		/* first read the 32bit data of addr, then change affected
> +		 * bytes, and write back to addr.
> +		 * For unaffected bytes, it should not be changed
> +		 */
> +		tmp = ioread32(tmp_dst);
> +		tmp &= ~affected_mask;
> +
> +		tmp |= (tmp_val & affected_mask);
> +		iowrite32(tmp, tmp_dst);
> +	}
> +
> +	return 0;
> +}
> +/**
> + * imx_dsp_rproc_elf_load_segments() - load firmware segments to memory
> + * @rproc: remote processor which will be booted using these fw segments
> + * @fw: the ELF firmware image
> + *
> + * This function loads the firmware segments to memory, where the remote
> + * processor expects them.
> + *
> + * Return: 0 on success and an appropriate error code otherwise
> + */
> +static int imx_dsp_rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct device *dev = &rproc->dev;
> +	const void *ehdr, *phdr;
> +	int i, ret = 0;
> +	u16 phnum;
> +	const u8 *elf_data = fw->data;
> +	u8 class = fw_elf_get_class(fw);
> +	u32 elf_phdr_get_size = elf_size_of_phdr(class);
> +
> +	ehdr = elf_data;
> +	phnum = elf_hdr_get_e_phnum(class, ehdr);
> +	phdr = elf_data + elf_hdr_get_e_phoff(class, ehdr);
> +
> +	/* go through the available ELF segments */
> +	for (i = 0; i < phnum; i++, phdr += elf_phdr_get_size) {
> +		u64 da = elf_phdr_get_p_paddr(class, phdr);
> +		u64 memsz = elf_phdr_get_p_memsz(class, phdr);
> +		u64 filesz = elf_phdr_get_p_filesz(class, phdr);
> +		u64 offset = elf_phdr_get_p_offset(class, phdr);
> +		u32 type = elf_phdr_get_p_type(class, phdr);
> +		void *ptr;
> +
> +		if (type != PT_LOAD || !memsz)
> +			continue;
> +
> +		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
> +			type, da, memsz, filesz);
> +
> +		if (filesz > memsz) {
> +			dev_err(dev, "bad phdr filesz 0x%llx memsz 0x%llx\n",
> +				filesz, memsz);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (offset + filesz > fw->size) {
> +			dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
> +				offset + filesz, fw->size);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (!rproc_u64_fit_in_size_t(memsz)) {
> +			dev_err(dev, "size (%llx) does not fit in size_t type\n",
> +				memsz);
> +			ret = -EOVERFLOW;
> +			break;
> +		}
> +
> +		/* grab the kernel address for this device address */
> +		ptr = rproc_da_to_va(rproc, da, memsz, NULL);
> +		if (!ptr) {
> +			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
> +				memsz);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		/* put the segment where the remote processor expects it */
> +		if (filesz) {
> +			ret = imx_dsp_rproc_memcpy(ptr, elf_data + offset, filesz);
> +			if (ret) {
> +				dev_err(dev, "memory copy failed for da 0x%llx memsz 0x%llx\n",
> +					da, memsz);
> +				break;
> +			}
> +		}
> +
> +		/* zero out remaining memory for this segment */
> +		if (memsz > filesz) {
> +			ret = imx_dsp_rproc_memset(ptr + filesz, 0, memsz - filesz);
> +			if (ret) {
> +				dev_err(dev, "memset failed for da 0x%llx memsz 0x%llx\n",
> +					da, memsz);
> +				break;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>   static int imx_dsp_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>   {
>   	if (rproc_elf_load_rsc_table(rproc, fw))
> @@ -729,7 +908,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
>   	.start		= imx_dsp_rproc_start,
>   	.stop		= imx_dsp_rproc_stop,
>   	.kick		= imx_dsp_rproc_kick,
> -	.load		= rproc_elf_load_segments,
> +	.load		= imx_dsp_rproc_elf_load_segments,
>   	.parse_fw	= imx_dsp_rproc_parse_fw,
>   	.sanity_check	= rproc_elf_sanity_check,
>   	.get_boot_addr	= rproc_elf_get_boot_addr,
