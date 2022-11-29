Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B0A63BFC2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbiK2MIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiK2MHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:07:38 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9513B22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:07:14 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a9so10033355pfr.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CLaMkaBp7KGIWxfb8Zd8ve3dRx2iCekJtCJrymRzWKA=;
        b=p8G9b0N31HwrkryXMsELri1esfPlWmkUvApiYvOqCI6V+RvhBMmAo3rfemrquf7d9x
         gv6PUWa46Tm5Ymh/rfgG0f9Pp+xgBQte9WTjYOLFk7rLpeHHZLelf2BE/f3fbN3B3j97
         1z7eNFVOPOogiLxxVsVYKwjsKyR61EviRxjEftCz47B9SvHBRKAoy3IGTJsuPjsJweTm
         FcLztLnQuMo4GzUVt7cgtfppT2l1OSI4V27NEtpmc7FN5oAfth76W5jAPShueqB6Nx8F
         9NqhCFXobifdhnyEs4L/BtbxAV7qZEoCVAwmxg/tTqr6JZJdOXvd+sgegWqE9R9DcFh2
         /UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLaMkaBp7KGIWxfb8Zd8ve3dRx2iCekJtCJrymRzWKA=;
        b=W2hD4KcvoZwJocYq0zigpdzpeyHcNXdzZSHrXhZY/0Yw7bW9JW5QtpIgsd7tGMwlUa
         lZpEZTQ6VFZZoPaly7xWsTBVc9mzSLs9xx5hLTrOZxpLjL///iLkX28o6gjB/Gn1KozA
         3+epgouPVom42oVqD84cHfS5avOennX5YDmChHttr5hLm1i/WtrjzZ0d0JgIJfQ3np24
         g/Fxs4stTsGc1INp4spnC0kmUPM3hWTx2SH6VJx2fQyfo1Ep0Bz3aCxe1gnzDm8OQ4IB
         nYopZccJexONv0AybQC2OnSWb1ahYGlk4aUXy/Vq9ZquKwge1ivwne8bi5kii/bK7+L8
         P7Nw==
X-Gm-Message-State: ANoB5pkJ3S0G9IjAd/kQRip33noib6GS+N0ZaLOHIC7wyoi/t5xTTJ3Y
        ZSVihEFMUw49BOSGORX0nx4N8TAEw6uk4bab+s5BMA==
X-Google-Smtp-Source: AA0mqf4Tf4VM1UWDXcxIfjvce1xmaAtKT915CDXPR9PGaf16YMIEdhpOXoB1vr0ly1KOA06qR727mEV0IgcbPs905yE=
X-Received: by 2002:a05:6a00:1409:b0:56b:e1d8:e7a1 with SMTP id
 l9-20020a056a00140900b0056be1d8e7a1mr36905889pfu.28.1669723634307; Tue, 29
 Nov 2022 04:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com> <20221122111124.6828-3-cniedermaier@dh-electronics.com>
In-Reply-To: <20221122111124.6828-3-cniedermaier@dh-electronics.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 13:06:38 +0100
Message-ID: <CAPDyKFqc2kc4O55BAVikZFeZpAeRYo3AAfnHyxKPcsUujeGauA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Make comment on wakeup-source less confusing
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        kernel@dh-electronics.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 at 12:43, Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> The current comment on wakeup-source is a bit confusing, because it isn't
> clear at first sight which property is actually deprecated.
> Change the comment to one that is less confusing.
>
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: kernel@dh-electronics.com
> Cc: linux-mmc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 802e3ca8be4d..a921442c6c1d 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -293,7 +293,7 @@ properties:
>      description:
>        SDIO only. Preserves card power during a suspend/resume cycle.
>
> -  # Deprecated: enable-sdio-wakeup
> +  # Use wakeup-source instead of the deprecated enable-sdio-wakeup
>    wakeup-source:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:

Rob, Krzysztof - do we have a preferred pattern for how to express
deprecated bindings - or is the above okay to you?

Kind regards
Uffe
