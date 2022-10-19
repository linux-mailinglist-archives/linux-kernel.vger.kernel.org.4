Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4586B60382B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJSCke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJSCkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:40:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45F5D77F6;
        Tue, 18 Oct 2022 19:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666147229; x=1697683229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/HnskVTMFIqdWDbV78cJbvGxTMesC7uWzjOyTheHfCM=;
  b=nATfg7TAYnXA6zumAArxhLeOEr6FeALCiV39xrXxhfDdrn6NzS3KWQxy
   TPIh7AHy7Tdpqk0oZqNr6M0Ed32/JSWhLhz6yDZGW7MwoIk+KvFd/uZdg
   6E2ISIgjODsSUSA+E3u3CM4YqZ9XQLLDUYK93k9+Z9uUnJqgF+hEbtbG1
   7WqIKupCy+GQGV/bloojD31LKzz6slU+tSBghJ0JIb0Chg5qoOn4mA1oR
   6eAevJaZK5K3jsrYUYsApzj6XnIU/Q9n+eXPO8sKXZdRa6I5aYP2PygJo
   iGoS0sc5n1fndw02z6dqwPgEY0vW0oX7a1jHxdoWSK59yEi4ddawsLQRl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="306275476"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="306275476"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 19:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="754355713"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="754355713"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 18 Oct 2022 19:40:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 19:40:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 19:40:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 19:40:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/ZflVa2ErMlxWTY720nXeK8Ynn5P/oaIM/izFuOKutJ5p097Z+vwNX5qV8SNAKK1NyMNCmLPndvso/w4PmXHrankdolgazyJCtvRLlhbYoeUeXnqXg2LcflBLH4KDAy8XYDMDKCdnGjJRVTJhxLmWwMgf15i1VBI2wzUsllnXGss3o/rF0nW3Q1J8rAn50fI1jS+rGA2t+3r8ePrQ2CwaBoIKNBLFnrpSHOKbs8uqb6jf5XRe0hUe/rSE5RclZyxI4p63frnxA/G2Ro3nnP0DPIF+6G11a+UVFyMLtLSin4ZKDJdKXiOdzMj4A5w/BdkMzbirb6KbtkHtcpoVD3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTXGbPZbNT8GKeXtRw9WRNaXl7VTE7YyynEfXDq/e0Q=;
 b=kW/AJEoDTWNLlhIVETCfu3ZFarXsfrtuTg+m+2DCw+ewliEFJprBnfCcsooJY3q+6ngOPqdAKJ40KItN/IWJVjd5vcalRdxF90a1V5Zj5XPODuf+y2v+ZmJKikh+lmcEvKIIlAPDmSYlenDYFBWsxTVo4P5ha+I4ZAlHofvlPyUcnLDCEgXmYceV7a3ee95q3qzqCgeif4a/MKgaicQMk0jTPE2nLeKv/uw8hXsliQgY8+SKrUB8ZjIi08IFZNwQCScMjnglJf891plROJM/KkOW1qJpZTMSvz0SWDjHqBj9cvWH1xlBeKUiDHbPZ4s26fW6gGezSJ+TcOuLICamsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA0PR11MB4656.namprd11.prod.outlook.com (2603:10b6:806:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 02:40:21 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0%8]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 02:40:21 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Yu Liao <liaoyu15@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "liwei (GF)" <liwei391@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: [BUG] possible deadlock in __rcu_irq_enter_check_tick
Thread-Topic: [BUG] possible deadlock in __rcu_irq_enter_check_tick
Thread-Index: AQHY3XRA23Ul8kJaeku0Y9YHsqxYoa4KUo+AgAntSQCAAMrasA==
Date:   Wed, 19 Oct 2022 02:40:21 +0000
Message-ID: <PH0PR11MB5880C91E45FB6C57EB3CDC14DA2B9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <e015e32d-d068-2d17-1ca5-c584c30ffebb@huawei.com>
 <20221012064911.GN4221@paulmck-ThinkPad-P17-Gen-1> <Y063MGk3oVg6ney0@lakrids>
In-Reply-To: <Y063MGk3oVg6ney0@lakrids>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA0PR11MB4656:EE_
x-ms-office365-filtering-correlation-id: fc15cacd-d54a-4db4-abe7-08dab17b4471
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQeLl+qKk7C0Ojr8uQsqLJybl5ZgNoFZEIb+YVcbn7oCJ8MI+izWbgJhwJJjoOjzVw6cOP5c0pS6bjJT56bAvLL/Q4gEB7aO4a3OGMTrKqKiWHTRFhzmbvFv1F2ZfWxqna/+y/KOwlvZ5vvOvmGHeanmZ+NGM2dPZc2cXxUPA7bRVr0RwQXss0YdM4JKxADBQNynzwX8Q6fo5cAzMOVEuUWkyWdXeR8JpoLlutUVp6RnEhfDOvX0kzJy1oYn01XiuEv41SlbKcGz4dPxFYj8pcPHhPg2jHxnikxc5s7KGpN++EDbl8sjzqXquFTYnqCF3Kq7v7I319xgrMDSHeuxslmC4NLctb3hhDL1JHfKaxLs9rCZ+yYzblshdh7bKSNnqiJruS4smzL68hPqjeUBB5L1InVFws5SrqFl+xz0Fbrx3jIpxYghl5HZa4lt6ApVNNLxTrHqwhhqxJfHbU2t47G/O8LyVAM6UNzT5E18TJQoU//D15aymVLZsfsWFmPrheROt6hrgDqwlzhOxEZZdntUAX05sSlzvI0I//zus287Sb1iy55nlqN+NGttUz5Oat40YLyIZlcs9/GYTjdGQPEEUGZe5rB11m3eHrGjC7UcPJEHC2j69fBcyJme3MpQPCVKWqdeoPtNZcafYyxGZLqOAVFt+EbURv8lHzCTg39YU3CwleEt3zqyE3Qn66y9Pl5EqVeV3IVbMKfBSpAARM6/Pu6LpVhaVG23e94z9xzuOwHIMC490YhswXbJH0L0aCpB1DQtThHG7E6egtYTGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(9686003)(186003)(26005)(6506007)(7696005)(71200400001)(66574015)(83380400001)(2906002)(30864003)(5660300002)(55016003)(54906003)(478600001)(316002)(41300700001)(52536014)(8936002)(66946007)(6916009)(66476007)(4326008)(8676002)(66446008)(76116006)(64756008)(66556008)(86362001)(33656002)(122000001)(38100700002)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Wb8w7qrXFcQ35G5eYT7PFW26ay4GZeYh/2uALcWVXL6URSlYjFS5ML0SuZZ?=
 =?us-ascii?Q?tK47yzbvpCGzuyWKVdzmQlfvK4Xxihta9G2rMod9Hlv0GEVHm234DDQ9dYio?=
 =?us-ascii?Q?vr5ilgN3et/kU0GgLfeguWOg54C2b4vM3r1ct3YDAlWPzy5xGpr7zWGIBUsq?=
 =?us-ascii?Q?3UGiKA+QIIVDJ1eCo1ROzxtj4wSLD9MCPwxkwxonJsfaSaanvTJPv5IbtZP1?=
 =?us-ascii?Q?Wy3/QSMO5pCbEnWW8HqAAD6lm25hnqHMoO2GvccB8dNcjBkA+hB/esbHzj8I?=
 =?us-ascii?Q?nSzKt+CArDUmd6FnigHWZthiGNc9T4LuRTDe8PpEADRia6xM7+gEtNoncoAC?=
 =?us-ascii?Q?6AUNYtvvrITmlw/LDDhbrcIR4ClIelMKmzQaNnnNWZ+KmCq62z18/P6h8rN7?=
 =?us-ascii?Q?edelGbHhBtdkvE/neaCkGmqeesy/+xOiFMimWLm0NwJhhX/sqENJbgyojpg7?=
 =?us-ascii?Q?zYNwxdVOzxb/fsIGeKoCJFVPbe4rpXnN3W8b5317aQVEZYUJWBB6tZqNb9fy?=
 =?us-ascii?Q?8mgYDzZBiX5TUfdWrIZl+6+pz5+zmSfvRHTRNT9EyBhAGrLjsyhHnDmU7XC5?=
 =?us-ascii?Q?cbFodyGhy5jeWacpUYm/CRmMg8aFs6zJlfdUakyjSWdci6t7LBeLrF06kGJE?=
 =?us-ascii?Q?KnZlAiHnKtvSEIOvfgnjIAf/4s2/RCYcdHxHz5u+xGHat/EYwFCtXqbzsuJn?=
 =?us-ascii?Q?lyUyORJy1R0/p6QY286xFs9tnQFauXWZQXcVwN5mlt9HUAtrd3OX+dQSLE5P?=
 =?us-ascii?Q?vAOKqjLo1OPQqy0zsz3Waq3Fs2HZOqQmlo7MlZu8a3pU9ICPBicYvneTiOuy?=
 =?us-ascii?Q?AeRVAF8SfVWRPYJ8lxD0QMLOJ37oeuUWmCi4t+uUb8dtRk2Hul0H7p8CrJBP?=
 =?us-ascii?Q?bv5PjaXleFUFdoyTwAZ4JRDUz5i+7v3mphQFnW8FC+Fbbm29OfDGjNMqPsWP?=
 =?us-ascii?Q?VORXTbOZaLC1yojV5oKpAfbu07lnT3eAL/jOSXmY+XTiOcjZl924rp3P79Et?=
 =?us-ascii?Q?SOWjU1s7z/P/T/HJWiPSbZFh0Udf7+TTQLTKVo8SGC4qkfR+hO84GePeU3IS?=
 =?us-ascii?Q?HGjSGUrNWCa2GsNMrMwBxJk8+ei5lK5/+w0E9GHw2r6tUD5AV5kCA5n2Zd84?=
 =?us-ascii?Q?7BVC3VvRq/PKAkP1j5uB0d9m/IS3r43KTuaL6RbzR0GiV7J1+gGWc5jjUi4P?=
 =?us-ascii?Q?vy5xLhipYggP/NiRMDVOaWXmvxuy5DPDV0SyFSLrAvkwzeTbvof/w5Xq60yb?=
 =?us-ascii?Q?tH5aXw8uXtZ95t5yKQjGIamzAdxmD5ZUDIFFQnsGsw5Wv6r/vRml1P0P29WT?=
 =?us-ascii?Q?/p/6ofbYfZcPUeMnKaIvnNQBev+4i4uA8IO2VGPq886v0hihVBTfdAWFmDLZ?=
 =?us-ascii?Q?/4jnzDH/DUOpbNHWYBedMag3dY2QpIa/mCuxb7uSLl0tLkN0TXH01+Vu+kNH?=
 =?us-ascii?Q?YGvHvNR5StqepKdfOH3RN+DgWCIr5bZfL4xJyFd8UnzSjT47Sba8WexvVSQJ?=
 =?us-ascii?Q?SJp5gr4+LVKMa1f23EyLm1SKMNSZ5pTM2OEaau2BiMOs+0eKxrEaUxuayLyZ?=
 =?us-ascii?Q?hm4afEfNOKSMC5krQIIOzlR3SxMx9XI6rvyIczwd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc15cacd-d54a-4db4-abe7-08dab17b4471
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 02:40:21.3115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEInytnWPa9ylcFqFq144BwIUNL5beesiEPg7n/TA0CRB67rtB5a9bpZySQtl/WMvKmfGn4r8WPbfpC18xEhrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4656
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Oct 11, 2022 at 11:49:11PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 11, 2022 at 09:18:11PM +0800, Yu Liao wrote:
> > Hello,
> >=20
> > When I run syzkaller, a deadlock problem occurs. The call stack is as f=
ollows:
> > [ 1088.244366][    C1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [ 1088.244838][    C1] WARNING: possible circular locking dependency de=
tected
> > [ 1088.245313][    C1] 5.10.0-04424-ga472e3c833d3 #1 Not tainted
> > [ 1088.245745][    C1] ------------------------------------------------=
------
>=20
> It is quite possible that an unfortunate set of commits were=20
> backported to v5.10.  Could you please bisect?
>=20
> > [ 1088.246214][    C1] syz-executor.2/932 is trying to acquire lock:
> > [ 1088.246628][    C1] ffffa0001440c418 (rcu_node_0){..-.}-{2:2}, at:
> > __rcu_irq_enter_check_tick+0x128/0x2f4
> > [ 1088.247330][    C1]
> > [ 1088.247330][    C1] but task is already holding lock:
> > [ 1088.247830][    C1] ffff000224d0c298 (&rq->lock){-.-.}-{2:2}, at:
> > try_to_wake_up+0x6e0/0xd40
> > [ 1088.248424][    C1]
> > [ 1088.248424][    C1] which lock already depends on the new lock.
> > [ 1088.248424][    C1]
> > [ 1088.249127][    C1]
> > [ 1088.249127][    C1] the existing dependency chain (in reverse order)=
 is:
> > [ 1088.249726][    C1]
> > [ 1088.249726][    C1] -> #1 (&rq->lock){-.-.}-{2:2}:
> > [ 1088.250239][    C1]        validate_chain+0x6dc/0xb0c
> > [ 1088.250591][    C1]        __lock_acquire+0x498/0x940
> > [ 1088.250942][    C1]        lock_acquire+0x228/0x580
> > [ 1088.251346][    C1]        _raw_spin_lock_irqsave+0xc0/0x15c
> > [ 1088.251758][    C1]        resched_cpu+0x5c/0x110
> > [ 1088.252091][    C1]        rcu_implicit_dynticks_qs+0x2b0/0x5d0
> > [ 1088.252501][    C1]        force_qs_rnp+0x244/0x39c
> > [ 1088.252847][    C1]        rcu_gp_fqs_loop+0x2e4/0x440
> > [ 1088.253219][    C1]        rcu_gp_kthread+0x1a4/0x240
> > [ 1088.253597][    C1]        kthread+0x20c/0x260
> > [ 1088.253963][    C1]        ret_from_fork+0x10/0x18
> > [ 1088.254389][    C1]
> > [ 1088.254389][    C1] -> #0 (rcu_node_0){..-.}-{2:2}:
> > [ 1088.255296][    C1]        check_prev_add+0xe0/0x105c
> > [ 1088.256000][    C1]        check_prevs_add+0x1c8/0x3d4
> > [ 1088.256693][    C1]        validate_chain+0x6dc/0xb0c
> > [ 1088.257372][    C1]        __lock_acquire+0x498/0x940
> > [ 1088.257731][    C1]        lock_acquire+0x228/0x580
> > [ 1088.258079][    C1]        _raw_spin_lock+0xa0/0x120
> > [ 1088.258425][    C1]        __rcu_irq_enter_check_tick+0x128/0x2f4
> > [ 1088.258844][    C1]        rcu_nmi_enter+0xc4/0xd0
>=20
> This is looking like we took an interrupt while holding an rq lock.
> Am I reading this correctly?  If so, that is bad in and of itself.
>
>In this case it's not an interrupt; per the entry bits below:
>
> > [ 1088.259183][    C1]        arm64_enter_el1_dbg+0xb0/0x160
> > [ 1088.259623][    C1]        el1_dbg+0x28/0x50
> > [ 1088.260011][    C1]        el1_sync_handler+0xf4/0x150
> > [ 1088.260481][    C1]        el1_sync+0x74/0x100

>
>... this is a synchronous debug exception, which is one of:
>
> * A hardware single-step exception
> * A hardware watchpoint
> * A hardware breakpoint
> * A software breakpoint (i.e. a BRK instruction)
>
>... and we have to treat those as NMIs.

Hi Mark

As can be seen from the callstack, we are not treating the above as NMI,
The following code snippet can also be seen:

kernel-v5.10 kernel:

rcu_nmi_enter ()
{
..........
	} else if (!in_nmi()) {
                instrumentation_begin();
               rcu_irq_enter_check_tick();
}

Maybe the following modification should be added:

--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -259,7 +259,7 @@ static void noinstr el1_inv(struct pt_regs *regs, unsig=
ned long esr)  static void noinstr arm64_enter_el1_dbg(struct pt_regs *regs=
)  {
        regs->lockdep_hardirqs =3D lockdep_hardirqs_enabled();
-
+       __nmi_enter();
        lockdep_hardirqs_off(CALLER_ADDR0);
        rcu_nmi_enter();

@@ -278,6 +278,7 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *=
regs)
        rcu_nmi_exit();
        if (restore)
                lockdep_hardirqs_on(CALLER_ADDR0);
+       __nmi_exit();
 }



Thanks
Zqiang


>
>That could be a kprobe, or a WARN, etc.
>
>Thanks,
>Mark.
>
> > [ 1088.260800][    C1]        update_irq_load_avg+0x5d8/0xaa0
> > [ 1088.261194][    C1]        update_rq_clock_task+0xb8/0x2d0
> > [ 1088.261595][    C1]        update_rq_clock+0x8c/0x120
> > [ 1088.261952][    C1]        try_to_wake_up+0x70c/0xd40
> > [ 1088.262305][    C1]        wake_up_process+0x1c/0x24
> > [ 1088.262652][    C1]        wakeup_softirqd+0x58/0x64
> > [ 1088.263000][    C1]        __do_softirq+0x6b8/0x95c
> > [ 1088.263345][    C1]        irq_exit+0x27c/0x2d0
> > [ 1088.263674][    C1]        __handle_domain_irq+0x100/0x184
> > [ 1088.264049][    C1]        gic_handle_irq+0xc0/0x760
> > [ 1088.264394][    C1]        el1_irq+0xb8/0x140
> > [ 1088.264709][    C1]        _raw_spin_unlock_irqrestore+0x7c/0x130
> > [ 1088.265134][    C1]        __aarch64_insn_write+0xc4/0x100
> > [ 1088.265516][    C1]        aarch64_insn_patch_text_nosync+0x40/0xa0
> > [ 1088.265942][    C1]        ftrace_make_nop+0x120/0x1a4
> > [ 1088.266300][    C1]        __ftrace_replace_code+0xdc/0x160
> > [ 1088.266684][    C1]        ftrace_replace_code+0x100/0x1a4
> > [ 1088.267063][    C1]        ftrace_modify_all_code+0x1a8/0x260
> > [ 1088.267456][    C1]        arch_ftrace_update_code+0x1c/0x2c
> > [ 1088.267847][    C1]        ftrace_run_update_code+0x38/0xa4
> > [ 1088.268259][    C1]        ftrace_shutdown.part.0+0x2dc/0x550
> > [ 1088.268682][    C1]        unregister_ftrace_function+0x74/0xc0
> > [ 1088.269117][    C1]        perf_ftrace_event_register+0x130/0x1a0
> > [ 1088.269559][    C1]        perf_trace_destroy+0x68/0x9c
> > [ 1088.269938][    C1]        tp_perf_event_destroy+0x1c/0x2c
> > [ 1088.270340][    C1]        _free_event+0x2f4/0x670
> > [ 1088.270696][    C1]        put_event+0x7c/0x90
> > [ 1088.271031][    C1]        perf_event_release_kernel+0x3c0/0x450
> > [ 1088.271467][    C1]        perf_release+0x24/0x34
> > [ 1088.271824][    C1]        __fput+0x1dc/0x500
> > [ 1088.272155][    C1]        ____fput+0x24/0x30
> > [ 1088.272471][    C1]        task_work_run+0xf4/0x1ec
> > [ 1088.272811][    C1]        do_notify_resume+0x378/0x410
> > [ 1088.273180][    C1]        work_pending+0xc/0x198
> > [ 1088.273504][    C1]
> > [ 1088.273504][    C1] other info that might help us debug this:
> > [ 1088.273504][    C1]
> > [ 1088.274168][    C1]  Possible unsafe locking scenario:
> > [ 1088.274168][    C1]
> > [ 1088.274658][    C1]        CPU0                    CPU1
> > [ 1088.275012][    C1]        ----                    ----
> > [ 1088.275367][    C1]   lock(&rq->lock);
> > [ 1088.275646][    C1]                                lock(rcu_node_0);
> > [ 1088.276082][    C1]                                lock(&rq->lock);
> > [ 1088.276517][    C1]   lock(rcu_node_0);
> > [ 1088.276797][    C1]
> > [ 1088.276797][    C1]  *** DEADLOCK ***
> > [ 1088.276797][    C1]
> > [ 1088.277339][    C1] 4 locks held by syz-executor.2/932:
> > [ 1088.277696][    C1]  #0: ffffa000145251e8 (event_mutex){+.+.}-{3:3},=
 at:
> > perf_trace_destroy+0x34/0x9c
> > [ 1088.278345][    C1]  #1: ffffa000144fb5a8 (ftrace_lock){+.+.}-{3:3},=
 at:
> > unregister_ftrace_function+0x2c/0xc0
> > [ 1088.279034][    C1]  #2: ffff0000c0e0c968 (&p->pi_lock){-.-.}-{2:2},=
 at:
> > try_to_wake_up+0xbc/0xd40
> > [ 1088.279672][    C1]  #3: ffff000224d0c298 (&rq->lock){-.-.}-{2:2}, a=
t:
> > try_to_wake_up+0x6e0/0xd40
> > [ 1088.280300][    C1]
> > [ 1088.280300][    C1] stack backtrace:
> > [ 1088.280706][    C1] CPU: 1 PID: 932 Comm: syz-executor.2 Not tainted
> > 5.10.0-04424-ga472e3c833d3 #1
> > [ 1088.281315][    C1] Hardware name: linux,dummy-virt (DT)
> > [ 1088.281679][    C1] Call trace:
> > [ 1088.281910][    C1]  dump_backtrace+0x0/0x41c
> > [ 1088.282218][    C1]  show_stack+0x30/0x40
> > [ 1088.282505][    C1]  dump_stack+0x1fc/0x2c0
> > [ 1088.282807][    C1]  print_circular_bug+0x1ec/0x284
> > [ 1088.283149][    C1]  check_noncircular+0x1cc/0x1ec
> > [ 1088.283486][    C1]  check_prev_add+0xe0/0x105c
> > [ 1088.283804][    C1]  check_prevs_add+0x1c8/0x3d4
> > [ 1088.284126][    C1]  validate_chain+0x6dc/0xb0c
> > [ 1088.284442][    C1]  __lock_acquire+0x498/0x940
> > [ 1088.284764][    C1]  lock_acquire+0x228/0x580
> > [ 1088.285072][    C1]  _raw_spin_lock+0xa0/0x120
> > [ 1088.285392][    C1]  __rcu_irq_enter_check_tick+0x128/0x2f4
> > [ 1088.285779][    C1]  rcu_nmi_enter+0xc4/0xd0
> > [ 1088.286082][    C1]  arm64_enter_el1_dbg+0xb0/0x160
> > [ 1088.286420][    C1]  el1_dbg+0x28/0x50
> > [ 1088.286689][    C1]  el1_sync_handler+0xf4/0x150
> > [ 1088.287010][    C1]  el1_sync+0x74/0x100
> > [ 1088.287295][    C1]  update_irq_load_avg+0x5d8/0xaa0
> > [ 1088.287640][    C1]  update_rq_clock_task+0xb8/0x2d0
> > [ 1088.287988][    C1]  update_rq_clock+0x8c/0x120
> > [ 1088.288309][    C1]  try_to_wake_up+0x70c/0xd40
> > [ 1088.288629][    C1]  wake_up_process+0x1c/0x24
> > [ 1088.288945][    C1]  wakeup_softirqd+0x58/0x64
> > [ 1088.289271][    C1]  __do_softirq+0x6b8/0x95c
> > [ 1088.289580][    C1]  irq_exit+0x27c/0x2d0
> > [ 1088.289868][    C1]  __handle_domain_irq+0x100/0x184
> > [ 1088.290211][    C1]  gic_handle_irq+0xc0/0x760
> > [ 1088.290522][    C1]  el1_irq+0xb8/0x140
> > [ 1088.290801][    C1]  _raw_spin_unlock_irqrestore+0x7c/0x130
> > [ 1088.291188][    C1]  __aarch64_insn_write+0xc4/0x100
> > [ 1088.291533][    C1]  aarch64_insn_patch_text_nosync+0x40/0xa0
> > [ 1088.291928][    C1]  ftrace_make_nop+0x120/0x1a4
> > [ 1088.292256][    C1]  __ftrace_replace_code+0xdc/0x160
> > [ 1088.292613][    C1]  ftrace_replace_code+0x100/0x1a4
> > [ 1088.292963][    C1]  ftrace_modify_all_code+0x1a8/0x260
> > [ 1088.293335][    C1]  arch_ftrace_update_code+0x1c/0x2c
> > [ 1088.293694][    C1]  ftrace_run_update_code+0x38/0xa4
> > [ 1088.294048][    C1]  ftrace_shutdown.part.0+0x2dc/0x550
> > [ 1088.294415][    C1]  unregister_ftrace_function+0x74/0xc0
> > [ 1088.294787][    C1]  perf_ftrace_event_register+0x130/0x1a0
> > [ 1088.295172][    C1]  perf_trace_destroy+0x68/0x9c
> > [ 1088.295500][    C1]  tp_perf_event_destroy+0x1c/0x2c
> > [ 1088.295850][    C1]  _free_event+0x2f4/0x670
> > [ 1088.296154][    C1]  put_event+0x7c/0x90
> > [ 1088.296439][    C1]  perf_event_release_kernel+0x3c0/0x450
> > [ 1088.296820][    C1]  perf_release+0x24/0x34
> > [ 1088.297125][    C1]  __fput+0x1dc/0x500
> > [ 1088.297404][    C1]  ____fput+0x24/0x30
> > [ 1088.297682][    C1]  task_work_run+0xf4/0x1ec
> > [ 1088.297989][    C1]  do_notify_resume+0x378/0x410
> > [ 1088.298316][    C1]  work_pending+0xc/0x198
> >=20
> > I checked the code. The following scenarios may cause deadlock.
> >=20
> > static void ttwu_queue(struct task_struct *p, int cpu, int=20
> > wake_flags) {
> >     struct rq *rq =3D cpu_rq(cpu);
> >     struct rq_flags rf;
> >=20
> >     if (ttwu_queue_wakelist(p, cpu, wake_flags))
> >         return;
> >=20
> >     rq_lock(rq, &rf);
> >     update_rq_clock(rq);=09
> > 		=3D=3D=3D> el1_dbg
> > 			  ->rcu_nmi_enter
> > 			    ->__rcu_irq_enter_check_tick
> > 				  ->raw_spin_lock_rcu_node(rdp->mynode);
> >     ttwu_do_activate(rq, p, wake_flags, &rf);
> >     rq_unlock(rq, &rf);
> > }
> >=20
> > static void rcu_gp_fqs(bool first_time) {
> >     struct rcu_node *rnp =3D rcu_get_root();
> >=20
> >     WRITE_ONCE(rcu_state.gp_activity, jiffies);
> >     WRITE_ONCE(rcu_state.n_force_qs, rcu_state.n_force_qs + 1);
> >     if (first_time) {
> >         /* Collect dyntick-idle snapshots. */
> >         force_qs_rnp(dyntick_save_progress_counter);
> >     } else {
> >         /* Handle dyntick-idle and offline CPUs. */
> >         force_qs_rnp(rcu_implicit_dynticks_qs);=09
> > 			=3D=3D=3D>raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > 			=3D=3D=3D>rcu_implicit_dynticks_qs
> > 				  ->resched_cpu
> > 				    ->raw_spin_lock_irqsave(&rq->lock, flags);
> >     }
> >     /* Clear flag to prevent immediate re-entry. */
> >     if (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) {
> >         raw_spin_lock_irq_rcu_node(rnp);
> >         WRITE_ONCE(rcu_state.gp_flags,
> >                READ_ONCE(rcu_state.gp_flags) & ~RCU_GP_FLAG_FQS);
> >         raw_spin_unlock_irq_rcu_node(rnp);
> >     }
> > }
> >=20
