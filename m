Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922A764DF7E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiLORQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiLORQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:16:11 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400162EF47;
        Thu, 15 Dec 2022 09:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671124569; x=1702660569;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C/jmFiuAncroBt+jqSFVlhmHsKxhxGQOCjGJ5hFsGfg=;
  b=BHrECSJOf5TVJq63NaqlSP01CXWJh4pHj+Lkok/QxqX7xHe/2OInuG5Y
   JYUpEO/T0dlCfMmtbixAFG+sTZx7Jc6LMuzq7bIIHKGr07CzDNefBjDM5
   rDa3q3ykkB6+5AHQ5sj2fryfUVALW4wcnEh3MG58IyIYNMNSj6nFkq8+T
   B6EZxUgoe0tWcZEidkWIbFR70/TI3w2HV42CACtjZiQX7QKhUx+nKha3Z
   EAMjTaVLrEL3V0yQjNsh5XPSVblSVjj0v1ywQsUVk1H6jKl4QwnYmmDOg
   v6UroInolam7E49O46fihzojE1wOeUd3fM34lBXV+1qudZ+Hn1iu2/tte
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="318788469"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="318788469"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="627266615"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="627266615"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2022 09:14:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:14:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:14:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 09:14:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ph8V8dUkDoVeZ0wTzrRttNZ6pd7o9VwTVAGy7tSf5t1g68cNqlDPO5o3niG90v88+LZl57P9vVSniufsg9j4303QokpTlnu8YS4WuIaFkDA5o+QTK+ilDQnpnSqKH9encEr+SGKw3UuZNuAohKPOUhu+MBqdn0kkSVqUgCDtGhOTABD28m36UDniQ7AKNuQ/lJVBedAAxvLZWlZiTAVkHIHjNG8I+A9GIVbs/tTp/KzYVz3LhO+uEd710BXkm2qms+cEk4EH8roouRdvIYfMgUiQhxMw7sUdbLzjdRqVo2BHKnon1ZhhKYQUterg2ufjm8powZePoYPZSSRtZsyfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UepokV7Neu3LSw2JIttvD8ZaJojaXtBbO2spZtH0XSI=;
 b=c/sndf3nxsBZnRQIo6of2dDRAnEtLKIX9iF+uaMFOZ4fqrvXsVabeVDMZqAqpAMpY4CDEuGlJiB/Y1I4yQeKknukN8nFTz1YYKB40rHlk9DmiRrLyUpRCKyGCVKryUrR0xsuH7AUVRCUwcZxbaqWRSuncXKLDvs03bDEKYABKfbZHDRCVBIxJFfJKwNRLnZ08pYNKoo8csJ+SeMSXjVKqbm/IM2IQmWzTdZBL2vHPNEEyBI0WXMxHr/cqgOUIIxxT7Rhyxqc12cR5+RDJ6AoeD7RL2yoiwZi81traAglx5K98BBP6BG0ZDGJ1S8UX6OXAO0XW5Qsi3mmzlgL6e7AVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB7374.namprd11.prod.outlook.com (2603:10b6:8:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 17:13:58 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 17:13:58 +0000
Message-ID: <392f2e9a-27d0-15c9-923d-6c829c6ae5fb@intel.com>
Date:   Thu, 15 Dec 2022 09:13:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 05/13] x86/resctrl: Detect and configure Slow Memory
 Bandwidth Allocation
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
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
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990899399.17806.8574636266624372983.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990899399.17806.8574636266624372983.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::26) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: c39062bb-df78-454b-a3bd-08dadebfc0fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IaQIZ3SDiLyEZv+RwVfAfghd30/4H/LVI3YbeCv8LEY+dz85ATVpNi5CNgI8dVMMLLhUKyZwUZyGJqYf9hJmhPvL+GuKJraCpv1gskBBK0dtcX1IV4NDjXI1X283PTqrE7InIJ26JNlWJeIbDVoF6a2h+9NwPSnETCytDNWRwp6glkdU2xsTEAtR5PGRjQGSGRzqgFWHfmKl3t77SZDT2KOVUaR3Ng7sUuQ+QDGZ4xmCnxxg6ZfuBQIyfFWIIYc0i5CstOBm4xx/u5uGZxVyGRbXvLZrENNKrXp0c8Bq+OsvkPbfcAU+LmGqduesXHM+wCe48Z8npj5UOmFuCxzOmCCbvVxxb+Wbl6XHsX2HVcQnNM0OFxz/4BUPyTn7XqHhvOxv8aoo0TbtoUUHfImIyTOVbgFwgEhKEJrfVbz8yG3GbxnpdC0K3W0U9rHK6m+pQKXxtj37PAjZ89SQxc6a/NMZXBJR8JIFPwdiLNfEH4W90Wm3mx49DKv4TMm5IgPPHA4nyXlmcjlLAsThjRtANl7pU6kWOFggONO/EzJOs2IRdn8GyxLg9wedYwKKUn+lZkvlWH8ut62YIeUn0yXz9eKZfe6LpAkieuRcUBhQsZK0dipQ9wQYV4zfBXVkC+tcVd/iJHsQxOXIkD1JxnTlSTjHFBVAboy2stl5BpyZAeAFFCnlgTjvCX1/mJEpKnoY7S9HVGeDWUUhyj9bfS5j8dF60PgvhE9eNa0p2TzRz9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199015)(478600001)(86362001)(31686004)(6666004)(31696002)(6486002)(38100700002)(6506007)(53546011)(6512007)(26005)(186003)(82960400001)(8936002)(41300700001)(7406005)(44832011)(83380400001)(316002)(36756003)(2906002)(7416002)(2616005)(8676002)(66476007)(4326008)(66946007)(66556008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckkxV0lKeGk3WHpYQ0dIcUplNHlVNVQ4U0Exd1haV2VENXFrQ2ZnSEYzeXEw?=
 =?utf-8?B?cXdPaWtIQ0hHaFR4N2hzcW53NC82bHQ3akdraTZFaEJ3OEtnaGRDcTNvbkxp?=
 =?utf-8?B?dWplbFZISVc1LzRlTFczZlo0VnpBWlJYTm9LU2VOS2FMM2kzY0p2bDV6enR6?=
 =?utf-8?B?dDQvMlE2em1EYkYrY3gwUjM0OEFsY1A1bWcrYXYvTkJYNERlcWtuaGU1ZGZ6?=
 =?utf-8?B?Ujh3Z3VKRVMyMEtKQnhCNjlQYWVhL0xZSVFBSzlLaUE2ZzFTbGhqNGNGQjBJ?=
 =?utf-8?B?bFhnNXFRMWdRejJuQjdkMHRPdEJsRTNDQ2R6NitFWkRGdGdwWFk2QS9OUFZt?=
 =?utf-8?B?WVJiNUsybzlhZlgvb0c3RHNwZTRqSzZCdW1XTTFobjNDYmI0M1lhQW1mS1Bn?=
 =?utf-8?B?VU5iUXlGcVpKbUhlNVlSYkw5UzBwWlFaalFaS0NKbUlpVHdrcnJTb29ubVI1?=
 =?utf-8?B?aityK3pvUHc3bFN1ZFUzb21zNkVJL2ZNRDlPNHcxbEQ0L25lQnhaNXdVandD?=
 =?utf-8?B?aDVEU21oK3RwdUNlWEtYdjJCdmlMVmpHemhzNUljWWdYaVdhd1NxMGs1TG5M?=
 =?utf-8?B?aUp5NXgyeUxYR2lVQnVmQnFrRzJDeVJ4Z2h3VVJ0OUw4MGM4UnN3MkJjNHFT?=
 =?utf-8?B?N045MVREby9kWGdRSnk5WGpBU0hOdE5UdmJGT3RmZ1JXNzNHTUYxSTE5bjBm?=
 =?utf-8?B?aWREcEJEME9YcEFCL2o4STcwajRQbkRyZWxJYk1CMUFvdHNmaE84alBFUWpy?=
 =?utf-8?B?RU5NV0FmU2hZb0dsMWpjUGZyS0Vjdi9ZOTlNVUpnNmwyVzZLL1Z2MkV5RFR6?=
 =?utf-8?B?T0VjNlRMVCttb0xTeWNQQVJKc0kvNlh4YTVnaXFPUzFjckk3d3l4Q1pRaUdn?=
 =?utf-8?B?VGVZWWM3U1U1aU5UTDVaVWhWa1hIZDUyckoreGEyYW9ZYTBIN1NTVUdOQ2hV?=
 =?utf-8?B?NUJ5WGRzbXBHSmQ2WEVIVUgxOHk1VFF3RGdpTkZFcUhLNURuTm12a2hhY050?=
 =?utf-8?B?N2lPTGJYd0QwZ09nejBPRllMekpHSXNpVFdVZWF5bVFZRVZ3TjZlR3Y5b0tU?=
 =?utf-8?B?cFdTTjFHMlRieFVmQVY0Ry9oSDV1TU1ZeUxYSXNlTFFYOEdma3hndzJGSk83?=
 =?utf-8?B?R1N2U1Z4MkdoSVZUM0UxSjN4NHlPdlU0M0RxaG11MFZ2NXQ3eEJrUWNtQVg3?=
 =?utf-8?B?RS8wbXU4RFhKdHVCNDNFNVNHbFdJUS93VVNvVlFBY3l5SEVMeXRyU1RBYXEw?=
 =?utf-8?B?M2dndkx2YzJNVDBTL0R4NDBNNm8reDBVdStLZE42NGN1N29BWjRLN1NzbTh2?=
 =?utf-8?B?L1Z4b0l0OWcrbnd5WGwxMzVidkVZa2NHUnhsRkQ3dEZEcGhqSXVFODI1Tngy?=
 =?utf-8?B?bWFuQTdhUERvdHJpRHhTbCs5Tjd6TFJBQnlVUmtpZGJGajNFcEw3NnkraGtQ?=
 =?utf-8?B?TUcxWmY4QnRkMU9ISkRYaDF4WlRIM3FkcnFuL0ErNGJSbmoxOVpHVHBUT3pv?=
 =?utf-8?B?UmxHMktTTDhqWENsL2praCtwdjJrQkZPMTNDZUdXejVIRCs3dE5PMHdHMHMv?=
 =?utf-8?B?cURNRDUraUdDSFpKVjVnQzFSWjJoaHNManhFZkg2Mi92UlVGdWxVTzVoakpH?=
 =?utf-8?B?QkY5WWVERGEyM3NaNkpMN0ppZFRzbWNMTFo3TXFlWmhNOExwZ0dwdVM0Rmdv?=
 =?utf-8?B?OWVqTWZGZEFoa2Q1QXZrZlkrNTdJcXI2Z2psREFxU1RDajlWcVJjU2toMGI3?=
 =?utf-8?B?MVZvVTFxUjNUdXhHcTlXWXFUQndNTlJiUW95VUZvc3BndkR4QnkxUjNITzRD?=
 =?utf-8?B?WXN6VGxDaW1hYU1waEFVbFlzRlRxTS9vaE9hb3RTSTVpWVp1d0Z1UVFhaW9E?=
 =?utf-8?B?bVdGNUZSSmtMRzJ2ZGg4SXVvNk5CSnZ5WlhLdjBMVFJzKzdQN2VzMjhYNHRL?=
 =?utf-8?B?NHJKVVA0YzZEYk8wTkVqQVUwVEJpMEExZjNwVzlKUEdKM01ZNTJxaWxIUnEy?=
 =?utf-8?B?NFdLY0VPWTdXR3MrQmhUK1B0aVRCTERSL1BBS3VPcUQwMEdHZ1Y0UmJXdTFh?=
 =?utf-8?B?cVdMb0hmZFIrak9XYmg3Uy9Rbkg4MUVTYlVGT3ZqTHBxNWlkKzIyYTQ0eEZS?=
 =?utf-8?B?TkFQNFlqMGVTQ0UveHFEMmZGRmZCNUVseG5qQnYrUitoMnRTNmhubldPM2hh?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c39062bb-df78-454b-a3bd-08dadebfc0fb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:13:58.6683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4Cv/Ru7AECPBVGax3a2LjM0U4aDtdK4YAA6CwbhiDTwE7KaT1hriwpaO3BWyu7bO1afORN4o5/rXoY4egb6mGt+wJqOlWOTFmxklJ6+1H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7374
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/1/2022 7:36 AM, Babu Moger wrote:
> The QoS slow memory configuration details are available via
> CPUID_Fn80000020_EDX_x02. Detect the available details and
> initialize the rest to defaults.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h          |    1 +
>  arch/x86/kernel/cpu/resctrl/core.c        |   36 +++++++++++++++++++++++++++--
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |    2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |    8 ++++--
>  4 files changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 37ff47552bcb..e0a40027aa62 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1061,6 +1061,7 @@
>  
>  /* - AMD: */
>  #define MSR_IA32_MBA_BW_BASE		0xc0000200
> +#define MSR_IA32_SMBA_BW_BASE		0xc0000280
>  
>  /* MSR_IA32_VMX_MISC bits */
>  #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 10a8c9d96f32..b4fc851f6489 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -162,6 +162,13 @@ bool is_mba_sc(struct rdt_resource *r)
>  	if (!r)
>  		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;
>  
> +	/*
> +	 * The software controller support is only applicable to MBA resource.
> +	 * Make sure to check for resource type.
> +	 */
> +	if (r->rid != RDT_RESOURCE_MBA)
> +		return false;
> +
>  	return r->membw.mba_sc;
>  }
>  
> @@ -225,9 +232,15 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	union cpuid_0x10_3_eax eax;
>  	union cpuid_0x10_x_edx edx;
> -	u32 ebx, ecx;
> +	u32 ebx, ecx, subleaf;
>  
> -	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);
> +	/*
> +	 * Query CPUID_Fn80000020_EDX_x01 for MBA and
> +	 * CPUID_Fn80000020_EDX_x02 for SMBA
> +	 */
> +	subleaf = (r->rid == RDT_RESOURCE_SMBA) ? 2 :  1;
> +
> +	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
>  	hw_res->num_closid = edx.split.cos_max + 1;
>  	r->default_ctrl = MAX_MBA_BW_AMD;
>  
> @@ -750,6 +763,19 @@ static __init bool get_mem_config(void)
>  	return false;
>  }
>  
> +static __init bool get_slow_mem_config(void)
> +{
> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_SMBA];
> +
> +	if (!rdt_cpu_has(X86_FEATURE_SMBA))
> +		return false;
> +
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);
> +
> +	return false;
> +}
> +
>  static __init bool get_rdt_alloc_resources(void)
>  {
>  	struct rdt_resource *r;
> @@ -780,6 +806,9 @@ static __init bool get_rdt_alloc_resources(void)
>  	if (get_mem_config())
>  		ret = true;
>  
> +	if (get_slow_mem_config())
> +		ret = true;
> +
>  	return ret;
>  }
>  
> @@ -869,6 +898,9 @@ static __init void rdt_init_res_defs_amd(void)
>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>  			hw_res->msr_update = mba_wrmsr_amd;
> +		} else if (r->rid == RDT_RESOURCE_SMBA) {
> +			hw_res->msr_base = MSR_IA32_SMBA_BW_BASE;
> +			hw_res->msr_update = mba_wrmsr_amd;
>  		}
>  	}
>  }
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 1df0e3262bca..2dd4b8c47f23 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -209,7 +209,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
>  	unsigned long dom_id;
>  
>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
> -	    r->rid == RDT_RESOURCE_MBA) {
> +	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)) {
>  		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
>  		return -EINVAL;
>  	}
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e5a48f05e787..8a3dafc0dbf7 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1213,7 +1213,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>  
>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>  		r = s->res;
> -		if (r->rid == RDT_RESOURCE_MBA)
> +		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
>  			continue;
>  		has_cache = true;
>  		list_for_each_entry(d, &r->domains, list) {
> @@ -1402,7 +1402,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  					ctrl = resctrl_arch_get_config(r, d,
>  								       closid,
>  								       type);
> -				if (r->rid == RDT_RESOURCE_MBA)
> +				if (r->rid == RDT_RESOURCE_MBA ||
> +				    r->rid == RDT_RESOURCE_SMBA)
>  					size = ctrl;
>  				else
>  					size = rdtgroup_cbm_to_size(r, d, ctrl);
> @@ -2845,7 +2846,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>  
>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>  		r = s->res;
> -		if (r->rid == RDT_RESOURCE_MBA) {
> +		if (r->rid == RDT_RESOURCE_MBA ||
> +		    r->rid == RDT_RESOURCE_SMBA) {
>  			rdtgroup_init_mba(r, rdtgrp->closid);
>  			if (is_mba_sc(r))
>  				continue;
> 
> 

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
