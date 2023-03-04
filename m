Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B14C6AA61B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCDAMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCDAMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:12:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0699C1A498;
        Fri,  3 Mar 2023 16:12:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 75D02CE21C2;
        Sat,  4 Mar 2023 00:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D4BC433D2;
        Sat,  4 Mar 2023 00:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677888731;
        bh=/D+MeNZVhWO+HFCeoeJd/kEM4MK8zlGqnelldAKh9jY=;
        h=Date:From:To:Cc:Subject:From;
        b=b5uGotXO3Tx4NpatEau4Rd5/SZg6GTqcYlFwGycRSqClbgvMYLoCY5Mtsg7pJrWU8
         EA7AkFwU9jZ/VvmAh4XC0vZs8Y1jADjbQuq5HyogD9pJKWpXboIdLYn3bQF6UfBD69
         gI9azPPzTm4evRhh4bpXoUr1/Y6HJrUbcbynEN1WRjKV6CZeNJmDzdPRpi7IxvPPFS
         Hv6oUIDv8JU+8ADXHomC47EO38OQvG0hAuQHZJpjh//U0jBsBsvFFw6NAwaCGIaWXD
         GToeiB6ErU1S+LF7Yga/UcHIHrIEqQQr9a5xSOerjzZT6DjQ6R5wQuK3Y0W0PGIt4Y
         l1Aha7zNvpGyQ==
Received: by mercury (Postfix, from userid 1000)
        id 015DE10609DD; Sat,  4 Mar 2023 01:12:08 +0100 (CET)
Date:   Sat, 4 Mar 2023 01:12:08 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.3 (part 2)
Message-ID: <cfde34bf-c229-4a5d-b2c4-b76b5ba55dfb@mercury.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5m2g76thvtzrjhda"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5m2g76thvtzrjhda
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I have some more patches for the v6.3 cycle. They have been in
linux-next for a week without any issues. Please find the details
below.

The following changes since commit c142872ea40a99258e2a86bf5c471bcc81752f56:

  power: reset: odroid-go-ultra: fix I2C dependency (2023-02-15 23:49:40 +0100)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.3-part2

for you to fetch changes up to 13af134bdc6a9dacec4687e57b2ea8d3e08ff04f:

  dt-bindings: power: supply: Revise Richtek RT9467 compatible name (2023-02-25 01:17:24 +0100)

----------------------------------------------------------------
power supply changes for the v6.3 series (part 2)

- Fix DT binding for Richtek RT9467
- Fix a NULL pointer check in the power-supply core
- Document meaning of absent "present" property

----------------------------------------------------------------
Bastien Nocera (1):
      ABI: testing: sysfs-class-power: Document absence of "present" property

ChiaEn Wu (1):
      dt-bindings: power: supply: Revise Richtek RT9467 compatible name

qinyu (1):
      power: supply: fix null pointer check order in __power_supply_register

 Documentation/ABI/testing/sysfs-class-power                         | 3 ++-
 .../supply/{richtek,rt9467-charger.yaml => richtek,rt9467.yaml}     | 6 +++---
 drivers/power/supply/power_supply_core.c                            | 6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)
 rename Documentation/devicetree/bindings/power/supply/{richtek,rt9467-charger.yaml => richtek,rt9467.yaml} (92%)

--5m2g76thvtzrjhda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQCjNgACgkQ2O7X88g7
+ppMsBAAlKiViJ2nemJ6fwH1SIV/bTQmOklkjZQQrpJd/Q5d+tUgcYay2nD9FWUF
40tYGoDM8HMXx6ldn/aSds5vEx7QRA9vNQcJdOiyqx/bI3Ti2s2TBhGwGnLVrst3
YmI8Ex/NECM28kZ1S/H+FfjZEUHo49AzO2SSQ7aziZA1Rp9xcGVkaF0DrNkBQJzo
HrJDYR095sKGhc1sYt70BvN8Y6HiWzkjxjWqxwHyZzwyAELaTzwty0MN6OrivoYu
MpbVjrN+CNi/yz7Db+WSCiLVtm91EyE+0ohjIJYyvUBe3fxTbnUvaJpg/u3mnRsi
OzB34GjDZYrYh1uyI+p/dn84rdzl11NVkiP/OCkPCEJS8+A/U4cChHMGF4fyAQcg
RzsjDzjAl+9eCAT4ITcD0GtqyPUCEjjNJUJXplyy3Uw8++hrgP7xvgrdMM+2HK8e
IhJw+OKptdgSpd+EznPrihW7ZJP/01elgO3YSImhNl96lEX41oQynaGain+UWpO6
nJj8HLscXvS4icntGKMHcy71VM/UqXLGYDh7VUZYf6+lazxu/Gjxp987Svs8PhFS
sVB48Rq1uFIlOWn3k4F8egfYNnMnZ9w8toLjob1FOeMHcCWyz2dP6R3QDYfSCbLI
JErj5BIX+jCiz+YphvIlUe0ApwG+qM+Fb82ZwPeTbbuMLBbDZ8U=
=burO
-----END PGP SIGNATURE-----

--5m2g76thvtzrjhda--
