Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613ED654087
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiLVL75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiLVL7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:59:30 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC6C31349
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:52:07 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p36so2338321lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M30y/3TxbO371CJNFGIt6ImCkcVESnuhbBT4xUOz+H4=;
        b=BZvKlfrnICVEkblXCG720FtFMEMhogYR+lUIo7UKozU5kskYXNCjGqbDX2DQduc9bJ
         3SJFqtwcKgerB0HCmvjxF3RufKGCqcp1U1zfB6qHZ8ucxb8tAM/EwqKQ7ye2G/4ZLngr
         Jfe+gdK1CTW0QUCi9QHwEI1hkrxc9tBZnpAu+lCmwndjpQWzrxLjKEgrzSVzDPPZbdya
         bxEs3iflfgI13yP0t6dmTaoihJSVYTWUV2wnjQflNJatJRzMvT9LtU0RJeCDv1UBYYQK
         QphUcLMtjoSNYiYUhV5q5XGKbSoBJvKxYyYoeCEeK+NmtfVu1pZoeaMRCmGZRIF6XGTF
         vRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M30y/3TxbO371CJNFGIt6ImCkcVESnuhbBT4xUOz+H4=;
        b=VcXbrLzWbq7+wb+ybiR6S4rPQPOYDRk9+3ZABeJPRNxErkkeFDZCl0Qhz5dj/byXWm
         C0q91dd3kt9Mts+qA3b5xVvNRzFAizCCaMf9sft65j+ybafdvJF4EWU4hMGRBHUVrTvD
         gdIE1F849QVDbzNZ30xngYwP50iWfjzqDRThvykt/FFdCPtfe/u+qGyPv798LDvpv250
         qsfYicBt/pp0mEvM6ug3DCIGPouHT/j/qiJ7cCtgbrAqkFvNT6FY6NUOOHjKMfL1jQJq
         qelw+rYIyJwqLXRlftLNg+EL3W62jqpIDnJMdALSn6NZXR0l0d2+89IVv7FZdOxDtwNg
         H0LQ==
X-Gm-Message-State: AFqh2kra7Gbs6OswKw4lOcW1H9nfD05B9H311aHA5kZhGfA5niBSsLPK
        NaoOlFnnZ+jESsjnpdcDvZyXtw==
X-Google-Smtp-Source: AMrXdXsDYcBW3ugj0qOFlwHwHKZiQ1w0s1KXbyUzMNViPONGJA9/7MRgcCx6WVU4EGLf4Zlr/CYoZQ==
X-Received: by 2002:a05:6512:3d2a:b0:4b4:b8fc:4aba with SMTP id d42-20020a0565123d2a00b004b4b8fc4abamr2100655lfv.25.1671709925720;
        Thu, 22 Dec 2022 03:52:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z14-20020ac24f8e000000b004b55cebdbd7sm47193lfs.120.2022.12.22.03.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:52:05 -0800 (PST)
Message-ID: <42eec0d7-9c6d-108a-cb91-8cc069fc97e1@linaro.org>
Date:   Thu, 22 Dec 2022 12:52:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 06/21] dt-bindings: msm: dsi-controller-main: Document
 clocks on a per compatible basis
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
 <20221220123634.382970-7-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220123634.382970-7-bryan.odonoghue@linaro.org>
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

On 20/12/2022 13:36, Bryan O'Donoghue wrote:
> Each compatible has a different set of clocks which are associated with it.
> Add in the list of clocks for each compatible.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../display/msm/dsi-controller-main.yaml      | 189 +++++++++++++++++-
>  1 file changed, 179 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 98d54a7ee28d4..ce103e3ec4db3 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -9,9 +9,6 @@ title: Qualcomm Display DSI controller
>  maintainers:
>    - Krishna Manikandan <quic_mkrishn@quicinc.com>
>  
> -allOf:
> -  - $ref: "../dsi-controller.yaml#"
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -55,13 +52,8 @@ properties:
>        - description: Display AXI clock
>  
>    clock-names:
> -    items:
> -      - const: byte
> -      - const: byte_intf
> -      - const: pixel
> -      - const: core
> -      - const: iface
> -      - const: bus
> +    minItems: 3
> +    maxItems: 9
>  
>    phys:
>      maxItems: 1
> @@ -157,6 +149,183 @@ required:
>    - assigned-clock-parents
>    - ports
>  
> +allOf:
> +  - $ref: "../dsi-controller.yaml#"

Drop the quotes.

Add missing Ack.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

