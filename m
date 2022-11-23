Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D836634B81
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiKWAJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbiKWAJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:09:36 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58A5D338C;
        Tue, 22 Nov 2022 16:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669162175; x=1700698175;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dPSHJO8sCITvWtl6Zz/ED5g+kVJ+0p3BZtLtGc5eElE=;
  b=e0rudrT15bWAOavLfyHCJTtiNabGrNUwW4t1h45zO2CvhsWhDsArLYbz
   Iw2Iqf4pVb7CX+bUr5WniHNrzfiAsZXuINiKrDn/Q2T96MwH8uBILHsqb
   VLNT4gXlsXtFoXw7rF7K4+sOIA0Oxfiqhzgc7r08fGDYeBGbgmfw4TAqG
   2t7zigPf8JJOczfTHUNE4Tu7T5UtVZ3HPsyTkOqyjY6ckBs8XVTV9gx8z
   5XQDagtUTdL6O5vDKgezVhtvIN/Gpwt8Suh29+JcABA6opsyLuiUODeG/
   rPvx6VnhkdDc74aLjW3pKiyb35SrWUc461dGsM/KNapEvqph/k9c1b58C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="315765197"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="315765197"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 16:09:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="619407923"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="619407923"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 22 Nov 2022 16:09:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.13; Tue, 22 Nov 2022 16:09:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 16:09:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 16:09:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0kiFJjpCp+s8ORN+FTY8s6JOD7/49+aMo8JYiNiDFpxwkHM/3K2QUUsCvtNui3Q4TQL9wPQTdyqo/brvs79OXHkSezWjNSbP1je/EE7dJhHYKIhH3j5PPhgFnj3QupMw0J42Lwpvd5ELxNrxPsjo0L7+0D2hS4DF+sg/LR9TVmE8pEWQUMWabOrTpDNKs5z6cMwlpsGvQBWB9LKoNYzo03JSGUWjnulL1vr4+lFAHgqqdWcruGyhgEunyi32OnhXgWSCoHJHJcz3wonD3tNo9XUZ4HGP4UEs+n9Nw3b1aHpkzBhJK+8XZinzWttvoZ3KMypi2Y13ujqfXA43SrEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x8HZM9lxz/Vm9DProxWlmBgmkzjU1YM07hq96Dnrvo=;
 b=dsPJIWupRWAjLXfIUlydcP6tq3HHg6H1gKC8yZR8YRRlVF5o7M0sH56KlaVdvZiZw30AGxB7upuyYsR5MBH9+xbwOTdYlmrI/42d70ndRuC5bc9wM9YnymT1nHA02chUq2VI+ah5LAQ6XBNDBvdK9/MtxUf1kKpfrjF/UkpoHjDvq6lOdPCBMRJYbIvCpI3Yh0QEFw+uXfIS6KBVt1fdsJf0VqqkVEXlHfLvFg191QG8qEhbHFoOxfZh81n9LvrV2stO+mdXcwdXvmSDsMi4u6pEtI93QWREevjP0G0kInxNtN1Srn7uYl/1azHQbeArQxICel/JSFBsg5HaHgJNpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB5988.namprd11.prod.outlook.com (2603:10b6:208:373::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 00:09:22 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 00:09:22 +0000
Message-ID: <d8924a9e-d48d-d552-dce1-78d396372956@intel.com>
Date:   Tue, 22 Nov 2022 16:09:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 03/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759201032.3281208.8545863740733338256.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166759201032.3281208.8545863740733338256.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: f92a37d5-462a-4d7e-cfd9-08dacce6f90e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9T8VKFbxs3f0v6tGpXkAj0H4VnJ1Iq0ycAeobukDVjTzpf+Oi/q+wjbmdbsCkNZWGkCOY1VtK1AfxXnfdwzYuCk7DjfvlV7prUSvsq3x9tbgVH7qTIhITzgDOoCUydn5naojtyBqUcP1PDRrmJ0vRnepu4GG8aUJKsp0BEEXE5zVMpXUW0KtA4t198atDS6Hd7SURkkC6Gy3Dq4dxOUBcFCgdXrU0trXuzI4hMNdmLojXw7BySods5sJunjHFcpdKxu6/l8/j7Q+Htdgfsn4ecc9UmP/yk2DQVCHCab5Vb6jA8C5ru4SMlk3rNgZxuTvcHzMM/0z+Th0F7IipFaIQBRA3G5vYeA9rXJ5XF3/ijpKiFkFjOen0ss83NAKDd92JggXLrW42GiYAATWH/3kY6wUbuAbS/12Js/zAS+9JuBX7tH1qLZbd5v5R5RpWbi8Ckh4CXw4GpLcx0wXaAZcJYvqPFVdjS4yw/cOsZkEWa/VNjSfZYxFgAZPQ6knP5VyvXM0spHwoX+jDL1aBoKgAbCLjdQ0hfjqeyoeDJiPLtfkzDszpUPjXDya/c9ureQ6APVtCYt4frE1xQ6Ah5qBbX5DKp6GxO9PI7kQW4kZaZ8HsGnoglnbPefdn8mYCCPP/sH8uAlzeCYwidz8kJnoYQyQZjwGTJ79aJdO/S/IZJOSCmz8NQeSuSW/d1ld70MMmudzgCckR1w4QXXQERMnwMF5PbCgE2WTcOSfCHtt4PO5Iv5kLZuQ5+ZzyEresmdZ25Xo8564DKTrio1vAcVYnfQ8niQVxW8RyIHPAlcKOs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(6486002)(6666004)(6506007)(6512007)(53546011)(966005)(26005)(186003)(36756003)(2906002)(478600001)(38100700002)(82960400001)(86362001)(31696002)(83380400001)(2616005)(8936002)(7416002)(41300700001)(31686004)(66556008)(66946007)(66476007)(44832011)(8676002)(4326008)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGZUK0hsd0dJU3ljZFF6SjByaDVGbUplQm44V3hRN0E5MXpBdTE0cXZkbU10?=
 =?utf-8?B?UTYwTHlIRTYybUYyTEJHNnJhbjNoZW16R2pzbks0SDNkeWttTW5BYkZWMHVP?=
 =?utf-8?B?ZTFOM3dlbnZoU3hRNTAxaGIxM2J4NFJ3eDQ0ck5MNjU2MlBtbHkrUTFXdU9v?=
 =?utf-8?B?SEJoKzRiZS94YjdlaC9qYjhqUXFnTFZSTGtBdE9DTjdsSVI1Q0JmZlZmSS9P?=
 =?utf-8?B?TGo1VEZTaFZKOW1IZTZ1YjlVR3UwM282dkxWTjN5V0JBbXUrcTJHYjVKNFY4?=
 =?utf-8?B?VmZUMWJuWWw0djZ3aTEvZ2JrL0N4YUlhb1ZjWDNJL3BGSEkxdGt0YXgrbkxp?=
 =?utf-8?B?VGkzZVcxUXZTcCs5QTZsbTBJTDExNjJFTG5PNHF5dDNKSlpOYW45Ym42VVpQ?=
 =?utf-8?B?K1hUd05LSEFYRnNjelJEU0JReE1Rdis3b0IzaEhrMjRtbytyMmp3M25kSXYv?=
 =?utf-8?B?NERBdWlmUStXZVRRQ0wxb05kSFo1S0xBbXU0TUorQWdlV2Vodi80SzRZck5v?=
 =?utf-8?B?MXdQWGdEZTc1NW45d1oyazJidHMwcjlPYWFMczFWNC9vSlp3c0RZMjFyN1Z0?=
 =?utf-8?B?STZTN2szYTVPSWVWUFE5V0JsckZ0U0Ztdkw5SkJoZGx0cFErTVNMdWJvc3R2?=
 =?utf-8?B?ZnBuSEJNazdzQWdLRGV4dHE3T1FwcnR4alVJMGpibURKclBMMURKZkdvMHJ1?=
 =?utf-8?B?YTNGYnBMQ2FxcU9VMW5sZmoxemVLcUtkc2JOMU5hT1UwQUdIcVBGQjJHakE1?=
 =?utf-8?B?RXlUWUFuZzIwNE5vYVBVSVAybnRMcmFlTndKL0YrOFJDdjNLdEhSSURBK09o?=
 =?utf-8?B?L1YwRnBneVBFWDN5ZnBURmdzT0xGK3ZOMzNrcWwvVWczNjhZc3ZqTk5URUJU?=
 =?utf-8?B?dWdHTGZ3bC9ZWjR4ejQ0OFM2TWNyT2dCVks3ajZkSUdqMXN6OUxuRStSSGMx?=
 =?utf-8?B?NExaV2FKL1NzL0x0YXcrd1BHZGt5d0huQXllMTlvYUxDRmFmSktaQlFUd0FK?=
 =?utf-8?B?Y3g0RFo0VkRjemM1Nm1IWmNCRFd1SEs4ZHFXcmRKL0NHQ3RmdjJ0UU1GMjZm?=
 =?utf-8?B?VGlSZVJEQWxGelB4UEVDN21VV1pib3hyYXNUMVBHajBLMWRWVDJ0cVpOZTQx?=
 =?utf-8?B?MjQ4MmdYQzBIMDdYSGxOZGgrRWVvdTBMSDAvbzdTRCtVdWtsUlRKT0ZHNm9C?=
 =?utf-8?B?TW85MnVZN3BXeXZxbURabkx3dDlCYnQ4UEI3UmdkZklsVEltQzlYYXFBV0xG?=
 =?utf-8?B?ZW9naXhBK1VtTk53NzBNUzFLUkNrZWh3MDBsa01RbDd2NW9UZVhmNnJxOSsr?=
 =?utf-8?B?TXlqZENSQUZmNHRhb2l2bnl4YVdOekZjYmsyT3NXNGMweXI4eDhMWUYwYlZE?=
 =?utf-8?B?d0hJTkY4YmkyWlozSm1XbTRsbC9vUStIMjhNdTc4czlOMWVnYVNYZ1hhcUtP?=
 =?utf-8?B?T3FBU2l4dTRwTVhtbEc2dnczdFpOc1Y2TEpWenhJOU81Z2xCTUJWNnFkTTA3?=
 =?utf-8?B?dWplandma0Era1NCNkZqNFphNXNmbUtxczROUWNaeFFTWGY3QVo2VGppaDBv?=
 =?utf-8?B?c0d0MW5jVnpKZHd5WTFGMlFraGpLMXhQZ1g2VWhnMEpqV3F3M09zUTQwKzgy?=
 =?utf-8?B?K1VFTkE1YVVEK3YyWVV4ZkJtb2paT3pVQzhsN0VDeHBnUXN1dUxqMm5wUWla?=
 =?utf-8?B?djRkRFNKcG1IMWhGenQ0d3lRb0phYnR0TnBJUlY4SkRtMFVqNmtEcE1ZdWlH?=
 =?utf-8?B?M3MyRForaDdwTGVDQTNGaG9xWGNoOXpuNGRYMVZHVXJoZzM0dzRYSHp3ZFo1?=
 =?utf-8?B?bHRDMHlQb2Q3Q3NkUDVid05pWWo2b0U3OEZOdERHSFkweEdHSDVpZ05nWDNl?=
 =?utf-8?B?eUl2OGlRdGlJNHozMkM4anhrSUNxSXAyZkZHK0t5QVB1ck5rTE9IM3FCenpr?=
 =?utf-8?B?VWpWeTZJZjNtbTBDVTV6U3dhb01WTktMdTFIanI0akdUeDdBenlUUFVxbFdU?=
 =?utf-8?B?NkhuNUx5MDhuVTEwU2RER3FDVDc2dmxMbFE1ZE5lcmYrYXBETWNHZW5wK1VP?=
 =?utf-8?B?VUVITmNySE4yTEZCYjExYWJJVm1HbnZyWGI0NlB6TGpLR3dENW9GOTFnYjFl?=
 =?utf-8?B?ZnVTR1ZwOFI1YitoQWFIRVllVDZwMlkxMEN5cUI2LytpZ1VHakVZZExGOEJB?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f92a37d5-462a-4d7e-cfd9-08dacce6f90e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 00:09:22.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyEma22RUAppTzb99t58RM8E3CelR0+HkWUylxWN5r4SG7xdgzBm0PNmMt/+DyOErg3nhyfM68dl4TC8kIhGd2YLEOsGIfgg+6tlpcU85BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 11/4/2022 1:00 PM, Babu Moger wrote:
> Newer AMD processors support the new feature Bandwidth Monitoring Event
> Configuration (BMEC).
> 
> The feature support is identified via CPUID Fn8000_0020_EBX_x0 (ECX=0).
> Bits    Field Name    Description
> 3       EVT_CFG       Bandwidth Monitoring Event Configuration (BMEC)
> 
> Currently, the bandwidth monitoring events mbm_total_bytes and
> mbm_local_bytes are set to count all the total and local reads/writes
> respectively. With the introduction of slow memory, the two counters
> are not enough to count all the different types of memory events. With
> the feature BMEC, the users have the option to configure
> mbm_total_bytes and mbm_local_bytes to count the specific type of
> events.
> 
> Each BMEC event has a configuration MSR, QOS_EVT_CFG (0xc000_0400h +
> EventID) which contains one field for each bandwidth type that can be

Looking at later patches it seems that it is not really 0xc000_0400h +
EventID but instead "0xc000_0400h + index_based_on_EventID"? This may be
too much detail for this changelog so maybe these specifics can
be deferred and just refer to the "configuration MSR".

> used to configure the bandwidth event to track any combination of
> supported bandwidth types. The event will count requests from every
> bandwidth type bit that is set in the corresponding configuration
> register.
> 
> Following are the types of events supported:
> 
> ====    ========================================================
> Bits    Description
> ====    ========================================================
> 6       Dirty Victims from the QOS domain to all types of memory
> 5       Reads to slow memory in the non-local NUMA domain
> 4       Reads to slow memory in the local NUMA domain
> 3       Non-temporal writes to non-local NUMA domain
> 2       Non-temporal writes to local NUMA domain
> 1       Reads to memory in the non-local NUMA domain
> 0       Reads to memory in the local NUMA domain
> ====    ========================================================
> 
> By default, the mbm_total_bytes configuration is set to 0x7F to count
> all the event types and the mbm_local_bytes configuration is set to
> 0x15 to count all the local memory events.
> 
> Feature description is available in the specification, "AMD64
> Technology Platform Quality of Service Extensions, Revision: 1.03
> Publication
> 
> Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h |    1 +
>  arch/x86/kernel/cpu/cpuid-deps.c   |    1 +
>  arch/x86/kernel/cpu/scattered.c    |    1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index d68b4c9c181d..6732ca0117be 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -306,6 +306,7 @@
>  #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
>  #define X86_FEATURE_CALL_DEPTH		(11*32+18) /* "" Call depth tracking for RSB stuffing */
>  #define X86_FEATURE_SMBA		(11*32+19) /* Slow Memory Bandwidth Allocation */
> +#define X86_FEATURE_BMEC		(11*32+20) /* AMD Bandwidth Monitoring Event Configuration (BMEC) */

Surely a nitpick but it is strange that the two features introduced in this
series are described differently. Why does SMBA deserve the "AMD" prefix
but BMEC does not? I do not think the "(BMEC)" is necessary since
it is in X86_FEATURE_BMEC.
  
>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index c881bcafba7d..4555f9596ccf 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -68,6 +68,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>  	{ X86_FEATURE_CQM_OCCUP_LLC,		X86_FEATURE_CQM_LLC   },
>  	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },
>  	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
> +	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_LLC   },
>  	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
>  	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
>  	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index 5a5f17ed69a2..67c4d24e06ef 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
>  	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
>  	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
> +	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>  	{ 0, 0, 0, 0, 0 }
> 
> 

Reinette
