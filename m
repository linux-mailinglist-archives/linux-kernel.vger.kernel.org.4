Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EAC65DBC7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjADSBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239582AbjADSBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:01:20 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDF01E3F7;
        Wed,  4 Jan 2023 10:01:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDJPfYEPAQJeFBmxuvZ5y6WbdgzkqgiJU4Nh01gCpGE6oUWzrkwDLaOgwUgo7GV1ilX+GBQzd0VAMfXvbv7cSj3ibXGOStfn3k5I/RPklRZFDt2j8G/cfAAITUr+fH62M3fnivUTP1bEqZ4V2+otKLRJKEFYIFWUyz/o1b2BKV/QBjaI3R9XgkotilA8eU1NlVBIo4sw/93nLp59/4EiZPhGlPXTyJ/8tAZ3sm1iRe1H471tyFojgGL+exsCCVP9Jw5Wbcs/yf1DE0lcUs64Jenty1qG5TKQ/pJO01KBhbV3bflPM/GVdbhIv0EGiA0qTbOnPlznWcns0PNhJwy8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wctrDEXn7bZ87CRacRJjXPIRYocfrVFbrdr7bEdxo4Q=;
 b=Vwo3vCyTfsdOZfbdElZC3ugiLZ+Oh1tSQQ6gt4KSU3XeVSxPuCxJ1tApSjNKp8wcV17CrvIKml4q490TAwQicjxc5DNBSmd0ReRAA6+otel1YB7+UaOpLxrpjJ6LSZR3O+/tqKNPlhlkbZDLqGRv+fCvrHgxM3M+TcvTi+1Ox47pr8Y7KOKDcSEAeQ/WJZxwH7gpfEJkzf+1igrEVOEr9GGbFuMpbz7NyLpdNwWNWFSgIJiinlfoE4eJ292vgZYhBFOlfHmE8kaYzY+F/N0asJcJnJjhdC44Ht4cypPBTqQ6FdWleb9FmaWbaCj84yiJI3E1PIhdE2CYvTYkCyekDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wctrDEXn7bZ87CRacRJjXPIRYocfrVFbrdr7bEdxo4Q=;
 b=MPM/sHaA19m8LeM0UeuDyt+2HAK1Bc/Ax7n6Bml9NQM3/vh5B9i7f6aWNDYpd9g7GaLTSyYU+Msm9U8y64BISHCYvcYkk8aoROEe3Bksynk46F+eNbNhAJIfVa1wwKJvsuJU6VN3b3Hkz9rwwHWRW1iTDKK+YYR3MA145zuAb0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 18:01:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 18:01:17 +0000
Message-ID: <9ca06669-7826-b3b7-0977-02185be7ce08@amd.com>
Date:   Wed, 4 Jan 2023 12:01:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH 3/3] x86/resctrl: Display the RMID and COSID for
 resctrl groups
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
References: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
 <167278361325.34228.16916982678071203069.stgit@bmoger-ubuntu>
 <IA1PR11MB609764AC3E09E0A1F8A8FF7E9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
 <CABPqkBSoO3XoWGbk-HgxPsAfs7hUF+EjoUsu5qXtakjkT9QpWQ@mail.gmail.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CABPqkBSoO3XoWGbk-HgxPsAfs7hUF+EjoUsu5qXtakjkT9QpWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a81884-8c04-4f74-e337-08daee7dad14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDSTm03eYjpIEWeHmFppBiIm1wDZAAWT/r+nLuABSAmesOvWm0amZQdL9OWHjntwwXigaj4SduAphZVnlv3hwYCCK+nsb75BNI4EWi5NgWpHvuwp0S7coJsPj2X4QCd0BngZ3dEX32e2kSM/sjuTHyoeueV52G/Y5nCy1RSmTrHg8TwBAJimEiX4fvFUHp05FVed8n846LMuYf4RY0j/TWUM4uvTRV9YvW34amDIiSZHHnv23/hYm/FV0q0liT7kEJNwSny3r/wRdBIsVZ80b/F9mIE+JxNLyKOt40injy8npBIeumNj5sS62JW7xRg2yh+qZcHbKHsRTDEeGuqxk9IE6ZliQPSFt7dcuv5qiTRwDohOOAjchF0+e/WEEp/9XHC0Onvp50Q5L+tJT2uqPD9g93KfkKNeMkQdPOYn2SsoZAwaOONZiBmQCkPLywGxUXT6N5u1YBZlGeW8Q1rS6WFARWAoE0CKb/xJVdBPRDDqd3H8yyqukm7bVTH67KfYk1Mi1kD6iNu+Tgw6qIAwEqvMHN3K+KMKXQIMwJcgBa6fGmNeqp+uJAOl4rMQRU5AnYmGdJD9CGQbUWWPpK89peT7hT8uJVVYMrMJxhZxHW3KAp8sgZZi9N6yEMm4IXVJNYjr9LcS9FwUeiGDK/FjNqYqoNCgkSDUnuUO0T6fb8Yqz5yxLzYW5QOTXTEAqV4zJlq1d5x+vM1tIdfvEyBEnFjyeZrdnrB0D6bPBsByX3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(6512007)(110136005)(478600001)(6486002)(5660300002)(36756003)(2616005)(38100700002)(7416002)(8936002)(6506007)(31686004)(66476007)(66946007)(66556008)(41300700001)(4326008)(8676002)(53546011)(6666004)(316002)(31696002)(26005)(86362001)(83380400001)(54906003)(186003)(3450700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1FpSkU4K2ZVKy95MkhYTFgxU0g4ZDRmZStCMVBGcjZCN0F6UUxXNUhYbGk0?=
 =?utf-8?B?WW5LYW8xWE4wTkhvcE5udEJ5SE1rWUF6Umd2eHhwSmJEaDV3NCtpNWhrYnpM?=
 =?utf-8?B?eEk5b0RsbEo2Mlk2Z2pxT21PeHRmOFloYWR2eHpCSkRmNkJwSkxoT3lYTHZQ?=
 =?utf-8?B?alNPbjRySEorNkxKR3ZkU3NMd3FWRFF6Njk5QXVJT3Uwd0cvT3QwTFVlQ0V3?=
 =?utf-8?B?N3ViU0VpUWpJWkdqVEJIZzNqNk0wcGMwWjZzL0xBRWRoS2hRZW04bGJzYXJs?=
 =?utf-8?B?dDBVdzMzSTRIWnh4SURuQVhWRDV3Q1M1d0NRVy9yeFRITTlYVnQwcWxrUldr?=
 =?utf-8?B?RzhMb3Mxa29IUFVveTIvOGRwa2w5NUl4bS9Rd245VzVHb1J1ZkFYVXZtZUg4?=
 =?utf-8?B?dktJQWxyZ0ZjWExaVmQxTXh5czJybDRkSjBXV1EyOEo3VWg1SUovSnJzTmc1?=
 =?utf-8?B?YkE5UW1wMzVHR0xFVFVNUnJ4TjNqaDl4RGxTNUdQSHVZTVdiSmpWNldMSzRO?=
 =?utf-8?B?WlRINW9XWVhydndpSk9DbUxFMWxYMDUrWml2azZNNGQyVVJMRVBibjlTb3Vi?=
 =?utf-8?B?Y2V5SVN4TW15NDNnL0VIcHozdVRvS0JpNm54c1lNalZmT1JkT0dCdnlVZkpt?=
 =?utf-8?B?YjVpMXJsT1VzdzQ3ODdUb1E5M2ZEVStOSU1VeGdOWGw4Yit2RXUyWW0vM0px?=
 =?utf-8?B?clVqMEtvc1lYSFRLUHJHbTcxNWtERSt3Vi9RdlN6RHdibGIvS2RXZnNyZ29H?=
 =?utf-8?B?TktRNjFNUmxBa0hoVGNXUC9Wak14T2wvR3BBbWM1enY3Vi80Z3gydDlFNDlJ?=
 =?utf-8?B?dGNkZmtsSmtBdDlWR3ZJMmI3TmhWeFRRaEZxZEFhTkpqcUd1cWQxNmxPTXRL?=
 =?utf-8?B?MDNmb1EyWmgybFRzeTJpUjJWNnRwRGgrS0tiUEgxN2JWdCtaSmZYMXFUMWRZ?=
 =?utf-8?B?U05qSjFXbERRb212T1p6OVlLVmNYL0JCZXIvNkI2WjF2RmtXMkVsRXVZYkFC?=
 =?utf-8?B?dTNMMFE5bjByNFh3dG5HYnhxOE1qZ0ZNWGxmZlZ2VUhpSGQ1a3JCbVlvck5G?=
 =?utf-8?B?NHZxcms2QXQyNU5YcGUzYVlObTlSaUpkNVUrbDVsZVl0d200WFJ2cU1jdFBN?=
 =?utf-8?B?VkVORW9pUW9paGkrUnI4Ri9XbmQ2UEtteEF0VlgxcE5BbjBhT2xIa0habWpR?=
 =?utf-8?B?Q3d2UDZLUEZNQUpVU3lEbitENklWdHhjUGFSV0pXVjZBL3hRZnhZMUcxN0RV?=
 =?utf-8?B?dU5UZEltU1J4djVUNkRJNW1OQlU4aFJuY1M1b0liSXc0L3VKL3pxc2paUmJJ?=
 =?utf-8?B?V2d1RFMzalNQbXppY2ZYdlZULy9QTVRIQnVRaXhNWG5jN2ZlVnZTeTdSM2VO?=
 =?utf-8?B?bHFxSjRtcU1OMlk5ekYvdjJuS29zaE1aRnE3K0NDdDg3bXFpYmUzaUVxZHo4?=
 =?utf-8?B?cU1WTjkxbTBlWkptR0VRQVo1NHp6VmVzaDJiN1dSeUVrTzlad0FJK2ExVFJh?=
 =?utf-8?B?ZndpV2xobHN4aU5QNnU1RUNkMGhxcXRxa29Kb2VGTzA3QkFzTnEvTHlHbjQy?=
 =?utf-8?B?bDE1d2VxRlptK1RMbW9aTVd1L0xyTTJic2dyUytmSzgwbWtYUEx4NUxwcGVZ?=
 =?utf-8?B?dU5rMTh0OHhmVGtqcEJrTmJ5dy85ZVhWWlpXa1ZwMlM4aTJvb2I4akhib0pC?=
 =?utf-8?B?MFNuU3Z1TzJ4Rmh0YU1sc1ZqSGM1OHUwNTRBUkE1bWJpVE9pSGcxblZWdHYz?=
 =?utf-8?B?THNlVllIOXF5UFUzY2MvMUhMZXZVWG9USFFOL0wvd0RFV2dqV3FLSXR5Uncr?=
 =?utf-8?B?bkRMZ0d3Zjlkb0ExR2dnbWp0c084M1JFcWFHREJBcjVWb3F1dytjNmx3R3dr?=
 =?utf-8?B?RHB5aUxMOXhTNDNRdnVFWjFKV2sxU2FveFJXaFQvWmZIMjcwNDdZTExnUllP?=
 =?utf-8?B?MFFsTjhsRHhkbVZ0L3ZESnBneE94dWt6L2pqczhsWmRtRVRGM0ZkYkEwaHgx?=
 =?utf-8?B?bDdMOFNMa1NvN0syalgrZ2Q4a2JxSHIzK2Q1b0Fpc0VFUHc4UHVTSWd4SCtr?=
 =?utf-8?B?V0dvRTQwVWJZQTBhZmJmNEhnR1pUWVhjbytCeW80ZFRJR1lhcE1GVU5UOW9Y?=
 =?utf-8?Q?4x7QLVfiRPsmGngkqcUES05//?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a81884-8c04-4f74-e337-08daee7dad14
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 18:01:17.0371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTcBE0S0GldOt1t31VNXQvonB6e1EEz9M6SBhvze8bmiCgTPPLlewQsL3nB5IPDk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

On 1/4/23 00:45, Stephane Eranian wrote:
> On Tue, Jan 3, 2023 at 10:06 PM Yu, Fenghua <fenghua.yu@intel.com> wrote:
>> Hi, Babu,
>>
>>> When a user creates a control or monitor group, the CLOSID or RMID are not
>>> visible to the user. These are architecturally defined entities.
>>> There is no harm in displaying these in resctrl groups. Sometimes it can help to
>>> debug the issues.
>> Although "no harm" to show them, it's not useful for generic user either and may
>> cause confusion sometimes. CLOSID and RMID are supposed to be invisible to
>> generic users.
>>
>> Maybe introduce a new resctrl mount option called "debug" and show the files
>> and maybe other future debug info only in debug mode?
>>
> On other non-x86 architectures, these have no meaning or no direct mapping.
> Take ARM MPAM, it is called PARTID and it does not map to either RMID
> or CLOSID, it is combined.
> Why would you call this closid/rmid at the user level?
> You could instead use a more generic name such as mon_hw_id,
> ctrl_hw_id. And on ARM they would be the same.
> Just my suggestion.

Sure. We can change the names to mon_hw_id and ctrl_hw_id.

Thanks

Babu


>
>
>>> Add CLOSID and RMID to the control/monitor groups display in resctrl interface.
>>>
>>>   $cat /sys/fs/resctrl/clos1/closid
>>>   1
>>>   $cat /sys/fs/resctrl/mon_groups/mon1/rmid
>>>   3
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>>  Documentation/x86/resctrl.rst          |   15 ++++++++++
>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   46
>>> ++++++++++++++++++++++++++++++++
>>>  2 files changed, 61 insertions(+)
>>>
>>> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>>> index f26e16412bcb..8520514bc8b5 100644
>>> --- a/Documentation/x86/resctrl.rst
>>> +++ b/Documentation/x86/resctrl.rst
>>> @@ -231,6 +231,14 @@ All groups contain the following files:
>>>       Just like "cpus", only using ranges of CPUs instead of bitmasks.
>>>
>>>
>>> +"rmid":
>>> +     Reading this file shows the resource monitoring id (RMID) for
>>> +     monitoring the resource utilization. Monitoring is performed by
>>> +     tagging each core(or thread) or process via a Resource Monitoring
>>> +     ID (RMID). Kernel assigns a new RMID when a group is created
>>> +     depending on the available RMIDs. Multiple cores(or threads) or
>>> +     processes can share a same RMID in a resctrl domain.
>>> +
>>>  When control is enabled all CTRL_MON groups will also contain:
>>>
>>>  "schemata":
>>> @@ -252,6 +260,13 @@ When control is enabled all CTRL_MON groups will
>>> also contain:
>>>       file. On successful pseudo-locked region creation the mode will
>>>       automatically change to "pseudo-locked".
>>>
>>> +"closid":
>>> +     Reading this file shows the Class of Service (CLOS) id which acts
>>> +     as a resource control tag on which the resources can be throttled.
>>> +     Kernel assigns a new CLOSID a control group is created depending
>>> +     on the available CLOSIDs. Multiple cores(or threads) or processes
>>> +     can share a same CLOSID in a resctrl domain.
>>> +
>>>  When monitoring is enabled all MON groups will also contain:
>>>
>>>  "mon_data":
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 0d71ed22cfa9..98b4798e5cae 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -769,6 +769,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file
>>> *of,
>>>       return ret;
>>>  }
>>>
>>> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
>>> +                             struct seq_file *s, void *v)
>>> +{
>>> +     struct rdtgroup *rdtgrp;
>>> +     int ret = 0;
>>> +
>>> +     rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>> +     if (rdtgrp)
>>> +             seq_printf(s, "%u\n", rdtgrp->closid);
>>> +     else
>>> +             ret = -ENOENT;
>>> +     rdtgroup_kn_unlock(of->kn);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>> +                           struct seq_file *s, void *v)
>>> +{
>>> +     struct rdtgroup *rdtgrp;
>>> +     int ret = 0;
>>> +
>>> +     rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>> +     if (rdtgrp)
>>> +             seq_printf(s, "%u\n", rdtgrp->mon.rmid);
>>> +     else
>>> +             ret = -ENOENT;
>>> +     rdtgroup_kn_unlock(of->kn);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>>  #ifdef CONFIG_PROC_CPU_RESCTRL
>>>
>>>  /*
>>> @@ -1593,6 +1625,20 @@ static struct rftype res_common_files[] = {
>>>               .seq_show       = rdtgroup_size_show,
>>>               .fflags         = RF_CTRL_BASE,
>>>       },
>>> +     {
>>> +             .name           = "closid",
>>> +             .mode           = 0444,
>>> +             .kf_ops         = &rdtgroup_kf_single_ops,
>>> +             .seq_show       = rdtgroup_closid_show,
>>> +             .fflags         = RF_CTRL_BASE,
>>> +     },
>>> +     {
>>> +             .name           = "rmid",
>>> +             .mode           = 0444,
>>> +             .kf_ops         = &rdtgroup_kf_single_ops,
>>> +             .seq_show       = rdtgroup_rmid_show,
>>> +             .fflags         = RFTYPE_BASE,
>>> +     },
>>>
>>>  };
>>>
>>>
>> Thanks.
>>
>> -Fenghua

-- 
Thanks
Babu Moger

