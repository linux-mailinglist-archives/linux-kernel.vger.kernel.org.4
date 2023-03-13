Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F4E6B7133
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjCMIcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCMIcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:32:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93A237F0E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:32:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j11so14582883lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678696331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/8aoFq3Wt4qRJGdyM50szuohL78RDsQQ4bLouWO7Kc=;
        b=FwTJWlPNne5zVw7TP82i61UUGFDKCSeE6kqRogUzFfyCHT7MP0rS4f+h98K9ngjqHv
         YlDwsaLX32Mw25Eh8vpbCsSNQn6oFokUVDKAb4o0sjOSHxNHizddUYWgK2tu5B0bLtXy
         E5pAsyNur9Wc5UOGWrWCtOnQn8UY0uXeziFpwtA0Wc4Lw5jg1QDR5KruJgx1UGuintAp
         M8KKLo1F70bAOnG4uHuK7vuf2k5Za3GVu0f8ETLrOvgtcTkPYj0V9JrAJBHTW4r3fyM8
         kf/xoYj9zgHkot6YrHKoBMrjnfgEA6Lqt2LhHwjxZ40pGs3IFoy7q+4xg3pEjx5ApWrk
         Q8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678696331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/8aoFq3Wt4qRJGdyM50szuohL78RDsQQ4bLouWO7Kc=;
        b=nsWZVJKrdr/O+hhCpc2Zyl0tD3dr+GJsHp07QxAb7rInt8qzVuuEuuS4lIhnwCxIR8
         +VQcBQa9MxffYO1ZEHx9n0BKf1McBs1A2+fFGDd6nHAh+67xVEVrTh9ImMgI+HrfjMo6
         NOHeNRU66uVIB44WDbf+fSM0FZa23QY7f7CmWTDnJY4bIwXWWk0F56bR/Tmvt1E1xA9n
         DrKsgCtA9RRs4fnQH55VZfk8mjK7rSH1IdQeue0P7wX1wpNjaEIEoOHAR4KO9AmKpZKq
         qlTOjoouQgF3ddDZEOupsDhnCtFfjn/0bkqaXSfx0QCQZkQgm/AQr+u2Jazlcqk/wjmY
         vJ2A==
X-Gm-Message-State: AO0yUKXrROSMVxeI+tnjj9jdX9dgQhNQtvLAliRcZ6d8BPAnakRWZ4ji
        tpRStHJ+Czp1OMzpxN+GN5BHKw==
X-Google-Smtp-Source: AK7set9mepNuW+zboSNk0nqXRNn14qHxcfk9RKzKaRvRz1VnHLHEsN+6ZEf/F4XWWao5C+mNNVTORQ==
X-Received: by 2002:a05:6512:24b:b0:4b5:5caf:9d62 with SMTP id b11-20020a056512024b00b004b55caf9d62mr9615247lfo.61.1678696330893;
        Mon, 13 Mar 2023 01:32:10 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w1-20020ac25981000000b004e1b880ba20sm896028lfn.292.2023.03.13.01.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 01:32:10 -0700 (PDT)
Message-ID: <5441450e-be39-1033-b3d5-c3eb10950d34@linaro.org>
Date:   Mon, 13 Mar 2023 09:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: qdu1000: Add
 LLCC/system-cache-controller node
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230313071757.31533-1-quic_kbajaj@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230313071757.31533-1-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.03.2023 08:17, Komal Bajaj wrote:
> Add a DT node for Last level cache (aka. system cache) controller
> which provides control over the last level cache present on QDU1000
> and QRU1000 SoCs.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index 801f090335a3..a4816a862344 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -1321,6 +1321,16 @@ gem_noc: interconnect@19100000 {
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  			#interconnect-cells = <2>;
>  		};
> +
> +		system-cache-controller@19200000 {
> +			compatible = "qcom,qdu1000-llcc";
> +			reg = <0 0x19200000 0 0xd80000>,
> +			      <0 0x1a200000 0 0x80000>,
> +			      <0 0x221c8128 0 0x4>;
> +			reg-names = "llcc_base", "llcc_broadcast_base", "multi_channel_register";
Please turn this into a vertical list, like you did with reg

> +			multi-ch-bit-off = <24 2>;
driver-specific properties generally go after the generic ones,
so swap this one with interrupts

Konrad
> +			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  
>  	arch_timer: timer {
