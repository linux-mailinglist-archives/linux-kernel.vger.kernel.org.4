Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0C3612E35
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 01:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJaAPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 20:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJaAPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 20:15:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DC3A1B7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 17:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667175352; x=1698711352;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DaSkmFu4wpm6hZJs7sOCw4a4lgvuOmlG/NCRg7SzPt8=;
  b=GYJc/en3jn4NEoVS8mx9dBgouJcB/mm1ygfiSPYrAr4msmqhD096iFl5
   1ouJBIu5VWcdzBjiZW2N4WEviKg5aiCvXPzNOmumIZFFA1bx0MZP7tsW9
   RyH1U1DYtJiAaJWB5DoIwk1A80bqkUwinq/Uw5aVDuCMA7zJpavSMFW4H
   XqEBcQRirFdADKGJzJg3XkzMVR6dCBPG9/vfWG4o8XjpYTAJGthFzHjgg
   dHJRl4TVJjZxu6jQWrjgkZ0C5PyXaba3LXgJSJOZcXR5PJujXWmnl0LCV
   YrQ7cVe7HTmtBTKbbYeUWp2TpAH8a+tguUQlNGx1bANKeazI8EJxD8p8k
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="395106035"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="395106035"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 17:15:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="696818106"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="696818106"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2022 17:15:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 30 Oct 2022 17:15:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 30 Oct 2022 17:15:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 30 Oct 2022 17:15:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaRJcQG0pQxsW9ps0hSCoj0BgDlR/duG3K9eZoUvNGI7jWd3L5JwI8rVNW51FX7DwhjSQBRW0CPzwrYhwsw/TZIymAl5YAOFqUFDoGpj3nQqx8ZfJp3QwgPjXmjd7olbAmo+T2df/qkkjcKw7Mxognbih/dN/+FRsXbUjxv/0K/6dpLCY+49BoPYr3PPmb017s9AutaR65Atesfi6USXXDESS64pCP+ZARpsw83GTBwyukyZg/Dx1Xbdw8ILEpZ23BZYt5jw5BVXRkk5AirH7DL1eJ0I6+hPFIYIpt/WwoIzQ0MW+AWVYw/VDS8JJtVF1uoPIqOB32FxDdJ3FEjJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8a1xxFPwY+P1DD7FTE/PI8OGJeY7GR34kK5vwdweyhQ=;
 b=UEgejRU5TDgGikNDtqHnoR3kwD2pAwR04R0V6El53GLq4Jv6rYQLVK4NAb4t5//OSqJozrvLRQq3E8MUyCKd0fyqmpY2RsZRktN9qR9zeF7GIqAsn5A5Ik6U9MiSfMnkATdscrExiCaklsVXXR/zscN69W001ipXZcQkPHQN99Jrso3Hp1dXGKvcGiB22JhtAik9Wbq+hmMNy0lhS2vH8s8jEvS3dUn9HP3t7KePKyIwcWNWqZlhwyRGJ8C2MYqzkxg71GM5c+qX0s1ow4o8p8/4lZqUS0OGKCjZZFg+E069DW3PIvyId3Rd/Qsd68Sv8Qh1h816N8Bc7uPT/CtgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 31 Oct
 2022 00:15:47 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3fb1:a450:2263:755d]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3fb1:a450:2263:755d%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 00:15:47 +0000
Message-ID: <7afa3099-cc62-b439-24ea-4d04f03ab402@intel.com>
Date:   Mon, 31 Oct 2022 08:15:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH] x86/kasan: map shadow for percpu pages on demand
Content-Language: en-US
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "kernel test robot" <yujie.liu@intel.com>
CC:     Seth Jenkins <sethjenkins@google.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        <kasan-dev@googlegroups.com>, Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
References: <864b4fbe-4462-9962-7afd-9140d5165cdb@intel.com>
 <20221027213105.4905-1-ryabinin.a.a@gmail.com>
 <3a372c25-7ce1-e931-8d7e-a2e14b82c8f0@intel.com>
 <c6fbc75a-4e8c-05f4-c1d9-53693a7c604f@gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <c6fbc75a-4e8c-05f4-c1d9-53693a7c604f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: be0afd49-ff36-4c55-4d0e-08dabad50f75
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVijRGgEtHsTPAvkwVwgLnmej4ZwqxVk9dd/Yeq3huP9utimAo5OQjFnrzqecp3uIWQ7SQFT1Qz2juM4C8h9fV4wWghFJfmNxp5OjFyt8za4y/iSlJ4DwnAgUn4j6hxzXK/c73uGqUgkJEtdmUsR9yy/3oN7IRA1g5mL+YddiJhuZUdA24GjClWjd7kDMwy8ckycF6eiuddZg8XZkBj/k/AJbA9ZDOTk72KK91V67E3JGDn497K2eHvZLiDw/UX4akbT+MXhdMgWff0WIG/O1vWR5mIXx12uMbBGy/edHKgug3Ij4ljTMxBh3WcUpX23sUozM2GpuJeZ8/02sa29ZICVJ7Avd/83N1hj6qBw/O3RqfIWQHlhzv+fxdM2cyFOT3IWcrdOINk9nACpfCicSnJfZPz8tn78DYGDzrckBLjaKfJR6yqJ2X3N2fczzsF4axBSGIcrC2TKqBy1il41kDp9JciS/7k2+VG1/4i//588GtGwWsU1EpEYUSkGjX+C6PT4zBMRErcUZDpm8NJnYmuwSi33YwiUxRm079tjcBcEUIH3fnq9aDERSJULQWarCK2c1jcrmryGzqx5Doh/CokbxK9zz/LaQ7OxipNdzxWHS3hq9cJ51mfhLhLAM8nw3C9jWGWd2oUNgIEx6JECbKRFXhAD3M+Y0YQy6WFHGMrYbxXyvUYtDGu95PsuO5VCVH0y/swOHK0Nu8VprJqkkIq3KNLo5a1rrMaytS6VHScSBy60YsxE4kHA7JOiG03IKvrZyGAZMU4pPYGPGaibTZqfgLmS34/lFTfUJ/UM2xA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(36756003)(2616005)(186003)(6486002)(8936002)(82960400001)(478600001)(66946007)(86362001)(4326008)(66556008)(110136005)(41300700001)(83380400001)(38100700002)(5660300002)(31696002)(66476007)(7416002)(54906003)(6636002)(316002)(8676002)(26005)(2906002)(6666004)(53546011)(6512007)(31686004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1J0bDdtaTZpZlhYb0puVGZkOWYxc0FRYkk0V25Kb3RmcVBQNXMwZ2RScmF2?=
 =?utf-8?B?MVczemR5N1gwU3V3RnprVittQkRmQlFJa1d1TDRwR3gxRktlTjZPUU5yWTB3?=
 =?utf-8?B?ZUhpVzJCc0UzTXgzUDFidVVXbnRCbTdBTUxvcDFjV0p0ZFY1OE5HMjEvNkdm?=
 =?utf-8?B?TkpUQW1SK2xHeU90NjV1dGwzci9UNTcvbDZHVEw3SFJtV3E1ZXcxYjFDbTRj?=
 =?utf-8?B?ZjQwbnNQT0w2blBVUllCUjFRQUNKb3B3dlFzNmhZSGxYdDNVbUs2SHdsYnFi?=
 =?utf-8?B?eVFNSXhxN0w1NmsweGFPRzBJWTNHSmltR0J3VTZuZ3Q1Z0dxVlRRZUJrdFRz?=
 =?utf-8?B?YmN6SzJIK1c1dEE2aUNUcWM5UDh6SjNOcXFIbDNDcFZJRmRuaWdlbmt6Tzk4?=
 =?utf-8?B?ckVrK09GVHpWcTgxdGlMempPeDc2Z2FPZEdxZit0a3hldWVvNUR1bkh1Vkxp?=
 =?utf-8?B?ZWdlM0F2eUJ6QUhiR2NvUWN3dlpucks5SlhnT3luMkVVeGVpZDNQL29haHRo?=
 =?utf-8?B?dnZZVERLOHZVV2lBZ296Y3RPQnJyZjlERENnb3VzampRQ2d1d1VJQTFHRmI2?=
 =?utf-8?B?enFBYzZ6Tk5NYnFhZlp6K0N6eFlWVXNubXZudVROaVNIVVZtQ2o2Slhkenh5?=
 =?utf-8?B?bE8vd3lnVjMwYk05R2RvZ1hNV2p6U0VTUlFSd2NpNVNGb0hWZnkxUjAyZ3Jq?=
 =?utf-8?B?VlVhbGw2RjRXQWpraUhJN3lJc0ZXMDltNzlMNTZVZ3p2M0Zyb1UwbUxOYWd2?=
 =?utf-8?B?NHgyMzBCMEF2ancyMk1ubGVWVENEZ1B2KzNueFIwNStTcGlxc1p2bHZ4Y1F6?=
 =?utf-8?B?MGtSQ1g5eHpDeVcwNnRpU1J6MTNsYllRaHhmc0FUa1VLQnNOYUw4MitKeWRV?=
 =?utf-8?B?QWFoWDRrd0h1SWRPOHhCM1BTVlBXNW5lOHh2VWovNXVpQkNjWkZ3S3BHQmpX?=
 =?utf-8?B?cWZIZmtXZ2kxRnZ1czZPbkhGeFA3VzBtenV6ekVZNWJhRkR4Yjd2ODRVRXVi?=
 =?utf-8?B?V3dnWDRzSUxUY2ZkVHUyN1I3T1J4Tm15UHJXSUFDbkMwODAwYTlReWlqMHBR?=
 =?utf-8?B?YXFDRVJaYlBLZ3poMFhEZkYzU1hBYjdyOHpUbXZNYVRNL3JGOXBQQ01nU01p?=
 =?utf-8?B?Q1UyaEJOQXdiV1FTdUlpTHVkZUhqZlBYSExVT25Sd0s0aHIzQTFDVTMwSnNv?=
 =?utf-8?B?RlhuNWFEOGsvU2xRK2Rpbm9hSGdkTC8zVHhQU245UmVjcThPRlFPVkVaSjI2?=
 =?utf-8?B?QXp2cG5DMFgvRTlrdTlQVC9sTjZEUzMwL1JxM05yb3QyQlN2R3NnMzBPQTdr?=
 =?utf-8?B?bHdrMFNyTWpoL21jNWJMNUZmd1l2RDZIOWIwS1g4NW5nYW1kZHZTRVp1OEZy?=
 =?utf-8?B?bi9hWHUvR2ZUY05YNUp2TDRIRVl2bXZrbWxZR2tMSFlpNGxUN1lQbXhENzQ2?=
 =?utf-8?B?ZXRBMUFXZ3dFMFdJRUFEaWJJNFhqUXJVelJVbVVSa1hEUGpQTXF3d21xcFRt?=
 =?utf-8?B?QVJpcnBTVEhZb0d1UVJybitWejhtLzR2Z2duM3M3dEptUFI3SENFcVBrNGdP?=
 =?utf-8?B?UjFDK1UzSnM5THd6YTdpTWNYS2xBL0YwWlREdnRhN0w2aTErSER5Uld6MXF3?=
 =?utf-8?B?UFVhaDIydkJGQ2pRRk52bnNQdGc0VlFMYmQ4SnU2OWdoaTFBaHROalVSQjls?=
 =?utf-8?B?eVpaNDMyT3ZJaWdYaHpVV08xZmJsYVovSkxUMU41c1E3ZDFKZWNZV0lmMStV?=
 =?utf-8?B?aHlFaDZ0THZqWjJEOUdYNGE1Rmx5aUlvK3psWDRINmJkYUJuNm1ZK2R0RldK?=
 =?utf-8?B?ajVIMU0wM0M1TmZFaUpuWXBmQmJFaXJoTWEyampGWDZqWTlJZzVZTWc2dDh3?=
 =?utf-8?B?aTg1dDNwZVROQWZkMTFabGszMmVMZk5TRk1mditOT1YyWS9FaW9RV2VJNGxR?=
 =?utf-8?B?QzM0NklzeWFUUzNtYkhreklMaWlDell2aUhWdWNUYXRPUTVQc0U2NW5MYm5C?=
 =?utf-8?B?UFBlU3lEd3gveDlJVFRDYVBkazdGc1RTZ2c4Z0dXKy9QQWV4UjViVkRIS0dC?=
 =?utf-8?B?UzMrMDBKRGtPQXJpSllnY0RVeGtYSWJUOFlTYkdZbmFqRS9VbW14aThnNWN2?=
 =?utf-8?Q?UZ/tlq9sd/bDS0WnSSh7veC1u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be0afd49-ff36-4c55-4d0e-08dabad50f75
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 00:15:47.7742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7batv5seX7RlumUPYq1q2UTkzkX6Gna9kDxPYq4mTdSB/WAwrpjC/+58LHv+b69A8avXQWPX1JOuXi2UK95bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/2022 10:20 PM, Andrey Ryabinin wrote:
> 
> 
> On 10/28/22 05:51, Yin, Fengwei wrote:
>> Hi Andrey,
>>
> 
>>>  void __init kasan_init(void)
>>>  {
>>>  	int i;
>>> @@ -393,9 +405,6 @@ void __init kasan_init(void)
>>>  		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
>>>  		shadow_cpu_entry_begin);
>>>  
>>> -	kasan_populate_shadow((unsigned long)shadow_cpu_entry_begin,
>>> -			      (unsigned long)shadow_cpu_entry_end, 0);
>>> -
>> There will be address in the range (shadow_cpu_entry_begin, shadow_cpu_entry_end)
>> which has no KASAN shadow mapping populated after the patch. Not sure whether
>> it could be a problem. Thanks.
>>
> 
> 
> This shouldn't be a problem. It's vital to have shadow *only* for addresses with mapped memory.
> Shadow address accessed only if the address itself accessed. So the difference between not having shadow
> for address with no mapping vs having it, is whether we crash on access to KASAN shadow or crash few
> instructions later on access to the address itself.

Thanks for clarification.

Regards
Yin, Fengwei

