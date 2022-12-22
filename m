Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F224653D84
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbiLVJfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiLVJfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:35:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3695264A0;
        Thu, 22 Dec 2022 01:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671701711; x=1703237711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tp27g+i44u4yLnZ3/OaBz9U9xjUqFOjVtFV6aywwE5I=;
  b=kRtbPMAZdKe1SMRKgZKeIx5+AfjjwF6/3diI/gnETIOvJkDcOfYcakXq
   8pwE/TvvlLhxOBgmHn9g3mjx/2/5Qo21x4pruQyLjqJGScNN0xzNSQiKb
   1f9doMueMIlI8+XwwNFwIX7FoW86TZo8mLDX0+wEVn2QzWL7jOapOS52G
   dFUXs9KwcHk0qPhoxMoMqtHTfTMNFUhvErv+oI2+2bgc+l/3JO+OnjGRi
   kUkW0GPANs24lBPZ8lNIW/+OsAqBt+g9K6d0vhDc8r+/FjzCuSZIFBdfy
   3OdG3MP2A5rFGfXwbcZOjqMFWjNQZa3LNGI1NHUAb9a+oPciI2FoQUQ+H
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="347228090"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="347228090"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 01:35:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="825919012"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="825919012"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 22 Dec 2022 01:35:10 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 22 Dec 2022 01:35:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 22 Dec 2022 01:35:10 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 22 Dec 2022 01:35:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+rTva91inOrLQkL9yipOHuEjX3+dMcu9eUBWxutpcty1iwzxVKg1fcbv3mGjsi/mmwYapEFfHWbwLVVrIH0yhvLIQTcuRgwAhbKKdEdN7YZlAgjBhb+0MR2MpBtlokwSEComtsxdxhhyf66KgkQl1SXPvuCk2aukNzZ4NDLMBGhOkUFc3sLVSltrYBLv0RExGEOLJBGiFLaA8ySqbSHfYT2XKdC0kHisVg0LxoekgDo4uL+aKyl9RlUXN1yzeL/pBGBfPXifwgabSLND7X7bZRmXnOIioPnIQtGR2WttkO+N+yH9UqOlNk0sf4SVO4SNquRoUe+3aJKREADdRcXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRp2RLSPYCdajZrCS+KvpVoZbqyXbKv01FX9bsBSmTQ=;
 b=mPpIkeUwgNvJ30RkQARpVPoKT65hiW2lx+WRsJ/V2wlVaoGNv+aV9LpxuKJiXMjWnGmvwG+PM5GViuP5AooxMyvxxd++8/bOGh/WkvNcWWFvY2RTqCgcWNhMHO6yCdrSYE/R6uEtaaxbvXty2I0N7i7vupw0mEJqlwq6nIcKIpkELROf1zvzfM8if1EzxTP82J4HgvOTQ//bvOC/eXInEOXvnzB0nQahcELOb8fo5sfmPf8nFtqvh0M4h4AM0MPRa9/pG6kRkzznX55ABnWuO4WicYA23XnGYT6oEnzURX5iCAm5AIerOpTLMRYCnfMUbR5XjfjMCcixqGnRFf5EpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SN7PR11MB7042.namprd11.prod.outlook.com (2603:10b6:806:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 09:35:07 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%6]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 09:35:07 +0000
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
Thread-Index: AQHZBRUNYM7gGe8KaECV+8uqpx3Q8a50ePYAgAAL4hCABFctgIAA5ZxA
Date:   Thu, 22 Dec 2022 09:35:06 +0000
Message-ID: <PH0PR11MB588092AB6A014F30420D697CDAE89@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221130234533.1983769-1-qiang1.zhang@intel.com>
 <202212181914.f5a305f3-yujie.liu@intel.com>
 <PH0PR11MB5880EB31D9AFD82EFA3073A6DAE59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221221193325.GE4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221221193325.GE4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SN7PR11MB7042:EE_
x-ms-office365-filtering-correlation-id: a5ac8c20-74bd-4d39-0e53-08dae3ffcfdc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1o2DS6iDUicyCgClZ0Iat0okK8xA4JSFHrKvOgW/YuwE1OkYrABHY8TLYLTSwFmcbZvyw+yOhgh88CLJoYIQaN923Vc+L3LrNoQiuFhBFskz6zSNbK69g4Rvdv2W7hdW/LY1pe/3bcgn0HMoK6JNXUCwSgDxU7f5RhNi4/FYsocxqMwhpf2HNLwwiVypYUlo+cf+jhIBEsV+P6IMPNSkKozEnn402nHmXj2XAGMp8B1BY7BntNIYcFeOif1De03DiLRzvOjI+oR1q4DZXtwhMUsnA6TZoA1+EZLSAYMJf2/JRkX0hiVu7NqK2HPBpgHLRMpCXeS4JQzqKb2bntR5dcsz8njs5sRlM++/gCaQakwu5iLPMzL9ngUX07DHiOAhmrw8s+aoEcwYtUXiIuLpkV6OJJkLIiTbrcjvFe8cS+glb40RGevKOXWuCyiTVCbG/b0jIqneBlFqUpPyLRDyoNlqSsJ7HrUzmhnCRjs30pBnFFHullyixzBHztw/WfKsesdmQDsk7Cwik2j0tmlFn/gIau1xY5HG2Q+pAuB/gVDgW+VLXKiaYQo6VIghjyo2zyF0o6iavpmFaA7VhFWrXn9UrYlYkfN+n6YG5eT22tECCOSKZP/BB+e5rYgU7uQIq0dKAazDWUoXF2xiyr+HVlzgD3jhRkELYvS66X4J0PNxnOidk5ZYkMzUGM6BxxpAiIBpyyLgKJn6hvYVX7nHa5dbvhSIeSW98J0PG5XYla2K995kF/C63SNMkRvsCiZrGrNE41aSVP2slUtQskg0Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199015)(966005)(478600001)(8936002)(6506007)(71200400001)(38070700005)(45080400002)(26005)(9686003)(86362001)(7696005)(66946007)(33656002)(186003)(66476007)(64756008)(316002)(8676002)(66556008)(76116006)(66446008)(54906003)(6916009)(82960400001)(41300700001)(52536014)(122000001)(4326008)(83380400001)(38100700002)(2906002)(55016003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s1muFqAJYAZGHgRDOypxq7Gsl6oFAipqPNBHWwPl/US79J3d48Gzk/b8Sigm?=
 =?us-ascii?Q?a0as5mA0uLZGEADlvHIkbuAt9l1BzXsKmxCqQFtTUO3x2pwTjNQyrXT2nz6C?=
 =?us-ascii?Q?OLs80FA1llCMN5Hq+ycFVXu6IVDX4oTG0x8kgdI18LNDN3xpAMzEpbrhk+7r?=
 =?us-ascii?Q?WqVEUMAOZkdhcBLUzqWA4B54c+xSwOyH9tPhjVg9d9xNvd7hiuKF9cCC5RmY?=
 =?us-ascii?Q?uHoMNnH26UY7cRRYGhfBEp7lwxPtZ2xPK2dsV8UYK6ZpR73Vp0Vx2BCjZZNG?=
 =?us-ascii?Q?lWvrNB+v9PgZR4zGjhlhxu9J5UvBNr3nd/9rRZY98/a9tN411FumSwKdlkpv?=
 =?us-ascii?Q?lynNxmg7jWvCvfuAkB8ZaBg8G6UOsTPWg7nCu5Zd7+/r0kL1fD9XgONOvd01?=
 =?us-ascii?Q?b72I4sfkB+J7n+Gozz6+1vonUOy15ItfB19Wf7SUAcABQVBeQmciXhtW3v01?=
 =?us-ascii?Q?EFJSWhXE9+9QLiD6VoB2B4dTyHdvz1dXUjpPbwj5NxBu5h+O90n2CVffwCsc?=
 =?us-ascii?Q?H9th5cE8VGEAgL2ggqllY0Ra2A9xxTSpt5Mwyw4yjiIZDq1zc7aTtLVGFFJo?=
 =?us-ascii?Q?SPPBF43NwxiYswC7TZx2TpAz0GIs+g6Vspu1GmjIDBYbchZaufyhaDMttxdP?=
 =?us-ascii?Q?ufcH6pAkQiZ/xJ3xLI+zHsoOLR2VvLFgaEi9IyJAtIMl7Uzmu1J5jeppKbDj?=
 =?us-ascii?Q?Epe9mm+w0CwZJbmUJTxDA1pQ2Bh94PbSAqI1Ub0y2pEyY8bb1hq8jOSUGUFx?=
 =?us-ascii?Q?OMQVhIn3vU0bNI6154N4jDbzR7dtuUM34JtYnZv1rAKB2cCehsMOOKIEse1w?=
 =?us-ascii?Q?6RiLgW6oolOIcsrjAjSfZJi6KA1IHFoe5BZ/VMAo7K0UPjlAbi2Hb5I8brCp?=
 =?us-ascii?Q?/xnRrLVX6RNSlyBaMuNXsRVsTDmHneqTl7/1phxG/PyWTzG8sq/nSl/jJAgz?=
 =?us-ascii?Q?ldSVimduCqZf6Pn02IH5DcPMM/BVjIiLucg665RLsfXikNa/xjkGEuMfGyjS?=
 =?us-ascii?Q?QU4pids7n9x3EunuWzZ6CBMGsH3HOeK5gIh180knzevoAi7kvPanPnPLx9fR?=
 =?us-ascii?Q?U6TATlooRwfTl6Gllt+F2TjyQIsyLiayCpid+XWZeCgT3mKPuNGNVhR8N27W?=
 =?us-ascii?Q?4XYJ2Sqgrrd7ZdqJILgufS0tzdzeEymGVRQ6fC/qVgViUWxkDroxi3UVnaRW?=
 =?us-ascii?Q?c46WKcxmJZXm3vON+4GEkhdDGYb+IVAqG3u+9FOZB0Gcy3mt/FRqV/JRMn+u?=
 =?us-ascii?Q?I7xgCihFXBWkVH6EoMJwFOoyFQJb+ES/MhK4evA5GtSYyRoguqAXRcLrGblB?=
 =?us-ascii?Q?QBP0EdZutrFVuYCVcwreJaD0pZgHZXi6XBy/ArTY8ue3dicsGwIZvyAXLLjw?=
 =?us-ascii?Q?rWReOlde0Y3bHaPGudXaVEGXfZwH68EXThOuFz5ePkUz3brdayBzDeOzlgJC?=
 =?us-ascii?Q?kFHMcUiwg9q4xVnH4v/swRvgzzVYR7WoJaBYBcv/4AVe+VgHWZnKk5a7/jaB?=
 =?us-ascii?Q?YE6IHt+/QRDDhWQglc4AMcp4eRXAXkg2qnDEJGGNqL+6OBdjcOPpAx2iCNge?=
 =?us-ascii?Q?JOCFfKRnLOIqBjZLHuoEHXrI8V/ZslZ42qQ8m3m5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ac8c20-74bd-4d39-0e53-08dae3ffcfdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 09:35:06.9661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/SwK+nn7P5SYzSN1dNw9RAAbh1Lb9L8BguvCgbY9q4VLk7tPWujAZ193TQJh+WKTJAwREfKAW/CCeC8DQNcBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7042
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, Dec 19, 2022 at 02:21:01AM +0000, Zhang, Qiang1 wrote:
> >Greeting,
> >FYI, we noticed WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog=
_cr[rcutorture] due to commit (built with gcc-11):
> >
> >commit: 572a17843591d3c03ad891492939a06833fdd17d ("[PATCH v4] rcu-tasks:=
 Make rude RCU-Tasks work well with CPU hotplug")
> >url: https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-tasks-Mak=
e-rude-RCU-Tasks-work-well-with-CPU-hotplug/20221201-074127
> >base: https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git=
 dev
> >patch link: https://lore.kernel.org/all/20221130234533.1983769-1-qiang1.=
zhang@intel.com/
> >patch subject: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with =
CPU hotplug
> >
> >in testcase: rcutorture
> >version:=20
> >with following parameters:
> >
> >	runtime: 300s
> >	test: cpuhotplug
> >	torture_type: tasks-rude
> >
> >test-description: rcutorture is rcutorture kernel module load/unload tes=
t.
> >test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> >
> >on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m=
 8G
> >
> >caused below changes (please refer to attached dmesg/kmsg for entire log=
/backtrace):
> >
> >
> >[  106.051532][  T583] rcu_torture_fwd_prog: Starting forward-progress t=
est 0
> >[  106.052085][  T583] rcu_torture_fwd_prog_cr: Starting forward-progres=
s test 0
> >[  133.611262][  T583] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_bar=
rier_tasks_rude+0x0/0x10() 0
> >[  146.800051][  T583] ------------[ cut here ]------------
> >[  146.800411][  T583] WARNING: CPU: 1 PID: 583 at kernel/rcu/rcutorture=
.c:2806 rcu_torture_fwd_prog_cr+0x22c/0x2a7 [rcutorture]
> >[  146.801075][  T583] Modules linked in: rcutorture torture ipmi_msghan=
dler crc32c_intel serio_raw processor fuse
> >[  146.801894][  T583] CPU: 1 PID: 583 Comm: rcu_torture_fwd Not tainted=
 6.1.0-rc1-00180-g572a17843591 #1 0cc09f902db70bae111a0c12c137296733dde4a9
> >[  146.802916][  T583] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> >[  146.803693][  T583] EIP: rcu_torture_fwd_prog_cr+0x22c/0x2a7 [rcutort=
ure]
> >[  146.804177][  T583] Code: 89 d8 e8 fc c5 ff ff e8 67 49 03 00 83 c4 1=
0 84 c0 75 79 a0 96 c6 10 ef 84 c0 75 70 e8 c8 ee ff ff 84 c0 75 67 83 fe 6=
3 7f 02 <0f> 0b 8b 45 f0 8b 15 40 25 8a c2 ff 75 e8 ff 75 e0 01 f8 2b 45 dc
> >[  146.805599][  T583] EAX: 00000000 EBX: ecee3800 ECX: 00000000 EDX: 00=
000000
> >[  146.805992][  T583] ESI: 00000000 EDI: 0000c350 EBP: ed9d5f64 ESP: ed=
9d5f40
> >[  146.806491][  T583] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLA=
GS: 00010293
> >[  146.807010][  T583] CR0: 80050033 CR2: 08082ff0 CR3: 2daaf000 CR4: 00=
0406d0
> >[  146.807484][  T583] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00=
000000
> >[  146.808031][  T583] DR6: fffe0ff0 DR7: 00000400
> >[  146.808384][  T583] Call Trace:
> >[  146.808634][  T583]  rcu_torture_fwd_prog.cold+0x3b/0xee [rcutorture =
6754ed9afe4685f50ef7fade6309181c73794538]
> >[  146.809348][  T583]  kthread+0xc8/0xf0
> >[  146.809635][  T583]  ? rcu_torture_fwd_prog_cbfree+0x80/0x80 [rcutort=
ure 6754ed9afe4685f50ef7fade6309181c73794538]
> >[  146.810347][  T583]  ? kthread_complete_and_exit+0x20/0x20
> >[  146.810734][  T583]  ret_from_fork+0x1c/0x28
> >[  146.811075][  T583] irq event stamp: 205883
> >[  146.811400][  T583] hardirqs last  enabled at (205891): [<c114bb06>] =
__up_console_sem+0x66/0x80
> >[  146.811960][  T583] hardirqs last disabled at (205898): [<c114baed>] =
__up_console_sem+0x4d/0x80
> >[  146.812583][  T583] softirqs last  enabled at (205880): [<c1ecb40b>] =
__do_softirq+0x2bb/0x440
> >[  146.813079][  T583] softirqs last disabled at (205871): [<c10845f0>] =
call_on_stack+0x40/0x50
> >[  146.813567][  T583] ---[ end trace 0000000000000000 ]---
> >[  146.813926][  T583] rcu_torture_fwd_prog_cr Duration 2411 barrier: 39=
60 pending 50000 n_launders: 0 n_launders_sa: 0 n_max_gps: 0 n_max_cbs: 500=
00 cver 1 gps 0
> >[  147.914266][  T583] rcu_torture_fwd_cb_hist: Callback-invocation hist=
ogram 0 (duration 6702 jiffies): 1s/10: 0:0 2s/10:=20
> >[  149.453780][  T557] ------------[ cut here ]------------
> >[  149.454322][  T557] rcu_torture_writer: rtort_pipe_count: 4
> >[  149.454817][  T557] WARNING: CPU: 1 PID: 557 at kernel/rcu/rcutorture=
.c:1583 rcu_torture_writer+0x71d/0xc80 [rcutorture]
>=20
>=20
> This is not a bug.  this is caused by grace period taking too long time, =
the previous callback
> has not been completed.  from the dmesg, can be found that the cpuhotplug=
 test is being
> performed periodically, this may cause the rude RCU-Tasks  grace period t=
o take more time,
> due to we need to acquire the cpus_read_lock, and the CPU0 always bootup =
failed, that is to
> say, only one CPU of your system is online at this time.
>
>Onlining of a CPU failing with EIO is a new one on me.  Especially
>persistent failure.

I use the kernel configuration file in the attachment and  base on:
https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev

use "echo 1 > /sys/devices/system/cpu/cpu0/online" can reproduce this probl=
em,
the CPU0 always fails to go online. =20

Debug found CPU0 is always not set in cpu_initialized_mask.
causes the do_boot_cpu() to return -1.

do_boot_cpu()
     wakeup_cpu_via_init_nmi();
     if (!boot_error) {
                /*
                 * Wait 10s total for first sign of life from AP
                 */
                boot_error =3D -1;
                timeout =3D jiffies + 10*HZ;
                while (time_before(jiffies, timeout)) {
                        if (cpumask_test_cpu(cpu, cpu_initialized_mask)) {
                                /*
                                 * Tell AP to proceed with initialization
                                 */
                                cpumask_set_cpu(cpu, cpu_callout_mask);
                                boot_error =3D 0;
                                break;
                        }
                        schedule();
                }
        }

This looks related to this modification e1c467e69040c("x86, hotplug:=20
Wake up CPU0 via NMI instead of INIT, SIPI, SIPI ").


The following modification can make CPU0 go online successfully(This
is just a test, not sure if there are other effects).

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3f3ea0287f69..26ee9cdf639e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1013,10 +1013,10 @@ wakeup_cpu_via_init_nmi(int cpu, unsigned long star=
t_ip, int apicid,
        /*
         * Wake up AP by INIT, INIT, STARTUP sequence.
         */
-       if (cpu) {
+//     if (cpu) {
                boot_error =3D wakeup_secondary_cpu_via_init(apicid, start_=
ip);
                goto out;
-       }
+//     }

        /*
         * Wake up BSP by nmi.


Thanks
Zqiang

>
>							Thanx, Paul
>
> Thanks
> Zqiang
>=20
> >[  149.455687][  T557] Modules linked in: rcutorture torture ipmi_msghan=
dler crc32c_intel serio_raw processor fuse
> >[  149.456490][  T557] CPU: 1 PID: 557 Comm: rcu_torture_wri Tainted: G =
       W          6.1.0-rc1-00180-g572a17843591 #1 0cc09f902db70bae111a0c12=
c137296733dde4a9
> >[  149.457660][  T557] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> >[  149.458484][  T557] EIP: rcu_torture_writer+0x71d/0xc80 [rcutorture]
> >[  149.458990][  T557] Code: 05 00 00 8d 43 f4 39 c6 74 c3 e8 0e a0 0b d=
2 83 ff 63 0f 87 3d 05 00 00 ff 73 fc 68 88 a0 10 ef 68 f4 9a 10 ef e8 10 0=
1 d2 d2 <0f> 0b a1 30 c6 10 ef 83 c4 0c 85 c0 75 95 b8 01 00 00 00 87 05 30
> >[  149.460472][  T557] EAX: 00000027 EBX: ef10d630 ECX: e49c0f28 EDX: e4=
9c0f24
> >[  149.461022][  T557] ESI: ef10d694 EDI: 0000004f EBP: ece35f8c ESP: ec=
e35f18
> >[  149.461539][  T557] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLA=
GS: 00010292
> >[  149.462101][  T557] CR0: 80050033 CR2: 08082ff0 CR3: 2daaf000 CR4: 00=
0406d0
> >[  149.462642][  T557] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00=
000000
> >[  149.463172][  T557] DR6: fffe0ff0 DR7: 00000400
> >[  149.463526][  T557] Call Trace:
> >[  149.463795][  T557]  ? lockdep_hardirqs_on_prepare+0xa4/0x160
> >[  149.464333][  T557]  ? _raw_spin_unlock_irqrestore+0x45/0x60
> >[  149.464795][  T557]  ? trace_hardirqs_on+0x35/0xe0
> >[  149.465191][  T557]  kthread+0xc8/0xf0
> >[  149.465506][  T557]  ? rcu_torture_pipe_update+0x130/0x130 [rcutortur=
e 6754ed9afe4685f50ef7fade6309181c73794538]
> >[  149.466327][  T557]  ? kthread_complete_and_exit+0x20/0x20
> >[  149.466771][  T557]  ret_from_fork+0x1c/0x28
> >[  149.467136][  T557] irq event stamp: 45753
> >[  149.467457][  T557] hardirqs last  enabled at (45761): [<c114bb06>] _=
_up_console_sem+0x66/0x80
> >[  149.468145][  T557] hardirqs last disabled at (45770): [<c114baed>] _=
_up_console_sem+0x4d/0x80
> >[  149.468803][  T557] softirqs last  enabled at (41056): [<ef1037a0>] r=
cu_torture_pipe_update+0xe0/0x130 [rcutorture]
> >[  149.469602][  T557] softirqs last disabled at (41054): [<ef10377c>] r=
cu_torture_pipe_update+0xbc/0x130 [rcutorture]
> >[  149.470401][  T557] ---[ end trace 0000000000000000 ]---
>=20
