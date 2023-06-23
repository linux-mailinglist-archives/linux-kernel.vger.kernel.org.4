Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE1E73B21D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjFWHvq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjFWHvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:51:40 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B011724;
        Fri, 23 Jun 2023 00:51:38 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-57028539aadso3005157b3.2;
        Fri, 23 Jun 2023 00:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687506697; x=1690098697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxyxDexqa1F6dnoldyOUQc/KFZNYj0AG9ZFf5f/vnv4=;
        b=KX0FlmwGWaUWDWSKJLi9SN3kfIwQAf7hGpgmox+6mV8ykTICRhCa1bSST1YR11VNyY
         3l3X8rx8HutNeVgTOfxgSMZ1Eg/022IEI22xY9Tq9vIUZCI774E18z8wYNUaDye6HmqH
         EMIku4y/CMeAagGeau+Nq1HO+gypQon5224dUbyHJ1TobHkUekbvOChGS+Nf6253kLWY
         yK4NGNvKlV5KUOqJ0ikq2CfvDuLQ2ecZZ5Bk619KcoS1DxFmTDoSb7y0isP/K0qYw+Ui
         xSYfUd/PmRsg72Eg8cnGegRY+QrPNbG6/MzR+8PNaiO1VwKrvmD/S8nGRXmFqLP9O0kr
         +JSw==
X-Gm-Message-State: AC+VfDylaZXRWw3oK1ouahFtBTnqPdM3aryoMlmBfg/G3mYewHBW/o+q
        zW3bj5sKV4/tya/j0PaXgZVrT1CcGKRgVodz
X-Google-Smtp-Source: ACHHUZ50U8gtmDVBd8e15JKwviHwzTsgcCwhP1gV5d3OcOkmwbIw0QCmrBVPdXhbW/1CzAOr3UH1lQ==
X-Received: by 2002:a81:4f83:0:b0:570:6fbd:2daf with SMTP id d125-20020a814f83000000b005706fbd2dafmr26255584ywb.37.1687506697508;
        Fri, 23 Jun 2023 00:51:37 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id o16-20020a81de50000000b0054f6ca85641sm2275866ywl.99.2023.06.23.00.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 00:51:37 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-57059626276so3012277b3.3;
        Fri, 23 Jun 2023 00:51:36 -0700 (PDT)
X-Received: by 2002:a81:4e88:0:b0:565:ba4b:aa81 with SMTP id
 c130-20020a814e88000000b00565ba4baa81mr22920867ywb.45.1687506696754; Fri, 23
 Jun 2023 00:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230622084045.519203-1-tanure@linux.com> <20230622084045.519203-3-tanure@linux.com>
 <20230622-unsent-willing-574906af5e1a@wendy> <4a2a2f0c-f9dd-d5c4-1e7e-5852970f87a7@linaro.org>
In-Reply-To: <4a2a2f0c-f9dd-d5c4-1e7e-5852970f87a7@linaro.org>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Fri, 23 Jun 2023 08:51:25 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+3AcDOYHTJJFRa=rxAWiycDXo99_2KuLSmg5+f4upPJDQ@mail.gmail.com>
Message-ID: <CAJX_Q+3AcDOYHTJJFRa=rxAWiycDXo99_2KuLSmg5+f4upPJDQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
To:     neil.armstrong@linaro.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor@kernel.org>
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

On Thu, Jun 22, 2023 at 10:38 AM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 22/06/2023 11:26, Conor Dooley wrote:
> > Hey Lucas,
> >
> > On Thu, Jun 22, 2023 at 09:40:44AM +0100, Lucas Tanure wrote:
> >> Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
> >> There is no need for an extra compatible line in the driver, but
> >> add T7 compatible line for documentation.
> >>
> >> Co-developed-by: Conor Dooley <conor@kernel.org>
> >
> > You can delete this, I don't need a Co-developed-by tag for review
> > feedback.
> >
> >> Signed-off-by: Lucas Tanure <tanure@linux.com>
> >> ---
> >>   .../devicetree/bindings/serial/amlogic,meson-uart.yaml      | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >> index 01ec45b3b406..4ca4673169aa 100644
> >> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >> @@ -46,6 +46,12 @@ properties:
> >>             - amlogic,meson8b-uart
> >>             - amlogic,meson-gx-uart
> >>             - amlogic,meson-s4-uart
> >> +      - description: Everything-Else power domain UART controller on G12A compatible SoCs
> >
> > s/Everything-Else/Always-on/
>
>
> "Everything-Else" was the amlogic naming for the non-always-on power domain, but it seems
> it's no more something used on new SoCs like the T7 family.
>
> Anyway, the description is wrong, and it's a mess because we used "amlogic,meson-ao-uart"
> for uarts on the Always-On domain, but here it's described as Everything-Else...
>
> Lucas, is there AO_uarts on T7 ? if not drop this amlogic,meson-ao-uart for the T7 UARTs.
No, there is not an AO_uart in T7, as far as I can see from the code
and datasheet.

>
> But if there's no more AO uart controller, you'll need to change drivers/tty/serial/meson_uart.c
> and add a OF_EARLYCON_DECLARE() for amlogic,meson-t7-uart.
>
> But still, why don't you use the amlogic,meson-s4-uart as fallback instead ?
As S4 and T7 are the same as g12a, I thought it would be better to
just have g12a uart.
But sure, I can use S4 as fallback.

>
> +      - description: UART controller on T7 compatible SoCs
> +        items:
> +          - const: amlogic,meson-t7-uart
> +          - const: amlogic,meson-s4-uart
>
> and update meson_uart.c if there's no AO uarts anymore....
Ok, v5 is coming up.
>
> Neil
>
> > Otherwise,
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Perhaps it can be fixed on application, I don't know how the amlogic
> > maintainers operate.
> >
> > Cheers,
> > Conor.
> >
> >> +        items:
> >> +          - enum:
> >> +              - amlogic,meson-t7-uart
> >> +          - const: amlogic,meson-g12a-uart
> >> +          - const: amlogic,meson-ao-uart
> >>         - description: Everything-Else power domain UART controller on G12A SoCs
> >>           items:
> >>             - const: amlogic,meson-g12a-uart
> >> --
> >> 2.41.0
> >>
>
