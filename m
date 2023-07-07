Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3085B74B8C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGGVnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGGVnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:43:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50B51FEA;
        Fri,  7 Jul 2023 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688766186; x=1720302186;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AhTRDiK0+SvCAleDwrkKDtV6Xi38W0xiR9E7RW8FeKE=;
  b=f4rr1gQH/bkSlfHtmVVsMc6V1Yt5yH8cxoHpX9G5HiFikek+Zpe1c90c
   zS2qrb+DouQCoqEZYKz316681evKKpF0vMaiSVuQOc3MU9fcut0L3Tlva
   yVLK5k1HD1BHRbObYRa82pIlBZizTZKjds2Sl1Q9QpFaQFT0mRnBu+uTi
   CL+pRVf3Sujp7N411fkXdwBDbUxCGS3epSgBLToyDFtvd32Uc5q+Q6NiJ
   r2O6gWIBXGhWifoLcPBBEBU+EbgNZn5HwAtywPEI8RQIVDYP7kvVOmgeN
   lH2uEwLqjqYnNKo24J0k2anxruJ/njfpdAKQwy6f/IMVTKh/bYqsdHOvb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="343576502"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="343576502"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 14:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="1050693546"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="1050693546"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2023 14:43:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 14:43:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 14:43:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 14:43:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDHW+pLf9fmT5jp0NqobU8562/S3qjEXhLuCK0E6r2fko2Jiv3RBi3nXE9zWqpNEy8HdEGAuaHmySN1gDoP0oBt7Qyy7cdRaqIsrnVElZwXtwPGN1yo4/DB11miZWfnSuKwgSIqk/rtPdCI7hbKGWy0VjrbEIgxd+TiqwTJLgWLffVe583+dkllC4mWGGHE1GmOCPPu7rxFGAIRC7xg7SDNlyTJ0milq5Mrny/oGZBilFJAgwuBtDZG5GTGi6X9AgpGj9pkaG1iWo/5r4a4gRrE1ldLccK5CiLh3V2YDYnMcWiU7+DeX38xa2hmzEfbL9BqLW00P8ylxZsM20C2zHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HVzzbT8/yP1YU4v3ZXU+iuN3mctjS/tEvlM/1gIBU4=;
 b=YC1TvqpwNZcHFoQXL1WautVNrkHN/N430Bt7Nji/Z+/dpVCHbt9J5IHVtyXOCvBvX9lFfNRnxDaya1eGwRtqsU5EJrOR9N7Y+q9YP4LZOOx2H+r+ZUNSTEgmjtFOdV4zUrnxWWq1a1N0oAaQQs42gi2BsUYk2lFIqHijY3Y+PjH6SuVpWmKygfeWr+OwYJZGgRyUufpdcXQE+lJgzRKovMVHZ5HAbist2W0PR89TI2VJcb3kLZ7ikpgEtBGXjkC6ZrOTt5nRba+evE7n2cvVn9JGzm9qGiJ/17DDPCw4XFWnXjjLJd+tNLx1Z182wklE8dQVeos9LMWPDJLR/4egHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8350.namprd11.prod.outlook.com (2603:10b6:806:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 21:43:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 21:43:02 +0000
Message-ID: <9821c0d4-4b4a-9720-52a9-b993f1118a91@intel.com>
Date:   Fri, 7 Jul 2023 14:42:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v5 5/8] x86/resctrl: Introduce "-o debug" mount option
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
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564610093.527584.3413729327027786408.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168564610093.527584.3413729327027786408.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:303:16d::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: c191f2ed-c7b1-471f-930c-08db7f3323ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uZOTTzajZzpWyXQ2UJs953ZNThQQupCVZiUMpFCBlEi2t5c9WtztsiQ51qE5cmpasC+bm/Tc2kcggjkdWPRaLssCRXPe5+vzvB4AGpT5MXvfdPG8fXe8lddBoDckajgrF7BzzNZUd0Jyzf/cq4movc53KvStSu7//FziV1Lmlk0SP2JNe27BtfJ03ECuk1/SKv7YIva70uo6jKsf3+mTHHnsD4XrN5EZ4sjSRc1KnKFuuiX2wSk72g/+kQQ/6P7vdD8IZgiP8JXkSiK/H0ruuIV6JOuihYVhQA7F5oJ2Jqf1bkWLuwfVT4jLO6jyVteGc6c3ZNOevK2Ws7IMg965/ZEKVljK2sRkYMhJKBHPeQWy7kzM9aOpO10m4BWcAl6cPOlUUs8eceS2r2Bs6OFhnXnKjJtv35EV5AfbrVcmm45UtVAM0BvUTsiJKExNTVlqCSCwoFg8p+j6nopLUqFgytpiY8NGxEFiryhsZ/qViILFCxwnSGFs5JtLjG7XpEjPOoKjvhBcH2vnk3Fad7eISWmIuHhhB99rAxlPYkHGSHEbx/6BHfsxWpP9V6j/FuqU02o0CD/jP2vLaBS2lXtgdNOukGyZ5Or2cuJkDuAxz/XpqR/8GxEIs/kY8tCXznXuYYCgVJhZereGw9anYvhDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(6666004)(478600001)(6486002)(53546011)(6506007)(26005)(6512007)(186003)(2906002)(41300700001)(66556008)(66476007)(4326008)(316002)(5660300002)(44832011)(7406005)(7416002)(8936002)(8676002)(66946007)(38100700002)(82960400001)(86362001)(31696002)(36756003)(2616005)(83380400001)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjBZc3ZIMmx0Qis1SkFGUE5iQUt3YWJwdGlQMlZSV3JjelJkZXdYYXJYODBT?=
 =?utf-8?B?K3NRMzBXYzlwT1c1ZC9FQnNRQU5WWnFsVEJ4cWxXRkRLbXhDeTVkWHUxZ0Jp?=
 =?utf-8?B?VGFJNzRjT21nQU9uOUY1ZmtLRTE3MTBiV210T3hZNmZRU0xlcHpKWGlxZm0x?=
 =?utf-8?B?QzA5ZFRlTmVKVkxKYllWcEN3V20rU2dHb2F6RXFhKzRBZExvQ3FzTXRabzZt?=
 =?utf-8?B?cU9zRENQOEt4djBHd3hGK1IrZmQwREx3eWlWTmxuaVJld2JPRXlyNXBYY2Vx?=
 =?utf-8?B?Z1cyM0NoaUhrVTl1bWU4MWhFN0p6UmdIb1ptTmhocGZMME1uK0ZjUk1ianVL?=
 =?utf-8?B?c2dTTCtEZ1FtZzMwaUY3SmVodlNiQU5teGE5N1lpUnA4eVVHV1RGSnBuRzBO?=
 =?utf-8?B?d3F5SlQzQnhtS3ZqQWZxd0lNeGVlWGlncTNsVkM0b05ZeDdOdCsyVHVkSCs4?=
 =?utf-8?B?OWFqeXBRTjhRTTJKdmxJS0NUQzBaYVlhOEJRVXlLUzZsdDFoUFdKbW5aWGxx?=
 =?utf-8?B?WTVBN3hwVEttYjNsRjA5NkFVZWRWOFJ0Z2E0MG42ZG5xcXZlRmpmTUxoV2Nx?=
 =?utf-8?B?OHd4NENNN0tXVHhvc2QyRHN4cGJsNkFZTXZhOUlCZENqcXBZdjl3YlRnS0V3?=
 =?utf-8?B?dHc4K2xIRE9oYVdGc0M5cUF6VzJzVzJWWFkxV3lYV205dmZlT3l3RlFENCtS?=
 =?utf-8?B?anhoRXdrbDEybm1ldklDS1BIdVBBbmgwbUs5OEcvVWVoL3M5UlFsM20rTDBm?=
 =?utf-8?B?R1BZdkZMU1ZLVTg3VVRwQjVuODllK3FQV0VDZ3pBS0RDcDZJSFQxREVMZlgy?=
 =?utf-8?B?U21RNTRReElDKytXTFRVWTdwakhLajhKcldldHJjQmswN2F0QmVmTXNYUmdQ?=
 =?utf-8?B?b1owVG41cU9aeEJaNjE0bHVFbTRUZVl5cWYrRTJudFl6WkRZT0MxaUdkTHJO?=
 =?utf-8?B?Y1dGNHNyb0NkZThoVms0L2tTNDYrUVBzbllhWXAwRVNQY1dvS1FRWlFyd0hz?=
 =?utf-8?B?YWlrUEh0UVRDSGZnanB5SWRXSjBNUHlUSWxKUTdaUFBEaUQydlNhWlZPU3lu?=
 =?utf-8?B?czlLTWo2bzRpaStuMmZyNTgrYTlXbnBXbldiNUErWkdsSERiOUxYL0VVcy8y?=
 =?utf-8?B?ZHVVN0lTbUxXS3l6Sm9HVmVLenhwclNTZ1Z5UDFvRjE5b0oyQmxRb2d4VU5k?=
 =?utf-8?B?Y1ZTNHRzMklvVldQZjB0SDB3OENZY0VDVTlyMGt4bzE4bVF1MWY5T1l4RjdW?=
 =?utf-8?B?NVlHekZKZCtjOGdham9PU1dqeUh2Wmx5NVNPMUVlSXdZcFUyaUNTbnBkOFM5?=
 =?utf-8?B?TzBYK3dXbDJGeG9YRFFqZ0UrcHRJdzdNbmcvTXhzK0lHeUFZSUc4aUE1RSts?=
 =?utf-8?B?cjBCSHpoaFJMT3JZb3Z1WEE1b1pMSTQ5UmJ4WmdZSU9iRHFnRUdVSnZobGMy?=
 =?utf-8?B?KzYxYVVyeks3ekozSE1xRGxSWmhybHlkalRDMFo2cXhtenc5dWJGWmJCTmV6?=
 =?utf-8?B?R21XelVGUEkzYzcxd01BN1JjRmNOeTVzNDJlV21Kcms5NFpqalZLT2hDKzJH?=
 =?utf-8?B?VExYNU9QUkkyd2xPMXBrUXhhODVqbEdLSlJsV3U5aFZScG8wcWxMajdudG10?=
 =?utf-8?B?R0tUQW1iYitnQzBna2I2cW9HN1lxRXJzajZVdGpoQ1VHdDVESTJLaDVBZ2Zr?=
 =?utf-8?B?SHhWSkJOTGJ2TXZORlhqc2RNTlUrOTRrQ0VHdEZTcS80RjhpOWU1SVhqSDMx?=
 =?utf-8?B?VHM3dU0rKzJwTDh0VXl2K3g2RWtJeGdjNHJMQ2duSGxZOXdmT0JyWkhpWE5P?=
 =?utf-8?B?QzFhdG52cCs3Um9XMVNQV3NVZ0NQdy84TTc4RmFTZDdYUE5HN29BaFExN2lN?=
 =?utf-8?B?d3krdWJKS21MS3VIVCtvVDRNSGdrZ09HMmcrdURhYVE1d1EzOUg5ME1zOXp3?=
 =?utf-8?B?bXVlQ0NlK3pjVmQvS1gxenJiS3p5U1lmRWhlbHljYjZEOGl5UnpDK2tTeXRw?=
 =?utf-8?B?U2JFdlh5aWMzdUFZb2Y5dzRRaGt1NW1ZbC9MeGM2Mzc3eTBDNzR2WDZMNGpR?=
 =?utf-8?B?d2gvdU9PdVp5L1piNG5reHMwVmlLMlJiM2hVS1J4d3FEdSszL3NnbUN6L3Jv?=
 =?utf-8?B?Y2VNakRhQ081U2RXZENjZ1BlSHFoQTdPTUM3UkMvODlwc0NMRE94Rmhyc3c3?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c191f2ed-c7b1-471f-930c-08db7f3323ba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 21:43:02.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J96r9lRs//dop8W8jwsMMt39cqIXnRaJgBfpkbB9BP2Ns9Hqoi30txdA+eMwMXeU6fFAZNr+ExG5c1SWG+3NiFFGQT6HFZusTZx225kGclw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8350
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 6/1/2023 12:01 PM, Babu Moger wrote:
> Add "-o debug" option to mount resctrl filesystem in debug mode.
> This option can be used for adding extra files to help debug
> resctrl issues.

Please avoid uncertainty in the changelog (re. "can be used"). I
think it will help to be more specific if the first and last
hunks of patch 8 is merged into this patch, making it clear
that the debug mount option is in support of debug files with
this changelog written to support that.

> For example, hardware uses CLOSID and RMIDs to control and monitor
> resctrl resources. These numbers are not visible to the user. These
> details can help to debug issues. Debug option provides a method to
> add these files to resctrl.

With the debug file support added here this extra motivation should
not be necessary (remaining hunks of patch 8 can be moved to where
these files are introduced).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/arch/x86/resctrl.rst     |    3 +++
>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   15 +++++++++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 290f01aa3002..afdee4d1f691 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -46,6 +46,9 @@ mount options are:
>  "mba_MBps":
>  	Enable the MBA Software Controller(mba_sc) to specify MBA
>  	bandwidth in MBps
> +"debug":
> +	Make debug files accessible. Available debug files are annotated with
> +	"Available only with debug option".
>  

At the risk of becoming unreadable, the earlier documentation of the mount
command should also change.

>  L2 and L3 CDP are controlled separately.
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c20cd6acb7a3..c07c6517d856 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -59,6 +59,7 @@ struct rdt_fs_context {
>  	bool				enable_cdpl2;
>  	bool				enable_cdpl3;
>  	bool				enable_mba_mbps;
> +	bool				enable_debug;
>  };
>  
>  static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index baed20b2d788..be91dea5f927 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -56,6 +56,8 @@ static char last_cmd_status_buf[512];
>  
>  struct dentry *debugfs_resctrl;
>  
> +static bool resctrl_debug;
> +
>  void rdt_last_cmd_clear(void)
>  {
>  	lockdep_assert_held(&rdtgroup_mutex);
> @@ -2368,6 +2370,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>  	if (!ret && ctx->enable_mba_mbps)
>  		ret = set_mba_sc(true);
>  
> +	if (!ret && ctx->enable_debug)
> +		resctrl_debug = true;
> +
>  	return ret;
>  }

Looks like unwinding of rdt_enable_ctx() errors is done in the caller, this is
not ideal and additions like above cause some error unwinding to be omitted.
I cannot see why rdt_enable_ctx() cannot do its own error unwinding. This
may be better as a separate patch.

Reinette

