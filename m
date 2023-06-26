Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276F473D7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjFZG3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFZG3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:29:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF3AA8;
        Sun, 25 Jun 2023 23:29:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHxL0xBtz4wZy;
        Mon, 26 Jun 2023 16:29:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687760952;
        bh=hZj5SpgUl5Mk5j8hYoLE+L8btm7Rk7BQ0o68g324GBk=;
        h=Date:From:To:Cc:Subject:From;
        b=BOBahx3pY3L3eGOJ8WOb7h7BlMyKQKC0OUJrcUvALWJij63+SHs07oFAJI1G5k7dj
         O4LZL6hHwIKAAQyurZI3+yV+SWVHu+vT1SxZprldGd2gBLLTr8UpsMgxn2vcC63DiI
         V0ndnuCzyQJsnsS/LB5bdPbPttb1wb0Wi1kbdLw9w5spaHNhiFmIVzAzuNuRBpO6Gx
         LzfOjyCpUqRQtYFBrntu93BXXmDJBbEj4GdiTHjaBmco8utTtdwIZh0XzAqbqWWgJ9
         G0PcEoSEtg8PF0Yzv+p3yvNU0f7a2Atft+j7Bj/Ewsz/a1hyI118mYJ7M0HZlRYTIg
         4ELutZF2rkxLw==
Date:   Mon, 26 Jun 2023 16:29:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the net-next tree
Message-ID: <20230626162908.2f149f98@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pgqS=2ogaJDS6o=laFxWZbx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pgqS=2ogaJDS6o=laFxWZbx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/networking/kapi:144: include/linux/phylink.h:110: ERROR: Unex=
pected indentation.
Documentation/networking/kapi:144: include/linux/phylink.h:111: WARNING: Bl=
ock quote ends without a blank line; unexpected unindent.
Documentation/networking/kapi:144: include/linux/phylink.h:614: WARNING: In=
line literal start-string without end-string.
Documentation/networking/kapi:144: include/linux/phylink.h:644: WARNING: In=
line literal start-string without end-string.

Introduced by commit

  f99d471afa03 ("net: phylink: add PCS negotiation mode")

--=20
Cheers,
Stephen Rothwell

--Sig_/pgqS=2ogaJDS6o=laFxWZbx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSZMDQACgkQAVBC80lX
0GwdiAf/Wa4isrd91W2nI9RQUXaMPonnmNvOJ/IRshOLqgqhQyw2d+bbdycqfHX6
rasmuBo0MW1z9ct1ci5sR3YTVH2WooA1Td3hNrbyNceOih4xkDPmvx+tHHRc/M6Z
qqrlR64SmVF0uMPIKn47Karf5UmtHSbCFvQ7IgAPFfuTIQxRa2N0iVJU584K3rdW
Ci8F3/ufVDbHQoiq8U5zxOdsouqXhSfkN0eiwmuU0A6GVgWz6jn208LKUyY0zzfa
mhCKamg8lwgUG9LWkWubGNZtJb9qvSR+NuYCnc371b2+Fq+7pT8hJN4WC27CmrUa
EYaSZqzlANa7EAThC6SuMD8W193DGA==
=b9NL
-----END PGP SIGNATURE-----

--Sig_/pgqS=2ogaJDS6o=laFxWZbx--
