Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBA36611A8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 21:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjAGUog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 15:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjAGUo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 15:44:27 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E5A3DBC2;
        Sat,  7 Jan 2023 12:44:26 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id p12so2390038qkm.0;
        Sat, 07 Jan 2023 12:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v91NOW33Yw4ld/8hrWNvp88PBg4HhV/z+jC8/6Hxg/g=;
        b=fZ54oarpBPjAErlsUXRhoViKjxS+Cn/Z4UkwKhEcRGsQDW4RJIJGXfbAoqE2KMfT5Z
         mtzUWGbDpzL+U2fJAyQ2Bc5Ccei++KTSWP4KT2QaNJWASRx9wjAjBuNsppuntANxPDE5
         EBGIcqdIoSm3nvswcInG0XGOIAG/LpLwfpYjM0PKqfMVyBbegDMMI2EsM7YRWsr8PYB0
         bt9AxzZ3WSvpTveM6PESRVHeCr6l83+hi0j7+0vyjo7U9JiX3VmUHpBErsd/rI37PUSc
         vTP8BDwvD6Fq8izxU3I0okzgZLMeFfe9VLSubS+S/xXzegRG4FuY4VtCFEzJfJc2Zi0g
         Q8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v91NOW33Yw4ld/8hrWNvp88PBg4HhV/z+jC8/6Hxg/g=;
        b=aoeBTqT87Pbj7BYSIWZmaVwPrVMHZD6wvBuxUrxTzacWmj0MkhUy5mQtuauq3MhmBY
         z4d1KKom3n2B942YhEbMT7oo07jYR8P93ovnr1+8Z51YY03p//PtLgBIzDp69thzuRN0
         RjY52j+CjJJBLJe7CoL/CFH992X9fH75Hyg/euaF7NKsctbKwrgtk6XBkrlZR4803/Z1
         OhTLaLQjwbsVC9Yt4ulmhhYlXlQg0neyTmFMj3nx6RkMrzeC7LCQgF46RgjEFVj3DQ+9
         9/kRxsLB1D9i3/JHaGxKNKnyuf8Xmr49mLk0/tDKZLpi5emcitNF1u+ENDmgFmRlzfNL
         nlSg==
X-Gm-Message-State: AFqh2kpVAUzHyk2sv+9cKnOALkfWt2bQMqYYYbPb0B+pHvbzKr7eQ1wh
        ioWz1lrbnvlhNRl2MvDzdbO+E9TutkZDJglmosDyH5ZFkSUFIg==
X-Google-Smtp-Source: AMrXdXueMgeOelADEFUHqX0SiYMVBoF5mWwpL5jyMWhIhE/iVeSWmNE99SCl+Gxh0Q60C5zbuPWE2aryRDkuCqQ+oa0=
X-Received: by 2002:a37:38f:0:b0:6ff:b5c2:9c88 with SMTP id
 137-20020a37038f000000b006ffb5c29c88mr2926548qkd.575.1673124265987; Sat, 07
 Jan 2023 12:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y7iYZqKcoRycsoTg@spud>
In-Reply-To: <Y7iYZqKcoRycsoTg@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 7 Jan 2023 20:43:59 +0000
Message-ID: <CA+V-a8uBDx42o12UUwP=bBjeGzJJSP=jPcQr0xgkvkkoA7_vFA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
To:     Conor Dooley <conor@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh@kernel.org>
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

Hi Conor,

Thank you for the review.

On Fri, Jan 6, 2023 at 9:53 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Jan 06, 2023 at 06:55:24PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> >
> > The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> > Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> > describes the L2 cache block.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > v5 -> v6
> > * Included RB tag from Geert
>
> I think not!
>
Sorry that was a typo. I meant Rob  :)

> > v4 -> v5
> > * Dropped L2 cache configuration properties
> > * Dropped PMA configuration properties
> > * Ordered the required list to match the properties list
> >
> > RFC v3 -> v4
> > * Dropped l2 cache configuration parameters
> > * s/larger/large
> > * Added minItems/maxItems for andestech,pma-regions
> > ---
> >  .../cache/andestech,ax45mp-cache.yaml         | 81 +++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> > new file mode 100644
> > index 000000000000..9f0be4835ad7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2022 Renesas Electronics Corp.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/cache/andestech,ax45mp-cache.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Andestech AX45MP L2 Cache Controller
> > +
> > +maintainers:
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +
> > +description:
> > +  A level-2 cache (L2C) is used to improve the system performance by providing
> > +  a large amount of cache line entries and reasonable access delays. The L2C
> > +  is shared between cores, and a non-inclusive non-exclusive policy is used.
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - andestech,ax45mp-cache
> > +
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: andestech,ax45mp-cache
> > +      - const: cache
>
> You might find value in a specific compatible for your SoC & enforce
> constraints for it. Or you might not & I don't care either way :)
>
Good point actually. Geert what do you think?

Cheers,
Prabhakar
