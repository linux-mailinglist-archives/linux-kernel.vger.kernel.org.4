Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E473669999
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbjAMOHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241882AbjAMOGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:06:55 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901C86E410;
        Fri, 13 Jan 2023 06:03:35 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id j130so17755970oif.4;
        Fri, 13 Jan 2023 06:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QutA8fHBQTxFnKX6Y2E+CKgWtbt+S8/vaN1GoJ/uma8=;
        b=YKgcetQBfchjYhkxCnaFULOgrZeKVQtCUVZnkdXSMs5JizvJwFK8eNUdvWIHtzLUP4
         MURxZuVa8VMOBF/aWfGMkqN+jaZZBdCNRcZKj//RBj0qYGU+7OcvRRtCzBe/Eslmn2f1
         NtMpRQ+ZtIdiQ1exfcLH74grLho9jMMvF1c+CzYdzB2iqON1sbg0L12Rgy7MyzSVzGX2
         SJBj5HPOqEvNpV2vKhplurXJZBEN5zXDiHwANbyPY4OJwwdV50oJCbF7aC0hkIbIMYeq
         FzUJ2Cg15Xi22BG0UmTZkEYj7KiTAz/gqwsIEU41X8OvX76VC75QtFRLcnxu62CcklCu
         XNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QutA8fHBQTxFnKX6Y2E+CKgWtbt+S8/vaN1GoJ/uma8=;
        b=rkXroa0R+LaxYqDKzYrhh4Ided0Te0t4RldanxWQX7vFuq6XFTyKDj4aRdEDDoUpkk
         LCMUb+j6f3cb3DdnOA7jwfES1GrM0DzePBv9X6AnxX9VrWhAwL5DnGsW5qjNs1LfGhGA
         3GmtSqjJA2mi3gJ1B6+p9oCvxitkSogsQba/q7yPWQoaEJ9UXf/6izkwLB6vwuMQKacK
         7iyIxSVho3VPh0N1tuslSSK4WRloZoeH7nj85bp5XKIVXO9BGBcguW2+F96UJn/BQHNt
         qYB9CtMIJQjJqqjNw+uul6kemDneoxevD+PUYKb0u31BLTS6lsGZ455p/ULYFv0ubS4k
         RRJw==
X-Gm-Message-State: AFqh2kpX3r+BhqDctRNHG0gXsOBqzkw18XNxVydluWocqRJxqz/2Y3u5
        dVsadP6r2SwsLkj6O/1F1VY=
X-Google-Smtp-Source: AMrXdXsZpwz3t+cwCWsi7vgosB3GCWdqQwkzNWgwVO3CJtxmy/bCR8oLEgtKXY/top1u7+cm73oPmg==
X-Received: by 2002:a05:6808:e83:b0:364:8f2c:186c with SMTP id k3-20020a0568080e8300b003648f2c186cmr3675955oil.7.1673618614855;
        Fri, 13 Jan 2023 06:03:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h16-20020a9d7990000000b0066ec4e2b396sm5302099otm.53.2023.01.13.06.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:03:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 13 Jan 2023 06:03:33 -0800
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
Subject: Re: [PATCH v2 7/7] dt-bindings: watchdog: allow "timer" as node name
Message-ID: <20230113140333.GG1606649@roeck-us.net>
References: <20230113103346.29381-1-krzysztof.kozlowski@linaro.org>
 <20230113103346.29381-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113103346.29381-8-krzysztof.kozlowski@linaro.org>
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

On Fri, Jan 13, 2023 at 11:33:46AM +0100, Krzysztof Kozlowski wrote:
> On some SoCs the watchdog device is actually mixed with timer, e.g.
> the qcom,msm-timer on older Qualcomm SoCs where this is actually one
> hardware block responsible for both system timer and watchdog.
> 
> Allow calling such device nodes as "timer".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes since v1:
> 1. Add tag.
> 
> See also:
> https://lore.kernel.org/linux-arm-msm/20221212163532.142533-1-krzysztof.kozlowski@linaro.org/T/#t
> 
> which causes warnings:
> 
> qcom-msm8960-cdp.dtb: timer@200a000: $nodename:0: 'timer@200a000' does not match '^watchdog(@.*|-[0-9a-f])?$'
>   From schema: Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> ---
>  Documentation/devicetree/bindings/watchdog/watchdog.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.yaml b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> index fccae0d00110..519b48889eb1 100644
> --- a/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> @@ -14,9 +14,14 @@ description: |
>    This document describes generic bindings which can be used to
>    describe watchdog devices in a device tree.
>  
> +select:
> +  properties:
> +    $nodename:
> +      pattern: "^watchdog(@.*|-[0-9a-f])?$"
> +
>  properties:
>    $nodename:
> -    pattern: "^watchdog(@.*|-[0-9a-f])?$"
> +    pattern: "^(timer|watchdog)(@.*|-[0-9a-f])?$"
>  
>    timeout-sec:
>      description:
> -- 
> 2.34.1
> 
