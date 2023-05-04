Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD2B6F6909
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjEDK2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEDK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:28:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6284688
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683196083; x=1714732083;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Gz94ylXLtZVkRG3wE38N14bWVo6Gnc+ymhg8zrDr6W0=;
  b=iikihqLFeRHVeIHlzise1k9ZItyhueeUZwMnW6XGR9xhMA9fp0vv83gr
   MrsuLxiECUufBUQ0B19QKbVszmRreGmwfv1fbGhcHQC8kvIlKTMTcYkqd
   /CEnZhx6A7Z779YGZxR+9ALusbkk20zz8LPnNrC2BHIOcBKNjHmhVpK82
   Sm8idCsf/I4VDwGWi5tqG6bu5v9h+/EtsbRUvguRbGC4ogHj3krYnYQUJ
   jri//+8kNf64AuCY4djsyAGIpU73AMiZBRAGebVAMGvyxqgsmFGUv4POe
   QpUTBpcJZr0LPzY3odnt+wM23Lsc9Nl475XUMeAYR/EPK6bZMN9sMk3X9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="329254018"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="329254018"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 03:28:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="647259890"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="647259890"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 04 May 2023 03:28:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 03:28:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 03:28:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 03:28:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FccHcNUswBSgxUZ+N7x//JAjZEboIhbAZE3FdPLqJCCDVfM5Hxqwc6k2AsVEcUVnK9dwYXslMDIISPFN/7r01prGmT/vtYjsJme5W1X1i+oKoSPxeEoKzpINQ6ZMTjUXvXtieIi5Nb8a+CsOyqonu/L7AZdFqBk0xNG09F4YSN5X3vBlZpgRJGTTxE5Xu20BCZW73IBbbqj3WMWI6vA3MHZ+YHL1IK5Nb7CTm09Pg2oTNDV2WboadXvBMZRgEFri9ohisxBvpYBTelvVlpaLBN6DDN13Mj8NAjjnjSbNGz15WKhH8Q7NEukLbwTuVxmy3QQi8U2S1uaZwAshK3cOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GbNq8y73PfwFartafzsRnCP52LlBuLHBjyqRcDKaGQ=;
 b=biVM4FwPiq00CyvpDs5zh51abb4Opb2CVTZ2w+AyqDJnsGWO2gELLPzEyB5IA/1VAqWsllZrJjrYV3ZcZ7qqAgUDJUJdgNb58EUnjInS6K9Q2ycZZXf5c2wCNdEtH2wAeSaGk7CGswvhsMT/q6XOr/jsdK/T8oI9fP3Ixk0pVX9QcvFZSAl9bs+k4RsApsxSvZd7W4Q5lCM1AGoMyqMk3k3sK3nMj/IZl8CoB2ONnYxotTIwem2xIIgOAlepw/AEWAvQkSWiohHlPWrAMUiYbo32roHvQtYzg0xkbFO6UAfNlbrqgi42m1X7xicqnncgGn9g9pvXbofmpnLasOArSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:27:59 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4d1:3278:8c5:c1b9]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4d1:3278:8c5:c1b9%5]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 10:27:59 +0000
Date:   Thu, 4 May 2023 18:27:46 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Nitin Tekchandani" <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230504102746.GA137823@ziqianlu-desk2>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
 <20230328125624.GA6130@ziqianlu-desk2>
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
 <20230329135455.GA108864@ziqianlu-desk2>
 <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
 <20230412120736.GD628377@hirez.programming.kicks-ass.net>
 <20230420205201.36fphk5g3aolryjh@parnassus.localdomain>
 <20230421150559.GA162558@ziqianlu-desk2>
 <dfkllxtzchrxeqykzyk24ppgwxbztk6rbbb6xyizpbhg7ctibi@fhk77qxo7yia>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfkllxtzchrxeqykzyk24ppgwxbztk6rbbb6xyizpbhg7ctibi@fhk77qxo7yia>
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH0PR11MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: da76aef3-2708-4e94-ce08-08db4c8a3b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xc5sl2yIHGt8k/+EQTSTbpXDIDdPExYjj6MiNaoEty76R555nQ87Q2P1DbJVs8pOMlp9l5LUT72Y6DN41GhNfOms2KfFq57tdGtZ141VdF5nOUuvADohzb9esrH0XCoCFrljlzURcb/y0SeEswxAYP4qkhyQjDLwOZZimVRWKKEpwOeFAVKjn+irE9asDRK4q2pfeuYX3LGsHRqcS4AccHXPCGp7eeSnVa0+qmrLvTtcU6+gD1ASD9ij50Mu2sf7ngMkp7B8p7wf7Un/4sMLTUSD4ZrujIqUExdIIcOgSsw7fqKRjTtcs8pjNfCg8EiZSJKQSxPY4RSDiZshEW+Ookl+GZOExNRvAVJeRljaX0uFuRLFHv4hX+VnroxlpI2J0ZJDfEUwQ582gI6QhQgN4dzSBbd0Jj9mdYpPdEUrRE4nGmQmU9Rpcs987GtrnPmQaw2ta8SvwEFTsRG2OBKDXTHTnm532p4beuqWmYV79FPY11VbssZA3f7siQl4AS4MoUMgvyTDEIbPQjBeQGwoMkMBflBvf8+yTzOJBCE8RnzCvZ5pxRvNVG4jyxH69B8y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(44832011)(7416002)(478600001)(38100700002)(82960400001)(8936002)(5660300002)(8676002)(54906003)(1076003)(26005)(6512007)(6666004)(66946007)(6916009)(4326008)(6486002)(83380400001)(66556008)(6506007)(66476007)(33656002)(316002)(186003)(9686003)(41300700001)(2906002)(86362001)(33716001)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0Te2BCvmWGwhyo5vYcYaRP1SlkXcrZQzNhJ0BPceyVvnIwEsq/vxfnYZ0g?=
 =?iso-8859-1?Q?Du1yMyTA8Lz5c3J5PcwTOUg9oW2UoDOmZ1iZUnbbWjE9HN6URswZ0r105N?=
 =?iso-8859-1?Q?XjrroJ7yCZANDDrC8jbWe0KAocD4+zW6rzkYoShfWB3fyK+cMenHH6i1wI?=
 =?iso-8859-1?Q?tdTP3k055j9nzct7MofQ7FSxYfMCj8EUPPKTCJd5KpJVVbzWLzLDQEIg0C?=
 =?iso-8859-1?Q?KcMmk5p2uambPNdtsk8loP/YN76Y7wcoEYhWhLhI9EdNBnAXqyoFTr8/Sc?=
 =?iso-8859-1?Q?UVqvvCbpr1JiXL06ompLKHo3Nwtw3A5+cTmGrvk0HMqPCzIqYHr+YsEkY1?=
 =?iso-8859-1?Q?53QXIJJPmcwNQmvM5W168YrcYSwqOvMlWfHyJOsuIYbB+maHQ+8GpKeDq8?=
 =?iso-8859-1?Q?nTewI6rU8hPHFYm9T+cuKt+3Z+GYEb9Ld9QSJLTQ1oAs/BwagABuje9/zh?=
 =?iso-8859-1?Q?wyKURxBl8QaAQJnJl2HpsSSV6A+rlvpO9qgM56rK7oIv2e93NpCzWAvOZv?=
 =?iso-8859-1?Q?LS6DllrtouIJiavDgEAKsoDZKvYILQ0tI/MYx8dmD9oRiXZc9GM2/hWEyH?=
 =?iso-8859-1?Q?xMEgIeOxJVlBVh0TrpA4Z25XeUlbsFrcWvcM/0OLJLwPDwRyiLrNX2isE4?=
 =?iso-8859-1?Q?C7UjWk4KpKxv1XbINQ2FetPbtov8a2MF/AVw3ztK4bJSB0KrZgwJcotJK3?=
 =?iso-8859-1?Q?hMNrRSSGvwTBk1Ix6x8g7QsbRrbtzSgMfmEJZI3jjEy0Ut+a0Om+s5El4G?=
 =?iso-8859-1?Q?AXp7hJwq+g4ACMrWLBO8+AejzdSDOIQiaRaxpDJG0Kw7SOgv4vFRCsILcA?=
 =?iso-8859-1?Q?T4xZgfS0pstTnsyFbY4pDwjNT0EawMt17k+OQH3j56dzo7P8CGaSUG9GGy?=
 =?iso-8859-1?Q?wqn+NOCIG7rvQA8gZshyHjead5pktcz1kMfMPvY4jSrC1uazh+jYWAEDc6?=
 =?iso-8859-1?Q?LOj3flfW5Fw9Ezyx0H5g3nuiq03ID5sruWXyjIYtpT6jHMJcfiO05GnV5m?=
 =?iso-8859-1?Q?ZMNkQGvzay+6RV8+c/4Yg5iucNQGf0IR2gYC0SKX74k1k3RKNRFaTviRXx?=
 =?iso-8859-1?Q?ghx46Ti8sG70bODFnPxjorb7CNqLU/XEKVVF/tx5MsS5MMyb4jqZqEq2w6?=
 =?iso-8859-1?Q?NxJgy/LEdaEGpx7EpSV/jTdH+43kLH1MuLOFmgwraxzkowqEfaumRNh4UO?=
 =?iso-8859-1?Q?NNQBLNeGdMV6X4U5p3O3YGZbHnk6DQL6wP2uhmzhSHWsUpR2dasZ3yY+H7?=
 =?iso-8859-1?Q?XRFL0UbZMnrzlv4/WGWRtgz24ApkqnoNyz2hIhCS0eXl+YaRNhKgv3QNlp?=
 =?iso-8859-1?Q?SdVfhy9oBLMUr3jW1S9sA01JIB+U4JQ3DAKFbCUL+UMrAnRE4da9YfCTDB?=
 =?iso-8859-1?Q?WA5I7XovRyhCXsR8cfTcB4kmEIFeMQUxCEqZfyTfsB1TfCVE4pbkWOe1M8?=
 =?iso-8859-1?Q?J4t7taqbGC1tXR4cA+FYwKzc4YtxSL/XXVwFAaH0otld+aespM1K35J1fk?=
 =?iso-8859-1?Q?ajRhuy8yo5Jqj9m4/VumHO/6jyXVgVgN3s3hzLS0eIJXS5ZDDVzmGwXznU?=
 =?iso-8859-1?Q?L4mieyL8TeMG2p2+lf5+vQ9NMic3zh8REVjIIQzNAjySHExA7MKMnJRGXF?=
 =?iso-8859-1?Q?4ge/+8tgdWlvJiTmupm8oe+ap76m45MCkP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da76aef3-2708-4e94-ce08-08db4c8a3b63
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:27:59.2508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjgI/svlk6k1et1A1w1pK+JaPcdfA0S0OWGAuqwQmDN2wVKScWC7o8Vva1vo2T5fQBNPao8z4JiSA+JoEcJoQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4904
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thanks a lot for collecting these data.

I had hoped to also share some data I collected on other machines after
seeing your last email but trying to explain why only SPR showed benefit
has slowed me down. I now has some finding on this, please see below.

On Wed, May 03, 2023 at 03:41:25PM -0400, Daniel Jordan wrote:
> On Fri, Apr 21, 2023 at 11:05:59PM +0800, Aaron Lu wrote:
> > On Thu, Apr 20, 2023 at 04:52:01PM -0400, Daniel Jordan wrote:
> > > AMD EPYC 7J13 64-Core Processor (NPS1)
> > >     2 sockets * 64 cores * 2 threads = 256 CPUs
> > >
> > >                       update_load_avg profile%    update_cfs_group profile%
> > > affinity  nr_threads          base  test  diff             base  test  diff
> > >  unbound          96           0.7   0.6  -0.1              0.3   0.6   0.4
> > >  unbound         128           0.8   0.7   0.0              0.3   0.7   0.4
> > >  unbound         160           2.4   1.7  -0.7              1.2   2.3   1.1
> > >  unbound         192           2.3   1.7  -0.6              0.9   2.4   1.5
> > >  unbound         224           0.9   0.9   0.0              0.3   0.6   0.3
> > >  unbound         256           0.4   0.4   0.0              0.1   0.2   0.1
> >
> > Is it possible to show per-node profile for the two functions? I wonder
> > how the per-node profile changes with and without this patch on Milan.
> > And for vanilla kernel, it would be good to know on which node the struct
> > task_group is allocated. I used below script to fetch this info:
> > kretfunc:sched_create_group
> > {
> >         $root = kaddr("root_task_group");
> > 	if (args->parent == $root) {
> > 		return;
> > 	}
> >
> > 	printf("cpu%d, node%d: tg=0x%lx, parent=%s\n", cpu, numaid,
> > 			retval, str(args->parent->css.cgroup->kn->name));
> > }
> 
> That's helpful, nid below comes from this.  The node happened to be different
> between base and test kernels on both machines, so that's one less way the
> experiment is controlled but for the unbound case where tasks are presumably
> spread fairly evenly I'm not sure how much it matters, especially given that
> the per-node profile numbers are fairly close to each other.
> 
> 
> Data below, same parameters and times as the last mail.
> 
> > BTW, is the score(transactions) of the workload stable? If so, how the
> > score change when the patch is applied?
> 
> Transactions seem to be mostly stable but unfortunately regress overall on both
> machines.

Yeah, I noticed your result is pretty stable in that the stddev% is
mostly zero. Mine are not that stable though. And it looks like there
are some wins in the node1 case :)

> FWIW, t-test compares the two sets of ten iterations apiece.  The higher the
> percentage, the higher the confidence that the difference is significant.
> 
> 
> AMD EPYC 7J13 64-Core Processor (NPS1)
>     2 sockets * 64 cores * 2 threads = 256 CPUs
> 
> transactions per second
> 
>                                    diff                 base                test
>                       -----------------   ------------------  ------------------
>                           tps       tps
> affinity  nr_threads  (%diff)  (t-test)       tps  std%  nid      tps  std%  nid
>  unbound          96    -0.8%      100%   128,450    0%    1  127,433    0%    0
>  unbound         128    -1.0%      100%   138,471    0%    1  137,099    0%    0
>  unbound         160    -1.2%      100%   136,829    0%    1  135,170    0%    0
>  unbound         192     0.4%       95%   152,767    0%    1  153,336    0%    0
>  unbound         224    -0.2%       81%   179,946    0%    1  179,620    0%    0
>  unbound         256    -0.2%       71%   203,920    0%    1  203,583    0%    0
>    node0          48     0.1%       46%    69,635    0%    0   69,719    0%    0
>    node0          64    -0.1%       69%    75,213    0%    0   75,163    0%    0
>    node0          80    -0.4%      100%    72,520    0%    0   72,217    0%    0
>    node0          96    -0.2%       89%    81,345    0%    0   81,210    0%    0
>    node0         112    -0.3%       98%    96,174    0%    0   95,855    0%    0
>    node0         128    -0.7%      100%   111,813    0%    0  111,045    0%    0
>    node1          48     0.3%       78%    69,985    1%    1   70,200    1%    1
>    node1          64     0.6%      100%    75,770    0%    1   76,231    0%    1
>    node1          80     0.3%      100%    73,329    0%    1   73,567    0%    1
>    node1          96     0.4%       99%    82,222    0%    1   82,556    0%    1
>    node1         112     0.1%       62%    96,573    0%    1   96,689    0%    1
>    node1         128    -0.2%       69%   111,614    0%    1  111,435    0%    1
>
> update_load_avg profile%
> 
>                                all_nodes             node0             node1
> 		        ----------------  ----------------  ----------------
> affinity  nr_threads    base  test  diff  base  test  diff  base  test  diff
>  unbound          96     0.7   0.6  -0.1   0.7   0.6  -0.1   0.7   0.6  -0.1
>  unbound         128     0.8   0.7  -0.1   0.8   0.7  -0.1   0.8   0.7  -0.1
>  unbound         160     2.3   1.7  -0.7   2.5   1.7  -0.8   2.2   1.6  -0.5
>  unbound         192     2.2   1.6  -0.6   2.5   1.8  -0.7   2.0   1.4  -0.6
>  unbound         224     0.9   0.8  -0.1   1.1   0.7  -0.3   0.8   0.8   0.0
>  unbound         256     0.4   0.4   0.0   0.4   0.4   0.0   0.4   0.4   0.0
>    node0          48     0.7   0.6  -0.1
>    node0          64     0.8   0.7  -0.2
>    node0          80     2.0   1.4  -0.7
>    node0          96     2.3   1.4  -0.9
>    node0         112     1.0   0.8  -0.2
>    node0         128     0.5   0.4   0.0
>    node1          48     0.7   0.6  -0.1
>    node1          64     0.8   0.6  -0.1
>    node1          80     1.4   1.2  -0.2
>    node1          96     1.5   1.3  -0.2
>    node1         112     0.8   0.7  -0.1
>    node1         128     0.4   0.4  -0.1
> 
> update_cfs_group profile%
> 
>                                all_nodes             node0             node1
> 		        ----------------  ----------------  ----------------
> affinity  nr_threads    base  test  diff  base  test  diff  base  test  diff
>  unbound          96     0.3   0.6   0.3   0.3   0.6   0.3   0.3   0.6   0.3
>  unbound         128     0.3   0.6   0.3   0.3   0.6   0.3   0.3   0.7   0.4
>  unbound         160     1.1   2.5   1.4   1.3   2.2   0.9   0.9   2.8   1.9
>  unbound         192     0.9   2.6   1.7   1.1   2.4   1.3   0.7   2.8   2.1
>  unbound         224     0.3   0.8   0.5   0.4   0.6   0.3   0.2   0.9   0.6
>  unbound         256     0.1   0.2   0.1   0.1   0.2   0.1   0.1   0.2   0.1
>    node0          48     0.4   0.6   0.2
>    node0          64     0.3   0.6   0.3
>    node0          80     0.7   0.6  -0.1
>    node0          96     0.6   0.6   0.0
>    node0         112     0.3   0.4   0.1
>    node0         128     0.1   0.2   0.1
>    node1          48     0.3   0.6   0.3
>    node1          64     0.3   0.6   0.3
>    node1          80     0.3   0.6   0.3
>    node1          96     0.3   0.6   0.3
>    node1         112     0.2   0.3   0.2
>    node1         128     0.1   0.2   0.1
>

update_load_avg()'s cost dropped while update_cfs_group()'s cost
increased. I think this is reasonable since the write side only has to
deal with local data now while the read side has to iterate the per-node
tg->load_avg on all nodes.

> 
> Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz
>     2 sockets * 32 cores * 2 thread = 128 CPUs
> 
> transactions per second
> 
>                                    diff                 base                test
>                       -----------------   ------------------  ------------------
>                           tps       tps
> affinity  nr_threads  (%diff)  (t-test)       tps  std%  nid      tps  std%  nid
>  unbound          48    -0.9%      100%    75,500    0%    1   74,834    0%    0
>  unbound          64    -0.4%      100%    81,687    0%    1   81,368    0%    0
>  unbound          80    -0.4%      100%    78,620    0%    1   78,281    0%    0
>  unbound          96    -0.5%       74%    78,949    1%    1   78,580    1%    0
>  unbound         112    -2.9%       87%    94,189    3%    1   91,458    5%    0
>  unbound         128    -1.4%      100%   117,557    0%    1  115,921    0%    0
>    node0          24    -0.7%      100%    38,601    0%    0   38,333    0%    0
>    node0          32    -1.2%      100%    41,539    0%    0   41,038    0%    0
>    node0          40    -1.6%      100%    42,325    0%    0   41,662    0%    0
>    node0          48    -1.3%      100%    41,956    0%    0   41,404    0%    0
>    node0          56    -1.3%      100%    42,115    0%    0   41,569    0%    0
>    node0          64    -1.0%      100%    62,431    0%    0   61,784    0%    0
>    node1          24     0.0%        1%    38,752    0%    1   38,752    0%    1
>    node1          32     0.9%      100%    42,568    0%    1   42,943    0%    1
>    node1          40    -0.2%       87%    43,452    0%    1   43,358    0%    1
>    node1          48    -0.5%      100%    43,047    0%    1   42,831    0%    1
>    node1          56    -0.5%      100%    43,464    0%    1   43,259    0%    1
>    node1          64     0.5%      100%    64,111    0%    1   64,450    0%    1

This looks like mostly a loss for Icelake.

I also tested on the same Icelake 8358 and my result is not entirely
the same to yours:

nr_thread=128
                 score(tps)     update_cfs_group%   update_load_avg%
 6.2.0           97418±0.17%      0.50% - 0.74%       0.69% - 0.93%
this_patch       97029±0.32%      0.68% - 0.89%       0.70% - 0.89%

For the above nr_thread=128 unbound case, the score(tps) is in noise
range, instead of a 1.4% loss in your run. Profile wise, the write
side's cost slightly dropped while the read side's cost slightly
increased. Overall, no big change for nr_thread=128 on this Icelake.
I think this is also expected since in nr_thread=128 case, there are
very few migrations on wake up due to cpu utilization is almost 100% so
this patch shouldn't make an obvious difference.

nr_thread=96
                  score(tps)    update_cfs_group%  update_load_avg%
 6.2.0           59183±0.21%      2.81% - 3.57%       3.48% - 3.76%
this_patch       58397±0.35%      2.70% - 3.01%       2.82% - 3.24%

For this case, there are enough task migrations on wakeup for this patch
to make a difference: the tps dropped about 1.3%, worse than your run.
Profile wise, both write side and read side dropped. But these drops do
not translate to performance gains. I think from the profile, this patch
is doing something good, it's just the tps suggested otherwise.

On another 2S, 224 cpu Sapphire Rapids:

nr_thread=224
                 score          update_cfs_group%   update_load_avg%
6.2.0           93504±4.79%      11.63% - 15.12%      7.00% - 10.31%
this_patch     103040±0.46%       7.08% -  9.08%      4.82% -  6.73%

The above is where this patch helps the most, both profile and score
shows improvement. My finding about why only SPR shows benefit is, I
think this has something to do with SPR's "Ingress Queue overflow" when
many cpus access the same cache line and once that overflow happened,
all those accessing cpus will have their memory operations slowed down.
This is described in section 3.11 of Intel's optimization reference
manual.

To confirm the above explanation, I did the nr_thread=96 run on SPR. To
make sure task migration still happens in this case, some cpus are
offlined and only 128 cpus are left. With fewer threads, the chance of
ingress queue overflow is much lower:

nr_thread=96 with cpu offlined to 128c left (32cores/64cpus on each socket)

                 score          update_cfs_group%          update_load_avg%
6.2.0           74878±0.58%       3.47% - 4.90%               3.59% - 4.42%
this_patch      75671±0.24%       2.66% - 3.55%               2.71% - 3.44%

Profile wise, the two functions dropped to near Icelake level, still
higher than Icelake but much better than nr_thread=224 case. When
comparing base line with this patch, it follows what I saw on Icelake:
the two functions' cost dropped but that did not translate to
performance increase(average is slightly higer but it's in noise range).

Base on my current understanding, the summary is:
- Running this workload with nr_thread=224 on SPR, the ingress queue
  will overflow and that will slow things down. This patch helps
  performance mainly because it transform the "many cpus accessing the
  same cacheline" scenario to "many cpus accessing two cachelines" and
  that can reduce the likelyhood of ingress queue overflow and thus,
  helps performance;
- On Icelake with high nr_threads but not too high that would cause
  100% cpu utilization, the two functions' cost will drop a little but
  performance did not improve(it actually regressed a little);
- On SPR when there is no ingress queue overflow, it's similar to
  Icelake: the two functions' cost will drop but performance did not
  improve.
