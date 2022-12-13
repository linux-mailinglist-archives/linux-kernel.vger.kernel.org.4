Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E4D64BDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbiLMT4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiLMT4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:56:34 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551112654A;
        Tue, 13 Dec 2022 11:56:33 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id r15so11118753qvm.6;
        Tue, 13 Dec 2022 11:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FF2ytRdyd1k49TJUY72Gw2rCc9xi0XLxuoiI0SmpnD0=;
        b=j9mRwIel76Klzf9yTJlK6M1OeOZN77kBnse0ioGurN9Psiz4UnaG2jfx/R14Ad5Ga1
         0mamCOQpn2JQiYLce/Yf6b0Bt3QPGZIOM8rAylJzVFnQ3r3PEtgibHEg0OmQkWSDQCm5
         N6hjfMUml8cxPVJRh6YOrztpQU2f5KZv/c6Y8W03zC8cTV6Mzkt9kVuKNE9bmHSw6muL
         KFsUFcLXOPXcv8LZ2Q+rSwFOo47e5K8VF2i6prL62UJgXfgoYkTkkyUTP/YnFtqyiPjS
         HNEDrDcqDdisSZ9k5/WJNzpkpe5KCzOqd/Jv17Th+k1SYmibAPCdyt8RvJ5oHsVLE9uf
         bojA==
X-Gm-Message-State: ANoB5pkBlI01z8DbzRV+v6uU92i4QeXe21E3p5JoAGA7m17PHpFcpGoy
        Ifp9j/85sVsU92+94nz2prtV7VpAT2K5IiNhqjk=
X-Google-Smtp-Source: AA0mqf4qoxAT0kzXxvDM80UKPbvt7KNfq48AR5gRJVHJ334HyE4k0x3jE4vGrUQELFgh1CM83GcqazNAskqdrBoLc8k=
X-Received: by 2002:a0c:facd:0:b0:4de:83db:b846 with SMTP id
 p13-20020a0cfacd000000b004de83dbb846mr461608qvo.119.1670961392410; Tue, 13
 Dec 2022 11:56:32 -0800 (PST)
MIME-Version: 1.0
References: <3ccca41f-0899-b205-903b-ec8c742f3e91@linaro.org>
In-Reply-To: <3ccca41f-0899-b205-903b-ec8c742f3e91@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 13 Dec 2022 20:56:21 +0100
Message-ID: <CAJZ5v0j2FvdkxHQqHErV0i7sMyxAnW7gnQwe5s195xLU1aa15A@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers for v6.2-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 6:08 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The following changes since commit 7d4b19ab6b89903fde8ad02f28a8943a4734e7b0:
>
>    Merge Intel thermal control drivers changes for v6.2 (2022-12-02
> 19:39:07 +0100)
>
> are available in the Git repository at:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.2-rc1
>
> for you to fetch changes up to f3ce48d06440a712de3c5ef1d26003c1e77afd74:
>
>    Revert "thermal/sysfs: Remove unnecessary check in
> trip_point_hyst_show()" (2022-12-09 16:23:16 +0100)
>
> ----------------------------------------------------------------
> - Rework a large bunch of drivers to use the generic thermal trip
>    structure and the opportunity to do more cleanups by removing unused
>    functions in the OF code (Daniel Lezcano)
>
> - Add the sm8450 QCom compatible string in the DT bindings (Luca
>    Weiss)
>
> - Use devm_platform_get_and_ioremap_resource on the ST platform to
>    group two calls into a single one (Minghao Chi)
>
> - Add the sm8550 QCom compatible string in the DT bindings (Neil
>    Armstrong)
>
> - Use GENMASK instead of bitmaps and validate the temperature after
>    reading it (Marcus Folkesson)
>
> - Convert generic-adc-thermal to DT schema (Rob Herring)
>
> - Fix the debug print message where the logic is inverted (Keerthy)
>
> - Fix NULL pointer dereference when getting the critical temp (Daniel
>    Lezcano)
>
> - Fix memory leak on thermal_of_zone_register() failure (Ido Schimmel)
>
> - Add support for IPQ8074 in the tsens driver along with the DT
>    bindings (Robert Marko)
>
> - Fix and rework the debugfs code in the tsens driver (Christian
>    Marangi)
>
> - Add calibration and DT documentation for the imx8mm driver (Marek
>    Vasut)
>
> - Add DT bindings and compatible for the Mediatek SoCs mt7981 and
>    mt7983 (Daniel Golle)
>
> - Don't show an error message if it happens at probe time while it
>    will be deferred on the QCom SPMI ADC driver (Johan Hovold)
>
> - Add the HWMon support on the imx8mm board (Alexander Stein)
>
> - Remove a pointless include in the power allocator governor
>    (Christophe JAILLET)
>
> - Add interrupt DT bindings for QCom SoCs SC8280XP, SM6350 and SM8450
>    (Krzysztof Kozlowski)
>
> - Fix inaccurate warning message for the QCom tsens gen2 (Luca Weiss)
>
> - Demote error log of thermal zone register to debug on the tsens QCom
>    driver (Manivannan Sadhasivam)
>
> - Consolidate the TI Bandgap driver regarding how is handled the efuse
>    values and the errata handling (Bryan Brattlof)
>
> - Document the Renesas RZ/Five as compatible with RZ/G2UL in the DT
>    bindings (Lad Prabhakar)
>
> - Fix the irq handler return value in the LMh driver (Bjorn Andersson)
>
> ----------------------------------------------------------------
> Alexander Stein (1):
>        thermal/drivers/imx8mm: Add hwmon support
>
> Bjorn Andersson (1):
>        thermal/drivers/qcom/lmh: Fix irq handler return value
>
> Bryan Brattlof (6):
>        thermal/drivers/k3_j72xx_bandgap: Simplify k3_thermal_get_temp()
> function
>        thermal/drivers/k3_j72xx_bandgap: Use bool for i2128 erratum flag
>        thermal/drivers/k3_j72xx_bandgap: Remove fuse_base from structure
>        thermal/drivers/k3_j72xx_bandgap: Map fuse_base only for erratum
> workaround
>        dt-bindings: thermal: k3-j72xx: elaborate on binding description
>        dt-bindings: thermal: k3-j72xx: conditionally require efuse reg range
>
> Christian Marangi (3):
>        thermal/drivers/qcom/tsens: Init debugfs only with successful probe
>        thermal/drivers/qcom/tsens: Fix wrong version id dbg_version_show
>        thermal/drivers/qcom/tsens: Rework debugfs file structure
>
> Christophe JAILLET (1):
>        thermal/core/power allocator: Remove a useless include
>
> Dan Carpenter (1):
>        thermal/sysfs: remove unnecessary check in trip_point_hyst_show()
>
> Daniel Golle (1):
>        dt-bindings: thermal: mediatek: add compatible string for MT7986
> and MT7981 SoC
>
> Daniel Lezcano (33):
>        thermal/core: Add a generic thermal_zone_get_trip() function
>        thermal/sysfs: Always expose hysteresis attributes
>        thermal/core: Add a generic thermal_zone_set_trip() function
>        thermal/core/governors: Use thermal_zone_get_trip() instead of
> ops functions
>        thermal/of: Use generic thermal_zone_get_trip() function
>        thermal/of: Remove unused functions
>        thermal/drivers/exynos: Use generic thermal_zone_get_trip() function
>        thermal/drivers/exynos: of_thermal_get_ntrips()
>        thermal/drivers/exynos: Replace of_thermal_is_trip_valid() by
> thermal_zone_get_trip()
>        thermal/drivers/tegra: Use generic thermal_zone_get_trip() function
>        thermal/drivers/uniphier: Use generic thermal_zone_get_trip()
> function
>        thermal/drivers/hisi: Use generic thermal_zone_get_trip() function
>        thermal/drivers/qcom: Use generic thermal_zone_get_trip() function
>        thermal/drivers/armada: Use generic thermal_zone_get_trip() function
>        thermal/drivers/rcar_gen3: Use the generic function to get the
> number of trips
>        thermal/of: Remove of_thermal_get_ntrips()
>        thermal/of: Remove of_thermal_is_trip_valid()
>        thermal/of: Remove of_thermal_set_trip_hyst()
>        thermal/of: Remove of_thermal_get_crit_temp()
>        thermal/drivers/st: Use generic trip points
>        thermal/drivers/imx: Use generic thermal_zone_get_trip() function
>        thermal/drivers/rcar: Use generic thermal_zone_get_trip() function
>        thermal/drivers/broadcom: Use generic thermal_zone_get_trip()
> function
>        thermal/drivers/da9062: Use generic thermal_zone_get_trip() function
>        thermal/drivers/ti: Remove unused macros
> ti_thermal_get_trip_value() / ti_thermal_trip_is_valid()
>        thermal/drivers/acerhdf: Use generic thermal_zone_get_trip() function
>        thermal/drivers/cxgb4: Use generic thermal_zone_get_trip() function
>        thermal/intel/int340x: Replace parameter to simplify
>        thermal/drivers/intel: Use generic thermal_zone_get_trip() function
>        thermal/drivers/exynos: Fix NULL pointer dereference when getting
> the critical temp
>        wifi: iwlwifi: Use generic thermal_zone_get_trip() function
>        thermal/drivers/mellanox: Use generic thermal_zone_get_trip()
> function
>        Revert "thermal/sysfs: Remove unnecessary check in
> trip_point_hyst_show()"
>
> Geert Uytterhoeven (1):
>        thermal: ti-soc-thermal: Drop comma after SoC match table sentinel
>
> Ido Schimmel (1):
>        thermal/of: Fix memory leak on thermal_of_zone_register() failure
>
> Johan Hovold (1):
>        thermal: qcom-spmi-adc-tm5: suppress probe-deferral error message
>
> Jon Hunter (1):
>        thermal/drivers/tegra: Fix crash when getting critical temp
>
> Keerthy (1):
>        thermal/drivers/k3_j72xx_bandgap: Fix the debug print message
>
> Krzysztof Kozlowski (1):
>        dt-bindings: thermal: qcom-tsens: narrow interrupts for SC8280XP,
> SM6350 and SM8450
>
> Lad Prabhakar (1):
>        dt-bindings: thermal: rzg2l-thermal: Document RZ/Five SoC
>
> Luca Weiss (2):
>        dt-bindings: thermal: tsens: Add sm8450 compatible
>        thermal/drivers/qcom/temp-alarm: Fix inaccurate warning for gen2
>
> Manivannan Sadhasivam (1):
>        thermal/drivers/qcom: Demote error log of thermal zone register
> to debug
>
> Marcus Folkesson (2):
>        thermal/drivers/imx8mm_thermal: Use GENMASK() when appropriate
>        thermal/drivers/imx8mm_thermal: Validate temperature range
>
> Marek Vasut (2):
>        dt-bindings: thermal: imx8mm-thermal: Document optional nvmem-cells
>        thermal/drivers/imx: Add support for loading calibration data
> from OCOTP
>
> Minghao Chi (1):
>        thermal/drivers/st: Use devm_platform_get_and_ioremap_resource()
>
> Neil Armstrong (1):
>        dt-bindings: thermal: qcom-tsens: Add compatible for sm8550
>
> Rob Herring (1):
>        dt-bindings: thermal: Convert generic-adc-thermal to DT schema
>
> Robert Marko (4):
>        dt-bindings: thermal: tsens: Add ipq8074 compatible
>        thermal/drivers/tsens: Add support for combined interrupt
>        thermal/drivers/tsens: Allow configuring min and max trips
>        thermal/drivers/tsens: Add IPQ8074 support
>
>   .../bindings/thermal/generic-adc-thermal.yaml      |  84 +++++++++
>   .../bindings/thermal/imx8mm-thermal.yaml           |   7 +
>   .../bindings/thermal/mediatek-thermal.txt          |   2 +
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    |  81 ++++++--
>   .../devicetree/bindings/thermal/rzg2l-thermal.yaml |   2 +-
>   .../bindings/thermal/thermal-generic-adc.txt       |  95 ----------
>   .../bindings/thermal/ti,j72xx-thermal.yaml         |  35 +++-
>   drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |   2 -
>   drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c |  39 +---
>   drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 209
> +++++----------------
>   drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   2 +-
>   drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |  71 ++-----
>   drivers/platform/x86/acerhdf.c                     |  73 +++----
>   drivers/thermal/armada_thermal.c                   |  37 ++--
>   drivers/thermal/broadcom/bcm2835_thermal.c         |   8 +-
>   drivers/thermal/da9062-thermal.c                   |  52 +----
>   drivers/thermal/gov_bang_bang.c                    |  37 ++--
>   drivers/thermal/gov_fair_share.c                   |  18 +-
>   drivers/thermal/gov_power_allocator.c              |  52 +++--
>   drivers/thermal/gov_step_wise.c                    |  22 +--
>   drivers/thermal/hisi_thermal.c                     |  11 +-
>   drivers/thermal/imx8mm_thermal.c                   | 180
> +++++++++++++++++-
>   drivers/thermal/imx_thermal.c                      |  72 +++----
>   .../intel/int340x_thermal/int340x_thermal_zone.c   |  33 ++--
>   .../intel/int340x_thermal/int340x_thermal_zone.h   |   4 +-
>   .../int340x_thermal/processor_thermal_device.c     |  10 +-
>   drivers/thermal/intel/x86_pkg_temp_thermal.c       | 120 ++++++------
>   drivers/thermal/k3_j72xx_bandgap.c                 |  67 +++----
>   drivers/thermal/qcom/lmh.c                         |   2 +-
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   8 +-
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |  42 ++---
>   drivers/thermal/qcom/tsens-8960.c                  |   3 +
>   drivers/thermal/qcom/tsens-v0_1.c                  |   3 +
>   drivers/thermal/qcom/tsens-v1.c                    |   3 +
>   drivers/thermal/qcom/tsens-v2.c                    |  20 ++
>   drivers/thermal/qcom/tsens.c                       |  68 ++++---
>   drivers/thermal/qcom/tsens.h                       |   8 +-
>   drivers/thermal/rcar_gen3_thermal.c                |   2 +-
>   drivers/thermal/rcar_thermal.c                     |  53 +-----
>   drivers/thermal/samsung/exynos_tmu.c               |  62 +++---
>   drivers/thermal/st/st_thermal.c                    |  47 +----
>   drivers/thermal/st/stm_thermal.c                   |   4 +-
>   drivers/thermal/tegra/soctherm.c                   |  35 ++--
>   drivers/thermal/tegra/tegra30-tsensor.c            |  17 +-
>   drivers/thermal/thermal_core.c                     | 153 ++++++++++++---
>   drivers/thermal/thermal_core.h                     |  24 +--
>   drivers/thermal/thermal_helpers.c                  |  28 +--
>   drivers/thermal/thermal_netlink.c                  |  19 +-
>   drivers/thermal/thermal_of.c                       | 124 +-----------
>   drivers/thermal/thermal_sysfs.c                    | 135 +++++--------
>   drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   2 +-
>   drivers/thermal/ti-soc-thermal/ti-thermal.h        |  15 --
>   drivers/thermal/uniphier_thermal.c                 |  27 ++-
>   include/linux/thermal.h                            |  10 +
>   54 files changed, 1115 insertions(+), 1224 deletions(-)
>   create mode 100644
> Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
>   delete mode 100644
> Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt

Pulled and added to my linux-next branch, thanks!
