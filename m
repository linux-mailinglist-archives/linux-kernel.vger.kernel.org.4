Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D66C1DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjCTR1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjCTR1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:27:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1972823A6A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:22:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q16so5013252lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679332965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kPaIIPg0cEDJef+2vXbL2TrKbz3IF8GiImY6QY9m63M=;
        b=pLAw22oZ09TCCYf3ZYwcuvh5CHKHYwbwkyDCZ1Q5w4/DXYbmYEeyeHK+hzFQeKouzt
         /84Tfv/i3GZQRzKoeuZF4vBTiGwCO8MzWl124GpG3IVrI75KfCUTycsBRcXZU1hdls6P
         2h/uy6GvYSGaKfsmeJs8aZxxtmOx1V5inb5t1Hnx66ArAoc8HZAFc0RIytk2uc0XueM2
         P5xraazxPKQR3YLiy6Q1ZqhFIP6s6J9D0dLXkYBNOAPcLyd3ZCMY/JnbsbNL1IAFPkG/
         HDdTlLtfEMaF0HlBFyDiwUTOnrEmn6Q/8wvbZLDVB0Kcxt/Lqz7q2SgWkRI2+5u8Chn1
         mUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPaIIPg0cEDJef+2vXbL2TrKbz3IF8GiImY6QY9m63M=;
        b=oqICZZGM2ZFsAWDt5rsVnsoF43a6jvE18HkxAydDCaztSUTRwUAQ4Qo3Yxh3BE8kRh
         CaH8X4Kz7vks6/9O5E2gru4ngcLdKK7fqm4sywYfU8MbsI6tbE2mcj5hEZBkLSIWcmwP
         qdd0fjFD24OcF17iOnpJa7two+xaej+4bgYbJM2U0W78o31gwsAlla7uIld9siX8Iste
         4POeeApFjTam9ldLw9Xy5AsFMTho6Q/Jd22s6V8nqK8YVXvdNy3BemstNziY/ZjdYgwg
         of9Ui8vyt68hYqvfiYsjPlvkIVf1cxfvSUGev2GoTr4j6T/9yLTtQ1tu5yd3xqJ60FXL
         7Beg==
X-Gm-Message-State: AO0yUKU+shJm1Ff89pSJrh+oWlxP9GvYBRqqjx64zV5Fs70Dils04XHL
        HVNqOaUV/NVADwPOX+7pDBjZwb4977DRI2dwceI=
X-Google-Smtp-Source: AK7set8En9k8hIPXDMMNlBYmu+6/QXlwX1VBFrPpOZmQRpcEf/GGj3u+h+S5EqAXTONUVvY7DhczIA==
X-Received: by 2002:a05:6512:21af:b0:4cc:6e3a:32a3 with SMTP id c15-20020a05651221af00b004cc6e3a32a3mr189688lft.25.1679332965475;
        Mon, 20 Mar 2023 10:22:45 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id l13-20020a19c20d000000b004d594481d0asm1790662lfc.34.2023.03.20.10.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:22:45 -0700 (PDT)
Message-ID: <388b8ae2-7cb4-d975-ccd2-c4e39b4ce3d3@linaro.org>
Date:   Mon, 20 Mar 2023 18:22:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 08/15] arm64: dts: qcom: sa8775p-ride: enable PMIC
 support
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230320154841.327908-1-brgl@bgdev.pl>
 <20230320154841.327908-9-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230320154841.327908-9-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.03.2023 16:48, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Include the PMIC .dtsi file in the board's .dts to enable PMIC support
> on sa8775p-ride.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: KonradDybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index 1020dfd21da2..b7ee4cc676b5 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  
>  #include "sa8775p.dtsi"
> +#include "sa8775p-pmics.dtsi"
>  
>  / {
>  	model = "Qualcomm SA8775P Ride";
