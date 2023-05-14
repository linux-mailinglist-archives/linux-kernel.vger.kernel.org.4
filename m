Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C67701D4E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjENMb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjENMby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:31:54 -0400
Received: from sonic302-20.consmr.mail.ir2.yahoo.com (sonic302-20.consmr.mail.ir2.yahoo.com [87.248.110.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F081720
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684067510; bh=LIpjzw43yAswmcqXPnpxZYz8CzOXQtvNx0gQj9Flbfw=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=M6e6pv1mxQUKgT6pRvy+tsRCgoBSGDj+wyYftWbClv2Gc/zpouBDemysvJg6j9iMEkpnGuVz1uxUeHZj+z0TeATlym+ZY7AIoP4PnPqOOYEWTEJGKX/flUD65Wbxxw7ozuFk9Gl/RCGyzBpgL2XHIzz/mvL1DrgFqgOZ0h+eXiNJUf6+UyhECUCS8PuakdGGHgAKCjVTEBnw1rzJKwd/y34VPcTMn3TYMn1zUWhwJdVehSoESX8wNIDz1HSqsrAbcgngQJMYdQOgfqMBxI6Ls5YawGgiR/s90Sdxn02FSzcOBsnjC4w5e6qid18io5ApVRWgeRzveyhSrtVPaHuRiQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684067510; bh=wSPmtaHvV3XsFmU5AcHElGb/HUuZARKV341mZWdkRJj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Rt2FFVD+HEdmNnGBVgWUqu7WlfI4SXktJSZtRohEk+GBG7WJS5iGPIq6bqTyaNkX2oBelYwImCvQqlvuJMtmi33GNCNaOplxUzFrFq1ct1KG85jTczCUq6oIOHaM8bXyMZClM11pMiOM1w3eh5SzUNRei5/1QUAn/6GTd1K7v0oDImXyghzm5gfR09fNdCaMN0ouuVLfreJHj3yHMTqrRNuNBoVJj29Uh+5iTMofbx4pvuAOY7GepIxcIMt6g3phn1uMXX8mrROWLf7zOwsP74f3eGMbZQC4Pz7tUUmEE/M1g9O3fh/QC/11x5Qfx5UqGnNw/MoXJctvdMRox1xgxw==
X-YMail-OSG: GU7I6agVM1nSqHH33UBeSuZjY3Cm1zjFlnZVfNYgQCsxalp.0_unYcvuYbLh3nv
 Lisi6QzDHWNS2Uraafs9wopb29QA7sH54hBYu15yl9ygDBMuy0q.D7_QGRna4Bey1a7hHV9quSHz
 V8a8TknBiRwYby9eVZLSIuZSTiHpY3GSK3CELJAWdctB1usq8dZzKNMv8nFrM3yjyw4n1PK3VWzf
 0x3CTpbb3wfV1OBGwmFq2opnKn7L1Vaff6qXkBXB.i_W4.Oq0pqvpsmD2wX3DWsmhv93Su8IDomL
 J4r3xOCHeJ3lMl15dSBAEMe8br98wwMW96LWBJtQtfOGxWxvsTA3g.vnhyR0sSHXZcbgHA.UF7WA
 ONfe_u9l5qwAml1b55oAMKcfvi6BEuDGlzwbOHd.bzZPB3.2OTKDhwoCBgxUswqnydVaXtTZNqo3
 eo2Kl6sAHeH9FwHy25NP229L1m5BWCmQ7GaipWujgsx4Qgju9652tI8pT9MGk5_8ELR3YRK6VpiI
 Np99VPfeHDDNxib2AztSF45gxT18i1nDg.O1uK7HF9LY23Mu8.sFW9wGHqENO1P3L.GRzebcf38M
 yMzbtQCm_5_3mxJRH8emGv2O4dHijj.o7auyrce3HHEdDLfdiKBqNn0iq10k1qKVo31wfBc1YNME
 EBjlAg16SWTc0CIMUNxLYcGxt5WKaY7kzsLRuMvzzN8yxUXxbu8b2ODtF4Wws4Cy_s5EYdPf8jhF
 IDR5isS1345sKtOJaMGT2Gf8MNY.Cm8tnv.TLVqZcUYG9H.nzsn7BQphwo6pPpzB6UmI9GLJU.HS
 3LPqrkoxQnS99nkne65lI9FhpVcFVyaMMo7YHWlaEVS.3FYljvjypTW4FyDKVmnPiaNuifTj1kjH
 2EXmJDgKKqQ5RJVXpxd_5enrjwdAOw8hx0wr1n2.9_w1WC.g_3kz7zsN0Uu_cEZNqx6kCZ8sXv0V
 dpCZC4TUOotDcONLw8aXV10taDPQPXOwncZTKq9LmFySM_FWOeiONS7qk5_kj2DjgM9wcn1g5bSD
 wYMzZ7Gb_dzb8MmP.phw9Zzhlq4ygz8slQM77wbvP0XfV.hjSwUI8bChXXyWxiyzlJx8fWp94xAP
 AsnxeiUNR1GCoFengVAbH5S6Da6g9Wvu1k71a3ez7Q0qW1eYI0RzBw57uY_Qsca9VN0yJ3ywhJEy
 oAZ_h6jdkXZwXg5F.ydF0j66IGwYWSiakhHEO5otV5UlZ4W_9jFGDJVCpOofBG90h.TR6z.xNlFy
 Ff6d8fBmC9DSk6Ov00vAG3srf.Exfp6TCJ4TGYctBnRDrVxDprkixSCkUs0AJ5gCRcFGpljyppee
 ZF8nto6QlXuN4F.fAFjWhsHUePqFCA9SmW0BdaoKF5SN5378kP1dWHRi_C5yQnthX0ITfB9.jp8k
 DnfOzh_2U_IuqODZo2LXsHcEAgwVX6SkcdoudOMTP9HlQ6YOQO8wR3QvjkRXatot_6e16PAyn2L5
 k0U4m5Kvsw.26dCTEx6wgZxqXtUDPYcHZVfTFdxVl9X8kYjXCGY6nZWlFV.RYp8u4Ohk69AAmVq1
 G7RMhMF7PMvC4lqnwUFGDlgbwqkgeV5ergLE9b.JqMmmNXZSWXHzlrjnKTBYfNdxgCaLgBpRZLW.
 EHj9Ibo81XhTLVGpWN8rJpO5y4QtQ9SSQUGsdyH0nl5N_TLq9T905docyfj.LKF8JIWXX89omIrE
 f6jInj1cPlV4VLrldQv0Z._UMZIaQsjxHLO6._2Ozr4_iZSOGqPzlN9XCnEF92S2pHGQZyVHaL0X
 ngkaIqFUqk7Q0oYazLOtBkvWMhf3RUNrvbdIgysLYvlLeQRyERQ3URakEZve.swkiTcaAY9E_zA_
 sKzYrTD09J9xb7Dx.McoURJ8qnR3jT8zkw_.QeuziarndnydnzoQ77BN6nWmv86DVNJSpaiqdmpV
 nxZVk3K_qbqxFQU2XzZRsyKN0x2oq9Gmqbf9GjI2yKddstNcwvSdkRc1wYmB5pjJ2yms49mFh_aV
 kcjkDVAbU8icxNNX.4rTNhdAcb50br.LZJXJ0VV0C8oXlAPg_gorlc2AsJXxWZ1GMx1Sf6lELBN0
 Ef6dS0KzfFc6bgTfHFZP2633C2yKTW0.LiBevcMk4lnOoA5TITJrGDnBpQq9RgsPL8vCXnLkpHlt
 JxmFUjS95Heez.2Y_t0QXqFDtG8uUzO957oCI__O3NfxFFs49pPgpbwTlSRsnHgVClNPyKmPMsSw
 zDR5zvha34VXvYGMfeOaHk34hnuAnmfTes2eStokqjHyWgLwoMsieQhpUcda1POdSCuwfgERNrJ9
 KjCIs3vEEJMfQsXaFYB98ppPV8w--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 695d8ed0-38ec-4e9b-96ae-2dedf005ef4c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 May 2023 12:31:50 +0000
Received: by hermes--production-ir2-7867f454fc-kqstn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 32d47a946aad3f7d203db987b930ba8f;
          Sun, 14 May 2023 12:31:49 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 00/10] Add RT5033 charger device driver
Date:   Sun, 14 May 2023 14:31:20 +0200
Message-Id: <20230514123130.41172-1-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230514123130.41172-1-jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the charger driver "rt5033-charger". It is part of the
multifunction device rt5033. The patchset is based on an older version by
Beomho Seo of March 2015. For more information on the history and setup of
the patchset see the cover sheet of version v1, there is a link further down
below the changelog.

Changes in v5:

  General
   - Rebased to torvalds/linux v6.4-rc1

  Patch 5
  - Removed the GPL2 text, not needed because of the SPDX license header.
  - In function rt5033_charger_get_property() removed unused declaration
    "int ret = 0;".
  - In function *rt5033_charger_dt_init() changed
    the error reporting from dev_err() to dev_err_probe().
  - In function rt5033_charger_probe() replaced "charger->rt5033 = rt5033;"
    by "charger->regmap = dev_get_regmap(pdev->dev.parent);" because only
    the regmap is used of the parent mfd device.
  - Accordingly to the previous point, replaced "charger->rt5033->regmap"
    by "charger->regmap" throughout the driver file rt5033_charger.c.
  - In function rt5033_charger_probe() after devm_power_supply_register()
    changed dev_err() into dev_err_probe().
  - Moved struct rt5033_charger and struct rt5033_charger_data from
    include/linux/mfd/rt5033.h to drivers/power/supply/rt5033_charger.c.
  - In struct rt5033_charger removed "struct rt5033_dev *rt5033;" and
    added "struct regmap *regmap;" instead. This is related to the above
    mentioned point of using "charger->regmap" instead of
    "charger->rt5033->regmap".
  - Removed #include <linux/mfd/rt5033.h>, it's not used anymore. Instead
    added #include <linux/of_device.h> and #include <linux/regmap.h>.

  Patch 6
  - In function rt5033_charger_probe(), where getting the extcon device,
    changed phandle string from "connector" to "richtek,usb-connector".

  Patch 7 (new)
  - New patch to move the struct rt5033_battery into the battery driver.

  Patch 8 (former Patch 7)
  - Changed the function rt5033_battery_get_status() to use
    power_supply_get_property_from_supplier() instead of first
    power_supply_get_by_name() and then power_supply_get_property().
  - In function rt5033_battery_probe() initated "of_node" by adding the
    line "psy_cfg.of_node = client->dev.of_node;".
  - In function rt5033_battery_probe() after power_supply_register()
    changed dev_err() into dev_err_probe().
  - Removed the "Tested-by:" tag of Raymond because the patch changed a lot.

  Patch 9 (new)
  - In dt-bindings power/supply/richtek,rt5033-battery.yaml added property
    "power-supplies". Otherwise dt_binding_check complains about not match
    regular expression.

  Patch 10 (former Patch 8)
  - In file "richtek,rt5033-charger.yaml" fixed typo on "PMIC" in the title.
  - In the charger file changed the general "connector" property into
    vendor-specific "richtek,usb-connector".
  - In the charger file added $ref to phandle for "monitored-battery" and
    "richtek,usb-connector".
  - In charger file removed line "maxItems: 1" from property
    "richtek,usb-connector" because dt_binding_check complained about it.
  - In the mfd example added the "power-supplies" connection between fuel-gauge
    and charger. As the example fuel-gauge contains compatible
    "richtek,rt5033-battery", dt_binding_check was rather picky to implement
    that node completely.

v1: https://lore.kernel.org/linux-pm/cover.1677620677.git.jahau@rocketmail.com/T/#t
v2: https://lore.kernel.org/linux-pm/cover.1681646904.git.jahau@rocketmail.com/T/#t
v3: https://lore.kernel.org/linux-pm/cover.1682636929.git.jahau@rocketmail.com/T/#t
v4: https://lore.kernel.org/linux-pm/20230506155435.3005-1-jahau@rocketmail.com/T/#t

The result of the patchset v5 can be seen at:
https://github.com/Jakko3/linux/blob/rt5033-charger_v5/drivers/power/supply/rt5033_charger.c

Jakob Hauser (9):
  mfd: rt5033: Fix chip revision readout
  mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
  mfd: rt5033: Apply preparatory changes before adding rt5033-charger
    driver
  power: supply: rt5033_charger: Add RT5033 charger device driver
  power: supply: rt5033_charger: Add cable detection and USB OTG supply
  power: supply: rt5033_battery: Move struct rt5033_battery to battery
    driver
  power: supply: rt5033_battery: Adopt status property from charger
  dt-bindings: power: supply: rt5033-battery: Add power-supplies as a
    property
  dt-bindings: Add rt5033 mfd, regulator and charger

Stephan Gerhold (1):
  mfd: rt5033: Drop rt5033-battery sub-device

 .../bindings/mfd/richtek,rt5033.yaml          | 138 ++++
 .../power/supply/richtek,rt5033-battery.yaml  |   2 +
 .../power/supply/richtek,rt5033-charger.yaml  |  65 ++
 drivers/mfd/rt5033.c                          |   8 +-
 drivers/power/supply/Kconfig                  |   8 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rt5033_battery.c         |  38 +-
 drivers/power/supply/rt5033_charger.c         | 744 ++++++++++++++++++
 include/linux/mfd/rt5033-private.h            |  64 +-
 include/linux/mfd/rt5033.h                    |  24 -
 10 files changed, 1035 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
 create mode 100644 drivers/power/supply/rt5033_charger.c

-- 
2.39.2

