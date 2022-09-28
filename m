Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551A95ED69B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiI1HoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiI1HnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:43:08 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10066.outbound.protection.outlook.com [40.107.1.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4250E110EEE;
        Wed, 28 Sep 2022 00:40:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeuppCvcvpt+g6aaqnLf3rVsoc6+JTJsz/gtgX0PB90Dt3FqV96Sd8yvCsaV8FOcTVLUvt0jhWkcyiOJwJvAv5MzV2ZgVdej/JJkLCvngRLUslsOhqpHSdkkWxSTNCUyDTEWcg6RBsiiR+LaN9mv+lijyIXnOVZpAfyjcWwk+2v/ZKaekUBrU6bLII0QbzOi0AcK4yqy0dKcSYSpVur9R646BafuChSkeUzmh2YYXS0BPX/A2kxV9efNbByg3u88OX8Zxi+PtTJ/S4vWd5opFcfkZwhdE+QEVgBTk9/nm4/CLO7VcUQSAjc5gPtSVJjOuza6K0YMnPCvLbnksP1Hqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45F3y3M0AoaVTsVkwmv59bJrh7zWWWwkzv14D0DvPrA=;
 b=CtQqJZ+0LqqBMy971dvGPDc7NohPVIMlMXIkuc2OGYnu0Ks3cjIcn4qxFxujNlflve+u8d8wil3KLLa8qVk2B1HDMRkuNC1Y6s3T664XIVm8n3m5zjjDgx2qFug6lSWPpznaLW0+pEj2wsbuvImzkSq+rKeG06K1TwXIR4Y2Lq2t8YeU+fR8fZ1iTAX6psQNdGSpLh/LTOfIRi2scl/FhPYwhVN1Fyk1kTmTc1+SXiuHNmIIcwbPN6yweLi7fox8BOVMCRhe4UO7UGfjktwGRyioSDs3Lkezk5Ncp5vHtATl82eZVfxZ8d9ym+Q6fqKEquK9CRguD1Gw61VpGkZWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45F3y3M0AoaVTsVkwmv59bJrh7zWWWwkzv14D0DvPrA=;
 b=NDMR7zqroQZcb7PpgynP7CkzVuat3IB99Eb9Vr7CF4upXOZOmG90VRHsFVWCJv4I3G7/A2pBTboecseVUhTmsAbm19BQ8FfW2uy2QDh8IlWlf+as57FKVn3216m28bBLn99pvE6UuG1izQ/OATKL0HxIv24ki7MT+ngJbhkoUjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8158.eurprd04.prod.outlook.com (2603:10a6:102:1c3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 07:40:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 07:40:06 +0000
Message-ID: <64c6bdc2-583d-a2d0-f8b8-c4487f8a4d97@oss.nxp.com>
Date:   Wed, 28 Sep 2022 15:39:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peng Fan <peng.fan@nxp.com>
Cc:     "bjorn.andersson@kernel.org" <bjorn.andersson@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
 <20220824011023.1493050-4-peng.fan@oss.nxp.com>
 <20220926232127.GB2817947@p14s>
 <DU0PR04MB9417EABB1B0A9B550E94236288559@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20220927175649.GB2883698@p14s>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20220927175649.GB2883698@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: b5014525-dcba-45ec-229e-08daa124a998
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWqYJDmo2TNAQ7A3NUiW5sYKb+RIh1SVQ759tWVizxRmC+pGpCeP//QwHrEbCyfpTM9WetEt9dOButW67pxw4Uy73pm5zDTeMtyLl9FepvW6D4RNEiFBDRJXZoviWTAHtdfgB4ABsPeKOtMwFCELjcqANeEdJE3T8L11K2Y4FCk1w1lXshe96wWxlGuB+87y1tApi46NG4TQK9iAbGZF2D03E4leHenHyViSHiVnP2R6/1wS9qkPoBiAYTjuKH+Pgg37mmzhXfuiX3w+HgGEGE4BOE7KDtnIfu3csdfFi+Blxkr72SMONLdIADzc4oY2iTwonJkD8BFf4CpC2NJSf7n0MzZCigj77I4OTteic9RHBSpL0A2n5LbIWAy5Xj1m1h6vgSmzoD17Zbl6sqnb4QyL31YbxPgcJOjw7i8gdUVrOVrgMBwTcXYaPyMzGOcdYvC4jmS4dcfLjJ2FgJ0rSl6T6y4sNVCrY1Ebljp8usbJZSzBhsyuJK34WQKqPlJwIpC6kpl/UKLv61J36PdKiZbRpR2LAcFwzy0+sKuCxb0/uQw+RNgpdvCpdf9yUlZe7UE3zp36H+x7QNP6Ugph3IP+0ARkkXfbEJ2tXmH8Uro+rPH2Vhc81IoM2taS0sFfxB8Fjz1Fp3TFi2Kc9f/P9YijV/zKI2SoQlj91n342iatBANKfoiNHKADWLZRMrJaHWwztx2H8FmoA3gvdMZjCOT+sXb/ybR+reezLJSaIwNV8sNKkMvgBmmMc3dTen/aixdo2BZnmeAymG2RgreBI4PLbheEydFkIoa4O+f3bxbcfgcC8+egNbcmEYTEqk0X4tZAVIec+ICGcbLfzgZ+SblmZPLGrrHEdq2nzctiSlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(54906003)(966005)(110136005)(83380400001)(45080400002)(86362001)(31696002)(38100700002)(38350700002)(6666004)(53546011)(41300700001)(8936002)(52116002)(66946007)(31686004)(6506007)(316002)(478600001)(4326008)(66476007)(8676002)(66556008)(26005)(30864003)(44832011)(6512007)(2616005)(2906002)(6486002)(7416002)(5660300002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFIQTRuWWFEdXh5TXRkd2NoRFc3WGQ0Sm5VN1BqWURGNXV2VU8rdmNoRVY0?=
 =?utf-8?B?cS9oaGVpWEJueW1oNGx6NUhzSUhIeGRsNU5Yb1hCUWVYdVJHY3ozT2hyMU0y?=
 =?utf-8?B?Q1lYbjBMQ1Bsby9qbEdoMUE1VnhUaUVwMG1BaU56b0tkYVhVNW83U0VRby9I?=
 =?utf-8?B?anlUNFZ2L2hEZVRVRDQ0RUg1T0hFT0lOaTh0ckFWU0JHQTJQVmFYRWhTUmZs?=
 =?utf-8?B?YW03cUQ5WFI0YWR1eU5neEtiWFI4VDlPdit0cEprUVNyQWo0VVgwZ2ZLZXJU?=
 =?utf-8?B?TW14MTRqZ2tNZDVGN005eitPcG1ORDUyRTd0NU9IbzRXT3NyZkpsc2lwZHcv?=
 =?utf-8?B?YnF0ODFuM25wbGVucDRTTjJ4SmI1NDhqVjhCWUVYZHNRb05qdjY3c1c5TXdj?=
 =?utf-8?B?YjFMUS8ydExZN2dpbWlXN0NaeTdkSUFUT1R3WTJnY0U4SmppUXRRaEZoWEds?=
 =?utf-8?B?bHVEYzJlSVFqUXZqREw1azF6aENoYzduU0FrY0NqMC9OQU1TV1ZOYk00N0w2?=
 =?utf-8?B?TVBKL1JjTE5JR1lUVXA0Zm5MeVQ4bjNsV25NVmZROE5XTVBMZnQ4aE45WFpa?=
 =?utf-8?B?RUY4WW4rdFMzM0ovTWxTL3dYakxiNXQ0bjN5Y0g0eGh4Yng1bHQ5RWN1Q0tV?=
 =?utf-8?B?RzZNUS9UM2tHZ2RtSEFNRlRPWU9WK3ZYTCtMWVRpT01OekZidzQyZlhoWEQr?=
 =?utf-8?B?K2R5WWs2MGgvRVUrcWtEVHJiY3NmalZ1Z3VJWm1DTEM3SDJCTTZ2YmppejYw?=
 =?utf-8?B?SDRkcExGQmhad3Q0cWZuTi8wWkRHRThXV1Q4b3hpejd3bCtlZlNqME10cndq?=
 =?utf-8?B?RHVOY2xvdzhqOFRNU2FHWjF6dFpjZHRuMkpmUXliQlNnNkRybDdVM1RMNVJ3?=
 =?utf-8?B?cVo5K3hmcUtWenZmTDNDUjc2eHZ3bUEyNjlqQ3JlWGN1ZkFDZ01aRkc1SXVp?=
 =?utf-8?B?bEhDSStTaHcyWWZvbXhLak5tcjFqV3N2WFFCSkRra1BpWjJyMU4rZEgydFlT?=
 =?utf-8?B?WnF0K1dLeno3MHFBNS91YU5zVjBZbWg0eXBTMVQzVllmZ3BHY2ExMWcwb3h2?=
 =?utf-8?B?YmJmbi9pY3l0VXFjTVlqQndZazRxQlRGWmxBcmZrM1hNRXViRTdYZXhOSHFj?=
 =?utf-8?B?TG5mbDM3NWJOUWxSY1hjQW4zblJMaWQ4cmZrUkk2MGxtMTg4blNMVnVlbWd4?=
 =?utf-8?B?bzBxbnovRURiMUF0ajlCOXNvZ0Y0UjkzL1RxRWRxRlV6anRqb2NuQzI0Umpt?=
 =?utf-8?B?YUErY0k2MVp5YjlyS3VPdXNYN2RSUGtOUmt6UTZYNkthb1BxdmJHWWNLNjRE?=
 =?utf-8?B?cGNhZVNjcE9QNHpUSUdsMGp3dnI0TWdnbHhVUUlFQkkwai9lWnFFR3V1R2d1?=
 =?utf-8?B?S21WM0RQREZSWGxsdUdxTDNMN2d0TFBEYXQxQ2NJWEo1dEUvVk5IZnd6Z1Mw?=
 =?utf-8?B?TFBtdFhzOXMvZHZJQWljRFhUYmFTNFk1a3IreVl5QjVEMjVZQUs0TmxiVVha?=
 =?utf-8?B?TS9uckZSYWQ1dzIxc1IrZlhwY2NQNUFjUU5OWFRkNGdqaldmdDQwejBnMkxH?=
 =?utf-8?B?UldESWJpTnk3R3MvZnpzUU1xZW9TbEEwY1Ayb0xqcG9QcjRjMW5oL2lLL2JX?=
 =?utf-8?B?NHEyVXpYeGtaYVFkSk9UM08rZllscW93dXRxMmZFOHlRSS9YUlNLSitxVytR?=
 =?utf-8?B?b01aK0N1Z2hWUHYwMmxzN1ZOSXlKS0hySkp4K05UMnl3WFNvMExOTS9ub2Vt?=
 =?utf-8?B?amJIRkFEbEV4bHdnbFFqN29WRzNpZVY4K0tYSUVLdWVJTFFzQXN3ckcySnll?=
 =?utf-8?B?RjFoTmEyUEhON2tRbUNSa3VVTll1SDdMQlFWbXFpTWh5ME1hUVFDS2tYQzh4?=
 =?utf-8?B?Q0dvcVB0dHUyUVJwWE1TUFVJdWFiQXNYZDV3dzRwTWQ3UmR3SW9ST2F3cXIy?=
 =?utf-8?B?djFNejNMV1VDSlNHSFd0STdDZGpPOUtGOUtYMVRWaUhEeHRrbjF3eVFUOE5X?=
 =?utf-8?B?OGVkSjBwNDA0VmFDcXZnQkZuVlFHVXJab3REV28yam1kMEVQMHNna0ZwN2tN?=
 =?utf-8?B?TllMSEhkSkRDZFJrVTZpV3JkLzVKdUpZRUk4WllETlRSOG1kZE1KUU1Mblk1?=
 =?utf-8?Q?WBjsMitJevIRVr4wj/Fp//D7F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5014525-dcba-45ec-229e-08daa124a998
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 07:40:06.7247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFhs+egBFfhxqcIUtxP8AgEVNmHg309N1vdyS4qjsg60JwGbkTfwQhh4GVyo+eK6506jiRPQFbXfdeKNJf7jhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8158
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2022 1:56 AM, Mathieu Poirier wrote:
> On Tue, Sep 27, 2022 at 02:48:02AM +0000, Peng Fan wrote:
>> Hi Mathieu,
>>
>> Thanks for reviewing this patchset.
>>> Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
>>> i.MX8QXP M4
>>>
>>> On Wed, Aug 24, 2022 at 09:10:20AM +0800, Peng Fan (OSS) wrote:
>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>
>>>> When M4 is kicked by SCFW, M4 runs in its own hardware partition,
>>>> Linux could only do IPC with M4, it could not start, stop, update image.
>>>>
>>>> We disable recovery reboot when M4 is managed by SCFW, because
>>>> remoteproc core still not support M4 auto-recovery without loading
>>>> image.
>>>>
>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>> ---
>>>>   drivers/remoteproc/imx_rproc.c | 108
>>>> ++++++++++++++++++++++++++++++++-
>>>>   1 file changed, 107 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/remoteproc/imx_rproc.c
>>>> b/drivers/remoteproc/imx_rproc.c index 7cc4fd207e2d..bcba74e90020
>>>> 100644
>>>> --- a/drivers/remoteproc/imx_rproc.c
>>>> +++ b/drivers/remoteproc/imx_rproc.c
>>>> @@ -6,6 +6,7 @@
>>>>   #include <linux/arm-smccc.h>
>>>>   #include <linux/clk.h>
>>>>   #include <linux/err.h>
>>>> +#include <linux/firmware/imx/sci.h>
>>>>   #include <linux/interrupt.h>
>>>>   #include <linux/kernel.h>
>>>>   #include <linux/mailbox_client.h>
>>>> @@ -59,6 +60,8 @@
>>>>   #define IMX_SIP_RPROC_STARTED		0x01
>>>>   #define IMX_SIP_RPROC_STOP		0x02
>>>>
>>>> +#define IMX_SC_IRQ_GROUP_REBOOTED	5
>>>> +
>>>>   /**
>>>>    * struct imx_rproc_mem - slim internal memory structure
>>>>    * @cpu_addr: MPU virtual address of the memory region @@ -89,6
>>>> +92,10 @@ struct imx_rproc {
>>>>   	struct work_struct		rproc_work;
>>>>   	struct workqueue_struct		*workqueue;
>>>>   	void __iomem			*rsc_table;
>>>> +	struct imx_sc_ipc		*ipc_handle;
>>>> +	struct notifier_block		rproc_nb;
>>>> +	u32				rproc_pt;	/* partition id */
>>>> +	u32				rsrc_id;	/* resource id */
>>>>   };
>>>>
>>>>   static const struct imx_rproc_att imx_rproc_att_imx93[] = { @@ -117,6
>>>> +124,18 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
>>>>   	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },  };
>>>>
>>>> +static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
>>>> +	{ 0x08000000, 0x08000000, 0x10000000, 0 },
>>>> +	/* TCML/U */
>>>> +	{ 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
>>>> +	/* OCRAM(Low 96KB) */
>>>> +	{ 0x21000000, 0x00100000, 0x00018000, 0 },
>>>> +	/* OCRAM */
>>>> +	{ 0x21100000, 0x00100000, 0x00040000, 0 },
>>>> +	/* DDR (Data) */
>>>> +	{ 0x80000000, 0x80000000, 0x60000000, 0 }, };
>>>> +
>>>>   static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
>>>>   	/* dev addr , sys addr  , size	    , flags */
>>>>   	/* ITCM   */
>>>> @@ -255,6 +274,12 @@ static const struct imx_rproc_dcfg
>>> imx_rproc_cfg_imx8mq = {
>>>>   	.method		= IMX_RPROC_MMIO,
>>>>   };
>>>>
>>>> +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
>>>> +	.att		= imx_rproc_att_imx8qxp,
>>>> +	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
>>>> +	.method		= IMX_RPROC_SCU_API,
>>>> +};
>>>> +
>>>>   static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
>>>>   	.att		= imx_rproc_att_imx8ulp,
>>>>   	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8ulp),
>>>> @@ -680,6 +705,37 @@ static void imx_rproc_free_mbox(struct rproc
>>> *rproc)
>>>>   	mbox_free_channel(priv->rx_ch);
>>>>   }
>>>>
>>>> +static void imx_rproc_put_scu(struct rproc *rproc) {
>>>> +	struct imx_rproc *priv = rproc->priv;
>>>> +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
>>>> +
>>>> +	if (dcfg->method != IMX_RPROC_SCU_API)
>>>> +		return;
>>>> +
>>>> +	if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
>>>> +		return;
>>>> +
>>>> +	imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED,
>>> BIT(priv->rproc_pt), false);
>>>> +	imx_scu_irq_unregister_notifier(&priv->rproc_nb);
>>>> +}
>>>> +
>>>> +static int imx_rproc_partition_notify(struct notifier_block *nb,
>>>> +				      unsigned long event, void *group) {
>>>> +	struct imx_rproc *priv = container_of(nb, struct imx_rproc,
>>>> +rproc_nb);
>>>> +
>>>> +	/* Ignore other irqs */
>>>> +	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group ==
>>> IMX_SC_IRQ_GROUP_REBOOTED)))
>>>> +		return 0;
>>>> +
>>>> +	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
>>>> +
>>>> +	pr_info("Partition%d reset!\n", priv->rproc_pt);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>   static int imx_rproc_detect_mode(struct imx_rproc *priv)  {
>>>>   	struct regmap_config config = { .name = "imx-rproc" }; @@ -689,6
>>>> +745,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>>>>   	struct arm_smccc_res res;
>>>>   	int ret;
>>>>   	u32 val;
>>>> +	u8 pt;
>>>>
>>>>   	switch (dcfg->method) {
>>>>   	case IMX_RPROC_NONE:
>>>> @@ -699,6 +756,51 @@ static int imx_rproc_detect_mode(struct
>>> imx_rproc *priv)
>>>>   		if (res.a0)
>>>>   			priv->rproc->state = RPROC_DETACHED;
>>>>   		return 0;
>>>> +	case IMX_RPROC_SCU_API:
>>>> +		ret = imx_scu_get_handle(&priv->ipc_handle);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +		ret = of_property_read_u32(dev->of_node, "fsl,resource-id",
>>> &priv->rsrc_id);
>>>> +		if (ret) {
>>>> +			dev_err(dev, "No fsl,resource-id property\n");
>>>> +			return ret;
>>>> +		}
>>>> +
>>>> +		/*
>>>> +		 * If Mcore resource is not owned by Acore partition, It is
>>> kicked by ROM,
>>>> +		 * and Linux could only do IPC with Mcore and nothing else.
>>>> +		 */
>>>> +		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv-
>>>> rsrc_id))
>>>> +			return 0;
>>>
>>> If imx_sc_rm_is_resource_owned() return '1' than the remote processor is
>>> under Linux's control and what follows below is not needed.  That is also
>>> coherent with the comment in [1].
>>
>> Case 1: If M4 is owned by Linux, here directly return 0.
>> Case 2: If M4 is not owned by Linux, the following code after this line will set
>> state as RPROC_DETACHED.
> 
> I understand that part.
> 
>>
>> Patch 3/6(this patch) is only to support case 2.
>> Patch 4/6 is to support case 1.
>>
> 
> Let's leave the subsequent patches alone for now.
> 
>>>
>>> That is in contrast with what is happening in imx_rproc_put_scu().  There, if
>>> the remote processor is _not_ owned by Linux than the condition returns
>>> without calling imx_scu_irq_group_enable() and
>>> imx_scu_irq_unregister_notifier().  That seems to be a bug.
>>
>> No. The two functions only needed when M4 is in a separate hardware partition.
>>
>> The scu irq is only needed when M4 is out of linux control and need some
>> notification such as M4 is reset by SCU(System Control Unit). That linux got
>> notification that M4 is reset by SCU.
> 
> I also understand that part.
> 
> What I am underlining here is that when the M4 is independent, function
> imx_scu_irq_register_notifier() and imx_scu_irq_group_enable() are called but
> their cleanup equivalent are not called in imx_rproc_put_scu() because of the '!'
> in the if() statement.

you are right, this is bug in my side. It should be as below based on 
patch 3/6.

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index bcba74e90020..a56aecae00c6 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -713,7 +713,7 @@ static void imx_rproc_put_scu(struct rproc *rproc)
         if (dcfg->method != IMX_RPROC_SCU_API)
                 return;

-       if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
+       if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
                 return;

Thanks for detailed reviewing.

Thanks,
Peng.

> 
>>
>>>
>>> There is also a problem in patch 4/6 associated to that.
>>
>> If the upper explanation eliminate your concern, "a problem in patch 4/6" should
>> not be a problem.
>>
>> When M4 is owned by Linux, Linux need handle the power domain. If M4 is not owned
>> by Linux, SCU firmware will handle the power domain, and Linux has no permission to
>> touch that.
>>
>> Thanks
>> Peng
>>
>>>
>>> Thanks,
>>> Mathieu
>>>
>>>
>>> [1].
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir
>>> .bootlin.com%2Flinux%2Fv6.0-
>>> rc7%2Fsource%2Fdrivers%2Ffirmware%2Fimx%2Frm.c%23L24&amp;data=0
>>> 5%7C01%7Cpeng.fan%40nxp.com%7Cbe679e9a409a48b834b908daa015d92
>>> c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637998312946913
>>> 710%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
>>> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=
>>> JDRvoDGGgEiSmbhj3410V2DNxamZbDmMS0U2GvBnI74%3D&amp;reserved
>>> =0
>>>
>>>> +
>>>> +		priv->rproc->state = RPROC_DETACHED;
>>>> +		priv->rproc->recovery_disabled = true;
>>>> +
>>>> +		/* Get partition id and enable irq in SCFW */
>>>> +		ret = imx_sc_rm_get_resource_owner(priv->ipc_handle,
>>> priv->rsrc_id, &pt);
>>>> +		if (ret) {
>>>> +			dev_err(dev, "not able to get resource owner\n");
>>>> +			return ret;
>>>> +		}
>>>> +
>>>> +		priv->rproc_pt = pt;
>>>> +		priv->rproc_nb.notifier_call = imx_rproc_partition_notify;
>>>> +
>>>> +		ret = imx_scu_irq_register_notifier(&priv->rproc_nb);
>>>> +		if (ret) {
>>>> +			dev_warn(dev, "register scu notifier failed.\n");
>>>> +			return ret;
>>>> +		}
>>>> +
>>>> +		ret =
>>> imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv-
>>>> rproc_pt),
>>>> +					       true);
>>>> +		if (ret) {
>>>> +			imx_scu_irq_unregister_notifier(&priv->rproc_nb);
>>>> +			dev_warn(dev, "Enable irq failed.\n");
>>>> +			return ret;
>>>> +		}
>>>> +
>>>> +		return 0;
>>>>   	default:
>>>>   		break;
>>>>   	}
>>>> @@ -803,7 +905,7 @@ static int imx_rproc_probe(struct platform_device
>>>> *pdev)
>>>>
>>>>   	ret = imx_rproc_clk_enable(priv);
>>>>   	if (ret)
>>>> -		goto err_put_mbox;
>>>> +		goto err_put_scu;
>>>>
>>>>   	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
>>>>
>>>> @@ -820,6 +922,8 @@ static int imx_rproc_probe(struct platform_device
>>>> *pdev)
>>>>
>>>>   err_put_clk:
>>>>   	clk_disable_unprepare(priv->clk);
>>>> +err_put_scu:
>>>> +	imx_rproc_put_scu(rproc);
>>>>   err_put_mbox:
>>>>   	imx_rproc_free_mbox(rproc);
>>>>   err_put_wkq:
>>>> @@ -837,6 +941,7 @@ static int imx_rproc_remove(struct
>>> platform_device
>>>> *pdev)
>>>>
>>>>   	clk_disable_unprepare(priv->clk);
>>>>   	rproc_del(rproc);
>>>> +	imx_rproc_put_scu(rproc);
>>>>   	imx_rproc_free_mbox(rproc);
>>>>   	destroy_workqueue(priv->workqueue);
>>>>   	rproc_free(rproc);
>>>> @@ -852,6 +957,7 @@ static const struct of_device_id
>>> imx_rproc_of_match[] = {
>>>>   	{ .compatible = "fsl,imx8mm-cm4", .data =
>>> &imx_rproc_cfg_imx8mq },
>>>>   	{ .compatible = "fsl,imx8mn-cm7", .data =
>>> &imx_rproc_cfg_imx8mn },
>>>>   	{ .compatible = "fsl,imx8mp-cm7", .data =
>>> &imx_rproc_cfg_imx8mn },
>>>> +	{ .compatible = "fsl,imx8qxp-cm4", .data =
>>> &imx_rproc_cfg_imx8qxp },
>>>>   	{ .compatible = "fsl,imx8ulp-cm33", .data =
>>> &imx_rproc_cfg_imx8ulp },
>>>>   	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
>>>>   	{},
>>>> --
>>>> 2.37.1
>>>>
