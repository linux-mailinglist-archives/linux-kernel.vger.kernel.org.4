Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F586537F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiLUVGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUVGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:06:52 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005251DF3D;
        Wed, 21 Dec 2022 13:06:50 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id kw15so423940ejc.10;
        Wed, 21 Dec 2022 13:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8KKbAaGdCU2qz8tzZ8Eajc31tmbLI+yoxmAyVIDyiEo=;
        b=iEeW+jFlWQHNAOcpKOv++bgVCIpOYDCgaQtQvCOgtQrueHtHQlgYTMP9SQ35W4ncHu
         Vd5cSfuNee2U7EpalJeQxIK8ZzZz6s/ptl2RJSfrsqayYMfdai7cAWJj+23E+v+yJXlZ
         qcHAnhy4G3QKSQ7Sj+R6rIA66qjvJLm6S/NxhT8J3dOe6tVJhqdjrPcyskkCpEWMzI+8
         bM3pXZAtVi9XHCF+NkKW5FPDlYqYjYHweBXS9U8BXZYNBXa6TSlLiSnzx88OoQ20WnVI
         CcIChN/xYLF0Xv2k3xdsMYgeUrlqLY8Jpx/ge5vOAZNnUpLq/poU/dyT8AyjfAu6oH0E
         A3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KKbAaGdCU2qz8tzZ8Eajc31tmbLI+yoxmAyVIDyiEo=;
        b=1WAUgoCE4Bu4xo19yYmtbFh4XhG+lv3OVuoDc80OYpZFRfhLN/I/pIXViBOguMcwe7
         k6fXfQ1jLiXRa3ikPxbcSiC6/WlFRXe8xg5pVwwDnEpHVj99qhLUiJ20l20cgjc8RsPL
         J0kxicMrUbchfoykl9glv0+G0drMX16u0KZqfBxBrirKldtyJpuRLeKHBPb/S6BGtrMV
         T1x02u2kiL/8xvW2GRwKmb6Jxh/EDGlYQNHaADhXE08CP0xFrhKzlf7Mc0ECV1s8jJ81
         z86Nto6d4we4ntqXCXg9GFARCk0PNVke9SKu5+p5oGpq1eUNDGlPgl9AdQX8rmkU8u8W
         w4cQ==
X-Gm-Message-State: AFqh2kqXFH3aJjv/SbZesWfMfL3DlVJFCpcraB2PSwnW1MkEnjjPGYS3
        +3cmFUIJaan+HI6N9DGhCzRuQ0AfUT0xHeY9sw1QRI2zqqiOLg==
X-Google-Smtp-Source: AMrXdXt3LFry2Pk44xOSwKCaBzl8/kUOHa7kVd6BTzeZ86BdZIVFyr3z2ToxY+RCjIfE7f9tLrzWliU8SEHHrmX8QZM=
X-Received: by 2002:a17:906:3398:b0:7c0:efb6:8744 with SMTP id
 v24-20020a170906339800b007c0efb68744mr329585eja.267.1671656809542; Wed, 21
 Dec 2022 13:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221221000242.340202-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXmKYV7CwuD=ZNgaOTc+LxP9OvEJ8gcW_iS5NamTxEE+w@mail.gmail.com>
In-Reply-To: <CAMuHMdXmKYV7CwuD=ZNgaOTc+LxP9OvEJ8gcW_iS5NamTxEE+w@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 21 Dec 2022 21:06:22 +0000
Message-ID: <CA+V-a8tqvY+Nj391j+zJO21Q=47pyFR1SkDLH-hmJephcorY3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G2UL SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Wed, Dec 21, 2022 at 12:37 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Dec 21, 2022 at 1:03 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Document RZ/G2UL (R9A07G043U) IRQC bindings. The IRQC block on RZ/G2UL SoC
> > is almost identical to one found on the RZ/G2L SoC the only difference
> > being it can support BUS_ERR_INT for which it has additional registers.
> > Hence new generic compatible string "renesas,rzg2ul-irqc" is added for
> > RZ/G2UL SoC.
> >
> > Now that we have additional interrupt for RZ/G2UL and RZ/Five SoC
> > interrupt-names property is added so that we can parse them based on
> > names.
> >
> > While at it updated the example node to four spaces and added
> > interrupt-names property.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1- > v2
> > * Dropped RB tags
> > * Added generic compatible string for rzg2ul
> > * Added interrupt-names
> > * Added checks for RZ/G2UL to make sure interrupts are 42 and interrupt-names
> > * Updated example node with interrupt-names
> > * Used 4 spaces for example node
>
> Thanks for the update!
>
> > --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > @@ -19,16 +19,19 @@ description: |
> >      - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
> >        stand-up edge detection interrupts)
> >
> > -allOf:
> > -  - $ref: /schemas/interrupt-controller.yaml#
> > -
> >  properties:
> >    compatible:
> > -    items:
> > -      - enum:
> > -          - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
> > -          - renesas,r9a07g054-irqc    # RZ/V2L
> > -      - const: renesas,rzg2l-irqc
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
> > +              - renesas,r9a07g054-irqc    # RZ/V2L
> > +          - const: renesas,rzg2l-irqc
> > +
> > +      - items:
> > +          - enum:
> > +              - renesas,r9a07g043u-irqc   # RZ/G2UL
> > +          - const: renesas,rzg2ul-irqc
>
> I'm not sure it's worth splitting into RZ/G2L and RZ/G2UL alike
> variants, and adding the "renesas,rzg2ul-irqc" family-specific
> compatible value.  You can easily handle the difference by the presence
> (or absence) of the "bus-err" interrupt source.
>
Yes, the only reason to add "renesas,rzg2ul-irqc" is to differentiate
RZ/Five later. I have not worked out on how this driver will work in
case of RZ/Five yet with PLIC (as we sifive plic driver as a chained
handler and then we have the RISC-V intc driver). If you insist I can
drop it for now and then later when we add RZ/FIve we could add a
check for compat string maybe?

> I understand there "renesas,r9a07g043f-irqc" will be added later to
> support RZ/Five?
>
Yes.

Cheers,
Prabhakar
