Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC9067D19B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjAZQ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjAZQ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:27:57 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3348303D3;
        Thu, 26 Jan 2023 08:27:18 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id y19so2362006edc.2;
        Thu, 26 Jan 2023 08:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXHqdCcPXRT2nSdBbLmCFv+i+Lvg2rJEnppDBqcag3U=;
        b=Rkaiv17Gs8+TjPUS7lkKNXQs92CwCaZUggz/jJNqJTkomIWQh8xIh/SVF6uGNTHvPw
         v4TfyYUSAnCkEp6ZZhqQGFp3fXUVIczXjvxc40nFiV1jsnUTVWRFbtsVp5B+qspmUmHI
         kavRKJ/DkaQDOJqyOhOsMDNdfDwe3cIElNget5ZL2q086CFHlKNG0AyRkqkbbV08T9El
         FgUHQjQKRxGN8J6yFsIF5UvzP8QbG8WcZAzOHQzJmU1ex4KRiJhZcgwIOcxe8GmwKCLC
         Xu6BZcD39AsykfvV7hpA5l00D87EsBUQdZD26HK+hcAeO/52RkSsPtP+PV/dRsF5PpP1
         9mOQ==
X-Gm-Message-State: AO0yUKV3CKSyWiSjxnkeKBoOr9Fb48eVXsYNVzSPIav8xAuC0jVpWSkC
        lW4rylIf56FNdpOMILwL9up7bEXh0S+f1B9r5Fs=
X-Google-Smtp-Source: AK7set+96J28LLlE8bZ3cwU+AaROac7WyqkaK9NnC10WWm6KgdEmJSIxtYZTjaoYuV0xPBgnsGSybqhiSQxHqoqvasA=
X-Received: by 2002:aa7:cf98:0:b0:4a0:8abb:fc89 with SMTP id
 z24-20020aa7cf98000000b004a08abbfc89mr2221639edx.50.1674750386549; Thu, 26
 Jan 2023 08:26:26 -0800 (PST)
MIME-Version: 1.0
References: <8317ac88-2ff5-9289-9123-0e222d2da905@linaro.org>
In-Reply-To: <8317ac88-2ff5-9289-9123-0e222d2da905@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Jan 2023 17:26:15 +0100
Message-ID: <CAJZ5v0jWy1BX9_fPo1asLCv8UoY8fa4eJWB6uj5DSqzj7f2Ppw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal changes for v6.3-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Yangtao Li <tiny.windzz@gmail.com>, ye.xingchen@zte.com.cn,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 5:19 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> please consider pulling:
>
> The following changes since commit 3a151494dc04c76add577ae66e8a04f900638aaf:
>
>    thermal/drivers/armada: Use strscpy() to instead of strncpy()
> (2023-01-06 14:14:48 +0100)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.3-rc1
>
> for you to fetch changes up to 8c5ee9155f8ae133070b40ee4be03cafb35c188d:
>
>    thermal/drivers/armada: Use the thermal_zone_get_crit_temp()
> (2023-01-24 12:37:56 +0100)
>
> ----------------------------------------------------------------
> - Fix kerneldoc format errors for Rockchip, Mediatek and Uniphier
>    (Randy Dunlap)
>
> - Add the missing 'qcom,adc-tm7' compatible string in the dt-bindings
>    (Krzysztof Kozlowski)
>
> - Improve the calibration routine by relying on the nvmem to read the
>    values and provide a set of fixes for the QCom tsens driver (Dmitry
>    Baryshkov)
>
> - Remove the duplicate interrupt setting routine in the QCom tsens
>    driver (Daniel Lezcano)
>
> - Fix a wrong loop condition in the i.MX SC thermal driver and add the
>    iMX8QM sensors (Viorel Suman)
>
> - Fix header inclusion asm-generic.h by asm.h for the
>    qcom-spmi-adc-tm5 driver (Andy Shevchenko)
>
> - Use the devm_platform_get_and_ioremap_resource() combo function in
>    all the drivers where the conversion applies (Ye Xingchen)
>
> - Replace a literal mask by an existing corresponding macro (Yangtao
>    Li)
>
> - Add support for MT7986 and MT7981 (Daniel Golle)
>
> - Use thermal_zone_get_crit_temp() for the Armada thermal driver
>    (Daniel Lezcano)
>
> ----------------------------------------------------------------
> Andy Shevchenko (1):
>        thermal/drivers/qcom-spmi-adc-tm5: Use asm intead of asm-generic
>
> Daniel Golle (2):
>        thermal/drivers/mtk: Use function pointer for raw_to_mcelsius
>        thermal/drivers/mtk: Add support for MT7986 and MT7981
>
> Daniel Lezcano (2):
>        thermal/drivers/qcom: Remove duplicate set next trip point
> interrupt code
>        thermal/drivers/armada: Use the thermal_zone_get_crit_temp()
>
> Dmitry Baryshkov (14):
>        dt-bindings: thermal: tsens: add msm8956 compat
>        dt-bindings: thermal: tsens: support per-sensor calibration cells
>        dt-bindings: thermal: tsens: add per-sensor cells for msm8974
>        thermal/drivers/tsens: Drop unnecessary hw_ids
>        thermal/drivers/tsens: Drop msm8976-specific defines
>        thermal/drivers/tsens: Sort out msm8976 vs msm8956 data
>        thermal/drivers/tsens: fix slope values for msm8939
>        thermal/drivers/tsens: limit num_sensors to 9 for msm8939
>        thermal/drivers/tsens: Support using nvmem cells for calibration data
>        thermal/drivers/tsens: Support using nvmem cells for msm8974
> calibration
>        thermal/drivers/tsens: Rework legacy calibration data parsers
>        thermal/drivers/tsens: Drop single-cell code for mdm9607
>        thermal/drivers/tsens: Drop single-cell code for msm8939
>        thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956
>
> Krzysztof Kozlowski (1):
>        dt-bindings: thermal: qcom-spmi-adc-tm5: add qcom,adc-tm7
>
> Rafael J. Wysocki (1):
>        Merge tag 'generic-trip-point' of
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux
>
> Randy Dunlap (3):
>        thermal/drivers/mtk_thermal: Fix kernel-doc function name
>        thermal/drivers/rockchip: Fix kernel-doc warnings
>        thermal/drivers/uniphier: Use regular comment syntax
>
> Viorel Suman (2):
>        thermal/drivers/imx_sc_thermal: Fix the loop condition
>        thermal/drivers/imx_sc_thermal: Add iMX8QM sensors
>
> Yangtao Li (1):
>        thermal/drivers/sun8i: Convert to use macro
>
> ye xingchen (9):
>        thermal/drivers/brcmstb_thermal: Use
> devm_platform_get_and_ioremap_resource()
>        thermal/drivers/bcm2835: Use devm_platform_get_and_ioremap_resource()
>        thermal/drivers/dove: Use devm_platform_get_and_ioremap_resource()
>        thermal/drivers/armada: Use devm_platform_get_and_ioremap_resource()
>        thermal/drivers/mtk_thermal: Use
> devm_platform_get_and_ioremap_resource()
>        thermal/drivers/rockchip: Use
> devm_platform_get_and_ioremap_resource()
>        thermal/drivers/thermal_mmio: Use
> devm_platform_get_and_ioremap_resource()
>        thermal/drivers/kirkwood: Use
> devm_platform_get_and_ioremap_resource()
>        thermal/drivers/spear: Use devm_platform_get_and_ioremap_resource()
>
>   .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |   1 +
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    | 153 ++++-
>   drivers/thermal/armada_thermal.c                   |  42 +-
>   drivers/thermal/broadcom/bcm2835_thermal.c         |   4 +-
>   drivers/thermal/broadcom/brcmstb_thermal.c         |   4 +-
>   drivers/thermal/dove_thermal.c                     |   7 +-
>   drivers/thermal/imx_sc_thermal.c                   |   8 +-
>   drivers/thermal/kirkwood_thermal.c                 |   4 +-
>   drivers/thermal/mtk_thermal.c                      | 149 ++++-
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   3 +-
>   drivers/thermal/qcom/tsens-v0_1.c                  | 655
> ++++++---------------
>   drivers/thermal/qcom/tsens-v1.c                    | 340 +++--------
>   drivers/thermal/qcom/tsens.c                       | 219 +++++--
>   drivers/thermal/qcom/tsens.h                       |  46 +-
>   drivers/thermal/rockchip_thermal.c                 |  10 +-
>   drivers/thermal/spear_thermal.c                    |   4 +-
>   drivers/thermal/sun8i_thermal.c                    |   4 +-
>   drivers/thermal/thermal_mmio.c                     |   4 +-
>   drivers/thermal/uniphier_thermal.c                 |   2 +-
>   19 files changed, 800 insertions(+), 859 deletions(-)
>
> --

Pulled pushed into the linux-next branch in linux-pm.git.

If all goes well, I'll merge it into thermal on Monday.

Thanks!
