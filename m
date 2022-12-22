Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C833E653E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiLVKsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiLVKsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:48:37 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72702791B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:48:36 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id cf42so2182667lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ia8KJdyr/weiXXqDeFy3RTipajicAjUGTpWBPLkZVJ0=;
        b=MzAOSxLWjD0lC/pnVpkUG4qU7fFfbpeMEKTypsZlFhqZWKl2Q6t+wZieDQLuJDcdSY
         rQL0ddVlYCruoBG9VqMAmT5nGxkx0dKT5rLygLRsR3Vs2WyiABzv7VeU2l5ptt9Zkvbv
         kSDxSFKUsQicfk+teRXS5v2RbSgqCvWSy+fJ8Q22G618W8YmR/seO+/JEi5nNw4rADos
         v1uAq0AKukd3y0ouieyOeiH+AUal0vIRa6f6rU2wGtt/9e4Pusbk8/NnsG6XgfFP6UCB
         gfgMRNJpyjk3qvFjWdM8ZViqIvTzA4JYqohRIyKqvuLHIlgIXHo35nrcibFKk52py7db
         XbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia8KJdyr/weiXXqDeFy3RTipajicAjUGTpWBPLkZVJ0=;
        b=1Z5IEQfgjjJbuu1/khztFxP2ZkP8AArWvrbEBByyCPfS7raQcwyap+qNReklDW6IyZ
         KoHS7xlxfqAYcBVC7zCekbMwNKBYN8FELtzDvMuY+Kk20iiw0xO2KJiB2pd9E0Idbygm
         gkBTqJpH16mSR75hpFGX7qQBGGuIcEmaHrWw78RN4dVTOj19XXEFp0PlllEgZcVjczYP
         FA02IY6N6g87OdPtULpRqmx6FndFaVGLMzU58LdOgHb3HBGIGmW4JuWCxn8UUQtnk+Xy
         cvdi+lM1oeXV2K/n+eiNZq6YhTubBf7uPFnSLY6KWkhJb71LxV1hrkhrhAlZEe9skmGk
         cF9g==
X-Gm-Message-State: AFqh2koRLAkZHToDL4Xfexc9DOHsb9/+fdJkK+CTmiiDAMJXhY7Sv7Ao
        ekqzXgfSZqpBwSFe5dW/4BaUig==
X-Google-Smtp-Source: AMrXdXsDo+FPzvd6zDJCEeGLBfA4RrWUpce4uDKCGO5owSQeUsOnswwVLMSAN96lC8QBw7TJDLei/Q==
X-Received: by 2002:a05:6512:4014:b0:4b6:f22c:8001 with SMTP id br20-20020a056512401400b004b6f22c8001mr2181830lfb.56.1671706115054;
        Thu, 22 Dec 2022 02:48:35 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m12-20020a19710c000000b004b700ba3cf3sm29773lfc.203.2022.12.22.02.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 02:48:34 -0800 (PST)
Message-ID: <a9cf2812-bf12-0127-d156-1cbdc133f6b5@linaro.org>
Date:   Thu, 22 Dec 2022 11:48:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v15 1/5] arm64: dts: qcom: add data-lanes and
 link-freuencies into dp_out endpoint
Content-Language: en-US
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, agross@kernel.org,
        dmitry.baryshkov@linaro.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        airlied@gmail.com
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1671227102-21717-1-git-send-email-quic_khsieh@quicinc.com>
 <1671227102-21717-2-git-send-email-quic_khsieh@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1671227102-21717-2-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 22:44, Kuogee Hsieh wrote:
> Move data-lanes property from mdss_dp node to dp_out endpoint. Also
> add link-frequencies property into dp_out endpoint as well. The last
> frequency specified at link-frequencies will be the max link rate
> supported by DP.
> 
> Changes in v5:
> -- revert changes at sc7180.dtsi and sc7280.dtsi
> -- add &dp_out to sc7180-trogdor.dtsi and sc7280-herobrine.dtsi
> 
> Changes in v6:
> -- add data-lanes and link-frequencies to yaml
> 
> Changes in v7:
> -- change 160000000 to 1620000000
> -- separate yaml to different patch
> 
> Changes in v8:
> -- correct Bjorn mail address to kernel.org
> 
> Changes in v9:
> -- use symbol rate (hz) for link-frequencies at dp_out at sc7180_trogdor.dtsi
> 
> Changes in v13:
> -- delete an extra space at data-lanes
> 
> Changes in v15:
> -- replace space with tab at sc7180-trogdor.dtsi
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi   | 4 ++++
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index eae22e6..ad98a87 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -814,7 +814,11 @@ hp_i2c: &i2c9 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&dp_hot_plug_det>;
> +};
> +
> +&dp_out {

Still wrong order, I think.


Best regards,
Krzysztof

