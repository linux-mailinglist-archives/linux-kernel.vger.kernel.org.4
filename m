Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AD664F309
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 22:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiLPVPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 16:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLPVPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 16:15:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65D61D69;
        Fri, 16 Dec 2022 13:15:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D31DB81DA0;
        Fri, 16 Dec 2022 21:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F72C433EF;
        Fri, 16 Dec 2022 21:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671225311;
        bh=BhKUvHili8P/IlCGNPbXXOBNfa2kM82Ro/0ibRWF4Fs=;
        h=Date:From:To:Cc:Subject:From;
        b=tMcsZU/opCaa9XFdbV7HwfzVX3bKeOt1VshwwMHaiqtlY5Q/SCWXPfvR3y7h93rJs
         2pMAs18hT5DrDl+Db+WKvdplaT9zEYgwRHlr9e8INy0NE8J1cUKQHZLK69lZNpDfdd
         YT0lhmQELg9POsI9Ro68SxRUMAY36gOMCgGSiMd83HZYbJC9NhOWkNXo7KaCwa6uxs
         uYRixzPtYt0bPRkhSknz64/1dzJUX0NOzprl4HZ94HYvnzqvdvuKfMbsrFISPwTLCq
         yyIko+QZNXRay+6980nDA7KDYsinNuyZQPCVsC3kwNSDWk1Tnird22SupNGtJt0+mm
         0l0Ee0ErNkLJg==
Received: by mercury (Postfix, from userid 1000)
        id F2FAB1060F45; Fri, 16 Dec 2022 22:15:08 +0100 (CET)
Date:   Fri, 16 Dec 2022 22:15:08 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.2
Message-ID: <20221216211508.dxifq5nrw62jh75g@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ggljl3sowcsgady"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ggljl3sowcsgady
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/for-v6.2

for you to fetch changes up to 104bb8a663451404a26331263ce5b96c34504049:

  power: supply: fix null pointer dereferencing in power_supply_get_battery=
_info (2022-12-05 22:56:16 +0100)

----------------------------------------------------------------
power supply and reset changes for the v6.2 series

- bq25890: add charge voltage/current support
- bd99954: convert to linear range
- convert all i2c drivers to use probe_new
- misc. fixes and cleanups

----------------------------------------------------------------
Angel Iglesias (1):
      i2c: core: Introduce i2c_client_get_device_id helper function

Colin Ian King (1):
      power: supply: lp8788: make const array name static

Hans de Goede (3):
      power: supply: bq25890: Only use pdata->regulator_init_data for vbus
      power: supply: bq25890: Ensure pump_express_work is cancelled on remo=
ve
      power: supply: bq25890: Fix usb-notifier probe and remove races

Krzysztof Kozlowski (5):
      dt-bindings: power: reset: restart-handler: add common schema
      dt-bindings: power: supply: define monitored-battery in common place
      dt-bindings: power: supply: bq25890: allow power-supply fields
      dt-bindings: power: supply: maxim,max17042: allow power-supplies
      dt-bindings: power: supply: bq25890: use one fallback compatible

Lukas Bulwahn (1):
      power: supply: core: repair kernel-doc for power_supply_vbat2ri()

Marek Vasut (7):
      power: supply: bq25890: Document POWER_SUPPLY_PROP_CURRENT_NOW
      power: supply: bq25890: Clean up POWER_SUPPLY_PROP_CONSTANT_CHARGE_CU=
RRENT
      power: supply: bq25890: Clean up POWER_SUPPLY_PROP_CONSTANT_CHARGE_VO=
LTAGE
      power: supply: bq25890: Add support for setting user charge current a=
nd voltage limit
      power: supply: bq25890: Factor out regulator registration code
      power: supply: bq25890: Add get_voltage support to Vbus regulator
      power: supply: bq25890: Add Vsys regulator

Matti Vaittinen (3):
      power: supply: bd99954: Use LINEAR_RANGE()
      power: supply: mt6360: Use LINEAR_RANGE_IDX()
      power: supply: 88pm860x: simplify using devm

Qiheng Lin (1):
      power: supply: Fix refcount leak in rk817_charger_probe

Sebastian Reichel (1):
      Merge 'i2c/client_device_id_helper-immutable'

Shang XiaoJing (1):
      power: supply: cw2015: Fix potential null-ptr-deref in cw_bat_probe()

Uwe Kleine-K=F6nig (24):
      power: supply: adp5061: Convert to i2c's .probe_new()
      power: supply: bq2415x: Convert to i2c's .probe_new()
      power: supply: bq24190: Convert to i2c's .probe_new()
      power: supply: bq24257: Convert to i2c's .probe_new()
      power: supply: bq24735: Convert to i2c's .probe_new()
      power: supply: bq2515x: Convert to i2c's .probe_new()
      power: supply: bq256xx: Convert to i2c's .probe_new()
      power: supply: bq25890: Convert to i2c's .probe_new()
      power: supply: bq25980: Convert to i2c's .probe_new()
      power: supply: bq27xxx: Convert to i2c's .probe_new()
      power: supply: ds2782: Convert to i2c's .probe_new()
      power: supply: lp8727: Convert to i2c's .probe_new()
      power: supply: ltc2941: Convert to i2c's .probe_new()
      power: supply: ltc4162-l: Convert to i2c's .probe_new()
      power: supply: max14656: Convert to i2c's .probe_new()
      power: supply: max17040: Convert to i2c's .probe_new()
      power: supply: max17042_battery: Convert to i2c's .probe_new()
      power: supply: rt5033_battery: Convert to i2c's .probe_new()
      power: supply: rt9455: Convert to i2c's .probe_new()
      power: supply: sbs: Convert to i2c's .probe_new()
      power: supply: sbs-manager: Convert to i2c's .probe_new()
      power: supply: smb347: Convert to i2c's .probe_new()
      power: supply: ucs1002: Convert to i2c's .probe_new()
      power: supply: z2_battery: Convert to i2c's .probe_new()

Yuan Can (1):
      power: supply: ab8500: Fix error handling in ab8500_charger_init()

Zeng Heng (1):
      power: supply: fix residue sysfs file in error handle route of __powe=
r_supply_register()

Zhang Qilong (1):
      power: supply: z2_battery: Fix possible memleak in z2_batt_probe()

ruanjinjie (1):
      power: supply: fix null pointer dereferencing in power_supply_get_bat=
tery_info

wangjianli (1):
      power/supply: fix repeated words in comments

 .../devicetree/bindings/mfd/ene-kb930.yaml         |   6 +-
 .../devicetree/bindings/mfd/rockchip,rk817.yaml    |   2 +
 .../bindings/power/reset/gpio-restart.yaml         |  13 +-
 .../bindings/power/reset/restart-handler.yaml      |  30 +++
 .../devicetree/bindings/power/supply/bq25890.yaml  |  16 +-
 .../devicetree/bindings/power/supply/bq27xxx.yaml  |   2 -
 .../bindings/power/supply/ingenic,battery.yaml     |   4 +-
 .../bindings/power/supply/maxim,max17042.yaml      |   2 +
 .../bindings/power/supply/power-supply.yaml        |   6 +
 .../bindings/power/supply/rohm,bd99954.yaml        |   1 +
 .../bindings/power/supply/sc2731-charger.yaml      |   1 -
 drivers/i2c/i2c-core-base.c                        |  14 ++
 drivers/power/supply/88pm860x_charger.c            |  38 +--
 drivers/power/supply/ab8500_charger.c              |  11 +-
 drivers/power/supply/adp5061.c                     |   5 +-
 drivers/power/supply/bd99954-charger.c             |  84 +------
 drivers/power/supply/bq2415x_charger.c             |   6 +-
 drivers/power/supply/bq24190_charger.c             |   6 +-
 drivers/power/supply/bq24257_charger.c             |   6 +-
 drivers/power/supply/bq24735-charger.c             |   5 +-
 drivers/power/supply/bq2515x_charger.c             |   6 +-
 drivers/power/supply/bq256xx_charger.c             |   6 +-
 drivers/power/supply/bq25890_charger.c             | 277 +++++++++++++++--=
----
 drivers/power/supply/bq25980_charger.c             |   6 +-
 drivers/power/supply/bq27xxx_battery_i2c.c         |   6 +-
 drivers/power/supply/cw2015_battery.c              |   3 +
 drivers/power/supply/ds2782_battery.c              |   6 +-
 drivers/power/supply/lp8727_charger.c              |   4 +-
 drivers/power/supply/lp8788-charger.c              |   2 +-
 drivers/power/supply/ltc2941-battery-gauge.c       |   5 +-
 drivers/power/supply/ltc4162-l-charger.c           |   5 +-
 drivers/power/supply/max14656_charger_detector.c   |   5 +-
 drivers/power/supply/max17040_battery.c            |   6 +-
 drivers/power/supply/max17042_battery.c            |   6 +-
 drivers/power/supply/mt6360_charger.c              |  15 +-
 drivers/power/supply/power_supply_core.c           |   8 +-
 drivers/power/supply/rk817_charger.c               |   4 +-
 drivers/power/supply/rt5033_battery.c              |   5 +-
 drivers/power/supply/rt9455_charger.c              |   5 +-
 drivers/power/supply/sbs-charger.c                 |   5 +-
 drivers/power/supply/sbs-manager.c                 |   6 +-
 drivers/power/supply/smb347-charger.c              |   6 +-
 drivers/power/supply/ucs1002_power.c               |   5 +-
 drivers/power/supply/z2_battery.c                  |  11 +-
 include/linux/i2c.h                                |   1 +
 45 files changed, 387 insertions(+), 285 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/restart-h=
andler.yaml

--3ggljl3sowcsgady
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOc39wACgkQ2O7X88g7
+ppCFg//cJ2RvL2YP25YPKh/5Ys+qY6EIoGujnbYmu2/oh6puokTxvfAw9CnC2XW
9jcFaB4g1pAxyggEjrDmd6g6qsTvLZrUsaUC+9/uFoo6un7bAtlnF0SZNdGWU8jG
rY/Bq7rc9bLYoL+G6mh9FVNEDxI+Y3ilTfNQn8JSRys9RyIGM+TKCBLJ7hGX4DzA
SxAc0ZHjxRylSDcr/VQON7g2eAzQ8oHt65h29ZgCcBr3qVJwXqoG+tXt8OWzLILW
tMwfjqMEEHgJO4buOSHl6LA8/8FhE9qbSPtRQl8J24cqJXK2GfrzXSJB/VcVutRB
Da10wFtOFWtnAToFSaNi4pvMUc53JHedaH4QBW2YZ7hmUOYO0I7W6jJNuaRQJfnw
33Rf0dxPXcJ10VWd6recK/7G/Kb18UIshze/n9lZOwF475uyCWLnsL9vTdOCrrdn
HZJB+SxaPW5OJ9YNc+kiz/Zsbd+etGRhgarttExSEUwaN/Lm8oU/xHZ8S+zBJCAw
Fc+XzcOLOjjl6eEFbJVTly8Fub4O7d8vOn4FyWY1c4T+I8ZZSXRHyIU4WSLrdmVH
ZxSsvVbbQF62SFTTXqrWh80BawqD6NHLU91vRCru4yZ9vqvp6l5rlSzZYOVMTCop
ClTacCL/5CSgroxDiKov1BbEqQLfyfDa6Y4DyreCPKaWS3bm75k=
=F1Wc
-----END PGP SIGNATURE-----

--3ggljl3sowcsgady--
