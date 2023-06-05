Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187A67228DE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjFEOdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjFEOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:33:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F72699;
        Mon,  5 Jun 2023 07:33:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-256531ad335so3977467a91.0;
        Mon, 05 Jun 2023 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685975607; x=1688567607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ekP3RhJtUZILk2qnuNRNNeEbC6C5GUUQiR4tbiK5e/o=;
        b=X3va0yxh/FrQ52jqdKXXif81V9LGWorsC1qdWDnfSYKNHlmZGcMdRTyd781ze267V1
         b/sLmA1sflcIDskKH6/XvxBDGnFXsbpfTScg4OIHsWhZ1Y/rUjZQPhJpHqjvOoVLNrXX
         0/lg3XY/B/uYlD4PAvr3KMSLhv7B68p4zBQfxHYN9BG2C8YfsQ/w8TzzWw9zZzr0chy0
         UiggQTvB4R6k9HsLm2yuPS/g0+bKxzQqYRbNb8oI+C1t8VoZYOmsJ1dnv/vQyDWMFiVx
         6cNY3s9Yxis92L+W1ytpVroASmeDo8LswaxjHD94LUUFHKvoj6ta5NdVdRR368gLcAT7
         Xc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975607; x=1688567607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekP3RhJtUZILk2qnuNRNNeEbC6C5GUUQiR4tbiK5e/o=;
        b=DDesCiH2fQpfOEji7+uf/OiLaNfDW6XPCgkoMwG5doR3JSyucP1keKkdhC3FJbvnA0
         sI0qfgO4ozAQR1+tGXCCeUujCUwuS1n+YP1jtZPTfmDUaSVpmlTtbmU5/9BnsqtoIfSU
         c+B09x1DG43qdzLvxAL+L6KHNd6j06P+bvXbSXQS15xuQWBJFPgdzdQ/7iAPYkZfhxxL
         enVRCC/W/qZtMDc6wfHtXO2mr5hXH8MwfJbXhYFDtd08fSRAL/GdjeyfOUZEzBRMuLeM
         BO8dm3o9L4DsACM+Ipue2NdtkzgfMyezd/tFhrtXI4efb8+uvMLsf9JFcnHHjvesfRia
         lfHg==
X-Gm-Message-State: AC+VfDxZASbcqXN0yxy4zzOVXYDOV58XAg1LstZxEletfXoZQLC7EF8X
        kYb/3eaY34RC5cBcUufTr3rMO2QzNVPp44jaIWxTtj0TvhY/sg==
X-Google-Smtp-Source: ACHHUZ65GdG7b2lW9VigsylmFjnc6G6O2l/ottmoAQR9ATxdr1w08mprQ4VyjxXYojieL+qszn4CV6mu7ULBLjOZIaQ=
X-Received: by 2002:a17:90b:ed8:b0:250:2311:1535 with SMTP id
 gz24-20020a17090b0ed800b0025023111535mr6790908pjb.24.1685975606758; Mon, 05
 Jun 2023 07:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230519142456.2588145-1-pavacic.p@gmail.com> <20230519142456.2588145-2-pavacic.p@gmail.com>
 <20230519-emerald-void-066fad80950a@spud>
In-Reply-To: <20230519-emerald-void-066fad80950a@spud>
From:   Paulo Pavacic <pavacic.p@gmail.com>
Date:   Mon, 5 Jun 2023 16:33:15 +0200
Message-ID: <CAO9szn2sYRezCUQKFZ_qsVfne0gpWoirZoE-HpWTPS4G1U5fNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add fannal,c3004
To:     Conor Dooley <conor@kernel.org>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Conor,

pet, 19. svi 2023. u 18:41 Conor Dooley <conor@kernel.org> napisao je:
>
> Hey Paulo,
>
> On Fri, May 19, 2023 at 04:24:55PM +0200, Paulo Pavacic wrote:
> >
> > Added fannal to vendor-prefixes and dt bindings for Fannal C3004.
> > Fannal C3004 is a 480x800 MIPI DSI Panel which requires
> > DCS initialization sequences with certain delays between certain
> > commands.
> >
> > Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
> > ---
> > v3 changelog:
> >   - renamed yml file
> >   - refactored yml file to describe fannal,c3004
> >   - added matrix URI to MAINTAINERS
> > v2 changelog:
> >   - revised driver title, now describes purpose
> >   - revised description, now describes hw
> >   - revised maintainers, now has only 1 mail
> >   - removed diacritics from commit/commit author
> >   - properties/compatible is now enum
> >   - compatible using only lowercase
> >   - revised dts example
> >   - modified MAINTAINERS in this commit (instead of driver commit)
> >   - dt_bindings_check checked yml
> >   - checkpatch warning fixed
> > ---
> >  .../bindings/display/panel/fannal,c3004.yaml  | 75 +++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> >  MAINTAINERS                                   |  6 ++
> >  3 files changed, 83 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml b/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
> > new file mode 100644
> > index 000000000000..a86b5ce02aa2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/fannal,c3004.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Fannal C3004 MIPI-DSI
> > +
> > +maintainers:
> > +  - Paulo Pavacic <pavacic.p@gmail.com>
> > +
> > +description: |
> > +  Fannal C3004 is a 480x800 panel which requires DSI DCS
> > +  initialization sequences.
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: fannal,c3004
> > +
> > +  reg: true
>
> Are there no restrictions on the number of reg entries?

What do you mean by this? May I have some example if possible?

>
> > +  reset-gpios: true
>
> Can you put a blank line between properties please?
>
> > +
> > +  vdd-supply:
> > +    description: power supply voltage
> > +  vddio-supply:
> > +    description: power supply voltage for IO
> > +
> > +  width-mm:
> > +    description: physical panel width [mm]
> > +  height-mm:
> > +    description: physical panel height [mm]
>
> Here and for the supplies too.
>
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 82d39ab0231b..f962750f630a 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -462,6 +462,8 @@ patternProperties:
> >      description: Facebook
> >    "^fairphone,.*":
> >      description: Fairphone B.V.
> > +  "^fannal,.*":
> > +    description: Fannal Electronics Co., Ltd
>
> This needs to be split into a commit of its own.
>
> Thanks,
> Conor.
>
> >    "^faraday,.*":
> >      description: Faraday Technology Corporation
> >    "^fastrax,.*":
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5c22c828ab46..62374c8424b9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6427,6 +6427,12 @@ T:     git git://anongit.freedesktop.org/drm/drm-misc
> >  F:   Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
> >  F:   drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> >
> > +DRM DRIVER FOR FANNAL C3004373132019A
> > +M:   Paulo Pavacic <pavacic.p@gmail.com>
> > +S:   Maintained
> > +C:   matrix:r/mipi-dsi-bringup:matrix.org
> > +F:   Documentation/devicetree/bindings/display/panel/panel-fannal,c3004.yaml
> > +
> >  DRM DRIVER FOR FARADAY TVE200 TV ENCODER
> >  M:   Linus Walleij <linus.walleij@linaro.org>
> >  S:   Maintained
> > --
> > 2.40.1
> >

Thanks,
Paulo
