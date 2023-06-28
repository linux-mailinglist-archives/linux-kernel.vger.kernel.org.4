Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF42B74146E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjF1PBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:01:47 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:22273
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231464AbjF1PBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:01:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDnVN2ETwyhuOVgUl93Xt1j1i6WSsO67TQxYJaq9zx8OBEI7pWdhIv4iGdP7k4s5rkXyxGI/gRVTsjGY/P874QKFErg5BHPJ9qNde/si4/ObDxY2vhcFokWyIMcMXtuDEqlDVoajDXJH9OP0QwlcXiCnXgDkjXdMrlwuGOZ/pgg6WHplwIyrqit3C/Ytib2ShI/FjapBXN7p/Mo5ovxzk8MCx63ereZ7hnBMWamsNzbgJZT5IuOhfby4KsU+JLtNulE+c1I0XIakkSCdGMtQW7CWWPfEDJiAqVAlqpaEPNh9hPlWJmug8K5vLGRe1gT1rMShjMxrGNy0JxM9hGJX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+CT9dfiQEZuadCsj2RJU81X8mEfvU5rznF4BA4sXds=;
 b=aYqmhTMhttoXhE/tUWl691NbwhjhC2t5qQRHjdkEdecOVK68q0RT4rbHG3M8ZJD3HA5sfM5RGCsI/0N+SKLmvHGpb6jQfbTLZjeMBPDZIqj4HyS3b3UjgndiVgiaR2isQW2xjzitN4zRrnR64UvQjW9HjvFl3/BwmjtBdwcVYwPe2Td7ZNQAyJKXNVbpWuWIopubmZGL2CjYseLg9QoayHBcpMvyDohPUUgmhqZAdb++q5PVbjLyX5wWSd3JM1HDKR+/Zai9OKGlM6J9cAUX0zaNv/lkSMi1FbM/7AmY9VxiW5vhdRmDnv/fNicR29AHLMNVQabSPEh82xnS3G2xUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 CH0PR01MB7020.prod.exchangelabs.com (2603:10b6:610:109::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Wed, 28 Jun 2023 15:01:28 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 15:01:28 +0000
Message-ID: <e3b7a5e6-c0b4-244a-a3ce-073db28f0978@talpey.com>
Date:   Wed, 28 Jun 2023 11:01:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Jfs-discussion] [PATCH 0/3] dedupe smb unicode files
Content-Language: en-US
To:     "Dr. David Alan Gilbert" <linux@treblig.org>,
        Dave Kleikamp <dave.kleikamp@oracle.com>, krisman@collabora.com
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linkinjeon@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230628011439.159678-1-linux@treblig.org>
 <9343462e-6a4a-ca7b-03b8-4855e5a33b72@talpey.com>
 <ZJw4iLlFWRMq6a3S@gallifrey> <ZJw50e0pvn/IN5Gj@gallifrey>
 <90f35697-5941-d42d-b600-245454cbd040@oracle.com>
 <ZJxGFBzuhU8t5rcx@gallifrey>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <ZJxGFBzuhU8t5rcx@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR05CA0020.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::25) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|CH0PR01MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca1295d-3d28-45f9-3b26-08db77e88caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiJCIss2fwB3tz+V+MKQ2d9/ywW1C4szAXTmrFy+Gr5kBxptMx4TshhvkF9OstzQW7HXFB2t28XB2hAbW91M+rIiHS+GaLlVqHX1TOacuubnHkVVAOERL89ZIdIDtQcShRJu/RxnuU8LD8KvmXZKEnUlMjT/NdRuhsk9ZrFr6PHpRlVl0JmMM1pIDuBn06wcFJwdOIdClHNxJUo5CMsaAhJ+w7R19aCxDhFvlJiP7VzscW4BTUj9j5QX0wCTkydSVA/FQvUx3Lp4NdTt6zIWYQwwEJR38cDgtWmhg3zFg0OcwE8qrcZuabEOXdXPFBOkzuqGdtmWYTv97A15/C8mmVSaJnzTAMlX9SyR9HUL4nYGfJ5kaHH939ECXKuI5dgRZhokzh5prBLOXlBPpITmVY7T07YoN7Tog0VbSv/Ys1jLwPh1iHlP8zjMP4hQ5odkNiYZkrVDJ9LQBG7V5gZ9O4zviEWlPyikkYFtWAREvZTe7n+KOuvHvdEFoT40NFufXSG0Wa8idm5/E6eg4NJ5hCdIrVu0pcONyX1Hz3wrDCOkokP6CWe3FLMsha3RTvjRqpqfA19utdXzRCtyUFJIFJYBD/C2Jk9O01rQBECo1JKwNbI5ibDAf76ONkuhul2Jtn+AaiW9g5MyIUCszvjUSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39840400004)(396003)(376002)(451199021)(31686004)(186003)(2906002)(5660300002)(66476007)(26005)(6666004)(36756003)(52116002)(316002)(31696002)(6486002)(966005)(8676002)(86362001)(110136005)(4326008)(478600001)(38350700002)(2616005)(38100700002)(66946007)(41300700001)(8936002)(66556008)(83380400001)(6512007)(6506007)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUxKbjA0aVhwdHlhdzdqa3BlYUh3U3pCZkNLV2JNWDdMUEFQRjFVSmoxUEY5?=
 =?utf-8?B?ZlllSUlLM012aUpDd3IyVFdsTUhPTTNwRUpkb1UxQzlUWnFCYTlickxLN3dm?=
 =?utf-8?B?RHlRdWlqd2VpcmJhWUFQc0NkNUthOUM3MHl6VytxYWs3NzNwQnV2Zmtsd3oz?=
 =?utf-8?B?N2pPN0IwMjNRM1lVeUZpTW9icStrUmNWSEhyZ25iTXJzbzdubUZ3YkZVcjFV?=
 =?utf-8?B?aTN4Z1J5WUd3dUpSUWI4UklPYXpIc1czTnlWOTBsNDhEY0M2Wm41QWIyOXNa?=
 =?utf-8?B?bHdNb2F0UlFFK1JWNTV4bkE4YXRxY2NmQXM0bWhXaTlWUXkwUVJFK056ZEVS?=
 =?utf-8?B?Tit1Qm9VZHFvcFFhZTAxS3dKRnF6YW1MZUdtOTM4NWQ5VlhCTFlrQ2t4dXNj?=
 =?utf-8?B?VGlkZXdiUEpVZ09DSnpJMjNaaU5qSWpzY0RQUnZ2TGd2dXkzQTlnNmtiOE5V?=
 =?utf-8?B?Rmt6S2lxZmdYdFZrYkR5d2l2MUNSVmg1bEVXVTAzV2JEV0xnWlE3cUlOdjA5?=
 =?utf-8?B?ckc4eFc2dENvQUNEcVJpSTJRbGJqRGJtYmN3SFU4dmZYZG1JWjdXN3c1czI1?=
 =?utf-8?B?ckJhb1V0OWV4dUNXNnBWenFkZnRqdkJGUEdYMHlHUjRtZEphT3BJSkJQMFNa?=
 =?utf-8?B?elBRV1BWRzl0RXZrVWdWTHZmQThQODNBQnpKODFHTHpSM3FzQU85M2VrdE5L?=
 =?utf-8?B?M1duL091NnRkdzBqNFh2My9xMElLdUxUdjNUTFloTGQxVUErRmNUNTZlZ1pn?=
 =?utf-8?B?bkp1bDQ2anlOdnFubWlyUWZ5b05uUjFmV2gzSHR5bXpoZzRWN3ZtaE42bkI4?=
 =?utf-8?B?Z3U4aVFjaDJGVTBUVVpvK1NGUXJqZ2wyT003aDZiZGk2U0VNbDU0RktrYlBC?=
 =?utf-8?B?UG56YTBwV0s1SEtPYkxreENaWVJ4M1VhYTJyUFhVSUx6S0RtS1o3aW9CZkYw?=
 =?utf-8?B?KzJjRitRZDdVQzNwZlhHcFJPSnh2N0NqL2dna2ZuWWQ1dW5mNkNtTnNtUXhx?=
 =?utf-8?B?OGllR1ExVXc1WFlqbWYrVWRrSWZBZHNoWmFJbU5CeS94RGQveEpwRXQ3NnJO?=
 =?utf-8?B?dENMMGcwWDhvRDRLYVlETCswUnlNN0RUcG9mTmNhRWVKNlpscGFwbndwaDZs?=
 =?utf-8?B?NmpjSVEvRWdJODhCZDc4anNrL2hjRndRSXBEM3A4UWdrOE9EMjN5TUZIYXZO?=
 =?utf-8?B?MVBidnp5TTZhanZQa2RXWXNNYmxQRS9MemptL3lqazRVc2RNWDBzc0pEQ0dz?=
 =?utf-8?B?czRBa1czTWFGQjJNUlpYMnh0K1JCb2l1M0xFeWZvdjlIdG1aQ0pOUnJoS0F0?=
 =?utf-8?B?ZXVGamNBM216WXlpL3paQ2hQK1JocngzbCs3bjM0bHFEdEhwVTAxSUlWb0p5?=
 =?utf-8?B?R3ppaUhoUEdjNSs0bmpvQzI2ejN4VmhIemtuSFVrTWxOT3BVTFNReFhTQU5M?=
 =?utf-8?B?Ky81YnZlMEp2dTBqN2hVTlB1MlNTZ0hxdzUwZjJrUjNwaDk2aThXUGZMRlQv?=
 =?utf-8?B?UnVJd25VM08zWm9yMU5XaGFxbGdDaFFnazN1Rkg3NkQ1TXNTalExOHcwb0Vt?=
 =?utf-8?B?OUVmdTlsUkJBSVpyTjZ4dkw5Ym5laHR0U2dtUGZpNWNHN3BiZG05cjV3dW1m?=
 =?utf-8?B?Y3Z4UFRRRmVvTmNodEJpTVFsSnhGNXUwVGpaT2xlNkRWTzkyeWN4MDRaQ2RS?=
 =?utf-8?B?UG5VLzlkaDgySk1SOWc4UmlXRnhaRFR3bTRENnBzTjk0TnJ1TVF2TExlU2hG?=
 =?utf-8?B?SUtDdW5hbm1QbVFpc0JnOTk0ZzVPSEJrQVZIYnhLWXpkVklWTFI4bzVmRzFs?=
 =?utf-8?B?b2JKODFDY2JpdlFrRkpKRElXZjRXR1dJMUVqRERnZjU1cjVlYTBMTlJEbktJ?=
 =?utf-8?B?QmRlTzhYNm9wK0lYTmxZZlR4b2E4Qmg2UmpCSk52Zlg1RUVWOW83Qk4zckF0?=
 =?utf-8?B?WWZJOWxyZlFVL1kzdUxCWm9neEl6ekVKT3NqWFlCcGRJMDk5cVVoU2ppdHF6?=
 =?utf-8?B?b3RPbW1qY2ZObWxzYnZmZUlkQlA5YXdGbkhRSE0zQWdRd2REaDk5RnluNnla?=
 =?utf-8?B?WWh1RjFCME9XM0lmMnU1OVJDRnRNcVo2eTdOYkw5cVVycmhrNWNWUUNBVE5y?=
 =?utf-8?Q?FuAVQWLn90bbAqOkZQ9nhgfus?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca1295d-3d28-45f9-3b26-08db77e88caa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:01:28.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsZm5EaWlvd/bnphmj4TTnWC8K7swgOpwkZthcXWj4rEI7IZZNOyGN2arqppMOhq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/2023 10:39 AM, Dr. David Alan Gilbert wrote:
> * Dave Kleikamp (dave.kleikamp@oracle.com) wrote:
>> On 6/28/23 8:46AM, Dr. David Alan Gilbert wrote:
>>> * Dr. David Alan Gilbert (dave@treblig.org) wrote:
>>>> * Tom Talpey (tom@talpey.com) wrote:
>>>>> On 6/27/2023 9:14 PM, linux@treblig.org wrote:
>>>>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>>>>
>>>>>> The smb client and server code have (mostly) duplicated code
>>>>>> for unicode manipulation, in particular upper case handling.
>>>>>>
>>>>>> Flatten this lot into shared code.
>>>>>>
>>>>>> There's some code that's slightly different between the two, and
>>>>>> I've not attempted to share that - this should be strictly a no
>>>>>> behaviour change set.
>>>>>>
>>>>>> I'd love to also boil out the same code from fs/jfs/ - but that's
>>>>>> a thought for another time (and harder since there's no good test
>>>>>> for it).
>>>>>>
>>>>>> Lightly tested with a module and a monolithic build, and just mounting
>>>>>> itself.
>>>>>>
>>>>>> This dupe was found using PMD:
>>>>>>      https://pmd.github.io/pmd/pmd_userdocs_cpd.html
>>>>>>
>>>>>> Dave
>>>>>>
>>>>>> Dr. David Alan Gilbert (3):
>>>>>>      fs/smb: Remove unicode 'lower' tables
>>>>>>      fs/smb: Swing unicode common code from server->common
>>>>>>      fs/smb/client: Use common code in client
>>>>>>
>>>>>>     fs/smb/client/cifs_unicode.c                  |   1 -
>>>>>>     fs/smb/client/cifs_unicode.h                  | 313 +-----------------
>>>>>>     fs/smb/client/cifs_uniupr.h                   | 239 -------------
>>>>>>     fs/smb/common/Makefile                        |   1 +
>>>>>>     .../uniupr.h => common/cifs_unicode_common.c} | 156 +--------
>>>>>>     fs/smb/common/cifs_unicode_common.h           | 279 ++++++++++++++++
>>>>>
>>>>> So far so good, but please drop the "cifs_" prefix from this new file's
>>>>> name, since its contents apply to later smb dialects as well.
>>>>
>>>> Sure.
>>>
>>> Actually, would you be ok with smb_unicode_common ?  The reason is that
>>> you end up with a module named unicode_common  that sounds too generic.
>>
>> I'd suggest make it generic and move it to fs/nls/. I'd run it by the nls
>> maintainers, but I don't think there are any.
> 
> Steve & Tom - would you be OK with that?

It's fine with me but there are "CifsUni<foo>" and "SmbUni<foo>" entry
points which will look odd in fs/nls. I'd be fine with removing those
dialect-specific Cifs/Smb prefixes, but there might be some collisions
to work out.

Tom.

> (Copying in Gabriel Bertazi, owner of fs/unicode; although this isn't
> utf-8)
> 
> Dave
> 
>> Shaggy
>>
>>>
>>> Dave
>>>
>>>> Dave
>>>>
>>>>> Tom.
>>>>>
>>>>>>     fs/smb/server/unicode.c                       |   1 -
>>>>>>     fs/smb/server/unicode.h                       | 301 +----------------
>>>>>>     8 files changed, 298 insertions(+), 993 deletions(-)
>>>>>>     delete mode 100644 fs/smb/client/cifs_uniupr.h
>>>>>>     rename fs/smb/{server/uniupr.h => common/cifs_unicode_common.c} (50%)
>>>>>>     create mode 100644 fs/smb/common/cifs_unicode_common.h
>>>>>>
>>>> -- 
>>>>    -----Open up your eyes, open up your mind, open up your code -------
>>>> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
>>>> \        dave @ treblig.org |                               | In Hex /
>>>>    \ _________________________|_____ http://www.treblig.org   |_______/
