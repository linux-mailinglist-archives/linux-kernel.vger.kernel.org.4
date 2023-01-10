Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5C36638CE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjAJFuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjAJFtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:49:02 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD3A1EAE1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:49:00 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d30so11724488lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 21:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wEZQCF7r/hKH3+PuKuaEzx+VX+jWeUSGLdP7kMpvbXk=;
        b=mnMXExPNaUGbHc03oJdZNZQ6xvbloLJpihN+Im7a+alsvj7Gu1N7RgMAcEeq5kRHLz
         XySlHGCIKONS5ikU+ebg6EAbhztICZwdEeJOYarE/aIqE9ixPEU5quxCsVmt3LimRmp+
         nn0U1fcXeUowMEjgBRuRckP8aV6k0+mDQe4VAQ6lshQXPvrGdOKyJFqpHr19f9VvTAgi
         2TFgxrBhYYX4oWbJfMstPdibYHJKFgydedX2dOWG39f/Nvg+k3VBfdYkvwHyqG4BPe6G
         5COmChwVzUjBWDUR5/LiTaBjeY9vPpnEGIzquuB/2D+BB7BIPBCF2fkhWf2396IPHpkX
         P4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEZQCF7r/hKH3+PuKuaEzx+VX+jWeUSGLdP7kMpvbXk=;
        b=HYBRtxku9RZ9OY9I8EgqXG/R4zoJgAN8pXlrQq6Y70GnJXT3XlEjgJPbRQagX9D6pZ
         vbd/tcAIjKmRf0/ywXrKw12LnpJupId4QgK+4ZafVh8eSzIDHgmmXEShOIw6KFGlb3IM
         EExtGW5aZys1eCcDMU4T7lwUYjiGDS5AYxO86yHkTTo/dpTRgYX88YQ/dL7U8zrh1ezm
         f0MrzFaXNh2vSy5Y4iflNcOJ/BeMzCdDfCIMwmIWZ73ynpFHgRmA9kBLh0gb41hNeqsx
         QWaklW4JNGRHhkf84z2gugEVYRKRvqNh+MJJJrvEknmhZyuYt5ZNGYniRzO1CdWMRc3b
         VuyQ==
X-Gm-Message-State: AFqh2kriQZ2SbUU+7EciwcaX/BAr7fnRch8W/lK0azvxIxYqlb+HfUOt
        94kTTgFTwlWzuqdJ1x7EX9KtOg==
X-Google-Smtp-Source: AMrXdXtObN18+uFW0MQGD2/uG7h9Qi5wnyK0DtAuzC9YHGEtGEZhRUnE5aoLscqQo1UoyDffAU2GHA==
X-Received: by 2002:a05:6512:64:b0:4cc:71d2:eff3 with SMTP id i4-20020a056512006400b004cc71d2eff3mr3044316lfo.21.1673329738963;
        Mon, 09 Jan 2023 21:48:58 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b9-20020a056512218900b004b57162edfasm1998300lft.117.2023.01.09.21.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 21:48:58 -0800 (PST)
Message-ID: <913f2772-2673-4270-030c-c036984d36c6@linaro.org>
Date:   Tue, 10 Jan 2023 07:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 04/18] dt-bindings: msm: dsi-controller-main: Add
 compatible strings for every current SoC
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        dianders@chromium.org, david@ixit.cz,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        konrad.dybcio@somainline.org, agross@kernel.org,
        andersson@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
 <20221223021025.1646636-5-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221223021025.1646636-5-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 23/12/2022 04:10, Bryan O'Donoghue wrote:
> Currently we do not differentiate between the various users of the
> qcom,mdss-dsi-ctrl. The driver is flexible enough to operate from one
> compatible string but, the hardware does have some significant differences
> in the number of clocks.
> 
> To facilitate documenting the clocks add the following compatible strings
> 
> - qcom,apq8064-dsi-ctrl
> - qcom,msm8916-dsi-ctrl
> - qcom,msm8953-dsi-ctrl
> - qcom,msm8974-dsi-ctrl
> - qcom,msm8996-dsi-ctrl
> - qcom,msm8998-dsi-ctrl
> - qcom,sc7180-dsi-ctrl
> - qcom,sc7280-dsi-ctrl
> - qcom,sdm660-dsi-ctrl
> - qcom,sdm845-dsi-ctrl
> - qcom,sm8250-dsi-ctrl
> - qcom,qcm2290-dsi-ctrl
> 
> Deprecate qcom,dsi-ctrl-6g-qcm2290 in favour of the desired format while we
> do so.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   .../display/msm/dsi-controller-main.yaml      | 26 ++++++++++++++++---
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 6e2fd6e9fa7f0..98d54a7ee28d4 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -14,9 +14,27 @@ allOf:
>   
>   properties:
>     compatible:
> -    enum:
> -      - qcom,mdss-dsi-ctrl
> -      - qcom,dsi-ctrl-6g-qcm2290
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,apq8064-dsi-ctrl
> +              - qcom,msm8916-dsi-ctrl
> +              - qcom,msm8953-dsi-ctrl
> +              - qcom,msm8974-dsi-ctrl
> +              - qcom,msm8996-dsi-ctrl
> +              - qcom,msm8998-dsi-ctrl
> +              - qcom,qcm2290-dsi-ctrl
> +              - qcom,sc7180-dsi-ctrl
> +              - qcom,sc7280-dsi-ctrl
> +              - qcom,sdm660-dsi-ctrl
> +              - qcom,sdm845-dsi-ctrl
> +              - qcom,sm8250-dsi-ctrl

If you would for any reason send v7, could you please also add sm8150 
and sm8[345]50?

> +          - const: qcom,mdss-dsi-ctrl
> +      - items:
> +          - enum:
> +              - dsi-ctrl-6g-qcm2290
> +          - const: qcom,mdss-dsi-ctrl
> +        deprecated: true
>   
>     reg:
>       maxItems: 1
> @@ -149,7 +167,7 @@ examples:
>        #include <dt-bindings/power/qcom-rpmpd.h>
>   
>        dsi@ae94000 {
> -           compatible = "qcom,mdss-dsi-ctrl";
> +           compatible = "qcom,sc7180-dsi-ctrl", "qcom,mdss-dsi-ctrl";
>              reg = <0x0ae94000 0x400>;
>              reg-names = "dsi_ctrl";
>   

-- 
With best wishes
Dmitry

