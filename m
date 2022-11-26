Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E606397BB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 19:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKZS43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 13:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKZS41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 13:56:27 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9024165BB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:56:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id be13so11533262lfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8lPpKXS45ixTQsb1W3lrQ0O/1/giDkdpwlXIi9rIK0=;
        b=bH47IJUNvzxukvPxBHPanC96mCq54aXbxHPC3WXzz2xx6YfFDE8vnm3F2CpIsyUIoD
         ZXjlbpnGcnomDDX7yaV5urLnsLbLGyaX9cYcFN6G5nZPzUS2OluIG3dXeHo5Ee3eidxb
         cZndh72MmSag9HITY03GAj81Lp7IMZ47U7lSNnTwgWseFkZIRVqtEptSJd/gKIjM+45B
         6bHhouKqoHOpraY0kanDE0iTLwvWrGIrLcOrxLnRbQWXgk+LJvvpt44vch3qTJ4vOxqB
         1Wd7KEoYpAbpMY5/PU4JjKJ1Etx5145Vx96mHabFpVF6oactXZxHef7oaWhOaylTuLTr
         PpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8lPpKXS45ixTQsb1W3lrQ0O/1/giDkdpwlXIi9rIK0=;
        b=eqdfOhEcdpuoEpTO4xeSILeHEtdFSXIzTCifvYfF8nrWWkimMWbepykbXTh91tcI84
         oanRZQjneJua9mL8jMO3WGtWo+vWEOW2x7dpmi4fVGz8Hka73eknuVVjOdaG3QJFT9aB
         g+dWwk0won76juROj+OG6kKhSkW7H3kdQqbngebxrH4kK4hV9Bj64W4J49rZl4piBwa8
         ktFQeslA2mB+OZ71k+e7EyxIetT9qdt8OO0/u/hJOfd5KoLMfRrDhT0/EjcLeKOluK+x
         H8Vf3KTyRLE5hx9/6FKZ/aWe0dY0DF2c07sp0P/gq8UrHg0aeJDQb0+XmUPU2USR6yMB
         pp+w==
X-Gm-Message-State: ANoB5pl6ijRwpA3UnBvXg/3WzxFYYd827yixoW6QXVj/X6x0U0Z8k+d1
        YkaGLPMoGqqKuC2o8TGXLfE9SA==
X-Google-Smtp-Source: AA0mqf5UaVByEJ58l+9W3QDXOvvcwIxl3uE85p9GSOmKC7q7+z1qkKoZEKHWyE8wUHd1gw9obGxaQg==
X-Received: by 2002:ac2:4f0a:0:b0:4b4:12dd:3f4 with SMTP id k10-20020ac24f0a000000b004b412dd03f4mr16881562lfr.610.1669488983111;
        Sat, 26 Nov 2022 10:56:23 -0800 (PST)
Received: from [192.168.1.8] ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id q10-20020ac2528a000000b0048b003c4bf7sm1003972lfm.169.2022.11.26.10.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 10:56:22 -0800 (PST)
Message-ID: <a1d3dbd2-c13f-88cd-969e-ca6bafaa1943@linaro.org>
Date:   Sat, 26 Nov 2022 20:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 06/18] dt-bindings: msm: dsi-controller-main: Fix
 description of core clock
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
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
 <20221125123638.823261-7-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221125123638.823261-7-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 14:36, Bryan O'Donoghue wrote:
> There's a typo in describing the core clock as an 'escape' clock. The
> accurate description is 'core'.
> 
> Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

In the next spin please move this patch after first two fixes, so all 
three of them can be picked into -fixes.

> ---
>   .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 88aac7d33555c..0c09b9230b7f5 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -40,7 +40,7 @@ properties:
>         - description: Display byte clock
>         - description: Display byte interface clock
>         - description: Display pixel clock
> -      - description: Display escape clock
> +      - description: Display core clock
>         - description: Display AHB clock
>         - description: Display AXI clock
>   

-- 
With best wishes
Dmitry

