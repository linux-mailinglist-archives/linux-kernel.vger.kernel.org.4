Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3812360D822
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiJYXqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiJYXqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:46:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365E992F5E;
        Tue, 25 Oct 2022 16:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666741561; x=1698277561;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2XtuIZrmnx2kHw6qLunepRyFH9AjiEsomdy1ohcqwVE=;
  b=K6nUGEIHqQeDc2RpVq3zLXkfsnd80pxGyomkaiCSz8eftctRPHbcT4wa
   SLNOd/isNadWBuCDi9OusGMgkI3YKpFQ5L9aWwc0lnEy9DT9S//cB3MmU
   iPyV2A2Uim9Vp3rLG9uRZR/FkBdFxYDmmjLcsRMynwTrSjILzWQY8OrCU
   2ptuowkW6Xp8FMjkPKPByJ5OlRUEQaBn4o4mqPKgC1ACDlYgssVVfpnjz
   9R3j4Qm7O84/WisWzNs0WL7yQgw25C9YQC+rb1PfHCLkuZLZjC+1ahNXj
   DbiMNxFd1SZbxmU4Zq1BgIUaAC2Er6zTTK+B5nfqxyH43pl3gUuMe8fOs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="288214614"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="288214614"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 16:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="695155317"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="695155317"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 25 Oct 2022 16:46:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 16:45:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 16:45:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 16:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N075fjRUuyzjq3tc5j5VKzEewLVuaSMf8+8yu7Eq0nYdUqVRne0f9qfxDDBR+lb8cDj+iDp8S3/NESbnS31/KRhEzSbIu7AsuBEsYyumgqXfugA/u7sQlFCtFrVzjVJ9SQ+JcCUL1zdtU5/glSoEljoK+FLZmcgAWI1gHvUltecGJJrcE/ZcHKlfJFN7BYp0DFbHG5+5LoarfI5VzDTHewqEgEQj0uegifmeaW/Id+itcGMFR1CGAISaZrCEfOyG6vAIGH8MBO4TmlBeP/mPfjwhRTHtZn0lymdsPGZd6MKbFRfBbfhg2I0NhqSYeMZWxZj2fhDS3ozWbvgDD3RoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrGX8Ge0T4lLLqSIlc2p7zGbGkRlh12vAoiyZKTQVz0=;
 b=h59W8n9KBihWGd+Vo7yVgsRXY1ROi2CBuxOqvNVo3FSaIXw6CpVC0+hDTxUmqOCT6VXxtT7H0EPRhdkLplrabXJBLbbkGVtGxtq2AvxHcFawJQ9iQAEOZJWBiGL3Nhny8TNVxG/sfop0w/rO+tgm4OQI8fbo4GQbJ3WYHcXLziOVTs41+Ml+yS4JZgTFaz01I13WnPG94eUmDKAlFFXCgx/Y/gLk1d+A1CmeUnZVG6SZyveFMI6PiusTN4ry3dWEN31VjRqzmu6YsAKcP3QbuciqA5yubdyidsR2tR0vet+wasO1s7VHce4/mJkjz5k1ugS/VpN4NGcFwjBhNyC39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH3PR11MB7201.namprd11.prod.outlook.com (2603:10b6:610:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 23:45:45 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5746.028; Tue, 25 Oct
 2022 23:45:45 +0000
Message-ID: <8cb913f4-feee-de7d-60d0-055e234c6501@intel.com>
Date:   Tue, 25 Oct 2022 16:45:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v7 06/12] x86/resctrl: Introduce data structure to support
 monitor configuration
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
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604560666.5345.17936133716540279017.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166604560666.5345.17936133716540279017.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::47) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH3PR11MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e854520-43c0-4785-73f1-08dab6e308b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ViaHY/7mUp7+vKHLhjvTZVLHn1ZI1uBph3fh3h36M93Q4F389MQDsEMptekTQFRovfaa71/7iURDMuAfg2h30/2+q2Rfh0HLJ3/tjxFxed6AVf7UBTMO/GJdqPTsNx4S0QxnIYUwfOXt36g02bFBX8SryY+f//zpLycEzctqZdoWVDpsSFqwS4o9SF19T7yj2XgLoiTxAA00tLA5ljdwYbmEKMk1Kmeixn2ywjG3WcnA3fDEjQPFfRqklZsjL7v4Js26r/ehv1Ed8GcbKCa04g/c7dL+ahi93JCUxpfGS/IKPb0oNJl7iLqgdJt/sj8w3UCtCIac+CNxqEKsUs0Ip3XcOHgFVtpjzYDdaP6qdTw82kPS1/Q4gBoherFKD8rS26K5Ex9eoETOfp2T6JiWa1x3V+1kmUj7K8euIERdirCEug3r+4h7Tattbh0FCzb+lrxqfIx8hgqUYOWGjiM0JjQP1NRCV+4dcp4S+tlJEUoHUOrqML6U0JPThFvSJkn0rn2rFax2CDAUtUjpahIbISZ68W9dK8EievA3LO4d6dE+/fzK9YaBZ2wz3GE93vOg0CvQmoTp77k004TcL1mPLJPnaJNAo9h6EC+KZjPpZvnX+FMfEtbbz5jujom1iSPKP0BK7SUiQOyx7jMGXzI/JvXCIxITmRic/e+sfvC2cz/8TdPfS/K6Vfz9Cruf6zeL/14yyc//D74oEiR92ZQxDL8mz46kN5f/S3ntJEg5wdI/w1tK2YKOE0dA8xp48Ry3SZqf/Ymc4ssk36bPvhwWgD9pKXem3hj1D9inh7DSc9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(8676002)(82960400001)(83380400001)(478600001)(6666004)(4326008)(36756003)(6486002)(44832011)(41300700001)(316002)(26005)(6512007)(86362001)(8936002)(38100700002)(31696002)(2906002)(31686004)(2616005)(7416002)(186003)(5660300002)(53546011)(6506007)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHV2UXd6SlR4R2dYYkdyazFZQVBsUDJCdWNaWm1IbWdoMGdMamorV0h1OGxs?=
 =?utf-8?B?R0hHSExQbU1zOTY4cFFuSjU1VFQxbTFHL2dsVmZqR2hadUMyWGZESGZmYjlK?=
 =?utf-8?B?UDRNY3pBVTB0MjJ5QTJwZFRNRVovblFGL1BPb0ltclYvck9kZnJMMmNNT0Mr?=
 =?utf-8?B?a2FnelczV0Iwck9HdHArQlNpUmE3V1NDOVcwbG5pMG1CQkVpUHVYdmhtWmxI?=
 =?utf-8?B?cDlZd001TEt3U29UYk9Xb25VUXg2RlpmNFVKWHQ3TnUvTkplZ25qY3lpTnhm?=
 =?utf-8?B?YnBUcjhqeFYweUN1dU10aWViYUxnS0c4YVBJKzhDbVRhRDdUOEpyN2ZKdWVn?=
 =?utf-8?B?WHpXczN5ODFDUnFuQjhkclR5NmZsQTA1OWxkYWc2M1Q4MGVjQnVsNWFJZlQ5?=
 =?utf-8?B?RHdhaWI4cGt1ZWwxcUlOZ0VCdE1RbWJ2U2pZU0JSQ29XbXU4VDNFZ1JGTWVz?=
 =?utf-8?B?UnoxdW5tTHRNK1ZlTHRZQm9ER1YvZisySk1FcUcyYllkM2wvVmd0eWVpTDFY?=
 =?utf-8?B?NmZ5OUkwa3VZZVl1UjJvUlZZdnJSZWx3dm1OTUR0ZGEzYXFrR3Vwc1cvc1pG?=
 =?utf-8?B?QlBKdU1kVTNQQWx0bGtuemYxR0VyZlUreXZmZFVSNVRQTzRub25OVURnZ3lU?=
 =?utf-8?B?SjFDVXJlY05LeHE0aStpa1gvOExBNHRwWTJLYm1qcjlOQzZwWTRYdmpLY3pB?=
 =?utf-8?B?dU1FaHh2aHNPbUZkV3hGMncvOG1nb3p1Sm9YTEkrS3R3bWxtdWYrOXk4SVFL?=
 =?utf-8?B?NTJReDZGSUFibWFmM3RoUkRaSjY3bHI1ekl1RjFPelZISU5aVUdScm9oV0Y1?=
 =?utf-8?B?TlNRL3F0aytlbVdoM1F0Y2ZWajdEV0pXd0tsQ2JsWkVqbDVCbTJSem9CUXgz?=
 =?utf-8?B?NkV4am94RDdlVm1zSEdqeUhOZGdPcHU1NTBaL3JBTlVuYnROaVdOdm9rVGhx?=
 =?utf-8?B?QlV1OFZyREQyZ3lUT2RJd0laM0FLRndSMzNpMU1kM2hpNzFaYkZxdkRKbHJs?=
 =?utf-8?B?QkwwNy90TGJKT1FSWDUrZkpjK2xPa1FNNnphWkdiaHpQQldNZTErNFgxZWNu?=
 =?utf-8?B?RGxoWWpINjJuTnllZGMwT3dKMjk0NXlUTWdzUkhEa3dYdTZwQkpPSnBDTFpt?=
 =?utf-8?B?cFh0NVhmeEYrR0s1WXVLY3RocVJ2SGY0bFVIcGt5L243V0gzaHorQUYzb1ps?=
 =?utf-8?B?Uk9hVkRRQ2k3ZVNEbWNnWXRXbkxyeXRCN2UwaDZvWVljSW9QaWhXd0xzOVZv?=
 =?utf-8?B?Ty9mOVdwY2xPdFJxdDFKbmgzaGc4RUxmeGk2ekJ4LzFFbVR0aWRCYVlGcWZO?=
 =?utf-8?B?WjhGOTNuaUEzMDlNa2VKelppYzNKTi9mVTN3Slh5ZFRON0I5c21QRDh1bEQ4?=
 =?utf-8?B?bkZVNDllazlQTGY2QVBxY2wrUFFCN0JUK0xBZHBuaXpZYzBZZ0F4RTE0WmF3?=
 =?utf-8?B?NmZreFBVUlRCUERSMWZPc0FxQ1FBeWhLdDRuUEV5bEt6M1crWi9QZkczbnpW?=
 =?utf-8?B?SEh2OGpXZlRsZWFGRlpoTmdIakwzRWdNclJCT1YySEorNkswSERRbmk4SmhO?=
 =?utf-8?B?aUpXMDMxVmF6bW91WHoyTlpQUWdOOEd1c1pWN0ZKbWMrQi9obVZFekhacnlI?=
 =?utf-8?B?dDFKdDRNam1hM3lrV250YmZWUlgwUUVxY0V0dDNCMG9PaWhUSUZlQkNVVXND?=
 =?utf-8?B?OUVZRFZqM2hLWUcyR3I1aUkzTDBzQkFTcTNvZXJ3YUVMaTB0c1hseUtMUGUz?=
 =?utf-8?B?RHVuVDdQN0g4Z05EZGtmbHJmVERsQlUvWkp4ZHB3ZitzekFzYk80bUNSSjB3?=
 =?utf-8?B?bVo1SEgxSStrVUJRNFVFT2d2c1FraWpNSDE5Q2RJbXkxMDQyZHJoYnBBRmRx?=
 =?utf-8?B?MVRqOGpLNnFEU0RSNkFBWDZDOU52R2dWQ1c5VUNqMEU2RmoyK3M5YVBCTG9t?=
 =?utf-8?B?TWVNWi9kUnFaZkY3N1BERXUyTnFXbHJ3WHROVlJsKzh4N1JpazFWZ1Q5bVJq?=
 =?utf-8?B?dTR1S3FlMHNZTXp3VjdHRHJVclF0UW9oOFdPNEUvMmVmVDF2VDJRTHIyeThn?=
 =?utf-8?B?ZkNCU1RQU2dQelRMTTdWL0NSYVU0U2JSbHNrRmNMUFdvVXJwNUptcDdMc2Vn?=
 =?utf-8?B?ZXg0VU4rQm13RHl2eTdHN0V1VWJMSERQWVlDSWRSdWw1WDdybXBRaG9xM1FG?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e854520-43c0-4785-73f1-08dab6e308b7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 23:45:44.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKoT3znN6bZ6foyuzYMFCrkXYDetcTw0jHeQmfgU+P97IXYo3+d3m7Mcf1nyuxS8relRwsMQ5sM/WMF4AceJRQCM/GrIt131kSFhvv9cDBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7201
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/17/2022 3:26 PM, Babu Moger wrote:
> Add a new field in mon_evt to support Bandwidth Monitoring Event
> Configuration(BMEC) and also update the "mon_features" display.
> 
> The sysfs file "mon_features" will display the monitor configuration
> if supported.
> 
> Before the change.
> 	$cat /sys/fs/resctrl/info/L3_MON/mon_features
> 	llc_occupancy
> 	mbm_total_bytes
> 	mbm_local_bytes
> 
> After the change if BMEC is supported.
> 	$cat /sys/fs/resctrl/info/L3_MON/mon_features
> 	llc_occupancy
> 	mbm_total_bytes
> 	mbm_total_config
> 	mbm_local_bytes
> 	mbm_local_config

This does not seem to be what the code in this patch does.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |    3 ++-
>  arch/x86/kernel/cpu/resctrl/internal.h |    4 +++-
>  arch/x86/kernel/cpu/resctrl/monitor.c  |    7 ++++++-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |    5 ++++-
>  4 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index d79f494a4e91..46813b1c50c2 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -814,6 +814,7 @@ static __init bool get_rdt_alloc_resources(void)
>  static __init bool get_rdt_mon_resources(void)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	bool mon_configurable = rdt_cpu_has(X86_FEATURE_BMEC);
>  
>  	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))
>  		rdt_mon_features |= (1 << QOS_L3_OCCUP_EVENT_ID);
> @@ -825,7 +826,7 @@ static __init bool get_rdt_mon_resources(void)
>  	if (!rdt_mon_features)
>  		return false;
>  
> -	return !rdt_get_mon_l3_config(r);
> +	return !rdt_get_mon_l3_config(r, mon_configurable);
>  }

This seems to do a portion of configuration in the calling function, pass the
results of to the actual configuration function where the rest of the configuration is
done. Determining "mon_configurable" really looks like it belongs in 
rdt_get_mon_l3_config(). Is it availability of rdt_cpu_has() that prevented
that change? Why not make it available internally to all resctrl code?

Patch 7's mbm_config_rftype_init() can also be moved to rdt_get_mon_l3_config()
to match how other related configs (thread_throttle_mode_init()) are done.

>  
>  static __init void __check_quirks_intel(void)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 16e3c6e03c79..b458f768f30c 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -63,11 +63,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>   * struct mon_evt - Entry in the event list of a resource
>   * @evtid:		event id
>   * @name:		name of the event
> + * @configurable:	true if the event is configurable
>   * @list:		entry in &rdt_resource->evt_list
>   */
>  struct mon_evt {
>  	enum resctrl_event_id	evtid;
>  	char			*name;
> +	bool			configurable;
>  	struct list_head	list;
>  };
>  
> @@ -522,7 +524,7 @@ int closids_supported(void);
>  void closid_free(int closid);
>  int alloc_rmid(void);
>  void free_rmid(u32 rmid);
> -int rdt_get_mon_l3_config(struct rdt_resource *r);
> +int rdt_get_mon_l3_config(struct rdt_resource *r, bool configurable);
>  void mon_event_count(void *info);
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg);
>  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index efe0c30d3a12..4b8adb7f1c5c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -746,7 +746,7 @@ static void l3_mon_evt_init(struct rdt_resource *r)
>  		list_add_tail(&mbm_local_event.list, &r->evt_list);
>  }
>  
> -int rdt_get_mon_l3_config(struct rdt_resource *r)
> +int rdt_get_mon_l3_config(struct rdt_resource *r, bool configurable)
>  {
>  	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> @@ -783,6 +783,11 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>  	if (ret)
>  		return ret;
>  
> +	if (configurable) {
> +		mbm_total_event.configurable = true;
> +		mbm_local_event.configurable = true;
> +	}
> +
>  	l3_mon_evt_init(r);
>  
>  	r->mon_capable = true;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1271fd1ae2f3..5f0ef1bf4c78 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1001,8 +1001,11 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
>  	struct rdt_resource *r = of->kn->parent->priv;
>  	struct mon_evt *mevt;
>  
> -	list_for_each_entry(mevt, &r->evt_list, list)
> +	list_for_each_entry(mevt, &r->evt_list, list) {
>  		seq_printf(seq, "%s\n", mevt->name);
> +		if (mevt->configurable)
> +			seq_printf(seq, "%s_config\n", mevt->name);
> +	}
>  
>  	return 0;
>  }
> 

If mevt->name is "mbm_total_bytes", then would this not
print "mbm_total_bytes_config"? This is different from "mbm_total_config"
in the changelog and does not match the actual files created in later
patches..

Reinette

