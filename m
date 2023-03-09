Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69EE6B18C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCIB2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCIB2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:28:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F968498A4;
        Wed,  8 Mar 2023 17:28:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PXBQb60R5z4xDl;
        Thu,  9 Mar 2023 12:28:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678325304;
        bh=ouMQd0xHJ85FIrH7Sa9DKOIt+jrngCzToU9DAse/e6w=;
        h=Date:From:To:Cc:Subject:From;
        b=rqt+oSHabzTda4HL67z4qXjFMne2CUQ9a/T40hRRmqE5M/BZIEPd5y28DlkKj9t5a
         ih8NS2Ua5PEvmwi/I8KbHVSwTRzAtlBRvCmQz2pIlbQTdiSpbTONGOLyG34CIqaiFD
         EothlKSx3awyCZKqLmO42edBSfOtIfyzE8C6IHBTw5SziieiFw4DJQ97Ad26/AsQLt
         dge11J9do6yAEGlDlDYo00sbB2Ua30obuAF+sQZ7rmACyDhcDH/a5Z5hCclb5EpILz
         ghTpLXdzy5OepEim+87WwCNDtqR8V8r1C2Y7HVKZvRjQCXoBs8zyA0whDh18eJYzf7
         q8fWgtxkLlIHQ==
Date:   Thu, 9 Mar 2023 12:28:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the drivers-x86 tree
Message-ID: <20230309122822.77435e33@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UMx+61=x+rtsm4w65qUgjjU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UMx+61=x+rtsm4w65qUgjjU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drivers-x86 tree, today's linux-next build
(htmldocs) produced these warning:

include/linux/apple-gmux.h:99: warning: Function parameter or member 'type_=
ret' not described in 'apple_gmux_detect'
include/linux/apple-gmux.h:99: warning: Excess function parameter 'indexed_=
ret' description in 'apple_gmux_detect'

Introduced by commit

  fc83fbc80e1a ("platform/x86: apple-gmux: refactor gmux types")

--=20
Cheers,
Stephen Rothwell

--Sig_/UMx+61=x+rtsm4w65qUgjjU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQJNjYACgkQAVBC80lX
0GxcDwgAhukgr1tR3zoGiqtHz/XrJiatHWGOQ63jxeVM6hSwXZ43Kci0JK8tV2tD
v1SuemI4NaSxN+q22JqDxB21Fve0sUhlh9YLxf00Y6JpWJGtf6z6UGzOqV5u221A
42o2lbBNUYWHd2q/y9JdyimxS0Dan/JnKlSoN06GiKP76EQ2G4L7qS4ehRmw36g9
VZ/lLUz9zlFzGxO4XiIsOvBK9xn3aUAl00xMeJrF8rMJg/ozAndwlpAQ8ENbCJ12
eXmUeTsyjHgic1ZSx4lVHuvr86FMmYf8Me/oFq8VLL2iup38q0tj9lI3wgES8Zax
qrsn5+9M37PX/4YjYpY9KzOn8yQh4Q==
=LSYF
-----END PGP SIGNATURE-----

--Sig_/UMx+61=x+rtsm4w65qUgjjU--
