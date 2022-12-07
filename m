Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC68645B98
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLGN4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiLGN42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:56:28 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F755B876
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:56:26 -0800 (PST)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9E03641520
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670421385;
        bh=AN5JF4JjPpOJkZ/tkyQphRahAoTXPLdfhR7No5Nhr94=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mfGPEnrYxH7MDEe2VkNdKwpmEX4WJYgCMsTEItw2sH7O88OT9wPBhEgG6rVjY0xrO
         dkLmQJtblU+z30Rtta4Vj2LWR10I8tvXbT0eStYqvruY2nrtZE2/9pldgufBEj5cJo
         en9dLQ7o39BhXbjvGbqZn0ip7t5187CE0iMR6V4s9mUVFzlsBNsX6bCOWMJ2+EbcLG
         cjSd3c6JR+TDZQwHHY4QCsHUPOIz4V4quR3ufjFy1xf2uLOKecO/6d0KogcoWCmI8R
         4iBp/ta96LMWxwE6fZhi19+XNUrgS9b2SKk5IKbVgy0b1VbUi2opUDkjbGOyvYFCBY
         cATEhd2WFykgA==
Received: by mail-il1-f198.google.com with SMTP id n15-20020a056e021baf00b0030387c2e1d3so140974ili.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 05:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AN5JF4JjPpOJkZ/tkyQphRahAoTXPLdfhR7No5Nhr94=;
        b=6d/nsUVNWBEmzgBtkOllnzc/JXrY2gPGy5Dw4UQ9ck+wcJgIaDd0PS89uL9mTtijcM
         gRmd8BPK6MoypWXAwb1OUff65rfcCiHhXHg7dk+siAy3iVjqyvNDuA0paJViNrCRapJH
         WLEZJifB8xrKW8jpHGXkoufgjb8cNQ6lbxiTNjGG/0iTv4Tg8Dyt6UW7e6Q7yGDJzuzG
         USF7UmoexYbbRjipRN6UyypWLUtCDB5ZSl9uiGqQwwmvkuNoIkB3+GOqf5bP0/JOdmf1
         vLe9C0pSMlPyunS9SLkZNe4kN503fpFa3htyeq7fG4fop/wAEjrjo5aDplLjgWzA6iiF
         yiCw==
X-Gm-Message-State: ANoB5pnm/xc/IO0iDCTaKv7Wa/dWMKs0zeQWFCYU6fXSQ+6Y07IJW4fV
        19zzukt3eeR75NJgOqm5dbOhq/jVnFAdmr9FLz2enyDR/BsPuutuXBepQKWLnWUBShWLcjyzR74
        zYnyC10h+9VAWvf3pXCHTrtMWbVFqPXcZQXPSN++aiGHFba1VtMUnxcTFEg==
X-Received: by 2002:a92:cd43:0:b0:303:2fd2:f612 with SMTP id v3-20020a92cd43000000b003032fd2f612mr15125924ilq.144.1670421384614;
        Wed, 07 Dec 2022 05:56:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf68T1FZSxevGnNf72rEE0f+xwVzoSCPSjB0SLRGWkB37LRAqopLc6DAcKKSJpFo/ZWVkn24R+SZbWzdDyZVHaY=
X-Received: by 2002:a92:cd43:0:b0:303:2fd2:f612 with SMTP id
 v3-20020a92cd43000000b003032fd2f612mr15125908ilq.144.1670421384463; Wed, 07
 Dec 2022 05:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20221201090242.2381-1-yanhong.wang@starfivetech.com>
 <20221201090242.2381-2-yanhong.wang@starfivetech.com> <277f9665-e691-b0ad-e6ef-e11acddc2006@linaro.org>
 <22123903-ee95-a82e-d792-01417ceb63b1@starfivetech.com> <3a9ef360-73c3-cf26-3eca-4903b9a04ea3@linaro.org>
In-Reply-To: <3a9ef360-73c3-cf26-3eca-4903b9a04ea3@linaro.org>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 7 Dec 2022 14:56:07 +0100
Message-ID: <CAJM55Z-iLy1fZmoyk3FU7oDQcKBk6APYf-cbamKr7Gjx+NaoTQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] dt-bindings: net: snps,dwmac: Add compatible
 string for dwmac-5.20 version.
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     yanhong wang <yanhong.wang@starfivetech.com>,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 at 09:04, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/12/2022 03:53, yanhong wang wrote:
> >
> >
> > On 2022/12/2 0:18, Krzysztof Kozlowski wrote:
> >> On 01/12/2022 10:02, Yanhong Wang wrote:
> >>> Add dwmac-5.20 version to snps.dwmac.yaml
> >>
> >> Drop full stop from subject and add it here instead.
> >>
> >
> > Will update in the next version.
> >
> >>>
> >>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> >>> Signed-off-by: Yanhong Wang <yanhong.wang@starfivetech.com>
> >>
> >> Two people contributed this one single line?
> >>
> >
> > Emil made this patch and I submitted it.
>
> If Emil made this patch, then your From field is incorrect.

Yes, please don't change the author of the commits you cherry-picked
from my tree.

But now I'm curious. Did you check with your colleagues that the dwmac
IP on the SoC is in fact version 5.20?
This was just an educated guess from my side.

/Emil

> Best regards,
> Krzysztof
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
