Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E32464BB68
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiLMRyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLMRyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:54:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AF22229A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670954061; x=1702490061;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6JQlfSjmGWowuQLfU+ys4EB2UGCgEdecoNERcHGzVxk=;
  b=CE0J7RpKBGUA0g+Mj3+446xB5HqfphhjgDEf4KcebC52Yo525i4sEpBE
   p0PkWtwBfqY7mpgcukU7+VXTdPQ4oYtfXFX77MQ6ZNrnD0H8ZsfF+gtK3
   hDV4itwY/zJBf4P80V5YzcF4XtZ1fX2zmYxjgS9nHI1ZzOzo1ZFnEFYNZ
   fZScUDFOH/I6aicfFamCfbXzH7o7ZViMceMSFGBXrqOtqLoBBOm2T4kcg
   UqnEurnKNCfgKinwn5rAc6YYxY9XU53gH+dGhAUac2Qz1WEIfhnuw1UvK
   d5W3IwbmEvEpWbiSIQBFMEFArkbfICT6gISH7xe/o23iPtrzvJHTV/WkJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="297876987"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="297876987"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 09:54:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="755519188"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="755519188"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2022 09:54:20 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 09:54:19 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 09:54:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 09:54:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l866ldLv1hiA31/JK+KawwjcpMZiHT+oxltuKm5Rdc5xxJJzbpVWhpCqhr9BiBldg9cK4xzCV4udkLenC4d2CQ6I9yAgzMcha5DOb1AoVA1imkMq/cWnhYzrg6MIUIqXDNAM42kP8jvE0vduAvl5awoVkgvtwtQqtm9yHXcepxPnDWyg5LmnTY7riEvZP9UaGS/VNhy8ssPxxNh64FC2t933pay6vbgCTr4D3UpGu/kyA38FAiw0lHBRVuSvZUwSbIBGPHiCT1oKQx/NwUymC42P+fi0DMEaJAOUMBf81m8iWokqQ0oVpfdC7tiOUV1qO62ciaDdnEjrJUdxpdrsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBvzZUpuPZvaI+pD2pjlgfEyI9VLpNVT/rj3Wv5Q/GI=;
 b=FdxyabvOcG1Z6BWdozv49rlyT5msd6Xe0htlUfzAlKqqy109cHwID6os6DF4dCwYdkY9Lg9cF/BBfXGkQFAcbSFHX0SBWWFv/URF6+XrVuL4YcHNfdM1P+68DE3wAs7nLTlDLFpw6YDBOebkgn+62G7JFiqNgeABUXOd1ROwVAxcTXb+slOWlv6V96WYyOkmw+oF8h3IjzRHK97dx4ep9cYM6EvnXk0TPDDwc5ogSDQWlca07862AV0wHKLYPXaWvYwK0EjTYz9A1Ms6cygoPbQLhvP5egdoYPAIePNOc01P9c0yOzi6RVZQ2c4CEcSKkD9wN3RBJZ6QkHOEuE7Kuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5418.namprd11.prod.outlook.com (2603:10b6:408:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 17:54:17 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 17:54:17 +0000
Message-ID: <9c0e0e7c-45e4-ad65-f9a0-2eb582a62a3d@intel.com>
Date:   Tue, 13 Dec 2022 09:54:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v4] x86/resctrl: Clear staged_config[] before and after it
 is used
Content-Language: en-US
To:     Shawn Wang <shawnwang@linux.alibaba.com>, <fenghua.yu@intel.com>
CC:     <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <james.morse@arm.com>, <jamie@nuviainc.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <x86@kernel.org>
References: <20221209024436.22170-1-shawnwang@linux.alibaba.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221209024436.22170-1-shawnwang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::49) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5418:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd2293c-8ae2-4dd7-4fde-08dadd330db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqBTx0se5gvhj/I86c8COHM1RckBxR0BPu+Bn/zftVaeAEAeVUk3ZirmDPY8KyPjpFUwTumxfxAY2x7Vd43+ydBbQ+cOzvTiah6lUu+1XTbHm1q0EioZr7Fa3ahV1bZCadS7runGmaymyyyD/9fc+FbshHZl1L+LsKUaSqI6mBZYwHjsuDl+xve/Jrs2lRhS1J7nhiIl+WInjpJ7Mxd8V/A14cKVXIiLHLy3Uq3kxfew+0FxkdbLZK60nJG8KV4GRJrkL0pmKpA2m6BuHgK9w59K+PMLMokpefTyS/JmDRjkpyfNSGgQHbYLiMfOEgerzJH2kdFTSGz0kjhFInW0KnkpvQclvtTzVJHHwzjNfIlM8B8ZD/drTizJ4AnJNzp2panYABaLfnFaWDuAekjNYJl2YZXR0P33fcv9wii3q4egvvdTl0ZQvxn+xx34vLpO6cZipM5nKhC+InmgGDn537cyCDTLiYcXl0MWujoRcZnKudUdurEFmECvamwo8TSg0mby1f88TgZZCXqP5E+rYxTIkh4bM5RDAXEgafYaQfARH0WfsRYB2QMgpX0+Ag2wWthmzOUYbb4TXDdBDq7BZwmYZ/MbDvAfWtBPAOKtNh6ZSFFaI1+Gb7ehGohkPKZNj3xhRcYicDd0dLFDAxtsDEqliUi/DoDNQ507CLvel2KEabr81S17oIisYjcolTgthgsEJP72GFcakVgiVTsuP+ywlp/Hka12n9tgejtnNuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(82960400001)(2906002)(31686004)(44832011)(38100700002)(36756003)(6666004)(41300700001)(53546011)(6506007)(66476007)(86362001)(6512007)(26005)(5660300002)(6636002)(316002)(66946007)(7416002)(4326008)(66556008)(8676002)(8936002)(478600001)(186003)(6486002)(31696002)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3psUkZUaHkyZXE3UjZ2YkM3UjYzclNHaDNUdmJmQ2prTGsvdGtlaVFwc3JN?=
 =?utf-8?B?UnBISGh4Z3RFbktjSVltSzAxd09CUzZpMUJ6YXNZS3UzZ0phc0FldzMrSW1T?=
 =?utf-8?B?SmZ3MW1FSTAvSXB0cEk1ZUdVVnA3dlZ4Y3lXUHNFU3dUL2YxOWtJdGFLa3BK?=
 =?utf-8?B?THV4TFJSRk93Y2pvVFh3NU9QV1NlUktYbVI3NFo2RTFCMU96Mm55cmF3ZVFI?=
 =?utf-8?B?RW53Rk5SbmhteEhLV0dBV1lXNnVDYzM2dXZGTTkxQWlTQ0d0akhhZ05vVjJo?=
 =?utf-8?B?c0xOclJwSXRtUlZ1R1RYZE9zaTRjUVdYVzF4TUx2TkdXQ3lwNit1ZVB4a3dN?=
 =?utf-8?B?WTQrV0FQblBHaHNZMFBUb1EzV0R1R2N5V1pHZ0U3S1dLNVF2ekl1M0VVNlRv?=
 =?utf-8?B?YU9ZSExHYmQrd2M2V3RLazc1MndxUGwzRnVmMVcwOVcvMVdwa1pBeGJkMVlm?=
 =?utf-8?B?Sm5jYlFLSzU0TmRhMGhYY3NXOStzTFlBcTV4L21hNk16Z0ZENUlXU1NFKzhW?=
 =?utf-8?B?aWdQay83K2oySnpwR3VERFc5WTRtS1VER1dVZDd4b0ptWmFrVDVyRlRyYkR3?=
 =?utf-8?B?R1dHWkFHVitHVnkwV1poZVR6UjdnQzdHd1JiWmxldHp6bU5KTGcwczlOd0p4?=
 =?utf-8?B?MjZ2UUFHcGdkWWNJbW9tZUdpckQ0SFNnY1M0RFg2SG53NW9yQWpMNjdKMGJi?=
 =?utf-8?B?ZUZmVitHc2RLTmhianMwV1BJME55Zi8vK1EzeUNKOWZIbkV0UUFIcEI3NXo1?=
 =?utf-8?B?U0dnY2xWeE9ldG12cEtCV29kdWNTYVE1ek9vc0ltZTY5dzNTSWw1eFhveW93?=
 =?utf-8?B?VFVyZi9mNG5TZnJQT1RnWFVyUjNFamtYT29MY2xyaUR3dHY3ZG1Fb2pnQjFz?=
 =?utf-8?B?bGF4UUNOR1NtcHZ5VGx2RXFmZnp5OVdjaGpha2UrV2ptbXE5R0pwVmRsODI2?=
 =?utf-8?B?NEsyNGpIakFicUJlNnpDc0hsQXF3d1E3aUxCODNtVDdORlNXVDVMVVNsZkZ5?=
 =?utf-8?B?NGFjMktJVjF2SnY1Uzh2Y0ZUWm9KTklvNGg3akZTRGxBWFhhNVJET1lxUFcv?=
 =?utf-8?B?enp2bEdjcGNZWGR6RkRMTUo5eFpGRGZBTTBGT3dYUzN0U0RFQldvQlAwUkx6?=
 =?utf-8?B?Nm1LRU1yc3FOODhaWHJCaEtUaTVtaVI3UE4wYnF3TmxXaVlSMzZHODVYaFRs?=
 =?utf-8?B?OFpsMjI1ZElmRUhUMkVhOXNJU1pwdmhOM1RUUDRheUtaZFREWFRLeGpSL1FD?=
 =?utf-8?B?ejE1NUg4SC9MVEE3TkpMU09qbnpKZm8zY0xJWjVYbVRXKzFSY3hNeEdoc05s?=
 =?utf-8?B?dE9oYVMydGViMkFSM09KV2JRamVOMHhIUVJXbkxtdFowRGI4ckpucHluL1ly?=
 =?utf-8?B?TXJxZ0RrNDdzNndEaHJFbGJpSXV1ZnVkZk5VWXlCZE0wQUpjVThRcDVCek9T?=
 =?utf-8?B?VXpDY2U2bW1nVWM4Q01QWlptQUFWUVVVcGpSbDd1ZjVXUkhmanlBN01Yakgx?=
 =?utf-8?B?WWhRSGhyN0lIMHQySXdJd0t6K2pvVHZVcE9MUk51MFV4U2lwd1pDWkpodlk1?=
 =?utf-8?B?R3RVRHBNalA0VjNTdS9SRFN6b0h0S0FqbjVpWVFEWXJJeW8wMFVCOU83c3BC?=
 =?utf-8?B?RFd6Nk5tcGR4ZjlaYitST1FSazZJS1ZzcGlMQW9DSWNpMmI1VWZsaEg3Z290?=
 =?utf-8?B?TVF2ZFhZZzFXZHBzamlORTFBQ3ZUWXc1WGNIYXNHSjF4ZUJLWEwxcmtUQjJo?=
 =?utf-8?B?QWpFdGVVTjd0K2NHMXVOS3cydmRFbld3cW4rT0JVZDF6OGU2bytpQW1nTmNR?=
 =?utf-8?B?ZDRuMEE5LzhZbU1hc2xBTytoYnNMVHRPTlRVNXkwOUVXSDVWSU9oRXBBNnpF?=
 =?utf-8?B?NDRXYUJyc25GcmoxaExWN0I4ZmE5SmYvUFhqYlZLLzZZL1ZYU1JpNmZsak4z?=
 =?utf-8?B?amRjdUdpMktDTXh0bkh4OUU0U0VUTzkwYnJSNEE2bXRGc0lpSjFsUnZwZEE3?=
 =?utf-8?B?YzZjalNkdnZmcDNHcGxSenFmQ0NLRnl6Qm52cEJLRjlNMVNPdHpUVzZmdmtq?=
 =?utf-8?B?aUVNeWIyZmhPb21iY1BtcmdPd0E2Y3Y0cW9RdDJlNWM3bzJFUjMwRW40di9Q?=
 =?utf-8?B?bzViZyswMFhKb1JIZmtsQ2VEZi9JeWxXNll1dlJINjdCOVlpM1ljd3ZYMDdE?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd2293c-8ae2-4dd7-4fde-08dadd330db4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 17:54:17.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bDmPeh70RkG62P//5HgFjHgTurP4RwGW0NqirgEKHEZMXuhGRpAg1m+CSAd+eEROgg5hS1RJnAzO4F/JIYZ5rQgueKC7731gcEA1bsezT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5418
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 12/8/2022 6:44 PM, Shawn Wang wrote:
> As a temporary storage, staged_config[] in rdt_domain should be cleared
> before and after it is used. The stale value in staged_config[] could
> cause an MSR access error.
> 
> Here is a reproducer on a system with 16 usable CLOSIDs for a 15-way L3
> Cache (MBA should be disabled if the number of CLOSIDs for MB is less than
> 16.) :
> 	mount -t resctrl resctrl -o cdp /sys/fs/resctrl
> 	mkdir /sys/fs/resctrl/p{1..7}
> 	umount /sys/fs/resctrl/
> 	mount -t resctrl resctrl /sys/fs/resctrl
> 	mkdir /sys/fs/resctrl/p{1..8}
> 
> An error occurs when creating resource group named p8:
>     unchecked MSR access error: WRMSR to 0xca0 (tried to write 0x00000000000007ff) at rIP: 0xffffffff82249142 (cat_wrmsr+0x32/0x60)
>     Call Trace:
>      <IRQ>
>      __flush_smp_call_function_queue+0x11d/0x170
>      __sysvec_call_function+0x24/0xd0
>      sysvec_call_function+0x89/0xc0
>      </IRQ>
>      <TASK>
>      asm_sysvec_call_function+0x16/0x20
> 
> When creating a new resource control group, hardware will be configured
> by the following process:
>     rdtgroup_mkdir()
>       rdtgroup_mkdir_ctrl_mon()
>         rdtgroup_init_alloc()
>           resctrl_arch_update_domains()
> 
> resctrl_arch_update_domains() iterates and updates all resctrl_conf_type
> whose have_new_ctrl is true. Since staged_config[] holds the same values as
> when CDP was enabled, it will continue to update the CDP_CODE and CDP_DATA
> configurations. When group p8 is created, get_config_index() called in
> resctrl_arch_update_domains() will return 16 and 17 as the CLOSIDs for
> CDP_CODE and CDP_DATA, which will be translated to an invalid register -
> 0xca0 in this scenario.
> 
> Fix it by clearing staged_config[] before and after it is used.
> 
> Fixes: 75408e43509e ("x86/resctrl: Allow different CODE/DATA configurations to be staged")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
> Suggested-by: Xin Hao <xhao@linux.alibaba.com>
> ---

Thank you very much.

Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

