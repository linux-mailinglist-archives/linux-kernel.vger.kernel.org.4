Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDDF6392FC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 02:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiKZBEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 20:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKZBEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 20:04:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2174E201B1;
        Fri, 25 Nov 2022 17:04:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B512A61141;
        Sat, 26 Nov 2022 01:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CDAC433D6;
        Sat, 26 Nov 2022 01:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669424685;
        bh=TY8IZL8P0GF/A6JPjvDXNXoBU6fP3tYdWjqdkHU4+KQ=;
        h=Date:From:To:Cc:Subject:From;
        b=jdxb7OJTykXTbWY4qVib6VwP1PG4cWONNqmy33EzBOjEuIfgG8Y1Xbi3m6k900lZA
         TZAD3q8Rzqso3GSvglqjAG17syvH0axtZKPkigdq3ryjzO3UsgHiQ5FyQAn1Bhug5v
         QuTSWKCN9PBO9dXf94FL/eatVgXdcF8oTOgnwqTortbWGDkrmESwK6HHlzu5skRiMh
         oVeBP5apE5az3yl6zwmH2RMF6KZGnhCbYgu9aemYBurjgarsLtwzEaey62p/dYtc9d
         KWJSJqQrjT4g3Ai6jEUo+oX4PPHOsscfDip+TCNekVsdz3iBoTFYAMrE7tgTGNvWRf
         dRznfnYxAw/6A==
Received: by mercury (Postfix, from userid 1000)
        id 4014910613B8; Sat, 26 Nov 2022 02:04:41 +0100 (CET)
Date:   Sat, 26 Nov 2022 02:04:41 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply fixes for 6.1
Message-ID: <20221126010441.kkp6iavyvlcporpy@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vts4brejo3q2mbte"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vts4brejo3q2mbte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.1-rc

for you to fetch changes up to 767e684367e4759d9855b184045b7a9d6b19acd2:

  power: supply: ab8500: Defer thermal zone probe (2022-11-01 01:00:32 +0100)

----------------------------------------------------------------
Power Supply Fixes for 6.1 cycle

Fixes for the 6.1 cycle:
 * rk817: Two error handling fixes
 * ip5xxx: fix inter overflow in current calculation
 * ab8500: fix thermal zone probing

----------------------------------------------------------------
Chris Morgan (1):
      power: supply: rk817: Change rk817_chg_cur_to_reg to int

Dan Carpenter (1):
      power: supply: rk817: check correct variable

Linus Walleij (1):
      power: supply: ab8500: Defer thermal zone probe

Ondrej Jirman (1):
      power: supply: ip5xxx: Fix integer overflow in current_now calculation

 drivers/power/supply/ab8500_btemp.c  |  9 ++++++++-
 drivers/power/supply/ip5xxx_power.c  |  2 +-
 drivers/power/supply/rk817_charger.c | 14 ++++++--------
 3 files changed, 15 insertions(+), 10 deletions(-)

--vts4brejo3q2mbte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOBZigACgkQ2O7X88g7
+ppaDxAAgdH2kiKR3z0PT1/TrudVIhW0k7fHaLfq48WaVMTP5iKzOmoa55Wxf24s
fRiGV2NU/qJ4pzavY8hi1W+5SRCE0JshHXH6zFoorryEsDUWi9lplTZHDUavOjUD
U9IJPoyQ4hwmfgnB1GYJYfw3MlBFkypetSsrgbGUxVWQeWsrNh7kTtmoLX9abcHB
bVnOHWLOeQSsqBlgxdhc8P1J6juOhwPWCVQCBiX7s+80uGs3+o/ZGpmzuBUr9W2n
W0H+sVAlHAfz44EPi1KGhPpht4rahJv1XHrCPDNe1TB4hF0GlPXStY8+Yh8RicEF
5jlMwItQdL+eS9JSoRWnlHGsRUHprvgH40xPWPwuWPfqb7r6ghHAkW97g+2HMBe/
Ghp3BGyI9RV4nx6rDbyHf5/KcSFUeYTbRqrPyk0VcDUDc1PqwttRS9FPhd8EzGZW
mAF2LuB4AG7OB1KaI2prLELkAU7dZJPtBQ7Ei1Zqp+UcgjTfK7Yu10LAe8prQkYA
q7eK/V9pVNhEjh/Gf3/2aoQ5tgxIvuOdOzLWgw3V48BAi4u9eA9cp033R5mwbCu7
34EiN4hxwAUo7FBemW1RGlCEIOU1h1CKBEOrlBLjwTTsKrcm+0OrfwrL0R4ahJcZ
tlqy29pd1ZbrAWx64j7kv8TxFGYJW2uW67yr71JiJ9mG/pEf3iE=
=9E2u
-----END PGP SIGNATURE-----

--vts4brejo3q2mbte--
