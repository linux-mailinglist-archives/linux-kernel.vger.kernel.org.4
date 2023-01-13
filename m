Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871F7669978
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjAMOGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241638AbjAMOFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:05:15 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6BF1DDE6;
        Fri, 13 Jan 2023 06:02:43 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id k7-20020a056830168700b0067832816190so12295993otr.1;
        Fri, 13 Jan 2023 06:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9sIvFPf7hSnd/UCtGwTZQfM7Ez97B5HIWAZQQA1PuA=;
        b=Hi5wgjatdejl9OzowWcIyLZ8WD3/3GejCrpQt7JHpis0PNgUtKL5pKx4TTBRlzg8V+
         ggVHCtr62SYK0RhQilLWzKc/D68VpKrBgLpODbz9hdI6e8SZFHaa8fj9qn1tY8khZYRt
         mDTpz5apydPAvTMsFuxYBJA/HnNim/Jj6tybU6fynimuryY2EJ6xsccV+GLI6CAI6zpP
         McWgzjIg7k6fmD9hMJo+SmgwVL15bcimPV6IsxNFEb9veK1+mvFIZgvIenl+brE1ars4
         jWuGZoIxw3iw/z4rN0xQccXhLXPqbMZmrocJNlXRZOFGwAblE42GPBd8+aeznIgwbvJh
         6hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9sIvFPf7hSnd/UCtGwTZQfM7Ez97B5HIWAZQQA1PuA=;
        b=t+AWr3A08tmw7w5qlB7ZdqPA4ZAKjcE+DEHzup0gNlFaB1BWBv9lvoKvBP1HGUifH3
         cFv3hqpkzdJQuvekVnBGGSQzhLU14+nw9k2s7rOGPInbIhBYhbtC0ZamnFuDl2JdNZ1k
         Z0pyP2joJ9zT+X/e4pRBgYbAbBjd7+s1agdeFUTQItHowCBfZAK8IQRbbex7+yp7A1iB
         clTUAu6PfIXvhPWSKTZJjgKqwzQRQSJjfMMxZTw1gPiKMBu8IcPkRSDrl3T1Ai6q8C17
         QcJ7+2f3Yf5ixThS7q4+T8ct8ztc3KA8yA8xGhlG2MD8Rtv8HQaPfkVg2Zk6fTotPvTM
         aLtg==
X-Gm-Message-State: AFqh2kr+bzOtBsoScxVhK/IAiO+bhHHWmWirRCFZl16F9vlZxYqw8bYh
        NpBMu4a1mvx1rcTewSnDbKY=
X-Google-Smtp-Source: AMrXdXuamUYMY5BWPBuRC6S3EPGGGjqJG05YNCxnd1w4hYz6f++Kau2TYeEefD3/YVAHgrKbEK1CLg==
X-Received: by 2002:a05:6830:6704:b0:684:dabf:4dce with SMTP id cr4-20020a056830670400b00684dabf4dcemr119611otb.24.1673618562259;
        Fri, 13 Jan 2023 06:02:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x12-20020a9d6d8c000000b0066c15490a55sm1915026otp.19.2023.01.13.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:02:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 13 Jan 2023 06:02:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: watchdog: qcom-wdt: do not allow
 fallback alone
Message-ID: <20230113140240.GB1606649@roeck-us.net>
References: <20230113103346.29381-1-krzysztof.kozlowski@linaro.org>
 <20230113103346.29381-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113103346.29381-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:33:41AM +0100, Krzysztof Kozlowski wrote:
> The compatible "qcom,kpss-wdt" is too generic and should not be used
> alone.  Mark it as deprecated when not prepended by specific compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> 

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes since v1:
> 1. Add tag.
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index e76364c52fc7..3e0b30a817d6 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -31,9 +31,10 @@ properties:
>                - qcom,apss-wdt-sm8150
>                - qcom,apss-wdt-sm8250
>            - const: qcom,kpss-wdt
> +      - const: qcom,kpss-wdt
> +        deprecated: true
>        - items:
>            - enum:
> -              - qcom,kpss-wdt
>                - qcom,kpss-timer
>                - qcom,kpss-wdt-apq8064
>                - qcom,kpss-wdt-ipq8064
> -- 
> 2.34.1
> 
