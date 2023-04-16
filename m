Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BC26E383B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjDPMpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDPMpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:45:04 -0400
Received: from sonic312-25.consmr.mail.ir2.yahoo.com (sonic312-25.consmr.mail.ir2.yahoo.com [77.238.178.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EB01737
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681649101; bh=uou61x2ek9dko20lP5SzF9mUIOr+ld/ukFrixmFYXwc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=VSNpPxljZjt8Xhvg+fJsok28NhXosMufJuLM4tg+7MkSgiOID8m8JbZW5m6tznUGTQADE4tNQBHPcLvlD/UZiUGMdVx1JX8pkcGNq2Wmrw0lOmxMWbg+brIyaIuC9/yVIJy9JpTzUWFHhNGZckYe3Uuzb1oK4K9uZ3/53Bz09SkwBDgf01o1TrKHwJLw7RQ1N+mmW/WpT59v0sxrUkWPz4BCqhsIIX+vDn1gUx74kZ/CX1EeiM01M5DojbNQDIba4sXwNINUDbDdhnA9/uRf8azC5+I67tyg+KXNbvsVoXHBXu3lya25kqpZrbFghaBjOeC15TYtwxDvuLWgff8MPA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681649101; bh=8bXtnsa4gHFMcw6cKslKNTqWkA3e94z3e8oszgsXcoR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JLV4i4we0LVmD0L2zyp0hsV8nXkfT1vWD0/SZiVqKvgSna3GPWaJk21W8cLeLAdIP3t3YOoNj49SBO+vk76WAyZ0n/D+a0UTiH56dGr1VBfG0ysIAc/gYptJdsHih3MaZOn6LX2AHCncTo2FIHfs85zwinrQviXRWN1RFSmig8GR+jpHsK3cDJdy23kuRxTgqyi864CoDcNXE/mIlciWPPyGwQc85n+XERWNZzbcHiD+3gNB1sR+oUgs720EmIg8yA3MbT/Ka1XVShiaf+wdsb/oH9xL8v2/geuDojmJScDj30kHETXKSOwD8wwK70HeiS78E5fAoZvW5TVY8TWQHg==
X-YMail-OSG: cY_F.pAVM1lkJJRbdfSaA9PYF8zl2uaKqyjT2uNRhTw7wABLBki0gpiyUQk8RY9
 CZgqKx4QVJJn_cSJXhi.Qs4YKoknPTf2c0ubq8W1MA1WGYJFYJ2cJ6A.QcBTDRZDIiCbyiPWjsDC
 pxNZ5twrHwukdCJRWqf9jpEtDqJFxEvqOUyYPdikXveQHSYLaGS1tPce7aN0k36OWsuOPvtxnqi4
 bCccxDeD4RDTfF_spvKcT.hZxOGeXF5gzU.BGkGBFpwfVR4bKknx1Qv2ktMltijCZhs3jV0wV6fc
 yXJLlboFrpYIPQhTwXRg4g37HDzRuTOpzq_UhlGC8jrU.Rc8jR3aCnEMuC2KO7MIpLNTKKnCuF1p
 VIWdS9aSMzMnfKjiba8JN7R2iCL5b8E2IsrG1p8YkU.r00EB9mBFG.YdwTOGBhEACL7PHebsHsHq
 15cUWUAfjm3CcEJyJ4nsYJS8uIr0vfGAp0lvRKy6hKSpMo0e6SdybIVvYS9PlynSVeSJGdJ77q9x
 cPPFBKL7iEveB5xWQWm_hXN8O6d83tC_PwA_2Jjb.zVcBczMwiqAKmsJRNME7le3xMHyjzQTzbty
 LTs.5SCHSw1l86xZL2aOTDcvbOOXOHxBkToL53vmRxV5Yg7y7r.pKDM8nCtLzm.6r6w.KfNkLVXA
 BUXFhzM0YolkQyG_vsJ8OZSDlEbo.vZQJPDeGomqLZlm5iPJQ9ca6kK5WYb1JRF6ocg7dY38nq1L
 b_9QMhc7R69LLVM8B5M1HW85lKhGbfW9SoMo3niqazSwXd5ZOATQXegGrXqyfEzjtCbNtz.43WDz
 sXLKv0CnPz9ATDdcZml406qztaEAXo0_K.d6C1WGY3W2wRmeVjXP2kKwWsvcuH9eHpJ2TqbwuJQB
 dm_BENLyE5W5.zjhccUJzNQ8NkWUlxMnm9VBW0VdlGqFrpkxaOhtRY2dlHKIVucUCZNWTWM_6.tE
 oQG5ljdDGtClKZS1TqkWEtTudWfoA.bZc_01Qmd72zD0Ovk1uupWfRt05BAouae9fRHNHT0OJ6nQ
 wsCof5rrf2uG8kbf0p2Kmjb96vUakv9LlhKEPFH_0Oh4aFdS_e0J2YHXb5MkPCgvB4Z2bz2gyLVn
 v2435Hla.6I_1nOtXbd3SbWKazeyo5A7fNCBHtmhOkgGeibT73jWBunZLra4ZWWj6sdMzwFayp85
 POZ7ZMucBGzwBdGLjOBA1f.K0TgbRC3mTbKn8vBunalrPdzMbjQ7ueYe2XtBVVm7.OtPYghTUhaf
 LHzt0hYeq3HJ6ersMcDmDQ1snol9hNT70Fm5NXAI_gAj3JEqT8QP88YvH7Q.f7wXNaIJEoxKmYBd
 jjlTysrW9.8kTyrIHar1W_phDC2Tccme_Zvh_lYwF3XX_.RlRT4LSImy7dIiItDk.EmOSnd60oae
 ifBLFuoPVfcWwBCHYkdFpoMxeF77LiTDkDXF0lHr4wXAEYUm875bjAYXEM.cq6gKCE1B5pw4JNQQ
 ycaxW6CWtY5oY8n2m.8r23tRMXFWxXd2WfgQM4Rnaf4r0PXPT8cZei6bNulv3wCx3hKOIxXMlycu
 ls7OR0a.3ys3RdwE6k0HWT5z8t7CxDbZrAh5XKE2R8vSvtwbni27sWqxo5usYu.28zJBCXs7ik2d
 rPpyX8hWE.Ij8.IiP6aJFxk0nrOPt4WdQJHlms9Htz1OReGjtl.zCjgCYgCVVYrFFj.U4pF7Hw5S
 5TIsgEdLMckMh__iApCikgs5KmWcGYVGV.tBopUaDLqxNcxdTMZAjzGxbZbPqH8.5WxLtd4AhFyN
 eep7d7kPRMQNbINCh0EluifcOuLkzMWTU7tieTKlivOpJjE4.hw8kdf.XtJWjmK2td60Atsxa_Qh
 UvLZsfUzgr36WfmCiWeR42sBgBtznbdakojKrFxtIyejj2No.RvjNFFLL76dEy.vEEwZuZiu6jmq
 XqRE6o82jBgV1Q7UEas7o9F6ON7aJETvj8MaK.BCwGEG1UPzo7gJW7DGo7MbKw5hzwIZVyKrvj33
 0AV5qmffZML4tNVg9WsSFQ73ftasz71IuXfFUoqXzvHrlO2rFSinDqFUTKPl3yPmcMlHHP3xMDhp
 Pus_ZrcIxwbpmMGU3FOrSEPpp2.vqxCOCrxbNiUJ17mBzz79C5KKlSWNjQk0gQ3_x.dxW0fVCFeN
 Vhv60nNMxVpV1qVUau9RdzAJV5Cpd7s0KJoF35JOXVidmnkDBhfyzqSso4tKZfhh6Qx99MWTGGeV
 sfcu6HewmJRGXEO04rC4SBnN6CTQ7HwrKDaZYCMK1WlXFWiHHtulqQV1pHHRF5uOv7fkA8LTbWw0
 TV4m29g0lrnbBZ3BeeNPxkAVw_xMM6_O8PncZUS4.dV1D_F2n
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: cd681a32-e0af-4c73-810c-2372c6f94cf3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Sun, 16 Apr 2023 12:45:01 +0000
Received: by hermes--production-ir2-74cd8fc864-4bl68 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a53f7a8722383f9609d619e4fab1862;
          Sun, 16 Apr 2023 12:44:59 +0000 (UTC)
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
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 0/9] Add RT5033 charger device driver
Date:   Sun, 16 Apr 2023 14:44:27 +0200
Message-Id: <cover.1681646904.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1681646904.git.jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

In patch 9 I didn't change the extcon phandle, I haven't received any answer
on this.

Changes in v2:
 - Rebased to linux-next (20230413), as suggested by Lee.
 - The v1 patch 3 "mfd: rt5033: Fix comments and style in includes" vanished
   as it got applied already.
 - Dropped the v1 patch 8 "power: supply: rt5033_charger: Make use of high
   impedance mode". The high impedance mode is kind of a sleep mode for power
   saving. It turned out that it might complicate a future implementation of
   an rt5033 flash LED driver. Therefore drop it for now. The high impedance
   mode could be added at a later date as a power saving improvement.
 - Patch 2: Changed variable name "data" back to original "dev_id".
 - New patch 5: Changed name of regulators to lowercase, as suggested by Rob.
 - Patch 6: In function "rt5033_charger_dt_init" replaced the devicetree units
   "uamp" to "microamp" and "uvolt" to "microvolt". However, I didn't change
   the unit names of the driver-internal variables in order to keep the
   variable names short. Let me know if you think they should be changed too.
 - Patch 9: Removed '|' after all "description" blocks in all three files.
 - Patch 9: In the example of "mfd/richtek,rt5033.yaml" changed "i2c@0"
   to "i2c".
 - Patch 9: In the example of "mfd/richtek,rt5033.yaml" removed the last part
   on the battery fuelgauge. It has its own I2C line and is therefore not a
   subsidiary of the rt5033 MFD driver.
 - Patch 9: Replaced units "uamp" by "microamp" and "uvolt" by "microvolt"
   in the example of "mfd/richtek,rt5033.yaml" and the file
   "power/supply/richtek,rt5033-charger.yaml".
 - Patch 9: Changed name of regulators to lowercase in
   "regulator/richtek,rt5033-regulator.yaml" and in the example of
   "mfd/richtek,rt5033.yaml" (related to patch 5).
 - Patch 9: Removed example from "regulator/richtek,rt5033-regulator.yaml".
   It is already part of the example in "mfd/richtek,rt5033.yaml".

v1: https://lore.kernel.org/linux-pm/cover.1677620677.git.jahau@rocketmail.com/T/#t

The result of the patchset v2 can be seen at:
https://github.com/Jakko3/linux/blob/rt5033-charger_v2/drivers/power/supply/rt5033_charger.c

Jakob Hauser (8):
  mfd: rt5033: Fix chip revision readout
  mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
  mfd: rt5033: Apply preparatory changes before adding rt5033-charger
    driver
  regulator: rt5033: Change regulator names to lowercase
  power: supply: rt5033_charger: Add RT5033 charger device driver
  power: supply: rt5033_charger: Add cable detection and USB OTG supply
  power: supply: rt5033_battery: Adopt status property from charger
  dt-bindings: Add documentation for rt5033 mfd, regulator and charger

Stephan Gerhold (1):
  mfd: rt5033: Drop rt5033-battery sub-device

 .../bindings/mfd/richtek,rt5033.yaml          |  90 +++
 .../power/supply/richtek,rt5033-charger.yaml  |  76 ++
 .../regulator/richtek,rt5033-regulator.yaml   |  24 +
 drivers/mfd/rt5033.c                          |   8 +-
 drivers/power/supply/Kconfig                  |   8 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rt5033_battery.c         |  24 +
 drivers/power/supply/rt5033_charger.c         | 724 ++++++++++++++++++
 drivers/regulator/rt5033-regulator.c          |  12 +-
 include/linux/mfd/rt5033-private.h            |  64 +-
 include/linux/mfd/rt5033.h                    |  10 +-
 11 files changed, 1008 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
 create mode 100644 drivers/power/supply/rt5033_charger.c

-- 
2.39.2

