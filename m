Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EB569A3A0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBQBzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBQBzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:55:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F9A54D55
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 17:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676598893; x=1708134893;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=KxsdkInmDbLs1ts10qe+vX5Ued6X/Q+YDmUjfhe22wM=;
  b=iSe3kfH76Alv5FwkPF7LDPSIfjiOVNQmvdSgoaZDpNLqg33+SGjD0vYT
   iwrE+pvZVZNwEhV1fEAMT3LAltWxWiigUV9ALZYx5GkzFCa1K5MtpZQmS
   K0RS1DS4ax2b/vo3zAFWl/xnXJhQtO0adEE1ebnv/NrUuJJka63cvrzkJ
   UxfP6pfZHuT0Ga7rPP6/pWd4gzRUSrUJreOskvzj/muLYGTSIMJ6hvPGN
   0xTzXcqAfmfaTTi+NKPojdg30Lm/DoT/ESHXsJzTfmGCBQbq/nRledq9O
   4tw08DeSIeFKHIkUuYltpX24YZGS9hKPcWM1VR22mp6XqzNF4BdRU2r8T
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="315600538"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="asc'?scan'208";a="315600538"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 17:54:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="779620659"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="asc'?scan'208";a="779620659"
Received: from debian-skl.sh.intel.com (HELO debian-skl) ([10.239.159.40])
  by fmsmga002.fm.intel.com with ESMTP; 16 Feb 2023 17:54:49 -0800
Date:   Fri, 17 Feb 2023 09:52:47 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: move a Kconfig symbol to unbreak the menu
 presentation
Message-ID: <Y+7d7xKjjzRnV9eI@debian-scheme>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20230215044533.4847-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5hYsGdP+X0l/BA8e"
Content-Disposition: inline
In-Reply-To: <20230215044533.4847-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5hYsGdP+X0l/BA8e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023.02.14 20:45:33 -0800, Randy Dunlap wrote:
> Inserting a Kconfig symbol that does not have a dependency (DRM_I915_GVT)
> into a list of other symbols that do have a dependency (on DRM_I915)
> breaks the driver menu presentation in 'make *config'.
>

I'm not sure what's the actual failure in presentation, I'm not quite famil=
iar
with Kconfig, could you help to elaborate?

thanks!

> Relocate the DRM_I915_GVT symbol so that it does not cause this
> problem.
>=20
> Fixes: 8b750bf74418 ("drm/i915/gvt: move the gvt code into kvmgt.ko")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Zhi Wang <zhi.a.wang@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: intel-gvt-dev@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/i915/Kconfig |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff -- a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -118,9 +118,6 @@ config DRM_I915_USERPTR
> =20
>  	  If in doubt, say "Y".
> =20
> -config DRM_I915_GVT
> -	bool
> -
>  config DRM_I915_GVT_KVMGT
>  	tristate "Enable KVM host support Intel GVT-g graphics virtualization"
>  	depends on DRM_I915
> @@ -172,3 +169,6 @@ menu "drm/i915 Unstable Evolution"
>  	depends on DRM_I915
>  	source "drivers/gpu/drm/i915/Kconfig.unstable"
>  endmenu
> +
> +config DRM_I915_GVT
> +	bool

--5hYsGdP+X0l/BA8e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCY+7d6wAKCRCxBBozTXgY
J7p1AJ0dpqaZlCp0zdaSe3bAKO9rzkAeCACfV8FiMvxk2oTD7qWMr14oNevlGlA=
=2r4O
-----END PGP SIGNATURE-----

--5hYsGdP+X0l/BA8e--
