Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50B067D12B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjAZQTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjAZQTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:19:21 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3432721970
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:19:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r2so2295690wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wxCJ7VH8kcrhyzG9kkuTpUxvya7wMEChRRE8w8/Ur0=;
        b=xp3EJIj3spQjDcvxuOgJHqeJV7FEvFAT8Yztw76YVLx96+Pb0XADEz9E5ThyFl4g+b
         Qf4oCoIek8tXfp5ZASw8qFYWjbFfC1lM1vm/G7f+SNlcwJaGStu8kVNqFZyhZGVmE3CU
         xEtGRDOnpkR/BVcx/q9lctVMntis4p7vAl9fDKzdeKoLm/SD72r6GIV1nuuGil7XU7Bv
         h3BP67W+8zmboQdGx2DXn2bPl4Wh1FdXFRz0qOySVc5ACatD3IqYBWJhTspRN/dVLKWZ
         6T6yfT1ffl8FAmsVjH5/1vjdTQE6eCN5gpeOo2Gh5PhAA1AkSghDq3MucU9UkwCHeuF2
         kvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3wxCJ7VH8kcrhyzG9kkuTpUxvya7wMEChRRE8w8/Ur0=;
        b=JChSX7790WN9PNb0/JWXSn4/R1xiIiF3YLYJM5EnrCGIZ+cxLzGMlF8kKP2uYxCtOq
         +Ptg0xPT/ez/84HyjwUWAO/eGWhWqoWq+uUFaP5rVU3gdAadgZbF1v35pNXywnWffrb3
         Hd141eTGNOVG4NFtuuAfl+oeJ3cXtFaBFoIZgVWhO6ndVjceKOLvTxV1hmRC5aHKOBMP
         Q96z7S5qORbM5KwMCOUyTRU7VK3UMTKmi62urzsN892aKk7roarpGaUYuL6t+UjbFndk
         CBI7eWAXKWp5RSyr4BHFNuF1XrPRFQ0Ra1foiNKSEZkEiDvmoSk3sGNsKKB+UjcpS6Ic
         7tHQ==
X-Gm-Message-State: AO0yUKVNEQrklzy9R25uWOZe0+byYOqPGiY0hpzNFKcZlpHYS3Vl5hNl
        5OoyD3mJX1+7+PoqZxKSiZG2fA==
X-Google-Smtp-Source: AK7set/+Wm0+d7pajpb6gFoNTSJKwSFGoowC3GxDPuycC2PVav4CL0uRhdhERMrL3TguV5s9ZGXflw==
X-Received: by 2002:adf:ea01:0:b0:2bf:b35d:2797 with SMTP id q1-20020adfea01000000b002bfb35d2797mr8733613wrm.11.1674749956662;
        Thu, 26 Jan 2023 08:19:16 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id h20-20020a05600c351400b003dc1300eab0sm5794537wmq.33.2023.01.26.08.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 08:19:16 -0800 (PST)
Message-ID: <8317ac88-2ff5-9289-9123-0e222d2da905@linaro.org>
Date:   Thu, 26 Jan 2023 17:19:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Yangtao Li <tiny.windzz@gmail.com>, ye.xingchen@zte.com.cn,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal changes for v6.3-rc1
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

please consider pulling:

The following changes since commit 3a151494dc04c76add577ae66e8a04f900638aaf:

   thermal/drivers/armada: Use strscpy() to instead of strncpy() 
(2023-01-06 14:14:48 +0100)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.3-rc1

for you to fetch changes up to 8c5ee9155f8ae133070b40ee4be03cafb35c188d:

   thermal/drivers/armada: Use the thermal_zone_get_crit_temp() 
(2023-01-24 12:37:56 +0100)

----------------------------------------------------------------
- Fix kerneldoc format errors for Rockchip, Mediatek and Uniphier
   (Randy Dunlap)

- Add the missing 'qcom,adc-tm7' compatible string in the dt-bindings
   (Krzysztof Kozlowski)

- Improve the calibration routine by relying on the nvmem to read the
   values and provide a set of fixes for the QCom tsens driver (Dmitry
   Baryshkov)

- Remove the duplicate interrupt setting routine in the QCom tsens
   driver (Daniel Lezcano)

- Fix a wrong loop condition in the i.MX SC thermal driver and add the
   iMX8QM sensors (Viorel Suman)

- Fix header inclusion asm-generic.h by asm.h for the
   qcom-spmi-adc-tm5 driver (Andy Shevchenko)

- Use the devm_platform_get_and_ioremap_resource() combo function in
   all the drivers where the conversion applies (Ye Xingchen)

- Replace a literal mask by an existing corresponding macro (Yangtao
   Li)

- Add support for MT7986 and MT7981 (Daniel Golle)

- Use thermal_zone_get_crit_temp() for the Armada thermal driver
   (Daniel Lezcano)

----------------------------------------------------------------
Andy Shevchenko (1):
       thermal/drivers/qcom-spmi-adc-tm5: Use asm intead of asm-generic

Daniel Golle (2):
       thermal/drivers/mtk: Use function pointer for raw_to_mcelsius
       thermal/drivers/mtk: Add support for MT7986 and MT7981

Daniel Lezcano (2):
       thermal/drivers/qcom: Remove duplicate set next trip point 
interrupt code
       thermal/drivers/armada: Use the thermal_zone_get_crit_temp()

Dmitry Baryshkov (14):
       dt-bindings: thermal: tsens: add msm8956 compat
       dt-bindings: thermal: tsens: support per-sensor calibration cells
       dt-bindings: thermal: tsens: add per-sensor cells for msm8974
       thermal/drivers/tsens: Drop unnecessary hw_ids
       thermal/drivers/tsens: Drop msm8976-specific defines
       thermal/drivers/tsens: Sort out msm8976 vs msm8956 data
       thermal/drivers/tsens: fix slope values for msm8939
       thermal/drivers/tsens: limit num_sensors to 9 for msm8939
       thermal/drivers/tsens: Support using nvmem cells for calibration data
       thermal/drivers/tsens: Support using nvmem cells for msm8974 
calibration
       thermal/drivers/tsens: Rework legacy calibration data parsers
       thermal/drivers/tsens: Drop single-cell code for mdm9607
       thermal/drivers/tsens: Drop single-cell code for msm8939
       thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956

Krzysztof Kozlowski (1):
       dt-bindings: thermal: qcom-spmi-adc-tm5: add qcom,adc-tm7

Rafael J. Wysocki (1):
       Merge tag 'generic-trip-point' of 
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux

Randy Dunlap (3):
       thermal/drivers/mtk_thermal: Fix kernel-doc function name
       thermal/drivers/rockchip: Fix kernel-doc warnings
       thermal/drivers/uniphier: Use regular comment syntax

Viorel Suman (2):
       thermal/drivers/imx_sc_thermal: Fix the loop condition
       thermal/drivers/imx_sc_thermal: Add iMX8QM sensors

Yangtao Li (1):
       thermal/drivers/sun8i: Convert to use macro

ye xingchen (9):
       thermal/drivers/brcmstb_thermal: Use 
devm_platform_get_and_ioremap_resource()
       thermal/drivers/bcm2835: Use devm_platform_get_and_ioremap_resource()
       thermal/drivers/dove: Use devm_platform_get_and_ioremap_resource()
       thermal/drivers/armada: Use devm_platform_get_and_ioremap_resource()
       thermal/drivers/mtk_thermal: Use 
devm_platform_get_and_ioremap_resource()
       thermal/drivers/rockchip: Use 
devm_platform_get_and_ioremap_resource()
       thermal/drivers/thermal_mmio: Use 
devm_platform_get_and_ioremap_resource()
       thermal/drivers/kirkwood: Use 
devm_platform_get_and_ioremap_resource()
       thermal/drivers/spear: Use devm_platform_get_and_ioremap_resource()

  .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |   1 +
  .../devicetree/bindings/thermal/qcom-tsens.yaml    | 153 ++++-
  drivers/thermal/armada_thermal.c                   |  42 +-
  drivers/thermal/broadcom/bcm2835_thermal.c         |   4 +-
  drivers/thermal/broadcom/brcmstb_thermal.c         |   4 +-
  drivers/thermal/dove_thermal.c                     |   7 +-
  drivers/thermal/imx_sc_thermal.c                   |   8 +-
  drivers/thermal/kirkwood_thermal.c                 |   4 +-
  drivers/thermal/mtk_thermal.c                      | 149 ++++-
  drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   3 +-
  drivers/thermal/qcom/tsens-v0_1.c                  | 655 
++++++---------------
  drivers/thermal/qcom/tsens-v1.c                    | 340 +++--------
  drivers/thermal/qcom/tsens.c                       | 219 +++++--
  drivers/thermal/qcom/tsens.h                       |  46 +-
  drivers/thermal/rockchip_thermal.c                 |  10 +-
  drivers/thermal/spear_thermal.c                    |   4 +-
  drivers/thermal/sun8i_thermal.c                    |   4 +-
  drivers/thermal/thermal_mmio.c                     |   4 +-
  drivers/thermal/uniphier_thermal.c                 |   2 +-
  19 files changed, 800 insertions(+), 859 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
