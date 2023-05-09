Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4338E6FC393
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjEIKKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjEIKKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:10:45 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7888E100C9
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:10:40 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-559e2051d05so81712117b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 03:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683627039; x=1686219039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9PD/4wFlKgwhTb+3VkQbjoaWj4CSHaFf0HIucSINi2g=;
        b=llXJ3DEvqjj+hilBJmj+6N5Jm0D7CqeCzSrph9sqI+XpFjUyZRVynpAExlo7cVzyAb
         g+2V/2Q0Rb/G9Bdqo5xrGD/BuS/o1INSjKAh90W+V9EH1HkqLlcuxMMbdGTG3QZTBPUd
         mwetj9c3i6B9WPgKhIdtCBOhL5qrIqFDFWgSpDMTigPvo9tZReM0jn+7R2IM78X910yM
         1HdZaJ9suaXs+gd0otFGCm4Tj/IMiucMsOYFC034hEAg8sL982eC8zaXdOFh2A1hBMdy
         Vw4F6WJHTC12FzMlABLUar1vZfJC9zK7u8Mq6Z/dCTc235d3d2HnLfs8uwFvsZceI/dY
         VXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683627039; x=1686219039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PD/4wFlKgwhTb+3VkQbjoaWj4CSHaFf0HIucSINi2g=;
        b=Njr2GUD1yW1Ke95OQ7QQdOlRiD4bJulFTjfdA0jfnzQSeixhT7xze3QrgALFIkK7nl
         fbChVp/bHi5wAulx8qtImLnNMB4yKhU5nRntD0YqXLc86BT2YL+yKv3PmnM98Zpd2hcx
         59DEXUsdGjYwm9eRcK5qZZs7zCXUizpi5acwKOuo2Wlmj4uPLLDUezXzUhP9tYTUD61E
         FfwRY9JeSpSCyFpc/RzDD2/UGkHO5NhTGoQo0v4GVVFjEttiFVpxkQsJCvYMTIE96eNO
         iAOP+g87c0KAAwZyAS8oiSvfWUHJQqyHA/xKS1Lm1dBuyhhMRNXEJ1g5OscBRkF0h7u8
         QpIQ==
X-Gm-Message-State: AC+VfDxeNRTDpx/shE/7oTZ3SBu2zrONrqtxpXemPm7t/Eky8pH69BXp
        Xe48L5z5HH0sc+CPskcpJKktCxy8UMfa5jeEdlDtaQ==
X-Google-Smtp-Source: ACHHUZ7KKVqtqMUy2P63Qu3FA700p5MYckoU8Fxlsax9PIG3qpJhEDnpIUfzmbsfk5BVQv958NOmYEm0yV1Z3bksiNA=
X-Received: by 2002:a0d:f281:0:b0:560:beeb:6fc1 with SMTP id
 b123-20020a0df281000000b00560beeb6fc1mr1136013ywf.16.1683627039658; Tue, 09
 May 2023 03:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <88c64da50a1af868d8b14054c440e5ff96a63399.1683548624.git.stano.jakubek@gmail.com>
 <a1fd4092b8a31c2ee58a3cd4cca062db13197b45.1683548624.git.stano.jakubek@gmail.com>
 <669ba770-4ee1-e7e3-0692-51e6d6df0229@linaro.org>
In-Reply-To: <669ba770-4ee1-e7e3-0692-51e6d6df0229@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 May 2023 12:10:03 +0200
Message-ID: <CAPDyKFqHsdQyTRWVPhPZk_sqy7j68-b1-SAcPQ8nrPpW8qNb_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: mmc: brcm,kona-sdhci: convert to YAML
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2023 at 22:27, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/05/2023 14:46, Stanislav Jakubek wrote:
> > Convert Broadcom Kona family SDHCI controller bindings to DT schema.
> >
> > Changes during conversion:
> >   - also mark reg and interrupts as required
> >   - drop deprecated compatible (it's been deprecated for ~10 years)
>
>
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include "dt-bindings/clock/bcm281xx.h"
>
> Why different than <>? Keep <>.

I have fixed this up when applying, no need to re-spin.

>
> With above:
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>

So, applied for next, thanks

Kind regards
Uffe
