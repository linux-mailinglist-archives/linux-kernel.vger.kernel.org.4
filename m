Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EE56E4ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjDQOFa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 10:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjDQOFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:05:24 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED4CA5C9;
        Mon, 17 Apr 2023 07:05:09 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5068638856dso297464a12.1;
        Mon, 17 Apr 2023 07:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681740308; x=1684332308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o95qltEIxKaZ0GG79mFmfKBk2nk2vX2Uy1PRlh5e7Z0=;
        b=HdRXDhTVLvaQnB/r4MR1TSANokIweohmdPUBfNHsJ3ymfcJd3piaYGq8qc8Spdk7uJ
         I9osNcuewzR71uZAZWepIrNQAElW1u7WcI9jqLQW9z+tjhA1ZWLRfFcfH4Ls3OZULFu6
         +jyDdpY0gBMnKZe87hepvLDeC7u9Q73K48Tkbpk1mcvtg9YufPOEsGNsAfxBhYOjqkSr
         9D8m1qKZ+hhtqq3B5wB+2J6B/aAo9v/3miTQ2vETf+51Ievmnnkx43LdXLoGiWkZbpy+
         MxrpBC13rem9ap7C2o2j9HIVBc2LWQTmtcKm/bESSd1w/OMaK7HX20N4Dj3dkwnSXbxj
         xMgg==
X-Gm-Message-State: AAQBX9cqSuWATQuOJdax6M7nKB1pO1Jk+84eXEj8ZBkYiGdU1prF8KQt
        6oUoxUQdgVL4ZX55dZqTz20JzKtoAmTghQgbXFs=
X-Google-Smtp-Source: AKy350avk3TTzF4MJyGXSX9VB16oBXss2iyHfymSu64jJ3Ijpc2D3D6w0wSWrTyJpd62u8Bc/zQRv4oqUieGI3fktik=
X-Received: by 2002:a05:6402:34d2:b0:502:ffd:74a0 with SMTP id
 w18-20020a05640234d200b005020ffd74a0mr11963865edc.2.1681740307878; Mon, 17
 Apr 2023 07:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <a83c3a2d-8c67-9053-455d-c1cee3545f16@linaro.org>
In-Reply-To: <a83c3a2d-8c67-9053-455d-c1cee3545f16@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Apr 2023 16:04:56 +0200
Message-ID: <CAJZ5v0jKnTw=9kygy-A=rrfgQTwLomiGSCm7wR3EP7TnBRo4Zw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v6.4-rc1 #2
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 11:49 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> please consider pulling the following changes, they are all from the
> thermal/bleeding-edge which was then merged to thermal/linux-next
>
> Thanks
>
>    -- Daniel
>
> The following changes since commit 75f74a907164eaeb1bd5334b01504a84b2b63bf5:
>
>    Merge tag 'thermal-v6.4-rc1-1' of
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux
> (2023-04-03 20:43:32 +0200)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.4-rc1-2
>
> for you to fetch changes up to 3d439b1a2ad36c8b4ea151c8de25309d60d17407:
>
>    thermal/core: Alloc-copy-free the thermal zone parameters structure
> (2023-04-07 18:36:28 +0200)
>
> ----------------------------------------------------------------
> - Do preparating cleaning and DT bindings for RK3588 support
>    (Sebastian Reichel)
>
> - Add driver support for RK3588 (Finley Xiao)
>
> - Use devm_reset_control_array_get_exclusive() for the Rockchip driver
>    (Ye Xingchen)
>
> - Detect power gated thermal zones and return -EAGAIN when reading the
>    temperature (Mikko Perttunen)
>
> - Remove thermal_bind_params structure as it is unused (Zhang Rui)
>
> - Drop unneeded quotes in DT bindings allowing to run yamllint (Rob
>    Herring)
>
> - Update the power allocator documentation according to the thermal
>    trace relocation (Lukas Bulwahn)
>
> - Fix sensor 1 interrupt status bitmask for the Mediatek LVTS sensor
>    (Chen-Yu Tsai)
>
> - Use the dev_err_probe() helper in the Amlogic driver (Ye Xingchen)
>
> - Add AP domain support to LVTS thermal controllers for mt8195
>    (Balsam CHIHI)
>
> - Remove buggy call to thermal_of_zone_unregister() (Daniel Lezcano)
>
> - Make thermal_of_zone_[un]register() private to the thermal OF code
>    (Daniel Lezcano)
>
> - Create a private copy of the thermal zone device parameters
>    structure when registering a thermal zone (Daniel Lezcano)
>
> ----------------------------------------------------------------
> Balsam CHIHI (2):
>        dt-bindings: thermal: mediatek: Add AP domain to LVTS thermal
> controllers for mt8195
>        thermal/drivers/mediatek/lvts_thermal: Add AP domain for mt8195
>
> Chen-Yu Tsai (1):
>        thermal/drivers/mediatek/lvts_thermal: Fix sensor 1 interrupt
> status bitmask
>
> Daniel Lezcano (3):
>        thermal/drivers/bcm2835: Remove buggy call to
> thermal_of_zone_unregister
>        thermal/of: Unexport unused OF functions
>        thermal/core: Alloc-copy-free the thermal zone parameters structure
>
> Finley Xiao (1):
>        thermal/drivers/rockchip: Support RK3588 SoC in the thermal driver
>
> Lukas Bulwahn (1):
>        MAINTAINERS: adjust entry in THERMAL/POWER_ALLOCATOR after header
> movement
>
> Mikko Perttunen (1):
>        thermal/drivers/tegra-bpmp: Handle offline zones
>
> Rob Herring (1):
>        dt-bindings: thermal: Drop unneeded quotes
>
> Sebastian Reichel (6):
>        thermal/drivers/rockchip: Simplify getting match data
>        thermal/drivers/rockchip: Simplify clock logic
>        thermal/drivers/rockchip: Use dev_err_probe
>        thermal/drivers/rockchip: Simplify channel id logic
>        thermal/drivers/rockchip: Support dynamic sized sensor array
>        dt-bindings: rockchip-thermal: Support the RK3588 SoC compatible
>
> Ye Xingchen (2):
>        thermal/drivers/rockchip: use
> devm_reset_control_array_get_exclusive()
>        thermal: amlogic: Use dev_err_probe()
>
> Zhang Rui (1):
>        thermal/core: Remove thermal_bind_params structure
>
>   Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml  |   2 +-
>   Documentation/devicetree/bindings/thermal/imx-thermal.yaml      |   4 +--
>   Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml    |   4 +--
>   Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml |   1 +
>   Documentation/driver-api/thermal/sysfs-api.rst                  |  40
> -------------------------
>   MAINTAINERS                                                     |   2 +-
>   drivers/thermal/amlogic_thermal.c                               |   7
> ++---
>   drivers/thermal/broadcom/bcm2835_thermal.c                      |   4 +--
>   drivers/thermal/mediatek/lvts_thermal.c                         | 100
> +++++++++++++++++++++++++++++++++++++++++++++++---------------
>   drivers/thermal/rockchip_thermal.c                              | 324
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------
>   drivers/thermal/tegra/tegra-bpmp-thermal.c                      |   9
> +++++-
>   drivers/thermal/thermal_core.c                                  | 144
> +++++++++++++++--------------------------------------------------------------------------
>   drivers/thermal/thermal_of.c                                    |   8
> ++---
>   include/dt-bindings/thermal/mediatek,lvts-thermal.h             |  10
> +++++++
>   include/linux/thermal.h                                         |  55
> ----------------------------------
>   15 files changed, 358 insertions(+), 356 deletions(-)
>
> --

Pulled and pushed out, thanks!
