Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9472062B022
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiKPAjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiKPAjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:39:03 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EE5320;
        Tue, 15 Nov 2022 16:39:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NBkgk6ZZfz4xZ3;
        Wed, 16 Nov 2022 11:38:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668559139;
        bh=GvFgg8ljwaV0FWpRTrrGDvj7oXIjFGwZCxERL5k2fUc=;
        h=Date:From:To:Cc:Subject:From;
        b=AsWTrD1CpLc2DZxuBGrqyffMRaC7pB+ipu8VrGpqzTbbv9okrLN2g/RYHV2aMHbZN
         W1tM0BvdNP28GnNrFnWPuojJhd2mnDQMqN+n+nBnvVf83vdP7YejQIsyi4FXsPlz3m
         gTo+7mGf+fTS6rVA46vFEvINqcKw8kjmb373p2p968yig/iPBXc72KF3H31d6954by
         Rj2aZfMTiA1tYWGUCsPBMLOEWlzrMGOMEE3rldaVP9q/i4tgIxGhisMIdyp7+uFoXq
         O5wDViSwhl6ye+eJjHFr63fMNnMAOq3uJeeqcfQ6uF5wNrrp+lJUXSSFLGyiJTkyZF
         VE+49B/w/tSxg==
Date:   Wed, 16 Nov 2022 11:38:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20221116113857.6b7f3a9b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J4TZlPfBEwJPSoqMkkkvSlN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J4TZlPfBEwJPSoqMkkkvSlN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: missing MODULE_LICENSE() in drivers/gpu/drm/tests/drm_kunit=
_helpers.o

Caused by commit

  44a3928324e9 ("drm/tests: Add Kunit Helpers")

I have used the drm-misc tree from next-20221115 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/J4TZlPfBEwJPSoqMkkkvSlN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN0MSEACgkQAVBC80lX
0GxVKgf/cpJkTmRgMSuVOZvlWwzFOokwcDyFiN9l0Kl1ne5OiGjUsqwEfwU56fma
n7oNp+lZzc69c3IwlsPj8/ZRuyX+Up25ro05UtmGslqOe/p+wvLDO3PZLP1P4oPq
O/Mh+KTZnDxjGE2CTocYyhr01HtsKHSIt24p6P4JZUgV3Kkm62OQLpO/ihhX/ixp
REhE1KsmvdBs2OwilbbIwyUE7Txv+u42QAng6OKptmHns4sxX4RGziOkOEYOZUe/
AzJObp3IRhxRqtXl9rX5vF0lDkw731OfhAWIBg+W0nz+57mHZhT735Ctfm3V8Fwc
FLNglU2dtOjl3pgRIR78grL505LLng==
=AsUF
-----END PGP SIGNATURE-----

--Sig_/J4TZlPfBEwJPSoqMkkkvSlN--
