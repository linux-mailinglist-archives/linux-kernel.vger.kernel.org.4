Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E46732279
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbjFOWJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjFOWJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:09:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8C710F7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686866969; x=1718402969;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lI75zf7eAQ9EfJ+JE54YY3S4oLYNV6G4bazyaJvKZWc=;
  b=JGzZpp0/P2+Ek+Gl83cHUeAyq2OHvyxaZXj3IDzUoS/lKruv3l9njkDj
   N3KanxGtGx9ic9DmEwymv53Y+a7aCojKO/y3V8NMK62hE+32Q/puhqnf3
   pSOtmPGpta6kel8yTnvRS7eqCdC3pzm2+IDACaqxtq9nnuKQ8l/Oprqfg
   2Fzj9d8lUbrCFLUuskHSMHtBcmQTgfp3U0S7ZivwlOfjOmJ4OZfAEzQxA
   TBXJOy4dLQxxpJNL71S9Q+w6KX0Ae5xOXZoClwdI8Nrpkb1Z3J48fKb1Z
   T8+6vDhOP7iVaikH0ZVzWgdnFYoI8jrKoZ6O0t+ejDhGtLXV464REk3t9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356542700"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356542700"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="777906777"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="777906777"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2023 15:09:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:09:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:09:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:09:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gvi1Wo8522BylP31Gs+3SsqhMQMdGK+O93WUbxZbL70OT2W+OgSD8tcpvJyUzNbTy7PsMuuE7PE3JsrJ0alMSl4jhBVJ0GYqr+7jYqfgvqAolke6pQNhBR0bW1f7dnkXZ+cKGl9jBJMrUwX4BlJyk1P6ewknFQFNE9PUdk3Bx16QphyzxOcdgVSOcqgTR9i6Ugy2v42E2pCqVeChNv2AyOvcml4/6NqG4YyUdi/qFVIE7bwgpHSud54rrUHLeGKaaLCJ5pLlVqqtLOg3icsdzkG6DvWzvcYc+YwbQvELAWW9bN66pdFiwAUtTabgdCL2yEgOYWOP8EW9tlEPkXxkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV5wou3vEBaxL95wazmD7A5JguJKoNefWACBtu3avY4=;
 b=cjQ6ilcwNYvpypf8DFQ99UB7Uv+ueW6ep1W8jd96md1Pi6Dn4EjRzLsEKWkrJeQSCELZk+aIQKTifYykZ4xCBvtM9rgd8py/5UC1UifwbujdzoI+Y67GruAddwtKTWJsNPSscHete1OnbB4ewDJpQQxie+g92aAbLgtL8ZHLW5/IOamLcI42J7DQD9IaR4uR8LqTz+0U2uxbOsY1t771o8HGfyHzGBRHNlJyBRYx7h1vgFdJNINTbQFnaAhS3clicJ1J/r8ajBMwpfttOxX6c4wTizHC+qCnpJrpBW/K2Rgr4MAif3KU84q5PPa2BPpQppVef0F/JMZXbbuvvViYVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 22:09:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:09:14 +0000
Message-ID: <348034b1-7bca-a8cf-b5bc-36c656de0bd3@intel.com>
Date:   Thu, 15 Jun 2023 15:09:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 08/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-9-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-9-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efb1c57-dc4d-4391-b7bf-08db6ded27d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amLMdW7cxuuV/pG2tF2kcbIU85Ix3ijpinm4UA4zeli9rBFtN7nsLaqdw/l7gy5zR1HI/FVrRbjPzB32PnlUkvxyu+ej4kTGOSJ/Ptl0T/VFKu5brwUHw0yGEVDpF0yqVBXLCkOfruVDOEfJBe1GI+vetbPRMK64eFyxRvThpqFU33lboCs11Pv8fr4hRFBMswS0johf6fmtoetXtg8v5hTt9kZ/rqFjzyOOMKzT+cIXXmplyCLn5AH6eAoqr1lcHWpwPcZ+b3XgaSRxvHdeC/Kv7qbV8y6wVN8BlvIUWPYFNUwhM+YDmcc6Vpbyyn0AEA4uPkQYJcvwtZqtXrG7+jiL8uBrR9vXTqjApv324JG3NeRffrInhdy4FKzE71XgmFEfQWO4z/CbKBMjL5s0f42waO9gEhpQrh2pZPUsPv1L4RVMjoVQMNbpbwps/77NGZ0ePxWiYIT4MyDf5/s4tr0Gmm4aPf8fIcmd/mjr0fOVrShXqthVFn4aqNkKW9sSEiUCrIQusAAgAdsYRzS+9rscRN6tarJ12g407eSoX0YTCICy1/o6afM/VkfgEBJbFON6kOp4oOMG9X65GuzqFvf3hcuNtkQscAhWYepX6qLEKe9Ux0JRlxbhA2O2ljemVSb1bphv8MIGmUyo4Nk4UshHMcpqbIia9nXhtbN1U8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(36756003)(86362001)(38100700002)(478600001)(41300700001)(8676002)(6486002)(8936002)(4326008)(31686004)(82960400001)(31696002)(54906003)(316002)(5660300002)(44832011)(7416002)(53546011)(6506007)(6512007)(186003)(26005)(2906002)(2616005)(66476007)(66556008)(66946007)(83380400001)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGlWSWREdER0VzZQcEdyMnBmY2ppVWVuaTlCQm5hMVpQaXRMTlBqb0cyUnBa?=
 =?utf-8?B?NUFQU2ROQkIrOXYwVWlyWm5aYTMzeFNHM3l5WHl5eDg1d2pYSE9iWmloRG5M?=
 =?utf-8?B?Nm5Bb01BZXZUbkNFU1JhQTg3Z0IvVmUxNVdZYzUyK1BySk9zdU9JMGxobWN1?=
 =?utf-8?B?dS9YcHdPWFpSYXQ0NnFuNXBDL2NHcXR5NG4vSnp1OUJaOENoUnJOTzRSQmJo?=
 =?utf-8?B?dVdrSG9NcGU0MXdtSU5xaFBkcXRNRWdXQU05blM4djRSYXdLY05YQkJRZHJ0?=
 =?utf-8?B?aUFPWXk5TENjbDlYekI1RzZjVDJjUGpSWkY0eUxTUERzeDdnRmR6MFBxNHFN?=
 =?utf-8?B?YUMyVXZjcVdBRCtVNlZRU0tFTWtyRXZFV3lob0JJNEpwVTVCdCt5TFE4dDFM?=
 =?utf-8?B?dW9iTlVDQmc3SGk0K2FqalJVdGgvZzh4Qjh5RUhGNzhqZ2ZGcXJycm5YalUy?=
 =?utf-8?B?NU9nVkt6NUQ5MnNRYndaa2EvNzBieWJTaVJKdFNMVHUwbzdDTk9wMjEzbEM4?=
 =?utf-8?B?NGE3M2plNUNxbFlsdWVvSnFzRWlUc1NzSnlpTUJkZ0xuQWhDa2FXa1dNVVBt?=
 =?utf-8?B?dVdrOHpTbzRoTlVWZlpLVWgwUDhnNS9TSExEK1djdDA2bU9XTkxmZTdyUlhv?=
 =?utf-8?B?YnZwSTlqR1NFaU1tN3MxaFpsLzl2MkxxQ0R1dHJ3bnFSeWoyaWpBVGZsYzdp?=
 =?utf-8?B?QkkwbTU2WE9wL2JOV2xkWGFubkljZjVOeWFqRUN4TVJvRklGYmI2QlFST2V6?=
 =?utf-8?B?d282UVhkL3V1SEtYTUl2WlJjMWgxUlJoQ3JYWXNTbXhJU0YyaTRnelZ6WjYv?=
 =?utf-8?B?eU9pSjdEZTdUL3dkeUY1SkhGQmNTOTNORjdrUVhtN1dGZEpoTDlGRUZmV1Zp?=
 =?utf-8?B?S1JXdFAyMmZSVTh4am05V2txZ1N3VFdyOTJHQ3VVTmZCSDBmSHF2bytvckNE?=
 =?utf-8?B?THlGZmhUdERibG43MVg5d040dWpuWVdwUkxndTNMWWlmeWFGdXo2TmZSdTAy?=
 =?utf-8?B?aVlSRWVnaXBZNm1Ya0JxRk1vTDdMalZ2MGltVXBQWGd2WmlMd1Y4aGhuUzFY?=
 =?utf-8?B?M0hpblUyU0h1Mm9hSlYrNUpNZytDaDV5NUJKbzEydk15dS9YbWZjN3VKa20w?=
 =?utf-8?B?dURVRlVNME1VbkM3dHFSMTh6VW5tK0F4Z3dhSVBwT3ZqeGdQWVNpQ244SUZC?=
 =?utf-8?B?UytzTlgrMzRQdXR0M1EvVXY4WkQyc2ZZZFd3MGFJL1B6UnM5RlM3NzdvSWhV?=
 =?utf-8?B?SGMrU0JvWkU5M2pYVCtBZjY3dTc1d3RBWHhlWkhtSXY0NFk2ZFRiMFMwYkgr?=
 =?utf-8?B?NlBqUlY5WkIvWTQyWllnb1oybzlEa3F0Zng0UDRQT1c2RWRQK3NSSmpQdlF3?=
 =?utf-8?B?YlhyRWZOMFV1dmVmanp0VGd6MEw2WFpSSC9uNFdPWVBFYVJDV2NhY1I2RGly?=
 =?utf-8?B?Z090Yy9FTkdlc0t6UU9Vd3loUm9pNEhLT3pzM0p2NWhmME92VzBIcUpJckNK?=
 =?utf-8?B?dTVHR2g0ZHRPbXZWUmRQei9OM0VtZXQvRDFtenBBWVB2aFVQeFhDMUQwaXdM?=
 =?utf-8?B?YndKbk1WVmI0SUZZME8vUFBiK0R0VHhUSUlTaldmUlNLS2toUlFqZ0Vyank2?=
 =?utf-8?B?OFEzcE5EaWFHUGJIVS8rcnRwK2ZybWxoSlVhQnlGUEZYRHpMbVZPN1d2SVpH?=
 =?utf-8?B?WCtjYi9tTm1hUkJDeENzV2xXQ1YyV1NOU1hBRm1nMVVrb2JtQXMrZEZyWHNH?=
 =?utf-8?B?by9OSytpQUovSzBzN01GQmY1Kzd1c3ZOWGZTL1VCeDJ6UDdwclliQkNHRXBp?=
 =?utf-8?B?OWZjMy81T1dNNEMwZVlPV3gvYnRib3hWSmR2RjI4Q1ZFbDhkN3VBaEdtenpL?=
 =?utf-8?B?MXVTb3JSNVdtTFdTQnFwQzhpSjFZenBkSHMzbWlIck52TmlJOFRKNFM4UUtu?=
 =?utf-8?B?MDBBWjNvT056QVpFN1VDUUp3L1kyUVZWQjliZ1VTa0oyZytlYnFrdW1UVU9V?=
 =?utf-8?B?c2JoNjhQSTRJeE1RVlJ2ZDFtTlNucExjRjYwaDBVUHhpZHpIT1FYR1NMM3Bj?=
 =?utf-8?B?cERPSndNRG54RzlMQkpvN1VoZzQ0NHBzblF2YTR5TkJUKyt3ci9lQWFKM2RN?=
 =?utf-8?B?cU84VmUwQzh2b0NqbVgxTlVnNmVYcVBmK2pMWW9KMFk1cjQvdzFuNG5mNXdm?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efb1c57-dc4d-4391-b7bf-08db6ded27d6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:09:14.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJ/vSbcT7vkwsCZP0J3Rs4Ph0Mvc3QunwW5J2IsQd55wo3BfdnTToglO+7yPf6v+J1w6OnC+RY/Kv4pdQeCl4ONR7qQ21a5sUfnsYXJUOjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/25/2023 11:01 AM, James Morse wrote:

...

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 1e7fa40ee471..128d4c7206e4 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -379,6 +379,51 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>  	return ERR_PTR(-ENOSPC);
>  }
>  
> +/**
> + * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
> + *                                  RMID are clean, or the CLOSID that has
> + *                                  the most clean RMID.
> + *
> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
> + * may not be able to allocate clean RMID. To avoid this the allocator will
> + * choose the CLOSID with the most clean RMID.
> + *
> + * When the CLOSID and RMID are independent numbers, the first free CLOSID will
> + * be returned.
> + *
> + * Call when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined. If not, call
> + * resctrl_closid_alloc_first_free() instead.

I was not able to find where resctrl_closid_alloc_first_free() is introduced.

> + */
> +int resctrl_find_cleanest_closid(void)
> +{
> +	u32 cleanest_closid = ~0, iter_num_dirty;
> +	int i = 0;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		return -EIO;
> +
> +	for (i = 0; i < closids_supported(); i++) {
> +		if (closid_allocated(i))
> +			continue;
> +
> +		iter_num_dirty = closid_num_dirty_rmid[i];
> +		if (iter_num_dirty == 0)
> +			return i;
> +
> +		if (cleanest_closid == ~0)
> +			cleanest_closid = i;
> +
> +		if (iter_num_dirty < closid_num_dirty_rmid[cleanest_closid])
> +			cleanest_closid = i;
> +	}
> +

Reinette

