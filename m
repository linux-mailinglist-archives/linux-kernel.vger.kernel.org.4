Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A7F68BBED
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBFLpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBFLo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:44:59 -0500
X-Greylist: delayed 955 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Feb 2023 03:44:57 PST
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE347526B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:44:57 -0800 (PST)
DKIM-Signature: a=rsa-sha256; b=pwNoh53zSBmBCQymA1A73yZMN+0pfiYxOlY6bG81bzq76IFSfT+u8tGD8uuO6338M/rP3SSDI0pz84ygZyH8kPBw3IJ/6aqpjQ1239Rf9piLm2AnZSE5yuGsZN5Cv9kxOytR3eA9RYjkUQ8Z32ClLtBK3p7SWu0IxTx1BVCmQbqlqVPz6RSAhE2z6nSFRouaA/8SLqBNTLIP9zWHJJQs06y3rVs+jVQsCsmGPqjDaBEfpgp5t6+7S+nnOLws9YC2XzFdbMBpgncQbrYw3M9KB/xufY+oPh8JDlAmKLs4eW0st7rfHD7RfM6sv4EIPR8qXuwYM+ivqCMUYgz5Lff+RA==; s=purelymail3; d=iskren.info; v=1; bh=T/yO6Xxr1HxiBprUxHkrxxP2Yx1hXModjuOsaTP4Epw=; h=Received:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=ajp0D1WAL/e3KeWrCCX6oXJ8e+/zC3ir8S2HUYXgyA1BrEDdkZd49o5TbCqdwes+kNmPEGIDMX2Q5k+1qQggOzxugnddJIoLFHz6YDqILFbSWD0aK4vsl1i7YTsknYdaSECk4YbNThDEWb+XVBnFvZ0PqXAOrOk5q6dAdHaNr0jwxB6JNvtGFksD6/EK5KS0LM0je25kmSYhAcXxHVkKDIuOKpPsV/iHpuSiTw6s2xd3ZY4F32+pcVPMqoAVXPGmmSx5/FG+qtvX809iVKPkEge+7mnzPi3jl7yyWm42PnOc7top9odiZ+rotZO98iaJHQdO704OLnExabFBvkYu+g==; s=purelymail3; d=purelymail.com; v=1; bh=T/yO6Xxr1HxiBprUxHkrxxP2Yx1hXModjuOsaTP4Epw=; h=Feedback-ID:Received:Subject:To:From;
Feedback-ID: 10275:2339:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1101737953;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Feb 2023 11:28:24 +0000 (UTC)
Message-ID: <1444542c-d522-2aa1-fdde-40f14b464847@iskren.info>
Date:   Mon, 6 Feb 2023 13:28:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 10/10] arm64: dts: qcom: sm6115: correct TLMM
 gpio-ranges
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
 <20230202104452.299048-11-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Iskren Chernev <me@iskren.info>
In-Reply-To: <20230202104452.299048-11-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/23 12:44, Krzysztof Kozlowski wrote:
> Correct the number of GPIOs in TLMM pin controller.
> 
> Fixes: 97e563bf5ba1 ("arm64: dts: qcom: sm6115: Add basic soc dtsi")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Iskren Chernev <me@iskren.info>

> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 50cb8a82ecd5..b9fff0b0ea1c 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -363,7 +363,7 @@ tlmm: pinctrl@500000 {
>  			reg-names = "west", "south", "east";
>  			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
> -			gpio-ranges = <&tlmm 0 0 121>;
> +			gpio-ranges = <&tlmm 0 0 114>; /* GPIOs + ufs_reset */
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
