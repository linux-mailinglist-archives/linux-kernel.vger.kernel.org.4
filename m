Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31417680359
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 01:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjA3ApD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 19:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3ApB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 19:45:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A63118B32
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 16:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675039500; x=1706575500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xf0P6rR5HOHtB8oQeIMfHOYzWXbZ6yJyV3Rc9QqQiwI=;
  b=XfrfM8PpSVXBpufVVP1dRgICsMHsOmXUqv2EUshKuU01hqTx5/L+Pp4G
   9Qrnqj2jNu/hEseNs/gEky3rlDlx2dx38vrzASoSiPoC/MrfJ7rBPyJhw
   hZBGdnaM+8fA40nNwNgdYE3BjdwHDwWb7X7Ddj/tEDEALJyLqotAXsumY
   9e0MueK69IeuVxbb58Ht/DmbmlI6fujRbAsDqlqc/EvK+GUTvKjG1jKc6
   tg7d1jf4kZj9DFviOPBGcf2lPjN12tPux6oPkz4BbjMsw6RyxlWGHy7k0
   mdhDQBop5dTjZTPYy+0UxJ/QZ/YY/pDUyWrJeQmIzLQlxLP8Y3PoBHI8v
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="311070258"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="311070258"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 16:44:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="787840448"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="787840448"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 29 Jan 2023 16:44:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 16:44:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 29 Jan 2023 16:44:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 29 Jan 2023 16:44:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gs8RfP1xiPr0NXs5HuTkvnUWaLEfXGnUQJvcWX2XFIBo2s5SuEKiV8M9xkPfvkheBwMiCc7UdigahD8URvZr3H5/3hAdMX+DqG1Y3L+Hfp/sIbKLVoGfLyrlRGr/4aygzErK53VhkSTqd/m2So5V7u5OAfltQ0iYwymGymSP5drd44Js6S8rZMUv1h9hm6Y1WVbVz/L4Q3rbzvDv/kRJP/cwijXGhHQR+GkWw47YytBCxO+1lvS91pDjh9pG797lOQ08gYwbrtpfATLGlBwrMVKSlJV/3zr6Us0E8ffjKLeTi74ThcUqtA2tw2tNtV4V33U/5s7Eh6d10q3Y6ytO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiK8/dNg0GY7ADBbb971CaE8k0Jln1kDDYdPsQtyZ1Y=;
 b=hgciWUa1MHuiO2nQt5bkuDCEaBh31NqPwpzDgOs5ngIwyWb5Qbdo1+7LRqme3Ws+uATDR78TULUo4iwur2xp7dm6C7Bycc7gEDBvc4PydRitWwIYOR9S9p7Car3eK+oZjwvPxrDmkVnvJR2aVC90r7Db868Ke0ZMVJd/38JEzDN+Seq2A6xtQV2BY/aosiqZjzdUEgwdYhaMFoKIkFmxJawy+5vAlnsAPq6h1XFp+MF/5HfEyb2+Gdx77/o4Uua7SaKUNHHOe/UkR9UIH6ki12T13EpQWgjQo87khCMa40J8HY9eo/aIL/vG5dQOU+zwwDFkG1QMK3FuNd2wBAL3pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5161.namprd11.prod.outlook.com (2603:10b6:806:fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 00:44:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 00:44:48 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Thread-Topic: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Thread-Index: AQHZM14dxdHVToGJbUKK/xSgiTyXrK61IE4ggAAUtQCAAOtDYA==
Date:   Mon, 30 Jan 2023 00:44:48 +0000
Message-ID: <BN9PR11MB52769DF1D9C9C06C88CC13408CD39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <002911839dd30990d5e3135f8a0f8d41f14e856b.1674939002.git.nicolinc@nvidia.com>
 <BN9PR11MB527697E1E24784576C3FB7628CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y9ZMulxEyGvnvW0X@Asurada-Nvidia>
In-Reply-To: <Y9ZMulxEyGvnvW0X@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5161:EE_
x-ms-office365-filtering-correlation-id: 34fc1d91-8aac-4809-94fc-08db025b30d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EL+DDKyC9w2R9ClRm5GhcVrepMl1yz1XVPm3aib0SvxHeF/f2kzSjYIQEqUHWZbydkRq+6ZtNG9TR2EoKgwLl4S6AUqCUSalGZTfsRjvLygAI5zSGFPemeco7jwmVSFvN0sCs7FFGDdf1BDMYtEK4oufNphEDT09qbxJPkovvZzHams1f2Bx263sqLE1SRNsUIESCRzMMwtaH1jaDovrOLeDP16JyPSIQUUVWvSdTkOBb5JcR+eWZZH9weM0lOuU9R8KK4GZ2zJ7BZ6KSyuGdq1+9jKkXcCJd+cFVPE0FT3QuQRIEUo/PB+ZE7k3wD0jU+7BjdBMe/sm3YT+n8l+EESO348ugkbtzK3vSOs6731UaGcOvYxCJOTzwJAvbgBRPM57Z8WvghUG2OEJ6Ez29/WuLd2VrdFHYCtvHwa7sQdFQf5CW9qxXuSAlMTty8+mb5lgW/s3+AmxGzwxj3GRY+0LgvKd7WSwXAmDY7hRoclh+MxisRzOC7Vb0SlOvHnMCjRFzGgEkb5E4ayeYiROShoB3CqIJM9AB7BBfZQBqSEWTJ6vjlOaH5elR7lNU5fKeBjMIACnnX8rUbr2BdJBsdqxVEwll4KkHnoF+/vngbExmGlAaXVQVHMOxWcVtReyjknraGJvOg6frAlltDQQ+xMdh7MCpsE6vFqVrKU6WIK7+0W6vwbjFntJ+4ss3gLCWrbdyof4zLP4Cj2zHvfNMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199018)(6506007)(478600001)(26005)(9686003)(186003)(7696005)(66446008)(76116006)(4326008)(6916009)(64756008)(66476007)(66556008)(82960400001)(66946007)(83380400001)(41300700001)(8936002)(8676002)(52536014)(86362001)(122000001)(38100700002)(71200400001)(55016003)(33656002)(2906002)(5660300002)(316002)(54906003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7ppYaKmQcFbEdV8LFTxfc9FE15gYfLuYXYRXpBbj+V8t4IkUYkl2QZi1q60H?=
 =?us-ascii?Q?YL2ixZWK6S/lsP5G6FU1QOrCpeXrAVTc3bFxFVNNStyW/7R/+xuw8wapsCaH?=
 =?us-ascii?Q?l6D7UteYxop0Lti2ZVqGf0DNLYWzmErFLBqSsOlS1Bxt1YPaixpLcgUIuUlE?=
 =?us-ascii?Q?1O/GWP5AsKIhqjDHaUrbbYasYKlIcMJzzfH+MfS3mErTO4lxQrXbYHcEiC2F?=
 =?us-ascii?Q?EpF4cw2tDn66s5qkdaF3ZZ5OmSceoFHjYVRCXUpJxwz3ELJfoWwvHdOU55Pr?=
 =?us-ascii?Q?fzJp5Zt4lK27xtbf4iRwIRWY8TR2tHruB7ucW2ocGyEY4aNfuobPVFBEN4ml?=
 =?us-ascii?Q?nhexSq70/cqxPwIsYviY9gDnNdFsGCTQOkbgIoBAmf18M9XULP/feisOpSdD?=
 =?us-ascii?Q?1jTf9bJBWnYFopP/rkVOBW8tpCHjWgoFE2S2qNRQCIAtK96CzRIeAqmG5LYC?=
 =?us-ascii?Q?FXu99gbgZpjtZYjt7x+26uqrgoa0vJuzpYwyjye9IhnBrooQP3C85LuTZ7Wi?=
 =?us-ascii?Q?kSQKcE4GnrxheGiObbFerWtrgHk3xlHfHywE1WOOq1WepbeNSzEsAkFZYOeS?=
 =?us-ascii?Q?fz8QaeqXu737ZAiCM3kSRkzcVb10f6z8jRjdaXfos3lJBQxnOXEsSWvI+tVk?=
 =?us-ascii?Q?iySTP1+48/MzRm3qhrLazbDvj/fCY0ICicINH7yCuihjLVvL1Cwd/CcCtncd?=
 =?us-ascii?Q?3kRCUnlXQ27loNKqWNm1s6GBlEs22/rpU2z30C/1eTl9d/hDeZNZ1tnZdVC7?=
 =?us-ascii?Q?KGHs5HJ+Bw/7g4fEwO52BmGJnKU47uYhcrHooAKtrouIzcYzYTH81/jcJNv+?=
 =?us-ascii?Q?vu0XV122RBI+VvtPJr49someDphxM9pSi49lmTYKnppKJLb6lEM8279ypUVK?=
 =?us-ascii?Q?KOBSTRFihXSTHi7nbUQYO7Cm1XWzUNUgzEfmP/n5SwiegoPrlQdHrs/3yKvC?=
 =?us-ascii?Q?up9tK2dDFS033i3t5kAzZL6K5A1vozuUii3BvtfnuYXJRnOshn+q6JXod4+S?=
 =?us-ascii?Q?Zoc1nwIlnMT/tkeX++DEKdXafsXMbbeqoN3kZm4lTHRnv+Z1I0BclZ/V+L8f?=
 =?us-ascii?Q?RaEyZ6wjYQikSbY5IUP12I0lpUpX6KdJWi6yXhsLPWBsxlEfT/Dv1smV7pFq?=
 =?us-ascii?Q?MpCDcRyg064KAWK/deNFVz+z5473nq5lUYyohqa8bFZwyQVjmO2yfxm+PVN/?=
 =?us-ascii?Q?p7X9bbYVMe5yIOlFCgX+S6vPH44SL66UjW6xhHNlJBnr1bcUC0KYVckM3/gk?=
 =?us-ascii?Q?GTtrNq5arBQx6/n6YDbxJQdS6gcZDoIZlTcWG5POziCAXxMMXvu9qXdfRNra?=
 =?us-ascii?Q?XgL3jNAMW0bnyWJ3cNA+eioADAoofoP2SQ7eNmDclMeZlaqFNrIkQfm5HMvJ?=
 =?us-ascii?Q?QO1yYCRfkFfu2nK8XPZtAucD2Bek/9EoFuRpO2qJt2PrHiTRbzUdEejQvG3s?=
 =?us-ascii?Q?TqKtZ70lmgfHrcolabARoZ0+uXMYMkfy1z+XzaGCfSgrR9jH4cCIlRTbwAbp?=
 =?us-ascii?Q?QHF8mLZRAVvX1WXPUbKU+hHze0nV5xEmwC/o7lrmX3oU1DiD5+5hPG7r1fDN?=
 =?us-ascii?Q?ZE6ohs6sxgdCk7D9l99vTz23fNBzMCQS7WwJuIY4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fc1d91-8aac-4809-94fc-08db025b30d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 00:44:48.7327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ge39hC7VibNxUjWh55zquk4JkjG55uWeeOFBu6T3mG46Le4iXMPVb+nUT6/UfynzPf2/k/cuqArd7A4zrfmq3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5161
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, January 29, 2023 6:39 PM
>=20
> On Sun, Jan 29, 2023 at 09:37:00AM +0000, Tian, Kevin wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Sunday, January 29, 2023 5:18 AM
> > >
> > > -static bool iommufd_hw_pagetable_has_group(struct
> > > iommufd_hw_pagetable *hwpt,
> > > -                                        struct iommu_group *group)
> > > +static bool iommufd_hw_pagetable_has_device(struct
> > > iommufd_hw_pagetable *hwpt,
> > > +                                         struct device *dev)
> > >  {
> > > -     struct iommufd_device *cur_dev;
> > > -
> > > -     list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
> > > -             if (cur_dev->group =3D=3D group)
> > > -                     return true;
> > > -     return false;
> > > +     /*
> > > +      * iommu_get_domain_for_dev() returns an iommu_group->domain
> > > ptr, if it
> > > +      * is the same domain as the hwpt->domain, it means that this h=
wpt
> > > has
> > > +      * the iommu_group/device.
> > > +      */
> > > +     return hwpt->domain =3D=3D iommu_get_domain_for_dev(dev);
> > >  }
> >
> > Here we could have three scenarios:
> >
> > 1) the device is attached to blocked domain;
> > 2) the device is attached to hwpt->domain;
> > 3) the device is attached to another hwpt->domain;
> >
> > if this function returns false then iommufd_device_do_attach() will att=
ach
> > the device to the specified hwpt. But then it's wrong for 3).
> >
> > Has 3) been denied in earlier path? If yes at least a WARN_ON for
> > case 3) makes sense here.
>=20
> The case #3 means the device is already attached to some other
> domain? Then vfio_iommufd_physical_attach_ioas returns -EBUSY
> at the sanity of vdev->iommufd_attached. And the case #3 feels
> like a domain replacement use case to me. So probably not that
> necessary to add a wARN_ON?
>=20

You are right. I thought about the cdev case where the device is
not attached in vfio but has a valid domain due to attach status
of other devices in the group. But even in this case it's user's
responsibility to not break group boundary. So yes it's just a
domain replacement and WARN_ON is not required.
