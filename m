Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389265FAB86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 06:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJKEGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 00:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJKEGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 00:06:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F57957BC9;
        Mon, 10 Oct 2022 21:06:09 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 204so12405308pfx.10;
        Mon, 10 Oct 2022 21:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KibBS7/DP0lI+k/zxcH7tDRON+6p0Yd/miPufl5XhBg=;
        b=GqnD0ygD+BWYXuLuGSBbA441ocGW8ccTk66PQx98mMcUJPXTf1Kjtbqu69UHQ4lNYz
         WklgKEn6CCka5g48+F+tBSM81/kABbqBoHKKem0neJhItv7/H8/KdES1md/mci28DNme
         CvEeTNRJtbMpWBFnC1q0BVbUdvyuRSnql8Bu+AuNHBCm9AS4h/l0eNmbjiYTzhTDzrN9
         iVwazyKv78XnlJJJc8zPSsdTr9btF1+ibh+wN7n7MILbZ2Z6n6uvf4ogApGu+tIwwlgo
         1lYNReEJMWKsD4ZwsWl+pfqai2WW+yApesmqWMaJPNZwBTeGfmjmAeN/Ou4XBURFH7tL
         sTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KibBS7/DP0lI+k/zxcH7tDRON+6p0Yd/miPufl5XhBg=;
        b=C0YnigogTeDK0mpwtYL3smffdauGelbsfiSObH17St3aN5eM5VLDGwY27/KZw/Me5n
         njtHLtRcjq5qyJg+N3oOyJrAdlkSI8igdx2+Er10e4AP0kv49XY0oQrcUBu6QAYuF4Ae
         mkWe/8yKbOHYoK9ZabZ36uJvX9eOdGiehMFWoMLa83Wxz5GUdEkBz3ensFGRBIKSCBuK
         t3tBbO9oTov49kGdBPJTKWYQUZKELxLrh6CCO2mJBTrVT89WHLAsX0M3vQmpYMQ5tgeu
         rsoyyGMRCnzwuiKxBrGYe4HSmaf4u2KgKBhinRffzJALFms1SvavtJ0bbijzvW44lioY
         g9tA==
X-Gm-Message-State: ACrzQf2LSZphiI4MdcTNc6etCZ2PalC6CndpTn/aIGCSCKQxHat2gjkV
        Qmhso0lOFyRMeneZDgsSyBQ=
X-Google-Smtp-Source: AMsMyM6+pU2TNEWwV0Pf3AvWllZW4YM3UXhwkyu0zBbmjN4jsi7mYW5WADd4oJoS68WCgQjGDDqh1g==
X-Received: by 2002:a63:5f54:0:b0:462:1149:f3b3 with SMTP id t81-20020a635f54000000b004621149f3b3mr8281417pgb.445.1665461168608;
        Mon, 10 Oct 2022 21:06:08 -0700 (PDT)
Received: from RD-3580-24288.rt.l (114-137-131-130.emome-ip.hinet.net. [114.137.131.130])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a7ac800b00205d70ccfeesm9755968pjl.33.2022.10.10.21.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 21:06:08 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     pavel@ucw.cz, matthias.bgg@gmail.com, jic23@kernel.org,
        lars@metafoo.de, andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, szunichen@gmail.com
Subject: [PATCH v14 0/3] Add MediaTek MT6370 PMIC support
Date:   Tue, 11 Oct 2022 12:05:43 +0800
Message-Id: <cover.1665488982.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiaEn Wu <chiaen_wu@richtek.com>

This patch series add MediaTek MT6370 PMIC support and add a index macro
to <linear_range.h>. The MT6370 is a highly-integrated smart power
management IC, which includes a single cell Li-Ion/Li-Polymer switching
battery charger, a USB Type-C & Power Delivery (PD) controller, dual
Flash LED current sources, a RGB LED driver, a backlight WLED driver,
a display bias driver and a general LDO for portable devices.

First, in this series of patches,
- 'dt-binding: mfd' and 'mfd driver' have been applied by Lee in the v7.
  https://lore.kernel.org/all/YvJdpq0MWNPQZw5c@google.com/
  https://lore.kernel.org/all/YvJdxEpC2cB58Bq9@google.com/

- 'tcpci driver' has been applied by Greg in the v8.
  https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=c2a8ea5997fdfeb43eda259d5533234c3cae05d7

- 'dt-binding: backlight' and 'backlight driver' have been applied
  by Lee in v9.
  https://lore.kernel.org/all/YxYSDSlnOELL2mPF@google.com/
  https://lore.kernel.org/all/YxYS7%2FdZI69lMXeh@google.com/

- 'dt-binding: charger', 'charger driver' and 'linear_range.h' patch have
  been applied by Sebastian in v11.
  https://lore.kernel.org/all/20220920160857.6qfi66gtmgwesq7g@mercury.elektranox.org/
  https://lore.kernel.org/all/20220920161218.dkkfvfomrruebahi@mercury.elektranox.org/
  https://lore.kernel.org/all/20220920161238.dswtmyon462324dm@mercury.elektranox.org/

- 'dt-binding: leds: LED Indicator' and 'dt-binding: leds: LED Flash' have
  been applied by Rob in v12
  https://lore.kernel.org/all/166480917702.2250974.12439864185418442009.robh@kernel.org/

Second, the LED RGB driver is based on Andy's patch which moves
led_init_default_state_get() to the global header.
https://lore.kernel.org/all/20220805154907.32263-3-andriy.shevchenko@linux.intel.com/

In addition, we made some changes for MT6370 ADC and LED Flash Kconfig
(see v14 section of the change log below).

Thank you,
ChiaEn Wu
---
Change in v14
- In Patch 1/3 (MT6370 ADC)
	- Revise the scale value of 'VBUSDIV2' in 'mt6370_adc_read_scale()'
	  (50 --> 10)
	- Revise the return value of 'TEMP_JC' in 'mt6370_adc_read_scale()'
	  (return IIO_VAL_FRACTIONAL; --> return IIO_VAL_INT;)
- In Patch 3/3 (MT6370 Flash)
	- Remove unused 'depend on OF' in Kconfig


Change in v13:
- In Patch 1/5 (dt-bindings: MT6370 LED Indicator)
	- Remove 'allOf' property
	- Add '$ref' and 'unevaluatedProperties: false' in 'multi-led'


Change in v12:
- In Patch 5/5 (MT6370 Flash):
	- Rename all 'led_flash_setting *s' --> 'led_flash_setting *setting'
	- Rename 'max_uA' --> 'max_ua' in mt6370_init_flash_properties()


Change in v11:
- In Patch 1/8 (dt-bindings: MT6370 Charger)
	- Add more detailed description of irqs.
	- Adujust the order of irqs


Change in v10:
- In Patch 6/8 (MT6370 Charger):
	- Add a feature (disable input current limit) in
	  'mt6370_chg_init_setting()'
	- Add the header file <linux/devm-helpers.h> for using
	  'devm_work_autocancel()' and 'devm_delayed_work_autocancel()
	- Rename 'pwr_rdy' to 'opposite_pwr_rdy' in
	  'mt6370_chg_pwr_rdy_check()'
	- Rename enum elements
	  ('MT6370_ATTACH_STAT_ATTACH_BC12_NOT_DONE' -->
	   'MT6370_ATTACH_STAT_ATTACH_WAIT_FOR_BC12')
	- Revise the assignment value of 'val.intval' in
	  'mt6370_chg_pwr_rdy_check()' to make the code easy to read.
	- Revise the initialization of bc12_work (INIT_WORK() -->
	  using devm_work_autocancel()) and mivr_dwork
	  (INIT_DELAYED_WORK + devm_add_action_or_reset() -->
	   devm_delayed_work_autocancel())

- In Patch 8/8 (MT6370 LED Flashlight):
	- Add the revert code when '__mt6370_flash_brightness_set()'
	  return failed.
	- Revise type of 'led_no' (u32 -> u8)
	- Revise type of 'default_state' (u32 -> enum led_default_state)
	- Revise the return value of '_mt6370_flash_brightness_set()'
	- Remove the useless function 'mt6370_init_common_properties()'
	- Use 'led_init_default_state_get()' to init 'led->default_state'


Changes in v9:
- In Patch 05/10:
	- Revise LINEAR_RANGE() and LINEAR_RANGE_IDX()

- In Patch 07/10:
	- Fix wrong 'F_IINLMTSEL' setting in 'mt6370_chg_init_setting()'
	- Revise the usage of LINEAR_RANGE_IDX()

- In Patch 09/10:
	- Revise the format of the comments.

- In Patch 10/10:
	- Revise the format of the comments.


Changes in v8:
- In Patch 06/12:
	- Add linear_range_idx macro for declaring the linear_range
	  struct simply.

- In Patch 09/12:
	- Remove MT6370_CHG_LINEAR_RANGE() macro, and change to use
	  LINEAR_RANGE_IDX() macro

- In Patch 10/12:
	- Add include header file <linux/leds.h>
	- Remove useless 'enum mt6370_state' because of using 'enum led_default_state'
	- Revise the calculation of 'val' in 'mt6370_gen_breath_pattern()'
	- Replace the medthod of getting default-state by using
	  led_init_default_state_get()

- In Patch 11/12:
	- Add missing 'dependency config' in Kconfig
	- Revise all multi-line comments

- In Patch 12/12:
	- Add missing header file <linux/property.h>
	- Remove useledd header file <linux/of_device.h>
	- Revise the comment of 'mt6370_check_vendor_info()'


Changes in v7:
- In Patch 05/13:
	- Add the second compatible string for 'mt6372'
	- Add 'mediatek,bled-exponential-mode-enable' property for enable the
	  exponential mode of backlight brightness
	- Add validation for the maximum value of 'default-brightness' and
	  'max-brightness'

- In Patch 07/13:
	- Move '#define MT6370_REG_MAXADDR' to the next line of
	  '#define MT6370_REG_CHG_MASK1'
	- Rename 'MT6370_REG_ADDRLEN' to 'MT6370_MAX_ADDRLEN'

- In Patch 08/13:
	- Revise 'devm_add_action_or_reset(dev, ...)' to one line
	- Revise 'return regmap_update_bits(...)' with using positive
	  conditional

- In Patch 09/13:
	- Add AICR(100mA ~ 350mA), ICHG(100mA ~ 800mA) macros
	- Remove 400mA AICR and 900mA ICHG macros
	- Revise using 'if-else' to 'switch-case' in mt6370_adc_read_scale()
	  where the adc channel is ibus or ibat

- In Patch 10/13:
	- Revise the method to enable/disable irq
	- Revise all 'if (ret < 0)' to 'if (ret)' after using
	  mt6370_chg_field_set/get()
	- Revise all 'OTG' text again

- In Patch 11/13:
	- Add the comment for the union of 'struct mt6370_led'
	- Revise the wrong description of 'Authors'
	- Revise some typos (e.g. led --> LED)
	- Revise 'if (!fwnode_property_read_string())' to
	  'ret = fwnode_property_read_string()'
	- Replace 'memcpy(...)' with 'put_unaligned_be24()' in
	  mt6370_gen_breath_pattern()
	- Replace all 'LED_OFF' with 0
	- Remove the redundant assignment in mt6370_mc_pattern_clear()

- In Patch 12/13:
	- Fix the indentation.
	- For the well defined macro, the parenthesis is needed for input parameters.
	- Replace some dev_warn to dev_info in 'init_flash_properties'.
	- Add sentinel comment for the terminator entry of of_device_id.
	- Use priv->fled_torch_used directly.
	- Delete 0 in {}.
	- Use _uA instead of _UA in definition.
	- Refine the description.
	- Use usleep_range instead of udelay.
	- Rename config to LEDS_MT6370_FLASH.
	- Add missing ">" in copyright.
	- Change the Kconfig order

- In Patch 13/13:
	- Add support 'exponential mode' property parsing
	- Add 'return dev_err_probe()' after 'if (IS_ERR(priv->enable_gpio))'
	- Add 'mt6372' compatible string
	- Revise Kconfig help text
	- Revise update()/get() for supporting 16384 steps (MT6372)
	- Revise all shift usages form using 'ffs() and fls()' to defining the
	  _SHIFT macros.
	- Revise 'brightness ? 1 : 0' to '!!brightness' in gpiod_set_value()


Changes in v6:
- In Patch 03/13:
	- Add 'reg' property of led of multi-led to prevent checking
	  error.

- In Patch 08/13:
	- Convert tcpci as device resource managed with
	  'devm_add_action_or_reset' api.
	- Refine remvoe callback.
	- Refine the commit text from 'this commit add' to 'add'.

- In Patch 09/13:
	- Using 'struct device *dev = &pdev->dev' in probe()
	- Revise the sixth parameter of regmap_read_poll_timeout() by
	  Replacing '1000' with 'MILLI'
	- Revise the units of three macros
	- MT6370_AICR_400MA --> MT6370_AICR_400_mA
	- MT6370_ICHG_500MA --> MT6370_ICHG_500_mA
	- MT6370_ICHG_900MA --> MT6370_ICHG_900_mA

- In patch 10/13:
	- Remove the varable (*psy_desc) of struct mt6370_priv
	- Remove the deprecated usb type (POWER_SUPPLY_TYPE_USB_CDP and
	  POWER_SUPPLY_TYPE_USB_DCP)
	- Remove useless remove()
	- Revise all units from mini- to micro-
	- Revise get/set power_supply_prop (change to directly return get/set
	  regmap_field)
	- Revise probe() and use devm_add_action_or_reset() for handling of the
	  workqueue/delayed_work/mutex
	- Revise mt6370_chg_psy_desc
		- Add '.name = "mt6370-charger"'
		- Use 'static const'

- In patch 11/13:
	- Remove the 'ko' from mt6370 led Kconfig description.
	- Add both authors for Alice and ChiYuan.
	- Use pdata to distinguish the code from mt6370/71 to mt6372.
	- Instead of 'state' define, use the 'state' enum.
	- Fix the typo for 'MT6372_PMW_DUTY'.
	- For pwm_duty define, replace with bit macro - 1.
	- Refine all the labels from 'out' to 'out_unlock'.
	- Use struct 'dev' variable and 'dev_err_probe' to optimize the LOC.
	- Revise for the array initialization from {0} to {}.
	- Move into rgb folder and rename file name to 'leds-mt6370-rgb'.
	- Refine the 'comma' usage in struct/enum.

- In patch 12/13:
	- Use 'GENMASK' instead of 'BIT'.
	- Use dev_err_probe to decrease LOC.
	- Use 'dev' variable to make probe function more clean.
	- Refine the return of _mt6370_flash_brightness_set function.
	- Refine the descriptions.
	- Use mt6370_clamp() instead of clamp_align().
	- Use device resource managed API for v4l2 flash_release.


Changes in v5:
- In patch 07/13:
	- Add the comma in the last REGMAP_IRQ_REG_LINE(),
	  DEFINE_RES_IRQ_NAMED() and MFD_CELL_RES()
	- Add the prefix in the first parameter of all mfd_cell
	- Move enum and struct mt6370_info to mt6370.h
	- Remove struct device *dev in struct mt6370_info
	- Revise the description of Kconfig help text
	- Revise MODULE_DESCRIPTION()

- In patch 08/13:
	- Add comma for the last index of mt6370_reg_init.
	- Use dev_err_probe to decrease LOC.
	- Use 'dev' variable to make probe function more clean.
	- Refine kconfig text.
	- Remove both 'else' in set_vbus callback.
	- Remove comma for of_device_id if the assigned member is only one.

- In patch 09/13:
	- Replace using snprintf() with sysfs_emit() in mt6370_adc_read_label()
	- Remove macro ADC_CONV_TIME_US
	- Revise all variable ordering
	- Revise the description of Kconfig help text
	- Revise MODULE_DESCRIPTION()

- In patch 10/13:
	- Replace unsigned int type of pwr_rdy with bool in
	  mt6370_chg_set_online()
	- Remove redundant 'else' in mt6370_chg_field_get()
	- Revise 'if-else' in mt6370_chg_field_set()
	- Revise 'if' condition in mt6370_chg_enable_irq()
	- Revise all text 'otg' --> 'OTG'
	- Revise MT6370_MIVR_IBUS_TH_100_MA --> MT6370_MIVR_IBUS_TH_100_mA
	- Revise the description of Kconfig help text

- In patch 12/13:
	- Refine the coding style.
	- Use "dev" instead of "&pdev->dev".

- In patch 13/13:
	- Add missed <mod_devicetable.h>
	- Add struct device *dev in probe() to make code cleaning
	- Remove useless including header file <gpio/driver.h>, <of.h>
	- Remove useless variable uasage in mt6370_init_backlight_properties()
	- Remove redundant checking enable_gpio in mt6370_bl_update_status()
	- Remove redundant parentheses in mt6370_bl_get_brightness()
	- Revise the description of Kconfig help text
	- Revise the calculation of hys_th_steps


Changes in v4:
- In patch 02/13:
	- Add minItems of "io-channel-names"
	- Replace text "Mediatek" with "MediaTek"

- In patch 06/13:
	- Roll back all "$ref: " to v2 patch style (using "/schemas/...")

- In patch 07/13:
	- Replace text "Mediatek" with "MediaTek" in Kconfig
	- Replace "first break and then return" with "return directly"
	  in "mt6370_check_vendor_info()"
	- Add module name related description in Kconfig helptext
	- Add Copyright in the source code
	- Add header file "mt6370.h" for all "#define IRQ"
	- Adjust Makefile order of MT6370
	- Refine "bank_idx" and "bank_addr" in
	  "mt6375_regmap_read()" / "mt6375_regmap_write()"
	- Refine redundant "else if" in "mt6370_regmap_read()"

- In patch 08/13:
	- Replace text "Mediatek" with "MediaTek" in Kconfig
	- Replace "first ret=regulator_(dis/en)able and then return"
	  with "return directly" in "mt6370_tcpc_set_vbus()"
	- Replace header file <linux/of.h> with <linux/mod_devicetable.h>
	- Add Copyright in the source code
	- Add module name related description in Kconfig helptext
	- Remove header file <linux/of.h>
	- Refine all probe error by using dev_err_probe()

- In patch 09/13:
	- Replace text "Mediatek" with "MediaTek"
	- Replace all "first dev_err() and then return" with
	  "return dev_err_probe()"
	- Add Copyright in the source code
	- Add module name related description in Kconfig
	- Add unit suffix of macro "ADC_CONV_POLLING_TIME"
	- Add new macro "ADC_CONV_TIME_MS"
	- Adjust the position of include file <mediatek,mt6370_adc.h>
	- Adjust the postions between <linux/module.h> and
	   <linux/mod_devicetable.h>
	- Fix some incorrect characters

- In patch 10/13:
	- Replace text "Mediatek" with "MediaTek" in Kconfig and
	  MODULE_DESCRIPTION()
	- Replace "mt6370_chg_val_to_reg" and "mt6370_chg_reg_to_val"
	  with "linear_range" API
	- Replace "first break and then return" with "return directly"
	  in all cases of get/set power_supply_property
	- Replace all "first dev_err() and then return" with "return
	  dev_err_probe()"
	- Replace all "return IS_ERR(priv->rdev) ? PTR_ERR(priv->rdev) : 0"
	  with "PTR_ERR_OR_ZERO()"
	- Replace "priv->dev->of_node" with "dev_of_node()"
	- Add Copyright in the source code
	- Add module name related description in Kconfig helptext
	- Add proper unit of "MT6370_MIVR_IBUS_TH"
	- Add error check in "mt6370_chg_get_status"
	- Remove including <mediatek,mt6370_adc.h> header file
	- Remove redundant comma of every enum terminator line
	- Remove unwanted blank lines
	- Remove the useless label (toggle_cfo_exit:)
	- Remove using atomic
	- Remove using of_match_ptr()
	- Fix some incorrect characters
	- Fix updating wrong bits when using ena_gpiod of OTG regulator
	- Adjust the probe order in probe()

- In patch 11/13:
	- Replace text "Mediatek" with "MediaTek" in Kconfig
	- Replace text "const" with "constant" in Kconfig
	- Add Copyright in the source code

- In patch 12/13:
	- Replace text "Mediatek" with "MediaTek" in Kconfig
	- Add Copyright in the source code

- In patch 13/13:
	- Replace text "Mediatek" with "MediaTek" in Kconfig
	- Add Copyright in the source code
	- Revise the comment of "PWM HYS STEPS"


Changes in v3:
- Remove ADC ABI file, which is added in v2 Patch 7
- In patch 02/14:
	- Add items and remove maxItems of io-channels
	- Add io-channel-names and describe each item
	- Add "unevaluatedProperties: false" in "usb-otg-vbus-regulator"
	- Rename "enable-gpio" to "enable-gpios" in "usb-otg-vbus-regulator"

- In patch 03/14:
	- Use leds-class-multicolor.yaml instead of common.yaml.
	- Split multi-led and led node.
	- Add subdevice "led" in "multi-led".

- In patch 04/14:
	- Remove the description of enum.

- In patch 05/14:
	- Rename "mediatek,bled-pwm-hys-input-threshold-steps" to
	  "mediatek,bled-pwm-hys-input-th-steps"
	- Refine "bled-pwm-hys-input-th-steps", "bled-ovp-microvolt",
	  "bled-ocp-microamp" enum values

- In patch 06/14:
	- Use " in entire patchset
	- Refine ADC description
	- Rename "enable-gpio" to "enable-gpios" in "regualtor"

- In patch 07/14:
	- Refine Kconfig help text
	- Refine error message of unknown vendor ID in
	  mt6370_check_vendor_info()
	- Refine return value handling of mt6370_regmap_read()
	- Refine all probe error by using dev_err_probe()
	- Refine "bank_idx" and "bank_addr" in mt6370_regmap_read() and
	  mt6370_regmap_write()
	- Add "#define VENID*" and drop the comments in
	  mt6370_check_vendor_info()
	- Drop "MFD" in MODULE_DESCRIPTION()

- In patch 09/14:
	- Refine Kconfig help text

- In patch 10/14:
	- Refine Kconfig help text
	- Refine all channel value in read_scale()
		a. current: uA --> mA
		b. voltage: uV --> mV
		c. temperature: degrees Celsius --> milli degrees Celsius
	- Add "default:" condition of switch statement in read_scale() and read_raw()
	- Add error message for reading ADC register failed
	- Add the comment for adc_lock
	- Add <linux/mod_devicetable.h> header file for struct of_device_id
	- Replace "adc" text with "ADC" in all of the error messages

- In patch 12/14:
	- Refine the grammer of the Kconfig.
	- Change reg mode to the const current mode.

- In patch 14/14:
	- Refine bool properties parsing (pwm-enable, ovp-shutdown, ocp-shutdown) in DT
	  parsing function
	- Refine u32 and u8 properties parsing (pwm-hys-input-th-steps, ovp-microvolt,
	  ocp-microamp), from using register value to using actual value
	- Refine error string of "channle-use" parsing failed
	- Refine Kconfig help text


Changes in v2:
- In patch 01/15:
	- Add "unevaluatedProperties: false".
	- Delete "DT bindings".
	- Refine the description to fit in 80 columns.
	- Skip the connector description.

- In patch 02/15:
	- Refine items description of interrupt-name
	- Rename "usb-otg-vbus" to "usb-otg-vbus-regulator"
	- Add constraint properties for ADC

- In patch 03/15:
	- Skip not useful description of "^(multi-)?led@[0-3]$"
	  and reg.
	- Due to the dependency, remove the mention of mfd
	  document directory.
	- Delete Soft-start property. In design aspect, we think
	  soft-restart should always be enabled, our new chip
	  has deleted the related setting register , also, we don’t
	  allow user adjust this parameter in this chip.
	- Refine the commit message.

- In patch 04/15:
	- Skip not useful description of "^led@[0-1]$" and reg.
	- Add apace after '#'.
	- Refine the commit message.

- In patch 05/15:
	- Remove "binding documentation" in subject title
	- Refine description of mt6370 backlight binding
	  document
	- Refine properties name(bled-pwm-hys-input-bit,
	  bled-ovp-microvolt, bled-ocp-microamp) and their
	  description

- In patch 06/15:
	- Refine ADC and Regulator descriptions
	- Refine include header usage in example
	- Refine node name to generic node name("pmic@34")
	- Refine led example indentation
	- Refine license of mediatek,mt6370_adc.h
	- Rename the dts example from IRQ define to number.
	- Remove mediatek,mt6370.h

- In patch 07/15:
	- Add ABI documentation for mt6370 non-standard ADC
	  sysfs interfaces.

- In patch 08/15:
	- Add all IRQ define into mt6370.c.
	- Refine include header usage

- In patch 09/15:
	- No changes.

- In patch 10/15:
	- Use 'gpiod_get_from_of_node' to replace
	  'fwnode_gpiod_get_index'.

- In patch 11/15:
	- Refine Kconfig mt6370 help text
	- Refine mask&shift to FIELD_PREP()
	- Refine mutex lock name ("lock" -> "adc_lock")
	- Refine mt6370_adc_read_scale()
	- Refine mt6370_adc_read_offset()
	- Refine mt6370_channel_labels[] by using enum to index
	  chan spec
	- Refine MT6370_ADC_CHAN()
	- Refine indio_dev->name
	- Remove useless include header files

- In patch 12/15:
	- Refine mt6370_chg_otg_rdesc.of_match
	  ("mt6370,otg-vbus" -> "usb-otg-vbus-regulator") to match
	  DT binding

- In patch 13/15:
	- Refine Kconfig description.
	- Remove include "linux/of.h" and use
	  "linux/mod_devicetable.h".
	- Place a comma for the last element of the const
	  unsigned int array.
	- Add a comment line for the mutex 'lock'.
	- In probe function, use 'dev_err_probe' in some
	  judgement to reduce the LOC.
	- Refine include header usage.
	  BIT/GENMASK -> linux/bits.h
	  FIELD_GET -> linux/bitfield.h

- In patch 14/15:
	- Add blank line.
	- Replace container_of() with to_mt6370_led() .
	- Refine description of ramping.
	- Refine the mt6370_init_common_properties function.
	- Refine the probe return.

- In patch 15/15:
	- Refine MT6370 help text in Kconfig
	- Refine DT Parse function
	- Remove useless enum
	- Add comment for 6372 backward compatible in
	  bl_update_status() and
	  check_vendor_info()
	- Using dev_err_probe(); insteads dev_err()&return; in
	  the probe()



Alice Chen (1):
  leds: flash: mt6370: Add MediaTek MT6370 flashlight support

ChiYuan Huang (1):
  leds: rgb: mt6370: Add MediaTek MT6370 current sink type LED Indicator
    support

ChiaEn Wu (1):
  iio: adc: mt6370: Add MediaTek MT6370 support

 drivers/iio/adc/Kconfig                |   12 +
 drivers/iio/adc/Makefile               |    1 +
 drivers/iio/adc/mt6370-adc.c           |  305 ++++++++++
 drivers/leds/flash/Kconfig             |   14 +
 drivers/leds/flash/Makefile            |    1 +
 drivers/leds/flash/leds-mt6370-flash.c |  631 ++++++++++++++++++++
 drivers/leds/rgb/Kconfig               |   13 +
 drivers/leds/rgb/Makefile              |    1 +
 drivers/leds/rgb/leds-mt6370-rgb.c     | 1010 ++++++++++++++++++++++++++++++++
 9 files changed, 1988 insertions(+)
 create mode 100644 drivers/iio/adc/mt6370-adc.c
 create mode 100644 drivers/leds/flash/leds-mt6370-flash.c
 create mode 100644 drivers/leds/rgb/leds-mt6370-rgb.c

-- 
2.7.4

