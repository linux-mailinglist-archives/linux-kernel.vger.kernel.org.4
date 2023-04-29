Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4E6F255E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 18:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjD2Q6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 12:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD2Q6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 12:58:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD921711;
        Sat, 29 Apr 2023 09:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B70860A28;
        Sat, 29 Apr 2023 16:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1E9C433EF;
        Sat, 29 Apr 2023 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682787527;
        bh=9BhF2nTSCjFB0Gy5eknXva4Setavuky5AbLH1KVB80Y=;
        h=Date:From:To:Cc:Subject:From;
        b=UnK32S/UWo+TgFV/6KDuj6qZV3V+W7tG5+NPpk2T1Fp/nFV4zT5vWHkddTQcrFsXm
         3JQ47E/+SCDkCFp5FjRLmvnH0v+VUTxmAxJgSQC43+JKKP6Kq7Ca6aCwmFAWtNmbXc
         w49kCIZh8mv4xKYOqVrlJhNRzgweTGN8bha8yjwoFsXjPvrFNanxBuc0h4bBlRZbaa
         W5VMVP+M54aHEXrXfJbc0DboL7Pa6NczCzJ0NWLoxGpbocMzmu9xhU3OABN3Co1HlB
         wFsn356wPNBhKYwa2kEARkROb5TkyIjvFWAtrzyw573iFqLNBEMXXbXtEcsKl14WRQ
         nAKHbPhIm1cNQ==
Received: by mercury (Postfix, from userid 1000)
        id C80EF1066F41; Sat, 29 Apr 2023 18:58:43 +0200 (CEST)
Date:   Sat, 29 Apr 2023 18:58:43 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.4
Message-ID: <20230429165843.uobwenl6dy7x3vtr@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="td2ublvuvzdey55r"
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--td2ublvuvzdey55r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Not much this time, since I was super busy in this cycle. The pull
contains two merges. I had to merge in 6.3-rc3 for the ACPI
axp288_charger fix and my 6.3 power-supply fixes branch for the
rk817 fixes (as mentioned in the merge commit). I did not manage
to generate a proper diff stat for that, so the below one contains
the 6.3 fixes patches you already queued.

Thanks,

-- Sebastian

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.4

for you to fetch changes up to baba1315a74d12772d4940a05d58dc03e6ec0635:

  power: supply: rk817: Fix low SOC bugs (2023-04-08 00:30:05 +0200)

----------------------------------------------------------------
power supply and reset changes for the v6.4 series

- power-supply core support for automatic handling of constant
  battery data supplied by firmware
- generic-adc-battery: major cleanup
- axp288_charger: fix ACPI issues on x86 Android tablets
- rk817: cleanup and fix handling for low state of charge

----------------------------------------------------------------
Chris Morgan (2):
      power: supply: rk817: Drop unneeded debugging code
      power: supply: rk817: Fix low SOC bugs

Denis Arefev (1):
      power: supply: axp288_fuel_gauge: Added check for negative values

Grant Grundler (1):
      power: supply: cros_usbpd: reclassify "default case!" as debug

Hans de Goede (1):
      power: supply: axp288_charger: Use alt usb-id extcon on some x86 android tablets

Hermes Zhang (1):
      power: supply: bq256xx: Support to disable charger

Jiapeng Chong (1):
      power: supply: rk817: Fix unsigned comparison with less than zero

Krzysztof Kozlowski (7):
      power: supply: rt9455_charger: mark OF related data as maybe unused
      power: supply: twl4030_charger: mark OF related data as maybe unused
      power: supply: lp8727_charger: mark OF related data as maybe unused
      power: supply: ltc4162-l-charger: mark OF related data as maybe unused
      power: supply: bq24257_charger: mark OF related data as maybe unused
      power: supply: bq25890_charger: mark OF related data as maybe unused
      power: reset: qcom-pon: drop of_match_ptr for ID table

Rob Herring (1):
      power: supply: charger-manager: Use of_property_read_bool() for boolean properties

Sebastian Reichel (16):
      dt-bindings: power: supply: adc-battery: add binding
      power: supply: core: auto-exposure of simple-battery data
      power: supply: generic-adc-battery: convert to managed resources
      power: supply: generic-adc-battery: fix unit scaling
      power: supply: generic-adc-battery: drop jitter delay support
      power: supply: generic-adc-battery: drop charge now support
      power: supply: generic-adc-battery: drop memory alloc error message
      power: supply: generic-adc-battery: use simple-battery API
      power: supply: generic-adc-battery: simplify read_channel logic
      power: supply: generic-adc-battery: add temperature support
      power: supply: generic-adc-battery: add DT support
      power: supply: generic-adc-battery: update copyright info
      power: supply: generic-adc-battery: improve error message
      power: supply: generic-adc-battery: style fixes
      Merge tag 'v6.3-rc3'
      Merge tag 'for-v6.3-rc'

Zheng Wang (2):
      power: supply: bq24190: Fix use after free bug in bq24190_remove due to race condition
      power: supply: da9150: Fix use after free bug in da9150_charger_remove due to race condition

 .../bindings/power/supply/adc-battery.yaml         |  70 ++++++
 drivers/power/reset/qcom-pon.c                     |   2 +-
 drivers/power/supply/axp288_charger.c              |  15 +-
 drivers/power/supply/axp288_fuel_gauge.c           |   2 +
 drivers/power/supply/bq24190_charger.c             |   1 +
 drivers/power/supply/bq24257_charger.c             |   2 +-
 drivers/power/supply/bq256xx_charger.c             |  40 ++++
 drivers/power/supply/bq25890_charger.c             |   2 +-
 drivers/power/supply/charger-manager.c             |   2 +-
 drivers/power/supply/cros_usbpd-charger.c          |   2 +-
 drivers/power/supply/da9150-charger.c              |   1 +
 drivers/power/supply/generic-adc-battery.c         | 245 ++++++---------------
 drivers/power/supply/lp8727_charger.c              |   2 +-
 drivers/power/supply/ltc4162-l-charger.c           |   2 +-
 drivers/power/supply/power_supply_core.c           | 179 +++++++++++++--
 drivers/power/supply/power_supply_sysfs.c          |  23 +-
 drivers/power/supply/rk817_charger.c               |  46 ++--
 drivers/power/supply/rt9455_charger.c              |   2 +-
 drivers/power/supply/twl4030_charger.c             |   2 +-
 include/linux/power/generic-adc-battery.h          |  23 --
 include/linux/power_supply.h                       |   8 +
 21 files changed, 415 insertions(+), 256 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adc-battery.yaml
 delete mode 100644 include/linux/power/generic-adc-battery.h

--td2ublvuvzdey55r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRNTL8ACgkQ2O7X88g7
+pogNA/8CWq8enJWIft8JV9mn3HW1jykXqkoEy2ZOW+wZYlVHMhNKHtTd8HHQvPt
beTsctR7x4fpG+LFH20D8tYBRNftPmH/MSlGqyamF+wQEJnqZ+YJx8u0p8yCl3aR
ynkI7FGmHTbRkA04k5coT9XyYYNdx+/tYCAWHGNXBf/hh6n39O1+QL0HAEvB6Ytx
LOzp9L10EvKSKSqeOVtdqdmSKbqggXVMRLcS5O/2ETW/cLeMloNsxCt2YNpgkouR
uKkY05ZFdXyFokkDETi36N8luT6r+3qYXErRI1aJ18dAwKRtbSTiv7sgY4n1Q9xI
YVMdgJgNe5+OxC4NbP9mdefKqxxqrFeusqLqRKy5dBRSOBA/0Qa3mgNY3E8T/E/q
9cAn/vpDzhobn3kcJU+xSw90YZ5z2z337ntbiIfWEE/3657oFy2NCxQFvk1WuVWY
+rf0ftBXnLIXr10PhNHs/kYSqy6R90UmGA9htjiWPRB6SxOGHUHneZTbdIRbRr7y
LY5l6EON+tucec3UTi+t5fUOBiDYhDoPD0crK5DNO5ae6YX8dxM6YwSLY7O/G8mT
KTaqYwRj5vnkCEp/lOoHhLYEP6uS1MHp8WTgvk3CXeDQb+hF+1vaWEjkcha+27wT
p+SJfbi0jkL7PFolzIq8/bYZaElI7n1I6oIyF7C1BXEqF0RjtSs=
=wyeU
-----END PGP SIGNATURE-----

--td2ublvuvzdey55r--
