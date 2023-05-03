Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08986F5C00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjECQ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjECQ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:29:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9E07292
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:29:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc2feb320so6742436a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683131341; x=1685723341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AeGjiRxodEeGq070SZlBIm9caXWVi3ClWZLHmGEvqS0=;
        b=YBwc3Jr/tVLm3F5tPgm+OILYzq7Cd9J2SH4nxZklWRXu+Y5f1EkwAOw9LjMRzvwehY
         ngZiCckoPwMlb6jqDVaatWmGG8v2BaQLMuW4VM8BzncLAbGk7bRfZEDVhdHb4q4GN672
         MtUea+jXP9f4FJKzBlXn5T/UkiW3f04CNKlWfK5s5PqsOz8TnTkK77gCE33Xjye7rJ4o
         pCIFh1ZU/XWZbMsMxFQDNHmoXnIo+pUrqFlX2t8Woq4em3hmi7zYbRcYEsw1KluWtiyA
         qGuY8FBXnJkYYAnPwMxz5G4OZpGi/nFWZMSy+swzDDveFMavD6CcWREZdWw5HWxHBWQY
         BsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131341; x=1685723341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AeGjiRxodEeGq070SZlBIm9caXWVi3ClWZLHmGEvqS0=;
        b=bB5SQBHoN6QACOgqNLknqbHNSP80UjZkdmNbCY6JPvH1BB8Xjez4U1Ru1CGVW8WDnm
         fWR8BoKwQNXuEtjfb+x7rWCrzXjGv1da1zN4+yiWJyhazRxhfvlzOemNqkBTWvzdhnzV
         Rx7lJ+WXmZa/2dZtBdeYuz9WC/kBOwlwdZu6vpfaGdixgJ9ghsxVlCmEdQfucqp7Rcoe
         U0LiwpOVle0aQLSyed1LlOdxcSDghAb6v5rLjD6FNaXSO8qNPDDqdYnfeIwVhOyala+P
         xWvQdRaEYqrAUvEFbv3DozkzDcSNmRdwQwgoK7UA5q3tRkA8AGt6GxbFh8oVAhnHP4lm
         PD/g==
X-Gm-Message-State: AC+VfDxsmo28Q1NPq7qbh0ctno2CrJPA42ysaqI2Xl7//1wESf5/2D0Q
        yP/iBZMNJjMb6uDpUhPSwNIjqQ==
X-Google-Smtp-Source: ACHHUZ5Yim8YQR5XyfWMJMQFx5/VrdVrOpm/MU33VXtdboHVYz2WXoeWCAoHVarw4guuWHC8hv89gA==
X-Received: by 2002:a17:907:7290:b0:94e:1764:b09b with SMTP id dt16-20020a170907729000b0094e1764b09bmr4073320ejc.45.1683131341165;
        Wed, 03 May 2023 09:29:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:db42:e3d0:c55a:8cf1? ([2a02:810d:15c0:828:db42:e3d0:c55a:8cf1])
        by smtp.gmail.com with ESMTPSA id dn1-20020a17090794c100b00953381ea1b7sm17454132ejc.90.2023.05.03.09.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 09:29:00 -0700 (PDT)
Message-ID: <dae43973-18d9-7096-d23d-660e71c7aa97@linaro.org>
Date:   Wed, 3 May 2023 18:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sm8350-hdk: Add QMP & DP to
 SuperSpeed graph
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
 <20230503-topic-sm8450-graphics-dp-next-v1-3-d1ee9397f2a6@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v1-3-d1ee9397f2a6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 15:10, Neil Armstrong wrote:
> With support for the QMP combo phy to react to USB Type-C switch events,
> introduce it as the next hop for the SuperSpeed lanes of the Type-C
> connector, and connect the output of the DisplayPort controller
> to the QMP combo phy.
> 
> This allows the TCPM to perform orientation switching of both USB and
> DisplayPort signals.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 74 ++++++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index 2ee1b121686a..fa835bdb7408 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -58,7 +58,15 @@ port@1 {
>  					reg = <1>;
>  
>  					pmic_glink_ss_in: endpoint {
> -						remote-endpoint = <&usb_1_dwc3_ss>;
> +						remote-endpoint = <&usb_1_qmpphy_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_sbu: endpoint {
> +						remote-endpoint = <&fsa4480_sbu_mux>;
>  					};
>  				};
>  			};
> @@ -326,6 +334,36 @@ zap-shader {
>  	};
>  };
>  
> +&i2c13 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	fsa4480@42 {

Node names should be generic, so e.g. typec-mux
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "fcs,fsa4480";
> +		reg = <0x42>;
> +


Best regards,
Krzysztof

