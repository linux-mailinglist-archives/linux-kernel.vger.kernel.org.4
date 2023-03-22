Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211B76C4EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjCVO5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjCVO5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:57:17 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964FD67816
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:56:36 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id i22so12831220uat.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679496994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s1dhkhGlsHJNebLug/OyJJKxYaraa8k3XdeUJcdP7fY=;
        b=Ld8vUlBSpFLWaAMAjCnYUskjGk9LIgm7DGPQHv4oXLSdJJ+RFezkMOx6Uz6YJqBZfO
         wJvjgDm4deiyuILUXIp+ZE1LeHCqWP++0XelGwF0q2252M9OzkboaIfqTS3ZdXtrviRc
         8OnKzsCeHoous3htXrJHg2aVeJRkxvE59Rhqzq3k+bZ4eS4Ht/ssobpa2kesZP+tMCvi
         /c9Plzjda83WLKDgM0cap8OIMoE45Ko8pMMAPKzAeIgHnfr7jxyPxx5RnzUI3H1VzKMS
         1DrlSy/ABD3tv7aPOxL2+dw1MZORzaX496YwtnyetiIpVvWPtb5zvgH9K4J4sJMCkR9y
         1Trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1dhkhGlsHJNebLug/OyJJKxYaraa8k3XdeUJcdP7fY=;
        b=0ESSYZ5hSV5wVP3OMvtmjXpGUQEN0o0x/jRBqM6oXd8LLdIXJ8bCeOUCv9tkB/++gA
         CLNggGpK5V9/uX7NynfNAo44xej0Z8elOcSEMrg5Wgb5D7Ko+LlvqN19HY+N3Xxx2GhR
         yKXPf66lDIg9mAkAuPjlL93j7G9QUu83LKN/IbWxzGOaG7fBkYlDkV3w88m6KgJXlPBy
         3mNVaedwgCfLPVsqf33Jy5Td5vCiwyyCVY19xcSgGk8GfQGkSvbr3/L5hrTgmAjkCg54
         1Cj+wbvb5LXZpVdOgclqQCkZlFdZxNCcn852r5qAGturTGhQVxZU3UNGpm0u2R1vdHpm
         cztQ==
X-Gm-Message-State: AO0yUKUV+P8IF+9ytlABkFpK5eVmrq538k8CjHh0fvbYqMHgA4CHB+m3
        uTQbTCE9F4QEd0t9ewTu3mnx1/8gexKo7Mh9dWkTvg==
X-Google-Smtp-Source: AK7set/l4yh/G62A5DEQxGq7j4cKn3PTLI0N/FB3U0OHkX5KMhsa1s685MglAJYEtE7fy6NW9UjOMLTRvllRDHzq/OY=
X-Received: by 2002:a1f:aa4b:0:b0:436:5000:ed97 with SMTP id
 t72-20020a1faa4b000000b004365000ed97mr3715375vke.2.1679496993786; Wed, 22 Mar
 2023 07:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230322132212.3646972-1-etienne.carriere@linaro.org>
In-Reply-To: <20230322132212.3646972-1-etienne.carriere@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 22 Mar 2023 20:26:22 +0530
Message-ID: <CAFA6WYP09nmgXafdqZnpBfoe_rHTDCDy+BV8d8jjC-V9mCADSQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: optee driver interrupt can be a
 per-cpu interrupt
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 at 18:52, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Explicit in optee firmware device tree bindings that the interrupt
> used by optee driver for async notification can be a peripheral
> interrupt or a per-cpu interrupt.
>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> No change since v5
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> No change since v4
>
> Changes since v3:
> - Patch added in this v4 to address review comments.
> ---
>  .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml      | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> index d4dc0749f9fd..5d033570b57b 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -28,7 +28,8 @@ properties:
>      maxItems: 1
>      description: |
>        This interrupt which is used to signal an event by the secure world
> -      software is expected to be edge-triggered.
> +      software is expected to be either a per-cpu interrupt or an
> +      edge-triggered peripheral interrupt.
>
>    method:
>      enum: [smc, hvc]
> --
> 2.25.1
>
