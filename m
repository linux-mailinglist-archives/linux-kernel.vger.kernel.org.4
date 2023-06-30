Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD8574381C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjF3JTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjF3JTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:19:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959404206;
        Fri, 30 Jun 2023 02:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688116733; x=1719652733;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b1MKNCIma0f7rOHtLShYmjMQBwekVx9iZployIsLzOo=;
  b=b060wtHHv59xNugyVOmGL8Dcx5J7JM2//4Vhvv9I1BA7/VVrPIYCYY6a
   aDv1Y5Cr5V4xWRX7DPuHyGmAvi2QUKo4sBaykIGl+Y5W3QmVOvLC+LF5F
   Ytp9YeWjpujqEq0SSiFn6Cn6TJCLdxr3+fUR66BKB9Z2fY2CmUzZewpql
   gT26d7j7RQJqS/n++eOyGqrLWjiRs2kp35CN8V2+RYrc9bbzSCxfZr1tr
   EHJsoco760FCzVlmQ2nP0RFIvF4HY00kCE/W6oVNRaV16sQSlmxNYkT+2
   yEVC9y2dYxAhEzR03RjH3WYcDUfI4QiL9g54S+/tuePuSYI5UzxpUdV8k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="359833223"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="359833223"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 02:18:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="964310887"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="964310887"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2023 02:18:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:18:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 02:18:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 02:18:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKqNwkT8uiF9vIIXtFRfx7L+dmMBj5Qms6pvLYXtu6Yme4h5JHWlS5/8emosNJaBG1G6B7nYpFplJMtWI77LmkPGiv3s/IAnaaWnI80vl/N9bNyMRKgSRfDl5OZU5YcjxORk/n04+UzGVU0hvzZqsH6NvXZkRgFLe54/rTRiecgg/Yn4nbAmCvjn8rlOwvJWjV9d9UYw5aNzIb1MwJtlMm2GDPxOTQgPXk7noSofaNjT5TLUUGqVTUo84YODUMbHvBN0ZvF/OzSEAqTvtFuvwdn62N36GoSFTyXGL5yZOgmATG6itdk7z36Gj9xCyTdJU5vQreAroXySTq1G/Z/6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGK5kEGaCQ8bQaPxvWsQreRlQnUD7NU1t6izANtiql0=;
 b=KdIORerHEvBaToM+oXzLAfj+RGnFGW4iYCKwcRYKEk4EYK+3hebEUeYG2ePvmeHzkp4fsUCGHkxI6I4AGD62rMvVWGSw59DAy70jSnr9uuVawxVOoid8BgDM/iQd877jK/fOCLY2cYdDK/CWUAhl8ILDH3r6nsGFg33Bh0cGxik4P9oUy4NQ0mUTThFaXZr/Cd93Fcz3GiTj+3TT9xpoWAyD3Edpesynx5as4NHCR+LdM0QrXyuEV8ZmqfZYWQjKD/YPmJ6ZOxYkV82DMn7TKZ/PMPidpv2/SGgk6Uc52kMaWBtQITXzLK4ZlNAOVN9yJxNu57c0lTEcm6W5JvF0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 09:18:44 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:18:44 +0000
Message-ID: <4de5c2da-5bdd-68fe-fa80-e96f778f7fd2@intel.com>
Date:   Fri, 30 Jun 2023 11:18:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 4/5] acpi: Use _OSC method to convey processor OSPM
 capabilities
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <andriy.shevchenko@intel.com>,
        <artem.bityutskiy@linux.intel.com>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <lenb@kernel.org>, <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <20230613161034.3496047-1-michal.wilczynski@intel.com>
 <20230613161034.3496047-5-michal.wilczynski@intel.com>
 <CAJZ5v0ig9=5wgQbH__q6BJU=p2uryReS_Lmq7s7HdWoDX6eXsQ@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0ig9=5wgQbH__q6BJU=p2uryReS_Lmq7s7HdWoDX6eXsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0278.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::13) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SJ0PR11MB4989:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6e5290-a15a-4709-f6f9-08db794b0084
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQd1W0+/Y0UbLxwZLlbxVJ8GaqajUYqviuxFApu+rqUwlI0gK+RLfXxBLbG6P4SGKl1mG2swbvIZD/KPTl2CnCuG3OcyhL6RTqc3UqwBvQojVHHF+heFRXKxUYWzTMn8jMrejKMGv05R+POB23iVua5VpyraqSBm/It2gh5s/Nv26Rk4Ibkmysei3+HRUGgR17ReTFUfWd1cLC8CE/laGyazi2yn43eptwNdutRZxYnBjz89fTfPCtF2UEzInNlkynaqcm2paCMyc9NJ2+aFP6H/o9abD7lKrkGdFnC9B1MzxBfA8Uet1kEwQjHuD0jj16hzZOFqXZlxYdR8XmHKAB8GVaerj+3kE3i1GMBkJNDdWRPFpgCPdgrNCLcGQbwr07iuL8HcBXbVB9BCmEAOjYyfYxUCtmYMFqTODoDYf+E3mz6RT3NeA5nhDILaLd9sCpaCwhs8npWMa/CmCXBrduylRcad/bUXuMR28WqKkefJUrBJZ6ahaHdCUjv4D4+h23SUWsH+ff+tljOH6pgAeMOSUVsZIreQrupbvZeEMxwxNwN7w+v27mXIY223l3GDZSv/RAFxij7D/K1UmU2Y5d6LKYn4ec3RxbOHBG0B8gUKGrYaGAllXP54ZxyeV2JVM9kpJ6ojMDEUnaRjv8UBIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(83380400001)(2616005)(2906002)(38100700002)(82960400001)(36756003)(8936002)(8676002)(5660300002)(86362001)(31686004)(6512007)(41300700001)(66946007)(66556008)(66476007)(6916009)(4326008)(6666004)(316002)(6486002)(478600001)(186003)(31696002)(53546011)(6506007)(7416002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHJaT2gzdG1QR1FUa0QyY2hLNzJMY2t4MUJLTGU5NWdnZ1N2TFNwNmpZUU1C?=
 =?utf-8?B?Qm5rWWJCaEdnUmFNK2ZRczFuMi90NXJaVGJXRnIvRHhNaGJ1VzFvVmlnbHRi?=
 =?utf-8?B?WEpHWno0MjYwYm03bHZHVDFRbFFmbW05M0pwM0NsYnhuZkkvRk0rMVRxOGM5?=
 =?utf-8?B?YUhFMjBLOGNhTWljaFdhaENQVk5WUll0bTRyOER1aXNsOGNrTG1GMjZ2UWtx?=
 =?utf-8?B?cTZsakE1Ry9sZWRwbDd6Wk9WTmtQOVZUUU5xWW1KMTI1UUIzNWJVUGdEWWJ0?=
 =?utf-8?B?ZEFIbnZOYWN6QXZ6cGs4QVpNQ0JEMDFxUjVOUXBYNWRJQy9qaFg0V2RnTUlh?=
 =?utf-8?B?YzZUV2FQQlNId0prSlZOMFE1cExNOUtsN01ndjZVT1VEUzkyZ1dGMHY5U3dK?=
 =?utf-8?B?VURQY0hKV0ZUTlIzSFlDOWlhdFUyQ3IyaG5xb25NV25xaHc1VUhXRmQxd3E1?=
 =?utf-8?B?K3RELzJVNmdSOVpzYmJYMjZoVHppZHFCMG9hUm44NzFBZkFQYmVTWm1KSjJN?=
 =?utf-8?B?eUd6c0FFNlVxeHpHRlFzcXRiV2lxUHBNd0NxZzJtbFpneW5xSDE1SHZFN2tJ?=
 =?utf-8?B?S3RrRGZKek9SYXk0WWYrM09MTVEzWnFxZkNYcm5nVSttYThBZDFVSmUxRVNO?=
 =?utf-8?B?eGExOC93a2x5QTIwREM1eWlWYW1mck1KaVdCTEVyWnRMSWNCa0ozOUpjQjhH?=
 =?utf-8?B?dkJhNld6cjM1cXh0UDV2MTN1bm1LbG0rMk9wcFdwcVJtMndnWjhkMXNYN3RL?=
 =?utf-8?B?eWpqWm54d0U3SUlkc0NuVnRLQWxBc1puLzNkNk1UaERCNXl6NlRHR3o3R2Vz?=
 =?utf-8?B?alN3ZGdVS0JWQjFVWlVDaUtMU0p4ZVBUMVRSd1Fld1FyQW14ZWc2UkNvcEdV?=
 =?utf-8?B?SWFxVU9UVE9YTXMvODRtTkp6WXpzKzBPOHdEUzNsWUdUM2hEYVhrNS9FOTVT?=
 =?utf-8?B?aXlOSGYyWEp2UGhNckJyTG5RTmVHbHFWcDEvVlpNaGczdGlQMkFRaSs3YXRt?=
 =?utf-8?B?enh2dzBsVndMa3p1VU1LK3FpMFF3REgrMlhKK080cldscGw2b1doMHhsNUlk?=
 =?utf-8?B?dWs4RFQ3aDVXMUd5Szlrck5OcE5rMFBTeHRMQndKdXJVcTRyS2pPelVpSjBn?=
 =?utf-8?B?d1dOVHZJMlJGRGV5em1sNndmYVhtQUlzSnR3ZktpOWxWV2VGaGNINDdMYnZK?=
 =?utf-8?B?RjJCSTlGejFRUUh4cDZiNkU5S1hvcWFZM2Q3akFEelpjZkxqRWtMZnpTMElD?=
 =?utf-8?B?dDVyRjRVcGQzcldkaU1yUUVXNGJ5UW5NdkY5cUpEWU1ldXNuWHdDZXhOanpN?=
 =?utf-8?B?MEw1bHJ3Vm9xTnQ2ZjhsMzJxWWJ5NXcwdkMzK2dLelFVcC84cFZUSWl6Um5n?=
 =?utf-8?B?MDdVbjM0T1N5VTFVRUVHSHo5MFBIdDFVQksyeVFBZlFLQ2hpaTArZnVHdG8r?=
 =?utf-8?B?bU9uNTFsSEdkd1M3WXBjWVZtRi9SdnpwSERjNHhZMVQxTkMyUDZJZW9VeWgv?=
 =?utf-8?B?RHpiaU5xUzd4QzhqVUJsamtId1dnSVptQ05xT0gwT1Z6a1JmK0hwVlpZN2JE?=
 =?utf-8?B?TENza3p5ZTBYU3RtbElXYkFjQ2VvMXl0bG9wVXBaTUdkT3ZEbUtGakVSQjBR?=
 =?utf-8?B?T0pIMVpObE40djRHM29obGo3Qkozek1DWjlPTngyZ3ZzSjBwR3QzZm9Oa0NC?=
 =?utf-8?B?cE1CYy9CbXRQRVpKeWdwckVQSDRzV3pyTTZCQzZSMXBDd04vZEpDYi85L2VL?=
 =?utf-8?B?UFZsNms0OVpLbXNNUUhRNVJjc0w1R1hUUUVaVlROZVRXaDU2bTRYWXdQRW43?=
 =?utf-8?B?UGJ5TitKeGV4aysrZVY1Q2dYSVNmd0EwS1F2QWhiTFlZUS9BQ05MZmNKNU5j?=
 =?utf-8?B?SWQ4Ulp6aDhKbkc5QU1qK2ZId3dNZHZXbmowUUlKU21ycXRYYngvUnVHUjFS?=
 =?utf-8?B?bFQxN3E0UnhycDFDZ1RwOXo3ZFFpZlUvMW51ZXpxbDdVczdGeWNGM0M5Q3Fp?=
 =?utf-8?B?UW95UExWeXI5NnR5NWZuY0pXcjdPWDBmajFVMEo2WVJTc0V5UjdwSmRBQUsy?=
 =?utf-8?B?T3QxOVFSN0gxbVQ1ZTZMN09ocUliQnh2bDNBemJnNDNPMUlVK0FsRWxrazNL?=
 =?utf-8?B?ME9FV256Ny82a1UyaGMrM0dTWXgwalBWTk9HYXpndWQvelZjMmtURU9lRi83?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6e5290-a15a-4709-f6f9-08db794b0084
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:18:44.3653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12E5Xiilly1Pjn4Sf0Os1kaNwB1ime4TchEJmOM/zcLpZ4Fi1Du93S5yYtrx/hjqoRF+056zkcJjjuvsvZMiV0p0WmiERItyzsOe1vW/ihY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4989
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2023 4:23 PM, Rafael J. Wysocki wrote:
> On Tue, Jun 13, 2023 at 6:12 PM Michal Wilczynski
> <michal.wilczynski@intel.com> wrote:
>> Change acpi_early_processor_osc() to return value in case of the failure.
>> Make it more generic - previously it served only to execute workaround
>> for buggy BIOS in Skylake systems. Now it will walk through ACPI
>> namespace looking for processor objects and will convey OSPM processor
>> capabilities using _OSC method.
>>
>> Prefer using _OSC method over deprecated _PDC in the acpi_bus_init(). In
>> case of the failure of the _OSC, try using  _PDC as a fallback.
>>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/acpi/acpi_processor.c | 23 +++++++++++++----------
>>  drivers/acpi/bus.c            | 13 +++++++++----
>>  drivers/acpi/internal.h       |  9 +--------
>>  3 files changed, 23 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>> index 0de0b05b6f53..8965e01406e0 100644
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -669,17 +669,20 @@ static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
>>         return AE_OK;
>>  }
>>
>> -void __init acpi_early_processor_osc(void)
> I would rename this to something like
> acpi_early_processor_control_setup() and would make it attempt to call
> _PDC if _OSC doesn't work.
>
> Then it could remain void and it could be put under a
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC #ifdef.

Sure, makes sense to me

>
>> +acpi_status __init acpi_early_processor_osc(void)
>>  {
>> -       if (boot_cpu_has(X86_FEATURE_HWP)) {
>> -               acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
>> -                                   ACPI_UINT32_MAX,
>> -                                   acpi_hwp_native_thermal_lvt_osc,
>> -                                   NULL, NULL, NULL);
>> -               acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID,
>> -                                acpi_hwp_native_thermal_lvt_osc,
>> -                                NULL, NULL);
>> -       }
>> +       acpi_status status;
>> +
>> +       processor_dmi_check();
>> +
>> +       status = acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
>> +                                    ACPI_UINT32_MAX, acpi_processor_osc, NULL,
>> +                                    NULL, NULL);
>> +       if (ACPI_FAILURE(status))
>> +               return status;
>> +
>> +       return acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, acpi_processor_osc,
>> +                               NULL, NULL);
>>  }
>>  #endif
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index d161ff707de4..e8d1f645224f 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1317,9 +1317,6 @@ static int __init acpi_bus_init(void)
>>                 goto error1;
>>         }
>>
>> -       /* Set capability bits for _OSC under processor scope */
>> -       acpi_early_processor_osc();
>> -
>>         /*
>>          * _OSC method may exist in module level code,
>>          * so it must be run after ACPI_FULL_INITIALIZATION
>> @@ -1335,7 +1332,15 @@ static int __init acpi_bus_init(void)
>>
>>         acpi_sysfs_init();
>>
>> -       acpi_early_processor_set_pdc();
>> +#ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
>> +       status = acpi_early_processor_osc();
>> +       if (ACPI_FAILURE(status)) {
>> +               pr_err("_OSC methods failed, trying _PDC\n");
>> +               acpi_early_processor_set_pdc();
>> +       } else {
>> +               pr_info("_OSC methods ran successfully\n");
>> +       }
>> +#endif
>>
>>         /*
>>          * Maybe EC region is required at bus_scan/acpi_get_devices. So it
>> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
>> index f979a2f7077c..e7cc41313997 100644
>> --- a/drivers/acpi/internal.h
>> +++ b/drivers/acpi/internal.h
>> @@ -151,17 +151,10 @@ int acpi_wakeup_device_init(void);
>>     -------------------------------------------------------------------------- */
>>  #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
>>  void acpi_early_processor_set_pdc(void);
>> +acpi_status acpi_early_processor_osc(void);
>>
>>  void processor_dmi_check(void);
>>  bool processor_physically_present(acpi_handle handle);
>> -#else
>> -static inline void acpi_early_processor_set_pdc(void) {}
>> -#endif
>> -
>> -#ifdef CONFIG_X86
>> -void acpi_early_processor_osc(void);
>> -#else
>> -static inline void acpi_early_processor_osc(void) {}
>>  #endif
>>
>>  /* --------------------------------------------------------------------------
>> --

