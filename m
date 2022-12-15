Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7090E64DF77
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiLOROF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLORNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:13:54 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F2E122;
        Thu, 15 Dec 2022 09:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671124433; x=1702660433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zaG2s5IXG5P5UncO34MsKITBCPCp6TkLxNhCuURE+/o=;
  b=GZk2mU8sa47ROwJqBi9cKpHMnP9x+qk5Uy90hCX9TJCf4ZJxx0KXZsf6
   BXO1PaNOVp8yPdsmO/pXGyL5X6UheM5L/fH/C3S5LRldl2bcZQOHK1iHR
   HUJvOf489ATJMV+eJmMoAGSvYM2BNgzhayWfaOKGJFNmx/e8oWvEHhbHI
   iCbLrcXGaVQUNEUa3j4+SSQKiWF2V4119RNxHlIDhxjQoIKhFycOV59D2
   Elugb4NP89f/NHzhm/pcmOn2JtbbhGF5V9x6XWrsE/oJB4OkN56PMsg5j
   A+6WrQrca65qGtnJLGBgZBwJlZgTGAwJzLDNBNVGlitGt0bimpllv8cDY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="318787510"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="318787510"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:11:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="823786316"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="823786316"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2022 09:11:38 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:11:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:11:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 09:11:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPfRkC4DVAe77KAY5xTCPPi0tGTZyMOnVxEKlnmHLIl39xIefktNrm1g1SQA6KVQV4T7BEShww5Z/WNDGZd6aKEhUtSwPxAqOVLILROv2P1TnPAZUckXsBsJPHzs7Y9ML0g2GsHIua7bcP2SWA6VbQOg0cSK1bEx8TIuQQe/ci8jyhyFroE4apiCjCGptfw1t2lS3NirmnRNgkWCvSnfQiOZW8HcSiNcBfV4VmEa6JLvmmqruKpPtIvFNXF7+DMCmLvivLtwttIBqAe9Wo8aJ8LRD00w6uf40Udw1HhkiTkpdVe9EQm+50KoPc0VxRREZR/xVCovJ+STGfwnhp1HUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hmw03nLDAlEjT0ntrqk/QJVvJ3kW3HztvQ2u8QDaCgU=;
 b=blrZ3RAfxXLYbF5+O7DhqDsW4R0jWDzyXUcUuCyZtebn7Ma+S865NscuvHl7J17s03yx6/dPL1CIMSknToszi71XOaa21FWtd5O5bVQ4xb7549LZAFieYmIbYom8NQ8XB8fyrEdlq0Sdpww5WzRtmgXVnYSv4yX7hj/l+ZNKpM5QxhyTBnHqz5DQcCS7OIBipu7QUldZzO/KwY8omkZVXJ8fKjCpZZGbLpEr9G8oFCNiVhiCO5D70BYA8pFVJ8x93UDNTFeMzUf1lH9s+mWpFWwI4DPMo0ykMtmpAaG/MBZxZN2QdvItge/iT4UVoj1ZmUEMrBVMZQc7apbNzPSwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH0PR11MB5329.namprd11.prod.outlook.com (2603:10b6:610:bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 17:11:31 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 17:11:31 +0000
Message-ID: <b5c6c0c2-6ec7-a01e-75cb-113324298324@intel.com>
Date:   Thu, 15 Dec 2022 09:11:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 03/13] x86/cpufeatures: Add Bandwidth Monitoring Event
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
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990897968.17806.16187773270520553795.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990897968.17806.16187773270520553795.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0056.prod.exchangelabs.com (2603:10b6:a03:94::33)
 To CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH0PR11MB5329:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9de2ae-013c-46ca-9fd7-08dadebf6949
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/C3KLXqn8UEZ9LkMTkRAu9+b5z3eFkyS7pKT6NhQZ9hVyJ3e4SS3ejnVheMCr6EyzKhLXBi1QKVljmQY4A8rIlWh+kHU4c8u/PXQkeLNbr1jf/PjBTQjXY/vcohljypW/394bFuh9gVNPMnTvokoB79mZaGDyxy0BZoqmHEclwBcjzeI4irOm0FHPPWfccaHSP/EmuW0fjQG3Oqt7EAl17aVYXvvtSDbgChdBsY5MZ1hjA/TZ0I85um8/f6FJtFSMITbMLMA1mfADkXsyRcz4zTgJll0rEVuYzrk+gJxmx2a1byQAvEiFx9MOxrlKGE8B1GkTmaV8ePZFbSrzMBhhduw96JWtrt3xJzbxj+RrUzmYOdmmOZ0Z1MJl7nRzExM1AtEGJt/sJBFa9XlrjrPnDYb0RunM57ZNlrmggtOUtmF8aR0pkxsyFy/ET7kp7qkGAZKYQEURBEnibXiuCpZgeWwdBqemUF0B9ef/9afovBbcdoCtFe3aOTMfN/4QJQF68R1OFILJh+A/5USrwGxrWCTn8Tl9GDmQNMCKLRRzGyd3nNNRz+C+2WyTl/cQ+UORHW2x+p4K1crVV3pq2do0h2ErRIfVeB/68GcZAO4YI+q4ophiPtv/0sT45S79mQ+h6hCr3K/qwksLhke16c4eQjsSq5uFBTuSH82n0rUlVOFMADNZwpif5bK4v9V7p1VyDoK0OE53i1kMVIlxqaEjMjRmnXu5LXX396JIBNv/y6xsts9cCz8oybTgum5aSM2V87gWJ9Rxe7aJtu1oJAZPRu/3sHPox/0irIihDs9sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199015)(2616005)(82960400001)(31696002)(83380400001)(38100700002)(86362001)(5660300002)(2906002)(44832011)(8936002)(7406005)(7416002)(4326008)(41300700001)(26005)(6512007)(6486002)(966005)(6666004)(53546011)(478600001)(66476007)(66946007)(8676002)(66556008)(6506007)(186003)(316002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azhoSzI0TWZ4THBKSlNZWW9aV2w1WWZWVXhMckpBWnY1ek44VzV0ejFTYkVK?=
 =?utf-8?B?VUFLYnl4cTVvQUlqWFRmWnFIMGlOWndya3RSOXB6c3gzVEJHNDR2QXNuV2xm?=
 =?utf-8?B?Y2U4bnJJTm1rbHlrdnBjcjR6SE9mbUpLcjMwM2dTS3dLS01ySEFnOTY5VTJN?=
 =?utf-8?B?TzRKeXpSUmxGN1R1Uks0cHREOTBZbUhUUVJFTTcvOFhZSzFQTlhrdmJkclo0?=
 =?utf-8?B?L08zMytuTmRWaWZibjFMZlFmeDM5UmVZNWo0TzRiSlIzMFEzS2htQUgxdThI?=
 =?utf-8?B?T2I1OUxVcnI4czlEek1BVU0ycVVlMkdNZ3ZBTlVCSXBGSjNsOWFmZWY2RDYr?=
 =?utf-8?B?ckMwWXpnNG5CUUFnM01NLy80M0xYb2xkMlZzNktVZkR3Tm94SmxZQzdXM1gx?=
 =?utf-8?B?OUhkLzhhelJzUXRxK1lFVzFiS1FHMDNwanBGWDZMZHl3cW1pUU9Pc2llV1FC?=
 =?utf-8?B?UW53RFp5cHJOaHQxa2l0UXdzQTBCSzNZMWtZbHUzai95NUNaalowSXlMVnVB?=
 =?utf-8?B?M2R5ZDVTOE5GelRCZVpiRHc4OWJpclJ6WGtjV2tNSUhKOFE0a0xnVGw1Z1hz?=
 =?utf-8?B?QzZGU2JIY09aM3BPdU90dkt2d2o2Z2lqTTlHTUF4L1Z2bXRJT3AzK0RNaUR6?=
 =?utf-8?B?NTEvNGFvU2U5YnBBZTgyVXI1Q3ZHZnNidk9hRFluUmVodm5qYnBtelB0akt2?=
 =?utf-8?B?L1g0S0VTYW1sdm1ZT2J4SmJaMnZvN2xWbDgzMTBqWmRxU2oxcjBncTZleHI4?=
 =?utf-8?B?dnVnRzRDWUk2OXdRMUdOem50UFd5V1lBY2w3cWpyN0NzM0dkcjkxbjVvS2ds?=
 =?utf-8?B?eGErOGFuTEdFVTRXSjE4S1h2djd3UUc3VU5OdWYvbjF6MkNISWNTSFpwd2Va?=
 =?utf-8?B?Q0k5M1JNS1pqSkFKd3g4eVo0aUgxWFo1WDl3UExJTDZWSzdhRGQ2TGloY0s3?=
 =?utf-8?B?SHNKcWROYlNwWVpNZjNwTU9BRDJtMnRtRmxqYTBGdzBvd1NZVWhJZ3FjTG5i?=
 =?utf-8?B?WWdtRzBacG50T2JtalBFNHJzcjRoclFud3RyeEdYR01La2JqMWtpQW1JLy84?=
 =?utf-8?B?bjBpbDF6MU16cFhKWlBkMWptSEY5OHdmVU9UQndoc0I3c0tHQlo3aDVPbTRJ?=
 =?utf-8?B?UEhXbUJZYTZLYjBsRk5YU295dTAvVWVkUTFtWVlYTGxpVmJURytpeVBoWG81?=
 =?utf-8?B?aWRsWVhUWWhIZGhQeGs2TDZWK1gzbnRWeHRteCtDT3E1RHNpdk9tSndrZkFr?=
 =?utf-8?B?N21kdUdmbHh0TWp3OHFTdzNIaDE2UERnYjJFazN6bnBwRElBc0YwelQ5N1hy?=
 =?utf-8?B?dFdIa004U3BVK2g5eFlEREE1VGxVa0RRbThpY1JoZEZHUTNOMERvcHpCN0lu?=
 =?utf-8?B?ekxnTm1NZ05RQUJKRUF3MTduY0p2aVM5U09ocVFIZzFXVzUyZE11MStlbDZZ?=
 =?utf-8?B?ODVlcXRWSzl3Qkw5WmRpbUN2WHVsUWhkd0Z4VFFSR0VYNVY3aWlLV1BHbzM4?=
 =?utf-8?B?bEVxKzJFMENkQmJQSDJQMWprWjZsUVNzSStkZ1JqbzhRME54RmZteE9YWWRu?=
 =?utf-8?B?SkpQT0J3N1RDS0xwZS9lSW1WK0x6WmFoOFhYNEpOenFqM0JDM01ZUmRDK3Bq?=
 =?utf-8?B?RTRqMlliQmZISGpUaXlyZGw4Mzc4Q0U1amltbXd6U1dsY05aTmN6M2NJN0hM?=
 =?utf-8?B?M3QvTmdJZGFvazdLVDRFa0x3TGptY2ZvbHhOV3RaWXN1ZUdkOHZwd1V2c2Rq?=
 =?utf-8?B?VzYzbnRLSWE5SjMyeG5UcHdOUDRTRC9KY2k3K0ZZN1NWZVJKNmxJSVB1c2F5?=
 =?utf-8?B?bWdxa3N3WDg4S2lnVWF0SHR4WWZkYU51dVRlSGE1a3VNUnc1UmUrNUxVOVVR?=
 =?utf-8?B?VWNySEIyY2dEKzdFSFlDUnJkdzNCb01BQWRoL2I2RFFjVnhpQ29TbmliSkgz?=
 =?utf-8?B?TVlrVlJ5c08rVVhtQlhpb0UzYzNISGcxRU1aaHk0dUMwSkhCVXFDN2ZPYjZq?=
 =?utf-8?B?SDhqNVFlK2RPZjhXNVE1QTJpQWhxVHBpYnlvNDJ2NStTLzhYWEkrVUFvVlhs?=
 =?utf-8?B?MHNUYTNyQTliQnNPMW9sYW5INzUvVDIxcDdqWDhmWm9iWUxMWVBWakkwS2Yv?=
 =?utf-8?B?Y1dZLzZQRDZyYmV0WWtIOGczcDVqdmgvRjZSb0dOaGlVQktISDZUR294NCtS?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9de2ae-013c-46ca-9fd7-08dadebf6949
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:11:31.5867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wysy2hr7WXz9/aL/X0bty8thvFdGVDFLbgFWgxkUrU+ovvi3WCGI1OU3/W2NjT3giT+MsAg1Wboual5HwpeTSb1a1+mVsnUSJipxTkMqh98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5329
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/1/2022 7:36 AM, Babu Moger wrote:
> Newer AMD processors support the new feature Bandwidth Monitoring Event
> Configuration (BMEC).
> 
> The feature support is identified via CPUID Fn8000_0020_EBX_x0 (ECX=0).
> Bits    Field Name    Description
> 3       EVT_CFG       Bandwidth Monitoring Event Configuration (BMEC)
> 
> Currently, the bandwidth monitoring events mbm_total_bytes and

Please drop "Currently,".

> mbm_local_bytes are set to count all the total and local reads/writes
> respectively. With the introduction of slow memory, the two counters
> are not enough to count all the different types of memory events. With
> the feature BMEC, the users have the option to configure
> mbm_total_bytes and mbm_local_bytes to count the specific type of
> events.
> 
> Each BMEC event has a configuration MSR, which contains one field for
> each bandwidth type that can be used to configure the bandwidth event
> to track any combination of supported bandwidth types. The event will
> count requests from every bandwidth type bit that is set in the
> corresponding configuration register.
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

Missing end quote above.

> 
> Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Same comment about "Link:" ordering as for patch 1.

> ---
>  arch/x86/include/asm/cpufeatures.h |    1 +
>  arch/x86/kernel/cpu/cpuid-deps.c   |    2 ++
>  arch/x86/kernel/cpu/scattered.c    |    1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index b6a45e56cd0c..415796d7b309 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -308,6 +308,7 @@
>  #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
>  #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
>  #define X86_FEATURE_SMBA		(11*32+21) /* Slow Memory Bandwidth Allocation */
> +#define X86_FEATURE_BMEC		(11*32+22) /* Bandwidth Monitoring Event Configuration */
>  
>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index d95221117129..f6748c8bd647 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -68,6 +68,8 @@ static const struct cpuid_dep cpuid_deps[] = {
>  	{ X86_FEATURE_CQM_OCCUP_LLC,		X86_FEATURE_CQM_LLC   },
>  	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },
>  	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
> +	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_TOTAL   },
> +	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_LOCAL   },
>  	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
>  	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
>  	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index d925753084fb..0dad49a09b7a 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -46,6 +46,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
>  	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
>  	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
> +	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>  	{ 0, 0, 0, 0, 0 }
> 
> 

With changelog comments addressed:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
