Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E5B6AC586
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCFPgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCFPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:35:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8568367CD;
        Mon,  6 Mar 2023 07:35:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkx6DB1NxzSoM8LUcIDDa5x1hiXf/6ULS+bxNPzFhFNBrkbiCXL/Ux9T69/2UzfH6EQi7LxLRnzCC3aSqkUiddTGgwO9fNvG4RHAfc6eZZ3wciF7meYdpDVQM5b+v+tdfSMixgkQ5zvGWbpzzQcEjGRskbyOMylWSBa+YPZY7Uo+Fp6EP/fK24V8zozEJ7IXuR4nLN4l98LSUUAENqQJe9jG9DdaNm/OKcacxU8GCWhpn5wNfgcA2/nLp3xlRHXs7EscQAWGg54LJ8E8VOnhFWWbxXKhAanUrOFO0eIVkPnASQ7tBCQshv+gcjbKKRi9EGsF85CrIynM4BXCnx0e3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERr3uOy02lJnlvJ9vW3Hay2bhZKtBdfBcys2YA57QYc=;
 b=mpzECBVyJ4yjtDNYTDhH67Osmk/PCy73C16ndDxVsLAhKsEUOPcifKb+Vvyh+esvwPcjiOykEHHCgqnRTLDTPYdAoPb72SVPKSTtnGlcaYLRD2SQoaJ1vlxUsa6X/PpkNgWpsxBuHCBFa6Q6sB003ukhEw9E8LtbqEtUCIkSAhjInZeg0XAx8EFtSgPbtGYmQiI33nHHO8j+yQ2SDNdXSM/PJgEEoX61qmkXC0hj0CWJIgVZeU7VO93uVCOVgxKFR6r2VcPg/kLt/xtmZ15SgP6evhs1+LBBsd8RrE8USSgqWgCffG1kARvupW4DZ/3NiurNevj+1DwvI2/tiTiluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERr3uOy02lJnlvJ9vW3Hay2bhZKtBdfBcys2YA57QYc=;
 b=qp3uNJmPDVd7BiE7EC57SbnQZZKApiVW5DobZLuGBkdnI6+G5TOqohEVuVO1OMs7vhD6WGtOR+BCOiILjph4xFaQUEpg6v6sSi63PHUPjd01ZXgBMOn1LAY8olsVUhwo+3lyoN4KTB1XoQ71G45mv9p/twZ5PfzYl39HYwKvr5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Mon, 6 Mar
 2023 15:34:31 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4%8]) with mapi id 15.20.6156.019; Mon, 6 Mar 2023
 15:34:31 +0000
Message-ID: <2b4f177b-3b8a-fef6-e7a5-692db347679e@amd.com>
Date:   Mon, 6 Mar 2023 09:34:29 -0600
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
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <6f1d8954-586b-efea-526b-ef461b5624df@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:610:e5::27) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 72294412-affa-422a-d155-08db1e5847c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ar5g6v73IWbXPzSpY6w4ezFVf2BBKfl3PnB7JdRSQNrI2ozRFmCyj/aGecHPQZ9SL8mkAUxFBaryGM+8gs4QUMtvsYRJNf3SrDCdm+KjRpdGO8df0o5PRVli9bpxkPY3UFEyEfhVmR016E2Ka5uB4QAjAiVTrtsNe7lDDYi8PoVLOUzc6Fg0D79M7Wzj4fuy7gUEdCg4pcuZi5kaC5f59wbEdWS8ts1hBllIeWjbmzhTfsgFqbj6cojHd5zbLtQcYRJR0pLIlp4bNqRNNQd19hayzmCaVdakpkIPr5tv059BFWMpXCnRDf4Ai+Sj9c5pabHuyQWOKMbw2f72u+Y4q9JROSVJ+lKPCUyBhmjy8JfDfbOP6pHJMTtNB7DYytT2lEw9bkJH5fOlwjnSFzf2IN6AzOK5jm/YZO/VBrOeuzQKaU8KTpS2JN88Yhdpq5IDgG1ZsCLRn+rr2oJpV8bfvd5550qSWLjNDLoEfBRrFI4RaRdYY3EnX7VafPQ038QrDamnrYhklTo8w5mpbLbMb2HlagqI3crs2tLKa8C6U7rSvaYSULAiTuWXUSQoWR2PuB3Q1zTYS1fz1D0jVDJqcA+1Yz2Z52frk2e3pq10R4EzX0UCaAdl7b93DmvCItRMyzxht+jy58XJNQZb5twlnKx5LPcXnMMVZkd8gowGpvet8DARNo5+80vDjmI9qWl9le6URE9hlPkTrKRru7hbgLrV74lyCrAACxZNRnVu1oY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199018)(6916009)(4326008)(8676002)(66476007)(66556008)(66946007)(26005)(186003)(36756003)(316002)(6486002)(6506007)(53546011)(478600001)(6512007)(2616005)(44832011)(38100700002)(2906002)(31686004)(86362001)(31696002)(41300700001)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V21wLzdmRDlNZW9OOFZaNlBWR1g3VkhrLzc3WTBSM0ZLbCtYcFpLS3lwbm12?=
 =?utf-8?B?THhKbkg2M3RwMUNWeUNWOU9xZUFHdlphbFBHY05vcHdmVnBEZnB4eHBXRzho?=
 =?utf-8?B?MHFiWjNmVThtUTZ4RFRIeGEySzdYc2p2bVpGSDFLRUJaVmo2VW80eTdWWEVw?=
 =?utf-8?B?b0lOM1FQTVY0N1BxdzVueWU3UFl6SVpRbDJwNXhwRzJCajQ3UXJGRlIrbW9j?=
 =?utf-8?B?M0xNT05MdnQwcmg4QzhRMjBQMXlUNmJRL2ZndURRNmdPajNqNTNKa3Q3V1Bh?=
 =?utf-8?B?NDBJb3ZKU1V0MXVaWWRJUGJqenJNaHVIQmNLRUxIZ0JmaTRsQmM0bTNJRStJ?=
 =?utf-8?B?MDFYMjJ3OGUwdHV5NzNMVi9ySExYTlVWanMxcjFCdjJwRlE2Yk5uaEtaQ0lE?=
 =?utf-8?B?MlRwL1g3U1JhSHY1YldlRVE4QkhQQ3dXL2Z6R1luMkRuQm5Sanl2OVRYRmZk?=
 =?utf-8?B?WHNwSmg1aXRrQjN2bjUrbURXNnZmUUgvS01hV3VEdmFLemFuVWk4MEJ1bUxS?=
 =?utf-8?B?U21IWmg4VmFHMU1mWDluMzViVTZzcFluL29abmFUazlDcW41YWxTYW9Ocmww?=
 =?utf-8?B?eXlrVmJuYzZOVVRwaFNFVjJ2cGExMEhWaVZlTWlTelBVZFBFZnBtc1cyU3hN?=
 =?utf-8?B?aWF5a1hZbXExd0MvUWIwNHViMVJGdnhrZmJpUjNYU1VqQU5wOERXUGlJSVNN?=
 =?utf-8?B?NGN0UTk1NEJ0eTBlKzNjWkRhcWFoNWJUTFJzWVlqVFZJUVpmN3FoSVNvaER2?=
 =?utf-8?B?cjZjQ2doWkFUeGd2MTNvVUdWY1dvVVRzVktHS3ExUVJ6bktPOVRDbTBJdWdQ?=
 =?utf-8?B?ZkZ1WWZFNW5MN2VndDNkUndRMlRFdWxhQ3JFT3lFUmUrY042M0s0STk1TWpo?=
 =?utf-8?B?S2E4NElJSFlCTEc0NkU0OXZjMDdsNE05d096ZTI2Vy9RTnhpbDVIckRzQmxJ?=
 =?utf-8?B?WEFFVWdFeVUxdnhWbTBianVBSHlYMVlWeVVMeU9wMmwvUnoxUUFDd2ZUUHRT?=
 =?utf-8?B?d2VYampBdGtiVFRhZWJVcjV2Y1NzZDZmVW5IZm5MWDNyTldXekgwVzZHaWx5?=
 =?utf-8?B?NmpVdEh3SElqbmFjYlIrSjNOQlpUeDg5cVVCL1hxT2ZmMTI5MktyTXRlM0RX?=
 =?utf-8?B?akFWaXFxQVJneEpyUGEySjNsQUtQQW1Xb1dFUEQ3d3hVb0paVGZNN25PTHVJ?=
 =?utf-8?B?YklEU05PRGVPOUVIRzF6OWRNTHpZcHZjMVBGQVpwdzlYekk5WXZmWGRad3Fr?=
 =?utf-8?B?bmQyZjNNVDAzcHNvOHgxRks5VmV3VFNXS1U3dzZaQUp3alZYRlF6NTFhenAr?=
 =?utf-8?B?YndvYjhXTXlhQzVGbkhEeVVldGE1REZyNkNBUmQvVzZsY1E4a0pGU1RyYmE3?=
 =?utf-8?B?VEpUc3pLOHpSK3hiUHpSVXF2ZENuNXRYYUlOZWNhcWIxQW11KzRDb0xod3lS?=
 =?utf-8?B?Ym50OTRQaW11QmEzUC9nTHhUNWVxUXhlR3BDY2hPSG0wSlcwc3VqK2J5dWNt?=
 =?utf-8?B?RGxqWkE2bjY2SkY0b0JValQvd0plS1ZwTllyZUs0anBTbUFvUWJPM244VTdN?=
 =?utf-8?B?SzRMbWN1dUNSZzJHMGhFcnNjRVlJcHlKenpIeUtOWTBSNEQxMUd0RXZrSFoz?=
 =?utf-8?B?d3drbTl5RXhlYTNmVWlZenozbXIvdGVTUm5KT3RsZzFzOTQrYjBoc2xTS0p6?=
 =?utf-8?B?L09hZnZML0Q0YUZmRklKSUpIS2QyV2ZnVWR5N2RiQzdOcExGSm55ODR0UjZz?=
 =?utf-8?B?TGE5VzcxaGczcnJJb1ZRUjJXc0dEZVR6T3M4azRYVVUwdnQ1WlFUc25ERktP?=
 =?utf-8?B?MmppTE5kSlYxQmgxMHpWdnZhd28zd29uS0ZtOVNzWWZydUMray95UnlBZDlM?=
 =?utf-8?B?cGVldXFhVHpPSExzalJPd0hYYjJRSVhlWmpvYkV5OFRrbkNHci9PTFRVaVA3?=
 =?utf-8?B?MVNSaUZkTDcraS9xQ0o5WE1ra1VOVFlxMGhIV3pCSk8yYnJxNUJtNWRTdTJn?=
 =?utf-8?B?dmdVcVdPV2Zsa1V4RXBRQWptTjhtOHBnQzQ5YTVXc1B0SEFCSUJ1Yjl0Si8y?=
 =?utf-8?B?RDVtenludFFraDkvTy9iK2NRbStzMWk0Y2JvUE9KMHpZNVJkZWFvN1A4RFNK?=
 =?utf-8?Q?CW11Vf0RknxHnMUKd5WGOq3KH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72294412-affa-422a-d155-08db1e5847c5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 15:34:31.4252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5gyvhEtN2WKztIoi/cMvp0gosON+beCOng20MagcPhVX7dT/CRWfWxoLOl1EQs2YiwoaD0pYuFAOelrDhU71A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 09:30, Akira Yokosawa wrote:
> On 2023/03/07 0:20, Carlos Bilbao wrote:
>> Hello Akira,
>>
>> On 3/6/23 09:13, Akira Yokosawa wrote:
>>> Hi Carlos,
>>>
>>> Minor nits in the Subject and Sob area.
>>>
>>> On Mon, 6 Mar 2023 07:44:20 -0600, Carlos Bilbao wrote:
>>>> Subject: [PATCH] docs/sp_SP: Add process deprecated translation
>>>
>>> This summary looks ambiguous to me.
>>>
>>> Maybe
>>>
>>>      docs/sp_SP: Add translation of process/deprecated
>>
>> This summary follows the same format followed in the past. Some examples:
>>
>> docs/sp_SP: Add process coding-style translation
>> docs/sp_SP: Add process magic-number translation
>> docs/sp_SP: Add process programming-language translation
>> docs/sp_SP: Add process email-clients translation
> 
> Let me explain why "Add process deprecated translation" looks
> ambiguous.
> 
> "deprecated translation" can be interpreted as "some translation
> which is deprecated".
> Of course you don't need to agree.

I see what you mean. I'm sending v2 patch renamed to avoid confusion.

> 
>>
>>>
>>> ??
>>>
>>>> Translate Documentation/process/deprecated.rst into Spanish.
>>>>
>>>> Co-developed-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>>> Signed-off-by: Sergio Gonzalez <sergio.collado@gmail.com>
>>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>>
>>> To me, Co-developed-by: from the author of the patch looks
>>> strange, because it is obvious the author did some development on
>>> the patch.
>>>
>>
>> No, we both worked on this patch so Co-developed-by: is the appropriate
>> tagging. That being said, Sergio translated more than I did, so I put
>> him as sole Translator in the document itself.
> 
> Hmm, anyway I don't think you are following the rule of Co-developed-by:
> explained in submitting-patches.rst.
> 
> Again, you don't need to agree... ;-)

But, why doesn't it follow the rule?

The rule is "A Co-Developed-by: states that the patch was also created by 
another developer along with the original author. This is useful at times 
when multiple people work on a single patch."

IMHO this is the case here, but before I send v2 I'll wait to read you 
again in case we agree at that point.

> 
>          Thanks, Akira
> 
>>
>>> Which is your intent:
>>>
>>>      Author: Carlos
>>>      Co-developer: Sergio
>>>
>>> , or
>>>
>>>      Author: Sergio
>>>      Co-developer: Carlos
>>>
>>> ???
>>>
>>>           Thanks, Akira
>>>
>>>> ---
>>>>    .../translations/sp_SP/process/deprecated.rst | 381 ++++++++++++++++++
>>>>    .../translations/sp_SP/process/index.rst      |   1 +
>>>>    2 files changed, 382 insertions(+)
>>>>    create mode 100644 Documentation/translations/sp_SP/process/deprecated.rst
>>> [...]
>>
>> Thanks,
>> Carlos

Thanks,
Carlos
