Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846AE6211BC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiKHNBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiKHNBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:01:14 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283C614D00
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 05:01:13 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id l8so20971343ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 05:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2KBnjP+nSiovlrgCNq3pgnMfvwR/TgjyTkfX/lxAXY=;
        b=B1NLcQxYD/tx2pF3yzopjY1j/+5ZIQBGNS2nBPNbnSEbAaWVMjzgybAcu8U73wnSpS
         2p6Wl/qwuoxfmZpHd4pLS6PNPs01SywKDuEOkq/q9Ll06Uhqm9dlrj5PlresGVgbve64
         81jMN8Is3/iJqmZxDo7rnXCEDUqiUT60X5AEQtVsfFO+9JPBb1eHrIMgmHyC84lpfQty
         9u8nsXg0URwU1h2oRYR5vAB2D5t6Snyqq+Yxr9V/yyuKVp2JYkbfKX1XfxXOF1yYSOwy
         F5+k72GuWuWwlibeltt6Y62hytjwcAWnJqWAeXfoAy6vj5S9H50BOjRbtsk+tq78j1X8
         3IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2KBnjP+nSiovlrgCNq3pgnMfvwR/TgjyTkfX/lxAXY=;
        b=wWNH2t677eaEwd3qoxve22XD+XpJkTvSomC9xrdSG62mEMYHq8qAZ2Bis+Fk/8CxGo
         eo8pstNzMNoyzQiV6ronZAPfOtytmI4xL39pBGe18OLwyTdRBBiqyKYTvGVEp9iuPXzK
         RAYs79IHV9hnGIKsvPHdcisQavGwXCnE1CGINVyBkekPgDWE/+It5HFK2UqgQEyEX1vc
         am3mvdni9JdL+ahkSxvPc3BFL91mzx4baktHLMUnFf85MDl6zPDxzOCrY5bY+SosBuJ+
         lNGOW3+CktCpLYJTilUxZ5VCbqZiyqN1suesM41MnZI1U6PP1+sPzHVqOAYkcwsF1FhH
         lZJQ==
X-Gm-Message-State: ACrzQf1BBji88c4IklUpNMnjQdNd0GeOoXk1r+XoHnJINKORKXschzuw
        2F5UXx/Bf6NpIkd7GMKV8afQvQ==
X-Google-Smtp-Source: AMsMyM66xrug6V/sv7oOh3M+8rA31Sg6TAYX3OsMnAX7+YblTowGVcUPAZ+KslM0y4845evMIBVXVA==
X-Received: by 2002:a05:651c:178a:b0:277:8a07:a558 with SMTP id bn10-20020a05651c178a00b002778a07a558mr5264594ljb.333.1667912471539;
        Tue, 08 Nov 2022 05:01:11 -0800 (PST)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id h7-20020ac250c7000000b004a2386b8cf5sm1767451lfm.215.2022.11.08.05.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 05:01:11 -0800 (PST)
Message-ID: <228c9136-0c52-af0b-459e-23c9f7ee08f3@linaro.org>
Date:   Tue, 8 Nov 2022 16:01:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 05/18] dt-bindings: msm: dsi-controller-main: Fix
 description of core clock
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, quic_mkrishn@quicinc.com,
        linux-arm-msm@vger.kernel.org
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
 <20221107235654.1769462-6-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221107235654.1769462-6-bryan.odonoghue@linaro.org>
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

On 08/11/2022 02:56, Bryan O'Donoghue wrote:
> There's a typo in describing the core clock as an 'escape' clock. The
> accurate description is 'core'.
> 
> Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index cab38a20a54b0..a607ccd4a905a 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -32,7 +32,7 @@ properties:
>         - description: Display byte clock
>         - description: Display byte interface clock
>         - description: Display pixel clock
> -      - description: Display escape clock
> +      - description: Display core clock
>         - description: Display AHB clock
>         - description: Display AXI clock
>         - description: Core MultiMedia SubSystem clock

-- 
With best wishes
Dmitry

