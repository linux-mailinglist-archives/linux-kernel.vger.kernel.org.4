Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7226C62E3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbiKQSJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiKQSJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:09:34 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2066BDDA;
        Thu, 17 Nov 2022 10:09:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6nXcxnY/1lR032YjIIGGk+LV9Nzy+rv1dtus/i5ay8ZcxcV3JNtZfirwufP76BHaFK+j4ULYcZLxTPidzzVkMsHGdj7WBwCLRr15c/nybtIGBuukGwZOeHdZDM0t5ZTmtz7WLPQ1F5nfUk99X5djvNi98aM0RnoyvFTEHTEXfjianJk3Kz5TYCQOs6eWL7o5EN1kbRNLPv/YonGX3LDJb01hjfL2Gny0Qd0ZX6UfbBVFNiA8AQ2Dy98Hhwa9yNWH4Qvm57uBlnzzAxvPoqTYnTlHegvYKYbIfaBKJLVKJLDbHQAxV+nCfh/Y3/wZchHjH8/dSsCpvyin7DgzOQoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX4HNwjHt7EZrnI2OAbRtgJF/oRrtNKYNfgqSfuTAcg=;
 b=SyBC2er6IX+qmw8cm6rdK1oANBW0HaOpG4xQWjVZecq2f5bORcXVsB4KeAC3KKTd8jmZN74s4iXrF4lb0Rf9Dq+9KjfP5neAnzbPmqgZczCjY4mwR8H94WOTMbu2kHnHKPRRW67w+wRKSvO98upo89AwtGFxI1wou1lCz+igDCzA/wT+Ur0ZFSPdceYMEwdBwmJOlyCGOtvUa/Pja6UFBm/iZ5nB0CS8gjoJLMHtTi/77RMDu1VEEWDzLDecl6SZHOpYziw7E36tdD1Mp810kc78F1H9FQCur966tbDD8ldVbR5y/TTY1W659J138sB+33pZ15YWcUp8Vejhif0XHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xsightlabs.com; dmarc=pass action=none
 header.from=xsightlabs.com; dkim=pass header.d=xsightlabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xsightlabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX4HNwjHt7EZrnI2OAbRtgJF/oRrtNKYNfgqSfuTAcg=;
 b=fPKr2uKUAjeyd7CfARAshpRqXRLHaxWhpGugDC1J7hydA0Y9wFMcG6jX+3m3n9k+zxRcw/mXYNcChtCttn2YwTHedxwtdSYNhCzE3xMWCPH8Og349Anrna19gwEpflndwLxAqQWaSNsg4vRCClwRr8VHwYyc66S55RolW04p9mU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xsightlabs.com;
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:446::5)
 by PAXP193MB2284.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 18:09:30 +0000
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::dfba:b6f1:374c:a371]) by AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::dfba:b6f1:374c:a371%7]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 18:09:30 +0000
Message-ID: <3b28294a-1e2b-140a-8462-5014ba893cc5@xsightlabs.com>
Date:   Thu, 17 Nov 2022 13:09:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC] ACPI: PCC: Support shared interrupt for multiple subspaces
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
Content-Language: en-US
From:   Robbie King <robbiek@xsightlabs.com>
In-Reply-To: <09e0a108-9f22-a9a0-2145-a81936745887@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:208:e8::34) To AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:446::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2335:EE_|PAXP193MB2284:EE_
X-MS-Office365-Filtering-Correlation-Id: efcd93bb-4dfa-475c-b4df-08dac8c6df3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5pw5UIGMqSyrGrioto2CryQg94aVGAKPRIbInRdzDbNUF8/RDY5SxRINcx8e15ZmaDVrkok4e4JKqjQf2VrREUoTSCCdkghN+457pgjDk0PQs3lqcBGjprMThQYJmKO4Fgc+1HQGAt21lr7eTuBYGODTkmgFE19IID1zDluxjhMvJbU2QRPDYY57BMteNC7MEeOxg+CIr+bQ7IQ0SYdcJNWdQVNsfSvHhfX6FUcqflcwAmzZAwgGv2socOyl5yoG0R5NgAvC9RljvOlvjBrafwzoOSU8CO44PpLjX4Wn74pmIOLulRo425Uf4ypyEKNGBzmMd1cc138urrFgiMNe+ykDw24yDc1kJ/oEHX0ti2Kmq3H5CNZrKzSPRhMLX5dHita8ssXjwYBrhDyCRKOEagMYF2OkRVNf4opRu8ioD7Dvmut2ZQpAdZCU9DC3nIyY0/Br1KAEN+4ANmvztWhb6AWrBMJI6OZRDvsqWqyvupNto3elncHnJhTtGDdW9s2NQOdjG6XBVaEDterj6kOfL5NK5dTEa3uWiybPtNsmi7LxZG1AAdFs07D8GjXVTMxYXszPDqqy5fD4TJFmsYEyRe6NMWrvfbxG+gtrcYNLx5ZMklOehfVBUFHEwuomIi6jEhMXtlmv0r2t9U9awkHZ8XA5RLrCDtO8dvdcEQ/4AXjpdvqAI9fyRtUh6WRi3LhG8dcmx1/1VPVm7RsL58NELnnC9ccQ4RfcuJu3ecjmSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2335.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39850400004)(396003)(136003)(366004)(376002)(451199015)(2906002)(31686004)(83380400001)(2616005)(186003)(41300700001)(478600001)(26005)(6506007)(6512007)(53546011)(6666004)(66946007)(66556008)(5660300002)(38100700002)(36756003)(8676002)(8936002)(66476007)(4326008)(316002)(86362001)(31696002)(6486002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hDSlhKS08rTmJpbHQya1VRd21BZlRObjZiK1BWZmkwMG1rc1I1MWt6WTVs?=
 =?utf-8?B?QTZzVk1QbzFSNkJUSGxOZlNLWGZ5d0kxSEJLWEhhUHY2L1dYQVllb0lWK3FU?=
 =?utf-8?B?TkZmNnpYdDNRYm1jR3NkTzRDV3ZaZEpDQ0F0U2IrTkEyMmlkMGpRTnFLRDVM?=
 =?utf-8?B?UXFOMXhVRTFFNStlZWI5NE9lVDZRVW1DTVZ4OHE5UmVuaVJpSU9vSHJML2xR?=
 =?utf-8?B?WjlnU2JUY29POGxvRzNVeXpJQlowMEh1QnY1OGRBV3VUdHh4dkRpZ01MNmY4?=
 =?utf-8?B?ZWRaaTFXc1VadzlrVTVzdjlzNFQ3RHprd3dldnpVNmRPT2twMFkrd3l3cEtZ?=
 =?utf-8?B?K2lPcGVMc1NrUUxwY0F2b3AxR3NLS3VDMkVkbmhKM05OUGxXS2NwZDFGYU9X?=
 =?utf-8?B?UVVMZW40Wkkzb01SSmw4Q0I1NzFGSmhIOGk2WHV3SDFmcDJxU3ljVjM5d1FY?=
 =?utf-8?B?UGtsSHFvcEY1YWd5a3JQSVNjaWtiSXd6K3VoQ2VyYW5wRUd2RUg2QzFzMGUw?=
 =?utf-8?B?T2ZkbWg3SGVxSkdmUDlTNUNZak4wdTByQ3p3VkVtUnpRQnVla01UMm8rYmJw?=
 =?utf-8?B?bEFPdzZGVmhTbU9xQ3BLNWh2MEFyWCsrTlN3Z2ZTS2ZqYTk1a2U2YVVRWkVo?=
 =?utf-8?B?WXNkOEVUWk8yRjlMalZqQ2M2T3QyMHB6Y3Fma1JXRDRaeTBPYVROUVlLVUdZ?=
 =?utf-8?B?Kyt2VEJ3N2hLUlYwMTNvNXVrMFE1Vk1UeDB2Yk9WWFZocjZYbjlzRWtyc0pj?=
 =?utf-8?B?QzlZdnY2Rndnald0Y3hJWUVBVlVhcTFwWFEzRHo5bXg4N1ltZkJnbEg2cHli?=
 =?utf-8?B?enJXQjNYV1RybG8wRTE2cXB4R2hRakZCR0RsUExZZlBqWk5ZeCt3MkpNclNq?=
 =?utf-8?B?b1pGVXJlSXhnQUNhZExFU2lKM1hrdk5uTkhYV0p0M2JDNlh6M3RxbldwWkp5?=
 =?utf-8?B?bmJNdXdxM01nT3BTZkR3SzZ2SHowc1AzbE1PVVFiMmpkK005eE9ybXFKZElW?=
 =?utf-8?B?MG04NHY4M25tR21XK2kyN0czSXAvZTdxbFN3djE0NnFxRm9jUkVaQTlaTFll?=
 =?utf-8?B?eGs4K3FHYXpSaTlEWDA1a1BaWHVsMENOM2RYVFhrT25uemlVZHBuRHVxOGdZ?=
 =?utf-8?B?cDk0YUlCS1ZiVGJ0L3RlWDBnVnF3cFJYaTZhUjMzamc3REczbTdiOEQxWGZr?=
 =?utf-8?B?UkVlbTUrVU9FQ3RQM2tPTnZHenozcm1BK2x1R3dVOWFqZGlWV01uaEZHV0Y5?=
 =?utf-8?B?Q05SbURzR21pSzY4QzdtRVR4YlBVZFFFdytOUktlOVhnTEw4eWh5NndPMWRu?=
 =?utf-8?B?d3hNd2pYVDBacjJLSTFoMWFPa1dTR0JUS3krTTZHL2h0MWVsOHFrOHdYV1hv?=
 =?utf-8?B?bWlvbVFPMlZPQTBnL0tkS3g0VkR2My9XbHBhQmJJZ1J1T3AzOFVJU3BFOUlV?=
 =?utf-8?B?dWY3RXZCVFJodnM3UjZVMjJtT25vT3JZOWZ3Q3p0UHhRdGVYeWN0aU5vbDdR?=
 =?utf-8?B?bFoyV2dqSkpuK01KVi8xSW5md2V6MnV3SjJGYVJvb2tTeCtHVHV6Z1N4RHM1?=
 =?utf-8?B?YlpEd2NsMmw4alBLNGRqMEoxdm9YSFEvZ2pLc01qM1RpbzBkd3lJeS8rYjYr?=
 =?utf-8?B?U2hTaWNMQ24vRDBLWUplaUl0ZGVpMTQ1Z1ZweHZML1lHczVjdjV5RWxLaGdw?=
 =?utf-8?B?TGhhbnlRWEhGSWVDWHVLRmRyUThoWkVoWU4yd2pCUkY3SUU4SFdYYkZBeUlG?=
 =?utf-8?B?bmVabzRVZ0tLKzFzbm5wQTB0Y3JWRVdVeUV3QmE1OXRoUnBCYnU2TVNVNDE0?=
 =?utf-8?B?ejB0OXJkN2JsTU5PZjRrRVBNNlg2cmdORHJWT3JTM3V5MHNhdUQrajRuVzM2?=
 =?utf-8?B?Z0pLejlYV0FxOFF5NVVCT2k5ckJMS1llbnovSUd1a2xucjFXQzBqbXIvTlFT?=
 =?utf-8?B?ZVE2MTB5czZzM1l5WDlMUWdLbDQ3Q0lnVjZBWGdrNStYR2xxVHlTL1NPWXZw?=
 =?utf-8?B?ekplVGRMNGRkSmNjREFWSEh2WnI3cWh5MXl6WEVud1J2VWZ4Z1BIYkhEcnZH?=
 =?utf-8?B?T05veDl5Q1hvRG9LZlpIN2FuSzNnNUhvOXpEbHpRaklTQWJzbzdCLytkWkRR?=
 =?utf-8?Q?qTkXn3Vsq9yyPsjRj+Grzf6xD?=
X-OriginatorOrg: xsightlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcd93bb-4dfa-475c-b4df-08dac8c6df3b
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 18:09:30.3314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 646a3e34-83ea-4273-9177-ab01923abaa9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6lR4rULoYLpT6VrKhhhzuR4IPNWfflzNabBxvNBNqINExO+UmXh3cSM1wm0nyptbZfxTve5qIP5PVSumuCmWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2284
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 1:24 AM, lihuisong (C) wrote:
> 
> 在 2022/11/4 23:39, Robbie King 写道:
>> On 11/4/2022 11:15 AM, Sudeep Holla wrote:
>>> On Fri, Nov 04, 2022 at 11:04:22AM -0400, Robbie King wrote:
>>>> Hello Huisong, your raising of the shared interrupt issue is very timely, I
>>>> am working to implement "Extended PCC subspaces (types 3 and 4)" using PCC
>>>> on the ARM RDN2 reference platform as a proof of concept, and encountered
>>>> this issue as well.  FWIW, I am currently testing using Sudeep's patch with
>>>> the "chan_in_use" flag removed, and so far have not encountered any issues.
>>>>
>>>
>>> Interesting, do you mean the patch I post in this thread but without the
>>> whole chan_in_use flag ?
>>
>> That's right, diff I'm running with is attached to end of message.
> Hello Robbie, In multiple subspaces scenario, there is a problem
> that OS doesn't know which channel should respond to the interrupt
> if no this chan_in_use flag. If you have not not encountered any
> issues in this case, it may be related to your register settings.
> 

Hi Huisong, apologies, I see your point now concerning multiple subspaces.

I have started stress testing where I continuously generate both requests
and notifications as quickly as possible, and unfortunately found an issue
even with the original chan_in_use patch.  I first had to modify the patch
to get the type 4 channel notifications to function at all, essentially
ignoring the chan_in_use flag for that channel.  With that change, I still
hit my original stress issue, where the pcc_mbox_irq function did not
correctly ignore an interrupt for the type 3 channel.

The issue occurs when a request from AP to SCP over the type 3 channel is
outstanding, and simultaneously the SCP initiates a notification over the
type 4 channel.  Since the two channels share an interrupt, both handlers
are invoked.

I've tried to draw out the state of the channel status "free" bits along
with the AP and SCP function calls involved.

type 3
------

  (1)pcc.c:pcc_send_data()
        |                         (5) mailbox.c:mbox_chan_receive_data()
_______v                      (4)pcc.c:pcc_mbox_irq()
free   \_________________________________________

                               ^
type 4                        ^
------                        ^
_____________________
free                 \_____________________________
                      ^        ^
                      |        |
(2)mod_smt.c:smt_transmit()   |
                               |
(3)mod_mhu2.c:raise_interrupt()

The sequence of events are:

1) OS initiates request to SCP by clearing FREE in status and ringing SCP doorbell
2) SCP initiates notification by filling shared memory and clearing FREE in status
3) SCP notifies OS by ringing OS doorbell
4) OS first invokes interrupt handler for type 3 channel

    At this step, the issue is that "val" from reading status (i.e. CommandCompleteCheck)
    is zero (SCP has not responded yet) so the code below falls through and continues
    to processes the interrupt as if the request has been acknowledged by the SCP.

	if (val) { /* Ensure GAS exists and value is non-zero */
		val &= pchan->cmd_complete.status_mask;
		if (!val)
			return IRQ_NONE;
	}

    The chan_in_use flag does not address this because the channel is indeed in use.

5) ACPI:PCC client kernel module is incorrectly notified that response data is
    available

I added the following fix (applied on top of Sudeep's original patch for clarity)
for the issue above which solved the stress test issue.  I've changed the interrupt
handler to explicitly verify that the status value matches the mask for type 3
interrupts before acknowledging them.  Conversely, a type 4 channel verifies that
the status value does *not* match the mask, since in this case we are functioning
as the recipient, not the initiator.

One concern is that since this fundamentally changes handling of the channel status,
that existing platforms could be impacted.

For reference, here are my Pcct.aslc tables:

   {
       EFI_ACPI_6_4_PCCT_SUBSPACE_TYPE_3_EXTENDED_PCC,
...
       ARM_GAS32(0x06000004ULL),          // CommandCompleteCheckRegister
       0x00000001ULL,                     // CommandCompleteCheckMask
       ARM_GAS32(0x06000004ULL),          // CommandCompleteUpdateRegister
       0xFFFFFFFEULL,                     // CommandCompleteUpdatePreserve
       0x00000000ULL,                     // CommandCompleteUpdateSet
       ARM_GAS32(0x06000004ULL),          // ErrorStatusRegister
       0x00000002ULL,                     // ErrorStatusMask
   },
   {
       EFI_ACPI_6_4_PCCT_SUBSPACE_TYPE_4_EXTENDED_PCC,
...
       ARM_GAS32(0x06000084ULL),          // CommandCompleteCheckRegister
       0x00000001ULL,                     // CommandCompleteCheckMask
       ARM_GAS32(0x06000084ULL),          // CommandCompleteUpdateRegister
       0xFFFFFFFEULL,                     // CommandCompleteUpdatePreserve
       0x00000001ULL,                     // CommandCompleteUpdateSet
       ARM_GAS32(0x06000084ULL),          // ErrorStatusRegister
       0x00000002ULL,                     // ErrorStatusMask
   },



diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f8febc4f3270..a7dfcb5503ff 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -93,6 +93,8 @@ struct pcc_chan_reg {
   * @plat_irq: platform interrupt
   * @plat_irq_flags: platform interrupt flags
   * @chan_in_use: flag indicating whether the channel is in use or not
+ * @is_controller: flow of data on the channel is controlled locally
+ *       (as opposed to notifications which originate remotely)
   */
  struct pcc_chan_info {
  	struct pcc_mbox_chan chan;
@@ -104,6 +106,7 @@ struct pcc_chan_info {
  	int plat_irq;
  	unsigned int plat_irq_flags;
  	bool chan_in_use;
+	bool is_controller;
  };

  #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
@@ -243,22 +246,32 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
  	struct pcc_chan_info *pchan;
  	struct mbox_chan *chan = p;
  	u64 val;
+	u64 cmp;
  	int ret;

  	pchan = chan->con_priv;

-	if (!pchan->chan_in_use)
+	if (pchan->is_controller && !pchan->chan_in_use)
  		return IRQ_NONE;

  	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
  	if (ret)
  		return IRQ_NONE;

-	if (val) { /* Ensure GAS exists and value is non-zero */
-		val &= pchan->cmd_complete.status_mask;
-		if (!val)
-			return IRQ_NONE;
-	}
+	/*
+	 * When we control data flow on the channel, we expect
+	 * to see the mask bit(s) set by the remote to indicate
+	 * the presence of a valid response.  When we do not
+	 * control the flow (i.e. type 4) the opposite is true.
+	 */
+	if (pchan->is_controller)
+		cmp = pchan->cmd_complete.status_mask;
+	else
+		cmp = 0;
+
+	val &= pchan->cmd_complete.status_mask;
+	if (cmp != val)
+		return IRQ_NONE;

  	ret = pcc_chan_reg_read(&pchan->error, &val);
  	if (ret)
@@ -704,6 +717,9 @@ static int pcc_mbox_probe(struct platform_device *pdev)
  		pcc_mbox_channels[i].con_priv = pchan;
  		pchan->chan.mchan = &pcc_mbox_channels[i];

+		pchan->is_controller =
+			(pcct_entry->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE);
+
  		if (pcct_entry->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE &&
  		    !pcc_mbox_ctrl->txdone_irq) {
  			pr_err("Plaform Interrupt flag must be set to 1");

