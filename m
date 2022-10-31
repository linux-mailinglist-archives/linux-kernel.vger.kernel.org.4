Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E298A61330F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJaJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJaJvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:51:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC8DCE24
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:51:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o4so15164717wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VziB7h28RAb/PpCZNcV8L41sOfQewqSOqnvB/DPlrMo=;
        b=dO28zyztaMfCnhKERLsvk0QYXe0sBp7JybCMwIY0BVbTH+mpWjmP9LeJPs79WlFFIp
         LYLXtm6hGkGke0un9gQljjDD7L5Q/A0OGNwWKPLDzoqauQ1uL1DDrB2ZZtuSDrIDmcc4
         u6xGNwTJFh+iRkSjPBREh8fIG+Hyz1vNPPvJkpsQTfB/0CeCE8353e0V+sGe3eptwS87
         7ptg6A+SYniaM56BZag4C1DQv7Z2jTl3KcifeQZUEs7HRXxmpAjVxnPE4lBOkPksM6go
         /TqgTNdSB33qM1s7yQJxcY57LfNDBGcwK16I79T/0eeDqNbh8ixYobtAK5RhNoypphzN
         bimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VziB7h28RAb/PpCZNcV8L41sOfQewqSOqnvB/DPlrMo=;
        b=hgBmP+pQfYGkNCWOyccHAg9+iRvp2B3Uj4ZAtv7zmQdaEMxfAdgRlsWSLwI0xzU9yb
         9dBSfqEqMvfC1wEw+6DE3slaKcBlApCuAJrwNNOtI9+mbBoNgydeNjnHlSDFy0YgSikz
         OvWo28vRFjGO/m2fLQMdD4169axCOseWuXw9jwMXxLZrC9WqHwiilkOdR22q+joorr1D
         y8abXTxdM86AxgwNUGokhaVmNiY5UwgK03E4fAi8aBqECqmF6kWWaaBL/ihCWKC0C3p6
         e2FiqnwhBCVUMC1GktfELW80njYXh432xnVEQ5BQrUOkeTg6TY8GmQwrc5bdfdmq3JIm
         4KIw==
X-Gm-Message-State: ACrzQf1Ah06ZXsdO2Xpy7bYGrNUgyStcwNz8YJwetzs6F3GgO22gKRZx
        Uuxggn130fehLPFtf3U3FW/r/w==
X-Google-Smtp-Source: AMsMyM5zls16f0t/jN719mMXfIpntktnGfwljIHwNt266SKMYSnD9UtUjWxGVUVBVWLB1wDySYE1fg==
X-Received: by 2002:a5d:680a:0:b0:236:b797:5d80 with SMTP id w10-20020a5d680a000000b00236b7975d80mr5876999wru.403.1667209899782;
        Mon, 31 Oct 2022 02:51:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:898:f380:f572:21f0:736:a7ca? ([2a01:e0a:898:f380:f572:21f0:736:a7ca])
        by smtp.gmail.com with ESMTPSA id b6-20020adfee86000000b0023677fd2657sm6571659wro.52.2022.10.31.02.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 02:51:39 -0700 (PDT)
Message-ID: <fac3eae5-687e-9eb0-ddfb-c659d3816d81@linaro.org>
Date:   Mon, 31 Oct 2022 10:51:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 02/20] arm64: dts: Update cache properties for amlogic
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob.Herring@arm.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20221031091918.531607-1-pierre.gondois@arm.com>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <20221031091918.531607-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/10/2022 10:19, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> 
> The recently added init_of_cache_level() function checks
> these properties. Add them if missing.

Is this tied to a bindings change ? Since I'm only in CC to the 02/20 patch,
I don't have the context here.

Neil

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi   | 1 +
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 1 +
>   arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 1 +
>   arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 1 +
>   arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 1 +
>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi  | 1 +
>   6 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index b4000cf65a9a..d2f7cb4e5375 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -36,6 +36,7 @@ cpu1: cpu@1 {
>   
>   		l2: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 04f797b5a012..1648e67afbb6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -105,6 +105,7 @@ cpu3: cpu@3 {
>   
>   		l2: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index fb0ab27d1f64..af23d7968181 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -50,6 +50,7 @@ cpu3: cpu@3 {
>   
>   		l2: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> index ee8fcae9f9f0..9978e619accc 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> @@ -105,6 +105,7 @@ cpu103: cpu@103 {
>   
>   		l2: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   };
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index 023a52005494..e3c12e0be99d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -132,6 +132,7 @@ cpu3: cpu@3 {
>   
>   		l2: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> index 80737731af3f..d845eb19d93d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> @@ -88,6 +88,7 @@ cpu3: cpu@3 {
>   
>   		l2: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   

