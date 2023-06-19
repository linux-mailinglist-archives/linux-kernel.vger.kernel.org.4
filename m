Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785EF735849
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjFSNQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjFSNPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:15:43 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594781984
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:15:33 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b4636bb22eso31980121fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687180531; x=1689772531;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBO3iu9jfDiNa7LMgJxeNhsBFTZP/cc62vDSqJcSUqY=;
        b=SPfB70Lb0paCTXk0ODmtZOJ+K/6K/Fwp4Qv1LRn4g/pJGyi7H/Fdw2K4Ryuo7rVEBJ
         +ZPde3kTNRk+uZdINiF2/8g2zU32jcnqCMdIEGpqIMWQ6R5mcej0eHBan/Y9hVBiNyuR
         k41IjGh3Qi+cMvQp2lFX04yg73dszezfQLxWa1a6y+3WM2GOIiGVjFq18F+H0V6rH4mt
         iLLeMrQLzfwXNG1qK8Vhd+22Ip8rZjeH/Pwr0cjpPXTtUIxHkKjmG778QCm92xXuSdhg
         PlYuqRMQw1J1zGhS9zs/N9R/gTcE/+mHCoHqtkRmKGCe+6yhdWsgJE3JlsIr0ogOUR6B
         fT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180531; x=1689772531;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBO3iu9jfDiNa7LMgJxeNhsBFTZP/cc62vDSqJcSUqY=;
        b=kyXKZ0pvlsZP1eXE2pM/TeeQhNX8r7AKEGRpiw00a14khkW6BatLDZZDOTMivQn6+1
         o19/hpOh0GIeV578X3PrpRsi+vIOIfnWFQkuXXsX2EB3ZT0/E6025bP3EBEp2gR7P+Zt
         ceupnEexusEtQrrHpfaltITntVVrQBTvDpF3wM1XD+0/tRBjPQKSW49cdmPoIAIk2w1r
         UwPw4t7MjT4jP+3gRwbmw66pM5OG7eAaJDzExj0ryDiNkbGDKzZWb1XB5pZR4zJSi2VL
         vB9oUc1Vs3KJZFZQn0Z4wCvTlsH//7gPoSZkhPmQQntM7Z5gF9nAAJUkXqWpdY6Tsxzo
         9vgg==
X-Gm-Message-State: AC+VfDwIzYA8xRqQ2QJTIq6y1VHljmq7MG4/y9515tyd6VypvbLhp0t9
        3qpvCx+L59a/DPygWuYq4nz5Xg==
X-Google-Smtp-Source: ACHHUZ7RFBcS6H5Xk7h1y7XdJSaySB6X+zOjjCLar4M07y0Y3EKdqNCWbSnt6k6oO8dT7nyiVD+4YA==
X-Received: by 2002:a2e:b6d2:0:b0:2b4:7da2:bd5 with SMTP id m18-20020a2eb6d2000000b002b47da20bd5mr1252006ljo.34.1687180531268;
        Mon, 19 Jun 2023 06:15:31 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id 15-20020a05651c008f00b002b47e824518sm341988ljq.76.2023.06.19.06.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:15:30 -0700 (PDT)
Message-ID: <bc741c41-d291-9876-e944-c37d67854aac@linaro.org>
Date:   Mon, 19 Jun 2023 15:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 15/15] arm64: dts: qcom: sm6115-pro1x: fix incorrect
 gpio-key,wakeup
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
 <20230617171541.286957-15-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230617171541.286957-15-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.06.2023 19:15, Krzysztof Kozlowski wrote:
> Use 'wakeup-source' instead of 'gpio-key,wakeup' to indicate key can
> wake-up the device:
> 
>   sm6115-fxtec-pro1x.dtb: gpio-keys: key-volume-up: Unevaluated properties are not allowed ('gpio-key,wakeup' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> index 3ce9875e932c..9b70a87906dc 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> @@ -44,7 +44,7 @@ key-volume-up {
>  			gpios = <&pm6125_gpios 5 GPIO_ACTIVE_LOW>;
>  			debounce-interval = <15>;
>  			linux,can-disable;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  };
