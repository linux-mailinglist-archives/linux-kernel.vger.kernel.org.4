Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665856C479C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCVK35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCVK34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:29:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BF71A656
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:29:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j24so7558076wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679480994;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2CSmXLvmqA7bxkhpjhNVaNEFLz0F3Dx2g9G5u+pqBpg=;
        b=ZqiLsknkgIBNaxJkvEc5gQ5p3e6L7VkoIH3hOVUO4wpZpX7v1KlevxVGbF9dfOPumU
         GJJBZS5ltwSZpcKxRr7vXY4Gr/3wiOCkn0osCwQZHoWNaHvhFk554Py2UwiYswOQgQmP
         ylDnv1p1gzUiRtZbgyPJAJZiOoFd00Qh2z5tXOzapFJWphOTB7uD456aUKQZkO+s/yD7
         ESea801EmePRyqnMFb3Eni1REHSi0H1//7LJYSvFYFinSonaFHWscU04whOXdtbrmgdF
         YOR3hA1ZgKnvso9QcESwH56Q61KVFQlTDUI5izXAPalkSgt1NBRyp7QObcU4gaEu9JbG
         /RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679480994;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CSmXLvmqA7bxkhpjhNVaNEFLz0F3Dx2g9G5u+pqBpg=;
        b=CwMZuu1DtwQK1LC1tI9kpfdx/R/lhC/JpRBT7u294aCjoQadsXk/IlntD14AS19gR2
         g7IDieYF7vn3Tr5REnrgoQ+D3icKWgyHyt+X3LSGWF5tAAhJMBDQWdX8BOJGDhIS0pyY
         8/Ef1PjCM6i0fFfDZXN4VX8WuRFd4tDkszmFltO6o6Xy4g4KetOCD2rIsDP8y1MHBFnR
         oE9+ItTc1ekPTSBzMcOtpW1leGVC3iy11ihfA35doFxGjHLYCHb8vSAhLKBZuMQGpH7F
         W/N75fIVByUgfz73xkVjabJfIEaESZsTYnqhpPRbe3h+U/7Ybto5fF4KTLuu0ub2fZmd
         +F4A==
X-Gm-Message-State: AO0yUKVVNDnsV3T0z0XKyM+H7OL21x5Zv6DUHkwVTgH8RwdJkfxEdjsV
        4UdG1Sl0axj8xAaEHvCScRWBUg==
X-Google-Smtp-Source: AK7set9+8osMG3uRRHQbdIbgNIu2F4He+sRHTNEKyF0j4GgomIyJJPIrOJ0Q6uQ4enlL/0jZjPoSiQ==
X-Received: by 2002:adf:f48e:0:b0:2ce:a7df:c115 with SMTP id l14-20020adff48e000000b002cea7dfc115mr5087430wro.41.1679480993756;
        Wed, 22 Mar 2023 03:29:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3606:a601:f273:994a? ([2a01:e0a:982:cbb0:3606:a601:f273:994a])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c0a0900b003ede04deb14sm10600709wmp.48.2023.03.22.03.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 03:29:53 -0700 (PDT)
Message-ID: <c7e41662-ce98-62c1-18d7-22402faf8322@linaro.org>
Date:   Wed, 22 Mar 2023 11:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/3] ARM: dts: meson8: add the xtal_32k_out pin
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230321171213.2808460-1-martin.blumenstingl@googlemail.com>
 <20230321171213.2808460-2-martin.blumenstingl@googlemail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230321171213.2808460-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 18:12, Martin Blumenstingl wrote:
> GPIOX_10 can generate a 32768Hz signal when enabling the "xtal_32k_out"
> group with the xtal function. This is typically used as LPO clock for
> the SDIO wifi chips.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   arch/arm/boot/dts/meson8.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 21eb59041a7d..4d18bb4e3c33 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -568,6 +568,14 @@ mux {
>   				bias-disable;
>   			};
>   		};
> +
> +		xtal_32k_out_pins: xtal-32k-out {
> +			mux {
> +				groups = "xtal_32k_out";
> +				function = "xtal";
> +				bias-disable;
> +			};
> +		};
>   	};
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
