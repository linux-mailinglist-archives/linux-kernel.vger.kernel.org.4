Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D4F703E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243336AbjEOUKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjEOUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:10:27 -0400
Received: from sonic305-21.consmr.mail.ir2.yahoo.com (sonic305-21.consmr.mail.ir2.yahoo.com [77.238.177.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AA510E53
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684181424; bh=WJLRyMpR9Zs1Mo1BzHlS7P1TlsFQADra8VgIsrbooio=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=ch2BMQ1V3uCl48wXN0HOAwkLTL586giooeA0Po/N54aUpW3MhnFdFTbBlmngLdhBO8t3V2RiqUnqHwtkYku3mWE/8TpbvRgcn7TzxgAh2fPlaR4MKgHSxBatBI3k87wBypyKDwbxT/EYOQTA/arviuOitAsej/enJTepHejweJgs5EUEg21i9j0WmoFan6cGcIMC00LBiQ8zsa3lxt+zBJIeMpTG5exao9sOgy35EJxhpwYyrSMMCYgl1t39mXVDmlTqgdJn4tGvxjJrswv0wtEtUWcbZuIRA8Duz0N1SE8EkMGz4nwCqY5m5bj7H0P886Mhv7xt5KAUY2x/wr3thw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684181424; bh=RSXmtpPAyShuCSoGphsWw7WxrgudOXz6AWlodofl/eC=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=j73I1VmrqBv+mCWVqfV1sYxT//xT9M0H8WHP5wNi2NUQPHct60mf15n3+AkSTZ95ymrE08LA5mMYtxXASzLKtrgbSr/Xptb9HHdiNT0p7wDWulRrUH4QIyGSwG82SYSuF/RFFFN4F5ATynVKf++Ikcxsn94GDMD0L6TML+pQ0rwf7Ub+GXdnXamEBr5Mrsc9TcY8u0ED/L1Ajnw/PAb00iKXRhuAO/fm3lYSdBQIRu/axUxKFp+FUFivt+jSkGYBWpPZMzAdnhQl7WayVpTBknnlI2azv8skMBje3ZMRzJPK7asTpa4/jhyy9R3/sS7O6jjAc405DG/6+z3svXZ9HQ==
X-YMail-OSG: bHI2BcIVM1lJ1l8qDhdtIfAIQj1C3u.Ve6BLiDYp0QVl7eswburp0Itxysx9rCS
 p2ZM0bMoeeytmjCPQqSsKyf5iownGKhLFwUghaerB000.0z67O8x6ZY8l60VaN3jnRvghI1OicL8
 oKPyn3W_3scGwyelyxZbiHSFCLcneUryltUQF43eXMuOTvNcZMoQb4z9LTv7RL9wJZ2IC_7hMqj6
 aPRIPP71Dlt256eqzwHS_HOWd96htth2XM0X0DIvBzMISQ_z1YSnJ5OS5SmKOx25HSQVO.wee.NX
 O9nKi8foI1aJ0shla8254J8azzC3ju1D0YBQ8BY3HBsTmd0zHWR4voqQRYkd.d_5J34srN0yChbt
 e9npL9yvZkPoP7hZ.XINtd3legcJigdSVUMFFBtbTj3NqZcD2NqL2VgFlONTl3Mh5dwcc9HD0W90
 Gx8NEeP.ZRqLADShNSoF3vjlm7wIJs9D05bzIrmm1QhCITUgKEESyv4R90_jNmuEwBx1cW2cwZ4c
 vVWG5CMrt1fm4fioR_z4zfK8guK13DxoRQImGPc3y.PNyVq.duYSnG3tgVbVzWBmLo0yKSc7NTnV
 _128xZaC9ulNhgCwDJy7tQISwAwCDInjrvrSRkBBoe_U35cwPPGwZ3znaaTy2al5lXJCaiX5Bqbu
 vNe3.3c_z8eLgl.zFJGiMmjHNOGik.qHRbkPhwWP1IqlAkCHvg0G5X1wg623QUUT.wswpuaOG8_0
 TOHxdvQ1MRFJR4xO0irNNzrsBF3BN3xrisBbh0ImMa25KlOVmwcx2VQgP8s8uZBqpaesEKXBASRD
 rQ6BFGvJVaZOIGVKsMl7202ZYOOnlwbauVn578TmQ756DxpiGZ5dbmZN_IpTmcu9hsxQAoYLBCRM
 jcsrkLcRyu2T17f_nAKx407oduSY5Sjze__QIk_MsaSycoci8J.OTpTSu5Nc_fmHOLnM5ZapYxln
 YPh3WfcmjaLaJYIU.TOYPtn.dUMCz_IFgRdDf.6tmMpdLunatb_pRLmB4pTw1WwzEP5HeFFA2uJo
 S4tmrQe9.Jv.jMxzYopEOAwHkDZp3F4utVs5fnroyJSU9YJ2FORL796lOswsiy_8JDB6k7Y9vdVq
 R1NxVZwgEyqYS3aEJZgWatVXOxGGAMesThS82CCN73bCy_K87sIdW25HspYgPzIqx.LC_mpQfHaB
 O2XUU962TbZhdOwoqtXRKaLIBeX8OjqpfKN2gc9q__B8h5AwpKme3lqhs0H6Mj0VDsybA6iH5L14
 mgx9i8elAPWTanN9_Pv2RsfpecrnZN.YbuF.D8mwWc8fIHLiPoGIOjt63i48_2Mkk0GLESMTVriD
 jbMjgTmoT5xtXEjoTl_vzu8jSx.QvKdnUC.24s6ZPMsPTRw9wLP3oloWW_g.VMOVJdQM3R_uUokC
 jrnYNnz8_2wfuCp5buQgA.FPbXTWmZYOD_8XhALg8iUPvveyh0EQHpEWKOBDcYs.NBlfL6xl_lTt
 LB.AAml7UMx4a75NW8VmIGhIgEd51MncCm0lIH2_k7NmxYEXM4sJ3v2GVBL6RCDIu09oEUitWbYn
 o8gSer8f8fNFCRPz9XyWFUgMxvbXQa.jmx7vhVFDywst7amqZK35rd9mp3BA60RPz6ZTfAHFZli0
 ebQwJBTHzzngVCYJ7ubYPYS8ElYhiz50p4B_qHrmisXVs3CnqXMZ2sp_FCGYjdFnYKyPMigqR.GW
 fH9SS8w3vG5BGo.7W_iSitQATO9w2tFMtWrz9YBxGL039y.fyABSBRFbL_pJ3oxDe0CBDSmp3N.T
 yYjsumlmw.xDDb5djgExV763Hh1b60TFa3VaSfQ8DPM34VugpVJoN7tCzfUn4QsTBp_0YAagPHTm
 EySEwOZF0RBvnkRmxM0tKthBMCTaO6c46KE9y.IaQYos_wQMVOHe4.P9X6RNpmu.mcXCs5.biv6g
 9.uImgSVgS8ZqTfTiUzvOmcQcTEXDSeRSzZkvgNI6KRbQEOZJJyowkZuGAX2cUi1ihLHl_bhgVD_
 g4yM0W1RZnNT0OpIgjj8j29_VAYxt5FFv_xhpxzy.bbNp.KC.ioIMgHg7UqXYxmnMO8qWbD1Fp0H
 PIfxwT3A7xPMT7wMKJ6rYidPh8rAoHXoCLar5oKaT2sEHTh0A6BmiNvEe9Ohz0iFJQp5.kdCWwos
 0yU3bavAztuTFvPZYnU2CJIqewpgCERlvLzF.4f.0uTLLSQb8P0J5.jHC08PefITse1fdgT0d0eE
 ILtvajDgrv6p9RNc8jBCBTV2pLSW42y9oL9Tdy6C7ffIPRX7NmDcD5R2lplV7Y9fs5tKt4shVrY4
 .1UiIPXrNn4kTNy0y7XoU
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 8a8a3ca2-8e9a-469f-bb3c-619cd0f5a80e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:10:24 +0000
Received: by hermes--production-ir2-7867f454fc-nvr6n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7905ff065b8716c1e39bbada6be8236;
          Mon, 15 May 2023 20:10:22 +0000 (UTC)
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
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 00/10] Add RT5033 charger device driver
Date:   Mon, 15 May 2023 22:09:52 +0200
Message-Id: <20230515201002.29599-1-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230515201002.29599-1-jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

Changes in v6:
 - Patch 5: In function rt5033_charger_probe() after
   calling rt5033_charger_dt_init() replaced the return value from "-ENODEV"
   to "PTR_ERR(charger->chg)", as suggested by Christophe.
 - Patch 9: Changed the patch from adding "power-supplies: true" to replacing
   "additionalProperties: false" by "unevaluatedProperties: false", as
   suggested by Krzysztof.

v1: https://lore.kernel.org/linux-pm/cover.1677620677.git.jahau@rocketmail.com/T/#t
v2: https://lore.kernel.org/linux-pm/cover.1681646904.git.jahau@rocketmail.com/T/#t
v3: https://lore.kernel.org/linux-pm/cover.1682636929.git.jahau@rocketmail.com/T/#t
v4: https://lore.kernel.org/linux-pm/20230506155435.3005-1-jahau@rocketmail.com/T/#t
v5: https://lore.kernel.org/linux-pm/20230514123130.41172-1-jahau@rocketmail.com/T/#t

The result of the patchset v6 can be seen at:
https://github.com/Jakko3/linux/blob/rt5033-charger_v6/drivers/power/supply/rt5033_charger.c

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
  dt-bindings: power: supply: rt5033-battery: Apply
    unevaluatedProperties
  dt-bindings: Add rt5033 mfd, regulator and charger

Stephan Gerhold (1):
  mfd: rt5033: Drop rt5033-battery sub-device

 .../bindings/mfd/richtek,rt5033.yaml          | 138 ++++
 .../power/supply/richtek,rt5033-battery.yaml  |   2 +-
 .../power/supply/richtek,rt5033-charger.yaml  |  65 ++
 drivers/mfd/rt5033.c                          |   8 +-
 drivers/power/supply/Kconfig                  |   8 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rt5033_battery.c         |  38 +-
 drivers/power/supply/rt5033_charger.c         | 744 ++++++++++++++++++
 include/linux/mfd/rt5033-private.h            |  64 +-
 include/linux/mfd/rt5033.h                    |  24 -
 10 files changed, 1034 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
 create mode 100644 drivers/power/supply/rt5033_charger.c

-- 
2.39.2

