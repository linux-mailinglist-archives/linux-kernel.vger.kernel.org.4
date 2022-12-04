Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B564641CA1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 12:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLDL2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 06:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLDL22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:28:28 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098AF164A9;
        Sun,  4 Dec 2022 03:28:27 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id x6so10433370lji.10;
        Sun, 04 Dec 2022 03:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dlASmsVVlIAawOyrYJeITNTPMdDfsPV+VZ2ZrkYJC7Y=;
        b=moPrFkOZYf5LNJBN0/oMqqx4uPpfxMyZw/cl1PiKjfMGljcjqM1c4A0Q10ksxLtO0j
         D8IiGe792U06UA85nItW/E7ItcjQ1/1eBLEvmvEGF7cWElkJZ2tTr8c5eCkm42h79CwJ
         +QaTDchUKzBWtGjmCoYTKgQZnbKe41TKBZ1vzL7Y+hBUuZK7lOHI9osS+l8XLwF6lSoF
         vaOg91FjxV0C4iBDbLZpZpQZJFJuKWhIzfNkFtgs4h9H+rKzTgXfOZY5vjjLsZKsZF30
         cGv5PoRvkSfSpcX0l537JA9r5GekerLZPO11IpErdr6I9lJBlrBi3PewbBEHSfHFyaE2
         q+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlASmsVVlIAawOyrYJeITNTPMdDfsPV+VZ2ZrkYJC7Y=;
        b=Aa05Trbar7y+/dezAm56i52Si1sYLkpjhq4ToWuG6S4SQBOzXbWVHHZO/k2eSQo3UE
         ud9tY81JWdibIEq6m1FXLEzlYscrTqx2wSYaNCwRFt9UHU1fZa8/1YkA4gNuzwykqbsW
         0bF2q5GivTYRkPK1R9uvaM5CVSlzTminDgWT+AmquMv+IOLvZzRzzW5Eiq5APf1I1ONq
         h7BCb6OWf9rAd65yl9rxh1Kbn1nuCGtGrMqkpoSX5hki2jlQMlG3/P3rToxcdqqNrQAr
         p8zNG+l8l6hyDWStjqNZsrYut6zYF6CjfcusLkUEVAqjwxV9VffU0/kOZUdAQW5cbzeK
         qKbg==
X-Gm-Message-State: ANoB5pnIpJu7GgkPPvLs6a2xHygX/rFOEYgyQGWTtOdFs2kZAivQZAPo
        Pym4i2Z8O00sHQ/fc71hkA83xADqxSMIZszEepM=
X-Google-Smtp-Source: AA0mqf67qlul+nzl9WXyoO+z3yIXlr8GwaC1mMyospYAePxhQLm8xslW6KkAghrvhrumIJLs/opwZfWejis3GQtmL9o=
X-Received: by 2002:a2e:a37c:0:b0:26e:93:980d with SMTP id i28-20020a2ea37c000000b0026e0093980dmr26277436ljn.488.1670153305285;
 Sun, 04 Dec 2022 03:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20221130150857.67113-1-tmaimon77@gmail.com> <20221130150857.67113-2-tmaimon77@gmail.com>
 <20221201234954.GA1704219-robh@kernel.org>
In-Reply-To: <20221201234954.GA1704219-robh@kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 4 Dec 2022 13:28:14 +0200
Message-ID: <CAP6Zq1iou=ViB_N+wE_3O6HO7FNEArhebpcbXuBsz4oRxdqXVQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: npcm,sdhci: Document NPCM SDHCI controller
To:     Rob Herring <robh@kernel.org>
Cc:     ulf.hansson@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, adrian.hunter@intel.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, andy.shevchenko@gmail.com,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your comments.

Your comments will be addressed next version.

On Fri, 2 Dec 2022 at 01:49, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 30, 2022 at 05:08:56PM +0200, Tomer Maimon wrote:
> > Add binding for Nuvoton NPCM SDHCI controller.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../devicetree/bindings/mmc/npcm,sdhci.yaml   | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml b/Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
> > new file mode 100644
> > index 000000000000..38409272807a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mmc/npcm,sdhci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NPCM SDHCI Controller
> > +
> > +maintainers:
> > +  - Tomer Maimon <tmaimon77@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nuvoton,npcm750-sdhci
> > +      - nuvoton,npcm845-sdhci
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +patternProperties:
> > +  "^sdhci@[0-9a-f]+$":
> > +    type: object
>
> sdhci is a child node of the nuvoton,npcm750-sdhci node?
No, will be removed
>
> > +    $ref: mmc-controller.yaml
>
> I think you want:
>
> allOf:
>   - $ref: mmc-controller.yaml#
>
> And then you will have some errors in the example to fix.
>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    sdhci0: sdhci@f0840000 {
>
> Drop unused labels.
>
> Node name should be 'mmc'
>
> > +      compatible = "nuvoton,npcm750-sdhci";
>
> Indent by 4 spaces.
>
> > +      reg = <0xf0840000 0x200>;
> > +      interrupts = <0 27 4>;
> > +      clocks = <&clk 4>;
> > +    };
> > --
> > 2.33.0
> >
> >

Best regards,

Tomer
