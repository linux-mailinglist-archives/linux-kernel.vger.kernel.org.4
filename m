Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BCD65C0F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbjACNhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjACNh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:37:26 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7636CFCD2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 05:37:25 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m6so35306325lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 05:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQFy18JQ1dRxEx4LtdGtGz88gqRR4qiBZ9yxigNf2Gw=;
        b=wreb3D5Z7XfSHKUvn2NZ7gUZHu11ra6X1hvq0pXkx0cQGAm9CZKkzqxeUP2wztSTr9
         pXQoqA47rUIUlqUgc1bGFUATHUeGzLZmxkSqL3bV9I9uTr2UM9bphU4OrYVCXGXpKYfm
         pUWRD68PeWisVL0vFbHh7dL6256PeF2v18tc6WD6oAH6f8ofgIEtFD6GLmHpBjBArjKn
         rqXw/ZEJ0c4SAqst8+00nM0C74qYipMsMS79MRH2hntI1IXRepASCu+BzS1RPsjg3E4k
         7HI/CH3+4+ZSroVPJ99nRq/m8gamK8RIgBE+iBiOHW83z897rOC4zZIMsqiMTPx5gbzP
         0Keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQFy18JQ1dRxEx4LtdGtGz88gqRR4qiBZ9yxigNf2Gw=;
        b=YHwMFJ7QDMoInRdaGaaitupcaEpFjcRtO2mVlLDWiER0xvI6Vr/XTrE2rcDcYwaeKE
         9utAv3OJ2ZNRunTVSBoWtGOyUOFQVmOcGLvgXGqKUmYmPZmnqxS4eyOfVIF7Gz5vnkSJ
         RsVVmEFZaLYOQjlV9Rb30cDMPYPPoI1Le0+yKne27m1343oi9HBmBK8s1UDp6z231iWk
         1ILDqe9hRLdL7BNg4+mU8Ka1RAum5ArTxqqOiyp/ja6rRluuCcYWydfR0yjsGrHukW4S
         YvEa0Q2k/57KB5Y/BOP5nqgnrSEKGqH/+5P15cWw7F9WJGTbH2NaEV6/HXHcn9Up4cn1
         fr2g==
X-Gm-Message-State: AFqh2kpbbb4h3RMDHmZWMhUi69W1Ikp2bbIBkehRC3LA+L84f4MbDkxn
        0KxWSu+E6YwpDW3ZAUUvRZWcQQ==
X-Google-Smtp-Source: AMrXdXsw610dQgisZXJIbNB6BT7zt+chBkpj6GQb2p20IuzA6oAFN95l+z7Wpt1h9uIZlsY8ucgntA==
X-Received: by 2002:ac2:50c1:0:b0:4b5:2eb9:8d3 with SMTP id h1-20020ac250c1000000b004b52eb908d3mr12310491lfm.19.1672753043874;
        Tue, 03 Jan 2023 05:37:23 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id y2-20020ac24202000000b004bd8534ebbcsm4793979lfh.37.2023.01.03.05.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 05:37:23 -0800 (PST)
Message-ID: <534ecce6-54b3-7b7a-9c92-48e0b810edc0@linaro.org>
Date:   Tue, 3 Jan 2023 14:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: sm8250: clean up wcd938x codec
 node
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103103141.15807-1-johan+linaro@kernel.org>
 <20230103103141.15807-7-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230103103141.15807-7-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.01.2023 11:31, Johan Hovold wrote:
> Clean up the wcd938x codec node somewhat by adding newline separators,
> reordering properties and renaming it 'audio-codec'.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> index b741b7da1afc..0991b34a8e49 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> @@ -23,18 +23,16 @@ aliases {
>  		serial0 = &uart12;
>  	};
>  
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -
> -	wcd938x: codec {
> +	wcd938x: audio-codec {
>  		compatible = "qcom,wcd9380-codec";
> -		#sound-dai-cells = <1>;
> +
>  		reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
> +
>  		vdd-buck-supply = <&vreg_s4a_1p8>;
>  		vdd-rxtx-supply = <&vreg_s4a_1p8>;
>  		vdd-io-supply = <&vreg_s4a_1p8>;
>  		vdd-mic-bias-supply = <&vreg_bob>;
> +
>  		qcom,micbias1-microvolt = <1800000>;
>  		qcom,micbias2-microvolt = <1800000>;
>  		qcom,micbias3-microvolt = <1800000>;
> @@ -44,6 +42,12 @@ wcd938x: codec {
>  		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>  		qcom,rx-device = <&wcd_rx>;
>  		qcom,tx-device = <&wcd_tx>;
> +
> +		#sound-dai-cells = <1>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
>  	};
>  
>  	thermal-zones {
