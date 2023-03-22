Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0AA6C419C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCVEip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCVEin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:38:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2923B770;
        Tue, 21 Mar 2023 21:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679459920; x=1710995920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0A9OxTg3CkgH+YEwTtIsNCJqvOL7TIcPKWVpZRGE1wM=;
  b=GrB6akHrdq9+b2iYYVVxlfrdKpzpNMTLXs+Jt19LZZKiDqWgEyTq4yRh
   pnmiw5B2gFoYYcWfQImAo20Qsn6nSHqQdpkJwt11a5AM5PvMjNMknrevR
   JiC2S9OvV4BbtVk0r5obl+NOBROU3Do5Cr1lNESA3h9iqj+ngGILeLKFI
   Ou3/EJiYUa2DV2/6VIcgPHsiAq2ppL6oCq05F8uwKOpcFaiVIK7eO7BIn
   qiOo+vdm6HstBzMC8tJIh6IIyXCuI5bQVmPzmCWIsQF87hx2B63M4yo+2
   xFxXW4q2s3freMoSuIbjG7/+FY4KBYP++vFUQMJ2gf6Q0mlbex9IbGPaD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322967614"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="322967614"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 21:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="792390051"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="792390051"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2023 21:38:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 21:38:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Mar 2023 21:38:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 21 Mar 2023 21:38:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFahd7LxGMuXYQrQPrmpjv1edqBckwxugEH1KEH360awaCmX/SEe4XKpjflEDi9NXw5CNUKL+EqMitps+fy5kkZ0twsx1RAp1oVB89Qg7v3RSLhdWS+18pN7nY+uF/hzi5glunlLmjgB5+3Z4OXIlYBrBDZr8Z0YqulGyOkwE2ySvA1kg9f0y7vZ5KG6r+/uzpxKPveXGbsPyiTHO2OW2r9LDMAPVZmEuofChsY2q/TmPBr42nKpryrDtqusNrbDqdMmtw9nuC9fCJOZ2U21iK53XHLZ2q7ukj297mTulNwPxQ0uvvgXGtGTgkBKH67kzH1ivW4Y35TTciNRSmyASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7t6QBX61vg9RneK6NJtNTz9B0yqqe+bzHA3p369B96g=;
 b=kkcP0I/phDlTUe1CtqIITIOoRaVp0ulP1Lct3xYU+TD9HGUk5WznjqBDmU1BNcq+crCWurtxY1jpj+oLc2/N710XzjnYyk5AhIH/whlORFdWn+D721CdyA+O14/2K5IKloKTxzzn13+puVbmobGf6k5l79EV9yOfcqVXslMDipjpyRR0i3AiAhGp1pcghmciFQor1duENrMQeAg9aG3MdM+mVQplkyyDfqXW/KDd7T7RkpHuOyOh2LYzW7MmZAUMViKihi2JOCaDXYSfA+zED1XDcJsjFnipIh7CnKC7xkoREq4Q/2DUJKZNLuhel4V2CZOxDAckceU54TyToqzC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CH0PR11MB5233.namprd11.prod.outlook.com (2603:10b6:610:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 04:38:31 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 04:38:30 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] srcu: Fix flush sup work warning in cleanup_srcu_struct()
Thread-Topic: [PATCH] srcu: Fix flush sup work warning in
 cleanup_srcu_struct()
Thread-Index: AQHZW8x3wcHPlwuNM0Wizzk5AGbgwq8FVToAgAClkaCAADGigIAACIWA
Date:   Wed, 22 Mar 2023 04:38:29 +0000
Message-ID: <PH0PR11MB5880CAE4D4A58BD71AE984CFDA869@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230321081346.192000-1-qiang1.zhang@intel.com>
 <e7951c31-4a24-4493-be4b-603fec0730ff@paulmck-laptop>
 <PH0PR11MB588087645FE02C9F2C113CC8DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <f13e878f-65c3-40cb-aa3f-eb87ae6c9d6b@paulmck-laptop>
In-Reply-To: <f13e878f-65c3-40cb-aa3f-eb87ae6c9d6b@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CH0PR11MB5233:EE_
x-ms-office365-filtering-correlation-id: 91a780c8-5508-490c-18b8-08db2a8f4921
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HXyANTJAsyCvPQVzWNGKRM81ZKiCUysLotBpzI2Roo+x8CaIQ6KIn2cZBuP01M01AJpkQOhiIV/vxExGYjM7byvnlyOrbocYUtcF64t5XPPv+UJO0nMaM/g6eqwR0v95gmS6rjr5zx+ZrDhmG4dlN/MpFEtB8xEj0NhfUsYW24b4MhniaCU2ILIg3kcZjK/IdVU31F2lIxJdLsbkrBRF7QCN4emf9ZoKy8Cx8WTXBH4JTl9x5oFyIAYte0DtgTWYTBKA2OoTJ66wtQ+77l/TSMXAE9aAtK4/CIsoRGTrI96WrEwG7KC27SmUCnQFHcug6y577p9fotQwin8bIBBmxhkuLd1gDcuq61spGIKuSbd9E4WD0OHhJQCtCQsqQwsHIC04h23WrfqwXHLZIkHxGy3uIxHbrNnM/qxmf+6wMK5+ULk/+UDtiqCqhuRMYFTW1brq6vAovlfZgGTWrfWtPdSjbFqUsPX4Tj0eoYHJSCx+Shoj94Yh3XTVBRXZlXrFl/YaqwSGjdldvG4m5pUONiPifQuDa3Sf6lMn7xblTIQab5h52DDZJ1ZRyqXmcaHELib00fcQXefe28mhjdILj666iZ34iBGlXWhRD5YF/cfXK4WQx95Ec01w5SRUZl6O+U1BZOsurXwe7Qq8MM2YG5fmYSyU+yHa0fC3HvbWGx3LvOL2Yx31GFfxpB3KH3+ug6Bc2rsswBcJZsp/JcRJuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199018)(186003)(7696005)(71200400001)(4326008)(478600001)(45080400002)(83380400001)(64756008)(316002)(66556008)(76116006)(66476007)(6916009)(66446008)(66946007)(54906003)(6506007)(9686003)(8676002)(41300700001)(52536014)(5660300002)(82960400001)(122000001)(2906002)(55016003)(38100700002)(86362001)(38070700005)(33656002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dDac/1ymLYuyGvZwR4q7EJM1CwxKpygHJkO5NMMyC0zUWSRXA7l4Se79+mrI?=
 =?us-ascii?Q?l13HDUoEeWobfAMkcJTW8iBP8V4/GxK64eAC9sYl+J0kRuuOJlSM1o+WfHrU?=
 =?us-ascii?Q?sR+RhjizA8HRGMUd+iUXJfZUaeEDNH032Wt+ks/2u2jZqYWre3kzMCR1OQlj?=
 =?us-ascii?Q?BRV4+h5pVMPFHM850a8LumoGe1ttWGmAWOfzbNXomMAbN/I+PU3Pv1JJL65F?=
 =?us-ascii?Q?xjgyxn0f5G8iBo91cwQHYwK5drf+de9QDh7mXxD5F/YEh4AzpDKrw2SqdyZw?=
 =?us-ascii?Q?cJynLskgmYcSwRi63Twjs+IyRUOZXeChNRSAdbvu3x3ngHSJmF7eyvxkc/3S?=
 =?us-ascii?Q?+4aVa9yqQcrr7WZqGkMvE5Lu1DarrjJ9b2z2J72Ata3sHtPab5+LmsO2OmeJ?=
 =?us-ascii?Q?H+9oG9x4oKju113k6V40twtOt5X7ysy2OR8pB0a5DMTmv1lv9lkwd3SJVJ/x?=
 =?us-ascii?Q?QfWHW2W3C+fKRuBYiPpdEApvFWev+GX7awox+2u/fr2CQYel1PvwnZORT2Ni?=
 =?us-ascii?Q?RpMo3mdZrZaXrQ4XNBoyKRIs+UwreRrVgijugiYOVOVHZqGSHUmAAeyaKmFH?=
 =?us-ascii?Q?F7HE/BxMGf6X4zB2hn/IIlfg7HuRgfYTVC24e4qgrLISGw8L1kwxqX0MVO3Y?=
 =?us-ascii?Q?iSugH3dmfmaourDyvM0blMWsNPkurt0cUHwMlcAIXIKfJQFqWcNL9Cqy0iwU?=
 =?us-ascii?Q?V6zYsttgiRgEutqBve7NPCKu1HBIcbNw0HWCdJgvsgFeMs8+jXJv/VGPvQKV?=
 =?us-ascii?Q?NEzMSZu8FML3ZyzdFWcgcJeoc5dQwHsiRGvXRn2umTMyTPPKH3j+WIc2xRSJ?=
 =?us-ascii?Q?cLOqfdfgsb59+h5hnktKTEiWLie4+LnNzI2UF3p8tiNEE/756oZ549Txu9qd?=
 =?us-ascii?Q?K7Jm2pvDcSpCMol14UWcCNJ1fZbhxRabd2RWOcVNS67787dphbhBmzpwhloF?=
 =?us-ascii?Q?nFkTqS73nsl4k3Juys4v1HrRGy3Q1vLcVefPTo9Zrdvg2c7ZB/7SD8UHOc0f?=
 =?us-ascii?Q?P+jnmcDbL7lrkHiT7Rh4fyATUH8gpgmh4HsWBBo3x0D6d3mAWPDpZpm/i4np?=
 =?us-ascii?Q?zHw3U5VeRE1F2Absc6UtGjUVv1ouF+qAcWqMes9lhsPor4splA2xxpqHpw1a?=
 =?us-ascii?Q?AQapq9KYffBNGV4tfi6PEkknyb+q8PtMQednjBlhjqFo53p91LZpVv9KGsMi?=
 =?us-ascii?Q?HYKvoFDE1ynna5uqS7hYTcU5iyB+X4axK5ARDx4Up9gfTFef5oaD9iOHBM8y?=
 =?us-ascii?Q?9dIAF93rHI8jRbFvFJkTCi0dld3apE/eoFT+DO4fHmzfe3o2oeVGvq7wgyxE?=
 =?us-ascii?Q?kPEX0agPC3tQAJ3bf5UQQ1PZy+73ttqwlhSaeHUoQdTexkr9y4PpAZL9HlKH?=
 =?us-ascii?Q?nB/M+UXauxrXYYC8uJ5jXd/MrIg2PIa/O1WnJoBwtUcLDvpXdDaX61wKxqwN?=
 =?us-ascii?Q?Ch/x+UFun/GtXQLJQvpGo55ziYntrzk1caHCfnhRRQUM/OSDmElKE/7/nsMQ?=
 =?us-ascii?Q?L4Wlywl4KcuoTvMqlGUkmt8L7TpTmeEJv9/4LK6lnWgSEQxSe9xTGeSfSz1k?=
 =?us-ascii?Q?6l1pkE0K9avxBLTgYlB/UmNV37kPMfA6BMNspKb4XPgLli0oqgfm0EoNIE4q?=
 =?us-ascii?Q?qT8k73biudYxES+ziydilB5YNmlcPed4Y5eL4b0UcuId?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a780c8-5508-490c-18b8-08db2a8f4921
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 04:38:29.8496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8GYocGwH9lUU/dnwsaoRokQZbdosIWIZcmzI2rgwa++eBZDnOnt7GL8L8v/vwxj1kEOJPkG1yApJwMTgv1yyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5233
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > insmod rcutorture.ko
> > rmmod rcutorture.ko
> >=20
> > [  209.437327] WARNING: CPU: 0 PID: 508 at kernel/workqueue.c:3167=20
> > __flush_work+0x50a/0x540 [  209.437346] Modules linked in:=20
> > rcutorture(-) torture [last unloaded: rcutorture] [  209.437382]=20
> > CPU: 0 PID: 508 Comm: rmmod Tainted: G  W  6.3.0-rc1-yocto-standard+=20
> > [  209.437406] RIP: 0010:__flush_work+0x50a/0x540 .....
> > [  209.437758]  flush_delayed_work+0x36/0x90 [  209.437776] =20
> > cleanup_srcu_struct+0x68/0x2e0 [  209.437817] =20
> > srcu_module_notify+0x71/0x140 [  209.437854] =20
> > blocking_notifier_call_chain+0x9d/0xd0
> > [  209.437880]  __x64_sys_delete_module+0x223/0x2e0
> > [  209.438046]  do_syscall_64+0x43/0x90 [  209.438062] =20
> > entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >=20
> > For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU(),=20
> > when compiling and loading as modules, the srcu_module_coming() is=20
> > invoked, allocate memory for srcu structure's->sda and initialize=20
> > sda structure, due to not fully initialize srcu structure's->sup, so=20
> > at this time the sup structure's->delaywork.func is null, if not=20
> > invoke init_srcu_struct_fields() before unloading modules, in=20
> > srcu_module_going() the __flush_work() find
> > work->func is empty, will raise the warning above.
> >=20
> > This commit add init_srcu_struct_fields() to initialize srcu=20
> > structure's->sup, in srcu_module_coming().
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >Good catch, and thank you for testing the in-module case!
> >
> >One question below...
> >
> >							Thanx, Paul
> >
> > ---
> >  kernel/rcu/srcutree.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c index=20
> > 1fb078abbdc9..42d8720e016c 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1921,7 +1921,8 @@ static int srcu_module_coming(struct module *mod)
> >  		ssp->sda =3D alloc_percpu(struct srcu_data);
> >  		if (WARN_ON_ONCE(!ssp->sda))
> >  			return -ENOMEM;
> > -		init_srcu_struct_data(ssp);
> > +		if (WARN_ON_ONCE(init_srcu_struct_fields(ssp, true)))
> > +			return -ENOMEM;
> >
> >Wouldn't it be better to simply delete the init_srcu_struct_data()?
> >
> >Then the first call to check_init_srcu_struct() would take care of=20
> >the initialization, just as for the non-module case.  Or am I missing=20
> >something subtle?
>=20
> Hi Paul
>=20
> Maybe the check_init_srcu_struct() is always not invoked, for example,
> In rcutorture.c,   here is such a definition DEFINE_STATIC_SRCU(srcu_ctl)=
,
> but we use torture_type=3Drcu to test,  there will not be any interface=20
> calling
> check_init_srcu_struct() to initialize srcu_ctl and set =20
> structure's->delaywork.func is process_srcu().
> when we unload the rcutorture module, invoke cleanup_srcu_struct() to=20
> flush sup structure's->delaywork.func, due to the func pointer is not=20
> initialize, it's null, will trigger warning.
>=20
> About kernel/workqueue.c:3167
>=20
> __flush_work
>      if (WARN_ON(!work->func))   <---------trigger waning
> 	return false;
>=20
>=20
> and  in  init_srcu_struct_fields(ssp, true), wil set=20
> srcu_sup->sda_is_static is true and set srcu_sup-> srcu_gp_seq_needed=20
> is zero,  after that when we call
>  check_init_srcu_struct() again, it not be initialized again.
>
>
>Good point!  In the non-module statically allocated case there is never a =
call to cleanup_srcu_struct().
>
>So suppose the code in srcu_module_coming() only did the alloc_percpu(), a=
nd then the
>code in srcu_module_going() only did the the matching
>free_percpu() instead of the current cleanup_srcu_struct()?

But in modules, for srcu objects defined with DEFINE_SRCU() or DEFINE_STATI=
C_SRCU(),
when a module is unloaded, we usually don't call cleanup_srcu_struct() in t=
he module
unload function.
If in srcu_module_going() only do free_percpu(), the srcu_sup->node memory =
maybe
can not free and also lost the opportunity to refresh the running work.

Thanks
Zqiang


>
>							Thanx, Paul
>
> Thanks
> Zqiang
>=20
> >
> >It should also be possible to eliminate duplicate code between the=20
> >in-module and non-module statically allocated initialization cases,=20
> >come to think of it.
> >
> >  	}
> >  	return 0;
> >  }
> > @@ -1931,9 +1932,13 @@ static void srcu_module_going(struct module=20
> > *mod)  {
> >  	int i;
> >  	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
> > +	struct srcu_struct *ssp;
> > =20
> > -	for (i =3D 0; i < mod->num_srcu_structs; i++)
> > -		cleanup_srcu_struct(*(sspp++));
> > +	for (i =3D 0; i < mod->num_srcu_structs; i++) {
> > +		ssp =3D *(sspp++);
> > +		cleanup_srcu_struct(ssp);
> > +		free_percpu(ssp->sda);
> > +	}
> >
> >And good catch on another memory leak with this one, looks proper to=20
> >me.
> >
> >  }
> > =20
> >  /* Handle one module, either coming or going. */
> > --
> > 2.25.1
> >=20
