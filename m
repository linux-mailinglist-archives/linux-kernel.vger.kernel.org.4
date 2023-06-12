Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBB272B8CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjFLHkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbjFLHk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:40:26 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE24510DA;
        Mon, 12 Jun 2023 00:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdJPlOJk/Pyifui7i+8UWM44ilhlq/XMKV6vnLwgM3s+9bVGS+8NoImO95WeprMcYlBKk2cC04UTUnNl25vmDryhLHYApCpofjZvBqSM6fkVCZVW2B+JCqocG/TsIl0Vnqd/fpbUyqS8gXTYGUrTJ5sxoWb0DrpYrJSY+AwJvYe7MN4FrgJfaLaFLVeRw9D82w/cVeK5tErDvse4C0jZ+KIIxhEDvH2I0N0tpeq38TJ45QR0EwK/NZkhQ2HiEvzjG5uT6XIWMCWXo+lF+8le6TNtUCo610qs0OPdI8G9RyD7Fv1boAyo0jUSFsm22ltyqUK1mVlLHwdysfg5cM8KmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N75a6xG3s+qLFF3PlI6av295LIDPuta7mHnO0bq2XzE=;
 b=Xip0mXkhFtRGvLSXZHOy0dAw4pv9kihff5mbyMSMq2vpMn6zIkgnPAEI60yTliP5GdlDh7kRg+/dIXlQNyocjElwiOrYbn97C2keyaoLlTiJYKxpE43vYEQYC86cojGgTfqxZt3YjLjlYp+ibJEHUK/2MYt89mog901vf/E95d1QHf5Cuq7QpB2X4FGRJifzJl8B0o7LbcVGi9hHaOKuPVSGjguL0VYzzIUj5CC0MOdO5R5bXfh1rl1yMK5aXkJOKmyF6vpWt6x4du2lvJUwp1VMjfqHuCXHs2XaDChoYMAcbwczE80Kn2Wf4Olgh1F6KkNBpvpJWhsO4GgOBqHEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N75a6xG3s+qLFF3PlI6av295LIDPuta7mHnO0bq2XzE=;
 b=gCnDXapMhaclLx87L16cmcSjva0VtyX/kNC41Sswmwig5s6NmZrXkqSmEHVkMZPoyR2F1krr9aC45/2UgP4NlbCanpFJlDpKDI/lY6Zq9Sg4GNFO7cD4SFdSMcz/2GVxPY3l6DBTfeFlkcgarClPpM8OtACGiTvy7f6U7wKoYtqBp57tq4lHI+0uGD4LMxF7W1wUO6quqnBav92GucosHLtT3IUgaxBeIKWW1OLlByf41Ah4hnC92StRkTStJlsCxFjmb/zhdOQHYCbSys0EgrZQ034iAUsXaAGHSC78EYQ7sHH0NROA/hEqVpujr/dno+a115tS24FM0ekA/hLoNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8113.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:37e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 12 Jun
 2023 06:49:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 06:49:13 +0000
Message-ID: <c195c196-d99b-9e17-3854-fc147ac2e447@siemens.com>
Date:   Mon, 12 Jun 2023 08:49:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] rtc: pcf-8563: Report previously detected low-voltage via
 RTC_VL_BACKUP_LOW
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <da84b6b1-a9d8-ce46-16a9-e1a2d495240c@siemens.com>
 <20230610083135e40dd2f6@mail.local>
 <1d532c45-ee33-9729-f0ac-b59c2bec8d7d@siemens.com>
 <202306111511569834cac2@mail.local>
 <9ac4b2a5-7cc8-4fce-7ea0-61b26d6ef223@siemens.com>
 <202306112216153a75dfa3@mail.local>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <202306112216153a75dfa3@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:610:e5::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 56fff30d-6899-4bb8-04fd-08db6b1121f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBB44RjTlo5WlOpr0IVJ1IJuZrxGW5R1eSizjlwnHcm7eUuMAmFfSgZb7K08gGK1P/TrjTzX4fc3tLbTs7+7ikhdgN/koIV625gPlvgMLkS/+6HnK0STB1iXyHaIGmOMCQkjBFB0FAvgEEJ1/nW1CIJb4IeVakqv1Xu6Mdcp8L5Lf4fXqobWjTr1ONcgiTki3iv1wvSPg2Ce7G+zrbqTa5VXM5Gj/ojc6BPAygzSOeDReypfldenF82iATQJl+q4ikzKvLkaHXxh/LzsVWyTeASs705MNf28xchP5VBogLITH+cNYrHYsUb3azbKp2Wzm7SOLrhJK2JuQMqk/qEGDj2lKcpdhhpHyvXHzRRV2s78Vk4MCCzHH8QdtPzcDuYymAnjqiRaExY+KqaRCnJpg/JbU8LtxpJZ292lHRERxrxhrgKRS+4vy61Qfi1WqaGW1Wgrdrje7R++9kD7UiwwfkiNThVXfTo0+CwMdbnSheyhlDMB0xYxkmRREZm8YCLXkIGVBUnIRxsz9ep3pkWOwSC4EfJy7wCobeYWK1GI76sJln1ZuYF3RCoX6fZF2ri6iZq46j3msIVBoip4vvJmBMjU2somuEgU314pKyGX0ooV9PMeN2nJDCRCYI3eS0rbIMbXftrgRrJSgKm0DL7cwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(83380400001)(66476007)(66556008)(66946007)(6916009)(6512007)(6506007)(26005)(53546011)(6666004)(6486002)(478600001)(2616005)(54906003)(186003)(86362001)(44832011)(2906002)(8936002)(8676002)(31696002)(5660300002)(316002)(36756003)(4326008)(82960400001)(41300700001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnFvZkI1Sm0xcW1OTWY0KytjaW5BSVpzWGZydndrSHZyUzB3ZU5STW1ZdVI5?=
 =?utf-8?B?TFFZL0xodVEybWt0VXk2TG1ZcVR1dUJGa1ZGRml2aHFEV082aE9aTisxMkc0?=
 =?utf-8?B?WWRTTEQxTmN4OUVCajVhRmNJcUV6cFRWenpxZ0ZsTlBEUGJvRGpCYnkyZU5O?=
 =?utf-8?B?Wmg0Ri9BKzA4RWFOWDZ5bE9rTWt6WnBsNlQ1VTkxZkJrcEpFZXM5L0Y4U1Bt?=
 =?utf-8?B?YWtxL3ZKOXkyQnlpTEFkZU9qQmN1Vk1CZkxjSnRVTllKdDJPUTJJbXFjR1Nm?=
 =?utf-8?B?UXJlcFFPNHBWLzYzVG94VE1xOHRvZitzYllMOTYrRjZHY25uRlJ3MThNMmo1?=
 =?utf-8?B?UTI0cWh2cWE5RWV0bDdoY1RuNnNEamplNFZZY29QeEdSYWwwRDBDRnRqblJm?=
 =?utf-8?B?K3FrUld4djh2K0gyeVpObVVGUTZ1azZmT2JzTHpLLzVDTWxKYkZBRUpUQTNs?=
 =?utf-8?B?eW1BTDc4aEZLaXFibUhLdzJzQTZGVCthbEFsMDQ0Znptb0daYTZuekJaYlI3?=
 =?utf-8?B?bkpEdXRmNWhkWnVtaDg5S3kwV1c3QWxZd2QvYXNmc2NwVUhJWVVkc0R1bzJB?=
 =?utf-8?B?MEJLaEhPMXlER05CYTVWTUwxYXFwWXh2UCtDT1lRNzdMMk5pc0tpYVMxeWRZ?=
 =?utf-8?B?aGFjNFVlSERlR1N0WHRqQ3F6RGMvcWVlRnJ0Z3NtWURHa1AxK3FIdWpCSm9j?=
 =?utf-8?B?OVpvcGVjaDFaeThJWFY4VUd6M3ZmaE5DdDVJNy91UGdOSHN6eVBxR1lsQUJq?=
 =?utf-8?B?L2daQmNHbmdBb2JTaWlsQmhPWVlxdThxUitVT3UvdnlyT3YyL3M4S1hDR1Zy?=
 =?utf-8?B?NUlJNXlFQnVGUkdPcGR2aUNBMTNpTG5QNXhlVTVTMVRKV0ErSmxtZk5jMElP?=
 =?utf-8?B?dStsUUk1aTR5aE1QT2tjU3RDUlVpc1BDb3krdXRJZDBIRVg3NHp5eVhzR3lB?=
 =?utf-8?B?U3Azb3pwbGlPYjZMdVF0MTNTMFhoUDRXcnJyL1QwMENyVk9mNFBuZHhkMnN4?=
 =?utf-8?B?QjRUczlTVWpkM3NQcXk0RGYyQmxOUC9QbFoyRnFGWjM3S1gwNDgzS1FYdS9L?=
 =?utf-8?B?SUptMjFvRmtiVlBPTHVzSnFFUXowaW9IQzJjODR2bitGSWRVRzQ2Z08rN1Z5?=
 =?utf-8?B?TGpjWmJCU3VWQkRTdUtZQ2JySGxtM3krYlBCMjg2NElLRVVWNHYrL0hBbnFy?=
 =?utf-8?B?Y2hhNFBnYXJrMHdmNGswaENxNTNEUXlzSHcrN3o2OE5RZkxKOFQ0dzJVV2Np?=
 =?utf-8?B?ZlI0M2o4em1CeGFCTUl1eUJLZ0pBcTdPcFVrU2Fha3FlOW5ZUHJDQnJpSFVm?=
 =?utf-8?B?NDMvTFA2OUlaWm9lYmh0TWdlL2pBaUtBa3lnRWtENXJrRHdRMjZQUzVsUXJx?=
 =?utf-8?B?SVR0bG5RV3FFaGcwblEzdlRmNUgyRmNybGVtMGZBQWw0ZmNYRWRQS1ZGUFpR?=
 =?utf-8?B?dHFMY0lFNVl4SHpuOTZkWk5kQm1Ka1ZuU0hkZ2NvZGN0Ni9iM3RFSm8vQkE0?=
 =?utf-8?B?OGIzRmYzaGc4Y3JWSHdBUnhMTDVBdDhMRXMvclpzU29ReGRZd2NkYzdHcVlu?=
 =?utf-8?B?VDYrc1lrZThTZDF6TzI4RXRRZlFZaEp6anpSREx4eXM0YkpyL0VXT3cvQVN0?=
 =?utf-8?B?aHArbTQ1dkE2ZjB0cDcrV0hleUtieTQwbkg3UE55WjkyZy9MTmhna041WkRq?=
 =?utf-8?B?RkllSUJEN0xBVmtremJPcm1GNE52MncwbTRWVTZ0b2UyaUdDUXY2ODYvT1dN?=
 =?utf-8?B?Z2xTVzQ0cGVLUUNaQWUrQTVocDgwck9nMzlJTHZ5QWJNL0Z2SFFFUlZaNTFF?=
 =?utf-8?B?V2xValVlelZaWW50Q3g0RStydk40aWNlZldPcEt2NHlqL2V6OEdoZ09jRk00?=
 =?utf-8?B?azVydlZOb0pVZnFTenptS0Z1bEdLT1grTS9GMFZVbmtqdmtBcXFVR1NERm8r?=
 =?utf-8?B?dEgvUU1KQjRROHlsaGxidnJpQzJ6bHlWUkpsL214QlJpR3pqS0thNVRSSkdU?=
 =?utf-8?B?YXlyMm9vaU03TW5Qb0w4R2FmYURqY1ExL2hCbnhUeWl6eVVBandjUXBOeGEw?=
 =?utf-8?B?L3BOeXYxUGU2U2I4M3pFdCtBTHpsQVlpV0kxRUVPWGh3M2lMYnFCZEk2eHhX?=
 =?utf-8?B?THFmTGhhRW9qMWJ1ZWFzU042c3dyakxDN3Y4QWRUNFVmdzUwTXhZcS90Kzkz?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fff30d-6899-4bb8-04fd-08db6b1121f8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 06:49:13.4667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDHemdxQ7YNqNHqvT8reQ81tUAWUnrTxGkiGRJFpY6/PUksi/cFN5RP/L6c0/+LU38ocvcCSE/b8eHHAk0j1sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8113
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.23 00:16, Alexandre Belloni wrote:
> On 11/06/2023 18:28:22+0200, Jan Kiszka wrote:
>> On 11.06.23 17:11, Alexandre Belloni wrote:
>>> On 11/06/2023 15:38:04+0200, Jan Kiszka wrote:
>>>> On 10.06.23 10:31, Alexandre Belloni wrote:
>>>>> Hello Jan,
>>>>>
>>>>> On 09/06/2023 23:04:12+0200, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> The VL bit in the seconds register remains set only until seconds are
>>>>>> written under main power. As this often happens during boot-up after
>>>>>> picking up a network time, make sure to preserve the low battery state
>>>>>> across this, caching it and returning it via the RTC_VL_BACKUP_LOW bit.
>>>>>>
>>>>>> To permit userspace clearing this state during runtime, also implement
>>>>>> RTC_VL_CLR that works against the cached state.
>>>>>>
>>>>>> This is emulating RTCs which have a battery voltage check that works
>>>>>> under main power as well.
>>>>>>
>>>>>
>>>>> Emulating doesn't work well and I deliberately chose to not implement
>>>>> it. For example, in your scenario, if you boot twice without using
>>>>> VL_READ, you anyway have lost the information. This makes emulating
>>>>> unreliabl. The fix you need is in userspace where you have to ensure you
>>>>> read the status before setting the time.
>>>>
>>>> Then let's make sure the bit is also set in the hardware register. Then
>>>> also the reboot issue (which is practically a minor one) is solved. The
>>>> current situation is far from optimal.
>>>
>>> This doesn't work because then the time will be considered invalid. I'm
>>> not sure why you don't want to fix your userspace.
>>>
>>
>> Nope, that could be easily avoided in software. The actual problem is
>> that the VL bit is not settable (clear-on-write). And that means we
>> can't do anything about losing the low battery information across
>> reboots - but that's no difference to the situation with the existing
>> driver.
>>
>> There is no "fix" for userspace as there is no standard framework to
>> read-out the status early and retrieve it from there when the user asks
>> for it. That's best done in the kernel.
> 
> That's not true, nothing prevents userspace from reading the battery
> status before setting the time and destroying the information which is
> exactly what you should be doing.

What is your "userspace"? Mine is stock Debian with systemd and
timesyncd enabled. But there is no framework to read the status early
enough and propagate that after timesyncd did its job. Any concrete
suggestion to "fix" userspace?

> 
>>
>> In that light, I still believe my patch is an improvement over the
>> current situation without making anything worse.
> 
> The information goes from behaving deterministically to being unreliable
> which makes the situation worse.

Nope, not at all. You already lose the VL bit today during reboot when
you have written a new value (which is standard). So this here is not
making things worse. It's rather improving the situation for the first
boot at least. Deterministically.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

