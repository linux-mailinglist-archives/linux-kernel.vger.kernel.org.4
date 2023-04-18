Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D1F6E6EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjDRVxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjDRVxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:53:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A55173A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681854779; x=1713390779;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZnRsKwnCP8qItCIrUxfshHO97aJrl494a4xFIEbrwZw=;
  b=Te/w2GLOW22Lp42DaIqCUIEBXuHJzFBHlanZ9JI7TjQQxSuEnnheHAsw
   styt+w2fz3GeiNSPKGlmP/HTeUMUqeAFcba8dIJ0jRL+IG54LDjo7wd1D
   QDiNDCy4r6QdT2ERLBSwYglz8v75ObiX5wwsSk7B0l5huDgbxPqgU1j9v
   8Uk+vtbf6N8qLMifcDNZyqgJ72dmDT0gf2Wj33grzadwOxq3phfaSsT90
   81iHiG/2D6gXjjCNSywy2gwLABf5NLe65EKdPMBczj28acCrVgocZjdJ8
   jLev91TurGt/r2cs6WL9U1Wi3Uwla0wL+XXGVhxGY1t6vFYGLacQS9Ydv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="348050546"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="348050546"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 14:52:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="723835689"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723835689"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 18 Apr 2023 14:52:58 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 14:52:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 18 Apr 2023 14:52:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 18 Apr 2023 14:52:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbyFeVXzroTgN1ndrn7TMKwMdb8xRE97xK/h5mCf4ctjZ4UmPIjDvHwvHKyDNFm4XCJbIYiZoyPvAJxMtWyOg/QOwG+jWSQpVW/7d1yfjQCnjwYR31jYKMGBXMF3tAlLjpb0Fcg0kx6VSlcEzk2Jc++2wsbOGKUHeZ7JFzcDkE/xtGzr6kXHI/QQo+N0hK5bl9syew/IYE/JgcwsysfV1YNicyediYuoiv4A8jc1nBNd8Lfe8PPbjlIzwKeHGW7v3597vpna3UaKnHWb8AqXxxFjf43/3yiBW0g+9cnX7gxvir1Q67Pcoyar9FkpiusfTKLyXtkMODWu82afQbMEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlJ53qOTNsslM18QjSKpU11p7N6kjV8C9hvlaV2MpFM=;
 b=ELIZzUMKXTJNA4tTC2tOGjPxuFhZlfNj1VFgEYdlfmbXQo5LMAffRU/Ckao4SgUver78mH9j3QXM+27UwSWTuKd/MxImGOyBgiSkW4jfi9AEVe062Ma57kahRKMD/CeLonsB21MdvQyYpdZataEh+Vl6GdrJPOEwEop4Nql9WltZwgJha9ap/Yw6VQhiENZV9NdKBV2j3HHAgYBJEFhUBsNSuyUegb6PvS611hwBJ4OGql1Du00aXPLaC0ox9ZLKPVHJd1x6HIs+VnVC8R2KxsfJEuBzK9LnsCYDwoi9p9MvxrcjN5sBNKEhYlcAOPgpHiFHNrWMClu2wPRzXR6Q9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN2PR11MB4742.namprd11.prod.outlook.com (2603:10b6:208:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Tue, 18 Apr
 2023 21:52:55 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b%3]) with mapi id 15.20.6319.020; Tue, 18 Apr 2023
 21:52:55 +0000
Message-ID: <678ab8b6-9465-cdeb-da65-448c0cf075f5@intel.com>
Date:   Tue, 18 Apr 2023 14:52:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/3] x86/resctrl: Implement rename op for mon groups
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <Babu.Moger@amd.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <gupasani@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <skodak@google.com>, <tglx@linutronix.de>, <tony.luck@intel.com>,
        <x86@kernel.org>
References: <20230330135558.1019658-1-peternewman@google.com>
 <20230330135558.1019658-3-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230330135558.1019658-3-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN2PR11MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8463cb-b9da-4fe5-a899-08db40574362
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MKNXusUlcfUzirXobBeeIGPwlYFIpfkukd9MMOgdvY/nWMGvuypNS4BYYLMr6c7pB/35ca3hoHdL9zcL2ZGsJk2RObjmur0IjeJlpCGU/OIaCXnu8dOoe7AQKsDOeIkC1ief2/QhOy28DJQjHY8RerbNNhIyPAXo/FzVVxytk+GFCSSburEIgKdbvWONlUd2WxDs5gZ6/7MLhxCyNQcARAMIUIwDdTs9d6fZ5p1dDZ6cEuLataPYe/2/v5m58wBgoOUfQRKWdiLwp6p4IJhiBwYVkybapWTE9wclBHMSAgORX0d/LVlEOEOpuoy1rG/DjHAl+238lkEFWqCB17r08CquJ0Z1QziURhdfnvsS6rST6tHhL60lNquvRfFqFI3AhcrAKPbto5wr9L+rCQ4WB6yLpvKfqixe/UMHT0z68wgA1qVRnkqG4qIIhx1gEdxLTt8iv9c/fNHByQVvog0YuroFnCizNT57Bk4XWYTzupr2ILwENDcx7lEvhA/NX0FzU/AKVndocSHvbBdW7X/HF2uzZ+jF5hJRJMp6ndp0F6TopHs0PGNaZOEsm0zn91b98/7Qn6jql2K8kIfiv24BnLXBpY+jsJxRu/jnTk94CW+YgGthVJMtxDicYaFc4wAkNfuV1nrvw8VlDyyz/MCN8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(36756003)(86362001)(31696002)(2906002)(31686004)(6486002)(2616005)(6666004)(53546011)(186003)(83380400001)(6512007)(26005)(6506007)(316002)(4326008)(66946007)(478600001)(66556008)(66476007)(41300700001)(82960400001)(7416002)(38100700002)(6636002)(44832011)(5660300002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZSU1g5ZWdEc2tNbXNFS1NaejN6U05iKzBqMEpPaDlmSVM5RFNCNjM3ZXpM?=
 =?utf-8?B?UFFUYlE2bWp5NWVoZVBsM1lnZENZTGxLVmdTL3dSZDN4d3JOWDR6MFNWaGFv?=
 =?utf-8?B?MmlBYkFZMkpaOUhOcTRtK3hkaE9QcEVtWjd1eDl5RXlBRFdYRG9IS3lEZDJy?=
 =?utf-8?B?QmR3ZU5TUDUreDJXT0xoQkdJNU8yMUJhVmhkQW5LLzV4dHRzNmw3Kyt3dU0w?=
 =?utf-8?B?MzF3S203Q1ZzVUxZZ1Y0eHk3UkcrRVg3WWYxVkRpd0Z0Q1QzS2pJbkhSb2ZD?=
 =?utf-8?B?L0RxTlRsMG1lVjFHMjV3UHVXMjRQSTVDQURUS0N4OVFEak9rWUlDUGJ3Vnk0?=
 =?utf-8?B?cERyVEFhQjdET2RBSGFlQy9PN2ErUlovNkE0ck5tdFhzZnF1WEV1N1hzRDM0?=
 =?utf-8?B?V0d4WFJ6UGJ0anowTm04K25tUjZDY2gwbk5NV0hkYThvS1BKOEQ2QmEyM2FH?=
 =?utf-8?B?ZkJoVkU4aVNmOTJPRlphYWVFUUxjL21UWXYwZVRmVHVWd1RWSHNRdzQvODl0?=
 =?utf-8?B?bVZnL2Q3MEdJNjVBZmJ2NEVqOTBrOUY3aHNNeXhXbkdzSWRHeDhWdDR6Nmhk?=
 =?utf-8?B?bzJSdlU0VytzMnIvRFVFc1VEVlNwaElidDA3L0pLSXd1TWZHNHgzREZ6b2No?=
 =?utf-8?B?TkM1UnV4ME4xODE0TEQzNlFXY0k4elFHcjY2UUUxM1Q4SnJOcnVjKzhpRTF4?=
 =?utf-8?B?cHQ5K3hQd1lyYk5YV0JsNUU0cXZEUitVR3ZuT3hjaW5OVEZqSW1kekhmK2ZH?=
 =?utf-8?B?SmVqZE5rQjBKckF1c1JOZko0bUxGZ1hxSUgrUVBlRjRJdE5hc1dxVlBJc3FF?=
 =?utf-8?B?eWF1WXJjOWh2MkFhbnhBRms0dk5hcWE3Q0VSeWVBLzBETkZ1ckFwd01hcVdB?=
 =?utf-8?B?MDd4OXJIY1FPUUpCdGp4MFRUKzExejdlMFdxQm52Vm9qUzM5dm1MK3dXVUg3?=
 =?utf-8?B?V0FPQnp2dlo1eE1DVU95Nnh3eGZ2OTV0cUtQRCtveEhEY2JyemhzaVN2ZTNV?=
 =?utf-8?B?SStkNnNsZTlSbDJLR3F5TDlTZzhOdjNFWVU0SjMzR2ZjcVB3cDg2b2dCazUw?=
 =?utf-8?B?b2lCVUtPNm1CVUxnUjJIVXV0RHlnOGxkUm5JMzVpanBXUlExWXYzWEdjMnZN?=
 =?utf-8?B?eTZQcE85cjR6cU9TNWt3STNtVEwyOWtBU1ljNDJIL1h4QzlkcXRTdmhUY0Zu?=
 =?utf-8?B?UkR0bHM2bmhHRU43SEc1eEVDa2NvMVp2Zk0rM1Y5MGw0QVZCVDdyWjljRVI1?=
 =?utf-8?B?ZkpLMm04M0RQL29XeWdzK3NPa0gwbVkySEpzR0lRdDNBZy8xUjc1bGlwVTd6?=
 =?utf-8?B?eEV3N3Q1RzlGdFN2K1RVRndrNSt3dTUzVlZtdEhsMFNtSlphWDZWMktkc2JK?=
 =?utf-8?B?cDUzb1lDazJpV0piRmk1V0ZQNFl6N3RSTEJyNUIxMi9xL3RnOXpybE5pY0RY?=
 =?utf-8?B?Wk53aWNRVzZTQy8yUGxLQUJmVS9vQ2NqUTEyTm5MMTJHNUptU1lmc3lXeSsv?=
 =?utf-8?B?dkpqMllsUGZSNFo1ZlRrVC9xSnloL2RmYjRUeHVkc3RGTG14Q2JERlN0UlRS?=
 =?utf-8?B?cEw4bkpUZ3NSa1NGYWt6TmlaWlBGUVI3dVo0UFZlREdqZVF4YTJSWlhrOHpr?=
 =?utf-8?B?b3J2WWhtOTZPTUhpZ0ZYaXNEc0VCblo0WkVsQXdCdlR2MVAxYk1JRE1uQnJx?=
 =?utf-8?B?cThRMTBiQnNYTEl0a2ROV3NVSlhId1ZucTFjaXU4cmNVbHFvc1NxRml0NDBD?=
 =?utf-8?B?ZllDbDlSUGJacllpcXlnOXlCeDVmWExnZW9UNU5nREFkZW11TG5sMFNmY2NB?=
 =?utf-8?B?VXE1NjBtOXhxaDhJKzBkdk5ITnkzWE5hV1NVYlZMVmNLNGNsRFBSNWFOR0dy?=
 =?utf-8?B?cUhGbzBuUUxUVnpDTGV5VlJlNkQzVVRoMXVyMlVWWSs5eGxsbDNNS3cvN3J2?=
 =?utf-8?B?WFl0YkRUTUhpRnhqenpoWEkrZUNqWE95ZWo2bzZBbFp1cDFONDZHMjFvYllr?=
 =?utf-8?B?MHQrYTNmTURwQ0RXWEdLY0t6WXFZbEhoR2NYT3JtVlBiNEo5emdqRWxackxw?=
 =?utf-8?B?NE0rUFZSclVMZnhtckxQSUtCL1lDMC8rSWlVVFk4VktTK0prU0NEYUlsZERE?=
 =?utf-8?B?V2hGaHFURFQrWWRPdE5hbFZhSGcvZTNlQzFINW4rdFQ2SERnK1Y0Z1hEU1Yr?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8463cb-b9da-4fe5-a899-08db40574362
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 21:52:54.4017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ph5qPqBJY+ZwFnVeeIDgCReM+NiTuUCkcbhxz/aabGlPBtKkks4i/64cnNcqjdIQzBjsWr4kKxnL1sETgLhDtZb9Q//YmwZHJrG4v1ORAx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4742
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 3/30/2023 6:55 AM, Peter Newman wrote:
> To change the resources allocated to a large group of tasks, such as an
> application container, a container manager must write all of the tasks'
> IDs into the tasks file interface of the new control group.
> 
> If a container manager is additionally tracking containers' bandwidth
> usage by placing tasks from each into their own monitoring group, it

The above sentence seems to be missing something after the "for each".
It seems to still parse if "for each" is removed.

> must first move the tasks to the default monitoring group of the new
> control group before it can move the tasks into their new monitoring
> groups. This is undesirable because it makes bandwidth usage during the
> move unattributable to the correct tasks and resets monitoring event
> counters and cache usage information for the group.
> 
> Implement the rename operation only for resctrlfs monitor groups to
> enable users to move a monitoring group from one control group to
> another. This effects a change in resources allocated to all the tasks
> in the monitoring group while otherwise leaving the monitoring data
> intact.
> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 128 +++++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 51b869149e76..86de22d8e23a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3514,6 +3514,133 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
>  	return ret;
>  }
>  
> +/**
> + * mongrp_reparent() - replace parent CTRL_MON group of a MON group
> + * @rdtgrp:		the MON group whose parent should be replaced
> + * @new_prdtgrp:	replacement parent CTRL_MON group for @rdtgrp
> + * @cpus:		cpumask provided by the caller for use during this call
> + *
> + * Replaces the parent CTRL_MON group for a MON group, resulting in all member
> + * tasks' CLOSID immediately changing to that of the new parent group.
> + * Monitoring data for the group is unaffected by this operation.
> + */
> +static void mongrp_reparent(struct rdtgroup *rdtgrp,
> +			    struct rdtgroup *new_prdtgrp,
> +			    cpumask_var_t cpus)
> +{
> +	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
> +
> +	WARN_ON(rdtgrp->type != RDTMON_GROUP);
> +	WARN_ON(new_prdtgrp->type != RDTCTRL_GROUP);
> +
> +	/* Nothing to do when simply renaming a MON group. */
> +	if (prdtgrp == new_prdtgrp)
> +		return;
> +
> +	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
> +	list_move_tail(&rdtgrp->mon.crdtgrp_list,
> +		       &new_prdtgrp->mon.crdtgrp_list);
> +
> +	rdtgrp->mon.parent = new_prdtgrp;
> +	rdtgrp->closid = new_prdtgrp->closid;
> +
> +	/* Propagate updated closid to all tasks in this group. */
> +	rdt_move_group_tasks(rdtgrp, rdtgrp, cpus);
> +
> +	update_closid_rmid(cpus, NULL);
> +}
> +
> +static int rdtgroup_rename(struct kernfs_node *kn,
> +			   struct kernfs_node *new_parent, const char *new_name)
> +{
> +	struct rdtgroup *new_prdtgrp;
> +	struct rdtgroup *rdtgrp;
> +	cpumask_var_t tmpmask;
> +	int ret;
> +
> +	rdtgrp = kernfs_to_rdtgroup(kn);
> +	new_prdtgrp = kernfs_to_rdtgroup(new_parent);
> +	if (!rdtgrp || !new_prdtgrp)
> +		return -ENOENT;
> +
> +	/* Release both kernfs active_refs before obtaining rdtgroup mutex. */
> +	rdtgroup_kn_get(rdtgrp, kn);
> +	rdtgroup_kn_get(new_prdtgrp, new_parent);
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	/*
> +	 * Don't allow kernfs_to_rdtgroup() to return a parent rdtgroup if
> +	 * either kernfs_node is a file.
> +	 */
> +	if (kernfs_type(kn) != KERNFS_DIR ||
> +	    kernfs_type(new_parent) != KERNFS_DIR) {
> +		rdt_last_cmd_puts("Source and destination must be group directories");

I do not think it is obvious what a "group directory" is. The source must be a
monitoring group and the destination must be the "mon_groups" directory. Maybe
the "group" term can just be dropped to read "Source and destination must be
directories" (which is exactly what is tested for).

> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	if ((rdtgrp->flags & RDT_DELETED) || (new_prdtgrp->flags & RDT_DELETED)) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	if (rdtgrp->type != RDTMON_GROUP || !kn->parent ||
> +	    !is_mon_groups(kn->parent, kn->name)) {
> +		rdt_last_cmd_puts("Source must be a MON group\n");
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	if (!is_mon_groups(new_parent, new_name)) {
> +		rdt_last_cmd_puts("Destination must be a mon_groups subdirectory\n");
> +		ret = -EPERM;
> +		goto out;
> +	}
> +

Thanks. I think using these terms ("MON" and "mon_groups") in the error messages
are useful since it gives the user something to search for in the documentation.

> +	/*
> +	 * If the MON group is monitoring CPUs, the CPUs must be assigned to the
> +	 * current parent CTRL_MON group and therefore cannot be assigned to
> +	 * the new parent, making the move illegal.
> +	 */
> +	if (!cpumask_empty(&rdtgrp->cpu_mask) &&
> +	    (rdtgrp->mon.parent != new_prdtgrp)) {

You can remove the extra parentheses so that this patch can get a clean slate
from "checkpatch.pl --strict" done as this work moves to the next level.

> +		rdt_last_cmd_puts("Cannot move a MON group that monitors CPUs\n");
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Allocate the cpumask for use in mongrp_reparent() to avoid the
> +	 * possibility of failing to allocate it after kernfs_rename() has
> +	 * succeeded.
> +	 */
> +	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL)) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Perform all input validation and allocations needed to ensure
> +	 * mongrp_reparent() will succeed before calling kernfs_rename(),
> +	 * otherwise it would be necessary to revert this call if
> +	 * mongrp_reparent() failed.
> +	 */
> +	ret = kernfs_rename(kn, new_parent, new_name);
> +	if (!ret)
> +		mongrp_reparent(rdtgrp, new_prdtgrp, tmpmask);
> +
> +	free_cpumask_var(tmpmask);
> +
> +out:
> +	mutex_unlock(&rdtgroup_mutex);
> +	rdtgroup_kn_put(rdtgrp, kn);
> +	rdtgroup_kn_put(new_prdtgrp, new_parent);
> +	return ret;
> +}
> +
>  static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
>  {
>  	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
> @@ -3531,6 +3658,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
>  static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>  	.mkdir		= rdtgroup_mkdir,
>  	.rmdir		= rdtgroup_rmdir,
> +	.rename		= rdtgroup_rename,
>  	.show_options	= rdtgroup_show_options,
>  };
>  

Thank you very much.

Just the few minor comments. With those addressed:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
