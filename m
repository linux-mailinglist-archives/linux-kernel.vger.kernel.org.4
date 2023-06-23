Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD1973BAE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjFWO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFWO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:58:38 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5C4172C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:58:37 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b4790ff688so12912801fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687532315; x=1690124315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8iZIJHkItLzlXB/SuaNbWjOORPBzNehh8JHCznNClo8=;
        b=bZhD81QjHVE8sLn30+Dd41TV0wM7G4i/8DkeEXF1eJQxsHb+olly0T23rqvbY53Aue
         YnuNAoZOej/1SEdDY8GxulmTxZXtGgeH8m51x+RLe1q/+B/kCht9hWVr9Pw5/11m11DK
         E6W424mcqrNxWxU4XRDBHgjhhadtXSCSIBq8ggbZVEGQAFdIxxejy3MQ57+naN9oACIa
         hhWd7zLtyCpQoyZ0DTrEo2U1qfDes1gHK0EgxIc7WaTo066x3U0QqvqN3SugjYAH0vEI
         v/1AqIgzbBNN9LdKQ6jVw8U6XGNfBp9l9bsfBIRXL86WjJ1MNtUpuCIkZJ5RZm/Qkczl
         Ytcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532315; x=1690124315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iZIJHkItLzlXB/SuaNbWjOORPBzNehh8JHCznNClo8=;
        b=L6LKflHDijiDiDITTgDn1lJDmAfCb1saYDn7wdQ2a2z5Up/swgTpSqLm4aN04NRTED
         u7JepYmCAHbPPLhTCLO1GVAMKQiaN1e+dtx3uR0uUODrMhwN+y0oy39EBjn/d9xWb+Q9
         7lrvieutL3uYx61w6Jl09A9uYrhghPTZpVAUCfiUdAUDonaJSkeobxGx+IOQ/AIz3tGL
         nSY+cI9//wp/eL999mpSNgsKGY/QXCqihRxtGnHtg/gnRe56dnDRHSLp7zidQExOk8nx
         8iXdBYNJ9lVhk0FhCU/THwz/YX4q50NBf5mdYGASWjU6Msj5OivIn3KNYaiqA7nDk9vr
         uvyw==
X-Gm-Message-State: AC+VfDxjKXoCBN+B7YtleUV2MaOathK+Tv4MS3KgJhtk2t1TbB8/KOEi
        x4tFvoGAYSZykdEkRK90i8i9eA==
X-Google-Smtp-Source: ACHHUZ5UNgjRV3IV53BdUnHm0xskpC+nJbc1ZFFx10PdV6FKFLVu9EqMffd5rt/yKNDNP8AJppix9A==
X-Received: by 2002:a2e:3e13:0:b0:2b5:813c:b74f with SMTP id l19-20020a2e3e13000000b002b5813cb74fmr6319924lja.5.1687532315261;
        Fri, 23 Jun 2023 07:58:35 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id p14-20020a2e9a8e000000b002b58eb44badsm753175lji.106.2023.06.23.07.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 07:58:34 -0700 (PDT)
Message-ID: <b84b2bfc-6f8f-f50f-27b5-52a982ae30f2@linaro.org>
Date:   Fri, 23 Jun 2023 16:58:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 5/6] soc: qcom: Add LLCC support for multi channel DDR
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-6-quic_kbajaj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230623141806.13388-6-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.2023 16:18, Komal Bajaj wrote:
> Add LLCC support for multi channel DDR configuration
> based on a feature register. Reading DDR channel
> confiuration uses nvmem framework, so select the
> dependency in Kconfig. Without this, there will be
> errors while building the driver with COMPILE_TEST only.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  drivers/soc/qcom/Kconfig     |  2 ++
>  drivers/soc/qcom/llcc-qcom.c | 33 ++++++++++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a491718f8064..cc9ad41c63aa 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -64,6 +64,8 @@ config QCOM_LLCC
>  	tristate "Qualcomm Technologies, Inc. LLCC driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	select REGMAP_MMIO
> +	select NVMEM
> +	select QCOM_SCM
>  	help
>  	  Qualcomm Technologies, Inc. platform specific
>  	  Last Level Cache Controller(LLCC) driver for platforms such as,
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 6cf373da5df9..3c29612da1c5 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> @@ -943,6 +944,19 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index)
> +{
> +	int ret;
> +
> +	ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
> +	if (ret == -ENOENT) {
> +		*cfg_index = 0;
> +		return 0;
> +	}
> +
> +	return ret;
> +}
> +
>  static int qcom_llcc_remove(struct platform_device *pdev)
>  {
>  	/* Set the global pointer to a error code to avoid referencing it */
> @@ -975,11 +989,13 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	int ret, i;
>  	struct platform_device *llcc_edac;
> -	const struct qcom_llcc_config *cfg;
> +	const struct qcom_llcc_config *cfg, *entry;
>  	const struct llcc_slice_config *llcc_cfg;
>  	u32 sz;
> +	u8 cfg_index;
>  	u32 version;
>  	struct regmap *regmap;
> +	u32 num_entries = 0;
>  
>  	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>  	if (!drv_data) {
> @@ -1040,8 +1056,19 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  
>  	drv_data->version = version;
>  
> -	llcc_cfg = cfg[0]->sct_data;
> -	sz = cfg[0]->size;
> +	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
> +	if (ret)
> +		goto err;
> +


> +	for (entry = cfg; entry->sct_data; entry++, num_entries++)
> +		;
> +	if (cfg_index >= num_entries || cfg_index < 0) {
cfg_index is an unsigned variable, it can never be < 0

> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
if (cfg_index >= entry->size)? With that, you can also keep the config
entries non-0-terminated in the previous patch, saving a whole lot of RAM.

Konrad
> +	llcc_cfg = cfg[cfg_index].sct_data;
> +	sz = cfg[cfg_index].size;
>  
>  	for (i = 0; i < sz; i++)
>  		if (llcc_cfg[i].slice_id > drv_data->max_slices)
