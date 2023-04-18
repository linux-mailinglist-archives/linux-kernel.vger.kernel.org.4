Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC546E5A67
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjDRHYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDRHYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:24:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15C83A8C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:24:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u3so18695108ejj.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681802678; x=1684394678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mc2ExA+PYqwwVZ/2XtG8G8622ouzIpPkXOpvzHUJGzY=;
        b=LlL3Ix9wb13p8+AVSBkcuTAG/yELJ9qLYyM2yRbHicQzplcpKd+hMWgco8vu+ABC0c
         0fBZwOlnJ0lL5OuakMB3mxO+yT/DMbRF/x21gW1Y5m2HG1yLCXjfHm/qcF3iisRgpF2F
         /RQTSKn0omVPRYl34oN3630drxBEXMpp5En18nWgh7LTfXl2NbBGuCnT11yLejK0wO/s
         ZFgUc0Mlf07+zuDYn6YAsX38ej6CVapUP6kgoJP2TACb7KEtnvJOFQ7hjlLjbks49LYK
         qsM9HN4jIazntQ95nbJK5ksqIaDlfSXQENJJ7qGNMoxOU20Ek3VLTxM/SPX9WyK+0kQW
         aFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681802678; x=1684394678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc2ExA+PYqwwVZ/2XtG8G8622ouzIpPkXOpvzHUJGzY=;
        b=MCT3Kg3X6otY4pEf+WWrMX6R2gdvJnJB2lzRylqIXAHCTwsmFpmw0XqoblA87bp0pa
         u2mhUrNSqEnRKvhd6KRvOx67yBoADEOouuGxBq3k5Pr64+E1BUL1+cHLQF5V9xdk5MJ/
         52tJ1VXYuTlZytbqBdbQ8cllaYp6WFyJgHKYf15MKZNvAYxhtqzvPYgJKH6agMDfUJyA
         B9h0n6DKxwL2mEVgY6dd04Vg/y8KVRDl8q6hlBMiUJMZCK9fXHYKUer/OEKsoOrJacwo
         WmVU7p6t2ocZ7TlLyFjDMHaPSfFr+vgJesKgGBWclV5HcSqxj2L5bJi1VRfnl5eqzWnI
         /GzA==
X-Gm-Message-State: AAQBX9dtOLov5P9bZXR1Y/Od1L1hHT+s1sLfF/77Ty3UXWcZg6Vnh+qQ
        pBhvrIez3q9yMf23Y8MG+SToKg==
X-Google-Smtp-Source: AKy350ZiD4lH0dbwhlOPNgRf0zXiwlE5tOpXAZnVwKUxlUGU4tbmGbLlxHA0xKSydZHhGMIj5ANaQg==
X-Received: by 2002:a17:906:938d:b0:94e:46ef:1361 with SMTP id l13-20020a170906938d00b0094e46ef1361mr9458125ejx.34.1681802678423;
        Tue, 18 Apr 2023 00:24:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id p20-20020a170906615400b0094aa087578csm7730783ejl.171.2023.04.18.00.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 00:24:38 -0700 (PDT)
Message-ID: <cec395c8-83b0-8626-7229-dd8427db48fc@linaro.org>
Date:   Tue, 18 Apr 2023 09:24:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/5] dt-bindings: display/msm: Add reg bus interconnect
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230417-topic-dpu_regbus-v1-0-06fbdc1643c0@linaro.org>
 <20230417-topic-dpu_regbus-v1-1-06fbdc1643c0@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230417-topic-dpu_regbus-v1-1-06fbdc1643c0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 17:30, Konrad Dybcio wrote:
> Apart from the already handled data bus (MAS_MDP_Pn<->DDR), there's
> another path that needs to be handled to ensure MDSS functions properly,
> namely the "reg bus", a.k.a the CPU-MDSS interconnect.
> 
> Gating that path may have a variety of effects.. from none to otherwise
> inexplicable DSI timeouts..
> 
> Describe it in bindings to allow for use in device trees.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/mdss-common.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> index ccd7d6417523..9eb5b6d3e0b9 100644
> --- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> @@ -72,6 +72,7 @@ properties:
>      items:
>        - const: mdp0-mem
>        - const: mdp1-mem
> +      - const: cpu-cfg

You added only interconnect-name, not actual interconnect.

Best regards,
Krzysztof

