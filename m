Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52A96BA4CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCOBqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCOBq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:46:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B74BEAF;
        Tue, 14 Mar 2023 18:46:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PbtXR27tjz4xDq;
        Wed, 15 Mar 2023 12:46:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678844775;
        bh=8obVoLw0IvwVZvweGkMPIQlFDHnT37gEuT4Gsl4XnQg=;
        h=Date:From:To:Cc:Subject:From;
        b=F7BQtIoNtAZb78MS3DJPRH6eLm2QE2buIyCGRP/930ndZ6mjDom04FZCmj11hhzxZ
         xNygUYvX7wa1RAonAlfDKKJN8N4cye9Ei16O33T8d+bFMH/128dqKK5mb3dphiMBVj
         yirkGionpuD6QSzefbzD7b5aawoRjVxxwoGPqCfl5mHUf6K88GOd20rvXlXn5XOTuR
         IlJ2LLCnhTYGmTViESohLKPWerS70x8jYqKkb/All01GHiN7E/AWiUOtBpEY4DtciF
         Ya9JiUYyjng6fBqWofdT37QE1J0w0GBMVnRB3w68oBLplxVAwQpPAfcof+8uW1GLB4
         RCM1F3FOJiAZQ==
Date:   Wed, 15 Mar 2023 12:46:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the nvmem tree
Message-ID: <20230315124612.6cb48c72@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2aahZ+9Gy1CJJdbIDcztN+C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2aahZ+9Gy1CJJdbIDcztN+C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nvmem tree, today's linux-next build (htmldocs)
produced these warnings:

drivers/of/base.c:1228: warning: Function parameter or member 'alias' not d=
escribed in 'of_alias_from_compatible'
drivers/of/base.c:1228: warning: Excess function parameter 'modalias' descr=
iption in 'of_alias_from_compatible'

Introduced by commit

  c077ed868e50 ("of: Rename of_modalias_node()")

--=20
Cheers,
Stephen Rothwell

--Sig_/2aahZ+9Gy1CJJdbIDcztN+C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQRI2QACgkQAVBC80lX
0GzxWQf9GkQR0JjpnN4x4VBtf5a/xoBLYEDu5jwupHBIpECIvhLxZv2KArcjLm8Q
7yQ7IwQzFpq3ENZwFjFBKYbG7w3Bdarn6MGvsZ6JlgnK2XXOj+hSke+/oE6XcKdP
fJjfORXiei4WMFHF1YBRAjdXeCtnJP+jgKeHbfoGfSySHrGzRgkYvD3px7BL13eO
ghUmXptAQRawzZQ9OrgRV2rGFE8z+1D/rTZONC7Bj9h9PcygwXRdJ5j0cVcrFhvj
iRc260dkBuP6ONXnbkXRM+9mzm+mf1HbfmUxUdqJOCoIAMYpN2gzhAO/SLuooxX2
Kbh5nUIIykKHNiRW3r1Q0ozNcNu42Q==
=Yslb
-----END PGP SIGNATURE-----

--Sig_/2aahZ+9Gy1CJJdbIDcztN+C--
