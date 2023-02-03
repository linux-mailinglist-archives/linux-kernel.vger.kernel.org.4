Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D912D688D99
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 03:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjBCC6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 21:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjBCC6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 21:58:37 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B77193F1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 18:58:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id k4so11800958eje.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 18:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hr14rJhyuOYS8CCUPkhJr0V/RzyGfQ4WdWOK9XcyHds=;
        b=DPYTk9LfruNrk0yQfRVEMZfhRtdFK/yxKmc6GwnKAYfCLVOGHi+ZWILSVVaHo/h4Rj
         j9PnLd7WJkD3q1H45Ojvmmwv5e8zj9mPpPaoZSOORM4TlcNoaIGvwAYMcxb//kbZSocz
         4PmfYKbAcpc9BTzUlt1Xf4qN/sd2hxJpH8duI7IqxnXR9xvxdiiXwNRwJsgRByiI+JpC
         2jk/uV9pr4sxIEa3yZr1QdYtcUVXpWnxKsRbu/uU4upnB4uGTDkmVyPQ4BLKxcpHhyuo
         U5kE/5oZN62u9tOpIAq18vaGybiTK+B77zK3K+pU4qtkJW8T3X0YITk0FUiJIuhShbkf
         ejXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hr14rJhyuOYS8CCUPkhJr0V/RzyGfQ4WdWOK9XcyHds=;
        b=HS/wYJLUf5wn3q0QhY20/NChNXREenSs4lwPm16G1+WxtPKqeI/RLODvV4kW1VyBOB
         DqEYZODAdzv809VP/JqzQlsz4za7dL2GdjPtKPzghXnjTEKST8emxoSlejOavdxFK04Y
         pDvt4bG0uW1OpjDW1Ym8B834N1fd8qEJ/vQmWz1VIrK7f5bXiJWuEU2Fn0nK3CmOoSGV
         B6KiVJ+6MWi6tz7jq7Mj+Fjc7xlRCOu06ik7q5ez+Whb2h63IQx7uda2EsubjHHUvji7
         X1tHgtxTa9GmYkTBJjyrQZxxciiGftlCi4PayQLgs2Tf+2YbXtJoEjrsXHbccKe5Qml7
         6bmg==
X-Gm-Message-State: AO0yUKVypMZAYdzubreOhT6+0SmMVsjpMfuYmAmRPTpEGkQy8S0LnfrF
        cxR5BfYg/GzjdEJGv0leKvtuXg==
X-Google-Smtp-Source: AK7set+a/A9kd8g19vDm6ooyY/CnSwtS6HJyTItZX2sRwOTPiG+M9P8aPtzxyDm5bR2gT/CPNNQFuQ==
X-Received: by 2002:a17:907:2d28:b0:88d:f759:15ae with SMTP id gs40-20020a1709072d2800b0088df75915aemr11932550ejc.42.1675393110296;
        Thu, 02 Feb 2023 18:58:30 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id x26-20020a1709064bda00b00886c1a02d20sm680121ejv.47.2023.02.02.18.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 18:58:30 -0800 (PST)
Message-ID: <e77f197c-199d-a88b-deda-67ec6fd1c456@linaro.org>
Date:   Fri, 3 Feb 2023 03:58:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 21/23] interconnect: drop racy registration API
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230201101559.15529-1-johan+linaro@kernel.org>
 <20230201101559.15529-22-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230201101559.15529-22-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.02.2023 11:15, Johan Hovold wrote:
> Now that all interconnect drivers have been converted to the new
> provider registration API, the old racy interface can be removed.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/interconnect/core.c           | 16 ----------------
>  include/linux/interconnect-provider.h | 11 -----------
>  2 files changed, 27 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 93d27ff8eef6..b8917823fd95 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -1078,22 +1078,6 @@ void icc_provider_deregister(struct icc_provider *provider)
>  }
>  EXPORT_SYMBOL_GPL(icc_provider_deregister);
>  
> -int icc_provider_add(struct icc_provider *provider)
> -{
> -	icc_provider_init(provider);
> -
> -	return icc_provider_register(provider);
> -}
> -EXPORT_SYMBOL_GPL(icc_provider_add);
> -
> -void icc_provider_del(struct icc_provider *provider)
> -{
> -	WARN_ON(!list_empty(&provider->nodes));
> -
> -	icc_provider_deregister(provider);
> -}
> -EXPORT_SYMBOL_GPL(icc_provider_del);
> -
>  static const struct of_device_id __maybe_unused ignore_list[] = {
>  	{ .compatible = "qcom,sc7180-ipa-virt" },
>  	{ .compatible = "qcom,sc8180x-ipa-virt" },
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> index d12cd18aab3f..b9af9016a95e 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -125,8 +125,6 @@ int icc_nodes_remove(struct icc_provider *provider);
>  void icc_provider_init(struct icc_provider *provider);
>  int icc_provider_register(struct icc_provider *provider);
>  void icc_provider_deregister(struct icc_provider *provider);
> -int icc_provider_add(struct icc_provider *provider);
> -void icc_provider_del(struct icc_provider *provider);
>  struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec);
>  void icc_sync_state(struct device *dev);
>  
> @@ -179,15 +177,6 @@ static inline int icc_provider_register(struct icc_provider *provider)
>  
>  static inline void icc_provider_deregister(struct icc_provider *provider) { }
>  
> -static inline int icc_provider_add(struct icc_provider *provider)
> -{
> -	return -ENOTSUPP;
> -}
> -
> -static inline void icc_provider_del(struct icc_provider *provider)
> -{
> -}
> -
>  static inline struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
>  {
>  	return ERR_PTR(-ENOTSUPP);
