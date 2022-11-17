Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ACB62E0AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiKQQBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240048AbiKQQAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:00:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1082253F;
        Thu, 17 Nov 2022 08:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668700847; x=1700236847;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=BuUmPgqr1gKGWjTUN8g9tLoojOhBbprvA2Zcib8Mm6k=;
  b=QJz22JKdj9Ns5vhsaP8MwLwfusIV2ccOT1p4jdf/Etpbb3UcGsjm3eEe
   Kjre/ALZAsQsgq7mAf1YPzhW3e15DCb8ciZa/gwA4F4NXabR48dsM3blj
   tSPO/gz2sWIRk9yJoHGQkrUgW6KdfCmGnCizb1fm1c4dDPHogMsRCW5MN
   IJtCHgvVIf4UENp7sX2C1otMVV4Hm9ZZ6lDfjNQx4J/cbIoo8E3tY8Ahf
   npsgb0WmPDEbVPt1aFQPmGmqPvh4oPYea41ShEVKeb1DTbNurPEdrqxak
   m33BE3jxb9OFLKgsVVt4RAnB3kLOAOrPFskf+QEFl/rLeytnM3dl0ttKC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="311592482"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="311592482"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 08:00:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="708665301"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="708665301"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 17 Nov 2022 08:00:42 -0800
Received: from sulochan-mobl.amr.corp.intel.com (unknown [10.212.246.182])
        by linux.intel.com (Postfix) with ESMTP id 9B45A580BBE;
        Thu, 17 Nov 2022 08:00:42 -0800 (PST)
Message-ID: <a21a7a1b749d0c7e8f7942fe02dd4b6fcd3e97f6.camel@linux.intel.com>
Subject: Re: [PATCH 0/9] Extend Intel On Demand (SDSi) support
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Nov 2022 08:00:42 -0800
In-Reply-To: <267ebc83-04a8-4421-732d-7a329bc0fa9a@redhat.com>
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
         <267ebc83-04a8-4421-732d-7a329bc0fa9a@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-11-17 at 15:01 +0100, Hans de Goede wrote:
> Hi David,
>=20
> On 11/1/22 20:10, David E. Box wrote:
> > Intel Software Defined Silicon (SDSi) is now known as Intel On Demand. =
The
> > following patches do the following:
> >=20
> > 1. Identify the driver/tools as Intel On Demand. Only text descriptions=
 are
> > changed. Kconfig and filenames remain the same.
> > 2. Perform some attribute cleanup by preventing the showing of files wh=
en
> > features are not supported.
> > 3. Adds support for a new GUID. GUIDs are used to identify the layout o=
f
> > the On Demand registers in sysfs. Layouts are described in the
> > documentation on github [1].
> > 4. Add support for reading On Demand meter certificates in sysfs.
> > 5. The rest of the patches modify the existing tool to support discover=
y
> > and reading of On Demand registers and the meter certificate.
> >=20
> > [1] https://github.com/intel/intel-sdsi/blob/master/os-interface.rst
> >=20
> > David E. Box (9):
> > =C2=A0 platform/x86/intel/sdsi: Add Intel On Demand text
> > =C2=A0 platform/x86/intel/sdsi: Hide attributes if hardware doesn't sup=
port
> > =C2=A0 platform/x86/intel/sdsi: Support different GUIDs
> > =C2=A0 platform/x86/intel/sdsi: Add meter certificate support
> > =C2=A0 tools/arch/x86: intel_sdsi: Add support for reading state certif=
icates
> > =C2=A0 tools/arch/x86: intel_sdsi: Add Intel On Demand text
> > =C2=A0 tools/arch/x86: intel_sdsi: Read more On Demand registers
> > =C2=A0 tools/arch/x86: intel_sdsi: Add support for new GUID
> > =C2=A0 tools/arch/x86: intel_sdsi: Add support for reading meter certif=
icates
>=20
> Thank you, over all this looks good. I have some small remarks
> on patches 4, 8 and 9 see my replies to those.
>=20
> Please prepare a v2 addressing Andy's + my review remarks and get
> that v2 to me no later then next week Tuesday, then I can still
> merge this in time for 6.2 .

Will do. Thanks Hans, Andy.

>=20
> Regards,
>=20
> Hans
>=20
>=20

