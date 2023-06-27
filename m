Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AA073FF0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjF0Oz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjF0Oyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:54:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCFF35BD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687877576; x=1719413576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mkfhtreuxusToFgvxOpU2UjVZfPct2x3MDn6fs/kkfI=;
  b=blQ9NBkiYj0ECOXXstL3mMERLHViAetDVERyC3Ds5q01SP3OEXjvOjec
   lTWKtKrfvKc9VY3apI+PsfL3SoNfVWQPQ+5aK3c6Flim7bhzGJC24qLnF
   GU0I4XOe7fPYivSId9nWaxJ33Yh9tp7qUfANZ3JbT47l9LowAOwkweuuf
   IUBDQTrEv4FdBI7sQ0/QvRDaoTAg+oWFXi5CC22dfhQk8TWGPn+Bfj5Si
   ksJOlusTnwGGP33VdkV4COXYPXAVuV/8KX7JG0wCTsIPRxAXPJ2KdeMig
   Y4bvJxi63lMNsq8qW9bucA7zZPdPKGChnnP3GweBIYUhBwHI9QjxXgg+M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="447974377"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="447974377"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 07:52:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="751756094"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="751756094"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2023 07:52:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 07:52:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 07:52:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 07:52:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8BiQgwacBd/Skxx4fMLtcMQm19eVCtMD86cMQOJrIHps3jTvgWxti3txaoJKXlXJ0rNFzColDh9EReqB2dJmIeNbcqZq8ADSZGSYnzkqpbzsVEkouzzV5LH24pZC1TQGGXsMbaVOIf3YPnaIWHVIvouZo5DNWAmK6lktkejjZJTTxKuI/I5h6f9rwthXFV1+mlZbqzpm6DbKUj7+hEjpSR3KECcwv/nh5qZ3Ese0jL+BzvvUPJMUNT8VChSaBoRUYNRfgQRxUC2T342TmnNVmryaYl1e8wRakIb+4Xkai2YiyC+l0GlkjpB/1Oi726A0F22G4f0sSanJYf65RZO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0V/fhjwhAb8hUkBGKT5x20wvQoyj6f3GoMLCdY5UuRw=;
 b=gFg1yH8ZMycdb8IZQmhqaG6P3t4Yu9pCjrv4sM8lhlh5hskuJNbYUi47HfUqdzj4b4Y/IOZTGw2688YDmO0NyCzGakluk4P/NIZH9PAJspqbIY0qdu47w2tazJVEuUNDxMRmO6PpeRIYvuWriedk6YTsT5FxqRZuf3fvKB8x5DWmtNo13gUsDKEkI8voIrfp7/P4hjb4pzZldX3u+A6actHz9y9dRXKovycQz8gN/oca+MIrCKN4o4y+NvYRQv57VawS8HKkdnLv+Rs8pQ2ZxVeEKuqvKPtjtuxN/oaiWKMaK2FSFXytrvGDeYfZ27fqOKj5qvQa3R/cYhYODSfceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3260.namprd11.prod.outlook.com (2603:10b6:5:b::30) by
 SA1PR11MB6919.namprd11.prod.outlook.com (2603:10b6:806:2bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Tue, 27 Jun 2023 14:52:51 +0000
Received: from DM6PR11MB3260.namprd11.prod.outlook.com
 ([fe80::9aea:5d4e:5008:a155]) by DM6PR11MB3260.namprd11.prod.outlook.com
 ([fe80::9aea:5d4e:5008:a155%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 14:52:50 +0000
From:   "Deng, Pan" <pan.deng@intel.com>
To:     "Chen, Yu C" <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
CC:     "Lu, Aaron" <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Tianyou" <tianyou.li@intel.com>, "Ma, Yu" <yu.ma@intel.com>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>
Subject: RE: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Thread-Topic: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Thread-Index: AQHZpBf8y9gtMyr/606YJQEIlMf8Fa+cm1MAgAAivoCAAJuXAIAA+yqAgABvq/A=
Date:   Tue, 27 Jun 2023 14:52:50 +0000
Message-ID: <DM6PR11MB3260FC52E13ADB32AB745DFC9627A@DM6PR11MB3260.namprd11.prod.outlook.com>
References: <20230621081425.420607-1-pan.deng@intel.com>
 <20230626054756.GA435374@ziqianlu-dell>
 <ZJlDsbyNmcKtweg4@chenyu5-mobl2.ccr.corp.intel.com>
 <0a611696cbc63a3a9b99a7966b8fe4f7e20a014b.camel@linux.intel.com>
 <ZJqY5xnCv7BNkWuj@chenyu5-mobl2.ccr.corp.intel.com>
In-Reply-To: <ZJqY5xnCv7BNkWuj@chenyu5-mobl2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3260:EE_|SA1PR11MB6919:EE_
x-ms-office365-filtering-correlation-id: 99356a5f-ae0a-40de-2d49-08db771e2dc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1IGQSCmHsjRxqyesq3C0I/6P7+STsrWI2YyRrP1koMKyMoRj03uNoWPCXQ3SKbuw/AUACCe+IrWzNdcYxery/cRPpauhIY/+aUBEF5qzc3mQiUCKqDpuW1Ao5CKAhYhbV2/PMmb2jtRzoY1AkO6cmqWlgPIjA0dT32icgw0OGRDhofaziZ2iD3GOJgNeVfUQ8+aXrFQbQAPfPWlwXPXmn8SxwRC6/lDqNnatI+CTr+iPN9C+sj8gp5D2yuM1c1kee8GkpwbIG0s3ty3oNv7zRSEce+6+aQaTruVnKiciqHF0WuJkccNjszyWB3qlWnX0ifb0brby0K9cr9XyjiMiKsWe6RyCZJk3GQT29wC89xMqiePY36/10e8N1ZjwvvG/WEaPydWivGZtupnwjTM0ZtpnPtnw0/O4AB0taOofXoiWVC6ftVNQpLw7TGz5vwDlHBqOZpFQFodoobzYhfdcg1h9TRK8LrQZSotvU6p6VSqoAx/wq2O92RV46IXitef6LKhajyDG24rbDTny80etpNPYezW2Cfrb3an6nizGe1tEA23a3rVaObsp9wEfwXyv+hd4wb15fKPg/mNdc0oCXDhp00hNwvG8iEovT0XJhoinJcotip9969C8yJGHxyH/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3260.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(54906003)(2906002)(53546011)(9686003)(7696005)(82960400001)(26005)(83380400001)(38100700002)(122000001)(71200400001)(186003)(6506007)(55016003)(41300700001)(110136005)(86362001)(38070700005)(4326008)(478600001)(316002)(76116006)(66556008)(66946007)(66446008)(33656002)(66476007)(64756008)(8936002)(8676002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jA+5xJJ8IslKxEaLAhf+/SxFp5C2p6YsAQ57uQtT2KDcZ82R2r9cFfY1iKJE?=
 =?us-ascii?Q?4wKRRP4pp7F1DB7/xW207TRtxrlZOlnaXMaLWcVHM4nWRy0mFnZ7vAXRsbJ1?=
 =?us-ascii?Q?q+ziR45iGXAfEZJwWl7ofySUKTCGx6CrwuM0lVKuU1TV7A+yGQggO+O4HnRF?=
 =?us-ascii?Q?Ua80aUkv92aU4gSDBpgst7lP2pEKtVI91RPlB5LiEW7MxUGJvRqQtWtmrDDk?=
 =?us-ascii?Q?jSUYr7ENSaTVXNT2YrR65WjImpKEF6FHF/IIBjv9swU5YxLOeBFKJD34RYvX?=
 =?us-ascii?Q?l3Q5ylu4kpARBP/QCkjvSgkpwC68BdUDdYgWmbmTM9TOHbGFDY3s7V8Bs5FH?=
 =?us-ascii?Q?hR+ooUgatxr+FhaVj9qyebiKtnP1vEQ7m0K0H+HUaUN/WuQ+r8JVdh46dHEa?=
 =?us-ascii?Q?zz852WAREWzLm0S3QFvxVSkTeEBJTc5hxiI7U0WjSfuN47WF9LFVWS0e1XuM?=
 =?us-ascii?Q?ukYWlPSRVwlMV7jeoVrXnAy0NWc2w/HOz3A1doZshhT4Z+aBn0NeWKF7MZ2j?=
 =?us-ascii?Q?pxT/f7m0mjqPkA9XXRuZX/XLC6abbAsFSQQ1jIX1f6+Zy7OKfQG7qZQnKZKl?=
 =?us-ascii?Q?GX0pU+dtG1VGdkPTEOHZswse4UrB/xGsH5x4bjz63Y3VDH1rxU0AeXahJWt9?=
 =?us-ascii?Q?GDemXvWCibtzRlbLVDs/M26fAWQD3gF0umhI3Hv4SwCNASaWfUrjqpjPeh2+?=
 =?us-ascii?Q?vUuDa0M5iMeR3oz0VLdifHRufznw2refIkrxKa6rnZDUr9t6sXaZu3La1aM5?=
 =?us-ascii?Q?MYvh+6vylW3IF2mkMv0Ur5MdMkRSFJ8+XlNFFfqTJuA0/3p+KggR0fEclEga?=
 =?us-ascii?Q?g02Ek0QmwO43SMyMGf4hk4MBg2a5AMGJ5HsIX+iRYrIM6+OwbwusdGHuhqEF?=
 =?us-ascii?Q?GryGevswnlXnfpqGVtpnn1uXCuHF7+cHcbUC28bWbL24rHaPzillINP57OOU?=
 =?us-ascii?Q?hA3J54qTv+JhV8t4CwbLJmoxU1Tl4oYWQIy1wmeFigtfUlJJx55J5q3S0sNV?=
 =?us-ascii?Q?xXY2AE+fzyTLBu7XADLYge/UqTVPbqRDoFQv9J6Naeq+pZzbt+cYgQbUsVpt?=
 =?us-ascii?Q?ZjurhJBfOx2rJu7aR0/hsyxtdgpnBrSCyWwjgA/Bgz3xq1rIkrS61B9kIjlz?=
 =?us-ascii?Q?aIb7m5F6qPme03iCkeBXOrqplC9BVDrKammmlGnAaALdW2JmpxyOInBN+AdI?=
 =?us-ascii?Q?ve8Px4clXLrJjY4V5FJ9wuByNxyZKlVBWUZsf5JiUTKDc1hlqihUJCsWybPs?=
 =?us-ascii?Q?YMfWCpKuxq/UKrTGvESN6h2KL7C1VE5I4ZPIVORgzW9UwnEKLWtGxVLkSULH?=
 =?us-ascii?Q?507cID9IZpMwlwoC29p3vmsuHQbR+Uzhyfvqr6luL8HqA6NT0juVHamAhhKk?=
 =?us-ascii?Q?CkIiMbcDpEnL6g5QRZNcQ7RBx6wUhDr/M8yaJhD5mboL0y36WqdsTdvmlKuM?=
 =?us-ascii?Q?X9zGhzM23gqYx2mZGDXXkkybBXePyEFNnTi175XZk2GQaoQxW7K3hdgGfhuH?=
 =?us-ascii?Q?6RZYD1hWR656bHunVkiGeztoYIN/pJ0qATTawsuwaQdtVb4pw19VkISBCsz4?=
 =?us-ascii?Q?GzcYbft43hy1smwCkco=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3260.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99356a5f-ae0a-40de-2d49-08db771e2dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 14:52:50.3314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mw/6kHEM3880pDDF5Qd+qFNvGQP3/6zPV3iuxzhelPSIiWRBZZ9XGCaaghcijw4bFRLjGPTqg+CfHigyaObOeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6919
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Chen, Yu C <yu.c.chen@intel.com>
> Sent: Tuesday, June 27, 2023 4:08 PM
> To: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Lu, Aaron <aaron.lu@intel.com>; Peter Zijlstra <peterz@infradead.org>=
;
> Vincent Guittot <vincent.guittot@linaro.org>; Ingo Molnar
> <mingo@redhat.com>; Juri Lelli <juri.lelli@redhat.com>; Deng, Pan
> <pan.deng@intel.com>; Chen, Tim C <tim.c.chen@intel.com>; linux-
> kernel@vger.kernel.org; Li, Tianyou <tianyou.li@intel.com>; Ma, Yu
> <yu.ma@intel.com>; Zhu, Lipeng <lipeng.zhu@intel.com>
> Subject: Re: [PATCH v2] sched/task_group: Re-layout structure to reduce
> false sharing
>=20
> On 2023-06-26 at 10:09:10 -0700, Tim Chen wrote:
> > On Mon, 2023-06-26 at 15:52 +0800, Chen Yu wrote:
> > >
> > >
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h index
> > > ec7b3e0a2b20..067f1310bad2 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -1958,8 +1958,10 @@ static inline void set_task_rq(struct
> > > task_struct *p, unsigned int cpu)  #endif
> > >
> > >  #ifdef CONFIG_RT_GROUP_SCHED
> > > -	p->rt.rt_rq  =3D tg->rt_rq[cpu];
> > > -	p->rt.parent =3D tg->rt_se[cpu];
> > > +	if (p->sched_class =3D &rt_sched_class) {
> > > +		p->rt.rt_rq  =3D tg->rt_rq[cpu];
> > > +		p->rt.parent =3D tg->rt_se[cpu];
> > > +	}
> >
> > If we avoid the assignment for non-rt task, do you see it further
> > improves c2c bounce?
> >
> I did not see noticeable extra throughput improvement from netperf, with
> above change + Aaron's fix + Pan's cacheline alignment adjustment.

Echo Yu.
Cacheline alignment adjustment resolved set_task_rq c2c bounce with load_av=
g,
The remained cycles of "assignment for non-rt task" is little according to =
perf record
data, the should be the reason of no extra throughput improvement.

Thanks
Pan=20
>=20
> thanks,
> Chenyu
