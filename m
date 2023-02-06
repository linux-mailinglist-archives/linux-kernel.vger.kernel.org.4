Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA13268C24B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjBFPxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjBFPxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:53:31 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325B429E01;
        Mon,  6 Feb 2023 07:53:21 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 635361C000A;
        Mon,  6 Feb 2023 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675698800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+B3RCvnN/A9QkWUBTmslla6TsR6i6LzRlnEYAv5F3Q=;
        b=Qtjb3GZlond/VqhH1wI9WqFkUTwIx6Xv+zssCdcz0vlldDafEWSB06zZ//x0Ak5PkC5s9y
        ZxfUTza51NQilgjwYbUeD93lWl0YkGanyt4N/HQcJQmS+KroZcFE/xfTkRSM2sxsdcGf1f
        20SxBUIoivwiZ6s9aJ+ixE2geS9izQBcTC0BtnofMVoclnJKbVIB5QEvwsdQxDRVvnTztn
        mWfYNVZzBBsywzjxDjc3HnjZoENi2lYxasHSm8kpUEw2am/dKrdmudXoC8BSbNJ5qS4nRi
        XqyYsA8WsUcyWOY6WGG+PMMJLyhBUYj2TKKx+CBVhWfLPP7d+4gsOsJ9cAGaug==
Date:   Mon, 6 Feb 2023 16:53:11 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
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
        Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
        <niklas.soderlund@ragnatech.se>,
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
        linux-amlogic@lists.infradead.org (open list:THERMAL DRIVER FOR AMLOGIC
        SOCS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS),
        linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: Re: [PATCH] thermal: Remove core header inclusion from drivers
Message-ID: <20230206165311.0777ec69@xps-13>
In-Reply-To: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
References: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

daniel.lezcano@linaro.org wrote on Mon,  6 Feb 2023 16:34:29 +0100:

> As the name states "thermal_core.h" is the header file for the core
> components of the thermal framework.
>=20
> Too many drivers are including it. Hopefully the recent cleanups
> helped to self encapsulate the code a bit more and prevented the
> drivers to need this header.
>=20
> Remove this inclusion in every place where it is possible.
>=20
> Some other drivers did a confusion with the core header and the one
> exported in linux/thermal.h. They include the former instead of the
> latter. The changes also fix this.
>=20
> The tegra/soctherm driver still remains as it uses an internal
> function which need to be replaced.
>=20
> The Intel HFI driver uses the netlink internal framework core and
> should be changed to prevent to deal with the internals.
>=20
> No functional changes
>=20
> [ Applies to thermal/linux-next or linux-pm/linux-next ]
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/amlogic_thermal.c           | 1 -
>  drivers/thermal/armada_thermal.c            | 2 --

For armada_thermal.c:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

>  drivers/thermal/broadcom/bcm2835_thermal.c  | 1 -
>  drivers/thermal/hisi_thermal.c              | 3 +--
>  drivers/thermal/imx8mm_thermal.c            | 1 -
>  drivers/thermal/imx_sc_thermal.c            | 1 -
>  drivers/thermal/intel/intel_hfi.c           | 3 ++-
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 1 -
>  drivers/thermal/qoriq_thermal.c             | 1 -
>  drivers/thermal/rcar_gen3_thermal.c         | 1 -
>  drivers/thermal/samsung/exynos_tmu.c        | 3 +--
>  drivers/thermal/st/stm_thermal.c            | 1 -
>  drivers/thermal/tegra/tegra30-tsensor.c     | 1 -
>  drivers/thermal/uniphier_thermal.c          | 2 --
>  14 files changed, 4 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_=
thermal.c
> index d30cb791e63c..9235fda4ec1e 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -28,7 +28,6 @@
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
> =20
> -#include "thermal_core.h"
>  #include "thermal_hwmon.h"
> =20
>  #define TSENSOR_CFG_REG1			0x4

Thanks,
Miqu=C3=A8l
