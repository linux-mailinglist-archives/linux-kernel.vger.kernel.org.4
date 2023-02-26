Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859E26A3578
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 00:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBZXCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 18:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBZXCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 18:02:45 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5591216328;
        Sun, 26 Feb 2023 15:02:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PPzfN4bDGz4x80;
        Mon, 27 Feb 2023 10:02:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677452524;
        bh=1YiC+BZa+sK89Q2onWDnva3zgDxn/Fq4nKQm8IHGfXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uJHgrEwyT0shEaLRgrOhfZXYDhdJK877xrp41yXoKKjCk/jfgID5TqzdB8qBZspJ9
         cZfrgt1WIbWy8ZLa1EjoAfhvScwTwFzyDSEPh/nL1glruoFpNJDArffinqcvTPN8jV
         yfBiPgA4ivQDTMjKRp5qGvxdS/Cp6qfGhL/SJPloMhVbzaZSzheuDtBoNQz5hh9NDG
         5UKytnUVVhHh4SlYyFLKvPAU+HeiH3t7yaz9eEH9mIQPc+KofOOmBkAveMcj/QcOvN
         qr/5w6rV1BhTaPrBPA1leVKhmtRs7XI/W37bs2kho6VP3hZjf2IF6lM2Z07SQaZPh1
         vsonsKtCs5y8Q==
Date:   Mon, 27 Feb 2023 10:02:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robherring2@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: manual merge of the devicetree tree with the mmc
 tree
Message-ID: <20230227100203.74ced769@canb.auug.org.au>
In-Reply-To: <20230125112438.552917be@canb.auug.org.au>
References: <20230125112438.552917be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9AGaPf8994QCEtjexj=EkHp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9AGaPf8994QCEtjexj=EkHp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 25 Jan 2023 11:24:38 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the devicetree tree got a conflict in:
>=20
>   Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml
>=20
> between commit:
>=20
>   1e52a7e6794f ("dt-bindings: mmc: drop unneeded quotes")
>=20
> from the mmc tree and commit:
>=20
>   21fd06dc4a34 ("dt-bindings: drop type for operating-points-v2")
>=20
> from the devicetree tree.
>=20
> I fixed it up (the latter removed a line fixed up by the former) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

This is now a conflict between the mmc tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/9AGaPf8994QCEtjexj=EkHp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP75OsACgkQAVBC80lX
0Gwldwf+NrrTZuquthRgkluhEJWsuc31jH+EccPNicJD5tOESLbgs9T3rvIqk9HA
RqpDiA13e2OoHqdzeyHix8JAB7s774qcGAFixtH0Sev9hEDFfdTyZt9jnbIaCGrX
02yzY9q7XRdGF9NVfT4P8A7N9gydHDX8Idl8kHRup6SdgA0SXQFjTpJK2h8IOsNn
547Xh8JTSxA3hO9BDqzNB3mUYvBvCmaNDFTGWozKrPPpM8dA2M0TcRzLHLyLP7G+
Kalwj1HfDrTPJfZcpHkXvNqfXheoH2uVIIBx9GU7dvy1cymeXuJYsyDDRJ1vDW3N
l3FZDX0kbTCIpSrOk+fdz2s7WcDsyw==
=DAuY
-----END PGP SIGNATURE-----

--Sig_/9AGaPf8994QCEtjexj=EkHp--
