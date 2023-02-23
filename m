Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A666A0286
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjBWFqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBWFqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:46:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F1E2D153;
        Wed, 22 Feb 2023 21:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677131206; x=1708667206;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=5LUNYswzjNRR62NCzZouZlNn0t25R/Y0NvLZYy4sFJw=;
  b=VDcPoTjapyPXdmEvrJ/Ul1EWBBDCvUNXD3/kgjHTMNQD1G9+t89RQ6Yq
   PljBkcXmgXt6i1sVEirsDbnQKT6Xzbl9LhjQV75WRDEnT0Jvm25GLrSj9
   SNUX8+eWQsYIFwJj4d0fa/J9HfFKkXiYUBZ5KiGfz2XwpNSGWBPLBdswf
   X2L5EKxxU9pG/3B+5ygUpdFpOSTWq80dC7K0MZzpKia/ahbG+qlZmhfdy
   cb8uStmxqMKkunc++hE2E+PkZOXi2+E4fVdjnb5c4w8NsOj1d8/tNxd8z
   sjl2G9wuiNlKajl1zdhQ3A29yQtWH6UcEgKTLZI06S15bPgrZKYN9l5Eg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="360610228"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="asc'?scan'208";a="360610228"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 21:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="674390236"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="asc'?scan'208";a="674390236"
Received: from debian-skl.sh.intel.com (HELO debian-skl) ([10.239.159.40])
  by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2023 21:46:42 -0800
Date:   Thu, 23 Feb 2023 13:44:55 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] i915/gvt: Fix spelling mistake "vender" -> "vendor"
Message-ID: <Y/b9V321SlQt9wWS@debian-scheme>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20230202125018.285523-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HzSWUdm6s+7n4EaD"
Content-Disposition: inline
In-Reply-To: <20230202125018.285523-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HzSWUdm6s+7n4EaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023.02.02 12:50:18 +0000, Colin Ian King wrote:
> There is a spelling mistake in a literal string. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/i915/gvt/firmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/firmware.c b/drivers/gpu/drm/i915/g=
vt/firmware.c
> index dce93738e98a..4dd52ac2043e 100644
> --- a/drivers/gpu/drm/i915/gvt/firmware.c
> +++ b/drivers/gpu/drm/i915/gvt/firmware.c
> @@ -171,7 +171,7 @@ static int verify_firmware(struct intel_gvt *gvt,
>  	mem =3D (fw->data + h->cfg_space_offset);
> =20
>  	id =3D *(u16 *)(mem + PCI_VENDOR_ID);
> -	VERIFY("vender id", id, pdev->vendor);
> +	VERIFY("vendor id", id, pdev->vendor);
> =20
>  	id =3D *(u16 *)(mem + PCI_DEVICE_ID);
>  	VERIFY("device id", id, pdev->device);
> --=20

Thanks, Colin.

Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>
>=20

--HzSWUdm6s+7n4EaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCY/b9VwAKCRCxBBozTXgY
J6YGAJ9xp830QGO5I7mHfJCVb6JRefE6tgCgi00lyStr8rW5AvDfi8sjBs32WoQ=
=sHmJ
-----END PGP SIGNATURE-----

--HzSWUdm6s+7n4EaD--
