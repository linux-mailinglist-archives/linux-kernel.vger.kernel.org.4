Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECFB6552B4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiLWQVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiLWQVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:21:03 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D452B2BDB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:21:01 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id s10so5535007ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGE4aiddpWZpTmOp5qjqXo8uOyEFwG1Nm6YUdO3rP4A=;
        b=Flom2l1aG9I0SlVPGYNJ2w0R4QOnwrBFEjXOvevK7KZSM7AwQocmB3nIXJlMfCB2sL
         ZDT7P5uMUlQFf7JtnBM/er6mTCfcEg5/QgidskA8KThV+PW+hSu+MPObF/N+G+WCtyp/
         TmC+T87O9RqgTyZGo+eBG2yJGOHdr8FQVc6JipdNXU8Y/V6XZToBcAdgIa0ErYC59wXa
         MSyvyH0Ofcb9FJpAAVSNuoszV5dvpm/x2UtVMsoImKISpnWRCiNXjcA/p+46ZPxjaYP7
         A8ms+jqsFZGihbPFRZ/TDlJ8aqEITN0nfx0XHP1E7JR0WMtp1DxtSoIShY1R0rsiB2Du
         njHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGE4aiddpWZpTmOp5qjqXo8uOyEFwG1Nm6YUdO3rP4A=;
        b=kaYanFULOW1md6ZRJCB2UkRfQR2YmiEm8E0Nv9h9ZbTR9XsAf78fhIAY+Xb/IONKD4
         aqI1EO2c8xs7qmhyRGWTUSQgpwugRUjyurOtR0pEPPyrJAcl75NL0/VGRBhK6/a2zaH7
         jQ6UTyjeQYgTlqiL+8wtEtZVai17+rb3ZdwNb/kbAK6Oo0PMRF5xdSOvOoBHSY1uwkbs
         ltfUeuTGMm6UCLNfRKWIZbk0obYKINDZ/ox/2pgWm9x8NQ5Jfzu/D5NizxHkLOQYVRmP
         RO+r+yiwHdSvkm37swlKpbQHKWNeger12Oeu1f3i/g0T5TzshG+gjuIXdIJ3TMqfWXTA
         9iKA==
X-Gm-Message-State: AFqh2krGO8bI3fHPfnkUFDnkSaL895xpToq0aQHtkSdxGrTotKZwjfGf
        lkS9Wma1P0YvcM73b5fMBkRNMA==
X-Google-Smtp-Source: AMrXdXvA/MuFWJXmof5QSgEpiEWgEl1DXp7edXH+5w9yIKkKFO3TP0PVccR72yksEh04fko9ECJeLw==
X-Received: by 2002:a2e:980a:0:b0:27c:f0af:37b6 with SMTP id a10-20020a2e980a000000b0027cf0af37b6mr2449246ljj.11.1671812460272;
        Fri, 23 Dec 2022 08:21:00 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id s14-20020a05651c200e00b0027a17f86998sm494761ljo.127.2022.12.23.08.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 08:20:59 -0800 (PST)
Message-ID: <d6fcecda-2f78-bd75-579b-672f6db779a2@linaro.org>
Date:   Fri, 23 Dec 2022 17:20:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/4] ARM: dts: qcom: sdx65: add specific compatible for
 USB HS PHY
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
 <20221223161835.112079-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221223161835.112079-3-krzysztof.kozlowski@linaro.org>
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



On 23.12.2022 17:18, Krzysztof Kozlowski wrote:
> Add SoC-specific compatible to the USB HS PHY to match other devices and
> bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index b073e0c63df4..d3c661d7650d 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -219,7 +219,8 @@ blsp1_uart3: serial@831000 {
>  		};
>  
>  		usb_hsphy: phy@ff4000 {
> -			compatible = "qcom,usb-snps-hs-7nm-phy";
> +			compatible = "qcom,sdx65-usb-hs-phy",
> +				     "qcom,usb-snps-hs-7nm-phy";
Not sure if the newline is necessary, but still:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  			reg = <0xff4000 0x120>;
>  			#phy-cells = <0>;
>  			status = "disabled";
