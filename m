Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DCA64A11F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiLLNfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiLLNfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:35:15 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79F713F13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:35:12 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b3so18601112lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGzgsLhNezUD7PNgCBNxbBoD6cziN3f3cTOWGqgJdSs=;
        b=KFMDsEBLwYUg6jC8sZIlBdFgty/Yg711fDd/ATLdnYGk/ourXjIyNCkr6ePgwAtGFu
         QAlDtq1V8zqihuMoroMjFluX7+6DcmNQNb1+LFeSY8JbUFnPR3GYxInWMQO5tMTN+0UQ
         lcihoyw1xt7TyvgpJ3wjhsGJBY6aSVZa0N0MpRHjZw/u6pu4jxL6UZ9Je2vNH8fHmWI4
         yR9yaCO8zZLCPW+mw292oZNaVEWD0qWvpMc6OqlA8snwAKTzrUwxkuBX/JQhjX64lLJz
         JBRAAHhgMCIPYOitZUBJCdeXMgLYBOkggacz7L+NUuybxSKoS5D6VDw1xgbu2IfqHHrg
         3U1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGzgsLhNezUD7PNgCBNxbBoD6cziN3f3cTOWGqgJdSs=;
        b=S+teNz9vE61mhWLTXiD4cEGLFKG0B/vPOPClBzLAPwwCj6y3iuaL0zH+/5QxjYfFTg
         dCf7E60+64OfOIurO8oPY4L7NSC3qKGCBUmuE24U4ln3V8rI3S/ncg0N5iA5KcGaX2mX
         VVtTcWlyJnWUcXf79rblE1KqSGEfErKPGpkb/epOdINA9vEw9fw7pT0kaUcsI5kxZ7pH
         PWM5+1L8VCvF3DBqSdYae/7bDwY58hI2X66BFfXUuI8nSfaYSP6eciOGMUbvinbUzsZc
         q1w/o8faoJr9khTEFvtXf4yE1Ldr+TkBZH5nR6HueI/i2zTOAoRVK5xsm+qd4GmD/5Hj
         vTPQ==
X-Gm-Message-State: ANoB5pmjbMeYM207yvXC7k3Mo2TV88UD/877erymR6UtNpzz5fuXakBL
        Ka+dAUHyNWvqJm9RhwuxXU87ig==
X-Google-Smtp-Source: AA0mqf4rjSEkJtJXHr8YIWhnA40c0BZCzmLAnoEl6SLL70B7+Jx+YyG808ghPI68uxGRVxoganIBNQ==
X-Received: by 2002:a05:6512:1329:b0:4b5:853c:ed30 with SMTP id x41-20020a056512132900b004b5853ced30mr6929590lfu.23.1670852111129;
        Mon, 12 Dec 2022 05:35:11 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id y2-20020a196402000000b004b4823f02b0sm1626181lfb.152.2022.12.12.05.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:35:10 -0800 (PST)
Message-ID: <93ad9c5d-784e-3cba-a34b-84f2ce4d3964@linaro.org>
Date:   Mon, 12 Dec 2022 14:35:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc7180: correct SPMI bus address
 cells
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221212133303.39610-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221212133303.39610-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.12.2022 14:32, Krzysztof Kozlowski wrote:
> The SPMI bus uses two address cells and zero size cells (secoond reg
secoond sounds very Dutch ;)

> entry - SPMI_USID - is not the size):
> 
>   spmi@c440000: #address-cells:0:0: 2 was expected
> 
> Fixes: 0f9dc5f09fbd ("arm64: dts: qcom: sc7180: Add SPMI PMIC arbiter device")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Interesting that it worked with this wrong..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index eb1e1ea12ff6..906fb9343bcc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3274,8 +3274,8 @@ spmi_bus: spmi@c440000 {
>  			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
>  			qcom,ee = <0>;
>  			qcom,channel = <0>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
>  			interrupt-controller;
>  			#interrupt-cells = <4>;
>  			cell-index = <0>;
