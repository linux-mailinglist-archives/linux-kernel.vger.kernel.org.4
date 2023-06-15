Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61936732282
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbjFOWKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbjFOWKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:10:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE22272D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686867023; x=1718403023;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ywH0QhqXggJH57v0mg6YfXTwtwhmkwHkol41ug6hcvw=;
  b=EhG0XApRCIUwAebqs/fFJ6UY+OgQ8MkT6+P5fxGZdkOERw8aypo4q0pN
   m1YN1JZ+gdeMUhPHUTm+qb8nknCnXFt/opPs/0cB4Q3FJQkHsjDyxIWUr
   q7st6BoXZO4yrw0fzgtDekgasE0zv2x+yHpAtsMsxXANwV3hpFb2j663U
   0H8RsVS6KXOdkwQsPGG1DUDHVvDoVOAXSgMvGuet5en6LHaQQpTDaT3o5
   LgkFJUCKQ4jYu1f1TNrwrdF0D/guNXvXo8mKin81dX/HH5ucd085702+B
   24MJkgznucC2B+0cyS3l241U2EcJNj46fxo9UY47C33+kqp+dtR96mUMr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356542892"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356542892"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:10:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="836787890"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="836787890"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 15 Jun 2023 15:10:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:10:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:10:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:10:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhbeMl/U0ow4JEgMe7krffLeTh6G+7zw8iXjYuZ3MCjUdPZ/n1SAQvofcjMRkaAHHMaFKDAJ5N3yfRY/RT4OCpOAbv4OdQABT2XsbXEmPvPdOnKJ6ngLIST9LnLTiBHb0pY1235PKFj07ppbZvN2OMdOEWskJWS0e+JGuWyRqjGpYwKWdUE1oXpFIZtySZvj4oqJ4RljuP143rws3PvEEjhFQKdYn7hX3dRHL2X8gCY4PlOYwDh9oUnGdHsFhcjYViaIWw2jO/9npYHbMH0FjNOXRYVKKHh5Sgp4V5ZJvUAIIqNgVfp8HoUSp4hWi78Rrmw3QwoeOCICnxqpZVGYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATNPE8oypocihPvDOZXEvZEPToDtMHuH+aPgz2LsA9c=;
 b=EphpjEsIBU2jF8KZZmfC8+fMo4k7EV7d5UarwYP7YHcNnYIDs27RSqkOS9JGVXJCgDxJQdZaBD6otSQ8zikHRB/lYKOe6RgRU8f9Nei4oDzCWvsiUp3hJNCNyt+Dv8B1aFTkbmIBRTWYqjYTr9xI2atUkVMyoPFg+ZBjL2uovBW2BtR1eDwlwtCDpRUqPGtZAXvdCoIlOCbr7KG1Q5o5ILFcSHr/Z+lIaUgxXRBASkI79evY+Lp8rt10hWe9dzzwy5cQUhGXotjcDAcPHdE/Az4q1rEEEYYVXVrZaA44TxTlzuCi/MGeiLBeqW3Fewkig0PGguZjKOT85GsOV8JUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB8204.namprd11.prod.outlook.com (2603:10b6:8:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 22:10:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:10:11 +0000
Message-ID: <5dab0967-8236-534c-a2c4-13cda9cc7150@intel.com>
Date:   Thu, 15 Jun 2023 15:10:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 11/24] x86/resctrl: Add cpumask_any_housekeeping() for
 limbo/overflow
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
 <20230525180209.19497-12-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-12-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::37) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 28177382-66db-42b4-19bd-08db6ded4961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6K9qr8B56wBzJbCzJFYh5Bup6dNL1AmvC1ByvruZHpTKJWGRjjcSZdfkk+jYV1X352VqSUP10OFH094hBpKCsnSXSUTq4RUqr/B0RuseEwSpBT0jDbnLUfsxDu4wiVBJ7IhSu779RICTjj/fXQiy1AEzIEFB5KVvqJrpBBoYgZEMT3CD9B7qzpBijbCYdrzZM6JrMrvHGnaVGNcqJblnRtJOFCzfynLiFPHv8TPOvrWVcKNpf9CNn3l7XJqHukQ+qTsWiTITqfzBRuN68FmOiZjn9TJyZOiJ7zq0EGaySlfYSmMf0RCTHl544HTiiItF0wSNALObJAYhjcsDAzYTI9wZbb947ofzvIGJhTDZI196GSts582+0h96mzrn3ndxKOFxkk2qcqbac2qCURPkm0q6u8+1Ryecn+NBZ6Hy21FrGoMwez9QdukmOaXDTAUeGuLz/mW6xEPMUCchVs3oKRgsWUiWkOxJ+OG43y3D502m9YgD34PqKh5OXvCTdT5bIgwPhxhlw0enDJtSgCwo0C7hToEsc+POZ9GOsa5ZisOGjSLC3u2hwbj6s9RIWf8MtaCx3JcuZ2Ms14OmlB0UY1bAkIbes6ZqWo8Igu/q5tmhgj9zeqp0s/1Ys2eq1S7zXkJUPoa2C8FPACe2qT/Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(8676002)(8936002)(83380400001)(2906002)(5660300002)(316002)(66556008)(82960400001)(66946007)(31686004)(4326008)(66476007)(38100700002)(54906003)(41300700001)(2616005)(36756003)(478600001)(186003)(53546011)(6512007)(26005)(7416002)(6506007)(6486002)(44832011)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHMzM3RCdU1OZUhVQmxEaHRvVlc4NDl4b0FPRk93eEZHNTU1bm96WXIzV0ZJ?=
 =?utf-8?B?dGlRMEdFVGg2clcrMG9iNkZSSndMSlBLL0ZSTlNGTVNnMHN3anhtN3g4R2xM?=
 =?utf-8?B?cTdpQjJFMjVvd0NJRFIrRmJ2QjM1S2tLemE1WXVHNlBOYW9zU1V3ODdxYXk5?=
 =?utf-8?B?UnRkNWpUTGdvZ0pYTVRUOFIwUkV3L0xrSzVHZk5MMzhBUVFQeXlVbzlnajBu?=
 =?utf-8?B?NnMxR3FicjRFdlFrbTlKUEczVTFoS3RWZVU2eTlyMkVkbjM2TSs1dy9VUElo?=
 =?utf-8?B?QUdaUVR0VnpwdTNHNDV3WThZWnNMSlQ0T1p2K1IyYklXL2JiRGJMd2Q2OE1K?=
 =?utf-8?B?YVYwTnhYZHdYOG1GNFhIelRaNE9wbkg3dW5mSGFqQy93ZmlqOFRKcnhBdU93?=
 =?utf-8?B?V1JYRjVLck9NNzNIQUd1MVIwZmRvUXVJeXdiY1JTWnpLb1c2S3MwZUJvNFNO?=
 =?utf-8?B?TGg4K0dXQmpGUGk0YUpoUjZucStNRGVGZFhzNWFLU202S3RLL29SZVBOMHFJ?=
 =?utf-8?B?YXYxQ3ZZRTl2aHJSV1plYmpMb2MvT0ZIckRYNUhZWWo5anE4OVNqT1AxT0xP?=
 =?utf-8?B?d1RHTGhsbFpuNnhpWk9rWmE2bHh5a0pqaWlPbUhONmxIRExuZ3YwUXlNZjZW?=
 =?utf-8?B?azU3UXJHTUpvaHBQWFRLTlpSbGpkRjNaWlNWLy9TMlhySGl2SzQ0eUxVQWNI?=
 =?utf-8?B?ZWlVOEpOS1FiTGlBelN2T0U3d3FKYXpna1lTZjMxbmtZYWNTZDB3SHUzQzZG?=
 =?utf-8?B?Y3JGdmlsUWFxaWRlMll6dmdzTXJPNVBaZGplN3prZXVHSXljQ3hsZWVFWUNz?=
 =?utf-8?B?OW1WSkZlZi9wUWp3UlRWL1hmemVzcXhYeUwvRWgxdWdWOUdzRks0S2wyQ1Nl?=
 =?utf-8?B?cWE5bDNCN2xXR1JqRUs0akxMcVBtRVhqRm1OKzFGbGhnMUJ3Z3hEdmc5OWhz?=
 =?utf-8?B?TlFhU3pWZUJ1Y2tFZDA1bFFPRnNjS3NJL3EwK1QvUlhCMlYyeTlBUG40cnNp?=
 =?utf-8?B?cWtkenZBellkUGlUUTJySW5hRWxQMi9xc2ZGTFZNeGc4M3VSdHZieHQ4TzR1?=
 =?utf-8?B?VU5mblMvTFJXcUZYM0twM2VUc0ZOV1d3M0xvZnVFNkROSEhEb280UGJvcmtQ?=
 =?utf-8?B?NG81eWVqVHFsYTkvYjJKVHdCVVVlUXRvWFJRUHdtSDNGZVB2K2g3L2djUWY0?=
 =?utf-8?B?am85bFU0V1pUcUJLVDZKUWFIRjUvcW5PUlROT1kzc2huZkNtdjdya01GZkZH?=
 =?utf-8?B?ZnlEYjRSSnJkVi95RFhVdWg3TmdWay91c1crVXdvMU51MEN3MWZ0YXlJRFhn?=
 =?utf-8?B?RGo1S3hSa0FOTXJZUkFvRE9oc0NFNkRVZkRhTjJwYkwybGllc2RjaFYxS2ty?=
 =?utf-8?B?emlmTTdha3VxQytoa3g3ZVdML1hnVVNKR0F0cmNMMXpXb3hzZ0xoWlBwRVBQ?=
 =?utf-8?B?ZEtSS3dZbW1tdWdBbDY3OFdlZWVBN0c4aFpCcTBqZWkxL1p2VjVFL3pkUC9i?=
 =?utf-8?B?ZFhISGpGeHNQZkxtTjY5dVp1MlEwRWFCanBnZ09hNzUvandEQnFSK24xSFNm?=
 =?utf-8?B?dDdQaXRGS3lDTDhYbkhvMWVzYk8wMm5pekVYYWUzSW9FSnpId3hxSS9MT0FL?=
 =?utf-8?B?ZTBGRC9qcUdIM2JIT2lxQ3FGYVFWalJ1dC9yQWxQQjlnOEZIY0VUMW1nQjgw?=
 =?utf-8?B?dWZyZG5seWhDd0NsVkgxVXNKRFcxQ2c2Uk1jY2lSbXF2Z2JncmVWZ1pKMS9n?=
 =?utf-8?B?djdvd0dYRFQ0Y2JITWcxdzZ1VENFZXB3NWE3VmtNWVRkM2I0bXJPcFdTU0tY?=
 =?utf-8?B?QmRnUVdoRlpON2tSajFNUTBrV0xOUkpTRjYwaDQxZ2ZrQnlpVFJMZHhBUk1h?=
 =?utf-8?B?NzRpaEM0Y3N3anMzSVFxcjdOQVZpaG1vZVBBWjJTZ3lsSjA2MjN1N1FNY05Y?=
 =?utf-8?B?Y2xBZndUbitvNkNqbmp5b3l2eXdrUFpoYVBGbjd4TWs0ZVdYYnBzc3ZhUnFm?=
 =?utf-8?B?YTdsQlhPa1JTQ1VwT3VpS0NnemtTL2VTYU15MGdiUExLbTVUZCtxWnB2REIz?=
 =?utf-8?B?dUJnb2E3ZnVHZmxHVFZNV2pYUE1oanZYU05aUWtlRkdzd2YvN1JIUnBFRlRI?=
 =?utf-8?B?NlZzdVp1OC9QK0dKWmtwUlhIcjRiSTRqSmZQRGNkdmJXTkFYWTVsRG13Q2o0?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28177382-66db-42b4-19bd-08db6ded4961
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:10:11.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LpZ7DKpM0G15bumZ0SMOthu+PjZDrjaGSqrDHrJpqxftk5ppeJht0Hqzh6E6+x5z8ZwjbEr+Arv7hdT2yuKsqWaA/WtHQlSUQyXCiehiLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8204
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

> @@ -55,6 +56,28 @@
>  /* Max event bits supported */
>  #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>  
> +/**
> + * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
> + *			        aren't marked nohz_full
> + * @mask:	The mask to pick a CPU from.
> + *
> + * Returns a CPU in @mask. If there are housekeeping CPUs that don't use
> + * nohz_full, these are preferred.
> + */
> +static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
> +{
> +	int cpu, hk_cpu;

Should both of these be unsigned int?

> +
> +	cpu = cpumask_any(mask);
> +	if (tick_nohz_full_cpu(cpu)) {
> +		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
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
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 128d4c7206e4..e267869d60d5 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -770,9 +770,9 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
>  void cqm_handle_limbo(struct work_struct *work)
>  {
>  	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
> -	int cpu = smp_processor_id();
>  	struct rdt_resource *r;
>  	struct rdt_domain *d;
> +	int cpu;
>  
>  	mutex_lock(&rdtgroup_mutex);
>  
> @@ -781,8 +781,10 @@ void cqm_handle_limbo(struct work_struct *work)
>  
>  	__check_limbo(d, false);
>  
> -	if (has_busy_rmid(r, d))
> +	if (has_busy_rmid(r, d)) {
> +		cpu = cpumask_any_housekeeping(&d->cpu_mask);
>  		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);

I expected cqm_work_cpu to also change when the worker moves to a different CPU.

> +	}
>  
>  	mutex_unlock(&rdtgroup_mutex);
>  }
> @@ -792,7 +794,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
>  
> -	cpu = cpumask_any(&dom->cpu_mask);
> +	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>  	dom->cqm_work_cpu = cpu;
>  
>  	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> @@ -802,10 +804,10 @@ void mbm_handle_overflow(struct work_struct *work)
>  {
>  	unsigned long delay = msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
>  	struct rdtgroup *prgrp, *crgrp;
> -	int cpu = smp_processor_id();
>  	struct list_head *head;
>  	struct rdt_resource *r;
>  	struct rdt_domain *d;
> +	int cpu;
>  
>  	mutex_lock(&rdtgroup_mutex);
>  
> @@ -826,6 +828,11 @@ void mbm_handle_overflow(struct work_struct *work)
>  			update_mba_bw(prgrp, d);
>  	}
>  
> +	/*
> +	 * Re-check for housekeeping CPUs. This allows the overflow handler to
> +	 * move off a nohz_full CPU quickly.
> +	 */
> +	cpu = cpumask_any_housekeeping(&d->cpu_mask);
>  	schedule_delayed_work_on(cpu, &d->mbm_over, delay);

Here I expected mbm_work_cpu to change if the worker moves to a different CPU. 

>  
>  out_unlock:
> @@ -839,7 +846,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  
>  	if (!static_branch_likely(&rdt_mon_enable_key))
>  		return;
> -	cpu = cpumask_any(&dom->cpu_mask);
> +	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>  	dom->mbm_work_cpu = cpu;
>  	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
>  }

Reinette
