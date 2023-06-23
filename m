Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42B073BA38
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjFWOdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjFWOdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:33:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85168A1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687530823; x=1719066823;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P8sjimN7R1klDRn01Mc403ECRM4fIBAG3skspYfECzo=;
  b=dhEdasGZTJG2hJ7bcLmXPa2V+xtZj0dQZuaAc4KcreV9j6pIl3zELH1G
   Fzlcg/lwxOTRCLR0Xk+t38s1XwDFFYYGbMElPSL98t1ppoxw7vGiqCnRx
   rsN5Gb6zVBOILc/moOUCH1Z9x2n9nGNX9eW7pgv5ihqzomlnaL61tRG4I
   2LpnCr1+Cg45NMaonNlnKlVmasFRJc4j8cerp5retKTAc24tZfyiW3B2h
   FQMfwvpkM2gtg0iz+3db9UwhmCdpiSZYprh7aTOvwssUqvgL7x1/G9ipt
   JNaivDyBhNpiTEvq+eNN8XybKE6c/RBWLiIUsc1ubjTaFvtTzTZO6uI47
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="447152055"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="447152055"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 07:33:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="828389194"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="828389194"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jun 2023 07:33:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 07:33:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 07:33:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 07:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jr0h8GWWB+YBzAi0idITZGZApUmV5bFX0OWRLam7yzJV8tPoisV6AV4f+pmNGl/SYNZ9b71WxVeFYWACc4tFuFa50x+6mZpXCOfnmb+yL/67ilpnuZmiIZrh2atPGCC+spLEvnjv4LDWa1dgYjPZwJ4bkTvQLK/Mi1OoMiVYLyIRPXcgNHtH4lzfSaESc+MLHDGgQKQPqP5fcrFpb5Efyyd5rHy5lwK+rzgyyhQtuihN6PoUO6YT8BXn2v7VkCfsgFtFixyW5bc9UvHyuPX5mBr77XoKkL3jCwe3kw38RSjJ7mJeFxznvV2DtxXBZbPkJzN9LJHD1cOeSknAxK6Sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ROHR6bWTf3FpJJadoTlIzVtA7crdgm5NC7ER8i86Rg=;
 b=TXD06AYOZUbR6E4PMD1PM858xBkzxQCTteE444FxESyAIilNdyINL/OSDQu0TWUMzaEXlv3Pn4LWfzxHpLqaNsufdJKqIMVenYheWe+ufDyjAvjPXf8iofPEM2briIBHgVCAJvBB4Mlb+I3qXxauR3qq/XSxdqIM2FyiYTZcYePUBfV2X+5/sLpaVZS5a4TJ3+PUwrSPgVU664SYuvr0UDTrdomwKJUxBNrWIDYwK84opTuHkzVsJlVmwCef2rYECTMkN2dDdxlhZBsA+CambA34bjXb/uu9ccCSh9jtWOp8DiazC9Rdjpvwb0qlWDV8SqIns0guhiCxgFb3T+Q/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by MN0PR11MB6229.namprd11.prod.outlook.com (2603:10b6:208:3c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 14:33:40 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::3cc2:6622:cce5:cd02]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::3cc2:6622:cce5:cd02%5]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 14:33:40 +0000
Date:   Fri, 23 Jun 2023 22:33:23 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] sched/fair: Calculate the scan depth for idle
 balance based on system utilization
Message-ID: <ZJWtM1rgC52twqPS@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1686554037.git.yu.c.chen@intel.com>
 <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
 <20230621111721.GA2053369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230621111721.GA2053369@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To CY5PR11MB6211.namprd11.prod.outlook.com
 (2603:10b6:930:25::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6211:EE_|MN0PR11MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: af35ee58-9b5d-4377-3e76-08db73f6d664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XccQgm6wd1FJhoqa9PpSHmgFkJyU2SyTtAXRRGV+17JWYuvk9enwXLtleLb2jJTMGs8VJMxGTs67Ckz/my3MKD0jl5H1hmag1AhoSXrCVstRk9dg7OJewpo8drfVxjKAiR4x0YgoF3xtYAPrvaTNLtvl2C8BIoFqkdV+7oBkW7VxJEvwQGJ4j6sOjm+TDWZu0sh1CQoR3zyWz7xggU14K8HznYnAWH7pbNcNoub6Pz1ruJbZH2fEQsgWLQPPJPwyF2Dgd9Xmqav+xQ41rjsTk4Vg7Ewr0s4CVZOtOeUxMNrxp9859uvVjDcFx7bBqm/EjZFGHw+RzI/NlVEM3rlyZHevMf2mQZmQxMGxuDOtZMSkn1ZLQhqpL97EanGAXhI3fK08UGop8Usb7NqpTpkh3q/7Ih/xt40hdymETkTUI6rzwyZ4D0RM4rrqnfn/u+b/PUoN4LRH9Mb10vvGBEnKcAl+IDRJlZuezDsEh0pAeeWHlCqaa18xUYGWYZjL5BbymsR0r63SXK51W28rm9yNgM2v0uK8bcxoomHEvMueQVVUgt87aQqWpM4XafPGGzvp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(82960400001)(38100700002)(86362001)(316002)(66476007)(66556008)(8936002)(41300700001)(8676002)(66946007)(4326008)(7416002)(5660300002)(6506007)(83380400001)(53546011)(6486002)(478600001)(6666004)(54906003)(6512007)(186003)(6916009)(2906002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T9Ot8hXCDLsEj3GDHhFSkrndhwIuWUqi41paeA1P3BgjqAQlLEZIO5g1chxr?=
 =?us-ascii?Q?65qW+Hmk7QG1h/3RAB1N6cBPU6yIf8LYlRxqwescYvzSjrv+9ArSEHGm7tTY?=
 =?us-ascii?Q?NO0knDCNUAyM//fn1u2MJC82HrQGsxvX1SkU9oA8xXvFcz4kQoj5CDBTSfXE?=
 =?us-ascii?Q?wa94Nw1D05jdEdk1DJAVc8wm5hhkhkIavMiev+J4BR1JT7ma/Auugjm7+OHa?=
 =?us-ascii?Q?2khvuoyU2CnpPrxBsnlGPQYcA6coqENc27m8X2V1r+zYYxgPCAaTeE5DOsPd?=
 =?us-ascii?Q?5b+KELAtR5IhPOXrgNxaU/NKKDjyHbGVmRemhEI7eCLkD4br+N9/lz7AvKIo?=
 =?us-ascii?Q?6xIfSOp1WkT12+AwyOg13kDytrK3kQlpQGDMNW4ayztwm4HkxCSvvIPSo7FI?=
 =?us-ascii?Q?pBRMdxIoiT2D1/xOJav3hMSe566ADTQWLPKUph6bGGAsWM4Idewj65HriSiB?=
 =?us-ascii?Q?qTERNloEBrJPFYvdftAq/Pe2QLANS0GN6BMaaFDJ/PS9s414X29HBMfPL9Bc?=
 =?us-ascii?Q?VYR5AjPfUMEXRUUMbE/U66hlJnZyt9EX2EffWoyPubYJ+uMnnDeuwQjUkaa8?=
 =?us-ascii?Q?15LNZXFAgUZmjxMD4/18RP39ADQkOnV3N4wVAVg5Zgj9xoI+V/4O6w/ioXEk?=
 =?us-ascii?Q?yK8WKtaWxIy25K8/synirbKJNvmgm8EBPMHmGS0oegUrz2lH1++z1LLgo3PD?=
 =?us-ascii?Q?n5bM0r/6AbbRxAmZ9N7Olny15HdBAZHvACUzR5x6vWhX1ifj3uMPJxHv3dc5?=
 =?us-ascii?Q?j4NwVL+MgeFQ8khTMufExDun0sLJBD9KS08R1+KgLx1DCWxMus02LUuunoOe?=
 =?us-ascii?Q?vuIm+Cpp31toIJbRiS3YxwddMi/mD7TEleaqoJhNpg4RfKrR0BMd/kzKfF36?=
 =?us-ascii?Q?PzEmUt90B/dzL2Om5h7J1WnK6Q2bWv7LzWGGJ4dZz3C1LnDd6VdQCTUvpY0t?=
 =?us-ascii?Q?sFSmSjKzrIPZPse5CYsUX0cP81nA+yAKcOH7q8k+jw2QUKekovZ9YV/KDWEw?=
 =?us-ascii?Q?5839O+C5RuzMKS8N4YhtRvMEMTZw67c7b3o2mTxHtbs4EtRZREKpmryQ0dsv?=
 =?us-ascii?Q?pgRpPrMUQcjY1P6kC1B8+I+RP+2L6Zwt3jNVoQZLpu+iYKmhrUF0DrSDwSSA?=
 =?us-ascii?Q?DAujuelqIFRgfWdSd5cZH6LlprIt2Oiv01XEy3DYQEpNHx4DKRW8wZYtOWbX?=
 =?us-ascii?Q?y4+K23mmdVQW3W3F9flCDbbyUGnUsbfARLf5GmHAvyJSdGs+l9deIzLG3C+h?=
 =?us-ascii?Q?zoNLw3h3wIOI7iOnq3bcA34ZrEyV7HNkR9JdPmGHVQf+camzGvq4f3qrNT3X?=
 =?us-ascii?Q?FZWoFwJX8eXm928UNBY0eFyiBxWdLfdybMjFvuR5RHEnw61OOMzlDyvOfrzu?=
 =?us-ascii?Q?o8Dx95YBUOWQXrnW0iG8p3iRnSVv+D+534tZvZDgvuWq5EKh2QpLk7hQ8D0I?=
 =?us-ascii?Q?8mJVrMqH4KPFEJgUw8AUAfO59rmm2w24M+BvRptnTTlz4H3L7qvjl8fY7zDD?=
 =?us-ascii?Q?GV8LlUl+z6btqsnLnWQ/CcutEUdEq0ZxOeaqa2F05KNiN8zyX2VylkMc5HnB?=
 =?us-ascii?Q?5cMoYyyylvlkefaYjbFrYv5NwfMukZHfNnqjfVj8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af35ee58-9b5d-4377-3e76-08db73f6d664
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6211.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 14:33:40.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iu6V9EmMX0hQuWIVwETe/VUi86G3HKmW0Yqm5DzJwneqgqDHuUZoRZDZDND7cG+x0kUB4BSwy+IJP4hoUZ6bbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6229
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
On 2023-06-21 at 13:17:21 +0200, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 12:18:57AM +0800, Chen Yu wrote:
> > When CPU is about to enter idle, it invokes newidle_balance() to pull
> > some tasks from other runqueues. Although there is per domain
> > max_newidle_lb_cost to throttle the newidle_balance(), it would be
> > good to further limit the scan based on overall system utilization.
> > The reason is that there is no limitation for newidle_balance() to
> > launch this balance simultaneously on multiple CPUs. Since each
> > newidle_balance() has to traverse all the CPUs to calculate the
> > statistics one by one, this total time cost on newidle_balance()
> > could be O(n^2). This is not good for performance or power saving.
> 
> Another possible solution is to keep struct sg_lb_stats in
> sd->child->shared (below the NUMA domains) and put a lock around it.
> 
> Then have update_sd_lb_stats() do something like:
> 
> 	struct sg_lb_stats *sgs = &sds->sgs;
> 
> 	if (raw_spin_trylock(&sds->sg_lock)) {
> 		struct sg_lb_stats tmp;
> 
> 		... collect tmp
> 
> 		sds->sgs = tmp;
> 		raw_spin_unlock(&sds->sg_lock);
> 	}
> 
> 	... use sgs
> 
> Then you know you've always got a 'recent' copy but avoid the concurrent
> updates.
Thanks for taking a look and gave the suggestions! Yes, this is a good idea, by
doing this we can further limit the number of CPU to do update in parallel, and
allow the newidle CPU to reuse the data for idle load balance from others.
This lock only allow 1 CPU in that domain to iterate the whole group, and the
bottleneck might reply on how fast the CPU who grabs the lock can finish
collecting the tmp sgs data. For MC domain, it would not take too much time, and for
higher domains between MC and NUMA domain, it depends on how many CPUs there are in that
domain. I'll create one prototype based on your suggestion and measure the test data.

thanks,
Chenyu
