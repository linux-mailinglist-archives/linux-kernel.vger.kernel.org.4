Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11826987D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBOW3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBOW3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:29:34 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A09C15545;
        Wed, 15 Feb 2023 14:29:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PHCRp5m76z4x1R;
        Thu, 16 Feb 2023 09:29:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676500168;
        bh=7LU4CAj8Zb/mcRh61K+lbqXtN5hxcSXnaJ+GvRxVlWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YPcMgBkV+8aFh8zF/WOLFGJLNU2UoNxTMnwsqVypT94dS8b5AB4mIhwikK/0RYs5r
         OX353fmYAWhpNV+wIJ61yACn5T8WG3PacagCipHaDFm1K2G69URcsPgxqAmaP+Dsdj
         vZ9F/ifcuKwJsvbicrGc3rtMmnHd+UM42xY4qELJY8yhmHIIjVpGzkbxQOtf1nYGeS
         GKUUhILQ6+Gf56BG26PHKM/N6U52dyn736+NgW1Yt71m5SWApWYSx48AAzg4W4q72L
         RBtW/dEV+VttzAjG+wFz9T/SodtvfYTPMZjhKPNs4l01ka2FTQa5sU8SPu7RWCJFLQ
         Mhp59/7pYkEMw==
Date:   Thu, 16 Feb 2023 09:29:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the v4l-dvb-next tree with the
 arm-soc tree
Message-ID: <20230216092925.6b5cfc0c@canb.auug.org.au>
In-Reply-To: <20230123100923.7899a60f@canb.auug.org.au>
References: <20230123100923.7899a60f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OJCY3qYlEj=b8n2EZY0sNwO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OJCY3qYlEj=b8n2EZY0sNwO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 23 Jan 2023 10:09:23 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the v4l-dvb-next tree got conflicts in:
>=20
>   drivers/staging/media/Kconfig
>   drivers/staging/media/Makefile
>=20
> between commit:
>=20
>   582603a95734 ("staging: media: remove davinci vpfe_capture driver")
>=20
> from the arm-soc tree and commit:
>=20
>   d2a8e92f0b41 ("media: vpfe_capture: remove deprecated davinci drivers")
>=20
> from the v4l-dvb-next tree.
>=20
> These 2 commits removed the same driver but caused a conflict due to
> other changes to these files.
>=20
> I fixed it up (I just used the latter version of these files) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

This is now a conflict between the arm-soc tree and the v4l-dvb tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/OJCY3qYlEj=b8n2EZY0sNwO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPtXMYACgkQAVBC80lX
0GxHLAf+Jvl1lhzdIOt7axPaxoeS+jKIL80VCd+B/4tjETpWqTSak/sSr+qUx4bi
2KmYehrIegoQjFDsUEKDF42/NnpuHLdJE4xx9OAiFXpwBOmmq8aMikIsV4MwfNuX
gov7iaNJIhl808ZtvhoCxGsrg43uwmOvR3+DwxTmYF9Iva4k/T+8+3TlS6Zs6d5L
sw+6Y6CfJfFkkq5ohG+BvxGLBOwamhxyLCs9tnVyq7Tf8CbsTlU+DXV4mHVApyD+
MwX1mPaxV7h7OTcvBpdiTlx/p0H9IdxKMe1+5xL6DC6bxnCmsdKJ+sfx00+MJOfX
/PWkU118ZxpOFRek0PMKNyyxnxorSA==
=vSsZ
-----END PGP SIGNATURE-----

--Sig_/OJCY3qYlEj=b8n2EZY0sNwO--
