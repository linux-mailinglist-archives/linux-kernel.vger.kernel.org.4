Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402826E4D87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjDQPrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDQPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:47:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BE9184
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:46:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sz19so8283623ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681746413; x=1684338413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+2F8EcU3cNQlU6Th/BtOE+WmBpizsH32/28ir+VRk0=;
        b=ngWGuIItu2FMBq91yohFZq2Y+mZDFO8bsXBpZu81UGmX/wPV25vJ7Xg1ZztfPRMIlY
         Yl+do9Zk1Ld2BMLLbSlxk0+AnRQc7qnJJs37zJPG3GsIrPIsaDFGs5ZjY00/LXvTMuUm
         KGeFdCk0nbX8c75gVYAkM5OPdnDtNQNinUmYE68Ym1TO2xurd/HEfaac5tZFUjZ1/7mP
         sGa8Bu10kyJHb/wE/1OK0XYhCOBKP/vzuCyWbyCaaPGi4Tu6mO4OrNBAoRc6XgZiE+4a
         8klGp4w67SsxY4PT/gqH2YVFN0vLfwlOe5g/SyZNssNJSzC2hW6B3mBo+6awlWVx0rZZ
         Ve4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746413; x=1684338413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+2F8EcU3cNQlU6Th/BtOE+WmBpizsH32/28ir+VRk0=;
        b=clqjx5ohWCXrhHHxTs0KHVI4zZvaajIqzpdSqNcfNqSie60xF2W7ol9RDMQIRFYfgI
         zctNjPyUgH+0a5KD1odCW3ZR9sunNsXeQNOYtmleRFgiwZ6TAfNSvG1cUcuFJhfSelMA
         t5O8FYZ57L36aCQeRbNMkSymkKu5KaXVpiVI/Xcg1gbOp555Ffbk6UHelHLy0Dowk1cp
         dr8RK/Hx24KEGlEDchoHq269JZt9uoUjhHtmj4Oipvz5vgUYRtwU+7TFw4R5KBz2NSXI
         i2oFY+iCNoNX0Pr5hZWLjWRoYKiMa3rXUkcUynIBezp7CNPes81gEFnarXiXhRppcHox
         YWlA==
X-Gm-Message-State: AAQBX9fYF9aa4IFfm1/DW/QzNE6xfeYTmB+7dfr4UK0RIQc9fmm6GNAD
        23W5bueW0Bs3YNJcv+hLoVqW7Q==
X-Google-Smtp-Source: AKy350bJHYPXBCE4loHLxVpwMibECxn5IjMoG9VlSvjeLVDYrduMZvouljdvNrC1Fx8qyZcbc0/iEQ==
X-Received: by 2002:a17:906:3a41:b0:94e:afa6:299f with SMTP id a1-20020a1709063a4100b0094eafa6299fmr8796087ejf.22.1681746413353;
        Mon, 17 Apr 2023 08:46:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:96aa:60eb:e021:6511? ([2a02:810d:15c0:828:96aa:60eb:e021:6511])
        by smtp.gmail.com with ESMTPSA id mp30-20020a1709071b1e00b00947ed087a2csm6774572ejc.154.2023.04.17.08.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 08:46:52 -0700 (PDT)
Message-ID: <3c72e720-d636-d929-658b-75c98b575292@linaro.org>
Date:   Mon, 17 Apr 2023 17:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: dts: qcom: msm8998: add blsp spi nodes
Content-Language: en-US
To:     Arnaud Vrac <avrac@freebox.fr>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230417-msm8998-spi-v1-1-6ea13d8a5384@freebox.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230417-msm8998-spi-v1-1-6ea13d8a5384@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 17:41, Arnaud Vrac wrote:
> Signed-off-by: Arnaud Vrac <avrac@freebox.fr>

Missing commit msg.

> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 309 ++++++++++++++++++++++++++++++++++
>  1 file changed, 309 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index b150437a83558..41c8bb44d1fb1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -1228,6 +1228,57 @@ blsp1_i2c6_sleep: blsp1-i2c6-sleep-state {
>  				drive-strength = <2>;
>  				bias-pull-up;
>  			};
> +
> +			blsp1_spi_b_default: blsp1-spi_b-default {

No underscores in node names, missing suffix.

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

Best regards,
Krzysztof

