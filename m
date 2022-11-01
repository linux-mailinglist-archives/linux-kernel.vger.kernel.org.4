Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84296151EB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiKATGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKATGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:06:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070981D669;
        Tue,  1 Nov 2022 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667329605; x=1698865605;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jhofsp89agcEO3OWeIuKI0oZ0TzvbZMZxf9UfTGiSGs=;
  b=bPnSDZyBA+0gihH8Q6mz0qOxGjgg8hmiJjh1mKoYV0Qy6jePb64KYDDa
   V8iyTnsiSbAazrlQZdnV+q30kFVhPqFiitOE09mwmpmwsaYekbnH8AR19
   NshhsGNa6g3NqPPE17D7Wt4/UQTfroFyfT4j1eG6QiB6FwQrOrAH7GW9J
   biNX/3HS9MW08EiD092SzAVv+1J5R4/veWaFjxxD+CBeAwwzF1rni6yqV
   uUcCWtk1mU2OpqVH0HwUiZZQRzX6luBwN3JBEdL8jKShHMf5Z/EgxlWoc
   nhoYYGjfnrdjcmEF2b8FCJIUvbnwhUqkR2nUh1jlJMlRmGVXYEo7xXfhE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="373439697"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="373439697"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 12:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="633978362"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="633978362"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 01 Nov 2022 12:06:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 12:06:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 12:06:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 12:06:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbNUfdeWkUFF9A/yA9tTOAoT9tW9uL7aKCX3sUKdxeZkp3UaDIUxdUpy4WZbrRYKAc/8LGo8EO8UPcqnxlHy36YO7AmECeZHJJzTiO5kggyA0721NQ+zIv2LC3INJWegCjlVjee9xCMrRx5URS4ELFdq/9ombDJ0PSf+IsvqLVllPPsVh1J+HqmYv3lcvxySAmB2ZSuJJmoi5F91KMV1SYPBrwnnQSOUehA2oMcX33re5uupEYKOSSQCbkCwP8Bf9BNlJ83gAD1ZSmciztuS1YfCqJSpBnv8uhj4Eu573cj+cBELwigtluh/xvykzvlJLAhM7JpS2hvyceDVOguAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwsD5P9eODIKrIXYQSQLTuKiDKVNnWm9xcdb/OsDXuQ=;
 b=H6GQKH/2tgaWzTrxi3pK1QaKLR0oqlghxeMIby+xCgoYi3WU8dRjxrp9iap/KLpeFlpSTXxECOhdzU49xz0gr0j+HAo1GqKKBIQlVbggia1weSCrtKxEfFrsgl2oKzsyv7c8/Dyi8jfhuQ/Z2deqWa3MaqlX13zYMLy9I5a5suV9ZSrhYSPrHGSCx+bf5yEzb0VL/rz2uBwpZaGJeuw8Cp66433UnBi+2tOiW/mf+bH4QeIPueNTaZaRriAfSF4UpUUdAciTEBShx2Q173TlSkbowgc6gp7HY+SsU6XF3zZ2yFv2UOoyw/PrAs56eJNxa3hj0KUKMszBR5K/ZHhdCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3771.namprd11.prod.outlook.com (2603:10b6:5:13f::15)
 by BL3PR11MB6314.namprd11.prod.outlook.com (2603:10b6:208:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 19:06:40 +0000
Received: from DM6PR11MB3771.namprd11.prod.outlook.com
 ([fe80::c5b4:b2:b261:1562]) by DM6PR11MB3771.namprd11.prod.outlook.com
 ([fe80::c5b4:b2:b261:1562%7]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 19:06:40 +0000
Message-ID: <dcdc52a6-c1f1-cbe3-81d4-cc06332f61c2@intel.com>
Date:   Tue, 1 Nov 2022 12:06:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 07/14] x86/microcode/intel: Expose
 microcode_sanity_check()
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-8-jithu.joseph@intel.com>
 <c225e969-a88d-f3b4-de44-ef71f44dd463@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <c225e969-a88d-f3b4-de44-ef71f44dd463@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To DM6PR11MB3771.namprd11.prod.outlook.com
 (2603:10b6:5:13f::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3771:EE_|BL3PR11MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cd14c0-124f-44d7-649e-08dabc3c3516
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3I8cz7CEEMTsvU/L/e0oR0GLX2EMoTmY9QMiKqhr5XcS1CVk2KYxsuYB43pJQACyE8CA7GAxLR1+M4WpFyfhvnUt5xFHxZuR6wAf9aIR9D9E+1ky4oj4lxYv6wM2Z1gMvSiTYnNoC906T1kjcQ3rGEMQWeKfN68QBwLE667SHW1gjgAn0G5BeeHFmKUG+LTnmHP9ziCGCQh9qO302/UomuDmgvse0my1FVfmMwsUSkRU3MWtfHbJVqU9S/V/60NTal+Fy8YR4a51PIFN4FKliLEykxSR7HxAYmQ7E7/Z0Rl9msHZrav45CPxvM6VDYg+WmYUoWCYjVBB7Ont7GJcbQW9+mDHQP0/7FgeR1sLAU738Rbxx9DdRlZPGzY+e+DR85OMElO810CCwO61AOJjgg8F+UmOt8q7KoSkkwEmMWRM1uu/+/lvYGGvNPvtPCYji79Ha3BdBOJRB9m9FGgfZkSftaYOMTtMAk4R3VWKEKsL4iqY5xxfKK4iZ2mhUG/qP7dfXpzXjHMdOJ+b+OOGhgrDk+pqVpBiebendI+EKOHCdNQYHRmE0Snuf9cnpAqwW8YAUtaWTPlgMQ/5+UXuTwJL+2zfFqQtnkSEtq+YtCSvpRericP2SFrpc616LofUr9jnLjJTsHWez3ZbEvZ5MvaAED4kSI9yuEYwdaCSwffqtax4Fh2JeGsqB2WMtO7ja1YYkhlvUOuxbtpBG5phmloR0hqaKSydt/SsPIEhVHLyUBtpV5BRx9OYqiIRLcf0TLJfDLUz6xbWMc3fVGrzW9ECm4hDcbeFGoDDqzXV5c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199015)(478600001)(53546011)(2616005)(6506007)(6666004)(186003)(83380400001)(2906002)(6512007)(6486002)(316002)(41300700001)(7416002)(8936002)(66556008)(26005)(66946007)(4326008)(5660300002)(66476007)(8676002)(82960400001)(86362001)(31696002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzFGZUxDS04zT0hhWDByczk5WjUwV3p1V3J2Y2VTZTlETWZRN1Z0R2VpZk93?=
 =?utf-8?B?OTFJeVJqeStpQTRXS1VNcXQxQVFVeC81MXE4RGlWWXM4QktXRUM2QTBMZ1A3?=
 =?utf-8?B?c1BCZnBlRWZZTHVRT1RQak1xSktBUlllK29ScGtOcyt5dnVQYVRDTmZyK2pC?=
 =?utf-8?B?c0hEQ1RtMEZEd3R2WTF5SEs0M05MSkhzRlJHTXd5VVJjVjI2RGFWb09hNVpq?=
 =?utf-8?B?OGNoc3VMekxScTNhK2RRZFJMU2laOEVHc2QzVGlRTzVLUnRPdUloN0tFam1t?=
 =?utf-8?B?d3llSG5xc0xSYWd3cHgvWHpvZWlnYzlKdjFURVFUZlNtdzgydTE5a3dCZVph?=
 =?utf-8?B?eU9rM2thSGtVUnRuTXUwVFM2cTBOazF4VWFNUTdoTHBHWFhwSE40dTFoU2Y2?=
 =?utf-8?B?MGswb09FWFBLSlVaVWFHT1BBZk5ZUU1lUzMxaGdrNk9iWW1HbWNDZ0ZCV21z?=
 =?utf-8?B?cStYWEJrT05XQlg3ckFPbzhkanlsTFB5eTZLMVBWaVNvbWxDQ29hT3FoZkE0?=
 =?utf-8?B?dTV6NWtLMCthYmw2aHRyb0w3OWpZZVRtMUhqbklNVXE3d0gyY0dxeUNjeGpE?=
 =?utf-8?B?RUlyRW9GdFl6aG5MbXU3czRYd2RIVi9yUHVyaFNyeGRmcSs2STBwc2IybUNL?=
 =?utf-8?B?TWtLRVpnTDlTYXhGaGFaUzBPTVh1YnhXNlphV0xBOHF2cWJ2cmxQK2FWWHNt?=
 =?utf-8?B?eHpHZXBkdDRweGxBdFRodXpaLzZUMTNqOGU2V09uVjNJalZqdHpJc2ZzK2dK?=
 =?utf-8?B?Sy9MMnRMQVJ1em9SMzZiM2tYRldySFR6YXNOTDllblU3M1lkVFJvYTVDNDBM?=
 =?utf-8?B?SmZHNUh1cm9DVUZCTUtSVXBwbkdjeVdrb0hDMmNKbDlHT2NEWlEwS1Fuc1hE?=
 =?utf-8?B?dlg1cXYxc2xodjJBRjFFdmZxZDh2QWpMZU1VMS9RL3QzZDVleVhMdW1oMndM?=
 =?utf-8?B?bDE4dldMRnkzeWZsOGhSUTVHRFJyZWZIZzk4bXpEODdSSVptK3FldUErd2hY?=
 =?utf-8?B?UnlyZlI2OUtJQytndXR3UjlDS2JYMHlVY05UYkJaQnVjUkhtcUFSRjBZK0tB?=
 =?utf-8?B?TXFFSjhMTXpFZnpIWDlQSEhxMEowMjdJZUpnMlp5WlRhWWNRMFNQY2xHMWpE?=
 =?utf-8?B?ZzRuWFFJMjI0TVVob2UvSW81MEdyMG5TUWVmNXJaa3VxY2I4MXJaNTRMZ245?=
 =?utf-8?B?dmZXUVBBcGJmMTI1VXZvUHY5czJWZ2diUUo1cVNSTjF2a09pNWdZSE5rMzFC?=
 =?utf-8?B?Y3JuZytUNjAvWWdyVGxDY2RrOXhuY3Z4NFljV3BESTd0YUMvZDlkK0pCdWtX?=
 =?utf-8?B?S0tyNm82TUFVMnVNeCtMTkVVSnY0ZWFTWm1EVllIZ2dVSFgxd0hYVjVRTzhC?=
 =?utf-8?B?N1FWSk9OSmVqV1RXVDBJTWZDZUNmVDI0M3Z4eEUrakRNTjBkaWxMT0pkem53?=
 =?utf-8?B?Ny9yYUV6emVMWGNzeU4zZ1lEK0RPN0craTVTT3Z6UXJOUThLYi9mSUMvUzll?=
 =?utf-8?B?NUlrZHhNNnlIektWbm5PMmNlbW54MzhsdjdLREpyb1ZCZWdqSkFzT1BXUXlL?=
 =?utf-8?B?VlYyYVhiRVl2WmMvL21aZVRVSXAwakcyaDcxakF1ZGZNNXdaSGlQa0pFdVJz?=
 =?utf-8?B?NDdrcTIwVUNGWkpodzA3Y2FXUFJGSzZEbkxTSTZPZzVEQmZXVG1Kc3FzZk8v?=
 =?utf-8?B?UzJqQjhRMktnSUVhYXptK3ZadUJFZG52QmRxK2JZRUNTV1E3dmtYTkFaMFE4?=
 =?utf-8?B?dVFSRjloRGxIUzIyU3lyZnMxU3JBd1F5QmhoYUs2SWlKeE9SNStRUGc5RU5T?=
 =?utf-8?B?cDRSU3o4Y0dyL2g0N1NxbkYvU0RYZVdITkNOcDZTNkQ2MWFmUXlZSlZnZ1I4?=
 =?utf-8?B?eHRsMXpoS2hPcFBtUmJJejVUNkMyUWVPRm5TSTg5ajFDWWRzVlc0MlEvYU5E?=
 =?utf-8?B?SFpvSnovOWpSbjBhR2M1bGF4Rk1qaWZsdHc4VHJRdzVUOEF0ckwrZmpXZ0RI?=
 =?utf-8?B?V0FWSlpxQjN1LzNSMk1yeSs1dHRWb1MwNkMzWWhHaWRSN2crbUJvNEFEcFp2?=
 =?utf-8?B?a2ptc29OYTRFTERyYnlLTVpCWXZjM3QydE1GeWlQakN2dGEvemlEdDZhWGFu?=
 =?utf-8?B?TXh3bWdnT3JBdUhGdG5NQXJhc0JkbG9HejNpYlQrV1czYVlwbzh4TnYvREVy?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cd14c0-124f-44d7-649e-08dabc3c3516
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 19:06:40.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ff5WCfDtXqnrE+eK7rQAhCf/QKkH8UvC6y96eVmU/DADzwucXpgyVAvS9F8mCvydTX8uMbBlz2ajaMMv9a8cUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6314
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



On 11/1/2022 12:28 AM, Sohil Mehta wrote:
> On 10/21/2022 1:34 PM, Jithu Joseph wrote:
> 
>> Refactor header version as a parameter and expose this function.
> 
> Isn't the header version part of the microcode data itself?
> 

Header forms the first 48 bytes in a microcode file followed by contents

> Microcode Format
>    +----------------------+  Base
>    |Header Version        |
>    +----------------------+
>    |Update revision       |
>    +----------------------+
> 
> If so, why the need to pass it as a parameter to sanity_check()?
> 

It is for sanity checking if the contents of the input file matches with the usage scenario.
All microcode files have 1 in the header and IFS test images will use 2. 

Existing usages check if the microcode file has Header version 1. This (along with other sanity checks) is done by the below code 
microcode_intel_sanity_check(data, false, MICROCODE_HEADER_VER)

and IFS usages check whether the file has Header version 2 (along with other sanity checks shared with microcode files)
microcode_intel_sanity_check(data, true, IFS_HEADER_VER))

In other words the sanity check will flag somebody mistakenly passing in a microcode file as IFS test image (and vice-versa)


>>
>> No functional change intended.
> 
> Maybe skip this statement. Apart from adding a parameter to an newly exported function, there is a change in an error print as well.
> 
>> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
>> index 5473b094baee..bc3f33a25d7a 100644
>> --- a/arch/x86/kernel/cpu/microcode/intel.c
>> +++ b/arch/x86/kernel/cpu/microcode/intel.c
>> @@ -37,6 +37,8 @@
>>   #include <asm/setup.h>
>>   #include <asm/msr.h>
>>   +#define MICROCODE_HEADER_VER 1
>> +
> 
> Should this define be in a central location, like microcode_intel.h?
> 

It can be moved there

> You would soon be adding a define for IFS_HEADER_VER. Having them defined together would make it easier to follow.
> 
> Sohil


Jithu
