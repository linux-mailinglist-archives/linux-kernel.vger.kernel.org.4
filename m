Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C765A6C3F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCVBQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCVBPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:15:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F1352936;
        Tue, 21 Mar 2023 18:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679447730; x=1710983730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/PmvodLe9VQ8ABFMYAq3yY3ScP2gfqbF6V0Gz5v7PGU=;
  b=U8zUTJoIwnMu7skGz0ysiZnVy4qxKU92WEknMvVarwuXghr++ESUiSHt
   8Olh5Y55MPiMDryVCxjCsRt81kiodj3OaU83CeamsBceWq11Mz7zmNwG6
   c5oG/9KnAaFw5BDpSelGyNJN2xBUvWHLRizZZgCkqgPSSuBTXMkeWT61u
   5gd9jjPTyIWG89yI5kuXJn+MwnXXrETIi0K9b74JIBx8xT8G3QkSLR+Zo
   IYKMWSfxmo72cgEjQ7O6OBGM+jX8953HuxLgu0d35tDrxYxUfRXO3x3m8
   XZDRjgkaXF/zPEgAByTYTDfWbQahxeEeaROtW2xIDx58LcclrvdfH9bpv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="341454065"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="341454065"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 18:15:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="927650083"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="927650083"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 21 Mar 2023 18:15:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 18:15:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Mar 2023 18:15:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 21 Mar 2023 18:15:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4k945Qj7AM28G97DJ7JcsWVXTAtwxM6091pMtjjh7gNxi1zzCHI7motEUWAJwKjeJOa/dJ7AqjIS+dmDKEPP9VGsuU30wAgVUAWumVv1c4y1HnOJ1Y/bqopeqnlUYe8aKAbwON6DicLzqKzke6c9Nop5F0w3mlq0sNptlPfLJ1EKFhkZGLbBIuRoDzTGa5bkvx/qW92HDzbxPc4dRsHYdhDyhr6NY0Ts96Wz6bXZUyMOCqcYRjPjhBgwis25z3l5UoOnxoy5I3Gv9xdNBvn1VfG4Jkr6pg8rOpAnA5TdVSFL20cAcZ1sIhqI03lX52s0D3iPtLMC0U4WROHkP8ijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gWL0KmfNUGgK1vFKNPGpyFjarEOdxFLJTp9bzGRMHc=;
 b=WwfnVzBrMffeNz2vboPiLNDwqZhrQX3YBrtdjxqagaR69VpXfygZA8XgLE6Lahnw/HKZaxjOCnX5qnbg1hlyC3aYHNC3XCToZ7i6dyzaBxsa4HV+lmMZUtFBbdoXCIWMVtQnVj3UhyAKylJfsxZkV5MS4vbP/0vHYGQCQydJtjMRwqXmrLC9N0PNvbUj4HdalfE2WN0LQ4fg76toXijupPf8kMAoczDAbYjvKjgk+atIS2/rnPaa4E8tmaNvkz9gfNW+JxU8QmM4ycuRk+UBh21vlFlB1+mc098SydmvZxnhiUWVQS3w+BXIrYXhpIWf01Bm8NyBJwuWM7r9IhyyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 01:15:02 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 01:15:02 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] srcu: Fix flush sup work warning in cleanup_srcu_struct()
Thread-Topic: [PATCH] srcu: Fix flush sup work warning in
 cleanup_srcu_struct()
Thread-Index: AQHZW8x3wcHPlwuNM0Wizzk5AGbgwq8FVToAgAClkaA=
Date:   Wed, 22 Mar 2023 01:15:02 +0000
Message-ID: <PH0PR11MB588087645FE02C9F2C113CC8DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230321081346.192000-1-qiang1.zhang@intel.com>
 <e7951c31-4a24-4493-be4b-603fec0730ff@paulmck-laptop>
In-Reply-To: <e7951c31-4a24-4493-be4b-603fec0730ff@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SJ0PR11MB4783:EE_
x-ms-office365-filtering-correlation-id: 4efdc9c2-4fb3-4215-a9ae-08db2a72dcda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6YwxT6a7eXV2YpTZSGJK5Qs0aJDzJ+KjWGYKle0gNTfSYFe4JXnQO5R5w9OxyIekbkor/C2ugUD10TjN8buTJoYO0etnHP70LUSMcbiWwo5sCWP1PpuWmFOqlgFKqhxKSmeEMMCxY32zCYN5PafZvI+XwBi4PzLXmNLEMd3QaIBW/aLOJ6SnEV1HmD/p5HWkOH2BzhJHARKXrOfac59n/rI2vh1p2pE/xuRSEPNavo1wqFWmcuX2nbSEt30vRfaqmc+AAeuakWiW7W+R8Ge05LxMbnazzkn/2wC/JyvLExSfIcK7Ps9EnRMPh7XihJNFKF+vQ6LiNOMNuyKS1M5Goza8JZkGk5pwtziiuy9GYXGu+nw3R7FVBgUQNKSIUvhahQfUhcc0k0WMXKjyY87LR0ZTWqscimZxAdKOwmaqc7Qa6q3biwxHbtK5ZltNSvLrues8RE+IVjCblLLR10wsmcaEtvalZwLHsJiJeKbOfP/UQhJHtNp5WuYmBil8LrIE86q37fc6ol6f3NjknGTTLYGcDueIXOiBsZaivmqoqDtGTW/YOsaKoHv4EUUo9l6U7zssu5oB4/zJtB5DremD/TjYctKZoDbpmyJ8RjQYI3grcB2a1yba5QxnY1yXQ/YUZwSO5MubvWVtNVk7ou+jTJAxKRTw3gJSuCPBp05RVtszNMKS9mCCQxwHDlEFQ9Bnt64ihS/BAMX24F/RdSh4og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199018)(9686003)(82960400001)(38070700005)(6506007)(186003)(71200400001)(55016003)(7696005)(38100700002)(83380400001)(52536014)(478600001)(2906002)(45080400002)(86362001)(122000001)(33656002)(316002)(54906003)(8676002)(66476007)(66946007)(64756008)(4326008)(8936002)(6916009)(41300700001)(66446008)(5660300002)(76116006)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gJwvaQA6H3S4DeBOUk6ht4oCLRIsUoP4cHeRpg/BigRJeB+XBzlLMvawgCUE?=
 =?us-ascii?Q?kOTgsylOIGrfIstCJqHdZN3lgxOBQK/TJAjemyAZsvuxuJw/6NhJNxkmxjqg?=
 =?us-ascii?Q?7F1vPpPMvYQys8aKD3Z2w61iZosbu/zFvhTRzPRxHYYlXT24II6sC08dZhBi?=
 =?us-ascii?Q?KmsrhlUoO9nXP60HE61NssohHQ1yB0HtrNSpMstK3Ye4lwQ2RuEEMU1aJ7v9?=
 =?us-ascii?Q?HYbynzBGCwOl4og6oIpvW4ev73GAamsKOzgQj+ru/vcKNjL5Oo5LbKKYS/lW?=
 =?us-ascii?Q?Gq/Tr+L+avd+yWphZ2O2E0XQurscrqvF2NjUEklF8/4EEbBMSe7rAe4nG0O5?=
 =?us-ascii?Q?ZQpKiGysL0GgPKNujxhx+1wDsNp+b2WT6zKKNmryzHdOghcNB29W+4Db/i2y?=
 =?us-ascii?Q?NGqAGg2q3qzUu+SzroNrlgWGGDZThfoloU6WWw+y41LfQ1Bqa4+NefGyCh60?=
 =?us-ascii?Q?pM0Y3tT0M5wGLzAyAQGp5CceHzZ81YgYFp/JV/8cR8+FCicp3B9/P8y7kD46?=
 =?us-ascii?Q?4fWJQ/U3u6ecJdaLtKmdL7l7DIDIsWBB5/U9oaEhA0LjrSlGJ9l4OYFr0US8?=
 =?us-ascii?Q?FV+4BEJeLlMNibzUjaCfpncnSDMaWlsV+icrmOuqvqzKgoOqAh0eZT5EgmFL?=
 =?us-ascii?Q?iT5FgChu6zp0a3Ljt76r+fODLAzNcreM0BstK7CaSgouTKceEePHm/mE3Zj/?=
 =?us-ascii?Q?aVPXZvfuDP4pTE1a8vrp9lIPYo6vkP9XuIXVWUXPeTjc20ZpHitBbuJyIrhK?=
 =?us-ascii?Q?Yze/5e+4m1Gu1QGoEaiIeyzPkQ5lbL52W0Z5pTcEBFUY2c3sWnaPPJdNt0LT?=
 =?us-ascii?Q?lWPpDBnrKHoVbO2ev3BE572NOLlbL/nQWpXLjiEfcOdR9WkRR5WNEKaUuHB/?=
 =?us-ascii?Q?GTuHMzteLaFa8b1JLLXl5hEtuS753jBQOt3OkeSlcFHPkU08DgV+N6oHKu4h?=
 =?us-ascii?Q?21hbeA/Ljwlra7RZBsErHOH48w0dVuzw2wI8bXAHSz+tep3EFn6uThqHtcSz?=
 =?us-ascii?Q?cHI4j0FJQc5Et5ycS3xcSCTeC7xgK492N8rNs6WGojKmbjWplhHm9TZm6lTb?=
 =?us-ascii?Q?Pq6FEOKzhVyrIbnlBGWMRLCPL0NlA7E96eoXTvq7sLie9CdB8N6v47HegIRK?=
 =?us-ascii?Q?V6zILqMgsd+ZybBgOyb81iFOsf4rmcfX1o9lsq/Um+A1+sOODSNBwm/2yuoY?=
 =?us-ascii?Q?938gohdY93hacHxfgWHhTgYJbwDLLuS6c6RTVbsu4apTwcQxDW2uv8jv+ePY?=
 =?us-ascii?Q?1Jwf8a8TWZCfV5Myeh91VWz3Ua+HkgGkcMznklzbNXuHdn7gQa2vzxYajoEp?=
 =?us-ascii?Q?9xkpXPUiACAIFk31pxcmq2/KOMHMn8KAEgZknrp/HhU+/T1R/2b7d+jEpTFQ?=
 =?us-ascii?Q?/cSGBskLqlQGkLIWfXDHOe7/uG1uFbS1ZE2qfLnFuWBBX4i25vsM1tvY3ERB?=
 =?us-ascii?Q?5kIuMISKs5b9D3m44DPbzAjrqTxIEMnavptYMRtUbZlIg5EgxXTZxTDlKpnq?=
 =?us-ascii?Q?ATFhQeZWTgpqoVzfVOptpSmsAnbSTk2zv0k5EDjDDz3xp3Xo5cJCm3xVmBQF?=
 =?us-ascii?Q?h3x6xrTAjumMeGCTmJeXeZhtMvFqUG6QIkoK+nLXsyogt7HaX98WTf7pZ/+n?=
 =?us-ascii?Q?NttFn8tLP9cjlnF7oxlyqPjisg96JXDj5J5pdQSL8FGH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efdc9c2-4fb3-4215-a9ae-08db2a72dcda
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 01:15:02.2544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jc/dZHkcRH+uX7uSi/fqqTKU2b+T3F8MXGLJ30lhUpMnocaY5Crr5kdx8MM3p8cX/KeioicrqwnVULHU+Z7GHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> insmod rcutorture.ko
> rmmod rcutorture.ko
>=20
> [  209.437327] WARNING: CPU: 0 PID: 508 at kernel/workqueue.c:3167 __flus=
h_work+0x50a/0x540
> [  209.437346] Modules linked in: rcutorture(-) torture [last unloaded: r=
cutorture]
> [  209.437382] CPU: 0 PID: 508 Comm: rmmod Tainted: G  W  6.3.0-rc1-yocto=
-standard+
> [  209.437406] RIP: 0010:__flush_work+0x50a/0x540
> .....
> [  209.437758]  flush_delayed_work+0x36/0x90
> [  209.437776]  cleanup_srcu_struct+0x68/0x2e0
> [  209.437817]  srcu_module_notify+0x71/0x140
> [  209.437854]  blocking_notifier_call_chain+0x9d/0xd0
> [  209.437880]  __x64_sys_delete_module+0x223/0x2e0
> [  209.438046]  do_syscall_64+0x43/0x90
> [  209.438062]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>=20
> For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU(),
> when compiling and loading as modules, the srcu_module_coming() is invoke=
d,
> allocate memory for srcu structure's->sda and initialize sda structure,
> due to not fully initialize srcu structure's->sup, so at this time the
> sup structure's->delaywork.func is null, if not invoke init_srcu_struct_f=
ields()
> before unloading modules, in srcu_module_going() the __flush_work() find
> work->func is empty, will raise the warning above.
>=20
> This commit add init_srcu_struct_fields() to initialize srcu structure's-=
>sup,
> in srcu_module_coming().
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>Good catch, and thank you for testing the in-module case!
>
>One question below...
>
>							Thanx, Paul
>
> ---
>  kernel/rcu/srcutree.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 1fb078abbdc9..42d8720e016c 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1921,7 +1921,8 @@ static int srcu_module_coming(struct module *mod)
>  		ssp->sda =3D alloc_percpu(struct srcu_data);
>  		if (WARN_ON_ONCE(!ssp->sda))
>  			return -ENOMEM;
> -		init_srcu_struct_data(ssp);
> +		if (WARN_ON_ONCE(init_srcu_struct_fields(ssp, true)))
> +			return -ENOMEM;
>
>Wouldn't it be better to simply delete the init_srcu_struct_data()?
>
>Then the first call to check_init_srcu_struct() would take care of
>the initialization, just as for the non-module case.  Or am I missing
>something subtle?

Hi Paul

Maybe the check_init_srcu_struct() is always not invoked, for example,
In rcutorture.c,   here is such a definition DEFINE_STATIC_SRCU(srcu_ctl),
but we use torture_type=3Drcu to test,  there will not be any interface cal=
ling
check_init_srcu_struct() to initialize srcu_ctl and set  structure's->delay=
work.func=20
is process_srcu().
when we unload the rcutorture module, invoke cleanup_srcu_struct()
to flush sup structure's->delaywork.func, due to the func pointer is not in=
itialize,
it's null, will trigger warning.

About kernel/workqueue.c:3167

__flush_work
     if (WARN_ON(!work->func))   <---------trigger waning
	return false;


and  in  init_srcu_struct_fields(ssp, true), wil set srcu_sup->sda_is_stati=
c is true
and set srcu_sup-> srcu_gp_seq_needed is zero,  after that when we call
 check_init_srcu_struct() again, it not be initialized again.

Thanks
Zqiang

>
>It should also be possible to eliminate duplicate code between the
>in-module and non-module statically allocated initialization cases,
>come to think of it.
>
>  	}
>  	return 0;
>  }
> @@ -1931,9 +1932,13 @@ static void srcu_module_going(struct module *mod)
>  {
>  	int i;
>  	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
> +	struct srcu_struct *ssp;
> =20
> -	for (i =3D 0; i < mod->num_srcu_structs; i++)
> -		cleanup_srcu_struct(*(sspp++));
> +	for (i =3D 0; i < mod->num_srcu_structs; i++) {
> +		ssp =3D *(sspp++);
> +		cleanup_srcu_struct(ssp);
> +		free_percpu(ssp->sda);
> +	}
>
>And good catch on another memory leak with this one, looks proper
>to me.
>
>  }
> =20
>  /* Handle one module, either coming or going. */
> --=20
> 2.25.1
>=20
