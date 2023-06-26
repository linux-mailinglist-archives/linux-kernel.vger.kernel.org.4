Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9EA73E65A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjFZRXG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFZRWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:22:55 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA960B5;
        Mon, 26 Jun 2023 10:22:51 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-98502b12fd4so85379166b.1;
        Mon, 26 Jun 2023 10:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800170; x=1690392170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cD80PIBgZup30mTfHgGV4u4iHdztSgaaBpFQjePwxjw=;
        b=OxtMxFPbaWtDDMKN4I/+onPV6NOHUg0e1kUu5PQns9SLEa/8fZr1GDZmvfmf/ySF2M
         JJCply7K+/t/sPCxvwEhyP6x8VKGq8VLvwkb4cpM7T1X9cPVZjM41qqoo5aY1TbwouDg
         p0t6rkgvmvztnzs3i7WQ3ZNPoDfupHDqHWm4XTM1+x2EARyp+hZzChMaz0iA2QJHhrnf
         Znrg7rPuAR3zhyfAMZXElvz43BqFx7KfXYiu3pgunXA04LzoghHhPPU4M3fJ/ulpRPfT
         mZSrwi/ZjcgRg1i3BdvrjIfCEoDhs06jD7UYSTmindP1GP21tJBXhzDxYdkYePeTNC7Y
         o+vQ==
X-Gm-Message-State: AC+VfDxVgTtzltcp8u6tx6kTlmg0WDaNJCvVDMStlsYQFrDKNYCbY0DK
        9fIlyMz7cnwHG9Q2THbyTklwXCXZXM66i7KN4kRwmXTuj7E=
X-Google-Smtp-Source: ACHHUZ4ERP/yI0j3ahAYAnIL8SC4KlcpCkDE7vVwxqhaV1TFAGMgVc13T+TN/+hVfStZCUUm3giYYSUeyXirHyAqzOU=
X-Received: by 2002:a17:906:73cd:b0:988:815c:ba09 with SMTP id
 n13-20020a17090673cd00b00988815cba09mr16477089ejl.4.1687800169948; Mon, 26
 Jun 2023 10:22:49 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Jun 2023 19:22:39 +0200
Message-ID: <CAJZ5v0h6P7rCOmZXChsYvdYm5HGZhuMLgHFHq_CtNgTHgdeF0g@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.5-rc1

with top-most commit a8460ba59464c038c817844f67a74fe847b56613

 Merge tag 'thermal-v6.5-rc1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into
thermal

on top of commit 0bb619f9227aa370330d2b309733d74750705053

 thermal/intel/intel_soc_dts_iosf: Fix reporting wrong temperatures

to receive thermal control updates for 6.5-rc1.

These extend the int340x thermal driver, add thermal DT bindings for
some Qcom platforms, add DT bindings and support for Armada AP807 and
MSM8909, allow selecting the bang-bang thermal governor as the default
one, address issues in several thermal drivers for ARM platforms and
clean up code.

Specifics:

 - Add new IOCTLs to the int340x thermal driver to allow user space to
   retrieve the Passive v2 thermal table (Srinivas Pandruvada).

 - Add DT bindings for SM6375, MSM8226 and QCM2290 Qcom platforms (Konrad
   Dybcio).

 - Add DT bindings and support for QCom MSM8226 (Matti Lehtimäki).

 - Add DT bindings for QCom ipq9574 (Praveenkumar I).

 - Convert bcm2835 DT bindings to the yaml schema (Stefan Wahren).

 - Allow selecting the bang-bang governor as default (Thierry Reding).

 - Refactor and prepare the code to set the scene for RCar Gen4 (Wolfram
   Sang).

 - Clean up and fix the QCom tsens drivers. Add DT bindings and
   calibration for the MSM8909 platform (Stephan Gerhold).

 - Revert a patch introducing a wrong usage of devm_of_iomap() on the
   Mediatek platform (Ricardo Cañuelo).

 - Fix the clock vs reset ordering in order to conform to the
   documentation on the sun8i (Christophe JAILLET).

 - Prevent setting up undocumented registers, enable the only described
   sensors and add the version 2.1 on the Qoriq sensor (Peng Fan).

 - Add DT bindings and support for the Armada AP807 (Alex Leibovich).

 - Update the mlx5 driver with the recent thermal changes (Daniel
   Lezcano).

 - Convert to platform remove callback returning void on STM32 (Uwe
   Kleine-König).

 - Add an error information printing for devm_thermal_add_hwmon_sysfs()
   and remove the error from the Sun8i, Amlogic, i.MX, TI, K3, Tegra,
   Qoriq, Mediateka and QCom (Yangtao Li).

 - Register as hwmon sensor for the Generic ADC (Chen-Yu Tsai).

 - Use the dev_err_probe() function in the QCom tsens alarm driver (Luca
   Weiss).

Thanks!


---------------

Alex Leibovich (2):
      dt-bindings: armada-thermal: Add armada-ap807-thermal compatible
      thermal/drivers/armada: Add support for AP807 thermal data

Chen-Yu Tsai (2):
      thermal/drivers/mediatek/lvts_thermal: Register thermal zones as
hwmon sensors
      thermal/drivers/generic-adc: Register thermal zones as hwmon sensors

Christophe JAILLET (1):
      thermal/drivers/sun8i: Fix some error handling paths in sun8i_ths_probe()

Daniel Lezcano (1):
      net/mlx5: Update the driver with the recent thermal changes

Konrad Dybcio (2):
      dt-bindings: thermal: tsens: Add QCM2290
      dt-bindings: thermal: tsens: Add compatible for SM6375

Luca Weiss (1):
      thermal/drivers/qcom/temp-alarm: Use dev_err_probe

Matti Lehtimäki (2):
      dt-bindings: thermal: tsens: Add compatible for MSM8226
      thermal/drivers/qcom/tsens-v0_1: Add support for MSM8226

Pankit Garg (1):
      thermal/drivers/qoriq: No need to program site adjustment register

Peng Fan (2):
      thermal/drivers/qoriq: Only enable supported sensors
      thermal/drivers/qoriq: Support version 2.1

Praveenkumar I (1):
      dt-bindings: thermal: tsens: Add ipq9574 compatible

Ricardo Cañuelo (1):
      Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid
resource leak in mtk_thermal_probe"

Srinivas Pandruvada (1):
      thermal: intel: int340x_thermal: New IOCTLs for Passive v2 table

Stefan Wahren (1):
      dt-bindings: thermal: convert bcm2835-thermal bindings to YAML

Stephan Gerhold (6):
      thermal/drivers/qcom/tsens: Drop unused legacy structs
      thermal/drivers/qcom/tsens-v0_1: Fix mdm9607 slope values
      thermal/drivers/qcom/tsens-v0_1: Add mdm9607 correction offsets
      dt-bindings: thermal: qcom-tsens: Drop redundant compatibles
      dt-bindings: thermal: qcom-tsens: Add MSM8909 compatible
      thermal/drivers/qcom/tsens-v0_1: Add MSM8909 data

Thierry Reding (1):
      thermal: Allow selecting the bang-bang governor as default

Uwe Kleine-König (1):
      thermal/drivers/stm32: Convert to platform remove callback returning void

Wolfram Sang (3):
      drivers/thermal/rcar_gen3_thermal: introduce 'info' structure
      drivers/thermal/rcar_gen3_thermal: refactor reading fuses into
seprarate function
      drivers/thermal/rcar_gen3_thermal: add reading fuses for Gen4

Yangtao Li (10):
      thermal/hwmon: Add error information printing for
devm_thermal_add_hwmon_sysfs()
      thermal/drivers/sun8i: Remove redundant msg in sun8i_ths_register()
      thermal/drivers/amlogic: Remove redundant msg in amlogic_thermal_probe()
      thermal/drivers/imx: Remove redundant msg in imx8mm_tmu_probe()
and imx_sc_thermal_probe()
      drivers/thermal/k3: Remove redundant msg in k3_bandgap_probe()
      thermal/drivers/tegra: Remove redundant msg in
tegra_tsensor_register_channel()
      thermal/drivers/qoriq: Remove redundant msg in
qoriq_tmu_register_tmu_zone()
      thermal/drivers/ti-soc: Remove redundant msg in ti_thermal_expose_sensor()
      thermal/drivers/qcom: Remove redundant msg at probe time
      thermal/drivers/mediatek/lvts_thermal: Remove redundant msg in
lvts_ctrl_start()

---------------

 .../devicetree/bindings/thermal/armada-thermal.txt |   1 +
 .../bindings/thermal/brcm,bcm2835-thermal.txt      |  41 ----
 .../bindings/thermal/brcm,bcm2835-thermal.yaml     |  48 +++++
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |  32 ++-
 drivers/net/ethernet/mellanox/mlx5/core/thermal.c  |  15 +-
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/amlogic_thermal.c                  |   3 +-
 drivers/thermal/armada_thermal.c                   |  32 ++-
 drivers/thermal/imx8mm_thermal.c                   |   3 +-
 drivers/thermal/imx_sc_thermal.c                   |   3 +-
 .../intel/int340x_thermal/acpi_thermal_rel.c       | 218 +++++++++++++++++++++
 .../intel/int340x_thermal/acpi_thermal_rel.h       |  57 ++++++
 drivers/thermal/k3_bandgap.c                       |   3 +-
 drivers/thermal/mediatek/auxadc_thermal.c          |  14 +-
 drivers/thermal/mediatek/lvts_thermal.c            |   4 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   4 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |  38 ++--
 drivers/thermal/qcom/tsens-v0_1.c                  | 126 ++++++++----
 drivers/thermal/qcom/tsens-v1.c                    |  22 ---
 drivers/thermal/qcom/tsens.c                       |  26 ++-
 drivers/thermal/qcom/tsens.h                       |   6 +-
 drivers/thermal/qoriq_thermal.c                    |  52 ++---
 drivers/thermal/rcar_gen3_thermal.c                | 141 +++++++++----
 drivers/thermal/st/st_thermal.c                    |   4 +-
 drivers/thermal/st/st_thermal.h                    |   2 +-
 drivers/thermal/st/st_thermal_memmap.c             |   6 +-
 drivers/thermal/sun8i_thermal.c                    |  59 ++----
 drivers/thermal/tegra/tegra30-tsensor.c            |   3 +-
 drivers/thermal/thermal-generic-adc.c              |   4 +
 drivers/thermal/thermal_core.h                     |   2 +
 drivers/thermal/thermal_hwmon.c                    |   5 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   3 +-
 32 files changed, 690 insertions(+), 295 deletions(-)
