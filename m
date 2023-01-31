Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B0B6833DE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjAaRbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjAaRbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:31:12 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DF86A46;
        Tue, 31 Jan 2023 09:31:07 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id o66so13446974oia.6;
        Tue, 31 Jan 2023 09:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23/Ygv4K9LVUh4Trn3GlV760MzhnYkiKXWah0In2v88=;
        b=q7E6y2nd/9deUEEXJ5EjsL7rCom7WIdcMBgwXImide0A48cE5rQrgwK5eCcuAnLw/m
         7N3TUCdRjhtgbR/k5IrJLZoI5pzO+jSttLlzqtNhEtrepG65Lzuyv6l7ENGPgFTDDe/H
         2dd7O+NvPa2ZZsCmM6YPNwrRKCmtXfQdjwiCmf49ht8jBIXua+chFCH9oa4b1dqs9qT7
         Xoq4tR0g6cxAtoAk1luIfLzkGGqtEepptwYaBJTjJZAZyZCPTsgmX/rpldckebFSkyAi
         gOom/+5FwxFb81g8L7Ovl/iX06Zj0ljN0gWes5/SPkAq5u40QTexsAwHKoiy7ZySQk3U
         2xJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23/Ygv4K9LVUh4Trn3GlV760MzhnYkiKXWah0In2v88=;
        b=IkvBA58BGXE+el3pJfz1nOGS8z+Ac4aKBXBh5NiSmNTVVlDPC4POGNFVYH0XrEm7jJ
         VqZ3nbqZeZPtuJRwZGOR95KNBq4Hg8YBNAdfJ7ymqKAn+S5YYFHKjvRtFYyHXOoF1QJt
         suCFihEToMkQnse+5//ek2833f87WO6NP6YGFNcnBOSxYNrR09MtNbLAUgArGzuYfkGq
         eThJUXQrM5H/6SG9crf/kUZbn2atmH/S3VVuc4K0HWaVBJqjxrOjUjUwiuHlyh9SWOt5
         bME8INe3K8UcuviX+K3BmkAbX29sU7VomP1SIAzPOs/kR1UuzpNtS/iFskFHzY/e2g4y
         C7WQ==
X-Gm-Message-State: AO0yUKWUuUXDO1DcyF3Mp2+4Z/oQlzWFWPJufAECD8t7X3MEnuXdD8N3
        JDaM7neMQQVtYm7J+UAuUqeYtZGLMLQ=
X-Google-Smtp-Source: AK7set8sJEXmQ1kws9YxJnpkV+RwwlImgJMbhRDSQOThL8KPYC2mp21g9BdNW6xBd4sf6YtVHHUtcA==
X-Received: by 2002:aca:2306:0:b0:378:29a6:b657 with SMTP id e6-20020aca2306000000b0037829a6b657mr4883582oie.53.1675186267126;
        Tue, 31 Jan 2023 09:31:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2-20020a056808000200b0037868f9e657sm1690563oic.37.2023.01.31.09.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 09:31:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 09:31:05 -0800
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
Subject: Re: [PATCH 02/12] dt-bindings: watchdog: qcom-wdt: do not allow
 fallback alone
Message-ID: <20230131173105.GA3601537@roeck-us.net>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212163532.142533-2-krzysztof.kozlowski@linaro.org>
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

On Mon, Dec 12, 2022 at 05:35:22PM +0100, Krzysztof Kozlowski wrote:
> The compatible "qcom,kpss-wdt" is too generic and should not be used
> alone.  Mark it as deprecated when not prepended by specific compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
