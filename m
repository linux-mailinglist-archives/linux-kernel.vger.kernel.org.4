Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDB4693277
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBKQdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBKQdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:33:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B9726CF4;
        Sat, 11 Feb 2023 08:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676133187; x=1707669187;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=OMMsvl+bUPjHIfFs5mz9bCDS3SOP8YrQweMO/MZJftc=;
  b=M9Tw8Zfr5iNEXR6swL1rEe0ss6Mc7Ijg5vAuC2ytMosBF7dNUF5tug2z
   W1p+eJaHXOxgEOtPGP6j0XvGent/VMaDxO3+TEX/eny/h2DQsVP9XgxRg
   O5xGPalkGIj/bkvsoSDV4r+n9oDNOFAz9hKJKt9QT0vdsnMvm5ueC7jvR
   JQoHMmrLnuuAEZ3RdT8r9HtKFFv+KEO59DMf/pJ6iN2T/uNzDg2xQW+kE
   behILSFf0+vo/4DJB+eZlYb8ididTWi53zuUEBLi3N3ItLDqeQfsRrmVl
   mNOdi7cM8udj65NwSXKdTtPitB9sMMdbOVwcc3p2aA3gGXA/c4MZ5f6I+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="314267315"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="314267315"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 08:33:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="732029288"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="732029288"
Received: from ajaymv-mobl1.gar.corp.intel.com ([10.215.205.181])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 08:32:51 -0800
Message-ID: <258dedb542d4dcb73e9ec903d205ba64639c9f0a.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: Remove core header inclusion from drivers
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Haowen Bai <baihaowen@meizu.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "open list:THERMAL DRIVER FOR AMLOGIC SOCS" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Date:   Sat, 11 Feb 2023 08:32:48 -0800
In-Reply-To: <9a121d43-b6d9-fe99-1e4c-498dac2e6b17@linaro.org>
References: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
         <20230211021023.GA13306@ranerica-svr.sc.intel.com>
         <9a121d43-b6d9-fe99-1e4c-498dac2e6b17@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-02-11 at 08:53 +0100, Daniel Lezcano wrote:
> On 11/02/2023 03:10, Ricardo Neri wrote:
> > On Mon, Feb 06, 2023 at 04:34:29PM +0100, Daniel Lezcano wrote:
> > > As the name states "thermal_core.h" is the header file for the
> > > core
> > > components of the thermal framework.
> > >=20
> > > Too many drivers are including it. Hopefully the recent cleanups
> > > helped to self encapsulate the code a bit more and prevented the
> > > drivers to need this header.
> > >=20
> > > Remove this inclusion in every place where it is possible.
> > >=20
> > > Some other drivers did a confusion with the core header and the
> > > one
> > > exported in linux/thermal.h. They include the former instead of
> > > the
> > > latter. The changes also fix this.
> > >=20
> > > The tegra/soctherm driver still remains as it uses an internal
> > > function which need to be replaced.
> > >=20
> > > The Intel HFI driver uses the netlink internal framework core and
> > > should be changed to prevent to deal with the internals.
> >=20
> > I don't see any of the thermal netlink functionality exposed. Is
> > there any work in progress?
>=20
> commit bd30cdfd9bd73b68e4977ce7c5540aa7b14c25cd
> Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 thermal: intel: hfi: Notify user space for HFI e=
vents
>=20
This is already exposed and we use it in user space.
thermal_genl_cpu_capability_event() is called from intel_hfi driver to
send the cpu capabilities.

Not sure what do you mean by  "don't see netlink functionality
exposed"?

thermal_genl_cpu_caps struct and thermal_genl_cpu_capability_event()
are defined in drivers/thermal/thermal_netlink.h.


Thanks,
Srinivas


>=20
> > FWIW, Acked-by: Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com>
>=20
> Thanks!
>=20

