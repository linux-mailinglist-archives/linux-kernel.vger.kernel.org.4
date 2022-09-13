Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615A55B7A59
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiIMS6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiIMS5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:57:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A64AEB4;
        Tue, 13 Sep 2022 11:51:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B99E6B80EA6;
        Tue, 13 Sep 2022 18:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4055C433D6;
        Tue, 13 Sep 2022 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663095093;
        bh=VpyC8lUP63HV4xeVdsJSfKE7jnXv9o0yRKVx04lPK5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RICEpambJkz/GD/KM08LAU1KfanG8H+Ycjf0MNU8HEkyDZHW89q44bpcLfniSe6Bz
         LFvr6ZVsH20fvRmBL23Q5Nh+SzuKVzW+zdv+DM9cyX0k9HR0E0kImJ3GkM1HGk0kVh
         5MnDxAl/TlZlGZN4opSxi3TrKMgHM8LBrkeF+pGUZmCeowxewMrS+eOYyWEGifFmd2
         ZWBKY5RQ9aXw1JXmsepYtTSusuJ6u8urTRZ7X0W8KKNxLpyOF63S+LWnyRdhqOwb+j
         ONbeAoM7VFoo6TI4OhhvG39pbXsKglfPL70XxxScXqb2jMZu7CVrSe3A5CqjpXCvXT
         gCROjv9XpD5YQ==
Date:   Tue, 13 Sep 2022 13:51:30 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, rafael@kernel.org,
        dmitry.baryshkov@linaro.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: Introduce CONFIG_QCOM_THERMAL in
 Makefile and qcom/Kconfig
Message-ID: <20220913185130.4eui3q2cvwjn4t7x@builder.lan>
References: <20220912194028.3584378-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912194028.3584378-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 01:10:27AM +0530, Bhupesh Sharma wrote:
> Introduce CONFIG_QCOM_THERMAL to allow better control
> over selection of various Qualcomm Thermal drivers
> available inside qcom/ directory.
> 
> This is a preparatory change to allow new drivers to
> be added inside qcom/ directory in a more structured
> fashion later-on.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
> - v1 can be viewed here: https://www.spinics.net/lists/kernel/msg4510793.html
> - Fixed review comments from Dmitry received in v1.
> 
>  drivers/thermal/Makefile     |  2 +-
>  drivers/thermal/qcom/Kconfig | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index def8e1a0399c..2506c6c8ca83 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -52,7 +52,7 @@ obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
>  obj-y				+= intel/
>  obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
>  obj-y				+= st/
> -obj-$(CONFIG_QCOM_TSENS)	+= qcom/
> +obj-y				+= qcom/

This change makes sense to me. Please send this as a separate patch.

>  obj-y				+= tegra/
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>  obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index 2c7f3f9a26eb..ccfd090273c1 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -1,8 +1,17 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +config QCOM_THERMAL

As written here this would allow you to make things conditional on any
Qualcomm thermal code being enabled in any form. But I'm afraid I don't
understand the purpose of this.

Alternatively if you had made below additions depends on QCOM_THERMAL
this would have "cleaned up" the menuconfig slightly. But IMHO there
isn't a lot of benefit to this (and we'd end up with people running
without thermal drivers, as they forget to set CONFIG_QCOM_THERMAL).

> +	tristate "Thermal drivers on Qualcomm Snapdragon series of SoCs"
> +	help
> +	  Support for thermal drivers on Qualcomm Snapdragon series of SoCs.
> +	  There are several thermal sensors available on the Qualcomm Socs
> +	  which can be used for thermal mitigation purposes.

This help text indicates that the option actually changes something or
enables some support for something, but afaict it doesn't.

Regards,
Bjorn
> +
>  config QCOM_TSENS
>  	tristate "Qualcomm TSENS Temperature Alarm"
>  	depends on NVMEM_QCOM_QFPROM
>  	depends on ARCH_QCOM || COMPILE_TEST
> +	select QCOM_THERMAL
>  	help
>  	  This enables the thermal sysfs driver for the TSENS device. It shows
>  	  up in Sysfs as a thermal zone with multiple trip points. Disabling the
> @@ -15,6 +24,7 @@ config QCOM_SPMI_ADC_TM5
>  	depends on OF && SPMI && IIO
>  	select REGMAP_SPMI
>  	select QCOM_VADC_COMMON
> +	select QCOM_THERMAL
>  	help
>  	  This enables the thermal driver for the ADC thermal monitoring
>  	  device. It shows up as a thermal zone with multiple trip points.
> @@ -25,6 +35,7 @@ config QCOM_SPMI_TEMP_ALARM
>  	tristate "Qualcomm SPMI PMIC Temperature Alarm"
>  	depends on OF && SPMI && IIO
>  	select REGMAP_SPMI
> +	select QCOM_THERMAL
>  	help
>  	  This enables a thermal sysfs driver for Qualcomm plug-and-play (QPNP)
>  	  PMIC devices. It shows up in sysfs as a thermal sensor with multiple
> @@ -35,6 +46,7 @@ config QCOM_SPMI_TEMP_ALARM
>  config QCOM_LMH
>  	tristate "Qualcomm Limits Management Hardware"
>  	depends on ARCH_QCOM && QCOM_SCM
> +	select QCOM_THERMAL
>  	help
>  	  This enables initialization of Qualcomm limits management
>  	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on
> -- 
> 2.37.1
> 
