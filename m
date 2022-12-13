Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870DF64B51B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiLMMY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbiLMMYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:24:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8991ADB1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670934292; x=1702470292;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0RhexriLhts25kE1EWAvUWv4dEOZP8waYncbA0kfj9s=;
  b=m0jywh5GeyqiGJqL4iildhqblcSYLdF/PfRVpkqJ6Wopsxpstx/Ruw4S
   xQuDxcID5Excai3UWTvbLFGZCJ5vMEylsT4KfbZ9dwkSKgpg+P09gtrai
   DJaSG5q/ZfurbGSEDTutN/CQQ582K80UcWvvliLKO2S6NWCfaHBI/vffF
   Ux2STZW+m0ir21eIedpHpz3xHbRmwKtQ1bldYEvivkf5i/2Wwjdj1QS+u
   gklNEOJ00sQ6m7b3zWtyZk6bkU1rMmE4LXHs88AQDLDCO0iWdrlFCrZNc
   igX59u/buV3deWE4n69Q58fJqst0YrzipICsb9owUtsndLABL1wH+J+rN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="316819254"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="316819254"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 04:24:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="642087909"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="642087909"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2022 04:24:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 04:24:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 04:24:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 04:24:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGdS896w2GsWpvdoObZgj4B4DkqXU4Y3yJg1LecKVDrSgFDinGn/PacxReCtGRzcxbI52YXbaPUP2LrrCDGkiJwstnI+KCZja+Y1u/xvsdR1RGbe6W1WiuYbwQNAkV67t7xUpKZWA9sdRllxMxmsYidu+cJaRfmNQ42NpsgSl8AyIZBnml3q3CI0eOqdSujXKoz2NXZPSJFpYZp4MLtOPI/PxCf5OziQPed28nqTsezkApDNMcu0T1xGFEPO6iJz3f1fom0C0pA3Yco20USwq59npJ4MEgxn/VF6x26JW5e5s9N1vAvsPXM6rGLUXkK+tZaLD6okb7ZgxkpInIr11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4YMdEXvRaKjzroF9sjwOg2llOGbZ+s/VGL/RXAGAss=;
 b=ofibele/VxgijgL3CslJll+Sj6oRb3EbgEeivO3ebsHvZQTLb2+ZCGSx91Hj60CRgKM/SM6KkJIs9pX6speHYj52nRlaiR460dXVJSxmaY6VkzwrBEuPXPwYx1CeAWUanC1Lbg67zDdDHtcM4vDnKQDbOpfGSbhmBEVzh0HUmipUnQaQ0uIytTYwkiYb4hdTr8PEN7Jkb+94bznxGAeGXpy2XNikgeBx6tGeZnsDbqNwGYl35s3EKlTFE9h/WH1MfllmeIf7g13bVjuogswbIAI/7AmN8FhI2h5RBUMr6bmbvs9kVL8AZy2UsUUYgwRPZf3KEH6L8G003YBMXqySBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 13 Dec
 2022 12:24:48 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 12:24:47 +0000
Date:   Tue, 13 Dec 2022 20:24:27 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Honglei Wang <wanghonglei@didichuxing.com>
CC:     Josh Don <joshdon@google.com>, Yicong Yang <yangyicong@huawei.com>,
        <yangyicong@hisilicon.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Rik van Riel" <riel@surriel.com>, Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] sched/fair: Introduce short duration task check
Message-ID: <Y5hu+2YA2OYR4VqE@chenyu5-mobl1>
References: <Y5gRsnLQLlzugB4I@chenyu5-mobl1>
 <2a54f264-de3d-d5a3-941a-016ed2cfea0a@didichuxing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2a54f264-de3d-d5a3-941a-016ed2cfea0a@didichuxing.com>
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c27eec-1fce-4716-c513-08dadd05064c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s36pC+wvcrjm37nZiWk7nnaSpVvupsJFQlVkGaOpvvYcdZve5wzCkup6Oa7QCKflJM4/l0A6RRRy9E755xYHa/ClPD+Y97u/nbtkYP/H5u1bL/h5Nj35Iv7kggJ85Vwl5AZRcBfUuJ6jsT394frHP1RiVD6xAVWP1w0Mc15fG+QCBp+TgEXH/PSRicLS9p3+8JYrBOiSHsnjj2GO9PoUJ4Ue3F7MpY6w9/t7HhVC+OxwWA4eFFZFAlipFnHJ1ZmjdULa1ig8fGVjA6H4gUQN9dmrWE25RlbEA71VKyfRnjDlQArLSjHWMHjE4fJpBp1GJU67oivt+899ZGlKISBU0+uew+Xso0z1jATlV6r0dR8bfePpwWJ5Zu9HZFKYJfG6nE4B9gb+xSFEoeplwF3+PlORZTJ1LHyb21ukGweigCFttyLlhNx2lS2iWF3OFvtnM9vLim4HMVsgolecy2BMsOmSmmW8vRUg643082lGMIcU/Pm6X0UYF5Aa+kcGwH7dhDp21ZqUCx1EY3tJoqlxfQ7KeeKNS/nL2aAhdI7RSDwgSITAC//YSth6YqSrY9D/SBLqiSRvyvZpfd4mpKD+qMJQ0pX/qGA1B6h+l57KZSmbHjCAIc0u8PQZ4ceikyoVYsoA3nHJ9MD2Ca28TgjuUv13r6yBsFqsR2P/rz1wymISokY+ii/SybOrDJFNVpBl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(33716001)(38100700002)(82960400001)(7416002)(5660300002)(4001150100001)(83380400001)(41300700001)(8936002)(186003)(86362001)(66476007)(478600001)(66946007)(54906003)(6486002)(6916009)(6506007)(2906002)(316002)(6666004)(53546011)(6512007)(4326008)(8676002)(66556008)(9686003)(26005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yMeHELps9vU5s/iwUqAGM0PrE+lmOrUWkGHat3EWRkWhavM7P/ikmKtKcNXd?=
 =?us-ascii?Q?T235DbCTlALmWTP8ELz1t6R0hafuvByyQ4NMlApGF/DsdjZiTkQBHYdGo8H1?=
 =?us-ascii?Q?hF18aA8ypUe/RIjHPuEa4Z3gtyMkuF4uYzfGMYzGRJcJjo8sea2vaaJBA/gL?=
 =?us-ascii?Q?4OTGNmp2EUbgCSrtrQEwbqFMxTv0nF2edvjY7fqwQbPnwF7w1Z5nWRPTt498?=
 =?us-ascii?Q?JCpBlC3mreMwncwMR+UWRoW2OM37mtT114l7czQpuHPYrnSqDRAFqK3/MsA6?=
 =?us-ascii?Q?tgz2IYVrbmJ7F2YydWGSPLrk2ktEkPJRpyvrfL9TFofHKCL+XCHgCE9Cx/pt?=
 =?us-ascii?Q?rP2RanIo/keGrOEzXequKe0jKhMCtQfVsr9Gdav73u8dKRow2MGVbwg6emOs?=
 =?us-ascii?Q?tOfTt6FeFbg6EfUFCqjtF4Pxabcghzi0WGOo5sRUd3fsh6G+Cgxrhf39m/Fj?=
 =?us-ascii?Q?o56btjRu+m/0r9IEqvb6UCnRj1xn7DDfNI7Tsnv/5jzduGhDQNFNx6OEFiVE?=
 =?us-ascii?Q?/QOSk6sXLqrejUIcZuDa2Xp9IZ6QUWNL3/YvR2N8e8P+NfOn3RHebEgtcGb7?=
 =?us-ascii?Q?aVaP+MY4fuVUAvWA56sdIKYgXV/TFy/mNcSKALg50PhxL/0kcM6HGJcCksJr?=
 =?us-ascii?Q?F8AAk3XUpNmetIAzRSf3Dk/9fFLuJG3+WlHnwqPT3ygvcaEYFqdaf/CPz1K+?=
 =?us-ascii?Q?Hten3PlBBtgxfYD7m2V7nYG172ogRP9Y3+CPQW4tJIekYH5ntyeGovkZiiJL?=
 =?us-ascii?Q?V178HqJu8yNheYzV4URffHlwLGI8W1He3L153NV2oLTYu9KBCZlBnvdEPbcj?=
 =?us-ascii?Q?aLRafut/R0tao1kyU6MWDJjW7HHzW5iPW1+9FoWPFTHAgXDrOjv8ZZ0RUSeW?=
 =?us-ascii?Q?vbyS/T7Xmc7dKp+AGhW7+5NNO+v3AH7d1ldfcqpphrsONtP+5Omm4x55/iMc?=
 =?us-ascii?Q?r2njlL4fSy7NBjXXmBHYciYCGF49munH5MaZXkxZYTp81+V3SzCvYhL7gl1k?=
 =?us-ascii?Q?ZmUPxPu0BiH/NCO5MO4QuCHOpXrUVJiz9/DsMlRwEbFcQQdZB+wvh9F4rHQC?=
 =?us-ascii?Q?5zCMLiAp/vNfDBywh0fOYQnGwSZpaA6pde5sWJgSZIMDp1fHFo1/FkZJJPeB?=
 =?us-ascii?Q?NqeLQ8Xnv8H5JsfWjOMP9LIHoxrTxh6A8WWkLM8PvGmYVPKTzrzhTdxWbHXg?=
 =?us-ascii?Q?aWjBD2BsKM3CzuRqDIsy89E1wH3kAX7KBiTjrAXJvo/skK1ttVSYyYvVhMHt?=
 =?us-ascii?Q?mQwwoo6VPr5rLhQYlGfR1N0I2Y/jhYtMv2Ue2seLuh6fmMS6rQ1PrhHL5j6s?=
 =?us-ascii?Q?1PsU+iBHUWk0sBdETTAzBxFm2OEW7Khu0QJB8hyDJglPKhk5mGBn1AmXUPlp?=
 =?us-ascii?Q?f3wH+t76QD/2cI032970oxWYxxx/h4aMLbdsHsMIrgZQOzZ+JuywbHJyqnt+?=
 =?us-ascii?Q?iWovjAa+IPV5czJpmxRow/Kr3rjpS9qpRs4TT8/8ScQCqW/jaNomX0tPhRQO?=
 =?us-ascii?Q?wgfhrBZxkCkF9ofLpn4kRewWYALtFkQBQhFeoURek7pZH3MmkmC1/H2CFsF/?=
 =?us-ascii?Q?HtANqyeyQESPI1Jnh6ChALyP3yOa59JRUscB+PXu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c27eec-1fce-4716-c513-08dadd05064c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 12:24:47.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/8zdbCgbRBRYMRhjPBzHXfMrQH2+zCqTqUwXAcjQ7WoN2Lw8PC6GuAiiz1wJ4vlYnbMmPG6AhwUfQMMLcxhUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-13 at 18:06:50 +0800, Honglei Wang wrote:
> 
> 
> On 2022/12/13 13:46, Chen Yu wrote:
> > On 2022-12-12 at 10:17:35 -0800, Josh Don wrote:
> > > > BTW, I've changed the threshold to (sysctl_sched_min_granularity / 8) in my next
> > > > version, as this is the value that fit my previous test case and also not to break
> > > > the case Josh mentioned.
> > > 
> > > Do you mean a hardcoded value of some number of micros, or literally
> > > sched_min_granularity / 8?
> > The latter. According to the test, the average task duration when system
> > is under heavy load:
> > 6 ~ 9 us for netperf
> > 7 ~ 70 us for hackbench
> > 7 ~ 8 us for tbench
> > 13 ~ 20 ms for schbench
> > Overall the duration of the micros are quite small(except for schbench).
> > The default sysctl_sched_min_granularity is 750 us in kernel if no user
> > has changed it. Then 750 / 8 = 93 us, which is close to what you suggested(100us).
> > On the other hand, if someone changes sysctl_sched_min_granularity,
> > then '8' can be viewed as log2(256). That is, if there are 256 CPUs online,
> > and the sysctl_sched_min_granularity is changed to 750 us * log2(256) by
> > the user, we can devide the sysctl_sched_min_granularity by 8 in case the
> > sysctl_sched_min_granularity is too large.
> > 
> 
> Hi Yu,
> 
> Seems there is a min_t() call in get_update_sysctl_factor(). In most cases,
> we'll get 750 us * (1+log2(8)) = 3000 us in default due to
> sysctl_sched_tunable_scaling is set as '1' default. (Correct me if I
> misunderstand).
>
Thanks for pointing this out! I overlooked this part previously.
So (sysctl_sched_min_granularity / 8) is 375 us by default.
> For the value in production environment, I've seen 10 ms and 3 ms in
> different place, FYI. Hope this help.
I see. 10 ms would generate a short duration threshold of 1.25 ms. From
my understanding if the user increases the sysctl_sched_min_granularity
then it is expected to have longer average duration tasks in the system.
And the short duration threshold should also be raised.

thanks,
Chenyu
