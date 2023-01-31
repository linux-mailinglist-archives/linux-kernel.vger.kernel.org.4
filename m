Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F406833F1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjAaRco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjAaRck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:32:40 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A9D530E9;
        Tue, 31 Jan 2023 09:32:37 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id dt8so10367155oib.0;
        Tue, 31 Jan 2023 09:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfxFuHI41G+yUaWVZ1QF99wYtGzDKQU8LZrDmmPEq9M=;
        b=Gghl5wiVa85yYLhVnZmjD0Aslt6i5mxmo1RK+v0pe0pnWX1bFRkaP65Qs24DxFuvCL
         0Gt6u5pLQTf/Mm3vlMQTQChoX0FxDvCs9BdGv3pErD+M4DwUUdrjpB4YFqZMX7/qWLxy
         m4aFTzoQEwZJ/AFy00gwCo9SCK5bmwx1O85M0D9NEzWYrQwN2Jk7OP8HbuTVXOCkOW4t
         0Z8YlIhX07eYRxRsajGj8IhPUaaauzAyEgZ2HEKErP52Raq8ZVbJIK3AQTnMP1F4yF2K
         xX+pw3Ft0y4vcAwZ9J0e9/2/yjNNTt8jMRA3cwaEPxkx+eTZfkzawgxL5yiGMtZ/gbYh
         c1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfxFuHI41G+yUaWVZ1QF99wYtGzDKQU8LZrDmmPEq9M=;
        b=5Hm79GTeE0dCogoJvY+TAXldzbgllhV5cNYD1qdsA0n04g/ogTOEZKC2CtEqBZWXk8
         VOirpZQDHp6FO0wwxtMTKNo+irm2erkVZ4UNerK0SKWLrNiWVVz3y9rQNxvWv+770shW
         PpbyeP9H4zZmCsBwdn8V9rVQAf3UQmrHyTiV/ze4ZiKwaBjRMuEr8KfB7XvBrKEBfA9m
         5bEGkf/X8o/6Y72BpCrw2Fs3k2GVTtPeEhe858zDAW6SeV1N8qNuZ25cC2cJK8VYP1HF
         0/T1kPHyRpGVdfcVsvTJkT89HNI1baOPZoeNIsK5eRnt0V6t84uMbZLgC9U2WEVqF351
         RoRw==
X-Gm-Message-State: AFqh2kq3BAlog2jE7JQfRF4ZHqDRAoEXFoIPk+OjkL9R9mEh8z+VOg2C
        2zoF+uVM/WHsZZKjNxe3xvQ=
X-Google-Smtp-Source: AMrXdXsoQn1dw6JRl1hqN0Nj4B9oU8n9+g7wY2I1D1sgAGPC1Lo6R8SO+PAiuSXKFE5IqsZEctF3pw==
X-Received: by 2002:a05:6808:300e:b0:364:f962:afd1 with SMTP id ay14-20020a056808300e00b00364f962afd1mr28995523oib.56.1675186356971;
        Tue, 31 Jan 2023 09:32:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l18-20020aca1912000000b0037880fdb1f6sm1058363oii.24.2023.01.31.09.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 09:32:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 09:32:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] dt-bindings: watchdog: qcom-wdt: add
 qcom,kpss-wdt-mdm9615
Message-ID: <20230131173235.GA3601815@roeck-us.net>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212163532.142533-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 05:35:24PM +0100, Krzysztof Kozlowski wrote:
> Document new MDM9615 qcom,kpss-wdt-mdm9615 watchdog/timer compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 93e4381067dd..1828eaf70b3b 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -40,6 +40,7 @@ properties:
>            - enum:
>                - qcom,kpss-wdt-apq8064
>                - qcom,kpss-wdt-ipq8064
> +              - qcom,kpss-wdt-mdm9615
>                - qcom,kpss-wdt-msm8960
>            - const: qcom,kpss-timer
>            - const: qcom,msm-timer
