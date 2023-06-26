Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D473E362
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFZPdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjFZPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:33:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C9510DC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:33:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fb10fd9ae9so7271205e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687793583; x=1690385583;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF49C2KyWhaD0aCZs4JSkQfR5O3+HuaVU0df0tQjSsM=;
        b=CWg4RftvygJKuDkNmRSNndz3/YjPDNo5JP6hp/UK06XiuiMvD5KxDyaylKc9alcHm/
         hei5LHE33rmzvqBw5fNEED0ITSXZPVq+axeB1QKHDaSLh5m/ziNRYoZ/rGczXedRGrMc
         cVt5YY4C4LfRHKhiT8hhqi5fMPLjkOe6FZ9DncmsqY6nwi4wlBKVc5ssZa5HAO/pWUqh
         gLQ17ZGBQL3Q4g+eETR+cz2FvdNC4IYxqI5DJ/OukkyrN9PH4Nt2qWd5bXrzjCaHTnBd
         jJflDxT+6dz/EYK+75Ota4o730LZGMy43wvobs4Q+2hYrt8vJeCSMfYfQfe5p8LqtAWs
         1LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793583; x=1690385583;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JF49C2KyWhaD0aCZs4JSkQfR5O3+HuaVU0df0tQjSsM=;
        b=b2EMpNTEnq8pk2QUEiQm7UMw0SUQSASIqextb1++7fZyZiwaRakIAURJMriDBOYXnA
         N4+BJvTD53KC7VCY3ey/ygutR+GqXI3ilWmllSo0DI4v4vDxN3xAsjstsQoU97EnItCq
         jRzi9aZRO8y+U8zwRZvrQy9qo3ZoFd5L92WF0xQ+tsol0VEuN3NTK+V8FlUjXtYsVIUx
         Zhj5Ue5FKn0fu7KlUc4jp5wFEANoWsyEJs6W+91x0mZJTINPvhZGAOSz4ltfUBkfzB3j
         2rXHhs4s97AgZhZ2DQaMDHoXEo+GD55HMse6G026mWA0K0N7z02ngNlS0HywSXejgcZn
         WfTg==
X-Gm-Message-State: AC+VfDxXzdlIzm9WoMnJyEaU/3oFdZFmpsa1J6cKokRA5Vcxylw9Gy9E
        Y5HPWKDYCVmWkxBivkoOEAdwxA==
X-Google-Smtp-Source: ACHHUZ7eEDZjLD6fNvt4DGX/qatJc+bCceJKDl9YGYk/i8s1F+AGUOP3IqhwEtLpnGOzWrgGPdZsJA==
X-Received: by 2002:a7b:c5d9:0:b0:3f7:f45d:5e44 with SMTP id n25-20020a7bc5d9000000b003f7f45d5e44mr20071203wmk.32.1687793583487;
        Mon, 26 Jun 2023 08:33:03 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 7-20020a05600c230700b003fa968e9c27sm3299283wmo.9.2023.06.26.08.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 08:33:03 -0700 (PDT)
Message-ID: <47423e79-8a68-87c3-c357-6d67c0653adf@linaro.org>
Date:   Mon, 26 Jun 2023 17:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v6.5-rc1
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        Praveenkumar I <quic_ipkumar@quicinc.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Thierry Reding <treding@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Peng Fan <peng.fan@nxp.com>,
        Alex Leibovich <alexl@marvell.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>, Luca Weiss <luca@z3ntu.xyz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

please consider the following changes since commit 
0bb619f9227aa370330d2b309733d74750705053:

   thermal/intel/intel_soc_dts_iosf: Fix reporting wrong temperatures 
(2023-06-15 18:07:48 +0200)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.5-rc1

for you to fetch changes up to 57c9eaa4de537e6f08819d9214de502cac5a989c:

   thermal/drivers/qcom/temp-alarm: Use dev_err_probe (2023-06-26 
12:10:22 +0200)

----------------------------------------------------------------
- Add DT bindings for SM6375, MSM8226 and QCM2290 Qcom platforms (Konrad
   Dybcio)

- Add DT bindings and support for QCom MSM8226 (Matti Lehtimäki)

- Add DT bindings for QCom ipq9574 (Praveenkumar I)

- Convert bcm2835 DT bindings to the yaml schema (Stefan Wahren)

- Allow selecting the bang-bang governor as default (Thierry Reding)

- Refactor and prepare the code to set the scene for RCar Gen4
   (Wolfram Sang)

- Cleanup and fixes for the QCom tsens drivers. Add DT bindings and
   calibration for the MSM8909 platform (Stephan Gerhold)

- Revert a patch introducing a wrong usage of devm_of_iomap() on the
   Mediatek platform (Ricardo Cañuelo)

- Fix the clock vs reset ordering in order to conform to the
   documentation on the sun8i (Christophe JAILLET)

- Prevent setting up undocumented registers, enable the only described
   sensors and add the version 2.1 on the Qoriq sensor (Peng Fan)

- Add DT bindings and support for the Armada AP807 (Alex Leibovich)

- Update the mlx5 driver with the recent thermal changes (Daniel
   Lezcano)

- Convert to platform remove callback returning void on STM32 (Uwe
   Kleine-König)

- Add an error information printing for devm_thermal_add_hwmon_sysfs()
   and remove the error from the Sun8i, Amlogic, i.MX, TI, K3, Tegra,
   Qoriq, Mediateka and QCom (Yangtao Li)

- Register as hwmon sensor for the Generic ADC (Chen-Yu Tsai)

- Use the dev_err_probe() function in the QCom tsens alarm driver
   (Luca Weiss)

----------------------------------------------------------------
Alex Leibovich (2):
       dt-bindings: armada-thermal: Add armada-ap807-thermal compatible
       thermal/drivers/armada: Add support for AP807 thermal data

Chen-Yu Tsai (2):
       thermal/drivers/mediatek/lvts_thermal: Register thermal zones as 
hwmon sensors
       thermal/drivers/generic-adc: Register thermal zones as hwmon sensors

Christophe JAILLET (1):
       thermal/drivers/sun8i: Fix some error handling paths in 
sun8i_ths_probe()

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
       thermal/drivers/stm32: Convert to platform remove callback 
returning void

Wolfram Sang (3):
       drivers/thermal/rcar_gen3_thermal: introduce 'info' structure
       drivers/thermal/rcar_gen3_thermal: refactor reading fuses into 
seprarate function
       drivers/thermal/rcar_gen3_thermal: add reading fuses for Gen4

Yangtao Li (10):
       thermal/hwmon: Add error information printing for 
devm_thermal_add_hwmon_sysfs()
       thermal/drivers/sun8i: Remove redundant msg in sun8i_ths_register()
       thermal/drivers/amlogic: Remove redundant msg in 
amlogic_thermal_probe()
       thermal/drivers/imx: Remove redundant msg in imx8mm_tmu_probe() 
and imx_sc_thermal_probe()
       drivers/thermal/k3: Remove redundant msg in k3_bandgap_probe()
       thermal/drivers/tegra: Remove redundant msg in 
tegra_tsensor_register_channel()
       thermal/drivers/qoriq: Remove redundant msg in 
qoriq_tmu_register_tmu_zone()
       thermal/drivers/ti-soc: Remove redundant msg in 
ti_thermal_expose_sensor()
       thermal/drivers/qcom: Remove redundant msg at probe time
       thermal/drivers/mediatek/lvts_thermal: Remove redundant msg in 
lvts_ctrl_start()

  .../devicetree/bindings/thermal/armada-thermal.txt |   1 +
  .../bindings/thermal/brcm,bcm2835-thermal.txt      |  41 ------
  .../bindings/thermal/brcm,bcm2835-thermal.yaml     |  48 +++++++
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |  32 ++---
  drivers/net/ethernet/mellanox/mlx5/core/thermal.c  |  15 ++-
  drivers/thermal/Kconfig                            |   8 ++
  drivers/thermal/amlogic_thermal.c                  |   3 +-
  drivers/thermal/armada_thermal.c                   |  32 ++++-
  drivers/thermal/imx8mm_thermal.c                   |   3 +-
  drivers/thermal/imx_sc_thermal.c                   |   3 +-
  drivers/thermal/k3_bandgap.c                       |   3 +-
  drivers/thermal/mediatek/auxadc_thermal.c          |  14 +-
  drivers/thermal/mediatek/lvts_thermal.c            |   4 +
  drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   4 +-
  drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |  38 +++---
  drivers/thermal/qcom/tsens-v0_1.c                  | 126 
++++++++++++------
  drivers/thermal/qcom/tsens-v1.c                    |  22 ----
  drivers/thermal/qcom/tsens.c                       |  26 +++-
  drivers/thermal/qcom/tsens.h                       |   6 +-
  drivers/thermal/qoriq_thermal.c                    |  52 ++++----
  drivers/thermal/rcar_gen3_thermal.c                | 141 
+++++++++++++++------
  drivers/thermal/st/st_thermal.c                    |   4 +-
  drivers/thermal/st/st_thermal.h                    |   2 +-
  drivers/thermal/st/st_thermal_memmap.c             |   6 +-
  drivers/thermal/sun8i_thermal.c                    |  59 +++------
  drivers/thermal/tegra/tegra30-tsensor.c            |   3 +-
  drivers/thermal/thermal-generic-adc.c              |   4 +
  drivers/thermal/thermal_core.h                     |   2 +
  drivers/thermal/thermal_hwmon.c                    |   5 +-
  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   3 +-
  30 files changed, 415 insertions(+), 295 deletions(-)
  delete mode 100644 
Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
  create mode 100644 
Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.yaml

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
