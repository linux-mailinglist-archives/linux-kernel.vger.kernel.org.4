Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E96636D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiKWW2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiKWW2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:28:03 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6404B1C105;
        Wed, 23 Nov 2022 14:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669242482; x=1700778482;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CUhuVsM3tboxVXgTVArLN9Bw3LTl6nZzdl66Fh7tdQM=;
  b=cpcFhCGmYIkNA1Cw79rZqbrJ/9crRbV56W2W/NCuc0ujbVx/aECw8JOH
   X/+5WrBojfyeo/g7Bf8fUXAOGHW493ljm/j+uZWTLhIoGYFXJdgATNCCS
   nKaJv1HeKiLUT+umRuMuec43tMAm7WzxQkwRvbQYDSpKVud/w/JY4CXsX
   SN1YKMnMWhWh+SYZe5V1c+t/Vrh9CXlZKLQsI3mwQOBSgv3cL4s6/+ftQ
   zIRKSuZdXCNHCrlYXE5CWH2GxQenAd/UMLEGR6Id0zZOvD5XH9cEcWeoC
   lb+pbGF7aUTlIQhhSTnZ55TOC1ir8nuOUZWSvGVJQx6AZGNmVyKw0HUcK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="378428275"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="378428275"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 14:28:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="642011486"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="642011486"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2022 14:28:01 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 14:28:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 14:28:01 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 14:28:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8fC5ZXVl0kX1SUyRBoVydy9phaXmWmBrk5D8St2VzLdbx0n5aOJjUlPNUVA913o0c6D8l5xj2kUErktp127ej8pXEssJSU+4p998IEel4vaaq8xtq/3pPBH/N0xXOI8W9JgbMeJTDnSRPkAIHUbrJdASHnMiJXb5LH76H3KWDVr82Xz6I2WmkqYYPkZRUC0phyNDnvLKTzCibm7ci/29i58tDPx5DfOn7s+pNU+V7VYrLiaiKrlz4snrtcjr2MU1It9Sxhs/queyXCOGTQeLV/INpk7qTa+sSo4HkE5QBS5UfKcwnUb3kOlOdYPY6fiZErHCQzvkuQiDjo34ub1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AWmR04pr9dnmbPoxGum/QUWGvCPcJQOTm3+l01v534=;
 b=HMycBaTVCPQCAS4KEWNlcLoImISGBfHSZV4csnoypPc/2ZlzN+B3jkiKtf+v9v3dAhuWjdVoz/deprW1kKhKBvm63i1IwDEpwKhwp12sIPI2uqW7LR0nuFyzcAmLZRg4cm5Zgm+6FpPitvvcYxmVOlRl9Nu3CCVTizGd2GLYOEDYW0+Lhx2RwZIkbX412xhv8BsySBwzX7OF5Cr5sgj8/9OvLGX3tRbYJqkc+XPUOr3K6nQgiUkE0vVBmnvBq9kXayxJsCiwDvz0MLr7oOPxWfTrVy1rTFdI+0mwkDzCulgc9EumtlT5uwz4k07JmeIzYx1Ei3wsNGTL58fjyesLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4768.namprd11.prod.outlook.com (2603:10b6:806:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 22:27:55 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 22:27:55 +0000
Message-ID: <71dfb90f-e58c-2f15-7283-14da1d76d5ed@intel.com>
Date:   Wed, 23 Nov 2022 14:27:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 08/13] x86/resctrl: Add sysfs interface to read
 mbm_total_bytes_config
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
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
 <166759205510.3281208.11437041392524040365.stgit@bmoger-ubuntu>
 <46d00211-e6e2-a0d9-22ca-ee0d3ca15468@intel.com>
 <7c1fd8c3-771e-fd4c-368a-83b30572980d@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <7c1fd8c3-771e-fd4c-368a-83b30572980d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:40::36) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4768:EE_
X-MS-Office365-Filtering-Correlation-Id: a447ad6a-d8c0-41f7-93b5-08dacda1f734
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CT/d84ivS9nye2ZrgrGNKbjnT4GW/Paa9lPBnKzFH3fkbZ4hVHIga3oU5kajLUDZyzOjqqddA3OxGUnBgk/AzZCoQCVZ9WKV3ZB0eBLd5Wo/B5nr+Uvka9ab6Ur+HWzBj/4ISYP/mFQMutJJOhEnw4LVJjuH3UUs502IKvUBwQROfZwaVqzYdKFLvLzoQwQSgvS/CcZJriw8doryn48CeNTXX5KLk5SQfy8O9gQ10y2ggZl670yHEx+Bd8vffk3Ng1oTsMb9sV/OukmM+4dd/O3iwQdNw1jtdEHdNMSiZxJ8p9hH4qgdcEytaUxIt1uqExQb+6FS7da2i/P5tfPw8bpdjD74A3CPrQId6FBmgBfyfUr5Lo4WnKhiCUEF24UG38AVDGRzpOj3Q+p1Zvz9zBjlESYz+z8GqM/gMCcjJb0vwj+TobjS9l1uLKi+7evzGKrYDLV5CqRfgMq8qgMJ2wVr2qtICt/FLTXlmmOW3Ac29KRcmOCHn3UA/VYGDn5TclGFjlAvgVbEbP6wl3N8bdp7RnwhNXToDjFgGRz8K9QoP+dtstpYmSHPWCs5UpD5aZozEHutgcwzofLAgDnQPIEFoCE2XwjjSksKLsmRCRAIHGDwu0FPojNztpyEaRIcpKwMt7p9KDGE2rA4cfu7pChIWsV3Fx8/5UIHMg+ib61p723m2H22XpTu0kPB95efZJMhuNmrewy332JqBkDxfu+tPGKmNBFcL2/v32tXkXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199015)(6512007)(2616005)(38100700002)(26005)(4744005)(5660300002)(53546011)(44832011)(186003)(82960400001)(2906002)(41300700001)(8676002)(6486002)(4326008)(6666004)(316002)(6506007)(478600001)(66476007)(66946007)(8936002)(66556008)(7416002)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHdub2RJcGgyTzUxbFhkL3puRXlzL3VNRTZUZEZtK0cxaU5IS1hlYXhTLzN3?=
 =?utf-8?B?c2xRbEJoaHViZTI2NmpCNllOZFpKWXdQNGk5YUUwRmFSSzJZSElFNEtFemxF?=
 =?utf-8?B?OGZEaTdROFA2YWZRWmVSeGVYWHgvclc3RWJ3ZExqcG5kamhqdUZFa0JTZlBx?=
 =?utf-8?B?MGQ2NExWQXNIcm01Y0JzMDZDQjJCWEFodVZqOTFBOHI5SWNTMCtIOFA5ZWc2?=
 =?utf-8?B?UXA2ZU84NytmNktVUVltMWc4ZGFQNUdHYzN6QW5ZOUc4aFJ2MUllQ09BVmc1?=
 =?utf-8?B?c3J2WG5jNVJiMDlmSWtKSTE2c2lKdHgvVk1KWjJwQ2RieWFTTzRmK1IzZThn?=
 =?utf-8?B?ckVvOEFTay9FM0doeTBKVlFScGJRMDdNQVRQKy9yZG4zR0xNTUtKbW5OTVdG?=
 =?utf-8?B?cnZwNXFwY0pPRnlZVm5raHRBalpWdHhsZzBRL01LLzA1djBFMnlWYU5GTVJQ?=
 =?utf-8?B?N3lHZktHQmtLamltRnNYZmppZHdyZDlnSm9uam1YbWJlYjg3QzF3QVg1V2pP?=
 =?utf-8?B?NVhjbk9iaTJXVldHaUdCS1VJbU9QK2xZMnQ3WFUwbWdZMnYwcEVPR3kzN2xQ?=
 =?utf-8?B?TUM5cENSMzlRcEsrSnNZV1VPVTZ2R09hZWpTbHZKWDgySGxOWjk2dTJEUm43?=
 =?utf-8?B?eDJNU2lrc3l0YlV0T2lPd1N0TGVrZCtYRWY1WkppUExNekNmSFBpcWVWVElx?=
 =?utf-8?B?a0t4UndNeFBuRUxCY0kzZXlXS1haTnpCZWdyZzFReXk5OHFHbGR2Y1grYktV?=
 =?utf-8?B?R01RaHRyRVhHTnVac2RKQUttVWRnQUc5UEp6VVk3YnhTVkpyc2lmQUxpSFNN?=
 =?utf-8?B?V0hxSlFUUEdXNVIyTEVXWDNtZ3RuVVR5S0RSV3gxWmx4dHpHVkkzcGRPakFR?=
 =?utf-8?B?TU1tbXlpTGU5dGZWRTRBWjh4R0pKajk0Ykdyc0Qxb1FlSlhlL3l3N0ZpdWFO?=
 =?utf-8?B?RW82QmszWXdHTWVsUUtwbWlKZDM1Wi9lVDEwUjFmcG5PNmptMTNCQTdHZkhs?=
 =?utf-8?B?TXd4NEFFa0JtQVlrYW9IYkVmZmFkVjFKbnhreG1rUHlkbTdaWUQrc1Q0WU5K?=
 =?utf-8?B?V3lrbW1KZ2hrenNOVjg0MUNhOVhOYjh4VEJCMjlia1cwM2tHODk4R1Zmb0dz?=
 =?utf-8?B?bEw2ZXFvVTYxTU9ZS1p2VE10dGRPMm5IdjR4L0hEZ1pLTVRHMUNoVTVRTHBE?=
 =?utf-8?B?bVUxMlU2V1VDbTk2TmJ1eVBDMk55RURsdDllSlN3V2gwSWxlNUtmVklWalFD?=
 =?utf-8?B?d1JyNyt4b1BqYlFyOU1GT25yQkdVdk1FY2JaUU9HSG1reGN0VFkwcU9DeTMz?=
 =?utf-8?B?UjVnN2ppNzJSaDRucE9xdC9VME9hTDd1WkpSWDNESTBoOHJ6SDJxK1Y4a0VY?=
 =?utf-8?B?VTR2emNrb3BUK29VcDhoQjBzZ01kWVMxZGNQTE8zT25XQ0drZ0lRTTcvUFEr?=
 =?utf-8?B?UjFEZDJuTnNrRmVzK1JQR2IwWU9BVWlkamc2dEIrUmp1RUdiZVlKcHV0LzZ2?=
 =?utf-8?B?Z0ZYMTZOekdJbUVwUUowRVpMT01PWitBeHQzeG1JekFuZmh1a2lubUpWV2Nl?=
 =?utf-8?B?UkFvbDBjaVBHUE1LYk9xcng1d0M2c1BuLzJrbk9GY3VXRCtXWmpkeXhzazF2?=
 =?utf-8?B?SXhlSnZreThhdjJTVzg0YlRXTUJWcnc2TENSYy9VeXRTWjRUd1pDNFhiZjFx?=
 =?utf-8?B?RTYxVDZhNW9sazZ3SHBRb1VaeXZSQk91S29Ld1Z5eEt1Wk5vNWhmbVRRcXVH?=
 =?utf-8?B?Ym1iRS9pVlhTcERZWXlJdTdlY3hzZUY5SDdZNDNyNnJZMXRnZVBaVFRDcnB2?=
 =?utf-8?B?SmhiOGZ2MlA0aDBFTkIvaFMrOEtBSlRHVS9FRW5xWGNtL0VnR1U5Tk90OU1D?=
 =?utf-8?B?TDA3UTczV244cXJjM1gvTzNseVEyNml3YzJZZGZRRDlieHh0SXlnRWF0UVlr?=
 =?utf-8?B?YVd3QVBUL0twY0lJTm5TZzJ5TkFPSVdWTlh3Z0Y3TzlsVS9QT0tzWlRaSzIz?=
 =?utf-8?B?QnNkYUowR1JCd3BqUURIZFVrd2xRWERBNUxLYTRqT2ZaWEk2SFpSZklJU2tw?=
 =?utf-8?B?UHN1QTd3UmozWEJ2ODRtSVBBb3lta3h3bVAzdXArZDdKY2JOOXp2TEZucEx1?=
 =?utf-8?B?WFY1Rk1jaE0xVW1QV2VHRUhQdTZVMjFnYU5HRHBoQm5iMHJJMC9xc2RWWWVO?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a447ad6a-d8c0-41f7-93b5-08dacda1f734
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 22:27:54.9693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hcwl3k4ZOx4VTebQ/Rvar5HHShnj//11McBTl2VLaFZIqrCW2PTQSOCZutRU2F2kG/fgs3GihohFviFtug6egy9hjqZK/uneciNTKXX/ZOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4768
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

On 11/23/2022 10:35 AM, Moger, Babu wrote:
> On 11/22/22 18:19, Reinette Chatre wrote:
>> On 11/4/2022 1:00 PM, Babu Moger wrote:

...

>>> @@ -1521,6 +1593,12 @@ static struct rftype res_common_files[] = {
>>>  		.seq_show	= max_threshold_occ_show,
>>>  		.fflags		= RF_MON_INFO | RFTYPE_RES_CACHE,
>>>  	},
>>> +	{
>>> +		.name		= "mbm_total_bytes_config",
>>> +		.mode		= 0444,
>>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>>> +		.seq_show	= mbm_total_bytes_config_show,
>>> +	},
>>>  	{
>>>  		.name		= "cpus",
>>>  		.mode		= 0644,
>>> @@ -1627,6 +1705,15 @@ void __init thread_throttle_mode_init(void)
>>>  	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
>>>  }
>>>  
>>> +void mbm_config_rftype_init(void)
>> Does this need __init?
> 
> Not. Required. Will remove it.
> 

Your response is not clear to me. I am not asking for any removal. My
question is whether the function needs the __init attribute. That is,
should this be:

void __init mbm_config_rftype_init(void)

Reinette
