Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4928E67492E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjATCGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjATCGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:06:39 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4EBA8395;
        Thu, 19 Jan 2023 18:06:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NyjXq2XDlz4xHV;
        Fri, 20 Jan 2023 13:06:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674180395;
        bh=UtRB6E0wN2erVA9ouuQuDSVey2aH1kMgxHSkIFViH0A=;
        h=Date:From:To:Cc:Subject:From;
        b=L+meNp7m0hF8Y4dsW9/76cHIk7uKgRk/3AuWiJUGhqsTXpNYphfs75QW4Qgd/ikXm
         5vbTYDXsbCw7SN6HcyVbt+gJSqkPQQ+bWwItCNer0ODSAoKA6jiZIHQT1pyQtUPR+l
         271vbDxi+E6FviO6tZhvGLncPjwnQO2C6K1fhKy1Qc0gQEjrTfzpwQeE49EK7WmLzw
         jyCR+r1Eifc5ZzaYzoH11gi5e7arYErweylA3yayk/NuS0oEQ/kiTkJbBYC9v7aA9Q
         uZwkTH12EnvqhPQFNOfxuFUXhRPzDmZrY4TnPCcjmMbIIrbuM8EiixNxLkeUyliFW7
         z82zA2dI94ZFA==
Date:   Fri, 20 Jan 2023 13:06:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Ofir Bitton <obitton@habana.ai>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the accel tree
Message-ID: <20230120130634.61c3e857@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A=2_9B9N4uqEOp8GZ4PgI5V";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A=2_9B9N4uqEOp8GZ4PgI5V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the accel tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/ABI/testing/sysfs-driver-habanalabs:201: ERROR: Unexpected in=
dentation.
Documentation/ABI/testing/sysfs-driver-habanalabs:201: WARNING: Block quote=
 ends without a blank line; unexpected unindent.
Documentation/ABI/testing/sysfs-driver-habanalabs:201: ERROR: Unexpected in=
dentation.
Documentation/ABI/testing/sysfs-driver-habanalabs:201: WARNING: Block quote=
 ends without a blank line; unexpected unindent.

Introduced by commit

  0a14c331682f ("habanalabs: update device status sysfs documentation")

--=20
Cheers,
Stephen Rothwell

--Sig_/A=2_9B9N4uqEOp8GZ4PgI5V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPJ9yoACgkQAVBC80lX
0GymPAf+IOpHfof0/LYaZr6N49uaVkMlA1DewjifwnvQDpErjx9a0kLAd7C4CSu3
pY57JLjHyCIm2lScdr+Cqx5z6zAj4sPlZMM0v040yCkaloTEIhFFoTW1q37s4im6
DkrhyFOGX0VHQnkJyygrR0mGVD2F5plzhM2aYV6gMCMGTcycC2Z+uarPiqn2PdDr
nFSddSoUCRv1BSGMy3J5IhM2OMFfJu0amuCLmA45xza3J+ecYpw+J8jjgDnyT9Fv
O857stTeu/+GQ3mhaSHHazY6p3yTh1pYvOfHH3QqH3e0DCjI715hdfjAyGMUYa1W
DA69ZD0keGRO+UF6agLPa8rY/zdDZg==
=yTyW
-----END PGP SIGNATURE-----

--Sig_/A=2_9B9N4uqEOp8GZ4PgI5V--
