Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E65FCF04
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJLXmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 19:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJLXmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 19:42:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6617D6889D;
        Wed, 12 Oct 2022 16:42:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mnq2Q3Pzsz4xGG;
        Thu, 13 Oct 2022 10:42:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665618158;
        bh=MSgqIlLNuoLVp0EJwgBfD8Q46u9XEpVHooayGrvn7Jw=;
        h=Date:From:To:Cc:Subject:From;
        b=KmuDHxg7WQCeaIYJs0urcN696PI1aLGg+fPSj0KsQzNE+IFaJHCVaXdqtXJ2vpNDt
         VgpcKLFMT/eYAioaSNKmBOgpd85ytenFgSaaITv1Gc1p7TRM1qmc56IdBX0L0TxUwl
         4xQGPzl3VhJC3EfgP0XyTJWC/uPuiJYJUF1YH14aCg9c224c2nBxeCluh1OAHOeJR/
         QdtBV7HhYdVhKI1WwGxIxznEFsSTGTujpYMnhWYHjmZdv9Q2JPbkeHr8eOfODMcfNu
         j6zUf8jmQZLzhYh2b0YiIeWCT5SvzfC8xS+jDyuQwSSbAAVeJ++X0Wbja8rIEkkMB1
         JL/57dG7peq4A==
Date:   Thu, 13 Oct 2022 10:42:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mm-stable tree
Message-ID: <20221013104234.11e88852@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9wo_KwYw/tNprJT532caCWR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9wo_KwYw/tNprJT532caCWR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  db24ef4e6b0a ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/9wo_KwYw/tNprJT532caCWR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNHUOsACgkQAVBC80lX
0GxDzgf+L8iPHqShlZ4+VjcZv3/fg0A1uRA0jlY3H1sZJUMXJsF5mXjP4sVcVDqw
Y75yBhMfyi2euEXOCXCPogzYMXK+Ar4Eh1SPsbnn0/kVC/ev2vCjYT81x2qXsS5W
ZRg7tYCmf+QietKubJFwEDfeFSM0kYrRV98d/BagCJbNVFFEd/auHrvSpknGtvbQ
dOxk/05W1y8u7HGn6Loy21dH9vVwTiZlEVkZI8PYQj4DTQEJVUMMGzoxGpLNUvE7
dZbpfmcnkj2/MI6gnlTWucZd4033hLlZoN0kuX2waoYCem5IY+L/6mWpP9f45RQZ
wNCtOAq89iVRamJK5jQNd1UxqwBt5A==
=dwFC
-----END PGP SIGNATURE-----

--Sig_/9wo_KwYw/tNprJT532caCWR--
