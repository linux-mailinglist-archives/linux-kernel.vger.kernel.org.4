Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2833721B56
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 02:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjFEA4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 20:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFEA4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 20:56:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B05BAD;
        Sun,  4 Jun 2023 17:56:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZFXZ2lGdz4x4B;
        Mon,  5 Jun 2023 10:55:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685926558;
        bh=q+7/zKp2K5V3a9BmmBm9h3eMtBVj2tHqR/Q+6bQxfcs=;
        h=Date:From:To:Cc:Subject:From;
        b=pfqQ+Do9bSLCMLeEpEz+BT2STQUFEqZJi9/gfz4hmQ/SBgmXeMRTE2+b3TGIRl7SX
         9VT5xgdcjINK1rSKgTvU5TKXzRAIHVaPXlY9gGtgist7A9c4jW6xbxpE1A4N86WmRt
         V4CeKV5S/2+MtQD7Pfc0bZtSzMi9CacReOBj/PXWFA/2UJdkJuGT4v03fY27NDjoGL
         r5/lA7waW+hdLxqhZ9aDAySm2gC3yCMSzIDgYXs4nCfnpoXtrfKiPmmFfMD2nJpwGq
         ss2ErL0JbvJVq9fnNC/zbEkIbs4QHyXuLCSUIygyl7XUuQjNgkix+DBunPOXG5gjH9
         yXErYEwI0Li4g==
Date:   Mon, 5 Jun 2023 10:55:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tpmdd tree with Linus' tree
Message-ID: <20230605105557.4c3ca468@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zm4HV=r9zIV2tnS88pU1V6a";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zm4HV=r9zIV2tnS88pU1V6a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tpmdd tree got a conflict in:

  Makefile

between commits:

  7877cb91f108 ("Linux 6.4-rc4")
  9561de3a55be ("Linux 6.4-rc5")

from Linus' tree and commit:

  b2b20594528e ("Linux 6.4-rc4")

from the tpmdd tree.

This is caused by the bad rebase and duplicate commits I reported
last week.  Please fix that up.

I fixed it up (I just used the former) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/zm4HV=r9zIV2tnS88pU1V6a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR9Mp0ACgkQAVBC80lX
0GwBqAf+OhgH5kUXidFWnLosuczOZ5K+ccgES2tnbKq1ZPJ0HWIcYo5W6I7QytTJ
xX8D5mcwL/eZujz0NHSug5AHVJLw5noJV1JNdLEWeVWuV+swXK9fA28oRLWm5LhO
cMB1TbHkuXDqkADKPkoHizlPaB2qNCjoDFVnQry6XhUkjZJbzxZpSDlVUKnVlBw4
dgfnjQWE8uilXU9VL1nLmhTs8QPJTCqYpm3cfrp4WUunnJdQHi0LgymsNX7DCJCS
xZUJ2Oiz0R/oABiYoXuZexPbjRC3SYSx8ZaT+Ejn2V/paitYJ4nmk2/fbMSwpRD2
v8/nI4PItTNeEB0yLvvjZMJ7l+VybA==
=N2wB
-----END PGP SIGNATURE-----

--Sig_/zm4HV=r9zIV2tnS88pU1V6a--
