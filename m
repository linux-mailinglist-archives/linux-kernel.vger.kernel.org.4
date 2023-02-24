Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335436A145C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 01:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjBXAgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 19:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBXAgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 19:36:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29854DE16;
        Thu, 23 Feb 2023 16:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677198969; x=1708734969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GDXnNACRdrN2NIKrcp+Zdj5g8PX7XtNVUvv6a5bWAx8=;
  b=j9L8z8Wr2Y2f2G1WJ+StucYiFu83yUXUDc2dtqQGdwPXPv8wbF8iAFrl
   69HKo/CJSiXILeT3Q/tO1SvaHPMYtVQ0xDOZBbbgDZtTaroQ+o+zY31nO
   m/A4qOJWvCBo7ZISyB7yti2LR7zlGL0cS2lSmgFSYYhAfl80lEcMh1nVe
   4VONe4KhQBFhjGCZzM1ILYaBPmghI9k4K8/kG42tqqzGwma4gwQ6zNWZp
   XyyPLWckc0V3gdj77ZN2eTWGTJ6TcGqTcxTzWpM7V/fdEppGufEquNB41
   4hRtzZQL4Hp11EJ7g+eicW2T2cez/6hV8Yg+kb0YACo1I2S4iGaATfllV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="331095499"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="331095499"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 16:36:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="796549712"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="796549712"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 23 Feb 2023 16:36:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 16:36:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 16:36:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 16:36:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAw+Stcf858l7vV7z+jwT2cVbYVVf3wWlx6hoJhWC2bXzlODlnAthd1G9Yw5vnVwaz0Wnnj7pHSM7MzvOSo89niYFVFJYzbLnEb2GeAujEjhMYTErVsA3k8TJYBR1sZSOlxYqmtKzIcxMP8lLYaFa8fRHKmXoJGsqepI9F2sfG4/1p9Ws11iB6RiV0jHN5W82GnXi1SHqKvesel0X/7HP/77Ry+uZBNoE9/lwPceE2CpWyp2ldJe8jrJmlMa8CoRjjGxqwoCccJRKDfOQ/kffPhMmUPwLhJR61U85fqQglKvWPK8f69TAWfPGuV6FLqNnF8iiYNOyfePe1Aqfg5jiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxZnBS/JSo1LiW3JW+i/6jpNBcRaqoSLUVYT5xlh2X0=;
 b=DaN8wIjEILTRyIVpeYM/7WtJgvWR68cUp/+4uPs3goCXnaZdHWiKGvD+wQMRVEyy71PKyhucBqVqmeFxnm93i4YuZuWqvpLJmB8JKBlwdVmrBiCgN9oXeHpBbxYYjWcWgV+0C3FZeTMYqM/RCcneZar5HTHUjdaAbLEnINu4IlMO01ibD8JKaq36YN9rbB+bPu+j5CGQGY4KzvQ1I0XjQdMv0LPhQGIpftwpqiKy5o3YFFZ5sJM1U93301qMkQJKbr97S9NeEaC7Kb0T5k4i1WfBXN4rIlOYQKxwFl0fQUTt5M4vidxgLK98czG4tJ+zNumMCJZkNiW/I4DEbWSfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 00:36:05 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%4]) with mapi id 15.20.6111.018; Fri, 24 Feb 2023
 00:36:05 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Thread-Topic: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Thread-Index: AQHZR0+ogcttGObez02wrCHslcltHq7cNR4AgAAAcHCAAH5tAIAAi3SA
Date:   Fri, 24 Feb 2023 00:36:05 +0000
Message-ID: <PH0PR11MB58801B94B0374865394E9F8FDAA89@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230223063022.2592212-1-qiang1.zhang@intel.com>
 <IA1PR11MB6171F5F6B525B6C599024C9D89AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <PH0PR11MB588084641FFB675A102BA503DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y/eP4h/chB8J0rAj@google.com>
In-Reply-To: <Y/eP4h/chB8J0rAj@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BL3PR11MB6508:EE_
x-ms-office365-filtering-correlation-id: b0008f09-57f3-48ee-5803-08db15ff1d35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OimXV1+0zX0wr9/0RwUze3KIfiY00w9pZEknVf92XQOpD+0O/+LfVbETkZVpmm3lHTV1Xq1kWmVCC2/If90gvq4qHjW7/s+o+yrqmmCpCrXTSxVBkaQ9a6faVIJeXtQ4AqX7C63Y3LORUh83BqIF8ksp+o+wymo8Ne1Jj7/C6cQepgZKPU9E1mXupZsFFNBF0v4h9Y/bd9lBA6nZjkl3BxWI8XndpS052nw5532ebDaCjltWSyvGYa6jTHhFsb57q+th+Kh4mBHKYxCOfZ/Qbtid78PvzsKhgf7G1yVJ+5aW+KR3X+O05z5lUFYEcsX4VLN5XH8xlCDvUlPqgCiiFF+AE6FpwCL9fJZ7/qNC6GlAKKZnGHBCY4XYg2Fg1dE0AFj8y0STa0NE9FdFzXw5SH1DIq0IlWppfW9p6xtC0MeBrFtS4e8cm76PSQJV7RrUmuv7U4HkM2TxPe2O2LSs5J30Kccf00I6RP0JQLm5outEHBVZUw3Pbqjz5pjzx9poQcXiwH33xDEL/LQHcv6bHGxqlo1mZeAe+2jFTynE/OfKv/EbTSD1BhRylN5I7F/IfqpZ0CzINEqUE0o92pSgbzC1mPsBis3AiZWZMHvrrW/aOTwZxdSuQtvTSYlKienwA6aXrpwUVD7eJhCKpWzUq8e6iCFZurfkcCcipze49kx72WTKI6QZYO40pmOs2Kex0Ae2xE556qolj1lCaEHTeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199018)(83380400001)(316002)(54906003)(33656002)(76116006)(122000001)(38100700002)(55016003)(66946007)(82960400001)(6916009)(66556008)(64756008)(66446008)(8676002)(66476007)(7696005)(9686003)(4326008)(26005)(186003)(41300700001)(966005)(71200400001)(478600001)(53546011)(5660300002)(52536014)(6506007)(86362001)(2906002)(38070700005)(8936002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eJ2BVTVj+ckp3i/OsotwV32JaCRWntABD+9KE4+Cp0YJms1Xdt00M2otER1I?=
 =?us-ascii?Q?Ntyx+/bGbNbX7srKEm2KbCXRfqoPgM0uURN1W+pNqzPoouJQHWQ0kmE6MbeR?=
 =?us-ascii?Q?huZmOM46XrV4aKCAbIpu1yre0yhUYSmADfwzCjyfu2UParJcSWY/4dYBcxUB?=
 =?us-ascii?Q?m9yeVLTt3WUN80Zn+J/EE/bGFQQAkl8InvL/wSp0AiLAbsii9/P352kewV42?=
 =?us-ascii?Q?4x4x4i3g6dEkpwZ8t3MgtO2XJzugZ6/2XW+yZDDJnyR0bvWaWn711yS+rX7M?=
 =?us-ascii?Q?I0KiDn3t3G9qLDGsIHJef5Q/HMBuJr8+OzVk515EYLu1R4rkAJcuo9l+s06i?=
 =?us-ascii?Q?jZRz9S/8kRyK01vApzT6q5e6J+FI26BdtqphlvqaRZ+BAzuFh8x0ZXruz7hA?=
 =?us-ascii?Q?2QK4HwsSDP9eV4pk+sO2hiXyJx6CC32t/3uqjEvaUA8Lf7WKP2o4DCCBvzLX?=
 =?us-ascii?Q?7x8oL5Go4GByn063SJ6v/EbmTTierPmyJet4Urlcjo1lhWd4nrJB7jofl4e4?=
 =?us-ascii?Q?AyCDaPAoAIPxcZjA336fULMoeaFypx+Z7+DAe0wKMp1K6f4zxcO7At/mjD8/?=
 =?us-ascii?Q?denJkfa43vKdjK7UDJzbWxTKCm20dPbeEK8dVGP6/NRSzK8rD8GCPgQScu8n?=
 =?us-ascii?Q?maf/Z7JSvfSsMrDrSsKuuc+gYvQNwfoq014xL4yFVNUiqq+CSAT4hP2DuXFa?=
 =?us-ascii?Q?PMEfrMgIRBfZ1BXiPbKyeI8Op54MEojOXLb5EcDErOiwqmlCLkvpjUCLhOrG?=
 =?us-ascii?Q?3bwtXBAiKKkxtDX/2xNDGWIOdiARusZwV2eqmE7hnHTQvot092tXjOMEeKdg?=
 =?us-ascii?Q?ODuG/9jxR5AJXTrTSIo7qF2qlYY0dI4XULuILwupLhIm6/y16NkR6pt0ew/S?=
 =?us-ascii?Q?HshXDP3vcFAsUMp4cYg15AiOrcfZLXd4RXdGXZuVn/PuA0qUQRNj8iyjHDxT?=
 =?us-ascii?Q?9qSFJnQj4XbM/8KM+uVDdL/+ReN67dsm3ek24sse+oUTK286xCLY5nCuV2ZX?=
 =?us-ascii?Q?lh/e9u9EsOq2pY9slINW3C/lFI1ebXJWIxl4UF8IbBuoxBqZ86sEVqvFrjB3?=
 =?us-ascii?Q?ES28f7xSSMiKsUqUWhdRTY1JUocfOXU9xFQ0xU0AXwzmU+Cdug6kY0UBYVHQ?=
 =?us-ascii?Q?JyBMH1gs1mIVk6Y2ThoHgHu0ecoIPuVupHPqJq/Lx9eghNkV5LStJIgd+Q/l?=
 =?us-ascii?Q?tiJVoNB5rJjJmz5zaRMxhfp+ub4Kn9kTJz1xvwtB2/lBCA8QsBtArqJr5zpt?=
 =?us-ascii?Q?IyJnhd8kavDKuPSaTL267385sSnbQS7w18+bIo6D315xU02w9osNzhahfAHa?=
 =?us-ascii?Q?1vh6KVbmL9tI/HBzLeAUSpEeUHuvcTKk5YPtS7D0l/axDemIVvH19L7RsR76?=
 =?us-ascii?Q?quPoPCfDW4ZoskHYv2QRa5oMVQ54M5pQmfGyws7cn3rk/lci6tRQgkbPQBnt?=
 =?us-ascii?Q?wIrGy1lnJznP96gTqX1qTf8bqugZ3TQsirLQI2EbwhSqdrnpyzJEPvtISaXL?=
 =?us-ascii?Q?mH1da1cSt/uo4fjAvsn3h9pJxAgoVCdc+4IY7XA77BKsqgmMMTKnm47+E3vM?=
 =?us-ascii?Q?zG6RugGGzkGbvmmI5QwRv3JdqmtrVZfOFgUW8YHX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0008f09-57f3-48ee-5803-08db15ff1d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 00:36:05.3467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjxRLfN+lCyAVwMgWw0XfVj1/mx4h+5tO1cKo+SmDd7Fh+QJSGo3s5X69QVAIJS1nAsZgyEcPt8JW0MzEINvrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6508
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLACK autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 08:43:05AM +0000, Zhang, Qiang1 wrote:
> > From: Zqiang <qiang1.zhang@intel.com>
> > Sent: Thursday, February 23, 2023 2:30 PM
> > To: paulmck@kernel.org; frederic@kernel.org; quic_neeraju@quicinc.com;
> > joel@joelfernandes.org
> > Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
> > call_rcu_tasks_generic()
> >=20
> > According to commit '3063b33a347c ("Avoid raw-spinlocked wakeups from
> > call_rcu_tasks_generic()")', the grace-period kthread is delayed to wak=
eup
> > using irq_work_queue() is because if the caller of
> > call_rcu_tasks_generic() holds a raw spinlock, when the kernel is built=
 with
> > CONFIG_PROVE_RAW_LOCK_NESTING=3Dy, due to a spinlock will be hold in
> > wake_up(), so the lockdep splats will happen. but now using
> > rcuwait_wake_up() to wakeup grace-period kthread instead of wake_up(), =
in
> > rcuwait_wake_up() no spinlock will be acquired, so this commit remove u=
sing
> >
> >There are still spinlock-acquisition and spinlock-release invocations wi=
thin the call path from rcuwait_wake_up().
> >
> >rcuwait_wake_up() -> wake_up_process() -> try_to_wake_up(), then:
> >
> >    raw_spin_lock_irqsave()
> >    ...
> >    raw_spin_unlock_irqrestore
>=20
> Yes, but this is raw_spinlock acquisition and release(note: spinlock will=
 convert to
> sleepable lock in Preempt-RT kernel, but raw spinlock is not change).
>=20
> acquire raw_spinlock -> acquire spinlock  will trigger lockdep warning.
>
>Is this really safe in the long run though? I seem to remember there are
>weird locking dependencies if RCU is used from within the scheduler [1].
>


I have  been running rcutorture with rcutorture.type =3D tasks-tracing,
so far no problems have been found.


>I prefer to keep it as irq_work_queue() unless you are seeing some benefit=
.
>Generally, there has to be a 'win' or other justification for adding more
>risk.
>
>thanks,
>
>- Joel
>[1] http://www.joelfernandes.org/rcu/scheduler/locking/2019/09/02/rcu-sche=
dlocks.html


The problem in this link,  in an earlier RCU version, rcu_read_unlock_speci=
al()
Invoke wakeup and enter scheduler can lead to deadlock, but my modification=
 is for
call_rcu_tasks_generic(), even if there is a lock dependency problem, we sh=
ould pay
more attention to rcu_read_unlock_trace_special()

Thanks
Zqiang

>
> > irq_work_queue(), invoke rcuwait_wake_up() directly in
> > call_rcu_tasks_generic().
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tasks.h | 16 +---------------
> >  1 file changed, 1 insertion(+), 15 deletions(-)
> >=20
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index
> > baf7ec178155..757b8c6da1ad 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -39,7 +39,6 @@ struct rcu_tasks_percpu {
> >  	unsigned long rtp_jiffies;
> >  	unsigned long rtp_n_lock_retries;
> >  	struct work_struct rtp_work;
> > -	struct irq_work rtp_irq_work;
> >  	struct rcu_head barrier_q_head;
> >  	struct list_head rtp_blkd_tasks;
> >  	int cpu;
> > @@ -112,12 +111,9 @@ struct rcu_tasks {
> >  	char *kname;
> >  };
> >=20
> > -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
> > -
> >  #define DEFINE_RCU_TASKS(rt_name, gp, call, n)
> > 			\
> >  static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) =
=3D {
> > 			\
> >  	.lock =3D __RAW_SPIN_LOCK_UNLOCKED(rt_name ##
> > __percpu.cbs_pcpu_lock),		\
> > -	.rtp_irq_work =3D IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),
> > 			\
> >  };
> > 		\
> >  static struct rcu_tasks rt_name =3D
> > 		\
> >  {
> > 		\
> > @@ -273,16 +269,6 @@ static void cblist_init_generic(struct rcu_tasks *=
rtp)
> >  	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__,
> > data_race(rtp->percpu_enqueue_shift), data_race(rtp-
> > >percpu_enqueue_lim));
> >  }
> >=20
> > -// IRQ-work handler that does deferred wakeup for call_rcu_tasks_gener=
ic().
> > -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp) -{
> > -	struct rcu_tasks *rtp;
> > -	struct rcu_tasks_percpu *rtpcp =3D container_of(iwp, struct
> > rcu_tasks_percpu, rtp_irq_work);
> > -
> > -	rtp =3D rtpcp->rtpp;
> > -	rcuwait_wake_up(&rtp->cbs_wait);
> > -}
> > -
> >  // Enqueue a callback for the specified flavor of Tasks RCU.
> >  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_=
t func,
> >  				   struct rcu_tasks *rtp)
> > @@ -334,7 +320,7 @@ static void call_rcu_tasks_generic(struct rcu_head
> > *rhp, rcu_callback_t func,
> >  	rcu_read_unlock();
> >  	/* We can't create the thread unless interrupts are enabled. */
> >  	if (needwake && READ_ONCE(rtp->kthread_ptr))
> > -		irq_work_queue(&rtpcp->rtp_irq_work);
> > +		rcuwait_wake_up(&rtp->cbs_wait);
> >  }
> >=20
> >  // RCU callback function for rcu_barrier_tasks_generic().
> > --
> > 2.25.1
>=20
