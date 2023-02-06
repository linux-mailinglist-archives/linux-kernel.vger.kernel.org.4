Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B2868B95C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBFKDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBFKDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:03:31 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922E5206B8;
        Mon,  6 Feb 2023 02:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675677752; x=1707213752;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=l/jB10VfqD0L4qSawHdyiw+glHCPUi3lamewwVD2rIY=;
  b=CxRpq+X7kE25ISU6epgOyDvE8r45MKnadFMkFabzrzvCJHvFn/5RQgJc
   CQ0dLGDes64c33MQJBow9h9IMWW34lYp4CasMCnHLL5EZ9T3EoO9WQvwm
   ViVyNuVQW+Pwol6ab1+++jepQURLytxCXQNkwAx8IytjaLSZHEXr+5XMg
   BYpP53kYsNsssCjW8fpxLzuYtuuWffT0022ME9J5THqCKWMrZNBwzEgoX
   GOSU06UiLHXqfxJq+Q+DXhk+5gBd5cNLA5jIZZPupIxm/DG4XJ9p12HWx
   0ZwSVplpSFHW9+aE44hfhAqxRhHsstfLooeOVcQe2GbQb7xRbdiQWJZTT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="330463128"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="330463128"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 02:02:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="775123018"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="775123018"
Received: from gvenka5x-mobl.gar.corp.intel.com ([10.215.125.12])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 02:02:28 -0800
Message-ID: <f33bc346d8d4ae086ddf59db2670ce9a8f80a250.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/2] intel_powerclamp: New module parameter
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Date:   Mon, 06 Feb 2023 02:02:28 -0800
In-Reply-To: <468eedb9d8a839d22ffd18125d3104f8c014965c.camel@intel.com>
References: <20230205025902.2899734-1-srinivas.pandruvada@linux.intel.com>
         <a68a6f8c76cb719cd4865bd6aa726306772d4ee3.camel@intel.com>
         <60514763753f572f854f1bbf287c3c16fbbc12c3.camel@linux.intel.com>
         <468eedb9d8a839d22ffd18125d3104f8c014965c.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
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

On Mon, 2023-02-06 at 08:05 +0000, Zhang, Rui wrote:
> On Sun, 2023-02-05 at 18:45 -0800, srinivas pandruvada wrote:
> > Hi Rui,
> >=20
> > On Sun, 2023-02-05 at 15:57 +0000, Zhang, Rui wrote:
> > > Hi, Srinivas,
> > >=20
> > > First of all, the previous build error is gone.
> > >=20
> > > Second, I found something strange, which may be related with the
> > > scheduler asym-packing, so CC Ricardo.
> > >=20
> > I thought you disable ITMT before idle injection and reenebale
> > after
> > removal.
>=20
> No.
>=20
> I can reproduce this by playing with raw intel_powerclamp sysfs knobs
> and ITMT enabled.
>=20

This issue is happening even if ITMT disabled. If the module mask is
composed of P-cores it works or even on servers as expected.
Also if you offline all P-cores then select mask among E-cores, it is
working. Somehow P-core influences E-cores.

Since this patch is module mask related, that is functioning correctly.
We have to debug this interaction with P and E cores separately.

Thanks,
Srinivas


> >=20
> >=20
> >=20
> > > The test is done with pm linux-intel branch
>=20
> sorry, I mean linux-next branch.
>=20
> > > =C2=A0+ this patch series on an
> > > ADL system.
> > Can you do test on bleeding edge branch of Linux-pm?
> >=20
> > > =C2=A0cpu0~cpu7 are Pcore cpus, cpu8-cpu15 are Ecore cpus, and
> > > intel_powerclamp is register as cooling_device21.
> > >=20
> > > 1. run stress -c 16
> > > 2. update /sys/module/intel_powerclamp/parameters/cpumask
> > > =C2=A0=C2=A0 echo 90 > /sys/module/intel_powerclamp/parameters/max_id=
le
> > > 3. echo 90 > /sys/class/thermal/cooling_device21/cur_state
> > > 4. echo 0 > /sys/class/thermal/cooling_device21/cur_state
> > > I use turbostat to monitor the CPU Busy% in all 4 steps.
> > >=20
> > > If 'cpumask' does not include all the Ecore CPUs, all CPUs
> > > becomes
> > > 100%
> > > busy after idle injection removed in step 4.
> > >=20
> > that should be the case.
> >=20
> > > If 'cpumask' includes all the Ecore CPUs, i.e. cpumask =3D FFxy, in
> > > some
> > > cases, the Ecore CPUs will drop to an Busy% much lower than 10%,
> > > and
> > > then they don't come back to busy after idle injection removed in
> > > step
> > =C2=A0Do you see that idle injection is removed message in dmesg?
>=20
> yes.
>=20
> > We can also check powercap idle-inejct, if some CPUs still not wake
> > from play_idle.
>=20
> "ps" command shows the the idle_injection threads time is not
> increasing any more.
>=20
> >=20
> >=20
> > > 4, although we have 16 stress threads. And this also relates with
> > > how
> > > long we stay in idle injection.
> > >=20
> > > Say, when cpumask=3Dfff3, the problem can be triggered occasionally
> > > if
> > > there is a 10 second timeout between step 3 and step4, but it is
> > > much
> > > easier to reproducible if I increase the timeout to 20 seconds.
> > >=20
> > > It seems that Pcore can always pull tasks from Ecores, but Ecore
> > > can
> > > not pull tasks from Pcore HT siblings.
> > >=20
> > That will be regular load balance threads should do.
> > Better to try upsteam kernel first.
>=20
> I'm already running with linux-pm tree linux-next branch + this patch
> series.
>=20
> thanks,
> rui
>=20
> >=20
> > Thanks,
> > Srinivas
> >=20
> >=20
> > > thanks,
> > > rui
> > >=20
> > > On Sat, 2023-02-04 at 18:59 -0800, Srinivas Pandruvada wrote:
> > > > Split from the series for powerclamp user of powercap idle-
> > > > inject.
> > > >=20
> > > > v2
> > > > - Build warnings reported by Rui
> > > > - Moved the powerclamp documentation to admin guide folder
> > > > - Commit log updated as suggested by Rafael and other code
> > > > suggestion
> > > >=20
> > > > Srinivas Pandruvada (2):
> > > > =C2=A0 Documentation:admin-guide: Move intel_powerclamp
> > > > documentation
> > > > =C2=A0 thermal/drivers/intel_powerclamp: Add two module parameters
> > > >=20
> > > > =C2=A0Documentation/admin-guide/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0.../thermal/intel_powerclamp.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 22 +++
> > > > =C2=A0Documentation/driver-api/thermal/index.rst=C2=A0=C2=A0=C2=A0 =
|=C2=A0=C2=A0 1 -
> > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0drivers/thermal/intel/intel_powerclamp.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 177
> > > > +++++++++++++++-
> > > > --
> > > > =C2=A05 files changed, 180 insertions(+), 22 deletions(-)
> > > > =C2=A0rename Documentation/{driver-api =3D> admin-
> > > > guide}/thermal/intel_powerclamp.rst (93%)
> > > >=20

