Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D376475A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiLHSc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLHScd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:32:33 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029E88425E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670524290; x=1702060290;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i2xFV7EEf2dhJFA3Wu5CrHrqh1tSPmwmMwGih9DNaR8=;
  b=Ja2z6Ax72HFHIDa+vqL/zJj0r8xu/GX9IpA2SZVjMaaPhkHKNyTvVFKl
   Xk83KdvdYgumBLWelFFBtdLgL4/ECkEj3Lmy07dayAMEbvIQM2Dqa8B9i
   EyJ+BSLhoM8e0tfXJkERKxfrkg5qWwA6bXLgKzDPQghe0W53Ke4ejTBzX
   7opnISVSkVapIRTePWKOUUxPzR0UEp2BqRtxYATDpTcrOCYlj8EDNagLq
   FTOVVa+3PMP3wmQv28xgNLozc3gdpjLZfwOJpzOA9FgDX7noj6APFfdyM
   PRJmPW5z64fVxffEBLyIg0ONaDfDzlcR7cHABoj+BWmuu4d4awIpF3i+k
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="297609442"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="297609442"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 10:31:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="753687481"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="753687481"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2022 10:31:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 8 Dec 2022 10:31:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 8 Dec 2022 10:31:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 8 Dec 2022 10:31:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1CxjcXv8XdGlHRnOYNfBQXtRU6oWScp19SyGFADVWjVQeezaLIB68xNWg4jdpxcf/gk1i4xQqFcv3idKQeD4BMtlbgLqb9Ev+YhUi3sXSAWjz6afkzaMB5wvIvDeY28ZFHJIVGgJvtt7vF4bBEwNMWl8Tq1gnD0xKQF0IwabbqIfZo6pbN0J9cUoYqqL7dG4efgePYN/e9s94gba2n4UsT24BdZGbxpUA0iDWmROmYWl5hIBs6E/wdE3tizcAf+fgDE1bH26E+1w44egSzFtCiZs/xeTAk9W3cayM0IvXe9hoAGX8kdmXB5t1MOn1Dh4gTA3JvaCxwxhlNk+pr3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YXJsg6LsW8lGPBv1H3bLREy3t64wuwrJWWLQHXRJEI=;
 b=HE5a1hzdawl8AImK0y3XYTXG6hC+TGxCEUQcoeVe6BGMptusxUWUY9eDNjVLrFymuajrU/tzyE23TGW0b5VYawSSMfNgaI7gB1c0BDDFw7GjP+8mvG39k80qA/+yLflweo9AnwUoiBl9ORJ4AYgdj7sqTa4IdlxcI8ixmx9/EI/hGFAwDLdGBttCbV8So9bI9q8gMiIS87fWfzfh1JetwA8GgKq22OEnkqrzg6EFuSYA4Q7rSNB/F9dsoi9OR3rn8Od+Jkn2GoQ6MLVjeroIiggr1SyVhFJ+xNp3sw8B0DemsxRcH63OAoOnnkmC9j++1xalmEoPVSsIGutdgQFJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CO1PR11MB4852.namprd11.prod.outlook.com (2603:10b6:303:9f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Thu, 8 Dec
 2022 18:30:57 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5880.016; Thu, 8 Dec 2022
 18:30:57 +0000
Message-ID: <74cfd689-3c03-5f41-d01c-efab04ce4197@intel.com>
Date:   Thu, 8 Dec 2022 10:30:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] x86/resctrl: Fix event counts regression in reused RMIDs
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <eranian@google.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <20221207112924.3602960-1-peternewman@google.com>
 <f58e6af2-aa16-9461-d40d-1e4e52ee6943@intel.com>
 <CALPaoCiB-vOuXJYkaLLsxSKHcjT55q1RSNBjhHUWmPL9rFdF8A@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCiB-vOuXJYkaLLsxSKHcjT55q1RSNBjhHUWmPL9rFdF8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0111.namprd05.prod.outlook.com
 (2603:10b6:a03:334::26) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CO1PR11MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e0cf4b-e931-4a33-4f86-08dad94a58dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRlUcZV7nEsLm9kK1vbsrCVYSri7AReDuTIcFxCnhGo+MzZzCr2/izzBniTRnPXekANMpf+ZTyq/5eGctA64LQY8aYsC2SpVtqJwPdM8wwExNozgGlgn390qxsyvjHrhS+NW7Aqlq2kvYYnjnycFbAzExeg2OfZusT/CdNSq9D0coLgoBOswmtRQfrp9rxtvvUOBYcWNTwSHlRsrjhG5EXS4e6t/sBZcotInewqMGsPRZhkzdJnBYNI4Y2Lp8OH7NFOr/eJz+mMshVP1Puy1dLiB2fP7v1BXV6G3n7sgr8qYxVIERnJxs+tK59piqr572Yh61SU1UcCHwExBdtyHdVzvraNiH7XUudGQXc0QUv/Qn2H57VDbU9wskEROVaMgpT9FUPzTUbZt8CIngRh0Pj5q7NEgkTuhUX/nd4V5mcGzJfV+ad0DijoEV2P4i0hv8FW/sxStHtftYannGK6MZtclnRWVW7D+QD6XKePJf/CNlvz3Rhzhs666FnZ+iKGDUoeycz6FcaCwqnsS+/AmqC+34USEWgk7l4dQO+3GGt0T4nlLhPlzmQ90i/W+cuZSvQ21sxZNBzrcAWlG/TKnkjsIW+gc+BxNvd6XlwRqNc+eAbN2aW4pZb5HO0MF5Lil860gP9BPpnBtwc0wOuDfcsE/5FvX9WrN9DdrRqU70Ys+6SRfQaHbntlrCEIhHITh89S7KGKV5D/JCZ/XlZ1pmQ2zJLJVJ6HKVbu7saKEfus=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199015)(44832011)(54906003)(36756003)(31696002)(2906002)(86362001)(4326008)(2616005)(83380400001)(66476007)(7416002)(6916009)(6666004)(6486002)(26005)(478600001)(186003)(6512007)(6506007)(53546011)(82960400001)(38100700002)(41300700001)(5660300002)(8936002)(66946007)(8676002)(66556008)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHA5ZXRHL0l2TVZwejhHaWMraVFjM1pMQ0Y5eHhwWUtNOS9XaGZ4aFN4d0pT?=
 =?utf-8?B?SFJIV2NuMlN3Z1M0dTNBdUY3NDJZQVI0UjNrd0YxUGdSQUZwamI2NUg1Y0dK?=
 =?utf-8?B?L2FLYjJFQlJja0dSSFJmWkF2OXpzMHVXU3FpNWx5eXZueXlxcjNzWjd4SXRs?=
 =?utf-8?B?NDRmV0NUcUVnZXBwR0xYcW5HM2swVkZaVUd3cVdkNEsxYUYxaDlNTFhrdHlh?=
 =?utf-8?B?L0E5Z2NWcEM0Tyt0a1Q2YWpPUVY5dFVIekYvZ2FwenFKeDN5bHUrYndXc0JR?=
 =?utf-8?B?QzNQb1lBRGNZN0xoaXhjdXdTZmtrTVFvWXlscHk5amJYNWd2WG1QcmZ5U2tx?=
 =?utf-8?B?WUFyWE0rWmsyOTcyNXpTWGdGc09nV3g5M0tiTmNtRGE2R0QzMk9IVGxnNWJS?=
 =?utf-8?B?SytGQnRBSXdCdkFYdmZjVENnUXJGZTVLOHFRQjQ3Q1RIL2VNK2d6dGxHbXRS?=
 =?utf-8?B?R0djUDRnRXNIUTNINGFFKzg3ZGIyTXVzdXZyaU83SE1GZ2xWMW1BekxlWTY0?=
 =?utf-8?B?OVFUK0tPaWhhZ0NsaXd3SW5ESGF6KysyM0hlUEhBK0FWY3p1RkdmdXRVWlZF?=
 =?utf-8?B?UisyWlg4eUtBdXE2UVd4K2ZQeWtBZlRqNC9yWXY2YURDK2dvZ2JvR2ZoZHdF?=
 =?utf-8?B?R3g0c1BsR203MmdOV0RFdWNEakJEN1ZXdVl0V2FQMWttQUN6Szh6R2d0ODMw?=
 =?utf-8?B?aUwzU2NEVzhKTEhJcktmdSs3Vlo4WDhLN0xjeXFxR2YrK3oraFVEVHUrTDRC?=
 =?utf-8?B?Z1NMUkxMTkI2dDdBODI0WTdCa1gyaXB5WnhieUgrL2lnRTYwZ09wblJmWTJX?=
 =?utf-8?B?UHVaV3ZaU3ZXLzFYNHZGalpqcmFWaUdHbUVYeWJ1NU05K3RtM2d6TE1wUmJx?=
 =?utf-8?B?RWhmMWJPVEVqRk51QUo3aStXL083L2Nwb3BCaDhrekw4MGZDQkxWZFhrSUJR?=
 =?utf-8?B?YURzaEVLaXl3M05teklsWm1YN2szTmthZzJBZGVyOTlFZmVGaW5qS3V2TFR0?=
 =?utf-8?B?eExNYmltRDNpZ3c5N0IzbU5NRXlXYXlFenhBZEhsTmMxdGhoMytOeE42SmlY?=
 =?utf-8?B?VDdDRWJYMnFFMUtOMDdZcytvYVRTQnFiZzMwOWR5aSsvYnlaUFRQdVRsRTBy?=
 =?utf-8?B?UGxJamN5MVIxZ0ZSQmNQa1Nad0VmRnAyeU9VUmxWOXBZTDIvOVkrUlluSHlT?=
 =?utf-8?B?Q0FYckYvSi93WEYyUDFjSUxaTUE2OThCU2wrcE05TmF1OENEN24waDJrMWxa?=
 =?utf-8?B?YjcvM3FpdnV2aldWSkkwcERKSCtUUjM4WVhhRVpRdDhNTUoySis0TTl0U1ho?=
 =?utf-8?B?bkxaR2ZoWDFrQWs5WjBHeHBRdXk5YlY5N3pZdFhiSVF0cnhRUUZPdDIrdVF6?=
 =?utf-8?B?RDdWZmp4QUY1VXJUOFg1ZE40SVExZU9EbmYzZDlLcm9GeTlJSlltUSszTTRy?=
 =?utf-8?B?YXZ2ejNVNkY1bDJOTHJ1bjdkbFhPRldZMGVoMmlDK28xaC8zbzJIbVR4KzJV?=
 =?utf-8?B?cXkvc2x5Y2d3K0Z5TExXMWdRRWZKeTRZV1hjYUIvYjJ4SStGL1cyaFYyY1Zk?=
 =?utf-8?B?ejN0Z0dONEdNQlp5Y1VsNi9BZWpmR29lUUhKWVJUeUM5YmxxajVPbHZuUVp4?=
 =?utf-8?B?WkVIZnhESUVIWHhrYU5WNGowRUQ4TGFHRkJkTGkrWTZSUU1ZMGhLNjRzR2o0?=
 =?utf-8?B?R3hWcjF4bEZaVXpjbW0vZktwc0tRK3ZyTGsvK1hIak1lSHdLTFJ3VEJkMGlT?=
 =?utf-8?B?aHlrMU9TMnhGR0Yzcys3YklqMzdhMFRDbHlRNlNGNnpyaldYN2lPanBNKzFZ?=
 =?utf-8?B?T1c2cmdxTVVtZkFYRmI4R0tzUC9rZVRlL1VMRVpHS0NXTE9CbEJYR2dHVXd3?=
 =?utf-8?B?N3lEbFVMTXNoRDZlSE9iOXpXMTkyL3lrSzY4QXkrMDVURlVhNlVQbzFaNFFY?=
 =?utf-8?B?dlROOTNHWWNJdGZuOERLTUR0QTUyQXNLMytJZmdoOUhMME9xd1pSWmlIN3JO?=
 =?utf-8?B?cFhsWElPdGFVd1lnNzdBeEJtVjRPeElWTy95Nnp2QmhLOWdrM3RKaUE2UjFw?=
 =?utf-8?B?NWNQNG90VWJHeXg0SVl6TWQzUFk2Qzc0dlE5VHZHcVZUTlZwNkpYVzM4MUJm?=
 =?utf-8?B?Qkk2bUNFdG5tbHZYa3dXQjlzR0RKS29zd0JoSFdiQnF5RHE1blVNb1N6QkpY?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e0cf4b-e931-4a33-4f86-08dad94a58dc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 18:30:57.0799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeFSvtiIlKn7JttlPFKtM8rFU2mHa6/9ADf220p4VPmZoSM9/jBI8KfFFaX4KBPIzBQh6dmppzl4lmawWIffNxbadv2pcF1tXEcl3wu1D+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4852
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 12/8/2022 2:04 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Wed, Dec 7, 2022 at 8:48 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> To get back to the original behavior before the refactoring it also seems
>> that __mon_event_count() needs to return right after calling
>> resctrl_arch_reset_rmid(). The only caller with rr->first set is when
>> the mon directory is created and the returned values are not used,
>> it is just run to get prev_msr set. This also avoids unnecessarily reading
>> the counters twice.
>>
>> So, how about:
>>
>> static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>> {
>>
>> ...
>> if (rr->first) {
>> resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
>> return 0;
>> }
>> ...
>>
>> }
> 
> Avoiding the double-read sounds good, but...
> 
>>
>> Also ... there appears to be a leftover related snippet in __mon_event_count()
>> that does not belong anymore and may still cause incorrect behavior:
>>
>> static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>> {
>> ...
>> if (rr->first) {
>> memset(m, 0, sizeof(struct mbm_state));
>> return 0;
>> }
>> ...
>> }
> 
> I'm less sure about removing (or skipping) this. mbm_state::mbm_local
> still seems to be used by the mba_sc code. That might be why James
> left this code in.
> 
> I was sort of confused about the new role of mbm_state following the
> refactoring when reviewing Babu's change. (which reminds me that I
> should have CC'ed him on this patch)


I think this can be cleaned up to make the code more clear. Notice the
duplication of  following snippet in __mon_event_count():
	rr->val += tval;
	return 0;

I do not see any need to check the event id before doing the above. That
leaves the bulk of the switch just needed for the rr->first handling that
can be moved to resctrl_arch_reset_rmid().

Something like:

void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d, ...
{
	...
	struct arch_mbm_state *am;
	struct mbm_state *m;
	u64 val = 0;
	int ret;
	
	m = get_mbm_state(d, rmid, eventid); /* get_mbm_state() to be created */
	if (m)
		memset(m, 0, sizeof(*m));	

	am = get_arch_mbm_state(hw_dom, rmid, eventid);
	if (am) {
		memset(am, 0, sizeof(*am));	
		/* Record any initial, non-zero count value. */
		ret = __rmid_read(rmid, eventid, &val);
		if (!ret)
			am->prev_msr = val;
	}

}

Having this would be helpful as reference to Babu's usage. 

Also please note that I changed the __rmid_read(). There is no need
to require each __rmid_read() caller to test MSR bits for validity, that
can be contained within __rmid_read().

Something like below remains:

static int __mon_event_count(u32 rmid, struct rmid_read *rr)
{

	...

	if (rr->first) {
		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
		return 0;
	}

	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval);
	if (rr->err)
		return rr->err;

	rr->val += tval;
	return 0;

}

What do you think? 

Reinette

