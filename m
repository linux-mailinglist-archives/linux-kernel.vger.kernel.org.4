Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97DA6D8DD7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjDFDFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjDFDEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:04:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00224102
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 20:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680750244; x=1712286244;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0z83+7TRoEMam/nvOdQczD6VP8z02T6w2gJjQ3L8Vgg=;
  b=Vj2Gr7jqhwM0QX2N9xzp7Z1iddc9SAiF4y2Mk726mMTrqxljL+OOMi6H
   S7GHyh8eZ/TUIi3Bcq3yKswEylWPEYYekH1qv1ml7JNu0zKB2f73IUiHt
   i4incR/lT9I4seXkq5zoWXcijaiV6zR83O+E7G354xuDOaz3qJbSZpszD
   81IfGic6jdUC09F17vOa97NGdkuOMfnWZDu7rjgQuCO3OsTXyEczxt2wm
   Oo8aDluiuRJ0dEiFmYQVzYiJZMglwrIMcRGcVKiOSrMmxafIjoBINq/yc
   l0w9ECZZueljh60JP4kBDOUJhu8QopPu+LsDR7bH8dX2woher66iVw9Xm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="341353277"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="341353277"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 20:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="686974649"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="686974649"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2023 20:04:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 20:04:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 20:04:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 20:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNBHf8WD2RefZULAIvJi5wpMiBOCeAk6pwmOG7aurrgNznbnMsPiWtk/wlaMx93gnU91a1rUZupgPylirjEtFjLDbXx9eaj5NIHpK0soy8fWaoapipNbvNoCA7IzEeBMQAxIgTKF968H1weKOVGj3VAloydElQlPGQsd2xCWlwvEL+Awh135z8R/HHSTga/tpm6cu6T/Nvc/BOF5yiAIqfX6WEpEsW7EJuGF1wizgE0m/hROfp6I84RJSCcMfuUvqX9wm2BM3QjN34kcYPgSp7/abQcEXDeSiA/XFBVrXX87jd+EpoX4vvr+MmY4fVykQHc8e5YC4+i5Lq3H+Gi4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WX06qdn6TsxZSc/6J538YykB1I7StXDjSdzEUk6dOI=;
 b=GuEYmb54KwRpRiHsgc2LOhgE5qYfTm7lapIKU00ig/2Zj0EWTB8T7K5fQIFkHZbAviHIGevKIlUdvjshWjfBjti8VVwQ2zv6sdeaNKcBnzm+/d6iVx098z2NH/b9R1aDxykTeRrlp7FKN69EPCoJL/cGWSH4MHQ7QIv4V/EaRzJph0Qzk/GkS846z7ihF/vkGFpEM0W/WaPjTyJBpiuICdexCDsHoKExVV3PTaBkvMcc5TLiUFJAERhbvzGBrV6HHAVtbQvWSQnBdsT/hQ2bcxDGtoMlMP5JlyomzpJyTv20TwH5Ks2IN07GeXhQY8DSKxZlO/u6Ab6sqjtCvVjcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 03:04:01 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 03:04:01 +0000
Date:   Thu, 6 Apr 2023 11:03:41 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@kernel.org>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <corbet@lwn.net>, <qyousef@layalina.io>, <chris.hyser@oracle.com>,
        <patrick.bellasi@matbug.net>, <pjt@google.com>, <pavel@ucw.cz>,
        <qperret@google.com>, <tim.c.chen@linux.intel.com>,
        <joshdon@google.com>, <timj@gnu.org>, <kprateek.nayak@amd.com>,
        <youssefesmat@chromium.org>, <joel@joelfernandes.org>,
        <efault@gmx.de>
Subject: Re: [PATCH 06/17] sched/fair: Add lag based placement
Message-ID: <ZC42jZiAp9JNAqj7@chenyu5-mobl1>
References: <20230328092622.062917921@infradead.org>
 <20230328110353.988000317@infradead.org>
 <ZCqZzp98q806qfip@chenyu5-mobl1>
 <20230405094720.GA4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230405094720.GA4253@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c17087-1b6a-4e2f-4ec0-08db364b9254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3wr+gJvN9zW9MlribIvE3QOr7QvJPXIRozOuPYPD4Wv0wX+CHU6j4MX1L99t6Momjw+Mhh3jkrujZ62t42ZqskgiFG42RfsVbBb58ff4QzH2pHwKFVO3DQjSAVMkvNhPtYr4UVvTZpNrlsIpoX70eG6ol/vxt35PlZpCsygGetIhfBJiucVkHRI4YcLbr4R3tbPgEAEpBUK8OSUAozXXc+TtuUJRxkomEsf3VmbyG0WHyy4GzSpGCU20v08jDZGOB+JORLohvkOH8MrGr2ugyZBtmkU44bX5V8BwD7PFAZI9CL3WEocvAlJuBuR0arlKQ2LvfJTR5E82dpQpZjDfrwFN6r9vfLbVzIQ53R3I9/WJoJHO9JughBzOf895AvWoMemYoFlD0sisj0WkR9vgBAM64aWkIOw/b5BP2A+VffCP7YRCRbIwcrfTv2+oJdSYEne8tPGjV83fVSfmx6uLkYo7s+q+zl9V8p9ioxvD4DfDMZumssS27jwTRFYXN/BXd4Th1ZQlG/Z2TIZFjx2PQZwkSUuqm8uT1qvra+YCURBBD7nb7OC1W/rUrdViQij
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(2906002)(8936002)(41300700001)(7416002)(5660300002)(33716001)(38100700002)(478600001)(66476007)(316002)(6512007)(6666004)(53546011)(26005)(186003)(9686003)(83380400001)(6506007)(66556008)(6486002)(66946007)(86362001)(8676002)(82960400001)(6916009)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GR2mJicNrP7hafck0LX6OH+eOOM9DZkkopXf+SHRDCPv3N9FdO8bdwEGhpyp?=
 =?us-ascii?Q?2YvyuApY07eB0g/S8RlyBCF9+Mg50sG9KgMXob4szKampY+5gjW6f2TsFdY2?=
 =?us-ascii?Q?lSNWTMLF5cJPy/64eJVjuQhgb2OORES8Zd9Emmm4jwIU83pZqtKGUqOe3iPT?=
 =?us-ascii?Q?YQPVb6dINvaYq5DP23EWj7bD+XG7BmGcjg7PD2hTbPi0oE6LKO7WKR/DU/5o?=
 =?us-ascii?Q?XRw2HZi4osfAvlFev+Dtz02Zatz1GrVAaRyOF9nAS1DT/Dl6STJxJ7qeE8U/?=
 =?us-ascii?Q?UyzSZtHxmMINll94YiBT8Jn+tut24sy0/ChZyGNfpJ23zazcx0iW8V/ZHVuu?=
 =?us-ascii?Q?sob9Iue6ETFRVusHl+I9w1uLUwcX5+Y9n3tKrGjDjuw+JJE82TpvjXpaXr7P?=
 =?us-ascii?Q?M8cT6d6+UxFl2g62eWDVaojg7Z0S05+vA2DC+h/A5CzaLiYZdE10ikDe3kfk?=
 =?us-ascii?Q?HmA2Me8BtuNYAqiYCkz1ZDiG5T2W2/uJsQzo/PRl1gcNfuvYE3anShqVXWoX?=
 =?us-ascii?Q?GI9ynt0YjV9w/Qz8L1scolv9Iy+LnrMM+cUbU62QWI8d490Y0eTF/hJ5GD4W?=
 =?us-ascii?Q?gknC1HPvQTQT0yss5rfUTjDV4BJh7CV1S4VSamB6ExAOk50tVtl7eB4FUTXE?=
 =?us-ascii?Q?rhNmSAv0DrB6SDLhZ0aZpMKxrXWStxylMiZ7NHaUZYCLeITNiQdQzUU1csMb?=
 =?us-ascii?Q?1soGmJoZ+162ZccW263fyDxbmwEceXIvOwY2h10g9iQvtJO27OPFcqWwoCQY?=
 =?us-ascii?Q?BNEwkiuB8hRdHCbTT3b+3GBVZ4m9slwhPLOw+akTRjyMVpmf37tYwhgYnTIZ?=
 =?us-ascii?Q?+23rkCOBfpv/ODR/SYXvz8GW6E7xpsk/seRZ4jcOWhQ8CqtKxY7tM2hLj+5F?=
 =?us-ascii?Q?Gr2RDVMi20BzcNFDwm7Rnip0dxXsQDu3XXLP49+cwkC0kGV9dST2E8N+pJ/A?=
 =?us-ascii?Q?fipbsaZPN64Qgbp5tK8npr1aiBLRMyEgeYB2yzjAKQ/cFBBvZha7sFM2L1gn?=
 =?us-ascii?Q?UvVk9U5CvTJcNwK9MjTebzfrKyDw48egEaBziECMmd/rkFvuvoGZoCCMZq5s?=
 =?us-ascii?Q?gu3Q0PMHo2ixrzUlU9GbcACdUudYbIby3rBJWwUBVckPE2dstuZHqW7SyOD6?=
 =?us-ascii?Q?2od1M5xjwlzbfMLsMtvoSnd7kA9CjBlMlhyXJVfdVd1pIMKadtgl4HOVmiI8?=
 =?us-ascii?Q?rYs/iRwiBKCUavebQLv0xJfXpDAF+6yejY7c9eVc2v7ydXk/75ollA59XkyD?=
 =?us-ascii?Q?lr37vkfYdUDqlBAHQoLUi2pRon0VVz2HLdxWibBuYd4H5qgQBeeclIr1qwSV?=
 =?us-ascii?Q?djVy0rCxkcsPTQ5jwFWsD9zAYzBh8jisfmPaLL6CQbpOU9GfPdnX2AbGT4yt?=
 =?us-ascii?Q?BdHJPB13ujmNb85h1YTIgYwjmxUBfRLLpT6DgQ7qTer6Qwf2illMa4m8YTJz?=
 =?us-ascii?Q?hMY8jjbghg6OoLVP6tgaw69C04YrC9U/lWi5QGBq0UmRBJfyEZR23jJGHhGa?=
 =?us-ascii?Q?MFUWmtRQgngg6XuHjoXgikxOZ22kUoAdugWGXXA8Kx7+xUDoLxoJ+VJnVZmG?=
 =?us-ascii?Q?ZQ3/URp71TnDe2spcO2BxReBuabsv2VoI5Ln1nlT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c17087-1b6a-4e2f-4ec0-08db364b9254
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 03:04:01.1294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2+mHdMhr1jj2VN7k2QNm8fWiRz0E4elYS691cZUZCkGT4LNqzmQONazgz/7BCMGXTJ6FF4DvCJP7EazcVxW3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6054
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-05 at 11:47:20 +0200, Peter Zijlstra wrote:
> On Mon, Apr 03, 2023 at 05:18:06PM +0800, Chen Yu wrote:
> > On 2023-03-28 at 11:26:28 +0200, Peter Zijlstra wrote:
> > >  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> > [...]
> > >  		/*
> > > -		 * Halve their sleep time's effect, to allow
> > > -		 * for a gentler effect of sleepers:
> > > +		 * If we want to place a task and preserve lag, we have to
> > > +		 * consider the effect of the new entity on the weighted
> > > +		 * average and compensate for this, otherwise lag can quickly
> > > +		 * evaporate:
> > > +		 *
> > > +		 * l_i = V - v_i <=> v_i = V - l_i
> > > +		 *
> > > +		 * V = v_avg = W*v_avg / W
> > > +		 *
> > > +		 * V' = (W*v_avg + w_i*v_i) / (W + w_i)
> > If I understand correctly, V' means the avg_runtime if se_i is enqueued?
> > Then,
> > 
> > V  = (\Sum w_j*v_j) / W
> 
> multiply by W on both sides to get:
> 
>   V*W = \Sum w_j*v_j
> 
> > V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)
> > 
> > Not sure how W*v_avg equals to Sum w_j*v_j ?
> 
>  V := v_avg
>
I see, thanks for the explanation. 
> (yeah, I should clean up this stuff, already said to Josh I would)
> 
> > > +		 *    = (W*v_avg + w_i(v_avg - l_i)) / (W + w_i)
> > > +		 *    = v_avg + w_i*l_i/(W + w_i)
> > v_avg - w_i*l_i/(W + w_i) ?
> 
> Yup -- seems typing is hard :-)
> 
> > > +		 *
> > > +		 * l_i' = V' - v_i = v_avg + w_i*l_i/(W + w_i) - (v_avg - l)
> > > +		 *      = l_i - w_i*l_i/(W + w_i)
> > > +		 *
> > > +		 * l_i = (W + w_i) * l_i' / W
> > >  		 */
> > [...]
> > > -		if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > > -			thresh >>= 1;
> > > +		load = cfs_rq->avg_load;
> > > +		if (curr && curr->on_rq)
> > > +			load += curr->load.weight;
> > > +
> > > +		lag *= load + se->load.weight;
> > > +		if (WARN_ON_ONCE(!load))
> > > +			load = 1;
> > > +		lag = div_s64(lag, load);
> > >  
> > Should we calculate
> > l_i' = l_i * w / (W + w_i) instead of calculating l_i above? I thought we want to adjust
> > the lag(before enqueue) based on the new weight(after enqueued)
> 
> We want to ensure the lag after placement is the lag we got before
> dequeue.
> 
> I've updated the comment to read like so:
> 
> 		/*
> 		 * If we want to place a task and preserve lag, we have to
> 		 * consider the effect of the new entity on the weighted
> 		 * average and compensate for this, otherwise lag can quickly
> 		 * evaporate.
> 		 *
> 		 * Lag is defined as:
> 		 *
> 		 *   l_i = V - v_i <=> v_i = V - l_i
> 		 *
> 		 * And we take V to be the weighted average of all v:
> 		 *
> 		 *   V = (\Sum w_j*v_j) / W
> 		 *
> 		 * Where W is: \Sum w_j
> 		 *
> 		 * Then, the weighted average after adding an entity with lag
> 		 * l_i is given by:
> 		 *
> 		 *   V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)
> 		 *      = (W*V + w_i*(V - l_i)) / (W + w_i)
> 		 *      = (W*V + w_i*V - w_i*l_i) / (W + w_i)
> 		 *      = (V*(W + w_i) - w_i*l) / (W + w_i)
small typo  w_i*l -> w_i*l_i
> 		 *      = V - w_i*l_i / (W + w_i)
> 		 *
> 		 * And the actual lag after adding an entity with l_i is:
> 		 *
> 		 *   l'_i = V' - v_i
> 		 *        = V - w_i*l_i / (W + w_i) - (V - l_i)
> 		 *        = l_i - w_i*l_i / (W + w_i)
> 		 *
> 		 * Which is strictly less than l_i. So in order to preserve lag
> 		 * we should inflate the lag before placement such that the
> 		 * effective lag after placement comes out right.
> 		 *
> 		 * As such, invert the above relation for l'_i to get the l_i
> 		 * we need to use such that the lag after placement is the lag
> 		 * we computed before dequeue.
> 		 *
> 		 *   l'_i = l_i - w_i*l_i / (W + w_i)
> 		 *        = ((W + w_i)*l_i - w_i*l_i) / (W + w_i)
> 		 *
> 		 *   (W + w_i)*l'_i = (W + w_i)*l_i - w_i*l_i
> 		 *                  = W*l_i
> 		 *
> 		 *   l_i = (W + w_i)*l'_i / W
> 		 */
Got it, thanks! This is very clear.

thanks,
Chenyu
