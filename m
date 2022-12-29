Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB60658B95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiL2KQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiL2KOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:14:31 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205AA7679
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:14:07 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g13so26904926lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OLQk/GuZ1RmMBbMLG8GgkkjESDctOzFQH3zJcOJbq4=;
        b=PO2rNo25jh/oldeOXrXYMPIWvC2tOyMthdiHVYN/I1rxa0HwjCdvlIs0o38r4t6oP0
         GbXdiIRjeGwe4jV8q8DnyB+QS3QtuRth+SijOiud6r//AIEPTi6oedIFWFm9ZuCQ2k1n
         LiNbuES/BhDMGwUnrIxpTgL6lJHc2hbexhEj44qOfqllYdgotLYygvnKn9YQ0JVRrlMn
         C9Lx6ltQKxqRSnz1gzbQn2OkY97wYaEt2/7YH5YdnY2g1nOuRVhsxDINaWPjy7t6dotv
         2d1LeQAXvFc3cIGUOtTWmDnSsUYcAjxzBJZkSIYlAungporIXCVtin92vNJS4TEL8Lrd
         hfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OLQk/GuZ1RmMBbMLG8GgkkjESDctOzFQH3zJcOJbq4=;
        b=YyKjIYQ3FnPQtwAUN5CEywaMdcXiTQ/ru5yoY9byi8O4W+clJpW3Be0CoMShxL84Na
         KELSI/nF1V+QgBuZVjzJax6ySXjCoi4e0blB+IqtuPAjQxB8q7QG4xnjNj55tFxxMcBM
         Z/mgxVt+aSkjeCSMVxMEIa3/YJTBG6pQP9HoyNcDjcjM6UGQ3j6REb9I88OAgKeJTE9h
         i92PSZayoBfHuNoMk60egfSnZq1JhFYE7291RiPWdJlh3AHIYjw2BbDr2B+XXtbrLfhW
         t5UE8x3zeERrWYr6bqbuKksX3PAsl4/bwIddWF2rol4w0RIPOzYvpUarA3dKNMFxx5xb
         Y+rA==
X-Gm-Message-State: AFqh2kparMMnlpTiA59+m9GVt7MfjbtQiyXVAnrVZXdpiPHVpifjxqAF
        MEgQw2K2W2Rf0wCmS6ZKbr03xg==
X-Google-Smtp-Source: AMrXdXt7ilFNSG5vyUHxOkVX+LMAaz3kV0gWtbuwW3JZKmsyWGcRsg6L0MNUzQPVB9s+zvTggtaVLw==
X-Received: by 2002:a05:6512:3b07:b0:4ab:f3f1:8299 with SMTP id f7-20020a0565123b0700b004abf3f18299mr8317929lfv.6.1672308845487;
        Thu, 29 Dec 2022 02:14:05 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id s7-20020a056512214700b004b57bbaef87sm2997981lfr.224.2022.12.29.02.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 02:14:05 -0800 (PST)
Message-ID: <a7f09231-fbe6-7bea-258d-5c9503c74791@linaro.org>
Date:   Thu, 29 Dec 2022 11:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/4] ARM: dts: qcom: pm8226: sort includes
 alphabetically and nodes by address
Content-Language: en-US
To:     Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221228230421.56250-1-rayyan@ansari.sh>
 <20221228230421.56250-2-rayyan@ansari.sh>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221228230421.56250-2-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.12.2022 00:04, Rayyan Ansari wrote:
> Sort the includes and nodes for consistency.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-pm8226.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
> index eb36d3662464..a2092569970a 100644
> --- a/arch/arm/boot/dts/qcom-pm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
>  
>  &spmi_bus {
>  	pm8226_0: pm8226@0 {
> @@ -41,13 +41,6 @@ smbb: charger@1000 {
>  			chg_otg: otg-vbus { };
>  		};
>  
> -		rtc@6000 {
> -			compatible = "qcom,pm8941-rtc";
> -			reg = <0x6000>, <0x6100>;
> -			reg-names = "rtc", "alarm";
> -			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> -		};
> -
>  		pm8226_vadc: adc@3100 {
>  			compatible = "qcom,spmi-vadc";
>  			reg = <0x3100>;
> @@ -81,6 +74,13 @@ adc-chan@f {
>  			};
>  		};
>  
> +		rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>, <0x6100>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
>  		pm8226_mpps: mpps@a000 {
>  			compatible = "qcom,pm8226-mpp", "qcom,spmi-mpp";
>  			reg = <0xa000>;
