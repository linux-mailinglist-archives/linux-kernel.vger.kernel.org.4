Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD65632A27
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiKUQ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiKUQ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:59:28 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9C2C8454;
        Mon, 21 Nov 2022 08:59:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiCO1A917dRXVlB1ezSEYIzvJK3zJSlm3KMGKy0eBl0LRJwDnfmsYDnDjZEBj5ccZ70iqEiiyKkyQLVH7HeJyaETTL5SpBh4o2KJOu2cLE4N3IMn6ToDCMjUlSD1c0VOh6yYwgAHJD/aZrQw97EiAcn/sNOZjDJZ2d/VjHQxAunGkikhNHXQRqpVlubknaPvL2FSFp6YB/0g1dlswro0CARv5rDnapDZ0INnGkK7bIWsRTFwGACsDOG6nxfZv6FvMJlfFJlQaPEmh+9WRzVYVXH5TPKVZDfn+jBdWbIWL1OD7REwTYjw5BujuwA9d3hJwDgfcO6lSokJJjdaDJ9EyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+/QxJErsqthJfMzHOQkrTsOVn8FRUMCxlHPY7T7Q9Q=;
 b=nSsuS0ihP7XDnaPghsEIgsIUAsZOmbJLzQweSeB7ePTh81cvCTysa39n3zzqaZo7NQqJNWdW3K1DBXCibO6IscAx0guj2Vep3S4+3Ol6lJSLI/g58mtXwJNEquqQPR90ScRkSh7ouhi0fqWOrZxj3/JId1eHj0XLs9X2tBdxaxcuvpOsyOEL2ELGdUdoTSCzwg/z41eGnR4420QwMzMphcS578eNUiEOjd7luBaHB/XQ+OBw234oOSCQfnaPf8GONAuT1+lSvRezE9+GB5hatZXxfc7FBZIq//eojkhvVjyrRgT+ZDpOXDm4kNiKDtKxRJ/X8gsjRi0WIa1WrnBEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xsightlabs.com; dmarc=pass action=none
 header.from=xsightlabs.com; dkim=pass header.d=xsightlabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xsightlabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+/QxJErsqthJfMzHOQkrTsOVn8FRUMCxlHPY7T7Q9Q=;
 b=fatf5TP6HHaVPpVLODWKV1cBC/JFwZtjFL+zuX6zUsy0p1TZisLFHB0no2fe3PJSBJ2u+FFH0GMW7c1Jg/s3OHix2VSo0oz0TQMhFdI3yzO1TML5fLg0uXeK9eT8EqGQA366WIxMXL8XCXH13VKDcGUo86sfFKv6dAXP/YjXc50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xsightlabs.com;
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:446::5)
 by VI1P193MB0607.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:15b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 16:59:21 +0000
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::dfba:b6f1:374c:a371]) by AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::dfba:b6f1:374c:a371%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 16:59:21 +0000
Message-ID: <a7119a55-9e7a-b27f-4969-2c6bef764011@xsightlabs.com>
Date:   Mon, 21 Nov 2022 11:59:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
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
 <d0b178d3-a036-399f-fb0c-bb7f8c52995c@xsightlabs.com>
 <20221104151530.44sms3fnarqnvvsl@bogus>
 <ca35058d-1f40-3f85-9e2d-bfb29c8625cb@xsightlabs.com>
 <09e0a108-9f22-a9a0-2145-a81936745887@huawei.com>
 <3b28294a-1e2b-140a-8462-5014ba893cc5@xsightlabs.com>
 <1156ef89-20a4-7e7e-6205-c68e21a9bb36@huawei.com>
From:   Robbie King <robbiek@xsightlabs.com>
In-Reply-To: <1156ef89-20a4-7e7e-6205-c68e21a9bb36@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:208:32e::15) To AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:446::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2335:EE_|VI1P193MB0607:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0c0ffc-7693-4b5e-0af3-08dacbe1bc61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pcx12uFt7HTD+6k7fb167j7pEO/lcuEXDAYzV8o3sJ30LOkNdYyzZja++G+kGdELlsTqOkiDVBb9aYjFdbROn0FB0gpLW0J9KuQonVJ4DxSsCLuL95I4DwPethNs0F1DFacQ1ja3CLJcBEO081Ux8mdcmFFASy5f4YdDHNQGX0MwL0LBKGqXQaeD9BX/tOlWed21cpbwRTLuMAY162AMXSa7l57G2xYQ7xgOs7uO8pbyVzJ2zFXoK03PcxPDxkQ+SL1yeXABnGXIkIaY8yf6IQHFdc/iNNqKLDpnFK+9+XBOOIuTwQLCvE4g+gMbWO3yk0d8WDjJ5QzcV0bWXZzLGoOlzwyNqjwwl2t/NpMkiPdVl/fjEBRwX8fA4T07XxrdJ9Z/ZWVEPse/2NCLXwSl7mN58GgDk/GFA9A4rwxJfLBu2Kk2+zfwVo7ohBCYn1Cp7fppoiNWdZrMCmFd/md0LTfun8HUwKOC2CwqFpq+7xtT9ICR5kKenfi2bq3qfRadNAsuUGfuDoNKV5ipFmVHEkoJgQLkoAKVTdRU7YHEuYVzAfCfGXDXFq4BREycOHEfnQaIwa0+ovNrfYBbMIRiA56g05zdYMJpAUMzH6hgrZGLibE8yc4Klp3mR9nJEZh5VZGAFgN9iZtw5MaWGsO8gKZPd2zejjhj2GO6ZGinCYKTK65J/45VorrH93TP3nAbP3Pbb8xBzozznZcUgS5AjJl8wl0+22JsW0uR6h1WQLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2335.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39840400004)(376002)(366004)(136003)(396003)(451199015)(66556008)(4326008)(5660300002)(53546011)(316002)(6506007)(110136005)(8676002)(2616005)(41300700001)(66476007)(66946007)(26005)(36756003)(8936002)(186003)(6512007)(83380400001)(38100700002)(2906002)(86362001)(31696002)(6666004)(31686004)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDVJa1U1REc2WjgzTW5lRmdDY1Z3MzdkRTZHcjFxOFVkQVZPbGE1VUQ0cmZw?=
 =?utf-8?B?NUdHTkRGeng2amJPL3FGRzVtQTVIUXBvVVlwRmhiS05MVjZnMDU2aHFXUWpj?=
 =?utf-8?B?Mi9waTNmSXJ5ZVJrMGdEWHdoZERaZlV0NUQ4c1J2L0JYa0lQZWo5dFI0RVVX?=
 =?utf-8?B?dnIrR3NpNDAyNjArcU5rSDZTRDNtR3FQaXVSWVBZZlZ5QVZwRG52UEd5YVha?=
 =?utf-8?B?UlBNY2M1ZE16YjVpaXJWNGZ4dDFaQmhZUFFWMUs2YndUbXhlZU45anAwZ3NK?=
 =?utf-8?B?bzh5Nk1UUUdIbTM0YWlNcmxrenFGamF1TXRxdmxNZnRoOWZ4YWVubjJSRFM1?=
 =?utf-8?B?cnhPcG5OQ1owai9FMzh2ZGdWSUZabVg1QllCelZ1WXI4dHlFaTdLZGgwWWlk?=
 =?utf-8?B?cDltenhEa0Z3eXZxVzRTbms3ZHBGT1VBRGRROFM5L0hHd1U4SGFCMkRDOTRH?=
 =?utf-8?B?NnMvWGJpd3YyUDN0cFhiMHpVVnV3TjRsNnZRUFp4RG5WLzZaUzBRTnhRNlRa?=
 =?utf-8?B?dXltcE9iNW1jOFhIb3dSOGxsZlZnTTFRZEpmcmtqYnZ5VkNRejB1RkJUeWZE?=
 =?utf-8?B?UmFaekxxZi9lOElZUEU2MnFBaWQ5MjMzVEtuRHY1bHczdU5xaU1kT2YxK2lK?=
 =?utf-8?B?VzlaL1FFc3MzdWluM0F2VnpkSm5Wd3BWN3J1NDF0RUhsR0lpczZnVDdOelhs?=
 =?utf-8?B?RU81d3VnL1ZpblMwNUpOM1dTV0d1QUJBU2tMdFZtVlVwOEJSVTVBWDk2amsw?=
 =?utf-8?B?K0xLaWZIVnl0bDZTRDNpZVNSNEE3cTY4TnBybWd6amdaMmI5Z3lQUW14Ylhk?=
 =?utf-8?B?SDMybDN1eUlSUTRrWjJTMExqT29OWXQ3MG1GRGl5SndvS2dYUEZkYmFDNjNh?=
 =?utf-8?B?N01KVkhHT2w1WkZLR1lWRlRZOTk0REdMMDlqWFcxUzRGcWYwL0MyRzR5RjYw?=
 =?utf-8?B?T2kveGUySVoxS2RTMHhDdVltNVZJNW5xdkZCN1lrS00wRVZOOERYSjNZejJP?=
 =?utf-8?B?ZWlhZ1g2dnF2NE12MmdGWkJUQjJSL0h4cUpOZ2Z1bjZZWm45NXZQS0VzR2Fw?=
 =?utf-8?B?L2xGVXRPMmNlditJbTBkK0JvOUYrcUZMSTloVkxrajlzVHRWNWkyNy9YYnpX?=
 =?utf-8?B?TWlxQUJFK0s1RWo4VzEvTVVOVllnK25pMHFVYXBMUW5lOE4zTExFNnh4T3k0?=
 =?utf-8?B?MHhqVWJXN3E1cUV1SjdCV2tNM3FoVUZLYWw2bmt2RGhTcnRjT1VZQnZsN1RC?=
 =?utf-8?B?UjB1VkJubW9Dd2F2UzMxWHEySkozZVcvSEZGK0JaRzN3R1BFYlAyaW41aUlu?=
 =?utf-8?B?T3Bid2NWWjlXalhqWnpGb2NPZWJ0bXFaNjVZM3BUaVZQN3dYSE1tL3d0dEx4?=
 =?utf-8?B?YituVTh1bVBkWWtDVGJ0cnVGRkJlSU81QlZ5ZHFnc21KMTEvSWdzTXJ0TGNB?=
 =?utf-8?B?NXdKSFFWZVpLdGRubFBTV2E2ejBFeEQxQldFQ0tGangveVIrV3Q1am5xaTBM?=
 =?utf-8?B?RDlBcUgrL09CODRMQ3JING5wNzlPL2xDSkduQW5kWFBicElHK3h1MnROTXJF?=
 =?utf-8?B?L1lzODRXTFhkaWUwc1EwOVIwbFBjZkRnekNhYnBFSm0waGFBTHpWbHg3bktV?=
 =?utf-8?B?VUdQUnBWVWlVYjVVQ0thdVFWZFRPV1luTDY0eG0xMCthZks2RWk4bmpFVHBI?=
 =?utf-8?B?YS8vdmduMkN3MDNuQ0VSNkYyWHpTOHA2T0t5L0g5Y1VldlMyMjM5RERoRk8v?=
 =?utf-8?B?U1FDL2NWZ0pmaFBRbmxpWXJGdGV2SlRlaExCMTVtTUw4dDc5ejdhb1VxMTRI?=
 =?utf-8?B?Q1VpM2gyWWowM3BjSm9ka2orS3BlTlNEdUdGdFRlQnhkVHZucjdjdGh4UEtL?=
 =?utf-8?B?K2NDUWJYTk02bU1vMFc3cGZkelJVRnFYcG16cnpxekVpb2JGQXIzTm8vMWlo?=
 =?utf-8?B?KzJSY1hXT05YNmhGdExudTkzMXpLYW5uWWQvRDRPdnRVR1BMaUZwODNLN0ZN?=
 =?utf-8?B?OEw3MFVaS3lyNW5yalFkb3FyV3FjWTJhZEFYMlp6RTJaUGx5a2wrQXdUZlpK?=
 =?utf-8?B?cDVjdmh6T01EaG4zQ0xrMHo5d2FzRlZvQ1Vua2VxaVJMa0wwSmloN1JObG1n?=
 =?utf-8?B?MGg5NHY5YTZHVjllQldrWUFaVUJSU2RRWk1GSzVJc0MrMW1zckdnRno1SE1I?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: xsightlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0c0ffc-7693-4b5e-0af3-08dacbe1bc61
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:59:21.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 646a3e34-83ea-4273-9177-ab01923abaa9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jX8A1lYa0wQuUMfmg8NbDJ/FWV2R8SiA/pwgCMun08UWGOhvyp4wRQ2YBfpVCp0U+VP6+A2/3kruDbZpbPCz1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P193MB0607
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2022 2:32 AM, lihuisong (C) wrote:
> 
> 在 2022/11/18 2:09, Robbie King 写道:
>> On 11/7/2022 1:24 AM, lihuisong (C) wrote:
>>>
>>> 在 2022/11/4 23:39, Robbie King 写道:
>>>> On 11/4/2022 11:15 AM, Sudeep Holla wrote:
>>>>> On Fri, Nov 04, 2022 at 11:04:22AM -0400, Robbie King wrote:
>>>>>> Hello Huisong, your raising of the shared interrupt issue is very timely, I
>>>>>> am working to implement "Extended PCC subspaces (types 3 and 4)" using PCC
>>>>>> on the ARM RDN2 reference platform as a proof of concept, and encountered
>>>>>> this issue as well.  FWIW, I am currently testing using Sudeep's patch with
>>>>>> the "chan_in_use" flag removed, and so far have not encountered any issues.
>>>>>>
>>>>>
>>>>> Interesting, do you mean the patch I post in this thread but without the
>>>>> whole chan_in_use flag ?
>>>>
>>>> That's right, diff I'm running with is attached to end of message.
>>> Hello Robbie, In multiple subspaces scenario, there is a problem
>>> that OS doesn't know which channel should respond to the interrupt
>>> if no this chan_in_use flag. If you have not not encountered any
>>> issues in this case, it may be related to your register settings.
>>>
>>
>> Hi Huisong, apologies, I see your point now concerning multiple subspaces.
>>
>> I have started stress testing where I continuously generate both requests
>> and notifications as quickly as possible, and unfortunately found an issue
>> even with the original chan_in_use patch.  I first had to modify the patch
>> to get the type 4 channel notifications to function at all, essentially
>> ignoring the chan_in_use flag for that channel.  With that change, I still
>> hit my original stress issue, where the pcc_mbox_irq function did not
>> correctly ignore an interrupt for the type 3 channel.
>>
>> The issue occurs when a request from AP to SCP over the type 3 channel is
>> outstanding, and simultaneously the SCP initiates a notification over the
>> type 4 channel.  Since the two channels share an interrupt, both handlers
>> are invoked.
>>
>> I've tried to draw out the state of the channel status "free" bits along
>> with the AP and SCP function calls involved.
>>
>> type 3
>> ------
>>
>>  (1)pcc.c:pcc_send_data()
>>        |                         (5) mailbox.c:mbox_chan_receive_data()
>> _______v                      (4)pcc.c:pcc_mbox_irq()
>> free   \_________________________________________
>>
>>                               ^
>> type 4                        ^
>> ------                        ^
>> _____________________
>> free                 \_____________________________
>>                      ^        ^
>>                      |        |
>> (2)mod_smt.c:smt_transmit()   |
>>                               |
>> (3)mod_mhu2.c:raise_interrupt()
>>
>> The sequence of events are:
>>
>> 1) OS initiates request to SCP by clearing FREE in status and ringing SCP doorbell
>> 2) SCP initiates notification by filling shared memory and clearing FREE in status
>> 3) SCP notifies OS by ringing OS doorbell
>> 4) OS first invokes interrupt handler for type 3 channel
>>
>>    At this step, the issue is that "val" from reading status (i.e. CommandCompleteCheck)
>>    is zero (SCP has not responded yet) so the code below falls through and continues
>>    to processes the interrupt as if the request has been acknowledged by the SCP.
>>
>>     if (val) { /* Ensure GAS exists and value is non-zero */
>>         val &= pchan->cmd_complete.status_mask;
>>         if (!val)
>>             return IRQ_NONE;
>>     }
>>
>>    The chan_in_use flag does not address this because the channel is indeed in use.
>>
>> 5) ACPI:PCC client kernel module is incorrectly notified that response data is
>>    available
> Indeed, chan_in_use flag is invalid for type4.

Thinking about this some more, I believe there is a need for the chan_in_use flag
for the type 4 channels.  If there are multiple SCP to AP channels sharing an
interrupt, and the PCC client code chooses to acknowledge the transfer from
process level (i.e. call mbox_send outside of the mbox_chan_received_data callback),
then I believe a window exists where the callback could be invoked twice for the
same SCP to AP channel.  I've attached a diff.

>> I added the following fix (applied on top of Sudeep's original patch for clarity)
>> for the issue above which solved the stress test issue.  I've changed the interrupt
>> handler to explicitly verify that the status value matches the mask for type 3
>> interrupts before acknowledging them.  Conversely, a type 4 channel verifies that
>> the status value does *not* match the mask, since in this case we are functioning
>> as the recipient, not the initiator.
>>
>> One concern is that since this fundamentally changes handling of the channel status,
>> that existing platforms could be impacted.
> [snip]
>>
>> +    /*
>> +     * When we control data flow on the channel, we expect
>> +     * to see the mask bit(s) set by the remote to indicate
>> +     * the presence of a valid response.  When we do not
>> +     * control the flow (i.e. type 4) the opposite is true.
>> +     */
>> +    if (pchan->is_controller)
>> +        cmp = pchan->cmd_complete.status_mask;
>> +    else
>> +        cmp = 0;
>> +
>> +    val &= pchan->cmd_complete.status_mask;
>> +    if (cmp != val)
>> +        return IRQ_NONE;
>>
> We don't have to use the pchan->cmd_complete.status_mask as above.
> 
> For the communication from AP to SCP, if this channel is in use, command
> complete bit is 1 indicates that the command being executed has been
> completed.
> For the communication from SCP to AP, if this channel is in use, command
> complete bit is 0 indicates that the bit has been cleared and OS should
> response the interrupt.
> 
> So you concern should be gone if we do as following approach:
> "
> val &= pchan->cmd_complete.status_mask;
> need_rsp_irq = pchan->is_controller ? val != 0 : val == 0;
> if (!need_rsp_irq)
>     return IRQ_NONE
> "
> 
> This may depend on the default value of the command complete register
> for each channel(must be 1, means that the channel is free for use).
> It is ok for type3 because of chan_in_use flag, while something needs
> to do in platform or OS for type4.
>> ret = pcc_chan_reg_read(&pchan->error, &val);
>>      if (ret)
>> @@ -704,6 +717,9 @@ static int pcc_mbox_probe(struct platform_device *pdev)
>>          pcc_mbox_channels[i].con_priv = pchan;
>>          pchan->chan.mchan = &pcc_mbox_channels[i];
>>
>> +        pchan->is_controller =
>> +            (pcct_entry->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE);
>> +
> This definition does not apply to all types because type1 and type2
> support bidirectional communication.
> 
>> if (pcct_entry->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE &&
>>              !pcc_mbox_ctrl->txdone_irq) {
>>              pr_err("Plaform Interrupt flag must be set to 1");
>>
> 
> I put all points we discussed into the following modifcation.
> Robbie, can you try it again for type 4 and see what else needs to be
> done?
> 
> Regards,
> Huisong
> 

Thanks Huisong, I ran my current stress test scenario against your diff
with no issues (I did have to manually merge due to a tabs to spaces issue
which may be totally on my end, still investigating).

Here is the proposed change to support chan_in_use for type 4 (which I've
also successfully tested with).  I think I have solved the tabs to spaces
issue for my sent messages, apologies if that's not the case.

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 057e00ee83c8..d4fcc913a9a8 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -292,7 +292,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	int ret;

 	pchan = chan->con_priv;
-	if (pchan->mesg_dir == PCC_ONLY_AP_TO_SCP && !pchan->chan_in_use)
+	if (!pchan->chan_in_use)
 		return IRQ_NONE;

 	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
@@ -320,8 +320,16 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 		goto out;
 	}

+	/*
+	 * Clearing in_use before RX callback allows calls to mbox_send
+	 * (which sets in_use) within the callback so SCP to AP channels
+	 * can acknowledge transfer within IRQ context
+	 */
+	if (pchan->cmd_complete.gas)
+		pchan->chan_in_use = false;
+
 	mbox_chan_received_data(chan, NULL);
-	rc = IRQ_HANDLED;
+	return IRQ_HANDLED;

 out:
 	if (pchan->cmd_complete.gas)
@@ -772,6 +780,8 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 			goto err;
 		}
 		pcc_set_chan_mesg_dir(pchan, pcct_entry->type);
+		if (pchan->mesg_dir == PCC_ONLY_SCP_TO_AP)
+			pchan->chan_in_use = true;

 		if (pcc_mbox_ctrl->txdone_irq) {
 			rc = pcc_parse_subspace_irq(pchan, pcct_entry);

