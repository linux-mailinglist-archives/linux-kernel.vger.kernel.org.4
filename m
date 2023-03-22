Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F776C5ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCVXqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjCVXpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:45:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB932305DE;
        Wed, 22 Mar 2023 16:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679528739; x=1711064739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+RQ4fclu0URoRGIsRKlJcDuIeO93C+5Pn4Xy0+JXZ4w=;
  b=Dakc2zpB85bpLhuSjDjnO422gpKEyPjWT00p+h4t947gTMeEy2ItdwKg
   itVLwyDwMjBg8BUN8QgHF/6XY8xI2vCrLSPdC5p6RpDJAV2UwzrXCL8e5
   pDQEswmuFroX+WMQR+zyN+HOdC/do9HjbzyTzXRmhH2bR4O1o3ROArGRV
   Ed4fEezL7OvSLznRsZ5wZ8jKKP5nf/c7vOLifh2jjE/Ld1lRX7M9FFeb8
   qMdMbukRY9LuuU5wIqj0CZ74ydK2WhKuI6CPCQEwkp4tMiHoqdKfsAlrV
   6I/u0Z5d8yAcpFm9UrndukwcyK3SWRKYaZGvfj8NasomBYlhXyeJoUTE1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="367095168"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="367095168"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 16:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="825606387"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="825606387"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2023 16:45:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 16:45:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 16:45:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 16:45:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ1IqtkrDW/SFLA9stE5P+3B1gUCPmCauitXkSajQF08BPFAsvA475Qxw+LzCepfSX4swc/QIn9O+Syuzytfg9JBrI2USbvPmwyjKBzauxw7rAPAv5V7eZ9X/ShIT6W22yMuRAJjev6QYzxpEUvc7ps9uJqd437UjAo+AlT0MYEP+2d4fozgSv3PDlNgLyZ/eiWj8lN9yP6dyqyrb03rm8MnwHMzBZIxSL/B/j9Xv3ARDxSMJ004t6bIws0uKIjh9RZebVvSltFcmT9mPIC1AI7K9cCYGLDdzrMBseIp1bAhqycj4wC2Ho7LZQ2JjYa1KC9vW8LRclFwmjd/A+NrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow9HXxNanLSYEOQnc/spLL+ClZOpLs28g8mb/G9iMxk=;
 b=OvVrqnDWO+30Vc6GTYyG0jcx2FLx94IMxjJPlBIlWlZu+VhS1EkpmyPTh7F1ACgZhubL7lVrzHpy2Mf6wfmBrOrJfsSDOsbN+5Psd6sNGJ6KuzhLFmb+o52uI72qkVc3ibq3LjRwWHQzPDfpHgiyB6YX1skKkgv2+ByKiOb/VDn9ZRVk56vjTIi4jpUFwVdlFMsBy+8E8UKiLHuwqTDf2uxha0+l+yIzzdaUQrodOLzHzwlEhdtKXJ+Bfpo00U5NSusw7W2Lpx8a8SFpi26PHBUGn3wxHiXy+cIXFJcPNvNRTKNWkWsV7Rn6QWvL6O17PTA1CRAalBrgcUU+TirjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SN7PR11MB7439.namprd11.prod.outlook.com (2603:10b6:806:343::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 23:45:35 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 23:45:35 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>
Subject: RE: [PATCH] srcu: Fix flush sup work warning in cleanup_srcu_struct()
Thread-Topic: [PATCH] srcu: Fix flush sup work warning in
 cleanup_srcu_struct()
Thread-Index: AQHZW8x3wcHPlwuNM0Wizzk5AGbgwq8FVToAgAClkaCAADGigIAACIWAgACwsYCAAHV/oIAAFDsAgAAGXDA=
Date:   Wed, 22 Mar 2023 23:45:35 +0000
Message-ID: <PH0PR11MB588085478B4E13DD48C4B7C1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230321081346.192000-1-qiang1.zhang@intel.com>
 <e7951c31-4a24-4493-be4b-603fec0730ff@paulmck-laptop>
 <PH0PR11MB588087645FE02C9F2C113CC8DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <f13e878f-65c3-40cb-aa3f-eb87ae6c9d6b@paulmck-laptop>
 <PH0PR11MB5880CAE4D4A58BD71AE984CFDA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <dc8b5a44-02ca-4e5a-bd4a-644af3e7c11e@paulmck-laptop>
 <PH0PR11MB58804435C08AEADF23B095D1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <4a9525f8-30a3-4ca9-87ec-355cde7f6ed6@paulmck-laptop>
In-Reply-To: <4a9525f8-30a3-4ca9-87ec-355cde7f6ed6@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SN7PR11MB7439:EE_
x-ms-office365-filtering-correlation-id: 1e06b466-aab9-4a4c-2b77-08db2b2f889e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gU+47CLC3V0ws5ErID9FWdx13WC4j64+m+TRRP5OadUXukv3fUg5v0ADqAN4gdTTcGdZAg1pLIMPRDll8ASddnRi75BhCvmznVNnn5H5vd7uex2LKIKKrGXaD0xTA8tVXZI6dQYRXndzrZevzQiDPTHotmM1IMLSxRQv1puKdKv2NG1hAxTeUVe3pVcRf6rI/9pg00J/owfu+9i5yBgqKtFyMSaMuqPHK8l78Q/GgxPmE1BMN+haIrpJlwihwVXjOQNnmh4qvpm5P8q39UVSN8IEzGIyy8pSm5P/OKdFPKzHI71XHQgI80GlLjAykcizsXoAVi6VgYQnwbed6h1RegMaolN7pbNrI7vERqolwXQDm0rdSFi4Yvsgd9WBOt8LM/oAS/W5X7JyJN0Y6V0UrL+OB9qcINpajqUUz84Q6rpdXDufcq5H+49HlZcohPZ5YnBBrheutFNRQ1hhowffr36WQQJnxUxeIcE88YiDGVq1sAq88sJ93a9lTT5VoDJWXlR8ygsUHP+DffFyxdNkjXGJ+Hzxf5k3d8x3QKc5cIEVq5j9wt29VkeXEXSY5TBd+AAdC2VEYTytY1TWrQbcMbvqqWPCVJmuu1NX+a9fXSjerS9MT7wFxuD7qrWABSTlOkC4izqb4mkX6YH9UiElhA+MxQqwjbS8X7EDdZfScSodx7EXk0BtGOWeYKYmMqGAtznqtIZRSYwnXDuOpVqZwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(38100700002)(316002)(478600001)(186003)(33656002)(66476007)(82960400001)(122000001)(2906002)(66946007)(66446008)(66556008)(8676002)(76116006)(45080400002)(6916009)(54906003)(6506007)(83380400001)(9686003)(86362001)(4326008)(26005)(41300700001)(38070700005)(71200400001)(7696005)(5660300002)(64756008)(55016003)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RPPL4lfwxfqON1HKp5+SCBXczu4/r70Y65BrIwSAa8h1HjSHd96T6AMjUzh5?=
 =?us-ascii?Q?6DXIEKexrBXnGLw+le3WZFWDlU1LQfz2yJz+3tw8WAPhXj8CGzsTV4Zmsl3Y?=
 =?us-ascii?Q?lhZ4Ts/DyoHKv1ACtBqDrd/R4Qg3RCdkmXX9ajJivlGrfrMnwiyhjprR3scV?=
 =?us-ascii?Q?rmGIYY0oKO22RHmCx/VBp4BFNLKZAJ0z3rGkxeE/3awnEWaw/SaUSuJ0PDJL?=
 =?us-ascii?Q?zp9hBf+60nwxfEf3H+rFfKls4GMOnq1Z8QpLMUnE19tOjwSJazklMkcIvOmc?=
 =?us-ascii?Q?OeKNmQtgmb/KOtF9nXUICisOyf2Ui90MijjFp7YCzgeGLFM+2IaYsmCiw7An?=
 =?us-ascii?Q?Zn5b/Ta2jDgilHcGiJXABFudO0uSXyKjT0Z5yOULCwiqE2uoOvNfMWTpNjsH?=
 =?us-ascii?Q?B84RGPiCnsKBVNoA3LKcGC+qM29dD25fePIDWltzAevjUhP0JKR4hAH2Gxan?=
 =?us-ascii?Q?1uEAr2RYfYd10Ym0ThSjNei3BmiQbQaLDtjRSnq3uMt+uMtg6+8FTpdh4UP2?=
 =?us-ascii?Q?a81D9vl+Qya/B8vbbVFVtMQNipGf5peOz7g/1Urjdj/uja3ijlALAadFV7jO?=
 =?us-ascii?Q?mt8qHnGx01LBzv7cXSI5CkrwwB7w4sMuFDZ/PwMQrRRNbJv8UjiLAIL9POLS?=
 =?us-ascii?Q?h5PMZWtJBKaT2CQoRNIBdJjj6h7vqyHFNXIb/PvYwHXxv9Iyei3wTS0HAxM2?=
 =?us-ascii?Q?yyfQXdKsqsbUAENAvj71jwjsMNwKbNVybWq8AZZnkWuF7dXePwcp3/nwkh9H?=
 =?us-ascii?Q?jaUyf+gXp+GdS+zi7aPyQd2dWWFbRQDKuyNomD2Ma/DPO4/SYBLRUxNlKzOU?=
 =?us-ascii?Q?0a8lWEHe/sh9CVJzwMh5ZptwTT193WOxPKB8AsxBqpSva+2yIs6bcu4LUQd7?=
 =?us-ascii?Q?X7k0qp0FyCVS6wRWCmcCexuQzBcydK2fx6SGe8NlW4bnac8ESdKPtwqOwLZX?=
 =?us-ascii?Q?mvAMmdbHWOBkmYltTK1cZTsiJiYGczMTbgm5WgIkEVojBoTVmF4LRntg4/aa?=
 =?us-ascii?Q?uGTBMrWbjkRfm1GsepriXIrZ/u2ovMPfh5FKzK2JB4iLwR4j44WfrRqXtlEV?=
 =?us-ascii?Q?L+4OPpRH3Pe12cGo2vvFiHfww0B04TPRyN0cyksycql/054rZTyDDmAaUYpl?=
 =?us-ascii?Q?t3YCuBK07ZwPQZ8j+RzxwjLWyJvwdHgAcfJYszKyVcVaOGcTGmmUeNSuhpBn?=
 =?us-ascii?Q?C1QCNq1sfoRp28qfF361KoolPZVT0IkyGqaCXlQ3ZaePVMOA9ZiEcBL7Gbi3?=
 =?us-ascii?Q?Md+tzwG3w2Gogr2I3kZ8KzYEQpBW30h+/KmKfJLETaQuUMpceKdPaqLsMzG/?=
 =?us-ascii?Q?oUC/FqWnrp14abEH9JjdrMWEvLDgl8+RsSBY4W2Ad4pAYxlFTwFS0xhOMVkQ?=
 =?us-ascii?Q?pk7Au9N5ckI6Gd4kDqPNhXgvKyKhOyARjw5VE+GE3Labuyv0sW9euGDyAQTb?=
 =?us-ascii?Q?rLvCwAOLq+D9b2aaooGf+an9WMRnpJUengtIVprRzXr2nfqSrO3p0Y8A5yc6?=
 =?us-ascii?Q?78Y5YXozMtIFG6fofdSl7uz2T6PIL4wbGjjDaHQfMPJYi9Mp5QI+CcFI/KA4?=
 =?us-ascii?Q?ezvSR+FntuLWkBPwuyNj7sJf2P1cwlHlNUebwJuZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e06b466-aab9-4a4c-2b77-08db2b2f889e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 23:45:35.7957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qff6BXHiPAGPAK/651UqU2LqN5R0l2fUseDwOBSdHBaHyZLnayxuKtoMi/YHnUDOrRTyJNnRcNeULbtp4AxXzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>On Wed, Mar 22, 2023 at 10:08:54PM +0000, Zhang, Qiang1 wrote:
> > > > insmod rcutorture.ko
> > > > rmmod rcutorture.ko
> > > >=20
> > > > [  209.437327] WARNING: CPU: 0 PID: 508 at kernel/workqueue.c:3167=
=20
> > > > __flush_work+0x50a/0x540 [  209.437346] Modules linked in:=20
> > > > rcutorture(-) torture [last unloaded: rcutorture] [  209.437382]=20
> > > > CPU: 0 PID: 508 Comm: rmmod Tainted: G  W  6.3.0-rc1-yocto-standard=
+=20
> > > > [  209.437406] RIP: 0010:__flush_work+0x50a/0x540 .....
> > > > [  209.437758]  flush_delayed_work+0x36/0x90 [  209.437776] =20
> > > > cleanup_srcu_struct+0x68/0x2e0 [  209.437817] =20
> > > > srcu_module_notify+0x71/0x140 [  209.437854] =20
> > > > blocking_notifier_call_chain+0x9d/0xd0
> > > > [  209.437880]  __x64_sys_delete_module+0x223/0x2e0
> > > > [  209.438046]  do_syscall_64+0x43/0x90 [  209.438062] =20
> > > > entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > >=20
> > > > For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU()=
,=20
> > > > when compiling and loading as modules, the srcu_module_coming() is=
=20
> > > > invoked, allocate memory for srcu structure's->sda and initialize=20
> > > > sda structure, due to not fully initialize srcu structure's->sup, s=
o=20
> > > > at this time the sup structure's->delaywork.func is null, if not=20
> > > > invoke init_srcu_struct_fields() before unloading modules, in=20
> > > > srcu_module_going() the __flush_work() find
> > > > work->func is empty, will raise the warning above.
> > > >=20
> > > > This commit add init_srcu_struct_fields() to initialize srcu=20
> > > > structure's->sup, in srcu_module_coming().
> > > >=20
> > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > >
> > > >Good catch, and thank you for testing the in-module case!
> > > >
> > > >One question below...
> > > >
> > > >							Thanx, Paul
> > > >
> > > > ---
> > > >  kernel/rcu/srcutree.c | 11 ++++++++---
> > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c index=20
> > > > 1fb078abbdc9..42d8720e016c 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -1921,7 +1921,8 @@ static int srcu_module_coming(struct module *=
mod)
> > > >  		ssp->sda =3D alloc_percpu(struct srcu_data);
> > > >  		if (WARN_ON_ONCE(!ssp->sda))
> > > >  			return -ENOMEM;
> > > > -		init_srcu_struct_data(ssp);
> > > > +		if (WARN_ON_ONCE(init_srcu_struct_fields(ssp, true)))
> > > > +			return -ENOMEM;
> > > >
> > > >Wouldn't it be better to simply delete the init_srcu_struct_data()?
> > > >
> > > >Then the first call to check_init_srcu_struct() would take care of=20
> > > >the initialization, just as for the non-module case.  Or am I missin=
g=20
> > > >something subtle?
> > >=20
> > > Hi Paul
> > >=20
> > > Maybe the check_init_srcu_struct() is always not invoked, for example=
,
> > > In rcutorture.c,   here is such a definition DEFINE_STATIC_SRCU(srcu_=
ctl),
> > > but we use torture_type=3Drcu to test,  there will not be any interfa=
ce=20
> > > calling
> > > check_init_srcu_struct() to initialize srcu_ctl and set =20
> > > structure's->delaywork.func is process_srcu().
> > > when we unload the rcutorture module, invoke cleanup_srcu_struct() to=
=20
> > > flush sup structure's->delaywork.func, due to the func pointer is not=
=20
> > > initialize, it's null, will trigger warning.
> > >=20
> > > About kernel/workqueue.c:3167
> > >=20
> > > __flush_work
> > >      if (WARN_ON(!work->func))   <---------trigger waning
> > > 	return false;
> > >=20
> > >=20
> > > and  in  init_srcu_struct_fields(ssp, true), wil set=20
> > > srcu_sup->sda_is_static is true and set srcu_sup-> srcu_gp_seq_needed=
=20
> > > is zero,  after that when we call
> > >  check_init_srcu_struct() again, it not be initialized again.
> > >
> > >
> > >Good point!  In the non-module statically allocated case there is neve=
r a call to cleanup_srcu_struct().
> > >
> > >So suppose the code in srcu_module_coming() only did the alloc_percpu(=
), and then the
> > >code in srcu_module_going() only did the the matching
> > >free_percpu() instead of the current cleanup_srcu_struct()?
> >=20
> > But in modules, for srcu objects defined with DEFINE_SRCU() or DEFINE_S=
TATIC_SRCU(),
> > when a module is unloaded, we usually don't call cleanup_srcu_struct() =
in the module
> > unload function.
> > If in srcu_module_going() only do free_percpu(), the srcu_sup->node mem=
ory maybe
> > can not free and also lost the opportunity to refresh the running work.
> >
> >
> >But in the module case, isn't the srcu_sup->node also statically
> >allocated via the "static struct srcu_usage" declaration?
>=20
> static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_fla=
gs)
> {
> 	sp->srcu_sup->node =3D kcalloc(rcu_num_nodes, sizeof(*ssp->srcu_sup->nod=
e), gfp_flags);
> 	...
> }
>=20
> Regardless of whether the srcu object is declared in the module or not, s=
up->node is dynamically allocated.
> right?
>
>You are absolutely right, thank you!
>
>There are a couple of ways to resolve this.  One is to simply add
>a check_init_srcu_struct() before the call to cleanup_srcu_struct()
>from srcu_module_going(), as shown below.  This seems a bit silly,
>potentially initializing fields for no good reason.
>
>Another way is to make cleanup_srcu_struct() do the same check
>that check_init_srcu_struct() does:
>
>	rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed))
>
>If the value is non-zero, then cleanup_srcu_struct() should skip
>consistency checks that complain about things that cannot happen if
>there never was an RCU grace period.  Maybe something as shown after
>the second line of dashes.
>
>Thoughts?
>
>							Thanx, Paul
>
>------------------------------------------------------------------------
>
>
>/* Initialize any global-scope srcu_struct structures used by this module.=
 */
>static int srcu_module_coming(struct module *mod)
>{
>	int i;
>	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
>	struct srcu_struct *ssp;
>
>	for (i =3D 0; i < mod->num_srcu_structs; i++) {
>		ssp =3D *(sspp++);
>		ssp->sda =3D alloc_percpu(struct srcu_data);
>		if (WARN_ON_ONCE(!ssp->sda))
>			return -ENOMEM;
>		init_srcu_struct_data(ssp);
>	}
>	return 0;
>}
>
>/* Clean up any global-scope srcu_struct structures used by this module. *=
/
>static void srcu_module_going(struct module *mod)
>{
>	int i;
>	struct srcu_struct *ssp;
>	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
>
>	for (i =3D 0; i < mod->num_srcu_structs; i++) {
>		ssp =3D *(sspp++);
>		check_init_srcu_struct(ssp);
>		cleanup_srcu_struct(ssp);
>	}
>}
>
>------------------------------------------------------------------------
>
>void cleanup_srcu_struct(struct srcu_struct *ssp)
>{
>	int cpu;
>	struct srcu_usage *sup =3D ssp->srcu_sup;
>	bool wasused =3D !rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_=
seq_needed));
>
>	if (WARN_ON(wasused && !srcu_get_delay(ssp)))
>		return; /* Just leak it! */
>	if (WARN_ON(srcu_readers_active(ssp)))
>		return; /* Just leak it! */
>	flush_delayed_work(&sup->work);
>	if (wasused) {
>		for_each_possible_cpu(cpu) {
>			struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
>
>			del_timer_sync(&sdp->delay_work);
>			flush_work(&sdp->work);
>			if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
>				return; /* Forgot srcu_barrier(), so just leak it! */
>		}
>	}
>	if (WARN_ON(wasused && rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)) !=3D SR=
CU_STATE_IDLE) ||
>	    WARN_ON(wasused && rcu_seq_current(&sup->srcu_gp_seq) !=3D sup->srcu_=
gp_seq_needed) ||
>	    WARN_ON(srcu_readers_active(ssp))) {
>		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
>			__func__, ssp, rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)),
>			rcu_seq_current(&sup->srcu_gp_seq), sup->srcu_gp_seq_needed);
>		return; /* Caller forgot to stop doing call_srcu()? */
>	}
>	kfree(sup->node);
>	sup->node =3D NULL;
>	sup->srcu_size_state =3D SRCU_SIZE_SMALL;
>	if (!sup->sda_is_static) {
>		free_percpu(ssp->sda);
>		ssp->sda =3D NULL;
>		kfree(sup);
>		ssp->srcu_sup =3D NULL;
>	}
>}


If we have not invoke check_init_srcu_struct() ,  that means call_srcu(),  =
synchronize_srcu(), srcu_barrier(), start_poll_synchronize_srcu() are also =
not invoke, so Is there no need to check
srcu_readers_active()?

Thanks
Zqiang

