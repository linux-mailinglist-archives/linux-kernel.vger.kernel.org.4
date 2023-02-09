Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C286690E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjBIQj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBIQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:39:26 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A037D5D1C8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:39:24 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id jg8so8120259ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 08:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0o3fie53BoLSY+AYigVplq0bFcGf6Tkg6Mvf3ssOE20=;
        b=Lve4rYIzrxrtSUDuWRsPS93B0O2wbupX0lwqTO/GN5HOIpefYg7xMru6BRdkk4woqK
         QzJITlxNueMNUyOhevm7ovjGcZUCKLZciSHfWrSnsr6jMaptu5Zcb45olfSuIpTaVETy
         Ikn04w9TQeipfesOUsLTceuUbKbzSkrvWWc1ddjPH83bQxp9Ch9sjTKu3Qw74qi2Iu6a
         VsJNDLxQycUYrL4Oq7DyyP6lt5uEZwJF68nfHTrCmwTg4R6vvJxVMLQZmFt6cSR4nq+h
         otWpCoCCZ6URY2stou/kS8h3ZKJtmGVDrtD6XK1njVdAovgDQl2Mo1kAQY4GaVHg9neO
         WeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0o3fie53BoLSY+AYigVplq0bFcGf6Tkg6Mvf3ssOE20=;
        b=oJdZAAnIk+3DILQcVGAImcJdBtmV7wooVuF4GvYIwJagZYpUQ36ZHQo2lw9iXS4l/E
         nSIzEgTofV13Y8B+ZLcYX1bKUkBGj3XLN6a3xloWt73B8U4RWrxnSKqywRYxgLWx4x0H
         KQtoQLql9IK4yH86Ge2knfoaCxoe9IO3hF/YOvnIPOlQo5t17ul/ZMDkRgIH3pS/ZjPA
         e0vlFQtICroGkrWG8MuL7NnFz+Fllkr9iW3eR5URRv09Ovi/W+yNXMTqsvYNhVI74trT
         /+oOTXV3W3gZjsXb89IrQ6wZE662mw/+OeVaWvhzHXdHE9xKj8pDRhv3SlSe6Nmxn/mQ
         ldKw==
X-Gm-Message-State: AO0yUKVh5EWR78jQWuj13EdLu5vsUz3FSSuDdD+I0XoyXUAIpz75JJHT
        7lW43qnEG3ybzZhmvL+7OOvsOQ==
X-Google-Smtp-Source: AK7set83961mDHFsorQjbZQlf6FTG80WERK+9DWuwKV4SF9NzNjcJiamUsILaNdZXp7n3NrCGqYpag==
X-Received: by 2002:a17:907:c29a:b0:8aa:c155:9233 with SMTP id tk26-20020a170907c29a00b008aac1559233mr8569998ejc.26.1675960763266;
        Thu, 09 Feb 2023 08:39:23 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709060dc900b0088c804c4ae2sm1049166eji.201.2023.02.09.08.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 08:39:22 -0800 (PST)
Message-ID: <38582f72-a9d9-c6e9-518e-6c8670dd40d4@linaro.org>
Date:   Thu, 9 Feb 2023 17:39:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: bring back missing disable for
 spi@4a94000
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230209155831.100066-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230209155831.100066-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.02.2023 16:58, Krzysztof Kozlowski wrote:
> spi@4a94000 should stay disabled in SoC DTSI and only enabled by
> specific boards.
> 
> Fixes: 1d0d6a6e6f6b ("arm64: dts: qcom: sm6115: Add geni debug uart node for qup0")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 3eccfb8c16ce..39a63ff46fc1 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -1001,6 +1001,7 @@ spi5: spi@4a94000 {
>  				dma-names = "tx", "rx";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +				status = "disabled";
>  			};
>  		};
>  
