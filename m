Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3C06AE0F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCGNnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjCGNmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:42:12 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C143344A;
        Tue,  7 Mar 2023 05:41:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi3pgtUWFCGX5Dw7qmXiwpgiKApwxtbJAnd9ElzbWdSILvWl4mnXag1cJxUNQES6mCeZckbYsiZZYtXKZ87ug230A7Ep6khzHnpD9eH07S8hoRwJTiOJZNgdfyOgywC7tD+qM9eVFJtO/KjOUDvDCFNmayk9TaOZhxYtgZ1wD0ScdkN7uVGu/uqDmYWShU/DcEtANWp6KPDZiMIsziTu33NigD9/w/6WC7AHKSAqN7mGH7M2yPR5c5QkCpSQKOQ7SUiTrzUmf2PIxnlfpEHSg9cZ3RHwNeCaShkHId0Wt3uty6dSUdSz9kaXUsxnQNc7F9wr69IIT6EQ45KwfTfmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OViwvK/iXR46ZTlxrWy60AcnggfVX4RM1oB5gnYV5M=;
 b=Juj0fA5OtmDIqg64uEc/8X9Zs0afUN2ZSZ+Rx8wskyFhf6CH4+y55QgTVjjKrXOa9xo+OjNchUT78XSPcqAKSIaXlJ1tkkgVN288lC4UYUDfpkoGZHkmac/3V98mrh7CEYinT4n5PHWJ1lQSRV5arwEZSGitdY05miW1dbVTrH6z6oBfnZfS2jipObbVBrmyG7nIM6EgJN4zBsHcKSkGX8qmNkInPdZ3n2D8OW1hz1eJATTUQNAiodoVYyH0Itwq2hqxwb8B3zbC2qysP6cNzbVXJ+CykfGffEhoQG3la/rGTGc0ZqdZLJRm97hiPUMt+g45FKbjL+Rlv7VMNwRkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OViwvK/iXR46ZTlxrWy60AcnggfVX4RM1oB5gnYV5M=;
 b=1oSTtXW0uKvGi/1cES73SdneOJgzBCLz71Oak+UxcVeLfb0tSRSvSDPWf3BFBeZSY7soAR5xhHNpMnHDoxoERW/7wfOdq510Rwde9p7S95isW53VJvaaa/gPAGwQWGSTVohGJhL7KK512CJFjwg69b2cA91A94f01tcqp0YkZ6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 13:41:53 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 13:41:53 +0000
Message-ID: <bb3fe216-9fe3-cc64-decf-290df128e370@amd.com>
Date:   Tue, 7 Mar 2023 07:41:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] docs/sp_SP: Add process deprecated translation
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sergio.collado@gmail.com
References: <20230306134420.30210-1-carlos.bilbao@amd.com>
 <38cb9f23-a56a-f420-5942-0bfeb620306e@gmail.com>
 <875b2564-589b-c381-cbf0-f30470d4a5a8@amd.com>
 <6f1d8954-586b-efea-526b-ef461b5624df@gmail.com>
 <2b4f177b-3b8a-fef6-e7a5-692db347679e@amd.com>
 <dbd8ece3-fb92-9ca3-917b-4951af7e1593@gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <dbd8ece3-fb92-9ca3-917b-4951af7e1593@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:610:5a::13) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 57013323-7cab-4be2-80c7-08db1f11b633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKEwS/I9w45F4IIn7IkTWRRXKpQdbqOtCqNNfbwbsOUCLxDOVCUZzCvAb/iep3o6indYdoW1wlnJg3nBTlgaXwrOyeCqM0W20FcJYB0A1wrT6Yn9MXnlbrX79GEltEgcxr46XpjBnB3xDl5uFuvYJ2uNAVOy8Uf71g1Mt18gIwXT8n6Oj7b8quM2E7l3EeKrnGn3hrvceCI9bvGfm5S0WZdDeytD0vYxEK2RmXl92VA5znLPMhxwGDyQAJeikP4h0qiQx0nWMfZDx5MeJ/pjzhukZbqboTkDlaSpEUNagKtlrxrH7oM5sWBush7sDKdT1alow3Y4VInImzB/jXkHtoMQ7BmdEUV1vuH6UYlZNrbbLY8col43z7ZdfbcOiEs31URC8YYSs6O/VkfCGiCY/i5WC4hvQgzslhPeU2qTDyiTgDLUF+KK3G01hn8LC4qXnIWPyOYPpcPJEs4b6EHa/Er9sJlVZtLUxTdagtCpSB9DLGoOytaKS+3Yv6VEs4ZRLOMJm47lgYgvXZFtsfp4m5v7+1FeTfYxYw0a9f0GBOy7oI+V5+dc8HThNDz/SB5p5/OqHJ3taYNBb4GGnKNLMGvP6vTQV6zD3HThxNmNA0ifRuuff0uKWPZsfRoo4+7r7NkTDRV9wk6iZ3+UgYdIPcwgomTC3hKZXz4vr3yLgXNoZvc6LLFHqNlCZdSX45tNlbDf5yw+Vamkk4vmF4lS/nL/1T8obQVyaUAETKbnvD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199018)(26005)(186003)(66556008)(8676002)(5660300002)(66946007)(6916009)(66476007)(4326008)(6486002)(478600001)(966005)(86362001)(31696002)(316002)(6512007)(6506007)(8936002)(36756003)(41300700001)(53546011)(38100700002)(2906002)(2616005)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWdodlo4Wk5keXhKTU8rZndsSUl5R0FMMDRwMm9XZGlZcjYxc0hrS3Nsd2VH?=
 =?utf-8?B?VDVLaTAxRW5hR1ZDVkpKNGtZM2FBWS9yUWJ0aTZnQ0JlaXFuSmdDSzB3VVY4?=
 =?utf-8?B?UGg0WDZ6MERNQmJOS0puUyttbjhScTJyVTYvYkNleE8xY0E0Y25mRTQ4T001?=
 =?utf-8?B?MGRoVWJhS0FNWlV0a2xVRWlZcFU4QUpRMzk0aWdPRzBaSDliSVJNVFo4ZGgy?=
 =?utf-8?B?Uy9jZlJoUm1YanZHbzdEbHNicDZ5TWVKVmFtZ1ZEM3ZEMmxUcEFNT2NKSUpn?=
 =?utf-8?B?SSs1OGVFUDAwT0U5d2M2Y2UyL3RxZGZIMXdYWUFuNS9kMmI5Z3JIdHplUVUw?=
 =?utf-8?B?WnhVVkVsclRpVTZSRnhvVDBrTmZkZDdjRzZhNFYyamlrZU1UVGJ6SVB3MmRI?=
 =?utf-8?B?dFhmVTUxYmpWV3BNQkcycWVYcW85Y3l4bEpET2l5K043aWxVdXAwdml3UnRv?=
 =?utf-8?B?cTBsNHhBczVIOUJaYURRY3luY3psVFNxQ3QxeFplMnBuR1kyK0pwUEcrek5p?=
 =?utf-8?B?QXB4NWtFQkt4c1gyY1pKM29iNFprZDdZTUUyRXllMGpHVXhkajRPaThQZHFk?=
 =?utf-8?B?MTBWVDFyVVJQUzVoTTFDZElrMDdLZ2lzRGhVNlk1eXdpNjJtUnVuUG1rd1RO?=
 =?utf-8?B?SGxuOFVuUk8rTlB6S0ZXVks0ZTdxSGJPNVhsMCtxWmdXK3IwMW4wa0QxbWgz?=
 =?utf-8?B?K25xbEZWTXQwUHh2endMa3NNb084L29xYy8vTGMxVmMvNTZrNHo3U1FIRng5?=
 =?utf-8?B?Slk3UVJVY0RkVTBiRmRqdXZnQkx6bVQ3bjlIelB2V2Q4UGZENlY1amIvMU9m?=
 =?utf-8?B?RGdxckFQTWxHNzZZYWY0aGpuVVIyR2VxNWdKbFhvbVJpUFA1Y1lDRzl4Yi94?=
 =?utf-8?B?VVQ5azdyaisvQ28zU09rN1doMzR2ZUoyRzRrR1Z2UHhkWFZ3MDlKbG5KQjl0?=
 =?utf-8?B?ZU1iQkI2c3FUbnd1bG1wcFdLM0NXcENHVDFUZjlOaEU1NkcrK3ZCWFJuUzlT?=
 =?utf-8?B?OW9HWmtHTWpzbUNsbWhXbTJCY1g4b3BKTkZWaGlkdjlVY2hJZXFXbWFoME90?=
 =?utf-8?B?QzJSSjk3Mm9nc0NMYXJFblp1QWw1amlUQXR4NXBmZVVxalVDN09QVk5wQlpU?=
 =?utf-8?B?MHY5T3dscGdGWGJEa2RiRXgrZllSWGdhTGZ4NmxUYTd1c2Z5TGlKZDFtMlRu?=
 =?utf-8?B?WUFYRDgrT3lKUU1nY2hCMC9jd0ZqSGZ4Sjk3VlF2Vzl5dnBkSGI5cS9HOWdm?=
 =?utf-8?B?TmlxQUlBRmdQTDBUU0phUVI2T2VnNnFjV210ZTFDYmtkbFFabXlkeXo2Mi9I?=
 =?utf-8?B?YVR2SEsrR0QxVlRwTzk0WEZBcjBrRW9mOFFzRFRMV1Rxd1JkNE45Q2pkaENm?=
 =?utf-8?B?QXdOeExYSjUzVng0L29DN0QzYXcxamZzVzR5b2JzeHc3QkJPMElhVTFMcFZG?=
 =?utf-8?B?a3FOZmdJaGVlaUFvemNSM2ZTVkVCd3Y2OG5YT01TYVJsdHFYelpUM3Bha0NQ?=
 =?utf-8?B?YXRoODI5SHpneHZFeExZRllGTjVtM2xaYTVxTVBvWkRQMlVTS0RHZEE0ZStw?=
 =?utf-8?B?Wnp1VkYvYloySXBRL1VJV0tZcUpzcWZVOWRXRW9URktFQTVRZ2Irc2xJaWcv?=
 =?utf-8?B?VlpXNDdIUG9HcUU5VGllcmtmbm5pTktXQmFZM3dFZTlDWWRDTUQxZ1BNSkRG?=
 =?utf-8?B?YmZSZkJrOVR6cFQvL0RnNVlES0tZejgzS0JoNXNtT255WWgzQ3ppRnp1ek8y?=
 =?utf-8?B?WmxrbTA0ZUZSRmhpaVhCZHdwakorSFVsN3NnZWZmNDFGK1B4Z2V3WTNHbzNy?=
 =?utf-8?B?SjVQY3ljUFd0SXdZWkxDUkZUeVZERXJXQ2VGVzRXTlNpN0JXeFhMblJZVWgz?=
 =?utf-8?B?USt5K0s0SWZnMGs5a0pSQlh4Nk1EOHNybUZtYUp2QnpUanRpdUtKTVBKZnVM?=
 =?utf-8?B?TUp6dXlQZDNEMjZQOUdldFZZVlV5N2dJTklZbG8xK0h0ZHlvbTN4NVFoQ3cr?=
 =?utf-8?B?eEFYZllLQk5KRWM4MC9zYVBzYk9rdnpaUFljZzVqK2hJaWdreEZSTEVrQzJU?=
 =?utf-8?B?VDUyMG5PQkhBdWFjQXkraks0SUh2czVoa2RVS3ozQ0poZmtqZnNwU1R2a2tM?=
 =?utf-8?Q?q2KkunDjCLPuOOEGg6dq0zleD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57013323-7cab-4be2-80c7-08db1f11b633
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:41:53.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFFhvKRsDkbrPeHjK0SqQQlciseerfIjyvqJsAEkm7K9DNVhFCd+MBOPXr/LkzfLyuoZkiVqvgBmRHzO6n3N0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 17:03, Akira Yokosawa wrote:
> On Mon, 6 Mar 2023 09:34:29 -0600, Carlos Bilbao wrote:
>> On 3/6/23 09:30, Akira Yokosawa wrote:
>>> On 2023/03/07 0:20, Carlos Bilbao wrote:
>>>> Hello Akira,
>>>>
>>>> On 3/6/23 09:13, Akira Yokosawa wrote:
>>>>> Hi Carlos,
>>>>>
>>>>> Minor nits in the Subject and Sob area.
>>>>>
>>>>> On Mon, 6 Mar 2023 07:44:20 -0600, Carlos Bilbao wrote:
>>>>>> Subject: [PATCH] docs/sp_SP: Add process deprecated translation
>>>>>
>>>>> This summary looks ambiguous to me.
>>>>>
>>>>> Maybe
>>>>>
>>>>>       docs/sp_SP: Add translation of process/deprecated
>>>>
>>>> This summary follows the same format followed in the past. Some examples:
>>>>
>>>> docs/sp_SP: Add process coding-style translation
>>>> docs/sp_SP: Add process magic-number translation
>>>> docs/sp_SP: Add process programming-language translation
>>>> docs/sp_SP: Add process email-clients translation
>>>
>>> Let me explain why "Add process deprecated translation" looks
>>> ambiguous.
>>>
>>> "deprecated translation" can be interpreted as "some translation
>>> which is deprecated".
>>> Of course you don't need to agree.
>>
>> I see what you mean. I'm sending v2 patch renamed to avoid confusion.
>>
>>>
>>>>
>>>>>
>>>>> ??
>>>>>
>>>>>> Translate Documentation/process/deprecated.rst into Spanish.
>>>>>>
>>>>>> Co-developed-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>>>>> Signed-off-by: Sergio Gonzalez <sergio.collado@gmail.com>
>>>>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>>>>
>>>>> To me, Co-developed-by: from the author of the patch looks
>>>>> strange, because it is obvious the author did some development on
>>>>> the patch.
>>>>>
>>>>
>>>> No, we both worked on this patch so Co-developed-by: is the appropriate
>>>> tagging. That being said, Sergio translated more than I did, so I put
>>>> him as sole Translator in the document itself.
>>>
>>> Hmm, anyway I don't think you are following the rule of Co-developed-by:
>>> explained in submitting-patches.rst.
>>>
>>> Again, you don't need to agree... ;-)
>>
>> But, why doesn't it follow the rule?
>>
>> The rule is "A Co-Developed-by: states that the patch was also created by another developer along with the original author. This is useful at times when multiple people work on a single patch."
>>
>> IMHO this is the case here, but before I send v2 I'll wait to read you again in case we agree at that point.
> 
> If you put "From: Sergio" as the first line in the Changelog, like
> this submission [1], then the Sob chain would make sense.
> 
> [1]: https://lore.kernel.org/linux-doc/20230227222957.24501-2-rick.p.edgecombe@intel.com/
> 
> Didn't you forgot to put it there?

Sending v2 :)

> 
> Just guessing...
> 
>          Thanks, Akira
> 
>>
>>>
>>>           Thanks, Akira
>>>
>>>>
>>>>> Which is your intent:
>>>>>
>>>>>       Author: Carlos
>>>>>       Co-developer: Sergio
>>>>>
>>>>> , or
>>>>>
>>>>>       Author: Sergio
>>>>>       Co-developer: Carlos
>>>>>
>>>>> ???
>>>>>
>>>>>            Thanks, Akira
>>>>>
>>>>>> ---
>>>>>>     .../translations/sp_SP/process/deprecated.rst | 381 ++++++++++++++++++
>>>>>>     .../translations/sp_SP/process/index.rst      |   1 +
>>>>>>     2 files changed, 382 insertions(+)
>>>>>>     create mode 100644 Documentation/translations/sp_SP/process/deprecated.rst
>>>>> [...]
>>>>
>>>> Thanks,
>>>> Carlos
>>
>> Thanks,
>> Carlos

Thanks,
Carlos
