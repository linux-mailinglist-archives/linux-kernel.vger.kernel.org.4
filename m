Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2476A6B33
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCAK7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCAK7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:59:23 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583BB3AA1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:59:21 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id h3so13492245lja.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 02:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3ZhRJHh4DWKDcNXBiie21WCRUSPF0das6G0cLZ3qog=;
        b=XsvQ3Xnkmy2gzsu8cozXUgqwPOCPwP+O2cs9jRE/4nNUmcCvlSUcPObumqXrtypi9V
         GPwvQzCIKsbtuv/U0/Tv4Ccv5RsGfb7Fi7kuJKQOf2flAd3u7C5o57LS5t8pgZNi3Sxv
         C00yngvUzAPJHnqHyUV5zxaq61DVL7LdDpie+OiyMK+/NAl/9HbrMLvvpQ/XDX54IfaT
         fEKoBmOHhYecZ53X7DRvgFlg2FenQBn0O9dYf/FDCsvQhELx0jCd5lnZ3Ozb2qEV0df3
         xvO/WwcuqDrX7cESFEZPfjjOnkw2ytzGsYHsVhg33MNqNxexWKeD9y/cH97I+t9k8Kg1
         yYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3ZhRJHh4DWKDcNXBiie21WCRUSPF0das6G0cLZ3qog=;
        b=NYT0vWh4da3eHtVEE+jymaFbyRk3+jx6TdVde2XbT8HcYQiBPxlmwE16AOJ944cGSF
         ND4jZKDByzCN1YhvXqBQjTRrNJxkqvFfCEMS7TuP/LotnlnM3F5g4F8qfZ4IF34dQIkh
         UlOQ8k+jU4K1yDgZII5kux+J3FNyDZih0t7MWuJx0MiIw/oFXuTlGebRdROlEVDO5wT+
         yaHuYUyyns+vZ2WDgC4Nx8Uj1r21dOaqGp6IRrrn/svPHeCBVdFKf2vE+ZK28QXoCG7R
         vkf1zFOsVCw5C/LSOF8MqXkOlnp8omdoGRz+6fvN0nEQxKvOkE48kB3JU9gO7WmBd+tf
         Xn9g==
X-Gm-Message-State: AO0yUKVDYeH/r82OmG7KtRgAECuypoCisVFreMhZh2HbjtHLeuKu2HA+
        /Lj5M9aelyyWLA+Zvm55NndJnQ==
X-Google-Smtp-Source: AK7set9GZ1CPZphxS+QpwK9OkBK6/QNjk8eMHF5wjHJVeqVVDVcHSfRMWnRPp2IM0cfQTAGw3DMf9Q==
X-Received: by 2002:a05:651c:a05:b0:295:b0aa:978a with SMTP id k5-20020a05651c0a0500b00295b0aa978amr4001546ljq.6.1677668359564;
        Wed, 01 Mar 2023 02:59:19 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id k19-20020a2ea273000000b00295a36fedadsm1618479ljm.26.2023.03.01.02.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 02:59:19 -0800 (PST)
Message-ID: <469b4a3a-ea40-ad6b-2848-210325b8914c@linaro.org>
Date:   Wed, 1 Mar 2023 12:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/4] firmware: qcom_scm: Refactor code to support
 multiple download mode
Content-Language: en-GB
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1677664555-30191-1-git-send-email-quic_mojha@quicinc.com>
 <1677664555-30191-4-git-send-email-quic_mojha@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1677664555-30191-4-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 11:55, Mukesh Ojha wrote:
> Currently on Qualcomm SoC, download_mode is enabled if
> CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is selected.
> 
> Refactor the code such that it supports multiple download
> modes and drop CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT config
> instead, give interface to set the download mode from
> module parameter.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v2:
>   - Passed download mode as parameter
>   - Accept human accepatable download mode string.
>   - enable = !!dload_mode
>   - Shifted module param callback to somewhere down in
>     the file so that it no longer need to know the
>     prototype of qcom_scm_set_download_mode()
>   - updated commit text.
> 
>   drivers/firmware/Kconfig    | 11 --------
>   drivers/firmware/qcom_scm.c | 65 ++++++++++++++++++++++++++++++++++++++-------
>   2 files changed, 56 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b59e304..ff7e9f3 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -215,17 +215,6 @@ config MTK_ADSP_IPC
>   config QCOM_SCM
>   	tristate
>   
> -config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> -	bool "Qualcomm download mode enabled by default"
> -	depends on QCOM_SCM
> -	help
> -	  A device with "download mode" enabled will upon an unexpected
> -	  warm-restart enter a special debug mode that allows the user to
> -	  "download" memory content over USB for offline postmortem analysis.
> -	  The feature can be enabled/disabled on the kernel command line.
> -
> -	  Say Y here to enable "download mode" by default.
> -
>   config SYSFB
>   	bool
>   	select BOOT_VESA_SUPPORT
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index c9f1fad..ca07208 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -17,17 +17,22 @@
>   #include <linux/clk.h>
>   #include <linux/reset-controller.h>
>   #include <linux/arm-smccc.h>
> +#include <linux/kstrtox.h>
>   
>   #include "qcom_scm.h"
>   
> -static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
> -module_param(download_mode, bool, 0);
> -
>   #define SCM_HAS_CORE_CLK	BIT(0)
>   #define SCM_HAS_IFACE_CLK	BIT(1)
>   #define SCM_HAS_BUS_CLK		BIT(2)
>   
>   #define QCOM_DOWNLOAD_MODE_MASK 0x30
> +#define QCOM_DOWNLOAD_FULLDUMP	0x10
> +#define QCOM_DOWNLOAD_NODUMP	0x0
> +
> +#define MAX_DLOAD_LEN	8
> +
> +static char download_mode[] = "off";
> +static u32 dload_mode;
>   
>   struct qcom_scm {
>   	struct device *dev;
> @@ -417,8 +422,9 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>   	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>   }
>   
> -static void qcom_scm_set_download_mode(bool enable)
> +static void qcom_scm_set_download_mode(u32 dload_mode)
>   {
> +	bool enable = !!dload_mode;
>   	bool avail;
>   	int ret = 0;
>   	u32 val;
> @@ -438,7 +444,7 @@ static void qcom_scm_set_download_mode(bool enable)
>   
>   		val &= ~QCOM_DOWNLOAD_MODE_MASK;
>   		if (enable)
> -			val |= QCOM_SCM_BOOT_SET_DLOAD_MODE;
> +			val |= dload_mode;
>   
>   		ret = qcom_scm_io_writel(__scm->dload_mode_addr, val);
>   	} else {
> @@ -1338,6 +1344,47 @@ bool qcom_scm_is_available(void)
>   }
>   EXPORT_SYMBOL(qcom_scm_is_available);
>   
> +static int set_dload_mode(const char *val, const struct kernel_param *kp)
> +{
> +	int ret;
> +
> +	if (!strncmp(val, "full", strlen("full"))) {
> +		dload_mode = QCOM_DOWNLOAD_FULLDUMP;
> +	} else if (!strncmp(val, "off", strlen("off"))) {
> +		dload_mode = QCOM_DOWNLOAD_NODUMP;
> +	} else {
> +		if (kstrtouint(val, 0, &dload_mode) ||
> +		     !(dload_mode == 0 || dload_mode == 1)) {
> +			pr_err("unknown download mode\n");
> +			return -EINVAL;
> +		}
> +
> +	}
> +
> +	ret = param_set_copystring(val, kp);
> +	if (ret)
> +		return ret;
> +
> +	if (__scm)
> +		qcom_scm_set_download_mode(dload_mode);
> +
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops dload_mode_param_ops = {
> +	.set = set_dload_mode,
> +	.get = param_get_string,

Please follow the param_get_bool approach and return sanitized data 
here. In other words, "full" / "none" depending on the dload_mode 
instead of storing the passed string and returning it later.

> +};
> +
> +static struct kparam_string dload_mode_param = {
> +	.string = download_mode,
> +	.maxlen = MAX_DLOAD_LEN,

I think writing "full" to this param might overwrite some kernel data. 
"00000000" should be even worse.

> +};
> +
> +module_param_cb(download_mode, &dload_mode_param_ops, &dload_mode_param, 0644);
> +MODULE_PARM_DESC(download_mode,
> +		 "Download mode: off/full or 0/1/off/on for existing users");

Nit: on is not supported even for existing users.

> +
>   static int qcom_scm_probe(struct platform_device *pdev)
>   {
>   	struct qcom_scm *scm;
> @@ -1418,12 +1465,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   	__get_convention();
>   
>   	/*
> -	 * If requested enable "download mode", from this point on warmboot
> +	 * If download mode is requested, from this point on warmboot
>   	 * will cause the boot stages to enter download mode, unless
>   	 * disabled below by a clean shutdown/reboot.
>   	 */
> -	if (download_mode)
> -		qcom_scm_set_download_mode(true);
> +	if (dload_mode)
> +		qcom_scm_set_download_mode(dload_mode);
>   
>   	return 0;
>   }
> @@ -1431,7 +1478,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   static void qcom_scm_shutdown(struct platform_device *pdev)
>   {
>   	/* Clean shutdown, disable download mode to allow normal restart */
> -	qcom_scm_set_download_mode(false);
> +	qcom_scm_set_download_mode(QCOM_DOWNLOAD_NODUMP);
>   }
>   
>   static const struct of_device_id qcom_scm_dt_match[] = {

-- 
With best wishes
Dmitry

