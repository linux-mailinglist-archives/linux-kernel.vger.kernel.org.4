Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592FB69198B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjBJIEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjBJIEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:04:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862DF80749;
        Fri, 10 Feb 2023 00:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676016269; x=1707552269;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=a7MA+GtVuWSR1Qinoc/FAkxpzhjV9HHl4RxnApxEqVc=;
  b=Ov7dFUYb1fCATlwr9Y7bZFZlQ8l+bZZN5NqqHIIL9gbjRZOGm7vFzS9b
   D2tzvqB9uJ8v94J+GlWwlqDRXm+m+x0KoKiUXwZLxeBxj7H1I2E4OXojf
   PcgqBHls46qjT+/FybEifvdysTopftnOYfxPK380W0PIwbIHYPJiynV7v
   ATVM+tFJXES8Ikt7Oq5VSDfNj7xUMTQQiwrS3HSbBLU6IgtYmGWd4Wrh+
   i64LQH6Lfm4KRtnOcQak7b/R1OcV09W8ZWrxiVwsG+EXZndGYgKetClsr
   VLHNBxAjK8JlVHImIpB4Cnqjg+Aqi4S+2NSs1IyG3nNWvrlLqftDx9oUM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="309996388"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="309996388"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 00:04:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="667963780"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="667963780"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.8])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 00:04:29 -0800
Message-ID: <6f51fcb89d0f1aad5d4f4e2cacb407a620454886.camel@linux.intel.com>
Subject: Re: [PATCH 0/7] Add TPMI support
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 Feb 2023 00:04:28 -0800
In-Reply-To: <918ac0c5-9f35-0099-5be8-6dbc72aa88e9@redhat.com>
References: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
         <918ac0c5-9f35-0099-5be8-6dbc72aa88e9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, 2023-02-06 at 13:49 +0100, Hans de Goede wrote:
> Hi,
>=20
> On 2/2/23 02:07, Srinivas Pandruvada wrote:
>=20
>=20
[...]

> Thank you for your patch-series, I've applied the series to my
> review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x8=
6.git/log/?h=3Dreview-hans
>=20
>=20
Thanks for the help here.

> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
>=20
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
I guess this will appear in 6.3 merge window.

Can I post next set of patches (targeted for 6.4)?

Thanks,
Srinivas

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
>=20
> > Srinivas Pandruvada (7):
> > =C2=A0 platform/x86/intel/vsec: Add TPMI ID
> > =C2=A0 platform/x86/intel/vsec: Enhance and Export intel_vsec_add_aux()
> > =C2=A0 platform/x86/intel/vsec: Support private data
> > =C2=A0 platform/x86/intel: Intel TPMI enumeration driver
> > =C2=A0 platform/x86/intel/tpmi: Process CPU package mapping
> > =C2=A0 platform/x86/intel/tpmi: ADD tpmi external interface for tpmi
> > feature
> > =C2=A0=C2=A0=C2=A0 drivers
> > =C2=A0 MAINTAINERS: Add entry for TPMI driver
> >=20
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> > =C2=A0drivers/platform/x86/intel/Kconfig=C2=A0 |=C2=A0 13 +
> > =C2=A0drivers/platform/x86/intel/Makefile |=C2=A0=C2=A0 4 +
> > =C2=A0drivers/platform/x86/intel/tpmi.c=C2=A0=C2=A0 | 415
> > ++++++++++++++++++++++++++++
> > =C2=A0drivers/platform/x86/intel/vsec.c=C2=A0=C2=A0 |=C2=A0 21 +-
> > =C2=A0drivers/platform/x86/intel/vsec.h=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> > =C2=A0include/linux/intel_tpmi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 30 ++
> > =C2=A07 files changed, 490 insertions(+), 5 deletions(-)
> > =C2=A0create mode 100644 drivers/platform/x86/intel/tpmi.c
> > =C2=A0create mode 100644 include/linux/intel_tpmi.h
> >=20
>=20

