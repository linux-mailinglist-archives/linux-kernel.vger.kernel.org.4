Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82E96C606E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCWHL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCWHLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:11:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DFE2311E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:11:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w9so82525333edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679555475;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rb5mZbbPjNdQ4g0YhiUoVsLvm1nZGoz4ulw8+49GlEM=;
        b=T3y+SDKCHBip4M86kHfutYQmXd2/1dAWQw2QA29dX73JpEPjrEZvm8O/qz1X3VXBa8
         2lbFF4xnAQ3uMOKAHLL9mWECxHi7owKC/oy47Mh6ojH24Cv7EDZHxDaeTWUL+bfQDk5j
         kEP69TwzYpNsvhG2rM8DtGUVeQ8FiS1mSRDIkVP9l4KphD0wEliq6sQwRkjfFCdDfIc4
         Hf55GRNAcooK9eVx23lvxLY9y5Gp9jpSdNB+AGSMLAcaEYZU2rhwP6f/6cfuzt13SLMF
         nsXR5bWTpoquhNXb2p4ODlfYXRMjJmusXQLxhIc4XXYe1qUGGh3tUXy9IYhyoke8i7dz
         3mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679555475;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb5mZbbPjNdQ4g0YhiUoVsLvm1nZGoz4ulw8+49GlEM=;
        b=fccrUQU33R5/Xe/56NiP7Rh8KSzkP0ombLsoRKAjesduoanQOi5WdkdN2CKg524UKy
         buS+x6LRT3RiZGhEEL71Ta0XEMbrChS0q2F6a/Xzzkvs5FxSqwbuncu91nqEkkjrecDt
         9XuNtcyzM7fXos9BD/IWrp/OdhK6rkH9oaKBAbHAqfESW5Hc99T6ftz0K4PSYR07ROP6
         6SnLNOZDsfk/xDagS/8EZ7tfMD9YOK9mu97PVLWypME00QdvTv07ecQ90HcKxMUBfvE+
         6e+RLw92kPSwLIMVcKn6vtFldzueZFg63s+y48hPgrC7WIB1C9pbZHQE8irBmZId0ls4
         x9ww==
X-Gm-Message-State: AO0yUKVx8zA8hKWviaZKYqiwTqcIYthYRbp7ACMDcm+2XDVi5ix7GK0Q
        xfZNKSGoWjuJXUsEFwoO5Kr9Eg==
X-Google-Smtp-Source: AK7set81vkHKd3YguUdxWt5fBpX1xbFzL+lC63f5hyyGYF8Q/UvN90mRYMpY2Eocns5dZFPGxcf9LA==
X-Received: by 2002:a17:906:2921:b0:930:fe49:5383 with SMTP id v1-20020a170906292100b00930fe495383mr9323227ejd.76.1679555475137;
        Thu, 23 Mar 2023 00:11:15 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id k10-20020a1709067aca00b009294524ac21sm8236498ejo.60.2023.03.23.00.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:11:14 -0700 (PDT)
Message-ID: <5591f9a7-ace8-673c-9738-71efe047dbd5@linaro.org>
Date:   Thu, 23 Mar 2023 07:11:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] nvmem: stm32-romem: mark OF related data as maybe unused
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230311111551.251675-1-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230311111551.251675-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/03/2023 11:15, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>    drivers/nvmem/stm32-romem.c:271:34: error: ‘stm32_romem_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied thanks,

--srini
>   drivers/nvmem/stm32-romem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
> index ba779e26937a..38d0bf557129 100644
> --- a/drivers/nvmem/stm32-romem.c
> +++ b/drivers/nvmem/stm32-romem.c
> @@ -268,7 +268,7 @@ static const struct stm32_romem_cfg stm32mp13_bsec_cfg = {
>   	.ta = true,
>   };
>   
> -static const struct of_device_id stm32_romem_of_match[] = {
> +static const struct of_device_id stm32_romem_of_match[] __maybe_unused = {
>   	{ .compatible = "st,stm32f4-otp", }, {
>   		.compatible = "st,stm32mp15-bsec",
>   		.data = (void *)&stm32mp15_bsec_cfg,
