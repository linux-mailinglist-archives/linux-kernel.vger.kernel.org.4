Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DC25B7A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiIMS7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiIMS7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:59:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E94F10FD4;
        Tue, 13 Sep 2022 11:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0930FB80EA6;
        Tue, 13 Sep 2022 18:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C84C433C1;
        Tue, 13 Sep 2022 18:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663095218;
        bh=0UHL9X5kgyWj+NLPd/bEfJSZS2AtaN7mXUf8u0gARD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMbZ/mk48Lh9NwUQIWnV/WCFj/g+zygEKTlMs8Gw6Ygyb1SvD1lAeIb2Nux74gN91
         J2nSl1M6+qsXOX+yf5NOuxSvrkgWteRAVqVGS96rJGiTp2afX7bo4wYA/tQbGhNolu
         DbO6MT9M/PAAPYr1rvMeCk3sn+oMS6e6nwuA1r8w1vkdLxtgxJefX9KGaqPSqfP6zU
         VjXpfR9VCT6VzwSDSlTaoaqP1kNtM0Iw+sYFByKJ0/KirApQj20PGkaqmwhNje++sO
         0K6FGXluD5Li8wKnToKp4HLezXAlFg2gqYxJ/7Ue/UuhFByIf/rlhayJuNuxWWiFPj
         QJlmBwK8fG2zg==
Date:   Tue, 13 Sep 2022 13:53:36 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        robh@kernel.org, rafael@kernel.org, bhupesh.linux@gmail.com
Subject: Re: [PATCH 2/4] thermal: qcom: Add Kconfig entry & compilation
 support for qmi cooling driver
Message-ID: <20220913185336.zbe3633yulm65og6@builder.lan>
References: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
 <20220912085049.3517140-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912085049.3517140-3-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 02:20:47PM +0530, Bhupesh Sharma wrote:
> Add Kconfig entry & compilation support for Qualcomm qmi cooling driver.
> 

There's no reason for introducing this in a separate patch...

> Cc: daniel.lezcano@linaro.org
> Cc: rafael@kernel.org
> Cc: andersson@kernel.org
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/thermal/qcom/Kconfig              |  4 ++++
>  drivers/thermal/qcom/Makefile             |  2 ++
>  drivers/thermal/qcom/qmi_cooling/Kconfig  | 14 ++++++++++++++
>  drivers/thermal/qcom/qmi_cooling/Makefile |  3 +++
>  4 files changed, 23 insertions(+)
>  create mode 100644 drivers/thermal/qcom/qmi_cooling/Kconfig
>  create mode 100644 drivers/thermal/qcom/qmi_cooling/Makefile
> 
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index ccfd090273c1..d383b2cf4c7f 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -53,3 +53,7 @@ config QCOM_LMH
>  	  input from temperature and current sensors.  On many newer Qualcomm SoCs
>  	  LMh is configured in the firmware and this feature need not be enabled.
>  	  However, on certain SoCs like sdm845 LMh has to be configured from kernel.
> +
> +menu "Qualcomm QMI cooling drivers"
> +source "drivers/thermal/qcom/qmi_cooling/Kconfig"

...except for the fact that I missed that you put the new driver in a
new directory, with new Kconfig menu etc.

Please just name your files appropriately and put them in
drivers/thermal/qcom directly.

Regards,
Bjorn

> +endmenu
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index 0fa2512042e7..61114129827a 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -1,4 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_QCOM_QMI_COOLING)	+= qmi_cooling/
> +
>  obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
>  
>  qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
> diff --git a/drivers/thermal/qcom/qmi_cooling/Kconfig b/drivers/thermal/qcom/qmi_cooling/Kconfig
> new file mode 100644
> index 000000000000..96488181cd5f
> --- /dev/null
> +++ b/drivers/thermal/qcom/qmi_cooling/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config QCOM_QMI_COOLING
> +	tristate "Qualcomm QMI cooling drivers"
> +	depends on QCOM_RPROC_COMMON
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select QCOM_QMI_HELPERS
> +	help
> +	   This enables the remote subsystem cooling devices. These cooling
> +	   devices will be used by Qualcomm chipset to place various remote
> +	   subsystem mitigations like remote processor passive mitigation,
> +	   remote subsystem voltage restriction at low temperatures etc.
> +	   The QMI cooling device will interface with remote subsystem
> +	   using Qualcomm remoteproc interface.
> diff --git a/drivers/thermal/qcom/qmi_cooling/Makefile b/drivers/thermal/qcom/qmi_cooling/Makefile
> new file mode 100644
> index 000000000000..ea6cb3c8adb0
> --- /dev/null
> +++ b/drivers/thermal/qcom/qmi_cooling/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_QCOM_QMI_COOLING)	+= qcom_cooling.o
> +qcom_cooling-y			+= qcom_tmd_services.o qcom_qmi_cooling.o
> -- 
> 2.37.1
> 
