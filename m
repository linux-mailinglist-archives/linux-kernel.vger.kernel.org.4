Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49956D7131
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbjDEATm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDEATk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:19:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7743AA5;
        Tue,  4 Apr 2023 17:19:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Prlcm2Ck5z4xD8;
        Wed,  5 Apr 2023 10:19:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680653978;
        bh=MjvnDkWNROQyVRvp4d+Byk81ixfEEgNbeMjAevrOlnU=;
        h=Date:From:To:Cc:Subject:From;
        b=cp8ln7RQuY7qRRKkhOKCiCzHeYjZs3FcWwchhdIAb3s8/7oNQVZp7s8JOFu2URg43
         cOI9LQchALdxkvczgi8s9waPdAmdF1Qw7hInCtQBodKGQ5PAtHhMwF06FKzyLPQpTt
         9cLvwSjgvPHLNwo0ZiRYOBOJsCWlI0jMog1Oy4p+p3WQahDNN6X413xWLG7lMSVfRp
         nBsy5dH7J0hRgdPvwWdvoj2bmtfXO8aNQwirVZ33gJ94f58y/TzKbX4Qs90z/pAn0d
         EXKtmn5I4MySOfL7WPupGxYnAZe40djS2nrsfOs2VXIqukQMu3ZAqpGl626MMSUmpX
         MqVZF/jxgEyqg==
Date:   Wed, 5 Apr 2023 10:19:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: linux-next: manual merge of the arm-soc tree with the mm tree
Message-ID: <20230405101934.4d744471@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6in8z/ln.8/k+Bik8FLetx+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6in8z/ln.8/k+Bik8FLetx+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/configs/oxnas_v6_defconfig

between commit:

  78f42d6994c1 ("mm, treewide: redefine MAX_ORDER sanely")

from the mm tree and commit:

  fc746270c2a5 ("ARM: configs: remove oxnas_v6_defconfig")

from the arm-soc tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/6in8z/ln.8/k+Bik8FLetx+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQsvpYACgkQAVBC80lX
0GyL3Af+Np5fREMmVQyqTjeTx12WHkio5r4QDlXXkPxU+xyOBzfPTGfIhoz9YUdq
NaHiAgTFzz08/8PHADcDrPFPpyuBvzSRZVR4zm0cu/YxuXX9E5CnNw9/8gyMtkYe
uJAt2Da9QaEq2qI/S2qF6s7nRdvDoEP+lBiG2KguaIktDsbJwNSCFqS5seujonGd
KCiGUTXFMCi2OEQph27jHlrAtqRJHU1YojMSjoO9IcRopw8z/7H56/zvIan4mU1m
kGlwl9DkHcuOuOWrfdeftUX4U82yd5H9VOgwWiSKjn59myzUJ7ZGy8KsJTHbLm3W
iaYokzh/lXAlkRIhy40JnnqrL8mFIQ==
=iqfv
-----END PGP SIGNATURE-----

--Sig_/6in8z/ln.8/k+Bik8FLetx+--
