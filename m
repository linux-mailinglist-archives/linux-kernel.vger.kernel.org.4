Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC0E5EC31B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiI0Mml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiI0Mmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:42:35 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D18D4314;
        Tue, 27 Sep 2022 05:42:33 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C840C3EBA2;
        Tue, 27 Sep 2022 14:42:31 +0200 (CEST)
Message-ID: <b70db7b0-42a7-5d89-1b9b-26416a82e719@somainline.org>
Date:   Tue, 27 Sep 2022 14:42:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: fix msm8974 tsens compatible
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925161317.76356-1-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220925161317.76356-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.09.2022 18:13, Luca Weiss wrote:
> Bindings mandate the use of the fallback compatible qcom,tsens-v0_1 for
> msm8974. Add it to fix the warning.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm/boot/dts/qcom-apq8084.dtsi | 2 +-
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
> index f2fb7c975af8..defc0602d750 100644
> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
> @@ -258,7 +258,7 @@ tsens_backup: backup@440 {
>  		};
>  
>  		tsens: thermal-sensor@fc4a8000 {
> -			compatible = "qcom,msm8974-tsens";
> +			compatible = "qcom,msm8974-tsens", "qcom,tsens-v0_1";
>  			reg = <0xfc4a9000 0x1000>, /* TM */
>  			      <0xfc4a8000 0x1000>; /* SROT */
>  			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 7a9be0acf3f5..cf8af99a4864 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -1116,7 +1116,7 @@ cnoc: interconnect@fc480000 {
>  		};
>  
>  		tsens: thermal-sensor@fc4a9000 {
> -			compatible = "qcom,msm8974-tsens";
> +			compatible = "qcom,msm8974-tsens", "qcom,tsens-v0_1";
>  			reg = <0xfc4a9000 0x1000>, /* TM */
>  			      <0xfc4a8000 0x1000>; /* SROT */
>  			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
