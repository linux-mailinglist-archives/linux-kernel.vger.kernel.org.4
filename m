Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819836B5646
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCKAW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCKAWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:22:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F3F138F68
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678494144; x=1710030144;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rJ1q4k1BD4I3xTwL0jZ3yubyFsUjQuIWt2xOHMk4g0w=;
  b=ZAHszABDUwMvDyKfL9BrRKXDjR9eayICH3k6YXIsW/uhXhfmweL2raHD
   vKpcZX7st4jXvNo0JqPlOyjJwCBw6FhgYw5K6waNGJyRV7S2w/kOmi3ti
   GdeyNZ4M62X4FD5St643Q9dgIlN2UrPmzeFbRkmpzWok1Nq6b83Ds6d5f
   qh9kvsi+c86JsMwLUxcMSD4RwxUIMIj5RFLmc2wynacMthgIc3/L5ZIV5
   e89ZSR0jQTfYwKR2FO74rqAuof2TjgpfsbWeUsEo57z+D05u40/5eZWD4
   U5pglFDkC6eka/utyE993Ke4laTsI+1OKmXKFV/D2AMGqdCZzT2YZeDx7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="335553263"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="335553263"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 16:22:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="655359844"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="655359844"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2023 16:22:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 16:22:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 16:22:22 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 16:22:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T67vCli+u339v5aBGJ60ntp6b+/TfUSrDz0WWuqGR7hB1BhstsVHBQFxJZoo6QzCiDpKknCWlZEgrk0J9pk6VhDGHbVcjb+DUoZ+PyiR8uHIasa8OCVEQ0VWwaqjvlD6Q7XpDF93t6Qf9PeZa3wdlhHAup3m7hTO4BYiEIwrnHbDtez2LFYjHuaOD6c6BrS5NUgQSIUf3Uah4ZwXE2wX1OSBtgugofy+Dqm7JlFCZS3YqlcACR0AiJ5MgiT/hitmjIYlxfoy/e7V4kskiavpYViQ4VNGVmRJJ0UT5Ezht4x1/ogoV8cFbK7cS+jZj2MglW5QWHzzJNKuZoBt9M99Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4reWyHC5rHNzZ+MR7ALTCN4kTVkrfd27hfIFGplpnI=;
 b=d/9P0NZR2gv0gCmyTTV6pv7K0zZDRsgExt1gNfHSVHeOjI6aNTB1ERsSud8z/ypDt7/osVLw1ClrxJIKIgQJYNNyp31O0N/nb5RJ9bjwJpweqNt3lc+fRzCazYWD9M3bIti9fOycl7MxBoGZGMbJyrl/5FdVon0FwWiF5bI4LNye4vLCIfkuwznKi4Tx0NiLznogR0aciu2A0WiWya5WW5kY+pr7KlMPZ0hAheP3uYyrkNPSFxjEyosKxl9hI2SXWcyo4eo2cF6FgGCBKoXSQ9aiD53w5HP/k7kYMh/MnRPwhRli78ZFohitqqdyRrGhWPMSRHT/1oC8xiDzFgJjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Sat, 11 Mar
 2023 00:22:20 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.022; Sat, 11 Mar
 2023 00:22:20 +0000
Message-ID: <16e7fd97-49e4-0180-86bc-9dfd5bf90940@intel.com>
Date:   Fri, 10 Mar 2023 16:22:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [PATCH v2 18/18] x86/resctrl: Separate arch and fs resctrl locks
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-19-james.morse@arm.com>
 <d7d43c53-a482-100f-8a25-4dae6500d184@intel.com>
 <cc4eed18-1966-ebcf-8ae1-81b7e0833299@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cc4eed18-1966-ebcf-8ae1-81b7e0833299@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::9) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM6PR11MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: 8022a86e-c6a9-4e27-79d6-08db21c6ad45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9oKeIFhTlWtbTwwCvqVm4oXRVxYZL5g2bCDslZw5uOzN38uDJ7sVQ8HksXuQsZ30JIwuQeG1toytwvzu/pjaLZ8V/iCr/M9+ROQ2EHJ/8JgM91wqQZahefVi0tnrBnASMmxgRe/20EJMpHXTRsqRu1HhuSSNRrFhXECSLIZNY8mkxF17q29vqUM9CflpSXuukNnYMqMq3Az686MvB86MWftSAuc1AQAVZM4r2EID1Bgfy75HCsySRFnmt27t3VVQFu5y9TmrKk7IybVhkgwysYJ9/KLCtytT14AjsPa6ZAU+tbz0XhXwwfACxrlXWpuK8UvMHYopsjPQ6CE6+qMX08eblhR5TvFKQebTfbGRRF0tb09laxW+USWeAFYNdZ63nglKOiTMvdf03sd42C1qa3dNtqkyNICC6fzGFbpolsRtgEZvBxST6S3pXp1qrnM27A50qaQf1opnSaIgeFVs2GaZe+o6B3FpChK1Og4Xlft8hp6S1uA0jPIRetLriASPac8YlWaxApMZSxyVbv3CRFJd8ErrjEPGl5ROuHK5gX7dM4CV7RpCpUSJL/N9+teRIg1IhE/HSJUB5wC2aK96OKerdrobucFVTp7Fsar03U2qWxmTfTuX4PvTKPRPsClXt/A3MaxLn0FzB+TjkwjysUpkpXHOXp7jhBPZbuvdDZV0tRbyGUorv4Ujy1dCLeZH5q2c2siAKZYUWPxip86C/MR+QYSOQ16ILrLSgVHwrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199018)(36756003)(83380400001)(82960400001)(6666004)(6506007)(6512007)(53546011)(186003)(26005)(2616005)(6486002)(41300700001)(8676002)(66476007)(66556008)(8936002)(4326008)(31696002)(66946007)(86362001)(5660300002)(7416002)(2906002)(44832011)(316002)(38100700002)(478600001)(54906003)(66899018)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0JUNmoySWphMTljYlh2bnFWZlZhNSt4RWRLZXNLUW4xT2VYMFRnZXJGSXVk?=
 =?utf-8?B?Yk9kdjR3SjJITHhxSkhWU2VmaWdublRCcnd0Y1gxT090cW1JMHJSdDY5Rm5Y?=
 =?utf-8?B?YWVJdFFWTUxESnZvQzBwVFBBejAvLzZiNVdkK2M2L2pPSFVDbEJPcE91V0Qz?=
 =?utf-8?B?TVJPYzcxdzF3a1pNU1dJT3pueUgzS1ZSYm04cUZkbzM4MDJkbjZWdllQU3k5?=
 =?utf-8?B?bHFXZnZPZlVZMkJZbEdmVGtaM1ROMlRYdjNRUmN2NXFydHcwL2xheTBPZStV?=
 =?utf-8?B?T29aRmczSjBTWnRqL0Q1ZnB6Tjg0VHNja2NnVjh0SndTcXVGc2ppSllhQVRs?=
 =?utf-8?B?M3dRRHFyL0l4bU1WVTJJcFlqZkxpa2gwMVFjelc0eEdOeis2eW5OTk04elBs?=
 =?utf-8?B?M0MvOGpJQjZ6UzE4Uno4VGluOHR5VFBsc05ROGJGUFlYVGZUZTFLZEZzaUpo?=
 =?utf-8?B?WFhacHRzbzlXb1gvc3lpWlJGcDgxLzNpdnJsYTl1cDhINTNaSG12VG5hMnlU?=
 =?utf-8?B?dGNTVldwVS9RM24zYi82QXZweitBV0lkU29ya2djeThYaC9WRDNuZTJmSUpY?=
 =?utf-8?B?RFlkSjlyZEY2Z3NXMWo3YklaQXBmUTNKamVtNi81MXQ2M2h6MTVzYm1Ydkhi?=
 =?utf-8?B?T0RWSXpWYUlidHVGNVJVNGlPc3JWWndld0hrcWJWeGJvV002d0J3aTc3VFQ3?=
 =?utf-8?B?TDExZ1VONm1DdTAyd3k0UHFYSWRJVG5vRCtjZzF0V2ovMThNODdxRzNLM2x0?=
 =?utf-8?B?dlNKOFZaRXlWTHJYYVZ5YlNwc2F0a3NUdTUxQmdVWUFDTXBaNUhiemZTZTFq?=
 =?utf-8?B?THJTeUhDT1M4RC9rYzIxcUxEY0gvQ21OcUpORzYySXgvcjkrQit1SWV1VGha?=
 =?utf-8?B?RGpRY1NLcXY3Q2k2dnNNdW9Za0dkcUYrb3RIUU9NdEVqNUQ4Q0lTU29pUFNr?=
 =?utf-8?B?UGN6eUNLL243WmFnQnNVVUxkdzFQSUNhQVBwdU1PU3R4Y0U1cENia1V0d3BY?=
 =?utf-8?B?VmhCV1MzaHJBZWJGLzcybFZGeUFabDFGU05jakdET25icDZEMWNpcXA5b1F2?=
 =?utf-8?B?bm9KWklQSDlMaWhSWXI3SVpKUUI5YzZpMHQ1cjM1YjhFLys0UzJLV2w2QVRi?=
 =?utf-8?B?b1ozQ1pIQlAvUFpBTE1sdGR0Yk1haXZoRHFVbzY1Qk1kNHpOeXhSRGZKZG9L?=
 =?utf-8?B?ajdVcTZQcW9XUUZTNTdSaDN2Q0lZeGJoNGR1ZTAyT0FNNEs2Kzg1cUIrN1pw?=
 =?utf-8?B?VEcxc3hQVE45MlRmREppR2FBTlFuWnZGMDFrQytwUmpnTU04QnhPMGZjbFBQ?=
 =?utf-8?B?UUtLZHFRUTBtbnVsMFpVZ2dacW9aRFdGOGN0Q09mRkJUTmpoblBqZHFQSGdO?=
 =?utf-8?B?S1B6Z2gzYXg3YzJpdEM5VEk0UDlwOWFvd2RDOWpXZjZ1cTRnbS82RytQSkpq?=
 =?utf-8?B?ZG5Oc3FLSWRXOTJNRjhzRGMxS1VZdzBBbkNUc2lYT1JXOXU4OC9KN0dUaXZC?=
 =?utf-8?B?VFlXYkRNSVRWaHpkTWtBUGh1Y3NWYk1rNWtFenNKZExyYWt2RGpLaUZuUURZ?=
 =?utf-8?B?emNOWHVoL2VLN2VieHBMSlE0S0I0bTFuT2UvQ2pyK1VxWEZreHRWTmtjMkhZ?=
 =?utf-8?B?WlV0K25uYkFTaVhqeDhNUGF3NEtmY0t3R01xMUhLTFRWNDI5M2t6UlJQcVI4?=
 =?utf-8?B?d2ljOVBkWE1RY2ZQZHVIRWNUOFZTdFhSbEwrMEQwUm1pY2ZkWkxTMG5hK0tH?=
 =?utf-8?B?Uk5LYi8rN1VWVXhtYndPOFRlRHlYektVTXlHa1EwenF1N1FuQ05MU3pxcldz?=
 =?utf-8?B?SFQ5bGpBWmNqbFlEMnBlZy96dVRJam9FQ2tqNE5jQit0SWRDNVRkNzJLYzE2?=
 =?utf-8?B?YUpwTHdyV0tVV2ZvUHdHRSsybEZURzY5d3A2Y1ltaU9LeHZRa1o4b3FHeEc0?=
 =?utf-8?B?c2xRSy9ZbVJyZnhCNy9pR0pXUVduQ2s5MGRtZGV2WlQ5V1hpQytjc3VQQnhv?=
 =?utf-8?B?S0tOZy9KWlhYbXhUdkMreEw0RUlKWU01d1Ezb1JJeG93TVFUSFBGT1R0ZndD?=
 =?utf-8?B?Slg2eDhmdWI3TUxudG5NcnM3ZXUxTjNKeTVTTUNmSlpqTUlMRWE5aUhtK21M?=
 =?utf-8?B?bWhYVUs1V2o2THdaUHBLdFBXQ0lwZzYzTnZxVEc0MzZLR3JkeWwyU0U4a203?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8022a86e-c6a9-4e27-79d6-08db21c6ad45
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 00:22:20.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHdbfv2ksoeY5gzxMP7C7j2R3y8NgXcZydruMOHtGUabSnV05Co2EPCqGAqfNboFfIfAq7ydg4gKTCCiqxbk90hgOoYqGRu5KnKuWlJrUQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/6/2023 3:34 AM, James Morse wrote:
> Hi Reinette,
> 
> On 02/02/2023 23:50, Reinette Chatre wrote:
>> On 1/13/2023 9:54 AM, James Morse wrote:
>>> resctrl has one mutex that is taken by the architecture specific code,
>>> and the filesystem parts. The two interact via cpuhp, where the
>>> architecture code updates the domain list. Filesystem handlers that
>>> walk the domains list should not run concurrently with the cpuhp
>>> callback modifying the list.
>>>
>>> Exposing a lock from the filesystem code means the interface is not
>>> cleanly defined, and creates the possibility of cross-architecture
>>> lock ordering headaches. The interaction only exists so that certain
>>> filesystem paths are serialised against cpu hotplug. The cpu hotplug
>>> code already has a mechanism to do this using cpus_read_lock().
>>>
>>> MPAM's monitors have an overflow interrupt, so it needs to be possible
>>> to walk the domains list in irq context. RCU is ideal for this,
>>> but some paths need to be able to sleep to allocate memory.
>>>
>>> Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
>>> of a cpuhp callback, cpus_read_lock() must always be taken first.
>>> rdtgroup_schemata_write() already does this.
>>>
>>> All but one of the filesystem code's domain list walkers are
>>> currently protected by the rdtgroup_mutex taken in
>>> rdtgroup_kn_lock_live(). The exception is rdt_bit_usage_show()
>>> which takes the lock directly.
>>
>> The new BMEC code also. You can find it on tip's x86/cache branch,
>> see mbm_total_bytes_config_write() and mbm_local_bytes_config_write().
>>
>>>
>>> Make the domain list protected by RCU. An architecture-specific
>>> lock prevents concurrent writers. rdt_bit_usage_show() can
>>> walk the domain list under rcu_read_lock().
>>> The other filesystem list walkers need to be able to sleep.
>>> Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
>>> cpuhp callbacks can't be invoked when file system operations are
>>> occurring.
>>>
>>> Add lockdep_assert_cpus_held() in the cases where the
>>> rdtgroup_kn_lock_live() call isn't obvious.
>>>
>>> Resctrl's domain online/offline calls now need to take the
>>> rdtgroup_mutex themselves.
> 
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>> index 7896fcf11df6..dc1ba580c4db 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>> @@ -25,8 +25,14 @@
>>>  #include <asm/resctrl.h>
>>>  #include "internal.h"
>>>  
>>> -/* Mutex to protect rdtgroup access. */
>>> -DEFINE_MUTEX(rdtgroup_mutex);
>>> +/*
>>> + * rdt_domain structures are kfree()d when their last cpu goes offline,
>>> + * and allocated when the first cpu in a new domain comes online.
>>> + * The rdt_resource's domain list is updated when this happens. The domain
>>> + * list is protected by RCU, but callers can also take the cpus_read_lock()
>>> + * to prevent modification if they need to sleep. All writers take this mutex:
>>
>> Using "callers can" is not specific (compare to "callers should"). Please provide
>> clear guidance on how the locks should be used. Reader may wonder "why take cpus_read_lock()
>> to prevent modification, why not just take the mutex to prevent modification?"
> 
> 'if they need to sleep' is the answer to this. I think a certain amount of background
> knowledge can be assumed. My aim here wasn't to write an essay, but indicate not all
> readers do the same thing. This is already the case in resctrl, and the MPAM pmu stuff
> makes that worse.
> 
> Is this more robust:
> | * rdt_domain structures are kfree()d when their last cpu goes offline,
> | * and allocated when the first cpu in a new domain comes online.
> | * The rdt_resource's domain list is updated when this happens. Readers of
> | * the domain list must either take cpus_read_lock(), or rely on an RCU
> | * read-side critical section, to avoid observing concurrent modification.
> | * For information about RCU, see Docuemtation/RCU/rcu.rst.
> | * All writers take this mutex:
> 
> ?

Yes, I do think this is more robust. Since you do mention, "'if they need to sleep'
is the answer to this", how about "... must take cpus_read_lock() if they need to
sleep, or otherwise rely on an RCU read-side critical section, ..."? I do not
think it is necessary to provide a link to the documentation. If you do prefer
to keep it, please note the typo.

Also, please cpu -> CPU. 

>>> @@ -569,30 +579,27 @@ static void clear_closid_rmid(int cpu)
>>>  static int resctrl_arch_online_cpu(unsigned int cpu)
>>>  {
>>>  	struct rdt_resource *r;
>>> -	int err;
>>>  
>>> -	mutex_lock(&rdtgroup_mutex);
>>> +	mutex_lock(&domain_list_lock);
>>>  	for_each_capable_rdt_resource(r)
>>>  		domain_add_cpu(cpu, r);
>>>  	clear_closid_rmid(cpu);
>>> +	mutex_unlock(&domain_list_lock);
> 
>> Why is clear_closid_rmid(cpu) protected by mutex?
> 
> It doesn't need to be, its just an artefact of changing the lock, then moving the
> filesystem calls out. (its doesn't need to be protected by rdtgroup_mutex today).
> 
> If you don't think its churn, I'll move it to make it clearer.
> 

I do not see a problem with keeping the lock/unlock as before but
if you do find that you can make the locking clearer then
please do.

Reinette



