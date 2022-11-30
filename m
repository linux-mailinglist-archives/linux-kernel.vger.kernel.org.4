Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6890A63D4C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbiK3LkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiK3LkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:40:21 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C02EF4E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:40:20 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id k5so15438519pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9LNjWyH35fVY/TMIzB5ImQEdzHY0s+B+xCvg9O56BsM=;
        b=z5CawRqPrYDA48WMicMvok00qsLCphUB2bR6AkZ/d9YBlR2s4zjnPdO9kK7hRXpzgg
         pyHgndfm3URHkyHq3sZChFZbNKLbevZK8BtyEBcjgUqj+e5OmI7jyrfQJaInYxqrDq3y
         IY7Y9lGxslKC7eKrUgyhNNnU02mrs3jLvcxT2M0iK3uzbfmKALbUSeqUVUXXvFtuTMaF
         U0SQGDcsBmeGnj13YRDFRKnMoxHB38c/HFaNVrE33jjs8BHRwO8wih2vHrnAbmmxApTH
         9nNpiXL/XwvauD76pxaD9e9UGVmx1JufEeW5+H4HZ8cp5wO+bK/VqjZOnRCRNg/n7bRP
         phPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LNjWyH35fVY/TMIzB5ImQEdzHY0s+B+xCvg9O56BsM=;
        b=ibM7oENpLW3ZtOqr1wKaMaKdHuxfGgtYELUzjCeapPZiPkqVdSYqlhsRUvHZWLrUM/
         RW74WdanMEwHWW4Sun7/S0RqLLZbJT7dOVayEv2b/acWfDiCFMgJS+ip7WWdx43hIfy/
         KQsGrZ+ssrrBC26CistjCqnZeCj7feYlM8l2Da9kfsu/VdHWbUusPVktOqStPHwQSir1
         8L4hYSQM+ZxKzrpw0y0SkQaHJMRuxJ9xcVkoUwP2RLYWgu0lS51mw4bn5xV1yJw/Teum
         Yclb+AnW0U0PCDNEyhRIqY44EnyQq3pHqrwLLrknEANPtxS/fvDesJqSzYRcgJaSkeOc
         figg==
X-Gm-Message-State: ANoB5pliscXucQK+kd0+nokeNj3KYfGX9q3GIhF0EkL97aIXvnCKSooQ
        G+eOJ+146JMRpCuz65XFfztwPjcJ2iYHmYz8GJjyFMXI1zAc9A==
X-Google-Smtp-Source: AA0mqf6iaywNXQp7J6No+cTnfXmbnavNVNaL9Gtrh9Vdjr65ORYiD9n0kq1vcrM3ud2gzVPfwi75crAIe0SaKgFEjvI=
X-Received: by 2002:a17:902:a503:b0:188:6baf:2011 with SMTP id
 s3-20020a170902a50300b001886baf2011mr39978056plq.165.1669808419589; Wed, 30
 Nov 2022 03:40:19 -0800 (PST)
MIME-Version: 1.0
References: <20221130101852.5408-1-cniedermaier@dh-electronics.com>
In-Reply-To: <20221130101852.5408-1-cniedermaier@dh-electronics.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Nov 2022 12:39:43 +0100
Message-ID: <CAPDyKFpZnnx_4+NmsVewMs8duDqf=qY57a134QD+1NdcKRnK_A@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: mmc: Remove comment on wakeup-source property
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 at 11:20, Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> The current comment on wakeup-source is a little confusing because
> the word deprecated can be interpreted at first glance to mean that
> wakeup-source is deprecated. Also mentioning the obsolete property
> confuses more than it helps. Therefore, the comment should be removed
> completely because the enable-sdio-wakeup property is not used in
> any current DTs.
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
> V2: - Instead of changing the comment, remove it
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 802e3ca8be4d..e82c00368088 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -293,7 +293,6 @@ properties:
>      description:
>        SDIO only. Preserves card power during a suspend/resume cycle.
>
> -  # Deprecated: enable-sdio-wakeup
>    wakeup-source:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:

This looks good to me!

However, let's also drop the reference to the property from
Documentation/devicetree/bindings/power/wakeup-source.txt.

Kind regards
Uffe
