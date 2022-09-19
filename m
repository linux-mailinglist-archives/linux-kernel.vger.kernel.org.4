Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391425BC1FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 06:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiISEU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 00:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiISEUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:20:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1087712758;
        Sun, 18 Sep 2022 21:20:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MWBKv55Fbz4xG6;
        Mon, 19 Sep 2022 14:20:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663561221;
        bh=ShLocAlOND8r9lKpNdlfYgRuznNVexTr8rgvFbP6tRA=;
        h=Date:From:To:Cc:Subject:From;
        b=n+EPjENvcmWFZ+ItpQe+K9JSH0TErULALTDn69+dpSiqWcFwxZqTBOfl//TVZ8scS
         7bz9p7aNq232HCVmmQpHvvERdzvMDEqOHM0pQDQBex9R2kHWLmc6xnor3CH0+bUl4O
         4NoJGIhme7Zs90ZtSVev3v/dV2KlqVT/XkuT4RT/YA8GNu3a/vFLwdezJup0faLEXK
         zf2PFMLXVhlTk1HkZRBrGR3MMGxAIDPYiGQnX/PfT1v3CV61GdTrK3pBpcOouhfzwa
         sUh+C0zFUQU6VFDr9s8kWy7Xk+aeVxea3H9/r36n95F+woxrLFwFHLmSQsJ5NBuNzt
         lFSZRxf2Tl0kQ==
Date:   Mon, 19 Sep 2022 14:20:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Arvid Norlander <lkml@vorpal.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the drivers-x86 tree with the pm tree
Message-ID: <20220919142017.77555449@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KRSLZuq1lXhmmebLcWZZQWM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KRSLZuq1lXhmmebLcWZZQWM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  drivers/acpi/acpi_video.c

between commit:

  574160b8548d ("ACPI: video: Add Toshiba Satellite/Portege Z830 quirk")

from the pm tree and commit:

  c5b94f5b7819 ("ACPI: video: Change disable_backlight_sysfs_if quirks to a=
cpi_backlight=3Dnative")

from the drivers-x86 tree.

I fixed it up (the latter change seems to incoporate the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/KRSLZuq1lXhmmebLcWZZQWM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMn7gIACgkQAVBC80lX
0GwBiQf/WE7jtl9g6KcVE70Hl5BwEP7WDeYT/NYcqFOCwjlZa20CMZdpiFWeYp5k
wYJi9Et/Qynr62tq/jlC/06myiWSdLmDqiu3OZv12IZ61B5SqDjqWwzfYnivyg7s
fvVNYSmb0cGrt5hVbkEwJD5LwG84B+EWnzyPvRIln2UUfFmSiqredqtv7Be82nxE
czarLGlg6opOb39maVF9M1cBcwyx5Ez7OiBBsUVUh90e24JIN9EvGU/t5OqOV9TJ
kLKBwlvnFfvHCaNL9EO1+MKtWG2eH+2gPlXfU8YGH7lBf1rdhitOsfFW/aDoLdde
4bu727xv5tJA66BaflcTMl0i0ij2Ww==
=XUFF
-----END PGP SIGNATURE-----

--Sig_/KRSLZuq1lXhmmebLcWZZQWM--
