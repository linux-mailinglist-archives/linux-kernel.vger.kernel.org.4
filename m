Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F73C64A60A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiLLRiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbiLLRhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:37:33 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2FC13D51
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670866650; x=1702402650;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kQ0sNV+0ivtE4n8gG7gzjb6va2JvPf9ZTnvGFWEEZM4=;
  b=HE8kzdfJc3pqQX9SNu4vG/0FoXcZk2NvV1S3yabIAUIwNZI7mOyB6qlR
   9shQpcHJdQ4k/G+DAmQDn6L3f19COuA/Dge56zbKzoPqYKcDLi7KfY7ru
   2jI4NzRaUkwi18BnARPcpAUZpcJF42H21e0hp8MmknO+0fEQBMJux4Ke7
   /l+PzgKs9zUOSrbllMLF9wLFRE5kaxOhp5GtELyxH045KcUWXJsQ3cRu9
   MtRZBg8e2xxt4mkXtZWHQRMpBfFSKOCdcj2O6Cozp6mLk0JbThvJArbd/
   /lR5Fd28H9y3q10jLoFWnIoZqzvvyZyorx0mW9MXvK2VyhVDb1sWKVcq4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="380125212"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="380125212"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 09:37:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="737051025"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="737051025"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2022 09:37:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 09:37:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 09:37:03 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 12 Dec 2022 09:37:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKkNhkkzW0wtKsFKEnMZwR5E0ZOMKCnG/xa0yEc94g9Obd8FnBbi41L6VX7FEXa6bGuwv5vIODKMCkIR6mPltmLZ0oTcZzLa/0f7A4qLMzZlnVnWYhq9szdYIkJ3iC28v0pW3jOImdrD/E23fS0mG6vPkopXv0E+dsGn+aXB25GQRimiXFUkRdZ++tHUX1NN4x4NKWEWh5tV1PDuHNEVdn4g/fu6cG9FhKr6wabiqR7Ft/iUhZI4pjavnliqCaN4yn54jcGqonGK7IzR2MLME2LB8YxwPoA4eQxThwYADfQNSuAv8h+mn5J0no7ZKIcmL4zW8YU+4GjHrUoAsiEksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpfTNeTek2GdTL3I565DgNVd/SSFNH5CHLo7ry3CwoI=;
 b=nnlBcILij8S0XPW0yapQBZa7W1GL8U4mnnsIcn/btHV2RZR1l/saWGryOz6JLakGGWJ/N8w2oFmZ05DQCoFyDWxlz0E75qIlvWixR56Pxl2rmxZC86gNNwoDhKOUk2SAoGidMd17nC5XDBhQKZ2zdWfpelri40t1ZrYWa6m5pt5NRmB5HfIQljTdw5HQDFyd17RariZ+rUZqb8gcwyB3jS7nWby3fqZYpVd0b/ATy7jtWDIBVOhvQdhhN9vOSx6YAYZy2RVJI5kg+3orV/uPyYK2smYjbxw7WxwzueREwuie3/DJKiC3YCxO4q9ogXDh6+L2CMBRGu4fzgO8MjkQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB4546.namprd11.prod.outlook.com (2603:10b6:5:2a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 17:37:01 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 17:37:01 +0000
Message-ID: <29bca1a0-b8f9-2c16-db74-f4ff3e45dc8a@intel.com>
Date:   Mon, 12 Dec 2022 09:36:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v4] x86/resctrl: Clear staged_config[] before and after it
 is used
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Shawn Wang <shawnwang@linux.alibaba.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jamie@nuviainc.com" <jamie@nuviainc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
References: <20221209024436.22170-1-shawnwang@linux.alibaba.com>
 <IA1PR11MB609702742C92B316A78D73459B1F9@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <IA1PR11MB609702742C92B316A78D73459B1F9@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:180::26) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM6PR11MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: b52374c8-082f-42ad-b8c8-08dadc677a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UuQbDZgDZrpSQ3MRGPIBryn4otF/SRw6G7UkXZVB18sA0exuMUt3L/YR/AJ1iXmbXGdY7TCYUtnfVXSSiru2jF+OPr9gSHcyN6iGqu/jpdWt/GKIt8nUHF1OACqvXouyWLJf13nYtuH0Rmju7q5IsEzxM4tAx7Mk2wfN+m6RhtlFKkojsIvaaRgFDrmjf7dcIAhs8weHlSUP6JWbMl/6rwLVYmRqDXeMY+Fshszh0h+7p7oL/oqIJfjJ0lqZzzMZ4u/fLrTKaibO+QV8jgfv7gu/djVNsKIVUIYGm1Y3qzLWe151CVMdp50iwxKRfA6GCpVbnMdfHHaZ/LFfKONyzaa1/m2T6//7/e77EBONm9nLbHZV8qxTsIZphLbNP9fRdS4zEH+2AbAwPNGfMedZvPyi8KIKDNgkL9CIyoQhH0GEYbXbwff67psUqwmH93zcl8JYJlWGvcMEsFEGnZW94vjoXzmEXuD4ezOKlxbr4MdaMYIAAEsrQwrWhf3/H1ZCv9lc8MhkT47MKQH5UE+Q3k7wSU+UC9io1ela8mYNCWaT5b+Lqwd1Jvudh6mw88XQFx4xvQE8dWI6AQvgugOvoGz/eGmmD6FvJkJToX/+Lkn+5F5CVwBV8DXVCOEAWG2wCaoZ9PbufftQqCHB8lm5ZOdwJdfAk30vPZTOXh4JuZyaoEIhAobBwrW3jW5722a8kDgNUJrzRje71BOV46oAYoQbWmTiMrKLfMHJ/S4LUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199015)(53546011)(6506007)(6512007)(31686004)(478600001)(66899015)(26005)(316002)(4326008)(2616005)(8676002)(66556008)(66946007)(186003)(41300700001)(66476007)(5660300002)(7416002)(8936002)(44832011)(83380400001)(6486002)(2906002)(36756003)(38100700002)(86362001)(31696002)(82960400001)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0lTbVlESHppbUY5Q0F3cjArUitkV1N0QUZMN1BQQnRwNnVZRXE4Smd4NDhX?=
 =?utf-8?B?MmNmSzFYdG9FTTI3MmJ4ZlhGL0dLUFNPbkcvVkFESXkxM0UyV0ZYWDVoU1Js?=
 =?utf-8?B?WDRsMHVuSjZMTHRnVm0xUFZ3ZDQ5UHlPNFAxRGo5VUg3TnR4T1Y0eEtpemNL?=
 =?utf-8?B?ckN4S0VwdlpsUzA4ZFJ0dThkVlhOUXNNQnRVelVRU3pYTTlQMFR1WnlnaXp4?=
 =?utf-8?B?ZkFsdVRQZ2xwUFRMT0t3eER0dFVDcjYvMGJVZTVVeGprNU03Mzhnd3FYSWd1?=
 =?utf-8?B?dW5mYTM1U2pXNmdyV0FOdUhScmlsL0lMY0dFVW5WTlNKdkUxOFltQlhuN01Q?=
 =?utf-8?B?QWdPWFNmQjdvSHlBZ1FRZkk5NE43QXZsbnIxK3dscHVvVVlsSjU3UjVLblZq?=
 =?utf-8?B?T210c2QyVkZJTmxxZ1JOOXdTZW1rSmVDV1lHalN4T21oTWNyaUlCK2dvZWZM?=
 =?utf-8?B?QmFUSWNSUnl2NXhBamg3TFVDUWNqUG1ZU2RXRDBjTHhyU2E1WWx2MmtpWENv?=
 =?utf-8?B?Z0RhRVIrWEZISXlyY2EzemVqSXI5RXR1SmxGMTVveE1mVEVDWTloRlRzcVBB?=
 =?utf-8?B?QWIvdkM3UFhHSGR5NS9FV0dzUllETG9WN0U0bVNoc1JRT09qY1dKV1dRVkph?=
 =?utf-8?B?K285N2NSTURXRTgyMVFyUVZ1eElaalNtbE9Md1I4MmNCOHNzMTIreEV2U1R0?=
 =?utf-8?B?MjFPUzMycDJrSGR5NHVJU1FtaWNuRXhHK3VvZnBHc1VEY0RubzRvTmdWMmZq?=
 =?utf-8?B?T3JtZ2xiOU15UmtKYjBINHkrcVhtOUVCeVhwTU1LOXV2K29PRnpOMzNZUGty?=
 =?utf-8?B?NnBud2d5UUtSVXBPLzJ1Z2pjbFVFZmZPODFlZTZ2dXRNZTJHKzlWVU1wbkQ5?=
 =?utf-8?B?dWNHQmVSTDZHNUduUW5yOE1sbU9oTG9tUVlQSVUrUW9mbTF3QWNFOXEvU3Zq?=
 =?utf-8?B?V3hHQ0UrcTNhRUJ0U0F0Um5VWTM1dlEvazNocm9QZlN2ZHlrb3FRT01oVHF5?=
 =?utf-8?B?eEtEUUlyT3JBdDA1VDdiQTlmdk5QbGNaU2pwU0NTYVFKc3pLQkpYTmx6a0ZT?=
 =?utf-8?B?dVA2eTFKb1UwL3l5SEVaMEwyVUFJSVNjV0s2U1NvZGdRTUpRLzZaSXBMc1VR?=
 =?utf-8?B?aVMxUk9xQ2Z0VTVGMnpPZXhncENEbmJUM2Q4TmhhYUlzejRRa2xhaFR2djhU?=
 =?utf-8?B?SElreUwzVzlmVzJ4TUVFVmNXRThLMEJaNlUrWko3WWFtaGVxeWE1b0R5WHdT?=
 =?utf-8?B?SlNZb084RWNIWEpyMC95d3NhRkJpZ2RTZHlBOGUwRkJaSVZtUTBLMU1XK2l3?=
 =?utf-8?B?WExqU25TVVRUTjl5bG5sVUhLdStFU2tkaFhFVUVwQ2lEdVN6a2lla254OVYz?=
 =?utf-8?B?OFJNVFRiZlNSYlF1Lzlvd2lYQWRrakF3MlZCY3hsQTE4SHJmcUxjeDdYMUF3?=
 =?utf-8?B?R0Z2aFE4UWNTb0w3N0FTTWV3dVlkd1hvOUNwalBmSjBZVFpWQThxaTNXVWU2?=
 =?utf-8?B?ZnczRFJTVXFPcy94SThzVUR1SFVxNTd5NkxvWWsxNDJjTFVHSlM5WVhSQnJi?=
 =?utf-8?B?RlVHUnMrejNiY1lBS2xVYVZsRmRTQmYrVlVPM0tLMEtpaWZNNVpKRGhYWEJw?=
 =?utf-8?B?Q0k5K1o5UzM0aTBFa1VqTU5LTnVXMyt0WHplSjlHTkdqMEpPQUE0OXk5bkVj?=
 =?utf-8?B?ZGx6MW83ejJUQmR3TXg1VExuUjdrREV6M2xTQXpHUk9sMW1rbmUzR3cxSGJj?=
 =?utf-8?B?Q1RJN0pYTzdUTFpLVXJ6YWtnOWJkekxQa2YyREtOckpmMGgyUGpDT2ZrYkpH?=
 =?utf-8?B?bkpMNlNCN00wallJR3E5b09FQWpaSDV5MVRPb3BHeHdGMDVpWlBiWHNub2V4?=
 =?utf-8?B?MlU2YXgvZXFPYkVrQXE5SE9kKzJNckJmdm1NRmpCRC90VDNPNkYrTTBicHJB?=
 =?utf-8?B?bUdHL2t6YW42amtBYjEzeTFxV0JiOVlCa2dsdUV2ZGFsVmg2c3Nucks4dkdJ?=
 =?utf-8?B?T1FXa3cyeWNqRmVMU1B0Y2ZsWnJXYndpRW52djBsMU1mNGVweDFIN3RZa1NN?=
 =?utf-8?B?L0NoQm9vSDNOWXpaZHBiQ2JBQkhERW5pdkV5bXExWGNoeHdPWkZ6NVhKbHNG?=
 =?utf-8?B?QWNka2tNVmV1aWlYR2psRFZOWm91VGNkK2V5UE83dkZmdFMvWWJ1dHZ5Y3B5?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b52374c8-082f-42ad-b8c8-08dadc677a06
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 17:37:01.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnXYMFePtC0cvVAVVb22GYpR1OJnbbisUHDL7ICYsoNCqNoydiJEmsYLu9UQ7ZNJINqN735lgJrRFLDiUSsH4ZWzRLpCe1ZE9t91B+RassA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4546
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

Hi Fenghua,

On 12/9/2022 6:18 PM, Yu, Fenghua wrote:
> Hi, Shawn,
> 
>> As a temporary storage, staged_config[] in rdt_domain should be cleared before
>> and after it is used. The stale value in staged_config[] could cause an MSR
>> access error.
> 
> Why should staged_config[] be cleared both before and after it's used?
> If it's cleared only before it's used, does it make more sense?

This is something we discussed during v2 of this fix.

> Usually temp variables are initialized before they are used and their values will
> be ignored after usage. Especially clearing stage_config[] in double for

Ideally temporary variables have usage that matches their lifetime - variable is
created, used and then freed. The staged_config[] array is different in that it
has temporary usage but its lifetime matches that of the domain. 
I agree that temporary variables should be initialized before they are used, but I
do prefer that we do not leave stale data around, especially since stale data was
the cause of the bug needing to be fixed with this patch.

> loop is pretty heavy code and an extra clearing stage_config[] after usage
> takes unnecessary longer time.

Could you please elaborate on this being heavy code? The clearing does not involve
interacting with the registers, it just clears the 3 entry array, one array per
domain. This is definitely not in a hot path since it is done when the user
initiates reconfiguration, either by writing to the schemata file or creating a new
resctrl directory. I thus do not see harm in doing the clearing after configuration
to ensure that no stale data is left around. I would like to better understand your
concern.

...

>> a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index e5a48f05e787..fee8ed86b31c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -78,6 +78,19 @@ void rdt_last_cmd_printf(const char *fmt, ...)
>>  	va_end(ap);
>>  }
>>
>> +void rdt_staged_configs_clear(void)
>> +{
>> +	struct rdt_resource *r;
>> +	struct rdt_domain *dom;
> 
> Please reorder the variable definitions in the reversed Christmas tree order.

Could you please provide more detail on how you would like this to look?
Since the lines have equal length they pass the initial ordering requirement
so there must be some finer grained requirement for lines of equal length?

Reinette
