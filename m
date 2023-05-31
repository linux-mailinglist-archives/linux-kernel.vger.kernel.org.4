Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CEA7172B7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjEaAqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEaAp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:45:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBDFA0;
        Tue, 30 May 2023 17:45:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QW9YC0rVQz4x1R;
        Wed, 31 May 2023 10:45:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685493951;
        bh=2fDgm4fosu3usB3XuGndIWWKh/GegmrYwHl+2OxrhHk=;
        h=Date:From:To:Cc:Subject:From;
        b=j9Ow9A89tGGt3pWdTqbEPgUvDOrftUzT5C3M4feM4i1uE6069zXiWnSN46ednkLmn
         EPtQCUp46kRKfH+SAbPNDe9hBRZbsvjhF1t7XkECZanB5ksLvR1OLi6wEL/b/lO4b4
         8Gh5LeEQ37DVh7LN9CRtDDs7OD8Sfbv/pVJj5xLJAqXHNBuHRS20a+kt/+rp7XU4OZ
         WlxNRBBT9+BjqP+zQp9v7IcbaI2pLF/XzqgRKVR561gu0WnW703tk4WGy8XOfcNJID
         rS7glp3f9Xy/drrjEl6Aby1m6N389C4p2iMcj8T28gVHdJ2bAjHwVf9CvzScU+0jCN
         xmmlZjB761AKQ==
Date:   Wed, 31 May 2023 10:19:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the fpga-fixes tree
Message-ID: <20230531101925.39360756@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X4T5yPeh6aW4zhwsAM7brzz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X4T5yPeh6aW4zhwsAM7brzz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the char-misc.current tree as different
commits (but the same patches):

  d8bdc50012fe ("dt-bindings: fpga: replace Ivan Bornyakov maintainership")
  feeb9c9219bd ("MAINTAINERS: update Microchip MPF FPGA reviewers")

These are commits

  9da6225bc737 ("dt-bindings: fpga: replace Ivan Bornyakov maintainership")
  929f4e7c06ca ("MAINTAINERS: update Microchip MPF FPGA reviewers")

in the char-misc.current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/X4T5yPeh6aW4zhwsAM7brzz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR2ko0ACgkQAVBC80lX
0GzQsAf6As1Sv3c7W9cYS/b3cKpAevuax2nOzLnc2HWfAnPhGiHAw9smGKptTmi+
LsTGYMJyWEtgEu+l+vt/RSKFvYTMECehrpLtEjNntUjsRYYRZW4uVhRqKlCEPM7m
prlKKOgBUvt8n8odjFYo7C6tMp+i9ApcWekqI1t4fqxrv6yBBju5ZNo5IPP6Nlyq
LOUCxnMGUpbQhh865+nRNvaCb0OKLrHy3bga/4hRyptQKCrMTpyCFiwlJ9WoqLdT
OiM0TYccETtIMJY8E0ppAVjRyds0JXs7URYpXYhoa7nGejbHeeudWMVwOfCnFo11
BqVKn1rcFlhYmdcM4B4Z+GHHQUK50A==
=Xjh9
-----END PGP SIGNATURE-----

--Sig_/X4T5yPeh6aW4zhwsAM7brzz--
