Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A375EC55A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiI0OCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiI0OB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:01:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91474167069;
        Tue, 27 Sep 2022 07:01:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r7so15188711wrm.2;
        Tue, 27 Sep 2022 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Zl3CYBbxDXgqBxtjh5C7beBUpnsxheMilBJE58SXbWk=;
        b=D1dcNej7lgw4hQyNwIM6GOULn2x7zin4v0Mk6AZSu7JxMsuPwlvyvDrvQ4P/obvnR+
         zC8knFVdz6tm8dpaKkPBYHf7HGxWI0HRBbZlBc54ujLvb8XEsNMXRnUILXtrrDExm7uk
         SvrvVcmfS+Qi7BFofVpa/kgnTYtEMvII8y710Jx0LCUkPnJxk5ZoNyxxTNqyhlpLvS2i
         2D8FbKtxWkaeS9x7rIyMQJV8aigr05iw8/zk/RkbNr04Ty064FRfav96aOMN1bna2oT+
         SMTfxUPHBa43PXAJivxOCCSsyA8N2PTPHaYqHUOqyC82qI2VpSjcNX77PNF1S5CgGddL
         iepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Zl3CYBbxDXgqBxtjh5C7beBUpnsxheMilBJE58SXbWk=;
        b=H25hS6HA/uHxlUy9qsSb2vXCXi/E8fOEOo7z52ZAwxvikmcV2SnN05o/9/3y9y8/G/
         Ov0uHcTo6uHJiE92B/66EdabnkghnRkrPeDv7b0wkI0W4ZeFLxkYHS3QKysNYFXa+prg
         Mb2doxf6jaoJWHed+ZnMkOpAWqwqxZWWg+ifnuCM/Ao/e+z+7t6jP0ISy2qrQkbRuHhE
         MP8PMp6Bx/SZqdSgHhuqzFFCxHNRNnFXWAB3YwguWwq57AyDr2VCt/9ZSgEWBd5LI7Xh
         s5/T33VuDj8AIU6jkP6QMqxRItq1cI3cu14jCoFHpLjhpWD5tum/FPKN2xX0oVQDSv2E
         boOA==
X-Gm-Message-State: ACrzQf2mc6//lgLPyxB7LSRW/Zh4JmTSN9mm+P8quS0/lmC4XITUqkvv
        ms385c1EK0194JPkCUriGCM=
X-Google-Smtp-Source: AMsMyM6mplNHrXN0mTK3Yjnt6CSBZnyux/jhGU9KmvIIs5qL9RxB/QzaleQKaV3sNBoNRnXZyQoFTA==
X-Received: by 2002:a05:6000:912:b0:229:9bc1:27ed with SMTP id bz18-20020a056000091200b002299bc127edmr16508539wrb.546.1664287267615;
        Tue, 27 Sep 2022 07:01:07 -0700 (PDT)
Received: from [192.168.3.32] (dh207-97-176.xnet.hr. [88.207.97.176])
        by smtp.gmail.com with ESMTPSA id o2-20020adfeac2000000b00228c375d81bsm1944246wrn.2.2022.09.27.07.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:01:07 -0700 (PDT)
Message-ID: <647d12dd-9bc6-ebe3-7a72-9b9c0d4610dd@gmail.com>
Date:   Tue, 27 Sep 2022 16:01:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 01/33] arm64: dts: qcom: ipq6018-cp01-c1: correct
 blspi1 pins
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
 <20220926074415.53100-2-krzysztof.kozlowski@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <20220926074415.53100-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26. 09. 2022. 09:43, Krzysztof Kozlowski wrote:
> When BLSPI1 (originally SPI0, later renamed in commit f82c48d46852
> ("arm64: dts: qcom: ipq6018: correct QUP peripheral labels")) was added,
> the device node lacked respective pin configuration assignment.   It
> used also blsp0_spi function but that was probably the same mistake as
> naming it SPI0.

Hi,

Sorry for making it confusing, but "blsp0_spi" is the correct function.
Pinctrl driver and datasheets call functions blsp0-blps5, but usually in DT
we call the nodes blsp1-blsp6.

It would probably be better for me to rename the nodes to blsp0-5 instead.

Regards,
Robert

>
> Fixes: 5bf635621245 ("arm64: dts: ipq6018: Add a few device nodes")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
> index 1ba2eca33c7b..afc2dc79767d 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
> @@ -37,6 +37,8 @@ &blsp1_i2c3 {
>   
>   &blsp1_spi1 {
>   	cs-select = <0>;
> +	pinctrl-0 = <&spi_0_pins>;
> +	pinctrl-names = "default";
>   	status = "okay";
>   
>   	flash@0 {
> @@ -57,7 +59,7 @@ i2c_1_pins: i2c-1-pins {
>   
>   	spi_0_pins: spi-0-pins {
>   		pins = "gpio38", "gpio39", "gpio40", "gpio41";
> -		function = "blsp0_spi";
> +		function = "blsp1_spi";
>   		drive-strength = <8>;
>   		bias-pull-down;
>   	};
