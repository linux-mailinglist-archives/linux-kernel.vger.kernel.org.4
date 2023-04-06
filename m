Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0E56D9830
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbjDFN2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbjDFN2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:28:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732CB902D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:28:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y15so50810112lfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680787712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/EYwiDQhUW4YEmdZOCemB3N2W/Dg9tNc5lKjH1epoQ=;
        b=cdvVQBzhf2PQsKTcMuHserN+U/aS7ZWtSSQriiN16ak8G83qx8lqqUTxAEk/on4Z3S
         x/Mb869elBKjnTXLP3IwGiRYxmfeHWkA4fm4hb/YUtM82iqp5loKtGma8JPZkbfiH7nc
         ShAEwJbxF/rvvh2T5QW4uPwTKcGc5P2O0X0gUk43E5bUO3snNYExbxGApedZrl6TNqqC
         dDSRmwVlcBP5l4/3eecuDgB1EJZnwJHjysWZ5iyKNIwJDegonGc0WIyeGjBooxx0GNh/
         hENqXeWmd9SUWK/HNxSdp1IMWZMkO47GGvgNrlHdOLLlwGAD4ml+pSuV/2ZU1F+TSAgt
         h83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680787712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/EYwiDQhUW4YEmdZOCemB3N2W/Dg9tNc5lKjH1epoQ=;
        b=0yIry4+CM9BT2Y9LhfBWWwi7afEav6CzRLIQj8kBth6k8qLETK0k9SO6Tc/40iz9IR
         A9RbZkNijqRzBzhPOcWPbE9pjHysn5TI+jjlyf3mXexlGoXiZkTBk22v3OjmMc0SLBbV
         3+jVcuaO/gFAx0eoJD3lvo4AmpCNCOOES7hxSUIF1yDyYofOZ0+uQVPLhUb2YoLOGvm9
         DcsCtc+ktzlHzadcLUAfpWP5kD0y5MNik5X+iled9LGI5mCdGfTIn/gr8uyVAyFM4SPr
         ooWpMIOlEvR43jCwiaRus/fGmCGi48n8btqz0GzV65pxFpiy1qVYsDV4XV/VCFU8ct6x
         qx0A==
X-Gm-Message-State: AAQBX9c+jG+a6OA9Pow1kQ8zyLDNu0t94OkzTq8agfC4U7IguXxCwepE
        yKp77+T1unQPTR62NgE8pKjdEg==
X-Google-Smtp-Source: AKy350ZaQpuoGr/0Wi4agBDl4nVyoBDk54/kiArKJqfB+wNXdEoQUjZ65D1rLNitTMaS7yiBL9Z3Pw==
X-Received: by 2002:a05:6512:3983:b0:4d8:86c1:4782 with SMTP id j3-20020a056512398300b004d886c14782mr1547618lfu.23.1680787711665;
        Thu, 06 Apr 2023 06:28:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d14-20020ac2544e000000b004e844eeb555sm262262lfn.214.2023.04.06.06.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:28:31 -0700 (PDT)
Message-ID: <86e3e7b6-710d-6c2d-4f01-22933ab15101@linaro.org>
Date:   Thu, 6 Apr 2023 16:28:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/7] arm64: defconfig: enable the SA8775P GPUCC driver
Content-Language: en-GB
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20230328193632.226095-1-brgl@bgdev.pl>
 <20230328193632.226095-4-brgl@bgdev.pl>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230328193632.226095-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 22:36, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the GPUCC module for SA8775P platforms in the arm64 defconfig.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d206a9120ee4..fa0a145defe2 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1161,6 +1161,7 @@ CONFIG_MSM_MMCC_8998=m
>   CONFIG_MSM_GCC_8998=y
>   CONFIG_QCS_GCC_404=y
>   CONFIG_SA_GCC_8775P=y
> +CONFIG_SA_GPUCC_8775P=y

=m, please.

>   CONFIG_SC_DISPCC_8280XP=m
>   CONFIG_SC_GCC_7180=y
>   CONFIG_SC_GCC_7280=y

-- 
With best wishes
Dmitry

