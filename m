Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF40766AC5F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjANQAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjANQAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:00:03 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85A49007
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 08:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673712002; x=1705248002;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=51pMelGDfmX9WhHZhNVDVg6XkvnUloHdETgTsgqgiuA=;
  b=gpk/rjPmiUsBTNNlS83UzoPzHsD8jfXUtNj9wpdtL7l1NqxTgAMX3ZYS
   raCsw47dHa+CvnbOuP+czufm/4h2JSfncwPCOFRNSnMNZaGFYt/q6gH2A
   dEoswUwJbrF2jzr0Nb21Gwa2yXgWX7kugjdD6QM2VZv8QENp2DpVTcAtz
   fO0rJvUSSYhuGVBT0ReHTOm2IH5MmuFDlBW1q3vTnA7fqyNvrFi23ce+D
   eSlioIy1Wlzg7sklhY0XaMLynRprLggaaWCRVc+AvbBY3fzDlI9A+RGCk
   OxQpckBDdUZSscs9CBw2cmHV8i0P0r7dVe/pHv+xwB70Si4GiOoFEXWkd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10590"; a="324263627"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="324263627"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2023 08:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10590"; a="987313583"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="987313583"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2023 08:00:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 14 Jan 2023 08:00:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 14 Jan 2023 08:00:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 14 Jan 2023 08:00:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nElbHec/HMA9zSOkxEGZUD5nQWjXJli7B3OpE2YHDFUD735Dj+6M5f9yHPIqodliN17MA2t7ONOT4TmtwaUSK6VdToHJTwazc7hFk4q1MdOl9UfiTafEeWOB1v3mW2SpW2u7x6Ew3RH/zipiWyF71aZEMpmKv4SnSP/tpoipByXw7PXZskSiJln4zTOyZ2Bv9iV203azxz8XgIHQe5VJ7+5vnk9l2QGHsKNtrtPMxLc/a9huhp8IxGSWLR/YxRgfUho3Heh5KEONb8NoHKQAJqaipVIbUcErX6777PgPrrMGCkltU32SWghblDA35Z2C7rQ6zInNSgXDLY2Vgym5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cUq7Hx8gObKgpJkMGayjIZg3xzjwxvPcgU7yMlWdGc=;
 b=M6QYTb4VEVvVDbvbvQYHEzOB29/CIAeHdPa0vHFjd//XEeufI0B/rBnmdsgQaU6coiEB7fMJ87Nyrx6Bl+5EnxCvq+EKiATlJwPCM41TP2aY0AMKKsTLWdHJ+LTxdA+lFSBsEIKZ6AyrURgsmzZ5yuwcsVpdYzjZpjjHYm8I7Gds4qT1FRibuc2gvj5F6VUdmxKGkfXl2n0hcJBFSAFAbltEmuHnoVHwAgozioL+czfeOPic34jozP7vzvn83EYH+Ta1AId6JZm2aUQRHtuDaHAMhlg6V3JyIOqSRFDPuxVfkzKkAuxM9aUxVSpXhNRLO3UAp2mEUb48m5sWszmgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SN7PR11MB6704.namprd11.prod.outlook.com (2603:10b6:806:267::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Sat, 14 Jan
 2023 15:59:58 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2%3]) with mapi id 15.20.5986.021; Sat, 14 Jan 2023
 15:59:58 +0000
Date:   Sat, 14 Jan 2023 23:59:39 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andrei Vagin <avagin@gmail.com>
CC:     Andrei Vagin <avagin@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        "Will Drewry" <wad@chromium.org>
Subject: Re: [PATCH 2/5] sched: add WF_CURRENT_CPU and externise ttwu
Message-ID: <Y8LRa/HJtZ/L2Shy@chenyu5-mobl1>
References: <20230110213010.2683185-1-avagin@google.com>
 <20230110213010.2683185-3-avagin@google.com>
 <Y7+4S9umCo5I+Ty7@chenyu5-mobl1>
 <CANaxB-wcpKS64q6_0+r+OwoZupRN-A-PQvPRiVsMmEgB1TRSrw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CANaxB-wcpKS64q6_0+r+OwoZupRN-A-PQvPRiVsMmEgB1TRSrw@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SN7PR11MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: c720d012-123d-4453-36db-08daf648622d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbutYcbzkKvRZ65QnOPd888wMKWmT3XKWrm9c7FB2aJ6KsnU3cDgvk2KsukuZc/EjQjqvq/AzubNC0+AflzfV2uwLQZ1MewMW2YSZ3oZMHO6ab9rGbE2ZwVIMKIvbWtbu/cuwJcjt0oPTeunVVGBhWOl05ASXZEhNkhVH14uFo4xo+ZN4/l9S8o3KS1LT2wQ6GdpeORjb5UOb8/4Nfbd8u9thQOHnDHr2igOcZqHmdKOW613sY5syWHz5hkPJPkgpLMEDha2gpBhJT7gnVBvOtjb2E9Ze9r4M1xf/KmlBwpaO3eNI2ShPvRh1obdicgUjC99Yv5X9M5OYE0HBUbQ7u9CtvNsuCZERK1RNVsk9YCYrnXmKW7mDDxbO3VyH5CyZD5bqtRlROHa56VYJvOpXaLYbhDHW+A1i9+0T7kpkjXQRfz7VPvo3mFLqM3IRzR/pNhlKhD7sSOZa7GEPfGmKSfb0u12QH2cOeKDuPA/7M77TSlHEdT5jpyXZv1q6VsLZc/b5wK48NLsqYsm5eoC5XAX2AqD2iI17duFG1oL4sVFidi69f22iyvKayzOunQT+66xmiuINjPJMyufp20tu7klst49OX0oPw/XHFunifirDXkhlLiletS4OSf3NonUCFuu4IPUea60Wg1iX9iizKzU8PgLHcamUUJoZVa95FhpfTIkBappYc57CvxPC2fifMXVZHxLG1jnQ3vBvj/zWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199015)(66556008)(66899015)(2906002)(7416002)(5660300002)(66476007)(8676002)(316002)(4326008)(54906003)(53546011)(41300700001)(6486002)(478600001)(8936002)(26005)(6506007)(6512007)(186003)(9686003)(966005)(6916009)(66946007)(6666004)(86362001)(83380400001)(82960400001)(33716001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CjB2z42m8NMGAQ0O+OfVaK4vR0gxZRZobdx+R6UjqmxnW61ViAuG5zj5HYCN?=
 =?us-ascii?Q?pKdeCJyBr5wKRDIbFBLD/w3Cb/Omt27TH3UKzik0ANXv3X07LNvDX3fojcM+?=
 =?us-ascii?Q?pwxTjjcHtzZcvHXQ09u9loA1/mxcNDZctfd9+tV4Q6Z01cKEROOEQOcuByBf?=
 =?us-ascii?Q?en4SFsPESiV5y3TkxWCwBDZfFsvq+YglF11aekKA6t2raaQJumlXzxQ63Pr4?=
 =?us-ascii?Q?jIAzza+bXdQXh41GUiPKjtq1ILDI7qIIdAOFrC9e3YHw1stWeP8TioryO3fz?=
 =?us-ascii?Q?+IZTkh8+4I+e5uDDXQICoof05mJYZ+64B8xhiV05FpZm9VkLkkWlMg7PO+OW?=
 =?us-ascii?Q?T19AeLKikl1c9jZ8AQzeYPp51FtrOzBAIRpDat8I8wTvfb64n0iAL/1BdGvi?=
 =?us-ascii?Q?6WkNvDeSd/YhqbS+5kBcrxsobz0pFfLhMTivx0lqEyXUHjAtIQEGhMV62F79?=
 =?us-ascii?Q?c9xvk1O4pfWXQbpnWefAfwbie8Ov/5olrxsbXHI9QvQtfl9QT2ZTg0T7G+tS?=
 =?us-ascii?Q?bJEn1ydK9GYvq8U6UEcn2/zaTZDIf8RThksBsnkvQBUj515HZbuCkD7JwFwg?=
 =?us-ascii?Q?PphaiIHSMzxC7QlcdJ0U4t4sO8JLRV/1J9i8xX1ZZBjqRAVkWdJc6e5Skn1A?=
 =?us-ascii?Q?H2UpUvCj4TdEMJ4cs3yZV9BPMgj0hw8Ue23es33k4HF6k9uv5SxTlD7FKePj?=
 =?us-ascii?Q?zdJd/AFfB2anUGmoTQfCEADMAx0wHb1ohfrHbPhhEyGs0WABIJzQOMRsWEDU?=
 =?us-ascii?Q?2PrtmvKaQkQ0H0VF7qUKwReeCFPbgYTZOqc20TziqwfT1FJYzMhQWIdUfzfi?=
 =?us-ascii?Q?c1sP4RRIUCBZsCeCCkDQ+4IC+5tomVjAn9RgzQjYoEkoqJdyEqmD3QD5Eqa3?=
 =?us-ascii?Q?fzt1UhvVqGfMz2d1zit+9ZdmeW8bfJdGYzkk6SSpNGG4s7GYd39NqU3kuxc2?=
 =?us-ascii?Q?03y8wd2nGuqr3MicM4MkjNv7vG3Pdm6kZgFDU+GdnOlhraZpKfFXtJjiqNTt?=
 =?us-ascii?Q?Po+8gSEZ73o1n5T/4aRoSxpx3+dtRNBUy1JRTcYpQu28D/CnAcp8lr++3qw+?=
 =?us-ascii?Q?zxLW+DodN26zPoUBq7vyYoVAbOAWwzoEH7O/4B60yAg1lBHsXXgIFWIfPEC/?=
 =?us-ascii?Q?V1L9NegdF/9smszLVhoEZCF3FvWfWoLPi/Nx1MekNRLNyCtkHNkhhnGv33NV?=
 =?us-ascii?Q?JuL8d/22BfDHre8psZxpF9KZplEoni0+f6pBHZr7LJ3snueZanAkNs0DxQQ5?=
 =?us-ascii?Q?Gjn3kk6Nx7Q6TaucrilTYXoJE0dWLCALAdTpDjy5VblRQLuRuZW7eNphboLM?=
 =?us-ascii?Q?VO+6CdRHGRGpPKXUOWALGuge3QxFLU5fl9IcP6DmJzmojdsA6p0Jaa+LcnaG?=
 =?us-ascii?Q?h0XBbfjBJomhSE5s0v85L/UxHWQzxSmYSf6GuYj3DmOix8i1FvbnU9tegbny?=
 =?us-ascii?Q?5mOaoL8qRudFZWlUo+WYSsoLBjaWxkQbwiU2vrpdA8vYYXOs3vl5m+gDC9xY?=
 =?us-ascii?Q?SVBz3L2C0bz+m4tssBr7fn9lKS//3BuOFFa6E0pbepwJbUx1j8taCoBd8T5c?=
 =?us-ascii?Q?99QDQkOAs9u5v+1CX5udzquhDhZ+AMYm3Xxts1FL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c720d012-123d-4453-36db-08daf648622d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 15:59:57.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfSW1SnchjTcc9Urwk56bUJCV+hGR+TWtE196e4/Smwo6VbCxSecU+h+rgsuFJzJBIkG0egdhsFrVzk3qtA1CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6704
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-13 at 13:39:46 -0800, Andrei Vagin wrote:
> On Wed, Jan 11, 2023 at 11:36 PM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > On 2023-01-10 at 13:30:07 -0800, Andrei Vagin wrote:
> > > From: Peter Oskolkov <posk@google.com>
> > >
> > > Add WF_CURRENT_CPU wake flag that advices the scheduler to
> > > move the wakee to the current CPU. This is useful for fast on-CPU
> > > context switching use cases.
> > >
> > > In addition, make ttwu external rather than static so that
> > > the flag could be passed to it from outside of sched/core.c.
> > >
> > > Signed-off-by: Peter Oskolkov <posk@google.com>
> > > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > > @@ -7380,6 +7380,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> > >       if (wake_flags & WF_TTWU) {
> > >               record_wakee(p);
> > >
> > > +             if ((wake_flags & WF_CURRENT_CPU) &&
> > > +                 cpumask_test_cpu(cpu, p->cpus_ptr))
> > > +                     return cpu;
> > I agree that cross-CPU wake up brings pain to fast context switching
> > use cases,  especially on high core count system. We suffered from this
> > issue as well, so previously we presented this issue as well. The difference
> > is that we used some dynamic "WF_CURRENT_CPU" mechanism[1] to deal with it.
> > That is, if the waker/wakee are both short duration tasks, let the waker wakes up
> > the wakee on current CPU. So not only seccomp but also other components/workloads
> > could benefit from this without having to set the WF_CURRENT_CPU flag.
> >
> > Link [1]:
> > https://lore.kernel.org/lkml/cover.1671158588.git.yu.c.chen@intel.com/
> 
> Thanks for the link. I like the idea, but this change has no impact on the
> seccom notify case.  I used the benchmark from the fifth patch. It is
> a ping-pong
> benchmark in which one process triggers system calls, and another process
> handles them. It measures the number of system calls that can be processed
> within a specified time slice.
>
Thanks for this information.
> $ cd tools/testing/selftests/seccomp/
> $ make
> $ ./seccomp_bpf  2>&1| grep user_notification_sync
> #  RUN           global.user_notification_sync ...
> # seccomp_bpf.c:4281:user_notification_sync:basic: 8489 nsec/syscall
> # seccomp_bpf.c:4281:user_notification_sync:sync: 3078 nsec/syscall
> #            OK  global.user_notification_sync
> ok 51 global.user_notification_sync
> 
> The results are the same with and without your change. I expected that
> your change improves
> the basic case so that it reaches the sync one.
> 
The reason why the patch did not bring benefit might be that, that patch
aims to wake task on current CPU only there is no idle cores. The seccomp
notify would launch 2 processes which makes it hard to saturate the system
if I understand correctly? I built a kernel based on your repo, and launched
above test, it seems that the average load is quit low on my system. Is this
expected? Besides, is 100 ms long enough to test(USER_NOTIF_BENCH_TIMEOUT)?
> I did some experiments and found that we can achieve the desirable
> outcome if we move the "short-task" checks prior to considering waking
> up on prev_cpu.
> 
> For example, with this patch:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2f89e44e237d..af20b58e3972 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6384,6 +6384,11 @@ static int wake_wide(struct task_struct *p)
>  static int
>  wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>  {
> +       /* The only running task is a short duration one. */
> +       if (cpu_rq(this_cpu)->nr_running == 1 &&
> +           is_short_task(cpu_curr(this_cpu)))
> +               return this_cpu;
> +
In v1 we put above code before checking the prev_cpu, but is was reported
to bring regression on some systems[2]. The result suggested that, we should
try to pick idle CPU first, no matter it is current CPU, or previous CPU,
if it failed, we can lower the bar and pick the current CPU.

[2] https://lore.kernel.org/lkml/6c626e8d-4133-00ba-a765-bafe08034517@amd.com/
>         /*
>          * If this_cpu is idle, it implies the wakeup is from interrupt
>          * context. Only allow the move if cache is shared. Otherwise an
> @@ -6405,11 +6410,6 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>         if (available_idle_cpu(prev_cpu))
>                 return prev_cpu;
> 
> -       /* The only running task is a short duration one. */
> -       if (cpu_rq(this_cpu)->nr_running == 1 &&
> -           is_short_task(cpu_curr(this_cpu)))
> -               return this_cpu;
> -
>         return nr_cpumask_bits;
>  }
> 
> @@ -6897,6 +6897,10 @@ static int select_idle_sibling(struct
> task_struct *p, int prev, int target)
>             asym_fits_cpu(task_util, util_min, util_max, target))
>                 return target;
> 
> +       if (!has_idle_core && cpu_rq(target)->nr_running == 1 &&
> +           is_short_task(cpu_curr(target)) && is_short_task(p))
> +               return target;
> +
>         /*
>          * If the previous CPU is cache affine and idle, don't be stupid:
>          */
> 
> 
> the basic test case shows almost the same results as the sync one:
> 
> $ ./seccomp_bpf  2>&1| grep user_notification_sync
> #  RUN           global.user_notification_sync ...
> # seccomp_bpf.c:4281:user_notification_sync:basic: 3082 nsec/syscall
> # seccomp_bpf.c:4281:user_notification_sync:sync: 2690 nsec/syscall
> #            OK  global.user_notification_sync
> ok 51 global.user_notification_sync
> 
> If you want to do any experiments, you can find my tree here:
> [1] https://github.com/avagin/linux-task-diag/tree/wip/seccom-notify-sync-and-shed-short-task
> 
I'm happy to further test on this. One thing I'm curious about is, where does the
benefit of waking up seccom task on current CPU come from? Is it due to hot L1 cache?

thanks,
Chenyu
> Thanks,
> Andrei
