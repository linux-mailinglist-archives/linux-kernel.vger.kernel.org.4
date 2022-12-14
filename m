Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C076264D3B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLNXvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLNXvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:51:45 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CD0187;
        Wed, 14 Dec 2022 15:51:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NXXFk22wjz4xGR;
        Thu, 15 Dec 2022 10:51:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671061898;
        bh=Jhs0FxkxL1WiMawudA52+qgnbA54iThVsDF4Fvd4VNY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=of1YjaryGKwX2d8tL/g1zkJbffaW989hdvkp2Sm+6HC/unPtFjwVQflvG8OZNeHsV
         KzLrV2Cao8qqcvRJqQrsa+A7ahPu/WArqUm7OpDCNXgHIdMZ4onM6GKQhTNxNH8fbe
         gRjW/nOleuKM1tSP3uV6+n612HQrg/CFRaJ+3axrNlS4z+z1FEFe2ec/eeiZgRt+MT
         CQ/hMr1M19OExj1bt+ocPksUBN5ibML3Aj1TO3Vk63HHS+fOpykg2IzE8/jsWhVve3
         quFzK4hmbHnG9LatsFryY/oTkQlmRn/iC1bR0ifJ5ym1FKp+8bfrpDdR1qiyPwz+kn
         Go/i4VYSrnPNg==
Date:   Thu, 15 Dec 2022 10:51:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: linux-next: manual merge of the iommufd tree with the vfio tree
Message-ID: <20221215105133.71fc6601@canb.auug.org.au>
In-Reply-To: <20221206125542.52ea97a7@canb.auug.org.au>
References: <20221206125542.52ea97a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m4IRHkZ+Nq07H3x/2dNL9DD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m4IRHkZ+Nq07H3x/2dNL9DD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 6 Dec 2022 12:55:42 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the iommufd tree got conflicts in:
>=20
>   drivers/vfio/Kconfig
>   drivers/vfio/Makefile
>=20
> between commits:
>=20
>   20601c45a0fa ("vfio: Remove CONFIG_VFIO_SPAPR_EEH")
>   e2d55709398e ("vfio: Fold vfio_virqfd.ko into vfio.ko")
>=20
> from the vfio tree and commits:
>=20
>   a4d1f91db502 ("vfio-iommufd: Support iommufd for physical VFIO devices")
>   e5a9ec7e096a ("vfio: Make vfio_container optionally compiled")
>   c2849d718d26 ("vfio: Move vfio group specific code into group.c")
>=20
> from the iommufd tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/vfio/Kconfig
> index 0b8d53f63c7e,286c1663bd75..000000000000
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@@ -38,6 -46,17 +46,12 @@@ config VFIO_NOIOMM
>   	  this mode since there is no IOMMU to provide DMA translation.
>  =20
>   	  If you don't know what to do here, say N.
> + endif
> +=20
>  -config VFIO_SPAPR_EEH
>  -	tristate
>  -	depends on EEH && VFIO_IOMMU_SPAPR_TCE
>  -	default VFIO
>  -
> + config VFIO_VIRQFD
>  -	tristate
> ++	bool
> + 	select EVENTFD
> + 	default n
>  =20
>   source "drivers/vfio/pci/Kconfig"
>   source "drivers/vfio/platform/Kconfig"
> diff --cc drivers/vfio/Makefile
> index 0721ed4831c9,3783db7e8082..000000000000
> --- a/drivers/vfio/Makefile
> +++ b/drivers/vfio/Makefile
> @@@ -2,12 -2,17 +2,14 @@@
>   obj-$(CONFIG_VFIO) +=3D vfio.o
>  =20
>   vfio-y +=3D vfio_main.o \
> - 	  iova_bitmap.o \
> - 	  container.o
> + 	  group.o \
> + 	  iova_bitmap.o
>  +vfio-$(CONFIG_VFIO_VIRQFD) +=3D virqfd.o
> + vfio-$(CONFIG_IOMMUFD) +=3D iommufd.o
> + vfio-$(CONFIG_VFIO_CONTAINER) +=3D container.o
>  =20
>  -obj-$(CONFIG_VFIO_VIRQFD) +=3D vfio_virqfd.o
>   obj-$(CONFIG_VFIO_IOMMU_TYPE1) +=3D vfio_iommu_type1.o
>   obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) +=3D vfio_iommu_spapr_tce.o
>  -obj-$(CONFIG_VFIO_SPAPR_EEH) +=3D vfio_spapr_eeh.o
>   obj-$(CONFIG_VFIO_PCI) +=3D pci/
>   obj-$(CONFIG_VFIO_PLATFORM) +=3D platform/
>   obj-$(CONFIG_VFIO_MDEV) +=3D mdev/

This is now a conflict between the vfio tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/m4IRHkZ+Nq07H3x/2dNL9DD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOaYYUACgkQAVBC80lX
0GxoKAf/fYsSNrPra53oL9grnGpMq5ligH47Xo0xm5EHuEWZjUxToFuzSoMfcryi
5XXAzbrUIjhrHUXexePK889bQtyof6VzIDr/TQbazWxeWZFWnuOuHDWvoGhxnW54
/npqmoRNeRa71xYcn7wPubbadZef4OjNq/vKV9doQc2OznMQKxPwwxhA48Ie+SpJ
sZ1gCZxEcOwvscSP4fRk3GjL8Phu75xkM0pZwLlYNSun6+dCj0Lhn4IGzOVvXSQ8
jFL68jBEuMoP9vwhVgHa1xlyKuE0cW/d9utVZmW2p2FCuGgq4CN5zmTLLULjk+Uk
IAIpMazUsh1oknoavN9I2DM0LJaegg==
=v77K
-----END PGP SIGNATURE-----

--Sig_/m4IRHkZ+Nq07H3x/2dNL9DD--
