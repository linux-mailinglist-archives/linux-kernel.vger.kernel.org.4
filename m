Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67D85EFDED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiI2T3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiI2T25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:28:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A79315E4D4;
        Thu, 29 Sep 2022 12:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQXalQwt1zg7/bCU7iHwswuuIooulC07CgdJwfNplFomEAdrmbNZ1MPQXTk7gffxT4czt3/SY+1tsyNwq0fTOykAGw8a+16uqGjBdZK6aJdKw68DpUREITzhionkVry9bRN0eH68KBRS+WLO9aRdNVeTow9I+STWzp7uk2oQPCM3a8g88ZaS65XqBjfesAyj349ayAsda1mN2r1mth7vxIrGW4MhF1QbTodJN0Z/uqJX7fKScnq7B71tEYkoUt+JTPxuv8DXMLvqjxTlg3BDC7n2ciKpLuLFVL+AGd4zwV00MNGv3j1rSMCfzjTWrOwA563IEx6cCCk8ftttTKuf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AMugPJ5thtiPGcZ3zQxt+dLF+3jtw/7+G+MH/wRE54=;
 b=Igp3BnQ4EDEbnGe5f1cbhueqZde0re2Y88Z+qTygFIbRLNDLe+1xhmUp5ocF6iHdH10ZWSJUai67OzgOrldrbHfDHW+RdeAbi2q1NGwwO5fXBNXXm2DgSVrYMn8Q073dF9hNVtH1HW20aVe7mt8jYauMHnYuO1VopB8E9ha2ml8Fub3xPQKQSxkeX3xULjOGz6tNxylRIqhSHOzQ3lCphytjjVEkoEh2pSexfAs668CQ5eNRWi1MKfp93k3l7ZROJo4UUB1RKHwCBZIDUc4GhfJonj5f57jPu0rc4cI9HVck1vikuFEW7SWVNEgszWmX9nrronGN99t1Idlj0d8o7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AMugPJ5thtiPGcZ3zQxt+dLF+3jtw/7+G+MH/wRE54=;
 b=FInZTZwmvSVUf6JIoFqaBEt2eHMZ/v12od/jBhqcN+0c9IYYTbbLzg/Q3O08eqKEQALdc+F1ZzyidKhtxaxgIXA+r1b5qFk6q1d+3KKpwn3XjMNn404LM5X711Go6uUQkDNMNpghiGBHXvWvnG9ENWGOMYRNgP86DkpzRFNs6xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18; Thu, 29 Sep
 2022 19:28:52 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988%6]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 19:28:51 +0000
Message-ID: <fa91ce5a-8c7e-850a-eede-1f6a61a3d651@amd.com>
Date:   Thu, 29 Sep 2022 12:28:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v9 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        ben.levinsky@xilinx.com, tanmay.shah@xilinx.com,
        michal.simek@amd.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
 <20220708013955.2340449-7-tanmay.shah@amd.com> <20220901202517.GB626605@p14s>
 <d1cfa787-9f8e-fe8a-d816-0bd8c3a3244d@amd.com>
 <20220929172200.GB3107608@p14s>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20220929172200.GB3107608@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:332::32) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a48fc20-174c-40d7-5cbb-08daa250d71c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQ5SuWpPKBNMCxOhcHxK0EVqM1QqapF8oi54Kf4CxryiMieKwqpnFwKtxxtu5Zmsr4vYIPmF0u/cH2ItVp5eMMfyEaxxy2mBIvzGq1oSTHePLigKqUR0C0Pk+kslwgObc3/lY3zXuIDYyxHMGTP484KGBP4RJx1AwqnX+FTBU/M8/S/GBpQ5gBru7HQwJncPXkg7jnAW+KDTPUOTZ9qPXRG2KK/5Tp56FKOqtnKxWPZ9TOH1xX9iHRC64vCQaa8jrd0BXBkwHLGfwU/lsKAsf01Khlulq8mckJfaSvIG/78m5a+PZO8hKkJZKooZarf9czrNMY2WjSpewPmXyuli26qgrrLeIoraGMI2LpNeSiwo56355oIYt+19hkZ/1tIvRt+mzWu7VVA3RJoRFIjl3UZDuw2lxdpR1cI4cyaMgZXxqfIwaxIGpbRz4slw/emSIvcpPHivUNQBfEQW5yCV9lszIEhRaYkYjJgzIkfBNptj0p54YOhGj97HKjWm/8RC+NCaBq+sUeHFcTuKiW57mbfj3QQXEW+9ty26JfaCAEv5Lk8yzNNSQXAfJm9a+dg1nXDPyBjiFt4L/fAU7LvCoewUnhzdPfznW4gbv4L9u0fTHi9CTIM5/rqBGhZS+GOaiSl1r6wx+N6kpiyZkOaGyWZ1XxVYnJUSy4ui84Si9/dXsJ0F/nt/BHBUJcxTUh+MdauP/YdeyXJhCpBdqHP/tAFlvJ57/awxNlgS8h74CaOfY8VnrKwlapJG7/r/yZl+IpB4rAv1Wk9Ere3ykJtSi8ZFYehzGWw0lQFVtEisC+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(31686004)(66476007)(26005)(6512007)(186003)(2616005)(83380400001)(36756003)(478600001)(6506007)(316002)(38100700002)(53546011)(4326008)(6486002)(2906002)(6916009)(8936002)(5660300002)(66556008)(8676002)(66946007)(41300700001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blVoekRuSGhXWlRiaGp3S3RqNTFUbkQrdFYxVU8zYWpGMXNRVXlJWlZzZkU3?=
 =?utf-8?B?Ky9DamtBMHpVbjFyZ09OOWJhaWJNNTBBdHdIbkRDL1F4OFhaT2twMjBhcDZo?=
 =?utf-8?B?ajlwUmE0aWdEQUh6Vmt6dWdMNXNPZDl2YkpDdEVzUENBZGpLcU0xSTQ1bFFx?=
 =?utf-8?B?Zm5tWFFwWTYxK1hQZGNCZzRRYURoMW9VRkhvdWgwWTZ4aklRZ3B1OHA1djMw?=
 =?utf-8?B?TGRvM3hCQTVRRUhndldZSlZhZVptWHZWK1hkV1lkTDJsbEE1Y0x0MlRuZFZ3?=
 =?utf-8?B?VUxxNVNKZnh3ZU56Yy9pN294djJ6NFA4aUtxalJnemJsV2lydWRBZHFhWWov?=
 =?utf-8?B?YmVjNkp5bHdmdGplbndHNmNULzVKTHdtNUtkY0kzbVFVNUtFbUlMcjg5RDh6?=
 =?utf-8?B?b0JRUXZBTmdFaGs1MjFNWG05eTA0ODZhNEVta21GSWkzTERaUnJMSE93LzhN?=
 =?utf-8?B?VkNMQzRHczNpWnc4RjlrMWNSTmNrQ0poTDNnbmtNVE5oOWhmRGdoeHdjNlZs?=
 =?utf-8?B?N09KdktsaE1DalAveThTWUpVY29DNWpNbDRiM2xFM3lRSFZlSTQxaUNWSWZ1?=
 =?utf-8?B?OXA1Z3A0bEp2Ti9XZUlCTUUra3IxNkQ3c2dPWFpzd2ZoTmNRMkNwSGx5UzJN?=
 =?utf-8?B?N091ajBvT1hJbHcvRndScEZDM1kxWmZXUU8zb1hrNGFLblhReCsxeHAyZXcv?=
 =?utf-8?B?ZW1mZFBCck9QZm5YQWNTQzRrdXh0SC84ODlZVmZmTFBDMnRDMWlJcWVFbGZy?=
 =?utf-8?B?cnZ3a0tZOVZYMzNmTjZNUzBCOUZLZ0tLVnRXWDIxZFZneTVjU3ZpNDViblFO?=
 =?utf-8?B?Tkw2SEx5QnowRXRNeWhsRDFvYSt4YUU4ZUwvMmttUm44WDFqbGNJNS8wMktP?=
 =?utf-8?B?cTFOelF5VGRsYVd3Q3ZaR2pyQURMN2pMTGhBdlFycHdRT2JxWmJ5SHd3TmRI?=
 =?utf-8?B?QkFIcFMzeXdPdmNXUWczZEdMSWY3a3pmZlU0R2RyRnk5clc2MEFVdmRYdWR5?=
 =?utf-8?B?SVg5RVRtbGtZQW84eEtselVXMVc0dDM4S1pvb253bFdpRHVCaUI2Ny9kaXVI?=
 =?utf-8?B?UC9WdnZxUUpHR2JVTlZhS1d4ZWg2dGI4ZlZaTy9kcVladjN2L3VGSGRrU0M3?=
 =?utf-8?B?YzExVHE1ekdVcnZubzJiT0ljU01PWU05RzQrdC9aaGo5WkdPMlcwb3pEL1J1?=
 =?utf-8?B?akZJc2pCZzdleWxCZGdDQUdSZDNoRVFTM1B0b2Z3Rnd6QU5Vd2daSFZkNmox?=
 =?utf-8?B?d0gzSjZCN3lDT0FvOCsraTQ3Zy95MjZhcDhadk9Ed3JTNlpIL0JFdko5S3R0?=
 =?utf-8?B?MVpTM3Brekg4eTVjZGU3Y3EzNExNSDNtbWFGcHpxcEpXWmZiVkZUY25wRTF5?=
 =?utf-8?B?TlVUQTM2a1FWYVlDS0EwMmI0bkxCbm9jTFhMRDB0NGlTVXZMejJhcXhXdEIr?=
 =?utf-8?B?b0hYbVQrZGp5NEtTR09MTGFaUS84M2RHNTFJTFNnR0JtTG9yVXlHclZKbllM?=
 =?utf-8?B?dEUyWjRneEdpS3E1bTJDL29aZ3N5cFFvbGMvbEdrb25PN2dYT21rRGljUkE1?=
 =?utf-8?B?bmlPeG9kYmQxamF5eHFCN1R0TmRoeTRuWUswRUtSOTdCT202MGNiMEdLMFpv?=
 =?utf-8?B?cm5OaEE0clBkc0dDQm5jR21SdmdZbkZTQ3E5N2ZnOGJWNmR6R1cya1Fvbk5q?=
 =?utf-8?B?UGZjSFRqV2RRQTM3Zk5QbnlmbUpLZGdiQWJzSVpXWi9Dc29Bd3luSHdNeFQ4?=
 =?utf-8?B?L0Y4Q3lPdU5kcnNSWWdaTzVGWWJlNXROcnhlUW1nWDZCN0FaeC96Q0NicE45?=
 =?utf-8?B?QXZhRk9ROG9rYTNXNC85WC9VMERuRTZwVUl1bHJ2ZHFRSHM3bWR3cEZzNGxG?=
 =?utf-8?B?blBoZ0E1bTVtMEsvbTNrRGZSYy9KVDVISlhEZnpPdkhadVZ2U1JJT0xrVTcw?=
 =?utf-8?B?MWcvdTNDdDFEcmpMTGoxTTNKZmtiVnp6N2pDcG5leGtzZkVacTRlZmRWSGpL?=
 =?utf-8?B?WWdzdEs3bm9jWEdoUlNjc0NCd0w5VHBEVjEvRVFPWTlrMVFWaEtJU2JiL0ht?=
 =?utf-8?B?MlhoM3pmekQ2VjF2ZzFRSmszYkt3R3BJaExqRmxVK3VHOVBtdUw4N0p1QzFz?=
 =?utf-8?Q?aWf7SV9QhlKdCw+UtfHOnskMM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a48fc20-174c-40d7-5cbb-08daa250d71c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 19:28:51.9046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4eQTY3K828cxchoZ0kUVbmwjU5Mm+AvpUsFjCsvPExzN/Q1RS/QFJ6hBE/R4UCQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mathieu.

Also, I see that last few revisions I have changed driver a lot based on 
comments, but documentation in driver is not in sync.

I know we agreed initially, that I will address changes _only_ commented 
in previous revision. However, in next revision I would like

to fix documentation all over the driver along with your comments. I 
hope it's fine and I wanted to give you heads up so we stay on same page.

Thanks,

Tanmay

On 9/29/22 10:22 AM, Mathieu Poirier wrote:
> On Mon, Sep 26, 2022 at 03:02:22PM -0700, Tanmay Shah wrote:
>> On 9/1/22 1:25 PM, Mathieu Poirier wrote:
>>> On Thu, Jul 07, 2022 at 06:39:55PM -0700, Tanmay Shah wrote:
>> [ ... ]
>>>> --- /dev/null
>>>> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
>>>> @@ -0,0 +1,1055 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>> Hi Mathieu,
>>
>> I tried to fix SPDX-License-Identifier to GPL (same as MODULE_LICENSE
>> below), However checkpatch.pl reports this as following warning:
>>
>> "WARNING: 'SPDX-License-Identifier: GPL' is not supported in LICENSES/..."
>>
>> I see that GPL-1.0 is under LICENSE/deprecated directory.
>>
>>>> +/*
>>>> + * ZynqMP R5 Remote Processor driver
>>>> + *
>>>> + */
>>>> +
>>>> +#include <dt-bindings/power/xlnx-zynqmp-power.h>
>> [ ... ]
>>
>>>> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
>>>> +
>>>> +static struct platform_driver zynqmp_r5_remoteproc_driver = {
>>>> +	.probe = zynqmp_r5_remoteproc_probe,
>>>> +	.driver = {
>>>> +		.name = "zynqmp_r5_remoteproc",
>>>> +		.of_match_table = zynqmp_r5_remoteproc_match,
>>>> +	},
>>>> +};
>>>> +module_platform_driver(zynqmp_r5_remoteproc_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("Xilinx R5F remote processor driver");
>>>> +MODULE_AUTHOR("Xilinx Inc.");
>>>> +MODULE_LICENSE("GPL");
>>> There is a discrepency between the GPL-2.0 in the SPDS identifier and the above.
>> Also, changing to MODULE_LICENSE("GPL v2") gives following warning:
>>
>> WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure
>> the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
>> #1115: FILE: drivers/remoteproc/xlnx_r5_remoteproc.c:1034:
>> +MODULE_LICENSE("GPL v2");
>>
>> So, It looks like SPDX-License-Identifier should be GPL-2.0-only and
>> MODULE_LICENSE should be change to "GPL".
> Commit bf7fbeeae6db is an interesting read - thanks for pointing it out.
>
>> It this ok? Any other suggestions ?
> What you have looks good, in that regard there is no need to change anything
> from your patch.
>
>> Thanks,
>>
>> Tanmay
>>
>>> More comments tomorrow or Tuesday.
>>>
>>> Thanks,
>>> Mathieu
>>>
>>>> -- 
>>>> 2.25.1
>>>>
