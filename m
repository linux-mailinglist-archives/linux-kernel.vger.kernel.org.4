Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACDB619AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiKDPEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiKDPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:04:34 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D5B9594;
        Fri,  4 Nov 2022 08:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7SxXMT7Zko1Cfz2sHZb1V48dP+06LZ1Gie3Umr1MqlgVVriSv4VA2MaqlbFKmAeg6d2DTSUfoVd+IHuI0RsTDC43jkM9AW6HLNFsEXVx03aXE6XZbhgV8OUFfFYDt7Oc2xX+LV3RR04m/ZXke8582FpbMZ6b97xY7qfOxfAaReQKlcw7Sd7Ug6t6+1dWvYqh77/5G2XpRi8tYT1nOG7dgoO03th4z5XHxciKNa+Br9MuNt7bpw+FwEdvJcduseKa/yLa5FMHq/31XvlKiJYHSLmqOP4EOwsCddC8J0PEScLfLs+49xDF7F5S5HJXw3N0Fi8Db3UQLiw470GN6iGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QD/mSJf1rAuxhw4PGYjYUdbT7osuFLd8yQm00O4zsQ=;
 b=V6HkzQxH+JiWZLpSkolnZvrbnQplqS6maIJnb0EP2ZOWabxhKItGotojzuJUW3z5J1vxKE0Z3iZanOzAdN0sNYCz6xNizBZrv3gVBcJ93IpVS4ZTCQf1R1NUSTHQt/6u+t7Lp0t2Tjua9z3/pPyFxkaJovZO+the06Jk9jobRGA/FMqz3mx403hpRQ96V/Ml66GjPoRYMsEkaM5CX+wDVkMGZ1AHDaAtxm4PGEFn5ecO1sqc7u3maGZkKpovxBNlWhzKdrevwYu+QDVwqqUIG2WaBqManAzdI7JtLMAspdzVDfs1EnphPoitZ2ZD81X63Sf1R/2NMgmd8RLoyIUjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xsightlabs.com; dmarc=pass action=none
 header.from=xsightlabs.com; dkim=pass header.d=xsightlabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xsightlabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QD/mSJf1rAuxhw4PGYjYUdbT7osuFLd8yQm00O4zsQ=;
 b=BhvUKTiEIeAuFlHXQ1ZQQ/lf1C2ChcMXespsDJ/JrgIM4N0kIcuIATSr1KPoZgM7PRKxziByskwXTGnUimeES5NhG7G36byFJMEIxCRT5f6rNgc5yTkVXMYaGar0xZTTrQB7iFFtEMbvLpHf6hLy90+zLgmFPyaX5ML8eBz1XDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xsightlabs.com;
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:446::5)
 by DBAP193MB1002.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:1b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 15:04:27 +0000
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::5d12:7b6f:bc9a:303a]) by AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::5d12:7b6f:bc9a:303a%3]) with mapi id 15.20.5791.020; Fri, 4 Nov 2022
 15:04:27 +0000
Message-ID: <d0b178d3-a036-399f-fb0c-bb7f8c52995c@xsightlabs.com>
Date:   Fri, 4 Nov 2022 11:04:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC] ACPI: PCC: Support shared interrupt for multiple subspaces
Content-Language: en-US
To:     "lihuisong (C)" <lihuisong@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, rafael.j.wysocki@intel.com,
        wanghuiqiang@huawei.com, huangdaode@huawei.com,
        tanxiaofei@huawei.com
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221027155323.7xmpjfrh7qmil6o3@bogus>
 <f0c408a6-cd94-4963-d4d7-e7d08b6150be@huawei.com>
 <20221031104036.bv6a7i6hxrmtpj23@bogus>
 <925f360d-e6b3-6004-de22-f39eaa86a750@huawei.com>
From:   Robbie King <robbiek@xsightlabs.com>
In-Reply-To: <925f360d-e6b3-6004-de22-f39eaa86a750@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::30) To AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:446::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2335:EE_|DBAP193MB1002:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a674b93-4bfa-46c4-66f8-08dabe75de0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXXw3BCM+z7jSoCIl6ffiEmo15BuqaWhqasbCV4X1bMRdCn72QQ8fH4Czu0QXpXgU9E7nURwg7hwT2sh4ANwhHF3aEZBJhkgIfyOHmwohhLhi6e+GPpdLvhA/BbVHJLLnQgruptW8SJ+kJiYkC8Yxy+PpZz6opnAGelwSjs1Vg93znZF76y63v312K6kIRTHLSB7rojoApuWybXR3fZpysu1AFBJYLIdWezdAQ1PPkHwajmSlHHl2jP/98nVhUgTK/7lvW25uxRYU5+QlZ5ogxUpsRQ00bGD6kEItZc9y1qJsbNEeVWqiAIaxMWQoA6EO126Mp6GP0BvkPpzEUUqHNMjIofwNYgETyD0yROHjn3vOvFOiKQzxWL4b6FgclSUmsVBRLyL0j+H1lzQ882UKSCQ5nE3hQNUKfJPEqJbwpHyms42QAcmaiy7mTLyaevYHGC9cdiEHruTus8/yD54Ll3cdZP0xXY2EBj58jj757kWvLzkMVB+PWPRA47N3Qfs5nuIvJn1oNs4u5c7Uu2yOvTbSku1Jpo1WWzzNEWLGdptiqk7r5unR9MOAF3mlhnkSKUtyiFvuhnusiyFkBr2s9+Ex2GxkWmWlu0HAp4brvlQBmv4//+C85v3rozdBlRSpWUXr979eHucINcc8HESpjcuzXfjdysjnb/+fhS9Qo6dwK+Ti5CEIb6cccgaKym6KnIGjgTIZQaw0vaO4AVDAS8FY/CuCljZmZASnLG+wwb6QTefH0pTgMO9VWVlEf9ySRhXu+znlKIGCHz+R3uZ35t+DQRIhLQsvBLlOnzBFdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2335.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39830400003)(366004)(346002)(451199015)(36756003)(31686004)(86362001)(30864003)(2906002)(31696002)(5660300002)(38100700002)(83380400001)(66476007)(8936002)(6512007)(26005)(316002)(6666004)(2616005)(186003)(478600001)(110136005)(6486002)(53546011)(41300700001)(8676002)(4326008)(66946007)(66556008)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXRDcW1KT3NqdXU2ZkkyVFlyMlFJOXhBbGxldkR5SWUxbXhWUkZaTk85bUlK?=
 =?utf-8?B?UzN2QTIrR1RiS3IzWlVsaTNML3dPYjJmT0w0d09MTkZxSHNVQlFUc0FUTHRu?=
 =?utf-8?B?UWxMMmRGWmx2czZNRWV2b1NwbUFOM0h5Qy9XRjcvKzJXdW5va3NxL0xuMVcz?=
 =?utf-8?B?aXN3cmFVTklldUtGUUl3SjQxeWl0K2ZGcU1ZeENWOXlVMXFzeU1GQmtqWjl4?=
 =?utf-8?B?TU9xUUlnbnlQRy96QmIyWkxoenBoaFQvYlhkTlNGeGdyTm9KaCtiY1pFNkxs?=
 =?utf-8?B?N0I3c2VDVURyMTJZSEZtZFpjdW02aWVBRUlkaUVPaEJ1VGdBdWw1TFc0dHhw?=
 =?utf-8?B?R2YvVWtJeXVKTUUyaFplUDd4bXNJdTZDYndKU0tUMkVsd2d2U2E2NjhodG45?=
 =?utf-8?B?N1prMGRaaDI5cHF2Q1hiU0FtZEY1SzRzTU1MdXlaQk9DUGxjczMxWk9hZWk0?=
 =?utf-8?B?ZXAzcVUzRUNYbkZKMlFoTjZBWWh6R1dmeUxuSzFQdUtUTnAySzBwVGphbU4y?=
 =?utf-8?B?VkNJS1BpRmlKS3NtM1pMSG54RXl4NWI4aWRyWGZrZEJTOW9zZlRUY2IwMStv?=
 =?utf-8?B?eWQrM29zY0dudHlHTGZnZndaUHVndTJURWoxNGxHTStsa1g5ZUViUCtGMmh2?=
 =?utf-8?B?UFNTbzdlaStUSXdyTkd3OVZwODl5U29FNVZiM25sWE9RRXVISTgxei9Za20w?=
 =?utf-8?B?Nmk3QmlrOVlUckhKYUlmWm9VQkdPVmp3V01hQmdlNzVPR3NtRWIxaEpxeWVn?=
 =?utf-8?B?RENhRjNiUUtyWTZBQ2VNMC9haFYreHcvWGR1K1V1dU15aXdsVG9UVmVkOTJO?=
 =?utf-8?B?eHdSR0lHbWdUWmxkMkVEWHM3VXVoQnVKRzEzSGhnU3BNUFNEN0F4akNpVzc3?=
 =?utf-8?B?Z2FNQjYwVDZGSFpVUG1yVWswdzV5UHhjK1dMdS9QNmJEN1JLMU1nSnRZRjlN?=
 =?utf-8?B?aFJHY2huZnRnU3MwRVUvTTR4SkFqSE1wQTJ1M2k5ckxjVU1DUTI5ZU9Wd1FX?=
 =?utf-8?B?c1A2cDVwZ0Y5QSt1VHdTd1hwT044Z1AxRS9scWUrTzRQK1U5QnJBOFpRSDdu?=
 =?utf-8?B?ZUJiNVl1ZHRsbjZtd2g0NkxwTFAvM044MVFPakJ5ZFlmS2Z1ZmM4UnlxNnBS?=
 =?utf-8?B?OEo5cXNhZ2lKQ2NseGdkQS9aM0hoMGtUZ3R4VWphNEdydnJHS0F1ajYvVnV0?=
 =?utf-8?B?T202c1ZZV0cvNHkreE9oay9GOGdRRGgyeEE5aURnRUxnQVYwTlE1K0JHcWRl?=
 =?utf-8?B?TzNPNWpyKzNpNGFTY0lPbXcrd1h5dWdnQzlFVlB0SGhvaGhCaVllWXdYYS95?=
 =?utf-8?B?V2RXSG1zNlp5SXpMUEZmRlk4TDFuZ2dzVHNaWENZbUpPdGxlUkdJZG1scVRo?=
 =?utf-8?B?OHNheUJINUwwYnhrOERDbXFmYytmc1hwSHJaNEFOK2xOU3JSbWNQeExVSlB5?=
 =?utf-8?B?ZEp4bU82YzJ6UVU2YmpDaXQ0L05BNFZkWU5RQlQ2am14SG01QkhzTERGbmd1?=
 =?utf-8?B?MnRmUzhNdUNUM3R6ODlVdnlDUERqT0FFZG04R0FnL0hReXA0K212L1UzQXN4?=
 =?utf-8?B?eTE3alZRaFNoNDlWTm9tWmlMbnBwOGtVN0lkUVgwMUN3U1Nscm9nVFpyd2R0?=
 =?utf-8?B?Mnoxb25KMzI4MDJxVDdqcmg1ak9QaDBQMWhmYTc0L3pTaENBTi81S2Z3ZHpS?=
 =?utf-8?B?MXdUNXFMdFJQd0FQdnJPVGpIZEJ3ZTN1Y0UvRm8wU3FnQzFpSFpaMDREckJR?=
 =?utf-8?B?WW55Y3l2T0hQbjJOL1FVRjFybnI1L2g4OVdlTnArWUhQN2s1M054SGlWM2ZN?=
 =?utf-8?B?QlJCZkVxT05SaHhXZldYZC9OQjI5TW5iSlZRKzJYMHB6SlRYc2E1bjBIaTJl?=
 =?utf-8?B?bmtkaEx4NXdSS3ZaT3JUY0Z3VkluQ0NZMVh1M2tlYkFncm5ta3ZHMXBiWjUz?=
 =?utf-8?B?cVo3QmluWGVYVFpxS0Y0VWs3Sm1jTCtXRjA0S3FibndQYWN6QUxtY2x1L1Ju?=
 =?utf-8?B?Lys2L1J0OTBZbHAyUVJ6b0JwRXd1QXJVeTZQdHpHa25VMTVXVGxKNnVkQnNC?=
 =?utf-8?B?eEQ2aWFlaE9ZQVFpVWRRVUpKS1BFQlN4dUo2bFNJVGVFbUR0WWZ3d0V4dkdr?=
 =?utf-8?Q?OOjmNy7D/CVwkWieLep4KKY39?=
X-OriginatorOrg: xsightlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a674b93-4bfa-46c4-66f8-08dabe75de0e
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 15:04:27.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 646a3e34-83ea-4273-9177-ab01923abaa9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hJ3GoGDs+T3BG/XT0UKZnIy6pUG26tYk31t65Ccjf/zhOlFx5oE9LEmAyqPXswiPz/CxVRcmckTi9/iDu6vHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP193MB1002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2022 10:49 PM, lihuisong (C) wrote:
> 
> 在 2022/10/31 18:40, Sudeep Holla 写道:
>> On Fri, Oct 28, 2022 at 03:55:54PM +0800, lihuisong (C) wrote:
>>> 在 2022/10/27 23:53, Sudeep Holla 写道:
>>>> On Sun, Oct 16, 2022 at 11:40:43AM +0800, Huisong Li wrote:
>>>>> As ACPI protocol descripted, if interrupts are level, a GSIV may
>>>>> be shared by multiple subspaces, but each one must have unique
>>>>> platform interrupt ack preserve and ack set masks. Therefore, need
>>>>> set to shared interrupt for types that can distinguish interrupt
>>>>> response channel if platform interrupt mode is level triggered.
>>>>>
>>>>> The distinguishing point isn't definitely command complete register.
>>>>> Because the two status values of command complete indicate that
>>>>> there is no interrupt in a subspace('1' means subspace is free for
>>>>> use, and '0' means platform is processing the command). On the whole,
>>>>> the platform interrupt ack register is more suitable for this role.
>>>>> As ACPI protocol said, If the subspace does support interrupts, and
>>>>> these are level, this register must be supplied. And is used to clear
>>>>> the interrupt by using a read, modify, write sequence. This register
>>>>> is a 'WR' register, the bit corresponding to the subspace is '1' when
>>>>> the command is completed, or is '0'.
>>>>>
>>>>> Therefore, register shared interrupt for multiple subspaces if support
>>>>> platform interrupt ack register and interrupts are level, and read the
>>>>> ack register to ensure the idle or unfinished command channels to
>>>>> quickly return IRQ_NONE.
>>>>>
>>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>>> ---
>>>>>    drivers/mailbox/pcc.c | 27 +++++++++++++++++++++++++--
>>>>>    1 file changed, 25 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>>>>> index 3c2bc0ca454c..86c6cc44c73d 100644
>>>>> --- a/drivers/mailbox/pcc.c
>>>>> +++ b/drivers/mailbox/pcc.c
>>>>> @@ -100,6 +100,7 @@ struct pcc_chan_info {
>>>>>        struct pcc_chan_reg cmd_update;
>>>>>        struct pcc_chan_reg error;
>>>>>        int plat_irq;
>>>>> +    u8 plat_irq_trigger;
>>>>>    };
>>>>>    #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
>>>>> @@ -236,6 +237,15 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>>>>        int ret;
>>>>>        pchan = chan->con_priv;
>>>>> +    ret = pcc_chan_reg_read(&pchan->plat_irq_ack, &val);
>>>>> +    if (ret)
>>>>> +        return IRQ_NONE;
>>>>> +    /* Irq ack GAS exist and check if this interrupt has the channel. */
>>>>> +    if (pchan->plat_irq_ack.gas) {
>>>>> +        val &= pchan->plat_irq_ack.set_mask;
>>>> I am not sure if the above is correct. The spec doesn't specify that the
>>>> set_mask can be used to detect if the interrupt belongs to this channel.
>>>> We need clarification to use those bits.
>>> Yes, the spec only say that the interrupt ack register is used to clear the
>>> interrupt by using a read, modify, write sequence. But the processing
>>> of PCC driver is as follows:
>>> Irq Ack Register = (Irq Ack Register & Preserve_mask) | Set_mask
>>>
>>> The set_mask is using to clear the interrupt of this channel by using OR
>>> operation. And it should be write '1' to the corresponding bit of the
>>> channel
>>> to clear interrupt. So I think it is ok to use set_mask to detect if the
>>> interrupt belongs to this channel.
>> The problem is it can be write-only register and reads as always zero.
> But it seems that it must be a read/write register according to the ACPI spec.
>> I know a platform with such a behaviour.
> Can you tell me which platform?
>>
>>>> This triggered be that I have a patch to address this. I will try to search
>>>> and share, but IIRC I had a flag set when the doorbell was rung to track
>>>> which channel or when to expect the irq. I will dig that up.
>>> Looking forward to your patch.😁
>> Please find below. I am not convinced yet to have extra flag for checking if
>> the channel is in use. The other idea I had is to use the Generic Communications
>> Channel Shared Memory Region Status Field in particular Command Complete
>> field. I haven't tried it yet and hence the reason for not posting the patch.
>> Let me know if the idea looks sane, so that I can try something and share
> I don't think it is feasible. From the spec, the Command Complete field in the Generic
> Communications Channel Shared Memory Region Status Field for type1/2 is similar to
> the Command Complete Check Register in Master Slave Communications Channel Shared
> Memory Region for type3/4.
>> it. I may not have a setup handy to test and may need sometime to test though.
>>
>> Regards,
>> Sudeep
>>
>> -->8
>> >From 6dd9ad4f3a11dc9b97d308e70b544337c4169803 Mon Sep 17 00:00:00 2001
>> From: Sudeep Holla <sudeep.holla@arm.com>
>> Date: Thu, 27 Oct 2022 21:51:39 +0100
>> Subject: [PATCH] ACPI: PCC: Support shared level triggered interrupt for
>>   multiple subspaces
>>
>> If the platform acknowledge interrupt is level triggered, then it can
>> be shared by multiple subspaces provided each one has a unique platform
>> interrupt ack preserve and ack set masks.
>>
>> If it can be shared, then we can request the irq with IRQF_SHARED and
>> IRQF_ONESHOT flags. The first one indicating it can be shared and the
>> latter one to keep the interrupt disabled after the hardirq handler
>> finished.
> after --> until , right?
>>
>> Further, since there is no way to detect if the interrupt is for a given
>> channel as the interrupt ack preserve and ack set masks are for clearing
>> the interrupt and not for reading the status, we need a way to identify
>> if the given channel is in use and expecting the interrupt.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/mailbox/pcc.c | 36 +++++++++++++++++++++++++++++++++---
>>   1 file changed, 33 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index 3c2bc0ca454c..a61528c874a2 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -91,6 +91,8 @@ struct pcc_chan_reg {
>>    * @cmd_update: PCC register bundle for the command complete update register
>>    * @error: PCC register bundle for the error status register
>>    * @plat_irq: platform interrupt
>> + * @plat_irq_flags: platform interrupt flags
>> + * @chan_in_use: flag indicating whether the channel is in use or not
>>    */
>>   struct pcc_chan_info {
>>       struct pcc_mbox_chan chan;
>> @@ -100,6 +102,8 @@ struct pcc_chan_info {
>>       struct pcc_chan_reg cmd_update;
>>       struct pcc_chan_reg error;
>>       int plat_irq;
>> +    unsigned int plat_irq_flags;
>> +    bool chan_in_use;
>>   };
>>
>>   #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
>> @@ -221,6 +225,12 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
>>       return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>>   }
>>
>> +static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
>> +{
>> +    return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
>> +        ACPI_LEVEL_SENSITIVE;
>> +}
>> +
>>   /**
>>    * pcc_mbox_irq - PCC mailbox interrupt handler
>>    * @irq:    interrupt number
>> @@ -237,6 +247,9 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>
>>       pchan = chan->con_priv;
>>
>> +    if (!pchan->chan_in_use)
>> +        return IRQ_NONE;
>> +
>>       ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>>       if (ret)
>>           return IRQ_NONE;
>> @@ -262,6 +275,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>
>>       mbox_chan_received_data(chan, NULL);
> 
> This flag should be set to false when the Error status register indicates that the channel has an error.
> 
> what do you think?
> 
>>
>> +    pchan->chan_in_use = false;
> 
> Maybe need add following logic?
> if (pchan->plat_irq_ack.gas)
>      pchan->chan_in_use = false;
> 
>> +
>>       return IRQ_HANDLED;
>>   }
>>
>> @@ -310,9 +325,12 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>>
>>       if (pchan->plat_irq > 0) {
>>           int rc;
>> +        unsigned long irqflags;
>>
>> -        rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
>> -                      MBOX_IRQ_NAME, chan);
>> +        irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
>> +                IRQF_SHARED | IRQF_ONESHOT : 0;
>> +        rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq,
>> +                      irqflags, MBOX_IRQ_NAME, chan);
>>           if (unlikely(rc)) {
>>               dev_err(dev, "failed to register PCC interrupt %d\n",
>>                   pchan->plat_irq);
>> @@ -374,7 +392,11 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>>       if (ret)
>>           return ret;
>>
>> -    return pcc_chan_reg_read_modify_write(&pchan->db);
>> +    ret = pcc_chan_reg_read_modify_write(&pchan->db);
>> +    if (!ret)
>> +        pchan->chan_in_use = true;
>> +
>> +    return ret;
>>   }
>>
>>   static const struct mbox_chan_ops pcc_chan_ops = {
>> @@ -458,6 +480,8 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
>>           return -EINVAL;
>>       }
>>
>> +    pchan->plat_irq_flags = pcct_ss->flags;
>> +
>>       if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
>>           struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
>>
>> @@ -478,6 +502,12 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
>>                       "PLAT IRQ ACK");
>>       }
>>
>> +    if (pcc_chan_plat_irq_can_be_shared(pchan) &&
>> +        !pchan->plat_irq_ack.gas) {
>> +        pr_err("PCC subspace has level IRQ with no ACK register\n");
>> +        return -EINVAL;
>> +    }
>> +
>>       return ret;
>>   }
>>
>> -- 
>> 2.38.1
> 
> Hi Sudeep,
> 
> ACPI spec requested that the Irq Ack Register is a read/write register. From this point,
> only using this register supports for detecting if the interrupt is for a given channel
> as my patch implemented. But If we need consider the platform whose Irq Ack Register is
> write-only register, the chan_in_use flag in your patch looks good to me.

Hello Huisong, your raising of the shared interrupt issue is very timely, I am working to
implement "Extended PCC subspaces (types 3 and 4)" using PCC on the ARM RDN2 reference
platform as a proof of concept, and encountered this issue as well.  FWIW, I am currently
testing using Sudeep's patch with the "chan_in_use" flag removed, and so far have not
encountered any issues.

I think the RDN2 may provide an example of a write only interrupt acknowledge mechanism
mentioned by Sudeep.

The RDN2 reference design uses the MHUv2 IP for the doorbell mechanism.  If my implementation
is correct (and it quite possibly is not), acknowledging the DB interrupt from the platform
is accomplished by writing a 1 to the appropriate bit in the receiver channel window CH_CLR
register, which is documented as:

   Channel flag clear.
   Write 0b1 to a bit clears the corresponding bit in the CH_ST and CH_ST_MSK.
   Writing 0b0 has no effect.
   Each bit always reads as 0b0.

in the "Arm Corstone SSE-700 Subsystem Technical Reference Manual".

Apologies if I am off in the weeds here as I have only been working with PCC/SCMI for a
very short period of time.

Regards,
Robbie

> 
> Regards,
> Huisong
>>
>>
>>
>> .

