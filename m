Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FF26A0055
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjBWA6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjBWA6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:58:19 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C5239CE9;
        Wed, 22 Feb 2023 16:58:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PMZQC3lF3z4x5d;
        Thu, 23 Feb 2023 11:58:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677113891;
        bh=ztxbZdscDinWNA8JxkiaTpX0fD/X3cvFoxGXemclLVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U1z+cqqeIrKmmpl7Db6MDKpBEhPYAkmm9+pXJvIV9SmtW1ivsBkjWmhPuzwOblA5e
         T8GRl6Erj03r+sG0iOKhK1H6ztSc2w3gSgkfq8jRZ1GFEsRZAyN8NTcknJUtT31QH8
         R9maTPaE1mIrRpaxKKx+h7mHWPVqGU27FI2fcSMMI3iQqotjf95OB1bliLeZl5ySAF
         dgUpiSl04glTZ12FTi/B41dwg2qFwAqadeLvstkBDc0XSF1flNS6bD2MZ2Dgz2iDlc
         Xv4hfZtW1QcIpZxe6HecPK7B5+r2B/Dm7S/Tc8j7V+bnjy1BePd7TB7bvBKtxPu81q
         yHKDjooO7ppqg==
Date:   Thu, 23 Feb 2023 11:58:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Mark Brown <broonie@kernel.org>, Alain Volmat <avolmat@me.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: linux-next: manual merge of the spi tree with the i2c tree
Message-ID: <20230223115810.56134cbe@canb.auug.org.au>
In-Reply-To: <20230216113035.3050871a@canb.auug.org.au>
References: <20230216113035.3050871a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WkjcS3PsLpgLma5i_aEpZyB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WkjcS3PsLpgLma5i_aEpZyB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 16 Feb 2023 11:30:35 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the spi tree got a conflict in:
>=20
>   MAINTAINERS
>=20
> between commit:
>=20
>   b3de755d6041 ("dt-bindings: i2c: i2c-st: convert to DT schema")
>=20
> from the i2c tree and commit:
>=20
>   7ec844a2c753 ("spi: spi-st-ssc: convert to DT schema")
>=20
> from the spi tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc MAINTAINERS
> index 71e92d3c51c6,daa33e7bb457..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -2791,7 -2925,8 +2791,8 @@@ M:	Patrice Chotard <patrice.chotard@fos
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   W:	http://www.stlinux.com
> + F:	Documentation/devicetree/bindings/spi/st,ssc-spi.yaml
>  -F:	Documentation/devicetree/bindings/i2c/i2c-st.txt
>  +F:	Documentation/devicetree/bindings/i2c/st,sti-i2c.yaml
>   F:	arch/arm/boot/dts/sti*
>   F:	arch/arm/mach-sti/
>   F:	drivers/ata/ahci_st.c

This is now a conflict between the i2c tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/WkjcS3PsLpgLma5i_aEpZyB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP2uiIACgkQAVBC80lX
0GxgAwf/Vfg+WXMgrhRiP6qidy7pmaKmiI3QQcCVOTycLCTG5RGDQQoyYow3jtew
PjHorCgiQKTliZKG10cQyxUAcXkgmUXguKvmm0P8qtM9ILJTp4tXlPTNQjTXU8df
gLCz/EWv1j0XPSnzZDebAWUgKtGfCzvye7mf9vJEVDz+GH2xKmWj+tGeoJ6eJQsP
g8d5RQRNVcmieRZ9mLX76EGzKLCQHLWumBtGfmVdWQG+V7nFPQCvFADnEXEHzWrR
etmSiUhVCJlHHiVLo+s1nmrrzDUcF5PhdDFqQGHWnMNxJG7yMb85tWEwFaljPIMo
MQ+WTFMJBa88seZ+USdCpHHLDksf5w==
=7seG
-----END PGP SIGNATURE-----

--Sig_/WkjcS3PsLpgLma5i_aEpZyB--
