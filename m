Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985695FE2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJMTpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJMTpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:45:51 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D2183E3C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:45:46 -0700 (PDT)
Received: from [192.168.1.101] (95.49.31.41.neoplus.adsl.tpnet.pl [95.49.31.41])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 68E851F67B;
        Thu, 13 Oct 2022 21:45:43 +0200 (CEST)
Message-ID: <6b81eedd-f23f-d793-baa8-c0ecf8453702@somainline.org>
Date:   Thu, 13 Oct 2022 21:45:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 4/4] ARM: dts: qcom: ipq4018-jalapeno: Add SoC compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221013155418.47577-1-krzysztof.kozlowski@linaro.org>
 <20221013155418.47577-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221013155418.47577-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.10.2022 17:54, Krzysztof Kozlowski wrote:
> Add qcom,ipq4018 compatible fallback for the SoC.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts b/arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts
> index 394412619894..365fbac417fd 100644
> --- a/arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts
> +++ b/arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts
> @@ -7,7 +7,7 @@
>  
>  / {
>  	model = "8devices Jalapeno";
> -	compatible = "8dev,jalapeno";
> +	compatible = "8dev,jalapeno", "qcom,ipq4018";
>  };
>  
>  &tlmm {
