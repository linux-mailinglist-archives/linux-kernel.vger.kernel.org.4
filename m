Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBA16B18E9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCIBtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjCIBtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:49:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C0A8091A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 17:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678326588; x=1709862588;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=ynyyLkU64gZ+fFduDlkYav+op+9blkNz8x4B87ST38c=;
  b=jwEg8xWOryeRKqOequYH6klYacNK/nRb+NOMOGb8x+5H4OQB6dw9f+J+
   oXPcgjUfzYyRvMWpd8waPtaEs8hKnRPo8DbTecC340QXz0pYruxt7wU5I
   sZhr824Fdij8kpIK5EsCSST7NRRKRRLtximyEfbERnKRIpibjU/0t97gN
   hd0K54ZEEDM8QWXJOwEn0nC1uijamTzKTcaI1dPCo5SqrJS2noS+x2gde
   YVGSxPvua/DcjvM3hSl0e93hN7sy7LWL2JYjwEdpAODQHv17jxFDjdDoW
   mKCAyMlVSKFevb3MX4DYa8LbQ3jD2eMrd7j8adBk4mlYX58a4sx+fengk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="363964578"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="asc'?scan'208";a="363964578"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 17:49:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="679559150"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="asc'?scan'208";a="679559150"
Received: from debian-skl.sh.intel.com (HELO debian-skl) ([10.239.159.40])
  by fmsmga007.fm.intel.com with ESMTP; 08 Mar 2023 17:49:46 -0800
Date:   Thu, 9 Mar 2023 09:48:30 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf/x86/intel: use hexidecimal value for cpuid
Message-ID: <ZAk67tyBMde8k1C5@debian-scheme>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20230308031501.4688-1-zhenyuw@linux.intel.com>
 <20230308141619.GI2017917@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kQDGHQ6bVW4X2LBn"
Content-Disposition: inline
In-Reply-To: <20230308141619.GI2017917@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kQDGHQ6bVW4X2LBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023.03.08 15:16:19 +0100, Peter Zijlstra wrote:
> On Wed, Mar 08, 2023 at 11:15:01AM +0800, Zhenyu Wang wrote:
> > It's easier to use hexidecimal value instead of decimal for reading
> > and following with SDM doc, also align with other cpuid calls.
>=20
> *shrug*..
>=20
> > Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> > ---
> >  arch/x86/events/intel/core.c | 2 +-
> >  arch/x86/events/intel/lbr.c  | 2 +-
> >  arch/x86/events/intel/pt.c   | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index 14f0a746257d..5af084198c8f 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -5903,7 +5903,7 @@ __init int intel_pmu_init(void)
> >  	 * Check whether the Architectural PerfMon supports
> >  	 * Branch Misses Retired hw_event or not.
> >  	 */
> > -	cpuid(10, &eax.full, &ebx.full, &fixed_mask, &edx.full);
> > +	cpuid(0xA, &eax.full, &ebx.full, &fixed_mask, &edx.full);
> >  	if (eax.split.mask_length < ARCH_PERFMON_EVENTS_COUNT)
> >  		return -ENODEV;
>=20
> But now the data type names and the cpuid calls are no longer related.

oh, right, missed that. How about we change those too e.g union cpuid_0xa_e=
ax?

--kQDGHQ6bVW4X2LBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCZAk66gAKCRCxBBozTXgY
J4QVAKCNg0g+Y2/f8QRFEGaBrIpkUGZlTQCfYKWjU6RQJ+qpiSaMzkkaUJz9oUU=
=BvZw
-----END PGP SIGNATURE-----

--kQDGHQ6bVW4X2LBn--
