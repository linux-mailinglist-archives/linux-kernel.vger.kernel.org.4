Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB7B610060
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiJ0SiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiJ0Sh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:37:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3849410B;
        Thu, 27 Oct 2022 11:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666895878; x=1698431878;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=amLNkMSlyqeQG7y+M0AM3wkbWQ2CXAtma/ICaKGuhzE=;
  b=criKZoT6VFfSZlp0lmq5Tzuc+L4yliZnF0OyxLnJUfGbGWbu7SsjrqgU
   uloihfwpZGieVl93MaO0NurpRDnoij3RtSGuC6RfQZS39gBb2lYNCmsBA
   JJi5lxuBq1+ebCkEVNjpNd9Ik2EOcn7r3PG6ruockDukjchhlZRLkRIpQ
   96NMMiF04RyxlZPz10oOIxcaMcDP3q/rlFI0frHxjrR+wBIlT0UdrzmI2
   /FFGV6OQw2NlG4B5s4MmN1UxGuOiT5rbr1G5sHZIK/9R0kKLF2AzNtFy0
   T/aJDhQRr6AXGAeFIxmaZgNTfCrDDAN+kRD6ovWwiugbH5A4O9gQ89IQO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="288027426"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="288027426"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 11:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="665786227"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="665786227"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 27 Oct 2022 11:37:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 11:37:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 27 Oct 2022 11:37:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 27 Oct 2022 11:37:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5NIr377SqWgSZwKYVgJTchEcyvnKdu54jsc4OC386kuNPtvJ0iScqpf8AibHy+JRu2+2u6rSBHVDoDdMNtqioeHkZ2YXW7HsdPzwxcxdCoANyplu2nTgWkpAcxdpghzEylz+cQpmSEswK5z7TAW8MtGrbLMdPrFqqy/3isWIVqDcXOQLaBzRVvh/A+ZCCQ2NghpNOhh9KWuxBapNvEkg6tYfAKoxBkx9atB+nP9LMdvaaqg6rhMEBgfTNRms16dEZGMWou4plg3I9SQagn6DXDS5cdBcdn1/pfjBdIUJ5m41/QeSnbBoOx69GWmhvV8AKLEszi2YDFZJnepufYnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5NsZ+V7CLtqqMaXkFWgx/GvaEjCeVyNEmRgAvkAiwE=;
 b=DoHgcuYpkqBo3sMQ2Gvb4YPjLhAhXZm9plXuo0vCk0EDFRzsoODjK9QH/5iPqrk+AKq1kwVBBg2aZHknQQKcJdaPHV0z9psjYipL8dhVBiBgYxaI+2W6vABi+2jEj6DVIjRj/XVK6DKC6L9I0sqiWmQ+WDpDCWiz/EWLRZmMHSOMlVGX2W8wjPuWw6s8Z81TA/Q9q4BcGgRni53wHZCk1XlvEeLzvtWxxNKlF6+mdOndbITwspXNL8sPS9OUZGfV8MNu8KxbAcIDQDOpQcDm1UT2sgWpQ3W5W5cRnjzhGZrwfVKwcdWsN1+tNav3/kjzpdxdEwqHQ4s823u9AiILog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW3PR11MB4633.namprd11.prod.outlook.com (2603:10b6:303:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 27 Oct
 2022 18:37:50 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5746.028; Thu, 27 Oct
 2022 18:37:49 +0000
Message-ID: <cd4c5da6-6ada-67b4-44f6-6d5796fae8c9@intel.com>
Date:   Thu, 27 Oct 2022 11:37:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v7 05/12] x86/resctrl: Detect and configure Slow Memory
 Bandwidth allocation
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
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604559954.5345.14619487558472213422.stgit@bmoger-ubuntu>
 <c999a7f8-b083-72a6-ff07-201369339c92@intel.com>
 <ef734fc1-8a51-4c60-f73f-2d71fcc54b30@amd.com>
 <e299ce70-ebca-a05f-a1f1-aed6386c379f@intel.com>
 <fbb32df7-df49-7a51-67d8-a8abfe7e1c3f@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <fbb32df7-df49-7a51-67d8-a8abfe7e1c3f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::14) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW3PR11MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c925f7-ba45-44e4-861b-08dab84a5980
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JrA+4++4Qp2zFpmscKreTC+jjHkRk4mg2dWqH7rIZlhsfJDwOsGshEQYfo3i5Ogg3uO6k9RurcbmrN6YRvD2NLAIM/2yPT7LV1TYNz3TtXKiwNZl0RUsLmnHwA04ge/WMtj/nW5Il6HlHyb/+O/gAeb9JGHUcvdg0xu7KMfr+jPgDttvfzycqnRAFZMJQi6iLvBhrP88LUqPj0HWeyDbK65/geicijbpFfjrJISNMLYE4UF0G/mtPoO3oNXbid1+FhNtOipiZhBanTvzZ0ixHB4KMChEEmGtfoRXaqWAx9Qkv3GtjHMELRgE0gs/TEWNWiK2Us50UK4LvA3InkgiZsmtRayv0paS/8hfQsbUFt8uydSZyLCGkZEiZAVf1Oh3FXc789zaJweILWf2IU/gsMzjLL5uCuU3UH2Co7Vew1eUOODDwvDCRW3fmD1JJ8JZtyyvrwi9eNaKvD8x+SGvf3YgcOLMUZEImtSVgODuJ+1yUhKvMDItN31Hlin+Em+SJaaPozvtrwmK4bjp8eNMHCzPsz4OAwBuFrMPI44p5cwpUsbvpb1P+WHRLrehimW2U34xm6J0vYUHOXyLQyV5+cjmvS1iwIAJSnz6KDmLUGrXvr1qTHz4rEplJHZFlrBTEn6rXHXdo7EJ2D1r+09YPZU7HHS5TfWADFChL578TkRMvKUB7Tz3JzVUUnauZA2UfC1ZxLGHATiriY89mEBX9n/7WCJuntZLmoXuQUEw1fEZmRnhXSesJaX+TkxAksgOAyT9XVo0Ee09LVeqeCu/+UyPgoHOkB72nTnGdTvcVmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(44832011)(36756003)(6666004)(41300700001)(8936002)(26005)(6512007)(6506007)(53546011)(4326008)(38100700002)(8676002)(66556008)(66476007)(2906002)(66946007)(31696002)(86362001)(316002)(186003)(2616005)(83380400001)(31686004)(5660300002)(478600001)(82960400001)(7416002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2xiSmNBSU5vQzFLQmU4elZUVUpvcGN6aUlMY1UwMDlwY0pWU0lueUE1YzNT?=
 =?utf-8?B?amZBQzNOemdEVkF3akowVFZRSGJjcFlLeFZjZXduWlNBcHRXRjNDTE92R1I4?=
 =?utf-8?B?Qzh2T0JIOTBwb3E3MlNHNkM4WnBWbG9IenpCZXJxTW40UnZRZkRKYWI4QW5M?=
 =?utf-8?B?cCtWcldPUU5DLzdiVWoxUTc3NFh2ajVXeEQyYXY5T1pyTTRhd09FcXVxYis1?=
 =?utf-8?B?a3BwVVFnMVJEMERHZkhMUnNCaTQ3TmNuelhVdXNYOUNxU2JkNlpQdG5WSWdo?=
 =?utf-8?B?eDF2b3l2M1ZrbmJTSnBPanl0eW8zMFlvNDlWZWtrcG1lYldLMmdMeGdVWlZj?=
 =?utf-8?B?TDZ2VFpyVHcyTExnVjV4QmEwK0t3V2NzV3JlcW9JZzFUTm4vTWhMNkE1ZVNT?=
 =?utf-8?B?NW1hUVBINEZKaUx6VkFMSCtFTTlGN2phZFhONDRsTmpJOG4wVTJOMnBjbjZK?=
 =?utf-8?B?TDN1aDRsTzFPZzF0Nno4djlHK0c0LzZTdlhFd3dibXNmajJoNFkxUmdCb29X?=
 =?utf-8?B?TUdMNGVzWmxlVHdFdnhZRDVVZ2wxa1hwbjJrU3FEdS9XSU5zU2w1aHV6Qlph?=
 =?utf-8?B?MkFFOEFCTGdieWhXN2JrUXltVUZ2eVhuR0RJT0g2QVFGdG5MT1hPYlc2anUv?=
 =?utf-8?B?bUJsN0xLRVB6UE1rNFJOMFV4aloraE9kQzJHcmozcWZWdytack82cGg5L1Nz?=
 =?utf-8?B?bWp5R2RKR000enBMWlNNTWNZZmdkMDhxUFFTM09rTkFLa1I2NUYxdWdhREc2?=
 =?utf-8?B?Zjd0c2xMMHJsejROUXZFeDc2Z1FrVzdGTUVLWm55SEF5Y1lMZ0dPdHFHVlU1?=
 =?utf-8?B?Kzh1bDNsYjNvbzc2aHZEYS9yQkhMOWh5U2JLT3VxTk82OHNWbTcvTDF4ZUZK?=
 =?utf-8?B?TExrYVlYRnFWLzBLUk4zMmkvbFAwRVdxaldWeS9oU0VtZVJEZE90ZW82d1BH?=
 =?utf-8?B?RWNYLzNZMUtrVDRvTE10aU9DbnVpVVlmY2hudGVtWHpKOXVSc0J1aENnSHAr?=
 =?utf-8?B?b053N1l3YldDM1RkbEJhTkpyQk1NTTgvUHg4aWE2NU5UeHp3bmZaTnNwS0tp?=
 =?utf-8?B?Uy9xcG9RcEF2RUlySlZ6YkxJcG5pYitaaXBuTUVNZFFJbWs3Uy8vSHBHa2I2?=
 =?utf-8?B?TExWS1o0WURLM1RTZkRrNnpJSTFSZVcxTHRTRm1YM3BQVDIvekJua3ozbk1w?=
 =?utf-8?B?bEF2ck85Y3k3VUppWk9DUEUvSmtsV1lUY2hwRlBOdXNzMFpZbVYveW0vNkVt?=
 =?utf-8?B?M0lLUU54alFEdEcwTS93RlJISDJ1YnEySWtaL0JjMlNCZzhoUExnbzlYZEVj?=
 =?utf-8?B?OXZmQ0pZR21iTExkcUpuL0hXOVY3NzYrNnorYnMySVZNZnhMbFRCeitYeHZK?=
 =?utf-8?B?aFVsQTRkUFJYUGRqelZBZVl6SnpDdUdLaWtYdnBmS1FjaWNJTzVVOVVuUkxo?=
 =?utf-8?B?SFU0bzR0UFNKRlp2UW13T1JuTVAyTTJhMlkyUmd0QlVuLzgyNnpyV3c0M1hr?=
 =?utf-8?B?Y2g2L1E0NWlZZUIvMStWb1N4Y08xZHhSZEVtZjloblNRTFBWRzR0a2VKOXVt?=
 =?utf-8?B?TkgxUGhGaGRYcnVyY0UxVnIyemwzSE80aFAwZ1VadFpISmY1alE0QmxaYUg2?=
 =?utf-8?B?WDdTTUgrMEUxaXFEUWpPbldMeWpXdFpZeGtUSmdlSUVoaGtLRkZnN1QyamhR?=
 =?utf-8?B?YTRZT0tXR01CZzhPV3YvNDNUZENNSkpydEFMYzEraHhKKzBMMkVFM20zQWpm?=
 =?utf-8?B?dkRielc4bmFEVmZwenkvb0NLc0RSeHRPay92bm9ZTW1UYklsOW5TZk1aNHRs?=
 =?utf-8?B?eFFYM1AvbGxGNjg3TzNEaThaUzZianBudlFPYk5LcXJDMHNrSHY5ZXdpb0lp?=
 =?utf-8?B?SGUrOXN1eFRWUWtka0JCakI4OGhVWmpoWEEzWXBMMjZSaTNXbWFZanhKTVB5?=
 =?utf-8?B?RUhNellGYm51YWVkT1dWb0VJTXcvcGNUT3lZd3NxUlAwZWlackdCSWxrYURW?=
 =?utf-8?B?dWdzNnZHVlFHbEY5Wkw2MCtmU0RnMmgvSXFOSUxwT2crbk9KaE1KbHZwdjRk?=
 =?utf-8?B?KzBsd1lsNnVDYjJBS0hTSVBXV3FKSmp4VkwxSEM4SjJ0c3FkNjdaZTUxVGxC?=
 =?utf-8?B?UkcvZ1JoSmIxSzl6WndaMmhGSEdXRXVGMUZmQ3p4K3UzTHFhMHRaRU5UK0ZC?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c925f7-ba45-44e4-861b-08dab84a5980
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:37:49.7532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CY5UDltILWfGSLbUNOzADVh7WcZp2Qnzh37UPqVo+saTU3QIvyT/dpvBtS0Ze7kIwO7WiZhLUFtlaJ7CBsPogo4paR1rMoB7zGSD9t0+5hA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4633
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/27/2022 8:30 AM, Moger, Babu wrote:
> On 10/26/22 15:23, Reinette Chatre wrote:
>> On 10/26/2022 12:07 PM, Moger, Babu wrote:
>>> On 10/25/22 18:43, Reinette Chatre wrote:
>>>> On 10/17/2022 3:26 PM, Babu Moger wrote:
>>>>
>>>> ...
>>>>
>>>>> @@ -2845,7 +2846,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>>>>>  
>>>>>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>>>>>  		r = s->res;
>>>>> -		if (r->rid == RDT_RESOURCE_MBA) {
>>>>> +		if (r->rid == RDT_RESOURCE_MBA ||
>>>>> +		    r->rid == RDT_RESOURCE_SMBA) {
>>>>>  			rdtgroup_init_mba(r, rdtgrp->closid);
>>>>>  			if (is_mba_sc(r))
>>>>>  				continue;
>>>> The above hunk and the ones that follow are unexpected.
>>> I am thinking the above check is required, It is updating the
>>> staged_config with default values. Right now, the default value for SMBA
>>> is same as MBA default value. So, I used this code to initialize.
>>>
>>> Did I miss something?
>> As I described in the following comments my concern is related to all the
>> software controller code still executing for SMBA. Yes, in the above hunk
>> SMBA would need (some of) rdtgroup_init_mba() ... but note that it contains
>> software controller checks and in the above hunk its call is also followed
>> by another software controller check.
>>
>> The software controller is just applicable to MBA and these checks have been
>> isolated to the MBA resource. Using it for SMBA that does not support
>> software controller at all is making the code harder to follow and sets this
>> code up for future mistakes. I think it would make the code easier to understand
>> if this is made very clear that software controller is not applicable to SMBA at
>> all instead of repurposing these flows.
> 
> Yes. Understood.  How about this? I feel this is much more cleaner.
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e5a48f05e787..d91a6a513681 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2845,16 +2845,18 @@ static int rdtgroup_init_alloc(struct rdtgroup
> *rdtgrp)
>  
>         list_for_each_entry(s, &resctrl_schema_all, list) {
>                 r = s->res;
> -               if (r->rid == RDT_RESOURCE_MBA) {
> +               if (r->rid == RDT_RESOURCE_MBA ||
> +                   r->rid == RDT_RESOURCE_SMBA) {
>                         rdtgroup_init_mba(r, rdtgrp->closid);
> -                       if (is_mba_sc(r))
> -                               continue;
>                 } else {
>                         ret = rdtgroup_init_cat(s, rdtgrp->closid);
>                         if (ret < 0)
>                                 return ret;
>                 }
>  
> +               if (is_mba_sc(r))
> +                       continue;
> +
>                 ret = resctrl_arch_update_domains(r, rdtgrp->closid);
>                 if (ret < 0) {
>                         rdt_last_cmd_puts("Failed to initialize
> allocations\n");
> 

I do not see how that move changes what is run in the SMBA case and it ignores the
is_mba_sc() call within rdtgroup_init_mba(). How about making is_mba_sc() more
robust in support of your original snippet?

Something like:

bool is_mba_sc(struct rdt_resource *r)
{
	if (!r)
		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;

	if (r->rid != RDT_RESOURCE_MBA)
		return false;

	return r->membw.mba_sc;
}

Reinette
