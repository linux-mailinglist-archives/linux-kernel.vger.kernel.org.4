Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16B0607E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJUSFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJUSFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:05:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA1410CFBF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666375536; x=1697911536;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hRAc6L3U14KBIadF33FB9nwhpAklFEsvZlrhqCrKiGI=;
  b=f6t/wjOkISSav3XnMRgrkG4eO0RPfd5GXq1Qzzm8b4sTsnCm2W8qJXCH
   DyaWRCmq9NA9KnDhZDZxnfUAviJeXf9G5DhoZNltAvEmT+BHI7dLu2IGz
   cwwVgX3ybCc+IIDu4WKkkCBtcMesrYG9+JMBCGXzRBHzFglx4iiBsEzTN
   /qjbWyKha/Heah6iP/F5SGy/sqP/2zfsC1GWAHIGf/xDgPx7GPzgskwGt
   u2kod9/6bQ+1OF7o6mbuFds4Edu/96CRh2QT6IYb7fZlg22UUApQ8uCP/
   015vAzCDbIHf7hAOaWUPw4earEDxfwtIOiDdBpAGib05JkQnyQSmGK7mS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="304683508"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="304683508"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 11:05:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="699450451"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="699450451"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2022 11:05:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 11:05:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 11:05:35 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 11:05:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7wZh3CD8nWDHjrp8HCQKy899QS15Q98sGJSCjM7Af0kRv9EqN0ASTbdYtwdaQAP0YoUuHSreg3l04EzmKhK3m3GvLFpnf5sCh15UWqkKswbgG4M1K09K/xrw9aSi3XtQV9srkZXZ9DHWSDhHdPxcoEdptMnBiUOVZu8HQTf2FvnImctb0LOKNxB3vaJbN67qfmVlkKMyBD8Yln8Kl/uSJFBGILxEniiwvGgE8yGBVgc7ze5Q09NgkElSf8+W7oiwIcQzi9Y3bKO7K/vekCNZ/o2GCeD0Ep+1EZqOkcd1MKogwwR614UX4l8QqfJZsmBA/mDg2MBaDF1P9z9RuWXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz+5acfqfZmK0ML+Ienrk360i1OY1bSVLS+l5hqAvmI=;
 b=KhbkpOg3t7J6AATlzN7b7RQ7BqVdfm4fq4CYcE4YGFDo4X1DaBCmFkqsBifguXAGGltBKvNzUvjCkGOYc0dP8qC7PZ8HClEX5hN4CsfQmVcU7Xfn+GJa70DyAzsJEky03uZ3sOq7u7kT1yQ+wXNlNgWHlc+UjIy4EW+0mhMlMIj0E6pmpEFbDwf7IySNsB7mWwSRT6r0yAIzsVfNx7Zu8AlK2ecAn/6bNmcMgXR/xlMGwrjI9kXDkXZ0qk1s8CvyWyqZxVPyeHc4TnZ76UK37Xas9htUxHoBz7ztFXTn6gJw+lRwi6j4W6wprDk7mQVAsS194N9AUG1xM3AOiURIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW4PR11MB6838.namprd11.prod.outlook.com (2603:10b6:303:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 18:05:31 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5723.035; Fri, 21 Oct
 2022 18:05:31 +0000
Message-ID: <30637459-7419-6497-6230-b13c73a947de@intel.com>
Date:   Fri, 21 Oct 2022 11:05:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [PATCH v2] x86/resctrl: Clear the stale staged config after the
 configuration is completed
Content-Language: en-US
To:     Shawn Wang <shawnwang@linux.alibaba.com>, <fenghua.yu@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        James Morse <james.morse@arm.com>, <jamie@nuviainc.com>,
        <linux-kernel@vger.kernel.org>
References: <1665304608-120466-1-git-send-email-shawnwang@linux.alibaba.com>
 <7fa6ed4e-abae-85fb-4e95-8c73755a4263@intel.com>
 <ad08eee6-cfea-3858-0def-e2e3fef315fb@linux.alibaba.com>
 <ff44b0ff-6adb-3bae-d17e-4c341c09df5d@intel.com>
 <86fc22a2-e779-b7ab-67d6-a3aff975ae56@linux.alibaba.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <86fc22a2-e779-b7ab-67d6-a3aff975ae56@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:254::24) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW4PR11MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a64980-488c-4ec3-016a-08dab38ed7d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmibndFePA84Ll8qOo6Lcsu9o1wxt5XT8jpFPlHm46D48U2IBLCw+NSfhO6Ys47/LbIkl7u26aaGNNXw5egwo2LNb40gP/bwn/g85l5G33zCA+OdLNo4KhpQDY9ZMhJeNhvNe+hcR6Ab91fFLdv2TsER6E1W7VMRAZG/+eM6Uckac7RFAaXyP8waVpWLPJA6cZpWQLBdicnXYUbX0fa557EenI+j8ThJvKW8hp4rNuudvx08c+J0GeO8NlayciMUTdrRxcXlFM8+13TribUtsQMc5XVSCiAvVxzHgGhFs67lGrAXCk83SScONX4aWENRb90PZ6vk4TC98ZOblmovDh1fJh22uFc0OaXIktFaUCOGAtET6v/ot0qtRKKq6kMkzypR35rGZJeucw8oaVYN0oqCdMyiRRj5D//7zfcSbItMXIPtfbL2vGZssb/IVeIErXyn6tC+QfUgk9z5bcxWSkUGnGHmQdGUjaE6JVK2VpQ2CCslBHLB/U+FoLd949YUZDsdr+46ljtbzVcARkMH7PzfsFjE9pHbtIRY2+BIi+KsfXl3BI8OXrPAlksnk3QGl0e6lECthfpa3Q4u4Hi8HY9LPVTgty67QM0bhUg5vIddz+b0S+1K+9MmKiwmHfp0UKHVyUJnzdmd9YKjaTH08O+HYfnX4tMnhvWlBhoL+sHWb6Qf2CdQF7iC1IWgeTXH+iUvfNzEG6qyCTCqrIxudAGjJDfIFSlwyZKe6UU+XGpxZqx0nYfDwkvb6x+rkxopIf4I+bfWG/lcDLQqpDa0Z5GFg0lR+MsxZZLL8VjMRwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199015)(6512007)(36756003)(186003)(26005)(53546011)(41300700001)(478600001)(6666004)(66946007)(6506007)(44832011)(4326008)(8936002)(7416002)(5660300002)(31696002)(86362001)(2616005)(2906002)(38100700002)(6486002)(316002)(6636002)(82960400001)(8676002)(66476007)(66556008)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXhiVURQRjk3OCtXeGJZMDZvbTNIZnlMK2J0ZjZLaVhtQzhBdENXSURvYk9o?=
 =?utf-8?B?d2MwRkdJMDVGOHFmNmNteWkvMzVIV1g4WkVPV2FCWGtCSW1nSW9oSDh5cWdk?=
 =?utf-8?B?cWxmRHM3OVRpT2RRTVZIRU82RDRzRDFwWUdoVmRDK0QwNVJMMk1zdnN0WmdX?=
 =?utf-8?B?OGRocHo3RjY1V1FmcEZOeGpGRXlpaUw1VXhYRlhJL0ZzaGdhY3REeXM3cU9Y?=
 =?utf-8?B?aWl6R2k0Q3N0TWNZQlpsVkdxOGFlWmpNQnpvVGg2RHBGOGdhRUcvd2VBbkE1?=
 =?utf-8?B?WjU5eVZlQTJWeHFHVHRVSnVjS3RRTUNEUTVoK0VDV0VLNWh1UXFsR0pqd3ZZ?=
 =?utf-8?B?Vk1IdVVsVWlLejF1a0FDUWdkY2lLdnBqUjBPeFo0dzdyNCs3bFlRYlRTRWhE?=
 =?utf-8?B?bzU0L1RwRmtHaEltMVh1VmlSelFYZ3p0anQ4bmhGbk5jQ1dISjN1WXUwc0E0?=
 =?utf-8?B?VWViUTBEenR5bkU0NkZWNzdpWFE2TXlFMnVRTXhPRlcxRk1PWktTL284d3ZL?=
 =?utf-8?B?ZEoxZlplRWE3eWtoWlEzSU9qVEVUNERDVXJ6NGtSaXVWN2svd3NZejIxY0Iy?=
 =?utf-8?B?UlkzSDBLdTZhd3VXbk9odWkyTnNxOTdabWhWZVJUbnBEOU5EZ2ZtS0dibHdK?=
 =?utf-8?B?Q05NK0FDdnNFRDEzSU5saGJzMHE4akxMTTRxYU9Qd0RFN2VSUDlGSUpSdkl2?=
 =?utf-8?B?dWhISjdIM082N2h4U2lQZU9ZODJLMkFnNnNCTlhZSmlCOVl2Y0xkWkIrTHZl?=
 =?utf-8?B?aHl1Lzhzamd0cFA4elhOdUswc29wbjNJd2dMc0lzSUR1MTNhaEw5bnBzV2pI?=
 =?utf-8?B?TVNUaXZIb09SWEpTUXRLWWJ3TGRuTCtJQ3F6L1hPY0dqVFppYjhub3Rseng2?=
 =?utf-8?B?azUyejdIMHp4d1BsSnNqTEF2a2lWNEY1Snh6Z0FkV2Y3ZVVTTFNCb0dpY2F0?=
 =?utf-8?B?VFhsK3QwRXdHbXZvdDVEbGZQOFBKaEg1V1J6c2xLdEYwdk04NVR1em5oK0hO?=
 =?utf-8?B?bzFzOWloUW5JWXI3aDVrK0dvQk14VXh2L3RVN3p6YzBha0lFQ1dzdzZEZ1hI?=
 =?utf-8?B?REcyZy9odlBPS0xnQ2Jqb2drdjlmRFFmdHE5TFc1SDVNRnlweFJ6U1Z1QTdX?=
 =?utf-8?B?cEY2V0lLZjRyTWlGdnd1NHRHekpJbUxBY0FRMEdtV2puUEFkRmJhUTBwM0NX?=
 =?utf-8?B?TE9haGI4aEZNZElOUE0vR3oxSzZvcGZub0N1WS9QbnBaYXpyQ1FnRE1nb09V?=
 =?utf-8?B?S3hSdHU0emk2YWJiRHFCc29IRFRkckYwWm95cVVScEZpU25NTTI5bFdBQzZK?=
 =?utf-8?B?Nmo0YStEV1ZOWnE4YUtyQnZ6bkttaDZkU3VKai93Y0VPemxDUE1vZUd4amNG?=
 =?utf-8?B?dmsvL2tqd1luMzRHK1Z4VzY1SzJDRlpZbEZJNUZrRXJYbnNlR2RQUDlmUFY1?=
 =?utf-8?B?Y2drbTJLR1FtSURjMEx6c1pRVk0vSldjSnphVFpZQWNFc2tpaUJmbXJnRHhZ?=
 =?utf-8?B?eVdNWEsvbFkySjIxKzI2Z09qRHQ2b1FHWjEvMWhxdlRvLzhTbkVYODNpSVAw?=
 =?utf-8?B?RFBHZGxXR0VSa256cUY3Y0dCdCtDN2xic3JaSTNkNlB1alZXSmI4MDJDMHph?=
 =?utf-8?B?ekx0OHdRKy9iakhIbVdhZU9DT0tXbEV5bFlJdCtQSlpwOXRzZHpCVXQvcUV0?=
 =?utf-8?B?T0xHMUtDT1F1Sy9xdnZkVmFXTkFJbE5hbW5yRy9PaWxReENRMDN5R2xialRl?=
 =?utf-8?B?a1VTR1NBbUVmV1lSYkMraGhMbWtha3BaQ08xMk14YXR0ZDlNRkd2VldESDZn?=
 =?utf-8?B?d2J3UHFXRGQyY2FZMWNqbjRPTkdzQkdVNnhHaDNNNXV0WDFLRm14S3hxWXF4?=
 =?utf-8?B?NlZCZlN6aS9RbzRpL0liK0crTE5GSGlyem9BOW8wMUdyS3BvWTFCMzNzcE51?=
 =?utf-8?B?RjBsV1ZVUmJHckpWTTk3cUxZYnpnTjB0UDhHWE1tN1V0ZTBVVUlwVklVY08r?=
 =?utf-8?B?eGEzZ0xRSTFuYkxRd1ZkMU55cHJXck4wR29XaTd5Y2VuUVQ1dXFVSlpQNS9Q?=
 =?utf-8?B?UzkyYmU5ZWJDNnp1UWZKY2xlbmVYVDQ0K3AyVGJsL3ZYSDQvbGJXcUtUYWVi?=
 =?utf-8?B?eWlqcEZSZFBETmRxb21DUHNFdUN1SEIvajFNeW5UOFlNYjd3R3JnVHF5c21v?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a64980-488c-4ec3-016a-08dab38ed7d4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 18:05:31.5476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPmeQ/4mY0hVr8dL7ZYHn3thsHX1UcAxYR4tdJ1Tl99uKJWvJQju1y1GZ+tiK6fmXRtl3tIs1o/oNwMzvC9aHWTuISxV1u1cycQMaGSKjv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6838
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 10/21/2022 1:22 AM, Shawn Wang wrote:
> Hi Reinette,
> 
> On 10/21/2022 12:35 AM, Reinette Chatre wrote:
> 
> ...
> 
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>> index 1dafbdc5ac31..2c719da5544f 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>> @@ -338,6 +338,8 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>>>>>                    msr_param.high = max(msr_param.high, idx + 1);
>>>>>                }
>>>>>            }
>>>>> +        /* Clear the stale staged config */
>>>>> +        memset(d->staged_config, 0, sizeof(d->staged_config));
>>>>>        }
>>>>>          if (cpumask_empty(cpu_mask))
>>>>
>>>> Please also ensure that the temporary storage is cleared if there is an
>>>> early exist because of failure. Please do not duplicate the memset() code
>>>> but instead move it to a common exit location.
>>>>
>>>
>>> There are two different resctrl_arch_update_domains() function call paths:
>>>
>>> 1.rdtgroup_mkdir()->rdtgroup_mkdir_ctrl_mon()->rdtgroup_init_alloc()->resctrl_arch_update_domains()
>>> 2.rdtgroup_schemata_write()->resctrl_arch_update_domains()
>>>
>>> Perhaps there is no common exit location if we want to clear staged_config[] after every call of resctrl_arch_update_domains().
>>
>> I was referring to a common exit out of resctrl_arch_update_domains().
>>
>> Look at how resctrl_arch_update_domains() behaves with this change:
>>
>> resctrl_arch_update_domains()
>> {
>>     ...
>>
>>     if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
>>         return -ENOMEM;
>>
>>     ...
>>     list_for_each_entry(d, &r->domains, list) {
>>         ...
>>         memset(d->staged_config, 0, sizeof(d->staged_config));
>>     }
>>
>>
>>     ...
>> done:
>>     free_cpumask_var(cpu_mask);
>>     
>>     return 0;
>> }
>>
>>
>> The goal of this fix is to ensure that staged_config[] is cleared on
>> return from resctrl_arch_update_domains() so that there is no stale
>> data in staged_config[] when resctrl_arch_update_domains() is called
>> again.
>>
>> Considering this, I can see two scenarios in the above solution where
>> staged_config[] is not cleared on exit from resctrl_arch_update_domains():
> 
> It may not be enough to just clear staged_config[] when
> resctrl_arch_update_domains() exits. I think the fix needs to make
> sure staged_config[] can be cleared where it is set.
> 
> The modification of staged_config[] comes from two paths:
> 
> Path 1:
> rdtgroup_schemata_write() {
>     ...
>     rdtgroup_parse_resource()     // set staged_config[]
>     ...               
>     resctrl_arch_update_domains()     // clear staged_config[]
>     ...
> }
> 
> Path 2:
> rdtgroup_init_alloc() {
>     ...
>     rdtgroup_init_mba()/rdtgroup_init_cat()    // set staged_config[]
>     ...
>     resctrl_arch_update_domains()        // clear staged_config[]
>     ...
> }
> 
> If we clear staged_config[] in resctrl_arch_update_domains(), goto
> statement for error handling between setting staged_config[] and
> calling resctrl_arch_update_domains() will be ignored. This can still
> remain the stale staged_config[].
ah - indeed. Thank you for catching that.

> 
> I think maybe it is better to put the clearing work where
> rdtgroup_schemata_write() and rdtgroup_init_alloc() exit.
> 

It may be more robust to let rdtgroup_init_alloc() follow
how rdtgroup_schemata_write() already ensures that it is
working with a clean state by clearing staged_config[] before
placing its staged config within.

Reinette
