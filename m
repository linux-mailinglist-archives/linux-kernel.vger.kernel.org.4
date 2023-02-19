Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6288969C03C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 13:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBSMy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 07:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBSMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 07:54:58 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89537CDC6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 04:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676811297; x=1708347297;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=NNDwZfUMtL5OJSQoDDPSDAV3GwPyQ1sNDZyWlm4WfnU=;
  b=UaKwyfcjsDDopjkhs101O2jrb9j945Hw0qL1mujIRwxIE1FL2if31fkY
   kKpgabJBIqvi4/+LZa4MPAs7lvgDPv2UsdwF5w9+ISNTNzMImUI4OL/lb
   yFC3NKWYM17xpFCK+0rvUlHNbs+5zyf6Twtv0I/Cg1rc9l9sHbPlbRR3L
   4TBtNRz/vyX6mxElNz4py8r6wi4qUsW4FjuM/CHqD8FSrRRjKdH/8aDvR
   vXeSGRbD9anf6b/TAbVUJ11CsUI/mZ5oY/DYlm7Iy2+b4YIT8tpDi595I
   OsU9Sz0GU27KtySC5kPZ+0cEhPp/RUa2uTZiGq4EpRpxulBCthfExmTVO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="329961553"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="asc'?scan'208";a="329961553"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 04:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="794912770"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="asc'?scan'208";a="794912770"
Received: from debian-skl.sh.intel.com (HELO debian-skl) ([10.239.159.40])
  by orsmga004.jf.intel.com with ESMTP; 19 Feb 2023 04:54:54 -0800
Date:   Sun, 19 Feb 2023 20:52:57 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: move a Kconfig symbol to unbreak the menu
 presentation
Message-ID: <Y/IbqTv0yOcPl3yP@debian-scheme>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20230215044533.4847-1-rdunlap@infradead.org>
 <Y+7d7xKjjzRnV9eI@debian-scheme>
 <bd1597ba-21c9-e1a8-8851-4e7c95b28b65@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bCCMBWSwmp2FPuGZ"
Content-Disposition: inline
In-Reply-To: <bd1597ba-21c9-e1a8-8851-4e7c95b28b65@infradead.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCCMBWSwmp2FPuGZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023.02.16 22:32:33 -0800, Randy Dunlap wrote:
> Hi,
>=20
> On 2/16/23 17:52, Zhenyu Wang wrote:
> > On 2023.02.14 20:45:33 -0800, Randy Dunlap wrote:
> >> Inserting a Kconfig symbol that does not have a dependency (DRM_I915_G=
VT)
> >> into a list of other symbols that do have a dependency (on DRM_I915)
> >> breaks the driver menu presentation in 'make *config'.
> >>
> >=20
> > I'm not sure what's the actual failure in presentation, I'm not quite f=
amiliar
> > with Kconfig, could you help to elaborate?
> >=20
> > thanks!
>=20
> For menuconfig and nconfig, it's a subtle difference. The following menu
> items are indented more after the patch (i.e., they are not indented enou=
gh
> before the patch):
>=20
>  =E2=94=82 <M>   Enable KVM host support Intel GVT-g graphics virtualizat=
ion          =E2=94=82
>  =E2=94=82 [*]   Enable Intel PXP support                                =
             =E2=94=82
>  =E2=94=82       drm/i915 Debugging  --->                                =
             =E2=94=82
>  =E2=94=82       drm/i915 Profile Guided Optimisation  --->
>=20
> Same menu items for gconfig: they should all be subordinate (so indented)
> to the main
> <M> Intel 8xx/9xx/G3x/G4x/HD Graphics
> menu.
>=20
> For xconfig, it's worse. "drm/i915 Debugging" and "drm/i915 Profile Guide=
d Optimisation"
> are shown on the left side window, while are of the other i915 options ar=
e shown in the
> right side window (before the patch).
> After the patch, all subordinate options are listed in the right side win=
dow under the
> main "Intel 8xx/9xx/G3x/G4x/HD Graphics" menu item.
>=20
> See attached photos for comparisons.
>=20

I wasn't awared of the wrong indentation. Thanks a lot, Randy!

Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>

--bCCMBWSwmp2FPuGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCY/IbpQAKCRCxBBozTXgY
J7KqAJ9ai4/UyyDGoRUOJQD34MJmFdFyvQCfYnyyPgV1EKMhMrDKUnh9nVBfBeY=
=nrt2
-----END PGP SIGNATURE-----

--bCCMBWSwmp2FPuGZ--
