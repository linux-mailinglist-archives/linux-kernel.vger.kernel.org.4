Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85206648759
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiLIRJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLIRJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:09:04 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8802A15FCE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:08:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u12so5819453wrr.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RheTipnQ3FDrtTGK6Np18Wan6gzAfSArggbEI3Dq53k=;
        b=zWgsiFzMpcRPWGKoDVH3cYFEzNOv4VAygMAq5QC4IbDeO+baY+9Dsp7GIqah0AHUQX
         iHSIBEdiAAB3WE+M7F8+RiCgiCP2hlWHXsG4fJPGfS9maavMvsg1c3xQmv9z6sQvvHmO
         eXhtnyyW3iVQp8DQbJM+xF2RQ17Xt7aaSheTwuexnLgcWYiE3gY3515r7YAVeq2DxSRr
         kL9vX0Z6CRPrlnlDo2gg4U3gVZohtDb+oAm53mUfHmWgId7P61AmBMcLyQZnjCcmg0NS
         3oYqtQMsEbZr6e54vpmLVy5Aop5Vw/cMTj6zzF04tGaqQfeMRR2C/r+VclBJ9cXnCI1y
         9npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RheTipnQ3FDrtTGK6Np18Wan6gzAfSArggbEI3Dq53k=;
        b=IGwvtcO9ck/H/YER5ve4QbQvBxZglsQzzatMzPD3gEuigF049X9V88tERFYntEB5VS
         Jo1gyLf8Ub7gYiaq+6gQz4RgirL0D/sfYKBpQ2VCb0Zqd5Cj8UFrpnUuhw2KuBMDLJ+H
         pWAKG01ZP6imrUivKTuVSngk5y36/aXcRQCZDrl8RB8n9ACxFCMrI8vJJiAi+u0YXTgQ
         m82DZyrFsBstQVmn5vveB95E1zmzm3WoGZOKDYKntNH9WHQF0q8JT5mu/g3TE8LEctAo
         u0A3au8UyfKiVsITHzApFmPyC+RN/mFVd+vuyYJDceB+ruqfBUkO97Y/DpPZYwotg+ih
         scRQ==
X-Gm-Message-State: ANoB5pnaDm0Q0WHeEUDAZHI2cC0damDwn1LGHNjWo6s7Lyvzyt77CYSq
        oI4nRSvRs2cXgsIUFo1STvvjjQ==
X-Google-Smtp-Source: AA0mqf43vIOxMkbH0YO61S1oWFrFyWdHAJCsHFjp1CaTcvxmKq8ulp9v0lTjzb60sYAOgcIOYp/yPw==
X-Received: by 2002:a5d:5c11:0:b0:242:704e:c3f8 with SMTP id cc17-20020a5d5c11000000b00242704ec3f8mr5616472wrb.46.1670605714940;
        Fri, 09 Dec 2022 09:08:34 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e20-20020a5d5954000000b0023657e1b980sm1814180wri.53.2022.12.09.09.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 09:08:34 -0800 (PST)
Message-ID: <3ccca41f-0899-b205-903b-ec8c742f3e91@linaro.org>
Date:   Fri, 9 Dec 2022 18:08:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal drivers for v6.2-rc1
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Robert Marko <robimarko@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Johan Hovold <johan@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7d4b19ab6b89903fde8ad02f28a8943a4734e7b0:

   Merge Intel thermal control drivers changes for v6.2 (2022-12-02 
19:39:07 +0100)

are available in the Git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.2-rc1

for you to fetch changes up to f3ce48d06440a712de3c5ef1d26003c1e77afd74:

   Revert "thermal/sysfs: Remove unnecessary check in 
trip_point_hyst_show()" (2022-12-09 16:23:16 +0100)

----------------------------------------------------------------
- Rework a large bunch of drivers to use the generic thermal trip
   structure and the opportunity to do more cleanups by removing unused
   functions in the OF code (Daniel Lezcano)

- Add the sm8450 QCom compatible string in the DT bindings (Luca
   Weiss)

- Use devm_platform_get_and_ioremap_resource on the ST platform to
   group two calls into a single one (Minghao Chi)

- Add the sm8550 QCom compatible string in the DT bindings (Neil
   Armstrong)

- Use GENMASK instead of bitmaps and validate the temperature after
   reading it (Marcus Folkesson)

- Convert generic-adc-thermal to DT schema (Rob Herring)

- Fix the debug print message where the logic is inverted (Keerthy)

- Fix NULL pointer dereference when getting the critical temp (Daniel
   Lezcano)

- Fix memory leak on thermal_of_zone_register() failure (Ido Schimmel)

- Add support for IPQ8074 in the tsens driver along with the DT
   bindings (Robert Marko)

- Fix and rework the debugfs code in the tsens driver (Christian
   Marangi)

- Add calibration and DT documentation for the imx8mm driver (Marek
   Vasut)

- Add DT bindings and compatible for the Mediatek SoCs mt7981 and
   mt7983 (Daniel Golle)

- Don't show an error message if it happens at probe time while it
   will be deferred on the QCom SPMI ADC driver (Johan Hovold)

- Add the HWMon support on the imx8mm board (Alexander Stein)

- Remove a pointless include in the power allocator governor
   (Christophe JAILLET)

- Add interrupt DT bindings for QCom SoCs SC8280XP, SM6350 and SM8450
   (Krzysztof Kozlowski)

- Fix inaccurate warning message for the QCom tsens gen2 (Luca Weiss)

- Demote error log of thermal zone register to debug on the tsens QCom
   driver (Manivannan Sadhasivam)

- Consolidate the TI Bandgap driver regarding how is handled the efuse
   values and the errata handling (Bryan Brattlof)

- Document the Renesas RZ/Five as compatible with RZ/G2UL in the DT
   bindings (Lad Prabhakar)

- Fix the irq handler return value in the LMh driver (Bjorn Andersson)

----------------------------------------------------------------
Alexander Stein (1):
       thermal/drivers/imx8mm: Add hwmon support

Bjorn Andersson (1):
       thermal/drivers/qcom/lmh: Fix irq handler return value

Bryan Brattlof (6):
       thermal/drivers/k3_j72xx_bandgap: Simplify k3_thermal_get_temp() 
function
       thermal/drivers/k3_j72xx_bandgap: Use bool for i2128 erratum flag
       thermal/drivers/k3_j72xx_bandgap: Remove fuse_base from structure
       thermal/drivers/k3_j72xx_bandgap: Map fuse_base only for erratum 
workaround
       dt-bindings: thermal: k3-j72xx: elaborate on binding description
       dt-bindings: thermal: k3-j72xx: conditionally require efuse reg range

Christian Marangi (3):
       thermal/drivers/qcom/tsens: Init debugfs only with successful probe
       thermal/drivers/qcom/tsens: Fix wrong version id dbg_version_show
       thermal/drivers/qcom/tsens: Rework debugfs file structure

Christophe JAILLET (1):
       thermal/core/power allocator: Remove a useless include

Dan Carpenter (1):
       thermal/sysfs: remove unnecessary check in trip_point_hyst_show()

Daniel Golle (1):
       dt-bindings: thermal: mediatek: add compatible string for MT7986 
and MT7981 SoC

Daniel Lezcano (33):
       thermal/core: Add a generic thermal_zone_get_trip() function
       thermal/sysfs: Always expose hysteresis attributes
       thermal/core: Add a generic thermal_zone_set_trip() function
       thermal/core/governors: Use thermal_zone_get_trip() instead of 
ops functions
       thermal/of: Use generic thermal_zone_get_trip() function
       thermal/of: Remove unused functions
       thermal/drivers/exynos: Use generic thermal_zone_get_trip() function
       thermal/drivers/exynos: of_thermal_get_ntrips()
       thermal/drivers/exynos: Replace of_thermal_is_trip_valid() by 
thermal_zone_get_trip()
       thermal/drivers/tegra: Use generic thermal_zone_get_trip() function
       thermal/drivers/uniphier: Use generic thermal_zone_get_trip() 
function
       thermal/drivers/hisi: Use generic thermal_zone_get_trip() function
       thermal/drivers/qcom: Use generic thermal_zone_get_trip() function
       thermal/drivers/armada: Use generic thermal_zone_get_trip() function
       thermal/drivers/rcar_gen3: Use the generic function to get the 
number of trips
       thermal/of: Remove of_thermal_get_ntrips()
       thermal/of: Remove of_thermal_is_trip_valid()
       thermal/of: Remove of_thermal_set_trip_hyst()
       thermal/of: Remove of_thermal_get_crit_temp()
       thermal/drivers/st: Use generic trip points
       thermal/drivers/imx: Use generic thermal_zone_get_trip() function
       thermal/drivers/rcar: Use generic thermal_zone_get_trip() function
       thermal/drivers/broadcom: Use generic thermal_zone_get_trip() 
function
       thermal/drivers/da9062: Use generic thermal_zone_get_trip() function
       thermal/drivers/ti: Remove unused macros 
ti_thermal_get_trip_value() / ti_thermal_trip_is_valid()
       thermal/drivers/acerhdf: Use generic thermal_zone_get_trip() function
       thermal/drivers/cxgb4: Use generic thermal_zone_get_trip() function
       thermal/intel/int340x: Replace parameter to simplify
       thermal/drivers/intel: Use generic thermal_zone_get_trip() function
       thermal/drivers/exynos: Fix NULL pointer dereference when getting 
the critical temp
       wifi: iwlwifi: Use generic thermal_zone_get_trip() function
       thermal/drivers/mellanox: Use generic thermal_zone_get_trip() 
function
       Revert "thermal/sysfs: Remove unnecessary check in 
trip_point_hyst_show()"

Geert Uytterhoeven (1):
       thermal: ti-soc-thermal: Drop comma after SoC match table sentinel

Ido Schimmel (1):
       thermal/of: Fix memory leak on thermal_of_zone_register() failure

Johan Hovold (1):
       thermal: qcom-spmi-adc-tm5: suppress probe-deferral error message

Jon Hunter (1):
       thermal/drivers/tegra: Fix crash when getting critical temp

Keerthy (1):
       thermal/drivers/k3_j72xx_bandgap: Fix the debug print message

Krzysztof Kozlowski (1):
       dt-bindings: thermal: qcom-tsens: narrow interrupts for SC8280XP, 
SM6350 and SM8450

Lad Prabhakar (1):
       dt-bindings: thermal: rzg2l-thermal: Document RZ/Five SoC

Luca Weiss (2):
       dt-bindings: thermal: tsens: Add sm8450 compatible
       thermal/drivers/qcom/temp-alarm: Fix inaccurate warning for gen2

Manivannan Sadhasivam (1):
       thermal/drivers/qcom: Demote error log of thermal zone register 
to debug

Marcus Folkesson (2):
       thermal/drivers/imx8mm_thermal: Use GENMASK() when appropriate
       thermal/drivers/imx8mm_thermal: Validate temperature range

Marek Vasut (2):
       dt-bindings: thermal: imx8mm-thermal: Document optional nvmem-cells
       thermal/drivers/imx: Add support for loading calibration data 
from OCOTP

Minghao Chi (1):
       thermal/drivers/st: Use devm_platform_get_and_ioremap_resource()

Neil Armstrong (1):
       dt-bindings: thermal: qcom-tsens: Add compatible for sm8550

Rob Herring (1):
       dt-bindings: thermal: Convert generic-adc-thermal to DT schema

Robert Marko (4):
       dt-bindings: thermal: tsens: Add ipq8074 compatible
       thermal/drivers/tsens: Add support for combined interrupt
       thermal/drivers/tsens: Allow configuring min and max trips
       thermal/drivers/tsens: Add IPQ8074 support

  .../bindings/thermal/generic-adc-thermal.yaml      |  84 +++++++++
  .../bindings/thermal/imx8mm-thermal.yaml           |   7 +
  .../bindings/thermal/mediatek-thermal.txt          |   2 +
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |  81 ++++++--
  .../devicetree/bindings/thermal/rzg2l-thermal.yaml |   2 +-
  .../bindings/thermal/thermal-generic-adc.txt       |  95 ----------
  .../bindings/thermal/ti,j72xx-thermal.yaml         |  35 +++-
  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |   2 -
  drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c |  39 +---
  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 209 
+++++----------------
  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   2 +-
  drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |  71 ++-----
  drivers/platform/x86/acerhdf.c                     |  73 +++----
  drivers/thermal/armada_thermal.c                   |  37 ++--
  drivers/thermal/broadcom/bcm2835_thermal.c         |   8 +-
  drivers/thermal/da9062-thermal.c                   |  52 +----
  drivers/thermal/gov_bang_bang.c                    |  37 ++--
  drivers/thermal/gov_fair_share.c                   |  18 +-
  drivers/thermal/gov_power_allocator.c              |  52 +++--
  drivers/thermal/gov_step_wise.c                    |  22 +--
  drivers/thermal/hisi_thermal.c                     |  11 +-
  drivers/thermal/imx8mm_thermal.c                   | 180 
+++++++++++++++++-
  drivers/thermal/imx_thermal.c                      |  72 +++----
  .../intel/int340x_thermal/int340x_thermal_zone.c   |  33 ++--
  .../intel/int340x_thermal/int340x_thermal_zone.h   |   4 +-
  .../int340x_thermal/processor_thermal_device.c     |  10 +-
  drivers/thermal/intel/x86_pkg_temp_thermal.c       | 120 ++++++------
  drivers/thermal/k3_j72xx_bandgap.c                 |  67 +++----
  drivers/thermal/qcom/lmh.c                         |   2 +-
  drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   8 +-
  drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |  42 ++---
  drivers/thermal/qcom/tsens-8960.c                  |   3 +
  drivers/thermal/qcom/tsens-v0_1.c                  |   3 +
  drivers/thermal/qcom/tsens-v1.c                    |   3 +
  drivers/thermal/qcom/tsens-v2.c                    |  20 ++
  drivers/thermal/qcom/tsens.c                       |  68 ++++---
  drivers/thermal/qcom/tsens.h                       |   8 +-
  drivers/thermal/rcar_gen3_thermal.c                |   2 +-
  drivers/thermal/rcar_thermal.c                     |  53 +-----
  drivers/thermal/samsung/exynos_tmu.c               |  62 +++---
  drivers/thermal/st/st_thermal.c                    |  47 +----
  drivers/thermal/st/stm_thermal.c                   |   4 +-
  drivers/thermal/tegra/soctherm.c                   |  35 ++--
  drivers/thermal/tegra/tegra30-tsensor.c            |  17 +-
  drivers/thermal/thermal_core.c                     | 153 ++++++++++++---
  drivers/thermal/thermal_core.h                     |  24 +--
  drivers/thermal/thermal_helpers.c                  |  28 +--
  drivers/thermal/thermal_netlink.c                  |  19 +-
  drivers/thermal/thermal_of.c                       | 124 +-----------
  drivers/thermal/thermal_sysfs.c                    | 135 +++++--------
  drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   2 +-
  drivers/thermal/ti-soc-thermal/ti-thermal.h        |  15 --
  drivers/thermal/uniphier_thermal.c                 |  27 ++-
  include/linux/thermal.h                            |  10 +
  54 files changed, 1115 insertions(+), 1224 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
  delete mode 100644 
Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
