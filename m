Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5393B6ABD07
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjCFKf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjCFKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:35:10 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216675279
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:34:42 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id i9so12058375lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678098878;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpIt6j/YeliOS4bppG5o0gcFhj/uSfcpVT93uVKWijI=;
        b=NezJ3DlBYxJIXrNUvD8JdJ0f0kHF0vQQmBkqlz3IQTkYhZlRNc+q4VGon6Ts05j6P0
         z5L6iYds3lbR5Y1JUOJwMqVhrnU8ZWDNgASY6dXiq24IDgjzzne2ioBEP+ilQqf70+Py
         I1ObiWjcD8fj/fGXQLnmEq/lo+r/e5e9zvNknal3RAfeo3QGTBcBSOfHQYNUIIf23H2M
         oAPwPh84vAvpXVW+59hQYNcBOkdvmEo+XmGwIMquhLJinwJM1ItRCTeNMMhHa6ltCYYH
         axkT0l5v1NvMf2XFC3AQ7c05xuI86gCni1S2n+kt7QymAiNszBw6sIHEJREmAi9Zr/UA
         ymEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098878;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpIt6j/YeliOS4bppG5o0gcFhj/uSfcpVT93uVKWijI=;
        b=MNTbrRCBlYQoUvWFAcTlJ6ZYT7vJheezF+Mil9OsiOyZjLD2e/GQ1fYozighc00BB+
         sYN/yIT2infa8tpo4Q4Y3mWk6jRA7yGalteLhP1/D8oQe5gIK/y2kB1LovJC4MpLkV4p
         0yCBE785fwYnsTg1RHb5t74WQ1/IlvrqIIzYTdca7j9Yjoi4bluuF6MQFyaKHm2Z1vNn
         2XNE2wqB+YlZ7D0TMWs5SEKwWvf4UDte2ip3Yi5wot8BBxin4tPrtL61slJ8elBGu6mH
         N0o1no60sdVs8x2fTmRwHN9mIGyzIaF2+DIshL7NWCjWGfvON9W3UOx6D9spGFyUCH4n
         gWsQ==
X-Gm-Message-State: AO0yUKXnLY8YKID6FUUqizSb9mSbR0fmUkzssdspsrEiE6pIiWXESi25
        gpl0dxvkzu6F9plJUaBBQiyYig==
X-Google-Smtp-Source: AK7set/LPPfpmBmxQtFf+RJtluBBUALRXbaz1bYa5konWz1zrVQNgvAuPcJGT4FIUG+bkjS6UNPgGw==
X-Received: by 2002:ac2:43aa:0:b0:4b5:6042:d136 with SMTP id t10-20020ac243aa000000b004b56042d136mr2816015lfl.22.1678098878214;
        Mon, 06 Mar 2023 02:34:38 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h15-20020ac250cf000000b004a0589786ddsm1591056lfm.69.2023.03.06.02.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 02:34:37 -0800 (PST)
Message-ID: <0f582739-e169-1c17-2f0c-a8ea46d41896@linaro.org>
Date:   Mon, 6 Mar 2023 11:34:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] ARM: dts: qcom: sdx55: add dedicated SDX55 TCSR
 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230306072618.10770-1-krzysztof.kozlowski@linaro.org>
 <20230306072618.10770-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230306072618.10770-2-krzysztof.kozlowski@linaro.org>
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



On 6.03.2023 08:26, Krzysztof Kozlowski wrote:
> syscon should not be used alone as compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-sdx55.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
> index df7303c5c843..72de632b5265 100644
> --- a/arch/arm/boot/dts/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
> @@ -385,7 +385,7 @@ tcsr_mutex: hwlock@1f40000 {
>  		};
>  
>  		tcsr: syscon@1fcb000 {
> -			compatible = "syscon";
> +			compatible = "qcom,sdx55-tcsr", "syscon";
>  			reg = <0x01fc0000 0x1000>;
>  		};
>  
