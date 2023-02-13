Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5060B6943E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjBMLKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjBMLKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:10:09 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692C8D52B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:10:08 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10997325wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewNdypPpxJtbl5al/d/KElLbd16ba+tKN4mS6vis/6U=;
        b=tEC8LqOsi41BXem0ZoRD2n4ttQHen8DBJmZX5sGQPiiLN2+It/bQKr+fvssV6W6Z9+
         H+kWAZ7yzPZihzo7cD8u3JTDZH/ypV8K+HIFcTeKEikVhQ12l/L+tfkgFKScvIiRKF1f
         nGxa4uM7XJiuNfSu0PNSaSOdjj5zVRFpCNQczfiWSdNDWG7E2cCEcrx9S+sAqwUuYin2
         zEH9BTnegLP7FJxzlYE+eHniJ6ViEYNgfPWhJS2DtcReU61bW3lYUG8KAR7nktW4JHv1
         S5tWPSjViHLiNwOKdpGIb+iywIzDupWDEmF+mtmHO1OX75srjumGPewBhI9ErFv+nbh6
         KZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewNdypPpxJtbl5al/d/KElLbd16ba+tKN4mS6vis/6U=;
        b=A/GlruxkL8x3JsLr/0MlwIE5mhCoPTtGeQcIVqAdXZEnmkHzOTfvETBtGLMskYT1gJ
         tVFn97BLOVo9IdTvOz/29HOXcNiCE5pjjfKi1oetQbVkqNVg7gHuixkuCn8ZBdiRmsMt
         ANdC0S0WpTcvmuLugIY/7d5BVRTmfg/+1DP4si5S2qj9F7DtS4UtqcigqS7JEkpjkFKR
         X6aOnFJeKVwp37ch/gml6eHKZiOjTSq1mP1b0e8onpyRN+2JQtEorIZ5NDN/9FRveewD
         8D8XQ2XDDaMXsHkFgOCJV1CjJJ1nWLw3CmaVhNYc1BPR/0kYSxbgR/5CIO8yic5ayurH
         KrEQ==
X-Gm-Message-State: AO0yUKVTybS3SG3l8R0ntTIjWHtElYRYRTg+KL9/mKJd+GqN232xM4n9
        GasEkXfa3Y3rEuUJxMaf71p30Q==
X-Google-Smtp-Source: AK7set+3FrPGhJqYdKr1igcuvqEZtlNXbken5c8kn5I6GBlF9kCgrwzlpVyBrAGRLULA+x/63LrNjA==
X-Received: by 2002:a05:600c:9a2:b0:3dc:576c:ab07 with SMTP id w34-20020a05600c09a200b003dc576cab07mr18330489wmp.14.1676286606839;
        Mon, 13 Feb 2023 03:10:06 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id j23-20020a05600c1c1700b003daf681d05dsm14557451wms.26.2023.02.13.03.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:10:06 -0800 (PST)
Message-ID: <76fe1e13-761c-1153-b913-ed2c41c8d807@linaro.org>
Date:   Mon, 13 Feb 2023 12:10:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        yong qin <yongqin.liu@linaro.org>,
        Vibhav Pant <vibhavp@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alain Volmat <avolmat@me.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal material for v6.3, take 2
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

The following changes since commit 61b7614c114c817f9f326282c2f7a728bf0051a8:

   Merge branch 'thermal-intel' into linux-next (2023-02-09 19:57:59 +0100)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.3-rc1-2

for you to fetch changes up to f8da73d02bfcf6d61513912035150d91c14ea1e9:

   thermal/drivers/st: Remove syscfg based driver (2023-02-13 11:42:35 
+0100)

----------------------------------------------------------------
- Fix missing thermal_sampling_exit() call when unsubscribing (Vincent
   Guittot)

- Add the LVTS Mediatek driver along with a relocation to the Mediatek 
folder (Balsam Chihi)

- Add the r8a779g0 RCar support (Geert Uytterhoeven)

- Fix useless call to set_trips() when resuming and add interrupt
   support detection at init time on RCar gen3 (Niklas Söderlund)

- Fix memory corruption in the hi3660 thermal driver (Yongqin Liu)

- Fix include path for libnl3 in pkg-config file for the libthermal
   (Vibhav Pant)

- Remove core header inclusion from drivers (Daniel Lezcano)

- Remove syscfg based driver as the platform is removed (Alain Volmat)

----------------------------------------------------------------
Alain Volmat (1):
       thermal/drivers/st: Remove syscfg based driver

Balsam CHIHI (3):
       thermal/drivers/mediatek: Relocate driver to mediatek folder
       dt-bindings: thermal: mediatek: Add LVTS thermal controllers
       thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver

Daniel Lezcano (1):
       thermal: Remove core header inclusion from drivers

Geert Uytterhoeven (2):
       dt-bindings: thermal: rcar-gen3-thermal: Add r8a779g0 support
       thermal/drivers/rcar_gen3: Add support for R-Car V4H

Niklas Söderlund (3):
       thermal/drivers/rcar_gen3_thermal: Do not call set_trips() when 
resuming
       thermal/drivers/rcar_gen3_thermal: Create device local ops struct
       thermal/drivers/rcar_gen3_thermal: Fix device initialization

Vibhav Pant (1):
       tools/lib/thermal: Fix include path for libnl3 in pkg-config file.

Vincent Guittot (1):
       tools/lib/thermal: Fix thermal_sampling_exit()

Yongqin Liu (1):
       thermal/drivers/hisi: Drop second sensor hi3660

  .../bindings/thermal/mediatek,lvts-thermal.yaml    |  142 +++
  .../bindings/thermal/rcar-gen3-thermal.yaml        |    3 +
  drivers/thermal/Kconfig                            |   14 +-
  drivers/thermal/Makefile                           |    2 +-
  drivers/thermal/amlogic_thermal.c                  |    1 -
  drivers/thermal/armada_thermal.c                   |    2 -
  drivers/thermal/broadcom/bcm2835_thermal.c         |    1 -
  drivers/thermal/hisi_thermal.c                     |    7 +-
  drivers/thermal/imx8mm_thermal.c                   |    1 -
  drivers/thermal/imx_sc_thermal.c                   |    1 -
  drivers/thermal/intel/intel_hfi.c                  |    3 +-
  drivers/thermal/mediatek/Kconfig                   |   37 +
  drivers/thermal/mediatek/Makefile                  |    2 +
  .../{mtk_thermal.c => mediatek/auxadc_thermal.c}   |    2 +-
  drivers/thermal/mediatek/lvts_thermal.c            | 1224 
++++++++++++++++++++
  drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |    1 -
  drivers/thermal/qoriq_thermal.c                    |    1 -
  drivers/thermal/rcar_gen3_thermal.c                |   41 +-
  drivers/thermal/samsung/exynos_tmu.c               |    3 +-
  drivers/thermal/st/Kconfig                         |    4 -
  drivers/thermal/st/Makefile                        |    1 -
  drivers/thermal/st/st_thermal_syscfg.c             |  174 ---
  drivers/thermal/st/stm_thermal.c                   |    1 -
  drivers/thermal/tegra/tegra30-tsensor.c            |    1 -
  drivers/thermal/uniphier_thermal.c                 |    2 -
  .../dt-bindings/thermal/mediatek,lvts-thermal.h    |   19 +
  tools/lib/thermal/libthermal.pc.template           |    2 +-
  tools/lib/thermal/sampling.c                       |    2 +-
  28 files changed, 1461 insertions(+), 233 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
  create mode 100644 drivers/thermal/mediatek/Kconfig
  create mode 100644 drivers/thermal/mediatek/Makefile
  rename drivers/thermal/{mtk_thermal.c => mediatek/auxadc_thermal.c} (99%)
  create mode 100644 drivers/thermal/mediatek/lvts_thermal.c
  delete mode 100644 drivers/thermal/st/st_thermal_syscfg.c
  create mode 100644 include/dt-bindings/thermal/mediatek,lvts-thermal.h

