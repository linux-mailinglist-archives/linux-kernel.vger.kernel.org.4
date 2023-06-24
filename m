Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C014473CA35
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjFXJdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjFXJdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:33:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8861728
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:33:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51bdca52424so1619921a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687599190; x=1690191190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tj3h2F7PrfXgiEVSgcmcva0dTAsO+LbFtvUy3HlpOUM=;
        b=ic86rBDVlYcttew4/vob85e87FNpbbw8JM1F4OZp5nVBORwXNv4q2cTt9SNVFlD9m1
         dFi33g/gLFSWKIokJ9yYgX/tAQvFqVzaGb+REdj5S1pJg8PrdKReA0WIdwbevE9qKL9X
         jTb64bNYUQw0MrC41EE0O0A9p8khOb4xXzpmJeG9HS6yk9KoACeNybd0UTWCAMTDIW+h
         KDdKphFAbVxcyXlCNtts7L78DEmH/dMSIUyCQVoipTLDJWOgGB1FLejiUR8b146FM1N8
         zQFTl5lZGymUQd3VgWk49FEUwvT7wCpqn0SQ1lMbET9C6orZAQ1dEMjK8+eDWqCcdBdD
         dvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687599190; x=1690191190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tj3h2F7PrfXgiEVSgcmcva0dTAsO+LbFtvUy3HlpOUM=;
        b=d7mjA2gKCg7b7CJOoAYXWkbZfBNci0NLYG/B1JnNAZYBG0JNdvbrdmj0PvzpxrPkfE
         luAL/eUmZEPuvHRLE4coTC7m2ABBMoo7XXfa3dYyFzMf5GFHloMt6zfG1mEYi4QBEAhe
         mP5rzwxnZxZAZAGdWDJtTRdxIA6H8tPPpLtDSekaghCv2A46AzuIHNI/jkbKQroQ6T84
         ZR15JfFT25GVJClrifheZMuBzimLp71tLrUBo/7v7rNdKXe8ajvEyjeP1CAVyz4d1n0n
         m22urYfsmSrAcr6cdyJRbto4+8HPwNCnE9rrpFPYJ5JIlxYFa3dI3TCCc4I0EB7JBYBT
         lyxw==
X-Gm-Message-State: AC+VfDy9VEAtd+hyAVgNm0zV97OEcPbD/sJnrwDQ8RQC9uQs4Zd6uA9k
        ndzSrS51AjGLucw0lpqsfBPI5w==
X-Google-Smtp-Source: ACHHUZ6bs/BxTDqMq4cvMfLXihVSFIJDim3qioOSXkCmAssN1V1E4/ail2H+MUzzE3JuAdSuXV/mmA==
X-Received: by 2002:aa7:d411:0:b0:51b:ece3:70d6 with SMTP id z17-20020aa7d411000000b0051bece370d6mr4079434edq.26.1687599190265;
        Sat, 24 Jun 2023 02:33:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7c90a000000b0051bed090703sm481937edt.12.2023.06.24.02.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 02:33:09 -0700 (PDT)
Message-ID: <00cd9016-4b2d-b8b9-45da-49d1f82148a2@linaro.org>
Date:   Sat, 24 Jun 2023 11:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 10/15] dt-bindings: msm: dsi-phy-14nm: Document SM6125
 variant
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-10-1d5a638cebf2@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230624-sm6125-dpu-v1-10-1d5a638cebf2@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2023 02:41, Marijn Suijten wrote:
> Document availability of the 14nm DSI PHY on SM6125.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
> index a43e11d3b00d..60b590f21138 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
> @@ -18,6 +18,7 @@ properties:
>        - qcom,dsi-phy-14nm
>        - qcom,dsi-phy-14nm-2290
>        - qcom,dsi-phy-14nm-660
> +      - qcom,dsi-phy-14nm-6125

If there is going to be next version:
Should be rather ordered alphanumeric, so before 660.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

