Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7405D6108C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiJ1DdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiJ1DdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:33:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E159CF878;
        Thu, 27 Oct 2022 20:33:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mz7RV1gHsz4x1V;
        Fri, 28 Oct 2022 14:33:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666927990;
        bh=5a5NSU0dIsDMvlc+OJ8XPLj9mtmzu3jUW4rkE0WVaKA=;
        h=Date:From:To:Cc:Subject:From;
        b=Tw9mR5leTLrZVOxrA5i6fh0icdHm5BoDvjurgyoxKXVzGy5EqIlcRjKwnHahDvKRp
         e+/b0XtM8Qkjqr0py7eePG5Xgo8xfkF8eDuxAeU1BQVuh2tOEsn4aL3cVnA8HV4ugo
         AFoXHEpSnHTiUrOeor4mnHZW3xtyyiAByJJfHpWiY1nAUwIWPOlm2zcUJOjKGmlhqN
         wHfGb6w5DQ/obmk8kDaYHLrxcwSnJx4wb6gokiRmQPW5rUpKCOM9n1RLxQpK1PziHJ
         SL3CGJBKR4wnnYUVc7jnueqx4+IsylsHCJqsgjpNjQWT7P771qN85KZpsi0rg7Fjhf
         A86E2H/O/5mWg==
Date:   Fri, 28 Oct 2022 14:33:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
        Mark Broadworth <mark.broadworth@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20221028143303.2cb92d35@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5zAGblCR1PAeeT+0Eu61XLg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5zAGblCR1PAeeT+0Eu61XLg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/dc/dc.h:502: warning: cannot understand functio=
n prototype: 'struct dc_clocks '

Introduced by commit

  1682bd1a6b5f ("drm/amd/display: Expand kernel doc for DC")

--=20
Cheers,
Stephen Rothwell

--Sig_/5zAGblCR1PAeeT+0Eu61XLg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNbTW8ACgkQAVBC80lX
0GwnRQf/TaqG7hPoJFK9iky2uGr/3IYI0zY51UvSKxyjHSQlgwNIRCGnekiQ1WUZ
sa/tAT3JIxC1aWDp6gfpl/Ahm/tUf6Sovf5Dt7IoDiyg5Q7jx8OF65JdZUssY4je
dkRIbGdX0gEEp0hyQ6Cc3XorDsLoUQ8AR/Lk3NTkCmpEUlTkwI1bLyjC2PYmiZnb
8mX+uuySj19GpDi62BJ99hu58OOYkKmQjIyu0t6jpTJtiFTXTzXQap3nVm4TAnj2
olLxWhWHJmlLIGyo/RW4Ac7yfKshlUH7bmsdsMLPOahHo6KxbRy1Q7qt1Qxo7al+
XDqetRPnyUljpOEJdBwyzNelrvo90Q==
=XTga
-----END PGP SIGNATURE-----

--Sig_/5zAGblCR1PAeeT+0Eu61XLg--
