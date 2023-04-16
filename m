Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD846E36C7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjDPJts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 05:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDPJto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:49:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE1E1BDC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:49:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id he13so17327242wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681638581; x=1684230581;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYyN/AslObwW9PeqYPq039dTL5hYssNl8+iqncjQ4as=;
        b=VZ2wGcQeAVAEP4RFmct0L/6OBDL00plV03Do3FEg+eFPg0jTLiT3ZOpe4DgA86gVzw
         LZXf38Nzv9EaFxGARYcJ6qMAEZEvUGpOY8L92n0vUNr+msh1B5C35KN6H0jtGuVPfEwb
         4ebPbI/bw56PVshiRe/R9WI4RPpOXJR6kNi0h+R+WichgaVRMOcoXj8cj5O85+reR6RX
         i73QSFAAGEjiKBnz4IrBsa3aloE3Zy/WEugnTd5+Cp3OWngFqM0d5Vo5kNKgOXeJyUb/
         AMh6nriNV5sYSeQ+gWerDYb7GBcunrx2uokohbrD+B8I79ZBRa1Vz0gjJp4uAikACZ88
         GJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681638581; x=1684230581;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yYyN/AslObwW9PeqYPq039dTL5hYssNl8+iqncjQ4as=;
        b=edc1JV5ONXkJzPYM7mx46TtOX9gMgzRZpvYrVLK7JckmvEXOcIo69CPRuPU1OISLQQ
         DBfS3KtkfKv3BV/UAyPbYtgqyzk+t24ZDS7+jI5ILrzxobIZI5ci8U2MfKOlBVXjmhC0
         DWSWy/ZLTXUr+Q6eSCbktpgWuNlbykX5lH8nS4rranlIiLrYXljwAiL+IH9R99cwfNEj
         NFs9ExZrEQ/FkLYG1DWe3eqlPDQ/5RwnPbTjLCmk4mWcOxBmpSQk7Ot9WKobeLYuYIgl
         Dk7imzJgY7cT7EhgQPRgmoOJscbokksylCWyZpugzQ/lXWk6GazKBzWhQTzVbEEHuOlk
         DFkA==
X-Gm-Message-State: AAQBX9ceKc4X9lcfcKIlrjQLlFITmADkhiYwqCcE6QY9wNZacCBJN3n9
        32DOFud+65iDD3KlstyNR6oaRw==
X-Google-Smtp-Source: AKy350bUiZqjoxYERnSAJKpvAt8CrihtPhmKAzb1lGX0uuzwv9YM5+W2t3cbapkeUaIw+yUjLPB/Sw==
X-Received: by 2002:a7b:ce91:0:b0:3ed:e4ac:d532 with SMTP id q17-20020a7bce91000000b003ede4acd532mr9007838wmj.36.1681638581118;
        Sun, 16 Apr 2023 02:49:41 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id iz11-20020a05600c554b00b003f09aaf547asm14362239wmb.1.2023.04.16.02.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 02:49:40 -0700 (PDT)
Message-ID: <a83c3a2d-8c67-9053-455d-c1cee3545f16@linaro.org>
Date:   Sun, 16 Apr 2023 11:49:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v6.4-rc1 #2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

please consider pulling the following changes, they are all from the 
thermal/bleeding-edge which was then merged to thermal/linux-next

Thanks

   -- Daniel

The following changes since commit 75f74a907164eaeb1bd5334b01504a84b2b63bf5:

   Merge tag 'thermal-v6.4-rc1-1' of 
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux 
(2023-04-03 20:43:32 +0200)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.4-rc1-2

for you to fetch changes up to 3d439b1a2ad36c8b4ea151c8de25309d60d17407:

   thermal/core: Alloc-copy-free the thermal zone parameters structure 
(2023-04-07 18:36:28 +0200)

----------------------------------------------------------------
- Do preparating cleaning and DT bindings for RK3588 support
   (Sebastian Reichel)

- Add driver support for RK3588 (Finley Xiao)

- Use devm_reset_control_array_get_exclusive() for the Rockchip driver
   (Ye Xingchen)

- Detect power gated thermal zones and return -EAGAIN when reading the
   temperature (Mikko Perttunen)

- Remove thermal_bind_params structure as it is unused (Zhang Rui)

- Drop unneeded quotes in DT bindings allowing to run yamllint (Rob
   Herring)

- Update the power allocator documentation according to the thermal
   trace relocation (Lukas Bulwahn)

- Fix sensor 1 interrupt status bitmask for the Mediatek LVTS sensor
   (Chen-Yu Tsai)

- Use the dev_err_probe() helper in the Amlogic driver (Ye Xingchen)

- Add AP domain support to LVTS thermal controllers for mt8195
   (Balsam CHIHI)

- Remove buggy call to thermal_of_zone_unregister() (Daniel Lezcano)

- Make thermal_of_zone_[un]register() private to the thermal OF code
   (Daniel Lezcano)

- Create a private copy of the thermal zone device parameters
   structure when registering a thermal zone (Daniel Lezcano)

----------------------------------------------------------------
Balsam CHIHI (2):
       dt-bindings: thermal: mediatek: Add AP domain to LVTS thermal 
controllers for mt8195
       thermal/drivers/mediatek/lvts_thermal: Add AP domain for mt8195

Chen-Yu Tsai (1):
       thermal/drivers/mediatek/lvts_thermal: Fix sensor 1 interrupt 
status bitmask

Daniel Lezcano (3):
       thermal/drivers/bcm2835: Remove buggy call to 
thermal_of_zone_unregister
       thermal/of: Unexport unused OF functions
       thermal/core: Alloc-copy-free the thermal zone parameters structure

Finley Xiao (1):
       thermal/drivers/rockchip: Support RK3588 SoC in the thermal driver

Lukas Bulwahn (1):
       MAINTAINERS: adjust entry in THERMAL/POWER_ALLOCATOR after header 
movement

Mikko Perttunen (1):
       thermal/drivers/tegra-bpmp: Handle offline zones

Rob Herring (1):
       dt-bindings: thermal: Drop unneeded quotes

Sebastian Reichel (6):
       thermal/drivers/rockchip: Simplify getting match data
       thermal/drivers/rockchip: Simplify clock logic
       thermal/drivers/rockchip: Use dev_err_probe
       thermal/drivers/rockchip: Simplify channel id logic
       thermal/drivers/rockchip: Support dynamic sized sensor array
       dt-bindings: rockchip-thermal: Support the RK3588 SoC compatible

Ye Xingchen (2):
       thermal/drivers/rockchip: use 
devm_reset_control_array_get_exclusive()
       thermal: amlogic: Use dev_err_probe()

Zhang Rui (1):
       thermal/core: Remove thermal_bind_params structure

  Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml  |   2 +-
  Documentation/devicetree/bindings/thermal/imx-thermal.yaml      |   4 +--
  Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml    |   4 +--
  Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml |   1 +
  Documentation/driver-api/thermal/sysfs-api.rst                  |  40 
-------------------------
  MAINTAINERS                                                     |   2 +-
  drivers/thermal/amlogic_thermal.c                               |   7 
++---
  drivers/thermal/broadcom/bcm2835_thermal.c                      |   4 +--
  drivers/thermal/mediatek/lvts_thermal.c                         | 100 
+++++++++++++++++++++++++++++++++++++++++++++++---------------
  drivers/thermal/rockchip_thermal.c                              | 324 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------
  drivers/thermal/tegra/tegra-bpmp-thermal.c                      |   9 
+++++-
  drivers/thermal/thermal_core.c                                  | 144 
+++++++++++++++--------------------------------------------------------------------------
  drivers/thermal/thermal_of.c                                    |   8 
++---
  include/dt-bindings/thermal/mediatek,lvts-thermal.h             |  10 
+++++++
  include/linux/thermal.h                                         |  55 
----------------------------------
  15 files changed, 358 insertions(+), 356 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
