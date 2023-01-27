Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C84767E556
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjA0MfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjA0Meu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:34:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9622B783F7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:34:33 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j17so3371891wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nFBq+LWNx9OQ5NIBolt0/CB9kGTsCrF8UXkK5/8aTUk=;
        b=E1Qar4eVRNKn7I+1ANxO82Oz7QAtYGqHewiZptFAGgK8eaCfBsh4aj3/MwXf+ErAa8
         11AlArtPGDoIURssZaiBuGstWaGoSu3dcJljdqXluwBaApVtTYx4Eo9jRpLXUxnBTx9b
         T6xjz9xIpjFpe94kv3uFTYnpGv40ChMpcQ3snQpcV8urwPeQWchYb3rR9SQ1dqc/cK8Q
         QEZE8noKB6O/GYbBKhTqekArLFTn8WSsxl/PqAheTaY3piCCk7WCyKhTONO8gs1g6y56
         A324UQlxJMmsLZ2ta0Q09opa59hoNB3Hf9meWroatX4DYOrG6MSqRuxqsVCJddJjQeB/
         PXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFBq+LWNx9OQ5NIBolt0/CB9kGTsCrF8UXkK5/8aTUk=;
        b=RrzpnVJZtkssNH1KjHQkYAdoFyHJvvRNdIRJwHqj10wpDwBxk1s38LlhMmFAkEuxGE
         R0Zb5CUmKXYdXlAtU8mY65b1JYlSfQ4+lf/IDcayL6Hr2gmFG7uZtpA8i42iE60cnsIy
         MwaltL5/5TjteXmtSIOLW68KB9ZA0KmBIpIMUpKNZMyUT3C9BUbt3Bi18vluyza4k/Lx
         5kv2XHucbAg44m9nbHTrGp5UiFD9Nm8FPT6B1/gs1c6k6r1XSSG+WJCC3O9jPVoTUxL0
         TohOu9yjeD/XBQhmObMOVd9MqCgh6jBCWMd41Lay8/vhD0uqFz8b+8s675sKLemZdsCo
         zfcA==
X-Gm-Message-State: AO0yUKUQ4T4J/AYiLvGknXmwPpaUc3BBlYFp2/KNm1m+STmvrVlVLKUy
        fGlKa9e9bMCfCAQvUinJYDbsfA==
X-Google-Smtp-Source: AK7set+oJEfGmo1/jdHpJGcP3MHNQJUAXDul5H1sxGP4LQF77hoAznOLVtjO67vr1M0M1dG6MuYKuA==
X-Received: by 2002:a05:600c:3511:b0:3dc:3da0:171f with SMTP id h17-20020a05600c351100b003dc3da0171fmr1279712wmq.41.1674822872068;
        Fri, 27 Jan 2023 04:34:32 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a19-20020a05600c349300b003cfa622a18asm7918199wmq.3.2023.01.27.04.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 04:34:31 -0800 (PST)
Date:   Fri, 27 Jan 2023 14:34:30 +0200
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
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8550-mtp: correct
 vdd-l5-l16-supply
Message-ID: <Y9PE1tdk/LucFXfn@linaro.org>
References: <20230127121843.349738-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127121843.349738-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-27 13:18:43, Krzysztof Kozlowski wrote:
> Fix typo in vdd-l5-l16 supply of qcom,pm8550-rpmh-regulators.
> 
> Fixes: 71342fb91eae ("arm64: dts: qcom: Add base SM8550 MTP dts")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> 
> ---
> 
> Changes since v1:
> 1. Correct, not drop (Abel, Konrad).
> ---
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> index 725d3bc3ee72..5db6e789e6b8 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> @@ -47,7 +47,7 @@ regulators-0 {
>  		vdd-bob2-supply = <&vph_pwr>;
>  		vdd-l2-l13-l14-supply = <&vreg_bob1>;
>  		vdd-l3-supply = <&vreg_s4g_1p3>;
> -		vdd-l6-l16-supply = <&vreg_bob1>;
> +		vdd-l5-l16-supply = <&vreg_bob1>;
>  		vdd-l6-l7-supply = <&vreg_bob1>;
>  		vdd-l8-l9-supply = <&vreg_bob1>;
>  		vdd-l11-supply = <&vreg_s4g_1p3>;
> -- 
> 2.34.1
> 
