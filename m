Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3E66671C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjAKXYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjAKXYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:24:06 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B683C71D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 15:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673479445; x=1705015445;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=k4zyCs4QsFaads44XxoxMirjlYnvjhwmaeD1I7l1Rzg=;
  b=U4GFSgKcKx9Avy8cgC964u8QiJr9KOYTXgAir+jK4/xcS5pPMf/0Xulj
   ccOAPM91sD+SjqWjutXB9fAn5YxLFwpujM943ZuWTAsQX4sYBLzn7fUwE
   PRfsPo83mofm3cgm2bfQ4udBQAvJzU+9Ayxj8OzpKIT7jyHtpzsGswjoO
   c967RXhS7Y6GD3WeHfqD7oZRXIqksnDYgls/W0769jlXZ7UeAoBevpXfi
   eN19L9i5n3TM/MRU9iW+8Xoj6Aqgr7M+AxOma9TAWhOjO6cLCrUKBClfj
   r76xZclb6fsRkHXya7WLJUjrAYBOHxmebkgF9WTCnKS9Cf8Gwy8ZlPnW1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="323626486"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="323626486"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 15:24:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="635163711"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="635163711"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 11 Jan 2023 15:24:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 15:24:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 15:24:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 15:24:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2q9kPIV10WyOMEAia2+BmLa9+TCFKg5ce7yCG1SwqU1l6Ou74yf3brTNjfmoLQ0dSqyrISPTFJUMN5KNoAmvnfPJjS5ikflYwI8PxfPzvVMF+x8VxdhV3oOANzN7kSUEJHShBNh0DcDotIu1u+TaB4cYnqm9mFxe8b4WVFcce5XuXwyoN3V6na2tdgdIjINi70ECgh1DfUobGYpofX9kYkXxqEn10LZ3G+P9ZcYB8gOh9xOBgJN9YRyG8ERz5tIXNF5spfOgcsQOcqqB0F2vjMPK04b7aaF8Y3LkJXiRqm4aCOWpmViJIJBFq5C8PM5Kmw9oBk8QtVCUq5oSg0w9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xpe+m3ziyo491X4Bb1UT41dY8dJuO/6f3dtqAjI2HA=;
 b=gMZyYhUjQUUyNiFQt6Ssv3wodWYIl3mbZnDDvkaxMV4Mrbd6ECQ0aZm4K/6fKOYbrd5ti3G6MpdkYZ81PUPH2FIESNZefy8GaXG+OEWbRs51lfpC3qn+jflrj2nBvysp0/SpYA/tsE/l7m5qJsA3l53k6d9MBDeZrEJWgP3e/A0iQMEGz/GBVoeAWlfRz9A7hvfYZSBTw4cNferQuJV1CbaXzuslOC+zNLDWhnHcJVwW8ip98pU90RXEM5spMGpjhNZ3a2wpMvL50nV1R7kNjb63winHpuTDm3LkMf6JiNeqB1hbqn3Z7vCVVVHcaVeDAgFHAV6mIN99Vr3OOj3/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by PH0PR11MB5659.namprd11.prod.outlook.com (2603:10b6:510:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 23:23:55 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7%4]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 23:23:55 +0000
Message-ID: <fcde9247-55cb-b402-987b-66f24dc76271@intel.com>
Date:   Wed, 11 Jan 2023 15:23:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 1/7] x86/cpu: Enumerate LASS CPUID and CR4 bits
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-2-yian.chen@intel.com>
 <9d935618-8f84-2d6e-4f4c-9d38eec2ba67@intel.com>
 <feab0dd1-2030-e31c-cbbf-9857c46d0c1c@intel.com>
From:   "Chen, Yian" <yian.chen@intel.com>
In-Reply-To: <feab0dd1-2030-e31c-cbbf-9857c46d0c1c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::12) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5262:EE_|PH0PR11MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: b20dff8a-3cef-42a5-d922-08daf42ae89e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mD8L+9NDMCdtMrVle0ZFCxdNnW9YG3mYiPqLvnhdoOV6vPKeCDe39xjUCZHmYHn4TKPNIPGhYcf17TBKY7nw1AzGBFNZB6x2HQa9zQRbyIGWAfNOT2O+vfAyPzMovA/EPV3hALf0ud3ip2d6c3j6VGqzETEdjfK3qds4Vev7onuREbC1u29gBEoVNuKlAjkw7kqP3lH4n+Gsi2aul88m+din4owyLRikG0vIE8jDClQYZpfcnuBU3HYw6Fc8EuDXHPg2lPWFiVY9NmkMRCmekqq2zSlHOSotgGqbeban6MDSNYHS/mSFzWmYmBRx8YPLkm9Eza0o6lWmjuoHfBMt51muj2zIlxrmyX0Z9gDKpbk0JfMR8/XsB/ZXAj4YXFlMW/blYkjuIHBc1oYE9CDcMgRh9uSxCz/3mvpOq6SeCKQKvl8Bm5aHgTXOkWmhLmiCAegNIEvOSDMeT/tN3M3sVQr0hEJC/IgnBT+NGorbjbucWxofRIhBhzyRHBA2jD+hBrSt6lhl7Q9SO2vkkDy/zqQyl4pvNRTeJhwwr7ANZaYUhF4tOqvOW1SPjiczBK2R3grwJLLBJ+F1OSFp5YogGDH9eCzoOqM78Hyl7Sp6UPYDj+OjSTj9eMjfyBZdABf4KqY/CwLlTD/N7FogBdThAY/Jylrv6ZW93FCqRibpVpTB0khm4vh+3PfZd9peljuKQmYNg/q7NwAzsyb2lZoG1x6vbBZhJG+qALBBZy/7vhNYKjSQWmCI5+GAUIOdZ/BHfq1z41sdO47qZg5wUz6hBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(36756003)(38100700002)(186003)(8936002)(2906002)(41300700001)(6636002)(5660300002)(66476007)(8676002)(66556008)(66946007)(316002)(110136005)(6512007)(26005)(2616005)(31686004)(31696002)(86362001)(966005)(83380400001)(478600001)(82960400001)(53546011)(6506007)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzlMbjVxN0gyeGg2WENvcU0rVmpGM1NzZytuYnpZZlF6TnNhdmFISDdMc28y?=
 =?utf-8?B?MjVHREFLYUFNaWZQbEZCUmdjZE80MHU3L3JNeFhPWkJIcHQ4eU9ITzNraWo4?=
 =?utf-8?B?VGZwcUttWDdldXZKYk15eVByTDR3Umd0eVZ2UElINitBMVIyaWMrdTN4dHgz?=
 =?utf-8?B?Si93NlVaL1VhWno0RzhnWjJNbEtuVXkwSjFuN3VOYnZFQm9QbThscVc5WnA1?=
 =?utf-8?B?UTYycGRIUTVaWjY3Ty96bzVJYjJtR2pIY3NnMkZBWTU3dHpGeHlyYUhmcmZa?=
 =?utf-8?B?MjVXUGJPaVcvN2ZpcXFRSlYvWmhNemV5Z2x5VWN5SEM3L2l3MnpjRmxQbjFr?=
 =?utf-8?B?emxnRnZhdjF0QVExZlF6TFlHOE81eG1BdmRDZ2l1ZDFhTTd1eUdMU3B1cmVQ?=
 =?utf-8?B?OHBSbnRDcisrdlZXNzA1c3JYcG93aWEzMlFyMnBGQTNaU0Y2dURLY1BlOWw4?=
 =?utf-8?B?ZGt1eUgyc1huMjFBQjdFRmFBTjlLeFFkMHFvNUYyN3N0bFBwL29VNms3Wml1?=
 =?utf-8?B?ZndjL0VNd0xoOG9ya3V2cEViOVFHempYaUlPbXJHYndFZ2FTRGZNUk1Tckhm?=
 =?utf-8?B?R0J4bHpFWUIyaGVjaWxwU3lHc0NuNi9TaVVKM2NsN2R6eVFNaTFpdndCMFdq?=
 =?utf-8?B?MmRQSHFVNU5PLytmVG5CWnJXdXV6dXhQZ0x4KzZEdDhvN2JBbnUyenhjNFJn?=
 =?utf-8?B?Z2kwdUlsQmxjVVZOYzNUbjdKY01UekVwSEthNGdRMHlIZmNRK0lYdmUzeWR3?=
 =?utf-8?B?dHhQY05MczNWOHRXOU9ISmoyUHVLYnI4eWRqZmorRHFtYjFoQnY1YktNWjZ6?=
 =?utf-8?B?QjFTZ0V6clFsL2VxeThMOUZ0bWV6Sy82MEVBVW9sR2I1azNMa3p6VzhLRmEy?=
 =?utf-8?B?L1FJQlZmNXZvYkZ3Z3E0dnNBak90eThHTkUzMzU2UHRDVXJNSUJZeWtEUnZ1?=
 =?utf-8?B?OEhIYlBQV2h1M05wb0tZU0YwTjQ2bmIvTmZqTkJJbGN2QndPSDVFTWlNTktv?=
 =?utf-8?B?aUUwTFBoN0NKWVRXdjloclovZU4vcWZWR2dIZ1YzemNuZzMrZ0RwK3FIaFJY?=
 =?utf-8?B?WlhpUTE4SWNreGltY2dVTkNwZXJMbUZEaHNGVWtmdzlycUJ2UVplbGpmUzZI?=
 =?utf-8?B?QkFuNHpaNGRuZnhoTTBwVVhYVFQwY0o4M2ZkUlhYMWlSWlBGZXpKR0ZwTWRE?=
 =?utf-8?B?cmdMbXNHaHRpc29pcjQ5TXlBQ2crY0lFS3owQTFGM3RiMXgwU1Nnb2IyY0Jm?=
 =?utf-8?B?QXp0WkpCN2V0WU9BWXRuaVZrRWZodFRyWTFoUTVqd1R1V3VlSWlCb1hIVDkr?=
 =?utf-8?B?b2ZrdFF2N3NDN1c3K2VjOG5WVEsvRStEOWpJaUUwMDk0RlNhanNIeEcyNUp1?=
 =?utf-8?B?N2poM29CdXpxQUpTWWF3SGZGM1NGb01RYm1LeFptQWl6MldCNDRJZWxFNGlk?=
 =?utf-8?B?ZUlNNTRWa2NON3pIc3JGWFlodDNHeVRPaVZ5VWtVSTgzTHVOeVZkQkM3anFu?=
 =?utf-8?B?NGZmQmlsaUdXM0lJT0N4RjJpTExUUXA5Yng5ckJhbDJ0SmZTbTNEMUhkdWVp?=
 =?utf-8?B?V2o0N1RoZXJCUFUwVWY3T2RoWHdJeTgzY2ZNTk9WVnQzSlhXS0k1MjVqWmZw?=
 =?utf-8?B?RnFQSzdtbGVrK21MSjZpSnIxRWJhYi85QmNCOXJxbXVRMUR3anhBbXVjeEJU?=
 =?utf-8?B?T25qSjQ3NVRRb3BjVWQ1ekRvb0ZyZE5YS0JiQjRMS2NOcW0xTnVhSWI3SHU4?=
 =?utf-8?B?WW9LR25IbWFIS09GVmhlM0hYV1E5R2RqTy95TjdnODlBWTNDQ3A2QlJabEdX?=
 =?utf-8?B?OW5nNVBWZDdFWXoyMkdGSlptV2V3SEdmVEtERnBNRkpmTnBTekRHUW12K2Zp?=
 =?utf-8?B?RXprU3BwUFJEdjVIZWdnN1pjT3NlVDZlY3o0YjN0dzZzaU1qMHd3MW4wUVA0?=
 =?utf-8?B?dVRVRkMzSGRFaGhtL2E1OWNBSU5GUW82NTR6WkFjSTlkalpaVnRHSVljb3F4?=
 =?utf-8?B?RjhsWm9BK3RHQ3FGVXNxTWtZMkMzVVZlZjIwbFZITy9hZ0Y2SFhSUUVYa1Vu?=
 =?utf-8?B?K0VNWnNtUDJ3aENFMU1XOHUybHczY3NVY3hVeFcySXBtK2J0UmMxNm9VN0Nr?=
 =?utf-8?Q?bpodsVeJbAmZMsvQjPOgmavQN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b20dff8a-3cef-42a5-d922-08daf42ae89e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 23:23:55.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zzo8DwfLRdm1VabBxmRGUmyR8undVtcdTkzAUZYu/pWy4K6qv1TAF3YRQ0xK/M2ruWd4pnQX4MQAPCPIvJQyNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5659
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



On 1/10/2023 4:13 PM, Dave Hansen wrote:
> On 1/10/23 12:14, Sohil Mehta wrote:
>> On 1/9/2023 9:51 PM, Yian Chen wrote:
>>> LASS (Linear Address Space Separation) is a CPU feature to
>>> prevent speculative address access in user/kernel mode.
>>
>> Would it be better to say?
>>
>> LASS (Linear Address Space Separation) is a security feature that
>> intends to prevent unintentional speculative address access across
>> user/kernel mode.
> 
> It's more than that, though.  The spec actually says this pretty nicely:
> >> Linear-address space separation (LASS) is an independent mechanism
>> that enforces the same mode-based protections as paging but without
>> traversing the paging structures. Because the protections enforced by
>> LASS are applied before paging, “probes” by malicious software will
>> provide no paging-based timing information
> 
> So, it's not _just_ that it can prevent some speculative accesses.  It
> completely short-circuits paging itself and *ALL* of the baggage that
> goes along with paging.
> 
> The TLB, mid-level caches, the page walker itself, the data cache
> impact...  all of it.  Gone.
> 
> *THAT* is the important part here, IMNHO.
sure, how about if I rewrite the 1st paragraph as follows:

LASS (Linear Address Space Separation) is an independent security 
mechanism that enforces kernel and user mode-base protections, similar 
to Intel SMAP/SMEP in kernel mode, but enhanced without traversing the 
paging structures. Therefore, the protection will not leak paging-based 
timing information and prevent malicious software from probing the info. 
The LASS details have been published in Chapter 11 in
https://cdrdv2.intel.com/v1/dl/getContent/671368

