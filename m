Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05135654849
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiLVWRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiLVWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:17:28 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A8726AD7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:17:26 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b13so4712795lfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S54q1Ly25fucvW8wy0dU1/tQS+0Zh9k/n0J/KMOoAU0=;
        b=UW/yqmwPTVLenNcJd2Qd9e0NTgzQmDmaeg/bt/1PlCivJ63Y0t909OjvU07U0fiXq5
         F+fAfdqnxDQCZ3CD1hBEotehTTTx9o02Jrp9q4h5qnUGBTYTyZuyM/4nsDCaMpRFE6bn
         yxw1PjO7chlYHaKDLmRK/jM3xriUiZsxpwOJQmd4PMJpNJ5ftd11U64ACeCg8Yo6a02d
         ziaB+GPZOefHkuvljAfNwQo7C5F0DVM2QOHfxosbMflSALoeveHH9J85byzk0nDEFU0y
         rMrqkMl04eBixz/FrvumqndbNMhC/JV4CE0W4pXBfE2zdOsiCkiYVWb1D6f04Jj0wmJT
         DQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S54q1Ly25fucvW8wy0dU1/tQS+0Zh9k/n0J/KMOoAU0=;
        b=TQdnkn1/O6iKPWlpZ+/I8Rb1se5dqx1ibESert1WJqi/AqWsonRY8530kz3aJ2+E+n
         KgJuKrMNP1WzyNhyUvEnq50PXrSK8YzdnJOKFQFJC07VXDT2CK81Hlr3x0YlLENufhJU
         FBWX1w3k2Lx6zK9D2wrMtPBIaLH+K0xj9MP9a367RJowkD+ckHQZtMfUeuiR1yUHzsq4
         8ZGh6Chl4n+ao5Y4XBEXNgKc6O7TIg3DvF4ABBgzcO6cVvDMtoOTueBNCn/bNaELAa/a
         hmS34A8XQmY9B0375SYPhe5xLXf1AVn+6vaYhvqIoOQCQM61IBixGge9EcOakAUuFeCY
         kxjA==
X-Gm-Message-State: AFqh2ko+d1wBrOU2UUEhis7Mmlr2dNKDK82RiJ+B3/h03OiSk3jIPoho
        qKwLOzrNyQHHB9hPN/r9n2VVlA==
X-Google-Smtp-Source: AMrXdXtWAyVvjnaVxKo6msD2MtpwrZhPvPMCjOS4jjqOp4cyiwI3D+yRNc34Pp4Vgq6Bd/bxog2D0g==
X-Received: by 2002:a05:6512:3e0d:b0:4a9:a1f1:3f57 with SMTP id i13-20020a0565123e0d00b004a9a1f13f57mr2962950lfv.50.1671747445066;
        Thu, 22 Dec 2022 14:17:25 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x11-20020a0565123f8b00b004b5adb59ed5sm222468lfa.297.2022.12.22.14.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 14:17:23 -0800 (PST)
Message-ID: <71bf6521-71d7-ec45-912f-e3dc6038d3a4@linaro.org>
Date:   Fri, 23 Dec 2022 00:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] scsi: ufs: ufs-qcom: add basic interconnect support
Content-Language: en-GB
To:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20221117104957.254648-1-bmasney@redhat.com>
 <20221117104957.254648-2-bmasney@redhat.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221117104957.254648-2-bmasney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 12:49, Brian Masney wrote:
> The firmware on the Qualcomm platforms expects the interconnect votes to
> be present. Let's add very basic support where the maximum throughput is
> requested to match what's done in a few other drivers.
> 
> This will not break boot on systems where the interconnects and
> interconnect-names properties are not specified in device tree for UFS
> since the interconnect framework will silently return.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>   drivers/ufs/host/ufs-qcom.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 8ad1415e10b6..55bf8dd88985 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -7,6 +7,7 @@
>   #include <linux/time.h>
>   #include <linux/clk.h>
>   #include <linux/delay.h>
> +#include <linux/interconnect.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
> @@ -936,6 +937,22 @@ static const struct reset_control_ops ufs_qcom_reset_ops = {
>   	.deassert = ufs_qcom_reset_deassert,
>   };
>   
> +static int ufs_qcom_icc_init(struct device *dev, char *pathname)
> +{
> +	struct icc_path *path;
> +	int ret;
> +
> +	path = devm_of_icc_get(dev, pathname);
> +	if (IS_ERR(path))
> +		return dev_err_probe(dev, PTR_ERR(path), "failed to acquire interconnect path\n");
> +
> +	ret = icc_set_bw(path, 0, UINT_MAX);

I noticed that this patch bumps peak_bw (and leaves average_bw as 0), 
while vendor kernels bump average_bw, but ib (peak_bw) is set to 0.

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to set bandwidth request\n");
> +
> +	return 0;
> +}
> +
>   /**
>    * ufs_qcom_init - bind phy with controller
>    * @hba: host controller instance
> @@ -991,6 +1008,14 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>   			err = dev_err_probe(dev, PTR_ERR(host->generic_phy), "Failed to get PHY\n");
>   			goto out_variant_clear;
>   		}
> +
> +		err = ufs_qcom_icc_init(dev, "ufs-ddr");
> +		if (err)
> +			goto out_variant_clear;
> +
> +		err = ufs_qcom_icc_init(dev, "cpu-ufs");
> +		if (err)
> +			goto out_variant_clear;
>   	}
>   
>   	host->device_reset = devm_gpiod_get_optional(dev, "reset",

-- 
With best wishes
Dmitry

