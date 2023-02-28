Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED30C6A6277
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjB1Wdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjB1Wd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:33:29 -0500
Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE5323C66
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1677623603; bh=JrmTQwSxY/dfMLAb2ppOQWEOK3oTeYIJrKFAtBts/eA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=NN4EueteNUeJKKRBubBMrl83h+J59FoJW/5qpUssBBUdNOcnBKq51SULCPszZgsT//DG8wD1qiiUbji9h7fhGnTl3d563gcGrTeAiDvwSyFzxsOa2I1raYVR306bbHxXpEtXQMFf5xXwhj1drElOr7tan9mPAP6N9Ss0wEIw8O8NUBWIQ722/RMlfBZM2+/WDf9ZPQZInviktcCUbJJWiwhpfAViNXGDz552tpsJ+Hua8adkDQ8vplOM/f1jshAXG0SDMBx8Mq1obZyEroZnNbCyC16dDK72x2GQE9Fm/F5AmiRZsaOV7zOv3edlrRucgT9d1VjBNsKccmsq3fBF4A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677623603; bh=ijpjQcfQ4aU+b42bV+v+d74LDdHB4TBPAYj2nkZdZG0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OEYcyk3ZAQL4BTXO+ZDiG9ocUOwZ+BMMiL4mBRdCS3IB2Ah3GCtbSX7PBdYruDBiiH6/fq6j+pjPJEpwFlzSlT85hDdD/+/xgvLqLtaBDuMFeixVCL+SVHEGZHaWHeZ6ni+oSIg+6evWfubnqeeajbBzw+TJbFHjad8bi6T7plfVOgdTh10UHmxXE8jDrrDIPCUB4mG1RkUaEPbsy6ObTrPeRB7LTCM3OHBVGgTrEaV+wJrjjmxEG5s4uCwO+Q5akB0nfx1oajS9m4cSegJrvA8ClScxE3/v8cpV5/KSJNRdERXpc58XjOG05+SJxnBv2mtGpt6m+6hl2NDD6Nbo2A==
X-YMail-OSG: BNDnJ8sVM1m9xUy2Dkf88jYPaBxlZtZ.Kehtgn2XSCwAwkxeH0Idy7qhhnd_A5W
 nMpxSSmT5.Ag9RSuQSkmUYP_AyxgsJX3fO9Xke_xKluHWrrG8qtm3DC75YqDEyIPEOo0PaEu3rKw
 Hm9AldSyMrTjNhvcCYpUSxGIBP.FkOwgwrtkZ.RgQ16EJI6M6ILs4EsWf9MzkNls36GNB6B83swM
 _K06MBgBf4.jJbXCM.KzI_bED6rLxyNee9mSWidhpij4AZQSCo8wH1lRkfrXx8DtlVUqW8I.4OMN
 mZPDB9Zhq1QITWDb8UMnnb5XyMITKB5D8qDJMUTQA7OLz9iPRxjJ6vG2SCrlpkZ_KiJlyok_FTkn
 JRooHiX7pUPUhb9jILWGdES1Wq_Hq1ggoTIFtoPVTs6z5yphK6hzTV6X02LDtk5sGrq4SO3LcoKq
 bCPGoNugKu7pbK.1iWwt.JTSMoYE3bU4nTHZmEf2x4PRsW_EkwDOi8Mo2wNFcgRC.gWQKhqcnFG5
 qw95zcKaB4.I9oQgMxf6F.1WfHykV0xhddyBngvfKlom.MN81j3YIuJ5NOQHSIbaIlUBrH.Xuf.1
 F19hQUmINIVyC442bha816ByKHhMOuUD1w1.0fRqX.gFvZQaIqCltaUN8i5bASidw6ys0QosXHeR
 Je0d4AQL2BLKlfGyv.g3B.ypSng3UBrZtex.xPAfm62oZQpN1sDNH5AFLuLUiCMK96Rsaeevmo6D
 NqU04KDCmmjb99rsD9I3ZgS6aXAHBoqAbMkbP2iAuxNbDCSA7Hy71yav7JBXQHLjN6qKBzBJz2pc
 xLXZN8tG72JQU7vvwtxfZFoJ52D1V70DGoTX57iWb_71kkmniHpiOBK4c9X.4e23RfK2_4z0GD91
 wLWD5swvFvhyHdeO9aAX8G8RfXy4B.25zE3P0OqTkriC_DO.coPkeSPZvnqnSH9UYPl1ARbtf6fG
 YW.FnPSq5ToXxOY0.JCtMlntJUBKZuQZqIV5NQLn1UVShcce4ojQrIRwX7Kx5li74jWrQdNh6x_Z
 2GsU7vml4htx0WIbQTMNe18gpmDz4vEhjXmkdI43CEswhkcD_zQ1ujCkT3V77ddChOSE2.iKlzUl
 4Bb7lZHLWyqElvMDV5VFbrLWfzemlQg4hfSbMaFPt2dH57b9.L_9yjXsH.j0_TFxIwkHdzOnGYAx
 pX07CeQ4QquOzQq7tW6JcHPSNZq14bLLiQuNuGELJGEfLwSpW6ljU1lUVcFG5BjA7bWccvY4lIXQ
 Q9NYRUz95RCTavaMDj3e4_DCLO9aYul0dj6fOlCxHQciWiX_1guZY9Rg9W2Pu1oNrt3NJD4SGZi8
 jnCmZ9DsYv0jAF7yf5CyvGY4DcSo.pGzEImYYhbH.Xd.Zhyi.YU872v_hMfkiPk_bFmy6S.x5RAc
 3wjtniHnj5bf2Prw3SShpo4CO_cDLRmur.6jBwIFrTDL69sLHDzELc8AtdT4_w9vqdM4ArKy9_7f
 OjNOGrAlIt8QR4r_5Ctx5hMu41cXJF1KE7fLMpPhspTkSoW8rkmy_Tc6cfEBy30TGcPolqF4jC2k
 9pHJqdSvO12IRxJuhyVnJ5Ft9COlHArYxSRNr0ctKqX6giP9igq6MA78F4Mu5ztx_PLXzPU7Xsnm
 Cqx6eoohJEqrmNBsHfggiOyks4zaJlE0fJuOXo5mooI8G6O2_uuwh8I1FzXkLtqYhIe3HE2Emhn3
 ADEHviJVjxitnjvhTteUew2NBUdqdFtGAqNL2HrOgjI6MXLszOZGQopCoK8JYRny3yamMz.cBDZR
 6LRcSce3mrH5PxIHwPNEmsFrcS5Du4pBzfJnLwG1d_qpXfoZIABfRpIi_8U0RdVQE7niV0gqNSFL
 bxiaeRh7X12fcTN84XRv6N9zNG_NE4nqR71tf6HVTLoSl3lh9mCeIpoM.toTurK_cmvogB4yud77
 S2jMJct8GBiwCv7gSnXK8HkjwgKNPPxdQ5UxRAgO1s8wNhfoSRUmQQxduTvUxBP5EDwIfV.6GKRN
 eGROuKoF_JUPa.Gnz7Iji8m9XNH1e3FPQs1kAP.s4VVQHMaFMMONfmgpgKBHbIA_02QdHEoEW.Io
 HcIvXYHDSamEkGmYj56dujEGwNZ5ugl8QTSb3oos1UiZrq1VTXnH3ctz2eLWIXZKMyfLNqJ62XcO
 .WKC3sEirUb0RrY4I5vRxiJiTjmUdR50qYinj9wld9ah.7soAvPFMz_AYW_2R4txDsLfaS0VYK5T
 Pr9O7A6miYBxJI180ox7.sHCw9GsWXNWtDOuBq9CKRUuR4btEI17jXHeDZdDigbre.ACjIxgOvwS
 KhR2.PwcqddwAAYkbz91vGm46cFkOp0Ph0GXCVaTo51zM3j8-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Feb 2023 22:33:23 +0000
Received: by hermes--production-ir2-65c64dfd66-lx9xq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4362ede20d54ad479836919fc460cee8;
          Tue, 28 Feb 2023 22:33:18 +0000 (UTC)
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 00/10] Add RT5033 charger device driver
Date:   Tue, 28 Feb 2023 23:32:17 +0100
Message-Id: <cover.1677620677.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1677620677.git.jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Works on rt5033-charger has already been quite far but phased out. The last
patchset version I could find was of March 2015 [1].

Let's pick this up again.

Those patches of March 2015 are now patch 6 and patch 10. On those two
patches I actually would prefer to use From: and Co-developed-by: tags. I
contacted Beomho Seo beforehand but didn't receive an answer. Therefore I
applied Cc: tag.

Looking through the old patchset, there were quite several things I changed.
A detailed list of changes on those patches 6 and 10 can be found further down,
going from top to bottom through the patches.

Some comments on the end-of-charge behavior. The rt5033 chip offers three
options. In the Android driver, a forth option was implemented.
- By default, the rt5033 chip charges indefinitely. The current goes down but
  there is always a charge voltage to the battery, which might not be too good
  for the battery lifetime.
- There is the possibility to enable a fast charge timer. The timer can be
  set to 4, 6, 8... 16 hours. After that time has elapsed, charging stops
  and the battery gets discharged. This option with a timer of 4 hours was
  chosen by Beomho Seo in the patchset of March 2015. However, that option
  is confusing to the user. It doesn't initiate a re-charge cycle. So when
  keeping plugged in the device over night, I find it discharging on the
  next morning.
- The third option of the rt5033 chip is enabling charging termination. This
  also enables a re-charge cycle. When the charging current sinks below the
  end-of-charge current, the chip stops charging. The sysfs state changes to
  "not charging". When the voltage gets 0.1 V below the end-of-charge constant
  voltage, re-charging starts. Then again, when charging current sinks below
  the end-of-charge current, the chip stops charging. And so on, going up and
  down in re-charge cycles. In case the power consumption is high (e.g. tuning
  on the display of the mobile device), the current goes into an equilibrium.
  The downside of this charging termination option: When reaching the end-of-
  charge current, the capacity might not have reached 100 % yet. The capacity
  to reach probably depends on power consumption and battery wear. On my mobile
  device, capacity reaches 98 %, drops to 96 % until re-charging kicks in,
  climbs to 98 %, drops to 96 %, and so on. Not reaching 100 % is a bit
  confusing to the user, too.
- In the Android driver, both timer and termination are turned off. Instead,
  a self-written re-charge logic is implemented in the driver infrastructure.
  On mobile device samsung-serranovelte, after passing the end-of-charge IRQ
  trigger, it keeps on charging for approx. 42 mins and then stops. When the
  voltage drops below 4.3 V, it starts charging again. 42 min later it stops
  again. When below 4.3 V starts again, etc. This way, the capacity reaches
  well 100 % and doesn't drop below. This behavior is not managed in
  drivers/battery/rt5033_charger.c [2] but by the Samsung battery
  infrastructure drivers/battery/sec_battery.c [3]. Some of the settings for
  the re-charge behavior are set in arch/arm/boot/dts/samsung/msm8916/
  msm8916-sec-serranovelte-battery-r01.dtsi [4] (for samsung-serranovelte
  mobile device).

The forth option would be the best. But it would require a lot of additional
coding and testing for the driver. For the rt5033-charger driver submited here,
option 3 "charging termination" was selected. It possibly doesn't reach 100 %
capacity, which is confusing to the user, but at least it offers a re-charge
cycle without extra effort in the driver.

Patch 2 fixes the bits to be read out to get the chip revision. While testing,
I noticed a nasty "hardware" bug in the chip revision read-out. I have two
devices samsung-serranove. Both have rt5033 chip revision 6 (register 0x03
value 0x86, the last four bits are the revision). However, when I remove the
battery, wait a bit, put the battery back in and boot, then one of the devices
show chip revision 1 (register 0x03 value 0x81). It stays that way even when
powering off and booting again. Once I put in the charging cable for the first
time, register 0x03 changes to the correct value 0x86 and stays there, even
when rebooting. This happens only on one of the two devices. Interestingly,
in the Android driver there seems to be a quirk to handle this issue [5]. In
register 0x6b (RT5033_REG_OFF_EVENT) they set bit 0x01, wait 100 microseconds,
read the chip revision, then unset bit 0x01. I was thinking about adding this
quirk to the patchset. But I decided not to do so (at least for the time being)
because I don't know what's register 0x6b and what exactly does bit 0x01. At
another location [6] it says this bit enables OSC, possibly OSC stand for
oscillator, which I think is used for the internal clock. I don't know if there
might be some side effects when applying this quirk. So I prefer to do nothing
about this. Having a wrong chip revision in dmesg until the first charge isn't
a severe issue. The quirk might be needed at a later date when other quirks
(see next paragraph) need to be added conditionally on the chip revision.

There are more of such quirks in the Android driver, e.g. [7][8][9]. I haven't
noticed any bugs except the chip revision bug described above. I didn't add
these quirks because I'm not fully sure what they do and if it's really needed.
However, there is a possibility that some devices run into issues. Still I'd
avoid adding all kind of quirks without knowing anything about it. The
rt5033-charger driver sets the bits for voltages, currents and end-of-charge
behavior. So from a safety point of view the most important boundaries should
be set.

Additionally something that's missing compared to the Android driver is the IRQ
implementation and infrastructure in rt5033-charger [10][11][12].

The rt5033-charger driver returs a dmesg warning "DMA mask not set". I've read
that it would be related to platform_set_drvdata() in the probe function. But I
couldn't spot anything wrong there. It could also be related to the
devm_kzalloc() of rt5033_charger_data *chg in rt5033_charger_dt_init().
I couldn't solve it. As it seems to have no effect, I didn't do anything more
about it.

The patchset is organized as follows:
- Patches 1-5: Fixes and preparatory changes on rt5033 mfd
- Patches 6-7: Add and extend rt5033-charger
- Patch 9: Add status property to rt5033-battery
- Patch 10: Add documentation

The first patch is a lost one from a previous series [13].

The patches depend on each other, it would be good to apply the patchset as a
whole. Not sure if this patchset is organized well enough in terms of touching
several subsystems. Let me know if it should be arranged or handled in a
different way.

The patchset is based on torvalds/linux v6.2-rc5. The result of the patchset
can be seen on my GitHub fork [14].

Changes to the version of March 2015:

Patch 6

Commit message
- Corrected typos "adds", "supports", "provides", "modes", "The", "pre-charge",
  "fast charge", "They vary in charge rate, the charge parameters...".

Makefile
- Changed "CONFIG_POWER_RT5033" to "CONFIG_CHARGER_RT5033", as noted by
  Sebastian.
- Placed CHARGER_RT5033 directly below BATTERY_RT5033, like in the Kconfig
  file.

Generally on rt5033_charger.c
- Added SPDX-License-Identifier tag to line 1.
- At the top of rt5033_charger.c, before "Free Software Foundation", added a
  space between "by the", as mentioned by Paul.
- In function rt5033_init_const_charge(), rt5033_init_fast_charge(),
  rt5033_init_pre_charge() and rt5033_charger_reg_init(), changed the pointer
  of "struct rt5033_charger" from *psy to *charger. Firstly to avoid confusion
  with "psy" within "struct rt5033_charger" [15]. Secondly to stay more
  consistant to other functions like rt5033_charger_probe() or
  rt5033_get_charger_state() where pointer *charger is used.
- At the end, added rt5033_charger_of_match[], MODULE_DEVICE_TABLE(of, ...)
  and .of_match_table to probe the driver by device-tree.
- At the end, changed MODULE_LICENSE to "GPL v2", as noted by Sebastian and
  Paul.

Function rt5033_get_charger_state()
- At declaration changed the order of "reg_data" and "state".
- Moved "state = POWER_SUPPLY_STATUS_UNKNOWN" from declaration area to
  switch "default:".
- Data type for "reg_data" doesn't need to be "u32". Changed it to
  "unsigned int". In the Android driver it's "int" [16].
- The RT5033_CHG_STAT_MASK needs to be 0x30 to cover the charge state options
  0x00, 0x10, 0x20, 0x30 [17]. In the Android driver it's 0x30 as well [18].
  Thus, changing that value in include/linux/mfd/rt5033-private.h is needed.
  Interestingly it overlaps with RT5033_CHG_STAT_TYPE_MASK which is 0x60.
  The STAT_TYPE is actually just one bit at 0x40. However, using 0x60 to
  overlap with the STAT mask 0x30 allows to detect more states. If the
  STAT is "charging" or "not charging" (failure), BIT(5) is 1 and the
  STAT_TYPE can be "fast" or "trickle". On the other hand, if STAT is
  "discharging" or "full", BIT(5) is 0 and that way STAT_TYPE can be set to
  "none" or "unknown".

Function rt5033_get_charger_type()
- At declaration changed the order of "reg_data" and "state".
- Again changed data type for "reg_data" from "u32" to "unsigned int". In
  the Android driver it's "int" [19].
- Moved "state =" from declaration area to switch "default:".
- Changed "state =" from UNKNOWN to NONE. This way the charger type is "none"
  when no cable is attached.

Function rt5033_get_charger_current_limit()
- Renamed function rt5033_get_charger_current() to
  rt5033_get_charger_current_limit(). It doesn't return a measured value, it
  returns the current limit that was set.
- Removed the psp check and psp parameter, as suggested by Sebastian.
- Replaced "state" calculation "(reg_data >> RT5033_CHGCTRL5_ICHG_SHIFT) & 0x0f"
  by "(reg_data & RT5033_CHGCTRL5_ICHG_MASK) >> RT5033_CHGCTRL5_ICHG_SHIFT".
  The first is a shift by >> 4 and mask 00001111. The second is a mask 11110000
  and a shift by >> 4. However, this way it's better represented by the values
  defined in include/linux/battery/charger/rt5033_charger.h.
- Removed the limitation to RT5033_CHG_MAX_CURRENT. This function is reading
  the current limit. If the current limit is higher than the defined max for
  whatever reason, this should be visible in sysfs.
- Replaced "data" calculation "state * 100 + 700" by a calculation using values
  RT5033_CHARGER_FAST_CURRENT_MIN and RT5033_CHARGER_FAST_CURRENT_STEP_NUM.

Function rt5033_get_charger_const_voltage()
- Renamed function rt5033_get_charge_voltage() to
  rt5033_get_charger_const_voltage(). It doesn't measure the charge voltage,
  it returns the const voltage that was set.
- Removed the psp check and psp parameter as suggested by Sebastian.
- Replaced "data" calculation "reg_data >> 2" by
  "(reg_data & RT5033_CHGCTRL2_CV_MASK) >> RT5033_CHGCTRL2_CV_SHIFT;". This
  is cleaner. However, the value RT5033_CHGCTRL2_CV_SHIFT needs to be added
  to include/linux/mfd/rt5033-private.h.
- Removed the limitation to RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MAX. If the
  const voltage is set higher than the defined max for whatever reason, this
  should be visible in sysfs.

Function rt5033_init_const_charge()
- Added missing "int" to declaration "unsigned int val". Also adapted the
  order of declarations to be similar to functions rt5033_init_fast_charge()
  and rt5033_init_pre_charge().
- In remark "Set Constant voltage mode" wrote "constant" in lower case.
- Changed hex value 0x0 to two digits 0x00.
- In section "Set Constant voltage mode", the "reg_data" is wrongly set to
  0xfc (decimal 252). That's the value of the const voltage mask 11111100,
  which is RT5033_CHGCTRL2_CV_MASK. However, from 3,65 V to 4,4 V in
  0,025 steps [20] are 30 steps. Thus, the max value should be 0x1e (decimal
  30). Let's use a new define RT5033_CV_MAX_VOLTAGE here that contains that
  value. Needs to be added to include/linux/mfd/rt5033-private.h.
- In section "Set Constant voltage mode" at regmap_update_bits(), replaced
  shift value 2 by RT5033_CHGCTRL2_CV_SHIFT.
- In section "Set end of charge current" changed hex values 0x1 and 0x7 to
  two digits 0x01 and 0x07.

Function rt5033_init_fast_charge()
- Changed AICR mask name from RT5033_AICR_MODE_MASK to
  RT5033_CHGCTRL1_IAICR_MASK.
- Removed the block "Set internal timer". The fast charge timer stops charging
  when the time has elapsed (TIMER4 is 4 hours). There is no re-charging. Thus,
  this behavior is confusing because the device keeps discharging after the
  timer has elapsed.
- In remark "Set fast-charge mode Carging current" fixed the word "Carging"
  to "charging".
- In section "Set fast-charge mode charging current" changed hex value 0x0
  to two digits 0x00.
- Moved declaration "unsigned int val" to the beginning of the function.
- Replaced max value 0xd0 (decimal 208) by RT5033_CHG_MAX_CURRENT (which is
  0x0d, decimal 13). From 700 mA to 2000 mA in 100 mA steps [21] are 13 steps.
  In the Android driver the value is written as 0xd [22], which is decimal 13.
- Calculation of "reg_data" as "0x10 + val" is unneccesary. 0x10 adds BIT(4)
  but "val" needs to be shifted by 4 bits later on, thus the bit added here
  gets lost and is therefore not needed.
- In section "Set fast-charge mode charging current", on regmap_update_bits()
  the "reg_data" value has to be shifted by RT5033_CHGCTRL5_ICHG_SHIFT
  (shift << 4) to meet RT5033_CHGCTRL5_ICHG_MASK (mask 11110000).

Function rt5033_init_pre_charge()
- Moved declaration "unsigned int val" to the beginning of the function.
- In section "Set pre-charge threshold voltage" changed "reg_data"
  calculation from "0x00 + val" to simply "val", the 0x00 isn't needed.
- In section "Set pre-charge mode charging current", the min/max values are
  350 mA and 650 mA according to include/linux/mfd/rt5033-private.h. And the
  step size is 100 mA. These are 4 steps (350, 450, 550, 650 mA). The max
  "reg_data" value is therefore 0x03. The value 0x18, on the contrary, is
  the mask where that value needs to written into (mask 00011000). Therefore
  add a new define RT5033_CHG_MAX_PRE_CURRENT to rt5033-private.h and use
  this value for the "reg_data" max value.
- In section "Set pre-charge mode charging current", when writing the
  "reg_data" to the register, it needs a shift by 3 bit to fit the
  RT5033_CHGCTRL4_IPREC_MASK, which is mask 0x18 (00011000). Thus, replace
  the "reg_data" calculation "0x08 + val" by simply "val", add a new define
  RT5033_CHGCTRL4_IPREC_SHIFT to include/linux/mfd/rt5033-private.h and apply
  this on regmap_update_bits().

Function rt5033_charger_reg_init()
- Removed the regmap_update_bits() of RT5033_CHARGER_MODE,
  RT5033_CHARGER_UUG_ENABLE, RT5033_CFO_ENABLE and
  RT5033_CHARGER_HZ_DISABLE. They set the same values that are already the
  default settings of the chip. Therefore it's not neccessary to set them.
- Added new block "Enable charging termination". It stops charging when
  reaching the end-of-charge current and enters a re-charging cycle. The
  re-charging starts when the voltage gets 0.1 V below the constant voltage.
- Set minimum input voltage regulation (MIVR) to DISABLED. This increases
  charging speed when using weak cables.

Array rt5033_charger_props[]
- Removed property POWER_SUPPLY_PROP_CURRENT_NOW, see further below.
- Removed property POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX, see below.
- Added property POWER_SUPPLY_PROP_ONLINE. Userspace layer UPower expects
  property "online" for a "line-power" device.

Function rt5033_charger_get_property()
- At declaration "struct rt5033_charger *charger =", replaced container_of()
  by power_supply_get_drvdata().
- Removed property POWER_SUPPLY_PROP_CURRENT_NOW. The regmap doesn't offer
  measured values of the charge current.
- Removed property POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX. The const
  voltage isn't configurable in userspace, therefore it's not relevant to
  the user.
- Assigned function rt5033_get_charger_current_limit() to property
  POWER_SUPPLY_PROP_CURRENT_MAX. It represents the current limit that was set.
- Assigned function rt5033_get_charger_const_voltage() to the property
  POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE. It represents the const voltage
  that was set.
- Added POWER_SUPPLY_PROP_ONLINE. For the time being, "online" is true when
  the state is "charging". This will be optimized when implementing extcon
  cable detection.

Function rt5033_charger_dt_init()
- Removed the remark "Charging current is decided by ...". It's true that the
  fast charging speed is not solely the value imported from device-tree value
  "richtek,fast-uamp" but instead gets chip-interenally managed by additional
  factors. However, at the one hand that's not the ideal location to explain
  this. Secondly, the external sensing register value of 10 mili ohm doesn't
  get changed by the driver. I would just skip this comment.

Struct rt5033_charger_desc
- Added a power_supply_desc struct. Using this in probe for
  devm_power_supply_register().
- Replaced type POWER_SUPPLY_TYPE_MAINS by POWER_SUPPLY_TYPE_USB.

Function rt5033_charger_probe()
- Replaced power_supply_register() by devm_power_supply_register(), as refered
  by Sebastian. Accordingly, removed rt5033_charger_remove() and ".remove"
  further down. Implemented "psy_cfg" in rt5033_charger_probe(). In
  include/linux/mfd/rt5033.h, turned power_supply "psy" into a pointer.

Patch 10
- Changed the documentation to yaml format.
- Corrected lower-case/upper-case on some words ("Power Management ...",
  "multifunction device").
- At the description, added that the battery fuel gauge uses a separate I2C
  bus.
- Split out the regulator and charger documentation into a separate documents.
- In the example of the mfd, indicated that the battery fuel gauge is set to
  another I2C bus.
- In the charger yaml in the description of "richtek,eoc-uamp" fixed the upper
  level from 200 mA to 600 mA [23]. Also added description of the step sizes.
- In the charger yaml, added property "extcon" for phandle.
- In the charger yaml, generally minor wording fixes on the descriptions.
- Choose more careful charger values for the example.
- In the regulator yaml added the voltage ranges to the description.
- Skipped the change on Documentation/devicetree/bindings/vendor-prefixes.txt,
  Richtek is already implemented in the vendors list by now.

References:
[1] https://lore.kernel.org/lkml/1425864191-4121-1-git-send-email-beomho.seo@samsung.com/T/#t
[2] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c
[3] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/sec_battery.c
[4] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-serranovelte-battery-r01.dtsi
[5] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/mfd/rt5033_core.c#L482-L486
[6] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/mfd/rt5033_core.c#L364-L365
[7] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L146-L158
[8] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/mfd/rt5033_core.c#L350-L390
[9] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L622-L627
[10] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L995-L1250
[11] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/include/linux/battery/charger/rt5033_charger.h#L52-L58
[12] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/mfd/rt5033_irq.c
[13] https://lore.kernel.org/linux-pm/YMeILEnjOCCzo61q@gerhold.net
[14] https://github.com/Jakko3/linux/blob/rt5033-charger_v1/drivers/power/supply/rt5033_charger.c
[15] https://github.com/torvalds/linux/blob/v6.1-rc1/include/linux/mfd/rt5033.h#L54
[16] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L657
[17] https://github.com/torvalds/linux/blob/v6.1-rc1/include/linux/mfd/rt5033-private.h#L59-L62
[18] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L671
[19] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L705
[20] https://github.com/torvalds/linux/blob/v6.1-rc1/include/linux/mfd/rt5033-private.h#L155-L158
[21] https://github.com/torvalds/linux/blob/v6.1-rc1/include/linux/mfd/rt5033-private.h#L165-L168
[22] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L377-L382
[23] https://github.com/torvalds/linux/blob/v6.0/include/linux/mfd/rt5033-private.h#L178

Jakob Hauser (9):
  mfd: rt5033: Fix chip revision readout
  mfd: rt5033: Fix comments and style in includes
  mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
  mfd: rt5033: Apply preparatory changes before adding rt5033-charger
    driver
  power: supply: rt5033_charger: Add RT5033 charger device driver
  power: supply: rt5033_charger: Add cable detection and USB OTG supply
  power: supply: rt5033_charger: Make use of high impedance mode
  power: supply: rt5033_battery: Adopt status property from charger
  dt-bindings: Add documentation for rt5033 mfd, regulator and charger

Stephan Gerhold (1):
  mfd: rt5033: Drop rt5033-battery sub-device

 .../bindings/mfd/richtek,rt5033.yaml          | 102 +++
 .../power/supply/richtek,rt5033-charger.yaml  |  76 ++
 .../regulator/richtek,rt5033-regulator.yaml   |  45 +
 drivers/mfd/rt5033.c                          |  11 +-
 drivers/power/supply/Kconfig                  |   8 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/rt5033_battery.c         |  24 +
 drivers/power/supply/rt5033_charger.c         | 769 ++++++++++++++++++
 include/linux/mfd/rt5033-private.h            |  81 +-
 include/linux/mfd/rt5033.h                    |  15 +-
 10 files changed, 1091 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
 create mode 100644 drivers/power/supply/rt5033_charger.c

-- 
2.39.1

