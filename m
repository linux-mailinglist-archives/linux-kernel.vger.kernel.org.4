Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095AE6C342D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCUO1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCUO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:27:05 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA211C7E7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:26:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id e11so7055001lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679408779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCldgHyb2h9qixVYyJ2sNBAegoqWwBxyeftYH7xEsmc=;
        b=T+qAhy6K1TQrkXS1CTvRjPnaXO4CxQ6NGlIDnPP/dT6/7KRuNYRmy2Ug3pjFKVASBT
         1qvzyNmGJYqbgLQO6/Cf/Izqc9IpWMjrqDg2H413zwiKbSjqaBR0m15dZmiOzxDP53Sz
         tABzJv6CGhb/2mJfVmnlxhwJ66iW3JGSLsihYRMWwWO+38B+xwXDdcHgiMFDZo9FfFVB
         g1Uy2JF3a2GqhF5Hat4ggGWTanzrbCQgdqEL/ubEFTrkhg0Hzr15jnPez4cDgIlVflos
         2h1LPvQn5t6I+E5WBRKF+8W6TXOly/G0u13mByLe+6GCuwbVHwTnLIEuFwfud8XGtcy4
         vn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679408779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCldgHyb2h9qixVYyJ2sNBAegoqWwBxyeftYH7xEsmc=;
        b=MmhYwfVFiYBXo0hxjXAGXUVGL7qwXYZdwB/krrMG5tZVb64aMdMNyRkNY2AEtgzTqc
         +KT8rVzd/vAvmLCULCBRQNKkhDTYMbLoKOfImsfqykIwnjF51aojNCPyoEqa5KnKgWpv
         kYhRZ/GfNBlnEn2w+2qeTd9iwadf6gKuPybQcKxhpDrxNTbo/r50QHepVjnu+KJM0LfH
         aO+2gzGzlQficEWMEhVymoF4R4Pgy6evAJz2G9zvJ2iWkvwCVRX50jwpz4HHC8YaQ/h1
         7mwRt9rQ27GOfKx4J06ogKynAreyH09xeGLrkbhrxj7gBsSTD3gkuVenA9Jbjhl4RRJF
         z88Q==
X-Gm-Message-State: AO0yUKWXKNHMGsdnfEsZo2Hu5QXef1pS4ibsvlDMT2mtPPLe8aMkwaOe
        s/mVllgeKZRBr+9zJo4/HtVZQQ==
X-Google-Smtp-Source: AK7set+/y9mc2nTmKbUOuAllDfvUsL4N1tdjoDkOt0gbg31qdSipHaF6kXT51sTVoupQKws0kmETig==
X-Received: by 2002:a2e:900b:0:b0:29e:e7b1:1202 with SMTP id h11-20020a2e900b000000b0029ee7b11202mr936794ljg.43.1679408778928;
        Tue, 21 Mar 2023 07:26:18 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id m18-20020ac24252000000b004db3eff4b12sm2183408lfl.171.2023.03.21.07.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:26:18 -0700 (PDT)
Message-ID: <5d058a4a-4ca9-db0a-f472-743a73cc7e8e@linaro.org>
Date:   Tue, 21 Mar 2023 15:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 09/12] arm64: dts: qcom: sm8350-hdk: add pmic glink
 node
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230130-topic-sm8450-upstream-pmic-glink-v5-0-552f3b721f9e@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v5-9-552f3b721f9e@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v5-9-552f3b721f9e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.03.2023 14:21, Neil Armstrong wrote:
> Add the pmic glink node linked with the DWC3 USB controller
> switched to OTG mode and tagged with usb-role-switch.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 46 +++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index 09baf6959c71..a10bf7c8764f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -31,6 +31,40 @@ hdmi_con: endpoint {
>  		};
>  	};
>  
> +	pmic-glink {
> +		compatible = "qcom,sm8350-pmic-glink", "qcom,pmic-glink";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss_in: endpoint {
> +						remote-endpoint = <&usb_1_dwc3_ss>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	vph_pwr: vph-pwr-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vph_pwr";
> @@ -674,8 +708,16 @@ &usb_1 {
>  };
>  
>  &usb_1_dwc3 {
> -	/* TODO: Define USB-C connector properly */
> -	dr_mode = "peripheral";
> +	dr_mode = "otg";
> +	usb-role-switch;
> +};
> +
> +&usb_1_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_hs_in>;
> +};
> +
> +&usb_1_dwc3_ss {
> +	remote-endpoint = <&pmic_glink_ss_in>;
>  };
>  
>  &usb_1_hsphy {
> 
