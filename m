Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8988F64DF8B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiLORSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiLORS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:18:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981CF3F063;
        Thu, 15 Dec 2022 09:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671124704; x=1702660704;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P9j4hSZviSkwCZj/x3pCd18x3f+ovnMU+Z81f2WESSw=;
  b=QCr+vgAQICRdOen1QLLvDxmf3t9b18ob/EA5n2in6IdPvJo9jzN+y+k/
   mDlG9SqbrQ9C4BX0cgrDXPnCfiQINJ35TRCizyYw1qJme0yz/zmiQDawM
   AbVeWoidFUxU4ZoIDWNFe9FvOOehQoDkFNikpf7IBPuED3y3JOvglXDfF
   /QDhPJafjGxob0iZq3QhJmUZKo91DOIabuoGdUjSOR59hVEFHc6uDOp/p
   Vp2vrRCw32xSMNLGGwcimuhp1/SnOfo6JER9dm/W039kfk5MGm4x9/7NT
   puIR72l75rlyu2VFYT4D+JE4kNvm3VfdR6fBFaUBUA7ljbHWNrW+byAZW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="318789614"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="318789614"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:17:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="823792273"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="823792273"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2022 09:17:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:17:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:17:23 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 09:17:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oT1w4M5dSd1QbeEhhml7/aIDT/gxO80NhS0aFkZMhEwKVz+5buIlrpy07b4+tVxT3+V877ResWHByZfxTZ1jlNOZ/6rgPyzJOskunQHKL4ae3od5ExzUsjXtq7zPsmEZSe9/yFt3rPrakS2kobYZ/Fn32Ol06i5LTJGoSIc3ZJKuGyOUlEyfjWab6bZUVtRUti4VEX5d7S9rMaAU0bfX8rxj0o2bjh1/MHOB4HL+1i9K0SqElD2fQ0iTHBl/j91aWpC//wx0hnh6Mi6JduPCZniNMn5vPaejhN9RHxGEJGl1PUkQscRJcTztww3EvW3WV1xEvqkr5QNo9NuWqJhsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iygohcToNT7J+AoiTUZJwz1r8vN8aAT3WvlswaouI5I=;
 b=MkMWo8j5VBd6Ta6fJws+ZWpYj6hGER9thpxPVnGqsCYxkoMKsSsOkH1focntvl2LbfJ7EGwgzvU1WubX4xpk1l6Eeum23s8rEY1d3+DlG0M61qLQgG9k0lQL3AuQPnWZ16yhKKhZPRsfDqfBbTfaD/Q1kT6CKzdR4SxZVwAKZHCz4ynf8/AsTPN9tPSbtJ86Dbkw6Cy72MZZlMnxyt87fCLme2+8QrL6wV0phc7niVmel/IyVbEOe1EDu8uZ74SvZrvRlEbKR9sWk7sJgwCN/VV4SOkuXxllpklc9bFbHGYLDL7YkUm+Lgc+xIfzVSJ9KLboV1G5dvPkOzP/zbkxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 17:17:20 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 17:17:20 +0000
Message-ID: <70e6b0a3-a18e-ff10-1df0-3b6790692bda@intel.com>
Date:   Thu, 15 Dec 2022 09:17:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 06/13] x86/resctrl: Add __init attribute to
 rdt_get_mon_l3_config()
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
 <166990900117.17806.4506067708943298894.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990900117.17806.4506067708943298894.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:74::47) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: c3cf88e4-71e7-48b9-604f-08dadec0391f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5qFDOBsmaqXpPnx0FXbJjVgimKqBX6fM+5mnVxA1Enzt/y3dXD2FlivVkBqwvOu/mUqbOWXZN5v2n16i3R230AqNJb2nhWLG70s1SNyH8S3+ufC+u0JYw4M3eB7TKFVVGL+lHeMrs8P7l+uSJaNjPHmVmHVDZKba77yvWn4Cd28kmcX5fEZvp46sjdytiGt15uz7sAJgPWaMAnZy5an6dZwOtnf0ueoGsqTbfHFLztwcK0V/H5YV8cRTH/mxthS5YjdnIuVcirytWaVaxGH/B4n01lwXRKY0vzHRMwwDC6AlkOgcaOeEJRGEV+Exf4fnxM4rX8beo8dBSg08Jwe9QPj4ln9C2/YoGecTZTi/BefCZthjNK5NYYjsT1PfsnbQJYASdtBXfcy5w4LbWkV+Zj/nnVT98HbFb38SvOeXKpkHLhiMkydMtWbD22KQV4YvAXwlQUdhmLak/2ngjxyAqtXhr1TCjhU14Y94cUmw92Iq32aA9S/6RkWgWpJB8EdlEsWGgY6wZZ12esxlI2yn+CIkhD3Cv2x+dNjULH11kJhcAfMjj6osNTvDCFNFLJhMM6/Yh0Vqh6aXg/PTUa4YzdRVb5QT/6ixH9dK0/T69lBU31anwp3QEmt/k0T6EbJDbUJyNyQT6LidMmUxUNLCXhVbZvwVr2XPNf7w0Gt9oFSdrxmuP8miOL/S5BAzXqYwBvBLuiDebIE2/vVb6DKhC39mWqElir2c5sk4oRPMhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199015)(83380400001)(31696002)(86362001)(82960400001)(8936002)(5660300002)(44832011)(7406005)(7416002)(38100700002)(66476007)(4326008)(2906002)(66946007)(66556008)(8676002)(41300700001)(26005)(6512007)(6506007)(6666004)(186003)(53546011)(2616005)(316002)(6486002)(478600001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlpOSXY0dlBjRzEwWU95SjFiNjVxdkFHZVdNbEZlZjkyazRmZWE0bEh2ZkJC?=
 =?utf-8?B?Z2l4NEJHY1IvTVZ1djZtYmRvcFI2dngwV0czYy9xU1RJUzByb3Z2d2xqQ3dG?=
 =?utf-8?B?YXBhWXhNeXZXN0Y1aFd4c3F1bmlEWUM5WnZBak9HYzN0WG9lWUlPNUZNOTdW?=
 =?utf-8?B?T3pMU3ppOGljY05nOWF2cE0vT0JnZ0lwWktaK056UlB0YTExNFZ6MUpLRC9E?=
 =?utf-8?B?bzNNZkQxRHdmWnc4YXczNUR5UDhJWkt3ZitRMld6REM5RlR5aFJvYWNsSFhx?=
 =?utf-8?B?RzhiQzhyWUZ3ODhyZ3pzTkFZY0kyM3hsbGwzMXVEMy8wWWdFQyt1VXdJN0Zr?=
 =?utf-8?B?K3VlVFlWL3FnTTBOeTFZTGpESDdaVy9CMGo0bUNwUDVxQ0FDUGNLVnBIM1dE?=
 =?utf-8?B?ZjF3VnZnMVh0Y0lFdlRqM2I4aTcrdmVkanpGdW52aDAyWlBQSEpxMDVlSkVD?=
 =?utf-8?B?QmZrVXo1TWRoZU83bTFzS00rMVdPa2p2dUxnNnNvaE5pUzFNOHpmNTVpdDln?=
 =?utf-8?B?TUhmY1ZHcHA3VjA4UkgvajJ6bjFyaUZwZ3VVblFhTG81K0dENFBhZlFtUTM4?=
 =?utf-8?B?L3hnb09MeFhCUEd1WmFpeGJRVkN1TXdnZWovMkx6aElDcHFqY0RTMHFON3Mr?=
 =?utf-8?B?Q3hDVW1uN1p4U1dscWNBd0xGMFFBUVZlellDdlVCTm1VSlJVWmVVTlRMbk9F?=
 =?utf-8?B?cnFjNEs2U1k3K0dJUEwrcFEvS3FtUjYza0FOZXY1NHVibkdjajYxbTA1OXNo?=
 =?utf-8?B?YXFRN2ZESFozaHNXc241UnJORlYxZUdpR2ZZbTJZSmtQc0NMKzNlcFAzaVdK?=
 =?utf-8?B?MUlMWGdtOXloU2xZWEdSbGtSVzNYTnNXRG9nM1Q1akF3S1pUWWpJOHZCYWpo?=
 =?utf-8?B?dTFYclo4UzAzOHJZZmhucWNMQ3c3SDJDN1Zta01kdmFNSFBjRlU1NGUzU2xr?=
 =?utf-8?B?bkxWZC9FS1FTR1ZTTDR5cW50R241UEtFWEFteHNTU25EOFppUUpyUHd3ak5F?=
 =?utf-8?B?SWFWY2tXc0E2N3JKd1lhYW9nT09GdGNUL2pnS3BrVGZiSUtaQk9OMGJ0eG81?=
 =?utf-8?B?ejQvdXhOdkNRNml6T1pMMVBiUzUyQXpMRGk1b0hwS3JCaGxTVlZTWTlrRlZo?=
 =?utf-8?B?Y3VSbGh5a3JLSUIyOXAzclJBNndZU0p3ZkxQNlZPdGtPZ2U5UWMwUGUzcXc5?=
 =?utf-8?B?U2F2RW4xb3ZnWkYzcGI1cTROR0Z5VzRZN3RGZmtPUFNyUTMvQ0VXOFZUMXlv?=
 =?utf-8?B?RlRvM0tqa1NiUlhFbEEyTFUvVGRyQURPNU9yTkxsalpXOGFNRjY1bUU3L2Jm?=
 =?utf-8?B?MFBQMWpFTmNTdFg4Mzdlejc4czhCc3VPVFhkTThGZy9DUUNwdjNGYVJ5ZEl0?=
 =?utf-8?B?RWZvSHJjaTVrUnZxYTRGMFJnZVN1MU5lbVVOditwQkJMUXV4aEpnOUZFeEtk?=
 =?utf-8?B?bzd4SWJhQ3QzeUxGTklHRzZzTFV3WGhlQUI0QnlBZk9QT3B2SzNIeUZqSk16?=
 =?utf-8?B?N0p2TllwN1QvMXRWMmRKRnd2MzVyMjJ5QlEraGYwV3JRL1V0K1lGMGVQazB6?=
 =?utf-8?B?a0RTNm8wQy9namxZR0FYZHQyTHZqZGh6RHUybEJsSDVwUzdMZytkSGFrMzJ4?=
 =?utf-8?B?T0NRSGR0VGt2OGRuY0FsRlAvTHdWcy9VWjRXRFdxbndqbmIrSVZDUWZXVzVl?=
 =?utf-8?B?Qms3MVNNajlMRDQ1SE9mOUNMY0hKMU1abm53c21RSk83akhYN1lZaytnb2RH?=
 =?utf-8?B?OWlZREg4Y2wyUkMyMnVzQVdOakNCN0Q3SElpUFVWeDZjWHlrUENhbFJXU2po?=
 =?utf-8?B?ZG1EcUpEaW8zRnZZOVZCS1ZwNHVEQ3RkeGk1N2Y1amdMeGo1ekM1d2h3ZmZK?=
 =?utf-8?B?MXQrZHZJTUpXSFUvRDFKQi9OZ0RHS0dnWFArTXhRTzdocnNGTzYreVlGS0NI?=
 =?utf-8?B?eWlXM0s4N0gvTzk5U01odlJEN0ZIREZyRWc2L05UQ2lKeVAxTFMrRzM3OVlZ?=
 =?utf-8?B?V2dGYit0YUM0K3hUZTZ4bUE2V0FGZHZRL1JPVlJXZVozaUtMT1prQVl0d1Yw?=
 =?utf-8?B?SXc0T0dBRURNRzB1SGEzdGwvMG1vMFg5NUlCdnRmTFpyWjlRK3JZbEpsQmxW?=
 =?utf-8?B?Nm9XVDVPMVNtSnE0ZEgwUDQ0ODZiTC9nUHczNlBLRVh0cktMN000d3VPaVJu?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cf88e4-71e7-48b9-604f-08dadec0391f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:17:20.2290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUzfSY5Qt5y+nmtbFNH8ZFb5l+QsRJaQgtEjBX9uwJkcdnPPphH2gzlmgiiNHjdvh0QTme4YW9DJi7FSJUudMm1cJ+cp2NS8Js5qVhWv9UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7608
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
> The function rdt_get_mon_l3_config() needs to call rdt_cpu_has() to

No need to say "The function" ... by using () after a name it is clear
that it is a function.

To support this change it could perhaps be:
"In an upcoming change rdt_get_mon_l3_config() needs to call
rdt_cpu_has() to ..."

> query the monitor related features. It cannot be called right now
> because rdt_cpu_has() has the __init attribute but rdt_get_mon_l3_config()
> doesn't. So, add the __init attribute to rdt_get_mon_l3_config() to
> resolve it.

Please place the solution description in a new paragraph and drop the "So,".
The description could also be expanded to support this change. For example:

"Add the __init attribute to rdt_get_mon_l3_config() that is only called
by get_rdt_mon_resources() that already has the __init attribute. Also
make rdt_cpu_has() available to by rdt_get_mon_l3_config() via
the internal header file."


> 
> Also, make the function rdt_cpu_has() available outside core.c file.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |    2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  |    2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index b4fc851f6489..030d3b409768 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -728,7 +728,7 @@ static int __init set_rdt_options(char *str)
>  }
>  __setup("rdt", set_rdt_options);
>  
> -static bool __init rdt_cpu_has(int flag)
> +bool __init rdt_cpu_has(int flag)
>  {
>  	bool ret = boot_cpu_has(flag);
>  	struct rdt_options *o;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index fdbbf66312ec..7bbfc10094b6 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -512,6 +512,7 @@ void closid_free(int closid);
>  int alloc_rmid(void);
>  void free_rmid(u32 rmid);
>  int rdt_get_mon_l3_config(struct rdt_resource *r);
> +bool rdt_cpu_has(int flag);

Please also add __init attribute here by using the same style as the other functions
in this file that need __init.

>  void mon_event_count(void *info);
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg);
>  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index efe0c30d3a12..e33e8d8bd796 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -746,7 +746,7 @@ static void l3_mon_evt_init(struct rdt_resource *r)
>  		list_add_tail(&mbm_local_event.list, &r->evt_list);
>  }
>  
> -int rdt_get_mon_l3_config(struct rdt_resource *r)
> +int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  {
>  	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> 
> 

Thank you

Reinette
