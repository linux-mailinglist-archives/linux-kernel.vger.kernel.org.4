Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524886E451F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjDQKXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:23:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806DC4224
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681726971; x=1713262971;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MOYPIgAuGkhDJ4eEU+R6xmme3D2CY8JpiXK0lkGw7a4=;
  b=IF46v9aPEsWwtxnrLVn8gAspYUnb+BgQeX9iEhe2t5HfV5VXIf6XugTr
   p9knGbvJH2jjMSVq79vZ6Ug17pbmGpb6HG+g+xXyNI0QPEUeflf+cCEXD
   IqoCFlIcsBVIPGrzNwEa7UV/sFRk/RsRVqGIel+8iHkXkxILyJU4/eWAE
   KETyuwJvoC44jVpLot5fLUy5VBUigFsAvasmtZwxjt3Ygh3JwdN5AwoTP
   VYMTeEMvMJBDGwPQhs2zG4+3b98VIZ9mG34dsdi4Hh2P4KheI9+wLIVPu
   1R8DT4uUpiD7jPD8nKvRzlO1DQ+LE7pBx9gXuXGTSpqgtVxjVptabDz1r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="343611487"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="343611487"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 03:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="780018732"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="780018732"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Apr 2023 03:19:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 03:19:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 03:19:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 03:19:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyLfq+F4KMGeOk+ADJkfYkUw+0WTE+kQIf4Qzz5r8P9jtq/kmu3Rz5J7ysQK9gvZpddBbKp2BOY7EYLWpEHz1gp+RJhZb6ZMoFc9hqDWJZB93XYJab+X0rd2t9R1HU9CCvP1P8l4jFathPv2cQDAb1oL69s9fy8IUG2AsPmZUlHfD3q7dHgJG5/OL8NLVYW4P+FhqH2V+PyapuoV26YHlKEyiVGOCKrmz+hbOW6boIg2p3YDmC90HcIE7JzZogEiVD4PmeK9+04i6WB+T4VgyuW6/nJOr1/2sdcm+NTyBu51riJNAwvQ8kjaOKPBLBuKro+wDg06nDZQ1t7P3ILWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlHJmYyfI3/FjtzB0skOD6KuM6s7dabiwzbZUwrUdcw=;
 b=cl8tgG5OVzBYDcZnFUtraAWZFhCmwxJUqZF43dOiaOlSGfGWIfBD2loolOdnaL5iGcbJMcQOK0YIxlBJ8TSUVNj5AkqjxkRbEE/ZrgB0WKst9w22XeMw8sxyZnhXCSMwmKj61xhPJDTA/43hc8g7lHM5u6rVcGHMhVL8ysFQscc0o66VE9sv2OI8oh2aopcm7lKIsGTtQMBOBbLg2ag54cnJ6YxHGMQQg8dNk4DW0LS6Vm3DfI87cgl97wP/GNr+M+ZigsKtw+9P37uEB2Bj5t8AeKyYkhKdbbWeEbu4RJGQ8+hAJ66W3YklJn/6ePYp0uAyRw322xiVSH7wIyxkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SN7PR11MB6725.namprd11.prod.outlook.com (2603:10b6:806:267::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 10:19:05 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 10:19:05 +0000
Date:   Mon, 17 Apr 2023 18:18:55 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v7] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230417101855.GA485797@ziqianlu-desk2>
References: <20230416223217.191261-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230416223217.191261-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SN7PR11MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb9f8c1-a27e-4579-4114-08db3f2d2c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPWpkZqMBd5CgzXl8bd8SUa8dzXPoidR9qSqif8LNB2dT1zggcM10lYSH81Xc/mvwAN7yqqQNsI7bijWSwltNPBT2vBLo7v4UM11GlRfhyLSbqxjVntTpU+szYqTIJBg4lDcf4S1J6nnTdsKlf1M/TGHujhTnVSdL4HBMQ46j0YErkFdy7NpgQBQjTNp0teSyO6OswXrV+hv+SnDGnqECiQKjD7sTf1ml6T4SZQ73pGjTBdfDd7EgMW8oM6hYIy2GRyKiSOiPu8afU6+8LB8NFOv6Ssw6JqBfJk+GDMGKs06WAgjwL/9ocw0d6xFryB9fqypqIGetjEIXi6hgyfJxYLZFrvXhVoCcwvYe3BHSdkD858YnvdJgtU4DK289cD1etu2kT544+Qb1dstWhNVnUUUfqUPndS0hT1KEklm4aSpa19dTXROiEkAtA7NHI5VfH+KdaiVqHAJbzNxvXgLz9rhJsNHWaT1nUZpACON8o2y9chFhnkd8O0y0QBGNgUdn+2rGDN06HDZ2lbmMRnuW/F/qOxYwNzwN/KWM1BHETLkCwVQ4xlS9okkEprUvQqR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199021)(478600001)(6666004)(38100700002)(8936002)(8676002)(316002)(82960400001)(41300700001)(66476007)(6916009)(4326008)(66946007)(66556008)(54906003)(186003)(2906002)(26005)(6512007)(6506007)(1076003)(86362001)(9686003)(33716001)(83380400001)(33656002)(5660300002)(6486002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2qVkZB2mr8ghV0Ar+Y7zgwRXd9H0rImd3bxlrDQdXVO2VOJ83ZimYQRXc0bT?=
 =?us-ascii?Q?NmFgreoP2f8CkiEkfS6cwB0+IBFr8MbkbPHk1P6vPULwbNo1wm/yYLffVUGZ?=
 =?us-ascii?Q?ZJUP80IJKhMkGD0IKCU7COeN77yVSSGEPG5YjHq1fdPP/xEJ+yLw1Mf5YnTb?=
 =?us-ascii?Q?8v5oEDVTpWK1IRgUyBM+R4qFOX4xgBdWlFRlKJG/7iZthWmmnx1FgbORhxVE?=
 =?us-ascii?Q?6jeTmaqPGZQMP558aU5KA1p6gFgoxoQt2/10tnxKdW3u3//0UWRZwFROuJTH?=
 =?us-ascii?Q?Cw3GqqB1wHMrtvuwzeqyw9vBl2Rc+69VsXf6Uhx5Y1NKNka0zWSQtjCKi4qQ?=
 =?us-ascii?Q?ejm0/RlbT5bxP5gJIQRT/uomYOAq6HmzHfnFJ/vOrBbkKOsiLQKHZXlKSzj9?=
 =?us-ascii?Q?lAyQ6S2VGFv+i1mNjHbrf/iNZGHJplFmkJ73DBr2n62RYdT97cNdmDx/Coik?=
 =?us-ascii?Q?jl5/y93KHoQMeiQtGb4irPAZ3/aZXYMuaREaiDb4Xg7m7qe9FdZj/FvgpmiG?=
 =?us-ascii?Q?flpk+xfem7s2tSE5YgRBoklcgw54JvT4S9LLn/Vtjkwvbp1S11ZGgnmf8kn+?=
 =?us-ascii?Q?T/ugqoh6TB81EGp2RVmZhq3ivo4QAcxoOcOqXL93qvxd3LSpzUmVOnKkt8LR?=
 =?us-ascii?Q?N640ZS3FHCXpuM3X1RQRHRD8dTTQ64un+ekRI4uAHAw+m2967UZo7H2dRe0J?=
 =?us-ascii?Q?VDMXv/fUL2i+H8FiQRRhyGaLJcbX8xSMBCzkSMGMAjBLrrXI16HKGli9bwPD?=
 =?us-ascii?Q?y94H/+WY99eCWB9veuvMsYbxegLRWOUMhHM9qZeIm38mKAduSsD5paLPEDr3?=
 =?us-ascii?Q?7b4vnxk5L1Q3BF6gb5EmtYyp5NZMhYIgReUJKufTyo1x5tlQR6KL+6aoPXJc?=
 =?us-ascii?Q?k7VKSlDvMkfuEb1PNr0qN7M0e4rE91rSs9zNv2hLBvlGjRFKB80W254JSXd7?=
 =?us-ascii?Q?z4ripBvV/AiA1psJdvAN3/joRXwCo2cjXAL6g8UNrKmNFo4Kw0YiOHyJuF5q?=
 =?us-ascii?Q?k/2QeZo4MRx4DR03eXFb7yaMy/SnNIk90vquN0bIid9hJjJg3fUBNW0ryCpH?=
 =?us-ascii?Q?wV5XOypc+9l2q+gEPIU7JUyekOJaB3hWM8Ftc0YVB/FDnXO19VH2RCFu6RGC?=
 =?us-ascii?Q?WoTo86M5Xl+jI8CZLrx9OE2bbZXOivlmPKpPgDCInsktgU1H2UTxIUDZFRJf?=
 =?us-ascii?Q?7uJpjMaMSOh4u5qKlVdTEiDgqt7XUMuct6SfDBrPso06nAXoxamPFkpXPCvU?=
 =?us-ascii?Q?iJjz2hrb8eIXlpB0tRUhSZswvuUDcHL3PkXU1tzNKxDumpXmBM1MohZ/a8zT?=
 =?us-ascii?Q?rVDkdb4CDPTJIgwEkQC4/MYdnpDpFxwTWGgLqfiWHIt787eD761wuu+2tmEP?=
 =?us-ascii?Q?dCA0+iUpqHtoJsYxzwS/L5cIG7yOwXTTsbKuX7wrtd8FUYcvnxxvh94zZoBv?=
 =?us-ascii?Q?tmbSx1LDs9OhclCMNJpZvE+dsLZJ47jy09rk+GjZv8eKMXMuCWLn2q5IO0DO?=
 =?us-ascii?Q?bYMa+GOPb3teL9uCQryBUUE8TuTIGawNrTxG0TiiGbENgPrjpV7PeK2zqUcs?=
 =?us-ascii?Q?JiSc1siU4j8oY2o6ho95OJMyb1eaup9Z2CXEwlVR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb9f8c1-a27e-4579-4114-08db3f2d2c3d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 10:19:05.5002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaS7+6BVEECk+hybnIZqMUQGYvpg5dg5ShJGA3y1Uq7XYb+/W3XoaEnXFVcZgGyv5ElM6s65H/Ifqem3l2MIsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6725
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 06:32:17PM -0400, Mathieu Desnoyers wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0d18c3969f90..9532cf1a2a44 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2084,8 +2084,10 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  
>  void activate_task(struct rq *rq, struct task_struct *p, int flags)
>  {
> -	if (task_on_rq_migrating(p))
> +	if (task_on_rq_migrating(p)) {
>  		flags |= ENQUEUE_MIGRATED;
> +		sched_mm_cid_migrate_to(rq, p);


I noticed you did this in previous version too but forgot to ask:
is it your intention to only invoke sched_mm_cid_migrate_to() for queued
tasks, i.e. tasks that are being migrated due to load/idle balance etc,
but not those tasks that migrated on wakeup?

I saw you did the corresonding sched_mm_cid_migrate_from() in
set_task_cpu(), which on the other hand includes tasks that migrated due
to wakeup, so it kind of feel weird.

> +	}
>  
>  	enqueue_task(rq, p, flags);
>  
> @@ -3195,6 +3197,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>  			p->sched_class->migrate_task_rq(p, new_cpu);
>  		p->se.nr_migrations++;
>  		rseq_migrate(p);
> +		sched_mm_cid_migrate_from(p);
>  		perf_event_task_migrate(p);
>  	}

Thanks,
Aaron
