Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9083E5BDE17
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiITH0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiITHZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:25:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5572950047
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:25:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u18so2298528lfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=TMSVmhoNQ+EVx6VuvGV7GoC7OCus+JONwHUFK5MPIiA=;
        b=PThj4PJ6jYkYYO9TZGLcFdngNjOP/nQjGMvwuQMKbc+bmRqAjWWHuOCGxyKACZ57yy
         91HPR0Tj+Mfd3Ep6uHTXJwrXdIHVrNfi/EkS3mYq4PeFDkzJOtPrL/lQPfacI96vsLwm
         AWRYw1Ep78RQaBX/wfXExS/ENl56JVLTNgt7kkSxNTn5Db1J/5pnyfwHVIrT8g+8b10M
         aNZUAgQ9albYsIjDRvsXnclJXSyYsV6hJr9cdESh/PuU7Bbo+ozsk7Uc9/668jziUlwW
         mHjAK4NB33WRUTUn4YIi82gK62JS3GEVMzU8yhfwK4MvNBKzbD7yQwaVwbBm7JGXKVrP
         qhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TMSVmhoNQ+EVx6VuvGV7GoC7OCus+JONwHUFK5MPIiA=;
        b=gGMflPM2Q/kqjbvpW7sltI73Yr1Ydj1X0S8FD49D5wsujc9rRs6aGa+asgHP7Hdn7m
         xG5jRa7TdcDSeQxPFtgMz9FHbCk9KhtVnI/VtwcY0zDkIy0pLI40GeQamMO0+PYU1Jre
         ClXm+Sq/gX3fXdMpWBLmfjkhv2CSonV0qWhrmx0H0AHZnZ1IRWq8D1uMZdlxJNxkIa2P
         5Ru74DiwxvjX/e+bE+790xJQOSCx3w9s9zO5V/ziO9YkO2cQWk6yg1pPUmGaMAcN50aV
         RmTx0ffzOX1GOqSCXR+QVWaohFNFhUSReDdRFK2DnCeAtoaFBCrggCxo7q5tzP1Fmw2Y
         esHQ==
X-Gm-Message-State: ACrzQf1oyTdsw6rx+0ItT151dzhUr+u4wIkl/WCfvWh7+kfqy2bQZpjy
        14vAin5YZDsvRALObCdDrOEt+j/dZUYJyg==
X-Google-Smtp-Source: AMsMyM5EHjB+cTmf8WPbUI9j9R50LpVkSqhwQo5FmkPm/75jGLSQhXhUgF3Nxxfh7Ed/mLF+o2/nNw==
X-Received: by 2002:a05:6512:3608:b0:49a:75c0:5146 with SMTP id f8-20020a056512360800b0049a75c05146mr7958042lfs.398.1663658753671;
        Tue, 20 Sep 2022 00:25:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x16-20020a056512079000b00497a2815d8dsm169165lfr.195.2022.09.20.00.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 00:25:52 -0700 (PDT)
Message-ID: <bb577304-f048-8fd5-fc7a-47a0897ba792@linaro.org>
Date:   Tue, 20 Sep 2022 09:25:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 1/4 RESEND] ARM: dts: qcom: Use new compatibles for
 crypto nodes
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, Jordan Crouse <jorcrous@amazon.com>
References: <20220919221509.1057574-1-bhupesh.sharma@linaro.org>
 <20220919221509.1057574-2-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919221509.1057574-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 00:15, Bhupesh Sharma wrote:
> Since we are using soc specific qce crypto IP compatibles
> in the bindings now, use the same in the device tree files
> which include the crypto nodes.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Tested-by: Jordan Crouse <jorcrous@amazon.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-ipq4019.dtsi   | 2 +-
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> index b23591110bd2..9c40714562d5 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -314,7 +314,7 @@ cryptobam: dma-controller@8e04000 {
>  		};
>  
>  		crypto: crypto@8e3a000 {
> -			compatible = "qcom,crypto-v5.1";
> +			compatible = "qcom,ipq4019-qce";

There are few issues here:
1. Compatible is not documented.
2. Compatible is not supported by old kernel - ABI break.
3. Everything won't be bisectable...

The same in other places.

Best regards,
Krzysztof
