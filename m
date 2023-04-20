Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E3C6E8EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjDTJ4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjDTJ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:56:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D60137
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681984589; x=1713520589;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/IwTzu3AW/kgI5HaIWrJUjFwvzK+hDA0XeAQ9a2wC0A=;
  b=cYOqL68A05kRunpxcP4PtUehV6gMV25acbbS77XY4wkDqMP/SrfIHv/4
   Wj6mooO8M4nJTp0R5ESjrZ/GAvovOEkHWRcnKmsvmDNMn5+Sj5XoSMM2m
   hFA1x4CNjifXfD2Xy8a+u0viN3B/zDRHcvmJyI3bfkULmhYhHzm9j1CBz
   K4pOElLq50Ht6bRO9h8/pcH6+UzP+SHCv/K55GyrBe621QP8et//xxQr0
   OuB3qgA3/MFoJTcjHDS0a+/kI5Ul/Arpf8aM6FTrbjguCB9Np5v2K1bjP
   Re4FYUuoLJrv3ugWrgDmCrOzrocJoK5GxnXpg842KOuUl3LBJ6TP8zv/L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="343168577"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="343168577"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 02:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="691854277"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="691854277"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2023 02:56:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 02:56:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 02:56:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 02:56:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8jcghz5GeDhnD30V5bXkLCTAWOG3nzZuKlrs6Sw8Pa9s2rscGugYIseJ3OpEHdLgPLe93/4CMduGHC5eovbrmtatAamGkHIkaEmYTP4qX7RA/Y37vc38FblKYkTdCklFlDORW1tipIt16G2SQkobaOtasPSGb/6Agumq4Dx+dYCW7oRiUTduwS+YVkqbrxfP/Ru9gRKETVi/49+6c8GhRNwvjNEdGEZZgUTjn8UoKru3QpuWYWueHOY7PDVamF+OKXC8tOLDhoefKJWSaXROhw+sbtrt6c32YBMjyJVWlgn2hzOCf0DnJombavBw5CcZHW07DRfqXhzHYt5kpUaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHWOXytSrClPORvnh/ra4pIy8cNJBaZBBhhEKS1akrk=;
 b=HLVz+TcoEPXgU312xmyQNXLXKlWIx5DgsMGtHX+py19tB1rTmr9yASDwRZBENF93J6xa+IYVTm3ri1xrBZjpnHpwjkBef+GTMr0DRA1gL1w5N59MYRf7VJmeR0DaGmQTSxyiB838IgzalVlO39vqj5ybRa3RCCJS2qTP4QufFHWJklVi/3U0657CnS1eBI7yy1P8odXj7USIgPBtzHIRDyy0QZF7VyWPaYxgb+UbM1X6RIii7SKiI+2CX1VtwZYyR5e2/wjyHH9O3sHo9OarEpYR5AUb6hAAs5RMAYrSGM+Pt4QI7VBD6Y6dyEh3O08VjLDt2Y3zwQFDdubZvDqGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA2PR11MB4860.namprd11.prod.outlook.com (2603:10b6:806:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 09:56:22 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 09:56:22 +0000
Date:   Thu, 20 Apr 2023 17:56:10 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v9 2/2] sched: Fix performance regression introduced
 by mm_cid
Message-ID: <20230420095610.GA153295@ziqianlu-desk2>
References: <20230419155012.63901-1-mathieu.desnoyers@efficios.com>
 <20230419155012.63901-2-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230419155012.63901-2-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: KU1PR03CA0047.apcprd03.prod.outlook.com
 (2603:1096:802:19::35) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA2PR11MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba0400b-6ef1-4746-8fd8-08db41857ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgJ5WnxsA2SXthlxbXnONIOlUsjxZTqfT6wlhflCGDakTdZmSf7fuwy2xEu35sKgIhwcvghtG0H1Fy+k7fr/uBCNbeMeno3ApTd75BbcRtFtktV7bsUhe3MBWIorypELMAjEMXBhlV6ww2NZu+JSLDaxj0A316yhsLAwaDI7yCvY37J7mnpx8IE1Q9VWR9YW/qF1H1tQ5/xYhy1La1D5DkcgGPZ+7QkT1R1WHYhIbLPo2xweacCuJ6DNMfck+OZnxzswZPhJB5KkmGt3EDVPkrvGR5D2/6wfquhkxKsBXozST3v60QNXpLSnvO/0iPs8Z6hYZOj2Rs64GViPLyKVfHCk2NKtkaSd3e83jEtda2AvFWRez7cUIkU5N8rml9h6YQnUX0gdrnCmImFlN/GvqsaHpDuPgIMI96XfL0aOv1mqJBX0dt3y3/oOmRlC11P49PxP/BR9wKX93FUdFtjjvy+aoTReDM2R6nijJPg3gCdxg0luDHgpRUyyN1ezLyDKuSc9Q1HeP8MrCyPM3IAfNSGSWFgA7Dyt7XTGakm4kXiBwSoCbHi5posEAySjc1gs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(33716001)(38100700002)(6506007)(6512007)(1076003)(186003)(26005)(82960400001)(86362001)(6486002)(66556008)(66946007)(66476007)(41300700001)(6916009)(6666004)(478600001)(54906003)(316002)(4326008)(83380400001)(9686003)(33656002)(2906002)(44832011)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2psOXR5bVJObHd5bng4Zkowd210ZmR4ZkttRzQwbElNYXFiTHU5MGdQbWVa?=
 =?utf-8?B?cjEyVjJhVzhYbFE4ZmFYS2FHbDlvL1YwRTdic3hWUmVVWHBQMEpuNkVFbHpI?=
 =?utf-8?B?Yjd0eHIrYWZoNnNta2JSV1VwUUhvOGM4Yk1DQXEwT0pOYjhURHQzYWc4UWNk?=
 =?utf-8?B?TXJtWFRBdkp0aHNPK2U3QUNyMmpkMUJTZ28wYVBkMTJCR2VwS3hpak1kS3My?=
 =?utf-8?B?VHNDZW5RQWxFRk44a2xNNFgzUnpBeUtBSHZXcGhySWx6UnZLSVhtTnZxVzU1?=
 =?utf-8?B?SUtOU2pQcERHY0lJaUF4T0RSQVhhMXcyQ2xaS2I3UnpLZzR5aEJUY0ViOTBU?=
 =?utf-8?B?T29TVDhIV2cxRVFKWFV1Rk10d2xzUUJJeStFOXcrYVJQdXpHb1l2cjdGN05p?=
 =?utf-8?B?TTBFVkkyWmUrOG5XZWZTWW9tenEyZ3lEVXFsNW5HWjJrdCtxaGpBUDk5VS9Z?=
 =?utf-8?B?eU5KUWlURVVmSHRCSVFsTFdOMFp4bDFVdmJRZlk5VW9uRTBBNndBc0wvMzd1?=
 =?utf-8?B?TXIycm1xRjR5bzFxaGZDL1FUU2VLeEplVG1rMk1HeTRsMVdnR3IwQXlnTUZQ?=
 =?utf-8?B?bFg0dlNDeTVXOEVPT25UQWxSR0FDdUNOZy8rSTFlVVMrZ3RXTEpQWUhrS2Vm?=
 =?utf-8?B?NFFCVy8yRmp5K24yZGR2MTFtZEVMZURwU29odW51aHdvYnBuZmVnMk1Ea1J6?=
 =?utf-8?B?T1J5SFdJdytOYmxMMnB2dVV4NVhmUksyTE5hZk9DRVZkQ3Ywd3BsYjgwMU0w?=
 =?utf-8?B?RFZLdmtDdFY2Z01JaXZTaEVJV3RvaE0zQTg1VW85YWdyZlRYTTZ4L2JpZlND?=
 =?utf-8?B?RDAzcGJkaG5iWTlrNENWTXlZY0pKTGEvcTIwWHdHd1hQcVVNbnZMSjFObUt1?=
 =?utf-8?B?UDZIeXNySEJ2ZnBSVjVkZVBWejZDM3RGZnQvdGNUV2F4Q3VNVm0vUTFqM21w?=
 =?utf-8?B?QVhSN1RxenRmNDI3aFZ6RlV0ZEhKUHI1NzRrakwraUpwOHdIc2tUenp1dlRr?=
 =?utf-8?B?WlI2VXRMTUgrWGhiV0toTXB5OHpNejVFSUs0SEFtY3VWaWVYakJJU1Rkc2pm?=
 =?utf-8?B?SFlyTVJ1a3lHN1NGYkJ2S1ZxSkNXOHkyRzVVZVgvNkZqZ05oUmgwSm1yaHcz?=
 =?utf-8?B?bzBUWm8vRXpGdnBnWVozQSthcmNLaG9OL095Y0JJSS8xc0Q4enhCeEhibWNu?=
 =?utf-8?B?UkZ5YUN1RmU5NDBTU29KSjkxanNLRzZZNnhFcXhkNVU2S1ZvYmVjWnIrYXRr?=
 =?utf-8?B?Ujc2bnZZMG1tcDdURm8ybXpwdlVZVkkyV3hIVnhnWEVERUlJOCs0b3FXdkpz?=
 =?utf-8?B?VE9SQi81MkRhRHBJVUFFSmlXS3UxekRKMm1LK1h6c3lHTzBoSW5ZUjNHMzha?=
 =?utf-8?B?ME8xVE85cjhvd3Vzbkd3aStLL3VZcXA3ZW9yYUg0WXBuMVNpL2c4Q2MvdjVy?=
 =?utf-8?B?SERnYU5aK2gzeFcvUThtY0h4NXFuM1NWODhRRjUxOWRuaEZDNzVxUjdoa3kx?=
 =?utf-8?B?dG9zYlBFN2UyUXhFaHUyMENOWGlha2tXUHVOTnA4VE9XZzFmSFM1eXZzK3Rk?=
 =?utf-8?B?bzltaEtoRnpyVCtSeWt4NmdBbG5UeTVhYzd3RjBOM2JYeEl3RkRWbW1NSVM3?=
 =?utf-8?B?MEV2SzBLM1B4MVJQRjhST1NQUGtlbzNTZEpKUDBqSXRNaG14Snl0YVZiTW5C?=
 =?utf-8?B?Y1VMdHhKbmVQYXY0bThaL3VYVTBTRzhGL2FINVgzdzEwdzROcWpSSXM1RFNP?=
 =?utf-8?B?NUJObDd6VHR5SkZkbmY1TTNmUG4rTEw4QXRCam1nVkNvZ2lLQVBkcDJqVVdi?=
 =?utf-8?B?ZFhJUWF5Sjh2THJVYmJ3ZDlvS2VVTlZxT1ptRlB5bWswcVZwSTg5SXpNemlI?=
 =?utf-8?B?a0Y1UFN0NHdEQUlxcEUvUHlwRGhNdFlsN1ZrV2pzWWc5WmZZZEN1c0g0TkV0?=
 =?utf-8?B?MEwxMjZwZU1VcTJlVHNmcnRhOHNxUFJ3d3hmcHBBQ29BOWg0cGZIOGkxVFEr?=
 =?utf-8?B?L0ZqVU5QTXVqOGNjeThuS29jUHJRQzAvUzc2VWVxYnFjM3kvSS9HNGNnY0p6?=
 =?utf-8?B?d1ZpazlFSlR6VXFxMzFuMU1ZS3dCekVLdi9LaHhLaVJyWjJIRW9qRmMxb3VO?=
 =?utf-8?Q?g+w1YnvxwJgh+cwPGav4nAnIG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba0400b-6ef1-4746-8fd8-08db41857ea2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 09:56:21.7783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPDY7aMYyvKtRsCr/s7YLhCBURpO8NpxhLMVBmk9E1uH7L584Unum2VIAeCWtHo4b5U+ENPW68IgqrwhDNZ50A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4860
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

On Wed, Apr 19, 2023 at 11:50:12AM -0400, Mathieu Desnoyers wrote:
> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
> sysbench regression reported by Aaron Lu.

mm_cid_get() dropped to 5.x% after I disable CONFIG_DEBUG_PREEMPT, using
__this_cpu_X() doesn't help, I suppose that is because __this_cpu_X()
still needs to fetch mm->pcpu_cid.

Annotate mm_cid_get():

       │     static inline int mm_cid_get(struct mm_struct *mm)
       │     {
  0.05 │       push   %rbp
  0.02 │       mov    %rsp,%rbp
       │       push   %r15
       │       push   %r14
       │       push   %r13
       │       push   %r12
       │       push   %rbx
  0.02 │       sub    $0x10,%rsp
       │     struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
 71.30 │       mov    0x60(%rdi),%r12
       │     struct cpumask *cpumask;
       │     int cid;
       │
       │     lockdep_assert_rq_held(rq);
       │     cpumask = mm_cidmask(mm);
       │     cid = __this_cpu_read(pcpu_cid->cid);
 28.44 │       mov    %gs:0x8(%r12),%edx
       │     if (mm_cid_is_valid(cid)) {


sched_mm_cid_migrate_to() is 4.x% and its annotation :

       │     dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
       │       mov     -0x30(%rbp),%rax
 54.53 │       mov     0x60(%r13),%rbx
 19.61 │       movslq  0xaf0(%rax),%r15

The reason why accessing mm->pcpu_cid is so costly is still a myth to
me...

BTW, I used below diff to mitigate the incorrect rq lock issue I
described in my reply to v8:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c6e2dd8f4ee3..f16418731866 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11662,7 +11662,7 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
 		return;
 	}
 	/* Move src_cid to dst cpu. */
-	mm_cid_snapshot_time(mm);
+	mm_cid_snapshot_time(mm, cpu_of(dst_rq));
 	WRITE_ONCE(dst_pcpu_cid->cid, src_cid);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d1d470441422..8b6a0c8ed3d1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3348,12 +3348,13 @@ static inline int __mm_cid_try_get(struct mm_struct *mm)
  * Save a snapshot of the current runqueue time of this cpu
  * with the per-cpu cid value, allowing to estimate how recently it was used.
  */
-static inline void mm_cid_snapshot_time(struct mm_struct *mm)
+static inline void mm_cid_snapshot_time(struct mm_struct *mm, int cpu)
 {
-	struct rq *rq = this_rq();
+	struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu);
+	struct rq *rq = cpu_rq(cpu);
 
 	lockdep_assert_rq_held(rq);
-	__this_cpu_write(mm->pcpu_cid->time, rq->clock);
+	WRITE_ONCE(pcpu_cid->time, rq->clock);
 }
 
 static inline int __mm_cid_get(struct mm_struct *mm)
@@ -3404,7 +3405,7 @@ static inline int __mm_cid_get(struct mm_struct *mm)
 unlock:
 	raw_spin_unlock(&cid_lock);
 end:
-	mm_cid_snapshot_time(mm);
+	mm_cid_snapshot_time(mm, raw_smp_processor_id());
 	return cid;
 }
 
@@ -3419,7 +3420,7 @@ static inline int mm_cid_get(struct mm_struct *mm)
 	cpumask = mm_cidmask(mm);
 	cid = __this_cpu_read(pcpu_cid->cid);
 	if (mm_cid_is_valid(cid)) {
-		mm_cid_snapshot_time(mm);
+		mm_cid_snapshot_time(mm, raw_smp_processor_id());
 		return cid;
 	}
 	if (mm_cid_is_lazy_put(cid)) {
@@ -3467,7 +3468,7 @@ static inline void switch_mm_cid(struct task_struct *prev,
 		 */
 	}
 	if (prev->mm_cid_active) {
-		mm_cid_snapshot_time(prev->mm);
+		mm_cid_snapshot_time(prev->mm, raw_smp_processor_id());
 		mm_cid_put_lazy(prev);
 		prev->mm_cid = -1;
 	}
