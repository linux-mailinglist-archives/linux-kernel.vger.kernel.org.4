Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7872441F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbjFFNQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbjFFNQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:16:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC83210D9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:15:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so7681902e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686057358; x=1688649358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjfzzwF9PKOo4h8atONi+JyNDf6hWNqVhb1cXUpUuTE=;
        b=bkUafAYRKMl7obj5VZygpxdv6WKJzh7W8Bb+29JXza6gHHAqmLDU+78nB11IssGpd2
         1OeSum7JKLGe3AtmgU5duJPPseFOzrBDJHxkWtC8xAriHYwZsuiRZNV0WyUHUMVXDqs/
         5T+r6JPzh4cjODp1oLHDLadYkWRq0SkPAG50aRYOWQBmQJkX8za0enofCFOgea0+xUPJ
         mEWMIw4B5I9d4+VN+gnf21j5Zx8wkVTRWusz4qlZRFJwfD5kIPYq47812k3B+AI2wAt0
         1ZAQqI48j85LezYeg6NFuP+L1py0Xqx0soGRpegawL23Og9ZjOTj3Iw1tPK6zpNc22Zk
         AA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686057358; x=1688649358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjfzzwF9PKOo4h8atONi+JyNDf6hWNqVhb1cXUpUuTE=;
        b=i0dsfEOyrXAwZmdFrRpQLS5DaRkkGIpkKXn/KMSHspkV5vKYCTm5vxjkm60dZvalyW
         0SWVY8jSW5DMb/RzCYO3vFbnjd7zjMRfLZ+9JKpiBlNbvGMkdLGvijWbmddJJnKHeUQ8
         1Cr+0Py4OK+vauownDf169mdMCGffndET8e2Q+1KuWOt8P4qqtLcSfDQLFaO12FoZpzR
         NnaUx6DIxgBabufl3jA9ILOLQSHq0UNfIstVvHqAZE1HT6xagIoaa1UV1SpkIgcP6VHv
         kl5ioW2Lah+2gU3QZiHKHTJfIg0LogvavtpkzQagrh2EBZAS79861CDO8+4m5ujJI0D7
         QTpA==
X-Gm-Message-State: AC+VfDzyqLq8P1TKEkFwJxLeYLBjlIE0r9OgnnGpI0p/CDC7Ay6qC2Mu
        MP4LEFdQSL1IitOfJt6mLJ/aRA==
X-Google-Smtp-Source: ACHHUZ5IDqB1ip1czs+yGIxH79eoli8GF0lqxAjULpLkARWJnwH4tpKVVQ2/mhJde3ptIOTiIdA83g==
X-Received: by 2002:a05:651c:8c:b0:2b1:e8f8:e0ff with SMTP id 12-20020a05651c008c00b002b1e8f8e0ffmr1430127ljq.10.1686057358069;
        Tue, 06 Jun 2023 06:15:58 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id x13-20020a2e880d000000b002ac7b0fc473sm1850597ljh.38.2023.06.06.06.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 06:15:57 -0700 (PDT)
Message-ID: <6548a1d5-9635-7d97-7a0a-0114c463b152@linaro.org>
Date:   Tue, 6 Jun 2023 15:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: ipq9574: add tsens node
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1685703605.git.quic_varada@quicinc.com>
 <dcb682766d8e01f8f4eed7f26fcbfba1b4091137.1685703605.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <dcb682766d8e01f8f4eed7f26fcbfba1b4091137.1685703605.git.quic_varada@quicinc.com>
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



On 2.06.2023 13:03, Varadarajan Narayanan wrote:
> IPQ9574 has a tsens v2.3.1 peripheral which monitors temperatures
> around the various subsystems on the die.
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> [v5]:
> 	Incorporate review comments
"fix bug" is too vague..

> 
> [v2]:
> 	Add "qcom,ipq8074-tsens" as fallback compatible
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 0baeb10..cda3fd4 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -206,6 +206,16 @@
>  			#size-cells = <1>;
>  		};
>  
> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,ipq9574-tsens", "qcom,ipq8074-tsens";
> +			reg = <0x004a9000 0x1000>, /* TM */
> +			      <0x004a8000 0x1000>; /* SROT */
The comments are unnecessary, we've been copypasting them from SoC to SoC
but it's time we stop.

With that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "combined";
> +			#qcom,sensors = <16>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		tlmm: pinctrl@1000000 {
>  			compatible = "qcom,ipq9574-tlmm";
>  			reg = <0x01000000 0x300000>;
