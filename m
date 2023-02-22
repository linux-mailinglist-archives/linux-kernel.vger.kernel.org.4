Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D84869FEB0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjBVWqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBVWqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:46:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0CD10D9;
        Wed, 22 Feb 2023 14:46:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBBD4615BB;
        Wed, 22 Feb 2023 22:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A74DC4339B;
        Wed, 22 Feb 2023 22:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677106005;
        bh=zbgZaBW/Q2tJROcrBif09erW7g96vrbI21VmWagnlmg=;
        h=Date:From:To:Cc:Subject:From;
        b=UolME5U4ddO/kM3jA1dhMtZSwClSqVZ2CkL3a/spWV+1BQEYAkrhQ+RYXfdzWAqlv
         B2gKZ8GIGTpBClnqAipYquESlU3Xjm3/BV5x8Ndmg3GmLg6p6qHncpl46dVbUmx69N
         aTYxI4aqHOF4kFYwt3BZ3MeJeXyvar8U+sL23KjjJkykCA/KbbzziGJ/HCF47YHKGx
         4ojAvIpG+pTpzx3mSrOCHFLCBVRBnRtgcUJBRJdC4SGE7MKIw7ppTx6cgVyt/zchZp
         ++v5c7H5tSrLzVReDfehczHtIqYEzKhkVE5TexNC/9kFWpyWZxabd+Jq3GQvcrSxAq
         BP6YpiBHihdHA==
Received: by mercury (Postfix, from userid 1000)
        id 7760C10603FE; Wed, 22 Feb 2023 23:46:42 +0100 (CET)
Date:   Wed, 22 Feb 2023 23:46:42 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.3
Message-ID: <20230222224642.u6cmwaoqtxty7sxx@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qxt4sqpb5my7myhq"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qxt4sqpb5my7myhq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Nothing special for the power-supply subystem this time.
There is a trivial merge conflict reported by Stephen,
that's barely worth mentioning:

https://lore.kernel.org/linux-next/20230206112143.71d626bd@canb.auug.org.au/

As always you can find the details in the signed tag
down below.

Thanks,

-- Sebastian

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/for-v6.3

for you to fetch changes up to c142872ea40a99258e2a86bf5c471bcc81752f56:

  power: reset: odroid-go-ultra: fix I2C dependency (2023-02-15 23:49:40 +0=
100)

----------------------------------------------------------------
power supply and reset changes for the v6.3 series

- power-supply core: remove faulty cooling logic
- convert all sysfs show() handlers from *printf() use sysfs_emit()
- bq25890: add dual-charger support required by Lenovo Yoga Tab 3 Pro
- bq27xxx: fix reporting critical level
- syscon-reboot: add priority property support
- Introduce new rt9467 charger driver
- Introduce new rt9471 charger driver
- Introduce new Odroid Go Ultra poweroff driver
- misc. minor fixes and cleanups

----------------------------------------------------------------
Andreas Kemnade (1):
      power: supply: remove faulty cooling logic

Andy Shevchenko (1):
      power: supply: collie_battery: Convert to GPIO descriptors (part 2)

Arnd Bergmann (1):
      power: reset: odroid-go-ultra: fix I2C dependency

ChiYuan Huang (3):
      dt-bindings: power: supply: Add Richtek RT9471 battery charger
      power: supply: rt9471: Add Richtek RT9471 charger driver
      Documentation: power: rt9471: Document exported sysfs entries

ChiaEn Wu (3):
      dt-bindings: power: supply: Add Richtek RT9467 battery charger
      power: supply: rt9467: Add Richtek RT9467 charger driver
      Documentation: power: rt9467: Document exported sysfs entries

Colin Ian King (1):
      power: supply: rt9467: Fix spelling mistake "attache" -> "attach"

Deepak R Varma (1):
      power: supply: da9150: Remove redundant error logging

Hans de Goede (5):
      power: supply: bq25890: Fix setting of F_CONV_RATE rate when disablin=
g HiZ mode
      power: supply: bq25890: Always take HiZ mode into account for ADC rate
      power: supply: bq25890: Support boards with more then one charger IC
      power: supply: bq25890: Add support for having a secondary charger IC
      power: supply: bq25890: Add new linux,iinlim-percentage property

Hermes Zhang (1):
      power: supply: bq256xx: Init ichg/vbat value with chip default value

Konrad Dybcio (2):
      dt-bindings: power: supply: pm8941-coincell: Add PM8998 compatible
      dt-bindings: power: supply: pm8941-coincell: Don't require charging p=
roperties

Marek Vasut (2):
      power: supply: bq25890: Factor out chip state update
      power: supply: bq25890: Add HiZ mode support

Minghao Chi (1):
      power: supply: max1721x: Use strscpy() is more robust and safer

Neil Armstrong (1):
      power: reset: add Odroid Go Ultra poweroff driver

Pali Roh=E1r (2):
      dt-bindings: reset: syscon-reboot: Add priority property
      power: reset: syscon-reboot: Add support for specifying priority

Sicelo A. Mhlongo (1):
      power: supply: bq27xxx: fix reporting critical level

Thomas Wei=DFschuh (1):
      power: supply: leds: explicitly include linux/leds.h

Uwe Kleine-K=F6nig (1):
      power: supply: max77650: Make max77650_charger_disable() return void

Xu Panda (1):
      power: supply: test-power: use strscpy() instead of strncpy()

Yang Yingliang (1):
      power: supply: rt9471: fix using wrong ce_gpio in rt9471_probe()

ye xingchen (2):
      power: supply: use sysfs_emit() instead of scnprintf() for sysfs show=
()
      power: supply: use sysfs_emit() instead of sprintf() for sysfs show()

 Documentation/ABI/testing/sysfs-class-power-rt9467 |   19 +
 Documentation/ABI/testing/sysfs-class-power-rt9471 |   32 +
 .../bindings/power/reset/syscon-reboot.yaml        |    4 +
 .../power/supply/qcom,pm8941-coincell.yaml         |   20 +-
 .../power/supply/richtek,rt9467-charger.yaml       |   82 ++
 .../bindings/power/supply/richtek,rt9471.yaml      |   73 ++
 drivers/platform/x86/x86-android-tablets.c         |    2 +-
 drivers/power/reset/Kconfig                        |    7 +
 drivers/power/reset/Makefile                       |    1 +
 drivers/power/reset/odroid-go-ultra-poweroff.c     |  177 +++
 drivers/power/reset/syscon-reboot.c                |    6 +-
 drivers/power/supply/Kconfig                       |   35 +
 drivers/power/supply/Makefile                      |    2 +
 drivers/power/supply/ab8500_fg.c                   |   22 +-
 drivers/power/supply/bq2415x_charger.c             |   42 +-
 drivers/power/supply/bq24190_charger.c             |    2 +-
 drivers/power/supply/bq24257_charger.c             |    8 +-
 drivers/power/supply/bq256xx_charger.c             |    4 +-
 drivers/power/supply/bq25890_charger.c             |  181 ++-
 drivers/power/supply/bq27xxx_battery.c             |    8 +-
 drivers/power/supply/charger-manager.c             |    6 +-
 drivers/power/supply/collie_battery.c              |    4 +-
 drivers/power/supply/da9150-charger.c              |    9 +-
 drivers/power/supply/ds2780_battery.c              |    8 +-
 drivers/power/supply/ds2781_battery.c              |    8 +-
 drivers/power/supply/lp8788-charger.c              |    7 +-
 drivers/power/supply/ltc4162-l-charger.c           |   12 +-
 drivers/power/supply/max14577_charger.c            |    2 +-
 drivers/power/supply/max1721x_battery.c            |    8 +-
 drivers/power/supply/max77650-charger.c            |    8 +-
 drivers/power/supply/max77693_charger.c            |    6 +-
 drivers/power/supply/mp2629_charger.c              |    2 +-
 drivers/power/supply/olpc_battery.c                |    2 +-
 drivers/power/supply/pcf50633-charger.c            |    6 +-
 drivers/power/supply/power_supply_core.c           |   93 --
 drivers/power/supply/power_supply_leds.c           |    1 +
 drivers/power/supply/power_supply_sysfs.c          |   10 +-
 drivers/power/supply/rt9467-charger.c              | 1282 ++++++++++++++++=
++++
 drivers/power/supply/rt9471.c                      |  930 ++++++++++++++
 drivers/power/supply/test_power.c                  |    3 +-
 drivers/power/supply/twl4030_charger.c             |    6 +-
 drivers/power/supply/wm8350_power.c                |    2 +-
 42 files changed, 2909 insertions(+), 233 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9467
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9471
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,=
rt9467-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,=
rt9471.yaml
 create mode 100644 drivers/power/reset/odroid-go-ultra-poweroff.c
 create mode 100644 drivers/power/supply/rt9467-charger.c
 create mode 100644 drivers/power/supply/rt9471.c

--qxt4sqpb5my7myhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmP2m08ACgkQ2O7X88g7
+poKwg/8DGAckyoBfLRfe7YGFNfgNkRU0K94BOzeIeF7y4GuYPnd0i8pFxdCPKTi
zJ9RjmfOOreIiOmn+4+PwrfOLGxCtdBh+jFL0d+7n+eW6j4HIibmqj4QUWc9sJtK
Hw2IpLLMJrn58LAtrCv7/Vu2pzevk+wdI+QPE+lubdhThUquncNpx2ugT/4gnlJE
FdrOCltpxfN6LPPHoA6eBFNu1D/FU5JzRMh4lL2MeIVh8LYFPomUvitc/HaKzje/
22irssHJseEzr6CQhdALvh6kmAZ1yP0PE59TsBhbADLuZDzsQRnnBdrufS8O78K4
zFoIIo42VhIjuxrq92yKLrL2LP24Ea8PmL6YnAIhQz+0JuwAz2EeAxQHAvmmmHDy
ijMZd2xs06Kje5uOMqU3zec1RTXbmCM0hXFGmMsjkTMxs19syp/F4fzAuzEvJOu4
1ZK4C8GpdjKOIvXzlDXKOoFvgvXqTk0burt/fdGrM9wfM7YOLPHVY33REUb/x2k4
Ii5VpNQ4IzyMcVDUYSeCjLmtQzOKQ19e4f/dpkde8Z6RNXuNUmK4UDkcO7nhgYbl
bxbo8wMoXlaOUqhFrnN8ekqLPtc5LEMvb1+ibwzKmxpnpIliS7vwUvhrUQOIbduQ
HLMRQL3INS5Y7hRV/ly/WHLW6lzrw+ArOxe8kPJcK8IUw0FtK9w=
=0Ipy
-----END PGP SIGNATURE-----

--qxt4sqpb5my7myhq--
