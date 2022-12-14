Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB28564D3C1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiLNXxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiLNXxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:53:06 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4249F4AF0D;
        Wed, 14 Dec 2022 15:52:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NXXGz6ll3z4xN1;
        Thu, 15 Dec 2022 10:52:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671061964;
        bh=zjMc/HavO9fWmvFAeY7aaQGz3MAeZp7ROQazCdszDQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I9Pqch04pID1TNDqRYHV4g6Y7luYpSvS+hfiP5skuRmJo4npKcHfB36sDT3cS1jvU
         X2t0WxkiU/RXCrLeJu7KpBw3UBDx2MOJYxl0+t+6d2w7CIIS/NzcD51EqRpLtahu2u
         +ZvsKLhrECvLuAMfg7y0oT+zmfR8kr76cO4n93KBXjsP8HNDO94Fe9Tlz5obKCJrio
         pmJebmnU7f7U0zsHUmti1OISmoUmG/qWy9HIcfjJTLBZ6QlRP2vacAAkH3J3DSF2ir
         tAc7OfpkMZwIiXYopNeHWoyvSljf7MypKDJ9FjLJqYGipGmfPp8+JO/PhoGOdRBv1d
         d6Q1CP1fowe8g==
Date:   Thu, 15 Dec 2022 10:52:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Greg KH <greg@kroah.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: linux-next: manual merge of the iommufd tree with the
 driver-core, vfio trees
Message-ID: <20221215105242.509e3682@canb.auug.org.au>
In-Reply-To: <20221206132153.074fff0c@canb.auug.org.au>
References: <20221206132153.074fff0c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WgFWN+K_R0+r61m.rpgA38b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WgFWN+K_R0+r61m.rpgA38b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 6 Dec 2022 13:21:53 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the iommufd tree got a conflict in:
>=20
>   drivers/vfio/vfio_main.c
>=20
> between commits:
>=20
>   ff62b8e6588f ("driver core: make struct class.devnode() take a const *")
>   e2d55709398e ("vfio: Fold vfio_virqfd.ko into vfio.ko")
>=20
> from the driver-core, vfio trees and commits:
>=20
>   c2849d718d26 ("vfio: Move vfio group specific code into group.c")
>   f96dc03a8368 ("vfio: Wrap vfio group module init/clean code into helper=
s")
>=20
> from the iommufd tree.
>=20
> I fixed it up (I think - see below and I had to add the fix up patch as
> well) and can carry the fix as necessary. This is now fixed as far as
> linux-next is concerned, but any non trivial conflicts should be mentioned
> to your upstream maintainer when your tree is submitted for merging.
> You may also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 6 Dec 2022 13:17:41 +1100
> Subject: [PATCH] vfio: fix up for "driver core: make struct class.devnode=
() take a const *"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/vfio/group.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index c5d8bf10495e..bb24b2f0271e 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -827,7 +827,7 @@ bool vfio_file_has_dev(struct file *file, struct vfio=
_device *device)
>  }
>  EXPORT_SYMBOL_GPL(vfio_file_has_dev);
> =20
> -static char *vfio_devnode(struct device *dev, umode_t *mode)
> +static char *vfio_devnode(const struct device *dev, umode_t *mode)
>  {
>  	return kasprintf(GFP_KERNEL, "vfio/%s", dev_name(dev));
>  }
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/vfio/vfio_main.c
> index 718215b55038,e21ff965141e..000000000000
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@@ -433,95 -241,28 +239,16 @@@ out_uninit
>   	ida_free(&vfio.device_ida, device->index);
>   	return ret;
>   }
>  -EXPORT_SYMBOL_GPL(vfio_init_device);
>  -
>  -/*
>  - * The helper called by driver @release callback to free the device
>  - * structure. Drivers which don't have private data to clean can
>  - * simply use this helper as its @release.
>  - */
>  -void vfio_free_device(struct vfio_device *device)
>  -{
>  -	kvfree(device);
>  -}
>  -EXPORT_SYMBOL_GPL(vfio_free_device);
>  =20
> - static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
> - 		enum vfio_group_type type)
> - {
> - 	struct iommu_group *iommu_group;
> - 	struct vfio_group *group;
> - 	int ret;
> -=20
> - 	iommu_group =3D iommu_group_alloc();
> - 	if (IS_ERR(iommu_group))
> - 		return ERR_CAST(iommu_group);
> -=20
> - 	ret =3D iommu_group_set_name(iommu_group, "vfio-noiommu");
> - 	if (ret)
> - 		goto out_put_group;
> - 	ret =3D iommu_group_add_device(iommu_group, dev);
> - 	if (ret)
> - 		goto out_put_group;
> -=20
> - 	group =3D vfio_create_group(iommu_group, type);
> - 	if (IS_ERR(group)) {
> - 		ret =3D PTR_ERR(group);
> - 		goto out_remove_device;
> - 	}
> - 	iommu_group_put(iommu_group);
> - 	return group;
> -=20
> - out_remove_device:
> - 	iommu_group_remove_device(dev);
> - out_put_group:
> - 	iommu_group_put(iommu_group);
> - 	return ERR_PTR(ret);
> - }
> -=20
> - static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
> - {
> - 	struct iommu_group *iommu_group;
> - 	struct vfio_group *group;
> -=20
> - 	iommu_group =3D iommu_group_get(dev);
> - 	if (!iommu_group && vfio_noiommu) {
> - 		/*
> - 		 * With noiommu enabled, create an IOMMU group for devices that
> - 		 * don't already have one, implying no IOMMU hardware/driver
> - 		 * exists.  Taint the kernel because we're about to give a DMA
> - 		 * capable device to a user without IOMMU protection.
> - 		 */
> - 		group =3D vfio_noiommu_group_alloc(dev, VFIO_NO_IOMMU);
> - 		if (!IS_ERR(group)) {
> - 			add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> - 			dev_warn(dev, "Adding kernel taint for vfio-noiommu group on device\=
n");
> - 		}
> - 		return group;
> - 	}
> -=20
> - 	if (!iommu_group)
> - 		return ERR_PTR(-EINVAL);
> -=20
> - 	/*
> - 	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace =
to
> - 	 * restore cache coherency. It has to be checked here because it is on=
ly
> - 	 * valid for cases where we are using iommu groups.
> - 	 */
> - 	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY)) {
> - 		iommu_group_put(iommu_group);
> - 		return ERR_PTR(-EINVAL);
> - 	}
> -=20
> - 	group =3D vfio_group_get_from_iommu(iommu_group);
> - 	if (!group)
> - 		group =3D vfio_create_group(iommu_group, VFIO_IOMMU);
> -=20
> - 	/* The vfio_group holds a reference to the iommu_group */
> - 	iommu_group_put(iommu_group);
> - 	return group;
> - }
> -=20
>   static int __vfio_register_dev(struct vfio_device *device,
> - 		struct vfio_group *group)
> + 			       enum vfio_group_type type)
>   {
> - 	struct vfio_device *existing_device;
>   	int ret;
>  =20
> - 	/*
> - 	 * In all cases group is the output of one of the group allocation
> - 	 * functions and we have group->drivers incremented for us.
> - 	 */
> - 	if (IS_ERR(group))
> - 		return PTR_ERR(group);
> + 	if (WARN_ON(device->ops->bind_iommufd &&
> + 		    (!device->ops->unbind_iommufd ||
> + 		     !device->ops->attach_ioas)))
> + 		return -EINVAL;
>  =20
>   	/*
>   	 * If the driver doesn't specify a set then the device is added to a
> @@@ -1848,19 -1260,6 +1278,10 @@@ static int __init vfio_init(void
>   	if (ret)
>   		return ret;
>  =20
>  +	ret =3D vfio_virqfd_init();
>  +	if (ret)
>  +		goto err_virqfd;
>  +
> - 	/* /dev/vfio/$GROUP */
> - 	vfio.class =3D class_create(THIS_MODULE, "vfio");
> - 	if (IS_ERR(vfio.class)) {
> - 		ret =3D PTR_ERR(vfio.class);
> - 		goto err_group_class;
> - 	}
> -=20
> - 	vfio.class->devnode =3D vfio_devnode;
> -=20
>   	/* /sys/class/vfio-dev/vfioX */
>   	vfio.device_class =3D class_create(THIS_MODULE, "vfio-dev");
>   	if (IS_ERR(vfio.device_class)) {
> @@@ -1871,36 -1270,17 +1292,20 @@@
>   	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
>   	return 0;
>  =20
> - err_alloc_chrdev:
> - 	class_destroy(vfio.device_class);
> - 	vfio.device_class =3D NULL;
>   err_dev_class:
> - 	class_destroy(vfio.class);
> - 	vfio.class =3D NULL;
> - err_group_class:
>  +	vfio_virqfd_exit();
>  +err_virqfd:
> - 	vfio_container_cleanup();
> + 	vfio_group_cleanup();
>   	return ret;
>   }
>  =20
>   static void __exit vfio_cleanup(void)
>   {
> - 	WARN_ON(!list_empty(&vfio.group_list));
> -=20
>   	ida_destroy(&vfio.device_ida);
> - 	ida_destroy(&vfio.group_ida);
> - 	unregister_chrdev_region(vfio.group_devt, MINORMASK + 1);
>   	class_destroy(vfio.device_class);
>   	vfio.device_class =3D NULL;
> - 	class_destroy(vfio.class);
>  +	vfio_virqfd_exit();
> - 	vfio_container_cleanup();
> - 	vfio.class =3D NULL;
> + 	vfio_group_cleanup();
>   	xa_destroy(&vfio_device_set_xa);
>   }
>  =20

This is now a conflict between the driver-core, vfio trees and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/WgFWN+K_R0+r61m.rpgA38b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOaYcoACgkQAVBC80lX
0Gxb4gf/Zvyj6euVtPiIcklPwvwrCx4Fo00k6bLI+RnPRAJN5QtbPXT7164iI5nM
WL1yYO3S/iFiRRhSEw1Y6NX8ve08543AHsNIQ4gG7DKiJoDhHchvwUATAiEeG+Zs
mVHE3fmJFtHEbwD6JlR7Mlv5xtm0cBIppJzo2FFuIGEgp5vb/kwaBDSBrO74jUL/
3tHxGanQcQNuUB5ET1H1LvIYFrFnbt3wqVT6PC5h39eOSBPlfG7ANPWBZ1Rd6vVF
b+M0I98LvW18b2viV/EvApcxUmxB8dfJ23EHh/1jL7rBQx9aQHhhAFcKnQpfFWgE
uehvYEtV1JiiLK/u1oQ7QMAIsU0pNg==
=jN6e
-----END PGP SIGNATURE-----

--Sig_/WgFWN+K_R0+r61m.rpgA38b--
