Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5603664B94D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbiLMQJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiLMQJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:09:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD811F2F0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670947782; x=1702483782;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HXHtDbsJDvbj9SoUBDKrSB68I6IuxyUKrEydRexS1Vc=;
  b=VosHop4ROoVbvAaRAfkaQ0YlYw+036DSIWWxBe5LRRhWho6GxwsdiGWy
   yzrEPB8nNRwE0iz9hHf5h9PeUKqK4TYR0835xQ+ekx+jMT4POIDhd91uy
   UC2sMeoNH2wYtRcesx0dNgv1apyYkvN1qDMSCi3kIuITorVih8s66/n81
   a218dakB7BzbCN8FydfpOE2eOpFG5U3dnChDw8uTmBPYitca30zKUFHvS
   KaAcfoaRm6JfGdeqLxSfcIStHtBWMi5JlFdAPNiH2OAvSl7PZzep8EGmz
   SrTPUpvAr7J4OxuEXtdAwPLZuqseEc5s9wP/GTJmenZg4yZ9RWTQPZYmA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="345230565"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="345230565"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 08:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="626403508"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="626403508"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2022 08:09:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 08:09:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 08:09:37 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 08:09:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFGM3kNPpAMBn0T3U3ToDJcyN8U+UY24dzaIZwOz0Ev+PLVyBfGrGmF9rcbTr1WUWkLynsXhU1bwGOWjQOCmVPqfI3LFpzqeVmvvJu6JojO2w9hMtOz5SWDUXqUUgUcNymutSgfovWBQ7ATB2FbyR19ipfQFP5bB3snf3xnw82UBYAd/Y+oWgfyd6LJpPOp5F9jOL+xqPA5lcIGgn5dcUJTtuHMnPxPMTUQGbO51bRvOZpi4uG3M+hjMgqETChBe+pW3XFMD9vkVZVoqOC48E6JSZs1oovKA5Aq3pJykAw5pbutLrCm0REBRkZF01OCC82kRvIpfC6qCK8VS4Pb+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kA6pCLzEIUjW1BaOIVJSbH3XGTjZ2ial9zzSKWcXAvY=;
 b=jfb4itw/WVZbLQA3v6oJXL6VwJnju7uHRUDi5YuWnAlpU7gQNpcAVojT7OWaotRHpp0bvsPxJPvwzqqvnDRtptqLAAdGx2mHh+Eta/9FoF/f3NyFA4ndFvO7oLlNmP4/e5sSv1j28U6b0ug76zI/HyUan/PsTHPYRvY59V6aFqK1I/K4cnr/d2U/9DYtguZdHWtQU+wuFfzNQ1owkXWTLo8Roy+Qu54gbGZHRaIdG0faz7nWjeS+JGC0Z4b8tT+MY88DVriQYcbjP2n9je1JY/29WhkmdRHciDaSCKXTVT2uJ1EWUQ9+sTC67GZC9HC4hPyXrN8+AuLqNxx8XmYegw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA0PR11MB7792.namprd11.prod.outlook.com (2603:10b6:208:409::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 16:09:35 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 16:09:35 +0000
Date:   Wed, 14 Dec 2022 00:09:15 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     chenying <chenying.kernel@bytedance.com>
CC:     Abel Wu <wuyun.abel@bytedance.com>, <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Reduce rq lock contention in load_balance()
Message-ID: <Y5ijqxqKPVxLebkh@chenyu5-mobl1>
References: <ef54b130-e727-5ed1-1a4e-1e3c0a713b98@bytedance.com>
 <c086b5fb-681e-d104-1e11-873ed5444c5c@bytedance.com>
 <11222824-9a23-0766-70f3-709ab2fc6cc0@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <11222824-9a23-0766-70f3-709ab2fc6cc0@bytedance.com>
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA0PR11MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f1d0fc-5b05-47d8-3afe-08dadd246c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDxseJdDQ4oWW+7DyDDgRjiIx+aAMlmQEoyu0whQcnMCtSUfePOx5ubnxUco9689rp6dk0+MIBTMF3yoHoj5OkLw1zBhM/L8xM1XrlLvPD4g7iSGh61OqDVsjPEoVcDKuCZKZ4dDYOHxaiWkRoBsu2BEXxoVt+n5uOLRChLEZTYPlSLMfI9rjl/f02hA1L5vBwKEez7YNtucdWhBcBJYKdmUbf8n9b93umx5GCXsXqT70EbFJYSvhZ+xxXNOBRj94Ojm269Us9n1gmvN/G48OKCAu2tjdB7/11fym89JXtsA2ilQsAhy0YDo3b7AP8RJ+//n2q9kf7bF5/y3KDJAvwQ/p+O9+2dhLw3odw+aNyBWBvplgvflnj9U5rzGXUO86FGLUfVcSUl1ShRD7k+ZG/3Gx4lSTA05NkaEuV1hTKQJWgLcAt6I7Heg7bAjz4d1CLCmnoIYoxjrbqKfU5RS/sxopQ2DT5fXt4eEmfPL98IpHt2TS8jqy/l5WRZN5QU6xL9wkWmPC3fFDCAL8ep5E7W5wn3vscmPaudiwS26MIKukfnhjL6fVtcYHetS68++Myf/RxYhtkr2yIqRiUcN2u4k+2iK13qb/JsoqPKsWLinFlxuEApw7jujQ5e+yjIN4XKl3UCyYbC26er9LIE4aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199015)(86362001)(66946007)(4001150100001)(9686003)(6916009)(83380400001)(54906003)(5660300002)(38100700002)(8936002)(66556008)(41300700001)(8676002)(66476007)(4326008)(7416002)(6486002)(6666004)(33716001)(316002)(2906002)(82960400001)(6506007)(6512007)(26005)(186003)(53546011)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IASOpVZS39HCdHGFakZ/QvMnqBouaMtbzkxfNLnblr944uBYG6vjd+fAqK3g?=
 =?us-ascii?Q?47qhrzI8FU2p3gmYUNFAXVvdL0WTLQ4WgZcCLuhC1/1OnGsrZkk7492A4GEi?=
 =?us-ascii?Q?w4jVk8Rg8F6b7oojm/fbP4fzcJgpGlfItKqUU7sLmKWquL7/PvUqMMvvPWix?=
 =?us-ascii?Q?OnQGQHyVn5cRO1JvGbsmzfclbbQiBjwB6PCnqtJA0jep8PnMUlFkMMnzOcXS?=
 =?us-ascii?Q?YajnEQNaL+rSbj7GxW6eZeMH4eHeetU3E/r9XYeXM2tQCpdQiNYYYOIYOQYM?=
 =?us-ascii?Q?MtgbBMAARV8cQPmgxkC2SE89AbWktWlvoDeqiUXL/9wAMN8eO7FJtZ+Wkq6Z?=
 =?us-ascii?Q?7baIPzlZmUdak5jVOEi0wZsAiKk+qvJyhfnpboy0VnIyesS5Kq2nRKIaVqrR?=
 =?us-ascii?Q?1QiF9jSqB1Rr0sXnGUBy0yt26VcAYBdbSH+0v6YFssxj72/7V7QT8beE5fW3?=
 =?us-ascii?Q?omImtafiUSsD0Bby9wQPMkrHt4gNb5AbxFb5rzBxdxbh0y6ZRysQ7FLEDGIX?=
 =?us-ascii?Q?0XMmWUQI1jKH0wkUdSAMkjJz1xY6DFWZG4pPFp8CIYeiHI3WP0KdeA/VLUvw?=
 =?us-ascii?Q?JOsvyAKMTQNvBuTDOcQpC0b/r1zFx5dxB8UceatTlA7ei/3i98MX4aDZ0BdZ?=
 =?us-ascii?Q?fF/zEEsGEJqCxviATcweOt3InUfVUxTupL04CfyXW8XUFGzNJwl4JojKyFt7?=
 =?us-ascii?Q?sVZuBBTRaGQYI4nUnrljPi+xle6SkRlg8wsSPmgXKHVws/9Qh1EQ4Z6Llrxk?=
 =?us-ascii?Q?igNB00tnDlS0Dei5InVt8Z9s4Qa/Ol595Y0I9HZIJWhTDL2JHTQEAMAzm0VY?=
 =?us-ascii?Q?WKA5ctFmj9FcvIjhN3hEBj3X0Tf5VQbUpd+MIZFvB6UzKhDz2J+m/UizNdqK?=
 =?us-ascii?Q?sQeVj7e0Wlp9sfa5/twDmCJ/eXEHUR+5WV8sa4UyuSoC0B9HxzWoOboTwcB9?=
 =?us-ascii?Q?CsLZHf7znFlM2kALoDMRA4hY95Cpq+6r+aAf6HfMWr5Byl4o0QQgZyViPA6f?=
 =?us-ascii?Q?yQMkiEmfqwwC623jvR/CwDrc07O5baESEGyDS7ANKC4+8DmJwqKaF6zi+I9G?=
 =?us-ascii?Q?4hhFde66ssv3+3PMBUY4Jq+TMotanxduuVghozpSaLYr623KNq0fiwPj2bpP?=
 =?us-ascii?Q?bzq5DIKwJVIP2uAhssBemHm0kQol7UT1/0kKwzXdqdhJruIcYyaIoSc2PYYC?=
 =?us-ascii?Q?CruEbrHNFCqVZHQKnb6yd/YUuQ8Rj7DLRPI+GmIU2ngrf92D4X7fXY2wQlSK?=
 =?us-ascii?Q?pumDLGJNGgo3BaV6fj3W8ggugymRRm89E5PEGaRr/ZYStM/3xiY1AkTtqMjF?=
 =?us-ascii?Q?nY74hJAfqMJ8cH4nE4PJQInNPRTr0bfLEVD+92LwI15imymg3NfAH0OY7OKm?=
 =?us-ascii?Q?m3cVxXdzTnjkQO2e1VIOb6bGuRAB5A2qlzeLd2Pq6j1NnPAR45BUJEPI+9Il?=
 =?us-ascii?Q?ZX/lmj2/IjNuz/04DjSRGJnTm8IqxQsQd6PO2HLPsvGxaFvaBHKKZEZXgpAM?=
 =?us-ascii?Q?w0QCeKBTtHWgnfdf/UbWPoFLPPolIgKV4QIIjYiKnMFDjGc91q+gOKIXlUFE?=
 =?us-ascii?Q?ats0cr+Rb6uObB8k/8taHqnAyoOXDu8h4BJtm+Qc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f1d0fc-5b05-47d8-3afe-08dadd246c3e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 16:09:35.2344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuPsto6vfFGz7wbJ65f6dgbDk5VCLILUP+YfY8ZodSFkOBKxmAyN2+ufoXLMjRF8kDj0Fyv16dSI/x/Q+q49Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7792
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-13 at 11:13:24 +0800, chenying wrote:
> From: chenying <chenying.kernel@bytedance.com>
> 
> When doing newidle load balancing, we may have lock contention on rq->lock
> while finding the same busiest rq on multiple cpus. However, it is often
> the case that after the first load balancing, the busiest-rq may not be the
> busiest anymore. This may lead to pointless waits for locks.
> 
> Add rq->balancing to quickly check if the busiest rq has been selected
> in load_balance on other cpu. If it has been selected, clear the busiest
> rq's
> cpu from load_balance_mask and then goto refind.
> 
> The test results show that this patch brings ~30% rq lock contentions
> reduced and no scheduling latency degradation.
> 
> unpatched:
> lock_stat version 0.4
> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>                               class name    con-bounces    contentions
> waittime-min   waittime-max waittime-total   waittime-avg acq-bounces
> acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 
>                                &rq->lock:         25532          26471
> 0.09          22.86       42250.81           1.60 1232063        6586225
> 0.05          40.54    10280028.19       1.56
>                                ---------
>                                &rq->lock           1310 [<0000000081600630>]
> __schedule+0xa9/0x800
>                                &rq->lock           1430 [<00000000754f510d>]
> try_to_wake_up+0x206/0x710
>                                &rq->lock          15426 [<0000000020af4cb5>]
> update_blocked_averages+0x30/0x6f0
>                                &rq->lock           1449 [<00000000dc949053>]
> _nohz_idle_balance+0x116/0x250
>                                ---------
>                                &rq->lock           3329 [<00000000754f510d>]
> try_to_wake_up+0x206/0x710
>                                &rq->lock           1241 [<0000000081600630>]
> __schedule+0xa9/0x800
>                                &rq->lock          15480 [<0000000020af4cb5>]
> update_blocked_averages+0x30/0x6f0
>                                &rq->lock           5333 [<000000004969102f>]
> load_balance+0x3b7/0xe40
>
Does the scenario above indicate that one CPU is trying to grab the rq lock
in either __schedule or try_to_wake_up or update_blocked_averages or
_nohz_idle_balance.
but it could be grabbed by another CPU at load_balance+0x3b7/0xe40,
and this patch is trying to avoid grabbing the rq lock in load_balance()
as much as possible?
And it seems that update_blocked_averages is quite contended too.
> patched:
> lock_stat version 0.4
> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>                               class name    con-bounces    contentions
> waittime-min   waittime-max waittime-total   waittime-avg acq-bounces
> acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
> .............................................................................................................................................................................................................................
> 
>                                &rq->lock:         17497          18300
> 0.09          23.15       32152.22           1.76 1137409        6484176
> 0.05          40.19    10125220.60       1.56
>                                ---------
>                                &rq->lock          12298 [<000000004314e22f>]
> update_blocked_averages+0x30/0x6f0
>                                &rq->lock           1005 [<000000005b222b90>]
> __schedule+0xa9/0x800
>                                &rq->lock           1271 [<00000000c7a66a89>]
> try_to_wake_up+0x206/0x710
>                                &rq->lock           1380 [<00000000eac23b6b>]
> load_balance+0x560/0xe70
>                                ---------
>                                &rq->lock           2962 [<00000000c7a66a89>]
> try_to_wake_up+0x206/0x710
>                                &rq->lock          11844 [<000000004314e22f>]
> update_blocked_averages+0x30/0x6f0
>                                &rq->lock            592 [<0000000032421516>]
> scheduler_tick+0x4f/0xf0
>                                &rq->lock           1243 [<000000005b222b90>]
> __schedule+0xa9/0x800
> 
> unpatched:
>  # ./runqlat 60 1
> 
>     usecs               : count     distribution
>          0 -> 1          : 1172     |       |
>          2 -> 3          : 210063   |************************       |
>          4 -> 7          : 337576 |****************************************|
>          8 -> 15         : 24555    |**       |
>         16 -> 31         : 13598    |*       |
>         32 -> 63         : 779      |       |
>         64 -> 127        : 230      |       |
>        128 -> 255        : 83       |       |
>        256 -> 511        : 54       |       |
>        512 -> 1023       : 62       |       |
>       1024 -> 2047       : 123      |       |
>       2048 -> 4095       : 283      |       |
>       4096 -> 8191       : 1362     |       |
>       8192 -> 16383      : 2775     |       |
>      16384 -> 32767      : 52352    |******       |
>      32768 -> 65535      : 14       |       |
>      65536 -> 131071     : 140      |       |
> 
>  patched:
>  # ./runqlat 60 1
> 
>      usecs               : count     distribution
>          0 -> 1          : 1091     |       |
>          2 -> 3          : 205259   |***********************       |
>          4 -> 7          : 351620 |****************************************|
>          8 -> 15         : 27812    |***       |
>         16 -> 31         : 13971    |*       |
>         32 -> 63         : 727      |       |
>         64 -> 127        : 198      |       |
>        128 -> 255        : 103      |       |
>        256 -> 511        : 61       |       |
>        512 -> 1023       : 45       |       |
>       1024 -> 2047       : 108      |       |
>       2048 -> 4095       : 271      |       |
>       4096 -> 8191       : 1342     |       |
>       8192 -> 16383      : 2732     |       |
>      16384 -> 32767      : 49367    |*****       |
>      32768 -> 65535      : 8        |       |
>      65536 -> 131071     : 183      |       |
> 
> Below is the script to run the sysbench workload:
> 
>         #!/bin/bash
> 
>         mkdir /sys/fs/cgroup/cpuset/test1
>         echo 12,14,16,18,20,22 > /sys/fs/cgroup/cpuset/test1/cpuset.cpus
>         echo 0 > /sys/fs/cgroup/cpuset/test1/cpuset.mems
> 
>         mkdir /sys/fs/cgroup/cpuset/test2
>         echo
> 0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46 >
> /sys/fs/cgroup/cpuset/test2/cpuset.cpus
>         echo 0 > /sys/fs/cgroup/cpuset/test2/cpuset.mems
> 
>         cgexec -g cpuset:test1 sysbench --test=cpu --cpu-max-prime=200000
> run --num-threads=24 --rate=100 --time=6000 &
>         cgexec -g cpuset:test2 sysbench --test=cpu --cpu-max-prime=200000
> run --num-threads=96 --rate=100 --time=6000 &
>
May I know how many CPUs are there in the system, 46 * 2 ? So this test is
to saturate test1 and idle CPUs in test2 try to continously pull task from test1
but fail due to affinity, which introduce rq lock contention?
> Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
> Signed-off-by: chenying <chenying.kernel@bytedance.com>
> ---
>  kernel/sched/core.c  |  1 +
>  kernel/sched/fair.c  | 11 +++++++++++
>  kernel/sched/sched.h |  1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index daff72f00385..ca4fa84c8751 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9737,6 +9737,7 @@ void __init sched_init(void)
>                 rq->rd = NULL;
>                 rq->cpu_capacity = rq->cpu_capacity_orig =
> SCHED_CAPACITY_SCALE;
>                 rq->balance_callback = &balance_push_callback;
> +               rq->balancing = false;
Maybe rq->balancing = 0 because balancing is not bool.
>                 rq->active_balance = 0;
>                 rq->next_balance = jiffies;
>                 rq->push_cpu = 0;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e4a0b8bd941c..aeb4fa9ac93a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10295,6 +10295,7 @@ static int load_balance(int this_cpu, struct rq
> *this_rq,
>                 goto out_balanced;
>         }
> 
> +refind:
>         busiest = find_busiest_queue(&env, group);
>         if (!busiest) {
>                 schedstat_inc(sd->lb_nobusyq[idle]);
> @@ -10303,6 +10304,14 @@ static int load_balance(int this_cpu, struct rq
> *this_rq,
> 
>         WARN_ON_ONCE(busiest == env.dst_rq);
> 
> +       if (READ_ONCE(busiest->balancing)) {
rq->balancing is not protected by lock so there could be race condition,
but I think it is ok because this could be a trade-off.
> +               __cpumask_clear_cpu(cpu_of(busiest), cpus);
> +               if (cpumask_intersects(sched_group_span(group), cpus))
> +                       goto refind;
> +
> +               goto out_balanced;
> +       }
> +
>         schedstat_add(sd->lb_imbalance[idle], env.imbalance);
> 
>         env.src_cpu = busiest->cpu;
> @@ -10323,6 +10332,7 @@ static int load_balance(int this_cpu, struct rq
> *this_rq,
>  more_balance:
>                 rq_lock_irqsave(busiest, &rf);
>                 update_rq_clock(busiest);
> +               WRITE_ONCE(busiest->balancing, true);
		WRITE_ONCE(busiest->balancing, 1)
> 
>                 /*
>                  * cur_ld_moved - load moved in current iteration
> @@ -10338,6 +10348,7 @@ static int load_balance(int this_cpu, struct rq
> *this_rq,
>                  * See task_rq_lock() family for the details.
>                  */
> 
> +               WRITE_ONCE(busiest->balancing, false);
		WRITE_ONCE(busiest->balancing, 0)

thanks,
Chenyu
