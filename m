Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C7269A384
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBQBm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQBm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:42:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98C813D5A;
        Thu, 16 Feb 2023 17:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676598174; x=1708134174;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vetNeQj65zaepRGUuxISmooGWeIf5/xRLUDjO2VtOXQ=;
  b=e1GZ49K+/zrVGg3ivptqgPpgDyFTLX7Esui0WWxUKo2WtniP3isGGjES
   XvYkz9Enx2qgH/to0LiXQRzMqyrG6dbT2a+l0f8kr6iaT4G/vxeIsjtif
   6Y0qpsX8p7uw6Z7oIxGR5KVVbZ1201ef3DLIhlpGVNbP8vfTVdL3QDZUB
   5asI9LSv3sssbZYtte65TBendVyzKoc4xepqe9gS5JrzZBFhFw/451MjI
   B8f5EGmyj2NH/abT6vKzb+NOxxgpQvaInPVqoLriIaioiijgU0CLHt2Jg
   LTjfpiQZPKsE8v5NwZNwhT7StHu/+ohRRw2a3ociIFyIOxcb72gN1x3nN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="330546291"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="330546291"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 17:42:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="813205469"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="813205469"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 16 Feb 2023 17:42:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 17:42:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 17:42:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 17:42:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReVNYi5SWUPr1SQfaH6qa4FsdVHGU+nxFTxgso4HCr6bOpUIlbJNjuWMMeVncstOkLuWLwDY5C4WgNJh3lE4p0h9DY1RD2y/dxVXLSIFCl2fFloGX8bYbpZgI9okzmMxbMf4jtP/7FEcGA/UANEThumlm0+d/Hx4LV3UBHeS84eZKJruJbmm8bbODBzwRNIf+j3UZItxto+ovuLGQSr4HNSQDScRZOTnVtcFiKepWAy2WeQgNLL94FmjS7WW6XhSP1Ln0DrgnsEhdcs6QprL9Gb7NT+PA1JuOlgRhmEZ1v9q9gEhR+FDe7/ErYdkhF80zgkSAiRYRqi7/BopbrnaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Xvljm5qGvA3S0Po5+LnAZkvQNJXrh/hsdYW5wzK6lo=;
 b=dOmSXCRhVQziKOZT0SUIRZkaVq3oRUfg5Ok7FD+eoLKZ+Od709HqxlkX87Sb2OFjtc/8fnsy82XbnIGoCmK8VqmtT2RnVM110cypZTCY9au7NUhzjpFlIIzR3SacbS/Dcfex0CnYvQ9WDUV87DO8Y3K0jMOzM8Dg7RxeInx7xdOIeaP7iXwD5cJ8rnDBbMAR2Ub1og87hALg8jFtIk7/pDLo5grOJZxgnKvV4hWeE4/RcJ9NMOAak/N8kIHVgzsvnqc7TMndgOVWnUXwG2Y5pkLf/FfNCWo2CtwkppxKt8x967heAuXgCfY0mvD2sRt8+JILm+FMBDs9M1dLbRr4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB4776.namprd11.prod.outlook.com (2603:10b6:510:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 01:42:45 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%8]) with mapi id 15.20.5986.018; Fri, 17 Feb 2023
 01:42:45 +0000
Message-ID: <04a598d8-eeee-9512-7db9-cfeae33999a7@intel.com>
Date:   Thu, 16 Feb 2023 17:42:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [RFC v2 PATCH 5/7] x86/resctrl: Introduce -o debug mount option
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <reinette.chatre@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
 <167537444491.647488.11815488030989406143.stgit@bmoger-ubuntu>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <167537444491.647488.11815488030989406143.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:217::31) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH0PR11MB4776:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c953c4-6277-434a-07b2-08db10884453
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgUh0MrZak4MXhVxTiEi8HwggVMGz/XBjmmQx3BgFy/tTujPDeehS7Fy63+Xt+TXHGwM+dTZh0zCXqTzq3pZcHD56sc9Hfndwg7D8lEdgvaWW/V3Bgp+vmenmrU3DGa2B/62WFp7OwS+mfLkv2+OspTTHQA8EGjFxAlbrvMybprMyKuPG3PQ/X0PYySBoLWQEekSMIRu7/ocGoj4jzxnqfBzMGxkgnco2jIR/6zRwWUYNDi1T9paLrEVn6H5e4websKlijmHotyxfskFKaEXp0EpXt2tPpVVTNpiR5kUJGcn7oFY30W0KsH8tp1GDPdFK1wuMGmJFYl1ATERpq1Fyocef2bdqWOujYeKf29mFIiEMTwmuZ71hSHlEU++c/zj5JHRs3pUB19p4m3ZCv92Ddoe0tmVteKN5G9lEq+CYLkihYg1UQD6Cu7aN81raxZxjJraamDxHgfrmq4S6MLvnnIH5qhv6+m5ntcz3kmQzg0yMeDyEZt6vYBm37bv5rMTaV+Zr8BJd7Z4kwYjfO3IS2toXog07QDfqjRO7xjfM49ETpSdlw5TePorSJ2femwYz0UwuoGtXtZ0g56p6yAAUNk7jFyITh0zH8uNYK0aSVbAbHL1SZOGi1zPikv5KvA+/UQVBbN7EiDvXrj5xV6nf+KghiMiN4QDWpmDxVaabDDz4bIZCm/IRimxECf3OEUb9Ss4KaGcvMpWKaQunSMn+MLit9xx/ThtkE9Z4bW3J1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199018)(31686004)(36756003)(66556008)(2906002)(8676002)(8936002)(4326008)(66476007)(66946007)(44832011)(7416002)(5660300002)(38100700002)(86362001)(31696002)(82960400001)(6486002)(478600001)(41300700001)(6636002)(316002)(6506007)(6512007)(2616005)(26005)(186003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG9VTVFweU44UFlDOU9oeHVkblNsVU1lNzkzUjhod0p6aGZZbkRpTnZLcjdo?=
 =?utf-8?B?TlhiY2laNmxxaXBaWDJNSWltektaUkV6b096eEN4eEpOaWdPd2FBanZZaUNj?=
 =?utf-8?B?V2NVWVV0NEJjWWsxaEtTVnZwUDZOWVVMRWMyVEllZEtkaTFuRGlteGtVVjRr?=
 =?utf-8?B?a1N6c24rNHhRZXNCS3gwNjhqSThPTjNEdWloSkZrVEowSEFjVEl3VkFXejRV?=
 =?utf-8?B?bENISFpmNDZMbXZSN0dQQUJGL1VKMFczZXhrTU5tL0hPZUIvL09yRjI1Njdw?=
 =?utf-8?B?TWxXc041OU1yR3ZwajhaMisyNUtrZGJrYXV1VHJ6ai9iZUM0OFpXR3BxSEpl?=
 =?utf-8?B?ZjcvMDlQUDVqYjVpMHJQU2loTjAvODAyZy9IRnVQdWxmMk5vUGN5S1FMOUJY?=
 =?utf-8?B?TGtqMXNEWFUrQjFvWmsySkR2eGRaWEFibHlhUVhqcXhQaUZyOXFkZXFyNEtu?=
 =?utf-8?B?RnJhSmFsVWpuVzE1cGNxTXFHN0JHNG1aTFoyQUF1Q2Nkc2tXazVZaVVPU0R2?=
 =?utf-8?B?UmhMOTJUa2pINExLTStaeFhVaFhMOTFXSnVGY3cwbmNZVGRvYmtPcDVJUEZs?=
 =?utf-8?B?WTBueUpPTS80RGNEdUFHakJ1eEc2Qjg2c1V6VWVvRVE3OHFEQStEam91Q0oy?=
 =?utf-8?B?cWJmM3RjZXExanFMb09qMlc1YXBqb2E3MVk5dW1jRXgzRVdlbURvNjlIcWZO?=
 =?utf-8?B?WGhXMkJqYVhJNDhBblRiRUhkbXZhckZRbFZQNjlEazg5bG85TS9XVElIeUQ0?=
 =?utf-8?B?UGRSMTZVWGhnUU1ENVZ5MlVkc0RpMHNLZWlqSjcxeTNtdzlOY042cGIzeGFs?=
 =?utf-8?B?Uk42VnhNcDlRN3lybEpTZG5IT2I1SS9XdGxCRDVMNlZHUnBWYnVIOWVicXlk?=
 =?utf-8?B?TWU5cGttRUhyOHFjbmNQRjJORFZJT2FnQm9nWXoxQ3RaejNjOGlmU0FzTVoy?=
 =?utf-8?B?UnRmWFQ4VFBmNXFFa283MThhV2RIWlBMNFVOUkpYcHhiazNmK200TTVMSGov?=
 =?utf-8?B?by9OSTFPL3NKSkR4Z292YlNETW9hWEJMOE84Q3Vsb1Nod0U2T0hFUXNrSTlH?=
 =?utf-8?B?T2NJT0g0MzIyWUgyeEErTjZDMTNUUkVyK3A1QUdEdWdVWm4zRW0xMkYyNEpq?=
 =?utf-8?B?WTNESUR6ZTBCaXl6bUZrVFFYZm5GaVRKRThLMmhIZXhKbG55OVIxRTVhaTV2?=
 =?utf-8?B?RjJiRTZMS1YwcWlMZmdReURDRGR4Wi9wNlZGMEpZMGdPVG5SNUVrVjdkZ1d5?=
 =?utf-8?B?VEE4cjJJamlXb1NFSXJFa2hWWC9rSlJyY25hYzVsdlhsTU4rZmRaZzhWZldk?=
 =?utf-8?B?TlFWZ3hqVG9rRm9SazlCMVR2U3NPWHRlNFcyQlh6ZlBqQkVOVy9idFdFYytE?=
 =?utf-8?B?dlc4MFREL0F3Y00vaEdXclRvTFo3NmFYUDlrSWNvWVRPeDB0OU9WM29lQ2Nv?=
 =?utf-8?B?ZE5CQTVVeHFjaU9PclcyblpNMmk0QktMUFlpZ0JBak81UzJEc2YrYUZDTE1t?=
 =?utf-8?B?b0h5aUI0TUxxMWpxS1lJVGdoZ1FieTNLUXVveVIzVnI4ZUdVanRCU3BLRFdF?=
 =?utf-8?B?UUJ2TXcrc1o1QkVSVnM2eVFHa0dKMW5RbVB5RnhaakliRFhQQjRpYVBBYTFH?=
 =?utf-8?B?YjhaVHhsQittQjVnejdGeHhhRjVqKy9nWHRQanBIcy9BRU44VXI3TVNjbHZ5?=
 =?utf-8?B?akZmNGdMdEZqT1RzYXlVVVhucTI4cjBhQUJSU2VyTitNNW1uM0txZGRlc0sy?=
 =?utf-8?B?ZDgybmFxckpkUVo1VUdxQjhKelFJUU1URzg4cnYyaFZXeVVTWHErNTIzQ29Z?=
 =?utf-8?B?Z3RLbDd0VmtiaXhpNElkT3BoQ3FJQUs0a3dsODJPT2g5S0lYN2tmZCs4ZXk0?=
 =?utf-8?B?MGlsam5lMFZiVjNYS3F3V01LalVhbDltWXYrUlZtaitkTjhYeEdCQytsektP?=
 =?utf-8?B?aksrTXQwL0VMRUFTallJcGVBZHRvOGsxTlRFbVVZMlhYR2tSbWNtY2FwOW80?=
 =?utf-8?B?L1VXNnI2UGVCVlVBbzN6SENtUEN1WHEwMmJEL0F5S015bjkrUk9YRWtVeHRz?=
 =?utf-8?B?WTJocmdYSTUyUDNuT2l5ZTZzVUxEM0k1dDlVWGVFbzN3dHVSTngzallXTFZT?=
 =?utf-8?Q?DDGNy9u3YkLgWq3OjwiP8AyJX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c953c4-6277-434a-07b2-08db10884453
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 01:42:45.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQrHdMyc8uhiqAw/qVFDWAKCWPRJ1tf2HjuqYDsaU1D/qlxvAgzedC1G5dX/4EKS6SOx66tA5BAwjzQzGzmBIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4776
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Babu,

On 2/2/23 13:47, Babu Moger wrote:
> Add -o debug option to mount resctrl filesystem in debug mode. Debug
> option adds the files for debug purposes.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   Documentation/x86/resctrl.rst          |    2 ++
>   arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |    7 +++++++
>   3 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 58b76fc75cb7..2c013c5d45fd 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -46,6 +46,8 @@ mount options are:
>   "mba_MBps":
>   	Enable the MBA Software Controller(mba_sc) to specify MBA
>   	bandwidth in MBps
> +"debug":
> +	Lists the debug files in resctrl interface
>   
>   L2 and L3 CDP are controlled separately.
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 6767c85b9699..35a9ee343fe0 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -59,6 +59,7 @@ struct rdt_fs_context {
>   	bool				enable_cdpl2;
>   	bool				enable_cdpl3;
>   	bool				enable_mba_mbps;
> +	bool				debug;
>   };
>   
>   static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 18d458a3cba6..9b7813aa6baf 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2555,6 +2555,7 @@ enum rdt_param {
>   	Opt_cdp,
>   	Opt_cdpl2,
>   	Opt_mba_mbps,
> +	Opt_debug,
>   	nr__rdt_params
>   };
>   
> @@ -2562,6 +2563,7 @@ static const struct fs_parameter_spec rdt_fs_parameters[] = {
>   	fsparam_flag("cdp",		Opt_cdp),
>   	fsparam_flag("cdpl2",		Opt_cdpl2),
>   	fsparam_flag("mba_MBps",	Opt_mba_mbps),
> +	fsparam_flag("debug",		Opt_debug),
>   	{}
>   };
>   
> @@ -2587,6 +2589,9 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   			return -EINVAL;
>   		ctx->enable_mba_mbps = true;
>   		return 0;
> +	case Opt_debug:
> +		ctx->debug = true;
> +		return 0;
>   	}
>   
>   	return -EINVAL;
> @@ -3525,6 +3530,8 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
>   	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
>   		seq_puts(seq, ",mba_MBps");
>   
> +	seq_puts(seq, ",debug");

Need to add a check here otherwise ",debug" will be always shown 
regardless "-o debug" is given or not:
+	if (ctx->debug)
+		seq_puts(seq, ",debug");

But I don't know a good way to get ctx->debug in this function yet. I 
think somehow ctx can be retrieved from kf but not sure.

> +
>   	return 0;
>   }
>   
> 
> 
Thanks.

-Fenghua
