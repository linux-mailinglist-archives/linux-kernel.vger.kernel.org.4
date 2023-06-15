Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866B37322B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjFOW0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbjFOW0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:26:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E751294D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686867958; x=1718403958;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JGnqCeWffuYGk7+efgSMEDFj2MbrqjEH+GFUmBit++I=;
  b=Vnh5+y5+5OMU5zrLRBpSJcKXg5TaxUY1XVV9ZEhUU0gRS/ACrs9Z0S/z
   +QsBRCMY+63eVMt5BW9tjPJGnCG+7X0gyr40Hzf2PuaOBY6yxAeni9bxX
   LIotILq3xNrF4SonaSLfpJYDCfF1iq6OCeKLoty/pZRlgi3byt4hflxhF
   UWXFaNGHlKvtabxaO1cF+yiB/zRVeqqdDXN1rZPaFkWYETWWC9lqUAhLV
   BnshTiyTKswl13b8CTB0wn4j7HD2AH81iqf+qJnjphTEhu1JVH9E3XiKs
   AyAecTL0cHX4a9fkQPQojb0/GZqBQHwwIMvoHz4haMNJP4hGwCT9Q5wQy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343795244"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343795244"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802582974"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="802582974"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 15:25:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:25:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:25:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:25:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkMwv+2gDPYDpzyGDPSEDV+Rz7uN62lQTrjwCVLAl/cD+b+fZNuJKtMPOHOH0HrBfkoQRaEXkMp7GjJ0Xznh2UQO17xZr7bEg88lSBacSSHTWV0qSikWgPmCdzDKtUrMxtWBki3zBUe7DI4Qldevhn5Pf3hcN0iW7aukoJ51quVAcaxmfCiadiThQHGwglvIl6n8RP6N/905ZiGfKcAr/0/GQ/OzHreZBH1A1OKtUgftKFqLkv8aIimrQa7xYMdyNfLBh6A8CPXFPL8ezFKw58P+DnOjnhr0W1jqVtWbxsVyJENtE3omNrcZ5EcYoSYG2d1rxD/CdnG1kH7N/pQwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vn3Emn/njlHuOQfpTchhxZ/anibL13WW96fN4VnP4M=;
 b=nXvffQCOMJfBrMygJwy0JJK5DidYf1HuMkblcjG6z+QiN8mNRekZLJU+7oIy5C1L81G1T00GMfzAdo34WcoX3c4WFFQL5+pbcXtsMm5K/P9cxIu+WH4WO7TQydOk2Oo4nrv3Xqt1S02RKdKS48HHpCeRQkthXxPABioTtjx/0w1n+SwFRohztB8GNCIuoG3N6GM+Yivm8DszaYGXV2L18Uf+dwIfuu8EAjdOvlVBZoacgFyzGPDzTQRadU3cg3mprEolFTf/ejvGMUvG0esTy4+/xewVTvevXT3kDpymX2jbpAbLw8m7F4OXDbqkzuFnSd9FnHoNEYo0Jq0tBUhpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5511.namprd11.prod.outlook.com (2603:10b6:208:317::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 22:25:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:25:52 +0000
Message-ID: <d4296dd5-a3ca-3319-8cf5-489d73195a2a@intel.com>
Date:   Thu, 15 Jun 2023 15:25:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 21/24] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
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
 <20230525180209.19497-22-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-22-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:303:b9::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5511:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c358b55-0c5a-424d-33bd-08db6def7aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZS+rk71vDFiYj9WMFSkprjzvwZe9iwSvhx+o2X4YUXIaWmrZhBuyfJQGkSumB7sTvVQHsuPL2uxg2ZuY9BhR0GGi7MTe3oACrIgPcwBBcY6L5fUxp1sxBUs1lkBlzrPHc4Ljbn+lfF1O8LtZjzAnSuRVoTav0cCJUZuBB8fxXvowb6n0YYpVugdW1JKbLPEFUM7pGxDl+FZGK6p9L3wQ+NoavBSZuTB1O4VGjbcl2yXpZd408KadLuhs5xLutqw1tw/T5CLbNaGKsfu5nU4DxtVBPCaFO3t75D5/o2DjBTXDe9UiBzr3uBC4mL/dU7poM2ITVmYF5bvy3cxzNFO4JANkXWijtBNdHvQfRPhgfT66mR6FaKTst9lUuJxC2RuuBiSy6JvUQCYZq4+PHhe8Y8bEDd7xMPXSLiiGoWZaCSzFA01FVH2umPwl1sf3T96GokLMs+RnzgS/g1hPoysqFAEo1gPhrmj/QLmd3WmzX9kIN2MatX/yqHKop4oTU7WCe7pkj/jg6XZCxj05Gw7TGLzLJE3H0WvJSXDr+ZXL5fjXdHlm0UyW9RoyC3zSrnbS7r8TI2ZI5jbnwuytvXLiyNEI8SqP7OA7csvfPjZHzlFI65E6hyFAHuht6Z2sSBRM9u1N30Kcn3vUlJrKXL/NZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(54906003)(31686004)(8676002)(41300700001)(86362001)(31696002)(66556008)(8936002)(6486002)(66946007)(66476007)(316002)(6666004)(36756003)(4326008)(478600001)(26005)(6512007)(7416002)(44832011)(5660300002)(83380400001)(6506007)(53546011)(2906002)(186003)(38100700002)(82960400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnEzQkNkbFpEb2xUZncvV01oYnJYUXRlTTVhejVnUUJtdDVZR2N6Kyt2NUx5?=
 =?utf-8?B?QWRxUkM5eVJSTlV3MWVSa2JvWTRJbG1LejgyeHBaZk1nMTBDbkVHYWtpOUl2?=
 =?utf-8?B?dFFyRGJ0QU9vZVZGLzAxVnRNdlBVSGhCWjR4ZWxoaTF0bGhCdDIxd0lOUFNU?=
 =?utf-8?B?c2dQSkxmTzB5a1NhOUw0QjB5OG9ROHFONUJGdkFNcGZMRzg0WVQrclNxT3U4?=
 =?utf-8?B?ZjdIejV0ZXdwUG9WaUZFTjRFUGw2Q1IwdjJuVUtheE9Cek4zaGNIQi9LdzYy?=
 =?utf-8?B?ZlVVMjVXZDN5L0tGZ1VMT3JZU2dNditzYUNZM0NCbUgzNjJQbjJmbEkyS1RT?=
 =?utf-8?B?aW51dTBici9iUElKNFVCSWZKd2laaU81L3dwNTErY21kRmhwM2VoakRWRHVx?=
 =?utf-8?B?dUROT1NqZW9ZeUppWk56d2FETlcyeWhtTlBsVUxsY09GNGlhZy8rTFhLcFcr?=
 =?utf-8?B?a2hMdkdvdzJBNUszSGRINVR3ckd0eS9EdlY0SWE0dDZ0RXc2RVpyWHh1VjU3?=
 =?utf-8?B?ak9yUk1WaTcxVU5wWU4zcncrSm5NbHE3ekZlMzhvcnp0bkxFcGlPaGd6U1N4?=
 =?utf-8?B?K2lyVkdySDRBMGpaVXlvL3lnYTJmU0JtMUg2MWtYTmIzeVZQWHl6YkRIeC95?=
 =?utf-8?B?emdYOERMNmw2WHBIdEdqemJHOXhEektSS2Y2R3FSQ0NRMzVjbzNNMEowa2VI?=
 =?utf-8?B?NnpkcTh0QU90R24wdTJ5QTNwd2NxaWMrRVJkb2hkM05aS2JPbk9nUndaYlNY?=
 =?utf-8?B?WU9sWjlCczFNK1BOWFFHV1dGZ2pMWmFONFNlcDhyTnVxZGxqa2Y4OXUyUTNl?=
 =?utf-8?B?TVF2bnp3SmpEUE1yUzFYOTEzYk9rU2FQWGJNOTEyU1Y4WEhYMGFQSFdaK3Vl?=
 =?utf-8?B?UllsU2ZjdzJnL3BJQkZoV05ZMHlsN1NTSEtWMnVsaTZyUHdsS1NMVzc0eVBz?=
 =?utf-8?B?OUsrNGk3VlNkRG9oa3AveTJLNjBsRXBTYS9ucm93dkh0aEk2NEpsdFhRSVFW?=
 =?utf-8?B?RlVoUFZIT1d0OWZhczJiL05MVXN5NVJEZE9wRmZZTW9jNSt0NktUZjlFbVBr?=
 =?utf-8?B?aWJsVFNUelpEemlab2t4QW5vUEsyZVo5alh2anhwNGsvTkJhWTM3cU5pR0s2?=
 =?utf-8?B?cUtTaVpKZi9aOHVuRVordzU2eFdzZ25hZWIvVmJCRmlWK25PK2Y5NitWdTVQ?=
 =?utf-8?B?UWFBckV0TXRqR2ZxR3FtTHB4akF6T2VGMkNSaGZCcXZnakIzTGJ4Y0RhNnpC?=
 =?utf-8?B?ajlhazBvOW9kVUdzekYxbVdiejc2MURyVHIvdkxXcXJYU25FVnlGa1VGa1RC?=
 =?utf-8?B?T2crU2xkbWZpQjJmTndtRTA4aFpFRStyNktGYVl6UEhRNWxoMXMwbU9adTJE?=
 =?utf-8?B?UVdGZzBHbEY4VEJab0JOTkxwNmFiYUFwUU1qdzBSZGRDMkdYKy9hZDJJR204?=
 =?utf-8?B?bkNDUlA4OUIxUFBkenF2UEZKeFhQSnZDd3hLejFmNVAvekZmWDJDK3p5SlQx?=
 =?utf-8?B?Y0x0ZUk5VE02cXpVVUJWOUNwblhCVVVnaVpzcEk4d25zNHAwNGtXZDVWY0U3?=
 =?utf-8?B?U2poN0NqL05kUmYxZzM4bEk0dTZPcGxKajdGMHRRWjk5bzVsTXVTT1JZczJR?=
 =?utf-8?B?ZTBCQzBYbHpHQkVlVVRXWG00S0ptSjA2VjRocGRFbXlsR0RxckJlYTYycGhO?=
 =?utf-8?B?bnl5elFKWkI5dTQ4azdJVmpUdjZBTjQrZC80a25SYUtLN1o4aElWQk9sNEcw?=
 =?utf-8?B?QTZlb1d4QjhvMW05RXd0d3Q5VThHaWNoVkUxUi9SdjRwTzFVb0l3b0pRSGY3?=
 =?utf-8?B?MU1LQ09xNU90VUdPWU9MM0QzTkJGd0JxVEZSc3RmNXRhNVVDVTRjVWM4OWgv?=
 =?utf-8?B?eEZLYzlBMUx6ZXRJVlFSMjZJS2NOckZWd0c1RjVteGcyOUZuS1pVcXJyNDFZ?=
 =?utf-8?B?U0FQUG9EbGJLUVJtWHVUOG8vVTZBZVhCR0xTWFFFWjlURzFxOU15ek5Md1I2?=
 =?utf-8?B?YXhIdjZlM085dkNNbUhENlBpTTRaU25vOVpTTnRXRXl1UTZEUFdaUXcwS1JB?=
 =?utf-8?B?VU5zcTUza3FZYXhmb2ltcDJYdDhjbG5GaXV1U0ZVek1QNG1jM3BxUnUzTWFh?=
 =?utf-8?B?R1FlWllkRW1Fb202S05BSmRqdHdsR3lSeEFWWXM1V1V0NW9FWGdQL3BPVlI5?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c358b55-0c5a-424d-33bd-08db6def7aa9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:25:52.7120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imPZpJqFwnizlrxXHEPWSlVoOInhkTNzUuUJSNppC/bpr1iFxpgum69Yw/JYc0+UV6We9oxaUzKszMZt2Pop9W2vHGyrkoPkIA7NvYgOv9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5511
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/25/2023 11:02 AM, James Morse wrote:

...

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 021a8956518c..9cba8fc405b9 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -79,6 +79,37 @@ static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
>  	return cpu;
>  }
>  
> +/**
> + * cpumask_any_housekeeping_but() - Chose any cpu in @mask, preferring those
> + *			            that aren't marked nohz_full, excluding
> + *				    the provided CPU
> + * @mask:	The mask to pick a CPU from.
> + * @exclude_cpu:The CPU to avoid picking.
> + *
> + * Returns a CPU from @mask, but not @but. If there are housekeeping CPUs that

"but not @exclude_cpu"

> + * don't use nohz_full, these are preferred.
> + * Returns >= nr_cpu_ids if no CPUs are available.
> + */
> +static inline unsigned int
> +cpumask_any_housekeeping_but(const struct cpumask *mask, int exclude_cpu)
> +{
> +	int cpu, hk_cpu;

Should these be unsigned int?

> +
> +	cpu = cpumask_any_but(mask, exclude_cpu);
> +	if (tick_nohz_full_cpu(cpu)) {
> +		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
> +		if  (hk_cpu == exclude_cpu) {
> +			hk_cpu = cpumask_nth_andnot(1, mask,
> +						    tick_nohz_full_mask);
> +		}
> +

These braces are not necessary. If they are added to help readability then
perhaps the indentation can be reduced by using an earlier:

	if (!tick_nohz_full_cpu(cpu))
		return cpu;


> +		if (hk_cpu < nr_cpu_ids)
> +			cpu = hk_cpu;
> +	}
> +
> +	return cpu;
> +}
> +
>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
>  	bool				enable_cdpl2;
> @@ -564,11 +595,13 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>  		    int evtid, int first);
>  void mbm_setup_overflow_handler(struct rdt_domain *dom,
> -				unsigned long delay_ms);
> +				unsigned long delay_ms,
> +				int exclude_cpu);
>  void mbm_handle_overflow(struct work_struct *work);
>  void __init intel_rdt_mbm_apply_quirk(void);
>  bool is_mba_sc(struct rdt_resource *r);
> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +			     int exclude_cpu);
>  void cqm_handle_limbo(struct work_struct *work);
>  bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
>  void __check_limbo(struct rdt_domain *d, bool force_free);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index ced933694f60..ae02185f3354 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -485,7 +485,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  		 * setup up the limbo worker.
>  		 */
>  		if (!has_busy_rmid(r, d))
> -			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
> +			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL, -1);

Should this -1 be RESCTRL_PICK_ANY_CPU?

>  		set_bit(idx, d->rmid_busy_llc);
>  		entry->busy++;
>  	}
> @@ -810,15 +810,28 @@ void cqm_handle_limbo(struct work_struct *work)
>  	mutex_unlock(&rdtgroup_mutex);
>  }
>  
> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
> +/**
> + * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
> + *                             domain.
> + * @delay_ms:      How far in the future the handler should run.
> + * @exclude_cpu:   Which CPU the handler should not run on, -1 to pick any CPU.

Should -1 be RESCTRL_PICK_ANY_CPU? 

> + */
> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +			     int exclude_cpu)
>  {
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
>  
> -	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
> -	dom->cqm_work_cpu = cpu;
> +	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
> +		cpu = cpumask_any_housekeeping(&dom->cpu_mask);
> +	else
> +		cpu = cpumask_any_housekeeping_but(&dom->cpu_mask,
> +						   exclude_cpu);
>  
> -	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> +	if (cpu < nr_cpu_ids) {
> +		dom->cqm_work_cpu = cpu;

Should cqm_work_cpu not perhaps be set to nr_cpu_ids on failure? If it keeps
pointing to CPU that ran worker previously there may be unexpected behavior. 

Note the different behavior between cqm_setup_limbo_handler() and
mbm_setup_overflow_handler() in this regard.

> +		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> +	}
>  }
>  
>  void mbm_handle_overflow(struct work_struct *work)
> @@ -864,7 +877,14 @@ void mbm_handle_overflow(struct work_struct *work)
>  	mutex_unlock(&rdtgroup_mutex);
>  }
>  
> -void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
> +/**
> + * mbm_setup_overflow_handler() - Schedule the overflow handler to run for this
> + *                                domain.
> + * @delay_ms:      How far in the future the handler should run.
> + * @exclude_cpu:   Which CPU the handler should not run on, -1 to pick any CPU.

RESCTRL_PICK_ANY_CPU?

> + */
> +void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +				int exclude_cpu)
>  {
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
> @@ -875,9 +895,15 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  	 */
>  	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>  		return;
> -	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
> +	if (exclude_cpu == -1)

same

> +		cpu = cpumask_any_housekeeping(&dom->cpu_mask);
> +	else
> +		cpu = cpumask_any_housekeeping_but(&dom->cpu_mask,
> +						   exclude_cpu);
>  	dom->mbm_work_cpu = cpu;
> -	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
> +
> +	if (cpu < nr_cpu_ids)
> +		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
>  }
>  

...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index ecd41762d61a..089b91133e5e 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -9,6 +9,9 @@
>  /* CLOSID value used by the default control group */
>  #define RESCTRL_RESERVED_CLOSID		0
>  
> +/* Indicates no CPU needs to be excluded */

This comment seems to just be a rewrite of the macro name.

> +#define RESCTRL_PICK_ANY_CPU		-1
> +
>  #ifdef CONFIG_PROC_CPU_RESCTRL
>  
>  int proc_resctrl_show(struct seq_file *m,

Reinette
