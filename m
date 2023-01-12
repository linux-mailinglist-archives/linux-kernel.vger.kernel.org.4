Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F314266690E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 03:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjALCtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 21:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjALCtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 21:49:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF60C479C4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673491786; x=1705027786;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=hmKX/UNMRk3mOMtLN5ofZy/PW5+ycZtnLmBjyQHlDMA=;
  b=AQGjkepga67Kw+K0IfXdxI6UC3SH5MrKCLI8xKWFOuY3b5ocPpmOCQ6C
   FaqnZW+S8o4BRv7vc6yGVnF+MfzN/m0NTzBFqyAheqzZYoJ/9NvsiKiVO
   tkPYJC31hLQ6oSsGtA//onawAxICZDVQg3b8ip9wse5sMil+/QOns+t8K
   Q6FlDXCR9rpeAuzwAGZCrzTXFyPc60kj97uBEJQsYGOXLGmAFLNgBeI0x
   gF2cc6+wSGVXnAIxr+04ygxlnvkebKgkNeJnck0kHVOpxDRkKfRpuxcl3
   u694objy7jKz95cH9mqJgEIrjf6io66ItaXIIrR7NZrETixWhx4aL1C1H
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321290347"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="321290347"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 18:49:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="781613728"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="781613728"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 11 Jan 2023 18:49:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 18:49:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 18:49:44 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 18:49:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCu0fG1vHPBnGKYOekHD4AC5uQdvi1Fva20CzB+26wWQANtGGyLoteCA2iS6obdcXtkooIKsJbtyBPN8/U4lwV8zhD460LkCV43T/45cTGl7sR6QNFb36Gx9FLq28+9utJKX3xSvkp21AKagACW+CjJlhJKyP7a/ii84ZyeWjkrRtaw8wo2IhxCTc/vPhITq5tlldlHhGAwvopE2HQcGdMN0GQ5JgA/S+7P7JJ4fO2zjctTyOQNmy2oJiXg6ASHU9Kj86cYKQxP9hwnDhaoWZ6M7pph+j+DBspmYomfT+0p31XlXnlU0FB44mLrs/SNPtyp9wSwm0zpAsAPONXoOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Q3klDFns8ov4+ww0gcptDwdldyHumv6bDm6VKHUdpw=;
 b=VULHuf8bsOMHy3tiDcE5FycVLKg8d1F6LPTZLgMmISUvRzr80posezLm12ejB0+NzKkQM/OSz1Ie+jU8h+cGeoYnUM+kIgMs4XXFI0xmSh7i/JlevEOHe1GwVHBOtSyLtU8PEmd6VxlHzD/suv5jtzsWhaDunJ6L9tFniwoqdo59Rjf4YtT3QTqkd0Bb5UF/AmXhBSo/+4WwR3UChboY53vcRJ38hnBuPbnqpeYkppmbNDjFybrToJ8cjMLLYBFDF2HJFdVMYP36iZH84iRgwnQiWrcBgeFVF/tDJK9qYAiC375qb61YLlVK405k3xHDn2S3LGt/pAZ3RVQa41qlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA2PR11MB4858.namprd11.prod.outlook.com (2603:10b6:806:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 02:49:41 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 02:49:41 +0000
Message-ID: <de08c24f-782d-69e5-6547-6efe0c4ca94a@intel.com>
Date:   Wed, 11 Jan 2023 18:49:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/7] x86/vsyscall: Setup vsyscall to compromise LASS
 protection
Content-Language: en-US
To:     "Chen, Yian" <yian.chen@intel.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-5-yian.chen@intel.com>
 <c2012105-0af6-6720-5a24-719dec775fed@intel.com>
 <adf3a609-656f-82a2-6a4e-199a12de298b@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <adf3a609-656f-82a2-6a4e-199a12de298b@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0100.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::41) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA2PR11MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d25487-dfae-49ac-b585-08daf447a74c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgLl0rftTWEKnmgB3qjX6rynBs4wMneItVRVgs5qouM4G8tB4/K5wbrhATqlVuOHYM2XSNw99GMQ0m4ghGsItJM6S8WLGqhsvOFVbqZ/oYg2m+F+4exXZjkQJ+JGWoK1FLS/si9XWdqGrpemc0M49LrZpzje0Q013Yq9pClgdc2nwYknZhSR7WJQdruvki9JlaCE9WdVOI8N1ayNq/50yqq2FhNQ5Q0xyyaUndldk49gdjSRi+QQ2C334crSYmG+wCP3UH1Ye7dv3qg7RsJc8etAw4C1aal/WX4uGmQSQ/fpZhOD90Aj+26OpsGZbU/h9CMOT3YIIi06yeGBQRTmiITM8oTCKbcXzzthJU9KtAorsVILMW5E/chDaI3czXBrbBZaCol3/aAjfeAp8H2TjgH/S9kYIaIEGLbGkAdiHjuXksZs+I0vgiy5dyMTZRZ9jiHv8D+u708ELr33F1DJJmNf7YDrMh5NLmZwf0ylyiNO2xxWL8iTSi39/th4EmQ7vH9bDgdGy6sTlbmzjYk7VnKcgOL81qjL3qMWefYPHRjfziZH+rbmrcWJ2SOFBFabDPay5Q4u5/VveTa9W9I4YzwSC5mNLUPWetmcWmJxFt5gWa1GdnvZmWRTAIIxsd0gOCc19MP60fH/1TFBNeOHkapDHhz/sF2r4d5/1JrtWZjpSuZNCB/j33hjJD5XIibdNwwJZtM+nWzomKl4GbALDo/2dTa6J6ezI9RhFbDNtAZrFkWdBOE0t+/1SH1gXL/d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(86362001)(38100700002)(82960400001)(478600001)(31696002)(6486002)(186003)(966005)(26005)(36756003)(6506007)(6512007)(41300700001)(66556008)(5660300002)(66946007)(66476007)(6636002)(8936002)(83380400001)(2616005)(110136005)(316002)(31686004)(8676002)(44832011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEpuVjlvTWxIU2c1ZEswdFJxalVzUmFqTll2eGQwWFZ0UjBSUkJRZXI0V1ZO?=
 =?utf-8?B?WGJCQURLQTRPUU54MTZXVnJZUVhxVU5qYUw4M0ZtNzZBcFljdlBhVVJoUTh6?=
 =?utf-8?B?SVVmbHdERmtzakFxa3BuZlh3QW9QTUp5cGZJR3ZLRzJKUFo5QmhtaU0vTldP?=
 =?utf-8?B?MWxPZ1FaNC9lZ3V6Wm5mU3Rxb0xjT2FrUWxmUllmM2pzaHl1VEh5eCs1Y3ov?=
 =?utf-8?B?WW5CSm1JcUsyMWYrM0tzejlvbkxnYk5GR3dxK2dKQ2ZyVUlGSnpTTWptSVBG?=
 =?utf-8?B?UFpJWHRHSmQyUmNzRWtsNTJNVmszTU9rUmlVWEF0RFllblFNQVhycFJFekRB?=
 =?utf-8?B?TUhRSEZwbkNWNC9sREErWHFQT1E4NHdUMitWMGE0UmtIcG1BOWQxdU5QY2Nu?=
 =?utf-8?B?ZDBmWkNKaW1QalVRcm0vYmEwcXlSblhqWFFCNDdKZGFyM3FtWUY2ZHFGbWJO?=
 =?utf-8?B?aHY3K2l2YVNNSW5tb0REN3lyUUNlU0NBUm9kdHhwa3EvK1B6OGZxTWNlWXR1?=
 =?utf-8?B?UVFxNHhhLzV3NVZBQ01LSkk1SUlTSFZweWhtZEVsSWgxNnJwWEZBOGloWXo2?=
 =?utf-8?B?SVNDVkI5a1A1RFY4cEJmc3NjYUduR3l1dlJCZTFtdHduZ3dENTVmV1VhalJ2?=
 =?utf-8?B?QmJXOWJ2c3NidVNueTBZYklQM0tHcDd4YWJwemloTjZUdmdEWE1KQnpnWkJP?=
 =?utf-8?B?dnJkYUFBc3plTXlONE8rMVZZVDhHaXViYVFnSWM5MEtFYTh0cFR0b0c0R3Bt?=
 =?utf-8?B?RkpzbDlhUy9JNUJsZW1Rd2RzcGtRVEtCYmRDMmVIL3g5ZTBGOUoxY2k0YXMy?=
 =?utf-8?B?ZTNCNG5xNTZVdkRseUNBVUoybTY0c2V0aE45T1lhOVh6aWE2dXlrRFNDN2dn?=
 =?utf-8?B?QVlaNjk1bnd4aXdXRmMvNUJnblZlNGRHUXordFJUbExNK1ptQXZqTjhaQ291?=
 =?utf-8?B?L3lKa2ZFUTJweGpUR2pDU2orMVRYWVljRXRsZ0lJM1ozMktFRGpXeE5hZC83?=
 =?utf-8?B?ekZEQmtpL1diclVvcHZiYWE1elBCR3M2YlpwSEVwTTczNi8ycHY2UTlmTTJ0?=
 =?utf-8?B?WFZYOUc5U0lDSDZta2hIK1RRRE9PcTNRZ3RnYjU3V2U2c2Y0bEM4Y1NOaFVC?=
 =?utf-8?B?U3lEdHYxZWpUK0dzeS9GVHBGdCtjTjI1L0VySS91eU5haXJ3M3BRK2IzNjRy?=
 =?utf-8?B?QW9BY3h5blhaRjVWSjRuNkNwL01WWThIQjk0TktDcTN0ekpCZytPZVZVSm5s?=
 =?utf-8?B?bWRhRk0xRTFVQnRBTW1zVDdFWXE0WWpqc0VqZEFaenM4L2tiWnQ2cmJtaUlF?=
 =?utf-8?B?L1IvVXVVRDRXWG1EV29kbURxeTJGUDZ0UHJSWE5HTVZtNjF3dGZpYUFORzEv?=
 =?utf-8?B?V2NHQXRpYzRCUEQxY3ZGbDFWYjJVZmxqKzkrZVYveUJCcnN5TkR1R3BOK2cx?=
 =?utf-8?B?aVRWeStyM0hWR3FmdFU4VjdyM3RVdXpNdHA1RHNMOGsvTXlRbGQreXJqbGQw?=
 =?utf-8?B?TXBtYUorS0FEQnBzMlJDMVZQZjZxVmw2blpSM0NLMFVhRk5xVnl5Y2QwUG01?=
 =?utf-8?B?QVdTLzdjbE04REJtTVNVUHFMVHQvTUdEWHE5bmFKdXhiaGNTRjcrS2NHaEti?=
 =?utf-8?B?ekdST2pzN3VEaEk0MUNkSjM0SEsrcUFNR2dGWno2OXNiSHNWdEFwcmFxZnp1?=
 =?utf-8?B?NE44TVh5TGRVL0twbVZpNzAvblFPYUdWbk90ODA5a2RydVVyOVF2Yks0THZz?=
 =?utf-8?B?UHBWOWlzaHkyek05STZIWjU2Ni9iVVJ6T1c4K3g3V2JRa3pQSVdoNkdqRW9u?=
 =?utf-8?B?WU0wVDBUKzlOV1BnQkRCSnZzVUFUaGhzYlhkL080OU45VTNoeGRLYjNiQzVB?=
 =?utf-8?B?UWlqdVppVnNqQ29vZ1pxaGpWM2o5M1Q4T01UUW1VN2F4VVlTNDdLckEwZzhZ?=
 =?utf-8?B?Y1Qycm5ENVdiS1BsNFpSUWV4Tys4SEgxWTROWjNhYUp4akRlSVgrbEsrWXFq?=
 =?utf-8?B?cU9SV3NNVDFPVkRVdExSQ2YrU3pNVDFKS09paHlsS1JwY3hrZkRidis3K0h5?=
 =?utf-8?B?ZjlKb2pUUHh5cEticjJkdEYySk80N2xVa1RvNk5nWFVvZTliaWg1eTVUQTRo?=
 =?utf-8?Q?LgOx6GtVurqtIw1hZDvcCeR2n?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d25487-dfae-49ac-b585-08daf447a74c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 02:49:41.7867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwOHmpHe5Onmz/1bhXtmn3g22nsHEPSXxThtvnqJPvh74mV+jDhFeDGW4NbMPQcAasg8qx+KR61Et24vEmv7GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4858
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

>> The existing documentation here is incorrect. The default vsyscall 
>> mode is actually xonly. This has been so since:
>> commit 625b7b7f79c6 (x86/vsyscall: Change the default vsyscall mode to 
>> xonly)
>>
> Yes, you are right. but this patch can overwrite and correct existing 
> one. I am assuming we don't need to correct the existing document first 
> before update it for LASS.
> 

We should fix this independent of the LASS enabling. I sent a patch 
earlier today to address it. I apologize, I missed cc'ing you.

https://lore.kernel.org/lkml/20230111193211.1987047-1-sohil.mehta@intel.com/

>>> +            In newer versions of Intel platforms that come with
>>
>> Words such as "newer" in the kernel start losing meaning very quickly. 
>> Also, this comment looks out of place in between the vsyscall 
>> sub-options.
>>
>>> +            LASS(Linear Address Space separation) protection,
>>> +            vsyscall is disabled by default. Enabling vsyscall
>>> +            via the parameter overrides LASS protection.
>>> +
> Sure, I will take out this part change.

Actually, having some text here might be ok. I mistook it to be placed 
between the sub-options. But avoid merging it with the previous 
paragraph as is the case right now.

>> Instead of doing this dance, can we provide a simplified behavior to 
>> the user/admin and move the decision making to compile time?
>>
> Current strategy is to disable vsyscall by default only for LASS capable 
> platforms. So that the dynamic decision is likely a necessary.
> 

Making this dynamic and platform dependent would make things hard to 
debug and isolate. It would be a perfect recipe for "But, it works on my 
system!" type of issues.

Let's see what others have to say.

-Sohil
