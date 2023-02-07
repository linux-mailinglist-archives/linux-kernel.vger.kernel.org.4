Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5815768CE1A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjBGETg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBGETe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:19:34 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EEA1115F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675743572; x=1707279572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LvI+tit0euvGidQKNdLM2oQgUPfdJKeHacy/wrJ700U=;
  b=Yr4tUu7bS/q2WdmJNOEKaUPwY5VzHeWpfaRsMq8tw+Pdgh9nliCBr43V
   fEb/mOWMBtIY+K9PXyaCwzCZW5VprDNDG0zZE27M7ItMOfnE6bgojozJu
   wxsmMDml6wMC4npxmzHCOpamuHKjvWJtyOpucqpoTTHKiQtlpiCnyPb1K
   XTj9NXoh7n7zifIVed1NUdH3rQ4ta4b1ygr17rLUlxo6MCa+xRG0sFPwj
   20u8IO36I0iHTRT0KEfct9NOC8ayIRWgwOUSqtZJEKYUWMlVM72mt4t62
   GbIj/kLut8VBOQbEP7blKcIt4P7vmU3hDiUmpdCwsSTF3wya/GpCCDRn1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="391796225"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="391796225"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 20:19:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="697114928"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="697114928"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2023 20:19:32 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 20:19:31 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 20:19:31 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 20:19:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoM5lQJe1ImBtzOc2MizXc01PE1iCa2l7uka3C7CdtvPvydDLkaOrzhBbI19YadxgrLHjUvbYUf8iS3aSnvgLgGNGGb4Rp/o4bXaPRHKQIESg69mC3DMM+9EAszYWJyJUf5qyqc3OWp7WdPg+5gYLFGEPKg7JDIe5m82XvAc/ivvdhssqJKU4e38kcCO0HMBpnTiHFQ9uHToSnWmrMbTwIY/CVtFG5cBoxKtpqWY8fzr6UivN6QMwzJerXWGrCectVZBwGVF1/pUwcExs1IjmbLVOYVyeEHIQrarDg87JkLjXzHQHKysESf36WViGGPOnVopIey5jqKJTvZJ5F9FPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af5H+nrs2ZwkZaW/26XuTIFO1a7L9BcxSs6Gpnk4UAs=;
 b=RIl6kCa8oF45wQbzcDnfmdpBhEAtlseNsWATlKL1SutoGHRgiHRNFXe98s5V8Wfj45ocdC0U2GO2ASj9roh9FcrKaIu0vjCb3/PsMigsQ3TIGR85rZsMy7Nc9Pt3P1OfhKYlfQ9mlQ5g2uY6heWYq53i4AgsxrdWxzU1XKbLuTihmQUMHmxYmcgahgflcRl5nNAwnjY+6xj6XRytC/MFQk4DSCF2zPjKJ5J1+WgKiDsu9K7CCVxnfsw6RQSLfHk3YWYO+DqHjU1/AkcTZBmNehp3jTmG5+51ULH/G/5VYTXSibNEFxdTJs3or94bUvHdKvzVg/sIJzxG6IJgSHuEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 04:19:29 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3%3]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 04:19:29 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Thread-Topic: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Thread-Index: AQHZM14a8sLMOu4lm0Wu+eywCVc4o663EP2AgABKGICAAAZKgIAABAiAgAAIrICAAAUiAIACSROAgAGp0wCAB4iHIA==
Date:   Tue, 7 Feb 2023 04:19:29 +0000
Message-ID: <DS0PR11MB752901B9E6023D1802EB13A3C3DB9@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com> <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com> <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com> <Y9guZhNve8A1DGL6@Asurada-Nvidia>
 <Y9oZMTMRG4mL5FT1@Asurada-Nvidia> <Y9t+ZtnphowLFwr1@Asurada-Nvidia>
In-Reply-To: <Y9t+ZtnphowLFwr1@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DM4PR11MB6430:EE_
x-ms-office365-filtering-correlation-id: 02ddf8dc-77d4-4ff9-a9e0-08db08c28197
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zVRADhTtyTYt5at+G7SKrpgYU8+zeMQEUFCmmnbJq6fJIGQCDuzIuyg5EAxLC/s6UR5Xie4eYAFYdNkVdIBGKXpJmgAKL7h4G7z2/Bcna4sk+rFf0Z9k09V/pM9mqzVicrklz7wxDEFNi5iUKHineLqqGqz8bcXY2HOThhGUYhucvXrtYfmVxBDgRDy5dOojAi/nU/t0mIhP1mxGIWIYpf2yMnd6Gmp3gZrhwnOdrGNsQ7KLYkBr1uPBeGDOVqHePS6PcWu4LuuPPOzCiz3RLBwKR70mME2/4q90KBfwiKm3d3pVBsKoUDBdWN/87u0zwvGnSOUdo94H090fT8zI2W471Kt/flZ14/PBfvzTkowIHiaIOe/nWkcWDj6z3QeR3CralVIoP+tE3ZREtHUnZ+EZC4LG7NPlKK1L3DdTXiAXZ4b2FetXYDjEDSkiPIh2heyqDyjBQkLdyDRN3HlYgq89UAuo+2p0WQX2+WzAUY3QjO75itZd1wuT5E1Pvw0ipMVeRwEuW+s7buv369WM8DGgloelLI5bvWnqv6TpH0QndA83134iUJzTf9tH9Ih8coGc8SXgsosS7akWGg254ZejiKRbM6BY/fYI/5syiZB+sp3ZX5iogj1K1w9ZrMBiW1WRE1KktQYqTqynzDQMSE1yzMLewaeN/nNkwkpNfShX3IuHyCB3mmnGPuvg6hI5Gtkv4dSXbNfHv4wEwTQafaTGUyBrjQyklUr7+5BHAjK+aYay8zowcdtHIVWubk2cRWbMxOsXgo152n90ia0NHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199018)(66946007)(38100700002)(82960400001)(52536014)(38070700005)(76116006)(122000001)(83380400001)(5660300002)(8676002)(66446008)(66476007)(6916009)(4326008)(2906002)(66556008)(41300700001)(8936002)(6506007)(64756008)(966005)(478600001)(9686003)(86362001)(26005)(186003)(316002)(33656002)(54906003)(7696005)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XpD46iszNQSIO9KgdYejLBLDwWjZSWs9P4Dgsl2eyl8nz3T3gv1kcGdw3Ake?=
 =?us-ascii?Q?vN7zy/uhuID7YMh3d/7BpDTcfxJfCPmMBqSIzxUWKO60t/BSZrezKlKL107y?=
 =?us-ascii?Q?ZeMJwmpYgxdPp9+pbUxvD8FKPuiqNFZJNhC6IXncRaMb8Y6CWfxkaE1qwu3s?=
 =?us-ascii?Q?bpCbKhxHjdi2acOV/mWP8HTz/EDTOQXEGwDXaETUn1CUqH2zapCvcA/1vGQ9?=
 =?us-ascii?Q?kEJPA1SaqUkAw76Hds+diKmOvKUs2YH97OAeq8KBdohPnJfNiYhpaiSs5Dmz?=
 =?us-ascii?Q?6gEBFHZ1DNIdTuUqJoSMFjD7nOQ+iJA4XiHbVKJ6kDDJoGkM1PbSBtq78HpU?=
 =?us-ascii?Q?Pjhi34uTWAUgUN9XCfebtpxZVKpXrkE9A3xwRg2VkWFhDwYoOMLz04jTjf8i?=
 =?us-ascii?Q?26HqSK9ucxZZwsM2t1nvrBVTXmOHQWPm9ZRdD4wL18Zajw/SwSxDFY6KP+Bz?=
 =?us-ascii?Q?IB/Ggynvjy4KBkoJMjX5kEqFyQQykAeKRl7e/D+vtpxATqCQIKz0NbU74YMH?=
 =?us-ascii?Q?vU337IuM+fDNRC6IukJMMU+z5N7b/d++MlvUQh6iAPZqZqbhziQj3se66wtX?=
 =?us-ascii?Q?HeJ26RT9XiOVi6HmDYCzvhY3Oq4X8dke+QDDYzL+Guvn5bAeJkQGwYRDv1yJ?=
 =?us-ascii?Q?EP64V0THY1mnkoPU/VrecT0OQKtxdRXrNz3qcD2t2+nx+WUTxOgSKiZR33AV?=
 =?us-ascii?Q?MaLcLlfXQy7PKUuKF1iVyjgaBOOiwXFfO4BiXnXjjrQB2HsntrMaKHLWTKl6?=
 =?us-ascii?Q?fd7ViDoQn7H6jH5XzZeSZePW/si+vhPCzKU6b4jkcavc7kHBNXuTkktItdJf?=
 =?us-ascii?Q?iGQ6+9/TdY+WMYzHI+iGAPhQSuUVwgxkJJvtuE7BE6wut4qE82b0NTPMRMkv?=
 =?us-ascii?Q?Ikx7rmIy4rf08rXig/13Nj/Kxh1VTIuvN4R8jb8kWPCCIztDpnD/8e7yIwjy?=
 =?us-ascii?Q?fVJL4YSdBfd2UWVH/xqeqWLR3yHACiYpQpdEY5cP/ZeCo/Rk6Fj0nqCfAham?=
 =?us-ascii?Q?uDO8qB4z2P3Gs56NGWhNkch4a4V6hMPvWLZeKlbnmVUAOwwMPGO1GnQxlhU9?=
 =?us-ascii?Q?bwYc6am6OYGSW0imzh5WD0fwT9yznZnm8zMrggzv2JXD07J3Z5HuvvmbUgGt?=
 =?us-ascii?Q?TjDRbAiIJ1OdtIKruhrWyX/toXTGVqpUcAHdUZL3ZWzGGHsBu/SIA0YeTabl?=
 =?us-ascii?Q?03QcYSPs/n+sMCtihjHsa1VPfI35QYeFmywryyT6jfqNv6UQDtGq2U8+Omj3?=
 =?us-ascii?Q?RKXHptHLCcJDs20KzmeDId/XLJaYR7d7zz36wypyIIOaLsxmW0LHvCcEizxE?=
 =?us-ascii?Q?ecqfVp1yNPkaWxlT5Pqt9q86FuylFbwqQ5k9fkd7eeG/qQ2zUGuGI71VlL2v?=
 =?us-ascii?Q?Q7dlxQS01m/VTAOldk0v8LOpWaXtNzplnLS4lmRbEkl9c0Q4bkGBz1wrpVj5?=
 =?us-ascii?Q?4y/xxjZwO5grvQ8Z5SFoT4ve/Ur+4yl1X2dqHPcjkQGa3bNlBZ7cEokb37B+?=
 =?us-ascii?Q?7lEidXmSQ092vYQyFg2FfxouWtUp+boJD3bZLh93tLB+wnqMt9lWEN/b3MSC?=
 =?us-ascii?Q?B+rshoiONG/wYd18rNazTeIVfhAXlXeVjgILFOwx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ddf8dc-77d4-4ff9-a9e0-08db08c28197
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 04:19:29.3310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwWEscYU4JAih5pfwqTg+kf5+zM49O1VabP0XzzFGKsMd0eQjGLCDNfAWzJp6UsQgvWWAiySsrYqjImKECi8+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, February 2, 2023 5:12 PM
>=20
> On Tue, Jan 31, 2023 at 11:48:04PM -0800, Nicolin Chen wrote:
> > On Mon, Jan 30, 2023 at 12:54:01PM -0800, Nicolin Chen wrote:
> > > On Mon, Jan 30, 2023 at 04:35:35PM -0400, Jason Gunthorpe wrote:
> > > > On Mon, Jan 30, 2023 at 12:04:33PM -0800, Nicolin Chen wrote:
> > > >
> > > > > I recall we've discussed this that SMMU sets up domain when it
> > > > > attaches the device to, so we made a compromise here...
> > > >
> > > > The ARM driver has a problem that it doesn't know what SMMU
> instance
> > > > will host the domain when it is allocated so it doesn't know if it
> > > > should select a S1 or S2 page table format - which is determined by
> > > > the capabilities of the specific SMMU HW block.
> > > >
> > > > However, we don't have this problem when creating the S2. The S2
> > > > should be created by a special alloc_domain_iommufd() asking for th=
e
> > > > S2 format. Not only does the new alloc_domain_iommufd API directly
> > > > request a S2 format table, but it also specifies the struct device =
so
> > > > any residual details can be determined directly.
> > > >
> > > > Thus there is no need to do the two stage process when working with
> > > > the S2.
> > >
> > > Ah, right! Taking a quick look, we should be able to call that
> > > arm_smmu_domain_finalise when handling alloc_domain_iommufd().
> > >
> > > > So fixup the driver to create fully configured iommu_domain's
> > > > immediately and get rid of this problem.
> > >
> > > OK. I will draft a patch today.
> >
> > @Yi
> > Do you recall doing iopt_table_add_domain() in hwpt_alloc()?

Yeah, doing iopt_table_add_domain() in hwpt_alloc suits well.
The only reason for current code is SMMU has drawback with it.
Great to see it is solved.

> > Jason has a great point above. So even SMMU should be able to
> > call the iopt_table_add_domain() after a kernel-manged hwpt
> > allocation rather than after an iommu_attach_group(), except
> > an auto_domain or a selftest mock_domain that still needs to
> > attach the device first, otherwise the SMMU driver (currently)
> > cannot finalize the domain aperture.
>=20
> Some update today: I found ops->domain_alloc_user() is used
> for all domain allocations inside IOMMUFD. So, without any
> special case, we could entirely do iopt_table_add_domain()
> in the __iommufd_hw_pagetable_alloc() and accordingly do
> iopt_table_remove_domain() in the hw_pagetable_destroy():
> https://github.com/nicolinc/iommufd/commit/85248e1c5f645e1eb701562e
> b078cf586af617fe
> (We can also skip that "symmetric" patch for the list_add,
>  moving the list_add/del calls directly to alloc/destroy.)
>=20
> Without the complication of the add/remove_domain() calls
> in the do_attach/detach() functions, there is no need for
> the device_users counter any more.

Yes.

> I am not 100% sure if we still need the shared device lock,
> though so far the sanity that I run doesn't show a problem.
> We may discuss about it later when we converge our branches.
> As before, I am also okay to do in the way with incremental
> changes on top of your tree and to ask you to integrate,
> once you have your branch ready.

I think reusing the device lock can simplify things to avoid bad
readability. However, I'll do a double-check.

> My full wip branch:
> https://github.com/nicolinc/iommufd/commits/wip/iommufd-v6.2-rc5-
> nesting

Thanks, I'm now re-integrating the nesting patches.

Regards,
Yi Liu

