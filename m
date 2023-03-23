Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D096C73F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjCWXSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCWXSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:18:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9AFAF19;
        Thu, 23 Mar 2023 16:18:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PjLqj4mYnz4xDj;
        Fri, 24 Mar 2023 10:18:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679613506;
        bh=zAfVv2ov8IOdqKsXrg7NCnHgMlsZf6l3vG5Nr7aUpVA=;
        h=Date:From:To:Cc:Subject:From;
        b=BjhRy7Tc0Wf9fdk2YRcKvGC0GcFgpn7h1ZdFz112vK6/++UjM/v3Ve73WxvENKzYF
         gti5fNQpLXI58GPagzXG59EvYKpTGGDVNL/7mST+xynvlHxT/RQQ1aRbHzqrVbeIpE
         ZBEQCuldbcUauQkEasn5uCHHUWz75Z7p9xR0yFLoxpBWYGXzLVPkjBkrPYB7y0YF+d
         u4UGx5WvFKZXlng5HJeyRAggRdOu5PwKCIageA4cRU44GK9BX+rWDERXGSPeKqtPAg
         7qRTPm8BTrUfL4QHnLQgqDzzi2NdflwtuFKuuGW8LJrPwJuXzhpSujyy5SPuuP+TZJ
         wOePHBiukEaNw==
Date:   Fri, 24 Mar 2023 10:18:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the edac tree
Message-ID: <20230324101812.37f2fe5b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nF7k5HIWcv7rAFV88n9STyR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nF7k5HIWcv7rAFV88n9STyR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  44fe68df7832 ("EDAC/amd64: Rename debug_display_dimm_sizes()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/nF7k5HIWcv7rAFV88n9STyR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQc3jQACgkQAVBC80lX
0GwrHQgApigs1ANVPjYwfJA7fV3UWI81QEDD3A0cjSm0chT4patODy6ggAwlNsct
fNbNTNhXatolIdvmeb/OYgKoS6z8tpZsPHck+rJ1qtYuDmlarOds9U6b3LMiGbGV
+QJK6pqZ7amP5RhSAKxrefJ3vlfT/8tFGzhAeVpu8p5ZjW03Tfml/ERPB3n8aX0a
GIofsfi21F/OPBtLCZ2Yc0EVPp/uVVRwpg7nSIZs3b6IWhXQ8PU0JsFRjybPrtCB
kougrmm9grWCExPqMnW//MuyU71jYfV9qnEAaWyZ/ND/MahPmhpay4aqNFGcL8ii
WpyT3AjCm5RSuHavkmHzd9ChxsOeMg==
=EIU2
-----END PGP SIGNATURE-----

--Sig_/nF7k5HIWcv7rAFV88n9STyR--
