Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17186AB542
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCFEE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCFEED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:04:03 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C5FF962;
        Sun,  5 Mar 2023 20:03:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVQ0t3Q17z4x5Z;
        Mon,  6 Mar 2023 15:03:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678075406;
        bh=3Fw9r8Bh63Ba8N9qM+IhwoWrq20FtDVAseOfA+BLBzg=;
        h=Date:From:To:Cc:Subject:From;
        b=fLDske/DQlN9ndKgI3QKk9GteyUov1KIjfuXDhJdZyAPepEpW3ZUWosfn/VscaCzq
         RiIZS+CyU9EoZWb2iVkuGAg90hHgvjl9Xq1VQTz6Pxwuln5EDg3Ijxh8TW5tHnxI3H
         XmogstaavwRGJhD8NT2ItZuD9yB+UfMdevIltpxjEombz+FJM8vcvnCtDc9h4PkQ/V
         1ABd62fA1WbGkNDq8EIwT6VTQzuPpFno/WT7gJKF+x+H5/ww5skY8ycoTp0apxvIig
         PIfOZMaNZ8X/MLW7z8dfs0KvGITennxhLW3nhv7bLj6MmpKaW9xfvhBijTp52Zywr1
         9fIcNERolUPTQ==
Date:   Mon, 6 Mar 2023 15:03:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: removal of the trivial tree
Message-ID: <20230306150325.128cc443@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NAZQ7hZAw0+v01Eg3u3iPcU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NAZQ7hZAw0+v01Eg3u3iPcU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

I forgot that the trivial tree had been dropped by its maintainer
in commit

  081c8919b02b ("Documentation: remove trivial tree")

so I will remove it from linux-next now.

--=20
Cheers,
Stephen Rothwell

--Sig_/NAZQ7hZAw0+v01Eg3u3iPcU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQFZg0ACgkQAVBC80lX
0Gyi8Af+ItGyoEffys3GMsZhAnK+1cOyoJ5g1ZdK7tIJ2Ss+83Sw2cXRPqNmfO0n
KrNvKUE25rYyox0Zr7WJp6QPjrYNmkcqBDSMJXap2dsJ3l0qJuWS2pDiqeMBvnsL
jjtL25wMGFLD5HIiW4mphQFkop7uPzuf42nLgc7vIAaVKbQqud1KIeCn6EFVxQTK
pvG05QDSSKUWw5zV+qsZ2O6dd8RZ6rwOzHHFc3wMva5NJy448TmZnfdSBHdAvx8O
j9mYxOXdmW6/deqBTd7dp8rMaMawDLvShtvK+b9nvttqMJxLJQGzVub56Hn2/unZ
uoeHY3+6paIcVEsLYW0Dq1fqC+lAPA==
=bXJB
-----END PGP SIGNATURE-----

--Sig_/NAZQ7hZAw0+v01Eg3u3iPcU--
