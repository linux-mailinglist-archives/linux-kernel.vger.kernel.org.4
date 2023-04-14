Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B726E1915
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDNAfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDNAfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:35:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646ECBE;
        Thu, 13 Apr 2023 17:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681432552; x=1712968552;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gJXUKvtAKIhFjJW0OMUbj/X+85vaYXQK0dClWr5sQks=;
  b=RTNx1zAmY8Kway3NdxJl1YqtPfFk+ssgMyU3kjmvXT8yKXNTLXUND+JS
   27ymq6x8t8p9GfWlgQL8PNxd+IRFmqy+hU593OTKWTfzOoWFuButSFiRe
   5bMww/uNFh4N9lKRUikdPs40zlt4a/dx6eQ+pAsM19WsXA5zAElaCNlzD
   AkoUmYhW4wscaPPb6OnNDol4JxsbJ4SlHtakp5XsZheHonnTVj+lmVeXG
   oq3aifODxaDCAG0IdQxl1KO9oKyRFoXSvWYiEzg3KxY10/6mf4XgkyDvQ
   Kq8M2VtZ//er98TcVGxDbHD8IQx8ub/h1xc9J2IAqpiNVRPfFSSEuriM3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346170058"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346170058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 17:35:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="722269709"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="722269709"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 13 Apr 2023 17:35:51 -0700
Received: from [10.54.75.144] (debox1-desk1.jf.intel.com [10.54.75.144])
        by linux.intel.com (Postfix) with ESMTP id 1E4DA580BEE;
        Thu, 13 Apr 2023 17:35:51 -0700 (PDT)
Message-ID: <fc37371bb116cabdd9d2ae114c0f34a818e9c4c2.camel@linux.intel.com>
Subject: Re: [PATCH v8 4/4] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Box David E <david.e.box@intel.com>
Cc:     "jstultz@google.com" <jstultz@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "svenva@chromium.org" <svenva@chromium.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 13 Apr 2023 17:35:51 -0700
In-Reply-To: <MN0PR12MB6101F7E14E3AD1ECFD6C2F25E2989@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230412194917.7164-1-mario.limonciello@amd.com>
         <20230412194917.7164-5-mario.limonciello@amd.com>
         <5d904d5a-d25e-7d6d-57e4-ca451bcead57@linux.intel.com>
         <MN0PR12MB6101F7E14E3AD1ECFD6C2F25E2989@MN0PR12MB6101.namprd12.prod.outlook.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-13 at 22:40 +0000, Limonciello, Mario wrote:
> [Public]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Sent: Thursday, April 13, 2023 04:24
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Box David E <david.e.box@intel.com>; jstultz@google.com;
> > pavel@ucw.cz; svenva@chromium.org; Rajneesh Bhardwaj
> > <irenic.rajneesh@gmail.com>; S-k, Shyam-sundar <Shyam-sundar.S-
> > k@amd.com>; rrangel@chromium.org; Jain Rajat <rajatja@google.com>;
> > hdegoede@redhat.com; Mark Gross <markgross@kernel.org>; platform-
> > driver-x86@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v8 4/4] platform/x86/intel/pmc: core: Report durati=
on of
> > time in HW sleep state
> >=20
> > On Wed, 12 Apr 2023, Mario Limonciello wrote:
> >=20
> > > intel_pmc_core displays a warning when the module parameter
> > > `warn_on_s0ix_failures` is set and a suspend didn't get to a HW sleep
> > > state.
> > >=20
> > > Report this to the standard kernel reporting infrastructure so that
> > > userspace software can query after the suspend cycle is done.
> > >=20
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v7->v8:
> > > =C2=A0* Report max sleep as well
> > > ---
> > > =C2=A0drivers/platform/x86/intel/pmc/core.c | 3 +++
> > > =C2=A01 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/drivers/platform/x86/intel/pmc/core.c
> > b/drivers/platform/x86/intel/pmc/core.c
> > > index 925c5d676a43..f9677104353d 100644
> > > --- a/drivers/platform/x86/intel/pmc/core.c
> > > +++ b/drivers/platform/x86/intel/pmc/core.c
> > > @@ -1153,6 +1153,7 @@ static int pmc_core_probe(struct platform_devic=
e
> > *pdev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmc_core_do_dmi_quirk=
s(pmcdev);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmc_core_dbgfs_regist=
er(pmcdev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pm_report_max_hw_sleep(((1=
UL << 32) - 1) *
> > pmc_core_adjust_slp_s0_step(pmcdev, 1));
> >=20
> > Technically this is FIELD_MAX(SLP_S0_RES_COUNTER_MASK) *
> > pmc_core_adjust...?
> > Where the define is:
> > #define SLP_S0_RES_COUNTER_MASK=C2=A0GENMASK(31, 0)
>=20
> That's fine by me to switch it over, it certainly makes it a lot more
> readable.
> I took the value from @Box David E to use suggested in v7, so what are yo=
ur
> thoughts?

Ilpo's suggestion is preferable. The warning comes from using 1UL, long bei=
ng 4
bytes on i386.

>=20
> The current version has an overflow error reported by the robot for i386,=
 so
> it
> definitely needs some sort of change.

Resolved by using the macro. With Ilpo's suggestion you can add my reviewed=
 by.
Thanks.

David

>=20
> >=20
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device_initialized =
=3D true;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_info(&pdev->dev, =
" initialized\n");
> > > @@ -1214,6 +1215,8 @@ static inline bool pmc_core_is_s0ix_failed(stru=
ct
> > pmc_dev *pmcdev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pmc_core_dev_stat=
e_get(pmcdev, &s0ix_counter))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pm_report_hw_sleep_time((u=
32)(s0ix_counter - pmcdev-
> > > s0ix_counter));
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (s0ix_counter =3D=
=3D pmcdev->s0ix_counter)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return true;
> > >=20
> > >=20
> >=20
> > --
> > =C2=A0i.

