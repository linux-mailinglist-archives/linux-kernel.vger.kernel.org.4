Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDB9643F10
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiLFIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiLFIwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:52:06 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C618E14
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:52:05 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a7so16397587ljq.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXjTNn9tiAsyp/wY7Vv6vP1l0Ibm8LYoSy2L8kWcIs8=;
        b=AoYO7gScR8TYHadSiWcysyhKrc/+agmfXO8ZS9pZfaJHXRyAgyLZ78pZ2Sm4lDiQQ+
         XnH7WRT9TvXcnQC2GTgY+5tPmyZ8iIHWR1UY7Pggp3mdCVUQ4y/b4vkD7xlIJV5vgEnF
         yz/1ljLK2GThAYxHurgNvJxisoo273ze7a6TMXfAievQEUadP2Qa6VuaPyObv7RCC7Re
         hdt1NEqz+WIWmmJQGwmcbq7iEVttJPlouqqMFq9XTkAbOn7zck+ih/wiFLRgizGVPlC9
         umGcDe+B+Ww9SKZzGUDhC3ZJ9R5YrpaUai44fmvVGNYlXRZTzNDBzpg6WGqt/Q4axGsb
         7quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXjTNn9tiAsyp/wY7Vv6vP1l0Ibm8LYoSy2L8kWcIs8=;
        b=OFiuFSUTYS2LDfoB/v78eTEJaWPvKthGiuMSk3A98TS7MJ8D1kPq04ns0XdP2YCNxs
         uGDVyGz09mb6ht0r40w3dfR0tyrFHvjWs4BKa+mcs5J3SBr/ouQhhXwcG/y/Vxz3N0Kz
         CYyMcFRNuo+tXvKBUV0fPrn2zNH+PMykOhmtYJKmoZQAekJPP7/tWYY9W9HTFV/0rOdv
         tFPP82WiPa+2Tv8luErTBQJvlN2814EqOzqQNjCJ2SRX7aaB2HReFr0128L+n5hCFdeC
         Rt+uJyEVYokbye0T1bHZaksE31obsjFN1NpVeCPVxWJgBm8cWJuo0ClyRTBkrWLr/lfg
         jJVA==
X-Gm-Message-State: ANoB5pkEfdaBNmkgaA16Yt5H9SObslrTza37c0MBsZx+hOeTrTjiEgv1
        wzT/CIsXx3w/k/BNQuweUrREjcvqOWgK5HoVX60=
X-Google-Smtp-Source: AA0mqf4tIwds6mHwsgzp2Mb1a75e4FX0OP4DpXxx2xDDn/AcUhj2GxCicQvN/lM82XFKMMGPopYanQ==
X-Received: by 2002:a2e:a409:0:b0:279:ebd8:37f with SMTP id p9-20020a2ea409000000b00279ebd8037fmr4104594ljn.86.1670316724199;
        Tue, 06 Dec 2022 00:52:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b37-20020a0565120ba500b004b5872a7003sm141213lfv.98.2022.12.06.00.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:52:03 -0800 (PST)
Message-ID: <a44c5ad2-932f-218f-add4-be727edb5dde@linaro.org>
Date:   Tue, 6 Dec 2022 09:52:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: qcom: sa8295p-adp: Add RTC node
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221205174309.16733-1-quic_bjorande@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221205174309.16733-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 18:43, Bjorn Andersson wrote:
> The first PM8540 PMIC has an available RTC block, describe this in the
> SA8295P ADP. Mark it as wakeup-source to allow waking the system from
> sleep.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index d55c8c5304cc..d2eb3d870f5a 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -510,6 +510,14 @@ pm8450a: pmic@0 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>;
> +			reg-names = "rtc", "alarm";

You miss one IO space.

Best regards,
Krzysztof

