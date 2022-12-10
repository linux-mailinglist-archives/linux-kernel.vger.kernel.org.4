Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D64648EAF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 13:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLJMcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 07:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiLJMcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 07:32:47 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A79DFBD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:32:46 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id q6so1072970lfm.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bt1IcNSVmqyqXv33Ev5rTYvEXElPqvKitUErcFHS9UE=;
        b=DtRoMkD32qwCMx4G9MRJapH/ZCgdnOt4mBQI5IUu/FJtRc2K3jri5yxMKTn6FTjZPs
         4D5YF+i+1zZtG/Ax75L/U96Ex86vsIicVJ9/1xmkbFzNZv+RGiasBnQqNL16/Bh93o81
         vV1iv0W/agKM+UDU2Z17Re9lBqwymNE3iz0ywIUNgTsZP6jwzUJ0nPHgbjiWbjCjwePQ
         hSeZ8+ghFIHpP7B/IR1AvqOVQEe8g2dgXynPJ1v0msYCwRNh/5fd60Jf7aiE6QQxf+rG
         CxuDf550Ur+hBQKUjHniVbYnFB1Oku/X82FTwWjahVK9ImurdExBVxRBSBj/Fbjfb663
         Kstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bt1IcNSVmqyqXv33Ev5rTYvEXElPqvKitUErcFHS9UE=;
        b=3gh7wJ+V11ia46VbTb7WHiYp+MgK0jIWObju4plvWl8z0Lj7inzeTRwB9mJiETEMw7
         wWdvtzad/QJwuqrrXOlqnv/Z4TJs8Q5lF3HasuOvtrM/th/b0HVSKlnOiX4Gwqpkzdiq
         WPE2JJT6OfK7JALt78ElmVljrjAJpTUK9mvl+eCukSWtB96I45JYBEuyyBHK+Jv0pR9Q
         ZoTO6syrmVWiIwW4vShrq1EQUV26vDJOpo1C2ZQpHhYCr29YjNg44vZcAXQepdmtrEIH
         4gjNNRPd1NqH2AImpMf8yBZuVDU/cdxTsaHHoTpldlIFb1XXzjNT+j3/BX4DxVcS2Z8B
         NxWA==
X-Gm-Message-State: ANoB5pnG9SWJz8hL+SA7QQpMCRLF9FBQ84azjznC2orcuNBaUIpGOmJb
        a44pfr/C9ixgOZE/vkpiTPM20A==
X-Google-Smtp-Source: AA0mqf56H+QMRP3S56B1qjMyIqh/55KZDkH2G+/pHZd2w2zcCFV7U/WR10Md+4TR2E+bFi5muvEVLA==
X-Received: by 2002:ac2:559a:0:b0:4b4:e429:e912 with SMTP id v26-20020ac2559a000000b004b4e429e912mr2237863lfg.45.1670675564497;
        Sat, 10 Dec 2022 04:32:44 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id r26-20020ac25c1a000000b004a03d5c2140sm704411lfp.136.2022.12.10.04.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 04:32:44 -0800 (PST)
Message-ID: <ae00359a-c920-aefd-d657-0c859287207f@linaro.org>
Date:   Sat, 10 Dec 2022 13:32:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/3] arm64: dts: qcom: pm6150l: add spmi-flash-led node
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
 <20221209-fp4-pm6150l-flash-v1-2-531521eb2a72@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221209-fp4-pm6150l-flash-v1-2-531521eb2a72@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.12.2022 14:54, Luca Weiss wrote:
> Add a node describing the flash block found on pm6150l.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/pm6150l.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> index 90aac61ad264..86e659fcbba6 100644
> --- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> @@ -112,6 +112,12 @@ pm6150l_lsid5: pmic@5 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		pm6150l_flash: led-controller@d300 {
> +			compatible = "qcom,pm6150l-flash-led", "qcom,spmi-flash-led";
> +			reg = <0xd300>;
> +			status = "disabled";
> +		};
> +
>  		pm6150l_wled: leds@d800 {
>  			compatible = "qcom,pm6150l-wled";
>  			reg = <0xd800>, <0xd900>;
> 
