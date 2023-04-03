Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0CC6D3CAB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjDCFL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDCFL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:11:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE63F83D7;
        Sun,  2 Apr 2023 22:11:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PqfBt0byyz4xFX;
        Mon,  3 Apr 2023 15:11:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680498713;
        bh=4UWCitb8tAAubX5QkYN6ZsO+f7sUUaNh6WBeSzi9/u0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BuQjggVnqjTct9CSxh9egGn8flyVxSYx/dSOUqoXYE/j3pxjyUbNUpFLdq4dt2tPQ
         Ny3FkeRtJTa+dwPz/omo7wP/8RuFBmWOw8PYXIMxo0hNDGaLUeewaHcpwS/OchikcC
         BcIsZf5JkyQPTiLCbCi7uYQFsOuG9UQYsU4FGgyMpgNFfIaVKrahADK074Z0KKk3xh
         dOMfSXcozWM8e/36T/zU/lyQxQvu23/qWSeDSnrhH8Pj3VjNGt9Ti/tTwbGlaHEMIK
         OMN++QCOYvk2VlM+D8EJGoL4nq4BJY+bqQxWbnrIMyCJ2ioV29Vk/SavVlQHQI8+Nr
         /RGol++Lyberw==
Date:   Mon, 3 Apr 2023 15:11:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the iommu tree
Message-ID: <20230403151148.2991d6cd@canb.auug.org.au>
In-Reply-To: <20230403143642.2aa6fe8e@canb.auug.org.au>
References: <20230403143642.2aa6fe8e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I4pUcbl9A=IvduKVADwaP.A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I4pUcbl9A=IvduKVADwaP.A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 3 Apr 2023 14:36:42 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the tip tree got conflicts in:
>=20
>   drivers/iommu/iommu-sva.c
>   include/linux/sched/mm.h
>   include/linux/ioasid.h
>=20
> between commits:
>=20
>   cd3891158a77 ("iommu/sva: Move PASID helpers to sva code")
>   4e14176ab13f ("iommu/sva: Stop using ioasid_set for SVA")
>   1a14bf0fc7ed ("iommu/sva: Use GFP_KERNEL for pasid allocation")
>=20
> from the iommu tree and commit:
>=20
>   400b9b93441c ("iommu/sva: Replace pasid_valid() helper with mm_valid_pa=
sid()")
>=20
> from the tip tree.
>=20
> I fixed it up (I used the former version of include/linux/sched/mm.h,
> removed include/linux/ioasid.h, updated drivers/iommu/iommu-sva.c
> as below and applied the following patch) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 3 Apr 2023 14:32:58 +1000
> Subject: [PATCH] fixup for "iommu/sva: Replace pasid_valid() helper with =
mm_valid_pasid()"
>=20
> interacting with "iommu/sva: Replace pasid_valid() helper with
> mm_valid_pasid()" and "iommu: Remove ioasid infrastructure"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/linux/iommu.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 54f535ff9868..0c5d4c3b59cd 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1172,16 +1172,15 @@ static inline bool tegra_dev_iommu_get_stream_id(=
struct device *dev, u32 *stream
>  	return false;
>  }
> =20
> -static inline bool pasid_valid(ioasid_t ioasid)
> -{
> -	return ioasid !=3D IOMMU_PASID_INVALID;
> -}
> -
>  #ifdef CONFIG_IOMMU_SVA
>  static inline void mm_pasid_init(struct mm_struct *mm)
>  {
>  	mm->pasid =3D IOMMU_PASID_INVALID;
>  }
> +static inline bool mm_valid_pasid(struct mm_struct *mm)
> +{
> +	return mm->pasid !=3D IOMMU_PASID_INVALID;
> +}
>  void mm_pasid_drop(struct mm_struct *mm);
>  struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>  					struct mm_struct *mm);
> @@ -1203,6 +1202,7 @@ static inline u32 iommu_sva_get_pasid(struct iommu_=
sva *handle)
>  	return IOMMU_PASID_INVALID;
>  }
>  static inline void mm_pasid_init(struct mm_struct *mm) {}
> +static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
>  static inline void mm_pasid_drop(struct mm_struct *mm) {}
>  #endif /* CONFIG_IOMMU_SVA */
> =20
> --=20
> 2.39.2
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/iommu/iommu-sva.c
> index c434b95dc8eb,dd76a1a09cf7..000000000000
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@@ -9,14 -10,26 +10,14 @@@
>   #include "iommu-sva.h"
>  =20
>   static DEFINE_MUTEX(iommu_sva_lock);
>  -static DECLARE_IOASID_SET(iommu_sva_pasid);
>  +static DEFINE_IDA(iommu_global_pasid_ida);
>  =20
>  -/**
>  - * iommu_sva_alloc_pasid - Allocate a PASID for the mm
>  - * @mm: the mm
>  - * @min: minimum PASID value (inclusive)
>  - * @max: maximum PASID value (inclusive)
>  - *
>  - * Try to allocate a PASID for this mm, or take a reference to the exis=
ting one
>  - * provided it fits within the [@min, @max] range. On success the PASID=
 is
>  - * available in mm->pasid and will be available for the lifetime of the=
 mm.
>  - *
>  - * Returns 0 on success and < 0 on error.
>  - */
>  -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t =
max)
>  +/* Allocate a PASID for the mm within range (inclusive) */
>  +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, io=
asid_t max)
>   {
>   	int ret =3D 0;
>  -	ioasid_t pasid;
>  =20
> - 	if (!pasid_valid(min) || !pasid_valid(max) ||
>  -	if (min =3D=3D INVALID_IOASID || max =3D=3D INVALID_IOASID ||
> ++	if (min =3D=3D IOMMU_PASID_INVALID || max =3D=3D IOMMU_PASID_INVALID ||
>   	    min =3D=3D 0 || max < min)
>   		return -EINVAL;
>  =20
> @@@ -205,11 -242,3 +209,11 @@@ out_put_mm
>  =20
>   	return status;
>   }
>  +
>  +void mm_pasid_drop(struct mm_struct *mm)
>  +{
> - 	if (likely(!pasid_valid(mm->pasid)))
> ++	if (likely(!mm_valid_pasid(mm)))
>  +		return;
>  +
>  +	ida_free(&iommu_global_pasid_ida, mm->pasid);
>  +}

It also needs this:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 3 Apr 2023 14:58:05 +1000
Subject: [PATCH] extra fixup for "iommu/sva: Replace pasid_valid() helper w=
ith mm_valid_pasid()"

interacting with "iommu/sva: Replace pasid_valid() helper with
mm_valid_pasid()" and "iommu: Remove ioasid infrastructure"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/x86/kernel/process_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 74c7e84a94d8..3bcbc165c5bb 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -39,6 +39,7 @@
 #include <linux/io.h>
 #include <linux/ftrace.h>
 #include <linux/syscalls.h>
+#include <linux/iommu.h>
=20
 #include <asm/processor.h>
 #include <asm/pkru.h>
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/I4pUcbl9A=IvduKVADwaP.A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqYBQACgkQAVBC80lX
0Gy44Af/aigr+tFZ2uCNw70ssJgNJQHKMEFtlvta1FLH0IdJBjybFodOQygdgRkr
VYDH5JoOnb+vdVNK0aSyvBgfo3pFLk7m5E4B1Yw57GySquMmLg+qpmY8nVNxLvZN
KKOPF2JhXWMiDXr2ZttkBTlNGUdDsYwzajsVpK6jcHd1Tw29EEwznJMO9Vr0JtbU
rxHJLInGUiGFIiVZTtOA/fpzpmYIxmRklbYQjv+X/QLOn+j8pwXNthjZetmCYXSw
KBAHsDlmnnIomT90xwCJA0ryUaiu5oHd5Ax0C9K6XbHugJOgXvJBaRI02TVI1/12
86wgijrTA8RHvrF3PtzTDmT/KVA31A==
=ljXa
-----END PGP SIGNATURE-----

--Sig_/I4pUcbl9A=IvduKVADwaP.A--
