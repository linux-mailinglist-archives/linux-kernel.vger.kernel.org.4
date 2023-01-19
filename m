Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC00672E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjASBuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjASBrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:47:41 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A518E3BDB8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674092842; x=1705628842;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=rKLFpP4rDqSelqFQXcW8rq5vU0H/8DBsHiwom/vp9P8=;
  b=IS9nmjDXXoX16Yr9mmhI7hyiahDmIsIs1wIxoHb7DSqBNHrfpSuUAfBL
   xp6UzL4Tfx0skgKJeFsM4BM2F1A5AtOh+hThodn3JmkgqEyAGIyTM57RX
   hAbWreDYTF2nQYKHNj3PAZkTYdm9YrT7kYSAsUyceKpiNMQHaRwyWz7h/
   0cHCh7nUV9w6Q4VDigs+jiCc7VCmxQVK+V1uqCOigr86Z0x6GZ/wCdMm6
   ldabZiHMckP50jTe/rPnYxdH5KwiPucMmHW/u8gUpT/6MR5++bwtft1SW
   HBr5vyjFSZDFUnDgGaTAtxcSitecEgSzed3dpPL6u2YywCRt/f/FDGXSH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="305538065"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="asc'?scan'208";a="305538065"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:47:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="988819731"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="asc'?scan'208";a="988819731"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.159.108])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jan 2023 17:47:17 -0800
Date:   Thu, 19 Jan 2023 09:26:20 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Deepak R Varma <drv@mailo.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        dri-devel@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/i915/gvt: Avoid full proxy f_ops for
 vgpu_status debug attributes
Message-ID: <Y8icPEqkdF+7mg7E@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <cover.1673375066.git.drv@mailo.com>
 <188df08e0feba0cda2c92145f513dd4e57c6e6cf.1673375066.git.drv@mailo.com>
 <Y72zVXYLVHXuyK05@intel.com>
 <Y8TkTi+/GQwhiMvO@zhen-hp.sh.intel.com>
 <Y8b3IRhx976Ke99X@intel.com>
 <Y8d6CwD3dHLKOUZ5@ubun2204.myguest.virtualbox.org>
 <Y8giB988U5cqsGdd@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZXQGCj+hEvN7Ovv3"
Content-Disposition: inline
In-Reply-To: <Y8giB988U5cqsGdd@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZXQGCj+hEvN7Ovv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023.01.18 11:44:55 -0500, Rodrigo Vivi wrote:
> On Wed, Jan 18, 2023 at 10:18:11AM +0530, Deepak R Varma wrote:
> > On Tue, Jan 17, 2023 at 02:29:37PM -0500, Rodrigo Vivi wrote:
> > > On Mon, Jan 16, 2023 at 01:44:46PM +0800, Zhenyu Wang wrote:
> > > > On 2023.01.10 13:49:57 -0500, Rodrigo Vivi wrote:
> > > > > On Wed, Jan 11, 2023 at 12:00:12AM +0530, Deepak R Varma wrote:
> > > > > > Using DEFINE_SIMPLE_ATTRIBUTE macro with the debugfs_create_fil=
e()
> > > > > > function adds the overhead of introducing a proxy file operation
> > > > > > functions to wrap the original read/write inside file removal p=
rotection
> > > > > > functions. This adds significant overhead in terms of introduci=
ng and
> > > > > > managing the proxy factory file operations structure and functi=
on
> > > > > > wrapping at runtime.
> > > > > > As a replacement, a combination of DEFINE_DEBUGFS_ATTRIBUTE mac=
ro paired
> > > > > > with debugfs_create_file_unsafe() is suggested to be used inste=
ad.  The
> > > > > > DEFINE_DEBUGFS_ATTRIBUTE utilises debugfs_file_get() and
> > > > > > debugfs_file_put() wrappers to protect the original read and wr=
ite
> > > > > > function calls for the debug attributes. There is no need for a=
ny
> > > > > > runtime proxy file operations to be managed by the debugfs core.
> > > > > > Following coccicheck make command helped identify this change:
> > > > > >=20
> > > > > > make coccicheck M=3Ddrivers/gpu/drm/i915/ MODE=3Dpatch COCCI=3D=
=2E/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> > > > > >=20
> > > > > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > > >=20
> > > > > I believe these 2 gvt cases could be done in one patch.
> > > > > But anyways,
> > > > >=20
> > > > > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > >=20
> > > > > for both patches... and will leave these 2 patches for gvt folks
> > > > > to apply. Unless they ack and I apply in the drm-intel along with=
 the other ones.
> > > > >
> > > >=20
> > > > yeah, they're fine with me, feel free to apply them directly.
> > > >=20
> > > > Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> > >=20
> > > Unfortunately I got some conflicts when trying to apply on drm-intel-=
next.
> > >=20
> > > We probably need a new version, and probably through gvt branches it
> > > will be easier to handle conflicts if they appear.
> >=20
> > Hello Rodrigo,
> > Sure. I will send in a new version. I am current using linux-next git r=
epo as my
> > remote origin [tag 20230113]. Are there any specific instruction/locati=
on from
> > where I should access the gvt branch?
>=20
> https://github.com/intel/gvt-linux.git
>=20
> but with the linux-next your patch is probably right for them.
>=20

yeah, I think so as currently from last pull request I don't have
other updates in gvt tree, maybe it's just d-i-n hasn't included
recent gvt change.

I saw Deepak sent a new one, feel free to apply. Let me know if
there's still any issue.

thanks!

> > > >=20
> > > > > > ---
> > > > > >  drivers/gpu/drm/i915/gvt/debugfs.c | 6 +++---
> > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/gpu/drm/i915/gvt/debugfs.c b/drivers/gpu/d=
rm/i915/gvt/debugfs.c
> > > > > > index 03f081c3d9a4..baccbf1761b7 100644
> > > > > > --- a/drivers/gpu/drm/i915/gvt/debugfs.c
> > > > > > +++ b/drivers/gpu/drm/i915/gvt/debugfs.c
> > > > > > @@ -165,7 +165,7 @@ static int vgpu_status_get(void *data, u64 =
*val)
> > > > > >  	return 0;
> > > > > >  }
> > > > > > =20
> > > > > > -DEFINE_SIMPLE_ATTRIBUTE(vgpu_status_fops, vgpu_status_get, NUL=
L, "0x%llx\n");
> > > > > > +DEFINE_DEBUGFS_ATTRIBUTE(vgpu_status_fops, vgpu_status_get, NU=
LL, "0x%llx\n");
> > > > > > =20
> > > > > >  /**
> > > > > >   * intel_gvt_debugfs_add_vgpu - register debugfs entries for a=
 vGPU
> > > > > > @@ -182,8 +182,8 @@ void intel_gvt_debugfs_add_vgpu(struct inte=
l_vgpu *vgpu)
> > > > > >  			    &vgpu_mmio_diff_fops);
> > > > > >  	debugfs_create_file_unsafe("scan_nonprivbb", 0644, vgpu->debu=
gfs, vgpu,
> > > > > >  				   &vgpu_scan_nonprivbb_fops);
> > > > > > -	debugfs_create_file("status", 0644, vgpu->debugfs, vgpu,
> > > > > > -			    &vgpu_status_fops);
> > > > > > +	debugfs_create_file_unsafe("status", 0644, vgpu->debugfs, vgp=
u,
> > > > > > +				   &vgpu_status_fops);
> > > > > >  }
> > > > > > =20
> > > > > >  /**
> > > > > > --=20
> > > > > > 2.34.1
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > >=20
> > >=20
> >=20
> >=20

--ZXQGCj+hEvN7Ovv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCY8icNgAKCRCxBBozTXgY
JxqRAJ4mPEIhMcJ+GIK42L38hfdcpJvByACglaFTkYJ6rUDkesdylanplx0Kur8=
=/lPp
-----END PGP SIGNATURE-----

--ZXQGCj+hEvN7Ovv3--
