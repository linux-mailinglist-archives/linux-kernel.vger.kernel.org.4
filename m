Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D42667DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbjALSVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbjALSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:21:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06C06375
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673546195; x=1705082195;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wh0knOyKT/nJPmoLn7lbFqqZkGep3l2GzfzkWE2jYlM=;
  b=LtVgfJ1984kx5NOoAWRi8D1q2rempEJHK3/wIG0hRj1NqJPMvFVpmOH8
   sq5cq4fNPrGUyRkEBqOAirSETMS4LYUEfyVQ77ajLu4nPh24y3uuny1od
   aHVDxU8ck3qd85FBlihHDoJUA3n5+N5Eg2SDMN8oVYt7RrSvRaP+DS+S2
   TJ5wfQYyNlL4xx4PjOuxcj88OR6SSR+y2Y1CuJm2gZopcpMxoor2A5R/p
   +6RsZRrYJ6jewpNHOonsk5hL7WYZg5k54ffJjMoo3/GtMcKmxZReMb8Ij
   CLUbfYYs5WAkdVL+SGTz3MzojYdbXeEKEPjVNhyoP2n5vSa4wrA6bG0qh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="388269433"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="388269433"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 09:56:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="800310021"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="800310021"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2023 09:56:29 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 09:56:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 09:56:29 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 12 Jan 2023 09:56:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCOdxa2IBOBb3kgInNX/c3nMbQ4AFw9P34XDxT2jqUwBRFXU+WVGFxoo35vS6ZTLwo2cnZ1cooRsTRSvYSTJ2yL87w5ISt3hWnBugH/XS3CQGs4UQru5Ve5nQG+18ks5pHHXPAPHibd3Rl5EnydHmMKXKVDTCGmWVYlVDo9xcu0zAqZPglEQzpHfEeDe8ioABDGYwfI5gCCx4soxwFs6PoI+A9Owvrs3T6TCTdi7SE1t6nrG38rMFP8wz6uZy+ZLThvYcpWIw9xExK6L/8THZM5glsoe1bOQYGICsd+n2NjhPi2GWUie+9zJWuB3CrRzezDVyhf2edAlLyYfEmXYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9hRgAMYjyzkSJOsyVTTUsidY/1ZQMR8BVZfCrm9rE8=;
 b=E4eThGkFd+Dhn2jZWjyYQkxwaHCJpOQt8UMXGoFUWuBndAfbhJsSqPsU6LS21wbp0hPsIxe93uapewJZhXUAFrZCWAy1kxoc2sjjfEGh9UYd/+8c+8caIF8rg5d3EzFp8ocomiiMMhwqvTOo9PwUN8dvlUbsLDbZ7RzEH+fnM1c6sfeWBJu9jCYFbLSxnVpkv63TzCUKpaF9xe02buaeH/Zlarnp0N8FMVbetqPoOarZk975wMGNylkuOmOHTgQgoiZnkDmRTBcZr+12bWME5PyL6/BhPeOUpQO2aHo6VH3F8d2XhQttb/V3TJhlWvqJZponBEWKG3KbiM1PNjWOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by DS0PR11MB7621.namprd11.prod.outlook.com (2603:10b6:8:143::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 17:56:26 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 17:56:26 +0000
Message-ID: <4c1a3a82-b443-ecd7-dc38-ac0574db0b50@intel.com>
Date:   Thu, 12 Jan 2023 09:56:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 5/7] x86/cpu: Enable LASS (Linear Address Space
 Separation)
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, Paul Lai <paul.c.lai@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-6-yian.chen@intel.com>
 <2b523ed5-a809-1354-1050-a4cc415a102c@intel.com>
From:   "Chen, Yian" <yian.chen@intel.com>
In-Reply-To: <2b523ed5-a809-1354-1050-a4cc415a102c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::8) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5262:EE_|DS0PR11MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 520fecff-8f63-4968-17ac-08daf4c6530e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpsSarVQojLO9ukDWz8xAw7a1tx+g71Vtqa4wJSIWwPPm2ge/pMxcRcjiqAwdyNxxWLnZx/uitSd2r2uGezj+v+lEGfy/Y+dUMKv6XJOLZdsE7W9QUsxG0X9ShJfVBqGh+H6l0RDUOh1D+0Onhq8jy5ZCifQzBq1j1Tr2axG+CqYAU+llD1HKZ/Sat6ezef3tTU/EEhJidF6hp/Ry9dRoMVHvJD3Xk7zIJJtGqM9nDsV5t0xMmrAoeYtrVYDjgFiCUMcmoKOpCXrN3cDPdZLBh6LFQd/YSUoXb1qCPCr3hwhCBIEl1gFL1sSfgbMjYDRRXIehMV2shOf99/WoHtwJClBUSSglbW3Qb8KFOxBhhK/c5QtmZ0Fqc26waufFfU8i95WlwaVVDWYNSyDUjRWOKf1n6I7GBkejAT5vmh8yI3c5BoszHlZ8LZeR5PbWzouWKy7JJYJqYPeII6ln2nAVJ8/8nNL8+5uGk8zCgnOkxKrwKCpQWebM0D4ReOQ316QZ9q3jk/IgiF41ePhQrvDcfTCAjtzn+CdlCrAnyvJCKlAXvSXE4iFAdO58x+G8C2Hy4Vj1LulEEGzlUiGzrWa+Bpd9FU4HY3VntFwuHkNuGQNx4Le9/s0c4lkbA1Q+Zn/CdG6wEmRvHr8NlyuB2ztheN5vTFsXRyirzw2/iASuSuRbhllGMlCM8ljlWnrc8AYvnGIMxCmX64jAs4b91RmRCYIidVDCljharQXbq05+1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(2906002)(83380400001)(478600001)(66476007)(66556008)(5660300002)(66946007)(8936002)(53546011)(186003)(6666004)(36756003)(26005)(6506007)(6512007)(6486002)(31686004)(2616005)(82960400001)(41300700001)(38100700002)(110136005)(8676002)(86362001)(316002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHVhWGJhejBrclpndGdXa2R3aS96b3dudVhFOWlTdWtRbmcxRm9naTFTcFIw?=
 =?utf-8?B?ZDM4dEJVbGFNTVhXcllnNkRzVHdXak1HYzhPNDk3TXFHSG91R2o4TTBjNjJU?=
 =?utf-8?B?a2ZPVW1Rd3VTcHJ4cUdsbmVmNGxMZmsyckVWRjNwbkVrQURoWUYrcGt6OHNk?=
 =?utf-8?B?bmp0SDdrQTFuOVZ1Y1pCOXB4NjNHdE0zOXZ5VjdKU2JPQ2NsS2RWVzJCWHNW?=
 =?utf-8?B?cGtlSzA2ZGIzeXU5SFVkUVFBcnZFVFMwT2g4S0xsaTd0dm5BejR3WDVNcEdu?=
 =?utf-8?B?SXBldVI2VUpORGFUc0E5ejRLRTlDVDJXNzRRYW4wcEJ0Zk5xVG9rczZzK3Qy?=
 =?utf-8?B?czd4Tk9URU5YZVpkNWsrbS8rNVZHWFJiNXl2S2hqVVdPWkJhMTdRbzM5WDZV?=
 =?utf-8?B?Mkp4NXdQcVpQRGVJTUJnYm51aTRHK3pZcHNNaFNVOWtJbkprVnZXWC9GUFRX?=
 =?utf-8?B?Q2lmb21WZmVmMkRFQm16Tno2WmhLRmEyM2ZUNUp3cTJ0K2lsZVRSK1A5bUUr?=
 =?utf-8?B?UThQTUNCSXBhNEdTUkpNcDllTktndFludjcwYnY0a2QvdFdBeXlaWTZYWk9v?=
 =?utf-8?B?REJnOHcrWHlFdGxGWi94WVVvS1JGaUZic1ZPWGN0dHZQQi8yRXVUQTg2Y3dj?=
 =?utf-8?B?MlNxMGFjSHA4L0RwK2ZFVnAybXYybUxRRzhJalpUdUhjQ1M2MjFkcUdFMVZV?=
 =?utf-8?B?V1h5ZWlXM0wyTU1iQzh4U3dybXRwTEEwUHhpSTZrN2FNSkg5RjIwVWRZUXFt?=
 =?utf-8?B?dFlpakM5d0k5cWw1UHR1MGZBM2Z3QWJnMWJXcEovOTQ3TTBrc0NKeFlUSmla?=
 =?utf-8?B?dWxMbm50WlppdXFCRURYWktYaVh5d2l5cTI2eEdMbFdZcFg0L3dacTgwNG1X?=
 =?utf-8?B?dHVRRFZsbm5aeTd4M3Y5UWhVV09JbmpnZm1uMlZMdFlyS21GaHE3MkJWRDQ4?=
 =?utf-8?B?MFpuN090UTQvTDIwcjVySTVFNyt6OE0wTEJZZkRKM0lsektIYmNoejhvNlho?=
 =?utf-8?B?UytUajVKbkc0L1ZkRHJhLy9Nb1Z0c2ZtUlV2TGwvcmxOb2I3TTZwNHN0RHBG?=
 =?utf-8?B?b2pRM2VVcXoxeFVxKzRHY1VncFdseURna1RXUTE1NzFhL2FsK3g0L3QxbEw3?=
 =?utf-8?B?NG5OWWdyNEw0VS9DUjhQNXRReXZXUHFHV3ltclMwQVhMOTIzNkpQbFdvOUdF?=
 =?utf-8?B?cU5FZWVzNnd1bmd6QmFCSlVXZnJjVHpTcUFnZDJTRUE4b3p0bWpWUE9uOWxG?=
 =?utf-8?B?WFFSa003bFZWd2N4SHUrSjNrNWc3YjlWQ0YyeDUzOHJpalVhTlpiSUtWT1Np?=
 =?utf-8?B?SHFFandhUlJwWVdLUHErM2pGcmY4S0VtTWVUT3U4WkpzamI5RlFMK3VrZnox?=
 =?utf-8?B?STNRZEZSWEdLZ1drVm5sY2RxbEJLQkw3SWRpVms2ZGFodVJCVEExSWZhbkVL?=
 =?utf-8?B?bFpaV3dSanJhKzREeGpuaDNCcWp1VnF0eW9NcXF1aU1yOVNiRFN1c0NjazhZ?=
 =?utf-8?B?UUkxNnBZMitHN1NWVjJrb1FIYnp4QWNWQnYrNUFPd1QxVWdYRUxCQ0RBd0dE?=
 =?utf-8?B?OXhoOHhJbXIrdnNlUGlrRG5ONnlDRXg4cUFEclU5WVlpbkNwR3NKQk9mVVZY?=
 =?utf-8?B?cVpvQ09DQzltRFNaTzVyWEF0ZWRCMEt5Y0MrTTF1Yzd3TkJNd216WGNXakc4?=
 =?utf-8?B?MTRzWEtlUmdlK2tYQ0kvTWxwVzJaSnhVVklqM0Q2d0Y1VVNwelVTRVlPUjdo?=
 =?utf-8?B?Z2xpV3lBSzhkMVBYdFFVUWdFUy95Q2dINElhbnlHalFEOEhMMEhLaHJKR3px?=
 =?utf-8?B?emV3em85OFNrT1pYOVBmTnlzMklxSGJCU2tJK2FHWHpOUTBHYXpRWkV2RGE2?=
 =?utf-8?B?N25FbjBIS0JqckFpZ25CalJyNEtRNnhyendYMThiTUFMMHVIK1BtWVZXbjhM?=
 =?utf-8?B?Skw0TWtmd0ZVK0phSHpUbXFDQ1liZFJEVG5qMy9ZU2FrSktrWGx6bDU5eTd6?=
 =?utf-8?B?ODNRUHlFcFlWTGsrZUdPT1FnRUpBaWNQUzJkR2pNWm1KaittK1BWcU9oMUJT?=
 =?utf-8?B?VkdMQ3l4Tm9tbzRhSU9PSmRzYXpNZmh2cGJBQkdSRVU3M3pFZkRZRzh2M3h0?=
 =?utf-8?Q?Swul17sQCAVDqD0tqGkNge1F+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 520fecff-8f63-4968-17ac-08daf4c6530e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 17:56:26.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zs+31/IroLcwRHELnpiKB7IozhjWp44P3XIAFdZSjq5WLJ+LHLKQbvHJCU/OQ/6EMLYHHM1u5lEh4JhC1sU0Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7621
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



On 1/11/2023 2:22 PM, Sohil Mehta wrote:
>> +static __always_inline void setup_lass(struct cpuinfo_x86 *c)
>> +{
>> +    if (cpu_feature_enabled(X86_FEATURE_LASS)) {
>> +        cr4_set_bits(X86_CR4_LASS);
>> +    } else {
>> +        /*
>> +         * only clear the feature and cr4 bits when hardware
>> +         * supports LASS, in case it was enabled in a previous
>> +         * boot (e.g., via kexec)
>> +         */
>> +        if (cpu_has(c, X86_FEATURE_LASS)) {
>> +            cr4_clear_bits(X86_CR4_LASS);
>> +            clear_cpu_cap(c, X86_FEATURE_LASS);
>> +        }
>> +    }
>> +}
> 
> I am quite confused by the "else" code flow. Can you please help 
> understand how this code path would be exercised?
>
The "else" branch is to disable LASS for every cpu. Addition to clear 
the CR4 bit, it would be better to clear cpu feature id for consistent 
result in every CPU as well, otherwise,  we could see the feature id is 
cleared in the boot-cpu only, for example, if user enables vsyscall.

> Also, why don't other features such as SMAP or SMEP need this type of 
> handling? 
It seems there is no need to have such if-else for SMAP/SMEP since the 
X86_SMAP/SMEP was gone from arch/x86/Kconfig.

I see something on similar lines for UMIP.
> 
> Also, how does the CR4 pinning code in the following patch play into 
> this?
I did not test if pinning code works as commented:  "/* These bits 
should not change their value after CPU init is finished. */"

Could it flag a warning when cr4_clear_bits() is called above?
I did not observed a warning for cr4_clear_bits(), this should be okay 
since it is called during init.
> 



>> +
>>   /* These bits should not change their value after CPU init is 
>> finished. */
>>   static const unsigned long cr4_pinned_mask =
>>       X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
>> @@ -1848,6 +1865,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>>       setup_smep(c);
>>       setup_smap(c);
>>       setup_umip(c);
>> +    setup_lass(c);
