Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87968B436
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 03:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBFCpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 21:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFCpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 21:45:33 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2EF1A94D;
        Sun,  5 Feb 2023 18:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675651531; x=1707187531;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QVLjhhaCJdAM7tDb08iqj5/bnGUsqsY+9Srfl63ErX0=;
  b=O71z6xQSnt+fOKP2F2JXTP1+GcJZjVXdWdfXNxcUgFf5ttWj+sdn/HtM
   +kxxJat70B4v56X1Qs71AYSgGHiLFbjTd5E0GQg1YtqnCq9+9o1w5lZ3E
   oI22cjhCPMI3Za41rrOVGF8FsKwzBa6RD0nr+XS3Jx6mkjj8mI2SnNbjt
   qEiBbyS765ERfwMSy5WukuCMc0FTHTDKg62EhzGRMnmaDr/YzQgC7Qwuu
   No7r25o7D/vJw+agPPWikaNNPx/Z9O0nxTW6G9RuWv7WdQFHDV0riUWrO
   UsY1Uk4bz+QanFbEtBuAXn98YSns6MponGf0/d9MkukkGALrYxXBtVJ5Q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="415339189"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="415339189"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 18:45:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="755105735"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="755105735"
Received: from gvenka5x-mobl.gar.corp.intel.com ([10.215.125.12])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 18:45:28 -0800
Message-ID: <60514763753f572f854f1bbf287c3c16fbbc12c3.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/2] intel_powerclamp: New module parameter
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Date:   Sun, 05 Feb 2023 18:45:20 -0800
In-Reply-To: <a68a6f8c76cb719cd4865bd6aa726306772d4ee3.camel@intel.com>
References: <20230205025902.2899734-1-srinivas.pandruvada@linux.intel.com>
         <a68a6f8c76cb719cd4865bd6aa726306772d4ee3.camel@intel.com>
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

Hi Rui,

On Sun, 2023-02-05 at 15:57 +0000, Zhang, Rui wrote:
> Hi, Srinivas,
>=20
> First of all, the previous build error is gone.
>=20
> Second, I found something strange, which may be related with the
> scheduler asym-packing, so CC Ricardo.
>=20
I thought you disable ITMT before idle injection and reenebale after
removal.



> The test is done with pm linux-intel branch + this patch series on an
> ADL system.
Can you do test on bleeding edge branch of Linux-pm?

>  cpu0~cpu7 are Pcore cpus, cpu8-cpu15 are Ecore cpus, and
> intel_powerclamp is register as cooling_device21.
>=20
> 1. run stress -c 16
> 2. update /sys/module/intel_powerclamp/parameters/cpumask
> =C2=A0=C2=A0 echo 90 > /sys/module/intel_powerclamp/parameters/max_idle
> 3. echo 90 > /sys/class/thermal/cooling_device21/cur_state
> 4. echo 0 > /sys/class/thermal/cooling_device21/cur_state
> I use turbostat to monitor the CPU Busy% in all 4 steps.
>=20
> If 'cpumask' does not include all the Ecore CPUs, all CPUs becomes
> 100%
> busy after idle injection removed in step 4.
>=20
that should be the case.

> If 'cpumask' includes all the Ecore CPUs, i.e. cpumask =3D FFxy, in
> some
> cases, the Ecore CPUs will drop to an Busy% much lower than 10%, and
> then they don't come back to busy after idle injection removed in
> step
 Do you see that idle injection is removed message in dmesg?
We can also check powercap idle-inejct, if some CPUs still not wake=20
from play_idle.


> 4, although we have 16 stress threads. And this also relates with how
> long we stay in idle injection.
>=20
> Say, when cpumask=3Dfff3, the problem can be triggered occasionally if
> there is a 10 second timeout between step 3 and step4, but it is much
> easier to reproducible if I increase the timeout to 20 seconds.
>=20
> It seems that Pcore can always pull tasks from Ecores, but Ecore can
> not pull tasks from Pcore HT siblings.
>=20
That will be regular load balance threads should do.
Better to try upsteam kernel first.

Thanks,
Srinivas


> thanks,
> rui
>=20
> On Sat, 2023-02-04 at 18:59 -0800, Srinivas Pandruvada wrote:
> > Split from the series for powerclamp user of powercap idle-inject.
> >=20
> > v2
> > - Build warnings reported by Rui
> > - Moved the powerclamp documentation to admin guide folder
> > - Commit log updated as suggested by Rafael and other code
> > suggestion
> >=20
> > Srinivas Pandruvada (2):
> > =C2=A0 Documentation:admin-guide: Move intel_powerclamp documentation
> > =C2=A0 thermal/drivers/intel_powerclamp: Add two module parameters
> >=20
> > =C2=A0Documentation/admin-guide/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0.../thermal/intel_powerclamp.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 22 +++
> > =C2=A0Documentation/driver-api/thermal/index.rst=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 -
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/thermal/intel/intel_powerclamp.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 177
> > +++++++++++++++-
> > --
> > =C2=A05 files changed, 180 insertions(+), 22 deletions(-)
> > =C2=A0rename Documentation/{driver-api =3D> admin-
> > guide}/thermal/intel_powerclamp.rst (93%)
> >=20

