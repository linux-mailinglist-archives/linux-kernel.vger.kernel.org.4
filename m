Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E98C741378
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjF1OL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:11:29 -0400
Received: from mail-dm6nam10on2070.outbound.protection.outlook.com ([40.107.93.70]:22497
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231394AbjF1OLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:11:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyr/FRh5XWoIcuHZJo3LdBLYagQ/FV5cX353kLuUYi6+MR5oavS/3q5YcbFxdCX0W+lBMWHkN/PysvH4Z6dOsDgt4Yjaws4XeAr7naGLNXR5w+8ko8YCpqDMDHZ4VcOaw/Mb7BPw6jgnl2D8cSd4LBrZz7vC9ZMAJvmF+kEzwpc9sJT6B3BZ+R7k8WQ1JTZpVyYL621a2mDqhWrkGzunCWtyXohuyfoi1jXW7Z/IrSrJR04LBvlJO9swnooq7Vz0N+CCMPvZPseDL+nQ9hP4gfa27AH4iU0M52TSkt97nhG58Mf2Xj5At5jmBwfPtP+Eb9bc7GYybvZlzYS1FNK+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+d6IuJSYns6ZYzAt9tCX+JQmfbcTC0p/2Iau9xFdl8=;
 b=WMP11unfgSrVuYXSw9QU8JWMBOYDalbsch1BRbQlzpF2qOs1UJFDmGCxqrT85HETe/CUyQnJUckF6uGD9pvEJzPG5Kk3bn9thAZ+sY/fIATZjZsTwnL6TvLSR3MTk6aedOcrHGVUcSHFXAvUDXZKodmym9Vp2WXOirpe5aOdA16EqYW+u5FLem1dpEZg/kb2UQYunTTolcaSza1O42C9IkUk6osxzG1bi1ABj/E/GSjsTRDiCRfC5vrxbxX+4KZ88/WJQzkYDZNqKDT/wvo5uSnNcWOaTtY+pyZnfqYdhjNjf0nWQSuTA3norU/W8Thi1Y0pC+Q9oP4qEKfmwVXIlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 PH0PR01MB8094.prod.exchangelabs.com (2603:10b6:510:298::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Wed, 28 Jun 2023 14:11:23 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 14:11:23 +0000
Message-ID: <92ae722f-c09b-120f-bc30-7452e87f5374@talpey.com>
Date:   Wed, 28 Jun 2023 10:11:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Jfs-discussion] [PATCH 0/3] dedupe smb unicode files
Content-Language: en-US
To:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linkinjeon@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230628011439.159678-1-linux@treblig.org>
 <9343462e-6a4a-ca7b-03b8-4855e5a33b72@talpey.com>
 <ZJw4iLlFWRMq6a3S@gallifrey> <ZJw50e0pvn/IN5Gj@gallifrey>
 <90f35697-5941-d42d-b600-245454cbd040@oracle.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <90f35697-5941-d42d-b600-245454cbd040@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0007.namprd19.prod.outlook.com
 (2603:10b6:208:178::20) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|PH0PR01MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1b8c8e-e4b2-40b6-4b28-08db77e18da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWl9NtrYRXFSRCmEG5zYgI3qOGewUxY/8j3KpMvd+sMapkO3P8+ZLeHSJtLsjqB2S5YGturr0FGGdKY9A0H7qDu/Ng+tY1INtDAMY1f0bNzUTJyUtd+5eNc3fmFc0zGMNb/8T+e2GtnaOd0KztaAGLRQlUfqYeKK5DJYGmZjw92zBnukyF5iIzxaE9P6OgTos9a56DThUH9VjqiacEHOYZr27LgdRhydh5aNT7psLvYZEEbKy+RZkcZqXheGK55ThXw+M0sQLyDCYzG8xlt2jY7E8N605xRfmu8ej28X78pOLjTCMrwwswEfDH3NWDIpS0SwwWKKIaGSZ+kCeqY8OkoVcUvDWsALOglqnS5691FDoaTp3PGUlzHsQ5Wx5geP2xeP2+1LMNpyoEFUdgcujbHzkkCyEvth2DkWH3tzg8ikgvvPPKtET397gE2ZrAZ5SXjQf74Fi4Z0HCgCD2gX0kjy5zngn6cR5oq63rkkpPKdXd+BaHdA2jCFvPBnnSlYvvhoKL0eF2GOu8SwIGpihe03HcGcsTbLGtNxXSutMjpCfmUS51ZuGc/GiuqNkCAXLJ//ZuKEJUUfAX1NhkWL6W7zJxfKPQrRaMFWI8V7YHRsY3I+a8Rw+KOoO5KzBCkj9TQMrsGwGzlYJQ1NsWXaHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(346002)(376002)(396003)(366004)(136003)(451199021)(31686004)(966005)(110136005)(478600001)(6486002)(52116002)(83380400001)(2616005)(86362001)(31696002)(66476007)(66556008)(6506007)(53546011)(26005)(186003)(2906002)(6512007)(66946007)(4326008)(36756003)(8936002)(41300700001)(38100700002)(38350700002)(316002)(8676002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWMrcHQxb3M2cEUrekVOMmZkd01Pa0lsc1VUSytqL3NEZmpCbXBieWR3cXdp?=
 =?utf-8?B?elpaUDBNc0xYWTI3S04wcUltaHpSNS9SZTV5bG81eGt1L3dQWnJNSXF4WGpr?=
 =?utf-8?B?bWFDaWxxVlB0N3JxTjBQVExkdHVWOTNYcUk1RjZEM05PMS9YZ0dObmVla3Zm?=
 =?utf-8?B?NEpnMXJ0MCtLYUI5MlphalhVKzk0N3d6aVVJT204RmU5UVdqQzhpVGwwbUxV?=
 =?utf-8?B?akRDbTVzczl5TVQzblY2U21tY004TENmMzN4Y3k4NW9Idy9OMU9aakkvYVhC?=
 =?utf-8?B?dTZFUkMvQXh2eUVIZnBLR2VidUgwWDF6T0M4T1VHUTVPdDJCeHpSSEtya0l0?=
 =?utf-8?B?SnJmZkx4dHRHM1VKdzhkWHhOVThucFJhdHNLN2RqQnZNeU1QNDZmcTJJUkdE?=
 =?utf-8?B?NVNtVldIV3o2RzFEZkxPQithMGRzR01ReGZBcm11dndJSWZ5Z2hzSEhVMzBa?=
 =?utf-8?B?VFZvYi9oQkU1Tmc3NjhJeHNhdmNBenczRGdxZlFKK2s0SnMzeFpzUnV4UlI0?=
 =?utf-8?B?Umpsbmc5NzRzR3FQSk5UNE50RUh6V3JFdldtUk03SzZBN210aW5CTXU1Rm1i?=
 =?utf-8?B?bDYrNXk2QTB4RUxpMVl6VU0xZGVLS2hRLzFUaWpES01SQ2FsWTBaL2JQUGVU?=
 =?utf-8?B?eG1EaXNWVW94YndSV1hGNVlqdUg4VDRObmVycjJXVDM4VXpIc080TGYxZ1Jo?=
 =?utf-8?B?bm5DUFJGYnR4VEFCRUczSWcvRzBqYVZkQWxMUEgzcTFGc1RZMGhjbll5dzRL?=
 =?utf-8?B?TlBsbElTdG9aU3RuTFhvMzRMc0g5Tk9YMTFyQThyU0hvbGg3TzBFeHk4ZGdH?=
 =?utf-8?B?cU14ZHhCd3k5Y2VlNHhyem1TS1RhNXdlcnZYWDlHamkyRnB6T3VpUm91YkZQ?=
 =?utf-8?B?T25jRjM3MnpHcURuL1RsZzAxZjViRnBPN0s0ai9BNmJGbGFSRzhDaG8xYW9F?=
 =?utf-8?B?WWlGOURodkt5MFFhWFhDZmZQNndZSXNlSmZrNW1GcGRGcDYveFJzMzNTNzNk?=
 =?utf-8?B?M0ZRaEdWb3BDRlZwOWV3NnNaVVlRNWFPSWpIK0xocHBRaFZ0Vkp2Z1U4em4r?=
 =?utf-8?B?K3dRRnNUN21YS2hhTWRSZUdJWGlsZm9hdmlhRGdxYzlBNEdaMVpQeTh5TnM4?=
 =?utf-8?B?djBoMVBEcEhCdjFlbTBBUTc2TEpScllIYnZMZTJDeWNYTFBtMjVpSndNNkVR?=
 =?utf-8?B?VjRMZ0ZUSlJ5c2FkZE44eDRhbERDYkJVQTdJZm5ZNlpKWllFN2wvemJONWhj?=
 =?utf-8?B?OFFmQmFBY3BHenZ3dkFCWURaaUhOS3JLdHczSXRkMWVXdGx2RFdqOVIrQ2FL?=
 =?utf-8?B?dEw5ZzBtdnBoREd4dStCNU5JZWVRU1dRUmpuK3JlRWhrNmpqdDE0TXRNVWha?=
 =?utf-8?B?Y1VJc0JEbkRMZ2hZOXNybkNzTlJzQ3B0b0NLN09nODdQcWVlNW83aEQ0Snk0?=
 =?utf-8?B?bGhOYzJTMXFaZjlKU2ZmNVFmM2wrR2tIN2hIcDVOalg4UUVtTlVPeXVqVFBM?=
 =?utf-8?B?ZFpxYUl4MFp0K05YRFNLZktncXFLYjczUXNsZnR0YnFhZkdUNFljZHNjNWpN?=
 =?utf-8?B?bFE2K2RRdDFNN09XR2UvYTEwVTNiMnl1N0gwYW5IeS9LcExMNHh2U240c0hx?=
 =?utf-8?B?Uy80UUk5YWNNTm5WOC9HNTNKNzF5Q0tOak94c3lWcHpFL0NDNlhpMEJacS9F?=
 =?utf-8?B?RHdEZUtKZVNBZG9ZRTRPK2NDMm1hUGxNYmM3RkRTWExZWkJTbVlXYVVsdlgr?=
 =?utf-8?B?Q3NvYWpHNUozUlZYSmUxemRMYnZqNnMvMkN2NFRDaCtHTjlub2FDMzNrR1My?=
 =?utf-8?B?L2wwK3VPSTVxcVhLUU1mVTRTU3RRazdOam9GNW4ySjhIVnRFM0VMVjVkUklL?=
 =?utf-8?B?eTM4RmF2T0JkcFJnOCs0QnpxQmxFc0ZGUUh2M3I1YmxGUUlEVkMxUThMcHBh?=
 =?utf-8?B?aWRHemtnUlRUN0xDemhldXNOYktUUm1wUGNzdmFiNTFad25lRVpaelkydzVE?=
 =?utf-8?B?NTcvN3Nnb1RWMGZZaitsdHM3TUlLWjNzOFZqQ08zZHc1WkxiTTdjMC9WT0xU?=
 =?utf-8?B?eFZqSWo0RlU5ZGxNclpsOEpwNTFDRmVlaUlzdjFxSVMxZ0tlSUxsTHpJbmNS?=
 =?utf-8?Q?9cSj4RBgRXQ1ozHjhEpFAmsSl?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1b8c8e-e4b2-40b6-4b28-08db77e18da8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 14:11:23.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ahi7koXc57h8+LG5669afjmq6CNxzcStEWwZ039fD8Qb6zt1xfRj0UiRg9bAmH5s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/2023 10:02 AM, Dave Kleikamp wrote:
> On 6/28/23 8:46AM, Dr. David Alan Gilbert wrote:
>> * Dr. David Alan Gilbert (dave@treblig.org) wrote:
>>> * Tom Talpey (tom@talpey.com) wrote:
>>>> On 6/27/2023 9:14 PM, linux@treblig.org wrote:
>>>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>>>
>>>>> The smb client and server code have (mostly) duplicated code
>>>>> for unicode manipulation, in particular upper case handling.
>>>>>
>>>>> Flatten this lot into shared code.
>>>>>
>>>>> There's some code that's slightly different between the two, and
>>>>> I've not attempted to share that - this should be strictly a no
>>>>> behaviour change set.
>>>>>
>>>>> I'd love to also boil out the same code from fs/jfs/ - but that's
>>>>> a thought for another time (and harder since there's no good test
>>>>> for it).
>>>>>
>>>>> Lightly tested with a module and a monolithic build, and just mounting
>>>>> itself.
>>>>>
>>>>> This dupe was found using PMD:
>>>>>     https://pmd.github.io/pmd/pmd_userdocs_cpd.html
>>>>>
>>>>> Dave
>>>>>
>>>>> Dr. David Alan Gilbert (3):
>>>>>     fs/smb: Remove unicode 'lower' tables
>>>>>     fs/smb: Swing unicode common code from server->common
>>>>>     fs/smb/client: Use common code in client
>>>>>
>>>>>    fs/smb/client/cifs_unicode.c                  |   1 -
>>>>>    fs/smb/client/cifs_unicode.h                  | 313 
>>>>> +-----------------
>>>>>    fs/smb/client/cifs_uniupr.h                   | 239 -------------
>>>>>    fs/smb/common/Makefile                        |   1 +
>>>>>    .../uniupr.h => common/cifs_unicode_common.c} | 156 +--------
>>>>>    fs/smb/common/cifs_unicode_common.h           | 279 
>>>>> ++++++++++++++++
>>>>
>>>> So far so good, but please drop the "cifs_" prefix from this new file's
>>>> name, since its contents apply to later smb dialects as well.
>>>
>>> Sure.
>>
>> Actually, would you be ok with smb_unicode_common ?  The reason is that
>> you end up with a module named unicode_common  that sounds too generic.
> 
> I'd suggest make it generic and move it to fs/nls/. I'd run it by the 
> nls maintainers, but I don't think there are any.

I agree that would be best. If it stays in smb/common, with or
without extra filename decoration, it will still need to move
someday. But I have no strong preference on prefix apart from
not constraining it to a single protocol dialect.

Tom.

> Shaggy
> 
>>
>> Dave
>>
>>> Dave
>>>
>>>> Tom.
>>>>
>>>>>    fs/smb/server/unicode.c                       |   1 -
>>>>>    fs/smb/server/unicode.h                       | 301 
>>>>> +----------------
>>>>>    8 files changed, 298 insertions(+), 993 deletions(-)
>>>>>    delete mode 100644 fs/smb/client/cifs_uniupr.h
>>>>>    rename fs/smb/{server/uniupr.h => common/cifs_unicode_common.c} 
>>>>> (50%)
>>>>>    create mode 100644 fs/smb/common/cifs_unicode_common.h
>>>>>
>>> -- 
>>>   -----Open up your eyes, open up your mind, open up your code -------
>>> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
>>> \        dave @ treblig.org |                               | In Hex /
>>>   \ _________________________|_____ http://www.treblig.org   |_______/
> 
