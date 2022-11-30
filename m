Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AE063D512
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiK3L57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiK3L5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:57:54 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2DC101C9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:57:51 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 136so15844067pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WPDD92aY5IkTDUm0AI88V6KsAntfL3f78DeuvRzGvOM=;
        b=gJFEf7gFsMnlSQpBr5KEIt5Psur+Fhv7TOvTVRy6K5MMkpva5lKkiMdT4uItObth6J
         0FzYQRO2YbzMuerlOFLXHzWM5M3tYOs5MxdXnu7iSdCftJ54HCCC+WKbhVO82CFrZNIc
         C5Gc7fvKH1INTTDCOGPdLBhDWkIohTBWgmvKdL6lPS4sRllC13VA6dr1/TXw1v61wcH9
         6EjcYpwB/GUsYm5ccQw2AcNJIyC77bzbGS1uk/6NsOsb4DSYY+QufHq8AR4YOwHcFEnn
         w6oPTQfPwZVoPC0dJvmm9vuolcShlc8eETnFqZqiZcitya5SsXYqt29AtB1N+RGPNYH9
         Yg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPDD92aY5IkTDUm0AI88V6KsAntfL3f78DeuvRzGvOM=;
        b=CsyGyAfsntMLL62Pm2kdYPwCk2EO3GzMq+V9Nx/BAfq8eF/k+Tc9dacILJJsoifR+m
         k9fKXCNxyTaNXN0m0HtzUSJdSa+urHTPZCR41f4lcFi+AcFTBU2e/7oE4RaVJ6WI+jWz
         1UE6ZlEBu0s1bLH4HuTm/wy0gEK48Wfl15QeLS42s2a03nRKCw8UQVkBJbvwehdVDQnj
         HcezktZRxMtFIVHUb/n8+AFje76QECfJjWSvx/31WJwkhGMzMEkNKWQWIGzzvR96itsA
         gTII/yk+mMLxG2VB8di9RSq9BX2j/iiWx1B9s+VyTPSh01nKTzkag0e1f94NTJlPPsLB
         47KA==
X-Gm-Message-State: ANoB5plEVvB0uNNkzOKjrq1ASBAjJ8fix+toobVg4tRz/4Rl7bSIqZuu
        o6t87yRV4mzMFW+/tXPOQ6FP1ZxEFxxeR1SxUwN4Ug==
X-Google-Smtp-Source: AA0mqf7EAo/yINVgmXn1/T70ufIfXqN2h6gc2Kx2rj1rmrErgBCihDYj3FxMaOL9Pg+2q1QlIo7A7fy4gsavegxAHNA=
X-Received: by 2002:a65:4688:0:b0:477:7aee:a464 with SMTP id
 h8-20020a654688000000b004777aeea464mr40156253pgr.595.1669809471316; Wed, 30
 Nov 2022 03:57:51 -0800 (PST)
MIME-Version: 1.0
References: <20221130101852.5408-1-cniedermaier@dh-electronics.com>
 <CAPDyKFpZnnx_4+NmsVewMs8duDqf=qY57a134QD+1NdcKRnK_A@mail.gmail.com> <adc58f49cb0c4de6b95d203f4b5440ba@dh-electronics.com>
In-Reply-To: <adc58f49cb0c4de6b95d203f4b5440ba@dh-electronics.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Nov 2022 12:57:15 +0100
Message-ID: <CAPDyKFoMQH=XnF=v9nCg0=xws985nXCDNygCLKkuY82Nt4VLyg@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: mmc: Remove comment on wakeup-source property
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>,
        kernel <kernel@dh-electronics.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
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

On Wed, 30 Nov 2022 at 12:55, Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Wednesday, November 30, 2022 12:40 PM
> > On Wed, 30 Nov 2022 at 11:20, Christoph Niedermaier<cniedermaier@dh-electronics.com> wrote:
> >>
> >> The current comment on wakeup-source is a little confusing because
> >> the word deprecated can be interpreted at first glance to mean that
> >> wakeup-source is deprecated. Also mentioning the obsolete property
> >> confuses more than it helps. Therefore, the comment should be removed
> >> completely because the enable-sdio-wakeup property is not used in
> >> any current DTs.
> >>
> >> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> >> ---
> >> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> >> Cc: Marek Vasut <marex@denx.de>
> >> Cc: kernel@dh-electronics.com
> >> Cc: linux-mmc@vger.kernel.org
> >> Cc: devicetree@vger.kernel.org
> >> To: linux-kernel@vger.kernel.org
> >> ---
> >> V2: - Instead of changing the comment, remove it
> >> ---
> >>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> >> index 802e3ca8be4d..e82c00368088 100644
> >> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> >> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> >> @@ -293,7 +293,6 @@ properties:
> >>      description:
> >>        SDIO only. Preserves card power during a suspend/resume cycle.
> >>
> >> -  # Deprecated: enable-sdio-wakeup
> >>    wakeup-source:
> >>      $ref: /schemas/types.yaml#/definitions/flag
> >>      description:
> >
> > This looks good to me!
> >
> > However, let's also drop the reference to the property from
> > Documentation/devicetree/bindings/power/wakeup-source.txt.
>
> Should I include this in a version 3 or should I send a separate patch?

Please add it in v3, so we can remove the confusing things altogether.

Kind regards
Uffe
