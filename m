Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545656C1DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjCTR2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjCTR1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:27:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680B12C67F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:23:05 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g17so15875362lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679332982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CL2vz+zQ4oHmxYZxUOy3fQMPIFYOUmLkNBcUH+pSFRw=;
        b=kLtK3nhyZCxHk5DC5CgS/Js+UNclsu7h2xp6e4r7Flbl6e8l3uys4DcnIFR668FzRZ
         K5scPn2blTR+hXBv4RTqxaYR9yvrm0mfmPNOtGAS6uU6p0Tzwy6CiJc3jhnBbZf1cXRS
         WpEfyooh76moROXx07amx04tnvmaNraZoD4rdXL2PfWG25B20TpLoVAcUVu1AGdTYAcQ
         L5/EY6jeYT8FsWvjlFK0SLsoh/RtHUk2409NGdYqAG4FknygWQJfUmBzP1jRTddavSBQ
         FIG54zUik3XOkiusegD0VwQFtUreqOJwSmnLp8dNOVdWdSYWQY8ZyX6bFe6JYkgc96dq
         t/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CL2vz+zQ4oHmxYZxUOy3fQMPIFYOUmLkNBcUH+pSFRw=;
        b=nLgsxisPgx6EliZgyxlxqdTmU8WpV8kygdSIhzK03XTU44GBwMquX8hoD7slHoX0T0
         loUUU1VG7YlSAiOj1pEm2Vw2UQXVTgmG2sh/uQFas8sGTICJHwyG5gO4BLZLaOYt4qqG
         IvccXcg2XK/6uw0hbPyMnqnoepVaBy0tN003ZrcAipnS7ya9dqrVKxEa39IJZxmLL0Y6
         MOeO+PWNPlNY2NTkoua0xNp8QkFdgnq/Tpk1Fl3Wydc+EYYl6lnf8/BcRSW26P+n+IBJ
         FhdXhXu+Vs+Xm+JKSTlXNcMbBeLz4BUgVLmUkk3Dp3DAE2SKLJNlHrXyYzJILFoX7tNs
         2lEw==
X-Gm-Message-State: AO0yUKXKAAVsbWAA7MyuB0NsjI91FtZDgV9kdbkE/dycr+bHkDhMr2rd
        n736IIDiYHN0qRrIcAcfbaHdgviTOWVbnt9SFBY=
X-Google-Smtp-Source: AKy350ZpHc1vK6Jxz9GNIudYL1oWr0U5rHORCqXISFK3qGDihBI9qwHTDNaBidMpZ9EMQtHt51+bsg==
X-Received: by 2002:ac2:4c01:0:b0:4e9:6e5c:bec0 with SMTP id t1-20020ac24c01000000b004e96e5cbec0mr190171lfq.53.1679332982143;
        Mon, 20 Mar 2023 10:23:02 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id h16-20020a05651211d000b004db3e445f1fsm1759121lfr.97.2023.03.20.10.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:23:01 -0700 (PDT)
Message-ID: <65d15d82-c106-b0a7-11b4-703bf22c28b1@linaro.org>
Date:   Mon, 20 Mar 2023 18:23:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 09/15] arm64: dts: qcom: sa8775p: add the Power On
 device node
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
 <20230320154841.327908-10-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230320154841.327908-10-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.03.2023 16:48, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the PON node to PMIC #0 for sa8775p platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> index afe220b374c2..dbc596e32253 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> @@ -12,6 +12,14 @@ pmm8654au_0: pmic@0 {
>  		reg = <0x0 SPMI_USID>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +
> +		pmm8654au_0_pon: pon@1200 {
> +			compatible = "qcom,pmk8350-pon";
> +			reg = <0x1200>, <0x800>;
> +			reg-names = "hlos", "pbs";
> +			mode-recovery = <0x1>;
> +			mode-bootloader = <0x2>;
> +		};
>  	};
>  
>  	pmm8654au_1: pmic@2 {
