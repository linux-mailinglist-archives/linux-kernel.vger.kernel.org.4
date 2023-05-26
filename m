Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC14712379
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243104AbjEZJZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbjEZJZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:25:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D041A8
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:25:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f3b9e54338so548915e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685093100; x=1687685100;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52mmibDACLRMIh8RU4WtvXxPHcTWwwRXhF0d9Ge0SzQ=;
        b=SWafjm1ssOiBH2WLljAAYcgvuaVfMDWsHaWwXlgB3trlEbpz90v5jhW+rzV1ID/oP9
         g+rz1Kd+fS1laGsB+WJkDxOX853hiS4KwSKZQH4xkx+GuR3072NlkHNqFXdPcSTUt9bH
         ZIzDk93zC8iF5sLrG5A/1o1fa2ju/pZYsQpnYsixSzTB6OClm8Gk2sZBFbjTnvYH6VnZ
         rOFBrLVMuNWo4FcQFVV4mIqx/WEtgmw5ouIRXRVd7JU2QGBQdLfRgD+j86gf1G7vy4EG
         XKy81SmVn15z5rrafeaOsbRSll61Y0B0YfVl1OR/Wjgvr76PLsRE1Ysi4C6wEUto2Ewj
         i8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685093100; x=1687685100;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52mmibDACLRMIh8RU4WtvXxPHcTWwwRXhF0d9Ge0SzQ=;
        b=EzrbM2koMXWb+KnllqRE+qBBB+4CQ1o8bjjARbGcwvAzw3kUPvvfwNBgVY/XETVJ/8
         svMybdXH4JDudgIG9/NxN7w9VTbgUrwG1Dl09VpSPmd9eGiM7GeoYGPfxHZisDhIWBLQ
         GsWU4wg7YkcufUuSVG90ddxPpGKBzMpF4vl6I+eQ8NRQYQP47WOLQzcrTK85LflY9uqF
         bR5m8cfSwI0UYlfeWFyhe6J9xMsoyQ0GEDsiIoCG49rHMQpfFjVjedE53o+x4n8Q7K60
         +SiWVhYBKGqwiF9V/1SERxv5C2r2KreQ9Whj2IADhoWyZHwdI2ZBcC4qYJli6iPYOGxn
         r+bw==
X-Gm-Message-State: AC+VfDyslN+0gswTktaMBXoqyYdtdgnYrnZWZ+6kCMP1BCjDjdbm5Wrc
        VnH2ipogIqRbjpMe9Z/pVuRPoA==
X-Google-Smtp-Source: ACHHUZ5eWBjMxaSbV0u8cTeCUf97RgS+TuJiJQSMYefmEf93NwMwzC5UXlGziD1OlJG3xRdpw30qnQ==
X-Received: by 2002:ac2:4425:0:b0:4f2:7cb1:65fc with SMTP id w5-20020ac24425000000b004f27cb165fcmr281618lfl.64.1685093100324;
        Fri, 26 May 2023 02:25:00 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id q9-20020ac25109000000b004f252003071sm543346lfb.37.2023.05.26.02.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 02:25:00 -0700 (PDT)
Message-ID: <4e226295-e19f-9518-6dda-7f96665ada65@linaro.org>
Date:   Fri, 26 May 2023 11:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: ipq6018: add QFPROM node
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230526070421.25406-1-quic_kathirav@quicinc.com>
 <20230526070421.25406-4-quic_kathirav@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230526070421.25406-4-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.05.2023 09:04, Kathiravan T wrote:
> IPQ6018 has efuse region to determine the various HW quirks. Lets
> add the initial support and the individual fuses will be added as they
> are required.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index f531797f2619..856879fd0207 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -206,6 +206,13 @@
>  		dma-ranges;
>  		compatible = "simple-bus";
>  
> +		qfprom: efuse@a4000 {
This should be a bit lower down (0xa4000 > 0x59000)

Konrad
> +			compatible = "qcom,ipq6018-qfprom", "qcom,qfprom";
> +			reg = <0x0 0x000a4000 0x0 0x2000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +
>  		qusb_phy_1: qusb@59000 {
>  			compatible = "qcom,ipq6018-qusb2-phy";
>  			reg = <0x0 0x00059000 0x0 0x180>;
