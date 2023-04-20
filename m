Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2992A6E9145
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjDTK5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjDTK51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:57:27 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D83910E5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:54:54 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bz21so2233643ljb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681988092; x=1684580092;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uokr7AZxxK3CfmGZign+lDpRDB7fqT0OoTxVToKmYGo=;
        b=rRawmEHRBb3p+OkEZhIx/xm6Lc3NBYbOx0vKd8MTbV4XDisNPzecmgUvbKJ2RuHFin
         oUSKzFwcJlr9ARzcvCjtu6tbXXVQhLxH6kqbkSAKU4EV58BRJxF5wkA4qkqI9pG0Zh9S
         pDZ24MqBPdQ4PnJ1yhSfsDUNaj/gxjaIEjMe6Hy45eHrW7QNPYG2nOUg9kZAqKT4jKCD
         zIRl6P8NFiLim6XQ2Luh74X1ZGT/MkeI0CPxxNCmLN7wiGyzdUiyGLmiW/FbwKTxGo5s
         RytmJso9WQDIBIcEScQ9gg2S0PLiFmf/KcAMnONFY8l3mE1I/zT8fgeEytdIS1IHT7dD
         oOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681988092; x=1684580092;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uokr7AZxxK3CfmGZign+lDpRDB7fqT0OoTxVToKmYGo=;
        b=UJ3IWvhje6zkhkgwknv9+3uFeKVd9dVwa172/+4Y5WG/XHbLA4HM/CtktJqRl1mZcb
         Z634qTBgLnJ41kHchSdOK69z3zqHuLyOxoGop7j9iv67FsxPi5u1v14wVp/Z/gygA9No
         UkRQgEujjJNXvT0OHnrUcQbngGHFub4p3gut2ZJZyO9m8tDkboSoLMsYNBCWkPQy1JR6
         n1see8L8NBjNFjHAFf7nkl8o7V49LBSnDs34fNbYqRMxm56Zri2KkDuEQbB3vxuTY4Xv
         J5yeQRARaLfXLQHx/4ElBcbXc7chle7tYLL9t8eo9hp/C14sCni7DomFH0ga79Bl2Kd0
         KxQw==
X-Gm-Message-State: AAQBX9e0UIIWn3V0ipBkCM5ys43UplrXqhMmnFUJA/1QxLsdwaKH8cP9
        YMsk/p9VgFPNnTsB/WBlwUQtNg==
X-Google-Smtp-Source: AKy350Y6mHOM99kCC2rB0bUim5t2Oq4jJrjEuosYy9J5Q150vMdZj9xQdmbFix4bOuUXRf1pjTbKQQ==
X-Received: by 2002:a2e:9450:0:b0:29b:d4d0:d3f7 with SMTP id o16-20020a2e9450000000b0029bd4d0d3f7mr376463ljh.26.1681988092144;
        Thu, 20 Apr 2023 03:54:52 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id y11-20020a05651c020b00b002a8a8f2dc89sm198868ljn.72.2023.04.20.03.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:54:51 -0700 (PDT)
Message-ID: <1d6f426a-723d-fe4f-098b-774f8dbb43b2@linaro.org>
Date:   Thu, 20 Apr 2023 12:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 12/18] arm64: dts: qcom: sm6115: correct thermal-sensor
 unit address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Todor Tomov <todor.too@gmail.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Foss <rfoss@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
 <20230419211856.79332-12-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211856.79332-12-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.2023 23:18, Krzysztof Kozlowski wrote:
> Match unit-address to reg entry to fix dtbs W=1 warnings:
> 
>   Warning (simple_bus_reg): /soc@0/thermal-sensor@4410000: simple-bus unit address format error, expected "4411000"
> 
> Fixes: 7b74cba6b13f ("arm64: dts: qcom: sm6115: Add TSENS node")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 43f31c1b9d5a..ea71249bbdf3 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -700,7 +700,7 @@ spmi_bus: spmi@1c40000 {
>  			#interrupt-cells = <4>;
>  		};
>  
> -		tsens0: thermal-sensor@4410000 {
> +		tsens0: thermal-sensor@4411000 {
>  			compatible = "qcom,sm6115-tsens", "qcom,tsens-v2";
>  			reg = <0x0 0x04411000 0x0 0x1ff>, /* TM */
>  			      <0x0 0x04410000 0x0 0x8>; /* SROT */
