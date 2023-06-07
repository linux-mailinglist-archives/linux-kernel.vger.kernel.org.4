Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1127252F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjFGEl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjFGElZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:41:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBA583;
        Tue,  6 Jun 2023 21:41:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QbZRj3jLBz4x3g;
        Wed,  7 Jun 2023 14:41:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686112882;
        bh=L5fDwdous2yWpaw5MIUpaxze8IZTU/Z/NG8MZPHw1RI=;
        h=Date:From:To:Cc:Subject:From;
        b=feYEmHISrGBoaNyMuD25v4JVD+gYWVp1m00iWWdG3Ge9XccBdT8dhiGx6OE/C3OBW
         hbLe15i3jNx0mSstebvNCK8RE0cKbU2yVE7GyGy5Utc+gMNFYhnzUk+dWXERhaA7J/
         VGw/jrHEevqhlx3XvDCS6BnExR94hKShHb9Yp729P8ES9r7cz31KXt3Rmcaxc0lpWJ
         FoZWiHLxsCd4EGqkg17TiNINWLutBFP27AF8FxxgK1bJtyW+WqiAODu79i9p+6H0cr
         L3fbRXSuccRJhESbnzBiMlER7Qv0F8Q+Hx1n03sNrhP8IsWjfPB2zwZrHGs+yCsKUT
         9Sw6t+CcOQ0eg==
Date:   Wed, 7 Jun 2023 14:41:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the pm tree
Message-ID: <20230607144120.01ce4655@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i9DfzRcBIBgqRY7qAwEW.rU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i9DfzRcBIBgqRY7qAwEW.rU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in nvdimm-fixes tree as a different commit
(but the same patch):

  8f0e8597a7fa ("ACPI: NFIT: Add declaration in a local header")

This is commit

  40d3f4a65a07 ("acpi: nfit: add declaration in a local header")

in the nvdimm-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/i9DfzRcBIBgqRY7qAwEW.rU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSACnAACgkQAVBC80lX
0GyY+Qf/YOIVQHsPtedkGjXR21JxRBsg0CJvr+Zz8PpWpWjX4zdoRjox42HvuhyS
RaiENxcbD8l6gGWN110BQ+wRyn9UnIkmJaBXDPWHLRLPrjj1DdpmbxdGVE8S+gQv
NPzOvJobdqlLw0sDSUuw2rGaUKHkRb3J7yVvix9a8DsvS6E/uYYmI3X3d+LdGUrY
5Gsq4opc4lHDg3PUpgBTovmK6xkeb0zamBXoXacVjfvRs93uWA5ZF2ytcWilc7dw
ejDcjLYAaHxoOPrdrsp0KhRmX0QDHIzNu2p5d2Dh3WZYn2wT9hUhT+xki7evJzmc
wPAxwAJ2F+ZeTH11yh98HesWdMhpmg==
=7Cht
-----END PGP SIGNATURE-----

--Sig_/i9DfzRcBIBgqRY7qAwEW.rU--
