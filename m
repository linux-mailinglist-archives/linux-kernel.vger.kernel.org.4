Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F02606EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJUEDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJUEDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:03:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA511C8D45
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666325017; x=1697861017;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3A99cpJ/+D2+Q/6eMaIwpihRfRpNY3qPVwbcXYy2KNw=;
  b=R/hwOlPA4GVlxsp1STEaUaamBjB1xdvbwUKXu6N1mQH3CD0wqq7vkOUg
   0aPDCluagpKbAjC7AezNiWHmE88jlB3TKCgZ7h6ajIKSipABCm2gaAxJb
   lrmBKw7z0IcOGy1AsPeRCdGe4qtmqYYbPveK+wwcPiicYPYP34dEAxvAA
   x6svdtHbXnopfBBEht98MpNsPCnfi7KqmNYFtJ5aoSY2VGYDz/2OCl9BW
   8k8u+0ELGIA2aKQjyBdKhn12JqxMyVYxzyyqeAN7g23/hQtPUCgc3IGKr
   6y5ps5SF8hDicMWlR0LK12zTz/saJhNVF9uZa2hmxki36aD62r80NvDdA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="308002576"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="308002576"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 21:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="693445245"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="693445245"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 20 Oct 2022 21:03:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 21:03:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 21:03:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 21:03:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwWiwIsyAEou1uArw+cOrUx95dg1TKyO1HZlu/OPKtQ+ieNfsgfDT6C+WyHxUheklcUYuyDRbK3htGqbjuNm2W0GhNVX6U4Jzz95UULOYXKhoWHjvHRTasC9yfQx59vNDk3I4x0o4fvBf/1Yw/HrWgsgbgfrtxvrT51VcrVmKf2FCwM7FgeUp3++mOuJ0qDGZCcU+1fG1KQ9rwkdUE2Uv0Iqvd/5oSaipUYLDAX12FpuI8dwmoE6yjiExCNH+A1+yUeYyiZecfQGk7KsMwBv9oZHqBaPHT1JqZke4eUCqOOPgEiJ9HIJnG5ZlMErUHfldtELJtxgZgOKUybp9U1ufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47JewXefYJvvCfgXbjWTzi6+LOxlpzFw30kdp1LHnIc=;
 b=PjZiEcMKirR3jwPEDpgIoMaWWfcx86QY2yLwb3PUbULi1KQfGFfUbSeheF/DRtp3M1U1INvIaRHTfIxPZ+Pee0Vrv6ZaV6QAWEgu9shJVmIWRHsgKbFCB/zFe9aCFojPTqVsJjmpnPf+AeUwmzc553YdYvoDycXcDc1uX+IEfPzvNkMOxq2g/cZTFP4GQEKFs9CVyOyzSbOhgK0JAW9Ir5uI32iSAogfLagO9fvaazkkaxPiY61i52DhlvEAF5jOFZQWhZboHgkjbmLmmSPgtMG/RhobN0igj0nR8WIpPTMVb5n2WyNYgTe1L1QNhDZI2tmiES7e8aRkZl5jJyrkNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB5582.namprd11.prod.outlook.com (2603:10b6:a03:3aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 21 Oct
 2022 04:03:28 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43%3]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 04:03:28 +0000
Date:   Fri, 21 Oct 2022 12:03:08 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, "Mel Gorman" <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] sched/fair: Introduce SIS_CORE
Message-ID: <Y1IZ/DZ1SWMn0QDs@chenyu5-mobl1>
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
 <20221019122859.18399-4-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221019122859.18399-4-wuyun.abel@bytedance.com>
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: 65018fd9-08a9-4e94-93eb-08dab31935dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vB1us29jMbBW7V68RojhSvLHh+PH+xZjwMkhb4Bc0TblT6hrXEJme/06MUFuJW1gDSCiY4ijufS2/17HLSJPjtWVumwmEYj1b4YyTrUtjPDrppeY5zSZP+c9DMfJ7INuTCrhv1awg1sK4UnfXDaN48Ab187sUB5U4ogDmLTd8u/ZL0UzyvJwLwZqLDgeJP2Ldo2cNtqsl517CqkfHDwEBkIywgoojZmf4qr+uT0rtmpCTO3DIHf43DgY8E/+b1mk5/a07JMGM+/WMJImghLDOaC0DkL/pzpMt6x13fH7LyFxKqxEy1hAtncgaordc3+pgbbWZUEl/asXQaZy5+p/Zr2wvsOdpAJXREM64ZdZTeiLsvb1bNAr5zdNO3yDCEAJ/CQp7ApMTaOf8GHDmyU0ErgU12mekUX6MhpOakuLZT/dXn7g8g+FU1+JMDQsvybh1NLHOdqGEQy5U/gXiS4pYQ/rnV9SMeYIx+ButvEF0OQzG6AW823XdI+e0bm7sGaEcOckxPX8bWzBaL2w0JpRR1THg9pM1lPcPWT5gNUkjdFDCw3LLkFB06Bpvyw7pkQZcqgli7yaDDK6CalWZys/FXzo9FgKfu95mjv3E5va+G+NxVFs44nQzvn94K8ia5TqGs3fZLg/j6YQ8nLgk6jWcbvrdJVcHgZGF11NzSJh+8JEShY2+DCUd/6fYJefE4Ir59sVg4LiLzXOonuvf9wslQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(41300700001)(6486002)(83380400001)(82960400001)(7416002)(5660300002)(86362001)(2906002)(186003)(4001150100001)(8936002)(8676002)(6916009)(53546011)(26005)(6506007)(6512007)(316002)(66946007)(6666004)(38100700002)(4326008)(9686003)(66556008)(33716001)(66476007)(54906003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yWhbgah2FochbUiPbc2cuOUEQMT9SV9s32kLyg+LMPB2b8PaPkdj7GtzT6vh?=
 =?us-ascii?Q?DRb1MCj0w9TzNCQAIz3SHbW7flr0a0/o12HqGQVMaxzFmBa88CDLiJBQ5jhy?=
 =?us-ascii?Q?Ep7+VBWXpFWp5GnOtMLMm0IxQRep1TVt5+EOaojVhceMWdns9jWHIvq/YrpW?=
 =?us-ascii?Q?odOND7i7qrtKTC/Ujt0aa9k8kd3enmF7LOyQEraq2AMj7kyDq7wjU+hIuEG6?=
 =?us-ascii?Q?xe+b8Q5lCE+T/7gEVoX8Vqht9osgd/eC2vZ7TbpdGHz9EfQbfkedFmQdL+ZQ?=
 =?us-ascii?Q?sMjSwtsWb/UWw38RUX93Vbny1d4A7slb4zVuJW2OGd3v1i7fDc0XyjZF1l1c?=
 =?us-ascii?Q?8qnNLGonEg/7T7+PDCmq6TVnzGQUPjgyPWfVAuM8GOgvT6i2tfkveXlRglId?=
 =?us-ascii?Q?EmdShFFvQpzfhiNdsCQ8A4sJsAfdMB2+cWjAm9frBGB84KAdXWj6JPPrC31p?=
 =?us-ascii?Q?nRvoqmc7DVHQacfU716ZBcpgD3NwcwccLfoXo9RXPRyDdShRufHlJ7inHl88?=
 =?us-ascii?Q?HvpA1j3FSWKD/G+dgfFGFYVP1myTpZx1AG5VaJGYhVGfaXtZJ3FyV9TXTu0T?=
 =?us-ascii?Q?6QKwpUtYuca8euRMt6tXbtKcDDSCeq7RPoCSMzUVksQkhxO312BbKCk3ncfo?=
 =?us-ascii?Q?YWzHogmm8AGP7VQaeWZppZmRSdQS8TlR+V5rfCdTF7a87K1Mjr1FSZZTY6Q6?=
 =?us-ascii?Q?9gpFmKlTyS9j0GhnCvk0SSKUAfCqSz0tR2RLiVdSuYJPDlv92M30D9pxvRvq?=
 =?us-ascii?Q?cCmlplGL7gw85+mtvSUR+C9bb0hOdZzNS4FlFgLOfsat1CoeTg584T4hsy67?=
 =?us-ascii?Q?Yp9OMIYRV7LJdvPmoFYmCWJCPEvA+KdPUqkT4heMXtyE41DLcOY9+BXtHllA?=
 =?us-ascii?Q?i3IWhEA/l5mjVJqeDjs93w+dvc3etZaub6jFW+p6qYxE/Q8vJI15yQhqsfZZ?=
 =?us-ascii?Q?hU9LzzKVboosUI1d+VCiD4lckDo78FrPeODbgRCqBnx/W1GfAACo0iToFsbB?=
 =?us-ascii?Q?1hkVGgFAnYyNs+jbLSNDIkJuJi6azMOJgz3t7BJHQW8o9BrL0IlXlAEo9KYJ?=
 =?us-ascii?Q?vtc9dZ8/p9eLyb/1Os9mJK2Xq6jQJDTZ98UdF2mH3bBeoSP322hobF0rKixz?=
 =?us-ascii?Q?N+L9ELLuDlbDd1E/mqISQS9bJ3JYfHwaiq5Ptz+hKVdDRsWqaQjQSAyCl8ll?=
 =?us-ascii?Q?QsmfgdETclU+n9vbAa/O81pBlI4R3mbAMI/8cF/kAxS6kg3qHwo2cBjGFayo?=
 =?us-ascii?Q?HLrBDYm27oriygNnqUuNMj5fLs0mbWAbABcgIDOFl7Rm9mOezAuMBEyuYHcB?=
 =?us-ascii?Q?Sy7YkzpbUWuCa/TE5oWVoSUd/CrsEO1f+BGfqDWeyw2xfDXXsg5KW+AbtlnW?=
 =?us-ascii?Q?jjlFm/Qcm2cCVJP7KEVjmmImaGP63gcV8wtYd/lFkV+F/Ok5kE47PuThpnRl?=
 =?us-ascii?Q?zd5MnUqhIbcjKx6tY5sjatUed9zXjepkFzwdrdI4qvz8a6fNE7Oe2U1Hj97A?=
 =?us-ascii?Q?f8UZ0hcP0mCtYk6kDJjsQzfkuawclbc4wozEcEj/3xPatpK3zXGu+uogBFJS?=
 =?us-ascii?Q?d3jvdOOy9oSTwCxl6T4Nfzy/WVdj1rpUBUYmCdjq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65018fd9-08a9-4e94-93eb-08dab31935dc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 04:03:28.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbIXT4XK6Cvlkj045mBW2+R3isDZPc8PcXXLwH4S8KYNMdqOtsLqFRiZXS03qe8g8AMgtz/nr9sUWI6zAkWKuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5582
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-19 at 20:28:58 +0800, Abel Wu wrote:
[cut]
> A major concern is the accuracy of the idle cpumask. A cpu present
> in the mask might not be idle any more, which is called the false
> positive cpu. Such cpus will negate lots of benefit this feature
> brings. The strategy against the false positives will be introduced
> in next patch.
> 
I was thinking that, if patch[3/4] needs [4/4] to fix the false positives,
maybe SIS_CORE could be disabled by default in 3/4 but enabled
in 4/4? So this might facilicate git bisect in case of any regression
check?
[cut]
> + * To honor the rule of CORE granule update, set this cpu to the LLC idle
> + * cpumask only if there is no cpu of this core showed up in the cpumask.
> + */
> +static void update_idle_cpu(int cpu)
> +{
> +	struct sched_domain_shared *sds;
> +
> +	if (!sched_feat(SIS_CORE))
> +		return;
> +
> +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> +	if (sds) {
> +		struct cpumask *icpus = to_cpumask(sds->icpus);
> +
> +		/*
> +		 * This is racy against clearing in select_idle_cpu(),
> +		 * and can lead to idle cpus miss the chance to be set to
> +		 * the idle cpumask, thus the idle cpus are temporarily
> +		 * out of reach in SIS domain scan. But it should be rare
> +		 * and we still have ILB to kick them working.
> +		 */
> +		if (!cpumask_intersects(cpu_smt_mask(cpu), icpus))
> +			cpumask_set_cpu(cpu, icpus);
Maybe I miss something, here we only set one CPU in the icpus, but
when we reach update_idle_cpu(), all SMT siblings of 'cpu' are idle,
is this intended for 'CORE granule update'?


thanks,
Chenyu
