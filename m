Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D7762AFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiKPAZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKPAZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:25:24 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CC028E04;
        Tue, 15 Nov 2022 16:25:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NBkMx2zQKz4xYV;
        Wed, 16 Nov 2022 11:25:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668558317;
        bh=TdQclqV/GxQxmzjoq+seDxRYSbFQNh0oghMNSOC4DRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pt9vpjbIZc/Qt7JzGdhuYK9vsoQ7zDkdQJR2fZ6m2BW1JGYO2jVs8bftpEERuhgsi
         nZeKj3DmSnNX12QR6IhvJVAjLv/0yJCbb1UpzunRJ+OcMBHnAzuwkfrutwb25fPSlz
         pBfuTXoOidWN4GPdtpsYzWYVSXb9flSr+D3VRsA8QTvqwMQZ+WQ6DHjXdLh17cbAxL
         znPicgM3hQiNdmHUlAUBce3EMDvBCXtAgQnhmfrc3M19d/rd46LRsBlEnGD3opevs+
         GQ0gI1zN5h3+oC4Of4U+5YL+EdYdintDMPOOB8v2Ib/bmxjDkXUzFBKh0oHcrigtta
         mc2KeiDKMT9ag==
Date:   Wed, 16 Nov 2022 11:25:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm-misc tree with the
 drm-misc-fixes tree
Message-ID: <20221116112515.3f01531b@canb.auug.org.au>
In-Reply-To: <20221116104752.4c64495a@canb.auug.org.au>
References: <20221116104752.4c64495a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c7RRuG4mWy0.E5ybru8QUfJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c7RRuG4mWy0.E5ybru8QUfJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 16 Nov 2022 10:47:52 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the drm-misc tree got a conflict in:
>=20
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>=20
> between commit:
>=20
>   eca13f3c67b6 ("drm/amdgpu: use the last IB as gang leader v2")
>=20
> from the drm-misc-fixes tree and commit:
>=20
>   1728baa7e4e6 ("drm/amdgpu: use scheduler dependencies for CS")
>=20
> from the drm-misc tree.
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
> diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index de5cb056c9ad,0528c2b1db6e..000000000000
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@@ -1197,10 -1201,7 +1203,10 @@@ static int amdgpu_cs_sync_rings(struct=
=20
>   	}
>  =20
>   	for (i =3D 0; i < p->gang_size; ++i) {
>  +		if (p->jobs[i] =3D=3D leader)
>  +			continue;
>  +
> - 		r =3D amdgpu_sync_clone(&leader->sync, &p->jobs[i]->sync);
> + 		r =3D amdgpu_sync_push_to_job(&p->sync, p->jobs[i]);
>   		if (r)
>   			return r;
>   	}
> @@@ -1241,14 -1243,11 +1247,14 @@@ static int amdgpu_cs_submit(struct amdg
>   	for (i =3D 0; i < p->gang_size; ++i)
>   		drm_sched_job_arm(&p->jobs[i]->base);
>  =20
>  -	for (i =3D 0; i < (p->gang_size - 1); ++i) {
>  +	for (i =3D 0; i < p->gang_size; ++i) {
>   		struct dma_fence *fence;
>  =20
>  +		if (p->jobs[i] =3D=3D leader)
>  +			continue;
>  +
>   		fence =3D &p->jobs[i]->base.s_fence->scheduled;
> - 		r =3D amdgpu_sync_fence(&leader->sync, fence);
> + 		r =3D drm_sched_job_add_dependency(&leader->base, fence);
>   		if (r)
>   			goto error_cleanup;
>   	}

Note that I had to keep the declaration of "leader" in amdgpu_cs_sync_rings=
().

--=20
Cheers,
Stephen Rothwell

--Sig_/c7RRuG4mWy0.E5ybru8QUfJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN0LesACgkQAVBC80lX
0Gw0/Qf/RUcE8uXqZXS+I8FAM+PzcSOeembp4BtTZRPi66xV7YhCONtlqTTkLTB4
JAf1fShC67V3+95bUPJBrfzNaH3we2+AztN4H9N98nurIQ1Vau0WOOUW0Qr2mr5m
AoaoLwLP5CwO7rEsTy1nOj72zjnaZCVnHg3vvX2+JMTGHDkD7hv16Bl8a4WUKxZY
r0LSw1My//57cEPA/hPu9TzgymxtQotOJUz7oWQWKdnhfOpzA3zJWERd3bNGDsjM
OyU1+AnmROKEQ7LD1l9gLkhecfrwVfmjbSowJi/cQHOyXqa98j++243LYWl9743h
twIdwG8fW17DpXxGva20FN0FabG1Rg==
=3ggI
-----END PGP SIGNATURE-----

--Sig_/c7RRuG4mWy0.E5ybru8QUfJ--
