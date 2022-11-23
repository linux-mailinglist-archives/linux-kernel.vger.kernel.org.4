Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9FF6365C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbiKWQ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbiKWQ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:27:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B24E8FF9A;
        Wed, 23 Nov 2022 08:27:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs9Pn73z65uIMB+wqHhac+KYcokw9zMyNWXHDpxwHwEEpG3qso++nxda3W7MtN+kecbneqE52gtivVddSpwQpiO/KhlhBoDBNsg6gletR45ADmrvUV65arZVyL+4VJWOwO7RljYFT2MUu+5TnhWAThq4y0nCB5WI73UMid1Ixz+EStlKCTYNffm3ABquF3KN8ayPeWd2BGl8v11JZ6vYI08KHZhdwh3/CVYPvldEBHTAfVflLeziQJkJuIChAFr9vGrXk66ySqI4+Rye46Fnrh795pXzZCvDgul2zpdhi8qXAWe5tBR1l7wMnYpFyWVUbhEF85TfzRdsBXNl2ZFgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpfoY77firEh3CsDqBSweJIooRZJPNPUYQLB7Cdc84E=;
 b=Rsw5iRzW7uTJJMeAcvyhYXYfyVnF4eK1AnELLlksOeweT3Q2wCEIWuFpbv9L/iy0zW9CZKngOYBsjugYa67D2ZG7Q8FGN+Oc/FlSzHJ6M405QowlOVYFeICtpl3ROeur7S/JTq2FBBqvlJE+kbHkBE0WnfsqXKgikLuLcf5liOt2BjNNqtkBmoSsGflwwJO+YGZp0Rlx8mSccbZk3v7oecf7wCz09Stofmj3uN2ePmjIisOWhkGuFgkBmiHey5805vDwKe9hMEpEWUqia46jNbuIAAE7Tcu0I7TOIGvCVpAImU/c/n/idaFZbzw89FD4axT3ZuJyODSvwU93Xte2yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpfoY77firEh3CsDqBSweJIooRZJPNPUYQLB7Cdc84E=;
 b=Zc3gUawg/q3Km7FrULe6CdXyJVvJsAgIQlN/v/Fmc/EOO/y3nzez/zS5laBwpLUwCn4o3PZWHagpxcpHnldNrEnCM/mP3Y+CwZ3xH1QNW/VSHLbx1ldRJlqSTRJ+NgkvDCy8T8F4IyQeHhM7taTQUFwVQ0eZ8zYoiGwJZNQ+HKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 16:27:21 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%3]) with mapi id 15.20.5857.017; Wed, 23 Nov 2022
 16:27:21 +0000
Message-ID: <6fa7ad4d-1c92-121f-25c6-005fd5f1b6b9@amd.com>
Date:   Wed, 23 Nov 2022 10:27:19 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] docs/sp_SP: Add process coding-style translation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu
References: <20221115184737.712625-1-carlos.bilbao@amd.com>
 <87bkp09fkc.fsf@meer.lwn.net> <3ca31647-3f19-a9ca-c6b9-d6eba2014f2f@amd.com>
 <87edtt8wyl.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87edtt8wyl.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:806:122::35) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ab4017-6669-4a51-1364-08dacd6f98d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wHZhUxum/q/PJkSz680Um28JMIHa0eEmMeL815AkTTwdXX1dI3i/F8Ql57winAxnFj7scz7Y2ZdBS7qoRySBO6wQz96nQ2RPRCFLDIzdU3x47qpxC4dXZCJsCAf0UlBsc7GafDlZHAh7M/bPyvG66f3Cuv2aCbPwL7OtEWy5M+b72nI+pYVCozIkAaqrw/jE2/rBlgAeoRr7B2jdUk/Lzty/Ap5jz0PMDbJc1a9cVRMbzHm1cidkE8ss/Vbi+pPVJnVJ8s969BrhiP6MsWQzR1LjHEgofWkq5U5vcpDs3GTynTnvuabac1YJgbQo+0Pj9gdwVFvnm5Bgk6ToEP0d07XvwElULnk5dSDuDt0WsmMnUvQMWHEV6pYyayNraeHfyBQ9cM9/GoMBT0GSgOQdJwcayI+UD2RI5I1+Ub3iGvWOLsCJ16CJcz01IIzFOiLBURjdA7IG3YqRNrUnobaMmFXEvH6bXxz7mtqg8nTaN0jyV4c2GugX0A2MCHXAt/Btm+7oiqr1CYsC/qjb8OlHvj1HBzZcVh5AJGfTL2t6/QSKUX/rOK9GcdfUUVbi1Hjb/H6bt7I4+B69GEOyHRZ9Z61gp4GctP/VAwOVzYG01UF834eC+4FUKcCe0PCucs4MYIZWeamQlxfwfP4OjVNZoD05b5GDblXtjTyMBN/jO5wuLJx7AnTZUWCadPEQlell4FYtV2bUBejVFOs/yeYHqWWiiQQAsPOfT4G2fexNc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(38100700002)(31696002)(86362001)(53546011)(66556008)(478600001)(6506007)(66946007)(4326008)(8676002)(66476007)(41300700001)(316002)(6486002)(2616005)(83380400001)(2906002)(186003)(6512007)(44832011)(8936002)(5660300002)(6916009)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmowcHdLcUpyM3REU0hIQXk0SWs5ZTQyMDUyWnNERmN5NUFPNW9DQ0l1eG1t?=
 =?utf-8?B?V1F6SWdlcFhZZ3h3NzhQcXZtOTNRQjU5ME1sQVJTRVRIZmxVR1EyWmpBWGhl?=
 =?utf-8?B?MDlSTUZEbWtSdFd3enZQYnYzNjk5dmRPQ3FHalo4aXJaZ2ZvNWNPQUFHRzF1?=
 =?utf-8?B?QnBmODhVUmJXNUNJVkU5Y2YreWlOOWxwNWVCTTQ4VzRsTU9IcEhVeFdMWU1P?=
 =?utf-8?B?M2U3U0RLcXBUSHFvbkZ5eWl0QmhoUGdyTTBIVGZ3MzdtV2ZKMEpmakIrVnpD?=
 =?utf-8?B?a0FqVHNPNENwa0FEMXNNN00zNldNek1teGViZ2o4UGpiYm5kbHM1bnVvUnIx?=
 =?utf-8?B?ZEJCVlU0eEl2L1FtdzdCcFV2Y2lMNFJKTXJxRDFNbnpnQjBySFVJcDJPcTU0?=
 =?utf-8?B?RGRXOUJ4VXpQNDNyaVprWW5ob2toWE1YdEdEZlNRQ2FVai84T3RUL3ZjajIw?=
 =?utf-8?B?cmJuV2FqelFiOHVsV2g2VGZ0MEVKVXJHYmJRak1ZVVYzVUxDVTlpTTRqdmJV?=
 =?utf-8?B?TngvbnZoVGwxWTR5OGN4SlRZQUlidVhMME5pV2FxL21ENkZESmZENkdSNXZT?=
 =?utf-8?B?M3BZN1hvVkY4VWhBc0VHejdqZkJpYzdpUTc2QnFzR3A1OGFlbEx5aitNY3BZ?=
 =?utf-8?B?V0wwSXhHVmtMdFMzaEhFUE5WNXZtbzAwRzFPMTAvUzJOYlNpZG1Na3JXQitR?=
 =?utf-8?B?THNONUNrVVhqb2hzYUp0WmNsQjdFSVd1UmorNHorbDFMTzBDdFh1NEtUNk4z?=
 =?utf-8?B?K1UvbXNjcVVQaVJYbkhWeTJONk5QbUZiWTdHOHJNNm1TOXcxOEkzbnpveTNV?=
 =?utf-8?B?dmpPMVZhZld0QnNDVGJFRm9Da0t2eVNtNGE4V0hLS3ZoRFUyVGdwVHNEcnk2?=
 =?utf-8?B?VGVDK0d3SUdTR28wZVpnWE9TcWdncVRLSzBWNzRsNmNSRnlub0JnYVVYWENt?=
 =?utf-8?B?amVqV3ZCNGRWc2ZIQnlYSklEYWJIcWVldzZzeDJ4R2c0Um5NNzQ0bTAzTUpK?=
 =?utf-8?B?Mm9ZWDFUeWtEcS9YczZ5WXJ2Wkx6b29adUxpR1IwY1h2NE1wenVJNEI5Rzlt?=
 =?utf-8?B?SGpOakhBTExIeUlqYmgzUjY5NFhpVHYvVnhObTFnQW9IWFRMRHNkL1BoNHNQ?=
 =?utf-8?B?a1VObnd4MWZCUU8zVXZzY3ZYNnhBV1VmaE51cjU3RkNYMDZua3g4OE9EcG5P?=
 =?utf-8?B?MDZEdFdpcVR3ekIzcVRCKzAzZGpZY3hONjhBL2EwRmg3QkcvdUVONGF4RGNU?=
 =?utf-8?B?YzF3czZNdWQ1QnR6UXZVb0NjRGtSYnNPV0NZak04MGRvb2s4NVhDVzhtelNT?=
 =?utf-8?B?S2wwd0JpLzd6SkdtTEN4bWJpK1dYZ1Zjc1RteWhkSE40YUhlVDBOcnp5UUMw?=
 =?utf-8?B?Rm5sVldVSFJSZS9zZDJIVDRvYTFIYzlraEIwdXJsdS8rOXd6cFRUTWdyZnl4?=
 =?utf-8?B?eFVwV3lnckQ2MmRtNHRRL3RnVExMMFBiL0tvQXdlVEs4SU43YWVLaFpNbTZR?=
 =?utf-8?B?Nm5iZnNkb0hKRUtRU1gydHlCY05sUW1YU1JMVGkrc3FYdVZLa1lBNWNFL2Ny?=
 =?utf-8?B?R2U0cnd4SmhkalNxUGJZSno1eEYzM3p3ZWpsYm00UjhMVHE2eGhqZkdtUkhG?=
 =?utf-8?B?TStXbzAyY0QxRDRqZUxhb3RVMjBzL0JPQjhJNjVlUnhLc2grTk8zRVBFaEx2?=
 =?utf-8?B?Y0xXYU9neGR6ZklLbEcramRNcE02RWY3ZE1Gc2s3bVV1Z3pteXo4WTRJR2dF?=
 =?utf-8?B?R3lqUGRNWE9CaGgzNjhJWkpiTGF2eUZuZ21iUmpkOW9ZQWs5ZGVLUEJoN3ht?=
 =?utf-8?B?M1RGeWM1SVdNdS8vbFpCOUQzN1ZaSHBSSXRJSExYNzBkN1RKNm1CTndrUEZP?=
 =?utf-8?B?TTJ5aWVkREFmMUZlcUcyTXpzNUxWS2pkeVZZVmwwWFFVKzZjOUpoczFVQjVV?=
 =?utf-8?B?d3VqUnhRNExHZkd1cklxOFNnUEE5Z2hocGMwQjJ3WUtRa0IweWRUTGYrOGN5?=
 =?utf-8?B?cUlyTTFpTllFVUtNTU9TSndhWmJHRTIxNXhJZEtISzFibW85RmlxWkIxdXR6?=
 =?utf-8?B?aW1jVDlwTG5qMStCQzlubE0xRVFDNUNjMjZtMC9Vakc3Smtjem9NeXlNVytM?=
 =?utf-8?B?TTdqZDYxYWZHd05ZTE9id2haZ1d5cjZmRXJhR1owY1lTbHY4SERyeGNmb3Zz?=
 =?utf-8?Q?hAdZEkW+Y3oopAlq/SYozpYvmV8TcChz0Op6U/aXRg7N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ab4017-6669-4a51-1364-08dacd6f98d5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 16:27:21.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Je03f1rrYUA1TXba0pHASU2sQqACS8QzYsEZ+otqzQTaOl1qn3+z/K5uyCrelsUSVRWQVgQ0sFIO5nrZzSRMig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 10:19 AM, Jonathan Corbet wrote:
> Carlos Bilbao <carlos.bilbao@amd.com> writes:
> 
>> On 11/21/22 3:13 PM, Jonathan Corbet wrote:
>>> Carlos Bilbao <carlos.bilbao@amd.com> writes:
>>>
>>>> Translate Documentation/process/coding-style.rst into Spanish.
>>>>
>>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>>> ---
>>>>  .../translations/sp_SP/coding-style.rst       | 1315 +++++++++++++++++
>>>>  Documentation/translations/sp_SP/index.rst    |    1 +
>>>>  2 files changed, 1316 insertions(+)
>>>>  create mode 100644 Documentation/translations/sp_SP/coding-style.rst
>>>
>>> So I'm kind of slow, I'll admit...but I have finally noticed that you're
>>> not preserving the directory structure used for Documentation/ as a
>>> whole.  Is there a reason for that?  We've been (slowly) working to
>>> organize our docs in a reader-friendly way, it seems unfortunate to lose
>>> that for the translations...?
>>
>> Yes, you're correct. The order I was following was: "If I didn't speak
>> English, what document would _I_ like to see translated next?". The coding
>> style directives seemed to me like the most important thing next in line. 
>> Following this logic, I was planning on translating
>> process/email-clients.rst next.
>>
>> What would be better? Perhaps the documents of process/ in order of
>> appearance? I don't know what would be preferable in terms of organization.
>> Perhaps we have some data on most consulted docs for the Documentation
>> website?
> 
> I think I didn't express myself clearly...I don't really care about the
> order in which you do the translations, whatever you think is best is
> fine there.  What I was asking about is the *directory structure* of the
> results.  Thus, for example, I think that this translation should end up
> in .../sp_SP/process/coding-style.rst.
> 
> See what I'm getting at?  The directory structure of the translations
> should really match that of the documents they are coming from.  Or, at
> least, so it seems to me.

Ah, that makes sense. I will send amended patches.

> 
> Thanks,
> 
> jon

Thanks,
Carlos
