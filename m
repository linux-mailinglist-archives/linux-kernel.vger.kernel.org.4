Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628196C3C20
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCUUqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUUqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:46:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562E853716;
        Tue, 21 Mar 2023 13:46:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ph3Xs0x6Nz4whh;
        Wed, 22 Mar 2023 07:46:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679431565;
        bh=jbbSyfF15CCmAYfwEpFN4mZSyPCgTiOHDupvsOOTxiY=;
        h=Date:From:To:Cc:Subject:From;
        b=LBGnwYv2P96KdvCQpl2ovk//PvWdAhawq4ZpFn9U7vrhsmISHFk5Ac78XMgT8ehK5
         WIXs48/KBmvwqwswpxYdl5UAn5hoJsbX3IFmmTZmYbFKY3TdnvnADP+cFwPwcSYHen
         540kWMn0ELobrQ4i/iGxjjwU6jAxYt3nVeB0Oq2BHxM37OLy0PwgakOnoTyuQhmkHY
         Wc1V9ZRt+dLivMRp36Q4g3M64ziuW2fWqdwROC/Viq4pX9BNlK5Wbg8ffo31WCnlkf
         mGZ0KA4UifhCdru6W5mk4S+rlRV7SwY30VUEqXloPAh/3P0X43AuPacWobP2waqIGH
         2pPMyOJK1YAUw==
Date:   Wed, 22 Mar 2023 07:45:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Frank Crawford <frank@crawford.emu.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the hwmon-fixes tree
Message-ID: <20230322074551.09dac2b6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7m/q9WKE1L5PIu_qunH.++S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7m/q9WKE1L5PIu_qunH.++S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  38c25fa52920 ("hwmon (it87): Fix voltage scaling for chips with 10.9mV  A=
DCs")

Fixes tag

  Fixes: ead8080351c ("hwmon: (it87) Add support for IT8732F")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/7m/q9WKE1L5PIu_qunH.++S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQaF38ACgkQAVBC80lX
0GwhQwf/W9hbkDgGkUYuhPkIy3DsOOyR/03ksx0a+GhlSnYqPv22y2GeVe3CyXdb
H22IgQPfClgxEiq98agUsohacjDbcA25DrJp3mPCIZdLylAWWKvZ+XFPFmE7OTkh
/dlXDfg2gDba3lsRMzjiNVfRKTbI9lVi61zzUhiAikjeT4uNpkx8oZxQosYNtW1X
YEaK0sy3pcNJiUXafdHuq6Gwf5k5LvjSdSOyCN89HrqbH+bh6+PoAk7FUulK68my
IFP4H0DMHAECkAROn0uOxvezBatcTTE6hQMfsqYs+7Q5UlsHZwbBpovmjJiLU63z
qjSdmYiMaCU+CijH5EMzSAMU+b1hLw==
=YwKD
-----END PGP SIGNATURE-----

--Sig_/7m/q9WKE1L5PIu_qunH.++S--
