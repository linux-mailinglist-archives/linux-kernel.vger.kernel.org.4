Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35586BCDB7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCPLNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCPLNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:13:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BC45A6D1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678965228; x=1710501228;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nMX6OJP9MfqJw+trCCxH3NF0b+9c1cuCFs80SlGVpRM=;
  b=lUASnfE7WwiJ4BdCNe2zG5dtscOIMHSb17ZyKYaUYLEqvjzv51mMNXvE
   aZDf+NIVSVArH9E7vnOaREqOB4cMxflP98alGF+3vKfCqxV/gUosJ7qgJ
   vKchDtcYi5AXraoDtNngLTG3f7dwEuzz7t7tWO4hkzC6SrpEZsz5nEtIK
   xDI67Yfb3vAQDq0Q5C2c/Ul9aFibcRWBGj2RKxLGkhAdWnJTUTmjzt8PU
   NiOjf/YIpOrGoPU+Q1dmHGtuvQaRJKS92ApljQE2RhosSqd1tjnoZW42B
   Uydc8O7H9CblEM+fcr+UJqvnYUwqQqXs8qHGTsr3hBeQxpHDg8sHbGJMD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="339484352"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339484352"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 04:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="1009182759"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009182759"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2023 04:13:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 04:13:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 04:13:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 04:13:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7LRPILk6GWm5J4GydCLe2YNWqhRKwZLM0TxzfNGPeFl12UJXTPmPkSD/gCsgmTnJYyxjjIpUdkT0cAdCKePXcyruXn3ZlliUL8ukCCX81bTE9aslPjck2nI6pZUBa0h1fPTXGUK8z4WT5a94lQ7vZJY9Zjx7q/M3/Lpb3kXL6yXAvF2U1ew0TcXPg8HRfWN3/5DZFVbKrDbQV7gkWOkrErfRU1EWrSRARLVGRabGP5xgIIgjhwHG7i/bsBAqmIacWG//9/td8sBnjVR/mjehhngXkDCFmWU964stnY2xfXKD5owoIVyGrdcXgqBBqnFK7J/WnYidHs8ro1ySRbE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVT+UGH0COgF1jQRqxLA5okMkbGYVX+3L9kCIirDXJ4=;
 b=KSvj0Fvlpq/43VPVvZRr7f7cP69V7/YHBVuDCLVHmBB+kQqr5G3KHz5R5dntD95KF559VI+hFzOI4q5fQj+6GwJML9UcYzhehrsNdDlnzsFIW9zhlwdE748nwWERguJbUUJRzlQRtjoWJsu0Ak57aN3U5fR5HwCEBTxwVtZBHfS4q+bHudNAsjKyp66trqPKSUyD/JwBtaGZA0302eBuRd1vcKSpIh21dQiKwLz3D3jGtMy91hGpKtw8X3K29IPoHpqmb2421nK7AL9Ux9eJ36olq6NCzSgrxayQBKXXmADgRtkOPVPwZ6wIWQcLUniKTjNNuyb7odpwNJX3pClU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB5918.namprd11.prod.outlook.com (2603:10b6:a03:42c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 11:13:35 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 11:13:34 +0000
Date:   Thu, 16 Mar 2023 19:13:15 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, <yangyicong@hisilicon.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        "Len Brown" <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        kernel test robot <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] sched/fair: Wake short task on current CPU
Message-ID: <ZBL5y9gCJxvI4HW6@chenyu5-mobl1>
References: <cover.1677069490.git.yu.c.chen@intel.com>
 <718acf0e-2c98-cff3-98f4-da43d49f776b@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <718acf0e-2c98-cff3-98f4-da43d49f776b@huawei.com>
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6f4fc1-69d0-4db9-7f8e-08db260f7b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: No2CsRLGpFH4l79iGDfQI9znyMjn3Ui+5138GMrbdH+BWK1kHxkRNucvKr2t25gO9t9Jwe2uaN0bGw+qdSmrp3lMkTsIpcZ30RJ9wI7kZXm/ZZ9v3eVh08/AU+E/gCAcleJWI0z1kSucCg39g9rtHOsvCIDPxJ7ne03rI4IUiIEFdN0rh9AFoiwhvG+A6mmr/JLarEeNHwfSKjtTARu3O+QklfDxy7hF9trb9exvpzwA2OoZ/5lc/ZdLn6PvIvoVVJa6S5O2qmpe9G3wKacAD0WrydMKdE484OxUiP3n9BM9Z3IGBM8Dz3sTzxLVUX0sx7XWuHZebCM3XpofZ25fMzog24Y7O8SsFe33fQxYKeEWNjmkojYl0mfd5smp/4F156nIUFwAUaURguHn4Mt+UTHs6/hSB2hjS9C/CRVbsqGTFyxyZiXrzXL11H+u4wl4nLiEKUAia3HtN5nBWn/N2re6T2st2uQTYMRzKdRuRfnewauD4iMJ6raQTt86tyNgbYMWLx8FzCYdY8ItsOKdZmpoLI8/gWfSUNoL9qXcrRAiQqtye4p+Zdq8ZbXLzgJ/eEOldhVUZXCkELBlXWfYl7KC6hZnE8kWDq6qgNEm6rIJCYFB5z0wYoNsHIs/MS7UTD98zRDv+w/xtCb3bZb37g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199018)(4326008)(41300700001)(8936002)(7416002)(5660300002)(2906002)(86362001)(38100700002)(82960400001)(478600001)(8676002)(66946007)(6486002)(6666004)(66476007)(66556008)(6916009)(33716001)(54906003)(316002)(6506007)(9686003)(53546011)(26005)(186003)(6512007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2gpCQgTjD2pdhgQ5e9sb6fNyI7RLi/JBcKkIPFlZx/vra+o8fHujx6M/QkZ9?=
 =?us-ascii?Q?amoRmDuFPkUVCjC6YBKpN6WpNMQsjlhIjnBDyLPEA744YpJZxqDlalMnGXeV?=
 =?us-ascii?Q?OPzLfAVRV+8qas8mB8PJ2RVQ/N6myw3th7Rh7eKB/rbqksLqW2m/a38ZxCa6?=
 =?us-ascii?Q?ZoR2+lzHwAHyT/exgtvQ4lYwo4LgsbxK2DoRTFVOB4eg2OBfXXXwPSVuicDS?=
 =?us-ascii?Q?+Q13LAhTZSQCPbgPg/n7GS+IcuE7DxbJw2R5U3Sa6kP83HZAyujAJbfsLBbP?=
 =?us-ascii?Q?6KwJifXu2OUs7hcTNTHA/yO+GiLppanGc8aViodOR/HX5M8y7R+Czn0eSmOR?=
 =?us-ascii?Q?/PtbKHroDPQP8aIb6JHQ2NrgDIuOHr3uroOywmfLjk+3Ho8pdjX0/OQ3vbCr?=
 =?us-ascii?Q?jcAMnDWZAaxu7JFhKMJCQyfvPabxBqjAf8M1ptrGVRU5SZhSTsSebDVSg6fy?=
 =?us-ascii?Q?Gl3+WNabPlUMx8mmEEbIIiL8pAyIu7NC7N+qH8hhJ7HLTOnntcAvqn30B3+T?=
 =?us-ascii?Q?o1zHlLVybwb7tduX2Q/2nykUoXKaUdompJRupgYlnQ5ycxohBPyj+nrizTLP?=
 =?us-ascii?Q?4cERVF/nwc/071coEMn6c653ecHHV2aPAO4OZRPcQlTJVuxkdY/2v+ASBaIB?=
 =?us-ascii?Q?wwzWoGSnPqWt4rDmpQedHsEbUSMefiGw059PAyyTG8knm6UT9H+46Tnq6Nd1?=
 =?us-ascii?Q?9V+9szqVtHKudDxg2eF8VJNN29v22gQHvjvUs7tg9z/4kUELmROHkUQnGh8A?=
 =?us-ascii?Q?Po4TnDTvEYazRbKbQ2lCTGIsDvuC3DrQEaLgDGpyuOw+fo0xG7LtZIn/DEqv?=
 =?us-ascii?Q?80GpW+sDQb3tM24t3MxGV4IN6uIk8/vQtyCJP0kGcwJ8UzIb7vyXmW9My0Zf?=
 =?us-ascii?Q?eXCc1Zn3A/GKXfHRKYYITjzJexBRjbfZTxr/s/igLErrMqe15y5nw73kPYjk?=
 =?us-ascii?Q?h66tvmSTWNKNXDGxKJd4QFsBN+oipuE63dQdZ+3gZz5wOTCnTfYo4JbNRBHk?=
 =?us-ascii?Q?yTmmdw0JckaF38FtXOpkIec9RtpquzT9X55lBXLiRPCuTTKe/Ojurl1MUfCn?=
 =?us-ascii?Q?c/6STXOv7mZl4GCwaSciuw2H5mnMJS5HAxwGXF4G5r/+A7XGBCVYk9NdxgNf?=
 =?us-ascii?Q?duqen0LXnY7yCd6aYyjk5Fz5x0X3O2voaOVrLQxT6S/jPiR/0QBLypP8+Wl5?=
 =?us-ascii?Q?grKObWHttp1iZzHqVcjK/CwgrFuVWKyqFg/yiaZtSZAHaxcOJpWhHb/AoSHE?=
 =?us-ascii?Q?spblw0Im8I6/1p65oA1mNWjnQ057jq+MjuaaEhbIeFLnBj0GTOuls21N6nBv?=
 =?us-ascii?Q?fI7ZBVXY84kIazpPjfUdOlkoTzX16Jl0j05tAtiDIeA6vZ+PX/soGYAFILHP?=
 =?us-ascii?Q?kCj373cw4umRQbwXnZe8aFeLMUC0dmVxwm+XExHcq3NVhCXcGM2o496fK/Op?=
 =?us-ascii?Q?WIiAn66TJSUmIKgkSIPR6CVx8Lw5nk4tlh4ofmkU5qFe+3zAauilZDV6tlH8?=
 =?us-ascii?Q?ZdyEFwXrxqXDcJxl0qW65JB9ibva0yXYcdI2AtDh3q6GqK0srwJ3s2w7TrXg?=
 =?us-ascii?Q?NZr40jwX2uDtAMrDIUqGYzsErkxO2ZWaY7DMZXq2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6f4fc1-69d0-4db9-7f8e-08db260f7b6e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 11:13:34.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAeaglkfeh5XuaRi4ODWqroan63v72v8sftBOwkM2neWhpVKe78JKQagKvsfNRAaQNpcF6NRsXUkd2pmrpRg5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5918
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-15 at 17:34:43 +0800, Yicong Yang wrote:
> Hi Chenyu,
> 
> On 2023/2/22 22:09, Chen Yu wrote:
> > The main purpose is to avoid too many cross CPU wake up when it is
> > unnecessary. The frequent cross CPU wake up brings significant damage
> > to some workloads, especially on high core count systems.
> > 
> > Inhibits the cross CPU wake-up by placing the wakee on waking CPU,
> > if both the waker and wakee are short-duration tasks. The short
> > duration task could become a trouble maker on high-load system,
> > because it could bring frequent context switch. This strategy
> > only takes effect when the system is busy. Because it is unreasonable
> > to inhibit the idle CPU scan when there are still idle CPUs.
> > 
> > First, introduce the definition of a short-duration task. Then
> > leverages the first patch to choose a local CPU for wakee.
> > 
> > Overall there is performance improvement on some overloaded case.
> > Such as will-it-scale, netperf. And no noticeable impact on
> > schbench, hackbench, tbench and a OLTP workload with a commercial
> > RDBMS, tested on a Intel Xeon 2 x 56C machine.
> > 
> > Per the test on Zen3 from Prateek, most benchmarks result saw small
> > wins or are comparable to sched:tip. SpecJBB Critical-jOps improved while
> > Max-jOPS saw a small hit, but it might be in the expected range.
> > ycsb-mongodb saw small uplift in NPS1 mode.
> > 
> > Throughput improvement of netperf(localhost) was observed on a
> > Rome 2 x 64C machine, when the number of clients equals the CPUs.
> > 
> > Abel reported against a latency regression from Redis on an overloaded
> > system. Inspired by his description, v5 added the check of wakee_flips
> > to mitigate task stacking.
> > 
> > Changes since v5:
> > 1. Check the wakee_flips of the waker/wakee. If the wakee_flips
> >    of waker/wakee are both 0, it indicates that the waker and the wakee
> >    are waking up each other. In this case, put them together on the
> >    same CPU. This is to avoid that too many wakees are stacked on
> >    one CPU, which might cause regression on redis.
> > 
> 
> The patch looks good to me. And for the v6 version there's no significant
> regression on our server. :)
> 
> Detailed results below. The setup are the same as what used on v4. There're
> some gain for UDP_RR. For mysql no significant regression, there're ~2%
> loss for 128 threads case but the proportion is within the fluctuation
> range so it should be ok.
>
Thanks Yicong for the test!

thanks,
Chenyu 
