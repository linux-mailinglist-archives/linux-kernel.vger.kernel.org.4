Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4448964CCF3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbiLNPT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLNPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:19:25 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED181146C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:19:24 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so10833255wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mbKCBo2UJJd6vmfSyM6UGB92s9H0LLOHg9t5nwtMIQ=;
        b=LNb4EXa+m3OftUmzbRJZDPQiS2P9iVz8Qbh5hVpJ/iBBkxEDwPFlCxxlHBPhlr10YB
         6zFzXtfRxbdiTbtE6Lqp3cyDKfkVdiXxfdOdILo5Ec8tR1DenhO+u9GWnxw3++j5RKhJ
         o8WZzHcz91bl9zAXQ1rXABdPy4ey9rQS/wmYK3rTuKsC9DlJkpGiZWe3tb16csvsF9r0
         dN1MUMMsY1nLaNINlhDEpz+v3leGbE4whzYA27TsuvXg3oQsxi6A+61owTKXuISM2ZTd
         +S7LcA22NGC3mMqa5F0jc77RChFtNanSt2KOYfM5W3ZcCtyV4HFR2Rx7iI6e91TgG2Qn
         aL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/mbKCBo2UJJd6vmfSyM6UGB92s9H0LLOHg9t5nwtMIQ=;
        b=xyiaQf8ULSk5x+cD5g9UnFQTgvnMkhTqk5+WB1e+pFQhf01jHxfJnmHyOzkSyCVKld
         5WF0+6U5XYRS/a5go051vEXlgg1Dw3pAE5CwNJRX9wsOeOaLiHnzv7IOyAjwe9apPKWu
         fwexEro/lC6ziQDa7LzMP0zm/wRrXUp/hMYpOoi6FyQ1ymWvV5Jfcb9gvFkEWrcVVI63
         ltk40yGuGmQr3w01iWWytPyzsbuujgsMA4Gufx5tRd7YJ382duhJuBin95tH7+0q4BsQ
         Y0osrS7Mz2Ow8up1fnVSa1kKj6hKIwVYDYglN7EmfE1PBAzJl25JdJIu2EqLJgHEJ/e5
         TJTA==
X-Gm-Message-State: ANoB5pl8GPFVQjQkmXZ+GbQIoW5FhjxGB4UTbfJBgs0OKz4Fnxh4ko89
        qEnWfZTYoZ0/PTmpofTswUGY4Q==
X-Google-Smtp-Source: AA0mqf4fV+sUDilc9pJy6AUbhF8Ceksa2WvhSKAwSekANGWztEfaPVvG5pUMW5WL1pn6aE5/AUp6Hw==
X-Received: by 2002:a05:600c:1d02:b0:3cf:6d9a:7b1f with SMTP id l2-20020a05600c1d0200b003cf6d9a7b1fmr19604174wms.32.1671031162432;
        Wed, 14 Dec 2022 07:19:22 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id x13-20020a5d60cd000000b00241e8d00b79sm3817849wrt.54.2022.12.14.07.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 07:19:21 -0800 (PST)
Message-ID: <ab7e7005-594a-eccd-7435-5dc9034af482@linaro.org>
Date:   Wed, 14 Dec 2022 16:19:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL][resend] thermal drivers for v6.2-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Content-Language: en-US
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


Hi Rafael,

please consider pulling the thermal changes for v6.2-rc1 (again).

This PR contains the same changes as the last one but without the 
generic trip point rework where a problem appeared with the locks.

When the series was submitted, the problem was not there but meanwhile 
my absence the commit 05eeee2b51b introduced a lock in the set_trip_temp 
call path. On the other side the lock was also taken by the generic trip 
point work series.

That was not spotted before because these two changes were in different 
branches (thermal/linux-next and linux-pm/thermal) and the merge 
resulted in this lock conflict.

I was surprised to see the deadlock issue as the series has been tested 
and was in the linux-next branch during a while. Understanding the lock 
issue helped to clarify what happened.

Given it is not a problem to post pone the generic trip rework, it is 
more secure to drop the series from the pull request and make sure there 
is no another subtle changes happening with the locks.

Please note I added a trivial change from Uwe Kleine-König removing an 
empty function [1].

Thanks
   -- Daniel

[1] 
https://lore.kernel.org/r/20221212220217.3777176-1-u.kleine-koenig@pengutronix.de


The following changes since commit 7d4b19ab6b89903fde8ad02f28a8943a4734e7b0:

   Merge Intel thermal control drivers changes for v6.2 (2022-12-02 
19:39:07 +0100)

are available in the Git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.2-rc1

for you to fetch changes up to 5011a110295d25418f5918a6af7bfcdb00dd4e34:

   thermal/drivers/imx_sc_thermal: Drop empty platform remove function 
(2022-12-14 15:27:30 +0100)

----------------------------------------------------------------
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

- Delete platform remove callback as it is empty (Uwe Kleine-König)

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

Daniel Golle (1):
       dt-bindings: thermal: mediatek: add compatible string for MT7986 
and MT7981 SoC

Geert Uytterhoeven (1):
       thermal: ti-soc-thermal: Drop comma after SoC match table sentinel

Ido Schimmel (1):
       thermal/of: Fix memory leak on thermal_of_zone_register() failure

Johan Hovold (1):
       thermal: qcom-spmi-adc-tm5: suppress probe-deferral error message

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

Uwe Kleine-König (1):
       thermal/drivers/imx_sc_thermal: Drop empty platform remove function

  .../bindings/thermal/generic-adc-thermal.yaml      |  84 ++++++++++
  .../bindings/thermal/imx8mm-thermal.yaml           |   7 +
  .../bindings/thermal/mediatek-thermal.txt          |   2 +
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |  81 ++++++++--
  .../devicetree/bindings/thermal/rzg2l-thermal.yaml |   2 +-
  .../bindings/thermal/thermal-generic-adc.txt       |  95 -----------
  .../bindings/thermal/ti,j72xx-thermal.yaml         |  35 +++-
  drivers/thermal/gov_power_allocator.c              |   1 -
  drivers/thermal/imx8mm_thermal.c                   | 180 
++++++++++++++++++++-
  drivers/thermal/imx_sc_thermal.c                   |   6 -
  drivers/thermal/k3_j72xx_bandgap.c                 |  67 ++++----
  drivers/thermal/qcom/lmh.c                         |   2 +-
  drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   8 +-
  drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   3 +-
  drivers/thermal/qcom/tsens-8960.c                  |   3 +
  drivers/thermal/qcom/tsens-v0_1.c                  |   3 +
  drivers/thermal/qcom/tsens-v1.c                    |   3 +
  drivers/thermal/qcom/tsens-v2.c                    |  20 +++
  drivers/thermal/qcom/tsens.c                       |  68 +++++---
  drivers/thermal/qcom/tsens.h                       |   8 +-
  drivers/thermal/st/stm_thermal.c                   |   4 +-
  drivers/thermal/thermal_of.c                       |   8 +-
  drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   2 +-
  23 files changed, 506 insertions(+), 186 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
  delete mode 100644 
Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt



<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
