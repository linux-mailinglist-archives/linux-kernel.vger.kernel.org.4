Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D81E6DE0F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDKQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjDKQ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:29:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A0F40C8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681230591; x=1712766591;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GDUTIsdLhH8IzZo5ytavKPyQU1gYBE0RWeVa5YRyW0I=;
  b=iROg6mGIrv4pnVPXf7Orlq8U/xBruE+NKxcbzNbywKK78WYhq49dUOkE
   2Of5uaqIZg8C8MKcu6erRE4/CN6vVvgE5faRhjLc3/U5ulHBOVwX59E1/
   F7oAgWEZDPRaxJQgm1dthO8mRoE5G70Lm99IP0ITXUzf5JZImNQ36vxiV
   5j3sPIJmGvUFxPPeuquRAhPBoCv2eLEm6267jp8DN7VjquphivENJMBrg
   xTXeJgQH8d54VswdNLe9k4sKnSD3mz6dXVxSPDBQF2lwZrldxtBgEpIOU
   GbwT5UyuA/eR9LRAEQv9vCm2vwNOzdZiv/T5dcwfOblm4G8WUY0h2od7u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="346339562"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="346339562"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="666040018"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="666040018"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2023 09:29:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 09:29:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 09:29:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 09:29:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNKu3d0B7K33Ir5D8T9A/Wk+JEW0Z3yzGqn/ImpgySe16UaTfm8MWSRSDpzMEzOcdcJwxyFMnGAjDxj9mLXb+d6R1y8BphdNPwFMDQ0QpQd5CpuqlZ6YAZQ4AsO4L3CQg7TFrZKsaIlv/RhwWkJLUd/PCBIj9Q9G4hOcn9XOuyymFVoMWXifnACp9hb6/9OHNSHP9OmMOWcBpOD/CYkUtcbFHsbGmtZUhxv+add0ekPI8hcVYZeaLbNxOZ+Enp2KDvxiuJlgSeQAc8sn9SlX9wArqfDzDzSuvaLq4yneZUDlhTAWZsIYVgEIxnFTEqXQxe3XHC5EpElMgs1Gq4kfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrWnpSEwNTDaZpZ4iVrUdD2CageR/cBsFRBHOU25P/I=;
 b=e8Tr9aQKXfWr+k9VLGrIT28pB7MxjWejWoGRdlfwJnWJDYAclMNPA5nzqqVyVEgq4xrl62Nqowan5+2GU1aRT6QEnvtfv1+w3LDWM0ZmjxCk9H+XobfYdSG0smCFMa7ErHlk/5VVazMXDlrdxqiXxHDMM2tt2KW/Wy7X5YG1QrGXD1aTtdUWKzbZOgrtqPybdwu6arkI7wWvmgDx86ERTpjteEded8wpCVyqSwtTuTX1f0O4pKtCtNAqgXUTGWMnfUssTBX1YwWg19bPSgFXuu81CC3diIHy3VoyqItnz1Cdm1Xbgdrgx6jvEcrHSlsM/9fs/dbLJ7HJu/lRem7NFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BL1PR11MB5462.namprd11.prod.outlook.com (2603:10b6:208:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 16:29:47 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::e002:4146:dfae:ba77]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::e002:4146:dfae:ba77%3]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 16:29:47 +0000
Message-ID: <2af114b9-2737-70e5-f534-e60416b52246@intel.com>
Date:   Tue, 11 Apr 2023 09:29:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH] x86/fpu/xstate: Add more diagnostic information on
 inconsistent xstate sizes
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "Chintan M Patel" <chintan.m.patel@intel.com>,
        Thiago Macieira <thiago.macieira@intel.com>
References: <20230405183942.734019-1-fenghua.yu@intel.com>
 <113918f9-0e44-3d46-8b48-028277ec26bb@intel.com>
 <c716e021-99ad-2cb7-44c0-ec8393a3440d@intel.com>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <c716e021-99ad-2cb7-44c0-ec8393a3440d@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::6) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|BL1PR11MB5462:EE_
X-MS-Office365-Filtering-Correlation-Id: 54147e90-0ddf-4a18-8b2d-08db3aa9f714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctW15yNmE0lE06+tDy54WbZtblHJsKtcQWfMIEg8Umx5GPLWEXI/1aLgQTQO6Zh5IJ6nZxDIo/EH37m2WVjOhi3Of0e+LVRlwcUslA6Pi1MYhJxqBzF7XrWDzR65ofz+nXZw9AQhPzuTgqMnof6UlKq/1d3JN/VFYCcJ9vbb+fUnjm7m5oRXvaKZDkj6+cY8W7ZN3k57bVbqY0k+wGt4acYu/ryZsvR4Kqcj8Ju/cRS9IcsZJdjQae5OfAZdRP68+xa03T5r04VpUNWnBAfDCvPYuAzVz9QWGoacAsp6koBXDmch7QjXG3AeiEb/rc6QwtnoLwGqtXaNT26NjZfGi4n1MYLBCOl4HoEuzA5Jk7kw9ptrkp0tvo5MDOZp/OoWAXxZquLbpE3Y/mfDZgLl3qMqb5fAM8f0k4HaYhv4nawUB2WOiuYdWjJUvLYC5FxutlU3niQlbwIFwbpwd22caS316GHuuiHZXKWo78EWlXEbCrFez2JUMw6Ft5bx8S7V9fbbviTANCrioBc+IyiVZ7vYDJXOn7mOReLC4QR9mI9l0pTVeLMY0ATcu7WtB+G0GKlwHd3qRY0fC6ZxCOJLYUZ2OZohSCpzCWTfR2ndr6qhQNSWjuel41hAmIzSleMpwX0pEGI9cUI71qGtfTzQ2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(31686004)(478600001)(6512007)(86362001)(31696002)(82960400001)(36756003)(2616005)(38100700002)(2906002)(53546011)(110136005)(26005)(316002)(54906003)(6506007)(186003)(66476007)(6486002)(8676002)(66556008)(8936002)(41300700001)(4326008)(5660300002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDdMeks2MmJpd2FYeVNvN3JHcWZwYVUvQTUyN1hpRndFR2lTeUZlVmZiQ0tO?=
 =?utf-8?B?WnNid1lqbDdVU29rTXhUTVBleW1Dd2Rvd0hiU3FFRTJNV2Rxei81VDRYQlg3?=
 =?utf-8?B?RXdpZHVKc0twL1FMSHJFaklxcHRmNlBRRjNzalhFd3lvZEhaclBqOFBGeSsy?=
 =?utf-8?B?VUZsQjEvKzUzaEhrVmgvTHQxWkN5U1hQRUo4blJEVHNRY3RZWUtKbitrcFV5?=
 =?utf-8?B?eEZrMnVueSszYURvYnNZelJ0ZEVNWGpEQloxN3Nhd1FqWTB1d0cxay94K1Fy?=
 =?utf-8?B?QjB1VHZraktIaVB2cmdXK1pJN0U1RlFVZTQraHZvaHR5ZHl0RmtYRCtWODNJ?=
 =?utf-8?B?OWVYODI0OTgzL3BYcW5aelk5NVQ2elk4MVJqNFhhYmtlck9VRFB3YUVUUm84?=
 =?utf-8?B?SHZ3YjIxaGs1Zkt0Z3NaQzhNVlYwaWwzbitqK1dybTJsVEZlV1VheWtCUXIx?=
 =?utf-8?B?aHc1b0hCVFJzcGN4S1c1MlhwMDVEYlpEVGgrR3FkMTVLL3FvQy9FbDAxK1JM?=
 =?utf-8?B?b0lnVWZVUzZjL2JOY2pFUmJxSnFpVm9TRGdwRS9Ka2Vsd2x3bXBKRkpCUkls?=
 =?utf-8?B?ZWVnRDkrbVA3S1JnajZSSUhMbWVqWWZObjczY3ZlME1kVUxmdFB1VksyTW43?=
 =?utf-8?B?Q0thMUh6RVVOb29vUlFZOFhrT1JUVi9zWjVnWkhOS1ZQQzBTenFwRElMWGVV?=
 =?utf-8?B?eWVwdzU3aC9rNFZYRmdTNDBIdjM3U1ZtVi9ENjVGU2pLQzF0anp1QVQvSFJY?=
 =?utf-8?B?SVc1bTZSSVo5aWRmanh5ZXd1djZ1aE03UXI2SnRuSWxUeWt4YWtVU1d5Y0ZY?=
 =?utf-8?B?aHNoNUQzSXRSTDhuUVluTmtqVG03MUVzcHVNNEEvZktwNkNLcW96NVgxdnY4?=
 =?utf-8?B?ZUhMMDZRSjJwKzhJRkJPTFpSYVk5UlZZWm5DNDRHY0hhNTBaTGp1NkRDakxv?=
 =?utf-8?B?MGtlZS9Qb1B1eFdOalhmbGF0VTl2Wk5OUFFWanVWQ0lDSWlnL2k0U0trWDJ5?=
 =?utf-8?B?R3lyM3JQSW5aYXUvVHlBRzNmRjBIQVU0QVBzaTRxREk3NnlNMUIxOUdybXRr?=
 =?utf-8?B?bWVTUG5ya2FUTjBDcTVkek96d1F4OE5zRTV0SGhoUGVlTUxCeDNtRmUweVFC?=
 =?utf-8?B?d0JvWTczUHY5cmJLN29QZ2xNbmxDK01GbEJxZFZuNXRZbS9hYUZ2WTFEcDdy?=
 =?utf-8?B?TTFiLzVYUWc1MUYxYXJYN2hCcUxVV0U5QTZMcmN6RFFoQkVWdVJOVXArZ2tY?=
 =?utf-8?B?a1NQcEs2bDZVYjZQNDB0Mmw2b3MzTVNNZzVrZnJ1d1dWR2ZUWUcyYk9pTys0?=
 =?utf-8?B?WUhKUDF4MDVoT1RpU0NneDFZN1dLN2Y4Y3Y0Ny9NZlFoQjk1N3A3TmxDMXNM?=
 =?utf-8?B?KzJpY2xiWU5qZktjbnV2VzNrTnhza3NGYzNyaERtQUNKVkFOMnZwRkg2WVp4?=
 =?utf-8?B?cEFpanprNjFjSjI2b1ZQVGg4NEFSQkVIRWRtazl6OWYzSytmWWFHT0U0YTYy?=
 =?utf-8?B?dFFpdXRTaStzYjVDRUp0c2IzTGw4SmEwNUIwZUpzYmZydDhJdjRQVkV6TEZM?=
 =?utf-8?B?OVFLUXBhN21OcjQzbTd0ejhhN2tXTEdISXVsVGFlSHZBdjV0eGROVDZwcUdj?=
 =?utf-8?B?b2pxbmpZN05IUWlycEJCTGFNQnNxWjFFQ1N3cGN3WmlSLy9KVkQ0cFdkMCts?=
 =?utf-8?B?UE9JaU5UVTc4OHRNM0tIY3pOWWhia1lvQnJ2V3YxcXAzbHMwQVc1ZnA2RDls?=
 =?utf-8?B?TjFObnl5NDZlYVlBV2NPdngrT1hVMVc4MHpQdXhyVU1jS2tTUGx2bXZTRitV?=
 =?utf-8?B?Y3FVNmUxSERZKzZuQ29QdlRRNDdzZi95TzBiNlFieElmMnk1UG1FVzJOUW5J?=
 =?utf-8?B?dzhiZHU5SkVNUVlCZFVrT1Q3N0ovSTBVQ3dEVm9OcE5UaTljRUl5T0JJaWJE?=
 =?utf-8?B?bnFJVjdUNC9lcHhNdCtvY1RFT3AybllCeVFaaUxpL0RVK2xGeE9YeTlMWEZu?=
 =?utf-8?B?ZFJKd3NyUFcxQXd0U3ZHOTlKaVlDS1ExN3hCN1k3aHZvYlo3bkJkZnc3QUIw?=
 =?utf-8?B?bURVT2hQMHdKYXRYUTlUeE8zZ2VsWC9ibTY0V0tTdGxacW56WXBTTmRWSzht?=
 =?utf-8?B?ZVBoWVNWUTdhSmRyNjIyOTc3SVlQSzdVaXQ2b2hCYzNxUi9UVVhPcTY2Z1pI?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54147e90-0ddf-4a18-8b2d-08db3aa9f714
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:29:47.8131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdxyXF/Fc9gFSGVgURYjKRStTkvoegld3/ihcOaythZhJUJNnuJQfO88L/uEhGJIeIRQfscIn7MRi4OdUKkq73LDyVhMpnS1Mk4PUf+c16I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5462
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2023 1:43 PM, Fenghua Yu wrote:
> On 4/7/23 11:22, Chang S. Bae wrote:
>> On 4/5/2023 11:39 AM, Fenghua Yu wrote:
>>>
>>> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>>> index 0bab497c9436..5f27fcdc6c90 100644
>>> --- a/arch/x86/kernel/fpu/xstate.c
>>> +++ b/arch/x86/kernel/fpu/xstate.c
>>> @@ -602,8 +602,37 @@ static bool __init 
>>> paranoid_xstate_size_valid(unsigned int kernel_size)
>>>           }
>>>       }
>>>       size = xstate_calculate_size(fpu_kernel_cfg.max_features, 
>>> compacted);
>>> -    XSTATE_WARN_ON(size != kernel_size,
>>> -               "size %u != kernel_size %u\n", size, kernel_size);
>>> +    if (size != kernel_size) {
>>> +        u64 xcr0, ia32_xss;
>>> +
>>> +        XSTATE_WARN_ON(1, "size %u != kernel_size %u\n",
>>> +                   size, kernel_size);
>>> +
>>> +        /* Show more information to help diagnose the size issue. */
>>> +        pr_info("x86/fpu: max_features=0x%llx\n",
>>> +            fpu_kernel_cfg.max_features);
>>> +        print_xstate_offset_size();
>>> +        pr_info("x86/fpu: total size: %u bytes\n", size);
>>> +        xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
>>> +        if (compacted) {
>>> +            rdmsrl(MSR_IA32_XSS, ia32_xss);
>>
>> This shouldn't be directly read here because of the LBR state component.
>>
>> See the function comment:
>>
>>   * Independent XSAVE features allocate their own buffers and are not
>>   * covered by these checks. Only the size of the buffer for task->fpu
>>   * is checked here.
>>
>> But, isn't that max_features bitmask pretty much about it?
> 
> How about getting IA32_XSS from xfeatures_mask_supervisor()? That's how 
> to get kernel_size by setting IA32_XSS without independent features in 
> get_xsave_compacted_size()
I think what it tests here is comparing the sizes between the kernel 
code and microcode calculations on the same input, which is the 
max_features bitmask.

We know that the kernel code calculates the size based on it and also 
takes it to write down there -- XCR0 and IA32_XSS. Then, showing that 
bitmask looks to be enough I thought, no?

I still expect some acknowledgment of what is coded here for the kernel 
calculation details.

Thanks,
Chang
