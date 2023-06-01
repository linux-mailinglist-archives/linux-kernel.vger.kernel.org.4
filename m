Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8D571F4E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjFAVjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjFAVjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:39:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3834E46
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685655555; x=1717191555;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jgJaCiYjybuAd/c7cG8pl5FPp/vNb74HJC0Bmyu+mZc=;
  b=jLnnPNJhXSTSdRrbbRHQnSbi62VLXsPjSxcAT0ZwZVOay0/HhQx8o6de
   F0JoMMYd3mnaYvSw98LPoyWIaiKnDqitQzC8eycskgdg/IFd9X8TMrVLG
   8Nbj3/fnbtsxITfzZ37qZqkvpMd+sdZ0SnaAFwF6KoIgRmnFjbEhZC7tX
   SXsFB84DKSmAIWjYrm1qs5yU1lgMWKYSW4LFue+NnkUg0kdaZqwz05zP1
   NvKjPfQFl3FhU+4/K6yHm+q1NC1c+W+W0Yg9xIoGyl/UaV8Kl8u4oPkaa
   E2h6PcIcqMQ2mHO8kcsHAMqhvPT5XYPsbtp6ULarmeUPf97cMZYIXmWz9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="442061717"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="442061717"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="831721423"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="831721423"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 01 Jun 2023 14:39:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 14:39:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 14:39:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 14:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4lRiJTmPXMBDto0cs7/vV5Uxi6dqfkIjK+Vt0LWiBBLTz8mODQ1xPdkl1YW2tVeZw13xuFj8YAwkhSTskVMKtMtewqC+sDmrKP/6ttBcGM9fFbvdXGaR+IaT3XZhKUSeaDwasmk+NGCjUxcNOSTwq+UuRILzLU9+9cSPd2rf3Lzu16NphMRxaBtUGH0OGzBDG1OT//uKKRghkIgLxBgm2A8IOJ5n5QmY4Alw/bvQ7fsLX/EyLu5VSjAYkXg91BPSIYwsNHBvJxG7gyLZXnQ5+Nh9OeQ6qP64KEXYTu4oi5FESKYWYJYS8uHkUWINvsUxX+eytXy03++DPnYQHxcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHtJrL+jVdwAgs7kRJxUtPUtNJU3ARMZeorBZtse7PA=;
 b=iWQmkPEmqgpRzdmB4TYt33p758aSLoTmzhXff3GmA3tW+R3RxcTPSh01AKl+b8H2mbg9+5BjkA8wLpNrFCAkyUV3IOLy0j2AWNqrZMfqbgsQ2FpoqmUhJDrPxCPGpVgQdtkR65ix94WJ4V6D2gr2zYkQAbB+C/rJF2xM8ZsWlZCNjudcR/KjiIRyDFjmQsslCApiDZeH7R5++liKnknkjOlYqfJVTOk9JD14360NDWBYFI/IHZaztgkMDiNVUYue4VtOgJ7ywu/6VX3cMjfnYZD60CVge8jrbs6ReTwHcDfstWTeq3/HQDYWzAtSWMccXtiZulhsMefQd26oSYVOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by DS0PR11MB6327.namprd11.prod.outlook.com (2603:10b6:8:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 21:38:57 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::ad48:40ba:142d:c421]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::ad48:40ba:142d:c421%5]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 21:38:56 +0000
Message-ID: <bb41bb82-d950-f458-3b46-7751353cc503@intel.com>
Date:   Thu, 1 Jun 2023 14:38:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v6 0/3] x86/resctrl: Implement rename to help move
 containers' tasks
Content-Language: en-US
To:     <babu.moger@amd.com>, Peter Newman <peternewman@google.com>,
        <fenghua.yu@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC:     <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <eranian@google.com>, <gupasani@google.com>, <hpa@zytor.com>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <skodak@google.com>, <tglx@linutronix.de>,
        <tony.luck@intel.com>
References: <20230419125015.693566-1-peternewman@google.com>
 <9d050abc-6ce2-28e1-7b48-358f2a3db437@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9d050abc-6ce2-28e1-7b48-358f2a3db437@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:a03:331::30) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|DS0PR11MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: d59f5b95-4363-4ed6-59df-08db62e89a01
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVkrQd/BfRmX4HVgZrjw0qKF8LS4dCY6mQdBpLFR+5Qan/ilzYBncDDdJYgBlOgVXUgZvKJamUCG0EFjoEtK/E/8Hus14HBsaT834cgDf20SX/xUOg6dsy1nxFQ0EShh4YbcxLBXhHAmugkCPaMjDViAKjabKF7MFz7taMVGGoQMcjfHw7b7N5iqG3V4CRb3IAm2tfT0qf8XigrhGPt8i8xdmTcNLgJJUEUqJv1YEPjJPSbxQmYheTHSGugOOO9T++3PnoZ0SFuP7TJz3hQdQ0d7mrLZP5fL1lGW+u75JWt7l+xFaXBpny8ZcIFTfpmfMSpJGf3Ggj7DS5M8KPRV+AIdb+YxszWZDYR4qp6qYLbS8FrDgtLlcFJxMnuhVYcZScLjNo5mDW5e4OF9b3xakaKlgrO0DyYfi8VOkSWo0/65t7Zgoh4UNmC1Q5SrRwvSIhafAFt+ipOvHu1/eN/U5pvzh4e3HVRu3va2PEiuZEfik3tntkxjuoGO+YqDcx6V61kCTxuLmOplrh/As/vy2szFd2O7w77wGWMItxyz4wmXClgzJAQSx9PbFuAqujRQQCIYvU8VYo5MP3IpN16+xrSRT3xjHCZVnlTHsvu4PszylyNfsOW/6IQLEee0KjwnFEzyWel4j4Bs1FKv24pJP3MD2YScFP9O75w/JrxTEe8H6RxNiGJdaVPmAduNTaHa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36756003)(2906002)(86362001)(31696002)(44832011)(7416002)(5660300002)(31686004)(83380400001)(966005)(6666004)(186003)(6486002)(53546011)(6506007)(6512007)(26005)(2616005)(478600001)(82960400001)(110136005)(66476007)(66946007)(66556008)(4326008)(316002)(38100700002)(41300700001)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkJrWDd4c2dGeEQ1M0FXUHkzUXVsREdKd3FVTUdXQVQ1UnJadlVybmthQ1FQ?=
 =?utf-8?B?b0o2VFZRYzkwYzVqcll5bHRCTW5jM01YZ1ZJbWUrc2FuL1RSanYyT2s3UzNo?=
 =?utf-8?B?eVpvUkEwKy9NZU1OQnR0aXBUUDZERlgvVFNvL1RFVWFDSU42Wm9GSGU0SzNu?=
 =?utf-8?B?ZWpOS2FaaGYxK0JPVDVkNVo3eEs4aTNGOGxycXlBejlKYXp6LzlPSk1DME1B?=
 =?utf-8?B?aU5nV3JXcXNhNHhsLzFXcWpvVWdlalZyVlNDc3k3VC9FQTlZb2ZxU3lLNmR5?=
 =?utf-8?B?TXVRV0ovUERrR081ZGo0YkMrcTJoMXYrdkIxWHhLdjFtMjNjekVsK1hqWjBp?=
 =?utf-8?B?OHZaWUVNcWk3NmtJTDNUelE2WXJIaHMxbUNKY21MNW5naTZsTC96MkVTQStM?=
 =?utf-8?B?MkFpbzhxVWpjeVpKNDZISERST1p3WDFIZEVpK3owOTgxQlVYbzcyTi9KdTBo?=
 =?utf-8?B?ZC9Lb1p4dnppa1hCZ1lMMlZQdHh0QTdoQ1FuNWZTYjNwQStxalpQYS83ZEJR?=
 =?utf-8?B?RmdPWGdaYzJHbVA3YWRBVU1YS0JsRkVlaWtOZURTTGlKemFSRnUvcW9CYnJI?=
 =?utf-8?B?TTdNUFRxMk1pUjNoSW5xbCs4REVSQ09qZGF0cGtRWFBsWEx3VnB5NmVka2s4?=
 =?utf-8?B?L0xuOFdZNWZzZjNkUSs5REMzV3QvRGhyWTZZS3hPY2RJblZldEh3bEFPeVpS?=
 =?utf-8?B?bjJUM3gzSGdUM3BWZlhiY3B2NXFRb0V2aFlhRDBNeFc1YUJ3TFdzQzJidVNM?=
 =?utf-8?B?THZJdXVWWCtVSHBnOFJ3cWhsTXhRclNlMTBqWU9xbUxEZmV5ck9FYjBUbTlQ?=
 =?utf-8?B?YkF1LzRnRzJsYWlzYTI0YnR2V3BES29FMnU4VDNMVDBJWS91dGtnYWdieDdW?=
 =?utf-8?B?OXZqd1N1Vk04UUgvRCtIZ1Z1dnpEdnI2NmdPekJiV1lZTXhpZmVEbWZlRGdI?=
 =?utf-8?B?Y0Q0T3ZhMEExcTE2MUFncGpaaGFZMTZJSDVkT0djNHQzVERQZkFGcUJURjJB?=
 =?utf-8?B?SFFRT0VrcTFmSDRlbEtPTzNRM3dDYWUyMXF4cW4rR0FpL25vREZhRE4xMzNw?=
 =?utf-8?B?aFNud2RXWVFseHdMRmxScndLck1kRkhnLzJQalhBb2R5MVZhNjZlLzJVSlVq?=
 =?utf-8?B?aTk2TitkcXF4eFNSMlFtdmpKdWpTUWt1OUh4RzFoVlAxTk1aUWJLWE9iTDdp?=
 =?utf-8?B?T2gyZGdQa21XcCttc1dOUy96OFNYK3hGQzVVRlBpM2NTRm5SYU56TXV1Uk16?=
 =?utf-8?B?OElnRDdsaUJiL3owUHNobW52andTOUM0VCtoYXFxT2IyaFNtSC81a0plM2p0?=
 =?utf-8?B?bWFmNXpIc3U2Q2lNSG4vUVpvbXFPcDBJVDBZeUJJejk0bkJGNDcrTlR2MFBa?=
 =?utf-8?B?RVZOZ2ppb0FSUk50WFlYNFdMRFVseEpKbGEwZ2NDaFZOem9ybWt4eE9zVmlO?=
 =?utf-8?B?SXQyRk1zemtGc2h5YXJyNWJqYVZrTzhwOE4zUlBzMk42NGdHZ1pMWGxaMnlL?=
 =?utf-8?B?MXhTdTV0emczNUExT0RHVlQyR2dBWWRsTWhYUVhmeEtaRExUR2dOOXN5TTM5?=
 =?utf-8?B?LzhFUWw3cnE4WVA1YVh6WEVzcWU4dGI2emJCMjBUTllQZDlOYTFqSmJUaU1W?=
 =?utf-8?B?djR6dGlBcFl6V2lNOXBwalllSStJaDVDRHNrc0M0NzBBVFpSRmFscGpNTmtj?=
 =?utf-8?B?eU5QN29ZYmJaM2oxb3hncVpWWGJnNU9wUlcwYS9pdjM5WUxEWElyOXp4Umgz?=
 =?utf-8?B?bjhtK05vbmN4bnA1VThoQWFXTXdFS0hQZTllWStuYTBXRHFlYjhMb0tLdCty?=
 =?utf-8?B?LzBPbHpYK1VoN2t2bEI2NDN4RjlnWnpIS1lUTEp4T3FLc0RZV281aTl5TnpZ?=
 =?utf-8?B?UmFFcFFPdVNYMU03dzFuVUo1Wno1Vnd5NDE0TWFoVm44ejdEY01tSGg0VFhT?=
 =?utf-8?B?NVZnNWt0aklBbzV1blg3VC83NzVFMTlIVEc2UlhXS2RZck44N09CVktETFhE?=
 =?utf-8?B?WE9NWFMvT0ZQTk0wVlFPQ0FFbXNYS1NGamkrWGp6OURGSzFiYVZyWlRpcDUw?=
 =?utf-8?B?aEd4WnBOdjFTaElpQUZMNFVuY2Y5cjFHWmdvQmlxS29CNkFKd0czc3NDejVW?=
 =?utf-8?B?THlNRGY4SGtwN0o2aVJHSXBkNk1ZNzhZaTV4OXRyMG1rdzlOK2MwUUdvZ2hz?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d59f5b95-4363-4ed6-59df-08db62e89a01
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 21:38:56.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aLP1dOGZ7eQD/L2rbn7jwvP5S+fmOhKIdBGSY7TctcrR7nZHm/xUe6JUGnqM59noRCqujGK0rBrEax4UU18U9wUMexNYF6syRJvrb89yPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6327
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi x86 Maintainers,

Could you please consider this series for inclusion?

Thank you very much

Reinette


On 5/3/2023 7:50 AM, Moger, Babu wrote:
> Tested the series. Looks good.
> 
> Tested-by: Babu Moger <babu.moger@amd.com>
> 
> On 4/19/23 07:50, Peter Newman wrote:
>> Hi Reinette, Fenghua,
>>
>> This patch series implements the solution Reinette suggested in the
>> earlier RFD thread[1] for the problem of moving a container's tasks to a
>> different control group on systems that don't provide enough CLOSIDs to
>> give every container its own control group.
>>
>> This patch series assumes that a MON group's CLOSID can simply be
>> changed to that of a new parent CTRL_MON group. This is allowed on Intel
>> and AMD, but not MPAM implementations. While we (Google) only foresee
>> needing this functionality on Intel and AMD systems, this series should
>> hopefully be a good starting point for supporting MPAM.
>>
>> Thanks!
>> -Peter
>>
>> Updates:
>>
>> v6:
>>  - rebase to v6.3-rc7
>>  - clarify changelog wording
>>  - clarify error message for non-directory move
>>  - remove unneeded parenthesis for checkpatch.pl --strict
>>  - add Reviewed-By's from Reinette
>>
>> v5:
>>  - rebase to v6.3-rc4
>>  - dropped rdt_move_group_tasks() task filter patch
>>  - code/comment clarifications and errno updates requested by Reinette
>>  - added Documentation patch
>>
>> v4:
>>  - rebase to v6.2
>>  - commit message updates suggested by Reinette
>>  - replace rdt_move_one_task() patch with rdt_move_group_tasks() filter
>>    function patch
>>  - prevent rename on files or renaming to "mon_groups"
>>  - optimize simple rename case
>>  - disallow renaming groups with non-empty cpumask
>>  - ensure source is a proper MON group directory
>>  - fix missing rdtgrp->closid update
>>  - add more last_command_status output
>>
>> v3: use revised task CLOSID/RMID update IPI sync method from [3]
>> v2: reworded change logs based on what I've learned from review comments
>>     in another patch series[2]
>>
>> [v1] https://lore.kernel.org/lkml/20221115154515.952783-1-peternewman@google.com/
>> [v2] https://lore.kernel.org/lkml/20221129120149.1035444-1-peternewman@google.com/
>> [v3] https://lore.kernel.org/lkml/20230125101334.1069060-1-peternewman@google.com/
>> [v4] https://lore.kernel.org/lkml/20230308131452.383914-1-peternewman@google.com/
>> [v5] https://lore.kernel.org/lkml/20230330135558.1019658-1-peternewman@google.com/
>>
>> [1] https://lore.kernel.org/lkml/7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com/
>> [2] https://lore.kernel.org/lkml/54e50a9b-268f-2020-f54c-d38312489e2f@intel.com/
>> [3] https://lore.kernel.org/lkml/20221220161123.432120-1-peternewman@google.com/
>>
>> Peter Newman (3):
>>   x86/resctrl: Factor rdtgroup lock for multi-file ops
>>   x86/resctrl: Implement rename op for mon groups
>>   Documentation/x86: Documentation for MON group move feature
>>
>>  Documentation/x86/resctrl.rst          |   7 ++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 163 +++++++++++++++++++++++--
>>  2 files changed, 157 insertions(+), 13 deletions(-)
>>
>>
>> base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
> 
