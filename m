Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5942968D96F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjBGNdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjBGNde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:33:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13473252C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:33:22 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o18so13571050wrj.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Gnj8mx6BQv+P/VZTc2ZRvZ4cPWBzn/d/g1R6N3t1SY=;
        b=sywB6VKP5uMO4iMwIfYWNewUXqdyUmfAHNyhyo3OrdI4w9hMA/do0JdT6XDgbayfL+
         hioKOeqNB9gmBTeOJ+GEqRzkacs91bBLXr18APnsVAUBpOFSSsRR/mPgDw2PAZiSngST
         GHN3F7C6RRw0zyStZrcDu6HUwZTZEJW9//HKZNnFr8pbdBYO0ZeQTSQ1wJUc9qr39WDw
         RAZprI560qB9/D7SJ2L2mhHzMzvqn4IkElOgb3RhfyiCRKxMOqVm8can1xTMfSUuQzTl
         3d/Otz4g9TJG3uwzIfUqVNKE0lVe3mXM4bFnaRqiGH/VF2JhF06rxIQG2kcu+KI3CJbC
         UTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Gnj8mx6BQv+P/VZTc2ZRvZ4cPWBzn/d/g1R6N3t1SY=;
        b=qJOxwNe9xRUWqXyroSxFvWufWDfBTUMUtwLx28nGy+pny2ojxLlEqKvqQllCDeJDGz
         mxFmJl3v3NfB17AMquAfgnJKg+UQByl6YNxFX/CjkRi2FtTE1iJ8Sx1Auzl2N6YBY/yx
         NWK9YD44+KVfONupJFOEXW7tkLmotZfFK6p5WWIlCowYjIk4oWGaP+lOh7b1HqEPUiSb
         IA5kJUMabB1pW0MoI/87IO04Fkh12hxMiiI0M1TueemcQrgSrF9lwLPWZt5MWIWE25lQ
         r5e++IOt5BlhDWo4StczGjw1k5wHBIV31LiIzWMNRk4X8cMTqZNcPZjfwOqYGM/iOSFx
         VqKg==
X-Gm-Message-State: AO0yUKUO8B2vZbW6qlmXRthEP0dkdvbW7XP1NLCm7+RxM/xk+ftRdmZ8
        PbSe6eKZX7mvvPI2BVm259afWw==
X-Google-Smtp-Source: AK7set9tflq7m2WGhWzU48ho/FGtJPjdoU4DUvNTQOyFDfwfzYJ/cgrUGOgVxSNmGa0o1E+FD6YRHA==
X-Received: by 2002:a05:6000:1b0f:b0:2c3:ea4d:3f01 with SMTP id f15-20020a0560001b0f00b002c3ea4d3f01mr2338118wrz.27.1675776801421;
        Tue, 07 Feb 2023 05:33:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c58c:fc5c:67d6:e5f3? ([2a01:e0a:982:cbb0:c58c:fc5c:67d6:e5f3])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d4601000000b002bdfe3aca17sm11241983wrq.51.2023.02.07.05.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 05:33:21 -0800 (PST)
Message-ID: <e8e983a7-5dac-507d-414e-0fdc1082644a@linaro.org>
Date:   Tue, 7 Feb 2023 14:33:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] thermal: Remove core header inclusion from drivers
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "open list:THERMAL DRIVER FOR AMLOGIC SOCS" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 16:34, Daniel Lezcano wrote:
> As the name states "thermal_core.h" is the header file for the core
> components of the thermal framework.
> 
> Too many drivers are including it. Hopefully the recent cleanups
> helped to self encapsulate the code a bit more and prevented the
> drivers to need this header.
> 
> Remove this inclusion in every place where it is possible.
> 
> Some other drivers did a confusion with the core header and the one
> exported in linux/thermal.h. They include the former instead of the
> latter. The changes also fix this.
> 
> The tegra/soctherm driver still remains as it uses an internal
> function which need to be replaced.
> 
> The Intel HFI driver uses the netlink internal framework core and
> should be changed to prevent to deal with the internals.
> 
> No functional changes
> 
> [ Applies to thermal/linux-next or linux-pm/linux-next ]
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/amlogic_thermal.c           | 1 -
>   drivers/thermal/armada_thermal.c            | 2 --
>   drivers/thermal/broadcom/bcm2835_thermal.c  | 1 -
>   drivers/thermal/hisi_thermal.c              | 3 +--
>   drivers/thermal/imx8mm_thermal.c            | 1 -
>   drivers/thermal/imx_sc_thermal.c            | 1 -
>   drivers/thermal/intel/intel_hfi.c           | 3 ++-
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 1 -
>   drivers/thermal/qoriq_thermal.c             | 1 -
>   drivers/thermal/rcar_gen3_thermal.c         | 1 -
>   drivers/thermal/samsung/exynos_tmu.c        | 3 +--
>   drivers/thermal/st/stm_thermal.c            | 1 -
>   drivers/thermal/tegra/tegra30-tsensor.c     | 1 -
>   drivers/thermal/uniphier_thermal.c          | 2 --
>   14 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index d30cb791e63c..9235fda4ec1e 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -28,7 +28,6 @@
>   #include <linux/regmap.h>
>   #include <linux/thermal.h>
>   
> -#include "thermal_core.h"
>   #include "thermal_hwmon.h"
>   
>   #define TSENSOR_CFG_REG1			0x4

For Amlogic:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

<snip>

