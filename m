Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9887457C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjGCIyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjGCIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:54:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E12093;
        Mon,  3 Jul 2023 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688374491; x=1719910491;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z3nEa7tznb8lgpZP6ZVnQoqDg+EcRI4nIendz+5/szo=;
  b=dPrrUkOSgPznqZYRKM7wm3eC7qegXIZ5yvwcuVYyU7AFILbvpeypNSWU
   UIye0ZaTeaLDXH98psvUnORPadaNmaYDWVNLV9SR45RWXMmi2QBvkxZ8/
   5uBIashBRcvEQ22QTy7GDHrg7ocfBVzlpXw3BqUkwgteLLUd7rXWA6AZ3
   iRYxRaw7CpstQ1G1TkHnVv9DLKW9hOdHie32anKiFq3oeWocm97w05vlE
   1PvJ/ClroRrMjjow+TD/R5JPfdyhv/dGC++IcCbY3g2MAFHPKwcwNYDtW
   h1YC9dRn0YxgxCBfu3hD1DgLZA1uIDI0vuZSMrMsIm3IhVuakJ8vdxsd7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="360309806"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="360309806"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:54:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="712494194"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="712494194"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 03 Jul 2023 01:54:45 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 01:54:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 01:54:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 01:54:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/t1IEJse1y57oMBRLvfHQFtAIWtKflFvWIp2yejjW2ltQsBXh+d6hA8lwetkiQhhViw3wW5Vs5EtAF8JdBk2vPzLHHHO25ut0rRKEP5YQ/TJNjJIIy2U64pXWtvtkqlQYJXz7WA90i4x4Xs0dNuwwjapTpyA0xJKROtsPo79EWYp4dlCTvQLke42yn7pAYu4KFAKuo0HBYVaLYplXGGwA9rM9kcWi86nC9UB1pZJpOmz71lkzi7BmZBw99nPBQCETd1ycLxPSUdC5mCNVFIHBvaayQuO2g3dt3d19NRbrqjHOoo/hMON4q6pP/6V3msmY/P/c4za9KHwnS9NLtXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ic2cVAeuNGgPB+YrHSCL3IlUAtHazp9926rWLq8Fb5M=;
 b=c5hNxHxk6ebJvs8vlbkjc4P4BTMnvI5EXz67GeFnm+BJVRoLGKSXDE80bYbh4Q+3cu/Rjre+PK9mOir7I5O+EnOXT9bYLV4SwcFyrB30rxcJjFbn5a3h4ExvAGXrWfZXBfNJ8pCCJqW0lLOYdKe815x4mVOMLhPPVEHX5UxNZXH2AREcwCsHQO7GaDa4iyyJRwzMxALTCnfpZLAFoh+46gFi2lRQ/mWpLe8r7v9AuPh41ptVr915jCYCx4bfhZy+Cu+Svu8SsRWgeel6C7z1ecgCLbdCwwOGBmymgs936kwhzVFOORh4dwitfvwXV/eJbJVNVIvolgYHepOejyw+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SA1PR11MB8474.namprd11.prod.outlook.com (2603:10b6:806:3ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 08:54:41 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 08:54:40 +0000
Message-ID: <527766ea-4d01-25e4-6e9a-42dd5bbaf650@intel.com>
Date:   Mon, 3 Jul 2023 10:54:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/5] acpi: Introduce new function callback for _OSC
Content-Language: en-US
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <andriy.shevchenko@intel.com>,
        <artem.bityutskiy@linux.intel.com>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <lenb@kernel.org>, <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <20230613161034.3496047-1-michal.wilczynski@intel.com>
 <20230613161034.3496047-4-michal.wilczynski@intel.com>
 <CAJZ5v0j+Wz7366kLT3ez5TNoGWXvsa53hBYYeS=aHgbTJUqvKg@mail.gmail.com>
 <72ed8f32-8bfd-2d25-a377-9adbacdc8c61@intel.com>
In-Reply-To: <72ed8f32-8bfd-2d25-a377-9adbacdc8c61@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0456.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7f::15) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SA1PR11MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b7406f-7f86-488f-f9fe-08db7ba32357
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQZHjquIfK0HmDOUDjm2sVzYm69SD36F+g69OmIM+sT1i5nzhfgozsRmy8WboWXTCKeZJvGzgPg+goD+EwDWn9OmHgmd5rvuE3bd1LsjWCHIX/ZecO+T8Mt87PU3/GwgJEF/b5KFc6Unz7dFeCmjJQp/W9Z5z3sMFaPTyyHxPRL4BT7tNt9AM6YttIIAyq0/nOFZHoafDDjUS2SlbHSV5oafjWiZuwVAYRVOFC9Chfi+R5/WbBC5GfXtoJCqBslyErQc935m1U8mS4mSqoJQ9ymL69Azw4Vmqh/R7dUtMyVvgPreZ0vX441V6D/tYsYQ2/JU7aspqLptS8MuXWjPcYwofL0Z/RKVyRxMRJvhMPfEnNjNpiqDg+c3HOSd2JlFShrAbWC9TYOpUsM24L/Lv0ZdAcSeF/xv//cQto3OZl+z7EBs6fJ7ycvdhbJBemSw+jpr2LgiqPHigsjjcKSJsGyl4/VbtVAWgpkUs9t5hAfR4YUtxbrtVQINv1UahdXgvNipwT8QuSUh1rxpMxFMIjDWK9eZgsARSLQuiV/brV9QI/gJPYHuLCXEnOnhknR8Ul0II/HDlbVFX/jh/qIcyvSUgvSMlXD/emx6X2AkgOFjcm/hVkKgmA2pl/UuMatolIHqY2CVFwse4n0DdE/NRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(7416002)(31686004)(6916009)(4326008)(66476007)(66556008)(66946007)(316002)(478600001)(2906002)(36756003)(8936002)(8676002)(5660300002)(41300700001)(31696002)(6512007)(86362001)(6666004)(6486002)(38100700002)(53546011)(6506007)(26005)(186003)(82960400001)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE5OcW1mRkZ0MUdMSVBzbzErZTgvU0NXQW1qS29jVTFVSjFtaFBMaVMyQ1Y2?=
 =?utf-8?B?ZjFqc2RPWUNsMGVjaER5Y1Jlem5SLy9iZE9MZVh0L2p6OVpXZlJONnJ3aWd0?=
 =?utf-8?B?YzA2K0RrMlZQNHFaclZnYjU5VWV6QWRWY1UzK2hEajlIaWxqVU5BLy9KRGQr?=
 =?utf-8?B?dVBibkQyU3NhT2VjalNxMXpVNkJRNE5GVTR3S3NUS2JkZkRoR0cyUGM3L3l6?=
 =?utf-8?B?VUdmRTN1UnJHWWcvTUpxSE02ejl3TUlSdUhGb0lnaHFEM0RLS0VENFJCT0tX?=
 =?utf-8?B?alZOMTlycUNQQXVJSmg1Qzh4YjhSN2RLdkkrM1Ruei9IcEJwZyt0M1libVdJ?=
 =?utf-8?B?clZHUXdmQjh6Q1dxVGp0eGtKS3lVTjZpN0kwdHRONjk4eWNoUTRZQzc2UVFx?=
 =?utf-8?B?SW1OZHFqTUs1Ulo5VXp5M1hIR21kZzRwRmsrVCtBSWErZVEvdEVGTkg0L0NE?=
 =?utf-8?B?cE5xaG1sU3p4dFFmSHlvbFBWalBNVmhtTisyR2ViZmdmVTFFNHVnN3BIQS9w?=
 =?utf-8?B?Z2ZjWnJRUUlOeFM5TGR3RWxYbUFVRXlScFdqaEwzWlJLUE5oSFN2MHd4MUVL?=
 =?utf-8?B?dEQ4ZEtTUzBUcklwZE9veWVlODZRRGRHQUg3elRIRWlsTnQ4bi9BUkVOT3dl?=
 =?utf-8?B?SE1vN3Z1UFRKdWQyVHMvcUF0alpUZUNjWVlVblpxaS9hL2dxN0c5UDZwL1RF?=
 =?utf-8?B?SWhPZXNwTVdRVjNrUm8xbVJRVDBSeFdnalFFMm1kMjVLYms3S0h6YktBZWs1?=
 =?utf-8?B?YjFZTk9wMFQyR2VoM0IyUnhVQ3lZTk01QlpTYTVTUmJwdlFLQ0VPWlkzSVpu?=
 =?utf-8?B?bDQyU3Jubm4vT0RWRjhsR1lDMG5kV1F4bWJzRmVZNHhaNExrUVlHRXl2dENJ?=
 =?utf-8?B?SWZsSEJyZVpoNUtzRFJrZm9wNnRGUjl2RUNxTFJmbG1nTEEwS2paVk8wVnpH?=
 =?utf-8?B?M3VXbkQ1bThUN1JjbmMxZDYwTzNKZ0VjNVhUSG14Z0VPZ0RnZUlOZlBQYXB1?=
 =?utf-8?B?dHp5QzdmSllkTUxXc1FTVXNWWVcyeld5SDhhOVhmT0dDNHVTVEg5N1l2WmZi?=
 =?utf-8?B?YXVXckxJSGNqL3lyOGZUVlNIY3pVN3ZkTFJ3SUJpSHczTHBneDJUVWVzUGth?=
 =?utf-8?B?VitoZytEMlduRHBSTFRIbTdrMHRzUHVtU0dsUTFYTHExRFdaT2NaUWZyaFl4?=
 =?utf-8?B?ZnhYL1VpbFEvK01jQjZVRnNXaHJmTkpiTzhuUkxjRGlLSHFydWdEdFk5NDNM?=
 =?utf-8?B?bzhxV1BtVCtwTXFMbi9wNWJwRUxaRXVrZGlrRExRMGYzVzFDY0FNRmFXNXFD?=
 =?utf-8?B?RnJLNFRaVFZHQlhhL1BlL2pOWTZhQ0JJUzM3M1AzcjU3NlBWckppTVNOVFdQ?=
 =?utf-8?B?elI0am1SczdjbHlGdnk3RlpkN1VkVWZpcXlSYlNmTGxMWEd5aEJVTU5kaDNQ?=
 =?utf-8?B?TVJiNDI5aXdLZ1lZbGY2SzFqRXNmaCt1QnJPdjErV0RSMkRSZFJoL3IrRU5l?=
 =?utf-8?B?OWhjbXFRdlpEa0kzMjZSVXJzbFNQaGhJK2ZCSG5ZWW5aZVlUMjc1RHpiQzAw?=
 =?utf-8?B?Y05GemlCVEM0c2ZxamdwYkE1ZWpxbnNYWk1uZ2k2VlZldVVjSEI3VkJMc3Fz?=
 =?utf-8?B?VjYyOEkyVUx3K0pHNUV4ZmlhZ2NZRklwelRlb2Jlb1JpMkVrWmFybE1wNVdV?=
 =?utf-8?B?STVQa1FnNXBLWmJ0b2RqaldNVG4rTzViM3BmRThwbTVlZUI2bHh5OGpxMnd6?=
 =?utf-8?B?V2k1T1R4MEhocWlaZFhCUitadXE2dlJ2MzJYa1YvMmcxd0w5Wnd2U0R2czZS?=
 =?utf-8?B?am9raWRhaU5GcXJCMXIvT0lQR1AwVTRMSGF2VVZSbEtrMXcyS29sMGZvRnFz?=
 =?utf-8?B?TjdKb1U4VVBMbStWaENVMTlwQXZUMFdoWHVJb29lYnV4R3FDN2lrc1VBNHZ6?=
 =?utf-8?B?QkZRNk1qQm5weW9WK0VnUjkzN1FlWmlKYVdveHRUOWtqSVhZYzRnR0dxTXVD?=
 =?utf-8?B?L3pGZVNJcHJzckFzUDVvSEFwa0dCUTFYSU4xWldkM3I5azBXUjFQdnZlbnNP?=
 =?utf-8?B?anhzQmhza3RTSVdjY1l0cTRNcThjdVZ5d251a2RCS0ErK2xEUmczekphUE96?=
 =?utf-8?B?VU9SeXpQZ0Fvck85dkJXVnF0MXd6MEVMdlhSK0l2YzlDWU85aCtOdFpIVld6?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b7406f-7f86-488f-f9fe-08db7ba32357
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 08:54:40.8382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrWINsfL1rhEN2FzOTrRH0n4PJkbbM35qGR0ezdTJ6jBL4JTLmTM2o0MYVgOe+3KUafdVPjauD8q+tS+mVE4jtzPLn+6IJJKlSEFASlE23c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8474
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2023 10:46 AM, Wilczynski, Michal wrote:
> Hi,
> Thanks for the review !
>
> On 6/29/2023 1:04 PM, Rafael J. Wysocki wrote:
>> I would just say "Introduce acpi_processor_osc()" in the subject and
>> then explain its role in the changelog.
> Sure,
>
>> On Tue, Jun 13, 2023 at 6:12 PM Michal Wilczynski
>> <michal.wilczynski@intel.com> wrote:
>>> Currently in ACPI code _OSC method is already used for workaround
>>> introduced in commit a21211672c9a ("ACPI / processor: Request native
>>> thermal interrupt handling via _OSC"). Create new function, similar to
>>> already existing acpi_hwp_native_thermal_lvt_osc(). Call new function
>>> acpi_processor_osc(). Make this function fulfill the purpose previously
>>> fulfilled by the workaround plus convey OSPM processor capabilities
>>> with it by setting correct processor capability bits.
>>>
>>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>  arch/x86/include/asm/acpi.h   |  3 +++
>>>  drivers/acpi/acpi_processor.c | 43 ++++++++++++++++++++++++++++++++++-
>>>  include/acpi/pdc_intel.h      |  1 +
>>>  3 files changed, 46 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
>>> index 6a498d1781e7..6c25ce2dad18 100644
>>> --- a/arch/x86/include/asm/acpi.h
>>> +++ b/arch/x86/include/asm/acpi.h
>>> @@ -112,6 +112,9 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
>>>         if (cpu_has(c, X86_FEATURE_ACPI))
>>>                 *cap |= ACPI_PDC_T_FFH;
>>>
>>> +       if (cpu_has(c, X86_FEATURE_HWP))
>>> +               *cap |= ACPI_PDC_COLLAB_PROC_PERF;
>>> +
>>>         /*
>>>          * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
>>>          */
>>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>>> index 8c5d0295a042..0de0b05b6f53 100644
>>> --- a/drivers/acpi/acpi_processor.c
>>> +++ b/drivers/acpi/acpi_processor.c
>>> @@ -591,13 +591,54 @@ void __init processor_dmi_check(void)
>>>         dmi_check_system(processor_idle_dmi_table);
>>>  }
>>>
>>> +/* vendor specific UUID indicating an Intel platform */
>>> +static u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
>>>  static bool acpi_hwp_native_thermal_lvt_set;
>>> +static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
>>> +                                            void *context, void **rv)
>>> +{
>>> +       u32 capbuf[2] = {};
>>> +       acpi_status status;
>>> +       struct acpi_osc_context osc_context = {
>>> +               .uuid_str = sb_uuid_str,
>>> +               .rev = 1,
>>> +               .cap.length = 8,
>>> +               .cap.pointer = capbuf,
>>> +       };
>>> +
>>> +       if (processor_physically_present(handle) == false)
>> if (!processor_physically_present(handle))
> Sure,
>
>>> +               return AE_OK;
>>> +
>>> +       arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
>>> +
>>> +       if (boot_option_idle_override == IDLE_NOMWAIT)
>>> +               capbuf[OSC_SUPPORT_DWORD] &=
>>> +                       ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
>>> +
>>> +       status = acpi_run_osc(handle, &osc_context);
>>> +       if (ACPI_FAILURE(status))
>>> +               return status;
>>> +
>>> +       if (osc_context.ret.pointer && osc_context.ret.length > 1) {
>>> +               u32 *capbuf_ret = osc_context.ret.pointer;
>>> +
>>> +               if (!acpi_hwp_native_thermal_lvt_set &&
>>> +                   capbuf_ret[1] & ACPI_PDC_COLLAB_PROC_PERF) {
>> Checking it in capbuf_ret[] if it was not set in capbuf[] is sort of
>> questionable.
>> Note that acpi_hwp_native_thermal_lvt_osc() sets it in capbuf[] before
>> calling acpi_run_osc().
> We can add condition before checking capbuf_ret i.e
>
> if (capbuf[OSC_SUPPORT_DWORD] & ACPI_PDC_COLLAB_PROC_PERF &&
>     osc_context.ret.pointer && osc_context.ret.length > 1)
>  
>
>>> +                       acpi_handle_info(handle,
>>> +                                        "_OSC native thermal LVT Acked\n");
>>> +                       acpi_hwp_native_thermal_lvt_set = true;
>>> +               }
>>> +       }
>>> +       kfree(osc_context.ret.pointer);
>>> +
>>> +       return AE_OK;
>>> +}
>>> +
>>>  static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
>>>                                                           u32 lvl,
>>>                                                           void *context,
>>>                                                           void **rv)
>>>  {
>>> -       u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
>>>         u32 capbuf[2];
>>>         struct acpi_osc_context osc_context = {
>>>                 .uuid_str = sb_uuid_str,
>>> diff --git a/include/acpi/pdc_intel.h b/include/acpi/pdc_intel.h
>>> index 967c552d1cd3..9427f639287f 100644
>>> --- a/include/acpi/pdc_intel.h
>>> +++ b/include/acpi/pdc_intel.h
>>> @@ -16,6 +16,7 @@
>>>  #define ACPI_PDC_C_C1_FFH              (0x0100)
>>>  #define ACPI_PDC_C_C2C3_FFH            (0x0200)
>>>  #define ACPI_PDC_SMP_P_HWCOORD         (0x0800)
>>> +#define ACPI_PDC_COLLAB_PROC_PERF      (0x1000)
>> I would call this ACPI_OSC_COLLAB_PROC_PERF to avoid confusion.
>>
>> It may also be a good idea to introduce ACPI_OSC_ symbols to replace
>> the existing ACPI_PDC_ ones (with the same values, respectively) and
>> get rid of the latter later.
> Sure I can do that, most likely in a separate commit preceeding this one, so
> it's easier to explain and review,

Actually on a second thought, maybe instead of creating _OSC specifc constants it would
be better to just generalize constant names ? As they're the same for both methods, they
are not really method specific and could be called as follows:

ACPI_PROC_CAP_C_C1_FFH
ACPI_PROC_CAP_C_C2C3_FFH

So instead of using OSC, or PDC, we just use PROC_CAP, which better explain what those bits
mean at the end, and removes the hassle of removing those PDC specifc constants in some far
away future.

Please let me know your thoughts,

Michał



>
>>>  #define ACPI_PDC_EST_CAPABILITY_SMP    (ACPI_PDC_SMP_C1PT | \
>>>                                          ACPI_PDC_C_C1_HALT | \
>>> --

