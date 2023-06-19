Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BB7735FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 00:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjFSWek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 18:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFSWej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 18:34:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5AAE53;
        Mon, 19 Jun 2023 15:34:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QlPhW3vGxz4wgq;
        Tue, 20 Jun 2023 08:34:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687214075;
        bh=pTjKQ2C9I7ZmwoDMbVuHDYYyzG2ICG3OkCyb656W3Lo=;
        h=Date:From:To:Cc:Subject:From;
        b=FIpIDACKpFfOe0EhCazWGCJWS/y0Lqc6UGj//AIK1R0GW5GNLukkYxznu20tp1lDd
         Y9y7uuBcq6Fp2jtncyt9V3DtDw+qvbD+fVynpJqTKGMyzSoDVcv2zApLPqdSUtWLqp
         JQ3Sx7OPv1sO1TAh4ILRHPZMsNas5jZiiViJ3v90AKVrDqiUsB0fzE/nPTvDCJ2B8B
         GjqyYiK10MhyYoJUuuDdX0l0oV0Fzip+myczWnRCasOA2u07HH5EebCNFMel8NxEfN
         65rzcS4LXxG5qKHeJW/JbVrsGf/Prb/cR7MXpNqXA/dvtAphAfygyYxdj8iSVAGTBQ
         eA0HyEtrlroGg==
Date:   Tue, 20 Jun 2023 08:34:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the ipmi tree
Message-ID: <20230620083432.24e9a1e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uYXQLfrN75V5mOCPjcR7=sS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uYXQLfrN75V5mOCPjcR7=sS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1d5244190c46 ("ipmi:ssif: Fix a memory leak when scanning for an adapter")

Fixes tag

  Fixes: c4436c9149c ("ipmi_ssif: avoid registering duplicate ssif interfac=
e")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/uYXQLfrN75V5mOCPjcR7=sS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSQ1/gACgkQAVBC80lX
0Gxa6gf/QSsaO9hEFjW5+N1VGv2spMvyyzqNoSOKR5uWkyiLmSkFBNAEMVmnEiDc
GaT2/lR/TRqN2BTpqyTb5VMVExVShWGw4iCdj6T0ELulV/UNbBsR0bNy/gtEodYU
o4WzB0hGsUxqk+GANm1M5hw8HERRy8//1fPmJAHT+PWDK1eoHj8xVho88FNJQN3T
zPMjV/jfimUoXmS5o5qA2pXfAIRbcV7fMP/XNNTGyTbHdLq4QK/ZGR6PUezgKCX2
+PLMkkloniKeDvH2NCTnxd7ygehuwSIYwNXebr7m29kkLtBNGuQfLokREJzIr3/S
4hPfNnygKExqSgEbGDGpDwp0E1TiHQ==
=fMPA
-----END PGP SIGNATURE-----

--Sig_/uYXQLfrN75V5mOCPjcR7=sS--
