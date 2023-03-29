Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500C36CDB43
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjC2Nzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2Nzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:55:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6821B6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680098136; x=1711634136;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qFfxA1HL8T/V2c1CTMmywdh7UO5dAw9kkTFHtVJajsk=;
  b=D4BO9aVelhbvQFMmQZANEcuWeLOa711OC9FwYFb+3D+jWGqFDgXhCfyD
   ip5XJHYaYrvDxa8rnp3UQbJyYboV/pzP6W6+iCVOmoePnttpZ3iq2IXW2
   s4L48QJywpvS0iW3V1X9+X4h1twSon1jfMeVIOYYfeowO5vKpxJnQYYhH
   Z7q/Qc0VuCtfmVJuqmUY/PRtIaDuF6SBXVFDvrr0ScDfbWWQnbuWmy+1t
   FKoysJ3d5V8FFEN0ah86EaLalsslulX24mogrv4AQVWZJU7THRyChKY8b
   DKKEKXb7Wn+UUbiY66zESCUBllB65NzeJO8DC+SLEsAI/PIF1dGoNxrae
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368652627"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="368652627"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:55:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="661603155"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="661603155"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 29 Mar 2023 06:55:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 06:55:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 06:55:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 06:55:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maQLXmWs+h/EVqZSZU3i9BZp9DbxP3R6mTfG6tLqIZOjScWFCRz7LwlN3RJYb/xIjIcfNpd9HmPx6j5eGnuBwb52zS/hV4HXQbZDhZwHy1qjDLNFL4deCM8wF49EV8A8+Xsui8KebQMuDlna44E0kOHBJGMbzbqPkzlLw1gf7kGxEgPGi0a4APE3pRzOW4SuxlGORcAYuj4OqW9ss2GEqPewOTDy5wv+tiaLdTVyii/SpuuxHMummmx35kLQMt3zXPs8rhdPtFv7Xj+peJjja9EC0EeDtp35DYEzPmQmk18t0mSiUeAZxDYp/fQ4ep3OPUH8CLPiD01+Gw1SZx1YsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p2GObb7Z83RUxRkvwsq8gSaTChhwU8LYauPqrVAt/k=;
 b=h2ii41aEnFwVy9/QgLG/SopOTdYOTQ02xQWr1Ui8aEwvyR+Q8P2NFyfa11d+/236JqZ3LVEC88v4HKJgEIRK0VbN7aSxu69SjgbW2CzcXucnlwQLeV8rWu8hpMWBaUlcWY13aLM6O9oRZObj9VOHPBPmOleCigWaColVtij2uED5FeaNAZ1QrVDwaQa+bZ/4m/UIOXjFUTpVUzdaU5PDvtpJRvtMm2LM8CPfiUV8skY78y9HRg/T5YyRpARDqPHYBFGsrn62+vrqDtw+5GtntqfdGvQ4NPSqIJOZ0dW+ShBR5xSqfIRHuAF3OrIBpa9vcLeMsW/m/xxJsZXX8D6hWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Wed, 29 Mar
 2023 13:55:07 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 13:55:07 +0000
Date:   Wed, 29 Mar 2023 21:54:55 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Tim Chen" <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230329135455.GA108864@ziqianlu-desk2>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
 <20230328125624.GA6130@ziqianlu-desk2>
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DS7PR11MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 131123ae-8635-4a65-2bd7-08db305d3444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55Jmqes7Khq+hMsURkQ7dZ+2WAQPDJBWC4Aqol2IoQ4Mg4WYN+Tk8+hDOvWZvGLINoQkTUwugBl1gsNKT/jN5uG0pgpyAvN2CXHsYquCPi0WwRkLuwu1knT6BBvfhAWOlmMJ35y/cCS437Du/tNgxacEcSqEd7930pzdzOMpYHCitLXIRdYfaVs3KXDzQp+ACY6uJozjWdQ9y0QndcGz7+BytOddCr/8Stzjt7AiTRs5A89ot0aP39IEXGuRFklSIIEYVYVS9ijHLNnH3Qs3Q+E1Qfcqya8cfEsTDzC17txs+l8MpzFzNA4lbraYWOMOZ0RjGTJuahpnOSmA0lTbu0nenQ3RgEMlET4nth1mqJxUJ3iJIyNFJpFyk8XbysxZgmyddGu8/SLq+KXG5utrFlCSvqzqk2eLaYgdosUEapyv6SsvPIyqlIPdhT1pn+PpYASaPFUz6PNH5awKnZlY7sjAQ5murSEU0bdzRZ/30MkSdGDzp/vwwTb3mpmQ0t5Ts+z8am1g032xXOPrzC4bzVJSJn+lDFmKgNvfvHK8NJ/G4Clcj+rcsROQ/BgN3lagYFXPhpaHHwfDwQCxjoTvx2G23gudsg1GeTSATYDRuovbh7nC9cxg+UvAwXRpxfy6DSsFJkVivkpcb4Yykwl1RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(8936002)(84970400001)(2906002)(83380400001)(6512007)(86362001)(41300700001)(38100700002)(33716001)(33656002)(5660300002)(6486002)(82960400001)(966005)(54906003)(66556008)(478600001)(8676002)(66946007)(6916009)(4326008)(66476007)(6506007)(7416002)(6666004)(44832011)(186003)(1076003)(53546011)(316002)(26005)(9686003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LlkE0AiuBsli7yyl/QLQFl7umekEAeXQlb4gq1k0qT5k/MqZxEptcSa72rkm?=
 =?us-ascii?Q?CSeZ8ee32E/vC+9KH/jCyxrHR7FwY1elfdJ6fPv4xWtEpZsgslLcuY2BVSQD?=
 =?us-ascii?Q?ELygKMCWA3yTE+vwwOrEkrUkvfEIMaafQvLFwtKeYs8jSc3gd0c3mNLLBp2V?=
 =?us-ascii?Q?/c3CldHR9+JbuJJJlT9UIEVbl96KIXNweEmJiGcTqTqssX6zYhhphJa7W80V?=
 =?us-ascii?Q?6k2oBK0UGocJ9vyn3uvYKheF8aRkLFIp01VQKM88TaFnke9Uu0/2enORqSRS?=
 =?us-ascii?Q?CNuNJTRiRMZuPJakowGlrUTaMHR/aJbMYDsWaHPzas7ct6L6CW621PLbz0Qt?=
 =?us-ascii?Q?TVDfpo+H2Y+VmQqNVe2oWFAEkMSvC1QoFPT/i5nycq3/gVMBbatNBC3jJ9Ih?=
 =?us-ascii?Q?ruZEFWLQX4lhHuxccCvlzBCBw1SR9w64TEgWgl0cikCoOyMcJX7brq+efOWb?=
 =?us-ascii?Q?eSKarMjHVB67woNIF+3xpRtOTTOmz8XLmwt8aYTQ6K9k5IkwGd4RLLNE5iq+?=
 =?us-ascii?Q?vJrlPJvxGKDVodVmPQTape6HNlXv/yHf05w0QO1wZgLxS8hR8RaCGtJpMeh0?=
 =?us-ascii?Q?ZV7E5Q8Za6oZT17FJv1PQa0qZcYrRZx/RCkYqCher4/3FAqTxYJ/ou8a1mNi?=
 =?us-ascii?Q?nPMOhqGRpfVQ5q7Rn2jpASSRX09405KLBlYH/K5HOSp6KRZJp/yXnMC1osNU?=
 =?us-ascii?Q?3Y5kBCdHI0WztF8Pzuq0QwplYqdpNhLAAU/ZzrxWte2/M4ofcBmmGEui6A4v?=
 =?us-ascii?Q?Y5vy2b2pkugiHW3vk1j0TWWvolEn1YXJcGliZGUZGfg6QEgvyqp4HJt5M05d?=
 =?us-ascii?Q?mMyyLmwQq0NfNHyE2L3Cxlh5pKYnUu/NJlpzEeivBbsx0+fy+n2tQTZtqacn?=
 =?us-ascii?Q?po0mBLhzQ40ppkrQvFCM7FYHGmdVAovyOaonUbL81RFsZE0j4UOfJa+NhRmv?=
 =?us-ascii?Q?l1S49mpI8FoS+FcldOsQdmkJ356EC6TBXlg/gtuKty3zDrwB/ce+dsuGtpai?=
 =?us-ascii?Q?GhsWndRNJedNZhl1dDCfzvayYcFP9iw5VPdvNvzHJOTgrPNqrutSGazeAprD?=
 =?us-ascii?Q?yJOIrTeYqhC3V5sFAz9yRvfvf2plSxc6NWknbU7fUYmJPq+pNYBdFac86qRO?=
 =?us-ascii?Q?3Te8rj7Wa4Exp21GgmuXn0L0mxpzjdlEfJ6b/kQEe47tGU3DB6/PYx27A1xD?=
 =?us-ascii?Q?uIz8gYFHp+H59vJhd2HJ21E/TXJgRIPaGggGZjZAOVf1JYpk+FeUdaj0rc2U?=
 =?us-ascii?Q?hnWER5/cbmZnDLEAt6/FXLzKgC9EnUu5INm/YNDK/uJwDrS+Micnq06Xl7pw?=
 =?us-ascii?Q?SEsBby4E1e+oTN14Ww1qxz7XBjkTgPIKBkAX1+1eRG7yXRsQ7Jpz1QNvomHo?=
 =?us-ascii?Q?ZODCGN0NCJdEaza/KSE+lcYvoIkI7+XAjJtaHAkJr3ZoKHddTLl5qbs7ri9C?=
 =?us-ascii?Q?xogoF96CEq+Td/ZBVA2A+ePDPEOCgMHPmg5ef7lYiAlcRCV7hoLs/HVTUwbO?=
 =?us-ascii?Q?0Y4WHCKswKz7C30YY8j1sG8BbxzfJaEoNQSM65W7bBBsbW33H4KfhoYympTt?=
 =?us-ascii?Q?OT0H4CJ14f9tEzMi1Q90N+GBdzcC9Ks3kNeXPx35?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 131123ae-8635-4a65-2bd7-08db305d3444
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 13:55:07.3304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsIusLU0zKXhxho0BMHcI23F4PSQyQlrZcozsS/nLmMp+AMOUj8+l+een1uU/GxotzOWBoMJHZaSQOXTUz1dEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6103
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 02:36:44PM +0200, Dietmar Eggemann wrote:
> On 28/03/2023 14:56, Aaron Lu wrote:
> > Hi Dietmar,
> > 
> > Thanks for taking a look.
> > 
> > On Tue, Mar 28, 2023 at 02:09:39PM +0200, Dietmar Eggemann wrote:
> >> On 27/03/2023 07:39, Aaron Lu wrote:
> 
> [...]
> 
> > Did you test with a v6.3-rc based kernel?
> > I encountered another problem on those kernels and had to temporarily use
> > a v6.2 based kernel, maybe you have to do the same:
> > https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/
> 
> No, I'm also on v6.2.
> 
> >> Is your postgres/sysbench running in a cgroup with cpu controller
> >> attached? Mine isn't.
> > 
> > Yes, I had postgres and sysbench running in the same cgroup with cpu
> > controller enabled. docker created the cgroup directory under
> > /sys/fs/cgroup/system.slice/docker-XXX and cgroup.controllers has cpu
> > there.
> 
> I'm running postgresql service directly on the machine. I boot now with
> 'cgroup_no_v1=all systemd.unified_cgroup_hierarchy=1' so I can add the
> cpu controller to:
> 
>   system.slice/system-postgresql.slice/postgresql@11-main.service
> 
> where the 96 postgres threads run and to
> 
>   user.slice/user-1005.slice/session-4.scope
> 
> where the 96 sysbench threads run.
> 
> Checked with systemd-cgls and `cat /sys/kernel/debug/sched/debug` that
> those threads are really running there.
> 
> Still not seeing `update_load_avg` or `update_cfs_group` in perf report,
> only some very low values for `update_blocked_averages`.
> 
> Also added CFS BW throttling to both cgroups. No change.
> 
> Then I moved session-4.scope's shell into `postgresql@11-main.service`
> so that `postgres` and `sysbench` threads run in the same cgroup.
> 
> Didn't change much.
> 
> >> Maybe I'm doing something else differently?
> > 
> > Maybe, you didn't mention how you started postgres, if you start it from
> > the same session as sysbench and if autogroup is enabled, then all those
> > tasks would be in the same autogroup taskgroup then it should have the
> > same effect as my setup.
> 
> This should be now close to my setup running `postgres` and `sysbench`
> in `postgresql@11-main.service`.

Yes.

> 
> > Anyway, you can try the following steps to see if you can reproduce this
> > problem on your Arm64 server:
> > 
> > 1 docker pull postgres
> > 2 sudo docker run --rm --name postgres-instance -e POSTGRES_PASSWORD=mypass -e POSTGRES_USER=sbtest -d postgres -c shared_buffers=80MB -c max_connections=250
> > 3 go inside the container
> >   sudo docker exec -it $the_just_started_container_id bash
> > 4 install sysbench inside container
> >   apt update and apt install sysbench
> > 5 prepare
> >   root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=224 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua prepare
> > 6 run
> >   root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=224 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua run
> 
> I would have to find time to learn how to set up docker on my machine
> ... But I use very similar values for the setup and sysbench test.

Agree. And docker just made running this workload easier but since you
already grouped all tasks in the same taskgroup, there is no need to
mess with docker.

> 
> > Note that I used 224 threads where this problem is visible. I also tried
> > 96 and update_cfs_group() and update_load_avg() cost about 1% cycles then.
> 
> True, I was hopping to see at least the 1% ;-)

One more question: when you do 'perf report', did you use
--sort=dso,symbol to aggregate different paths of the same target? Maybe
you have already done this, just want to confirm :-)

And not sure if you did the profile on different nodes? I normally chose
4 cpus of each node and do 'perf record -C' with them, to get an idea
of how different node behaves and also to reduce the record size.
Normally, when tg is allocated on node 0, then node 1's profile would
show higher cycles for update_cfs_group() and update_load_avg().

Another thing worth mentioning about this workload is, it has a lot of
wakeups and migrations during the initial 2 minutes or so and a lot of
migrations is the reason of increased cost of update_cfs_group() and
update_load_avg(). On my side, with sysbench's nr_thread=224, the
wakeups and migration numbers during a 5s window are(recorded after
about 1 minute the workload is started):
@migrations[1]: 1821379
@migrations[0]: 4482989
@wakeups[1]: 3036473
@wakeups[0]: 6504496

The above number is derived from below script:
kretfunc:select_task_rq_fair
{
	@wakeups[numaid] = count();
	if (args->p->thread_info.cpu != retval) {
		@migrations[numaid] = count();
	}
}

interval:s:5
{
	exit();
}

And during this time window, node1's profile shows update_cfs_group()'s
cycle percent is 12.45% and update_load_avg() is 7.99%.

I guess your setup may have a much lower migration number?
