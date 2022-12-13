Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0A364ACC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiLMBEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiLMBED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:04:03 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2ED1B7B5;
        Mon, 12 Dec 2022 17:04:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWKy802l9z4x1H;
        Tue, 13 Dec 2022 12:03:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670893440;
        bh=MjENaJjsUJ0vmAUhETsOh3SChVS76gPUtbz9SezE4n4=;
        h=Date:From:To:Subject:From;
        b=PSKl73GExO42QQ6oBUkGJEUk870n+JnNB65bK5rqjsSNTb1w20D4kA3iaNnLx1jfc
         uIYHLT+jMpcHIKcEPFKQTd6Tu3MLQJrqsCeVrrgIw7AbJ6BJ84ZjXxLOGFaqeV0E1L
         zQkCSbCrjWYo6xSrtbZcZpr1zsfpL2r6U6EKHdY1TTJMLVBGY8Mt6sv+PIfRghusee
         6GaU7tv554t3CGzoNTGgIsrxsi39mxI1ueLPS3O3sOrIzrYP3pV15OQYgca3v4WWHF
         QKVEMQPhtwvALOZWbEV2HCNENSMVMv6MU6+FTIs7dPw3yfkHUR78PLnqakfP4uAmXB
         ihm67E1n7wfUw==
Date:   Tue, 13 Dec 2022 12:03:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Merge window open
Message-ID: <20221213120359.47fc3cad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/owNLWUpQggM4k2fWYLRKWJU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/owNLWUpQggM4k2fWYLRKWJU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Now that the merge window is open, please do *not* add any new material
to your linux-next included branches (fixes, of course, are always ok).

Also, please do not rebase your branches unless absolutely necessary
(and if you do, you will need to explain why to your upstream
maintainer when you end a pull request).  The "no rebase" should
actually apply to linux-next included branches at all times (since they
are public) (except maybe just after the merge window closes when you
are "restarting" for the next release).

--=20
Cheers,
Stephen Rothwell

--Sig_/owNLWUpQggM4k2fWYLRKWJU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOXz38ACgkQAVBC80lX
0GwVnAgAnoVqAs+jlhQdUCk2bWRWSo3HwhbIdf9VihDvqtiMxOzfgcjLCCcnaXC4
UCRM+i7FjfJDYvQZ32M/2UR3nfHxkOiiXo/X5gIz8pdoCd4ih41CSzDeoOxMNBwt
lxc8o7BBrer0fEuPOjOF0sWhtyLsGJcosvSpFFg0bpVB93CklyHKeAfan7B9hJhb
2YLxWZwqiu2LkhjLKdbv6C1VW8/YCAOoN3R4UlaqKpJFxMxpgVy1K1a7wjKbcmOo
lDKtnVmwwEcXo03AKJ7OfI3KVKSBH+mCDJpGqS6LZRRcHbQF3yHtnZDsqNoWG5Pa
UO4gHuGmnBUWOgATHBU706jD0lq4Xg==
=tlQk
-----END PGP SIGNATURE-----

--Sig_/owNLWUpQggM4k2fWYLRKWJU--
