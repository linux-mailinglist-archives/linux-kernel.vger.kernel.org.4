Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E59267A12A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjAXSas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjAXSaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:30:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE26E3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674585045; x=1706121045;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fHMLqRpklBpYhwIR6Q0VWZIJNu9l2ShB6Bi+l/190nk=;
  b=IQNmUujWQNss2kWR1BHhZpQvHLoATSJXmUmN9oScQn/forigrsFcuAiX
   K7jK3pObsyZLZJA28fR4BQk3pgIbgO7d/GKYFgrii8MrJz7XGH//TOPlE
   PXVZE6Pwbj98+YQxEFIfR9sOv9l1tPO7JAWVW3zMRSME0ql5UZbRrWJ9H
   Z8ceg4Bs55it8x+Kz6qwseuEimAiwVlCZlA6bdqzYsTKLjcY3l4zxsc0T
   vBbyrYZMuQHfuCzsfQEkwez775QbgqbWF6dMRiAO8W9JlGrnx89NF+UCy
   3gamBtjSrE4HljfC89OKmC+XbbAiv4C4SJzYrRPAWnncUjT9GnC6xhibG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="390874577"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="390874577"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 10:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="639669926"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="639669926"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 24 Jan 2023 10:30:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 10:30:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 10:30:44 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 10:30:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVkUgHqk1ZNcSzNFwZoy4G3bePhO6MDh45vTZBuZvCCgSXnXfv9U9wRhP/aRMLyq1iJRNw3XVTc/wuZ9lpqZ2qBFnUjXfotGlwCTMjVtToQRNWNZ7U2hf9g4Ah28W7DV+sKf0Ei4nta6EwBKxYwJehAxSl7zFLsl1Wec5+gOTXXeVfQj7VKxFH7YQXpwxfzBwmnvHTjEI60GgsF6LoWe9LGciP97MN27WLdLskdwOoTr41/Oh6Gc/oH1Wlvjk71D3bNmEt4zHBpernwzAjeExQp736JdFG8XmFT2A0zRNsBp6M/wQWNFOcP10RmDjURId7iNhvUyLygmWBAFlXHXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1pOfLRS6HGDR7aYqQbMO+miw7uPeY0MQUpi9Ksixj0=;
 b=TEeHI+UX+hIBRFgOZB/SqDzoKaetakWCUDivEhyLdcy/WYJmJpU1/Zdgf45b/3xpL4KzbelCYeRGZBX75jKzPLvTuMpZ+izUHuDPVvVoNVsKbD/av96DZrXiO9rIHeIeUTOUpBIsLZ+qwgJVQAXZKq6O1eKbvJvXYOPJaismUcfr0p0Or0ZQE7DSpBndHDfHlu484Aehf1RgvfPQIQSCEKzBkYVrIZ6SeElA52NENMPCs/B446MO9RSWwy48mb/t28IImszPyu5MmHAs5jkNXbbai7ZmN3fJlzjNmUNjCBBFmUiTIRifp+HibEAdU4JQ9gnlyyjFDrI7J3xNNjhQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 18:30:41 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 18:30:41 +0000
Message-ID: <471c5631-f5b7-84aa-14a9-d587108c7cdd@intel.com>
Date:   Tue, 24 Jan 2023 10:30:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] x86/resctrl: Fix a silly -Wunused-but-set-variable
 warning
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Babu Moger <babu.moger@amd.com>
CC:     kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
References: <202301242015.kbzkVteJ-lkp@intel.com> <Y8/XoT23HVXHSY73@zn.tnic>
 <Y9AftBkWXcFflHbm@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Y9AftBkWXcFflHbm@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::38) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SN7PR11MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 529d2e3a-33a8-4246-13e1-08dafe39190e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5Tn6psvXbBPFZ6KldgG9eCDi82kmxAo0NEC5lSlp3kuLVAZ+Idr1Dg1GwAY0zI8MVgGmTMRl7a+9A+74vVsU2ZMNam/Yk57eijCRHlv7P4Ti61HP/NuZP6MswGDNSB5O6Lp0YL516noc0KT0mTpoT7O5/vuuTr+zlUcPYTSlvxTfGWGr3p/xLi5WfID5nsdEKYhaixheZGy1z4yoIVP3stc5z3VZABDh1T8f3s5/1qZHr4OL0IeQdfHT5sGeroGjVPVaxqh2hJkLSgR/t6rnPtgOdjblqYOIhcCSicWIrf9g8lqh+X4RWRTyim361rPa3JoH73QKq8jVXU2+Uq9nBAjx5ZsM7bIrn5hqyHjY+BCucckkxNMNc7uvseRYZp7yqB5XoB/bY2Hi1UNz0eSfbsXu+AF5wVne+ViZQxUQeMqsL30G6NrYl4ykNENUDKlTVzrzT6PGC0pfidlkI8Ktz0qbqklsUNhHFw2yMwnQCTDHOlv7g3X4kM1mlk1+PUGCeRIEdHSLGAT/kREC3fh1HPn/q9+17b0e3J2koIu55CqseBIgAvt7hi3GJN9VRLUQ6sEonEg2Okal/fdYgW66KbO2RL3m1rsUxRWz9SCt7t+bgyQ/zgZB9eFGKMkcnQNrsJM0Id2sS3W9YHAO9IYm0KOyL/LYX06EKHvho8EZyJ+9X41BJ2srVS5av4/4uN9hqued45uOInyka7f1UZpkpYTn7RyDOj/Qn8cp9srQSUGH5K+sZicCYosDzK5uW/HL/ceg8H3WxtGQ/sQb2bKbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230024)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199017)(86362001)(38100700002)(316002)(53546011)(44832011)(2906002)(4744005)(31686004)(83380400001)(82960400001)(966005)(6486002)(31696002)(36756003)(478600001)(66946007)(66476007)(4326008)(66556008)(8676002)(41300700001)(110136005)(2616005)(26005)(6512007)(6506007)(186003)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlY3MDgyZkRpc3lCNnJOcTBNa1A5L0lrak9oUHBhRzlzRVQxZHVOOXJraGho?=
 =?utf-8?B?MVFORUhZMTQvSnQ2bGNRMWRlejdZT1lNb21uMkQrYTVrSU5NY3RsS01vUUgr?=
 =?utf-8?B?NEl3ZDdwcS9BY0RIbFppN2lValBHTldFbjhDdDdHRE1kRVE4SU9yYXRBcjdm?=
 =?utf-8?B?NXNUaXhIMUMrRnpBZnhFaUp4QXdBeEF3VGhpY1R2TFowNURDNFpXTVNHQTJI?=
 =?utf-8?B?RlE3bnp0b1BTK1NxR2Nta2ZGZkpEdFp1ajIvM3U4UVBSd0tHcm5NMGY5YUhp?=
 =?utf-8?B?TFlpa0Jma1orMlNlNXBlTGxtTHJxSFYxU1NRUElrY2VPYmdONkdDSGlCSm5O?=
 =?utf-8?B?eFlYcGlzaTAwanRKbXlvVmFVUlFpaEhIblhsTG9VOTNWVmJSK0hBR1YyaWdW?=
 =?utf-8?B?NUxMNTVvQmhpSHJPV3RXNUd5cTBuVFhmZXpQM1ZQd2VzaHBrekFMbWM0WWpm?=
 =?utf-8?B?WWtrQWhhZkcrYVorZ3JSOUlsQVlud3V4ckJwckc5eFlla3JFZks3amZlYTJ1?=
 =?utf-8?B?QWdydkJJSHI4UU9LNXhHazRYWEE5R2xwR0doSHplbHIyTzBoWXRLMkZSL2sr?=
 =?utf-8?B?SHdGYTh3UmZRN3grWlE4Q1BJU2phNUN0Rk85RWtsb0dzMkw0TnAxRVRoRWZK?=
 =?utf-8?B?TUlER0MzaVVqbnlhTHVzTVpVUlZnVXRmYmZzTldzTE92QnZUM0I0b1F6VlE2?=
 =?utf-8?B?TWNxd0MrVW1uM1RKMzBWaFd6SHgzZlJUcXExWjhVdXlPakYzL05XK2ZIZk0y?=
 =?utf-8?B?SzEyUk00MlJmQXBaa2E0d0kwL2M5MXNwTk5vMUl2Q3d5TXJ3VjN4VitydUJZ?=
 =?utf-8?B?NXRrWlFqWHV1aXNoWjFZN2w3SkkxTitndlEwTjFSOFpWazRqaWx2TTdJOGpW?=
 =?utf-8?B?TFR4MmliYVVTSUhXZDR0MDkvbVlQQ0hDdnlkRlFEL3ZFQm9jMEIzaWZOaEM3?=
 =?utf-8?B?OUZrZlltb1lpaWxTNkFpL2VPeFdWOWlHUjc4Wjc4RVN1dVJGN0VrQ0kwMVpZ?=
 =?utf-8?B?eVRPOGRoUzhBWGJtVGdUeVNxTjNRdnFyY0JJRzI0RG9RRzF6R25kVTE0aDZz?=
 =?utf-8?B?VVgvNXBjQjJXV09JaWEyUURDRktWMzV6RktEaUtoZmFPSGZxL1dxZUVXY0gx?=
 =?utf-8?B?b1Q5Ull3aXFXMStrQ2RsSnhCeDJralkvOXVXcHUxTzhGS054MzliRXRGMHJT?=
 =?utf-8?B?NDRVUnkvcnJLaDh0Tk0yY3dsNlppa2dIbmdPeE1uckxyL2ZnczVKSXN3TS9h?=
 =?utf-8?B?cW9qOVJwMTFIRjUxN2lLQUJwUmxZeEIwUU9HSDdhTFp2Tk9rUVluZmF0UTFq?=
 =?utf-8?B?d0ZxbW9ocERFeXVuQUd1TWZaYlBKNHRZRHVPYWRZeUdkL3RiZlFRN0FxTHdp?=
 =?utf-8?B?enM5NEsrKzhsYVd5d1k4NENZYStMc3owYjllUWhSeC95NDJ4bGlxWGZvQ0E5?=
 =?utf-8?B?c3krekNER1k3N2NWZklSdzRaOUtuekFqdXNrcmdEdkVpWWtoY0R5YWdidk1z?=
 =?utf-8?B?bkpZMDRrakhXUjM4OW5lblJDNnRrRTUycklsMG9sMEM4Zm9laEV0NUZNVTRY?=
 =?utf-8?B?THNmYm1jZmI1enc3YU41WTM0WnIyUWJaV05GTkFpclNveE9GZ0V5bGJtdDQ2?=
 =?utf-8?B?NFJjcW0wOFNkdStFK1o4UUxPTUlobWszLzNVcGpjOWp1a0ZQcUxMM2J6WWJM?=
 =?utf-8?B?UllsWXI1S2VkT2Zrb3dyWlpsMmh5TmtlSEw1aXphV05uY2R6Q2JVU2s2SkhB?=
 =?utf-8?B?bDQ1Vms3Q1l0WWI0ZVI0WlVzd3ZQTUFoWEd1UVBMUkM3bldPbnY1WUhlVkFz?=
 =?utf-8?B?Q0JNMUVOR2NnRUFYN3V2SEgrdkNiRW9tU2g0YXNJQmxrZ3huOXUxMDFDUlFW?=
 =?utf-8?B?bWVGWkthazJwYXMvQjY4Q1kvVVBHMi9JS0JlbThsY0hwN28rWHlmVUxJald6?=
 =?utf-8?B?c2x4VWRlYUlKOG9ZdVBMcU02NmlMV0FIQ1NYOFEvdmF2WGdWcGRwUmFFT3pR?=
 =?utf-8?B?b2tuckp4RWNLTzNzaC96ZHJpbTRHQUh6d1M3YU9vM2wxMUszUGpzL0RCVlJJ?=
 =?utf-8?B?VHZwc21OZHFUdGhGV1hXT1dHS00rWC9RMHd0NXlGUG1pZXdlMEl6UVZRUDlG?=
 =?utf-8?B?MGFGaTdnVUhiVW85eHQzN2dNV21WL3JCOEZPUVhlZU01QkxkSUpETzZDakJX?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 529d2e3a-33a8-4246-13e1-08dafe39190e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 18:30:41.5321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHVs3Ovhctwb8xZ/WOVcFXNLpRMDkJlPyse32dyaikZNtl8hAHrPofMpbfI5GJnRWa/8aL1CF9H0gxVJNRL2A1nlAMfQY8D46Tej/nMcxpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6900
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

Hi Boris,

On 1/24/2023 10:13 AM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> clang correctly complains
> 
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1456:6: warning: variable \
>      'h' set but not used [-Wunused-but-set-variable]
>           u32 h;
>               ^
> 
> but it can't know whether this use is innocuous or really a problem.
> There's a reason why those warning switches are behind a W=1 and not
> enabled by default - yes, one needs to do:
> 
>   make W=1 CC=clang HOSTCC=clang arch/x86/kernel/cpu/resctrl/
> 
> with clang 14 in order to trigger it.
> 
> I would normally not take a silly fix like that but this one is simple
> and doesn't make the code uglier so...
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/202301242015.kbzkVteJ-lkp@intel.com
> ---

Thank you very much.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
