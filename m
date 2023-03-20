Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78716C1E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjCTRep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjCTReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:34:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D0C15543
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:30:09 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id t14so12947750ljd.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679333374;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jK9DrWyZ9l5FOuQheMnitoszzLP5bklP79WsjtYCrw=;
        b=NxDNZaQmNpt9V2d7gP9PLr+YynYtqw6yQq8xe2Pes6rTLqfj1gxn2ZRxL5h42D8l5T
         7MGXX8FKWA5gclVyS/tFF3LVrIiWNVnP9tbT3XVdSNSfIwx7HoHr7CYwuqau6eNfjbKA
         /JtlrzdL141zPzqkXFH+GzZQ2MmUKEK4oOn6PPym2PEsv1BD8peug3TqoZA530aLpWSA
         /Gak1lQs125FX/QSfr478q+3tjnF1eN3kIO2gwypDAHGj8dHF7Ps1cTXX1mgHS1azEau
         Bn29vUcPdkV6+Ziln0C+C3ATOc4syOHKaIC4r/r/nagp5VgX3Jwsn7PQ1wS1VGFXHVH1
         QhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333374;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jK9DrWyZ9l5FOuQheMnitoszzLP5bklP79WsjtYCrw=;
        b=c7v1I3ozJjEzlTGCP1zjYy9f/MBZ+o2aJ8cuAKX2CBDIecPq61kpgmudMwiwfrekvy
         doB0NVinjOG1UDWAJBGh/sFtu8Vp1DSc+LiUrYTwmjfZIOhuQQc8wx/l2wGyQBrarxZf
         IbeKRcPNsQBWCFwkSOp5Yhtsr3FkeXF8ari3vBWz3BXGSaxFL7GCXwn7OKO0pLt+bu7D
         L87c49F7ySU7b1Xq0OBvDKcYkgw6AHS11TdSzP1bfKkHgvvBNA2LeKxgPSDDRv5DQSHF
         Tk2AVXXqPRF2o3JSvShfaV9d2HKCDx6mhK8T+4eJ5BH2f8RMv0QmjLzhOIDplxXQFD3C
         D/aA==
X-Gm-Message-State: AO0yUKXU7GSpV8sAl4qNWSq5dxy522XeNXonx4swZr8EDfar2poFYjUa
        ANqkjJ+jw0DiwGqPoJGIMHz4Bw==
X-Google-Smtp-Source: AK7set8tBlhF1mbMjSmF9PtGua8bh+FsUyn/Aas9XaRq9KrcxlT2YKjIeRg8r/IwUD/OLeMy0lqQxw==
X-Received: by 2002:a2e:9dc3:0:b0:29b:d51d:38f9 with SMTP id x3-20020a2e9dc3000000b0029bd51d38f9mr224760ljj.46.1679333374119;
        Mon, 20 Mar 2023 10:29:34 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id y26-20020a2e321a000000b002934febffe4sm1841842ljy.128.2023.03.20.10.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:29:33 -0700 (PDT)
Message-ID: <6a453da1-76cf-467d-38e3-746c4a4d2312@linaro.org>
Date:   Mon, 20 Mar 2023 18:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 15/15] arm64: dts: qcom: sa8775p: add PMIC GPIO
 controller nodes
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
 <20230320154841.327908-16-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230320154841.327908-16-brgl@bgdev.pl>
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
> Add GPIO controller nodes to PMICs that have the GPIO hooked up on
> sa8775p-ride.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Only on 2 out of 4 SIDs?

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> index 276070b62ccd..574c20caf9eb 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> @@ -78,6 +78,16 @@ pmm8654au_0_pon_resin: resin {
>  				status = "disabled";
>  			};
>  		};
> +
> +		pmm8654au_0_gpios: gpio@8800 {
> +			compatible = "qcom,pmm8654au-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmm8654au_0_gpios 0 0 12>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
>  	};
>  
>  	pmm8654au_1: pmic@2 {
> @@ -99,6 +109,16 @@ pmm8654au_2: pmic@4 {
>  		reg = <0x4 SPMI_USID>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +
> +		pmm8654au_2_gpios: gpio@8800 {
> +			compatible = "qcom,pmm8654au-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmm8654au_2_gpios 0 0 12>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
>  	};
>  
>  	pmm8654au_3: pmic@6 {
