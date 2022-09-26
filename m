Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FD15E9C55
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiIZIq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiIZIqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:46:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EDC1EAC9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:46:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so7679655wmr.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=5Ml7yf5x+fVyOuDNSapRUuoUDWz/G8BORxjiAvIuMxw=;
        b=dY7lg+wUSXtvk2k8ZHwyuP/mZ4H3Osn3/PbwsCEOgsF06W7SZKNSG1z6TCJ8oksFWi
         Xs3SxGt5ygyytXqTyn6fQJeXlvPn8IK4/6tP7kvB1hErvDF0IYQXQpQDREQORi5Lm2gl
         IbWqYwYkdp3cxnky1QVTlOTldeqACp1KKdnF4lKJmtgDLgxSdh6shMrp9u+/VvBP/vV3
         Df5CxsS+skUHLLC5LCS/qWcNdiiU0s//B2u2Bzp0C2Qx1qJnLY2FcxENrrBCiz7QvpWO
         rKVA7EjW7NRqmpVNfVLIJILFF3Njz1sv3Fo74mzmfKVHTfsUU56kdXHiULQCY1d8aK1q
         1BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=5Ml7yf5x+fVyOuDNSapRUuoUDWz/G8BORxjiAvIuMxw=;
        b=ZzCPS8+svr5sdxZfmG+Ob2xXuNWiGBvbjJe35ts2oKlukK6bxh9ZHMiE7qXLsLQGbu
         nbUR/DdhAnPZeQqkJbhHm1uH17Phm84OXhLaVL3LPLtcFEfeeBc6Os2Cqk5E/EP4LPRT
         cNP0MECgO5I4nPa8pMz5J2bmj0Q0TimG7gBfN3vy1qiQBJt4t3hVttCyV5Y6IrOYjw8u
         D45vebVHK2u/qfWzxm23acgN/kOwlvmO5HJcG361LTfQ09aBJe84Jx4mh4eH024or3H7
         2P0hF56+/uO2M1hQpTD2Vd0ke7EVpRBywlHjLpjtuyVLlB64OwFM2xQOOnACrTOG6Off
         ozzg==
X-Gm-Message-State: ACrzQf1Pwy7LVD2oO4QEJ43NcAHyQVPaHD0jtaxKkZpMIOpulot9QBzK
        WxLZY8yEbv9B3MQ9IFYmXMcA/w==
X-Google-Smtp-Source: AMsMyM4rEt5jgdqlg7SiNQKTA9LNAfapxqWjttwRoxiLKVXgogtvYugTAYBYelZQC1i6J13JXOQAFg==
X-Received: by 2002:a05:600c:34d2:b0:3b4:a617:f3b9 with SMTP id d18-20020a05600c34d200b003b4a617f3b9mr13652175wmq.204.1664181963751;
        Mon, 26 Sep 2022 01:46:03 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id m187-20020a1ca3c4000000b003a83ca67f73sm10304371wme.3.2022.09.26.01.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:46:03 -0700 (PDT)
Message-ID: <8d2d111d-aaa8-5fd9-784f-4c830f2b0a27@linaro.org>
Date:   Mon, 26 Sep 2022 10:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] ARM: dts: qcom: pm8941: fix iadc node
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925161821.78030-1-luca@z3ntu.xyz>
 <20220925161821.78030-2-luca@z3ntu.xyz>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220925161821.78030-2-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2022 18:18, Luca Weiss wrote:
> The iadc node name is supposed to be just 'adc' and the compatible is
> only supposed to be qcom,spmi-iadc according to the bindings.
> 
> Adjust the node to match that.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   arch/arm/boot/dts/qcom-pm8941.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
> index 3c15eecf2f21..33517cccee01 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -131,8 +131,8 @@ adc-chan@48 {
>   			};
>   		};
>   
> -		pm8941_iadc: iadc@3600 {
> -			compatible = "qcom,pm8941-iadc", "qcom,spmi-iadc";
> +		pm8941_iadc: adc@3600 {
> +			compatible = "qcom,spmi-iadc";
>   			reg = <0x3600>;
>   			interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
>   			qcom,external-resistor-micro-ohms = <10000>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
