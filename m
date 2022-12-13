Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9E64AF68
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 06:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiLMFrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 00:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiLMFq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:46:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21A11835B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670910415; x=1702446415;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t4cdyoyeUbbpCrv0M4p3marP9lAbTu+i27MZ4zsNfQ0=;
  b=fguOo1meSg0aB1EmYnCaMKuSNfML4gz1FvJWs4V0VXi1LkUfkOp+9Jg0
   3sSVXFEcm4IECZkGY6tFWMYFxrrxyUNPAvuf7KwXC9lgOkCeoprqmD+/U
   ameKPFce8RFvoo9qP+6aFTtkjnDXf92pNLVT0fvKwFz3J1Z7GT1AWFC50
   Ugo3uqp0OIATAfbwJj09g+PbtvzNhxSZpC/+TIAPPXZKY9wyHNxpxMKDv
   DzWRipl1Qh9o7gr/Cp4LTIBbG3V7cyOBUsztIYLbDSrH5K5MtZouYTi5c
   LVtgR8SjYbU6JO21DgPggtlWkbIw/3cb+Mu6ZAuE2Z2zf+5A33CPgLxIA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="316750798"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="316750798"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 21:46:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="977327035"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="977327035"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2022 21:46:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 21:46:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 21:46:53 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 12 Dec 2022 21:46:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0Amt88NqZgrOlevR3Qu98MrPT9gznhROEAdorTmIj8MangP8pumxPFO3qDpSa/QVlYv8mCH3I+5seqyzT7IK/eT6ivoINZwSpjPqbqTa7q53XXtk3o2DomzytPDM266vF2BKwGpbV5zk4fp0ATQNtm3EtL6olbvnjFFuXGvdzhZV+yjnLmlRGjhCpWCabPfYLDbRhMrksVlzP7/ZbuXwsSaH02BQwPkPhvAr/mNcJMNeKhThBqDE7oNXU0v8fykPso+x9YbZfuyO8F97Z7h9ajvNqPux5H8PbGZ9FEHU8WKYsnuT9YWWlW5YvBC01PkoAMeaexKpjnCoJit+RMW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPBNwsczaGf5xUUA4VuDarehbPLEP82HoiVz0rFMTdQ=;
 b=VVjsCr4rtwy6Q0Sj7Pw3RSLfuc6oSaHlzZ5yl9C7resItF2RK/8S2Jf2XoCTrclzzfr7qKtgTmwHnLHWIlA1cIzLZKPbtrXQkf0hfTn+XreXyPMs4yBt2CQNmWMLOrQUQBHT++mFyGK4U2nlUfqs5ZzYsx8RKjxjqMH2l900/EHk/n3st1T3AoucscflWw5P6Rkh0AhpfrZseiEPAymzph5nMuax0yNCLCtQD9qy9SLhp98rctDpRMjDBK1G0lbSe2/ZlxcgfIJcgo7u9mBPqxi9mj6KyIiorsWutbipsLOdmEVwvbwP4LDpzjWbyc7B8hYNIuY09yvI7ugTSAPR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 05:46:51 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 05:46:51 +0000
Date:   Tue, 13 Dec 2022 13:46:26 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Josh Don <joshdon@google.com>
CC:     Yicong Yang <yangyicong@huawei.com>, <yangyicong@hisilicon.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
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
Message-ID: <Y5gRsnLQLlzugB4I@chenyu5-mobl1>
References: <Y4r/iuqyLG4MOK4d@chenyu5-mobl1>
 <3A5DA66F-4330-4FC4-9229-998CF98F663E@joelfernandes.org>
 <Y42uH5fglluWYOm7@chenyu5-mobl1>
 <CAKfTPtA61DDk-VbNDvAycp8Et5fTwaOS=Q3559rBF7QDHDpJfQ@mail.gmail.com>
 <CABk29Nuc+VVOpAwFsbBo+OppayszebT29Hadc8qK-xeyZpY6NQ@mail.gmail.com>
 <Y5CiN010QAwklahh@chenyu5-mobl1>
 <e0b20fe3-6528-41ca-f53f-d78e76cd122a@huawei.com>
 <Y5c7oTIRIQYYkdW1@chenyu5-mobl1>
 <CABk29NvsBbqop20Z8-mdnZpto+Znc_+93OK9dsVMcimsSOf1xQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABk29NvsBbqop20Z8-mdnZpto+Znc_+93OK9dsVMcimsSOf1xQ@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: fe36de0f-7e59-4e37-d342-08dadccd6dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmkkZOzaa3LhhKGQSTtqG65ic1QFv0ie5hkyC4pPO5krtmNDCRQUFerz+A+Val6FjUoLn6A5lACW5duUnSBEUpNxHusvFGdicD7I4ws+qA/jJtCFUCaE2o9twHgy9VsUHdCItYhPGWrRixr/EvAX8gnGr+8kKM9S6RZNzoRXCxkp5e6GFgITKZKOf56D2IZag8Pl1h8mQ1ZH324V4m2UP6CqwK5aR/sh8pqdYGmh7aN+EBgCYXNj1cIbJngiaQhsrHdmbg0ZGLaCNvFhks9mtQa3O8TV0WVxGqrNUVNaP4BZZK1fOWcE10oevHjiPGG6P/uG77HKC+yYQxxveM5gHfLZ7HWv4vsc0AmXoj1pErp6cqd/c8YUWDL1Ylg/X/hFyYFKUs1B0IWfllzfzsAXQP/hWIdxRKucnFx5Mp2uFkxZs4kYYLS9F6EzmHJ+8nZfXiPxeGy2Fpm0yBHvDewILJ+vhIahwHvCyoZZ49iPnp3s146eBu0bDo52Z2GowtOGXuudL41/TTqyCCJnlmjx3EN06xLnRPZatZW2jMjtUbaMypa8gh7YOQ/yIjbOFZBN+7mQf04sNpUZhdlrRyMl+oTKzF7xuHN06IQIjNhVjD3yNP5fl2MkoIMOLfmk0VuyzRjvWnx68+VAzrS+EPd7zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199015)(478600001)(6666004)(33716001)(83380400001)(26005)(9686003)(6512007)(53546011)(186003)(86362001)(82960400001)(38100700002)(6486002)(5660300002)(6506007)(2906002)(4001150100001)(7416002)(6916009)(54906003)(316002)(66556008)(4326008)(66476007)(8936002)(66946007)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J7EJuT8qMPm2iu2X/4NzqB60BA+pDExgV2kes78uNy1OA4GCkaNh8ncIKRiW?=
 =?us-ascii?Q?wQUK8rfX4sorm+ZwkmDMhYzP3gP9y8zw8kJkzFAxBgE0F8PK4sf5O7yuHrX/?=
 =?us-ascii?Q?ZKIr7R08TcKvDdXsERKnG9EB0nLOszFSooqqivDlaJpE5Uu8vWRaWqsRzdgy?=
 =?us-ascii?Q?lq/FJjMGPLGBFmo5dez2qT47RiLYEz5RTmTzxoEelu1a053hG9DgjhlUYs7N?=
 =?us-ascii?Q?Xma2yGyYqmwoz0Ng1hP/hrIZ2JALbPCF46cJD1TqCYmMQc5MTcirG6JiH5yL?=
 =?us-ascii?Q?grih36WLXtunduWYlsqBk5z0N0yL3CnXU2xPAnyajs6V47D3pAcv1RGpsxnP?=
 =?us-ascii?Q?sWJMUQMsLW6N5KHOgcS5/A8i81IR4dRANnJniPs1kFOIWmECeH9XTnjxl4NY?=
 =?us-ascii?Q?4h2Bn+QVZ00KrzHpVz6IvjnFO5ITECeYBxa3CeL8tM8UGYswJV1O7UvANHfb?=
 =?us-ascii?Q?pHEdI2PAVQlZ/Ll54LZunT7Jb42J06Bnu784qpqkJONFCL2ltqhhc6NOqq1a?=
 =?us-ascii?Q?Nuf0T2JqdSWSktFkMGegi2U5cc7n7lyA2hW9il6efruoDkMRYAdudHDW4Mxn?=
 =?us-ascii?Q?eemkv5pZFdasst7yX5dqPMFTOc1S2OVxikxljoohCqrOvN/QmQxWqCySXBip?=
 =?us-ascii?Q?6qjoGvLBq8KvYbvOLgcw3kJcewu0/ZtlS86a8AtABFcUv7qLiII5mNoiv+hz?=
 =?us-ascii?Q?ryBayeQvYaEUTp6SuOTxIYSrM5tCheRpQ2Kexv2uJkF2Q8JCQJR/4tcp/IbW?=
 =?us-ascii?Q?6rZQwLPo+S9sYeGBzB0Z7Eb1k6TwJDBRq3k+JiRzdEAknFzubxKMFaqyX1+b?=
 =?us-ascii?Q?tx3x3PiIyrTkyVLNQVWQpvjqI7ljyhJNXP3SefR5XIhoDBiHL657hsuG+u5f?=
 =?us-ascii?Q?ln0lz5d8++kUVsMw5siJcBKbtaT+NMvS5gPZjTDskWps77/ta4yIujyndc9/?=
 =?us-ascii?Q?1Jl2nRwS+1UUVQQIngqyP5w81zBHW76SPS2CGZHTdBfmn5qwrxGMu4KByCae?=
 =?us-ascii?Q?XYE7bAO2U9yqmz+e3iu4rxEzxktTKokd5cRUl8AYbXTO7JLFGaNUtYHYVBE1?=
 =?us-ascii?Q?YKhc5imj9nOSNnY2psDNlkPZ0XzrgtdxRkhpBDJGGMT0mFb7SiU4GOWl3gAV?=
 =?us-ascii?Q?vrwW2D6jFzjy2Pe4V0E7F4lHNF4BM9uhEuHp4AmLsbX8rqLIh4SNJ4rqCS9K?=
 =?us-ascii?Q?h+tmTap/TyijWkzpkl28CIxiKRIXUY+EJFnwcc/j1NFgQfUaI14T1YYlLHTj?=
 =?us-ascii?Q?9SmBL2SHdrSvHU8toEe/T/WLkF1n2C+zBs4VK5Zxpsbpmytu0ZIzttGS0QKv?=
 =?us-ascii?Q?10XgeXik1t/cXXHkYcDrF/uAabUuGmFMYxSdRYtEA6bPsHoN3uFsRz7DgNH2?=
 =?us-ascii?Q?4o29YJe3C8vXEI+4aEyIEacY7BLpdDTZdLwnwoSwYIlDMI+hde1D9dubLqAS?=
 =?us-ascii?Q?Ece6O22OnnMZYMzMbuk3HDlvrArssMn+pwFQeb0naN5aG36aQSNCMiKf6cyi?=
 =?us-ascii?Q?/boGkCKdNkeJ0mFc8ExXaMq4lvfSgAtISqpwJIvTVhkgC8Y23O/t+xfXQ2im?=
 =?us-ascii?Q?IFTzqjnxOp+gy0RfPCyX0sYqQyvN63Ef+EeVpWwf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe36de0f-7e59-4e37-d342-08dadccd6dd6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 05:46:51.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYhm/V8kj4+Yjly5/I3+fEdJ+K+F0kGJt/x0/VUkyMqeyzke0pA6zQ5O0oYa+5xM8k01GfoVObtFlqVoILg2sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-12 at 10:17:35 -0800, Josh Don wrote:
> > BTW, I've changed the threshold to (sysctl_sched_min_granularity / 8) in my next
> > version, as this is the value that fit my previous test case and also not to break
> > the case Josh mentioned.
> 
> Do you mean a hardcoded value of some number of micros, or literally
> sched_min_granularity / 8?
The latter. According to the test, the average task duration when system
is under heavy load:
6 ~ 9 us for netperf
7 ~ 70 us for hackbench
7 ~ 8 us for tbench
13 ~ 20 ms for schbench
Overall the duration of the micros are quite small(except for schbench).
The default sysctl_sched_min_granularity is 750 us in kernel if no user
has changed it. Then 750 / 8 = 93 us, which is close to what you suggested(100us).
On the other hand, if someone changes sysctl_sched_min_granularity,
then '8' can be viewed as log2(256). That is, if there are 256 CPUs online,
and the sysctl_sched_min_granularity is changed to 750 us * log2(256) by
the user, we can devide the sysctl_sched_min_granularity by 8 in case the
sysctl_sched_min_granularity is too large.

My concern of using hardcoded value is that, this value depends on how fast
the CPU runs(cpu frequency). The value I measured above is when the
CPU is running at 1.9Ghz. If a CPU runs faster, a hard code value might not
be appropriate and could not be tuned.
> I don't think the latter is necessary, and
> indeed can lead to weirdness if min_gran is too small or too large. I
> don't think the concept of what a short duration task is should
> expand/contract with min_gran.
The value of sysctl_sched_min_granularity might indicate how long the
user would like a task to run at least. If the user enlarge this value,
does it mean the user wants every task in the system to run longer?
From this point I found connection between the the definition of short task
duration and this value. I'm open to changing this value to a fixed one, may
I have more insights on how this value would be set in production environment?

thanks,
Chenyu
> 
> Best,
> Josh
