Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940FF63B941
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 05:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiK2Eyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 23:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiK2Eyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 23:54:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723B3186C6;
        Mon, 28 Nov 2022 20:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669697675; x=1701233675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XU9hr/kWuet6BJSbYMWijXAtYtPsurCS7es5C+aV3es=;
  b=Wm8LuIxY9PWP4p1Z32tGJBR/6Ti0SW9NYxQ5y7f2ZzI5Ca7S0eGbnDqh
   orPXt+MXZtl+nu2KdNzcp78YBUEar+nRGb3k4nnt5699GIRXqzNXb4FS3
   /S2ROLbyVV6j63J6cYatIEFooF9gaOwXPN+hMzB3HQJyYyapynvlLTXMx
   aMUJDdPVb4quPugnqHr3ESFPMigRQIbEhfq96PlEGPQnY/rajonT221za
   hsRSFEddberD78TMZeNjcR27GOKBk7u1hyLjLaWGK8l/K13baL2Pr6gN2
   KjN9mbrUQEU0gSjR87O4HEYcWro7/uF/UdfPj7MaeVUQ3LJ0VDki2+OJ1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="302608851"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="302608851"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 20:54:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="645759611"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="645759611"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 28 Nov 2022 20:54:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 20:54:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 20:54:34 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 20:54:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l48/tB33DmNq5mlzQ5GRkiEoI0brb8mxkpBkVMS7NB0SS+JK2KSoF8n7DlLT8X5sJUAWVqXPSGeXRnWguT3RzCV8wdJddbgZ7gwWdsxVU99e43NiWDiUR+aVT8qlnfHj0SDePs6DWg04EHgn8aa03dv5Oyp7xedaMLJaz/v65wqh8Gru8bN0mPNbHp1efNWPnUJoFyJPbhxfZoviVfUoT/5BEbvrcs61yxa3Ht4YL1lEUXmP0Gjb4SB0K0I2OKW4LMtWnMHVb/iBpnLwlJQtOTdvH93OdNsLQ/obnLsXWttI3+NhCcfrAmqfq1kC7T8/BOE75dYJjgU4Gr4znoS+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp3AwHYnRVPeRyO+3DtGCyRxozLHv39GCYrRp3JFs8A=;
 b=PRJIptSADv6HWrwhK+QMfjDmFT08l/zb69/TuiWUqDRm0cazFeM5PQMirhHqJqq/om7T0rQm18Aoh7S8b7jhSoSa61c/CX5dmfojRiE3qu4owpCU7KhTjFn3jhbVSHV4UCCVs77O4cUMKu8c1/rxPWRTbxNQY429XXH8l4XEXwqfG9JYeWEUkCRQ1dMQu6UXXiP0aHtPEX2kfMIvmHosDwnUYz+ixBs/eK3l6TQZtwLCG0Ig+WuvCKDxWO0aIV79sxVhLnYQvrYAKso+O0LvDe+NrOaeqombiOUVlV/0xKdFKZODs4stHCt3Ag1a++/7vXiKZTWyR7ponhnIy6aZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CO6PR11MB5668.namprd11.prod.outlook.com (2603:10b6:5:355::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 04:54:32 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%5]) with mapi id 15.20.5857.020; Tue, 29 Nov 2022
 04:54:32 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Topic: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Index: AQHZAzXSKOjuTzu2RUKeoTlESXbs8q5VFkkAgAAryDA=
Date:   Tue, 29 Nov 2022 04:54:32 +0000
Message-ID: <PH0PR11MB588001E6982A9DC32F93FD7ADA129@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221128143428.1703744-1-qiang1.zhang@intel.com>
 <20221129010312.GS4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221129010312.GS4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CO6PR11MB5668:EE_
x-ms-office365-filtering-correlation-id: 83c9ead6-ef5f-4e56-6651-08dad1c5ce43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1T4xW5V2PFpaYJD1caAdJORG+f1tYKaPO1uIbaF7i5tjn4Misp7TlXx3TGP5avWEGQJ0vgE1z91KNpX2M9fHuynCdjXpDnktAzMy3NmfoUmOKr0yesTDyZXAc5pifmCSyu7IGCZYMaaasHu7EB0urVJXXY04z3ZoHwuH2Y6q0rZA/U0rRecP/mbj0az+AVsAMO5MvyqzYDzE9o4c+Z8XAPhNtXhII0PDJ3iMy5tf9cmFUKwAAhnOB+bgVNWYwZu6FHYP03TRq/oFKfe3mtQMQJwngb4pvCo8P/SdwB/dlgnR8/ceGvII0pgeT07jLTLU1HHH70gzM73bQCwE65hZf0Vhi93NIDLu6JfMEQsMcl2uH6jYC7pzCuX2tLwBv15Zl9rwZ90GTR7e3fd8i0BXjORgyn2fZeSpFIwCO2aeI2fxU4aCjbqqb9ZjJjsM0XJVMD5ZOq6Nx+xfXBcA/Y1Wh9Fbl2dVcDXOOxhzDIQP6mGlNqtgLk873ACz27cWC2h34LpnehU+r5zMrPUiLCOdxHXqRS6muhtvZPD/KwaLHLAuX2IZdke04BwqDEm3/r8cHfraFCHWfdqRKRxrhTpy0aU6PFH7CPmXsFPWmbCtlucOWb5KvXHpurFv7JV2+V4o4wvTCohph+qSDlKOxQ/K4S4YZt7r1CB4WHdOrUShxYmkhNKsM75S4POIkpWdBQpt+8PNvXRfN+MpuIk9ah8A3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(33656002)(86362001)(478600001)(71200400001)(7696005)(55016003)(38070700005)(2906002)(82960400001)(122000001)(186003)(83380400001)(9686003)(38100700002)(66946007)(66446008)(6506007)(41300700001)(316002)(76116006)(66556008)(64756008)(26005)(4326008)(8676002)(8936002)(54906003)(52536014)(5660300002)(6916009)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Urf4hfy0q2MiMvaYQHtZJ2+S68vxDDEeaUqteBUllnos+drr4QLK8I+iUvBL?=
 =?us-ascii?Q?+lSoJeX+VYlyaSz3UQxuug6lI1IBmMcMI8arcjvw4gHGCkxBDuZUxC1FPlsl?=
 =?us-ascii?Q?eGMDC3eA6eyKHwVmacipAOkZ9U5KHKNwpHANVlWBdSXH/35HMutFFjo4FMZQ?=
 =?us-ascii?Q?jSNRBpknzuIEM7/jLOk/21L3pLoS6yTFuU/rI/A3ZNebr8UUV0stO6cyjY6j?=
 =?us-ascii?Q?8frvMZDDf1GYDCxW3HC4CPU6ejy6qHvSsd/Kc13P9ezF6016Fw7WqEHBD6eN?=
 =?us-ascii?Q?u0i70c8e5EntpgzntVjRlWru6G7mgZsrYsB9wPJTLD1MSoqiRzP/Gm4dGYEX?=
 =?us-ascii?Q?9ELLIKcR5Q7SoiRcPvqTdzSxTv1DpKjI9DKpkoORAR9Rjv2vj0I7IUEwqxO4?=
 =?us-ascii?Q?073/cw59/EchWcYak/1TtRWMMQIdAjDQdZ6KfDb5vYsTisIMgklX7/WBVmIa?=
 =?us-ascii?Q?+rI66T+RDFPFqG7MJJYsnnl2mX/ER2J9FwB9itMrBZN0ryAqWXDZkK1M/yPl?=
 =?us-ascii?Q?15e0N5VJXESwCcBD10IAvNXrG84fNzCXmBJ96UHK6OO5LfNTjbTh60Szi1Q5?=
 =?us-ascii?Q?vEHuR0egqLSJMRzZybwpXCfbXF+x9pGZG0878sj+nVWsvOYmfeVVSG8joiLp?=
 =?us-ascii?Q?Xm2fRxFm6RCtYLMg5Bu5lv3XIrCNO2MF2Nzu8KM8axPM4DwEffyMxnkZCUsI?=
 =?us-ascii?Q?1Um3cs1KCfVXCbPtzczBXO9SQKbjEWfTrwk4mVNbn4xQ3ub+wgz+bKwwTdJp?=
 =?us-ascii?Q?trLKwZHy2SlSCvjVREvPMBUzC1yn7j8ZodDmN+e30mE++lsT57WWZTxADbwl?=
 =?us-ascii?Q?LmMgYEAtlbyfGrs//5OP7PRF+M6QGatQQUa1nuV3eZMMMMjbpyqJO2AG6JcZ?=
 =?us-ascii?Q?4AXZQIdB8hYwkMe2MnomJtGBKimVVrISBeXR+JdLMjJknY2v44UY1P6aMwrO?=
 =?us-ascii?Q?3E5zcPBwNmcojNnM8kBE5dipCshQIhuE+4cPPWCYqDbFy6/r+tEhYuYiwxbm?=
 =?us-ascii?Q?Ohs0wdknEj2aHvUZtc0adHeT07KSkE+1wsUwjRIBvPwWp/rM74s4Mh3daYMZ?=
 =?us-ascii?Q?RctNx01L1Czaq4GxSskk8jNRzEjuUk+AdXgMzq/C3m7OkZlwK+U9oA5BinAe?=
 =?us-ascii?Q?Hmp3wuE7SxhlOfA07ch0fR8XcPn3qt5qN1Z6RwtLWq5ANJgXx1a59OomEfWU?=
 =?us-ascii?Q?ml81qq88iJw80suNrveAs6fdMoCT90mVphcorKj2WbAAtaCYG7LDy6jLo0Iq?=
 =?us-ascii?Q?11+QtvSK4OnPGaUB8SkTZK8bldHgDjWuypuYNaFV8dfX+sHJEs7wAw+jduwf?=
 =?us-ascii?Q?CHzDt+NTv7Tmh4iLVeeNTIhbRoD6dSMfIFO+Dn1vIMRnf9YcWXVMqy1ekpNC?=
 =?us-ascii?Q?NDxRxhHCU0FwEKN6ZqdbWsZxicsw9ayLLfL1o50CyHZRNg+hOLobXzav7lSW?=
 =?us-ascii?Q?JoeVcFM3vN/nEPIcdGJE6sVSByUhGwYT/Jgt6dAFmRAhxJjCJn3yivoDRPXc?=
 =?us-ascii?Q?yQCJzf0QWDOQ14nBrBuo2uHb7NxTlR5/9H+LVb6TkYdmVmV6o7VzglzauVTs?=
 =?us-ascii?Q?+7+wBSgZ3QZVfEM13635H3JUWP9msRsIIZJPU7Ys?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c9ead6-ef5f-4e56-6651-08dad1c5ce43
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 04:54:32.5151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgID7npB+sRK8/ptD8FI/n6M9rWLYdz9Mdp2c5gx6q1+xxzn3DpHbrxkaezmsYe0BYMJ0KTGTTmamimuMhpBiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5668
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:34:28PM +0800, Zqiang wrote:
> Currently, invoke rcu_tasks_rude_wait_gp() to wait one rude
> RCU-tasks grace period, if __num_online_cpus =3D=3D 1, will return
> directly, indicates the end of the rude RCU-task grace period.
> suppose the system has two cpus, consider the following scenario:
>=20
> 	CPU0                                   CPU1 (going offline)
> 				          migration/1 task:
>                                       cpu_stopper_thread
>                                        -> take_cpu_down
>                                           -> _cpu_disable
> 			                   (dec __num_online_cpus)
>                                           ->cpuhp_invoke_callback
>                                                 preempt_disable
> 						access old_data0
>            task1
>  del old_data0                                  .....
>  synchronize_rcu_tasks_rude()
>  task1 schedule out
>  ....
>  task2 schedule in
>  rcu_tasks_rude_wait_gp()
>      ->__num_online_cpus =3D=3D 1
>        ->return
>  ....
>  task1 schedule in
>  ->free old_data0
>                                                 preempt_enable
>=20
> when CPU1 dec __num_online_cpus and __num_online_cpus is equal one,
> the CPU1 has not finished offline, stop_machine task(migration/1)
> still running on CPU1, maybe still accessing 'old_data0', but the
> 'old_data0' has freed on CPU0.
>=20
> This commit add cpus_read_lock/unlock() protection before accessing
> __num_online_cpus variables, to ensure that the CPU in the offline
> process has been completed offline.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>First, good eyes and good catch!!!
>
>The purpose of that check for num_online_cpus() is not performance
>on single-CPU systems, but rather correct operation during early boot.
>So a simpler way to make that work is to check for RCU_SCHEDULER_RUNNING,
>for example, as follows:
>
>	if (rcu_scheduler_active !=3D RCU_SCHEDULER_RUNNING &&
>	    num_online_cpus() <=3D 1)
>		return;	// Early boot fastpath for only one CPU.

Hi Paul

During system startup, because the RCU_SCHEDULER_RUNNING is set after start=
ing other CPUs,=20

  	    	CPU0                                                               =
        CPU1                                                               =
 =20

if (rcu_scheduler_active !=3D                                   =20
	RCU_SCHEDULER_RUNNING &&
       	__num_online_cpus  =3D=3D 1)                                       =
       =20
	return;                                                                   =
      inc  __num_online_cpus
							(__num_online_cpus =3D=3D 2)

CPU0 didn't notice the update of the __num_online_cpus variable by CPU1 in =
time
Can we move rcu_set_runtime_mode() before smp_init()
any thoughts?

Thanks
Zqiang

>
>This works because rcu_scheduler_active is set to RCU_SCHEDULER_RUNNING
>long before it is possible to offline CPUs.
>
>Yes, schedule_on_each_cpu() does do cpus_read_lock(), again, good eyes,
>and it also unnecessarily does the schedule_work_on() the current CPU,
>but the code calling synchronize_rcu_tasks_rude() is on high-overhead
>code paths, so this overhead is down in the noise.
>
>Until further notice, anyway.
>
>So simplicity is much more important than performance in this code.
>So just adding the check for RCU_SCHEDULER_RUNNING should fix this,
>unless I am missing something (always possible!).
>
>							Thanx, Paul
>
> ---
>  kernel/rcu/tasks.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 4a991311be9b..08e72c6462d8 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct =
*work)
>  {
>  }
> =20
> +static DEFINE_PER_CPU(struct work_struct, rude_work);
> +
>  // Wait for one rude RCU-tasks grace period.
>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>  {
> +	int cpu;
> +	struct work_struct *work;
> +
> +	cpus_read_lock();
>  	if (num_online_cpus() <=3D 1)
> -		return;	// Fastpath for only one CPU.
> +		goto end;// Fastpath for only one CPU.
> =20
>  	rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
> -	schedule_on_each_cpu(rcu_tasks_be_rude);
> +	for_each_online_cpu(cpu) {
> +		work =3D per_cpu_ptr(&rude_work, cpu);
> +		INIT_WORK(work, rcu_tasks_be_rude);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_online_cpu(cpu)
> +		flush_work(per_cpu_ptr(&rude_work, cpu));
> +
> +end:
> +	cpus_read_unlock();
>  }
> =20
>  void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
> --=20
> 2.25.1
>=20
