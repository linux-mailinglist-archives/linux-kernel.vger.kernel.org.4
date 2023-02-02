Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8992688B0F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjBBXpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjBBXpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:45:44 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028D17D9BB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675381523; x=1706917523;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X+pCDIv+vGs5dFGLqqXZWJn6rqFARhZHJIwr+9qjw+c=;
  b=IDGuALzfyyhdeqdfV0fghWRepKA6eTlRWtbxj8O/WIp9PG1iXVPDRyuR
   SeIuKWxnFZ+Vt8+I5RBFHJ2tGMwtbMYjAz0w61xY/90ISMbo4Bne3KMyF
   BtyDavwSgp9/HApGPngjCJvIK/7SeSvGFnnzhDoM1BiO5XSPbCl/srLS4
   elOGSokhlWmM2hVM7/2KiYqbp3josrbyt9SZ4q2SpG8aaDTz/+D91gsee
   8j/L5d1Sy0W7EudBexQ65SjlcrtFkCLaWu8IzOVWSgFC7mZHQScQsiZhM
   DR0n3TU2WOajTRNv9Rri4ykbIKBT+mfXu6dFDztiYH0tdOAi8cZAIxJsw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="327249847"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="327249847"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 15:45:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="665508472"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="665508472"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2023 15:45:20 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:45:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 15:45:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 15:45:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzhwIm6lYdFbmxXUhG8TINe2CYP846uCpvIfQuieZgyhoNAKVs8V1QquzE00gJoZZMQYzybg2wo1otLdTDZpLvi2D0yuYu+BZ6OURVhQtZNiUsJoQv7ufI+Doj3jNYq05ZeRGE31RqA8PKuxdRMPf5/LMDfOdZyQr2cc8/jo5aajYsOkorMK595ZpAD1aRZ1pmYnVHc0K2AuBdh0e5CLR1uxv/1ZNTdzOPnAGrd+9z3wa5ORHuNkqUCZxf3nPeOLRkbm5lGgWVzf0Q+LIqCNgwvJl9BABYPwj45CyQ9OVyXR5R33yVdiMy28VHyueWeCDTEqZXd7wGRhOlj+mUjjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP9Mv9TSd9AkbGg7m6wv01qXjJwoKGV+aZ6qgPHyaiw=;
 b=fOToHF1Gj06ZbUFd4t/0y17AEiSXqgt5QY33AajXlSaeKpAEwff08pVIPsymtJNtNLollSr1Gwwp2+pGqr0ID1Gui1EDNyM/nVBnpSV4qpXzr9IMJlgTxqSf8l3ciPvqv1gEQFs9A09/JZFWir4V5KLwiPKTh8Nt0xY1FM8k1Mw3/jnr+P2vbStGT3fMcFC6WIQO6sb2rqoZMZSWiL4WfUv5EizwBS1CpjAYq5AphdRyCaSzq93EglNnWDVd9ILCo06dXhItqFKnl34j6rzLagYBTaRU9qrWKKxAN4WeKlEpBrkj45aax7BPglLvkgBTc1lpzRzSyjZfmCcF30sKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS7PR11MB6175.namprd11.prod.outlook.com (2603:10b6:8:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 23:45:18 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 23:45:18 +0000
Message-ID: <052a8700-bae1-a945-c8d0-df658697142f@intel.com>
Date:   Thu, 2 Feb 2023 15:45:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 04/18] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
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
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-5-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230113175459.14825-5-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS7PR11MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: dd806ac2-a3a4-4041-cb54-08db05778a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPQeGiQVpQcQE5yx5RH+19qURmymd+9NNcBdYNUVB3UZZ2JWAxtx9F2bPlgkzAh7yPFUfQi+PKztoP0Fkvenlp2/DGceS7pheNdwsBefRAPOEiM0aoUMrqDl5Mw/s4oUQv5GSWGDOeV14S0oWD14wmO8ogN1HcarO1pFHxpqBa+Lh3XRbKCV5Pozjq4TfDHRKko+d+RyT3gdNW+cmY3zOfkl49sxn4xe1vF4Og4AQfd6kwHGymnR64rkA265JU7AM7gA0tSwqCjAZLWDHmctd0ZsYRKFIs3jHHhPOBOkTVMv4ZU2k4KI4HgbCgriQeNhnzUwwC5gkvIhWLIcpdkvbDRXZzedA30oKcSOW7qThWKwqGDg2dRu/UBSXDLpGrJYILZpKi9rdQpYUjLN3t2uXeNBdZnpmKZY4KewgciePlHCshEPFCEshsa4XEBntQB3fXorTlMBU8ZdfJX0dw6nFqT+sbFok3w+zaEJU7MhG/7/NRkV7qMB6hSlSnDNcFVzxnMt/56yLc+xjYA7UQKcyRsxsefSvILvBfoS0nW7melsKMlvuQO9jlNyCLUfA3nYjOuj/ycYdRCNi0squmMNLQWQ14+HUmNJAMzXKZUpbShICw90lE1slvn3TUFxkKStFvjDYbEvAvvlswTUVwO1+Atl/h+F/3YCT+7e2B5WtsBobef+aoHmkbUVaT4VrOVwNI7kwt6SJz0LIOg/JO4MyARgcJmfgRi4BCBapsH2D8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(36756003)(478600001)(82960400001)(83380400001)(66946007)(8676002)(4326008)(66556008)(66476007)(54906003)(316002)(6506007)(6512007)(53546011)(26005)(6666004)(186003)(6486002)(7416002)(5660300002)(41300700001)(38100700002)(2616005)(31696002)(44832011)(8936002)(31686004)(86362001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDZvMks3T01kZTdyRVg1OUczNDRoVXEvSmdmSGQ2QXlLUkNNcXc0dUhIVXgr?=
 =?utf-8?B?bDkwRWRLNFRaemRIRjdtcXdOUHJpbDJETjR6TjFQV1pYVEdmNzFyTDlUL0Fy?=
 =?utf-8?B?R3FXYlFsVkZEV1B0bG9oTk1NR2RIT1pEalBnVE1FK1E5cjJMcXMyNkxSTG9C?=
 =?utf-8?B?ZXlGT1JBMHBpMUFmQnhjd0J1TUtja0tBVUp6aExjODg1NjdiNmozY3FQZVhD?=
 =?utf-8?B?ZTMzV3lQUXNJcndUMmViMnJhdjdpM1RlYTgxQytkUzRsaEJmUEFKTzZnVXA2?=
 =?utf-8?B?eG1sMWdwOFo5U2FoU0VTVUN1b3E1WWxMVkM0VmJVRTdieFIrdm02WnJuWXYy?=
 =?utf-8?B?TkdkQkpvd0prUzRXZWx4NFNuWHpVOGNZaWJEa1BRZXR6VkxEelNaR28zYUdQ?=
 =?utf-8?B?SlY2eW45U05uVDc2N3QwTTJnV3p6enhpRXVEVE9yY1hFTk5Sdi85eC9naXpK?=
 =?utf-8?B?dmtQWm91SnNyOS9QU0N5bWJiYTFXaVJWQmJYdUh0bEQ5OFVNN2c4QWdKalRN?=
 =?utf-8?B?QWYzdm1SSmNST3k4alpuU2psVmQ5cTJpVmVweHl1WE8ySFZScjk2TzZIUWJy?=
 =?utf-8?B?OHM2RGNYRWpocDhkVlBHN0hKQ1diaHd0Z2ZaVTRyNVFEL01SMERrVm54YW5M?=
 =?utf-8?B?eGt0MXExZGdKdTNEYzVJajlmMVBOWDkzZXlWWVIwcjBlY2dTL014OSszNEVF?=
 =?utf-8?B?Y1hsd0Z3VGJOVzRMUm1YczMvZ2VVY2NVOE94THBuNlFUejhKU2tEOTJmdHZ4?=
 =?utf-8?B?cTB2emVxbGdidmxYSTNKc3hGbDZBWktMczB6OWhSWVJNT09FSHdNR0laZVZG?=
 =?utf-8?B?Qjl1cGF3MFY4RVpvQ0NqTmQwMjJ5OGUxdkh1alRGMXZ4UE9ONjZSK3Ivam9X?=
 =?utf-8?B?czhPQmw5T2xJUGpIOGlkVWFxYmZCajNSdDRkMWw4MXRrbzVvdnNrUUFWUVkv?=
 =?utf-8?B?N1piSkZTQUNhQmJ1M1BYTFcwRXltVXFvM0x5WVJ0aUhvSFpMSlRCVUQ5cit5?=
 =?utf-8?B?WUVpMHZqTjdmOWl4N0FuSWw2SnR4RU93cXVVcWZJU3IwT1QwTWtWcVdZdkkz?=
 =?utf-8?B?QXdJcmVkcEZKdzA0UXVGbTJrUkk5ZnBJY1pxS0ZNdElxVTNYbE1ldkhFRS9Y?=
 =?utf-8?B?VUxGdXhGWnRRdUlmZGM5aGRselVBNStrd3hGZGsrWSs5cjkrOFREa2FsUnNQ?=
 =?utf-8?B?R0o5Ti8zNmpBSU1TY3A4bld6anVGME1QUUxGblRMdkhkMldjTnV4dzhQV2Zy?=
 =?utf-8?B?WTFRQThkS3dXVllkRC9wQUprQjBVd3BoZUpMQkQxck5uOXl3ZnR2eFNmSmsx?=
 =?utf-8?B?cldTam1saWp0MlV4OE9DVVBmeENkbE1qM1JJY1RQSW1ONGdmamVrWjBQdDZH?=
 =?utf-8?B?SG5NeWtIdkNINU90M2JTUVYxajEwczQ1M2phN1JlSUFoUmFpek1ZUTJxM1ph?=
 =?utf-8?B?SDN1a1poSkdaZkZ3V3VCYUN3d0JoZFY1dTB4T2FPeXY5TzJCSTNHdzhicWhC?=
 =?utf-8?B?a1hpQm5NNmd5Vzk5OE5WRE12SDhIK29jaHNyNjNNb1FDSjF3WnlCdU9xZUJQ?=
 =?utf-8?B?YVFpenVzMHg5eVlLcklaNnRUdVhLTTdtdXgvc0F1UGxsa2dYcWJod0IzOUZo?=
 =?utf-8?B?KzJUd1hwQWhERURIOTF3R2xxNE9LcytZVG0zSWxEempSWjYzckZGcytpc1Zy?=
 =?utf-8?B?aWY3dnhHSlJkeU1YWEN6amxnVVQ4ZU01L0NVVjB5VVkvOHRzSHlXRDhBQXBV?=
 =?utf-8?B?Nzc1SUFoU2dQODlIK1ZMd2haS2RPU2JhM3FBUXJkelFRbUtvZnBHZ0hIVlEy?=
 =?utf-8?B?RHh6SmhrUHNLVEhLRzJqUGxhSUNnRU1zU29zS0I0aVl0SHpreWtoNE8yU0t0?=
 =?utf-8?B?eHI1cGRaTUpsbmd2ajd5bE93NjlWNTdGUWcvNGh5dEZzZXdVb1hCRDVzT2hG?=
 =?utf-8?B?bjFYRXZMdVhWcVo4NTk5emIxdGtWN1FEMGlKeGZBMVNFMWVpUzlLQjBleVhz?=
 =?utf-8?B?Ri84SFRaSFl2NzBEL3BSem9WVVM1Rm5ldHEwa09oYWpxczdENS9JK0QrQW8z?=
 =?utf-8?B?SnZXRXA0eEdITXJZcERsRi9DV09FUGkyQnZLUEhOYnZ0bHNYNWU0MWxncURp?=
 =?utf-8?B?c1BNc1BDN2VSTEZvMTJpQldVZFBSbWlQekdTcitvMU5zZ1RVY1F5NVNSaldZ?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd806ac2-a3a4-4041-cb54-08db05778a42
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:45:18.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0jSMsIyHix8krUl1GTHyDqlfN6IrUI+nTjMT+uPaNY2MH/Tqs2NHEb05JS1Hoz/jE6JHjbEGiNewA3UCqeXJVZoY2eprhF+80nUuwHbJSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6175
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 1/13/2023 9:54 AM, James Morse wrote:
> RMID are allocated for each monitor or control group directory, because
> each of these needs its own RMID. For control groups,
> rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.
> 
> MPAM's equivalent of RMID are not an independent number, so can't be
> allocated until the closid is known. An RMID allocation for one CLOSID

Could you please be consistent with CLOSID vs closid (also RMID vs rmid)?
When reading through the series and seeing the switch it is not clear if
text refers to same concept.

> may fail, whereas another may succeed depending on how many monitor
> groups a control group has.
> 
> The RMID allocation needs to move to be after the CLOSID has been
> allocated.
> 
> Move the RMID allocation out of mkdir_rdt_prepare() to occur in its caller,
> after the mkdir_rdt_prepare() call. This allows the RMID allocator to
> know the CLOSID.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 29 +++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 841294ad6263..c67083a8a5f5 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2892,6 +2892,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>  	return 0;
>  }
>  
> +static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
> +{
> +	if (rdt_mon_capable)
> +		free_rmid(rgrp->closid, rgrp->mon.rmid);
> +}
> +
>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  			     const char *name, umode_t mode,
>  			     enum rdt_group_type rtype, struct rdtgroup **r)
> @@ -2957,10 +2963,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  		goto out_destroy;
>  	}
>  
> -	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> -	if (ret)
> -		goto out_destroy;
> -
>  	kernfs_activate(kn);
>  

This moves the creation of the monitoring related files/directories to later, but leaves
the kernfs_activate() that activates the node and make it visible to user space. Should
this activation be moved?

Reinette
