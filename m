Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9266942AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjBMKTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjBMKT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:19:29 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294991815B;
        Mon, 13 Feb 2023 02:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676283556; x=1707819556;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=I9F1qR4NteqwtlKM1//KDqNo9wf1t44txFT2AWm9PnY=;
  b=n5sBir7JxoNVkhYY5D9X/5wgiGVQ6GNXDc7U7jh5NjjDoIQHiP6qAM6q
   sFoE9VBofBa2mx3Tv8did1uUs+Mpwrtb3s6sICyP+1p26wKGOQ1rmfh/o
   FWEqa6y81rUTNh4yGrPDSKxsqpp2dMiabvafFikLiiubytgQbwNkSU8pS
   rLnOPWqSfl7kWkRt6PRnmkqgNXLXbF5+IKv7occ3RsLllNChs9PYyOfo8
   UheiDr9RudifqNfrg0WLxEvMW/h/kS2IEY6GA6VKQi3r9Qu0xtg2ZFbK/
   fzf5hCV/XrzPSxHDctX9bhjw95D2gBWJVF1gXcn68ETzEYDWzFHDJg5wC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="332996174"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="332996174"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 02:18:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="662132180"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="662132180"
Received: from pranavk3-mobl.gar.corp.intel.com ([10.213.82.89])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 02:18:26 -0800
Message-ID: <f6fc39d2060c964d32b6610956b66e8d3151d926.camel@linux.intel.com>
Subject: Re: [PATCH 0/3] Documentation fixes for thermal/bleeding-edge
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
        oe-kbuild-all@lists.linux.dev
Date:   Mon, 13 Feb 2023 02:18:23 -0800
In-Reply-To: <20230213100800.28333-1-bagasdotme@gmail.com>
References: <20230213100800.28333-1-bagasdotme@gmail.com>
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

On Mon, 2023-02-13 at 17:07 +0700, Bagas Sanjaya wrote:
> Here are documentation fixes for thermal/bleeding-edge tree. The
> first two patches are fixes to recently reported kernel test robot
> reports whereas the third patch is cosmetical (formatting).
>=20
I am fine picking up this patchset over mine, as this series has  one
additional fix.

	[thermal-bleeding-edge][PATCH] thermal: intel: powerclamp: Fix
warnings

Thanks,
Srinivas


> Bagas Sanjaya (3):
> =C2=A0 Documentation: admin-guide: Add toctree entry for thermal docs
> =C2=A0 Documentation: powerclamp: Escape wildcard in cpumask description
> =C2=A0 Documentation: powerclamp: Fix numbered lists formatting
>=20
> =C2=A0Documentation/admin-guide/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0Documentation/admin-guide/thermal/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 8 ++++++++
> =C2=A0.../admin-guide/thermal/intel_powerclamp.rst=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 15 +++++++++----
> --
> =C2=A03 files changed, 18 insertions(+), 7 deletions(-)
> =C2=A0create mode 100644 Documentation/admin-guide/thermal/index.rst
>=20
>=20
> base-commit: 1c7337f9eef60b8ce8a4b8c96d197e230d60b6b2

