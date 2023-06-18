Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A56734744
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 19:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjFRRh4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 18 Jun 2023 13:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFRRhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 13:37:55 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545F61BF;
        Sun, 18 Jun 2023 10:37:54 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bd77424c886so3059419276.0;
        Sun, 18 Jun 2023 10:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687109873; x=1689701873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjyowO3olSkVxM1P/M6uTj58+6YqzrML2c9g+1elEw8=;
        b=gzLUHlk2PIqmTF8HPM5y3rAwCM2IrId/Dar99HLwNoNSGg1sduntnn2KWffoU/6HSv
         ytV2Uz7CGONa5lZ5pFB4lKp0AQxt1sHF7QrdbhF78X36FPaq+OktxOAJwI4ADLVLGQ2o
         t95TVir6XWt5V1PQ6hA7WJ4re7Lk+5TAWxM/mqkHVvaCYq1Ogah3C9VZxzYVAgrx987Z
         yyykM20c7X9/Qjcj71cbkuMWJLvbs+HOjTvz/Lg/kXqeTXCA+5CxmV8QXC8T/KYhgKCt
         4gL1nTAa0TKfLHEymtv5KraqkZ3pIoIkePCl+4v5QBwGwLBZ73PsyN1l95TY3M/Hcl/B
         mDxw==
X-Gm-Message-State: AC+VfDxNVH2072uNnpmLZWKZw0iglfkfK9kh6LX5QW1MBBFeiQStp7qY
        HniPyqdJFSRfv/momwugLNJ5NrgUcsgwZuuyKJc=
X-Google-Smtp-Source: ACHHUZ4TPXAFltd7BI78ccjVwowAz7OL2JP3i3y2P7xTKi6A51SY3VJD3P/Ovyas9IyxHsU2Y9HBgA==
X-Received: by 2002:a25:d657:0:b0:bdd:85d:a5d6 with SMTP id n84-20020a25d657000000b00bdd085da5d6mr4135351ybg.31.1687109872969;
        Sun, 18 Jun 2023 10:37:52 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id c14-20020a25c00e000000b00be45a29d440sm859068ybf.12.2023.06.18.10.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 10:37:52 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bd77424c886so3059394276.0;
        Sun, 18 Jun 2023 10:37:51 -0700 (PDT)
X-Received: by 2002:a25:ad1e:0:b0:bcb:3280:57fc with SMTP id
 y30-20020a25ad1e000000b00bcb328057fcmr5010633ybi.53.1687109871675; Sun, 18
 Jun 2023 10:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230615182938.18487-1-tanure@linux.com> <20230615182938.18487-5-tanure@linux.com>
 <20230615-mushroom-numeric-3a4c03f2204b@spud>
In-Reply-To: <20230615-mushroom-numeric-3a4c03f2204b@spud>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Sun, 18 Jun 2023 18:37:40 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2ND=GJEEXdLLpEWoecN5gtZm-1i92pAgi+eQocSRUVqw@mail.gmail.com>
Message-ID: <CAJX_Q+2ND=GJEEXdLLpEWoecN5gtZm-1i92pAgi+eQocSRUVqw@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: serial: amlogic, meson-uart: support T7
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 10:25 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Thu, Jun 15, 2023 at 07:29:36PM +0100, Lucas Tanure wrote:
> > Add serial bindings support menson T7 SoC family.
> >
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> >  Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > index 01ec45b3b406..01b01f8840ea 100644
> > --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > @@ -46,6 +46,7 @@ properties:
> >            - amlogic,meson8b-uart
> >            - amlogic,meson-gx-uart
> >            - amlogic,meson-s4-uart
> > +          - amlogic,meson-t7-uart
>
> | diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> | index 2501db5a7aaf..0208f9a6ba7e 100644
> | --- a/drivers/tty/serial/meson_uart.c
> | +++ b/drivers/tty/serial/meson_uart.c
> | @@ -796,6 +796,10 @@ static const struct of_device_id meson_uart_dt_match[] = {
> |                 .compatible = "amlogic,meson-s4-uart",
> |                 .data = (void *)&meson_g12a_uart_data,
> |         },
> | +       {
> | +               .compatible = "amlogic,meson-t7-uart",
> | +               .data = (void *)&meson_g12a_uart_data,
> | +       },
> |         { /* sentinel */ },
> |  };
> |  MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
>
> You're adding another element to this enum, but the driver change
> implies compatibility with the s4 uart. Should you not set this up with
> fallback compatibles?

I will drop this patch and use the s4 and g12a compatible strings.

>
> Cheers,
> Conor.
>
> >        - description: Everything-Else power domain UART controller on G12A SoCs
> >          items:
> >            - const: amlogic,meson-g12a-uart
> > --
> > 2.41.0
> >
