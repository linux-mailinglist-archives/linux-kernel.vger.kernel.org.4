Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E985672D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjARXzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjARXzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:55:22 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF100A24C;
        Wed, 18 Jan 2023 15:55:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHYl9eA+CC/nhPv831HGr8swMT5DgqO0InjfMiTx9DCYK4W9qoJhlAIDP3jbnAfdNTSNrOtVTnnVvsMzvnAcVJG/x877mc6bXLJKDNF2u98bwJcZFG8yqzrsnGhqMncCj7jgzrxfmvshir360HfHxEM4uWHE9mB70aa7EhE5bB54VCUxgc+mS9Xb2oPuZGSmdWTN+KM512tphh03Tug0VvU16TEPlcsaKFzFEqPZKsyKEjK4zF0Qbuqbbvq+Du41znuXaDKQ+eW8YNq1hHZpKfEpviSUblj3uX3H20GI8pNDQa41DDTMhboNAIm6uJthdz5emruWFV6cF2VJxrD5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5SkW45KZdw85C5pxXUWbhT9YfYh/S9lvQp/hfuR5p8=;
 b=J6qyaMz2sZpcPDcvLZTMDq3R5SU9Awzjw3VFqgaSiUVgHRN3QZ4y/L/XV6s7s14a6BPuT09ZMka+3RzZBieHS1Wt9Opy5tGMxE9cWH0A9p8JtJDDZKsDpou2YZ1TgmZX4OSpAQhv8FIB+1lk+p6k57DVap1GbbrTsQ2v4o58Ui2/1hcvwlXGmDBFZ8h3/Ctqd+cpmSqIt6YwDu630WV242kNCUFssDiZZtJxKTvjBh0doAdOYvtp5+a/rGs52U4MP4zyBkj+H+tf+t2Qtk9vAOtGRDimGPlppLGtr4Cbw5+HIK/qaIuxUe+O4lee1xco+u2n9gyz0uHVdo7DQOF2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5SkW45KZdw85C5pxXUWbhT9YfYh/S9lvQp/hfuR5p8=;
 b=OaSF0p5XIrmMtzJNQw0m6liNZ8Yj6EuC5vIle7RyDbYFHnSjKscjAy36jWeKY7M5P9Zc13Cc6QD4B2KC0lc+rB97l7WbcVvZbqykkGg/mW6Xf48wcCwOM3Juoqk4YFJqvNCktVa8WCx2UxWrNDaCeruL2Alox7Abg8drVTE5He0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by AS8PR04MB7527.eurprd04.prod.outlook.com (2603:10a6:20b:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 23:55:17 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 23:55:17 +0000
Message-ID: <8ea4ce87-ea35-56d3-31e3-40e570425653@nxp.com>
Date:   Thu, 19 Jan 2023 01:55:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] remoteproc: imx_dsp_rproc: add module parameter to
 ignore ready flag from remote processor
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20230117110357.15091-1-iuliana.prodan@oss.nxp.com>
 <20230118172416.GB3394216@p14s>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20230118172416.GB3394216@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0015.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::10) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|AS8PR04MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 92786ea1-4efd-4ca8-c783-08daf9af733b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 13Zr0OmVWz0x9Ew2vbN5ZRWjp/CgxW57m+hkE7NwaRmZ6bjaXDjublIf3AuNXvAfIMjqTsaSecCQ0a4NLld5O67Ilr06IJQqkF0+10ey+Efxu18Tma9dlmY0G4Jy/jknXxa5B9a7DT5ZxJq4YITkvKmCGhzeOon8FutHoosG0x2O9gba0SlHxWPIOK1R8+LmTgRiMhpULwpXBmhhOXPdI4ORf45gaMv0cxjJNGoDJi+hUu091ZEVS3UGX1TDgU5tsgxZgDdrVjxg0/fgVRrnWgDawBKQruypfFXedpda25f9jWWP87fmui+viwVzsqhH/2cMjwNp+y3wEoAJR/ZlmmJef9/lXDpbJRBFGczCQvw6IfjMQv6PH/oiTpqylVzaNoJ7f/VplTV8ZCoCz6idVebcL3WP/FQ3POjzRhBJYwmhESviNSmuQZbwIU9Q8wk3Eh0lRkkom8EDSDh9r9kL8f5eO1yZuqU4dWRvusipta1inkD1V6YDJEZpAD5fVNP4tSVYWHjZj9AaBd6V7f1/b23Cm41LF2W9BvQqHcyowNFqQgucKjXXGak4+Ui8fVIhD8LM0UHVbTY2yqya4RHbmSpv5idRoagu6BGS9pmqlJbB9KK36UOq4GqiejX5Nua4iIqNf9BpQxQUgqmrS7M/cAuYaLEfDh8ZnWw5ag+hdhfx/nf7ExtlXSnMdRgOh6KOWkIFCssAhhcisemyYDSXJYXL9brp52/MFlU4SKyRpMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(31696002)(36756003)(86362001)(55236004)(53546011)(6512007)(83380400001)(4326008)(41300700001)(186003)(8676002)(66556008)(2616005)(66946007)(66476007)(26005)(6666004)(6486002)(316002)(2906002)(110136005)(54906003)(478600001)(6506007)(44832011)(38100700002)(5660300002)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWZGb2VqeE1sc0FTYXVGLzFqMVg1NUR1Wi84K05ZUXRWYVdVNS9IM1NrVjJ1?=
 =?utf-8?B?cmJsWWVMWjJlZkNNcmR4MXZsaFVaMFFrbG14ajlHaUNwbm5adGFvQWhyeXNW?=
 =?utf-8?B?MXdiUDNBeVhxTTFoRG5NYk5GMUUwMVBxN0h6TUllNGdmeGVKbmxlTHVEWVFn?=
 =?utf-8?B?YlY4eEJPSm83Sm1pam00ZHl1RTNCSmNRQ0hCZ2s4UzBpdi9welBVSjJIYUdo?=
 =?utf-8?B?cEtVVW1sbDArM3RvdHVhSFNsQkJ5RllOWEk2Q3Y2ampqUFFCUmRNdHJLYytu?=
 =?utf-8?B?SlZFb01qUDRVVDNtb3dWcWRmU05ibE5PbkMxK1MrTWJraWg3QjBDbnQzU0Yz?=
 =?utf-8?B?Vmg2d2VqT3RlSFMyOGZnSFdSQTZkN2tvc1V1VGxjWlJiYjFnUDNyUEp4bmFV?=
 =?utf-8?B?WXFyQWkwa25xSElzZDJSczdBc0h5T1E2ZmdjVGdBV1J4enZ1d214OTRIUjZF?=
 =?utf-8?B?S2IvdmU3Y0d0QzdkcEJnWldaekl3L2FnWWNuSE9lYzNqay9EZjExbzhZNnBI?=
 =?utf-8?B?TWJQd0ExZmFJamh3VXBGU0N2Nnlkd2wyMUs0Wk40dG9CYm43NmN1bEw3WkhK?=
 =?utf-8?B?TmY5ZlpkQXhrMVFQNi9JZHhlSTFNTkJ5SUQ0NVFQdEMxR2dpT2hueGQvMmZO?=
 =?utf-8?B?WEhuQ0k5eWpvb1hRbzNOeitNWnVXTVlQd0tBNkx3bDk4RTNJZDZCdWI4RzJs?=
 =?utf-8?B?d1JvY1JCTFB1QlRlY091Z0taYTBGNERvY2pCWUdxek9ZQjRzcmEzNlJmcjZJ?=
 =?utf-8?B?dy9UMmhxMmFlNkU1U216RDA1REdpVTA0c1lKaDJVcWdlL1BqTlhOVitOVkJI?=
 =?utf-8?B?cXUra0w2amt0ZnN2RWZtNFZlckx4ZG9NVmVoaXR0MDJ6QXZseEhEQmN5Y3Zm?=
 =?utf-8?B?dHlFY3A0d2JBV21vZkZ3bUEwaEtBK1RiMnJ6Q05TVHIvNmFPVW0wa2NBTjNE?=
 =?utf-8?B?MkJFYXJkUUl2OXhJT0MrSWVWTXUzSCtVRU5ZVmtvSU50VDFyd0hNdmVYU3Vt?=
 =?utf-8?B?QVhPMGRwQnQrMXNNYVQ0SjNYK2J4Q0VLZnUvb1pmZzVWRUx5MFRqb1lMMGZJ?=
 =?utf-8?B?dUllNENNeTE1aFVPNTcwUUZUYXdrMWdSdHp6QnljMG5GTXRwM01DL1J4RnB3?=
 =?utf-8?B?czZtS3g3YTJsSVNpcVFwMmszNnJPdzRHR0UvYVl3blNTeDlHN3JHMnEzOHZh?=
 =?utf-8?B?aktadWNORkk5ZEZ5aHV0bWszYXVXUno1NUFqMzRUZTlVdHl1UENmZ0NIZUZi?=
 =?utf-8?B?VEJOSk5vczI4SExudEhaQTM2N3ZJUGdramlZTkNFaEVqc1RmWjFTaEE3MVJB?=
 =?utf-8?B?QTN2QXVwNGFNdWUrTEZQOE9vSUE5VHVDYkZhd1FTSEFzZHZPdE9MQk1lU0tl?=
 =?utf-8?B?c0ZqOHFtUkNFL1NBczVlSkhmcU1xeVdpeWt3ZkcwcjJ5dnpndzBCM28xWkJo?=
 =?utf-8?B?VFdjclJoeSs5ekZEOXJxc0FENEdiZllRNFJZOXlUMzU5UjVPS1Q2ZHk1dSt4?=
 =?utf-8?B?U3BjTFlvZ1RqcDVSV1FmaXo4d21GUFJPS2dNbklza3REMGtBYktIQlIrcloy?=
 =?utf-8?B?Nm1NdlFyKzJJclVNL3RyNyt4M2RzY3ZWMjlTbnRuejB4SFFSc20xaVp6QWph?=
 =?utf-8?B?ZG01MElMTThJVzlJSGpHenJnSk56ZEo2N255d3NGVFFVTyt2M0hNeHdjNW11?=
 =?utf-8?B?SkpWRm9icUNLY2tJREVtcDM3TU9aaUNHdWN4OVQvS1Bsb21USGlOd1BuOExH?=
 =?utf-8?B?bXdiWG14UXhMNEJXS2RtaDFGRStORmdoWSs0eVZ5NmQ4cHU1V0NzaTQxd2NZ?=
 =?utf-8?B?NTNIWmRQM0krWHQ4UlFlMlBESkNSMnBQZGtGSTQ5UmdLazBzc0tJZGxuRkdW?=
 =?utf-8?B?RGdTc0h2NjNkek5xZnJwQThaTlBoNVFBbHREajR2cm4xTkpoTGtHTkN2Z3FB?=
 =?utf-8?B?S0ZyUG02MTVQcEd0ZHljbkJnN0F4TlVmVkIyVFoyeXdBN0hRc3dBUzZqb0Vx?=
 =?utf-8?B?bFhYMGl0citEMzNMTU1CSDJYcUpEeWpsL3lRTUZIODNUM2pDbnhaei9samo2?=
 =?utf-8?B?M2VITkN6TjJDV3V1andIWEhWUDUwY0pORGZBbUt5UnZ4V0g1T2p4WVlaZVFM?=
 =?utf-8?B?N21WOGJEcExrWExqSWl4OHJBb29lb0g4UlZjeCtzNEErd3orSUVMQUgyOUxS?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92786ea1-4efd-4ca8-c783-08daf9af733b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 23:55:17.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGUYomPCKi/7yBVAZVzA1BOWRaNn4PlUko0KxNQ8g0B9GVH/rVAbkHrB9f++oeG0PTkDlKGb39BF6Hwpmk+QkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7527
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/2023 7:24 PM, Mathieu Poirier wrote:
> Hi Iuliana,
>
> On Tue, Jan 17, 2023 at 01:03:57PM +0200, Iuliana Prodan (OSS) wrote:
>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>
>> There are cases when we want to test a simple "hello world"
>> application on the DSP and we don't have IPC between the cores.
>> Therefore, skip the wait for remote processor to start.
>>
>> Added "ignore_dsp_ready" flag while inserting the module to ignore
>> remote processor reply after start.
>> By default, this is off - do not ignore reply from rproc.
>>
>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>>
>> ---
>> Changes since v2
>> - s/ignoreready/ignore_dsp_ready
>>
>> Changes since v1
>> - change BIT(31) to BIT(1) for REMOTE_SKIP_WAIT
>>
>> ---
>>   drivers/remoteproc/imx_dsp_rproc.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
>> index 95da1cbefacf..22e2ef068c67 100644
>> --- a/drivers/remoteproc/imx_dsp_rproc.c
>> +++ b/drivers/remoteproc/imx_dsp_rproc.c
>> @@ -26,9 +26,20 @@
>>   #include "remoteproc_elf_helpers.h"
>>   #include "remoteproc_internal.h"
>>   
>> +#define IMX_DSP_IGNORE_REMOTE_READY		0
>> +
>> +/*
>> + * Module parameters
>> + */
>> +static unsigned int imx_dsp_rproc_ignore_ready = IMX_DSP_IGNORE_REMOTE_READY;
> Static variables are initialised to '0' and as such this is not needed.
>
>> +module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);
>> +MODULE_PARM_DESC(ignore_dsp_ready,
>> +		 "Ignore remote proc reply after start, default is 0 (off).");
>> +
>>   #define DSP_RPROC_CLK_MAX			5
>>   
>>   #define REMOTE_IS_READY				BIT(0)
>> +#define REMOTE_SKIP_WAIT			BIT(1)
>>   #define REMOTE_READY_WAIT_MAX_RETRIES		500
>>   
>>   /* att flags */
>> @@ -285,6 +296,9 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
>>   	if (!priv->rxdb_ch)
>>   		return 0;
>>   
>> +	if (priv->flags & REMOTE_SKIP_WAIT)
>> +		return 0;
>> +
> This looks very hackish to me...
>
> Here priv->rxdb_ch is valid and as such the DB mailbox has been setup, which
> contradicts the commit log where it is stated that "we don't have IPC between
> cores".  Moreover, the commit log mentions to "skip the wait for remote
> processor to start".  How can the remote processor executed an sample
> application if it is not ready?
>
> Lastly, is there even a need to call imx_dsp_rproc_mbox_init() if an IPC is not
> needed?
>
> I'm fine with the module parameter but would much rather see a solution that
> does not configure any kind of IPC related mechanic when it is not needed.
>
> Thanks,
> Mathieu
Hi Mathieu,

I've tested this with hello_world sample from Zephyr.
This was loaded on a hifi4 core from Linux using remoteproc. And, with 
this patch is working, otherwise I get "can't start rproc imx-dsp-rproc: 
-110:" because the ARM core is waiting for a reply from the hifi4.

I agree, I shouldn't initialize mbox if there is no IPC between the cores.
I'll fix this in a v4.

Thanks,
Iulia
