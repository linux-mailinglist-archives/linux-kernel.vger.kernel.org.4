Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D546CD4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjC2Idb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjC2Id1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:33:27 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0010C46AB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:33:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id br6so19090838lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680078793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mj5Xq6+JfoalzpG1WEfQLWuCEqNy/WskP4LNoja4eI=;
        b=mZu4wAUV9wtAfMe4oDDeNDOHrT8dJJ4XXAMQIKc4TBMCYrBJJnqF+x5EH1iO2TsVfl
         aEvpWhvc+NId0UWzgJvVeZnPy35HPwgKrybTyP8/JMuTKgLnVdMdU6L6FJf+kIKW3Mlr
         sg5w+KDBwE8p+3OWtejmvCjocBLh2P+KpPYxHenen9Hrvn1yNTMC9BSInu5jy3O49Pqz
         V+CaV4YqzWhb5b0avKwGAVVgbm1H4WVWBcTsCVUgNqf0rjfVX0mCfX4UMnDM/lPpB24y
         Q2BgzsrZn7DLQqsTGqrCcsj2/8sXjsIpKCANJH1ihtRrIdEsc2mx1tA8OqGXEysBodkO
         +uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680078793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mj5Xq6+JfoalzpG1WEfQLWuCEqNy/WskP4LNoja4eI=;
        b=CJeudtTYi0Xaf/M2RI0Nz7lPsfR3abYROGSb9M1iPsqcOFsJfgfjKdlxFWbboj2OM+
         fBOZ/tJxDlGZ/PbYaXxsNjoTrufaAXJS3ggzHAsOVHwZGhGwrVl8dk9i9rRDNpaS1Dch
         gFH6ueFWWltF+h3Z3i6ZATbVu47Wz/+PlaY69Re/PXz3ZggtDXAu9iHYGt0ffzix1bG6
         ZiTwtMBhbGKFWQBaz/uNhJ57WdRclS11Pr3sp5gVmZFm0AJVMwpf5Tub3iMEUd7uVUfd
         CeNfBN1I9PqX4tUEp72J/MbBI9X/twykz0l12lRvFxtKl+Xdgyz5qCOHnt9N6y6hJXTW
         PFGg==
X-Gm-Message-State: AAQBX9fh+dgmuhPil6EpdNY6H6hKqOtYWPQOv7rDj2ohvtzUivb927ao
        q5HggBWW49Am6cTsNnFk5C94dQ==
X-Google-Smtp-Source: AKy350aNzNob6HbJ/RxdWslNWAtB+K0yVD/z7brX3plRakI3Uhf8hEdc3GG+W8V8r8TlCiYY/4Ui8A==
X-Received: by 2002:a19:4f1d:0:b0:4d8:86c1:477e with SMTP id d29-20020a194f1d000000b004d886c1477emr483750lfb.19.1680078793292;
        Wed, 29 Mar 2023 01:33:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o1-20020ac24941000000b004ea889258d1sm3974268lfi.72.2023.03.29.01.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:33:12 -0700 (PDT)
Message-ID: <4ac63dc9-a420-f9c7-a1c2-1384dbf37fec@linaro.org>
Date:   Wed, 29 Mar 2023 10:33:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/7] arm64: defconfig: enable the SA8775P GPUCC driver
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20230328193632.226095-1-brgl@bgdev.pl>
 <20230328193632.226095-4-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328193632.226095-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 21:36, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the GPUCC module for SA8775P platforms in the arm64 defconfig.

...for Qualcomm SA8775P platforms...

(you know, this is defconfig for every ARMv8 SoC)

> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d206a9120ee4..fa0a145defe2 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1161,6 +1161,7 @@ CONFIG_MSM_MMCC_8998=m
>  CONFIG_MSM_GCC_8998=y
>  CONFIG_QCS_GCC_404=y
>  CONFIG_SA_GCC_8775P=y
> +CONFIG_SA_GPUCC_8775P=y

Are you sure this is correct place? Your Kconfig has it in different
location.

>  CONFIG_SC_DISPCC_8280XP=m
>  CONFIG_SC_GCC_7180=y
>  CONFIG_SC_GCC_7280=y

Best regards,
Krzysztof

