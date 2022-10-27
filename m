Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F07960FA22
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiJ0OJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiJ0OJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:09:28 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89628184
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:09:25 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id x13so1360622qvn.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I89zaE05JQ+ZcZwT8dk6MbYPpYEEi3XJBY1DJ5hKJc8=;
        b=yYjiq3VFiXTlggeul5+4tcm2ocLGI+LTUfUS0cEU4BFrLGulj7Ztbd+iBUTFBokeZ0
         xpDizvC92z+8w7X9ubQ91grB07Js2zkadNJuLZt7qN2eSG5a0AvulLt0IftLY31L2wos
         UMkYPSP6ElK/0py4SQLaSxBcq8IGzTTAvhuepOHe8ArQLjASqtrSImfsdVNLRvCrvF7R
         TmqZsCAAMIJw9NJYVXs7QT2ISoJjR6DvZeLEe+YjS3TQf04F1hMMZyokkVX1G8DRVIcS
         qeH1TXHP/qw/yhA75XiBw7AZR1NVT7Zt3/U+GjmU46tRG7CdrQoJx8VkCU33OmHcbTpE
         iLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I89zaE05JQ+ZcZwT8dk6MbYPpYEEi3XJBY1DJ5hKJc8=;
        b=Cj1OZs5hTRpAkE5kwTwriMUwUnKOGwYbQv6OCvTRO40wuEMtMoEw/9SstyHnHigWrt
         R5aMj6BF72LFapzj2n/zLddVJ+O0pBJmgMuNp79bH7m4sx1ZaMqsAjoW00TV5FjWh82m
         w/XhPwP2qkaU7+vjIQkMeB0wSETFYIJIBBsfbZXg/pryKs/B880SCxfM6oAxBu4oSySQ
         zou1ljbBviCivSrfsm6u3q44/Mv0l8nD5ZHL8maQOkNRVlw4bwHVl42IR3NJXyIym707
         nocSn63UPeorUYjhRWSenJLdwJUWQFVQIXN5ggd8QBKhUKc4J08KbSJ4oplhJeapAl5s
         J5tA==
X-Gm-Message-State: ACrzQf1utf2yw0SABbGAr8uV9CutBEtMVV4Z+3wyIkXsXVUFH1Pt4BN4
        kSBSjMvD7D56aVX0/Z/wmu2Jzw==
X-Google-Smtp-Source: AMsMyM5c4U2gbifsaVLJ70wFvb8UG3vCkg8d9jWESRPnpQGPWIfX0FHBuj5EznxDzFJ8dQ7ICfPLCw==
X-Received: by 2002:a05:6214:d0c:b0:4b3:36b4:c89a with SMTP id 12-20020a0562140d0c00b004b336b4c89amr42176544qvh.93.1666879764570;
        Thu, 27 Oct 2022 07:09:24 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id 18-20020ac84e92000000b0039cc7ebf46bsm879240qtp.93.2022.10.27.07.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 07:09:23 -0700 (PDT)
Message-ID: <5e66c095-898e-067e-1874-a3d2e5babf17@linaro.org>
Date:   Thu, 27 Oct 2022 10:09:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 09/11] arm64: dts: qcom: sc8280xp-x13s: Add PM8280_{1/2}
 VADC channels
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
 <20221027063006.9056-10-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027063006.9056-10-manivannan.sadhasivam@linaro.org>
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

On 27/10/2022 02:30, Manivannan Sadhasivam wrote:
> Add VADC channels of PM8280_{1/2} PMICs for measuring the on-chip die
> temperature and external thermistors connected to the AMUX pins.
> 
> The measurements are collected by the primary PMIC PMK8280 from the
> slave PMICs PM8280_{1/2} and exposed them over the PMK8280's VADC

secondary PMICs

Drop "them"


> channels.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 9ac5d5c22832..d300d217fdc6 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -7,6 +7,7 @@
>  /dts-v1/;
>  
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
>  #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
> @@ -189,6 +190,66 @@ pmk8280-xo-therm@44 {
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
>  	};
> +
> +	pm8280-1-die-temp@103 {

pmic-die-temp? What pm8280 stands here?


> +		reg = <PM8350_ADC7_DIE_TEMP(1)>;
> +		label = "pm8280_1_die_temp";
> +		qcom,pre-scaling = <1 1>;
> +	};
> +
> +	sys-therm1@144 {

I would say sys-therm@... why do we need the "1" suffix in node name?

> +		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +	};

Best regards,
Krzysztof

