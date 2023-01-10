Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134BA664DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjAJVFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjAJVFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:05:41 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E875D6AA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673384740; x=1704920740;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=HfhhS7iaZ6cSfc1lAD7zIq1D9uw2+V1oV4VaKE2VsKQ=;
  b=bEj/LzkL89NyQK26rT01o6/VTFrYiJ+JeMc8PgIm0kS/GNUvXD65QGDz
   64L6A19Ed9EiS3jk0nw1FAPNsnP7vEMIqMPqR/aXqtwp4av+7u+zVimgq
   0qsrJUMDrE92cG09LqHRh/xbwLOo2wmTjODglbxADFh5KWjF9XU4jfHBc
   IzWKj0RzyzK17Lm9NzZVkUaBG+LfHFNpOLZIiSde9WYlQc26N8ld+iu8N
   PrVf6+gbvP6mq1+0Kj6qdfZRFXcO92h5khxBncLtzMXul9Q1eqcfQDtH1
   E3/hWjRZvc6vn9jRWK51T3wh3nuzrjBOTda9JZY4jW0Hrt4OyYySsV6vS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303629260"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303629260"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 13:05:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="781179132"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="781179132"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2023 13:05:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 13:05:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 13:05:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 13:05:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiKwyPVvDt5vF8EM7xDpMUwXeL9kXO9a2KBGlm5YfJjreDIuLKQB+k92W6tuAH0z2SPS2F07boQ58HTXi3s0a0plnhZtgr7abK73wKLnCXiEAWyqPB8l2RZCAKVVIH0AHmv8Ix60fzw7DL66sLU+LQX9R97anjYsDNwfWMedyugB+xAKSxAxJwwInyUTvKeayOxigG0vy7pf6bGj8az31reNJdXoK3rbME84i0gdaSRIuxkhSu+a9oJF7AqZOfMd5sACGdwOd2QzG+E8EHIRZgkGscWTkDKXZRJud4PELZZChhSPJAussar4Z9z0VjHuwk349VSIav/wTynuNyBszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl0T59VGAiDTy0Jzc683NXJIu56m/Q45Sr6dhZFM2mU=;
 b=izVV8GUqPjevf/rlMbdorNdlppbNsY96HHGYEUasnK2NfaSFE3yQajvS3swATnVyZpSUbD3Rz/lVbz8ti3B+SwhjYzfDbaiBae2RnEICkVHoFqz0DxILn20jAgMkNb2lRHUeWc3atRmL3abhTNdFF+A7SjEuiIGQopnuRQydI13xg/IyaQFMnZQX2oxykjpwlHAsKGNYeTid93P4Wq5dRHSBSJuO/O/Gw9Gaw9uUKf695UoIGAU1HjLKR9Dj2Y7dL2BkUivnwQuT0kgEmZ8sf6a+lfHGvnHAz/PNasDyicNf6I6pErYY/dRVDwAEz1o6m9JbDZuPScv562EmRPvFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH0PR11MB5644.namprd11.prod.outlook.com (2603:10b6:510:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 21:05:34 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 21:05:34 +0000
Message-ID: <130a0ad6-31fd-dfe4-7b9a-cabb2e726349@intel.com>
Date:   Tue, 10 Jan 2023 13:05:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/7] x86: Add CONFIG option X86_LASS
Content-Language: en-US
To:     Yian Chen <yian.chen@intel.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-3-yian.chen@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230110055204.3227669-3-yian.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::22) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH0PR11MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 074d54ac-bcfb-43fb-c289-08daf34e6a7c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fo8+b6+S/UEGBjuycemnvgaomWqRi7xcGAVz8NCBDo53ST88KeR3k7bqw77c9RKs9O97sL5Jj0pOnU31EjlyNzRjwVGUHNFgktlKbybHdqRLD3ErLW18PDcSfJ8aPeadmqtza6WEPALLGi5JU1jiaogRRjhZOAR+Ul+AjZ0KoFC8VnvvQ2Afl8MUq2I3cFuLOOAMC8/Gjwp3j2xEnOR1NmW39Ak0eJ4F1881MKZX3LyLZ129iCBYezXzRSCWeh84f8297XqzXiU3YxaOX+Q6nQa3BmQ0wHSPlmMJtm7fbn96K7THVRhw1nxDA5izBkTCNOTH+A5hiOCBr2ncWWlcxCEWu9LbCu5kyTfyFFcW9PG0jAggx5wxcyHGlK1AZ3owhn8fVk6O/OkwQxnSNAY7KWu91KyreRPxKkofuc3QcF8CE86hQKvWXMoe27oZScLFLTpqPrdwVtjw7kMWRL2rhZsVQypXB4e81qfZUhw3YlppS9CV7QhLDBISCxBUweRmD1ZtpX+ALAXhZm9efA0tCgN3Dcc+P14nb1JV7l7Lh7u6zVQA2N2md112DeCoEva2YDTV1VPQ2QYLzSUTJgBZyTl35ZmL7h68MOJW7O7H4uXc0hukPCRPJphxh24f5LpgJBFinhKXyPy0oonYioL2zVltb4N9gArsn5y9usq6dJytMBdT/FO1Eh284vkv1hJ14q7SWPyQR0f3fAMQaUvgAcMiOxjgNkCvvK+Ept9znRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6506007)(38100700002)(82960400001)(31686004)(53546011)(2906002)(478600001)(6486002)(2616005)(26005)(186003)(6512007)(44832011)(5660300002)(316002)(83380400001)(8936002)(36756003)(86362001)(41300700001)(31696002)(8676002)(110136005)(6636002)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVRvVHM3L2NhNnl1Y1FQaW1NQkR6NTVaaXVuRDliUjQzOUZxQWRJbVhhK3l1?=
 =?utf-8?B?aExlVEd4ZTBPSDF6Y2VvcHlUYnlJbDhvVkxzN29ZWUZsT0FoTTZpMUpNeWZC?=
 =?utf-8?B?RkFzZW80clJ4VlB4RHpYL0p2ZjhDM0pWTlg1MGdFeURkZ1ptbDIrbVptRGVU?=
 =?utf-8?B?bk9mTjdRQ1pOUG9SbERSeis2VWNsdEdLYW1iVHdhRTdIZjBIUU53WHVsNEhY?=
 =?utf-8?B?dWZZT0EveVd3MW94RE1qYlROcDVEeXhEOGhFYmJGOGN5aTJLb2RxTDZpSmpH?=
 =?utf-8?B?a2xOREc3THRMUGdwdGN1aDl4a2RQRGY0V3JoWlp0K3NGd25HMmxxWG1jaTN6?=
 =?utf-8?B?UE1PbEw2c3d6UkRLdytoNXZmNGh3NGRIYnZOby96MnhVdTU5blUvWnBPVmU0?=
 =?utf-8?B?NElTVVYxSnNEcndONDlNRHBnYmxNdkVaRGV6WWFqN3p2b29uNVNvVnRFRWxH?=
 =?utf-8?B?S3V6RkRZQ2dCeWpXLzFuWDlGM1BYNWRDeGtLTUtqWjdjTHp3R2VTODhQT3E2?=
 =?utf-8?B?eXk4SUh2cEtZY016ZnIwRERRN1QrQjdHeElEVTBBbDJoczkxdTgraEJmVHVR?=
 =?utf-8?B?Vkc4Y3RqeUV6STA2RGwwLzFVbFZNd20rN1hJZGlIOGZLR2JscEVNdGIrYklK?=
 =?utf-8?B?RlRsY3BqNHhwbVRxQStvNEl4R20xSHdKSEc3VmF2MXdsTWI2Qjl5aWVVVDl5?=
 =?utf-8?B?UHZNSmlVUGJtMHNqUFZoTmRjZXloUWl2cW5PTjgvRU5GUW0xL05SWnp5RTJy?=
 =?utf-8?B?TUswWG8xcHFBWU5LcG1xTmVBQmM0eUQxMHVacjZ4UlFlSGx1N3FVbnJ4Znh5?=
 =?utf-8?B?bVlqTXozT2YzZldHTEZPN2ZJOXNjU25vSW1QNnU4bWsvUW1GdUs1SGlLNnRK?=
 =?utf-8?B?VkYrU0xFSU9iNjRoVmQwQm9Ia25TMWFzVjFZWFExNkVLL1lZTlpqQW9pditT?=
 =?utf-8?B?WExKS2o1Qmc4c0FzWjUyN0U4eGJYYVl3YkJlU2pmYzFmbmJWOGNKM3ZoL1Zh?=
 =?utf-8?B?S2ZMNFlLUjJJV3RsSnhWV2pYaWY4ckZMQlN4YWlCM1VvcDRlLzc3WW9JeEVF?=
 =?utf-8?B?S2o5VUJKVGk2alJwZU14SVdhbjhxOUtaUFRJcndHQ3BqUXVEL2lvR0RIYzEx?=
 =?utf-8?B?WmhRK2wzNmVybm1neERpM0dzYlVBNHlUMm9nL3lqRHN6bGU0YUtjRGdWYWpp?=
 =?utf-8?B?RXRUbmgySXdRdjlPb0ltempzdXpTSFdJUXh5UmJLbFVIU1o1Q0E4UWd6ZWlx?=
 =?utf-8?B?WHJNVXphK2ZodEFqc2NPc1JybTVyRFlCbm5vWUQ0WmZDaDRkUE9KczZRWlNT?=
 =?utf-8?B?NXJieWwzaURxZHQzaDl0clo5VlpFOHdVWk1KYzhPV0l3OTZsRFVyVEtabVc1?=
 =?utf-8?B?ckdCOWVjcUt2QnJRZGRtNUYrczEwU2dVUnVqZnNsU28wMTNWWC8yNkpPblVn?=
 =?utf-8?B?RG52dUtQSC9CSTNOcnFJbG5ITlF3d29lNE42U21IR3g1QVJBdm16R0c5MUdr?=
 =?utf-8?B?RFEzb2pONFozc0I2a2lwNEZCWUdQaThVQW9jNkFxRTJUM2JRcWpxc29TanRR?=
 =?utf-8?B?MEp0ZlBLeFVvbTBieXpwWVQ3akZBb0x6dERid3M3V0s5TkdOWFpaUEVsUTQ4?=
 =?utf-8?B?di9KRlM2K1VkNXFBd1k5TE4vNDgvbEQwamlvKzNTOHRiV3oyMTNISDlYd3py?=
 =?utf-8?B?bUNyVTFEeEFwc0l6QWwwWmtTdnRxck1ZdXp3NDlmaFVKdTB1Q1NiN01SYnlG?=
 =?utf-8?B?ZUJDMWxSWTJyQ1NDNGhqTHFtaW1pdUNCRllJeHphNmFvbDVmZzd4WmswZURZ?=
 =?utf-8?B?cVVnWDI0dnkrTlhJcjd3TmVYcXFLWm4wMHZqWjNoenM1QUM2cHlNQXZHVmxE?=
 =?utf-8?B?Q3EyeldJZUtheFJiU0F6R0tLSlNvY01lYXEvcmhvSWRyYVVwVWsxL255Tjd3?=
 =?utf-8?B?bjR3WWhqT1ArWXJWMzFFS0RNZlhUTTZ4Ykt3Q1BjVSttV3ZGVlNoNlA2WXZP?=
 =?utf-8?B?dkRDMWxsWUY2WmZnN2h3TzkxSlpBVWpDcUcvQUN6ZmpxYzZqcGUxaWU4ditY?=
 =?utf-8?B?Qk9abG1pUFo5NUlCUWVaVzY5cFBvcjMyUWVWWXVrRDZaR2hFSm1vai9yTHRr?=
 =?utf-8?Q?EmGsm1kCQTZs+sBSzI7dUBBuL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 074d54ac-bcfb-43fb-c289-08daf34e6a7c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 21:05:34.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7GcTlLEkgDw9FeUhrhSxWneHlzFz0XncjVPZVi5W45jVMTIuqpLLAiD8AULckZfs5vtiSd6rVb+2teYK0Pbsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5644
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

The subject can be better stated as:

x86/Kconfig: Add config option for LASS

On 1/9/2023 9:51 PM, Yian Chen wrote:
> LASS is an Intel x86-64 only feature. 

> Add CONFIG
> option X86_LASS and flag DISABLE_LASS to choose
> opt-in/out the feature from kernel binary.
> The second sentence is unnecessary.

> CONFIG_X86_LASS is enabled by default because it
> is a security feature which should have little
> to no overhead or side effects. 

Doesn't it have a side effect that it modifies default vsyscall behavior?

I am guessing the impact of the vsyscall change would be minimal. 
However, should LASS be disabled by default at least initially to 
minimize the impact on userspace?

A follow-up patch can then enable this by default once the overall 
impact is clearly known.

> If any issues are
> found with specific use cases, the CONFIG option
> makes it easy to disable.
>This sentence is unnecessary.

>   
> +config X86_LASS
> +	def_bool y
> +	prompt "Linear Address Space Separation"
> +	depends on X86_64 && CPU_SUP_INTEL
> +	help
> +	  Linear Address Space Separation (LASS) is a processor
> +	  feature that mitigates address space layout probes.
> +

Let's try to be consistent about what LASS is expected to do. This 
definition is very different from the one in patch 1/7.

Also, we should include some information here on how enabling the LASS 
config option can impact vsyscall behavior.

> +	  if unsure, say Y.
> +

