Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AAF5FBEE8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 03:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJLBkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 21:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJLBkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 21:40:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265D9A2844
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 18:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665538837; x=1697074837;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=taCHtXVPbBQA8FPlUHonRujUKGuRvRnrF/aPYiwSgaI=;
  b=FOUzoG6FV0A9eZYTDMhEEwYVw2hG2wgONIurVRGGOftaRR25SRqf2c6J
   HI4PaRZlYTYgv50qesFbaX7ss8OZV4ZymunlfGLX8F45bd+DJgzkTb7CM
   USxo5Av2kQ7HnwYC3w8WDtYaTor/H33RCghmoawKp7qsme2u6FiGwU5pw
   zMCc2PMUNZJs+69cMUzl3JuhOF89pilKPjoF3K4GQPMJYa2aDYuTXrFzE
   s/Z0xsyaPbt8OpA9+avotNPJkew+YYiBxPwchaUCZRGVgR+MpIP+j/ruN
   cG+Ed9o8I1/L1n4Y7nRQxCDP9Vtmlrbi/8BvlTLtwm1prLxMmiT/IGNpf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="306296844"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="306296844"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 18:40:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="621609764"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="621609764"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 11 Oct 2022 18:40:36 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 18:40:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 18:40:35 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 18:40:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVgU2q9NzUi5iW5rWpKl27iwnyDgYB4e09hFut34XUT9z9QOEBBNuPvHnahUgmaCWbTh2pMU2xDM77QTLRhg1YBYAN8ZZsu5XmTJKi6QscB2NbveJamLSCb8Ga/1eQm5BqWjwBqm/AAZ8N7Z8fWA3a0JAtM55GOSnJaAUDPqTTwi8qnYJRA7uGzsOIOaf9qfymzVCIOJ/rvmp+ptCQweZ48X3MTafX1NkIKIh5hkE1FOwt9DF123ROG1AOf1p6nO9tVHCM1x5C2W20NyDGOf8YJBKRo25GUNTzWaI7LPPDmhoMizqUg7em1v3goTEw2VBbEVKBK2IiW2lRD0fpJjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hp5QbkHPf5H3CAcl1lO2QHnzhkrY/64CIV+zyQUP9cE=;
 b=a+OypGbE6X4FatsU43rZEYtQg8E65p5PWE5qj4MO3HdPwahk++H+c5zGtAOU2FEXmsSf7jVVXgJfHUVAygnirH9zg+FDMKYUz+9CRCdMy2BFMpUiFuT+75JNvuwoMWVy5uW5BB0ZaS+1pjKWA0i2QN0K69ram78BPINAhkqxuYI3jfsjvnWb6o3A1j2d0OpjhwAgdMcTdpHdFG01Q7TtYyRwXcsw7ClGZH4aww2Om1DSujpFwl3JgAYsAj3W4OjL3+LUVgMZ/ONWBko4NKyP1gMUTXy6kLEmUOdV9EjZQviSn73VflFwiEugRzW08WbJRFT3HufJHWRdISskot5e6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH8PR11MB6951.namprd11.prod.outlook.com (2603:10b6:510:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.18; Wed, 12 Oct
 2022 01:40:29 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e%9]) with mapi id 15.20.5709.015; Wed, 12 Oct 2022
 01:40:28 +0000
Message-ID: <cca7e8ec-9fa0-7517-12d2-b0fd115bb9e9@intel.com>
Date:   Tue, 11 Oct 2022 18:40:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 1/6] x86/cpufeature: add cpu feature bit for LKGS
Content-Language: en-CA
To:     Xin Li <xin3.li@intel.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <peterz@infradead.org>
References: <20221010190159.11920-1-xin3.li@intel.com>
 <20221010190159.11920-2-xin3.li@intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20221010190159.11920-2-xin3.li@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:180::41) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|PH8PR11MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d939868-a54f-49d6-a513-08daabf2be0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9A1Jj8k7o0eMey5Uc+6XHCCGYuMp39cmPdfMlzzrnKJMQ74EF2intbI/jVvip6t8bvbtlJzqkR2IIoAvpcK0qpCLhtI68xEDo37L6kxDNV8DIaGm6zEEiB5YxYAYXUu2NSVl1FJwvV+080ySOFxaACGr3EGwMiyk9QNpWbh6ZgSVaNVwLoAxO1f6UIwbr7PDN1GYWJ4KWOJ6IgKpzOkbX1RtIZJDFfFUYQDKUtezdAgdnjaMnR28eyWECR5z0y6EwycU5jXrCqqIZCXDF6EumoTwmU0gTe1eNWjQqEQOrEpoZHIBxEBhU5IbWxYsrZpqSIw2n4qiSvWB4cD+1QifUFz/gjcy3rLJzimJUThm9s6EtNL3Fwp8NaVppvEVB7TPFTPxiuCgVnopG53CiI2oS3BeTepc6oCB73CRaq8xnu+Pgj5/P0R+08FXH8RwtOsAlXr+mEE1m79WRKrreBOFnt8l+QCujBaYP/tvXoxlwukqoULLx5/0sUf42cpl8WNsKf4tEwuxY927lsLnDjQLmAG6dJkLRJjjFtSNJtdaw9/iuSFAV+O4dCM1KrtgPks16PtKSg0ZbVWnse2OZCuPAeGULGTQxI08BYSoP+xf4aRdOhNybksYTlEorH05+cqxxARZBMYJc3WfJTIG+TJl6XUD2H4Or7P3PbaakmcL7+urUqEr0Q41O26qahTvAywD/S999jnZmtU9QEkPuLHX9vmTg0uaNHh3jgfGdImst8tMtJqFWvxFH/EnmfKuQlYB8oVBOL1V4rWxMrk/OzaqSyroOgBAIwnjH9gVsMa5hgHeptO57IXx93lqWQtRGTr6QGUbmgWwxpnO54TC+DMd6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199015)(31686004)(82960400001)(66946007)(186003)(2616005)(2906002)(6506007)(316002)(5660300002)(26005)(8936002)(6512007)(4744005)(53546011)(36756003)(86362001)(8676002)(66476007)(66556008)(31696002)(38100700002)(4326008)(41300700001)(966005)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUU1d2hTTDFKZkNQRk1uVVVQZzRpN1FQcnR3U3JVRWVTcFlZSC8xdVRIKzlr?=
 =?utf-8?B?QjdFVUFZTDJKSWduYlhZUGs0OFBmZzNFWHpLMTFqeW1Sd0pvQWNpcGg2MGpu?=
 =?utf-8?B?WlZBOTI0NjBEUDNsdUs0UWNWYWRJak9VUVNnYmhMcG0zTHFGRHdGVldMeExw?=
 =?utf-8?B?Q2pRUmE3aGZlY0hCNERyYzhqUm41Wmx5WVozVXJ0aDgxZ1dHVlBTSDNpVGUw?=
 =?utf-8?B?alZjM0NSUlIwemtBQ29rQVJiZFVXd3hDbHR5cUJsMGFLd1dZUWZKajYwaFo4?=
 =?utf-8?B?QlFmeE4wdXVJbVBON1AwQXpabXlwMHFXQU5YaFdyN1VNRXQvd3orNWw1RW5E?=
 =?utf-8?B?Vmo0anVod0RCZDZ6cjdSQjZ5cHV6U0tmQURtRzkvd0lvSlBqY2lxQ0Z1K2VR?=
 =?utf-8?B?dkJsZkNEWDFKeFo3dzBRVWpKdXVGYTJoSmdSaWJTM1poVVdNSytyeTZkMEtS?=
 =?utf-8?B?aGhDWTRPL1JiaURBRVZsWktiU2Q5UzlDZm9DVHFPck0rbkJyQTVyTEtBK0o5?=
 =?utf-8?B?MWs3emhkRFJRejNGZWxyM2hOWWF0OC9MandZN1FOalRyQTg2Z01yYTAxdW1W?=
 =?utf-8?B?R2c0dmtvK3E4amlaeVVOMElJc1o5U25DQU5SQmd4VWVOemU2Z0pINzJ0cGsv?=
 =?utf-8?B?djNtckI0K3cyc0x3R0c5K29STWRuN3hXZ0VvVW1ySWJNSytFSmtiZk1ZSGpG?=
 =?utf-8?B?U3JzSExqbHpldzhta1NXbWcvN1hSVElzMGZkRkFnczk4YlltZTVaUjd2cjY0?=
 =?utf-8?B?anZGcXJ3VWsxRExFTXV4dGxxTUhUeTVLRXE5WkRwTU9GT2RLK2lpKzVBbVU2?=
 =?utf-8?B?ZVRmclR6NHdldTRUNU5XTHpCb3RFQm1zV0xJRC9EK0lSclBpTWl6Q1ZoUzV5?=
 =?utf-8?B?ZE1PSk1tZmRWdzRVMEtFOHdmeGdhMFlIa2J1cmUzRm10Mm5iM2tGanhpVWQ1?=
 =?utf-8?B?N0xZMUY0bExQVkRmTUVueDQ1L3p5VTlMVStOUG43R3BCTjc4elRUaG8xM1F2?=
 =?utf-8?B?MTVFaFpyRGNiNkd3eG9FQmF6Y0RSQmEwV05Xb0FCVGlqeTE5dTdjY3huaXFp?=
 =?utf-8?B?QlJwZ1R0NUREbXBMRW03MnlIeEhTVlltV1lyYWRUaWNsTitDbk14eFlsN0NJ?=
 =?utf-8?B?a2tIRmZ6K25DeHpHdFR6eVI2TktYQVFNMXQ2UUtCZURrRHZDazlTdEMzU0dN?=
 =?utf-8?B?SmcrVENVakVSSzhpUHArYU95REFqb2dZYkNWWlQ2dXdlMWYrNENiWjFaUU9G?=
 =?utf-8?B?UTRuS1F0Y2xqeURodjFNMkdVVU10L3BraS9uQitZbHYrU05jSkxlQkpDOFFm?=
 =?utf-8?B?ZG85eDlrZzBkQlVJdEppMnZqMC8yU0lxVWVTb3BRSTdMenNVTWZPb01KWjZR?=
 =?utf-8?B?dkFRamwrWWZyVlN4SVN3VVB5WGdTcUFBV3VpYWZyOW50U3lHcnVUTElVWlpO?=
 =?utf-8?B?ZjhPSVFHaTk3NVcwU1JNcmJNSkNLSU5Ec1dYUEFONkRHbUFpK2pGMFJobVpF?=
 =?utf-8?B?UytubEZQZFBnUnd6NnRUZlU4TlR4UGkxNXVXRi9PQi9JRVBWTElNdWdXVyta?=
 =?utf-8?B?bGdGVlBTd1dQMFE5dWdSRE1hb3kvSVR4emx2QUZYOTZWZzZxQkxlcmZ4TTNT?=
 =?utf-8?B?ZFRuTXMveEIyaGZJMGpxYzZKTjFOUXBrMjVkTEFWMGJMQUNwU0toTzlZOThu?=
 =?utf-8?B?Um5CbmJMR2pEUHZ4MnJhVGtlK05MeVpDQkxZeHlMYnJxUzdLcmFMcEZZdVY4?=
 =?utf-8?B?TGYvMTd4QTJ3MmRMUjVqRXhJbW0zLzE4OVhqdVEzZm5YZXE5dngrQXJpL0pl?=
 =?utf-8?B?Z0E4VnB1SjR0QXhFbVV3NytJcTNzTUcwY24vc212UzMvK1R6RVlETlFJdUxB?=
 =?utf-8?B?L25wTUxZMWo2UWtWWHlxTXpwYzAvaGdlUE5IWkFkeENUcVI3bytjcHNoazNy?=
 =?utf-8?B?SkllQVkxMGtZVmpTNlI4dk0yV0E2OVkzcU5BUUtqYy9lOTBYYWN6cFVDVHF5?=
 =?utf-8?B?a1ZyRkRuODZ5SUIrdWlqN0JHcnVwNFIzQmRQWEkwRGdxcWR4cFVtRlQyTTc1?=
 =?utf-8?B?WVZDb296NXZPUXFwZlpOeXYyYmNmLy92WWxDRXp3VUloTXZMSE9hcnl3WWVS?=
 =?utf-8?B?QnVDMW1DbzkyUUpOV29VbE4zODdrelc4TDA0MWFmVmc4WmpJOUl3V1VRc3VM?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d939868-a54f-49d6-a513-08daabf2be0c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 01:40:28.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3Ns2r0hRvKxIO1FJgY6COo5Jo0Y4/AGg3rF0qlwaPrutVfpLyQJb9Il2Myxiga5IuPGjOfSXK5QKFrrbPDyxqqsKnkhxm6p1uSatrbHmQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6951
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 12:01 PM, Xin Li wrote:
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index ef4775c6db01..459fb0c21dd4 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -308,6 +308,7 @@
>   /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>   #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
>   #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
> +#define X86_FEATURE_LKGS		(12*32+ 18) /* Load "kernel" (userspace) gs */

The spec says [1]:
     "Execution of LKGS causes an invalid-opcode exception (#UD) if CPL >
      0."

Perhaps userspace has no interest in this. Then, we can add "" not to 
show "lkgs" in /proc/cpuinfo:
     +#define X86_FEATURE_LKGS		(12*32+ 18) /* "" Load "kernel" 
(userspace) gs */

Thanks,
Chang

[1] https://cdrdv2.intel.com/v1/dl/getContent/678938
