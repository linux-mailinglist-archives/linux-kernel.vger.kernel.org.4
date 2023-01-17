Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F096266D9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbjAQJQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbjAQJQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:16:35 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10BC33454;
        Tue, 17 Jan 2023 01:09:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pb96ClEGWpLiPv4WZGWFmKxraYMNWE7JtmX8QrD+ywlcD/Xb6nMEa9Lmsqm5IX4iXZJ0Jn0FWU6i5gxTbExTKdTyu4WBY+qRDJKTeGDzxRsn1N3wOkNekmSR5okMFdti1Cz+uoicA8h1kQa6VoxoJ+w/SVgfB4tHpmGQSuzv/nzMjkc8WVIeQt/0mDbJ+y3iPTDAf1Hmx1BWYJGLLgYkJ9eRlGDzCLb9yy2w9bmgc7QvQxF0vfbDjU3+atL1bvdMmdGa4qVC4pfjGj9jSqQFVx7X1IjxdXyExNJw9jZrKIQc+rLml3/MF7tdflZaOlpy6AbqnaDP9vYMITpvUFbzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NPopPAK6ZpYrhaQqLQ8fmDdseCZIe4iDOAzTPyxeXA=;
 b=azCuKpB0jYDZ5z0B1oVJUCJ+CqG0WuiE5Zac/IaKCrsLj8efFM9N8IBbPM/d3Gf9lesvdn9fAK8yYwfpASubOj0lfjFgz44XW82yHZ7NSNmPDCemYE+8TENr5JbxUc+PPR1dN1ePugm2+XOLg2awh0Al/yzCKxXjhf2BSheGCnSIpAlaRvJOZSUsooxr+g4zszInn7ZXuus30mW8rGqGw9pwurvdxUmNRx6CcN5ecMgfXxpz7aOopzhkAwSxtBKoAFYz0xrCMSGE3f+bh3rxfo427OHvPtWyK/ZwUmGWUmsPn2ba62w3UipCdG9XegLWSP3hXhgyazPjTmBtLPGb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NPopPAK6ZpYrhaQqLQ8fmDdseCZIe4iDOAzTPyxeXA=;
 b=pPuZG5n9Q3pi6+c+GFGs2tQqiOZkt3ltRbcHg/EjEkUd2MD/w2UBW0bEUHS9ksxI42uiHhldDl0R9i6QZMXhQ8fVFkPlNbyDJo9YLXWMtMj5NuSMgXuvowWCWP/LmVTR3ICboT/tFyge+UaghWpNctb3fFPIC1tGNneTjo8HjAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 09:09:21 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%4]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 09:09:21 +0000
Message-ID: <2e594495-0eaa-6580-17eb-16f5db76865d@nxp.com>
Date:   Tue, 17 Jan 2023 11:09:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] remoteproc: imx_dsp_rproc: add module parameter to ignore
 ready flag from remote processor
To:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        SOF-Team <sof-team@msteams.nxp.com>,
        MPU AUDIOSW-AUDIOSW <Mpuaudiosw@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20230116225343.26336-1-iuliana.prodan@oss.nxp.com>
 <DB9PR04MB935597568D763916CA4ECA13E3C69@DB9PR04MB9355.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <DB9PR04MB935597568D763916CA4ECA13E3C69@DB9PR04MB9355.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0160.eurprd07.prod.outlook.com
 (2603:10a6:802:16::47) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|DU2PR04MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fae5f5-8e38-4058-b4f0-08daf86a8549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h86OSHHHM14ULKrqSL/SeS4KnSewhVxlA04XXeeRFUHDUfejwsa/X0DVytJ1bCxanBmGkwVJo5X1BhMzPy6Jt3wlBlBTEqjpTnZW7MEw1kX1UCH9gI+PQnnLhq+dmu+POy/UgBL2WjxKZcIS/Og6r+c8pgmC2k+9ZP43v9jZbh1dptjf3YSPPAOdvZhwAiA6NNRNWykZMNvYiGTJ3YyItdTvys2VYRCkQTZhd7iBCigb9yTgxFUKm1z7/Jx3nndIOcSFNSBDcjqiz2bcxMeVX7hjHKjac1BICT5T7srEIyLl1hzrIO7trFA6nbpFZDmJ0bVimbAhAe0tGZZV60F9rJq0wtxL7rhaDg3LHftypvgc0wsWJaX5Ev3P3lIs1qUE4G7cYzrA9KdTA/m5AYALsDznovE+5NmkDqfuBV+GXstnUM7qWMl1zTN8ops6e7idCkoYiF45exYCwzwvu1sD2nVPBNlVhzI9B20j60QZIB6NS4Jb5DWp8NMPb7zBkQWxyMx11xcwYSRr0fSlsp9KFwzp0+faFoE9ddni8eLVFmalWDFGI1NtsFnFa5g0j7JIn8+S4r38YOI4+JnbDSmR03Q9znexZjpqgillsgnfkPmqPoXMY+rWdVFHUO6BmG1F2OLNXY3I4uK6umiu7ndQJwQyMGFn2bqiEkkBNsn8oJfkoWeVWXJOlyWVMlne5taS8Y4ARq/MGnqDTwtRngaCCTYu27wAXqUskuL0USklZzDnF5RdkWtjzuxuEpI99ywi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199015)(36756003)(31696002)(86362001)(2616005)(4326008)(26005)(8676002)(6512007)(186003)(66946007)(66556008)(66476007)(41300700001)(83380400001)(316002)(921005)(6666004)(6506007)(110136005)(54906003)(6636002)(478600001)(44832011)(2906002)(38100700002)(6486002)(8936002)(5660300002)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amcvdVc1VWRBWUpoUkdrMU9rcXFMMDBMUkFHUHEvVFNNS2R1NnFzcFRhUHlI?=
 =?utf-8?B?KzNPQXZpN3h4TVpWRWF1UmRwSmxZOGMwUHBHd2dCTzlKSkNlVDBUUWExNjZ5?=
 =?utf-8?B?UXNkM09wdndFN3ZXU0M0Wi8zUEIxT3FHWTZVaWFWQlF5YkV5N0hvRFhQL0Ri?=
 =?utf-8?B?bWhRVzZ6WVp2cVdSUmR5aTJZbVZWZzBOaWtEMEpYMWJrSUtPSzN4dXRZUlpp?=
 =?utf-8?B?Y0RKeFZ2alFnTU5xck1UaUUyWW5jVkVHNzdkVXRlU3Y3NFpDUkp2ZlE1c2Zu?=
 =?utf-8?B?aFJRSW1MUnJoNzQyZkwzN2cycUJzWUwvbjMrbExzZEw4SDlMRWR1NEJoamFP?=
 =?utf-8?B?VGdQQW41OU1KUTZ0RVFYWFRZWDhxWHF5UGlpUC9ESnV5NUZqVm9mZFNxVFJN?=
 =?utf-8?B?ZFlQbzZvR2xTdFVrVWVLRGNDbzd2cittaDVUenc3OGlaUXNhYjFSSWNjMktw?=
 =?utf-8?B?YUFzajJaRnVKUnQydi9MTFdDVXNBd0ZmSktGeHFKdVViMWhLaWJKRWdlT0dT?=
 =?utf-8?B?WGcwZHVZL3hOTzNzZlJQVTNjVDNsTkdBbnpEYVZxNFBVSFd6ZENDeG5sVHBH?=
 =?utf-8?B?Y3BhQVlqOTV0b3FQdzNFaHBtYmd6bWJLemYrcWdjMlFwdWFFZ3ozbFR0c1Zy?=
 =?utf-8?B?NG9VQTdQMGprb1VSU2E2bHh6RS9wSTNpS1JRdjM5d1BXNVhYdzZFbit1THE5?=
 =?utf-8?B?QXZLZ3ZrYzQ0UGRGdlN3Uko3blRudDNKVzBsWXc5ZVBJZ3N4Z2hNcnI1YjVC?=
 =?utf-8?B?bm9QK0V5eEZOUitSWWtCdjhXcHY4bGZwOE1SMUtxTnpPdm50NmF2YUV3Nm45?=
 =?utf-8?B?QlQ1N0dvb3AyeHUwbURNNkxNaEJDeWFKUUdaZ2pIbjhRaXhSdE5DVXY0VS9Z?=
 =?utf-8?B?ZXA2eHlDTWJOYkphcmJzdFdhRGRsNStzbVk5S1kwdEppdVZsSDJ0dmhyUFg4?=
 =?utf-8?B?WXF2aG9nd1dsL1BYSjVpbGhWZmNuU0xJNXpCbSsxem9LbWl3TzlaK0NqcGxS?=
 =?utf-8?B?MWRlM0tjaEx1V0pKMHovZ0o3UThZMkZ4eEd4RVZOeDJuQ3NLOG5ISlpOTFpo?=
 =?utf-8?B?eTVoOGZjQmZKcjY4YnhWRGhrclNWODZNbTRSYm0yTTZDRVMwZHc2UTV4UTVT?=
 =?utf-8?B?SGNZUnk0dlkvS0xUOXNQbHIvMFdEbnJQUWVuRjF2dytaR1BnWUtpWUt3ZGFj?=
 =?utf-8?B?Q2xIb3gyUlFFdzBkNVBydlErTi95WFlDMTVRRTM2MzlUeDBoQVBVS3FrQ2p0?=
 =?utf-8?B?QlhnbzZXNEcrVS9IcWladitnTFZFVy9tUDVWR3JDSmRXK2w2QUlFdXpjbmhD?=
 =?utf-8?B?ME1lZkJYeUtnWkJ5eng1ekUyL3RhYVJZdkovZzBIMTc1WVlpc3ZjL1EvMnAw?=
 =?utf-8?B?eVEwSWZiWjJTV3dscmk3Y0RtTnBWdlpIL1F4YWxnMzRJLzI3a21DQm5vWTRF?=
 =?utf-8?B?Z01TcjBhNGZoLy95MFRRVlI1bjFHQWxJVTRLcW9mN0tMWStrZi8rUlBCZys2?=
 =?utf-8?B?NlIrNnQycDBmNWtjV1NMQ0NBZlhPL2FJS0RkMk1MWHo3YjhWcW53c3Irc3Rp?=
 =?utf-8?B?ekJCaitYTytTNnRwUllhdU1qR0RVaS9IMm16dHIzWEJhTit6K1dsakU2NUJQ?=
 =?utf-8?B?Z21NY1h5S0lZM0ZGVXgrR0l3RUljRFZnTXZwQUppVkVZSyt3ZHFvRDI2OVFY?=
 =?utf-8?B?Z1YyRHR0ZjdIN0grZzBvTnpTK1dKaUE4emZLOFVZUm44UnF2L0MvRm8xRk1R?=
 =?utf-8?B?NkgwNVFjT3IzdnFVWDcybzRSV3ZmWExwL1JDMDNPVnQrOS9TWGVTeFU5RVFx?=
 =?utf-8?B?N0xMbmJhZTdEV0dMYi9OWG53RVZVUnJFK3F1eFJ4V1RJd3ZPTU92di85QXV4?=
 =?utf-8?B?b3U3MmorUFB5ZnU5dmtuRTBtc1ZLOFhZY1pWU0ZjekF3L2hOeHJlTlFFdGpi?=
 =?utf-8?B?TGFSOVBjVXF0ZHhOdDcxL1N0dy9BMDFici8wK3lDdG1vdXMwZUkrQXVsdFBF?=
 =?utf-8?B?MnJlcDl2RzhFT2JaUTI2VUxwNkNkUnl4dEFDb0ZRVUY0L3phZFFMeWc5WEpQ?=
 =?utf-8?B?eE1SWVlBRmg4ZEUrQjVRQUhUNTRHdTIySFl0dkZ5UTZLUngxRlVaenFVWDVT?=
 =?utf-8?B?VytRb0krTWtnWGxKMWF3bzQxY0NacFpIcDkwMktzWHVDSG9QdUl2SitvRVBn?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fae5f5-8e38-4058-b4f0-08daf86a8549
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 09:09:21.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rxJJO7c+PDtHpxutS2qRjOupRrf3YQbHSF9dOG/YDdLNuZ0MyWEUJui+TbsBFyjdjE7cneVZ73U/qEyz/6a0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2023 9:36 AM, S.J. Wang wrote:
>> There are cases when we want to test a simple "hello world"
>> application on the DSP and we don't have IPC between the cores.
>> Therefore, skip the wait for remote processor to start.
>>
>> Added "ignoreready" flag while inserting the module to ignore remote
>> processor reply after start.
>> By default, this is off - do not ignore reply from rproc.
>>
>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>> ---
>>   drivers/remoteproc/imx_dsp_rproc.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/remoteproc/imx_dsp_rproc.c
>> b/drivers/remoteproc/imx_dsp_rproc.c
>> index 95da1cbefacf..ec298f8b019f 100644
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
>> +static unsigned int imx_dsp_rproc_ignoreready =
>> +IMX_DSP_IGNORE_REMOTE_READY; module_param_named(ignoreready,
>> +imx_dsp_rproc_ignoreready, int, 0644); MODULE_PARM_DESC(ignoreready,
>> +		 "Ignore remote proc reply after start, default is 0 (off).");
>> +
>>   #define DSP_RPROC_CLK_MAX			5
>>
>>   #define REMOTE_IS_READY				BIT(0)
>> +#define REMOTE_SKIP_WAIT			BIT(31)
> Can we use a close bit with REMOTE_IS_READY,  like BIT(1)?

Sure, I'll send a v2.

Thanks,

Iulia

