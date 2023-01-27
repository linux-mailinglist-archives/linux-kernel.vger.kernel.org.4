Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CFC67E420
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjA0LvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjA0Ltx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:49:53 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800468627C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:47:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u21so4504394edv.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DaRRAfvxfJqSrDYc/T6dUW2JpmapMuQVxuuxsRDHL3g=;
        b=t69jrkz9SgxCei4WfeByohBBrLzhGEsyIDxNeyJRqUDr59WimVQW45Xku7GldIWpjF
         2r6yHBqJRHKcwTgnh+svOX8NZEgCEr+7WyojabZPrmPuoqah5uSNPkyO9Kz/y2TIAsW4
         jfQFpX5A3uDGlpqoxC9haB1mKzEXsHkaajpQuTmXAUT7DkbzQnZwJZh8Cx+jVlakAvlT
         HS6UrBUKPNC81A2DttawPWdhY9fpNlsmZ9ieIyGCJjBgCdzhHsqpmLKgkNHYTZeo03cT
         3GcZx5Uf42NUnGhJ1G6/3c9tgg9vVnlU+u96TgxfwxR+4MNv0lV/rLkvnch5Xdxn2FVP
         M+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaRRAfvxfJqSrDYc/T6dUW2JpmapMuQVxuuxsRDHL3g=;
        b=szgmer8hQgFQxyDaqDmcdp3hruJIOXcU4lr5SLlnC3CBiIhcRaDx08kz/veBiqgD30
         OWP9ePxwmfIxfdKRxfqr+OT9m/jJUBIJkOZWkSRRbdGhWo8xVacfXAKSicI2S/bQcmcG
         ZbKq3g0lrdgvXLOIhxj7HOYHjgwJQawAwOSqCVFwYffTVPwNjCQ3eDKRdBwuOUaK4bp/
         0cKmHPrnVJj/IATSCpqYdzYIWibsPny3Ncu6vCy09vHEl1ayWc2CBWeScT+7tuDIlbqJ
         t1dyupKFoayCQ3SG4+JdtByrrjtDrsdhuhcmef9kUlBcZVbTGuvFpYOeqMf3ksYDYuSY
         in9Q==
X-Gm-Message-State: AFqh2kpCoZJ1ftAskmcCRb8yPzkQsdX9/O5R7SBTAg1FXfJ/v2kMZhNJ
        dRoNfXAt7MYNVc0z7R45uG/AU4XmtD+jRWLP
X-Google-Smtp-Source: AK7set8keQvmYQzUlhP93L9+PZRj97OmGgCO3J08fX/ISka8dWTIQI/JG6G4yp7JUSNyrWui2A0GmQ==
X-Received: by 2002:a05:600c:4f4b:b0:3dc:2af8:83c0 with SMTP id m11-20020a05600c4f4b00b003dc2af883c0mr4924359wmq.31.1674819245543;
        Fri, 27 Jan 2023 03:34:05 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b003dc4050c97bsm676573wmq.3.2023.01.27.03.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:34:04 -0800 (PST)
Date:   Fri, 27 Jan 2023 13:34:03 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550-mtp: drop incorrect
 vdd-l6-l16-supply
Message-ID: <Y9O2q6Om+MK9k3UL@linaro.org>
References: <20230127111913.117036-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127111913.117036-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-27 12:19:13, Krzysztof Kozlowski wrote:
> There is no vdd-l6-l16 supply in qcom,pm8550-rpmh-regulators.
> 
> Fixes: 71342fb91eae ("arm64: dts: qcom: Add base SM8550 MTP dts")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> index 725d3bc3ee72..d6ae80414654 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> @@ -47,7 +47,6 @@ regulators-0 {
>  		vdd-bob2-supply = <&vph_pwr>;
>  		vdd-l2-l13-l14-supply = <&vreg_bob1>;
>  		vdd-l3-supply = <&vreg_s4g_1p3>;
> -		vdd-l6-l16-supply = <&vreg_bob1>;

NACK.

There is actually an L6 but is not added yet.

But the correct one here is actually: vdd-l5-l16-supply

At least according to the power grid documentation.

>  		vdd-l6-l7-supply = <&vreg_bob1>;
>  		vdd-l8-l9-supply = <&vreg_bob1>;
>  		vdd-l11-supply = <&vreg_s4g_1p3>;
> -- 
> 2.34.1
> 
