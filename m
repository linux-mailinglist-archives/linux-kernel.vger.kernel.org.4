Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8435B712EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbjEZVFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbjEZVF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:05:28 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ADF1AC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:05:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2af2ef0d0daso11459541fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685135117; x=1687727117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqzChK2p9Fmsbypm5fA/GYnlAjU1PYB3ZgmsKK+VVus=;
        b=t2cG7LYWCQ/fIqzKcGIfk8cwHzaznVTEc9PDO/9dcOBDmlYOw89iJUHjEWU/vSWIga
         uN+5r85b0ymLK9qb/cjnwav6OXL2AQNSx4FUrbqXm2LiD+EJWIOWcA1CWaHGk24z/j5t
         +iPXTpgeaVuDao1h3fkkw6uk8Hzl9360uPMzJJjBM27071/yl4kEIoCY9Ot7HL95lzwh
         LJEZ4P1YtgaSqTGP1qA655qKXErtuC81ekYUrvb++UQKoqan/I2wXBE8ZDW9zMok9/6o
         ohgLcLPkdP2HD81wTynIMiSdSJ/e8KV9RUP+WQUGUjfULLHUn2MnL3hhubMlE2rF6O9x
         DB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685135117; x=1687727117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqzChK2p9Fmsbypm5fA/GYnlAjU1PYB3ZgmsKK+VVus=;
        b=XJmGZXCoNWd88+9JszZTxWXjOpfuiw/AC2U11Zn9I/BVWUrhn5EcxrMDrq5VRi9SOI
         xC6MgWp0DZmPhbjXNwthgNiwkRaSGEJIXVIuncXKpNobrLwnAnO79omuEfNNUOtzisUc
         hPGZ1sHvj6D+Z59JB8Qp2CdpGjyg7lrNmaMJ4EAy/4jhg6gjAL9kp+0Olr3V1TkO09s8
         E7XlTY3jl/Zhdpg7GFTKnAvJ95Ucnx0lb9az+8fO5vyZvTmD2jvDgTW1PKVA5cItj/yA
         8So6ITKhrwhGo2GP5reCA50BW8Z3Y+t/hk7mq+KQyf9IiFqP1su0rEMWDFIvuI3+mMvw
         xVRg==
X-Gm-Message-State: AC+VfDxcA2g1u8k9deex3EkvsjZFKCo7AwJxU4jCZjctyE0+6QaqobSi
        LuNpIH0HudBOoJJmIM8R3xmb8A==
X-Google-Smtp-Source: ACHHUZ7O5tQX7gUXjHxxBp9kqHiKWVIiLCI+vuE0LsVKLdoVIEf/7YYM17Gn3NJ68MieU9Pnvc8NSg==
X-Received: by 2002:a2e:a164:0:b0:2af:b4b:8583 with SMTP id u4-20020a2ea164000000b002af0b4b8583mr1060146ljl.15.1685135116776;
        Fri, 26 May 2023 14:05:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id a24-20020a2e8618000000b002a76c16ad65sm951941lji.87.2023.05.26.14.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 14:05:16 -0700 (PDT)
Message-ID: <e8436d49-f9d7-fbb6-a4f7-935dc43c5ce4@linaro.org>
Date:   Fri, 26 May 2023 23:05:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/5] soc: qcom: smem: introduce qcom_smem_get_soc_id()
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, ilia.lin@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com
References: <20230526204802.3081168-1-robimarko@gmail.com>
 <20230526204802.3081168-3-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230526204802.3081168-3-robimarko@gmail.com>
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



On 26.05.2023 22:48, Robert Marko wrote:
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
> Changes in v5:
> * Convert the __le32 ID to CPU endinaness
Sorry for the confusion in my previous reviews.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
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
> index bc98520c4969..b0d59e815c3b 100644
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
> +{
> +	struct socinfo *info;
> +
> +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
> +
> +	*id = __le32_to_cpu(info->id);
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
