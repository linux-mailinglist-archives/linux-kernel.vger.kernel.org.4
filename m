Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECB173E642
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjFZRRw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 13:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjFZRQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:16:18 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D6F1BEE;
        Mon, 26 Jun 2023 10:15:27 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-98e2865e2f2so46484266b.0;
        Mon, 26 Jun 2023 10:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687799725; x=1690391725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtbCFdM31VuS7J+4uQXZ2N2jb4VKT9MQHjf41EIMETQ=;
        b=hDHf0B2Gyg3CDKlPo+7HF0z0+6dxgPWIaMcwJ8Jut7k+FMNCQHwj5ObQ8f6INaXSuj
         qPUp7gFrGDRFckcaxu4lphku407fqBnNkZe+cwiVruT36qVd4UU9j+oEV2m+XKL7hrcM
         TI16dovFumRFAhqmtUeLkSiANfW09NcHd3l3HC/zuIQESW1eoZvFxBpxK49wLdp7SNPG
         2qgASr4tsVG7sy7H/VGIBNYW3QlJkkOKQZdkLCAt+3rX7fYjfTqqcyeBsSWZ2jRnEWBQ
         ELppPL0/R30L6RAjERVe6xFF//nifAtDIZRv/N3A7jG98itk3y6mpkH1Uuu1FUziUMtu
         PegA==
X-Gm-Message-State: AC+VfDwjat6qcUgUKWSJ33Nfn3SN29xBPhLnF31Xu3EPArLpvHb9R2Ak
        yxNMrkhhInZP5QpiPiaf+aHa4MVRThCU/YL7hFY=
X-Google-Smtp-Source: ACHHUZ5i49hsGEMviP4cvK4Drkv3i9ic2FdjAGUF90dcLJbGHAC/4L57HdDYVvbFWWt9cW4kBH41Cg2c729uSiSRqKY=
X-Received: by 2002:a17:906:74da:b0:974:5480:6270 with SMTP id
 z26-20020a17090674da00b0097454806270mr21458379ejl.0.1687799725381; Mon, 26
 Jun 2023 10:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <47423e79-8a68-87c3-c357-6d67c0653adf@linaro.org>
In-Reply-To: <47423e79-8a68-87c3-c357-6d67c0653adf@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Jun 2023 19:15:14 +0200
Message-ID: <CAJZ5v0gt3jBtWKhL3PNV97FbBzoHm-iGs+cL+YSWF5Qi-wafkA@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v6.5-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Praveenkumar I <quic_ipkumar@quicinc.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Thierry Reding <treding@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Peng Fan <peng.fan@nxp.com>,
        Alex Leibovich <alexl@marvell.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>, Luca Weiss <luca@z3ntu.xyz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
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

Hi Daniel,

On Mon, Jun 26, 2023 at 5:33 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> please consider the following changes since commit
> 0bb619f9227aa370330d2b309733d74750705053:
>
>    thermal/intel/intel_soc_dts_iosf: Fix reporting wrong temperatures
> (2023-06-15 18:07:48 +0200)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.5-rc1
>
> for you to fetch changes up to 57c9eaa4de537e6f08819d9214de502cac5a989c:
>
>    thermal/drivers/qcom/temp-alarm: Use dev_err_probe (2023-06-26
> 12:10:22 +0200)
>
> ----------------------------------------------------------------
> - Add DT bindings for SM6375, MSM8226 and QCM2290 Qcom platforms (Konrad
>    Dybcio)
>
> - Add DT bindings and support for QCom MSM8226 (Matti Lehtimäki)
>
> - Add DT bindings for QCom ipq9574 (Praveenkumar I)
>
> - Convert bcm2835 DT bindings to the yaml schema (Stefan Wahren)
>
> - Allow selecting the bang-bang governor as default (Thierry Reding)
>
> - Refactor and prepare the code to set the scene for RCar Gen4
>    (Wolfram Sang)
>
> - Cleanup and fixes for the QCom tsens drivers. Add DT bindings and
>    calibration for the MSM8909 platform (Stephan Gerhold)
>
> - Revert a patch introducing a wrong usage of devm_of_iomap() on the
>    Mediatek platform (Ricardo Cañuelo)
>
> - Fix the clock vs reset ordering in order to conform to the
>    documentation on the sun8i (Christophe JAILLET)
>
> - Prevent setting up undocumented registers, enable the only described
>    sensors and add the version 2.1 on the Qoriq sensor (Peng Fan)
>
> - Add DT bindings and support for the Armada AP807 (Alex Leibovich)
>
> - Update the mlx5 driver with the recent thermal changes (Daniel
>    Lezcano)
>
> - Convert to platform remove callback returning void on STM32 (Uwe
>    Kleine-König)
>
> - Add an error information printing for devm_thermal_add_hwmon_sysfs()
>    and remove the error from the Sun8i, Amlogic, i.MX, TI, K3, Tegra,
>    Qoriq, Mediateka and QCom (Yangtao Li)
>
> - Register as hwmon sensor for the Generic ADC (Chen-Yu Tsai)
>
> - Use the dev_err_probe() function in the QCom tsens alarm driver
>    (Luca Weiss)
>
> ----------------------------------------------------------------
> Alex Leibovich (2):
>        dt-bindings: armada-thermal: Add armada-ap807-thermal compatible
>        thermal/drivers/armada: Add support for AP807 thermal data
>
> Chen-Yu Tsai (2):
>        thermal/drivers/mediatek/lvts_thermal: Register thermal zones as
> hwmon sensors
>        thermal/drivers/generic-adc: Register thermal zones as hwmon sensors
>
> Christophe JAILLET (1):
>        thermal/drivers/sun8i: Fix some error handling paths in
> sun8i_ths_probe()
>
> Daniel Lezcano (1):
>        net/mlx5: Update the driver with the recent thermal changes
>
> Konrad Dybcio (2):
>        dt-bindings: thermal: tsens: Add QCM2290
>        dt-bindings: thermal: tsens: Add compatible for SM6375
>
> Luca Weiss (1):
>        thermal/drivers/qcom/temp-alarm: Use dev_err_probe
>
> Matti Lehtimäki (2):
>        dt-bindings: thermal: tsens: Add compatible for MSM8226
>        thermal/drivers/qcom/tsens-v0_1: Add support for MSM8226
>
> Pankit Garg (1):
>        thermal/drivers/qoriq: No need to program site adjustment register
>
> Peng Fan (2):
>        thermal/drivers/qoriq: Only enable supported sensors
>        thermal/drivers/qoriq: Support version 2.1
>
> Praveenkumar I (1):
>        dt-bindings: thermal: tsens: Add ipq9574 compatible
>
> Ricardo Cañuelo (1):
>        Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid
> resource leak in mtk_thermal_probe"
>
> Stefan Wahren (1):
>        dt-bindings: thermal: convert bcm2835-thermal bindings to YAML
>
> Stephan Gerhold (6):
>        thermal/drivers/qcom/tsens: Drop unused legacy structs
>        thermal/drivers/qcom/tsens-v0_1: Fix mdm9607 slope values
>        thermal/drivers/qcom/tsens-v0_1: Add mdm9607 correction offsets
>        dt-bindings: thermal: qcom-tsens: Drop redundant compatibles
>        dt-bindings: thermal: qcom-tsens: Add MSM8909 compatible
>        thermal/drivers/qcom/tsens-v0_1: Add MSM8909 data
>
> Thierry Reding (1):
>        thermal: Allow selecting the bang-bang governor as default
>
> Uwe Kleine-König (1):
>        thermal/drivers/stm32: Convert to platform remove callback
> returning void
>
> Wolfram Sang (3):
>        drivers/thermal/rcar_gen3_thermal: introduce 'info' structure
>        drivers/thermal/rcar_gen3_thermal: refactor reading fuses into
> seprarate function
>        drivers/thermal/rcar_gen3_thermal: add reading fuses for Gen4
>
> Yangtao Li (10):
>        thermal/hwmon: Add error information printing for
> devm_thermal_add_hwmon_sysfs()
>        thermal/drivers/sun8i: Remove redundant msg in sun8i_ths_register()
>        thermal/drivers/amlogic: Remove redundant msg in
> amlogic_thermal_probe()
>        thermal/drivers/imx: Remove redundant msg in imx8mm_tmu_probe()
> and imx_sc_thermal_probe()
>        drivers/thermal/k3: Remove redundant msg in k3_bandgap_probe()
>        thermal/drivers/tegra: Remove redundant msg in
> tegra_tsensor_register_channel()
>        thermal/drivers/qoriq: Remove redundant msg in
> qoriq_tmu_register_tmu_zone()
>        thermal/drivers/ti-soc: Remove redundant msg in
> ti_thermal_expose_sensor()
>        thermal/drivers/qcom: Remove redundant msg at probe time
>        thermal/drivers/mediatek/lvts_thermal: Remove redundant msg in
> lvts_ctrl_start()

Pulled and added to the thermal branch of linux-pm.git.

Thanks!
