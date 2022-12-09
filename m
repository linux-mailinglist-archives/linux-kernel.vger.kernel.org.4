Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9894F6481BD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiLILa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiLILaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:30:18 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7443AC15
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 03:30:17 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3bf4ade3364so48196237b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 03:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MjK0sQNHkAnOyNoLULfLFC8tBks0VDS2+NJ4Yo442sA=;
        b=AfRGQFHE/4QABp88WIfbgyfDOy81cfakm17TWf4F5AZL2sftwRWRi4Lw8wdfsJhsF3
         Y7mvb184t/fForLJn9H4L30W4vGAdc1fvQk1YT8e/fsDDvqK6BPEzt9vIWoW4xLTJ1Sw
         ZEkV3zIA5IhMlYnmP4JqG0FBq8VX+S+ik/Tt9nKw5zzKB+tlYDBxAcApE6tfkoJVO69X
         LLqFzyoEeXimzaNT/pDC/c+oR8nmUxjvdX9ynIITarYmjtFbIFpgDlmKR0r1O7OxuqGD
         Vzpiivqk31devP9yFcv5nS0EIae97Jm6xS+ZZKzZ1Tq68Qk3vGm+2RoBEoGO90972p/f
         H0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjK0sQNHkAnOyNoLULfLFC8tBks0VDS2+NJ4Yo442sA=;
        b=fjoiC9w6d74Zm+UL+2ChXOEqYbOHYk2C7GZmKFQOUH+v+52WBrrJrbJ2XJYrcx6NUH
         Ait7XfeGqLINGUkngNvXsY1A7rNEvniekg9RSZ01l5LTE5ceTgAiS9mrnxFbvmXSB9TE
         ocV6/GVyK9bScjbXN4SjrFwq6qAcX8O0CACCy/tdebgXXfrO/+KLzBpIpsCeY6KrT8kA
         cG/pfaTRA5fy4sXifzYKJlS6uKxlofcL7jeFNvRMXnr4MRTXaFK5O/uKb4PJ9wa7BxN/
         vg5+bLqKcqwexxBBLkgfvNg5bVfbepSPJO3zCEJVgj03Mz/ViH17kFd4thSk/2tVg/rl
         0KXA==
X-Gm-Message-State: ANoB5pkZ/VJF6EZBQFdnumlG1tMpdWeDEUxQOWhNspYIKQoW5z04wEsa
        tV0C/i4r859Jb8SdJeRECDMqmLwJ5ycdcAgWhHyWPA==
X-Google-Smtp-Source: AA0mqf7pP+1F8DEdZRZp5BrYvfzyUJzKOuvAkltgXILih6wgXJxMU+qZ+fTFB9kxIvC7pN/xfkx/C4gAsxyb+DTEbmc=
X-Received: by 2002:a0d:db15:0:b0:3d6:2151:4038 with SMTP id
 d21-20020a0ddb15000000b003d621514038mr36253472ywe.418.1670585416427; Fri, 09
 Dec 2022 03:30:16 -0800 (PST)
MIME-Version: 1.0
References: <20221207220012.16529-1-quic_bjorande@quicinc.com> <20221207220012.16529-12-quic_bjorande@quicinc.com>
In-Reply-To: <20221207220012.16529-12-quic_bjorande@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 9 Dec 2022 13:30:05 +0200
Message-ID: <CAA8EJpp8oSW=yEi_QvL1PzF5yhfHsbC7WLD8Lic1R5A_o0i9SA@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] arm64: dts: qcom: sc8280xp-crd: Enable EDP
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2022 at 00:00, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> The SC8280XP CRD has a EDP display on MDSS0 DP3, enable relevant nodes
> and link it together with the backlight control.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>
> Changes since v4:
> - None
>
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 72 ++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index f09810e3d956..a7d2384cbbe8 100644

[skipped]

> @@ -230,6 +246,54 @@ vreg_l9d: ldo9 {
>         };
>  };
>
> +&dispcc0 {
> +       status = "okay";
> +};
> +
> +&mdss0 {
> +       status = "okay";
> +};
> +
> +&mdss0_dp3 {
> +       compatible = "qcom,sc8280xp-edp";
> +       status = "okay";
> +
> +       data-lanes = <0 1 2 3>;

I hope to land Kuogee patches that move data-lanes to the endpoint
node, where they belong. Do we have any good way to proceed here?
Or would it be easier to land this patch as is and then, maybe next
cycle, move the property?

> +
> +       aux-bus {
> +               panel {
> +                       compatible = "edp-panel";
> +                       power-supply = <&vreg_edp_3p3>;
> +
> +                       backlight = <&backlight>;
> +
> +                       ports {
> +                               port {
> +                                       edp_panel_in: endpoint {
> +                                               remote-endpoint = <&mdss0_dp3_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +       };
> +
> +       ports {
> +               port@1 {
> +                       reg = <1>;
> +                       mdss0_dp3_out: endpoint {
> +                               remote-endpoint = <&edp_panel_in>;
> +                       };
> +               };
> +       };
> +};
> +
> +&mdss0_dp3_phy {
> +       status = "okay";
> +
> +       vdda-phy-supply = <&vreg_l6b>;
> +       vdda-pll-supply = <&vreg_l3b>;
> +};
> +
>  &pcie2a {
>         perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
>         wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
> @@ -496,6 +560,12 @@ hastings_reg_en: hastings-reg-en-state {
>  &tlmm {
>         gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
>
> +       edp_reg_en: edp-reg-en-state {
> +               pins = "gpio25";
> +               function = "gpio";
> +               output-enable;
> +       };
> +
>         kybd_default: kybd-default-state {
>                 disable-pins {
>                         pins = "gpio102";
> --
> 2.37.3
>


-- 
With best wishes
Dmitry
