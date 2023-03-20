Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE196C1DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjCTRa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjCTRaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:30:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894D034C18
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:26:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s20so5725781ljp.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679333144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+Ms8Ww2VSBx+DdhMNxA/2llIoFpC8BcQm28rl49gls=;
        b=t3ns0CecKOK/rF2h/744F/AGGdZnNaeQ7nU5HVDRHHVIUTEHKsLWhJ3zwch3kJz9Nj
         e/a0dIgJlcpozKsMnhXT9pvEXncmCHE04t507vvHgNzVdaz7qU8YfhBshl7NnZCp/a14
         cs3HScQ971AwsvRd0Z+/KWO/Qm5K+UwDSYemZH9nY2Pi3K5zjk7LbAW5p4FnyOIVZoSX
         1Ne3eGZrCw2Gumwmxg7Vz5b3lQBsIPIVp3pRxwhIAeWRAGDDarKj676Wlgbq2f0pzHIY
         a52PIt55EEYdx00WVM2R6Q344AT9tZrSgtg1SQFeGVtEjpjuJ7BbAYlYRfYjYMXrTBsY
         yE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+Ms8Ww2VSBx+DdhMNxA/2llIoFpC8BcQm28rl49gls=;
        b=QHffxsAoh2uXj2RQUIDlI7FKy0pIoh/R1nZ9+I7wj0mezzw/H/UsWjgq2FBYBXSKY/
         e2E00zh3ykBkWpC394L8Qfsj5lO2OicgviDiRwDuEvaIzE7UoMFtbQsI40s4y11VT7F7
         ZZultRfITi0z3bJbk4Dbtr1+8+dpcKJgJIIgFVBbW5EtRR1OKrC1FdCtECAeBYj/tY4S
         gTZlYFOrWYg3HeKL3N+0Ps2PmP1iHRnLjNBsuwpcUK8EiVr04ouzhKkus4afKv1+sYBw
         mKOyJb0ZNGtt3NzxiuePSAp1GI0St8KyvzCnVXdIqo7HzOqej5m57RLEiKNfjc4u+7kQ
         kU0A==
X-Gm-Message-State: AO0yUKV2JJhyvjFkjh3N5swRrQfFVriCyQXeMTN9M/2JQSW6Fgqpb7pv
        IvKgZSj8RQhOXNl48Sk1l377Vg==
X-Google-Smtp-Source: AK7set++ZBqvf2vhiSYk8O4j0YKLRe79wz1p11zp8IM5tl/0bIPRhqNRpnVcOHQjyOuEXvyLABFcYg==
X-Received: by 2002:a2e:9d82:0:b0:29b:ad30:ed6c with SMTP id c2-20020a2e9d82000000b0029bad30ed6cmr235246ljj.27.1679333143890;
        Mon, 20 Mar 2023 10:25:43 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id m2-20020a2e9342000000b00295965f7495sm1832816ljh.0.2023.03.20.10.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:25:43 -0700 (PDT)
Message-ID: <d36956b3-cba5-8738-2de2-1e79012bc66d@linaro.org>
Date:   Mon, 20 Mar 2023 18:25:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 11/15] arm64: dts: qcom: sa8775p: pmic: add support for
 the pmm8654 RESIN input
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230320154841.327908-1-brgl@bgdev.pl>
 <20230320154841.327908-12-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230320154841.327908-12-brgl@bgdev.pl>
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



On 20.03.2023 16:48, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the RESIN input for sa8775p platforms' PMIC.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> index f421d4d64c8e..8616ead3daf5 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> @@ -26,6 +26,13 @@ pmm8654au_0_pon_pwrkey: pwrkey {
>  				linux,code = <KEY_POWER>;
>  				debounce = <15625>;
>  			};
> +
> +			pmm8654au_0_pon_resin: resin {
> +				compatible = "qcom,pmk8350-resin";
> +				interrupts-extended = <&spmi_bus 0x0 0x12 0x6 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				status = "disabled";
> +			};
>  		};
>  	};
>  
