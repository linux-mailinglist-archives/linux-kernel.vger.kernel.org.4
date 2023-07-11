Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2F674E7F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGKH1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjGKH1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:27:19 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749359B;
        Tue, 11 Jul 2023 00:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXanmKV0W9rTScsQo9vUPyfLyx0CERa9LNY1gEuzOvbPnQwIgaGLmC+OQps1laq7OR7Qlx5DuYW4qAzlMGLAy7vDcilLW7D5YsHuSdm/nDLDAXnfpk40p88PVN01HNUSX79Z0/djs1AKAykx0mZj/MOm0fn0Md8vV9LKaDcLMtle5F+w7W8DzKJwXvf6HHWtmzbVQMOMbGDmCd63/kERBazASL1W9KApBEbQ1F4KiT1S7VC3RVh3xDUqUBRoTlGsGmgIf4Bk5pKMffEiune3g1WkiqEbQGU7gIc27RO1l6W1lnxniwsFfExg2u0wYskHew9W/Bq99jS2NP641hYyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fprb596Vc66j1fQV+Dv8Hft1Ez6ow2ZRFTXRLViiY80=;
 b=Bq/iqIZQwppNKRb4D14KgHJGIFu2LwAP+Sd6KfjM6itF61yplHduifbyQs7vJX0zjvGtAnt6+RnXaJzBC4jCufPk1PjnjbDsOpqJcYosai9PQQucgYxbCG8+6BcB5W++T+UPwbcoHlKkMZgpNz9jF6ytNcONXHCdzFo8eTQ4+u36BIW5g6SQRGKS9R5B1UXgcT3l+vBU737agR+y8Vtdb7rBOnSEZ7RVeJ5aObpYQz1/YNJAgtZwxtc7ePa9CTM4AQueyPxMHzS8zhH+7WJOncu97HJ0PFHSKrDwqw/isMKXcjP8vxvUd6YMfM5zkH4A5eQF7VS09Yvii+v0aVcwuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fprb596Vc66j1fQV+Dv8Hft1Ez6ow2ZRFTXRLViiY80=;
 b=W8AJrHVwyI1ALSPmAeVALyNCG2ZTld1QLktlWE12Kv3T789RABvtO6TvGFnqoV58/wppqvrjABNr1Y2+N5PvjDWf2HuPuwDHFsGe6c54ikRr2sC34clCgHwKUH70ngFGIdWAcNM1d9gg230Zo8n4W0KZhaZsFFt6CJt5ga47ESuAxAwOC0hC+/36wKDQRwdrqrN453cHoVFcctEjIebSXiSH4ArCsWbfWZxnKnKejxXdxw/deihOrV2U5vz4hsAhZuv7L3O9jN67hSdA412NV4B7yEBS2aatUnVKy0u9ObWMSgunGLAR0j/dn+qzDQmYyEik/P3yK/lOcfP86IiWUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3463.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:139::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 07:27:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 07:27:16 +0000
Message-ID: <69dd51b9-aab1-a9ec-91c2-b1dc79797f10@siemens.com>
Date:   Tue, 11 Jul 2023 09:27:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] rtc: pcf-8563: Report previously detected low-voltage via
 RTC_VL_BACKUP_LOW
Content-Language: en-US
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <da84b6b1-a9d8-ce46-16a9-e1a2d495240c@siemens.com>
 <20230610083135e40dd2f6@mail.local>
 <1d532c45-ee33-9729-f0ac-b59c2bec8d7d@siemens.com>
 <202306111511569834cac2@mail.local>
 <9ac4b2a5-7cc8-4fce-7ea0-61b26d6ef223@siemens.com>
 <202306112216153a75dfa3@mail.local>
 <c195c196-d99b-9e17-3854-fc147ac2e447@siemens.com>
In-Reply-To: <c195c196-d99b-9e17-3854-fc147ac2e447@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3463:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2e6c64-5bba-4f7c-c42a-08db81e040c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DPFelRfjU8LSX9gEDQqRQ4gw8f2iqZwhZ1Cf+4R7PLtqkfuIrqlbYPKTz8oOGPsQMRFmbEqdTbyJQb7fygPzD3Kl06ayHabDT+TKE8F+AQvuBwHpfaJhTzJss7e4xTiwyrWO2lLa28/4/5UwD+xZx0i/9P8uiz9zwJoOR0tsRJBrdMZwbjqlNqS3dMGipKlmPvMjEvI5+Ulz4qzQeZ7L/feAFhtq/fgPwkv/pMr6hgbPR3qaO03KZua4IutcMzb7PKsAs0rIdpyMR3/gN5nWdExmeH2KMhCJIgdQI3I5ZaZhmaJe/+hc0clJ3775D3nOzGY+pLpIgFTkysQ1chi6fc+AOLuqLxzXhPT4gN7VVe6i8Xg1o2/xauadP2QczHX6W1P0gEu//+wmA/cDLHaA06fdClRjX8imh5/NC9LbipfbiVYyoXyOWhTyGIgQyvC0uuRsavjvqGg79TeS+dMkkKxSZ/tFdxsie6NXwJvFRKWJU1VOwSaIni717vMUplTJB5FoO3JrQxlp6kTbUhIhpVbMZdLx5InvTQDbp0jPAdZMTfMMEDHQORXkVLScXnsnCYrpZqRdm/VCKKXubr0X/AW9XwgCZFQZAZzZ7W5tIWVQCCtz1crIrQ/op1pH15soLYQkVPNJY345tMp0LetJ/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(8676002)(8936002)(5660300002)(478600001)(41300700001)(6486002)(6512007)(316002)(4326008)(6916009)(53546011)(186003)(6506007)(26005)(54906003)(66946007)(66556008)(31686004)(66476007)(44832011)(2906002)(2616005)(83380400001)(38100700002)(82960400001)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3JKdzdmZDU4VkIyZUlZdmV2eFcrc216eS9LN3dTcTlJRTVxTm5kWVdUbExo?=
 =?utf-8?B?Z3M1amU0VExIbHZQNzBMKzlkWkFnQTA3ZVM1MVF5ZW9sNlZNZjV4U3VCaUF2?=
 =?utf-8?B?R0szaVJ3Z3lMbXZIdk93T0dxdmxXRDNUdExyb1NicVFGak1ZZzBFWkZTdCsw?=
 =?utf-8?B?UVp1Z2hCYzNFcjUxbUVyMlNBQWppK3FEUWNNekxvcXBlMjdXSGVLRDl5cTZz?=
 =?utf-8?B?VGlmcVV3c0JTZHMyUjFab1d6Zk1MdGl1cUtodjFydmp2QXFsUjB0QmVUMGxt?=
 =?utf-8?B?TnRQMC91WURWczE2TWkwN3E1VTUydkRZb0RnRXN3V2RtRzJoYmkvanA4WjRx?=
 =?utf-8?B?L1V2aXhYTzNDVS8ydHJTeGNvb2xONFQrZ21JNlhudUE3ZEg0Z0V4cU55R2hW?=
 =?utf-8?B?eHYxaGx5Ym1ENzRaK2haVHhUYkpldmJKeDRJQkRKL001emRNMnlpZWJlUnB1?=
 =?utf-8?B?Ky91QkZrdTgxbTJTazBsYlFVVnRONEFIYWJiSDk5djcrdVhST0Y4YldQblVP?=
 =?utf-8?B?SlFqYVZQQnJMOWxmeFFUWllhbUp6VUgyU3pIc1NxUklFWm5XVkZKdHlFQUR2?=
 =?utf-8?B?UXI3Sytya3poQU9IQmRSYmpHeGFQTVhWeWdEUG9wUjRmb2c4dk1icVEzMVp0?=
 =?utf-8?B?dVRvbVNESlZKNDJCL3JpSk1mSlZBZHEwYTNtQ1hKNjZzTGlwd2NBbnJTQUJJ?=
 =?utf-8?B?RjRtblRCRXZDTHMxWjVVckpXTDFvK2tTbnF6NlBQdk8vTjZIK2ZNVXQ3SXla?=
 =?utf-8?B?WCtUdGZyY3NHaFpzS1VRSkw5aGw4YXhqenEvSWhNWm5VUWVKM3lZKzFrTWtv?=
 =?utf-8?B?UXpGSzIvU3YraXNlTTVpeXdQMVg3VGdPMFl4TGo1RzFvWWh5cGEwdlg5dEtG?=
 =?utf-8?B?ZGRQYnZoQ2NWL3RUTlF6VkhVeUhvbTVCcTlWbGlxdUIrUVBTNXlZd2NZb3ZL?=
 =?utf-8?B?dkExbFk5UjNNODFxcjBVSk1kS2xjR1F5eGFQVzNZUDYzRHN3MEpTMlVjTktO?=
 =?utf-8?B?OHhHR0hkUUhKemdDVmJKZkV3NE9hWFYwQWxNN2xhZ1VDOFdUU1JEUjJBejY4?=
 =?utf-8?B?cHN0VWRRclQ1OERjZUVkUFRteDlMYzc4dExNcm14Qy8zcjZQYkFFNGJmVTlt?=
 =?utf-8?B?YTNFc1hLNWVQWlo2TWlBNXZrUmVsemRjcXZuTzZudlVpSEtBOU93S1JtaUdP?=
 =?utf-8?B?OFcveHhoTkdQMDRPMVNHMHptdkVYSFJOLzk5VUozZjdLYk9wUVkrUElhaVdr?=
 =?utf-8?B?SG91M0gzOVBCOVpVTW9zZFpWemZaOWY1ajh0Mzc5VEdQaVJDY29XSEtXY1kr?=
 =?utf-8?B?SG5wc1Q5R0dhNjIraVA2bDA4RlBVSG50TGR4OWREb0l1U1Y2RlJqMFBXbVNI?=
 =?utf-8?B?QXZsVUV2clRkaVE2aXkxMnRhNkwwVSs1OFVnbEZqR0NSWnYydzF5dGQrTG9h?=
 =?utf-8?B?bCsvM1hSQkw4c08wQVFKSmJGUXFYZkFiNHhEWlRtdnc3MHp5TDBwMjUwSEpM?=
 =?utf-8?B?aWdaNWV3OGMzdzZGUGVlU3ovT1VjbFBIUkdvem02dUsxdTl5Z2ZlUS9OcGpW?=
 =?utf-8?B?aDVnWWlRMjdXZVU5NS9nTHJRUFNldThzWEN2OVpIVUE3aWZBMnQ5YWdDdG9Y?=
 =?utf-8?B?T2oxeUdaamh6WGxhbXNtMC84cWdjVEZRcHpWa0w1N045NkMrVmM4U0NuZ0h1?=
 =?utf-8?B?MGRDb1NVamZCZXlIT0lUZGNuYURTc2ZsS1I0a1ZHSmJSSlU4VWl1OWtSNnZl?=
 =?utf-8?B?aWZvSFRtOEQybSt0QlVCeERVVUwxRStyQ0o5dlZhSW9KSVVyWWlxZkxFcEZn?=
 =?utf-8?B?ZXVBcm1SdWxGaUNmQkF5S3hXclhwU2VYSFpJS1NIbnp2c0s0OFVDWWtUNnoz?=
 =?utf-8?B?T1hEd29JWXFGVmpxL0d3Z0RVRHEzczBJMDR4QTBleXhiRnJpdldqNTBwYWEz?=
 =?utf-8?B?eWk1eHQyYnBqVWVya1JuTWdCWTZoc1NsWVk0QzdOUVlHNVV4RnJFSkM2S3hh?=
 =?utf-8?B?YysxKzdjQ045MG9jN2lTY1ZDMVB4UE5YMXM4VkcyZDlhS2JLZDNvQ1kyR1dZ?=
 =?utf-8?B?NFFsdmtYTk9tYWhoUGpBZ2orYlIrM3hkejZ1Vkc0Mmw3RFhLamg0cFd0SFl4?=
 =?utf-8?B?dlFObC9LaTJxWC9XQXZ1TWx6QUtQVGd3aWsyL0VtRVpoUG14ckNWRUo3eFBL?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2e6c64-5bba-4f7c-c42a-08db81e040c3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 07:27:16.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vu2vzLdw1rjwELPeIVL+HyiDaWBu4wO9tbB1o0iK+1hoJ+kghu0d2e0zXY+JkYf8Y9/gqg6Bx98eIarxeECDDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3463
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.23 08:49, Jan Kiszka wrote:
> On 12.06.23 00:16, Alexandre Belloni wrote:
>> On 11/06/2023 18:28:22+0200, Jan Kiszka wrote:
>>> On 11.06.23 17:11, Alexandre Belloni wrote:
>>>> On 11/06/2023 15:38:04+0200, Jan Kiszka wrote:
>>>>> On 10.06.23 10:31, Alexandre Belloni wrote:
>>>>>> Hello Jan,
>>>>>>
>>>>>> On 09/06/2023 23:04:12+0200, Jan Kiszka wrote:
>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>
>>>>>>> The VL bit in the seconds register remains set only until seconds are
>>>>>>> written under main power. As this often happens during boot-up after
>>>>>>> picking up a network time, make sure to preserve the low battery state
>>>>>>> across this, caching it and returning it via the RTC_VL_BACKUP_LOW bit.
>>>>>>>
>>>>>>> To permit userspace clearing this state during runtime, also implement
>>>>>>> RTC_VL_CLR that works against the cached state.
>>>>>>>
>>>>>>> This is emulating RTCs which have a battery voltage check that works
>>>>>>> under main power as well.
>>>>>>>
>>>>>>
>>>>>> Emulating doesn't work well and I deliberately chose to not implement
>>>>>> it. For example, in your scenario, if you boot twice without using
>>>>>> VL_READ, you anyway have lost the information. This makes emulating
>>>>>> unreliabl. The fix you need is in userspace where you have to ensure you
>>>>>> read the status before setting the time.
>>>>>
>>>>> Then let's make sure the bit is also set in the hardware register. Then
>>>>> also the reboot issue (which is practically a minor one) is solved. The
>>>>> current situation is far from optimal.
>>>>
>>>> This doesn't work because then the time will be considered invalid. I'm
>>>> not sure why you don't want to fix your userspace.
>>>>
>>>
>>> Nope, that could be easily avoided in software. The actual problem is
>>> that the VL bit is not settable (clear-on-write). And that means we
>>> can't do anything about losing the low battery information across
>>> reboots - but that's no difference to the situation with the existing
>>> driver.
>>>
>>> There is no "fix" for userspace as there is no standard framework to
>>> read-out the status early and retrieve it from there when the user asks
>>> for it. That's best done in the kernel.
>>
>> That's not true, nothing prevents userspace from reading the battery
>> status before setting the time and destroying the information which is
>> exactly what you should be doing.
> 
> What is your "userspace"? Mine is stock Debian with systemd and
> timesyncd enabled. But there is no framework to read the status early
> enough and propagate that after timesyncd did its job. Any concrete
> suggestion to "fix" userspace?
> 

Ping - I still have seen no suggestion to improve this situation otherwise.

>>
>>>
>>> In that light, I still believe my patch is an improvement over the
>>> current situation without making anything worse.
>>
>> The information goes from behaving deterministically to being unreliable
>> which makes the situation worse.
> 
> Nope, not at all. You already lose the VL bit today during reboot when
> you have written a new value (which is standard). So this here is not
> making things worse. It's rather improving the situation for the first
> boot at least. Deterministically.
> 
> Jan
> 

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

