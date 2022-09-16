Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F675BB10D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 18:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiIPQSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 12:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiIPQSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 12:18:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E033B600E;
        Fri, 16 Sep 2022 09:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663345093; x=1694881093;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YDVOokc5iXGEV4ShcLNxCrJHWlSLHy69qui48L9iM94=;
  b=IJVHQ4thpnE0itY1DdjkX24VwWLMK12m6tAyorXemewr2WjBcqJUJ4xm
   HEG2H/yMhiupZP7u5kIGZEBtaVYixDdmwQ0gfwm9x0KhBwuvUEYwbugdT
   Qnia7Hcs6A7Pg9e7k/0kS4swWa6qSAomDcBkEMk75ParroQa10ZAgbYLt
   HFUpFSt2twgBlVgDGE4kqY38fzH7fvphGkuMQjxHywIWza5oo6B7yQ6eI
   NJVr7vujaWC5rkYay2wLI1by4ZuuHSrDsv4aPB3j4pjPjpOMxZ/L5sGFw
   8O0GjhXNgJxMPSpgHpZVHTm6ZvaQkTPECSk58gHTv9a+K9pj1s4FZcsQv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="297748408"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="297748408"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 09:18:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="793143843"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 16 Sep 2022 09:18:06 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 09:18:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 09:18:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 09:18:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+uIDbWt1kEtHwrEhmgLzjJEZNMdtT5qMxlZTRRGYcOc14YoB+/UpFsbHfsXKBMFpy/UtT1+iV95GNjx5hj2CXseHp5yuehpjllxaHa86h2lZe8chKnZsRGn0L3at1YFCr4dgF/9yaowgJH9/P+34cgfZgzGTy8EErkgz2XtwTWrSrf5c0uU7XL5LUmUdDazcVNP+W6odOHlVRz/kVdKmDixY5vZ2hDELxaymgJKhJ199Q1iDIRyJ/hYn7QedlwojdbnMF9m9vgY+yw8iVZUxofee/Abv4wMVTDEfGrKsaIPMQhsma9Wmv/X/e5iNk3b6EHzAyluY7vF+9A/o9gfRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsaS8igGZN9a82sgIFDszAKaeyLMV8JLM9Iu27DgcL8=;
 b=eA0nXtNZMxxdeWmNY24WGLLRxK2RMUdIhS6DCo66t0l2LXqop0FlS3aF91F530LlDztWsEvFw+VsORm2WJ1BNUDykIFnkbSpe07vG67vWR20IQ89TlZV4165e4fMs1cxM+lGDNhzIvpKUdIx2klngNqJxcFZQ5hFx7+dfpDfFtFipCdB21BqnpyELMdaZOqeVLlJZjDzGB1PwJlKwETV+tG//IEZK1TTuXUg3UkmZns/x8a8Xr09sqCmDZN37G9c/6LTOQqboRplR3jwNZS5bRTUG90QX+4Mo4CWNBBCGbPcmHmvE2QpzNElRgjAaKmKXB0gG2NtIwt4f+B5kSLI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 16:17:58 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 16:17:58 +0000
Message-ID: <aa3cbecb-636f-cece-0c6f-97f67f060cdb@intel.com>
Date:   Fri, 16 Sep 2022 09:17:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 12/13] x86/resctrl: Replace smp_call_function_many with
 on_each_cpu_mask
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
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257368306.1043018.15116501631578530094.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166257368306.1043018.15116501631578530094.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SN7PR11MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e011be-3927-4e4a-7853-08da97ff04c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcLzD6Ltd3Ce8pWJVq3icfsrn2qNpsYn6w+6soylQca01Ub1boU9rjGxrhBVKS+cY7LDSF+Izk8YsrmuFZru47mnAHsup1M7W8KpdxCQwlDJLcWCNbTgn+KM0FHE4Riz7tijZOOlVv2lYdp9CvJC/DGF3nFtNVsRhln169QJ7oTrz2AJvSl5ohMZMlk1ni0tFf7VbfoyL9KiKDmmgn57wgDpHtuETllhd9STiuEtFZznVqoVZigBQmWoo3XZ7Mr/LaS+92A5/BON4ksxXqnT46PxxqN+DO2S80PwXuiMCuJViG3VveHlKxxoFxG5KlTr7hzlekJ+ZDDI4oP7TW6CVRz/uaLu+UvVRTqjxX2Eazry+/W9WqcbesfiPsjBTE9iIJG8yvLQPz7lfzUXmRy9/lKmP98rpPkCXWHlgM0uYl22KtT+CWOKdAK1xrmZckmSyyje5+UHOIdO2MmGz6lmqLNXPbkLRBP41maHIFhtXY7RXL8MRy/mJreBspVlU05sIn9yR7HmsZgu2q81ccbbn3RUCS2CRLErndMMsYTCAEx4pa24tddEDtryr2dqodWSaKzgC/JQAzzI+gQvewl3KZ/doNOBxKzCD0I4i8oE/ZTusFdhFhZB4xiMMWBfrEfTDuv2GbZ76JMS2a0SEg0ZcE46MWpisPpqrCDW2przFl3aq3AgKEHNWuCrC8L7hC6fniUrLGlvrcQ7mYb+1j6zukjRoLhFX0m4RMfMnRVJ+dKZUaxeL4SPOOf/FSJp7f9iDezyRTtB/F3GKBxTHp/lbiloGF/Jl2ZK1/FfHPmgghI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199015)(6666004)(66556008)(44832011)(38100700002)(7416002)(66476007)(478600001)(186003)(31686004)(8676002)(82960400001)(5660300002)(6486002)(36756003)(4326008)(26005)(4744005)(2906002)(8936002)(41300700001)(6506007)(2616005)(53546011)(86362001)(6512007)(316002)(66946007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azVFK205MVdUOUkyd0VUeHFwcmN4alpHckkvSjFrWC83K1BKQnNOd1dTUXI4?=
 =?utf-8?B?blN6M1hqNldGRlBjejNBMUJrZ25jVnNLTUprOUlpcmhWc25ac1B3K3FqanZF?=
 =?utf-8?B?SXVqWTFyM2M3Mm9YSTNkdFcxOHcwcXJuMjFiYnYzaysxdkkxNzN4ZlplWVpF?=
 =?utf-8?B?K0hPZ0ZFTkVQZXIxVnN4Y3FZSjR6UU80SUg2TG8rRC9HWSt6OWQwQnBEUEJ3?=
 =?utf-8?B?WVl0akNmL3YzeXkyZUU0Z1ZXWElQNy96cUZ4eXpSckNwaXkxRytmL1FOZ01L?=
 =?utf-8?B?TDNxSE1RbjF3bGVkaUE4Lzg1QUNIejZzUkU5bFpQVW5lakRCMDh4MDZrY1ky?=
 =?utf-8?B?UE5EcGpKTmJ6Nmp1ZkIwQW5jcDhUb2JwZjdLUGdRWFJGcjZiRlloMkJmSGxE?=
 =?utf-8?B?eDNEWFBReXpqVXZXNTg4L2h6OVVicFBsU0lLeWd2K1d1U1RvZVEzRkJsNEYv?=
 =?utf-8?B?dlBzVWdNUmZZdWUvOEdRVEcyc1prelZFcmgvSWRIQXcyL1UrSG8wN0JPcWpV?=
 =?utf-8?B?anY4aXZBSmxTS1AxRlU2T2dId3phWFhQblJLdlVNWGNHVWJOQXJMeFZuRmdC?=
 =?utf-8?B?dm5LL1dZY25SSXhuUkNjbXhzVGN5R24wWVFaUWJCVnlKeFVOREtnendtZUdW?=
 =?utf-8?B?d1pTQXdDYWVvdFFIRXV0TTFEMitPSU1TY0c4ckNtbnRtbWcrd1FLU2FEb2ZN?=
 =?utf-8?B?aHNDN0ZPZk5TTGcyNTZVMTJJMVJkTzgrcEQ5U3RKRlJNZHBJWHBJRURhUzNz?=
 =?utf-8?B?L0R1ek5ZQ2dFQVBldVFJaThWeUJVTWVyc3UyY2JiL2s4Z3RJYjl6TXBkQmh6?=
 =?utf-8?B?djhQbGw0SzJySjd0NWlxa2pkZGl6OGZ5SG5PbXpzQVh2azl1MisvMnZYS3cx?=
 =?utf-8?B?TlNNUUM2MEJuREdwTWY5Sy80ZXFiSVVMMkgzN3ZQRmVNSDZUc1Jlc09ldjdO?=
 =?utf-8?B?ZWxFZjdRWEQwa0JqeFhOQjE5TWRVdEJDbG9FWERNYmNqOElXYW1SaEp6VlMr?=
 =?utf-8?B?STZtWUs2ZXN4YWN1M3YvNjNsaG9mN0pseFdwMFE5QittTTlodCtud3JFbnBv?=
 =?utf-8?B?dTZ0VVMyeFFTdjZZT1BHLzZiMi9TOWx6NW1FWDQ2NTRlTHJEM09oWWEyN0dN?=
 =?utf-8?B?SnU4NWlxYlErZE5uWkQ2SDFzMXp1VjN4TWx5TkQ1VGNsbEt2OXZ6RXhQNzQ1?=
 =?utf-8?B?WGJxdkRETmNBVWcyT1ZJS2tuRDl6Zk9JaTY4TWQveE1WNE8ydVFoZ0NlbUZ6?=
 =?utf-8?B?Z1hnS0J4UFhxTG5ZQVhaY2QyVHZlSjg5czV5dm9wbFhqZlpRckZ6ZmxTVG1j?=
 =?utf-8?B?SmVzeUhSYjhPOWtLeDRRN2dsTWVPV3ViVy9TRzAxNi9tcU1TVEszQVVtRmx1?=
 =?utf-8?B?QTBlaU8zR3dDS1BFOFI5U05mRFc2OGJ2THJSWTluaVJzY0p1MkxpRFBHU1Y3?=
 =?utf-8?B?aXZqNTJYcEFQUVk1UWYvR2twckhxZHJtSUl2Y3VLSVpQaDlwY1ZLa0ZPUjRN?=
 =?utf-8?B?alVPN1JvbnB1ckJNcFhVM2I5Zk5FTnZzZjhuQVJZWUpqTWdYNFg4bGVYSDVQ?=
 =?utf-8?B?NklDbzM5VldZQytydmZKMUNrWS9sSXc5Z3oxRndyUGZBOHJMTkhZL01KR1pY?=
 =?utf-8?B?V21GVHJlYUdxQTFTUFM0dGh2WFMwTEh3SEREc2N2ZkpkR0N5NjB0Z2RUS3ZN?=
 =?utf-8?B?dEovRlJJMlQwWmJ1Q2Yyb0FjTTJ1Y1BNU2xiM3RYcERzOTBMWkJKYm0xbGVZ?=
 =?utf-8?B?WDA2ZUlzM05Lc1ZrVVVUeWlZcE5aeTBxSkNYNFJoMUQ2Z2RoRkI1dThPeDlG?=
 =?utf-8?B?K2s2NUxHcy8xTVdsYkdWSENJTldlckRGTWZ2RjJMYUNJWEYrdHM3UWRTblB4?=
 =?utf-8?B?VWZib0V0Ym15TFBPa25uSHdOVkpzcmhNOFA1Nk5oa3dScENsUGRFeUtlZXBl?=
 =?utf-8?B?djdsUjN0d2thMVhlaEx6aWJ5aE5xUG5Yd1V6NG5WV2hTaUlweG0wVDlCbVlQ?=
 =?utf-8?B?RC9penV3Mm9rZG9RdkMxeTAwdTRRWHV5THloRWs1WjJYTzJhK1k0cCtPTW96?=
 =?utf-8?B?L25UZnBLNmY5a2xJanB1U0VLaGNSb3RDQlgyWDFYVGJld3BKZlZkbWVDSDIr?=
 =?utf-8?B?bS9ZVThWbHRjTUZhNFFYN0VyalVCWGlIbzRta3ZLNXlzaUZ5L0txUGYxWHp1?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e011be-3927-4e4a-7853-08da97ff04c7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 16:17:58.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d53rZ8XDlT3m6c4bWBme3K5BhAwLiVQRFlS6jkEC99v2pO2lQFjxQPSmYUZ/WYCUL5CMURbt+P5viZdjLelOTFvNQYMYhY5ZQJCLDeSZWNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/7/2022 11:01 AM, Babu Moger wrote:
> The call on_each_cpu_mask can run the function on each CPU specified by

parenthesis are used to indicate functions, in this case, please write
"on_each_cpu_mask()" and "smp_call_function_many()" instead.

> cpumask, which may include the local processor. So, replace the call
> smp_call_function_many with on_each_cpu_mask to simplify the code.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reinette
