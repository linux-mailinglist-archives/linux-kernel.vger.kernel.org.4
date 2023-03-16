Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9D56BC328
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 02:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCPBNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 21:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCPBNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 21:13:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20279A8C77;
        Wed, 15 Mar 2023 18:13:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PcTlb25gXz4xD5;
        Thu, 16 Mar 2023 12:12:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678929179;
        bh=BH3+/7RYEC52C+Ss/I1lr0J68DQj2CK/PR3cnKRr5C8=;
        h=Date:From:To:Cc:Subject:From;
        b=KphFU/ZaOyWhxnIJdYYQBN2vuyieLpbc/U+W8EZwn31aODDEBqvZ/7OGd23nJ3edk
         Gq0RMyiJQ7AG4/o09wG6Ct5zHUUOc1r4ihZI9e6+fI3DseohMpcfFhQceSsiPds4aS
         JkrTFoxpogFUALqe4e4KkvBsYCoTZYrbOsU13CR08wyv/cABY8rbdpqtc6/J+wrf4g
         U42NnbEwsmcLjKrFPTSgsIuwIUQu+kOKOBc8pDQRpRffv09yIrAatSfCJQpbq1XzCE
         vQjsG281P8yY6bsldeTPTwm4Yf9rEX6oxH7KoJzyyykFh7AvkLHyM1KUu12Crs+pk1
         AkdOQ81MXK7aA==
Date:   Thu, 16 Mar 2023 12:12:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20230316121246.2627d009@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rBQYc9HJZZAuFVzCQS9UoiR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rBQYc9HJZZAuFVzCQS9UoiR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/ELF/ELF.rst: WARNING: document isn't included in any toctree

Introduced by commit

  6d73cfdeee15 ("ELF: document some de-facto PT_* ABI quirks")

--=20
Cheers,
Stephen Rothwell

--Sig_/rBQYc9HJZZAuFVzCQS9UoiR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQSbQ4ACgkQAVBC80lX
0GzvyQf/WvwMLy/ahd+L8YJOrcu7AgJzZayZifKZs9K+CEEYQkR8fCy1P1VCyb9c
0k/iEyPI9V8C3AjuEfB72pl4sBt2LF9YghGAovGrm3ABT1ouEXCtReIXSbkkfYpJ
HAFwszxIS+Fv9Vn+UA/c0s9/9vAGvpiPx/sjRbapNK7ALc0Ay+NixcUWQQdmTjLi
hrRTsu/OjgnCtIEdwZDsphUyOeqGZK+8JAQu5VyknedGyvca1dbHVdFhK9lG7rSQ
+/Q/V7aPujNF+9tBPck/77up543DQmaEYX4vDlNi7vikpT7o3wG0gzcyAaPoluN4
3H+423m8Bb4ask6TXs9WE4y/CuSmqw==
=Kw7/
-----END PGP SIGNATURE-----

--Sig_/rBQYc9HJZZAuFVzCQS9UoiR--
