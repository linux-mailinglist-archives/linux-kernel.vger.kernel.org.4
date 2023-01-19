Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D517672E81
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjASByV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjASBxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:53:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45766F89D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674092993; x=1705628993;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=z+r26atOHYpjx3EjwFle3hiTih2WoOd+oZxdqvV1Bc8=;
  b=SkUQP+5q68RIKK2kUZZuiIO8J5VcicyVw5kbbj2lLam7pFo7Ujniu9lF
   pvkKxpZgcWHhFXeF1Xo8CGSdHm9/iidQN5qeN3yQ1mHR+BlEInPEDYwEa
   mZZ05c7bTvBaalrXvy2wXygljo6OlWj8i3sMom9+TI1iA2x+ERlzb3hOK
   eqCb0kZWtdTwlq4alP75WhHWiXp4ot6Wu+FOhHVJBEy0xnmgKBlNDQsdJ
   ytG5cXTRFWacCPzbAa2N1hhsl/+QMpgqiTVdH3o1lTovFA+DE+XP2CiHs
   KRrgG/iZwu2BbaiNRUqWRAYKeSBgOspuoVWcD4kZFMCLCBZ0mnM5T7WLW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="313039117"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="asc'?scan'208";a="313039117"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:49:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="661957728"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="asc'?scan'208";a="661957728"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.159.108])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jan 2023 17:49:49 -0800
Date:   Thu, 19 Jan 2023 09:28:52 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [PATCH] drm/i915/gvt: Remove extra semicolon
Message-ID: <Y8ic1B4erlEuWk9V@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <Y8LNbzgTf/1kYJX/@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rBD0G7EoTHOadgGA"
Content-Disposition: inline
In-Reply-To: <Y8LNbzgTf/1kYJX/@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rBD0G7EoTHOadgGA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023.01.14 21:12:39 +0530, Deepak R Varma wrote:
> Remove the extra semicolon at end. Issue identified using
> semicolon.cocci Coccinelle semantic patch.
>=20
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/gpu/drm/i915/gvt/vgpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/v=
gpu.c
> index a5497440484f..08ad1bd651f1 100644
> --- a/drivers/gpu/drm/i915/gvt/vgpu.c
> +++ b/drivers/gpu/drm/i915/gvt/vgpu.c
> @@ -323,7 +323,7 @@ int intel_gvt_create_vgpu(struct intel_vgpu *vgpu,
>  	ret =3D idr_alloc(&gvt->vgpu_idr, vgpu, IDLE_VGPU_IDR + 1, GVT_MAX_VGPU,
>  		GFP_KERNEL);
>  	if (ret < 0)
> -		goto out_unlock;;
> +		goto out_unlock;
> =20
>  	vgpu->id =3D ret;
>  	vgpu->sched_ctl.weight =3D conf->weight;
> --=20

Thanks for catching that!

Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>

--rBD0G7EoTHOadgGA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCY8ic1AAKCRCxBBozTXgY
J4oSAJ0b42wwImxB+8ewhGLo62rlJ/h5RQCfdBJOl5fRSYVgpckeJlWrImX8bCQ=
=c61Z
-----END PGP SIGNATURE-----

--rBD0G7EoTHOadgGA--
