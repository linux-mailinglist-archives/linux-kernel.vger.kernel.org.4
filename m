Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671F27465D4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 00:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGCWrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 18:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCWrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 18:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE417E59;
        Mon,  3 Jul 2023 15:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 097B56106C;
        Mon,  3 Jul 2023 22:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485E7C433C7;
        Mon,  3 Jul 2023 22:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688424440;
        bh=bOBJJtP5RiRGHnONa4i8/TIYLGK0hCJ1cQZticwJ4Xw=;
        h=Date:From:To:Cc:Subject:From;
        b=M3C4yi+r3Dbp3jRaFdEU1gy7nzHzzvt0O4vv1K8b6ZCnjDdfx8uK0GAfKq4939RaK
         0IySrbtTWZOu2CBgXO7MRIrWXALJ36MEsJy8RqwmcB60DGm5SLVzRlHgMhILj8ZuCV
         lGyX+w4p+ROoZfgEYpXNnBY9TG+GeJTds1yt/gYYOXrYwS1PIU5S6YMxeLek0Rk6zg
         v3TwGGW57XYw3bxmiElBJ0gRpq7PDqyQShgWolAx5eBcjZJKrQhL5oIuRbqcV6EPa0
         QYMrCZIxV7qvF9dTfbHJWcKS1VDupyjeFjyShzXmVaiQmY71d7wNxA6eT+MDHIvFlf
         QheaYiLE4gO2Q==
Received: by mercury (Postfix, from userid 1000)
        id 745581061814; Tue,  4 Jul 2023 00:47:17 +0200 (CEST)
Date:   Tue, 4 Jul 2023 00:47:17 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.5
Message-ID: <20230703224717.r74bjlyx5ikbk4bh@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jmbzm6eztaz2xsbx"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jmbzm6eztaz2xsbx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the power-supply pull request for 6.5. No merge conflicts
are expected. Patches have been in next for two weeks.

Greetings,

-- Sebastian

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.5

for you to fetch changes up to ef8d95b4a3af4ebfe47e3563c3bc5767dda28207:

  MAINTAINERS: add documentation file for Microchip SAMA5D2 shutdown contro=
ller (2023-06-19 23:48:07 +0200)

----------------------------------------------------------------
power supply and reset changes for the 6.5 series

* Add new Qualcomm PMI8998/PM660 SMB2 charger
* bq256xx: support systems without thermistors
* cros_pchg: fix peripheral device status after system resume
* axp20x_usb_power: add support for AXP192
* qcom-pon: add support for pm8941
* at91-reset: prepare to expose reset reason to sysfs
* switch all I2C drivers back to use .probe instead of .probe_new
* convert some more DT bindings to YAML
* misc. cleanups

----------------------------------------------------------------
Aidan MacDonald (7):
      power: supply: axp20x_usb_power: Simplify USB current limit handling
      power: supply: axp20x_usb_power: Use regmap fields for VBUS monitor f=
eature
      power: supply: axp20x_usb_power: Use regmap fields for USB BC feature
      power: supply: axp20x_usb_power: Use regmap field for VBUS disabling
      power: supply: axp20x_usb_power: Remove variant IDs from VBUS polling=
 check
      power: supply: axp20x_usb_power: Add support for AXP192
      dt-bindings: power: supply: axp20x: Add AXP192 compatible

Bartosz Golaszewski (1):
      dt-bindings: power: reset: convert nvmem-reboot-mode bindings to YAML

Caleb Connolly (2):
      dt-bindings: power: supply: qcom,pmi8998-charger: add bindings for sm=
b2 driver
      power: supply: add Qualcomm PMI8998 SMB2 Charger driver

ChiYuan Huang (1):
      power: supply: rt9467: Make charger-enable control as logic level

Christophe JAILLET (1):
      power: supply: rk817: Simplify an error message

Claudiu Beznea (3):
      dt-bindings: power: reset: atmel,at91sam9260-shdwc: convert to yaml
      dt-bindings: power: reset: atmel,sama5d2-shdwc: convert to yaml
      MAINTAINERS: add documentation file for Microchip SAMA5D2 shutdown co=
ntroller

Daisuke Nojiri (1):
      power: supply: cros_pchg: Sync port status on resume

Dmitry Baryshkov (2):
      dt-bindings: power: reset: qcom-pon: define pm8941-pon
      power: reset: qcom-pon: add support for pm8941-pon

Hans de Goede (2):
      power: supply: max17042_battery: Refactor max17042_external_power_cha=
nged()
      power: supply: twl4030_madc_battery: Refactor twl4030_madc_bat_ext_ch=
anged()

Hermes Zhang (2):
      dt-bindings: power: supply: bq256xx: Add ti,no-thermistor property
      power: supply: bq256xx: Apply TS_IGNORE from devicetree

Konrad Dybcio (1):
      dt-bindings: power: reset: qcom-pon: Only allow reboot-mode pre-pmk83=
50

Krzysztof Kozlowski (1):
      power: supply: hwmon: constify pointers to hwmon_channel_info

Miquel Raynal (1):
      power: reset: at91-reset: change the power on reason prototype

Niklas Schnelle (1):
      power: reset: add HAS_IOPORT dependencies

Uwe Kleine-K=F6nig (2):
      power: reset: gpio-restart: Convert to platform remove callback retur=
ning void
      power: supply: Switch i2c drivers back to use .probe()

 .../devicetree/bindings/arm/atmel-sysregs.txt      |   94 --
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |    1 +
 .../power/reset/atmel,at91sam9260-shdwc.yaml       |   82 ++
 .../bindings/power/reset/atmel,sama5d2-shdwc.yaml  |  114 +++
 .../bindings/power/reset/nvmem-reboot-mode.txt     |   26 -
 .../bindings/power/reset/nvmem-reboot-mode.yaml    |   52 +
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |   20 +-
 .../devicetree/bindings/power/supply/bq256xx.yaml  |   18 +
 .../power/supply/qcom,pmi8998-charger.yaml         |   82 ++
 .../supply/x-powers,axp20x-usb-power-supply.yaml   |    1 +
 MAINTAINERS                                        |    1 +
 drivers/power/reset/Kconfig                        |    1 +
 drivers/power/reset/at91-reset.c                   |    9 +-
 drivers/power/reset/gpio-restart.c                 |    7 +-
 drivers/power/reset/qcom-pon.c                     |   22 +-
 drivers/power/supply/Kconfig                       |    9 +
 drivers/power/supply/Makefile                      |    1 +
 drivers/power/supply/adp5061.c                     |    2 +-
 drivers/power/supply/axp20x_usb_power.c            |  307 +++---
 drivers/power/supply/bd99954-charger.c             |    2 +-
 drivers/power/supply/bq2415x_charger.c             |    2 +-
 drivers/power/supply/bq24190_charger.c             |    2 +-
 drivers/power/supply/bq24257_charger.c             |    2 +-
 drivers/power/supply/bq24735-charger.c             |    2 +-
 drivers/power/supply/bq2515x_charger.c             |    2 +-
 drivers/power/supply/bq256xx_charger.c             |   30 +-
 drivers/power/supply/bq25890_charger.c             |    2 +-
 drivers/power/supply/bq25980_charger.c             |    2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c         |    2 +-
 drivers/power/supply/cros_peripheral_charger.c     |   25 +-
 drivers/power/supply/cw2015_battery.c              |    2 +-
 drivers/power/supply/ds2782_battery.c              |    2 +-
 drivers/power/supply/ip5xxx_power.c                |    2 +-
 drivers/power/supply/lp8727_charger.c              |    2 +-
 drivers/power/supply/ltc2941-battery-gauge.c       |    2 +-
 drivers/power/supply/ltc4162-l-charger.c           |    2 +-
 drivers/power/supply/max14656_charger_detector.c   |    2 +-
 drivers/power/supply/max17040_battery.c            |    2 +-
 drivers/power/supply/max17042_battery.c            |    9 +-
 drivers/power/supply/max77976_charger.c            |    2 +-
 drivers/power/supply/power_supply_hwmon.c          |    2 +-
 drivers/power/supply/qcom_pmi8998_charger.c        | 1059 ++++++++++++++++=
++++
 drivers/power/supply/rk817_charger.c               |    2 +-
 drivers/power/supply/rt5033_battery.c              |    2 +-
 drivers/power/supply/rt9455_charger.c              |    2 +-
 drivers/power/supply/rt9467-charger.c              |    4 +-
 drivers/power/supply/rt9471.c                      |    2 +-
 drivers/power/supply/sbs-battery.c                 |    2 +-
 drivers/power/supply/sbs-charger.c                 |    2 +-
 drivers/power/supply/sbs-manager.c                 |    2 +-
 drivers/power/supply/smb347-charger.c              |    2 +-
 drivers/power/supply/twl4030_madc_battery.c        |    8 +-
 drivers/power/supply/ucs1002_power.c               |    2 +-
 drivers/power/supply/ug3105_battery.c              |    2 +-
 54 files changed, 1699 insertions(+), 343 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,at9=
1sam9260-shdwc.yaml
 create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,sam=
a5d2-shdwc.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/nvmem-reb=
oot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/nvmem-reb=
oot-mode.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pmi=
8998-charger.yaml
 create mode 100644 drivers/power/supply/qcom_pmi8998_charger.c

--jmbzm6eztaz2xsbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSjT+oACgkQ2O7X88g7
+prLihAAlnwfDbCQQZzijtl3cnj4i7FeQ5dS+8BUcU+pskpWDdCctXNlv742NJzn
FzZYANI+RvbA9i62k+lptqcwC4PL7Y5xB3DuV82bBe596meRKLqf7YOshta1ZuK5
Eh4myu689QYg/MNWbsyGNGeYdaQiMic7D3gzRV+I0AAl+mlv0vnHHyzC3tuzUTnI
UqLBrRsEX67klusPvJ7SyOGIQIxh9W7s1ZYeslCdOJmLzgwLjEKrYG73ZWnQl1Yh
8o01vjuNdH+d5MDRnjxJTEQEnGyt1sv9ocDnVslfd0sO4UAIn/znzhvvz3gvBhlG
FAvn6UDsNC/2PQf5FDLUls92pyPd/mbE3sTFupPYmYH5HeHu4RqlWVi/YmvF7W9z
lipCedtTtp9RH+urM/Aiel7ZsoSsPYD5VvqMYXF562wirOfiYZy1DsHLUgxCxpHa
3DYr4I+IjtgPjCcMxAhqXem3y+ocg7NLXmO6QkK2kg/ouOUcOCtUz9Be8CTqyMs+
+/4MAnhrjUgakjq4TPl7vJyzcW6XczckaYLSY+jxSgaLFOobihx3JBJNeX3+iOmJ
8dpXZ/fcTJX0kwc4vKt/sS3mLGwh4n3+G1xkTPvclI8BDbN06K+r8BgRnYwXksuu
7kVYe7sTTF7okyBJq1eqZqicJSoVm5A2bWlsL3J4nL2x6561FRs=
=QO9V
-----END PGP SIGNATURE-----

--jmbzm6eztaz2xsbx--
