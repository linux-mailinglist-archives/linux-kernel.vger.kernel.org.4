Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ECE6921C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjBJPQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjBJPQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:16:11 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9615AB23
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:16:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c1so1194905edt.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8CFDc7Q6h4tHsEQ2o15gydhFTdkNgUBmcZbo1eZNCM=;
        b=E6DTdjabGvQ39rr9knwYpFeED6vmEVuSPCla0PBX/oZyo64j1Mg17QS3JlPBCoR96S
         Qfp0L3q2VHNjmlyjv7wqbAHpNHBWz9n84MVQwiwNEmxT1CQIfAQdfZDB3NIdtX3eGg0o
         hCuJjxYSB2m1ZJtJobTpiwx8gyKNxCiWftnvoif6hYgTOrMp21cirb5JHhAjWSTJve3n
         TSTVkvDolN4Bdv6gl6bmWAOMhdhnUbNQAqHy1vM46ppjHNCvN/NV8cQcT3NZIr/6Dh5t
         rv4fQBQQiSF97SlI1Z6epm2edee3N+LNz9R3Kf21z1KaZVMlg2Ws3XrnoScb45g2RiLU
         5wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8CFDc7Q6h4tHsEQ2o15gydhFTdkNgUBmcZbo1eZNCM=;
        b=cc18Idrf25ZiF1J5rgR5Z5lSU5cV6x00mZISRAH+JKnWu8d/+aHY1YVO8mZZlU/36F
         Tu0BnfYXhP+5pABXVgqruLYZyXchbQBf9zZrIF9d6FTv3wxtP2a4w1pT6yJ/clIi51qY
         g9kfyh1k6B/guGNJ5TVIQMTPSt8R0Xsym5Z0I2EVr5/IW5S1kxv/vwgY+Tqgck61TzQq
         NYeCgG+JIxG3I3CIvbIHG9FqoNQaqXmlXTWbiC4sHivimjgCFeBHDAL2GehuVaCsRmIi
         pxMa8u/hiojAIIfBkt/BFPjXGa5gImnVrrQvJXYnVBzgEt3cJv7H/u/6D2xV2k9jD4DM
         3zUA==
X-Gm-Message-State: AO0yUKWUXRiWXqRauEpGMO9DrhoCT/cr63bpyDnweU39HiejCA/M+H5v
        2Qe0akKiHOgrCQeVdyYX6sfaqw==
X-Google-Smtp-Source: AK7set9GJwpO0Qq/hFPdLoHPZmF02QHKyZ5F0U5XlbyPvbWgDVlbuM0P695kOBX0NSN0a3NVPlZHiw==
X-Received: by 2002:a50:bb4e:0:b0:4aa:b40d:e0a3 with SMTP id y72-20020a50bb4e000000b004aab40de0a3mr16382386ede.34.1676042165662;
        Fri, 10 Feb 2023 07:16:05 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id cq5-20020a056402220500b004acb2c8aeaesm286858edb.85.2023.02.10.07.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:16:02 -0800 (PST)
Message-ID: <226aeac5-d1b1-2a99-5c17-c26a8458c5ea@linaro.org>
Date:   Fri, 10 Feb 2023 17:16:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/5] dt-bindings: display: msm: dp-controller: document
 SM8450 compatible
Content-Language: en-GB
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230206-topic-sm8450-upstream-dp-controller-v3-0-636ef9e99932@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v3-1-636ef9e99932@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v3-1-636ef9e99932@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 16:44, Neil Armstrong wrote:
> The SM8450 & SM350 shares the same DT TX IP version, use the
> SM8350 compatible as fallback for SM8450.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   .../bindings/display/msm/dp-controller.yaml        | 25 +++++++++++++---------
>   1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 0e8d8df686dc..f0c2237d5f82 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -15,16 +15,21 @@ description: |
>   
>   properties:
>     compatible:
> -    enum:
> -      - qcom,sc7180-dp
> -      - qcom,sc7280-dp
> -      - qcom,sc7280-edp
> -      - qcom,sc8180x-dp
> -      - qcom,sc8180x-edp
> -      - qcom,sc8280xp-dp
> -      - qcom,sc8280xp-edp
> -      - qcom,sdm845-dp
> -      - qcom,sm8350-dp
> +    oneOf:
> +      - enum:
> +          - qcom,sc7180-dp
> +          - qcom,sc7280-dp
> +          - qcom,sc7280-edp
> +          - qcom,sc8180x-dp
> +          - qcom,sc8180x-edp
> +          - qcom,sc8280xp-dp
> +          - qcom,sc8280xp-edp
> +          - qcom,sdm845-dp
> +          - qcom,sm8350-dp
> +      - items:
> +          - enum:
> +              - qcom,sm8450-dp
> +          - const: qcom,sm8350-dp

Neil, Krzysztof, I'm not convinced that this is worth all the troubles. 
I think it would be easier to have a flat list of compatibles and handle 
all the differences inside the driver. For example, for sdm845 we simply 
reused sc7180 config internally, while keeping separate compatible strings.

>   
>     reg:
>       minItems: 4
> 

-- 
With best wishes
Dmitry

