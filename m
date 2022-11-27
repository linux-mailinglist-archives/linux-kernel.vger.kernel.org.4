Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CAD639D3B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiK0VVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiK0VVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:21:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F94C767;
        Sun, 27 Nov 2022 13:21:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NL1jy6Lb0z4x1H;
        Mon, 28 Nov 2022 08:21:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669584071;
        bh=E7O8hKlAa8UVSirv1JlGS8ojDlZNmXtagLbs83whE3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ithL5iEiPNtACKqWb/sMmpHO+x4hRCZg9bqeIsoGZlB1o1AGMWzQ5oa2SRooU9CFq
         t7wLrzYEan3z3iIDPBmeBWB4hY+Tll2p6B6XGb9/RJxUaQ07dvSkmi6gsfZtJ2yk4p
         Sl3s6qkrirEm5TLxKWRtIcgveX/mQrUdgLS/4l8SwHElFA7zDgP+uIuJn7B7OrZucm
         ZPlTtVE0wwDMNTd6e76VhdQ7jHsuJ55GyE49+1K7ry7qdRAEXVcF/FrYjKHEb0FKyN
         qS04VCnWs+6OF7vBAiXI/+HNquA6uDqL+pFw1cgOpD1e2YsdEiSl3C0vMHofyyAyp5
         ZurZw31hJPXNg==
Date:   Mon, 28 Nov 2022 08:20:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 v4l-dvb-next tree
Message-ID: <20221128082046.26d95e24@canb.auug.org.au>
In-Reply-To: <20221116073848.46178032@canb.auug.org.au>
References: <20221116073848.46178032@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.767puWyK/d1N4jzBET_Kbi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.767puWyK/d1N4jzBET_Kbi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 16 Nov 2022 07:38:48 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Commits
>=20
>   0f6e8d8c94a8 ("venus: pm_helpers: Fix error check in vcodec_domains_get=
()")
>   ee357294a85b ("MAINTAINERS: Add Vikash as VENUS video driver co-maintai=
ner")
>=20
> are missing a Signed-off-by from their committer.

These are now in the v4l-dvb tree still without their SOB lines :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/.767puWyK/d1N4jzBET_Kbi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOD1K4ACgkQAVBC80lX
0GxysAf7Bguh801Ui3d+8w0BPyR0it1Rgr0FHpjZ6CMRA76Vx9lRxnlnJKermmxP
B80cKgdnNp5x7F706GrO5VeGcxLeYqpQg5RhNFng+FttKP/tHjlfThVDG/azt1iY
TIy98pVcglBYET9Iu91ITtKdDLNh7au4wXxA49tGjmHXDIRcdmxysVjy5yAeUPyc
Sy6N1+/hJFA2v9NQaaopugc9g74hlMWTZO4IkZMtK7Hcd9/5/qCXMmmO8bzccmqw
TRqpI/3f+B2blHLXGNaWtJxhjAkfV7+uVdwLLvs3e4pXPHQcGV2KPqyRJiaCqS+L
tMqR27m80QGqg17nOoDrEfBIQgLBYQ==
=xqhq
-----END PGP SIGNATURE-----

--Sig_/.767puWyK/d1N4jzBET_Kbi--
