Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F786F0EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbjD0Xay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344419AbjD0Xal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:30:41 -0400
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4661140C8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682638234; bh=QWU7WG5Ap+y18KPgl+TxRsGemwGKK4+kExfJODBoYZI=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=YEfUd+/xCRltMZuqzYLNqawuZcy54BdnvUg+s1mgDuezEPE4KwH+jeOIchdaO7aY0hITSkfcpnvUoMunW89siSvYVHowlXoKX+pWByDrXSoTokH2pqnVfnkjCwK13B+rHezItqUbXaYujclY+invKfi842V+uyS6EFN+gLboy269nHy3fw8aM9rD4VbjDUvjQhgU1vi5NoKmx3ODF0NbxbHUhBCaGiXHmAth2u+YxmDCrC4VNitMmBTTZEJlji1kSptmmWYSFAAGEVrDB2tSKwjUpIWJCfuSPYkjUr8t1rCNKwgXKeLlxeUCDP6oyMuuvrjV5Yqc4/F/Y318fRe4eA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682638234; bh=tkfUbPyOqymWI/j8UFJ6+mhWy1cSEZAqSNaysdUcSwo=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bkf/2LGJufQsQijNlgVzL5sjbCEegwJGeBV/ErbW3/pzyU/K2j5ADeAEae6ePcFEqmq9l8PMBHyB0M1RytiHgB/KZJJ63QJETs0fppSJMCkP56O7Vb6px00x38qL3eiuLvsRMzCbUKSBZGskTaXP8MYlki/B00wjkbQmttrWH1koSdd3eLli0bw8dkKPxVI3q60j3wDAgjK02FEzFlOTFkDD6k5DiSiWZNdF4wKvDisJ43fyrU7P+Kunr1LLWv1gFDihv6BMOuarkUFKGsqX8Ayl4mzW8usDzzyickcfqRAU4a/91mW/vDwF874KeX5mN0DztwP2AAaeu1pnKUUqgQ==
X-YMail-OSG: UMcGdgYVM1k6pSWwj25SC_.KB_7rFPLz.AnW2YwIMQCuwcKJBCcpUcdQ72MRxek
 zjiVv9ZMHBvLdxYdsOSxcfyFJ0J0417OxwHdQsI8G9O51YMU0ZcfBlQ7BCfAh4Ew2QRwm5UB5_8C
 C.HxzcH1vkAInL.K9CaI9Kjfua4S_a7Tjkd1yDKPND.Y0UCJdGf1fMeweGYdS3NyfpQnEqSY76Js
 bjKuwGiTYFZxgrsNNJjKzinlOaFRNVqI606Df2qYhtL8hLm6HDhn0JbnqMBagjC2ak6Lh5BE6t_g
 5.T_iK07lLXd.yvCjcuGEZItKVx4pVlZccEd0qXIPKQIexcf029fdQFyMr.4VQgDU34fU19UiOh4
 RvrBXAogIXppZcpjM9z1c3G0CyzHMFysG6JL0GcPHbTOIzjV8R01fEgzS2Ew19zPeHET9ojis.AT
 dwgfjcJImObc_tPc6vDQ0oQnhuysMn_whoElVFEDgSlwHYvU2CQw2gKnFB4ZKIubMVu0gXTHGoT5
 1ivqZ6Ib4IrV5xf_Z8tfIGxUbXsSLIWr2Q3y3mmx7LspXVHQ.9aXCnaU6mqp8EJHMWJ6KjucXd7W
 rvicKrSL3b932OoSDaXVjy46xDDGPzF8_GsWYgLuMoMq.S3DabsnPMV0icZklF.NUYE12hUnWD0i
 bGWeeP3XKBRQvzL7TPJfx_HAjQghP5zz5FPM.frUHbyho6Ab4EATX.FHLBqCO66fbyif8AyvIJPm
 XpcRvJHC_CTDhUh.sfkYRGsp6HvZD9yIiBppeg2q1BBScQmLn4CS8IkFHy0cIfWWLPT1E1e4iTRg
 BxErCRLI5TwpAhaO9d9yqqCnUdt2rgq8hK0ZAyuw..5OBsPNRW4e6pBQQWjRMBAK6iFebVAg_vnQ
 sqHmpHaQHoY6s3eQvzIlvJ4JgDy9ANuTZQDAt46Gs74S6Z.GNPCBhKDihIhZovQ_VsojuPnyMObQ
 6Wz5vIkdNgrn2TNtz0m5F4D930Ck9ucSqBiUrrZ9OxVU9hDu3ahpUQKdn1e..qOjC1NZLTJ1ZDx9
 1AJm6RofT9y60TgMHXswtYgDeHCr_2v.1Ap5q71WsbiNsPu2B8g0F0j1.yzC.9zk.5vc3EkNTZNM
 xBe.4ny1jlvNQxZ39RFunV9T3_V9QcbGiLWZGdNEc2qkqkRqrCEOMAXWcJSsLp_bHN7j3SsQ8_DW
 I72kUUM_Zgm3PBJQM7_fit3iws1hoJu1k0ua65r00G4Wigh2eIcjKr09yAMGMzU1wWT.EiQBNCK9
 z7gT_4V.eD89CDJP5L.2NBNVnaFGoXKrBe5xhi.XJAMsNDnQtdBQuUfHObrIqlTsDtgN6679VrJA
 WJ5pNFqlg2XABV4lLjHXy26c7YW0ZAeph_DtfSeuj9CYfA0atdBxihoO6_xM60CtGqZkIPJT6veB
 jh3j0uollhsvmHPTlHnlB263e_aG0C_MovmRQw9c8RZNtsZ97lJ9oRPgY0SvdLvmx2EGtHIYA4Re
 sxrJEY6hQydrI14KXhkoAYqV.f9EDJSjPEPkU5otBPhjFSMOcllX60Ih_XNtFqDkbTGTy9TFmA.1
 WWRTuQKStkoLf6yWzVaBGfm9gAYxJ.xCoAsNbzKzdp.Rf_urjEFlU4r4zegGWQMisOu3a5ntPw3k
 dlLe0xwA2BLUYFbeMVUb_TaIsnUHNkMWhjYHC6dpdrXRM_Ji290.Gu8BeoC0lijoshYn8_4THxgQ
 pfNmMI8rrbRgV0vxFk5cDZ8EF3e7Ec1YPcA4NM_VKODyPZj85uybM9TQjua1BTcWR4bDQTiLzozF
 qeOsMu5VIHNgK4CQNufIn2wv08n29JqM_xe6g7sqYyV0uZAufMt4yWzsTGtTYLHPe2QVuYeuJ_Ip
 IK9111JAfSfj34830LmSNwmFUzydSD4p7w3UEmqBF6bih3AKjqI0RFyalQEB018lzZOcX3eCxWMQ
 4w1DUyhQZTVzhzSS_DWiwBgTbgnHPXHxjPMvE7TI9Am1ibHZTwEicR.8uAfljni70EHetKIXMnrN
 nS_PJVJa78tyGbMGdEI18KyPV5mo1vjTA5udGRRkit1NMlhqDrlPPjWXlorrlt9Y4mrTwzo6rhh.
 FbXoUOgs0nqGHfqMcOh.QgCZooJAqKRB.oK69ryz6YRnkGLB8bGfM2xUHhq.XQyF5epa6pYS3fzq
 mlgRi5BlaSjWlWekvuDhDyLJMtOtVMZkU61QjCvROWybXBKxeEd59J4oDSX6o4H37qNlSmWgp7oI
 5IBAt0IOu7cvs5p4WuNCCs7mh50pZ4Mj3Vzc4k0lxtWLw26aPzYiHyUvhR5bF6TXIMbnw353HXnf
 KCP10vDhYW8eS
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: d61f458e-2c7b-4a84-b0da-19202c2b4c9f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Thu, 27 Apr 2023 23:30:34 +0000
Received: by hermes--production-ir2-74cd8fc864-9w846 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 912b1d1a256b22e43f453e00130c1256;
          Thu, 27 Apr 2023 23:30:32 +0000 (UTC)
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 0/8] Add RT5033 charger device driver
Date:   Fri, 28 Apr 2023 01:30:03 +0200
Message-Id: <cover.1682636929.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1682636929.git.jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

The patchset is still based on next-20230413.

Changes in v3:
 - Drobbed v2 patch 5 "regulator: rt5033: Change regulator names to lowercase".
   It affects an existing driver, therefore the uppercase node names are
   tolerable.
 - Patch 5: In function rt5033_get_charger_state() after "if (!regmap)"
   changed "return state" to "return POWER_SUPPLY_STATUS_UNKNOWN". If the
   regmap isn't available, the status is unknown.
 - Patch 5: Changed function rt5033_charger_dt_init() to the devicetree
   "battery" node readout style.
 - Patch 5: Added dev_err() messages if the values are out of range in the
   init functions rt5033_init_const_charge(), rt5033_init_fast_charge() and
   rt5033_init_pre_charge().
 - Patch 5: In function rt5033_charger_probe() moved rt5033_charger_dt_init()
   and rt5033_charger_reg_init() behind devm_power_supply_register() because
   the power supply needs to be initiated to read out the "battery" node.
 - Patch 7: In function rt5033_battery_get_status() after "if (!charger)"
   changed "return -ENODEV" to "return POWER_SUPPLY_STATUS_UNKNOWN". If the
   charger isn't available, the status is unknown.
 - Changes on patch 8 are described in that patch below the commit message.

v1: https://lore.kernel.org/linux-pm/cover.1677620677.git.jahau@rocketmail.com/T/#t
v2: https://lore.kernel.org/linux-pm/cover.1681646904.git.jahau@rocketmail.com/T/#t

The result of the patchset v3 can be seen at:
https://github.com/Jakko3/linux/blob/rt5033-charger_v3/drivers/power/supply/rt5033_charger.c

Jakob Hauser (7):
  mfd: rt5033: Fix chip revision readout
  mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
  mfd: rt5033: Apply preparatory changes before adding rt5033-charger
    driver
  power: supply: rt5033_charger: Add RT5033 charger device driver
  power: supply: rt5033_charger: Add cable detection and USB OTG supply
  power: supply: rt5033_battery: Adopt status property from charger
  dt-bindings: Add rt5033 mfd, regulator and charger

Stephan Gerhold (1):
  mfd: rt5033: Drop rt5033-battery sub-device

 .../bindings/mfd/richtek,rt5033.yaml          | 105 +++
 .../power/supply/richtek,rt5033-charger.yaml  |  63 ++
 drivers/mfd/rt5033.c                          |   8 +-
 drivers/power/supply/Kconfig                  |   8 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rt5033_battery.c         |  24 +
 drivers/power/supply/rt5033_charger.c         | 725 ++++++++++++++++++
 include/linux/mfd/rt5033-private.h            |  64 +-
 include/linux/mfd/rt5033.h                    |  10 +-
 9 files changed, 981 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
 create mode 100644 drivers/power/supply/rt5033_charger.c

-- 
2.39.2

