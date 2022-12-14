Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674A664CDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbiLNQUj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Dec 2022 11:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbiLNQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:20:29 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1560F2714A;
        Wed, 14 Dec 2022 08:20:28 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id o12so134018qvn.3;
        Wed, 14 Dec 2022 08:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NqkOZnEyvgjN6xlmzVF5U8QXetoO5CNLKt1YD0M/UA=;
        b=FUAmN/H4It5JV6DeUea+ye1KywuzPqjJxprXIFgsXSgIAIV1MiyUPMmrSQqNZRDbp4
         mqP+EujwP6iGrSa42pGplYRoL4wXn0IWyp56gI0zonprSEfqwQG+ZxnWFaV1tw+NgPMJ
         ytKTkV7IwMc9UADTS9EjsnnxfoTJeyXDZtbIWZscx2Xk8MG3OcG8xO+A10r2thHxdWwk
         xtcTvn06yy7Wxw2Z95xAsuifoZUoVhsIVvZRA8NoGYsQQPzwHjxcZCHGT8ULMVTjcCIB
         z4kmeEQeGQcO787Xsi/Yf5iVNgWzlD1wHr4MohEdCF1tAAgVWc4enAksztRkJZ0jbSLP
         7FYw==
X-Gm-Message-State: ANoB5plsqiQmOjJQlm11oWxVgb+QswjbAur+qCZMNMXXF5JwIdc66q2n
        +3RzhnjctlmMPnmx+fjAU/juFiApd8vFddkaqcA=
X-Google-Smtp-Source: AA0mqf50YFLTVk93hEBTlm+9JQosRaGGHy2qUm3mxeKl+cLxeyTTW2XsgKUzPsuZUYWy0u46SIR+eE2bip3ZZfo6mr0=
X-Received: by 2002:ad4:534b:0:b0:4b1:8429:a8a7 with SMTP id
 v11-20020ad4534b000000b004b18429a8a7mr69967228qvs.52.1671034827138; Wed, 14
 Dec 2022 08:20:27 -0800 (PST)
MIME-Version: 1.0
References: <ab7e7005-594a-eccd-7435-5dc9034af482@linaro.org>
In-Reply-To: <ab7e7005-594a-eccd-7435-5dc9034af482@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Dec 2022 17:20:16 +0100
Message-ID: <CAJZ5v0i88k66ODYhbZqPwjJG9=LGNt84jG3otf2CQoD5PR1UfQ@mail.gmail.com>
Subject: Re: [GIT PULL][resend] thermal drivers for v6.2-rc1
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
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 4:19 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> please consider pulling the thermal changes for v6.2-rc1 (again).
>
> This PR contains the same changes as the last one but without the
> generic trip point rework where a problem appeared with the locks.
>
> When the series was submitted, the problem was not there but meanwhile
> my absence the commit 05eeee2b51b introduced a lock in the set_trip_temp
> call path. On the other side the lock was also taken by the generic trip
> point work series.
>
> That was not spotted before because these two changes were in different
> branches (thermal/linux-next and linux-pm/thermal) and the merge
> resulted in this lock conflict.
>
> I was surprised to see the deadlock issue as the series has been tested
> and was in the linux-next branch during a while. Understanding the lock
> issue helped to clarify what happened.
>
> Given it is not a problem to post pone the generic trip rework, it is
> more secure to drop the series from the pull request and make sure there
> is no another subtle changes happening with the locks.
>
> Please note I added a trivial change from Uwe Kleine-König removing an
> empty function [1].
>
> Thanks
>    -- Daniel
>
> [1]
> https://lore.kernel.org/r/20221212220217.3777176-1-u.kleine-koenig@pengutronix.de
>
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
> for you to fetch changes up to 5011a110295d25418f5918a6af7bfcdb00dd4e34:
>
>    thermal/drivers/imx_sc_thermal: Drop empty platform remove function
> (2022-12-14 15:27:30 +0100)
>
> ----------------------------------------------------------------
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
> - Delete platform remove callback as it is empty (Uwe Kleine-König)
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
> Daniel Golle (1):
>        dt-bindings: thermal: mediatek: add compatible string for MT7986
> and MT7981 SoC
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
> Uwe Kleine-König (1):
>        thermal/drivers/imx_sc_thermal: Drop empty platform remove function
>
>   .../bindings/thermal/generic-adc-thermal.yaml      |  84 ++++++++++
>   .../bindings/thermal/imx8mm-thermal.yaml           |   7 +
>   .../bindings/thermal/mediatek-thermal.txt          |   2 +
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    |  81 ++++++++--
>   .../devicetree/bindings/thermal/rzg2l-thermal.yaml |   2 +-
>   .../bindings/thermal/thermal-generic-adc.txt       |  95 -----------
>   .../bindings/thermal/ti,j72xx-thermal.yaml         |  35 +++-
>   drivers/thermal/gov_power_allocator.c              |   1 -
>   drivers/thermal/imx8mm_thermal.c                   | 180
> ++++++++++++++++++++-
>   drivers/thermal/imx_sc_thermal.c                   |   6 -
>   drivers/thermal/k3_j72xx_bandgap.c                 |  67 ++++----
>   drivers/thermal/qcom/lmh.c                         |   2 +-
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   8 +-
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   3 +-
>   drivers/thermal/qcom/tsens-8960.c                  |   3 +
>   drivers/thermal/qcom/tsens-v0_1.c                  |   3 +
>   drivers/thermal/qcom/tsens-v1.c                    |   3 +
>   drivers/thermal/qcom/tsens-v2.c                    |  20 +++
>   drivers/thermal/qcom/tsens.c                       |  68 +++++---
>   drivers/thermal/qcom/tsens.h                       |   8 +-
>   drivers/thermal/st/stm_thermal.c                   |   4 +-
>   drivers/thermal/thermal_of.c                       |   8 +-
>   drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   2 +-
>   23 files changed, 506 insertions(+), 186 deletions(-)
>   create mode 100644
> Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
>   delete mode 100644
> Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt

Pulled and added to my linux-next branch, thank you!
