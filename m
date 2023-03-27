Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210EC6CA0BC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjC0KCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjC0KCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:02:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD349EB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:02:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h11so3649399lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679911339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nzrlXY169vmptBSZ14ni735sslP027W0vODATNCTldE=;
        b=Vb3F8ybyfwetkmg0osWqeWh8i1mau0YBJPXGKWbXY2kPNtlUAiSgqyKCKmmf10JuVi
         lDxKSEE2ZWXbeSrPPu2+hT13dKVNJuQHg8V8WhTZt9X/qLJcAOlqQT5LXXpUIwh2p/iX
         hpOME2QCXt7TGghvBNBfA8GGPXigUs3uTvKFTVnSNoP5q1cznGdXWQFvU/1NIqdJBfko
         1CBhjHZILjucok2+JOeo7K6m5tZHFKYM2F8x9ivVhXzm4IqdAHRCPAYZgEJo1sV1rmzt
         2qkuIQMPYRrOGzEhQ5gE2Zo8vRoOAw1Uj4zL5hjhkCnvBSID1gQVp5fmDEJYTF100jVa
         ayJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679911339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzrlXY169vmptBSZ14ni735sslP027W0vODATNCTldE=;
        b=xh+/v+hRkcbuOyVkCAJOjLvSCxqMIkWJSwlRVy2QyzIPczPGbDNHo21wnP7ScT8cLj
         9mFbzFmOb5ldEAC+j2AML/eaQMBKjWywUzk13QS6EmLcoCxH7tgFryG/RRadiS7AbdhS
         FOCZtVhXPPJuTkKDqKtICXEVEwxyVloC+F1RZzM4Pa+u9iCqVsflqK57Hy9ZpA8GyPVO
         yGi1xreU29d62Dr2ZfKE0taiQ4/vXXC7PvNF6Q/1LWuUceCC+yHGSeWN5uJe+AvkD0fK
         dcG4+Dcy9AgMub2UpXhsXax8H38F84Q36E+60FE45pXgLD5IMPhR27hTF9cB+QpPB5dV
         017w==
X-Gm-Message-State: AAQBX9fwcknyDCzLKDIX4KodpGxGTB0jbH11syWf1YGYh1mjPQpVHqBC
        2pn8IarJBSDVkkPjjx4MZkxCdA==
X-Google-Smtp-Source: AKy350Zn85bo9cC+P5Lt32895xw7OgFT/y227gFc6/VCwmmUEtiFz5dlVjlwkMo2hZK52XrZHUxDFw==
X-Received: by 2002:ac2:55a4:0:b0:4eb:beb:5ee0 with SMTP id y4-20020ac255a4000000b004eb0beb5ee0mr1974040lfg.35.1679911339292;
        Mon, 27 Mar 2023 03:02:19 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004bb766e01a4sm4633874lfi.245.2023.03.27.03.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:02:18 -0700 (PDT)
Message-ID: <24bcba8e-11e7-ecce-0e08-c9def6cc54e8@linaro.org>
Date:   Mon, 27 Mar 2023 13:02:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/8] dt-bindings: phy: qcom,qusb2: Document IPQ9574
 compatible
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1679909245.git.quic_varada@quicinc.com>
 <ed2abc0c260664c3039a4e7084ed9ebab1151a9a.1679909245.git.quic_varada@quicinc.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <ed2abc0c260664c3039a4e7084ed9ebab1151a9a.1679909245.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 12:30, Varadarajan Narayanan wrote:
> Document the compatible string used for the qusb2 phy in IPQ9574.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> 
> ---
>   Changes in v4:
> 	- Remove constraints not applicable to IPQ9574

I don't think this is a correct way to go

>   Changes in v3:
> 	- Maintain the proper sorted order
> 
>   Changes in v2:
> 	- Moved ipq6018 to the proper place and placed ipq9574
> 	  next to it as suggested by Dmitry
> ---
>   Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> index 7f403e7..3cb27da 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> @@ -18,13 +18,14 @@ properties:
>       oneOf:
>         - items:
>             - enum:
> +              - qcom,ipq6018-qusb2-phy
>                 - qcom,ipq8074-qusb2-phy
> +              - qcom,ipq9574-qusb2-phy
>                 - qcom,msm8953-qusb2-phy
>                 - qcom,msm8996-qusb2-phy
>                 - qcom,msm8998-qusb2-phy
>                 - qcom,qcm2290-qusb2-phy
>                 - qcom,sdm660-qusb2-phy
> -              - qcom,ipq6018-qusb2-phy
>                 - qcom,sm4250-qusb2-phy
>                 - qcom,sm6115-qusb2-phy
>         - items:
> @@ -157,9 +158,6 @@ required:
>     - "#phy-cells"
>     - clocks
>     - clock-names
> -  - vdd-supply
> -  - vdda-pll-supply
> -  - vdda-phy-dpdm-supply

So, how does ipq9574 power on the PHY?

>     - resets
>   
>   allOf:

-- 
With best wishes
Dmitry

