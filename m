Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776EC67A5FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjAXWjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbjAXWjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:39:43 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F81C4C2C;
        Tue, 24 Jan 2023 14:39:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P1hjg0PH8z4xP9;
        Wed, 25 Jan 2023 09:39:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674599975;
        bh=GkFWQBK4jy/04ZTnWGb8zsXMJrL9xseVauK1DbmQ5WU=;
        h=Date:From:To:Cc:Subject:From;
        b=STwG5VuAAMBpN9YarD/0N/m4V5iaL7B5PSfDr9+DtXzYWVf330TQJDoF8qMXgiKbd
         y56jJAA249btk6SexxRaSa7Saux6Sxf2CDgT+4Bfwr6JzRhfXTmRmt/kdv6v8L4d9Y
         yVpFSUdk8EnkD0T2akqTsKjDnrVpKp1xhijwh/MZCDOZ67gL65+93p40n4fZo2fyAt
         Y1xW4wBkf1SiQgRIBKY4JwnohCvQ5tXn1VOXoqyABV2xmGGKF9nwzeF+3NgJg3mPPE
         zYU1y3cSIu0fobQLg+y4xO/WGkFXF/PxLdiDRi2zMwcxDiDugA5WBPGZzAle67xCbP
         J8PP778mqs8xg==
Date:   Wed, 25 Jan 2023 09:39:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the thermal tree with the pm tree
Message-ID: <20230125093933.518d9010@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8X56z72XDNrLkoib226AOCr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8X56z72XDNrLkoib226AOCr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the thermal tree got a conflict in:

  drivers/thermal/intel/intel_pch_thermal.c

between commit:

  fee19c692160 ("thermal: intel: intel_pch: Use generic trip points")

from the pm tree and commit:

  9e631aa90c97 ("thermal/drivers/intel: Use generic trip points for intel_p=
ch")

from the thermal tree.

These commits are very similar, so I just used the former version (since
it was newer).

I fixed it up (see above) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/8X56z72XDNrLkoib226AOCr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPQXiUACgkQAVBC80lX
0GwvqAf+O0y6gS41QyoyCFlF4r6xlLQ1YOChRhkMcbCSGIdzvPLTDro0H1SYHxQu
V8SGj6g0ioA9ZjBAD8H1dQ4pCl5R6fdO5yNhUjLKqPLSfS/NDuLMFvciA5HvojBw
T7T3bQyw8/bfuNF9ZV0/B/469VTAqrLqR5OohAgqysPr9RJMa1SDKC9GzXykWYYY
aMo3zEjIalwi3i6zoB1fbfWe2e3MeK2vS+nBtWJwXuHDCC8XxCx71KQ9xigIic/P
hIizv50yogd75u9H3+eaVVAFMaeGKCPxKRG7cuBXiZIxOqiDpcC6aBfuqwNDCLiP
kqpm2Abldm/dG6dmzqjWZ+0YehYrbw==
=mZkh
-----END PGP SIGNATURE-----

--Sig_/8X56z72XDNrLkoib226AOCr--
