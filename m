Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47832672E97
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjASCDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjASCDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:03:25 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C84E20055;
        Wed, 18 Jan 2023 18:03:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny5WS2dwbz4xG5;
        Thu, 19 Jan 2023 13:03:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674093796;
        bh=dVbqFBHL26lCqydTCV/yOYw42UZm5LPdZP4HPOgRF50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KjnTZeIlAoIyC15I7fEa36IumKJtU6K7jHwJmdeJdswg6RGkdF/cFZG4ruTradeKn
         x2v6voZ3S5JOTk3EonsJOg/ibUmnvAB+wTcbWATqOXqMxcoV3blJTcPfzxyU6jlbfL
         EEhI4tbKaZJJl51IiTFfzqRsqoVUC2nrxjUmBu7ZeKmz6kiZkiA0+XHB7KctS2+rs6
         QTx70bmXPrewNNWP1Wa6I5DaBKzJk1ozCL5LSFX4XjwXq5dGh8GHHjEmndmevbLLAB
         IIfeV9RrXanwQRTmLsmfm+yjGZZJZAFLGU1zHBdKEyjK3fDcWNbvF8D/ltij4QIAJb
         lV0umfCvDLbRA==
Date:   Thu, 19 Jan 2023 13:03:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>
Subject: Re: linux-next: manual merge of the drm-msm-lumag tree with Linus',
 drm-msm trees
Message-ID: <20230119130315.766c9e71@canb.auug.org.au>
In-Reply-To: <20230119122350.2a767def@canb.auug.org.au>
References: <20230119122350.2a767def@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RTQ4IJ=wgbeTGIJQqAHD.ox";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RTQ4IJ=wgbeTGIJQqAHD.ox
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 19 Jan 2023 12:23:50 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the drm-msm-lumag tree got a conflict in:
>=20
>   drivers/gpu/drm/msm/msm_drv.c
>=20
> between commits:
>=20
>   d73b1d02de08 ("drm/msm: Hangcheck progress detection")
>   8636500300a0 ("drm/msm: Fix failure paths in msm_drm_init()")
>=20
> from Linus', drm-msm trees and commit:
>=20
>   643b7d0869cc ("drm/msm: Add missing check and destroy for alloc_ordered=
_workqueue")
>=20
> from the drm-msm-lumag tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Actually, the fixup was this:

f39d6f85acf03a184bb086cae8fd24d2c6d787fe
diff --cc drivers/gpu/drm/msm/msm_drv.c
index 0509e90d05e3,b052327181b2..d476c4ff0dd5
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@@ -420,7 -418,11 +420,9 @@@ static int msm_drm_init(struct device *
  	priv->dev =3D ddev;
 =20
  	priv->wq =3D alloc_ordered_workqueue("msm", 0);
+ 	if (!priv->wq)
+ 		return -ENOMEM;
 =20
 -	priv->hangcheck_period =3D DRM_MSM_HANGCHECK_DEFAULT_PERIOD;
 -
  	INIT_LIST_HEAD(&priv->objects);
  	mutex_init(&priv->obj_lock);
 =20
@@@ -542,8 -544,6 +544,7 @@@
 =20
  err_msm_uninit:
  	msm_drm_uninit(dev);
- err_drm_dev_put:
 +	drm_dev_put(ddev);
  	return ret;
  }
 =20

--=20
Cheers,
Stephen Rothwell

--Sig_/RTQ4IJ=wgbeTGIJQqAHD.ox
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPIpOMACgkQAVBC80lX
0GwwQwf9FneWw/LqN6qNMAvu5yckpBQIQWXFv0tsftLy5q/HMYLlh5HmAz3hRN6u
BLvy2SITecY8SIHq0jLkRSDapnfAJmTttnpG3d6AMygfCvjE2ueHogIUpczHlD2v
LvYEVXVVVB5oOQ5lbtGD20pFNBdXkj+YhWiGf4Yxzce6wkpBRmBouu66s1ouCHVr
4fZ01FihYIx8CWAZcFkB2WhIn6PDGtlb1O63WKz39TChCkfqf6I+hg00OfPWD/po
7tmJ23k2XoOJCjqV+IQ8XERjU7XSL0f+0F+fQdqm+LFp9YVqNsXfm9e7VGN5GhJd
rm3ppGqivMtl6Z/zfdrecozBvtqI1w==
=R/sK
-----END PGP SIGNATURE-----

--Sig_/RTQ4IJ=wgbeTGIJQqAHD.ox--
