Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB46711F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjARD3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjARD3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:29:21 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E774FCFA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 19:29:20 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v30so47876499edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 19:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f22eo9eS2+umBBEiAmmR4UxB2/bNY49apLHEf3F7vXc=;
        b=bxz7gGBCOtkpE6PEgY9c2/2u8h8M3a7aLEjc5LhLn5eyJp6w4wCeXiQM/uXGZY/UO3
         CDsErP/BD/Cy7SfRFb/jnRPM6IF9SHMJ3ir7SquTwOAh9xnAueuK+nO5STyJc9WT6/5w
         OZGLPcwtpSHtrG7kELSY7HUqN2Lknhlr9/E7oI0MQr5dGJu+/eVOgNxPbZ6JqFU+HGRr
         xEc40Wn3t+Bcg6sB9R+HdR9PbJ5hOMwbmZS2ReLXHv5rEd7yI3EARt1PqrlwS2W1+MEy
         /oxYpLE12LVrrpMouKfRAseBZ5enKqV82GRBtkK1DR4kqNd8l8V+JYqJszDeJRh3kCwM
         CPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f22eo9eS2+umBBEiAmmR4UxB2/bNY49apLHEf3F7vXc=;
        b=mswxbujOSPng6o2H3ufqyLsIehlsJBJ1/Ysx9GhtU4b2ycQY59OxLhZfeIQs7tIZIB
         DIZg4AKB/FxrvgdM+t+rkPoO1IF21LijdpAT69NnYgoCtAVhA/y1BsRP93dcE7mS87li
         2Fagzmm1B1LjLauJ0LuQ2I27BdP5hq2sk/BduA26odfdJVjYotPgXWnhysXrAHLz45kF
         AXZwuksDyZb9g4kSauY0FYalVsfAHbSzWSOV8p1timd20RGvXRCy0Zdac+COHH305POx
         jthL0Se69+x6CwK8cFBS+oYqQYHukVkWc04uhpemsjhNWSppo49l2x70iw8cu+kzxMv2
         6G7w==
X-Gm-Message-State: AFqh2koIs2E7+wnC1664a+qbBAVZBxCZcakrQRBU7ZwsgrFKnaSvtCF2
        lH9DQz8mc4bjuG0/ZXgRl5/pug==
X-Google-Smtp-Source: AMrXdXsFAiMSEeE2jv/0i2yE7K7wg58Ad8xfQq+oTG9hEPm/VYsjsbejv1CDlAxupFCZjj7Oh8L0Tw==
X-Received: by 2002:aa7:dd48:0:b0:497:233d:3ef7 with SMTP id o8-20020aa7dd48000000b00497233d3ef7mr5387954edw.7.1674012558961;
        Tue, 17 Jan 2023 19:29:18 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id et14-20020a056402378e00b00497d8613532sm12782557edb.5.2023.01.17.19.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 19:29:18 -0800 (PST)
Message-ID: <7bfd7a4b-95fd-0e95-70a9-7287ddbd3a8c@linaro.org>
Date:   Wed, 18 Jan 2023 05:29:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 1/3] dt-bindings: msm: dsi-controller-main: Add
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
        linux-kernel@vger.kernel.org
References: <20230116225217.1056258-1-bryan.odonoghue@linaro.org>
 <20230116225217.1056258-2-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230116225217.1056258-2-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 00:52, Bryan O'Donoghue wrote:
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
> - qcom,sm8150-dsi-ctrl
> - qcom,sm8250-dsi-ctrl
> - qcom,sm8350-dsi-ctrl
> - qcom,sm8450-dsi-ctrl
> - qcom,sm8550-dsi-ctrl
> - qcom,qcm2290-dsi-ctrl
> 
> Deprecate qcom,dsi-ctrl-6g-qcm2290 in favour of the desired format while we
> do so.
> 
> Several MDSS yaml files exist which document the dsi sub-node.
> For each existing SoC MDSS yaml, provide the right dsi compat string.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   .../display/msm/dsi-controller-main.yaml      | 30 ++++++++++++++++---
>   .../bindings/display/msm/qcom,mdss.yaml       |  3 +-
>   .../display/msm/qcom,msm8998-mdss.yaml        |  8 +++--
>   .../display/msm/qcom,sc7180-mdss.yaml         |  6 ++--
>   .../display/msm/qcom,sc7280-mdss.yaml         |  6 ++--
>   .../display/msm/qcom,sdm845-mdss.yaml         |  8 +++--
>   .../display/msm/qcom,sm8150-mdss.yaml         |  8 +++--
>   .../display/msm/qcom,sm8250-mdss.yaml         |  8 +++--
>   .../display/msm/qcom,sm8350-mdss.yaml         |  6 ++--
>   .../display/msm/qcom,sm8450-mdss.yaml         |  4 ++-
>   10 files changed, 63 insertions(+), 24 deletions(-)

[skipped]


> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
> index c268e0b662cf9..599a6bad80f43 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
> @@ -46,7 +46,9 @@ patternProperties:
>       type: object
>       properties:
>         compatible:
> -        const: qcom,mdss-dsi-ctrl
> +        items:
> +          - const: qcom,sm8450-dsi-ctrl
> +          - const: qcom,mdss-dsi-ctrl
>   
>     "^phy@[0-9a-f]+$":
>       type: object

The example also should be updated in this file to include 
qcom,sm8450-dsi-ctrl for DSI nodes

-- 
With best wishes
Dmitry

