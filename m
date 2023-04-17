Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D06E40C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjDQHYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDQHYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:24:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AAE4E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:24:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ec88c67b2eso1152674e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681716250; x=1684308250;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eRWJ8hnKWyB4yiHIkDBjWVTGsQ9zBqOizpsmrheXvo4=;
        b=GlW3+LN4eGY/axBgbLCz+q0/nuw9xaTqJE1fI13KRegreKnEpmkaqnHJxgOC5nXXc5
         t/U6eZ+cWjYmR70AyThlmdClKZuxePG449aWzDmNzQ7lJYZgHIn+4e5Cyaqy8G1JO0Vj
         R/rBL2oNWXVFYgtAV5QBkstXOodRqE2wY0rk8Spv4iKGBcSd0vhA94FxWMx+rb1LWiO/
         WK7KUQiTMDsdyV3km6TV+PGPZjC1DGOiHtC8/5uUZAKhzWi7RrA5QxVDUH/5Vr2d4DX2
         VHjc8bVxMVjT0Y7iq6YChOUimKZEqfwDBr0elWnBmYOzaZb3RI08lYMUsENAs9PJryLo
         qbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716250; x=1684308250;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRWJ8hnKWyB4yiHIkDBjWVTGsQ9zBqOizpsmrheXvo4=;
        b=CN6yiJtrrhSiNl0w7fjL2k2cSvjH+2IjI/qraWmqB+g8IE4PpkXlbr7A3zQr+gdkb5
         TzVRd/N5+RYoNykz0SnV8UoNDzQUvatSn5izv6YBY92x6qJx5jK34zoNJRIkXMW0gJR2
         8mSs7TZEdhxAmBoPLAGGpaOz/AN30uyw/6D1lhgeUXp4TnljDajpbpgIviXmwKTAVjTU
         t4j8NU2S35Bk8cf8IRT/OEmWGXekeV3pEiAq3pW8J6uX2xO2VMWQwPpQ3BiGUQD8dvGz
         QeDT8ubfCOdwycrGPc75yGte8CaRaO9WlZHOlb4Mb1D6eT9YO3Kl0IZjyNdi73J5UkuQ
         p4sw==
X-Gm-Message-State: AAQBX9cAAd4Rl5KCD6XZh76v4jZXarNBreASN2/w4cMfrx8iZB9OrBWL
        f/zF7mj5y49ZWbrni0siTQWTmg==
X-Google-Smtp-Source: AKy350aaIf1Um6YW2L2S/wT2lC/V9YBRD1WUB02oNkTx/S8rTidB07/UDkDddm4MUFLRFjPY2gvAog==
X-Received: by 2002:ac2:515d:0:b0:4db:3e2d:3efc with SMTP id q29-20020ac2515d000000b004db3e2d3efcmr1530925lfd.10.1681716250037;
        Mon, 17 Apr 2023 00:24:10 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id y7-20020ac255a7000000b004e92c0ed7a0sm1957825lfg.100.2023.04.17.00.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:24:09 -0700 (PDT)
Message-ID: <5a3a800a-da9b-1155-f7e7-f315887baf00@linaro.org>
Date:   Mon, 17 Apr 2023 09:24:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/4] arm64: dts: qcom: use decimal for cache level
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230416101134.95686-1-krzysztof.kozlowski@linaro.org>
 <20230416101134.95686-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230416101134.95686-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.04.2023 12:11, Krzysztof Kozlowski wrote:
> Cache level is by convention a decimal number, not hex.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 9ff4e9d45065..ece652a0728a 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -83,7 +83,7 @@ CPU3: cpu@3 {
>  
>  		L2_0: l2-cache {
>  			compatible = "cache";
> -			cache-level = <0x2>;
> +			cache-level = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index 84e715aa4310..4056ce59d43f 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -66,7 +66,7 @@ CPU3: cpu@3 {
>  
>  		L2_0: l2-cache {
>  			compatible = "cache";
> -			cache-level = <0x2>;
> +			cache-level = <2>;
>  		};
>  	};
>  
