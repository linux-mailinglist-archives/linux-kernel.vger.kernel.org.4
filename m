Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD62D688B19
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjBBXrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjBBXrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:47:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2D28691
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675381644; x=1706917644;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P1q38X6gn1Qbcjc96KWubDsqWZFxmapl89X2p0LaGpg=;
  b=dRcFRm8HpPiTlVuwl32HI8vcYhREOeBlGAUzTWCjJYBYwsQ8eloa53oX
   iFXZyAmsavLaMSV1LK/VC/33tnx5e+EUnJmFG6Hz4C29uQaqd+RwFASoO
   s2UETbhS1DB5w5KlczMkVXqAyKlbopDWisqyULE3QO/GaFpg52b56kUnW
   +s1Mog8i+bulOvHIs4aK/cu8/326DztYmr7YVdJaxb7NNpUwlXFOL8/3+
   subsqiJlkyRQei08ha8rBJ5pPitHeKibKeRX3qfVRg9c2fmClO06ZiYDA
   hd3DFpPH/njrbf7qfnufzHIVLz0HLemLufYjZnxdTUtR0HX/7+SHOplLO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="355945266"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="355945266"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 15:47:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="839398727"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="839398727"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2023 15:47:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:47:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 15:47:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 15:47:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hhr6lpcx/tp009zCVWnKHPft6rc9mCvEdCA935bHgiyUXhwTY4MgWlbn/l8baXdsHi0tr3nGxuS2aeI1ee+0o94DJz/wcJOpqSGuxGptOIceqHZuHDqwksIJkCM5vPqW//ban7j2NpyGdDg4n2dze3PPvofPx/mqZpwiM1ryO28dza+YL4X3CJmwyX6pm6yKzoE9bN+GZEVTqG6pczyMs7Ks6iHMMFrO52aEGUOc8c30FX2h3eFMuvdlnToEsKhwINyhqDvQTtJ9ZLoHwVr23xqfYfNHFClCldHjoEcXkauhlIwpSjJIN18SY0jm0ELuYqmkrQWevce7TNkye6alww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heQ9Pz+UuZOKgpNMzShpwtfYF/hIUwD+RKBJ/z5GXOQ=;
 b=B9KVaSw3lH+5rI+yxcKhggEuRhU6wyl48Pwd19USClQFY2o4q7tCe4EnFDWrMYSKgNGlCYWtDzl/pdoWlrFDjH3IifWw2CheAO+J+e6PcqOH2beuvIjyBhHtn6oOcudxzFeMFudZcY7vujc5UTFLTum1PciaRw0PUJ5ASXmSJxSg4KzWcmVA8svWFTvo3dyd9I4lIIYvqWist1mKe9G/PDwztvS5kcAf/n3THkPKW25+E+CEiZhEDSVZWCxYPmg7odUo29TyPmmXarTFdj4Q3YkQ0rfS9Ckz5nDOmIW2JzxOP92yTmiqa8XvIFvOGXhS5ytCUOTSHwGTfb4tXTj7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 23:47:19 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 23:47:19 +0000
Message-ID: <678c5d45-eb91-c000-76d6-7ed9341e52c3@intel.com>
Date:   Thu, 2 Feb 2023 15:47:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 07/18] x86/resctrl: Move CLOSID/RMID matching and
 setting to use helpers
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
 <20230113175459.14825-8-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230113175459.14825-8-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::27) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c1265d-82df-43ff-5bcc-08db0577d27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8x6geWsIdlg0dqnwleAo/6Lm6251p+7oRdEmpanp6+0m4BheWJlrygxTflE/R+pp3Ao2rNRQel4KHBPr+uzf0h9jnMFx02qFWwrvD6qSK7lJLbOKITrMkoJLTEFosQrqk9NuaJBgXc8RJPwKBtE3ipIwN4ae5nYCA8WpebWG9c34oUcG9j40+kLPT8CELEboidbLoRp58Cfm5guPsyJBiIpHDFmGLQbzjw+dDMLAIez/edPVpQyi7q5VEeOajfeWbw8aef/bPhXVLTzDZGSxTgl272ryL+9OEepVH5W2mTeis7xQ6BsWFs2lojQSAP3vVL1LpgsZ0hqXxBnxY92VlSdbZH/CR82rPXJFnUdSBS7kwyfbdHizMupLCfU3dCSc0J6/8YMMGilfD4Q4BnhBA2c7pL77LCE2ZuVtdWcNlVdmDP1dA+j/sIDq/CcaGuBhJ0pFxMAmdxpIDq+KGfyTzQApWG5y2E5XMwvHG+WMwygqXyndBdFPMFtEd3PwoKZMbvM8fhsEpNhhusWwYGKkDLhnsDrupkFBqW1Ygkc3OVcD17GL1a5AgYn43T57AFzQF7IDDWNciSpZpolvPsff8qTxH6FUS7qlnIlaqK52luvJLAZeuraUJzVc4Jam0iSDmaUCs/HLWF/uGBvqquIER5WbapKH3LqWMqbo0rx+enAdONwnwJYRJfprhjUBhSwXXpL4hKNg29ajnBnYABnQhkUzx7z2SVY9ob+k8ZS3GtA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(36756003)(86362001)(31696002)(316002)(82960400001)(41300700001)(66556008)(54906003)(26005)(478600001)(38100700002)(6506007)(6666004)(53546011)(2616005)(8936002)(6512007)(186003)(66946007)(8676002)(44832011)(4744005)(5660300002)(4326008)(2906002)(31686004)(7416002)(66476007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1pHQ0VjWXJWQjdwZ3FWY2JEWTAySDBZSitOd01DNXZDMWYvZGk3YkNlSzVP?=
 =?utf-8?B?YTNPVTZmZjBwc1lJZG5qWDdFcTZnc1ovcTJWRi9POFBsRWsydFdyR1ZYbEl6?=
 =?utf-8?B?djh6a3dmdkRSdU1rV0VHN1h0cHN2QkUvL1NRSEgxU3RYMStQR2NDRlloVENp?=
 =?utf-8?B?WmM1eTVLRVlRQW43VGJoM3JVV29nU3pNMHRtR0FLaXJXM05wbzIrRTJBMVZH?=
 =?utf-8?B?NlR3RDdpWXVxcXdtZ211Y3RsRm5qVytYS2ZtdEJxcXREVmdMZlpQZGZyMDNM?=
 =?utf-8?B?dU9UT0paTWp3YmtJREx0WWJxaENmM1B0UDdTMXRVT2JkZ1ZpTmE1cFVpa3d3?=
 =?utf-8?B?TW45eUEwQmRLWW9YNmZqZjNYb0ZrUGNnQTlGbENla3dIeUlpbjNkbS80WXJq?=
 =?utf-8?B?U1NLNlRVVjFhTkVOWlFqNU1RajZzaThHOW9tY21ZbjltaUFRaU5nNjVRWmNS?=
 =?utf-8?B?QmJQUm1QSWZselMyNnoyODkwc01qVm0zSzV4YjYzaXdYNHFmTVZWNEd4a0Zs?=
 =?utf-8?B?VXZvWTFKVTRaWDNNZUxQR3hKZGRraVQ3ZDhtM2gyanZKSjErcXo0SGJUeVRP?=
 =?utf-8?B?U09KZDBYUWh3bTFxWDJja0c5TlpETWtDTTd5WWRxa09DN0o1ZlIrUFR1cWdx?=
 =?utf-8?B?djhEeGZjdmNJUkRoK3dxZW8waVpuRUtWWVM1MUlJbnNuMEZGWHNkYzcwbnlt?=
 =?utf-8?B?T3pQV0dONDNCaXh6aUpsQUJiZlRmZTdoaDF0ZXg2WUFuOEY4enI2c3J3dlRL?=
 =?utf-8?B?UDBCcUtMaEZoNk5NM0dneUJNZk9VMTJaWW9TY0o1aDg0RFNlbWhPMG1VWG1t?=
 =?utf-8?B?b0NMbVN2SnFtZkE5dFZVTkoza2lzWE84Vnp0MG5lQUlxd0NKYUozUkQxOUxF?=
 =?utf-8?B?NGZFSzVLeFN1bzhTMTcwVkJiamNhUE9rMUE2WW9vV2VFblk3Y1NBNGd4VDM1?=
 =?utf-8?B?OEhzTFp3RCtBYjluS2dYVzVyL0ExMlEveWhWcEZMWmFPSDRuLytkNmF4ejdo?=
 =?utf-8?B?a21TNmM4ZWhOeWZPZ3I3MWFYRVF6Y2s2cmE3RkZ2QWR1aitKb3VWMmJxbTNS?=
 =?utf-8?B?Yk1uZU16Mkp1Z1Jya1NNMm1PKzJxR21FQnVjRGpsNXlXM0pEMERicG5Ldytz?=
 =?utf-8?B?R21BNVlvNWtsVGZ2QTVmZXFLRWFzN05NczYwZStIRzZVaU8rdG1iYjJJWWZI?=
 =?utf-8?B?MHRyMGhROHU1dDlTcGNiK2lKMVBtOWlrVmJFTUtOU25KcWs5YzlOL3JuYjNV?=
 =?utf-8?B?MjVMc3VxNC80SnkxWENlTFhFYWJMczRJOFNmL0gxSWt4a1NiWHRaR0QxcG81?=
 =?utf-8?B?TVlmMjNISTFoby8xU0dSZ3RpN2lNdHYyN056U1V3U0wwWHh3MWx2UXVHVlk1?=
 =?utf-8?B?MFE1TDRCWXJ6c1QybFRmdkVLOS9Qck9QZUhJN2xsUXp6VUl4YjUwSGtVNnph?=
 =?utf-8?B?NzY5TC9BSEdQY21xMk5mV0gvNnJrYzlzckJvQkNXYURjZlZXMmduZ3pUQVdw?=
 =?utf-8?B?M2U1NVRaZVBnQkRLMzNWQ3J0SnJTa1dQdnU4ekR6czVIYk1EUGMzMHo1bEFt?=
 =?utf-8?B?UzVReC9vL0JmU01DaEE0NVFueEhDOUlVWG9FN0ozUTN2QmRYZC9QV2E1a0Fl?=
 =?utf-8?B?V1NCWXMyVkRUUmwrNHRjY25zdm85S2V5TFlITHFwK1ZCeTdYZk9UREprNnZN?=
 =?utf-8?B?UmVHNklPbGFjTlVoWS9UNzVrdWJ2dmxoMkFwRXRSbDRLK1YxM2hhM2xmR3Y5?=
 =?utf-8?B?QjBVaHBtZG1BT0JiUjFUemNuaU4wUnlETFFic0J6b0lReDIyVk5OUElQVTdB?=
 =?utf-8?B?VW91c3RoK3hiZ1JRWnRubVRrNGtHVkR5NFNSWVNFdnV4UGRxalViMFFhRW13?=
 =?utf-8?B?UmtlRlVHeWovWjFETnJVRW1OMEU0MWpibTF3RnFpdkgyR1lQWFZtYWM5dEZG?=
 =?utf-8?B?K0Fyam5qSW5pN1FtMUFCRkEwYllWV1ViQnN2eGRDSmM5a0hzUmgxM0dvcUxW?=
 =?utf-8?B?MGlXaFRCa0RZdEdkQ2xxZjJ0bnJDQjBKNUZFNDdOaWMrYkZOaGdNN3FTd3Aw?=
 =?utf-8?B?V1lWWEF1OEFYZFEyeGFSK2dWVjZQbTF5RUZmSktaMDh5VVlIaU9iYi9FeE9K?=
 =?utf-8?B?MjR6b1RjMXVlT2FtM1c2dVdkZjBLN3RSMit1b0NlQkJ4VjBsSEkvd01tT1l4?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c1265d-82df-43ff-5bcc-08db0577d27f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:47:19.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96t0Cokg3tn6gO4fbIhWAPeOtflA6FkYVqMtjlxcsDr1hwK9x6FcXpdQ0XPbsNgNCq9oot6mgZOwspLBl6T+Rk8bFai5hvz5YnHgFuHhdxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 1/13/2023 9:54 AM, James Morse wrote:

...

> @@ -567,19 +579,14 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>  	 * For monitor groups, can move the tasks only from
>  	 * their parent CTRL group.
>  	 */
> -
> -	if (rdtgrp->type == RDTCTRL_GROUP) {
> -		WRITE_ONCE(tsk->closid, rdtgrp->closid);
> -		WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
> -	} else if (rdtgrp->type == RDTMON_GROUP) {
> -		if (rdtgrp->mon.parent->closid == tsk->closid) {
> -			WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
> -		} else {
> -			rdt_last_cmd_puts("Can't move task to different control group\n");
> -			return -EINVAL;
> -		}
> +	if (rdtgrp->type == RDTMON_GROUP &&
> +	    !resctrl_arch_match_closid(tsk, rdtgrp->mon.parent->closid)) {
> +		rdt_last_cmd_puts("Can't move task to different control group\n");
> +		return -EINVAL;
>  	}
>  
> +	resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid, rdtgrp->mon.rmid);

This does not use the intended closid when rdtgrp->type == RDTMON_GROUP.

Reinette
