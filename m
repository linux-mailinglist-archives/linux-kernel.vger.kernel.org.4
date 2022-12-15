Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF48864E4D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiLOXwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLOXwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:52:06 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF942532C3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671148325; x=1702684325;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NguQXI+7Ww3YcRS6o2hlVUXcJpfBatDfF5KmnV/x6dA=;
  b=Is2ITF1zieVFo0isj68Fh3wCsUwA061kF3Jgbf5eWLJNiBXnowEpXTK5
   rVD+3H28SujQloOUbWHmzvmz22SMIHgOTUW8qoV6OmGZoOc977pjsk0Qm
   f10foXcCoA8A+uSzKFhjLtThQOG6qbtXN/GSWQYFr/QMhSoI/rI6N0rgk
   Wjw8KCxjzLkI3nKW84W+5gQBgD5+XWyajgIwHCUfyEzFoWOWDBdTuKF9T
   MXwGMLmkMjHyRL17v+Oo/bFGJ6sSnKETZr/6nE9nowVFz5W3e70NuCOUN
   3AeJHTnKa7ZUf0hnuT3KQr+QJvHx+HvyL9547qyAVp3gBMJz3Kb9tVxq1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="383165018"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="383165018"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 15:52:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="895011345"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="895011345"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 15 Dec 2022 15:52:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 15:52:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 15:52:02 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 15:52:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8khoV/wWpmBcEKzSKGkT88diXiMbnvmU12FFU8yJ7f9kedQ5WsQjAo4QI/cRbkUY+K24y78Lg+6fYgA95ksXxxb5u36mIIUFR6BobLld8d3rKtWIRYf9kzzSJt4Bk2fYuKzunV9fhKKPCYjdfMOoK6s1Rbh/gmjmax01A5cCxn3WzQVZIQdzbb+0DPq4myK19T9MeXsi8uI3kvElOwGfndh9CyB2T8A4FtA72uTaEn/VnNR8g1voWdiO8smu0riGPCUxi6QhoticcnEEwz71k0Se+ImG4tSjCA1PO/x1yY7aH4EUUfmj2k4pMQjfK7DKz+Z4eHerZeIbNx5JtA2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bw+sGlNp6qqtaB0hM3DWA6+WEexdm4S6740GFdh3i8M=;
 b=J/CB5d1sslS/WKqDXPADGcTHCCBvjeqYqcdrmcFlvKFGTKAT+Bgx2Szs8MrcD8kNg9BrYGLohSJS9miH+G8DveQhkgzaR0DAdR7pgo52+7iVQNx6Yjrj9Wf/cMI/IhAqCPvEcN99ClMP5OMXkwGamN1QHkd7WCgkzrvdbDlBnzO1fexaTlhduLfnBUjyI+vWokdF7wHwfzScsbuganZlUw11JNpc3Rb9Ifc7aD4PpTNEk1W2d0bjadW6d33C8QRNYb/dA+3yn1jFJV/6yxkE0qZq/S2EhOd4mDKDzSSVeYET1OdMopeOdrjj4PN+v8HZbslUIFTlfQySjxmRhghuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB7642.namprd11.prod.outlook.com (2603:10b6:510:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 23:51:58 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 23:51:58 +0000
Message-ID: <bbc57154-b7f5-4b9a-65ba-ca8dc0fe0dfe@intel.com>
Date:   Thu, 15 Dec 2022 15:51:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/1] x86/resctrl: Fix task CLOSID/RMID update race
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <bp@alien8.de>, <derkling@google.com>, <eranian@google.com>,
        <hpa@zytor.com>, <james.morse@arm.com>, <jannh@google.com>,
        <kpsingh@google.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <x86@kernel.org>
References: <20221214114447.1935755-1-peternewman@google.com>
 <20221214114447.1935755-2-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221214114447.1935755-2-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::16) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 216df698-a0e3-4d6a-07f8-08dadef75a6f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88NXc5aXyy/P70aFg6UmvVnNUhYHwDXmsHx+6ALJ5TNIlB8YZ4yp0K818VKFJF63SVIinOrV4mcXmjWJbyejQV2kdBQfkedR+ZHvo8KGcccx7AyOugVnxyUc8Szv3eUtq+bdoH0xQxtv5AVYt7mMB3dU5vssK+UUy518v/YgTi/tkFBdnFoWOQIhzyjK4Wxn6wZxvfX8EaA3BCTgDzIi1NWBa2Iuse6tsA98D6uvSuL8sbsv3wQTBYMVXRdX1Ldv6jmsE7ofM2HKqojwKSc2aZJfl8KdRjnhMtfCXAl0iCW0xosbPGTxJMWTTiG/0AMV2Uxn6fCFc5NnUsraOuGoj/XfrVLfFvmhh8hEGV/oa1aEbeEJRmBIuJcP6ok2TsMerJrow90TjynnUUWy2xZSU8TkyzUpTlxx4BUBJioWDuNzvOYUcW/V74wbGAZP+JpXOBgSZlzY/g3GfUP6aQVwTLo4ydoii1BNfW3PcraMGZ8Tz+Bwd/IlvybURDsPhg7Rhtt9B0ezx+/IoKStBnP2ONvVwXndGcygMno5DZkHeVx6Aa+yM7d3++WwTwf7H8MaC7KJLHaZOPaZbpSrWhY9MotX8QdA0wD0V37TP6hUDp5l/lPByl+/RwsHYOmnFZa2Sy976SBE11ZmQOKhWkouyn2rQLDIdBDYVpqwZbJyxHyq4lQKnXiF9GRskAaaIgS8dTdcuPiBcu1oaykgkRr7pjftWEVsC/wqKQGu/qyiGdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199015)(316002)(26005)(2906002)(6666004)(15650500001)(6636002)(31696002)(478600001)(36756003)(8936002)(6486002)(6512007)(8676002)(2616005)(44832011)(186003)(83380400001)(38100700002)(82960400001)(5660300002)(53546011)(4326008)(7416002)(31686004)(66946007)(66556008)(86362001)(66476007)(41300700001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzVnRFY4R0JVMERvUC9FTFJCN1dnTUh6WDBqMEkwWk5vMy9oOUNWeCt0a21m?=
 =?utf-8?B?WVFxNDZCMi92d2w5NVdiOTF2dGliRlZoUS9OUGF0MUdiZjFwdVJmL1o1R2RW?=
 =?utf-8?B?V1luNGtEV3BSMWtzUVpYMUY1R1ozeGdYMStBbnpnSXBJOUpSdWNHVjlPby91?=
 =?utf-8?B?ZEl2Z0Jtb0ZYVzZQZHZnUU5SN0pQeTgyM2Y2MlZpYm1rN2QyZVErbXB2U05w?=
 =?utf-8?B?N052VFJHR08vOFVsd0hVV1NyckRYMCtqRTN5UjRqd0o4a1IzeU5TME5nbWgv?=
 =?utf-8?B?Z2ZBTXJtWFljYjk0azhqOEIyZEM0SWt2NUFpbDZ6RFovOE8wMDk1bU13emNi?=
 =?utf-8?B?YUpobTMvY0JLTEdLNlRTRDFqMERUVlZDWXdSYm5lZ2hmcFNmbzQvaEpkZDlF?=
 =?utf-8?B?dk1FSFd5ZlI5VFNIV2J6VXZRd3Z1SU10QlFQNVRSenMvT3ZsdGRGdHJJYzdj?=
 =?utf-8?B?TDRPVnNTaXRnUkVrZzRIdGlad2hQNmw2TjFmTlhrTE16a01RbUZPSVVYVzdR?=
 =?utf-8?B?RnVIZ3pBaU5abzNYaDE4SGNyWG1HUTBMcjJKeGxzUUs4OTNTa1pkdGs5T0cr?=
 =?utf-8?B?UUJxbjlBZGR5NitYWGQxUDRlby9DUHBnYXdQcVYrODk5eTdoeitaTUlCOHV6?=
 =?utf-8?B?c0t3dVBSK2hUeVBhaElNODFyN3NMb21kMG9ab0J5YUltQ2x4VllNT0ttbGlr?=
 =?utf-8?B?eVJCTnFDTTNBS1hvK1VjM3RwNjYwRFR5Y21ZcjZUYk9YU0FVQ2Y3QUVMbys2?=
 =?utf-8?B?R2xYZzc1cUdINUFnemVVR0x2S2ZFTVNYWHpjejhRdXBid0tNd1Jsai9DMUlx?=
 =?utf-8?B?Q0V4MFZRZFErcGVhL3A0TlJicUVNdzdyeVJjKzFYQWx4ZjFSVWY0V2FRUDQy?=
 =?utf-8?B?MWxjd3VQNld2eVVDdWxWdjVTamYvdnZHZGdJa2JpSXh5ODRWM3BJanI2bUJR?=
 =?utf-8?B?MWxROU1tZUI0TmJxcGhSZm9BVGhqWDVLR2l4RzBzRUhDTS93czJ3YVlQamtN?=
 =?utf-8?B?SVF0QUxTbnJJTXhlbkRKdDdsZGtSWlowV1FWUFVJbHVYRThmOVRTbC81Nngz?=
 =?utf-8?B?T0dtbG1iVitjSGRBSWpBc21rbEhoNE9nNitJWTNPRnFvWkJBWmp4N1BHbTc4?=
 =?utf-8?B?b1V4UERJbitzbHB5Ykw5YVQwc2w5T2N1aTBiY2hSSWFDc2FPWUluUmdGbzZs?=
 =?utf-8?B?MmQ2L0cwTkdvYUU4VFE3RVUwTTBoQytiS2FRZWwwOGNNeHEwYnVZcjVBZHVV?=
 =?utf-8?B?THhDZ0pUcjVLdHFsM3pFTkpRUmIrejNPLzBBRDEzbFBiZTlCVmIyc2J5b01S?=
 =?utf-8?B?SGNMZVFoU0swek1CdncvaEFocWdGWkdmUm1BNUxpREZ0VDR4cytzL1FvWGFw?=
 =?utf-8?B?c0hGM3FURFhwaVpuK292RkZSdjNPUXpmR2dxYnpEWU93Y0pRZ3B6OGZvMGk4?=
 =?utf-8?B?TmZWeWVrekVCRTkrL1JaNzdSNk5aV3BPSWJYVWViNXo5TFlQTDd5TDZ6dnBO?=
 =?utf-8?B?MGZpcnpUS3IrWTlmRklhOGhtbzVLTm1YbVZ4R3pxNmNubHVaS1VEczdrbkIw?=
 =?utf-8?B?Rk12N1YxZ2pFYzVDSHJxcjFUQ3hHODRINHVUMGthSmxMZStkRUUySGt0SmVs?=
 =?utf-8?B?MTdheWdxSkNqODlxd0hCbzNuNDN4ZmlwMFAvUXdobzBMb0ZYczRLSmlOUWhp?=
 =?utf-8?B?M1ZnMThHOEpQVG55aHhFMFQzdWQ0MjZEcnZJOWVRNXI5WWkrQTVvVDB0UjBJ?=
 =?utf-8?B?U20vSlhZaEU2dHMxekc5RFlhK2w3bnV2eFZmTngzU3p3anFKaTJVZUpaNGZq?=
 =?utf-8?B?MFVRK0d4R3p3cUlmNmtUWFJuN3I0QndobUZUWEtZUlpzN0xuYTlldUVWUHV2?=
 =?utf-8?B?UnV0WjBxd1JKM2FNNzEvK3dxZ3ZFcWV6elIvT09mTXVmNWxWOFFlaWNiaXoz?=
 =?utf-8?B?ODhFTUFKRTZEcmxvOWRwTVhUSWt2RDQzM2dnS0FLaG0vbU1sS09KM2lnS05K?=
 =?utf-8?B?bzRNN0lmR056OGQ5Sml2Q1IzMVhpVTBXKzhxZzVGdVhsb2RZV284S0ZKN2VR?=
 =?utf-8?B?UEZWb3g1YmlBK1JWdFl3RWlyMGNpczF5QnJ2bUJsTGRoOVNmY1lycGlBQmVB?=
 =?utf-8?B?YzByODJrcGRabEoyZzhqMFNsUW1DeFpYdXBQZGJLeGpncTZwRUF3UTg2MVl5?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 216df698-a0e3-4d6a-07f8-08dadef75a6f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 23:51:58.3735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHXb4V7tmvRmkQLuk6fJLfsJEpNO5/nn4SLnlGRcCS25u/+99ETBi4mkWH7a6nzb6dlBUUAEbKha5YbR29EiWobLHzylWgQKG4Fb/af9kTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7642
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

Hi Peter,

On 12/14/2022 3:44 AM, Peter Newman wrote:
> When the user moves a running task to a new rdtgroup using the tasks
> file interface or by deleting its rdtgroup, the resulting change in
> CLOSID/RMID must be immediately propagated to the PQR_ASSOC MSR on the
> task(s) CPUs.
> 
> x86 allows reordering loads with prior stores, so if the task starts
> running between a task_curr() check that the CPU hoisted before the
> stores in the CLOSID/RMID update then it can start running with the old
> CLOSID/RMID until it is switched again because __rdtgroup_move_task()
> failed to determine that it needs to be interrupted to obtain the new
> CLOSID/RMID.
> 
> Refer to the diagram below:
> 
> CPU 0                                   CPU 1
> -----                                   -----
> __rdtgroup_move_task():
>   curr <- t1->cpu->rq->curr
>                                         __schedule():
>                                           rq->curr <- t1
>                                         resctrl_sched_in():
>                                           t1->{closid,rmid} -> {1,1}
>   t1->{closid,rmid} <- {2,2}
>   if (curr == t1) // false
>    IPI(t1->cpu)
> 
> A similar race impacts rdt_move_group_tasks(), which updates tasks in a
> deleted rdtgroup.
> 
> In both cases, use smp_mb() to order the task_struct::{closid,rmid}
> stores before the loads in task_curr().  In particular, in the
> rdt_move_group_tasks() case, simply execute an smp_mb() on every
> iteration with a matching task.
> 
> It is possible to use a single smp_mb() in rdt_move_group_tasks(), but
> this would require two passes and a means of remembering which
> task_structs were updated in the first loop. However, benchmarking
> results below showed too little performance impact in the simple
> approach to justify implementing the two-pass approach.
> 
> Times below were collected using `perf stat` to measure the time to
> remove a group containing a 1600-task, parallel workload.
> 
> CPU: Intel(R) Xeon(R) Platinum P-8136 CPU @ 2.00GHz (112 threads)
> 
>  # mkdir /sys/fs/resctrl/test
>  # echo $$ > /sys/fs/resctrl/test/tasks
>  # perf bench sched messaging -g 40 -l 100000
> 
> task-clock time ranges collected using:
> 
>  # perf stat rmdir /sys/fs/resctrl/test
> 
> Baseline:                     1.54 - 1.60 ms
> smp_mb() every matching task: 1.57 - 1.67 ms
> 

For a fix a Fixes: tag is expected. It looks like the following
may be relevant:
Fixes: ae28d1aae48a ("x86/resctrl: Use an IPI instead of task_work_add() to update PQR_ASSOC MSR")
Fixes: 0efc89be9471 ("x86/intel_rdt: Update task closid immediately on CPU in rmdir and unmount")

> Signed-off-by: Peter Newman <peternewman@google.com>

Also, please do let the stable team know about this via:
Cc: stable@vger.kernel.org

> ---

There is no need to submit with a cover letter, but please do keep the history with this patch
by including it here below the "---".

>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e5a48f05e787..5993da21d822 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -580,8 +580,10 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>  	/*
>  	 * Ensure the task's closid and rmid are written before determining if
>  	 * the task is current that will decide if it will be interrupted.
> +	 * This pairs with the full barrier between the rq->curr update and
> +	 * resctrl_sched_in() during context switch.
>  	 */
> -	barrier();
> +	smp_mb();
>  
>  	/*
>  	 * By now, the task's closid and rmid are set. If the task is current
> @@ -2401,6 +2403,14 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
>  			WRITE_ONCE(t->closid, to->closid);
>  			WRITE_ONCE(t->rmid, to->mon.rmid);
>  
> +			/*
> +			 * Order the closid/rmid stores above before the loads
> +			 * in task_curr(). This pairs with the full barrier
> +			 * between the rq->curr update and resctrl_sched_in()
> +			 * during context switch.
> +			 */
> +			smp_mb();
> +
>  			/*
>  			 * If the task is on a CPU, set the CPU in the mask.
>  			 * The detection is inaccurate as tasks might move or


Thank you very much for sticking with this and always paying attention
to the details along the way.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
