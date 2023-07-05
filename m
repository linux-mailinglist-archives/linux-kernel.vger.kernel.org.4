Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C77748749
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjGEPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjGEPBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:01:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F651BDF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:01:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso10616460e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569261; x=1691161261;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0gcDRuQkjpHCUjM+vGdjv7W7sdjFlqZuGfjW7kfd7w=;
        b=S4bDWswS0FDlLNRhulwidTRmXgTlDL71mqxdvdPcN8XEWA2paOGVOlrr6mtYq9/jAc
         +2KDKRv4RJDiJWxoqmyQQnGChVtfS3MaryFSIe+CRqtDIBlRMPmIphfJXAGqW/xTEb8y
         B3sxMGi1wdSPHhndUcPAWKaSOmjM/d0qlPxbRIrFu4u6AE5hwgtd7qI4ne5ND97jTUVY
         7gf1Y150HmEX+uldjGGVrHIVgS3rbcCxRsnDYDmUbyeNPw6oz+uDxrwN9lr1xyqcdDiX
         e65Q2FU9+R2zMRzsgxhlhQ7q/6vIjdezYFd8mC5xAE9qhmpIdGIMLaKRGyohk28qSCQS
         avJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569261; x=1691161261;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0gcDRuQkjpHCUjM+vGdjv7W7sdjFlqZuGfjW7kfd7w=;
        b=MlvmDsRNsSZ30WD58pOgzfYpvauhYu0XVe+ptstvuECc4oUTOoZN/aAbqN+7TlriP2
         ic/4N7YKd0jJ50cLlAGSUryS3t1S4I1zj/y9DDv+0gGIOm0/7Ew980ryUqqY/9R0DxZT
         yrp3tGxAbJNFi6mX9AUCU4K+yxTieKTzUWfPzKiKmcwCYD+qQsu6j5+dh0V7x2EGH3dx
         bQTkwPRPfBusSrmecIzJzO2U1pyYzCRBHlNxrYIRw97ZZe10fDTJAoyXJsukVTX3HWBg
         D1wx0y9SPwl/gCUJKFfwoIFCdbHgbRNulpCNfQ0qJ+1+VOPWJjgY3t/iGhCsrbXC246s
         3HmQ==
X-Gm-Message-State: ABy/qLZrTDnUEp6cn+SFpMlW3OFiaNahQuPV39whvUatgWQ8xVboke85
        mPnDVRC20czi+THoGfDSoEnxLA==
X-Google-Smtp-Source: APBJJlFt/CvUvOaP9nhesV/5dotDDrJiq/+ibzYweC63Z4Y2rOtPRJzBG18lTXozTRNK0WQrjDGm8g==
X-Received: by 2002:a05:6512:1112:b0:4f8:7503:2041 with SMTP id l18-20020a056512111200b004f875032041mr14035474lfg.37.1688569261797;
        Wed, 05 Jul 2023 08:01:01 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id a10-20020a19f80a000000b004fb74dbbd98sm4951623lff.246.2023.07.05.08.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 08:01:01 -0700 (PDT)
Message-ID: <12f3e3f1-cd47-c7db-1078-5be92e3b5f91@linaro.org>
Date:   Wed, 5 Jul 2023 17:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: qcom: add missing space before {
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230705144226.280490-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230705144226.280490-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.07.2023 16:42, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi                    | 2 +-
>  arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> index 3c1314e12d08..fe8534538618 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> @@ -3429,7 +3429,7 @@ timer@17c20000 {
>  			#size-cells = <1>;
>  			ranges = <0 0 0 0x20000000>;
>  
> -			frame@17c21000{
> +			frame@17c21000 {
>  				reg = <0x17c21000 0x1000>,
>  				      <0x17c22000 0x1000>;
>  				frame-number = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> index b841ea9192ae..85e5cf3dc91e 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> @@ -565,7 +565,7 @@ panel_in_0: endpoint {
>  				};
>  			};
>  
> -			port@1{
> +			port@1 {
>  				reg = <1>;
>  
>  				panel_in_1: endpoint {
