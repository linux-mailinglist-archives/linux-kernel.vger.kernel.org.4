Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A62698780
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBOVrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBOVrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:47:15 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E6FE06F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676497634; x=1708033634;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oj1bw71PYeLkmYTebgOxDfB7bOfhVieYNVUIM5fFOAM=;
  b=kBXnAfR+pVfd+eeT2enOmNF1CMm5b0Cm7x1cMeGhRbvlyQS66pz/n9s+
   rGecXcw3leMTkXTYOWY0hS9sXC/7HS2vcjtTqnPZ3A1gKc7TzjH9Lvzn5
   k3jkWV2u45ykxRNLLVWtZtTD3zpwlnj1Vm4dG21sJgzXFdcw3AgomsrIC
   mHMaNulA5AOp4MfVtTUc40Si7nFHobOUkELFgNsfvmKsfWKR9vgHlE/Gj
   GLMJZkJimldfNrYC6Yw+2piDZHbjrROGmQTiRWwC1P78VgA4Ubsmh1QQa
   6foLM8gHMkg6nhArf5Iq+fwFKL4plCW4s5//Zh4hoivGf9oaT95FVmA9t
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="329273351"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="329273351"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 13:47:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="915398921"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="915398921"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 15 Feb 2023 13:47:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 13:47:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 15 Feb 2023 13:47:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 15 Feb 2023 13:47:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grdxZuF5H1LjmWEilSyS0JJ244qfPU8GtMEaud4jInio42LU1uyqYniFMROa/Rjg0YOZLJY5TsZCr2M9xL6KPD2r+ag3P3enZ3OPZ2vgQXjMZUduLst1msfrUTGgKh0HxUU8gJwXREQiBj3iIXSVTmQH6lyNovVQ2tnNLXs0SuL/3zcZ0J0C5YkC5bretwuUFUWdE/3CvAb9sDnB43ONJHwX1hzF8Ya/M8QitjuKZF5+ar7fRuQLAGKaBKbqRt3HPVpO2zZXjit7OLVGf3a9eYcb4aiYPr2IxIHxBokze0BqyLGi5APiYZedcw6nRVNB3AHF8p5ebPkdxM9DwhyKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrhHsR5MNhrP5u6O6tTcP5/zqteSEHjiFeagUmgXTCE=;
 b=dyY748djUZFGpdcSwNDzI+XVt/4pGOT2ic7MqoCQSuVmATlhyuYqmnujnaksiSPFcB9rQlR1AoeG/vt5HNOebS5QR/YT6dRwm4sjT2FZxLi3Bz81Oc3crux7lgE+bTn36ku+TmIaVan1QAKKSmZlvyaGQ7gVtjGuUn0Dv7WXZ52IFy1aN4yJ2z+BxD52BnL1kTbUfHwiAGCuTtwAIF4+tWbzAk84HbM/kjfCrLtHncisomFTeN3O+9vlu01/Na7DsW0vqnLGXJN6SaHqYJT/cSwqRPNfGKg9BKsSxWdQXMV/63AvdxehJ5/pAjDOzqJTNiUyqs4sAi2pwBssSl1isw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA1PR11MB7270.namprd11.prod.outlook.com (2603:10b6:208:42a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 21:47:10 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.026; Wed, 15 Feb
 2023 21:47:10 +0000
Message-ID: <95fca7d1-d473-e9e2-b6c8-c4ae3d44d2df@intel.com>
Date:   Wed, 15 Feb 2023 13:43:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [PATCH] x86/resctrl: Only show tasks' pids in current pid
 namespace
Content-Language: en-US
To:     Shawn Wang <shawnwang@linux.alibaba.com>, <fenghua.yu@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <james.morse@arm.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <20230116071246.97717-1-shawnwang@linux.alibaba.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230116071246.97717-1-shawnwang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA1PR11MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 910096b2-7c3a-4488-4458-08db0f9e3092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCK7rzl5+8UdNhKc8I+ilh0xErnFoCJYhI8bxLggNcybcCZHaPZc3S5W8j63s/2t/gP8jGe0CMRS7vwzx667ReZkapQVmS5YVxZQ39D16yOxzbofFOZqZ7ItcHVSw7osF4ZV/ES5GNrlDkWc7Andb06fDweo9tGqOjWVa3lLPnYSuGr4n4MoIva0c68IPHFMmubOypRe+DruxJOZkSOg+5yGIp72pMHxYqdmqiDVu60cDbWnZlSHQt+kWmXXPHoerMW9VjITGocXKdlB8BOhZ7roHwtm65Ydnpw33mECjxZgRVV1JsiSdjqMAxS6r4RZULLYueMhiamzJN2jQG++AgQhMvpqPegI2G1+SK2Xx60VdDeDLMwPUWwbSy+ggrNFz6GuOtSk1XS/DaEnymjJBskqma+PIY9k9uzuzGbD2HadZsnOJJIe1xowEro09t59rJAZ1ZY+8B4jtvaJF2rVE3zW9DZEVBC7ihQ229rdJtBdw5whW0ZmsihDsDoOEGDIPpwcIqf9kVDfcRrKfPn0WN6vNTXVR07d76VIFtaP59U2Ns8MqZrkMQW1Wm3tNl90HoPocvPS/6iGM74y+jr/GxLzzjHffZPfSWSyxW56YS4oiNFyRb9gn+Ad2Gujw9lvCExmcEjpIO/+jPEPSuZXar8U3KIitRYn76SdKlNMB52hkVvUemb1SMiMi0KVo0CP63yKeqXnlF4eWpIt+V57Z6ZHKKqvOmk4Q8cbd91mBbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199018)(6636002)(316002)(478600001)(6486002)(31686004)(31696002)(86362001)(38100700002)(82960400001)(2616005)(36756003)(53546011)(83380400001)(26005)(6666004)(186003)(6512007)(6506007)(41300700001)(2906002)(5660300002)(8936002)(4326008)(66946007)(8676002)(66556008)(66476007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0RqajVZVUovVVY1cm5OSTRQRFJMeVd2d3EzOUJZZkxqeFN5cSttUUFYQzV4?=
 =?utf-8?B?d2ltU2w5WDNDS00vV25HNG1NOVhpNmR3YkxLWFdNMktHVjJ4YzRrMVByQXR3?=
 =?utf-8?B?aUxCbWtrenJqbnFpQVhrOXp0SEpoWVJ4UTVSNlh6djdHQnZFTExzTG9JUk5R?=
 =?utf-8?B?SDVLc0JQbE8wSUZWNC9FbzJPQllNbTVueTIxUVMyZzdhMDFBTVJyTjZSWms3?=
 =?utf-8?B?Mm1JdkJKcmpyYVNpSWFmZVltaWVyZHNQRTMycW5EZ2xSZmJ4VVo3NWl4elNM?=
 =?utf-8?B?aER4V2pNVkw3dzVGMU80b2NGUERoRDNhanErL2FpdThSbmQ2S0xEYWp5TTB0?=
 =?utf-8?B?Qjh5Ri9PUmlLeFJUL0ZlbmUyUGRyaHJISS8wd3J1ck91NTZXOTE2UDlFRDZm?=
 =?utf-8?B?VFRJS0kxK1dhSXU3OFF6NDV3NER1bW1kUnFaMHlualV5dm1kNnJLTzRYeFJ3?=
 =?utf-8?B?RHAyT2lkcXRwcHFuSDRCbkdxNWlmRlMySDNFeHRNRXhmdkVsT0wvb09LMVNH?=
 =?utf-8?B?a2NWR1I1LzZaeHZpTzZjWmtmc1ljcFVBMjB3cmQ1dlFtZXZTYWw4ckkzMUE2?=
 =?utf-8?B?RlpXMXA1UTMxQTllbjA2eVU3eXlGTnRaS3FReEV1YlN2cVdhK1NXRU1pSmEx?=
 =?utf-8?B?dENMSkc2aU5kZDRqWjcvWkJKUlI5NkVNcXFiZUZySFgvek5KMWtRZDJMb3JC?=
 =?utf-8?B?UGFVR1JvcDBBNEh4VmovQXlNcWRiMkdIcmhzbGNGOTBFbHA2ekJVdXpFZ1Zp?=
 =?utf-8?B?TFhUNUpSQ29TakJIdFAxdVZjUU9BUDNIYnNnbi91YkR6TUN6OE9XbkdDazVi?=
 =?utf-8?B?M3dIdXVGVjh4NmR3ZFBJclBrM1R5WGtneGVKbkI0UkRxQWpWejdVbm1oVVpF?=
 =?utf-8?B?YTZHS0g1OU11VXBjV3JjNTNUQWIrQUVzOFR2V2x1aDBxSis4NE1URWlkOWJn?=
 =?utf-8?B?MzNXaUVDVVZVd3lSNlVuc1B1TS90UkNyS3pLYi9MMTVOMTJnOXlnNDA2K2FP?=
 =?utf-8?B?MmR5eVJBd2xmaUFxekVJV2I1MkJmUEg4b2F5aXhzTU1uUEora0p4d1grempN?=
 =?utf-8?B?aEVMRHViSlYyMHRLc0g0QVNyQVpRcG9ZaVNRaVdkRlZ1Tm1Eb3lPN1QxRHAz?=
 =?utf-8?B?ZHMyMmFLbWNDTWNSVnNEQlNKMlFnNnJCSlNVWUFpRFpzbnAyRXNBTHZIRVdM?=
 =?utf-8?B?eXA0RmtXdDlLMEpTT2ZtU3lKbzBPblhWZ0VxcVYvcjlDd09NRmJvdFhQRUhL?=
 =?utf-8?B?UlBlVnZYSk5XYjhIL0gvbkQ0NHdFanVwNDVkMnFyMXdQZ0ErQ2pRL281SDhh?=
 =?utf-8?B?ZHRaZnloZkJKWEJQUGMvUFdWZWV5T2xFeWFCVDF4bXBiOEdHc20zdXJLbTlV?=
 =?utf-8?B?N1JDdmI3bjZjbmdqQnRUN3lsL1NjUmF3NU9ocVgxOFkyL1RXc2Q0VFNncy9R?=
 =?utf-8?B?Wm1YR0ZiK2R0alFEQzlWTytGWUIvc1BMRVpQajk0VDNZVHlPcFVjOFlIWlBE?=
 =?utf-8?B?WlFocTJ2cE1jbFpBN05ITTNzM0dRYnp5TFgwb1AyUTdIeURseFViSEViZ2d4?=
 =?utf-8?B?Q0o1K2JCa0R4U21tQmFZR1JmTkNrOEVNaFFRSkRuLzlLbm1SOXRLdGNTYk96?=
 =?utf-8?B?R2hvWWZhY1pHUUtuOGRvdHgzRm04bFp0NVZYRWt2OHJhQXVVWXZFL2QyWFVV?=
 =?utf-8?B?QjJuK3p3YlFJNlVqR1ZxNS8yQUNmTlo5SkxYRDBWM3FlaVJjQU5XV3B3UmJO?=
 =?utf-8?B?V3VhYjM1MHRBMlVadCtqR2I2SDRoRDdQR1VhYVZ0Z1ZCaVZCY0lGK1VDYUZ4?=
 =?utf-8?B?MFBZcTNSUk1YVlpxbktXbC8zRlM2bEZCTnVKeUpKVjZIWUd6S3YwMGpod0w3?=
 =?utf-8?B?aVR4QUQwQU1aNmI0dEdmZFd2aVJWVkpPU3BUVWZnOUFrdTVIVVVmb0RzVWJI?=
 =?utf-8?B?emcxSTlsS0NHNkxoenZ5cUQyMnlQQ0NTd2ZHNEVDZWd6ZUNDTkRtNTZhcmNt?=
 =?utf-8?B?eUVKOU5oc0Rnc2tjUmlmTnNOSkhOZWNEdU12MllDOWFFM21KblpzKytzSHVP?=
 =?utf-8?B?RGNsR0lYOWFUQUVHaC90ZVFIaTVjQ0dYdzQxdkxwdCs3b3U3QTNzclg3aEFn?=
 =?utf-8?B?OENnbjJpSjJNWm9ETzNzVi9MSnBOcmZzeUo2aXhRbHE1V1pkbkdleWRGWjdw?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 910096b2-7c3a-4488-4458-08db0f9e3092
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 21:47:10.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExYlVy4skyHp7dN3SDKdnX0KuUXyPC4ifBGreIwroKmIxvlJkMCZl1tS8WbVY0ZGEHHYNP1Wh+k1XTzzbCW9VaEq7yBLEJE+wb5N3h6m+Jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7270
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

Hi Shawn,

On 1/15/2023 11:12 PM, Shawn Wang wrote:
> When writing a task id to the "tasks" file in an rdtgroup,
> rdtgroup_tasks_write() treats the pid as a number in the current pid
> namespace. But when reading the "tasks" file, rdtgroup_tasks_show() shows
> the list of global pids from the init namespace. If current pid namespace
> is not the init namespace, pids in "tasks" will be confusing and incorrect.
> 
> To be more robust, let the "tasks" file only show pids in the current pid
> namespace.
> 

Is it possible to elaborate more on the use case that this is aiming to
address? It is unexpected to me that resource management is approached from
within a container. My expectation is that the resource management and monitoring
is done from the host. 

> Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5993da21d822..9e97ae24c159 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -718,11 +718,15 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>  static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
>  {
>  	struct task_struct *p, *t;
> +	pid_t pid;
>  
>  	rcu_read_lock();
>  	for_each_process_thread(p, t) {
> -		if (is_closid_match(t, r) || is_rmid_match(t, r))
> -			seq_printf(s, "%d\n", t->pid);
> +		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
> +			pid = task_pid_vnr(t);
> +			if (pid)
> +				seq_printf(s, "%d\n", pid);
> +		}
>  	}
>  	rcu_read_unlock();
>  }

This looks like it would solve the stated problem. Does it slow down
reading a tasks file in a measurable way?

Reinette

