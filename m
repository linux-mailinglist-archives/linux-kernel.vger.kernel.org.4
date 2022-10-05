Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1595F5CAC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 00:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiJEW2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 18:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJEW2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:28:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F167DF5B;
        Wed,  5 Oct 2022 15:28:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MjTjl6hVpz4x1V;
        Thu,  6 Oct 2022 09:28:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665008892;
        bh=uYgrBDP1/U3UKipeqxPz+tb63PIZzevrui+UKaiiKrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RSQJ6n7QTM0+gF3dxwTLNlYRsyU/f43Z5Xfdt37/Eqh+H3NDBuxEs08FkXJSioeKY
         T6ZpERE7FSFQU+c3maPe1fV1ijxVfxaQiOTSuroWL+b1TSJc04Zprsy71tS9QuFO4+
         eZcNx7KQ2rDOUY+U3rWpyq0WhPhmdqoiD2kvw/SmTHR9ax27jhFTC6orqd7pXIe1Kx
         VypACoRAojW1kdWGevDjQAbcdU9R8Xg3kWHCNl45g6ncBfA7RvYtsMElxzQnozn4mK
         7O0RHzOq5EFxwsQkScfEz9fz7v5VsgLvoqPEkagBhiKFJs/xkT6BppOy+PlLbB6r91
         YN1ArE/r65nCA==
Date:   Thu, 6 Oct 2022 09:28:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Airlie <airlied@redhat.com>
Cc:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: linux-next: build failure after merge of the drm tree
Message-ID: <20221006092810.0c3a2238@canb.auug.org.au>
In-Reply-To: <09cd11c5-2a15-3653-957c-88c751fa9029@amd.com>
References: <20220930105434.111407-1-broonie@kernel.org>
        <20221004132047.435d42db@canb.auug.org.au>
        <CAMwc25oshRcJBoCT70B+b42bh5sPqgyoHuBx6K6ZLrwBMHnJzw@mail.gmail.com>
        <20221004140558.64f59f2c@canb.auug.org.au>
        <YzwbW4YQwQPsRPYw@sirena.org.uk>
        <CADnq5_PbPQPui1tOdUMB+OYbz6UBMKCgtwvE95oA+SfcN0RzNg@mail.gmail.com>
        <09cd11c5-2a15-3653-957c-88c751fa9029@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BBFuZQG7/.XqDoN9oEY_DQ7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BBFuZQG7/.XqDoN9oEY_DQ7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 5 Oct 2022 12:45:31 -0400 Hamza Mahfooz <hamza.mahfooz@amd.com> wro=
te:
>
> On 2022-10-05 11:30, Alex Deucher wrote:
> > @Mahfooz, Hamza
> > @Aurabindo Pillai can you get this fixed up?
> >  =20
>=20
> Seems like this is a false positive for GCC versions pre-12, because I'm =
not seeing this warning on GCC 12.2.
> However, we can fix this for older GCC versions with the following:
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm=
/amd/display/dc/dc_stream.h
> index 9e6025c98db9..67fede4bf248 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -238,7 +238,7 @@ struct dc_stream_state {
>=20
>   	/* writeback */
>   	unsigned int num_wb_info;
> -	struct dc_writeback_info writeback_info[MAX_DWB_PIPES];
> +	struct dc_writeback_info writeback_info[MAX_DWB_PIPES + 1];
>   	const struct dc_transfer_func *func_shaper;
>   	const struct dc_3dlut *lut3d_func;
>   	/* Computed state bits */

This is now in Linus' tree :-(

I have applied the following hack for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 6 Oct 2022 09:14:26 +1100
Subject: [PATCH] fix up for drivers/gpu/drm/amd/display/dc/core/dc_stream.c

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_stream.c
index ae13887756bf..a5da787b7876 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -520,9 +520,9 @@ bool dc_stream_remove_writeback(struct dc *dc,
 	}
=20
 	/* remove writeback info for disabled writeback pipes from stream */
-	for (i =3D 0, j =3D 0; i < stream->num_wb_info && j < MAX_DWB_PIPES; i++)=
 {
+	for (i =3D 0, j =3D 0; i < stream->num_wb_info && i < MAX_DWB_PIPES; i++)=
 {
 		if (stream->writeback_info[i].wb_enabled) {
-			if (i !=3D j)
+			if ((j >=3D 0) && (j < i))
 				/* trim the array */
 				stream->writeback_info[j] =3D stream->writeback_info[i];
 			j++;
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/BBFuZQG7/.XqDoN9oEY_DQ7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM+BPoACgkQAVBC80lX
0GyZVwgAgzWC3UyW11gvhenBa0JmMdUwcodPtmQ9KgVQ0qAAJdbouBh8sYX9q0RM
i8xNwFXmPJnh4hymww08vmNtiJZYvQWwJn0xu1PnlnQnuobDV4GS2pivKdn2cizn
tB7qA1J9dbl8sMt32zOmSOqzeMRFy4o9zliz2FfNguygM/iBJ2D9pvMFAPXlWHv8
OjdWP1+H73DClpGsijEXM+CEnbV0WqZs144EuAZ5Aeyd2Hb1a9hTHF3Rp82m+G59
oG9YnOWbLU5QLdoQaHa59gOojsKIp+85vnfG+AlQbOcAgNXT4w4YIbqRD7q5yH+N
/JisNQE6+9Z2wf7/hQhq2k8wCoK8cw==
=HigX
-----END PGP SIGNATURE-----

--Sig_/BBFuZQG7/.XqDoN9oEY_DQ7--
