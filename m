Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D44464425B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiLFLpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiLFLo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:44:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC90727FC8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 03:44:57 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 1so9602440lfz.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 03:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zs/glU61iMmBEYzfjQPXxEkfHrnwIczjCeiehS51xyg=;
        b=ZowRqI21xHzHjcUsGCIreEkHoDNuEcDh/y4chsUa54F27NggrLlvBnCDYQ6qIF2ZDh
         MDGOF3EeoPGe7gRaA24mEtqr3F5NNjk34cwjTRnUm1My5khxRdA5FGGY9RH4cOWNjdAv
         lSLaVA9HdJA0Q7yKQMeCEU2bmSCDMxnsG3qttL0fjORoCuVvww4AgTwubuwvZBNpMxZQ
         dm/GqmvZRF38t5UbgJ0LYv+B3SqhdnDVqpW1ewLwVr5jqVBg9YWXqjgRaAffzExOp7hu
         GrxYK/tFsPJEypaRxEwq00CjoVKdGZ45O9A2T8SwO4N1KyUqlnQ1XkODroJzz/gOaxX1
         6/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zs/glU61iMmBEYzfjQPXxEkfHrnwIczjCeiehS51xyg=;
        b=1Vdv58yCtbbf5tUjK66u29Vpbk8KALTdQ6usKPQv3GOgw9NxtNyAFblRp4tHVRC/t9
         ruJWG3tmIPh8RYRziJDqQ4c8qI1EjTfG5CLU89gzzT1aTQf8o/2Iuffa6IBz7euHfOPv
         L87mHK9DqpzeZnNQpkTHf83DZZBa96p7XypJ/bWSRYyq/u4EvstDu7MFq+5Gs2OAD0bV
         ipcfycSGnSikuLJMg+fVx2oQNTt75c026yHR4qyDytWJtpVu4AZD22eHvKYe+rEnxxiv
         kNQblZLkffSJHCG4lfMz10BYH0UNKBU0w4TAivZLqPo7cPGEMQbpj9AmowgRLSjjPMGm
         fMSg==
X-Gm-Message-State: ANoB5plSH+CznT1VrjeZVZa8tiJRPCNIHtlLVW3VOCN2f8kfCsxTFmhV
        gQ3Z7/hG7Wu7kQdTZEzYz1Tczg==
X-Google-Smtp-Source: AA0mqf6h22DC0KAQue5KYSYozblSb2wE8jNlr6J8sY+ZRFEnDjvn3P/MsgXcd3eJtC3umMD+KbGwsA==
X-Received: by 2002:ac2:488e:0:b0:4b4:cf32:e105 with SMTP id x14-20020ac2488e000000b004b4cf32e105mr27927160lfc.110.1670327095941;
        Tue, 06 Dec 2022 03:44:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j12-20020a056512344c00b004a05402c5c3sm2468044lfr.93.2022.12.06.03.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 03:44:55 -0800 (PST)
Message-ID: <cebb1182-ca05-b339-8990-e85fff43bcb7@linaro.org>
Date:   Tue, 6 Dec 2022 12:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 10/10] arm64: dts: qcom: Add base SM8550 MTP dts
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221205230342.494923-1-abel.vesa@linaro.org>
 <20221205230342.494923-11-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221205230342.494923-11-abel.vesa@linaro.org>
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

On 06/12/2022 00:03, Abel Vesa wrote:
> Add dts file for Qualcomm MTP platform which uses SM8550 SoC.
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 404 ++++++++++++++++++++++++
>  2 files changed, 405 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> 

Thank you for your patch. There is something to discuss/improve.

> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	cd-gpios = <&pm8550_gpios 12 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
> +	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
> +	vmmc-supply = <&vreg_l9b_2p9>;
> +	vqmmc-supply = <&vreg_l8b_1p8>;
> +	bus-width = <4>;
> +	no-sdio;
> +	no-emmc;

no-mmc

https://lore.kernel.org/linux-devicetree/20221204094438.73288-2-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

