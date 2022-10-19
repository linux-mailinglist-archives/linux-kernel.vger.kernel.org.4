Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7E26051C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiJSVJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJSVI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:08:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59CE1C77D3;
        Wed, 19 Oct 2022 14:08:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mt3Hq26Ztz4xG5;
        Thu, 20 Oct 2022 08:08:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666213735;
        bh=ZJ4f2jevkdHDlRv7osEd5K0zNgR8F9EQdr4PSe2DiKQ=;
        h=Date:From:To:Cc:Subject:From;
        b=t9XWWds7F3MiOyVjL+qaoyEUU8X8WoPSFfe6vN+zlzTZcIy0IYGtj3dVPwXOrml9F
         iR/a25gKLFKrkDyNvyOQh0y6FlL3LzY98wdV/6sqnEijyHoVuch5a4b6v5s/FwEZnl
         +OXwghx/TXKXPk40m3pfz6lp4B0M+iYlaaDZXpoUc+LwglkPahNtrfnCdIdi1xJQDv
         qT4nhRuNLThqwD61WfODSsym3bWN10Fa/qb4R1EgJbzvy8PFZ7CSjUx1hmLVsLUb8F
         y1R6xOZW+r1FSen6hIdd46hfVeHkepS1RVid7Mu69kjCy+SOgC7llerDh5rjDmSgaQ
         QBDNlgtVvFt5w==
Date:   Thu, 20 Oct 2022 01:26:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pci-current
 tree
Message-ID: <20221020012608.20a5f3dc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PAJilSD9HTNI4o9jiM8Aqt9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PAJilSD9HTNI4o9jiM8Aqt9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  22286757d2f5 ("MAINTAINERS: Update Kishon's email address in PCI endpoint=
 subsystem")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/PAJilSD9HTNI4o9jiM8Aqt9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNQCQAACgkQAVBC80lX
0GwyAwf9FIiqj4a6J+H9K7uGNQEmiWdo6940P3XiZNj8/nunD6wnCI4FBMuCph34
tVATP8W2tvk0VVkgTxwKso9QfZUV6W3smIvaHT1TvhkBmONxN+CVFb3eQ2MdE8KP
X+lbmSsJOIXArxRsDg8JZBLLWZc0wxpJ6xxi4Tdvz74Z6SstlsYQbMwqFPjd2dCG
ry3njJW1JcxLRnDkIgCLNI720TGQph50a0ATL+dQKKMAtaIw3jQa2jlgM+9ULxrh
GijMHrKn3/47dDReRxdjFSLyMkeoE8xfGyOrO/glg4/89pd0Pp3i/6MpgPljQjkG
zUiXoJ77Df6nJzVYlBYK84HIQ7isYg==
=x08p
-----END PGP SIGNATURE-----

--Sig_/PAJilSD9HTNI4o9jiM8Aqt9--
