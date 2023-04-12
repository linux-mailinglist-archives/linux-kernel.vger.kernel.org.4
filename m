Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3996DFF91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjDLUVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjDLUU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:20:58 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000EB6E92;
        Wed, 12 Apr 2023 13:20:53 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 59F841F54F;
        Wed, 12 Apr 2023 22:20:51 +0200 (CEST)
Date:   Wed, 12 Apr 2023 22:20:49 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-elish-*: Fix panel compatibles
Message-ID: <ec2rxutblwlm2wxm6e4zlu3v5d3f6l2eqxjafq2emky6t2kvgt@3u2lo4e53ixs>
References: <20230412-topic-elish_compat-v1-1-4e03f95d5410@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412-topic-elish_compat-v1-1-4e03f95d5410@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-12 21:47:20, Konrad Dybcio wrote:
> The fallback compatible was missing, resulting in dtbs_check failing.
> Fix it.
> 
> Fixes: 51c4c2bd6f31 ("arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

As usual: Krzysztof already sent these:

    https://lore.kernel.org/linux-arm-msm/20230408130809.52319-2-krzysztof.kozlowski@linaro.org/T/#u

> ---
> foo b4 requires i put something here

What?

> ---
>  arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts  | 2 +-
>  arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
> index 8b2ae39950ff..de6101ddebe7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
> @@ -13,6 +13,6 @@ / {
>  };
>  
>  &display_panel {
> -	compatible = "xiaomi,elish-boe-nt36523";
> +	compatible = "xiaomi,elish-boe-nt36523", "novatek,nt36523";
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
> index a4d5341495cf..4cffe9c703df 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
> @@ -13,6 +13,6 @@ / {
>  };
>  
>  &display_panel {
> -	compatible = "xiaomi,elish-csot-nt36523";
> +	compatible = "xiaomi,elish-csot-nt36523", "novatek,nt36523";
>  	status = "okay";
>  };
> 
> ---
> base-commit: 7d8214bba44c1aa6a75921a09a691945d26a8d43
> change-id: 20230412-topic-elish_compat-73c4511957a5
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 
