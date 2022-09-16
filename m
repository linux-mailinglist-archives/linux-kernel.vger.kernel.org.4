Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4855BB08D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIPPxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiIPPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:53:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F37AF49A;
        Fri, 16 Sep 2022 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663343607; x=1694879607;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W2KBFRkhJyRBbWPJTO37r6NEqlEsuT6ac1XxvQqjfFo=;
  b=Yvb3OqThOMwvigYPJFP+qta8C6yKxQm25P1oR5dhLkN9RB8MX+mqgC5y
   trMTom31ls4dRSRXvkLdsa3pOTM3r9NvSenqKv//9vDDsCuLLISQ9JKRr
   VTbwPe1nTdB1G/AGfwkzuIGzMvdyrtKczztygGkouM7zy/niN4L0qevUO
   UyPiS6Yd1qQKu+xw8LVYAi2IUPSclkWE693gVjsyqyBD8nlxbW2BgfG5z
   NkFb08+DU0Ss1n2RMoYs6FmcXgW2wSYyVsPIPkKZrq/BYp1Y/wyfK/q5D
   i3sA9TnlY//F0PCDRX2X389QtE+r6iCqP94Kgv3FvcMTRY2w0+6gGgEuE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="360758976"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="360758976"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:53:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="743380624"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2022 08:53:20 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:53:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 08:53:20 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 08:53:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgaufobURxOLLenhOiMSeT7FB38IGeQ3xx+QJ+UuUKVqV2PHvIcu2nZRnYAnbmn58r1IQ2Xfx925Bz//04oPA0HPc+GGrFiTiwUR7INLmkbpVNw/EFxnKLFTSKIosdkeOZzxX0qSonBSy6cbBhYVa7pTEglcbI60y2DgvAZXnVLrhWn2jj2wAgpoSZoNg+VMkZO59rGpnQoKfREsG+fKCeF/rw09jtYN7H3DRxsGS3kQDU/BOinZuEXKsAk3jL5bGNvIzB/xUQTVLhAwXTOLw4ODwv6zM4GRyX+ptufvyEzLsMeF1p2UCyrDuOyTTLjwgrq/HXKv7Ti8zXgvLf0gAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASJmGWX5yV4ap0h3FkCsPXZdkNlkXVGxUnfjpXDl8mI=;
 b=gHwmzPwkHh/644VVGOQIR3l5xcqxon+7TwTa+5aNW8f6Gtofcy+WIJfHo7xzEha48FKOXkh4bMsCAaJQz6dU6EvHBxc+0er4C7zToiwIQsCYb+9uekTCt3QpdW4k+/72MQifjkkoBz10UCXnnXoOydq0v9d83/jiV7mfGgiFUb7QlNGqHFuWu138JPrs3wkDp0iHMdF28D5HtJKKNeqygSaf5DDJaZVJkO1miYn6YRRmvxFnZqRV0nPvNeFVueYqdNcMN3y9kPjHdwawJNCugf8JoWrVb6w4qNbMgxX+9MVwNtVaymxMLmX8TxiwfBcLn5lf8a+cjS++WLKzHQ44Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4656.namprd11.prod.outlook.com (2603:10b6:806:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 15:53:12 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 15:53:12 +0000
Message-ID: <7c88b2e8-2cc9-404e-7167-6743d796b0cf@intel.com>
Date:   Fri, 16 Sep 2022 08:53:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 01/13] x86/resctrl: Fix min_cbm_bits for AMD
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
        <eranian@google.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257359679.1043018.9253512972611409799.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166257359679.1043018.9253512972611409799.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4656:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1a96b4-5d0a-4424-621e-08da97fb8f1c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPLkm6lt+HP0DPo6d/awix3jkwZZBevyg4RP6e2CcejVJO8ICKVtZmfrAm3ffG0ziMMLLUH0zK2Cy88qFipcxTIVJ+9DUx6DRE4PtLf5gXrTskgTfszqIBwHkQ07xEgujuaSIW/ogZFjC0gEfFHThIggB+3N9kgLF/x3xZ6tXKG7xpdxr6zoV/qZBwON8Gr4AbklVm9Vrrpgo6RXZMxsYMM9LqRJC7TPJl5PkXxjsAC/DXrHK+W0KxJ1y4ZyvEqEw39hgZE/k8PTppuqJ3PQDcI+CF83p3dagPvG8SBEaav2Mo66DP8+Viw9D6uJ6Xsf7UUuVxX+WCtDbWbSaaa+mojyRf2hpFgzqh7KqlQeqfmp/4tg9MR+drwL+8bvR2bLwFZW6ZFCvC+ZGVTVVk2/VcoVBZH9gI/Ssfz2m3kir5So57UbttdV/hCXeYffr24eI1i1pxbWKD+vUl6taF8TeAwM43LdcFuiB7Rx2UsKdjK78gvSyLs8/vvaUVAP3IDrWh/QAHQehJVxjmqWghKg4S1+Fvea111T7UrEecCSH26t0FW1XzA1wqbq//ng4UQGHBQcdvlWbxIcXD0GK8HQq+EBQLytjkkeLihWW0ur3H8RY5o5Bmx82rhVFm4pNIvrAHBFhHuKEIPGJ1TAAfUB/ya+2w8LRmStat2T024gWQ/vqx97V6KNHFolNUiSjRYmJEimk8euImsovD35WplTf7d7RDL77+FGo72fM6FQ0BiBRV/VSAa86vNRVDtbYDcfDLZif4vcAJX5ycFdAtJGE5IH42p+5NMHgd16/C+CFliuNmFzbMnBZ4KyoVR0SAvFpGi7/aYcANelc9eVh56DXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(31686004)(2906002)(44832011)(36756003)(82960400001)(38100700002)(7416002)(8676002)(5660300002)(8936002)(316002)(66476007)(4326008)(66946007)(31696002)(86362001)(186003)(26005)(478600001)(2616005)(66556008)(6512007)(83380400001)(6666004)(966005)(6486002)(6506007)(41300700001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDF1K3UrNzFTN1p4WHZkelU0REY0K3lDUG92R1lwWFpVM1RpOHZjL3BoZFFs?=
 =?utf-8?B?RkZvNUZQU1E4MFRpVzZzNFNUMlFHUUlITXNnUGV0dnlDWWVhZXJxWFdQbitR?=
 =?utf-8?B?Nnd6S2dnYXhoclFPVXlyZ2xvV3Z3YlQxRnc3clBJM0xORmtMZjNoSTV3Sko2?=
 =?utf-8?B?OVNpQm11cjVzcjYwZkY4N3N5Wm1Ib2hFYlRhaW9OWFNkRUdscVJRZ0Y2RHRW?=
 =?utf-8?B?V0NiaGJkWXVFZ1RHeUVtOUVSeGQ3MGNUQkkxUGtGRUQ0dzhvNjVZUmVZOWFX?=
 =?utf-8?B?Sjh4a1JlMjdSUk4xMFhjclUzc1QreGYvbGJaMmFmUFFBZk1yVmNNM3lWUzBW?=
 =?utf-8?B?a2hBOWFWVGI2VTYyd0NGUlhzamVMZ1VGL3gzU2syc1RZRC9tWWNGZmpYTHI1?=
 =?utf-8?B?ZHppaHUzVnJ4M3VJRFBLdGJlOUNYVUxlbzhGZzBnaFg5ZUN0VWJKMDdLN1ZM?=
 =?utf-8?B?b0Evd0R5b04rUG5jQi93bStROURBZUs0UkxRN2llaHUxbjFScW54SWowYW5a?=
 =?utf-8?B?akU1NGhrRitqNnArVFhDUnJ0b1ZmNHo1ZHMzOWlCY2tieUN4bm9kckx4b2RY?=
 =?utf-8?B?YWNvVWtzMm83cGE3SFc0THhwZ25OVm9IZUpOVWxIc1dQMWhxOFh6bmpDbU9X?=
 =?utf-8?B?WENHazc2c1U3K2p3RVN1R1I0Nm05OXo1Q1VVQXUvbHJzL1hIdmVuR3h5ckpi?=
 =?utf-8?B?emwwT2FVU1FHek9WbEVzdjhaZkZpRXhqTWpxNXMyRDZWSlh1MEYyTGUrM2hJ?=
 =?utf-8?B?eW9zOGhKZlh3Y1dhRFJ0TmxSSVB1UGhZak1zdmRFNS9BZzFWRlY3dE1JdkVQ?=
 =?utf-8?B?VFhyUTBSS0pCUjBZOWRoKzY0aUdlSEdRZ2ZwcE1CampIc29KWWJpQk1YbjUx?=
 =?utf-8?B?UW00VElQV0lPL2tYajVPbmIwTnBvZW41TU1kOFJGU2VwcURHR2QxQ1I0YVN6?=
 =?utf-8?B?WDBzc2hoVWxNQ01rRVhDdTBHcjFJQ2tQOEhNOGt6eDFMSVBSSUJIUlFlbjh1?=
 =?utf-8?B?VUZCZ2tUT3hPYXg0WllwV0tLd2V6eFZTcjBGUFRMcFlvWkE4ZU5rd1ZqcldO?=
 =?utf-8?B?N3FpbzZyM3QxV0FJeFV3Sy9Sek9ReXhhQ3hFaVZZWWlWV0x3RkZzZHZIWlR4?=
 =?utf-8?B?NG54N1hHZHQ4VmhScGdFWEZPUUdneFMxNEtjK2JqUUdNOE56NGR2RHBHRElv?=
 =?utf-8?B?VzBUTWhTcGpFRnFodFBKdFhZUWRJWXNHME84NTFsS3ErT3B3ZjlBTWR5U0s2?=
 =?utf-8?B?d1dxd3pmYzVGa3pKcmp6cjVrODlyeFB2NCsxQkZjakwzQXQrRDdiL25HSlph?=
 =?utf-8?B?WU0xRk8zUDR5ZmwyZ0hOanVTalhmNm1VczlJcXRTd25ybzF1YndOai9tVTc5?=
 =?utf-8?B?NmhvU09ybis3R3RoQ3ZHWnU2cjRWTWtnSXZkSWV3YmQwdFpkeXp3MUJRV0FG?=
 =?utf-8?B?WVpPUzFCVGVUUERWZ3NNVnRxQ3puOTZ0YUNWSmFtb3lkbkFaSmRNQ1hLMzU0?=
 =?utf-8?B?NGVTenZOem92c05iRjcxZEVvellscWVjeUdKSU1nazkvTzgzaGtjOG1kZUd3?=
 =?utf-8?B?UmgwSFBIY2pETlorRGZHRkx3eFJTQ1JzOEIwNk45OFB1UjIrTWRHZ3ZOdy9u?=
 =?utf-8?B?LzJWTVlFMEt5UTJlVUx0akdhRTdmS005K2VKd0VnMExhODBFLzZsMVFVQVdi?=
 =?utf-8?B?R3UwWEpuSHd1TWFNVnd1QlVzV1A4REZMQ3BBZzlaT3A2M2U1SXNYaUtpaFl6?=
 =?utf-8?B?REM4TG42bjQ5NEdyQ0V4aE9LQ1JpMExlSzRRSEZUbEwxN3pkM0ZOMTlqeUt4?=
 =?utf-8?B?ZE9ib0orQzF3bjhYNFY2ZHYreVZGeHQxM3d3OEdlb1Nra3o4NC9yK1NMRGs0?=
 =?utf-8?B?LzczbHhCZGNoeGxMQlc2UDlGNmJ4Z3E2c0xiVmFNZW11Wm9ISWhMVlIwWm5Z?=
 =?utf-8?B?OHNCamhxS2VyVjNxTC9XYTJwK2xrYUJIZEY1Q0V4NU1MeFcwbFRxM2R0OWFS?=
 =?utf-8?B?ZllOclAxaWlYbGE1VjVkNytZS2dNc04vRVhmYVNvYTl4dnZ0MU5XbmhwU04r?=
 =?utf-8?B?cW1UY0R2T2J6RHJHSFVjci8wOXRIc0xVYVR2SXIwV2ZxZ0EvMUlONWVxdlBN?=
 =?utf-8?B?NDRsQ091WE01cHExN1hhR1E2ZnE1Y3BHVXBnK2JZeE1vWi9Ld3lkaHc1WGd1?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1a96b4-5d0a-4424-621e-08da97fb8f1c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:53:12.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oCBWhuU9xWKhlFJJLdO3v52dr03phelEGNTeC4qahtzfcEc+/J5vBhnX+h9fDKaEiQaqqoqVya/jYdFxq9ZMnVff5cFDq8pp/q9arukcc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4656
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/7/2022 10:59 AM, Babu Moger wrote:
> AMD systems support zero CBM (capacity bit mask) for L3 allocation.

Above mentions "for L3 allocation", but the change impacts
L3 as well as L2 allocation. Perhaps just
"cache allocation"?

> That is reflected in rdt_init_res_defs_amd() by:
> 
> 	r->cache.arch_has_empty_bitmaps = true;
> 
> However given the unified code in cbm_validate(), checking for:
> 	val == 0 && !arch_has_empty_bitmaps
> 
> is not enough because of another check in cbm_validate():
> 
> 	if ((zero_bit - first_bit) < r->cache.min_cbm_bits)
> 
> The default value of r->cache.min_cbm_bits = 1.
> 
> Leading to:
> 
> 	$ cd /sys/fs/resctrl
> 	$ mkdir foo
> 	$ cd foo
> 	$ echo L3:0=0 > schemata
>           -bash: echo: write error: Invalid argument
> 	$ cat /sys/fs/resctrl/info/last_cmd_status
> 	  Need at least 1 bits in the mask
> 
> Fix the issue by initializing the min_cbm_bits to 0 for AMD. Also,
> remove the default setting of min_cbm_bits and initialize it separately.
> 
> After the fix
> 	$ cd /sys/fs/resctrl
> 	$ mkdir foo
> 	$ cd foo
> 	$ echo L3:0=0 > schemata
> 	$ cat /sys/fs/resctrl/info/last_cmd_status
> 	  ok
> 
> Link: https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.com/
> Fixes: 316e7f901f5a ("x86/resctrl: Add struct rdt_cache::arch_has_{sparse, empty}_bitmaps")
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

(apart from the changelog nitpick)

Thank you for clarifying the way forward for this fix.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


