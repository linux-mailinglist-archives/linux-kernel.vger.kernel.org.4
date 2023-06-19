Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B85734D43
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjFSIMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjFSIL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:11:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B268E61
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:11:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31126037f41so2794705f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687162315; x=1689754315;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C8frC8TiuVHslB+HMCCqRpnTLqgdKNXY2aJgyGX1zVk=;
        b=bMqN2L1aL8D4ZfIVJxK0UshevhfvNFhkRKnQmvKNAi52N1XZZZ888TdINIokDRKv8U
         I39nGDicTc4Comxls1cGG35gjt5YJEqIyf9D9cChiXiOUE7Y/CnUqV2skgKLPZush1s4
         I7lGoJrhSK5QnxzSTcUNHogT5v0ZRvqzBMGj3Yjp+2LoSLzsbGf89bPOfvl/bvPf2zY/
         NIcC4M9VaSiugdfhP8ybQ0qKrPSensCOK8G0JDo23f/B953EtkRxYN/L8eFCuUAA4wXV
         WzL0jAkYx8Hlx+LaZFRaD+zetzUk+61nqxrXLIq8S2ljf96SMSH8DLGQzP5ZmureZI8s
         z9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162315; x=1689754315;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8frC8TiuVHslB+HMCCqRpnTLqgdKNXY2aJgyGX1zVk=;
        b=Z8OkFcYiRLTARkDrnbqbYWTp+pwORMOKkBCEWasxbpmuz8ZtetJMQjuzvcRTdS1wXa
         1/r+bU8dPCSA0w2DJcyBaWWgw60NxoR3QvXMaX/ZzexwEDUDabEjCTFATb5gf8nNFyVV
         +hFcXIYpUXIjZKInlRxiTVMBwKulzlM3Y6/DIwmA6airOzj9fNhgvmgk20KgCESd+VNS
         jb4/QGKtoSafFVhyPoY6iOOz/8Zy7tbDlZU5jDuF6LnIGVL1wh+jI3Ci3dLxkFogikk3
         xJ9O4VviJVrAerVuN6x7GzNF0mkyAC/RuU4OBGH6LShp+qMAzUBiT7Cl8rnhMGsYMR33
         Aqcg==
X-Gm-Message-State: AC+VfDxC5MWrIj+M1v3gLbrPHuujBLqpVYUl8vpEB6YzHDyciZTCEOuE
        KgNxBlMESYm1XBEZtau0BaOckA==
X-Google-Smtp-Source: ACHHUZ6ea0iq6kWnXU9vNHgMl340RUm5Kl2MGrZvoW63f5AfuxU2rnXX9ObQ9/EtrCoWvGB9UbBBwQ==
X-Received: by 2002:adf:fe8b:0:b0:30e:5729:b5a5 with SMTP id l11-20020adffe8b000000b0030e5729b5a5mr7272540wrr.38.1687162314737;
        Mon, 19 Jun 2023 01:11:54 -0700 (PDT)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id d6-20020adffd86000000b0030ae87bd3e3sm30736164wrr.18.2023.06.19.01.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 01:11:54 -0700 (PDT)
Message-ID: <3c6a772d-07e3-2338-406f-d8e5b5001dc4@linaro.org>
Date:   Mon, 19 Jun 2023 10:11:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/7] arm64: dts: qcom: sm8350-hdk: correct FSA4480 port
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2023 13:44, Krzysztof Kozlowski wrote:
> FSA4480 has only one port according to bindings:
> 
>    sm8350-hdk.dtb: typec-mux@42: 'port' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index b182f4cf06cc..95a2a42ccb9e 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -349,16 +349,9 @@ typec-mux@42 {
>   		mode-switch;
>   		orientation-switch;
>   
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> -
> -				fsa4480_sbu_mux: endpoint {
> -					remote-endpoint = <&pmic_glink_sbu>;
> -				};
> +		port {
> +			fsa4480_sbu_mux: endpoint {
> +				remote-endpoint = <&pmic_glink_sbu>;
>   			};
>   		};
>   	};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
