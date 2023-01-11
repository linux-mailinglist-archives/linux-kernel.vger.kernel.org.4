Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1216653B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjAKFcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjAKFcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:32:07 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F332233D51;
        Tue, 10 Jan 2023 21:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673414520; x=1704950520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KiuXpC3FO9aNwxgFAFaTP4IwYzhZ97gCT4geeiVD3N4=;
  b=oEQcDJxycynBa4Y0c9EgoGhwBvDOoosbgBCd1FdI7aQAzZpJMEr9jhaY
   wlnN9pRD5lopo57/AC6TCr2EcjLg95Oy+DJXyBT0q/rc+DCNOO0cx2/+O
   80ZSUEfidPIkqdITKAMvtjQNxVDVaB81miFI3lIr1yf6/m1YNhuBVHGRu
   072BRaM1GPSJHZqdhmVJ6gIcTr3lddXDValu3j2lDcXodk/7H2XEAK12v
   F69Mjj988Cem1ONGv0g9CI/+/k1U9MnzYQDA8rTXogsCeKuOBjvpQ5U91
   b9LakKK8RYjjOF/A0yjvzu8uKgMGkS4V4hA7wKsLQRCnXvdWutrjyCYLB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303030814"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303030814"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 21:21:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="831231368"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="831231368"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2023 21:21:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 21:21:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 21:21:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 21:21:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+cMGgrqy6vwOBOhe3zNUYGbgacDIbRUqHBS0ZvKP92fgbhNMRM8Aa1Vp1qm3DsivgGFJ9DA9g1ZNAmqGq/b3MciU15JyusIp9Xg1eRBvx4vwYayKAsdAEMDHbi8gUPphOsovluJAtwYG/MYCgloPtk4qmpYDcWH4ZOGNKYSyoIR4+uyYdh2Ptgi0ouH5b3WPJZw30slqBS4UW+XILag8kDKCmXzl4jarOhUZsNYzUbklNZg3IWaZdG552WVkso+fadaOHlltX/lPLHptsc+chFGH9aSLG9h9RhxrBHJYHFQB4SZbc6z+RQLSjGYYoB1YDU5Ttp96iw/pfnMLS5jtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jew1BjVETQGBhz8gcnAyQ1Cxx59VXXAXJaW4Pten0Q=;
 b=aFFnc1V7hjvjSCSWf6h9yksEWMZiPDYlMDU2keC4KjiIvgR7nqkxPxDH5yR7y0Yiv7wlZ9DJMIuijS0yFjKTFdHT4l7kAgCGLCgJcXyl9QYqmdNy5fjUnYPxOvyfEetTa+vgimqrDRa4xdDhc+OC9MLMWxTm+W4AcYsYZlvoSsybFusoZYZTegHH8ETxUBhM+pfw+0V2TVk3+1LxKtYqRyZk7204j4TBg4M9NhQk0Az/s7exTYa7+jf0DuNxX8U1MCCC/X+ObVpi4DKtLtDQwJExSDjU0oo524deSHM2L9kjwFbKQBZJpK4G7KKB24EtGjGsVrjE6OkLwLXWLqkWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 05:21:35 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 05:21:35 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "Liu, Yujie" <yujie.liu@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Topic: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Index: AQHZBRUNYM7gGe8KaECV+8uqpx3Q8a50ePYAgAAL4hCABFctgIAA5ZxAgBaZgACAAIwEcIAGQAgAgAAwP4CAADGRwIAAdMeAgAAyxICAAJQWUA==
Date:   Wed, 11 Jan 2023 05:21:35 +0000
Message-ID: <PH0PR11MB588072CF2417F6F1D66A620ADAFC9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <202212181914.f5a305f3-yujie.liu@intel.com>
 <PH0PR11MB5880EB31D9AFD82EFA3073A6DAE59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221221193325.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588092AB6A014F30420D697CDAE89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230105182220.GF4028633@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880273B1F5A6FF2CB782051DAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230110021012.GI4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230110050253.GA3798705@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58808C49B2BFA8F4D6D9E0FEDAFF9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230110145815.GM4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230110175957.GA3836063@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230110175957.GA3836063@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SN7PR11MB7510:EE_
x-ms-office365-filtering-correlation-id: ef4d9c95-0050-4c12-4f73-08daf393b53a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFC57KiZvGqKeJXh/ap/mVABqGQq6NbjT3dhStZF5oYQrc6gDwIZcrq0JuaRTQSlg6UicRmz2/CNTfRoju/EEnIYx2USPMS02N8okrTlLfs4Pye3cJKkCgJOhdev1ofmQ+2BWQYOMqSjeys22+1NLWHS6ORSUgck0A45eEv356kYVs+AcM2FGP3q71cAcAPlhGJqac1e1s9/TAXVe03dxNLG8kJs2HHZufOHrgO8AD5d4cfNU2bidUr6UDySlo+wsBqpYuLGT7XWV5QcUpL1HZ27C9KIhBvNCkCMjYIocRLVIZ47onl730LafAq/chPxzuur81yWzzt+C/cOb5U7nNTD5AT7zVic8lY/tAJxaoo1FsZP7IFGjgmNxlQ7YGmgZPShoZVuDv71oPHsCFvtktc+FSzoJXBrx9NBDKjwZs0kVTMapozDzB/tFYLoG2vf7BVOpWr975Rmv3IOOrPKd0tCSzRUnr6I5piU7ZKlppLwZZzNMzaP37+GkHVpVhw9PpfeNz3BvFJMSD0a7gjE6ATJgBbjJ3GfPBXGVpEXW8mJ6Sa5JWwoK7Pv4FMJka7TNCkqzMZETbW9/WRuWiZGR1n4PbNaWdBedZHocAj1qqpnXa1LDHvO8+AIceNK6FAlqngH/nlEJ9sbB2ee9mKhLqXASJPvCe6f4gdUMDNOLkR7KulXz/oc+xQ02iCdhBnUnJgAOllFRjIphbnc4vNijtrMdRXkewEtdntFkTJUc9X4nPEzdOfYtjDQYubYfUMkLqMHvitLPOreWJ5Gpfs8Tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(9686003)(54906003)(6506007)(186003)(55016003)(76116006)(86362001)(4326008)(30864003)(66446008)(38100700002)(66946007)(38070700005)(66476007)(64756008)(5660300002)(122000001)(66556008)(478600001)(8676002)(6916009)(2906002)(26005)(82960400001)(71200400001)(33656002)(316002)(52536014)(41300700001)(8936002)(966005)(45080400002)(7696005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kT7gmD4+t2AIGmkdz5XHugyxk8Ql/XDIDYf+e8DlC9XLRqfJkQrkl5a03hS/?=
 =?us-ascii?Q?DsPQ92AyAzXiUwLFMUeutHL6bN1ecXqMtOYjlqRg3D4k24uhnqMxsRk0YRde?=
 =?us-ascii?Q?/3r6lI6Q/651XHaz50aSbWFD8MiAS+aY7HH6ZNxbkYcOLYDax0N0yXQ+dPEg?=
 =?us-ascii?Q?FgfadVQQB7OL1DJhy9TKAnAKQk05+be9TQbIBC6+1INhOI7nt5FhkwjMF/Ix?=
 =?us-ascii?Q?cviRouVLnTh1se1FiM/nSFF688Fma0VkhhkhCXoTJmCT1sg5K1B7nAOT6uzU?=
 =?us-ascii?Q?7IZbtfrAosCdBQrTNte0tjePJPebnJCMB6a30PHURMBOHwZEWde2+tlwPb+e?=
 =?us-ascii?Q?cDGhNwJBHow2xUf/IA4LLsPZ5jCz1lFuXAcEdHV+1mMbDia6I2zM60zAdMTc?=
 =?us-ascii?Q?JhDRKC+hqD6zcytwrwCZpZQAP0g2dEuN8rml2yyhJccrSnLXIw04cwmlA3VZ?=
 =?us-ascii?Q?Quo0EXMx+uOt6x4qoPHPZn25HH6W6i8qnzJa9tTA5nB0xjM98zDLfsKYwqhE?=
 =?us-ascii?Q?YbLPAg/0hiZDpENvyyREnqVlxr3wiDlk0ZlsRKO1G6cxN67kO1r6mOHPNjMg?=
 =?us-ascii?Q?t51JCxK6t8TxKrLpuDXqO/+6ttzgRquA45P1OnD9jpqp9WBtsvmYNldSWkxH?=
 =?us-ascii?Q?r4A1R7+CkK4Wyxmw0i7v5EGN7QiqWruT0v7AQprxGQ4k29JgXVZSkm0Rf0mv?=
 =?us-ascii?Q?nzE0v76OZvGgq5dDC+VuRpcMNZwFhgoeQGQxcuv3SEWxLQRuoUPHp5D3Npc0?=
 =?us-ascii?Q?iiX0hIyHEYLSNUkVyvZ/Epn8FlPf1C+ukC6SZQzYOeHPKbOaJjyWZ/+7U236?=
 =?us-ascii?Q?LGLkd+nXR/MCOrwPgmgI4i8Bzfhf0C8wP3N0NzYMGtpLM42jk/RGXdn82xZU?=
 =?us-ascii?Q?PshsA34OSLpS5K/h7sSN879HfyxHSWv0oyTrPBAzpjKShpNO2Jltf4LrCTdG?=
 =?us-ascii?Q?+shSYfL1VV5uMpufI+kvwEEgF3xXGwFPtD3UA/cBgeXXL4UxCSbI+U1VK4RO?=
 =?us-ascii?Q?oShjuLpTHpYT/a7W0tOOSVtThOdygRJD0+ePqXXJhwaY5uujySA1LnLwzWwk?=
 =?us-ascii?Q?xyf9a6uHLYXo0YRdtO0Bwet2NsvsQfHTljhoV+9iZWKP3LxYZ+djjAjtQ985?=
 =?us-ascii?Q?8mL6HLwVaUYRjZaUt90oNKDgq2o5P7g/BiJA2MdazuRrSSNIa9BJXkO2LUAz?=
 =?us-ascii?Q?YTv/uLVK6DabTGO2PUYO04L7PjkawiECQStoh6wHfjGjADoIVbaeHngA0ma2?=
 =?us-ascii?Q?I8KuFXcRccjIE5BGBQ0pp1obnf0Q9lNQh/LaZSXcQicpAvuwYiZvxCnY7Mm2?=
 =?us-ascii?Q?S0ZVvnsdUOjwEwhCEEoho4rGa+AD/An3zdo3/ubEofRLwRxk0lEPsILGOWcg?=
 =?us-ascii?Q?f+en+7Hdvfe1NqQIVQQfx6+1t+LC+Feg2u/x8bcxlc8N5WaLC9XDRW3KmO5q?=
 =?us-ascii?Q?ysuN3ct5cb3WIcnYjOVH7/GS3ZMdT3tywa+HLJv+1OBx/TdlRO2jIjP91GIW?=
 =?us-ascii?Q?jwdlLmGEya5huEiipcO9zl4Y5v2tdgSTX1TsSRQx9Jjt9HKzxjyLWiEBC9ap?=
 =?us-ascii?Q?GuEcchiy3McY+KlrKFtweucIGXsElsNRLEOYw+v5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4d9c95-0050-4c12-4f73-08daf393b53a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 05:21:35.2117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rq3SrHJO/pEoh6HDr1O/NfuPyGdFR5XOlcOpapJt3Enu6F+8YaTQce163XMUh/R1I/ZlofTAG8BUCxPEAn9yxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jan 10, 2023 at 06:58:15AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 10, 2023 at 08:12:49AM +0000, Zhang, Qiang1 wrote:
> >=20
> > On Mon, Jan 09, 2023 at 06:10:12PM -0800, Paul E. McKenney wrote:
> > > On Fri, Jan 06, 2023 at 02:48:56AM +0000, Zhang, Qiang1 wrote:
> > > >=20
> > > > On Thu, Dec 22, 2022 at 09:35:06AM +0000, Zhang, Qiang1 wrote:
> > > > > >On Mon, Dec 19, 2022 at 02:21:01AM +0000, Zhang, Qiang1 wrote:
> > > > > > >Greeting,
> > > > > > >FYI, we noticed WARNING:at_kernel/rcu/rcutorture.c:#rcu_tortur=
e_fwd_prog_cr[rcutorture] due to commit (built with gcc-11):
> > > > > > >
> > > > > > >commit: 572a17843591d3c03ad891492939a06833fdd17d ("[PATCH v4] =
rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug")
> > > > > > >url: https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu=
-tasks-Make-rude-RCU-Tasks-work-well-with-CPU-hotplug/20221201-074127
> > > > > > >base: https://git.kernel.org/cgit/linux/kernel/git/paulmck/lin=
ux-rcu.git dev
> > > > > > >patch link: https://lore.kernel.org/all/20221130234533.1983769=
-1-qiang1.zhang@intel.com/
> > > > > > >patch subject: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work =
well with CPU hotplug
> > > > > > >
> > > > > > >in testcase: rcutorture
> > > > > > >version:=20
> > > > > > >with following parameters:
> > > > > > >
> > > > > > >	runtime: 300s
> > > > > > >	test: cpuhotplug
> > > > > > >	torture_type: tasks-rude
> > > > > > >
> > > > > > >test-description: rcutorture is rcutorture kernel module load/=
unload test.
> > > > > > >test-url: https://www.kernel.org/doc/Documentation/RCU/torture=
.txt
> > > > > > >
> > > > > > >on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge=
 -smp 2 -m 8G
> > > > > > >
> > > > > > >caused below changes (please refer to attached dmesg/kmsg for =
entire log/backtrace):
> > > > > > >
> > > > > > >
> > > > > > >[  106.051532][  T583] rcu_torture_fwd_prog: Starting forward-=
progress test 0
> > > > > > >[  106.052085][  T583] rcu_torture_fwd_prog_cr: Starting forwa=
rd-progress test 0
> > > > > > >[  133.611262][  T583] rcu_torture_fwd_prog_cr: Waiting for CB=
s: rcu_barrier_tasks_rude+0x0/0x10() 0
> > > > > > >[  146.800051][  T583] ------------[ cut here ]------------
> > > > > > >[  146.800411][  T583] WARNING: CPU: 1 PID: 583 at kernel/rcu/=
rcutorture.c:2806 rcu_torture_fwd_prog_cr+0x22c/0x2a7 [rcutorture]
> > > > > > >[  146.801075][  T583] Modules linked in: rcutorture torture i=
pmi_msghandler crc32c_intel serio_raw processor fuse
> > > > > > >[  146.801894][  T583] CPU: 1 PID: 583 Comm: rcu_torture_fwd N=
ot tainted 6.1.0-rc1-00180-g572a17843591 #1 0cc09f902db70bae111a0c12c137296=
733dde4a9
> > > > > > >[  146.802916][  T583] Hardware name: QEMU Standard PC (i440FX=
 + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> > > > > > >[  146.803693][  T583] EIP: rcu_torture_fwd_prog_cr+0x22c/0x2a=
7 [rcutorture]
> > > > > > >[  146.804177][  T583] Code: 89 d8 e8 fc c5 ff ff e8 67 49 03 =
00 83 c4 10 84 c0 75 79 a0 96 c6 10 ef 84 c0 75 70 e8 c8 ee ff ff 84 c0 75 =
67 83 fe 63 7f 02 <0f> 0b 8b 45 f0 8b 15 40 25 8a c2 ff 75 e8 ff 75 e0 01 f=
8 2b 45 dc
> > > > > > >[  146.805599][  T583] EAX: 00000000 EBX: ecee3800 ECX: 000000=
00 EDX: 00000000
> > > > > > >[  146.805992][  T583] ESI: 00000000 EDI: 0000c350 EBP: ed9d5f=
64 ESP: ed9d5f40
> > > > > > >[  146.806491][  T583] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS:=
 0068 EFLAGS: 00010293
> > > > > > >[  146.807010][  T583] CR0: 80050033 CR2: 08082ff0 CR3: 2daaf0=
00 CR4: 000406d0
> > > > > > >[  146.807484][  T583] DR0: 00000000 DR1: 00000000 DR2: 000000=
00 DR3: 00000000
> > > > > > >[  146.808031][  T583] DR6: fffe0ff0 DR7: 00000400
> > > > > > >[  146.808384][  T583] Call Trace:
> > > > > > >[  146.808634][  T583]  rcu_torture_fwd_prog.cold+0x3b/0xee [r=
cutorture 6754ed9afe4685f50ef7fade6309181c73794538]
> > > > > > >[  146.809348][  T583]  kthread+0xc8/0xf0
> > > > > > >[  146.809635][  T583]  ? rcu_torture_fwd_prog_cbfree+0x80/0x8=
0 [rcutorture 6754ed9afe4685f50ef7fade6309181c73794538]
> > > > > > >[  146.810347][  T583]  ? kthread_complete_and_exit+0x20/0x20
> > > > > > >[  146.810734][  T583]  ret_from_fork+0x1c/0x28
> > > > > > >[  146.811075][  T583] irq event stamp: 205883
> > > > > > >[  146.811400][  T583] hardirqs last  enabled at (205891): [<c=
114bb06>] __up_console_sem+0x66/0x80
> > > > > > >[  146.811960][  T583] hardirqs last disabled at (205898): [<c=
114baed>] __up_console_sem+0x4d/0x80
> > > > > > >[  146.812583][  T583] softirqs last  enabled at (205880): [<c=
1ecb40b>] __do_softirq+0x2bb/0x440
> > > > > > >[  146.813079][  T583] softirqs last disabled at (205871): [<c=
10845f0>] call_on_stack+0x40/0x50
> > > > > > >[  146.813567][  T583] ---[ end trace 0000000000000000 ]---
> > > > > > >[  146.813926][  T583] rcu_torture_fwd_prog_cr Duration 2411 b=
arrier: 3960 pending 50000 n_launders: 0 n_launders_sa: 0 n_max_gps: 0 n_ma=
x_cbs: 50000 cver 1 gps 0
> > > > > > >[  147.914266][  T583] rcu_torture_fwd_cb_hist: Callback-invoc=
ation histogram 0 (duration 6702 jiffies): 1s/10: 0:0 2s/10:=20
> > > > > > >[  149.453780][  T557] ------------[ cut here ]------------
> > > > > > >[  149.454322][  T557] rcu_torture_writer: rtort_pipe_count: 4
> > > > > > >[  149.454817][  T557] WARNING: CPU: 1 PID: 557 at kernel/rcu/=
rcutorture.c:1583 rcu_torture_writer+0x71d/0xc80 [rcutorture]
> > > > > >=20
> > > > > >=20
> > > > > > This is not a bug.  this is caused by grace period taking too l=
ong time, the previous callback
> > > > > > has not been completed.  from the dmesg, can be found that the =
cpuhotplug test is being
> > > > > > performed periodically, this may cause the rude RCU-Tasks  grac=
e period to take more time,
> > > > > > due to we need to acquire the cpus_read_lock, and the CPU0 alwa=
ys bootup failed, that is to
> > > > > > say, only one CPU of your system is online at this time.
> > > > > >
> > > > > >Onlining of a CPU failing with EIO is a new one on me.  Especial=
ly
> > > > > >persistent failure.
> > > > >=20
> > > > > I use the kernel configuration file in the attachment and  base o=
n:
> > > > > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.gi=
t dev
> > > > >=20
> > > > > use "echo 1 > /sys/devices/system/cpu/cpu0/online" can reproduce =
this problem,
> > > > > the CPU0 always fails to go online. =20
> > > > >=20
> > > > > Debug found CPU0 is always not set in cpu_initialized_mask.
> > > > > causes the do_boot_cpu() to return -1.
> > > > >=20
> > > > > do_boot_cpu()
> > > > >      wakeup_cpu_via_init_nmi();
> > > > >      if (!boot_error) {
> > > > >                 /*
> > > > >                  * Wait 10s total for first sign of life from AP
> > > > >                  */
> > > > >                 boot_error =3D -1;
> > > > >                 timeout =3D jiffies + 10*HZ;
> > > > >                 while (time_before(jiffies, timeout)) {
> > > > >                         if (cpumask_test_cpu(cpu, cpu_initialized=
_mask)) {
> > > > >                                 /*
> > > > >                                  * Tell AP to proceed with initia=
lization
> > > > >                                  */
> > > > >                                 cpumask_set_cpu(cpu, cpu_callout_=
mask);
> > > > >                                 boot_error =3D 0;
> > > > >                                 break;
> > > > >                         }
> > > > >                         schedule();
> > > > >                 }
> > > > >         }
> > > > >=20
> > > > > This looks related to this modification e1c467e69040c("x86, hotpl=
ug:=20
> > > > > Wake up CPU0 via NMI instead of INIT, SIPI, SIPI ").
> > > > >=20
> > > > >=20
> > > > > The following modification can make CPU0 go online successfully(T=
his
> > > > > is just a test, not sure if there are other effects).
> > > > >
> > > > >
> > > > >Thank you for tracking this down!!!
> > > > >
> > > > >Huh.  CPU 0 is normally the boot CPU.  Back in the day, it could n=
ot
> > > > >be offlined.  Given that your testing indicates that CPU 0 can now=
 be
> > > > >taken offline, maybe this "if" statement is a holdover that someon=
e
> > > > >forgot to remove?
> > > > >
> > > > >But I must defer to those who know a lot more about this level of
> > > > >x86 code than I do.
> > > >=20
> > > > I found relevant modification information, maybe it will be of some=
 help
> > > >=20
> > > > commit e1c467e69040c3be68959332959c07fb3d818e87
> > > > Author: Fenghua Yu <fenghua.yu@intel.com>
> > > > Date:   Wed Nov 14 04:36:53 2012 -0800
> > > >=20
> > > >     x86, hotplug: Wake up CPU0 via NMI instead of INIT, SIPI, SIPI
> > > >=20
> > > >     Instead of waiting for STARTUP after INITs, BSP will execute th=
e BIOS boot-strap
> > > >     code which is not a desired behavior for waking up BSP. To avoi=
d the boot-strap
> > > >     code, wake up CPU0 by NMI instead.
> > > >=20
> > > >     This works to wake up soft offlined CPU0 only. If CPU0 is hard =
offlined (i.e.
> > > >     physically hot removed and then hot added), NMI won't wake it u=
p. We'll change
> > > >     this code in the future to wake up hard offlined CPU0 if real p=
latform and
> > > >     request are available.
> > > >=20
> > > >     AP is still waken up as before by INIT, SIPI, SIPI sequence.
> > > >=20
> > > >     Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > > >     Link: http://lkml.kernel.org/r/1352896613-25957-1-git-send-emai=
l-fenghua.yu@intel.com
> > > >     Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
> > >=20
> > > Interesting!
> > >=20
> > > When I run rcutorture on x86 (under qemu/KVM), it refuses to attempt =
to
> > > offline CPU 0.  The reason is that cpu_is_hotpluggable(0) returns fal=
se.
> > >=20
> > > If I comment out that check, I get this:
> > >=20
> > > 	rcu-torture:torture_onoff task: offline 0 failed: errno -1
> > >=20
> > > A bit of digging turned up the CONFIG_BOOTPARAM_HOTPLUG_CPU0 Kconfig
> > > option.  Setting that causes CPU 0 to be offlined.
> > >=20
> > > I clearly need to add this to one of the scenarios.  I arbitrarily
> > > chose TREE01, but please let me know if some other scenario or
> > > group of scenarios would be better.
> > >
> > >For example, like this.
> >=20
> > This looks good, whether all TREE* can be added ?=20
> > (after all, this just makes CPU0 support offline, but the actual CPU go=
ing=20
> > offline/online also depends on "onoff_interval").
>=20
> You can use the kvm.sh --kconfig parameter to make this happen in your
> own testing.  Or you can hand-edit the TREE* files.  The kvm.sh script
> sets onoff_interval for you, so that should be OK.  If you are testing
> using modprobe, then yes, you need to set up this in your kernel build
> and using the modprobe arguments.
>=20
> It looks like x86 kernels build with CONFIG_BOOTPARAM_HOTPLUG_CPU0=3Dn,
> mostly, anyway, so most of the by-default rcutorture testing should also
> build this way.
>=20
> But again, you have a couple of ways to override this in your own testing=
.
>
>And I cannot reproduce the CPU-hotplug online error under qemu/KVM.
>Which might be expected behavior, given that you ran your tests using
>specific qemu arguments that kvm.sh does not provide.

Hi Paul

After I enable the following options, CPU0 goes online successfully.
if the following options are disabled, CPU0 fails to go online.
(CONFIG_BOOTPARAM_HOTPLUG_CPU0 always enabled)

CONFIG_X86_X2APIC =3D y
CONFIG_X86_NUMACHIP =3D y
CONFIG_X86_UV =3D y

Thanks
Zqiang

>
>Nevertheless, CPU 0 really does go through the "Wake up BSP by nmi"
>portion of wakeup_cpu_via_init_nmi() at runtime, and this works fine.
>On the other hand, it also works fine if I comment out that "if (cpu)"
>check.
>
>This sounds like a question for your colleagues at Intel.  ;-)
>
>							Thanx, Paul
