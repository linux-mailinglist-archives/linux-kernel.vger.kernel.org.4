Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DDF74C690
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGIRS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjGIRS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:18:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761EBF4
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:18:24 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so5607918e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688923103; x=1691515103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4ESr9ycTlv2oyhDdfMdroTzsv1FcuY2XELb8Cinj9g=;
        b=plrOflODvDRg6EplaXi1Kbv7vSI/ij+/ROSCoK/v8rJnX9j2Sxdk3U+VncxJ5kjxz0
         1iA6K0Sqk7l3kIAoFDtkLxBdncWSAlf4TZ9Oilqc4iAZ7PgLeoBhH2cPFPmxqjsHGbHm
         xbw95cttVEdbWkleNdSbTIUUe3gldUTb2+SgaWMB9wA+QyB+lZa7dedtdQ36w8I2qDQA
         /N+AQDuydcTNKxAaetdmIg5JaLWvYrGLbHUpSYVEGudzs9ir62EsDQ6Pmz9btkBHKZqU
         3Ol5cdALdzyzxICPvymN6s+/cxEmRiGBJKdb0KEvmvl3mKilRCK/yQJOGOIaRprBpXAT
         A5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688923103; x=1691515103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4ESr9ycTlv2oyhDdfMdroTzsv1FcuY2XELb8Cinj9g=;
        b=OFoVA7iNnNlkclRt6pHn7TBXrct+1M8dh8Pvmkhuxgo0CgwNO61eS2eSplDvB13YyN
         CFWN6TysueeYeVVUKgsnwi2b5hg+HzIr3U7evEv1SI1M6Dy3FzPX7snnN1Y14Mk5hzsO
         znL2udfC1+qedr1rvJdDf6WF1EBLdkGHE6bVOABRBkS4SqjqoMkMb0a3qu5lyqATIa65
         /SUEpW0EAAIvR1ZYyGc9s/q0Aj3SChM85ZD08dyBzRQ76aZL5iCdBj0ZBaNw9hFXCwmm
         b5U2VkG1V/4mcGIrmhmmwp/hUHzKWVj4Sg7uOc3lU2aUw+SG7vsb1SWIo+iFUQ1H/+iF
         8YRw==
X-Gm-Message-State: ABy/qLYbahDyYqDCBKUkD6tMfX9dvHK15DsbGMC2F7eH6A7a8e6kSxN5
        EadECKXII0+UBFv5/dayGv9S3g==
X-Google-Smtp-Source: APBJJlEF3q8C9/RXRj0i6X1QW9hyoU2aZchYK6HK5qdXq5LupCCj5k9C+09fwOMNhreTqE5GdS2zhQ==
X-Received: by 2002:a05:6512:3d0f:b0:4f8:58ae:8ea8 with SMTP id d15-20020a0565123d0f00b004f858ae8ea8mr8776912lfv.58.1688923102661;
        Sun, 09 Jul 2023 10:18:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v7-20020a056402184700b0051de2455041sm4685273edy.24.2023.07.09.10.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 10:18:22 -0700 (PDT)
Message-ID: <839cfac2-8f74-3386-5854-e3fb2ba4e07f@linaro.org>
Date:   Sun, 9 Jul 2023 19:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/11] ARM: dts: qcom: Update devicetree for ADC7 rename
 for QCOM PMICs
Content-Language: en-US
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        sboyd@kernel.org, dmitry.baryshkov@linaro.org,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_kamalw@quicinc.com, quic_jestar@quicinc.com,
        marijn.suijten@somainline.org, andriy.shevchenko@linux.intel.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-4-quic_jprakash@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230708072835.3035398-4-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2023 09:28, Jishnu Prakash wrote:
> The name "ADC7" needs to be replaced with the name "ADC5_GEN2"
> everywhere to match the convention used for these ADC peripherals
> on Qualcomm Technologies, Inc. PMICs. Update devicetree files for

We do not rename compatibles to match convention. Please provide proper
rationale.

> the corresponding name change done in bindings and driver.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/pmk8350.dtsi         |  4 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts       |  4 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  4 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  8 ++--
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 48 +++++++++----------
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |  2 +-
>  .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  4 +-
>  7 files changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> index bc6297e7253e..149d2bb43d2d 100644
> --- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
> @@ -50,7 +50,7 @@ pon_resin: resin {
>  		};
>  
>  		pmk8350_vadc: adc@3100 {
> -			compatible = "qcom,spmi-adc7";
> +			compatible = "qcom,spmi-adc5-gen2";

You break all users without explaining it.

Best regards,
Krzysztof

