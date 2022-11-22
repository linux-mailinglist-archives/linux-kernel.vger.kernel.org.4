Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747D6633A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiKVK4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiKVK4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:56:35 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BBC2AC71
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=W+JtNi76/T/5X9X9LutPrpK18VtKjMse6siwqSuuxSs=; b=nogJKLfjL1+Ls5VvkX0VP8JnoN
        10DemJJniveOEOHvW8D0+caU6ZY9cqm+RNv+foIk6DniXrznWS8LZG2KNVhXbSuMecYlL2JxHRcUD
        cyvjhYM+AV7ZwSAV8KQUo+xoG2rYpLaIDJQ1Yyyjol7UZD7K32nxygDYKd7whIwpnjKIxfwCEKZsh
        lqfyeont66TCyjudqV7oG+rUD6bqAJ2EWgofh0V34P5VRMjeSiggGXr6AWSWyin96skkwF9Jq/FCV
        LPO7YLz73ve4pQGtrIvem/olKjk6B7D0Z8pPs20RFkNjPGV6BH8YvdhcVf4swByDN1fFGFud5afkD
        8vgmhxXw==;
Received: from [41.74.137.107] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oxQwc-006r3B-AU; Tue, 22 Nov 2022 11:56:02 +0100
Date:   Tue, 22 Nov 2022 09:55:52 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiho Chu <jiho.chu@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Friedt <chrisfriedt@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v4 3/4] drm: initialize accel framework
Message-ID: <20221122105552.edse4v3zb5q23e3k@mail.igalia.com>
References: <20221119204435.97113-1-ogabbay@kernel.org>
 <20221119204435.97113-4-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6pz67y7spm2gx5nc"
Content-Disposition: inline
In-Reply-To: <20221119204435.97113-4-ogabbay@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6pz67y7spm2gx5nc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11/19, Oded Gabbay wrote:
> Now that we have the accel framework code ready, let's call the
> accel functions from all the appropriate places. These places are the
> drm module init/exit functions, and all the drm_minor handling
> functions.

Hi Oded,

The proposal overall LGTM, but I didn't manage to compile the kernel
with your patch series when DRM is enabled but accel support doesn't.
Multiple missing link errors...

Am I missing something? Can you take a look at it from this patch 3/4?

Thanks,

Melissa
>=20
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> ---
>  drivers/gpu/drm/drm_drv.c   | 102 ++++++++++++++++++++++++++----------
>  drivers/gpu/drm/drm_sysfs.c |  24 ++++++---
>  2 files changed, 91 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 8214a0b1ab7f..1aec019f6389 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -35,6 +35,7 @@
>  #include <linux/slab.h>
>  #include <linux/srcu.h>
> =20
> +#include <drm/drm_accel.h>
>  #include <drm/drm_cache.h>
>  #include <drm/drm_client.h>
>  #include <drm/drm_color_mgmt.h>
> @@ -90,6 +91,8 @@ static struct drm_minor **drm_minor_get_slot(struct drm=
_device *dev,
>  		return &dev->primary;
>  	case DRM_MINOR_RENDER:
>  		return &dev->render;
> +	case DRM_MINOR_ACCEL:
> +		return &dev->accel;
>  	default:
>  		BUG();
>  	}
> @@ -104,9 +107,13 @@ static void drm_minor_alloc_release(struct drm_devic=
e *dev, void *data)
> =20
>  	put_device(minor->kdev);
> =20
> -	spin_lock_irqsave(&drm_minor_lock, flags);
> -	idr_remove(&drm_minors_idr, minor->index);
> -	spin_unlock_irqrestore(&drm_minor_lock, flags);
> +	if (minor->type =3D=3D DRM_MINOR_ACCEL) {
> +		accel_minor_remove(minor->index);
> +	} else {
> +		spin_lock_irqsave(&drm_minor_lock, flags);
> +		idr_remove(&drm_minors_idr, minor->index);
> +		spin_unlock_irqrestore(&drm_minor_lock, flags);
> +	}
>  }
> =20
>  static int drm_minor_alloc(struct drm_device *dev, unsigned int type)
> @@ -123,13 +130,17 @@ static int drm_minor_alloc(struct drm_device *dev, =
unsigned int type)
>  	minor->dev =3D dev;
> =20
>  	idr_preload(GFP_KERNEL);
> -	spin_lock_irqsave(&drm_minor_lock, flags);
> -	r =3D idr_alloc(&drm_minors_idr,
> -		      NULL,
> -		      64 * type,
> -		      64 * (type + 1),
> -		      GFP_NOWAIT);
> -	spin_unlock_irqrestore(&drm_minor_lock, flags);
> +	if (type =3D=3D DRM_MINOR_ACCEL) {
> +		r =3D accel_minor_alloc();
> +	} else {
> +		spin_lock_irqsave(&drm_minor_lock, flags);
> +		r =3D idr_alloc(&drm_minors_idr,
> +			NULL,
> +			64 * type,
> +			64 * (type + 1),
> +			GFP_NOWAIT);
> +		spin_unlock_irqrestore(&drm_minor_lock, flags);
> +	}
>  	idr_preload_end();
> =20
>  	if (r < 0)
> @@ -161,10 +172,14 @@ static int drm_minor_register(struct drm_device *de=
v, unsigned int type)
>  	if (!minor)
>  		return 0;
> =20
> -	ret =3D drm_debugfs_init(minor, minor->index, drm_debugfs_root);
> -	if (ret) {
> -		DRM_ERROR("DRM: Failed to initialize /sys/kernel/debug/dri.\n");
> -		goto err_debugfs;
> +	if (minor->type =3D=3D DRM_MINOR_ACCEL) {
> +		accel_debugfs_init(minor, minor->index);
> +	} else {
> +		ret =3D drm_debugfs_init(minor, minor->index, drm_debugfs_root);
> +		if (ret) {
> +			DRM_ERROR("DRM: Failed to initialize /sys/kernel/debug/dri.\n");
> +			goto err_debugfs;
> +		}
>  	}
> =20
>  	ret =3D device_add(minor->kdev);
> @@ -172,9 +187,13 @@ static int drm_minor_register(struct drm_device *dev=
, unsigned int type)
>  		goto err_debugfs;
> =20
>  	/* replace NULL with @minor so lookups will succeed from now on */
> -	spin_lock_irqsave(&drm_minor_lock, flags);
> -	idr_replace(&drm_minors_idr, minor, minor->index);
> -	spin_unlock_irqrestore(&drm_minor_lock, flags);
> +	if (minor->type =3D=3D DRM_MINOR_ACCEL) {
> +		accel_minor_replace(minor, minor->index);
> +	} else {
> +		spin_lock_irqsave(&drm_minor_lock, flags);
> +		idr_replace(&drm_minors_idr, minor, minor->index);
> +		spin_unlock_irqrestore(&drm_minor_lock, flags);
> +	}
> =20
>  	DRM_DEBUG("new minor registered %d\n", minor->index);
>  	return 0;
> @@ -194,9 +213,13 @@ static void drm_minor_unregister(struct drm_device *=
dev, unsigned int type)
>  		return;
> =20
>  	/* replace @minor with NULL so lookups will fail from now on */
> -	spin_lock_irqsave(&drm_minor_lock, flags);
> -	idr_replace(&drm_minors_idr, NULL, minor->index);
> -	spin_unlock_irqrestore(&drm_minor_lock, flags);
> +	if (minor->type =3D=3D DRM_MINOR_ACCEL) {
> +		accel_minor_replace(NULL, minor->index);
> +	} else {
> +		spin_lock_irqsave(&drm_minor_lock, flags);
> +		idr_replace(&drm_minors_idr, NULL, minor->index);
> +		spin_unlock_irqrestore(&drm_minor_lock, flags);
> +	}
> =20
>  	device_del(minor->kdev);
>  	dev_set_drvdata(minor->kdev, NULL); /* safety belt */
> @@ -603,6 +626,14 @@ static int drm_dev_init(struct drm_device *dev,
>  	/* no per-device feature limits by default */
>  	dev->driver_features =3D ~0u;
> =20
> +	if (drm_core_check_feature(dev, DRIVER_COMPUTE_ACCEL) &&
> +				(drm_core_check_feature(dev, DRIVER_RENDER) ||
> +				drm_core_check_feature(dev, DRIVER_MODESET))) {
> +
> +		DRM_ERROR("DRM driver can't be both a compute acceleration and graphic=
s driver\n");
> +		return -EINVAL;
> +	}
> +
>  	drm_legacy_init_members(dev);
>  	INIT_LIST_HEAD(&dev->filelist);
>  	INIT_LIST_HEAD(&dev->filelist_internal);
> @@ -628,15 +659,21 @@ static int drm_dev_init(struct drm_device *dev,
> =20
>  	dev->anon_inode =3D inode;
> =20
> -	if (drm_core_check_feature(dev, DRIVER_RENDER)) {
> -		ret =3D drm_minor_alloc(dev, DRM_MINOR_RENDER);
> +	if (drm_core_check_feature(dev, DRIVER_COMPUTE_ACCEL)) {
> +		ret =3D drm_minor_alloc(dev, DRM_MINOR_ACCEL);
>  		if (ret)
>  			goto err;
> -	}
> +	} else {
> +		if (drm_core_check_feature(dev, DRIVER_RENDER)) {
> +			ret =3D drm_minor_alloc(dev, DRM_MINOR_RENDER);
> +			if (ret)
> +				goto err;
> +		}
> =20
> -	ret =3D drm_minor_alloc(dev, DRM_MINOR_PRIMARY);
> -	if (ret)
> -		goto err;
> +		ret =3D drm_minor_alloc(dev, DRM_MINOR_PRIMARY);
> +		if (ret)
> +			goto err;
> +	}
> =20
>  	ret =3D drm_legacy_create_map_hash(dev);
>  	if (ret)
> @@ -883,6 +920,10 @@ int drm_dev_register(struct drm_device *dev, unsigne=
d long flags)
>  	if (ret)
>  		goto err_minors;
> =20
> +	ret =3D drm_minor_register(dev, DRM_MINOR_ACCEL);
> +	if (ret)
> +		goto err_minors;
> +
>  	ret =3D create_compat_control_link(dev);
>  	if (ret)
>  		goto err_minors;
> @@ -902,12 +943,13 @@ int drm_dev_register(struct drm_device *dev, unsign=
ed long flags)
>  		 driver->name, driver->major, driver->minor,
>  		 driver->patchlevel, driver->date,
>  		 dev->dev ? dev_name(dev->dev) : "virtual device",
> -		 dev->primary->index);
> +		 dev->primary ? dev->primary->index : dev->accel->index);
> =20
>  	goto out_unlock;
> =20
>  err_minors:
>  	remove_compat_control_link(dev);
> +	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
>  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
>  	drm_minor_unregister(dev, DRM_MINOR_RENDER);
>  out_unlock:
> @@ -950,6 +992,7 @@ void drm_dev_unregister(struct drm_device *dev)
>  	drm_legacy_rmmaps(dev);
> =20
>  	remove_compat_control_link(dev);
> +	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
>  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
>  	drm_minor_unregister(dev, DRM_MINOR_RENDER);
>  }
> @@ -1034,6 +1077,7 @@ static const struct file_operations drm_stub_fops =
=3D {
>  static void drm_core_exit(void)
>  {
>  	drm_privacy_screen_lookup_exit();
> +	accel_core_exit();
>  	unregister_chrdev(DRM_MAJOR, "drm");
>  	debugfs_remove(drm_debugfs_root);
>  	drm_sysfs_destroy();
> @@ -1061,6 +1105,10 @@ static int __init drm_core_init(void)
>  	if (ret < 0)
>  		goto error;
> =20
> +	ret =3D accel_core_init();
> +	if (ret < 0)
> +		goto error;
> +
>  	drm_privacy_screen_lookup_init();
> =20
>  	drm_core_init_complete =3D true;
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 430e00b16eec..b8da978d85bb 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -19,6 +19,7 @@
>  #include <linux/kdev_t.h>
>  #include <linux/slab.h>
> =20
> +#include <drm/drm_accel.h>
>  #include <drm/drm_connector.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_file.h>
> @@ -471,19 +472,26 @@ struct device *drm_sysfs_minor_alloc(struct drm_min=
or *minor)
>  	struct device *kdev;
>  	int r;
> =20
> -	if (minor->type =3D=3D DRM_MINOR_RENDER)
> -		minor_str =3D "renderD%d";
> -	else
> -		minor_str =3D "card%d";
> -
>  	kdev =3D kzalloc(sizeof(*kdev), GFP_KERNEL);
>  	if (!kdev)
>  		return ERR_PTR(-ENOMEM);
> =20
>  	device_initialize(kdev);
> -	kdev->devt =3D MKDEV(DRM_MAJOR, minor->index);
> -	kdev->class =3D drm_class;
> -	kdev->type =3D &drm_sysfs_device_minor;
> +
> +	if (minor->type =3D=3D DRM_MINOR_ACCEL) {
> +		minor_str =3D "accel%d";
> +		accel_set_device_instance_params(kdev, minor->index);
> +	} else {
> +		if (minor->type =3D=3D DRM_MINOR_RENDER)
> +			minor_str =3D "renderD%d";
> +		else
> +			minor_str =3D "card%d";
> +
> +		kdev->devt =3D MKDEV(DRM_MAJOR, minor->index);
> +		kdev->class =3D drm_class;
> +		kdev->type =3D &drm_sysfs_device_minor;
> +	}
> +
>  	kdev->parent =3D minor->dev->dev;
>  	kdev->release =3D drm_sysfs_release;
>  	dev_set_drvdata(kdev, minor);
> --=20
> 2.25.1
>=20

--6pz67y7spm2gx5nc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmN8qrAACgkQwqF3j0dL
ehzbEQ/+One2F+neBJcVWpLdVs1RaWmIljCE3vEcFFUAHm+cOZ/iYiCVpToMnGKE
E0RcMAecINg0zGLM8Wh3YdZ3ySrAjRo4+5bt4M20PGKAo0czQZf4a6mgXGcVXC1C
+prbuzzxBTPy1hTEOGgFBi3F+6lQ06vOV6qT3sXP9qSO51pSoA9F1/e8r3KVKniH
dunJeP9MmL3EtiBvEHFE4UNgsEKZogfUz4f41ITmlnrz0XFZ2tXZdExdokE4WE3Y
O3nFiXoFZJdN8PiHpuYLhOncnRyf0CHe9h2zQT8iq5qsZfLUUPiCYSIoeZLBc8qR
zSr6c5Sw4TJfxtsFdY4JNbJGZbXh5Z5iDtqyaFXFjCaL+Xev0jexb7TVEAtEKhF9
SyAtFek98caVD4XXBumpCRJoBdiwHxTPtRq81VqIuf6seH46qhYY+nkomWbGDJ9t
p1K+UNQoTFULaCagf9l+7/SinTaA8aK1ICkjmQrL+avJzOjVmQPa5HL7xB+vwvQJ
EiMYAsibObTAwMF0qD3tqYX9X8dAWRoWlYZ5n/pYW446pFIO5f/YIQGVkUJG0BJD
LVKjMIO/ywhji8wO1sQeGc0s3jhrxAND6L3iKaavVhqq91WoEe1ylIg705AUj8K4
+r01lCHZLM7/Qsl864LGXKWGWpuHRLY7JUz+stigvtVrryUSEZ0=
=uGpy
-----END PGP SIGNATURE-----

--6pz67y7spm2gx5nc--
