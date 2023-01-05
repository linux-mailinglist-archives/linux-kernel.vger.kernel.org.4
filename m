Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B582B65F323
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjAERtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbjAERtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:49:46 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D535014B;
        Thu,  5 Jan 2023 09:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672940985; x=1704476985;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kSXGf35bOJ1Wc9eQXX1dUfXOpsBahwldsXF+ZshgMUc=;
  b=DrUPwUYn4tcjDKoICX+fCcLIMzNRdJ4zPmRI/AdU+gy1/OhJiK5m7I82
   Yz9dhagbwhSYGeDWCWbHb0tX22jnxMGt/7USZQkgiG1xd3aWujybZBDNd
   X1WqwT3IHQWFNLds1jyMd1m0Pu9aRP2QqYxVk+6fe1qQy8qoNYTM/CQsB
   KHZPPDlQkELeNvakQ+FWhGHWs4/4hwsXPRJ58kArby9z1hUlRwSVNW0fO
   g96PNAlmiHdRckQM33ntHTdiuFTUg3y8gi9xt55FjKEtmEH9flsiRdfm3
   ZIsKW/na8TSmKgNijmbqiyVEpQ0yPhWZGHbMRbmpTJiO2uF8YFLOfXYEe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="320982087"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="320982087"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 09:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="687996725"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="687996725"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2023 09:49:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 09:49:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 09:49:44 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 09:49:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL/fj4+A7/rSr9phMis8CWl4fw2gBGBzxYuuv7jY7KmYgHICczpzKoBmg4zb+xwjeYd0kV0WTinzNGLSRa2/UMq0WKOdWk4HL1mIQTwsWpJSPrua8+jaKnoQqr+PZZgCKCeiouSjmQPjXgjCNtq2wd+Dp9NZm5nlGXeuhudjdh4+E8BYd7DMZw2sGsLsYoXVz13r+y4JPV5q3HLHFV90z3AZU6DrsPNRheqG9Im1vEVubF27UyFXAPIK7NDq2ig8Zajx86T1vNBWbffMuiuj5ILXt+wn+P7zruZsyLXFuv0hkXyeO2xYtg3WhNxGMsgCdykszOQJavpqVQWITZtPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4X6sfrHA+hy22BlnCqdhLZSJeTVB7j8+Ey29ZkkxYQs=;
 b=JbM0lwf/QPJG5gT9dkW8gMW5b5fYTHY4UuuId3rxVp6ofTBjpR0bjOPYeIgT5dGbWDsT+lJnKoR3NWLI5/SXcbIPaYZdFyLcKfsZdqYdE5yt5vepvNZmVCiPsOwWHo3/8n2mZbA4bYReK4FwYd/W+uFkSuNnHyrk3uOME+xluwTMt6Z+784XqIKVL7hAheA6EdJHDCC6/XGQyDJF/OJ5C2R13gPSwYE3fGHjCKsukLcXpdBVahqzKa4El+9zBjs0dyheYPIKn/SNAIrzqeVuRrSYSIioQUoVhkU+2T2bTwBNxkTC3Zj8o7Mcai77y1zygxfbJkS7xr0HWat7U015Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 17:49:38 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 17:49:38 +0000
Message-ID: <d78e4757-fb74-9d80-da71-9bfe3de9d059@intel.com>
Date:   Thu, 5 Jan 2023 09:49:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v10 11/13] x86/resctrl: Add interface to write
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
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20221222233127.910538-1-babu.moger@amd.com>
 <20221222233127.910538-12-babu.moger@amd.com>
 <3dc31a6d-5485-746d-3c49-df7dcd1827e3@intel.com>
 <d92fa6b3-227c-32f7-87c3-c267e052a824@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d92fa6b3-227c-32f7-87c3-c267e052a824@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::28) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de1ae16-8a5e-4ea0-3dc8-08daef453708
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAMtsLCP9ghtyqYoKiQckcPnnbeJLCp+QwhvhiyHaCwwKWIpDaOVId2Z9ghcAqJD/QI5EXoZjLiGUp1+t8BIVTHz+tjOkVq+TyHA6ns1nsmYOgDxorZjMyt/EA3HortJWUR6p9VggumNlnvr+uGy9mZ1q5rA7CHOhrxRtgZo+SAu/qI6J5TYXzOekzZJ0zj2rmK3MJ1OsOPHDySayz4drDhx3KJZjM9LCmU0ET+fe3lYRn9+3bNyYfe4M2232+7yTSb4XB/EdFsKBZcFsEVzDrMD0pGHjMkjatY4GN349j/Oh7OdUBkCkzhXNdaMAAk8F/AP10i3WGW21RbCLB6gtnGEHMU4iASy4J7NlIxFNHixwVYWOQ3XPobM7Iy9MRNCLRnmUFx2C6FzMfNc0y2KHhQDIqEckGIw97K0E7lH7BNipcYt3W5ouZs8R89/nvnHY0sYC0mjSfkpT9AMJLNcWfyLl/W/mTUiOKZCA+v6hMjfe3gXE/NzHynYdxf6DQnYNe6NI+iiCJV3IUrMuhhEAddkbX2UDJFPw1/NYuLzILr4SpU+h4aqBpphbIcVjBysurXF1gmgH/TBYmIbXsNJy+SlVGEbOwVkuh36GPAOm+kiWnY12fBGOa89QyfxZbHevuCuryTiQeyKYudz+EWZ5AHQ5v3/ZPDISEi1kwGvRb1J+2SkaiiovDmuWdwVASrN7DY6yz4bhOo64E59k3fCh4YzdF0H2L1jqHPYwlsrf18=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199015)(83380400001)(2616005)(6512007)(186003)(26005)(82960400001)(31696002)(86362001)(38100700002)(36756003)(5660300002)(316002)(44832011)(2906002)(66556008)(66476007)(66946007)(8676002)(8936002)(4326008)(31686004)(7406005)(7416002)(6666004)(41300700001)(53546011)(6506007)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEtMYmdmdlZMRDhHNnprTGVBVEZ4TTFmR3NKYWN6OUpCanpUR0U3R0g0M09n?=
 =?utf-8?B?UEE1ajdXRWI3bjBrS0c5b2h4SHpoSDBsZlRCaGJrUzBIaGFHaVFFZWoxZEJK?=
 =?utf-8?B?T25HL0J3dHhLUFFnQWpSSFlTNGMyL2haeFhLa1Nnb0hMSGtTZllrVlZ1ZnlQ?=
 =?utf-8?B?U0pYODU0eU8wUzNEUVY2aDlBSUo5M3RNd21UaGNOajFhSWN1MGpuR3MzYk5i?=
 =?utf-8?B?Y2EyTnRnNDMyaFcrRjVpaEhJdmZhSVR6QXR4VzA5MmQ4QUx1eGNPVWszaTEr?=
 =?utf-8?B?MVZxYlVtaXNPYVIvTkpmVjg3NkxaSzJYYUErMmV2R2FIRGZ6MlVUN3BWR0hW?=
 =?utf-8?B?clJkWnowOUpSb3Z6QlZ4ZExJOVRZTWNzMkh6SXdHMTE0Nnc2bUZoalhyQm9U?=
 =?utf-8?B?N3h6elFvTHFTd2lqSStQZnpSeEJZOWVJMmYvaGR6RkowVkd0RWsrRGx2YUVq?=
 =?utf-8?B?OWNLbFZMTllYWjVKU1V0dWVLcTllWW01RExxSFBKOEVTMEJ5UkxRZC9WMlBB?=
 =?utf-8?B?KzhSb3NadXBhekFqQzdwRENGS0xDMHhwdnlCQlRiRG1Db21jcmREcFM3ZTdK?=
 =?utf-8?B?UWs3NXU2eFN0dFBCVTdJZERJY1o0ZERMSmlMNjNZa0c1bzQ0bEJ0cXJXVVl3?=
 =?utf-8?B?bWZTM0dKL0lnM3ZIb1NvOG8rQUhvdG9vQVhydlRVZmJpWHVUTnEvQjJCZ2NV?=
 =?utf-8?B?aDE2TlE0ZXV6S0EwaUxiQ3lKUU9aM2VzOEJ1U2RCSExEQ3Y0dkV4RFFzREN0?=
 =?utf-8?B?czJDTkY2S2lsbWlEVm42L2dTUEt2bVp3M280QWRxVmEzRDQrQ010T3JnSkhr?=
 =?utf-8?B?SjgzZGxOWm1mWlY3SytjU2hWNU1nY0JhUC9CazJncy9KdCttNUx1YjBJR0tJ?=
 =?utf-8?B?MTh5dzNLMzlRdjRHa1RCOVE4YTJYcHQycUxFRVJjOXJ6V3J0dDd2MTJoZmNM?=
 =?utf-8?B?anpBY1ZwNk9jVUo3eWlINGNsb2xSbE03angyQ2wyTTJTdk00c2ZzSFNkc1cw?=
 =?utf-8?B?OURLQXFoVnJEcytIenIxNEZPT1lzc0NWRUR1MTlldnNLYmZFcTJIOTZkbGZ4?=
 =?utf-8?B?d2hOaFFKVlg5dTBmRmpnbHgzNWVkaWdIcENYZmdqeitvYkVTa2hIbmpaQlBw?=
 =?utf-8?B?dHZEWGY5NnlhZWVkN3RXRFIzVWoyUUNZMUJKZzFTc2ovaXFFbmZKYk9FNFF3?=
 =?utf-8?B?ZU1ZZmkwa0dXMUF2ODc5d2VpZ3NYUDVGcjRpaVFpVTVoOGZROFFJR2orRlFq?=
 =?utf-8?B?WHhoTzluTmdaaWVqbGJlTmNrSU9tQzJVTTB0ankwOFRMVnVKeVowc2dRQzlI?=
 =?utf-8?B?bGJEMlJ1NlZWc0E0dnlTakV5QWh0cm01cnFlZEVOYWVibHBMNHNBK3JQbjhl?=
 =?utf-8?B?YWZ5TkMvOXRFZCtxTndFZzdXT21BdzVJeGxTbm14NzJMK0VRMTUwemJSSDZs?=
 =?utf-8?B?MFFwbHd1STEzK3NqcjdkbkhOdjllM1hCYXM3MTV0bFlFR0hITTRwKzh3TG0r?=
 =?utf-8?B?dGpXeGp2YklZaHdwbEw5U1BRQkYvRWZIRkZINU1RMnBBOUxXM1ZoQ3RwTnUz?=
 =?utf-8?B?VHlURFAvaEZvTFFDMVBKSVZZc0N3aWdWeVo0cVJSbGxFQ1ZZSXRQSG5kVEds?=
 =?utf-8?B?dGF1MENwT3NVOGpTeGtBb0J0Rkl5ZkxoVWZSQmRGMFZkRHpLazJIZHdJS1lJ?=
 =?utf-8?B?TUxKVlVxaWMzL0VKaVBnUXJWM1ZVNjhKMHBPM3haMEtzL1NvUHlkWGZvRkFx?=
 =?utf-8?B?M05rZHp0OEJrODA2TkVPM1NqTkNuNW5MTGIxejkwVDVWQ0hacmRadTF3S1ll?=
 =?utf-8?B?cHYycnJiS0tEbnJEVi8zNUR5WnBhTGVJcUlhV2FmMlpZV0xxRWtSR0NSVUp3?=
 =?utf-8?B?aksyMmN2Yk42VlpwM25PWTVaVWZtL05qVWF2cFdUdnlhNTRSSm95eWJVdkdN?=
 =?utf-8?B?bktHa3dIMXA0U045QWVES3BoZG5PaUh2RllNbE1DckFXYnRMTDRWMVpIWC81?=
 =?utf-8?B?bjBpcnczYWVpQWQxQWpYQzVCSzJDbzR0TERPaVFsUVc0ejJVUWlxSUU3NWFT?=
 =?utf-8?B?cGZNUjNvS3FiZDdqalJZQnorZ0VFaEdUcnZTc2MvVXh5eDBSZC9LU3hZZ0I0?=
 =?utf-8?B?UTN6WTlRL0h3cUkzRmJ3b29IOVJqblZYaFBXMjJUVG9HcWhJRWRqMjA0QzBm?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de1ae16-8a5e-4ea0-3dc8-08daef453708
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 17:49:38.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kmy7VPbjKYhLmhvhX2G86CtKY27cxdSQEQOFXiUnBBlQRv/l708/5Yl4ayk5yXvlrMwKXEGvFk+2E262UwcbLg72PvNjraMhqMfE1QJVTew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8179
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 1/5/2023 8:04 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 1/4/23 18:29, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 12/22/2022 3:31 PM, Babu Moger wrote:
>>
>> ...
>>
>>> +static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
>>> +					    char *buf, size_t nbytes,
>>> +					    loff_t off)
>>> +{
>>> +	struct rdt_resource *r = of->kn->parent->priv;
>>> +	int ret;
>>> +
>>> +	/* Valid input requires a trailing newline */
>>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>> +		return -EINVAL;
>>> +
>>> +	cpus_read_lock();
>> Could you please elaborate why this lock is needed here as
>> well as in the following patch?
> 
> Holding the cpus_read_lock() make sure that this cpu is online while doing
> this operation. This code eventually sends an IPI to write the MSR on one
> of the CPUs using the cpumasks. My understanding is to make sure cpumask
> is stable while handling this write.  Same thing is done in

This flow uses smp_call_function_any() to send the IPI and update the MSR.
smp_call_function_any() itself disables preemption to protect against
CPUs going offline while attempting the update.

The domain's cpumask itself cannot change during this flow because rdtgroup_mutex
is held the entire time. This mutex is needed by the resctrl CPU online/offline
callbacks that may update the mask.

> rdtgroup_schemata_write.

Yes, rdtgroup_schemata_write uses this but please take a look at _why_ it
is using it. This was something added later as part of the pseudo-locking
code. Please see the commit message for the details that explain the usage:
80b71c340f17 ("x86/intel_rdt: Ensure a CPU remains online for the region's pseudo-locking sequence")

Could you please provide more detail if you still find that this lock is needed?
If you prefer to refer to existing code flows there are other examples
in resctrl where the domain's CPU mask is used to read/write registers without the
hotplug lock that you can use for reference:
* Even in this patch series itself, reading of the config.
* When creating a new resource group (the mkdir flow) the MSRs are written with an
  initial config without hotplug lock.
* When writing to the tasks file the CPU on which task may be running receives IPI
  without hotplug lock held the entire time.
* See resctrl flow of monitoring data reads.

Alternatively you may want to take a closer look at where the hotplug lock _is_ held in
resctrl to consider if those usages match this work. Understanding
why the hotplug lock is currently used should be clear with the commits associated
with their introduction because there has been a few bugs surrounding this.

Reinette
