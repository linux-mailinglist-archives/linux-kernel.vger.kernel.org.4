Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7682769428A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjBMKRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjBMKR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:17:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078462694;
        Mon, 13 Feb 2023 02:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676283446; x=1707819446;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=zeloRDIsdgzAHn0ZJQF6AbWhXizumlB5mC7D3T++dzA=;
  b=RH5323N3Q1MHSDFwSmWGPig7+64BQn4/tCNCgSybETKY31TCjfmM8ixx
   lkE8BdkZHnVqm93zs0TSKBefeRPTl9ooM/3FesWGUSxi7V838HKeVs48Z
   A/IZ9Qvf8p1XwLdudnP871lksJxV4AhEScLI5ZWDfEgyv5CaF/Q3kdJop
   0AxL+xTfP/al2V8gwuyWoGJkNm9GQsI54kTgmwSkcC4p1jqSBdTM8ebI1
   2uIr/0Ni2Q1qnlEUvmBxEx0GsYTzxXJPo5SK35v18G9TjLbJwm3AGtIUy
   qHUlresxXJJJvjwgzDhShz5mNVIypjku1bNs2HSgZBFYMUjp4LKuYvI7s
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="395470642"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="395470642"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 02:17:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="737461951"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="737461951"
Received: from pranavk3-mobl.gar.corp.intel.com ([10.213.82.89])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 02:17:05 -0800
Message-ID: <8367d92de90afaaa7ec5fac1dbcc0337ab641cb6.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] Documentation: powerclamp: Escape wildcard in
 cpumask description
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
Date:   Mon, 13 Feb 2023 02:17:02 -0800
In-Reply-To: <20230213100800.28333-3-bagasdotme@gmail.com>
References: <20230213100800.28333-1-bagasdotme@gmail.com>
         <20230213100800.28333-3-bagasdotme@gmail.com>
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

Hi Sanjaya,

On Mon, 2023-02-13 at 17:08 +0700, Bagas Sanjaya wrote:
> kernel test robot reported htmldocs warning:
>=20
> Documentation/admin-guide/thermal/intel_powerclamp.rst:328: WARNING:
> Inline emphasis start-string without end-string.
>=20
> The mistaken asterisk in /proc/irq/*/smp_affinity is rendered as
> hyperlink
> as the result.
>=20
I submitted a patch=20
	[thermal-bleeding-edge][PATCH] thermal: intel: powerclamp: Fix
warnings.

Thanks,
Srinivas

> Escape the asterisk to fix above warning.
>=20
> Link:
> https://lore.kernel.org/linux-doc/202302122247.N4S791c4-lkp@intel.com/
> Fixes: ebf51971021881 ("thermal: intel: powerclamp: Add two module
> parameters")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> =C2=A0Documentation/admin-guide/thermal/intel_powerclamp.rst | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/admin-guide/thermal/intel_powerclamp.rst
> b/Documentation/admin-guide/thermal/intel_powerclamp.rst
> index 2d9d2d739f0256..f919fbe1cdd942 100644
> --- a/Documentation/admin-guide/thermal/intel_powerclamp.rst
> +++ b/Documentation/admin-guide/thermal/intel_powerclamp.rst
> @@ -326,7 +326,7 @@ Module Parameters
> =C2=A0
> =C2=A0``cpumask`` (RW)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0A bit mask of CPUs to inj=
ect idle. The format of the bitmask
> is same as
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0used in other subsystems like =
in /proc/irq/*/smp_affinity.
> The mask is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0used in other subsystems like =
in /proc/irq/\*/smp_affinity.
> The mask is
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0comma separated 32 bit gr=
oups. Each CPU is one bit. For
> example for a 256
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU system the full mask =
is:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ffffffff,ffffffff,fffffff=
f,ffffffff,ffffffff,ffffffff,fffffff
> f,ffffffff

