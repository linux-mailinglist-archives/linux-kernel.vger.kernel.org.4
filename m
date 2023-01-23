Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751F6677B40
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjAWMlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjAWMlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:41:14 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F8E227BC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:40:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e3so10648233wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ctAeXQbGKSAr1B5seFHr6bhqHo1rRPcfqpnpNIdRSEw=;
        b=dSYNRl/1AZPlEQ+oq+Bok/Twfn5pqPxxaDv+z7g32jqUmi6dzFvXp6bnVcSgboaiPJ
         BA1stF6sMQv0JWa9z31RM2cYAlfCB04LgKjlLtMzv9MU1ASnXfnG3duuAH8/5fqn4vw5
         RlBy7DS58oLs47BD5b8dtlV6DyV4f7KfoO1bXi52YdyjHm7RzuFzPd/j5SEunFg0oeXk
         0RVWTA/goJxYTPgS0yZ+7BlKkKR2/e8dtyjwU+M2OrJwz4i/uI/1bW1FXrNJJhr1uHiC
         hAt908nG4yryL4Y7KS4b+fLfQTDKwnZEbIslTQPHj/B1qn+zx/Ht7MFYlyf6tocL2Kgz
         Jntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctAeXQbGKSAr1B5seFHr6bhqHo1rRPcfqpnpNIdRSEw=;
        b=las4fnQqppuQv+8qT7yVj58ITT1oFeb0LmdbDVdz1gMC2+8AF+nkUOZ1jCEnfFC7ID
         WmVAEDp38fqnqPcQGH4+kqNsXBJOtk5a5c7x1SPsCoPSVPUqfmXSFf0G+u9ESjV9z4em
         9zWPlUBOmWIjXy84DF4pKw9lUdpdV9XbhJTe8HwxWKFaW2ZZ2Ru/IXV3engIs/KHO4mP
         lzlZr5MVvHOYSKtlQ0HRvdKQHxm+94/KdCBeotX8Buo5dqkBJuf119kcZX5Lb1WdFYzw
         Rki/2YH7DYhvwXsUS7x2XOmr3/uhbBxFRLnkwYWFLu0vfvftGrJ878w0UJRs5QFDyJGm
         9IGg==
X-Gm-Message-State: AFqh2kqpeqlQTXgs+HPiwAqZbSzXmzDi9/boe+OEq71WDNzdGuu3hPxJ
        LxgtpNMmVlJ5hA09JGRifROY1g==
X-Google-Smtp-Source: AMrXdXvoHqDriOlhTDYKHtqiGtrdOZCXKaqWTI1V72XQvkzEKH3aMuwmWdY8AbmEPRnxUo/5it0SgA==
X-Received: by 2002:adf:fa88:0:b0:2bd:feb5:fb7b with SMTP id h8-20020adffa88000000b002bdfeb5fb7bmr19753407wrr.33.1674477640638;
        Mon, 23 Jan 2023 04:40:40 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002bdd21f25ebsm27744621wrq.71.2023.01.23.04.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 04:40:40 -0800 (PST)
Date:   Mon, 23 Jan 2023 14:40:39 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: fix USB-DP PHY resets
Message-ID: <Y86AR+1c3HUFlG5m@linaro.org>
References: <20230123101607.2413-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123101607.2413-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-23 11:16:07, Johan Hovold wrote:
> The USB-DP PHY resets have been switched.
> 
> Fixes: 7f7e5c1b037f ("arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 6ff135191ee0..2f453dc00852 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2395,8 +2395,8 @@ usb_dp_qmpphy: phy@88e8000 {
>  
>  			power-domains = <&gcc USB3_PHY_GDSC>;
>  
> -			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> -				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
> +			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
> +				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
>  			reset-names = "phy", "common";
>  
>  			#clock-cells = <1>;
> -- 
> 2.39.1
> 
