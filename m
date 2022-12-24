Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242FB655B53
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 22:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiLXVYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 16:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLXVYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 16:24:20 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CC0AE61
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:24:19 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d3so7841776plr.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O7iUW2yvLkltdJ+802lqDxjH4K6OrXY0D1JeDdF3S9E=;
        b=EZbEFdk/4VytSmEsom5jkRfrt7725OovIF6pGEOEMPd4rC1NNZYoDFjRjzeRUreWOL
         ynDybyobQH27InarSzLpWQ9iyd/lmERXpIdRfUQeAQqb5chcYYHTDXDdRR845nXnJkE7
         fn3nvIApiPI3z13VkU6Z1vkxDAz0pXgRpvhOTY3jKjeLZzQQwuH7eSODc27nbP04f4oH
         4UMvrLlYZvJ2zI6k8hEI2Iq4Ih+1VTyOqyEdD7Xcox3YNrTkiZYdrun8Gkp2J13ONj/y
         TOMaEDtq0H0sh56QLOUWA2+YIsHBVYy+Cswc9eMkyNVmOd6nI9HsWghT9t8r6HvpIEuc
         WadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7iUW2yvLkltdJ+802lqDxjH4K6OrXY0D1JeDdF3S9E=;
        b=fnHT7Qxk67OqSK2OtGByrTNBev8x6uCIGj+JuEfUwmxG5+Z15olAi9R5ieYUkASKd7
         9pYAvOQanSo89hMuijZVtQJFWdZUmq7L1wlcJ9PcNe1Op7BZuYh3pP6i+8KkCP03Qz4Y
         MwD7A+2wqcNQIf0TbcyV36ljTmHZO07Dd0Kauq7aOXMdTej9PRvmoCC//PNo/Ar/gs+w
         D1f30tn6BudMYsQPJyjKqtC2k37fHUFej6WFRVIugmMiW84NA/gtLpjzgcqj72B5LWkr
         TZcV5X3RjG4Ml5ytuDuC88miIryyJJKIaixlZO2jJTbq2/CBOrmqieSxE7PFsTstNJJN
         EceA==
X-Gm-Message-State: AFqh2koyQkr54jfNtfr6QWTnG/wf6RJPRtH04tLP5jDkGqtzQAFw7/Vk
        1STkjRp+yfQ3u39SBm+PhhnUv+ysOrL65FhAciIXjg==
X-Google-Smtp-Source: AMrXdXufSdzDq92KU6O4AEt6bGZwOQ4Kh8UTOP3WX1snLwgRIm8pHsfb3BR79NcWRxjinsFrfjD9knwbA/uHq88zD7I=
X-Received: by 2002:a17:90a:b301:b0:218:fb5c:a762 with SMTP id
 d1-20020a17090ab30100b00218fb5ca762mr1562383pjr.241.1671917057817; Sat, 24
 Dec 2022 13:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20221223132235.16149-1-anand@edgeble.ai> <CA+VMnFz8nQ2DnD6L9cPmoRqk+uohRqTEpak9g=WGJnSBoONmrA@mail.gmail.com>
In-Reply-To: <CA+VMnFz8nQ2DnD6L9cPmoRqk+uohRqTEpak9g=WGJnSBoONmrA@mail.gmail.com>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Sat, 24 Dec 2022 16:24:07 -0500
Message-ID: <CA+pv=HP8ckG8dsh-uZ6=k2nMGDGbw3gnh2b1ZWV31mzuYsjNig@mail.gmail.com>
Subject: Re: [PATCHv1 linux-next 1/4] dt-bindings: net: rockchip-dwmac: fix
 rv1126 compatible warning
To:     Jagan Teki <jagan@edgeble.ai>
Cc:     Anand Moon <anand@edgeble.ai>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 9:30 AM Jagan Teki <jagan@edgeble.ai> wrote:
>
> On Fri, 23 Dec 2022 at 18:55, Anand Moon <anand@edgeble.ai> wrote:
> >
> > Fix compatible string for RV1126 gmac, and constrain it to
> > be compatible with Synopsys dwmac 4.20a.
> >
> > fix below warning
> > arch/arm/boot/dts/rv1126-edgeble-neu2-io.dtb: ethernet@ffc40000:
> >                  compatible: 'oneOf' conditional failed, one must be fixed:
> >         ['rockchip,rv1126-gmac', 'snps,dwmac-4.20a'] is too long
> >         'rockchip,rv1126-gmac' is not one of ['rockchip,rk3568-gmac', 'rockchip,rk3588-gmac']
> >
> > Signed-off-by: Anand Moon <anand@edgeble.ai>
> > Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> > ---
>
> Please add Fixes above SoB.

That and, shouldn't the Signed-off-by: tags be reversed if Anand is
sending this?

Confused,

-- Slade
