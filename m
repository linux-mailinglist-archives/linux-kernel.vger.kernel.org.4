Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153D7735826
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjFSNND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjFSNNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:13:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D8010DB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:12:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f766777605so4316096e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687180368; x=1689772368;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hZMqiDWKqJFpGtRLtPBxl6Y5PH/ny9LZFU5PxL4esk4=;
        b=gfyBF9rgBUrSJ8A1bi2KB+vn+ctkw+QNFf5NA6LdL4oT9MpuMDsj+qhAyq+SG82lVh
         1Zus/ZpQYpg6LUmnLeLMPVwEF+lyFHmD9VSx43KStAkqvZeoBRzrwN0khyMldO2E2SzR
         +dTOzNoX7WW+y86ST+ey4Uk48jiecyBTU8XxlsmGiw55Nx5aa8Xz90xtvqgwDflzLOyL
         e0WbJV5EVyvuE2d3aW5eN93dyj/UCZ/RzOljtW0VaiVSRA4zOgeoEmzpHp4ZaX9HvT0Z
         O3sVk9Vfw3HIkA6TM4igXknhylXFtohK4bYvEWW3swD4/DBT2xkNBhm4QdrZv/WM9dnA
         Ic9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180368; x=1689772368;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZMqiDWKqJFpGtRLtPBxl6Y5PH/ny9LZFU5PxL4esk4=;
        b=SuC7m9vXHHI0FrYnMV/dEw6ld9KwtUWUUvR72+CFK92txX896omsgfKGlneNoQM+Jb
         xTbMqbwWG87qgA07AC9NZv6M52eIZjJdLyWqcXejgoxEWsjinM1N/WCa2AZ0dECF2EmT
         sRdHAfj9NK+/McRzjXmq6nFaDAqvEX3jeq1bRZvX9A2HsWnU5g6nSos6Pd/8iaK69hmC
         QGE5CaUxmA4UpdgVki1nMRqDPvTreGA+YYbFMhqixDxfp7mbzFY9vyE7xH2gMxvQPLyY
         cnGPb5NJLtF3Sv4usgDRqC95OKcPZ8foZfB7oQ86avZYDANlETXeQ4+K0aQklVT1nWxP
         mlhw==
X-Gm-Message-State: AC+VfDx4xdIU84nepmt7sx7nfNwSX5Gw7rGgkAgl3YL5M0v87y2/RanM
        vudRRxgp3IscXEQoeLWnu+E7JQ==
X-Google-Smtp-Source: ACHHUZ5qe1YE9iqKg4kWfzKzJDY4jnWZz0oaEWNln06F7D22tXeaoQEXuwlg1A6ZSUL3cNk91t0i6Q==
X-Received: by 2002:a19:5006:0:b0:4f8:711b:18b0 with SMTP id e6-20020a195006000000b004f8711b18b0mr1667371lfb.3.1687180367944;
        Mon, 19 Jun 2023 06:12:47 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id er22-20020a05651248d600b004f624d998c3sm1601993lfb.136.2023.06.19.06.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:12:47 -0700 (PDT)
Message-ID: <35332f87-fd0b-fa01-4109-9ce013556fc4@linaro.org>
Date:   Mon, 19 Jun 2023 15:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 05/15] arm64: dts: qcom: msm8939: drop incorrect smp2p
 Hexagon properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
 <20230617171541.286957-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230617171541.286957-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.06.2023 19:15, Krzysztof Kozlowski wrote:
> The children of qcom,smp2p do not need address/size-cells:
> 
>   msm8939-sony-xperia-kanuti-tulip.dtb: smp2p-hexagon: slave-kernel: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8939.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> index 895cafc11480..05d8abbbc840 100644
> --- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> @@ -386,8 +386,6 @@ hexagon_smp2p_in: slave-kernel {
>  
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> -			#address-cells = <0>;
> -			#size-cells = <0>;
>  		};
>  	};
>  
