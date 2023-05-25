Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E207710BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbjEYMMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjEYMMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:12:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E083090
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:12:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f3b314b1d7so2255186e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685016735; x=1687608735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvimAcS+ZqUCgtUPuylnz5rLyY+z8RpskX6gwW+E/gs=;
        b=tHwtdktVxcIOe67U/5tEhb9b4Vs3LQ8Au8IUUF8YfDGCGMomWdlLCk3QXkJFgLj8p6
         FMYINgLa7kSI1EqvwNxCLtJtAts1m1A6amNdCL/7Ap2SlYrMhsLaQQmSkX8qtN8r87kP
         FnvnGKGR2u/PTsuUDE7J0vFA1d5MlPgqVHlqs0TaZBE2DZbglVjtnxD+87xPwH4MUBz/
         fHTGkNMettCpuvdrzCpNfkoXaA23PmNk0fIuL9dhNLs8UwPdVqBSrtuNACwHzwuFkSuL
         nOYux+Dk9Ct67I6+gLvTN8c8BY9viIxRLvsYPA+Oyl3S30jUdqX7d3SBM2uAjeUO9vhY
         YeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685016735; x=1687608735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvimAcS+ZqUCgtUPuylnz5rLyY+z8RpskX6gwW+E/gs=;
        b=j0VTaSJodQqVMmz3eBpe95IGF46TPWMR4xcoM5V9gpoXLPM9BWGEGeEx4R71kXbsef
         oauxFjCMFiPr2Cj2K5bH4xE+BGlUrZ4jTbgB6pKeJ7wroHqoMIn2t4IhQRjkTZaPH8qV
         uhwNIFVX0hwgm7YIy3D28lfeyH8rOy3oisMQvntlN4VU0XWjTnJPp8Siy27wQyS0Nrmz
         ypBW2OeYI3uBgHNxF9inOy121v1rjvm7S8wAPqaGtfmGnRQFNG4eBq9f+bWqFsMf99wI
         7OL7Or2uwqD105ZQni8Vz4xQ8wTvfv7ZIde3n7TfZidxwPIM6O37m5xt7jo0C3AE8jnj
         TaHQ==
X-Gm-Message-State: AC+VfDzMxqk7Fl98mRLksha7hE9EFfN6CRs5hCw+us+Z40mk/8SkcOq2
        edLaPu0Fw3NFQB/y/r3hm4iC7w==
X-Google-Smtp-Source: ACHHUZ5ejVEKFhSF38eME2EJbbEhNyTzcL8KFdPsj5cEn1qQqKTJi8YBxBDdH/wiasqax5rzbj3lCA==
X-Received: by 2002:a05:6512:515:b0:4f1:44c0:a921 with SMTP id o21-20020a056512051500b004f144c0a921mr6603459lfb.55.1685016735075;
        Thu, 25 May 2023 05:12:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004f00189e1dcsm189563lfe.117.2023.05.25.05.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 05:12:14 -0700 (PDT)
Message-ID: <ed82970f-691a-b508-604a-17f78db9fdc1@linaro.org>
Date:   Thu, 25 May 2023 14:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/5] soc: qcom: smem: Switch to EXPORT_SYMBOL_GPL()
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, ilia.lin@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com
References: <20230525120956.3095317-1-robimarko@gmail.com>
 <20230525120956.3095317-2-robimarko@gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230525120956.3095317-2-robimarko@gmail.com>
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



On 25.05.2023 14:09, Robert Marko wrote:
> SMEM has been GPL licensed from the start, and there is no reason to use
> EXPORT_SYMBOL() so switch to the GPL version.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/smem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 6be7ea93c78c..bc98520c4969 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -500,7 +500,7 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(qcom_smem_alloc);
> +EXPORT_SYMBOL_GPL(qcom_smem_alloc);
>  
>  static void *qcom_smem_get_global(struct qcom_smem *smem,
>  				  unsigned item,
> @@ -674,7 +674,7 @@ void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
>  	return ptr;
>  
>  }
> -EXPORT_SYMBOL(qcom_smem_get);
> +EXPORT_SYMBOL_GPL(qcom_smem_get);
>  
>  /**
>   * qcom_smem_get_free_space() - retrieve amount of free space in a partition
> @@ -719,7 +719,7 @@ int qcom_smem_get_free_space(unsigned host)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(qcom_smem_get_free_space);
> +EXPORT_SYMBOL_GPL(qcom_smem_get_free_space);
>  
>  static bool addr_in_range(void __iomem *base, size_t size, void *addr)
>  {
> @@ -770,7 +770,7 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(qcom_smem_virt_to_phys);
> +EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
>  
>  static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
>  {
