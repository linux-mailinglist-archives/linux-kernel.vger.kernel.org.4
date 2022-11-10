Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9A6624CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiKJV2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJV2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:28:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249FF1D6;
        Thu, 10 Nov 2022 13:28:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N7Zgx2gp6z4xTg;
        Fri, 11 Nov 2022 08:28:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668115693;
        bh=ibUdi+QMYyfARWbAqqypO7qXyl6bTh0LELYGokheEJg=;
        h=Date:From:To:Cc:Subject:From;
        b=pamcZ3GyntHnF1u7g2l6+pmkLSNH7YGUl1Ubizaap6/dhjWNxXwH3nJ0c2sPwzpGQ
         Ko5JdEFwtlyVsW2/zMA2Q2i2O6NO6wodDlF6V8sM2qDqpfyvZnF1kMmBDkKrHfYByI
         QCWu120J8QStbicGiZis35nzcRg6RYbMmN8o6NULuPC53fQ8yzoHrjGZ0a0vvEwSsE
         /qMDi8nnTN5dNHZmR9eXByVfbuBcxQPbpadXops71t5TCwt0/8SOJGYktQcqkx27AP
         u7wgxNKFe4ZLmfVOrS0EzQ5e+ad3Ia4lFx/N4NatQxBN4+WXFon+amSSo8cL8+qfAu
         KEmdmtFSrtkNw==
Date:   Fri, 11 Nov 2022 08:28:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the f2fs tree
Message-ID: <20221111082811.3c0fe637@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W_8leBqFKyp1PGe/.wusItW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W_8leBqFKyp1PGe/.wusItW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6953bf65286d ("f2fs: allow to read node block after shutdown")

Fixes tag

  Fixes: 83a3bfdb5a8 ("f2fs: indicate shutdown f2fs to allow unmount succes=
sfully")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/W_8leBqFKyp1PGe/.wusItW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNtbOsACgkQAVBC80lX
0GxkkAf+O5ljI1lRsPBS0yOh6FHmJ446V7/0vPzwvQ+YNNli8/+kP7l5wtT8NOeP
twbfepNZT0qTteNlOJW5g2Lkm2Sv170vu1hl7vo8J/r/zQhdmIYyWa9ZknDUEuK0
Hc+59i0LoHDW9m0F9onn9CJs0i7USfjswv73VPgh+p5/GXxF8+1sVRWH2F7lx7I2
uCnlZSADpbROqE0FHSmcvKIRxRUSt60bB5g7BnMJxDEGoR77Mlp7JLG3oBg4uDCY
0sP/qJJcG38IvUk5cR82DWbea3h0KMAenYcLLUgE5oIdcD013JfXaz1qcMU+z6jv
RyvpNKklkhtxjDbrYD8mh80js1zSYQ==
=HIhv
-----END PGP SIGNATURE-----

--Sig_/W_8leBqFKyp1PGe/.wusItW--
