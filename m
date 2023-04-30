Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFB06F27D6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 08:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjD3Gij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 02:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjD3Gih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 02:38:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92D8E6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 23:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682836715; x=1714372715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SjkKuUhKShe/lxQs6VKTFj9o6gvXEH5I+SSusxzdvzI=;
  b=N90SpDYeF7ZdgF02YTV3O2Vr1seILdt3ym8TN80iOJKb65yIIKUMPIWR
   nZ8RZTnL0K+gGR1UY1NdwHiC2Xzz9sl/v89+Gd91dZpuyP31F8C0TDzkM
   TYRhZlCvB7Z53X6AyH1LwBdnaaE6Eesgw6ZQw6LdKM7QMRoTjTuhae9Ox
   4CE17btJDIexrIx6NQBN3oIoLZhHm46zxg65561ivsMPIs0aiAH2yeDi8
   rulQ0S+KjUWb/ouDr229JFN32N0C00rUu10Tq92tI3rRcG1NPNs3e4JLG
   Qf9R+K60lA7e0vDm5e6SvK0dyUKzaG/5tQiP3j4lqwWRJ7C06zSHaJi1l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="411117910"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="411117910"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 23:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="819626994"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="819626994"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2023 23:38:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 29 Apr 2023 23:38:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 29 Apr 2023 23:38:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 29 Apr 2023 23:38:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmfjdCpSuotk/9lfOSEaJB/FooPPdan1kqWT6gou02L/8BuwfZiu4UbAMnpTV5APSUDrDvDvorUI4HZYjCnV20yMOWCVlDhf5eyr7AHo39RtmKO9GdYuYkvag86lmvjET0B8FDi04MJOxikCy2jKkaxUmaljBLJi2CB1hX+/mbY40XjqdCuYHktvOcx+bszM92ORX6YV/6fMRqwC0+IRU7gj0wZdc4M7CWJ+ZprpyBfM2vI6SE8L7fBxkFBOzZ6wSOatZ9TlKKgFkp6Q6fmVPjjVTGqLcwUEXuvgjz+1hSjBS9Gyik7uzyvasiOcyAD6OOa8VHeG8kOeMxVAuqGQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVASXXduQDWrVJelws67G23SO5Gi6skOtCmnhsGfVqI=;
 b=Lo4Lyzbvtwb352k6E2ochxtVTmBLUChq/AtG27bNArh0VsJ/u3Y2YR4ou6uyB+GTgbwb/eed0TggEvTzWAPiHaN7OhmfRDqGAAYgt+2/MufEsF0HFooxzrKiUk30UJtudE3IaAE/L4yYvrzEA2cERaH0X7973z8ET749uw9xP3PL1CzbgaNteX4QzevWGRmlL7hqDKRHhoBAfJ57wijuEAI0UGjoqE0sUM7UiYwiF02QgEyF7kFIL606MygavpQyLMhZ0POpkiqk8jYBXKKwPyJ/ul6kqEc3ftUY8xdnCQl8L7DqKd5mufaL/czqSLGYmdwT3QkBjQEIlv2g6yVyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by SJ0PR11MB5648.namprd11.prod.outlook.com (2603:10b6:a03:302::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28; Sun, 30 Apr
 2023 06:38:28 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::377f:416d:7be1:8f9a]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::377f:416d:7be1:8f9a%4]) with mapi id 15.20.6340.026; Sun, 30 Apr 2023
 06:38:28 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Adam Borowski <kilobyte@angband.pl>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: RE: [PATCH] mei: make hdcp and pxp depend on X86 && PCI
Thread-Topic: [PATCH] mei: make hdcp and pxp depend on X86 && PCI
Thread-Index: AQHZderH+wsq6lIxj02Y7iezAU/Pd687czNQgAB5swCAAB4tAIAAHfEAgABrM4CAAVOV8IACVwiAgAJJtZA=
Date:   Sun, 30 Apr 2023 06:38:27 +0000
Message-ID: <MN2PR11MB40930E6A1A2029BBB19B51D7E5699@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20230423135124.55196-1-kilobyte@angband.pl>
 <MN2PR11MB409305D13E46C371321AC2F0E5649@MN2PR11MB4093.namprd11.prod.outlook.com>
 <20230425115210.GA4151911@angband.pl>
 <2023042502-resolute-divisible-fbff@gregkh>
 <20230425152720.GA4155584@angband.pl>
 <a8840c41-6245-4531-8b23-5c4e594c1ca9@app.fastmail.com>
 <MN2PR11MB4093C51F94BC3CDDC1F34968E5659@MN2PR11MB4093.namprd11.prod.outlook.com>
 <688fe177-5f00-4434-ba08-2348a8e5ee15@app.fastmail.com>
In-Reply-To: <688fe177-5f00-4434-ba08-2348a8e5ee15@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|SJ0PR11MB5648:EE_
x-ms-office365-filtering-correlation-id: f8593a86-db74-4837-a858-08db494581a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X/d+MCBSNGTdwD1b9kwV0oj7QyP1js4L+DxYupKzn27Am3pu0k8n8Vxn5UhPZ7oPV6Yb5RPq+jE5Vkv24yHs4lxM2ArEF4GJHL314eBev5UiRxf+JK/2dNShciEtrZlhDlj6VWtyuiTPv9CgusNJD8PMTIuwDPHQ9m3C8MSaA2rKUMGnWGIbtvr+m66Zt0wq9TblSey0LBPyKzU8KBBEvKDtG/5DvVeeEk6OWGKVuZoo+w9VSCp9WTnnZfa84a8aLepfkIsvs7w9cQGsfyOtdWwHwYFQGt3X6wt57/COqFm6Bug14dYVI5VPqhiaIA+/qNfZAcyK7Ry9W5H3tZ7NH9RgXbxI0TjD3NfC8MrH+yA/2DQsm+eS/3Oqc0hk2jhPixEW4Ax61Qna6loThcjjY2kapHQ5nxAw2Y8MTKO/i4ntoUm9FsqmjPDbNB49LFD6arT12YCJnr8b6io4zlOWiLH6NfI/CcH7JHWnlkedFEqPFwZA6Dhp3F5D+1ozhWUBPxWu5QetYIM/Bx9n5q9R4esrSlr/bwpmb7XJZc41+u/+kEfCQSFSjH0pkgLbFU1xHqYRNEWbPTrLqMO/trQAFshyD71BMhZhpBu3swnx+c9DC2ayK6rbL/Vlk/wP48eC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(33656002)(86362001)(38070700005)(82960400001)(122000001)(38100700002)(5660300002)(52536014)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(76116006)(8936002)(8676002)(316002)(41300700001)(55016003)(2906002)(83380400001)(71200400001)(7696005)(110136005)(54906003)(478600001)(9686003)(6506007)(26005)(186003)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?09hUKLXpa4fxe2eXJuitTZ9EL/ORf6NVWuw9cijoaxOylbXxzOLIgYJe2Biq?=
 =?us-ascii?Q?y9hSSscIr+jsNnF9H18q4M/l2Xi7RVFvnQMo9R+YpRSGc8tCAwoIEzoDhvKt?=
 =?us-ascii?Q?L4RubGs8Q/AtLdBcMz9gn82DvRfG4ykCNVhe1p1KTkdNAV/HMdtU0aECb6BD?=
 =?us-ascii?Q?wdudJ7jgYvhfVM6Nz8FkpjYu0Oa0JgnmEl+nAYM1BNF0XZ4BEI7GIHBSIcnT?=
 =?us-ascii?Q?aQge1lSPljArixONAWsB03lPp1Q/IZuPtAawyDYEnBfK2VCA8QfxD3CTZdla?=
 =?us-ascii?Q?+VXsmH5QEGBZctbqeWPW4H+sNyGEVLqMPHBw4BDxaVTG1vUQC9P3W3M5jg4A?=
 =?us-ascii?Q?hk3p2K+7bJ6VA2pBDPs38eFI8p+7RVs8O6e87TPsayJU1vhi9/0vzFavYIdS?=
 =?us-ascii?Q?PjgbxsinNoZQilnwjjqTLEljecmu2wHQwiCWYts25U7i52NvjkMRnFOXjn3R?=
 =?us-ascii?Q?JSDVmE/NKkP2gLI432GBccXftJrGvBTPlHNYmOy5QyT3aP04QUYO2E+fnoUI?=
 =?us-ascii?Q?uIyi8az2LWQIoLVTtbIdnfQmghI/UmEMYAhkqbvtduUbjeLn0UoLm61inuYy?=
 =?us-ascii?Q?djwqgocWEU8ds7abT0Kp6b6jcrfeiwcdV3TTo4pzLFR8KfLVO36kS3In+r/T?=
 =?us-ascii?Q?4B2MbSt+Uzk8cXByFT6jsw3VmBaEKOKpxXIbe1/W7YuOLJB6BgQVqaNXiY8I?=
 =?us-ascii?Q?cdIryT+tLK4O0lADKuZcPc+pmWUTVJ+BFOXNcZ1WBh0LT6CLMxsOt2OPE11K?=
 =?us-ascii?Q?YLcxQ5bPwiQTW97yMQ5iPfKGut3RuSO9w69FJedzRBI4g8YW5sHadvSq0CmA?=
 =?us-ascii?Q?1MIYfVDEBwx5xRhkWalJqrltM/MtkwfhF9Gg2Dp9BjJQHftxctKOV/Bl8kRQ?=
 =?us-ascii?Q?1uH8NdEuoU/EtBcDWTIlQ55YC/KEh9br25lFPBKt7k6RKNy6PKkGinOlBzCJ?=
 =?us-ascii?Q?x23Uf3Q/oMj24wcIYzFt4JAJEie1BdauMjqDGPVY9DPl1qn9Ak9n7+K7ThC4?=
 =?us-ascii?Q?vdDN09bFpcrs59Ur7H13HGuhN0q3NJqMKDeEVYFX08Q6spO4vQCRJ2RYxmb8?=
 =?us-ascii?Q?vU+8Ja6cI76m0iwVA/2TeGV0b4jAg+xPEHYPmH7YQNDsbjFuc9vBFsG4UBKT?=
 =?us-ascii?Q?MUbkHw+CGbcf6QnwjWfokHpa+nqh11mkWXcuO3RGhse9j0LWzkO+bRkP/4cO?=
 =?us-ascii?Q?z1abeDD03A/QRHhc0R/Zlcr6yVKkTnXIm0/8WZ0vx91RAgHbBCRtxMjaJrCb?=
 =?us-ascii?Q?sUQbJy2IqFuLgOWHCLngG5gyvChSUqlwPZMi6mw1lLmulLD9ioKLXCYZN3xg?=
 =?us-ascii?Q?aLn3K03C5FPjBYMWIEPLFmdo24SMWf25A/CKSzuAPpm8XvbxAGTS80h8gj9R?=
 =?us-ascii?Q?1KZFwPSK/AkWaJFM/pt4bkLaE/1oDGuTY7fPPBtk+QLT3x0gaXRVpYvGS41w?=
 =?us-ascii?Q?XJ/MzdqV0zUhUSLe8V5jnBXRsWwOlB0K/gzP0ODxQ0N6RJsJRnpDhWPCZLF1?=
 =?us-ascii?Q?tX/QYqIYXJNvzqd5zYv61NCNjFb/Mm2tCbPf5WCxeeCr3UdIaXyX4KOpK/E0?=
 =?us-ascii?Q?uevQhLDLTvQp/wsiL1WQiaHDR0RcKZ7349jfmfyF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8593a86-db74-4837-a858-08db494581a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2023 06:38:27.9740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrVO8xWsmeV87Wd4h3bMILqORjAOeeJMtSCF+vDLsY/9BwGkZkdg9FcGjur7IqdJ9vCeB5JBKdCmYuewGC1lEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5648
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Wed, Apr 26, 2023, at 19:11, Winkler, Tomas wrote:
> >>
> >> On Tue, Apr 25, 2023, at 16:27, Adam Borowski wrote:
> >> > The problem in mainline is inconsistency: out of 6 config items, 4
> >> > repeat the "depends on X86 && PCI" line, the other 2 do not.
> >> > There's indeed no immediate functional issue, but I'd argue that a
> >> > dormant bug is
> >> still a bug.
> >
> > The MEI protocol (CONFIG_INTEL_MEI) is not PCI or X86 dependent.
> > INTEL_MEI_GSC is PCI dependent but not X86. (Hope I correct also on
> > implementation side) They HW layers are currently X86 dependent.
>=20
> Ok, so in that case the dependencies should be relaxed like below I guess=
, in
> order to allow using the MEI on non-x86 i915 devices.
>=20
>       Arnd
>=20
> diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig index
> d21486d69df2..7c6e3b4588d0 100644
> --- a/drivers/misc/mei/Kconfig
> +++ b/drivers/misc/mei/Kconfig
> @@ -2,7 +2,6 @@
>  # Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
>  config INTEL_MEI
>         tristate "Intel Management Engine Interface"
> -       depends on X86 && PCI
>         help
>           The Intel Management Engine (Intel ME) provides Manageability,
>           Security and Media services for system containing Intel chipset=
s.
> @@ -39,7 +38,7 @@ config INTEL_MEI_ME
>  config INTEL_MEI_TXE
>         tristate "Intel Trusted Execution Environment with ME Interface"
>         select INTEL_MEI
> -       depends on X86 && PCI
> +       depends on X86
This should be both X86 and PCI, this is  a HW dependent module=20
>         help
>           MEI Support for Trusted Execution Environment device on Intel S=
oCs
>=20
> @@ -50,7 +49,7 @@ config INTEL_MEI_GSC
>         tristate "Intel MEI GSC embedded device"
>         depends on INTEL_MEI
>         depends on INTEL_MEI_ME
> -       depends on X86 && PCI
> +       depends on PCI
>         depends on DRM_I915
>         help
>           Intel auxiliary driver for GSC devices embedded in Intel graphi=
cs devices.
