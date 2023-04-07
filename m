Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E966DB44F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDGThO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDGThJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:37:09 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB2C59D5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:37:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c9so45176457lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680896225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DdfpGVYiIH49UkIzv2GHvV1XFU18RQJaEQNhzCtq13M=;
        b=SUsmQp2SAqGZcCP8dwzO8b5RWoOCShD5HGQZ8kh2bmRsn8kPulNesx8rOH8iaS2ZoA
         gM/IrQAEbbGzbs1UxXjonexmSc8JGBEvKUiNrQPAkb2ipIP8ejk6DLU308UWeg3ES+sL
         mDR1loVbl7pjOOcbltu71B+qi9wFO+A4B70DMNKl+ERuYCSCOef8vGZP/gx2xkFIOwk4
         g/mXQ4QXgYGRS4ERI7THLQm087iCuwNG+NvsWaaP/1O0xDZI8DHkbO+w14HUM5Rimhyz
         9MClG9nh/GF4f3lRrwlSiXFz4eIHnHD8CvSIcKGXlgUbDypr1CXeQsOw+N6R9xuOUCJ/
         rsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680896225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdfpGVYiIH49UkIzv2GHvV1XFU18RQJaEQNhzCtq13M=;
        b=fO80iQrkEayxXHlthtexMhW1dm7mFLJsZli33yWYlZV2chxUoGAiez52Ht7zVHw+FC
         Uqd8FQMpyyOXK4fs9QDxpXKUXyK1oYg6JmelaJJp+Gl6TwNsA0thDeP9ZqoDgFI486Cr
         Pgv9da1p0bnVoyJvQv0XyRLXhCxflRuKibiKWcPFA8rqvFMNxZQgHJRwjvrbc5zKS/SU
         witHbWx/amGrN4N+XEBH0CpbrZaRN4mr2/6BhncLQ5xg4gQz5Yg7kzm//avSQmJX7ynK
         orTk0d6VnOfRmuTIEo02ygWcJxQi5nRn3IuS4TZQXTEAaX9QcOfDBeUHxsIRxMNk0VLa
         x8DA==
X-Gm-Message-State: AAQBX9eWpCwAeg47nfuG+dehNW+wdKWE2+Uy6UcYUeJ/5KoRAhAWgF5W
        hbSF82ZH7JDwVbuYLtAChOyNZg==
X-Google-Smtp-Source: AKy350ZQ15H7KLZBjASa/i2jAVoikKumGXTpFkE8mHSl+jgIfK82QhNHdBDxJkLugnfG+uWiRsjymg==
X-Received: by 2002:a19:5503:0:b0:4d8:8273:ec with SMTP id n3-20020a195503000000b004d8827300ecmr833199lfe.20.1680896224936;
        Fri, 07 Apr 2023 12:37:04 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id i13-20020a056512006d00b004e83edd8ce8sm840581lfo.196.2023.04.07.12.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 12:37:04 -0700 (PDT)
Message-ID: <db168415-74b0-c83e-248a-a70b1c9b71b7@linaro.org>
Date:   Fri, 7 Apr 2023 21:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V4 4/5] arm64: dts: qcom: ipq9574: Add SMPA1 regulator
 node
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com
References: <20230407155727.20615-1-quic_devipriy@quicinc.com>
 <20230407155727.20615-5-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230407155727.20615-5-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.04.2023 17:57, Devi Priya wrote:
> Add support for SMPA1 regulator node in IPQ9574.
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  Changes in V4:
> 	- Updated the comment as suggested by konrad
> 	  s/Updating/Update
> 	  s/725000uV/725mV
> 
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> index 3ae38cf327ea..bdc1434fbe67 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -44,6 +44,25 @@
>  	};
>  };
>  
> +&rpm_requests {
> +	regulators {
> +		compatible = "qcom,rpm-mp5496-regulators";
> +
> +		ipq9574_s1: s1 {
> +		/*
> +		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
> +		 * During regulator registration, kernel not knowing the initial voltage,
> +		 * considers it as zero and brings up the regulators with minimum supported voltage.
> +		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
> +		 * the regulators are brought up with 725mV which is sufficient for all the
> +		 * corner parts to operate at 800MHz
> +		 */
> +			regulator-min-microvolt = <725000>;
> +			regulator-max-microvolt = <1075000>;
> +		};
> +	};
> +};
> +
>  &pcie1_phy {
>  	status = "okay";
>  };
