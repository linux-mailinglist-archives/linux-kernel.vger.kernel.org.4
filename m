Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C06D1A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjCaIl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjCaIlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:41:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E4F1BF43
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680252029; x=1711788029;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vmUvUQVi8XE3DYCFw5BLinLPoyYGoO6i7NoLOv8v/1Y=;
  b=jyHgpSjczf0RQvQ20AqbWoiXt+HKOCOVHfk367RBAFt2ZN24d1ek/5tk
   7Ow6yxNj5LdPIMI88DZFubX3HnVLm1aPtmnNcBevi76L8oBBfBi8p5eBd
   8UVNLS06tIONndAQMFgrLGzGjt2xmgXHP8vjMMCp7yFX9h8VZlpCpsuKe
   ZRwPUe35p3te89c0aO3bPZwiRe203Q9YvB9JrrU+1Q5KN3LJlD6DrdKrq
   ne1aNDEXvmUpdlgT3p9vGCVF6winjzNEoQvMxcCP8yKI9a+lRCws/vw1l
   +Ghnay5VogIX0dz9phRPjPgjT3XCUbScUFkh6kOLb1rxAH92xCQfORirA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="406409550"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="406409550"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 01:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="754331781"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="754331781"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 31 Mar 2023 01:38:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 01:38:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 01:38:41 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 01:38:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVVkZ+uXUVa9a6QFUbwjR+Vo5/mfmB6nc2Dt8VssHqI1DvO8/B/N/MOz3xssPNEX+IsdrrveHQfoFPKy1nWzxGHFo/3fIf1zrf7IA0GL/zQfeUg/hSwm5GVIOPlS6+phM/Q/LIJE+oggFjM1pcXnBLR1Hqr88LU0DuUkeV4RvsTIth4UV2WyfyqK2euEBvKaV2IQ6eoQRjgoslsqqHtIL1OZVKnmp7tfjBcWXdutEP5r0rIAs+SQWDdX2exFN/74lT27uW19MwU60vlnoskggD81iclQzo/zeIcVreAxqJkpYC/cnmxhLG91fQVEvETRXPyq04ed7+czs9dHYzuOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYfIgK0B+5p5fVjQOulRvvtclPtFs9xMH+8F4s4wQls=;
 b=avA7EvgV8camXh0YmXjlC6s/ikh77Up58GRZD4J/2TyeJRE8crKEiVXimuQi1lAsUoDHubRgOxZZ1Yez0JVYmG43Dhlk6MIMQ/2338cOCBkeeEpZZQD3gZqKJK29CV8OOgEFdkY7c87+trqhNmVI/8wHP7MOgrjAZhNxMZGeRz/wIE1eLopXZCaHw01v8ekNqg1IGTrJCi/CU/K+1eA/qbPTTNLQhYfdJMpFA+qO+sr6fZdCw5CMHIKuD/KpOsxMxQv0wvHKtpDUp7Or0Yb4r+67N7NWKz0LfKDO323qjxujKvrYkWGMWh5lRMOwGRFtdShjA4hhwzoKTK4haUxZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM4PR11MB6550.namprd11.prod.outlook.com (2603:10b6:8:b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 08:38:39 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 08:38:39 +0000
Date:   Fri, 31 Mar 2023 16:38:30 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched: Introduce per-mm/cpu concurrency id state
Message-ID: <20230331083830.GA186694@ziqianlu-desk2>
References: <20230330230911.228720-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330230911.228720-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DM4PR11MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a2dd31-7b91-4d8b-4024-08db31c3530e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8WEBYojDvmIK3Gi7Ta5Ib9PbsynWlvJqf3C65S8U8UGQNsO+tMJhTYQAsnLdAryStmogrr/2xO9kVsUU10rdQy5qaJeg/+r14Yij6XhaUZjbKnWo/qLfMBu/n2aZBzCJy077MIN+clAWPnjZqgwcnD/BcPBEn4ulc4bX/ImV5EPnb+tZ+8c2nD7UWi1JmFPy3NL43VHDo062UXs64puFidioJ8sEI5a8jZxFPf45maV4FMW9Ly6B4zNZAmtTkQ0SqTtUbBArPcGV77Ss3Br7mM0ZwzIwXU90Kz8AMK6ZPkQI2clsabDIgADx6E9xUkQuGVtF+YGdr9VgS51c6SacdXCJXvO1+YUbm690yg1IK5N3UM+YOI4Uwh3OajxA02GqzWk1fb1pdWLxu2vAivIr8aHNa/ZZlW89Kzd0YtAJaRQhcZQGnKsKKwU5LVGmJT3w1s+flvhxPy1dZB+fajvbK7hX9dCkXjEV8EiOWiX4GxKAQOeqLB2hPl719ExmIqneYs9Gg6Ht+7XpF8hZV9veeo0tvSD6gQX85OpAiFV12wCfQWIYe9BRV3wd4IQeT0u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199021)(6666004)(83380400001)(66476007)(1076003)(26005)(6512007)(9686003)(6506007)(186003)(8676002)(66946007)(66556008)(41300700001)(86362001)(82960400001)(38100700002)(8936002)(4326008)(6916009)(2906002)(44832011)(316002)(33656002)(478600001)(33716001)(5660300002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0/GoH4+RYFqeYVQqHfMkKXgtnbVP+VWnQicnJZlXBTVRgWJC6vdRw6jkrgat?=
 =?us-ascii?Q?+0+erI/ZlxilPuIrdVGfawcuOPcXeoUFw9Z4BBwvioEI9/mRFUucZtosbQhA?=
 =?us-ascii?Q?dE+JhuiTVRhWh0+AiptMUmxWzcwXvbTNT7NDdn2Lhp4WHscwjeyZ6QidK8Qc?=
 =?us-ascii?Q?49GkCYfUq28NY0D+c5CTbWaol+gVGI2r6cIjlAB12REDkPJbZG+6I9x1eMpr?=
 =?us-ascii?Q?CVlpmGU5uKFvTEl0g8GPmYqZtfcTxTtCb24VKgIPJZzlgDxt0kPVCp+DMtcU?=
 =?us-ascii?Q?Bb/ZDi2mrmfqfVAkJps8BuOU4YGtiJ6A2BFbvKqfeu1iQhyHEQVx46xYxVaJ?=
 =?us-ascii?Q?wvkmpKQupt2nNAmAfaxtgWGXy4o3hKomNbDL4gtkAlPJ00HmxzdPJvH+jfhG?=
 =?us-ascii?Q?YjSSaUXEJcU7LqcFy2yAEHPpqfNFvLjZaeYNyXMHSmEmPpA8e289TYQFxIhF?=
 =?us-ascii?Q?5xw7rhxtBI2Yh2OesUleehwnV3dwMGd12t8GhoZvTLWi/3CSSLaSGD0Wnozs?=
 =?us-ascii?Q?/iRxnNLWanjT8GpBcnQTH/95eLMrydmwMT41JsG0pVsKwmkVKFk4tUOh+nRc?=
 =?us-ascii?Q?KvZDwnVZwMRGFp4yxjilqqiQGsQ8l/wkbaO3n9I3NEtX666qAbhBho0O6o4c?=
 =?us-ascii?Q?+mGzLdOe/vgyediK5FHU3DbC1ceN1atlfd8jkIiRNnq9/yfzLliagTSOG4SE?=
 =?us-ascii?Q?ZVcYlnM1veUb5m4RqwUIw+EoTi63CtK5M8whqWXm6C6WBF5PvH4OYCa1HB55?=
 =?us-ascii?Q?14dIsY5rAKHAzOZndEtuxt5KG7qIuZOzvpgaIg1otxBOrlSlqP1z0E0Znaf+?=
 =?us-ascii?Q?wHofhaobGx481SCZFn3ie6keI159n6Y1hrm/ooSTk8N8y7QrSTfYru+EmY+l?=
 =?us-ascii?Q?ZRls6rz8HPlhn+jQooGCO6F1HXBobREN4HRHOdiHWoO7xxr76UzLe4XvDgql?=
 =?us-ascii?Q?Lgyywx58dtSfzP7Cb2ijtQNv+utd+wUX61DjPt4RuNWeuAqXD+v5QsQRxXJB?=
 =?us-ascii?Q?/mVKBOIf4MR81dfEpjJ4/+BUK8z3bE8bd1tyfuYdAkaIcUyoWY7QiFeydcky?=
 =?us-ascii?Q?OMCFvTG4ak8eIXnp8HGVGXuOogNBQglHxsC3MySby5x9nxNt07Tpi9c8a+2z?=
 =?us-ascii?Q?O/6nsqivg7OzKS4u8h0HeXjaTrGJwvkG743T6U807esYOQxaTK+Ywt5MvK2L?=
 =?us-ascii?Q?Om6/q6Z4fcLl+0b+LGWB7sMb+R/klrOKh8MXniIWXnHNH80rRHRfMIoG97Bg?=
 =?us-ascii?Q?i35yJHTETlg6TfxxRmnn7biwW4QlDcN4MCLm14OI+DTcWZqZZue0oHEu3Z41?=
 =?us-ascii?Q?SUJg+fQe+7/JYQ6heLd023FfaiiAbTRa2dbsgKvI9l34IZNx7mTthXfDz9PA?=
 =?us-ascii?Q?ou+UbyYmfGNuvzup+BBRHStuvqQLe86xbIhbhg6qNO/R5akCi29kQqdGr0rJ?=
 =?us-ascii?Q?GQKxMyMtVNi+aRtJo96eRi5wtTN8TNO9RW58j4pu21QcU9tILMj+dzYWbcxA?=
 =?us-ascii?Q?Jr/dKDVNLOhZk7bt+QH03daZkRQwBgoeAOylIWL3P5tSZnK+Dk3a6AXkxOap?=
 =?us-ascii?Q?myuyLImMcM44bNtQX5vb1+JYM/bmP4XKTD/D9mf+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a2dd31-7b91-4d8b-4024-08db31c3530e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:38:38.7655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhNn1Olxe2J9CMYj3XRdXYcVhlHLZwS+UsoATWDAog37Ojs+hg6U+16iNSCqhuil2UPz1us3qJ1zIyZOUnh6zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 07:09:11PM -0400, Mathieu Desnoyers wrote:

>  void sched_mm_cid_exit_signals(struct task_struct *t)
>  {
>  	struct mm_struct *mm = t->mm;
> -	unsigned long flags;
> +	struct rq *rq = this_rq();

Got many below messages due to the above line:

[   19.294089] BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u449:0/1621

> +	struct rq_flags rf;
>  
>  	if (!mm)
>  		return;
> -	local_irq_save(flags);
> +	rq_lock_irqsave(rq, &rf);
>  	mm_cid_put(mm, t->mm_cid);
>  	t->mm_cid = -1;
>  	t->mm_cid_active = 0;
> -	local_irq_restore(flags);
> +	rq_unlock_irqrestore(rq, &rf);
>  }
>  
>  void sched_mm_cid_before_execve(struct task_struct *t)
>  {
>  	struct mm_struct *mm = t->mm;
> -	unsigned long flags;
> +	struct rq *rq = this_rq();

Also here;

> +	struct rq_flags rf;
>  
>  	if (!mm)
>  		return;
> -	local_irq_save(flags);
> +	rq_lock_irqsave(rq, &rf);
>  	mm_cid_put(mm, t->mm_cid);
>  	t->mm_cid = -1;
>  	t->mm_cid_active = 0;
> -	local_irq_restore(flags);
> +	rq_unlock_irqrestore(rq, &rf);
>  }
>  
>  void sched_mm_cid_after_execve(struct task_struct *t)
>  {
>  	struct mm_struct *mm = t->mm;
> -	unsigned long flags;
> +	struct rq *rq = this_rq();

And here.

> +	struct rq_flags rf;
>  
>  	if (!mm)
>  		return;
> -	local_irq_save(flags);
> +	rq_lock_irqsave(rq, &rf);
>  	t->mm_cid = mm_cid_get(mm);
>  	t->mm_cid_active = 1;
> -	local_irq_restore(flags);
> +	rq_unlock_irqrestore(rq, &rf);
>  	rseq_set_notify_resume(t);
>  }

I used below diff to get rid of these messages without understanding the
purpose of these functions:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f07b87d155bd..7194c29f3c91 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11444,45 +11444,57 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t, int src_c
 void sched_mm_cid_exit_signals(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq *rq = this_rq();
 	struct rq_flags rf;
+	struct rq *rq;
 
 	if (!mm)
 		return;
+
+	preempt_disable();
+	rq = this_rq();
 	rq_lock_irqsave(rq, &rf);
 	mm_cid_put(mm, t->mm_cid);
 	t->mm_cid = -1;
 	t->mm_cid_active = 0;
 	rq_unlock_irqrestore(rq, &rf);
+	preempt_enable();
 }
 
 void sched_mm_cid_before_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq *rq = this_rq();
 	struct rq_flags rf;
+	struct rq *rq;
 
 	if (!mm)
 		return;
+
+	preempt_disable();
+	rq = this_rq();
 	rq_lock_irqsave(rq, &rf);
 	mm_cid_put(mm, t->mm_cid);
 	t->mm_cid = -1;
 	t->mm_cid_active = 0;
 	rq_unlock_irqrestore(rq, &rf);
+	preempt_enable();
 }
 
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq *rq = this_rq();
 	struct rq_flags rf;
+	struct rq *rq;
 
 	if (!mm)
 		return;
+
+	preempt_disable();
+	rq = this_rq();
 	rq_lock_irqsave(rq, &rf);
 	t->mm_cid = mm_cid_get(mm);
 	t->mm_cid_active = 1;
 	rq_unlock_irqrestore(rq, &rf);
+	preempt_enable();
 	rseq_set_notify_resume(t);
 }
 
-- 
2.34.1

