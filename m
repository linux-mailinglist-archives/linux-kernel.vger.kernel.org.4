Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33C56E9126
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjDTKz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjDTKzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:55:02 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80947AF1A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:52:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a10so2291038ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987961; x=1684579961;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifCYflhMoAcZ2WnlvUBQRuDLtNI2/FylcA5rDqp6NyA=;
        b=k+paVPAnhZMwktZJslZDAtX41uiexar1uDJmtOwRfFV+Zvz9CERiF+6CX6xziTTZU3
         6q3+00ni62oFv2KAvyMTJy/9Sy1/lfilXJlixyrEQaHTqqPvdhKAQfkPKai4BXm/i8UW
         joTz6rFzNqI2q/7r2hvDeir34WUwSe5AJY2YAEARm8mVJ1/2AyexgcCBbd5dD3dlqUKT
         vER4324FzJIXmM5NKiJ/s8viADymTYn7ooXoZdhX303xhtbBa1LdPHOwy3xi4xlsmZAK
         /h+7qqFkSEll56RhEn5QG9ttwfjZg6zzT0N5ybOsSDKKWjQ5ZoKhzlu1IB7Ki8w/O3dQ
         mAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987961; x=1684579961;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifCYflhMoAcZ2WnlvUBQRuDLtNI2/FylcA5rDqp6NyA=;
        b=aWGokilW2A4lrkR4c0434yA20WM7H41OY59by1CYq62L3WbTz48irYBwpBCrpUEa8M
         9iW3rgeICjFyxwP1DiEjR59t318kM0jd+yyxY4r4fFLCGtFvYoHZkDGtzJDH29cfBAQL
         du57gX3slF5BiOum1vgI8wKNSanAKVC1JK+vQhfE6rbi6Sony74cumVawGTWZO4IkHj+
         OTFrCjcugE7z+PV2u2E0z90nGcqcM/u7ZNzbGxlQUkgs0P8m7yAvTcsKljJngROMp8Ur
         HyGqJY2zJFJzXN3+2xrDeqR8JHsYDyeo1Z8xkfDFErot9s0KKWyNIw6Ahr40Roh6k1wL
         knuA==
X-Gm-Message-State: AAQBX9cQeZZ2EGpU7w6hTRWP5UZ+k26PuJLPPox3Qh260kdJXa0AAxAG
        Rl4K69y91NhOjJ7u6ed0JW40mQ==
X-Google-Smtp-Source: AKy350ZVankszm4ihdCdRu07H3Ct+LFB+R2/FScvdinIPD6UnZFQo66v1J0yDrRTgE8npo8AblrWqw==
X-Received: by 2002:a2e:8515:0:b0:2a0:69e0:9f7a with SMTP id j21-20020a2e8515000000b002a069e09f7amr324122lji.41.1681987961430;
        Thu, 20 Apr 2023 03:52:41 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id l8-20020a19c208000000b004cb24a027d2sm179255lfc.48.2023.04.20.03.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:52:41 -0700 (PDT)
Message-ID: <e56cacf4-9935-89c7-6749-e06f1ccd43a3@linaro.org>
Date:   Thu, 20 Apr 2023 12:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 04/18] arm64: dts: qcom: msm8916: correct WCNSS unit
 address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Todor Tomov <todor.too@gmail.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Foss <rfoss@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
 <20230419211856.79332-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211856.79332-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.2023 23:18, Krzysztof Kozlowski wrote:
> Match unit-address to reg entry to fix dtbs W=1 warnings:
> 
>   Warning (simple_bus_reg): /soc@0/remoteproc@a21b000: simple-bus unit address format error, expected "a204000"
> 
> Fixes: 88106096cbf8 ("ARM: dts: msm8916: Add and enable wcnss node")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index f6ccce0dad4e..bf88c10ff55b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1871,7 +1871,7 @@ usb_hs_phy: phy {
>  			};
>  		};
>  
> -		wcnss: remoteproc@a21b000 {
> +		wcnss: remoteproc@a204000 {
>  			compatible = "qcom,pronto-v2-pil", "qcom,pronto";
>  			reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 0x3000>;
>  			reg-names = "ccu", "dxe", "pmu";
