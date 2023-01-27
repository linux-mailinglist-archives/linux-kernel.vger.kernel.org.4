Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4D867E0FF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjA0KEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjA0KEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:04:32 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7851E5F7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:03:46 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gs13so1564444ejc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqcOIHJ8AdmjqV9pu1TUZaFga/jZxoTHW8uGlyxqnn0=;
        b=jtYILTuidtzcVDMu6N4Iz8i/X9vcd0ViaWG8pc4cA8zUATmQsQmPAs8TLM1hiHPXu3
         kvDYgvO4IZtFOYlSes8zvjDnPxGKt1xGxSZpv+wuX2W+YdZ4sKFsc9NerFlx1/MiPPe1
         TOw7K36DDjggL047rptRUAhsw7X9XFqwk96bah8rWAqyFeNw1YdRmfqsaLirbDGTb9Nw
         U1sguT5GwyQWvBkmfB3w5aG8eKySuhxSpTmI25/S8dofcvm9x0yUthHRF7s+lXpYYR30
         TvVlk+vifv4j51J6ohZYLr7jyXOl/JdGkdAS/Zc3MOlL7TC60pC5FF2AvYzdaXAOnDYT
         nclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqcOIHJ8AdmjqV9pu1TUZaFga/jZxoTHW8uGlyxqnn0=;
        b=SgiZhP0BVK2O92qm5rB5XhLWBgcpXUW8XG1Po3rXzMZD6e6cyZUiSZxHziKdeltTd5
         fCllU9MYPvRBVUNi+i0n+URpU8hHrPWL/eB2n976FoSldJPu2mlxJfZTic0s636+VSgm
         KmCFBjUcoe9yYJagp0oExKYmwBpwd/RE0ePkaUacI5ZGqoGGcHjqW9BjoYlD6Zsp5tlr
         5OTROS3YjZ+9TSSDkovsLxfsokTa+lY7HqeIixWUQqzp+2h0/aSrOmCBUZ4JW7YUgpzY
         sA5H6wvvONykjV4LIi9qA2ySuLeVeEK41Hw+FZE0j0c0G/CJGlQnqu64ZdDlW5oeJYY/
         Bdsg==
X-Gm-Message-State: AFqh2krJi4iPStXasikYdXyHEejONkFjhowbg7TmsSGoA4YvxP14Yay+
        oyD34lcR0Y1rVG8uzkrWrTMg9A==
X-Google-Smtp-Source: AMrXdXsA5HAt49wMzF8Xw4aZITkpZA52qt+jVIL4FDekX//BTbCTAPcFimR0oQKQce9slcF2MOSKFw==
X-Received: by 2002:a17:906:1f57:b0:872:2cc4:6886 with SMTP id d23-20020a1709061f5700b008722cc46886mr34797636ejk.30.1674813824644;
        Fri, 27 Jan 2023 02:03:44 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id gx27-20020a1709068a5b00b0086b0d53cde2sm1947693ejc.201.2023.01.27.02.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 02:03:44 -0800 (PST)
Message-ID: <a3bb7ecd-d97b-9465-60aa-bbf7d145a705@linaro.org>
Date:   Fri, 27 Jan 2023 11:03:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] ARM: dts: qcom: use "okay" for status
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230127095319.64560-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230127095319.64560-1-krzysztof.kozlowski@linaro.org>
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



On 27.01.2023 10:53, Krzysztof Kozlowski wrote:
> "okay" over "ok" is preferred:
> 
>   serial@f991f000: status:0: 'ok' is not one of ['okay', 'disabled', 'reserved']
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts | 2 +-
>  arch/arm/boot/dts/qcom-sdx55-t55.dts              | 6 +++---
>  arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts  | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts b/arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts
> index 6a082ad4418a..288cacd5d1fa 100644
> --- a/arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts
> +++ b/arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts
> @@ -20,5 +20,5 @@ chosen {
>  };
>  
>  &blsp1_uart3 {
> -	status = "ok";
> +	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/qcom-sdx55-t55.dts b/arch/arm/boot/dts/qcom-sdx55-t55.dts
> index 61ac5f54cd57..ccf2b8b42b16 100644
> --- a/arch/arm/boot/dts/qcom-sdx55-t55.dts
> +++ b/arch/arm/boot/dts/qcom-sdx55-t55.dts
> @@ -233,7 +233,7 @@ ldo16 {
>  };
>  
>  &blsp1_uart3 {
> -	status = "ok";
> +	status = "okay";
>  };
>  
>  &ipa {
> @@ -243,11 +243,11 @@ &ipa {
>  };
>  
>  &qpic_bam {
> -	status = "ok";
> +	status = "okay";
>  };
>  
>  &qpic_nand {
> -	status = "ok";
> +	status = "okay";
>  
>  	nand@0 {
>  		reg = <0>;
> diff --git a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
> index c9c1f7da1261..db7b3d5b0bd0 100644
> --- a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
> +++ b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
> @@ -233,7 +233,7 @@ ldo16 {
>  };
>  
>  &blsp1_uart3 {
> -	status = "ok";
> +	status = "okay";
>  };
>  
>  &ipa {
> @@ -258,11 +258,11 @@ &pcie_ep {
>  };
>  
>  &qpic_bam {
> -	status = "ok";
> +	status = "okay";
>  };
>  
>  &qpic_nand {
> -	status = "ok";
> +	status = "okay";
>  
>  	nand@0 {
>  		reg = <0>;
