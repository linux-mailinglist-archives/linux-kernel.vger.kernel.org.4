Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDB26905C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBIK4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBIK4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:56:35 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978904941F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:56:32 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n13so1127931wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 02:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnJlP6FIsmSatibefV/A+n1GcTw3yUSot7C1x8B79Wg=;
        b=8CYR2izZzKIWxMMcI4QqNJOVocF01mhKauFQ3mKWR3Sdh5tRTyjEHaCsTAYHJXHrAe
         AhPGYKXpVSVSfveCkvFBHGMbcCVjAQ2D16KXgWgEk5Sh1I7vVPCM9PJuVl9T9zwBm7J0
         99pDBgUnSFDLwFkPCHdjoIOqQWLLWQEW9sU+jxxV/NyX/nkK2qkjNDzuup7EICvecPGG
         yMY8189cnV+luki9d+PaIgfFxPqgt71dkFse9xaTFbBY4b7rM3Ot/wCsPOHrEBqdva/n
         SvNpSJfJWjWiEMcY/rYOdQT3Uh8kdbupwnmwFurtomXNBOceEyZ6n23hJc3xmnIvq61i
         7XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnJlP6FIsmSatibefV/A+n1GcTw3yUSot7C1x8B79Wg=;
        b=bDbT7ZV0CwCsHBnVHKQUGedxHJAKCKy7EiqNhKlGfox2nFuSW0p1LtxaLeZhUr4aWp
         LtLVA4cHlxKUnacdJgK/SYeA9K148JeF59couzAIY2a+Pj0dqpVB42J4IsuAxWKVq32m
         VV1hLyXXxT7KAaIWpjlZms3Ql795elZPHj7KiXzEFAvbV/kAuzXn4MS64gO8mNHnd2MG
         ShwgpdcCHUUjxNfluTGiVqw7bbc/LKDdQS1zZjyxZvWuhMSWQ3gVOO/lBM1NUGS03Nv3
         R37FI4pOVHbnNkpEyVI+q7lLVPEvRJyEHWlTek2HsKikKCuuHQp+v3mWEj1V8KjxpnSt
         WfvQ==
X-Gm-Message-State: AO0yUKUsJJzcZnDoJOQkPbK8NN3PKXEfIX1fgvGngn6A80EJsubSjGNt
        Ika6msQH6LL0YVSYLrt139cSOg==
X-Google-Smtp-Source: AK7set8tOP9iTwEd+6cUk3vpT+CGnECqGIkgE7P8djG0ngexw+8xDH6nevDuggKs6lc7iefSLhmRPQ==
X-Received: by 2002:a05:600c:996:b0:3df:f85a:4724 with SMTP id w22-20020a05600c099600b003dff85a4724mr9629994wmp.39.1675940191176;
        Thu, 09 Feb 2023 02:56:31 -0800 (PST)
Received: from t480-bl003.. (185.173.185.81.rev.sfr.net. [81.185.173.185])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b003daf6e3bc2fsm9140466wms.1.2023.02.09.02.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 02:56:30 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH v14 0/6] Add LVTS Thermal Architecture
Date:   Thu,  9 Feb 2023 11:56:22 +0100
Message-Id: <20230209105628.50294-1-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

The LVTS (Low Voltage Thermal Sensor) driver is capable of monitoring
multiple hot points. For that, it contains 7 thermal control blocks
dedicated to specific devices on the die. Each control block can handle
up to 4 sensors. 

The thermal controller supports several interrupts. One for the cold
trip point, the hot trip point, the return to the normal trip point,
and a specific programmable trip point to monitor the temperature
dynamically.

The temperature measurement can be done in two ways, the immediate mode
where the temperature read is instantaneous and the filtered mode where
the controller uses, by configuration, an average of a set of values
removing the minimum and the maximum.

Finally, it is composed of 2 finite-state machines responsible for
the state of the temperature (cold, hot, hot 2 normal, hot hot),
the triggering of the interrupts, and the monitoring of the temperature.

As requested, the thermal driver has been reworked to reduce
the complexity of the code. At this time, the 4 little CPUs and
the 4 big CPUs are supported by the thermal driver.They are described
in a data structure and more devices can be added later.
The calibration routine has been simplified also.

The series provide the following changes:
 - Move the Mediatek drivers inside a dedicated folder as their number
   is increasing
 - Add the DT bindings for the controller
 - Add the efuse node for the mt8195
 - The LVTS driver
 - The thermal zones description in the DT

Changelog:
  v14:
     - Fix dt-binding definition :
       - Change "nvmem-cells" and "nvmem-cell-names" properties of
         "mt8195" from "maxItems: 2" to  "minItems: 2"
       - Fix "mediatek,lvts-thermal.h" indentation

  v13:
     - Rebase on top of "thermal/linux-next" :
       base-commit: a2c81dc59d41e92362ab7d41d0c15471ea50637d
     - Fix coding style issues
       - Remove "__init" from all functions
       - Remove "lvts_ctrl_enable" and "lvts_ctrl_disable" wrappers
       - Use "dev_err_probe" instead of "dev_dbg" in "lvts_probe"
     - Fix subject prefix
     - Add "mt8192" to dt-binding definition
     - Change dt-binding license to "GPL-2.0-only OR BSD-2-Clause"
     - Fix debugfs mutli-instance support

  v12:
     - Fix subject prefix
     - Add dual licenses to dt-binding
     - Rename "include/dt-bindings/thermal/mediatek-lvts.h"
       to "include/dt-bindings/thermal/mediatek,lvts-thermal.h"

  v11:
     - Rebase on top of "thermal/linux-next" :
       base=0d568e144ead70189e7f16066dcb155b78ff9266
     - Remove unsupported SoC (mt8192) from dt-binding definition
     - Fix coding style issues :
       - Move litterals to define
       - Add interrupt macros
       - Remove wildcard : only mt8195 is supported for now

  v10:
     - Rebase on top of "thermal/linux-next" : thermal-v6.3-rc1
     - Rework the LVTS driver
     - Add the thermal trip temperature and cooling devices
       for the sensors supported by the driver

  v9:
     - Rebase on top of 6.0.0-rc1
     - Fix coding style issues
     - Fix commit titles and commit messages
     - Update dt-bindings :
     - Add "allOf:if:then:"
     - Use mt8192 as example (instead of mt8195)
     - Fix dt-binding errors
     - Fix DTS errors

  v8:
     - Fix coding style issues
     - Rebase on top of next-20220803
     - Add multi-instance support :
       - Rewrite DT-binding and DTS :
         - Add DT-binding and DTS for LVTS_v4 (MT8192 and MT8195)
           - One LVTS node for each HW Domain (AP and MCU)
         - One SW Instance for each HW Domain
         - Add a Kconfig sub-menu entry for LVTS and LVTS_v4 SoCs
     - Replace platform_get_resource by platform_get_mem_or_io to get
       Base Address
     - Replace platform_get_resource by platform_get_irq to get
       Interrupt Number
     - Add "lvts_" prefix to functions and structs

 v7:
     - Fix coding style issues
     - Rewrite dt bindings
       - was not accurate
       - Use mt8195 for example (instead of mt8192)
       - Rename mt6873 to mt8192
       - Remove clock name
     - Rebased on top of to series:
       - patchwork.kernel.org/project/linux-mediatek/list/?series=637849
       - patchwork.kernel.org/project/linux-pm/list/?series=639386

 v6:
     - Remove temperature aggregation (it will be added in another
       series)
     - Update the way to read the temperature (read one sensor
       instead of all)
     - Add support of mt8195

  v5:
     - Use 'git mv' for the relocated file.

  v4:
     - Rebase to kernel-v5.13-rc1

  v3:
     - change the expression in the lvts_temp_to_raw to dev_s64.

  v2:
     - Rebase to kernel-5.11-rc1.
     - sort headers
     - remove initial value 0 of msr_raw in the lvts_temp_to_raw.
     - disconstruct the api of lvts_read_tc_msr_raw.
     - add the initial value max_temp = 0 and compare e.q.
       in the lvts_read_all_tc_temperature.
     - add the return with an invalid number in the lvts_init.

Balsam CHIHI (6):
  thermal: drivers: mediatek: Relocate driver to mediatek folder
  dt-bindings: thermal: mediatek: Add LVTS thermal controllers
  arm64: dts: mt8195: Add efuse node to mt8195
  thermal: drivers: mediatek: Add the Low Voltage Thermal Sensor driver
  arm64: dts: mediatek: mt8195: Add thermal zones and thermal nodes
  arm64: dts: mediatek: mt8195: Add temperature mitigation threshold

 .../thermal/mediatek,lvts-thermal.yaml        |  142 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  272 ++++
 drivers/thermal/Kconfig                       |   14 +-
 drivers/thermal/Makefile                      |    2 +-
 drivers/thermal/mediatek/Kconfig              |   37 +
 drivers/thermal/mediatek/Makefile             |    2 +
 .../auxadc_thermal.c}                         |    2 +-
 drivers/thermal/mediatek/lvts_thermal.c       | 1224 +++++++++++++++++
 .../thermal/mediatek,lvts-thermal.h           |   19 +
 9 files changed, 1702 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
 create mode 100644 drivers/thermal/mediatek/Kconfig
 create mode 100644 drivers/thermal/mediatek/Makefile
 rename drivers/thermal/{mtk_thermal.c => mediatek/auxadc_thermal.c} (99%)
 create mode 100644 drivers/thermal/mediatek/lvts_thermal.c
 create mode 100644 include/dt-bindings/thermal/mediatek,lvts-thermal.h


base-commit: a2c81dc59d41e92362ab7d41d0c15471ea50637d
-- 
2.34.1

