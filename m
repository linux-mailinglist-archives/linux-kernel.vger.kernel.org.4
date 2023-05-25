Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75AD711A82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjEYXSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbjEYXSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:18:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F2DE56
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:18:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f3a9ad31dbso63516e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685056699; x=1687648699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVpMlft04baQe3FGBQ1uPFAK60NKjDWRg8PgqN8ZkKs=;
        b=GWTOtMpfSAgViyuzSRA6mbYzXhGs2FqqTAwIzKk3x37OoFGbj85vDXPTmX+X0nyUPj
         lG1Fhx76fjwSnGCNkjGDFbwZWQzxlot5ZPq2QY+XP7yxKv+C6/LY4US57qZgGBn+RJZ4
         CVWdzs0wvNq8SCL04pSVU9U2QvGY3cLy21bZakUGE299pqo26qW40fk0z1F5Mb0I2Cev
         5V/EoO9gAIuMbozA/5zAWCi8KYlQOv5YvyrecOuybW2ze6N7yRHa+ge0NWYZJCRnyz14
         wvgY/Qo55yWcXyOTKZIrc6eqQa1xrO+v8yHLgvlWJeh0xMSuwb1r8GLEn6PoJTi6ha97
         NF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685056699; x=1687648699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVpMlft04baQe3FGBQ1uPFAK60NKjDWRg8PgqN8ZkKs=;
        b=N6WTUua30wN1/+5xk4mwauxcDcZlkmHf4YchoWnAzqP1wlPJiqWFIJMmHbKuuqVxr2
         nBkj5vBQNywqF+hpdwlBJgMd4BAbGHNSqBMapLDGNuL3mp35UVq9O1xutCN4GjwGVj83
         bs8afmbtPB+HtdL2eI0zYXOVcs4/sNEYAeyxHKBbYcFikePax7vJajMS7CMbOuGNl2YR
         Lj0VmDEIvZ1ZShtNQL6DTIG5DumBQVPyFMLVGBAkRIv2fpPp5R5W3fW9HVfk3x3XQFYP
         +7Cn5DR6NTHiWVGA4cQaHe1PsG2SSQOkfBegTV+bHHDOZvSZo14eks14Inqful/310yz
         xvsA==
X-Gm-Message-State: AC+VfDxNywZxpbgeaPvx+NcqeNT250KcywLnzvwT0uoIX1XhBkLsMfsh
        FHdoXXV5S56nLSepWg4cEW6Zmw==
X-Google-Smtp-Source: ACHHUZ42t+kPWopue5lTtE9aHyixf26vmAWbHIBbKEH6AO1badc8c70TkbKv9vO1kH8MBf6kPbL44A==
X-Received: by 2002:a05:6512:410:b0:4f4:d805:cf62 with SMTP id u16-20020a056512041000b004f4d805cf62mr950794lfk.5.1685056699552;
        Thu, 25 May 2023 16:18:19 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004edc485f86bsm366766lfl.239.2023.05.25.16.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 16:18:19 -0700 (PDT)
Message-ID: <a196330e-9d70-1bbd-6fae-7d60eb06e478@linaro.org>
Date:   Fri, 26 May 2023 01:18:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/5] soc: qcom: smem: introduce qcom_smem_get_soc_id()
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, ilia.lin@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com
References: <20230525210214.78235-1-robimarko@gmail.com>
 <20230525210214.78235-3-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230525210214.78235-3-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.05.2023 23:02, Robert Marko wrote:
> Introduce a helper to return the SoC SMEM ID, which is used to identify the
> exact SoC model as there may be differences in the same SoC family.
> 
> Currently, cpufreq-nvmem does this completely in the driver and there has
> been more interest expresed for other drivers to use this information so
> lets expose a common helper to prevent redoing it in individual drivers
> since this field is present on every SMEM table version.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v4:
> * Change helper name to qcom_smem_get_soc_id()
> * Remove len and just pass NULL, that is sufficient here
> 
> Changes in v3:
> * Change export to EXPORT_SYMBOL_GPL
> * Use an argument for returning SoC ID
> * Update kerneldoc
> ---
>  drivers/soc/qcom/smem.c       | 23 +++++++++++++++++++++++
>  include/linux/soc/qcom/smem.h |  2 ++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index bc98520c4969..78cf79ea4924 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -14,6 +14,7 @@
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/smem.h>
> +#include <linux/soc/qcom/socinfo.h>
>  
>  /*
>   * The Qualcomm shared memory system is a allocate only heap structure that
> @@ -772,6 +773,28 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
>  }
>  EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
>  
> +/**
> + * qcom_smem_get_soc_id() - return the SoC ID
> + * @id:	On success, we return the SoC ID here.
> + *
> + * Look up SoC ID from HW/SW build ID and return it.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int qcom_smem_get_soc_id(u32 *id)
__le32 *id

LGTM otherwise!

Konrad
> +{
> +	struct socinfo *info;
> +
> +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
> +
> +	*id = info->id;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_smem_get_soc_id);
> +
>  static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
>  {
>  	struct smem_header *header;
> diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
> index 86e1b358688a..223db6a9c733 100644
> --- a/include/linux/soc/qcom/smem.h
> +++ b/include/linux/soc/qcom/smem.h
> @@ -11,4 +11,6 @@ int qcom_smem_get_free_space(unsigned host);
>  
>  phys_addr_t qcom_smem_virt_to_phys(void *p);
>  
> +int qcom_smem_get_soc_id(u32 *id);
> +
>  #endif
