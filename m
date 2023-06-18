Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2808E734748
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 19:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjFRRjf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 18 Jun 2023 13:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFRRjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 13:39:31 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B961B5;
        Sun, 18 Jun 2023 10:39:30 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-57045429f76so30952537b3.0;
        Sun, 18 Jun 2023 10:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687109969; x=1689701969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6cwyhtXgWV8QHFMzUCKjIBrAmoEHpsYP4sSAmGvJDK0=;
        b=V45Ae/yv0Nt7g5pVPRhvlNpx0zyFY7pccXwXud3wFO2rirDGI/KjVlc4gyKgOLJfTZ
         S2gV1xm8zwrVLWV57unc1VL3J6mqUrWCcMWqn3TLA4qSiVFGH2pD0v2FyKn8FtMn44ze
         v0gY3Ds95QpN1SA5C8ER7CpT2qXGNownJtza9VzUZACorpWwuxGU20CavSZU/qQHtbdW
         j4APxnjEMQDetY+wp2WTW6f0rrOHFbYiOq5mdxJtZBvUKiCdm2W4xXnTSFFhQibGh3Py
         G7grwOS9QTd8aoNy4gnjZlV7NJH5ZBHYaA7lDI8Oy7R9zK0TpaYNA97nOlAdso4WwHU+
         DBIA==
X-Gm-Message-State: AC+VfDzOdzhFdOUPxih3hW/muazz+sYom3RbgT5Oz6hkIo9CoCVL+EFC
        iu46gQFD5rB2HKslIqUIGlDzq82dmNiTYAr0
X-Google-Smtp-Source: ACHHUZ7lXTeeNNzOVe8bZkVoAAltNYIKAbNhNweTa63SnpSCmWbKGk/YUu6CigHswESAdBRzCiOhKQ==
X-Received: by 2002:a81:7206:0:b0:570:209a:a4fe with SMTP id n6-20020a817206000000b00570209aa4femr7695264ywc.32.1687109969156;
        Sun, 18 Jun 2023 10:39:29 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id v20-20020a814814000000b00570336e2729sm2101366ywa.24.2023.06.18.10.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 10:39:28 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-57045429f76so30952317b3.0;
        Sun, 18 Jun 2023 10:39:28 -0700 (PDT)
X-Received: by 2002:a25:d791:0:b0:bc4:78ac:9216 with SMTP id
 o139-20020a25d791000000b00bc478ac9216mr4665462ybg.61.1687109968456; Sun, 18
 Jun 2023 10:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230615182938.18487-1-tanure@linux.com> <20230615182938.18487-3-tanure@linux.com>
 <20230615-capable-implicit-90a8f0265616@spud>
In-Reply-To: <20230615-capable-implicit-90a8f0265616@spud>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Sun, 18 Jun 2023 18:39:17 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2Gm6mr_2cbhCh7a_bOw09W2PBxyOAvasGCrPTdcruczQ@mail.gmail.com>
Message-ID: <CAJX_Q+2Gm6mr_2cbhCh7a_bOw09W2PBxyOAvasGCrPTdcruczQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: clock: Bindings for Meson T7 clock controller
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

On Thu, Jun 15, 2023 at 10:41 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Lucas,
>
> On Thu, Jun 15, 2023 at 07:29:34PM +0100, Lucas Tanure wrote:
> > Add documentation for T7 the clock controller.
>
> Other than the bot's complaint, few comments for ya.
>
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> >  .../bindings/clock/amlogic,mesont7.yaml       |  69 +++
> >  include/dt-bindings/clock/mesont7-clkc.h      | 487 ++++++++++++++++++
> >  2 files changed, 556 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml
> >  create mode 100644 include/dt-bindings/clock/mesont7-clkc.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml b/Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml
> > new file mode 100644
> > index 000000000000..18e7cca0c0e1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml
>
> The filename should match the compatible - please test the bindings,
> dt_binding_check will complain.
>
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/amlogic,mesont7-clk.yaml#
>
> and this should match the filename
>
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Amlogic Meson T7 Clock Controller
> > +
> > +maintainers:
> > +  - Lucas Tanure <tanure@linux.com>
> > +
> > +description: |
> > +  The Amlogic Meson T7 clock controller generates and supplies clock to
> > +  various peripherals within the SoC.
> > +
> > +  This binding uses common clock bindings
> > +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>
> This doesn't add anything as you're adding a yaml binding. I'd drop it
> (and the | from description: since you would no longer have formatting
> to preserve).
>
> > +
> > +properties:
> > +  compatible:
> > +    const: amlogic,t7-clkc
> > +
> > +  reg:
> > +    items:
> > +      - description: basic registers
>
> What does "basic registers" mean? I think you should be more specific in
> your description.
>
> > +      - description: pll registers
> > +      - description: cpu_clk registers
> > +
> > +  reg-names:
> > +    items:
> > +      - const: basic
> > +      - const: pll
> > +      - const: cpu_clk
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: xtal
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - clocks
> > +  - clock-names
> > +  - '#clock-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  # Clock controller node:
> > +  - |
> > +    clkc: clock-controller {
>
> The comment above and the node name here can be dropped.
> You do however need to change "clock-controller" to
> "clock-controller@<addr>".
>
> > +        compatible = "amlogic,t7-clkc";
> > +        #clock-cells = <1>;
> > +        reg = <0x0 0x0000 0x00 0x49c>,
> > +              <0x0 0x8000 0x00 0x320>,
> > +              <0x0 0xe040 0x00 0x0bc>;
>
> Drop the 0x0 stuff from here.
>
> > +        reg-names = "basic", "pll", "cpu_clk";
> > +        clocks = <&xtal>;
> > +        clock-names = "xtal";
> > +        status = "okay";
>
> status can be dropped, okay is the default.
>
> Cheers,
> Conor.
>
I will drop this patch for now, wait for the S4 clock driver to be
upstreamed, and use that as a base.
