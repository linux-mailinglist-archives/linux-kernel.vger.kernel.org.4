Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4AE63F263
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiLAOMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiLAOMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:12:19 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B670BA8958
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:12:17 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id bn5so2024580ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUdjNoV4twBRqhcTiBFjGp/lnY9gr8hGcfHeADPJd8g=;
        b=gLdbfB+NoqVy/6JQwUiXSvW6BoGUetq5eK6vmNTOlUmYOP8evL6GpfYN+kZWyfsbS+
         NNL3JCmnZGwZRCfZh2uvvJZu5+yoP5SgR3B9lfA5kAqnIlEP2yXp1Tv/VGC2wp13D8lM
         OCyHFiFWhYYlxyrtKNLFPUnyUKfBfKB3bfHjwgxxcqp58zNBvgj0+RadhAq/o/keDVwx
         agzAhliKrCGPBVUlXMSXOCu7/JDLDFONo7w89SHgWkGz6Zh/qWDfukiN3R1y2gmlhfpD
         DitNcH2K9WGIuepM9uIKgADnyE7OzWoCT00J9krofzu+VA6iUWF1FJePIRVi0IF+EGsv
         hEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUdjNoV4twBRqhcTiBFjGp/lnY9gr8hGcfHeADPJd8g=;
        b=Zy/F3hh64ce5UeLMLdh9GSgy4bySI5+RchrA8kzgB8G290AB4TjFAvcMnpHMZg/cKR
         1po5u0atJtjl99dBMZZZwyEM/EFItrElKCoJlT5QLq4T/RNfsgRejfb2Ene85ioD4VTf
         gif+PKA4nj2wqk1Z4cJtb2KgqhoUjZ3ziSDSQhKGaa+7VwG5RgBXxTz37O6QPyIureCI
         Ire6oZbGQj4DzhilzqB6xN2zr+NaJiCqGTf1fU75B0WFV5CYfqwVaDOCnleBJaVoE6h9
         iRMpPmU9UNBGJ8QS5ouUew/MQqCV+8gpD2H331/64qubzAD6FeQ/onvsvtf3aps1UpY6
         IZDQ==
X-Gm-Message-State: ANoB5pkaTcdn2BQ7tzZcTMFFodNPk1Lij9izOgNvWrYitE6NArwqYeRR
        Lsv+L314GNfB+yOhPDddRYePqg==
X-Google-Smtp-Source: AA0mqf52pp6u4HK9pZLT/QCWfEFCWjSU+8eugblqryuYcRqm+NsMavJ6McDbegAIVleeyAbDg4vpYg==
X-Received: by 2002:a2e:87d7:0:b0:277:100c:db42 with SMTP id v23-20020a2e87d7000000b00277100cdb42mr20200484ljj.417.1669903936101;
        Thu, 01 Dec 2022 06:12:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q7-20020ac25147000000b004b514efb1a3sm659117lfd.201.2022.12.01.06.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:12:14 -0800 (PST)
Message-ID: <c91b13e2-ac74-153f-f19b-587ded948a75@linaro.org>
Date:   Thu, 1 Dec 2022 15:12:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 15/15] arm64: dts: qcom: sc8280xp: fix USB-DP PHY nodes
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221121085058.31213-1-johan+linaro@kernel.org>
 <20221121085058.31213-16-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121085058.31213-16-johan+linaro@kernel.org>
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

On 21/11/2022 09:50, Johan Hovold wrote:
> Update the USB4-USB3-DP QMP PHY nodes to match the new binding which
> specifically includes the missing register regions (e.g. DP_PHY) and
> allows for supporting DisplayPort Alternate Mode.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 77 ++++++++------------------
>  1 file changed, 23 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 85c674e7e1a5..3c5bc56e68fc 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/interconnect/qcom,sc8280xp.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/thermal/thermal.h>
> @@ -763,7 +764,7 @@ gcc: clock-controller@100000 {
>  				 <0>,
>  				 <0>,
>  				 <0>,
> -				 <&usb_0_ssphy>,
> +				 <&usb_0_qmpphy QMP_USB43DP_USB3_PIPE_CLK>,
>  				 <0>,
>  				 <0>,
>  				 <0>,
> @@ -771,7 +772,7 @@ gcc: clock-controller@100000 {
>  				 <0>,
>  				 <0>,
>  				 <0>,
> -				 <&usb_1_ssphy>,
> +				 <&usb_1_qmpphy QMP_USB43DP_USB3_PIPE_CLK>,
>  				 <0>,
>  				 <0>,
>  				 <0>,
> @@ -1666,42 +1667,26 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  			};
>  		};
>  
> -		usb_0_qmpphy: phy-wrapper@88ec000 {
> +		usb_0_qmpphy: phy@88eb000 {

Johan (and anyone also interested in this),

What are the next steps with this for older SoCs? Is there any plan to
change the bindings and DTS for them in similar way?

Best regards,
Krzysztof

