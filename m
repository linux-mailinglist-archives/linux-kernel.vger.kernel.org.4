Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E411750A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjGLOQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjGLOQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:16:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0601BDC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:16:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98e011f45ffso807395966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689171364; x=1691763364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtG6m9o3iIqHX2GRVgiObV3lAn01QmFcYVaWn2hSYUI=;
        b=LKIe5TTNimGx4RiYenJa9Av9tUfXqamiQ8Wa+51QVNCfGsEdH8FfEkiJqa/IOCPtbf
         hujSBypqdhaAjZJphywKYLcqdQP7fiJmwF3WO7X1IK6wU7JF3khXrtSSJIGjVBVY4W7p
         ohohbdDnjbKB7IbVUzfHcYAsd0GAsFLGhfsZNzzXfTzShYxWEZy9lxe5OfU1brbRWbNX
         pcLrXV6U9EVl6IB+bbhEiOlLd4ULQuxpMq5WJwLEXR9j3c1OZQLgYh5X0O74z5owkae+
         /RzirOx5Ke9YGc5KtwuF4K/9g67s0yTet+al5Gvxbyrxt29bC3Qs7joGDbVD7h2fDndy
         Nj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689171364; x=1691763364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtG6m9o3iIqHX2GRVgiObV3lAn01QmFcYVaWn2hSYUI=;
        b=kKGxlsdUY9JXEdiJ1h2ZRok9z4gby+Es3wFElCMdm7kET4X7+Ra6Fqb7TZhfhwqx9J
         /aOOtO/Y9B98dY2w1+W9MnRRVaH0XikIUwKacw1xs/3EdICnK4YYwnbC+vULvQMaL9+s
         YWfDLL9cNcAoXVkubohPxCOx7t2zCZYFLWY6gwrkTSzhjHDfeIJCl2VoYGL5QtmmRhpO
         w0v6n0NYnm21OiBhp8uSqfAF4J7UjzHvcod5sYHyC22EVGccy2yuyVQ8SyhKwgl7zaVy
         7AmMhZWZUD7HSTMitxeRDNE9qp76j2Hibg/PuGZU9w1dNI5uMHP7IUL6K3cIN6jSmrsP
         vv0g==
X-Gm-Message-State: ABy/qLZNv+nZAP+N6bWZR4hHxYPAdxcA1xBl8WBlVXr2Jo0C72YVzFb8
        zA87NbRV9mqHpcyD/lmFOJCwnw==
X-Google-Smtp-Source: APBJJlF9zV63ReZ5T527j/HCK7KAi/1kDcj/AbscFKY9q2fd/lPJoYpuQms4EEa6/+GbYOtHGIhKEg==
X-Received: by 2002:aa7:cf06:0:b0:51d:f37b:1b5c with SMTP id a6-20020aa7cf06000000b0051df37b1b5cmr7443937edy.23.1689171364390;
        Wed, 12 Jul 2023 07:16:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e13-20020aa7d7cd000000b0051e24284fc8sm2835440eds.12.2023.07.12.07.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:16:03 -0700 (PDT)
Message-ID: <c3ea2043-5d02-3a6f-ecb7-fb90d989bc6f@linaro.org>
Date:   Wed, 12 Jul 2023 16:16:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: display/msm: qcom,sdm845-mdss: add
 memory-region property
To:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Bryan Donoghue <bryan.odonoghue@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230712130215.666924-1-amit.pundir@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712130215.666924-1-amit.pundir@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 15:02, Amit Pundir wrote:
> Add and document the reserved memory region property
> in the qcom,sdm845-mdss schema.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>

Please keep consistent versioning, so this is new patch in v4.

> ---
>  .../devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml    | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
> index 6ecb00920d7f..3ea1dbd7e317 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
> @@ -39,6 +39,11 @@ properties:
>    interconnect-names:
>      maxItems: 2
>  
> +  memory-region:
> +    maxItems: 1
> +    description:
> +      Phandle to a node describing a reserved memory region.

Your description says nothing new. It's entirely redundant/obvious.
Instead please describe what reserved memory is expected to be here.


Best regards,
Krzysztof

