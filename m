Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9AA7229FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjFEO42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjFEO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:56:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DC4A7;
        Mon,  5 Jun 2023 07:56:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-653bed78635so1874972b3a.0;
        Mon, 05 Jun 2023 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685976985; x=1688568985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T6MJIwP6Qz41YN9JsUH44j/uT7BYaMY9w+C9sGj/uYc=;
        b=n0R6S5Pz/FUIVP6ytcw6xK8yCjSt5iCNR2Hy+2f+yMaV/QywwTJ94CYe9YVXvashMS
         Gurmudikv/rGA1FvM1U1yl6z4Y7GWJ+CCY2jUJ6Xt3oh1fu46XGh8gZgMNDV7U8ulA0v
         q8nDnfnBWwqzCa6BEEvG07v9R8Pott2fFPvO6YYVZA0r/6Ob72ymvh0y9hBH4HN3FYns
         AtPHWbIZr3QluXo274sl3KBvFjUb25OJQ2wkg7BXV31pN/wbiDVX+qIJDd192c2gAWxj
         kG5aL2equYVmpaGk4/vy1+yk+0yaADn+LjnMqvrJ30NiAAL188rXvIa5kuFtF/bQ7RWT
         n2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685976985; x=1688568985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6MJIwP6Qz41YN9JsUH44j/uT7BYaMY9w+C9sGj/uYc=;
        b=HZvsnBC/GRO5iVrWu2U+WsG+fzh4kOJQtJp+tzBf/6sS5qXBTDVswMazd4sQ/iewvI
         mOWV1Eplp/8g7Uo0g0hm0kZl3FG0FGpeY8iIns3Q+glvVQ4aa2/bbOGjMT0qG+GCtwiz
         QPRhUYHpAeFjzRZFC4NLDPBDoc3gfs+PeK3yTy68ZdEF/9bfcRI15jtc+sQWbhgRLRn5
         kBGstHxVgJPmYv7Y9mEuUMYd66su1Vsghnd66Pnhc/R2u9GhPR+t4WSIU8WKz6aKXKZr
         xJazMUeRbkhgiwSXaU5FAMi/YvilkQBcehX3d7YpiPXkgdxAACsrVtqq+RRgimngpFKP
         zEXA==
X-Gm-Message-State: AC+VfDwdCtK7YD02OfEP7rKHToobyN9YMWTjeSpkb0AMXkaPuch3LqtK
        tbc9fCVXbXjeNF6jKOxcNSgTyh4VgxjNwqNQu1kcnZr6crK2EBmU
X-Google-Smtp-Source: ACHHUZ6ELOU/gnEBfytvNDunlQ/WFvt5DfZeMzBsW5V77h1qMFRnFTZVm+SvCKe9kvX5TcXwkThMMzJd9XOK5y64DfU=
X-Received: by 2002:a17:902:da81:b0:1ae:35b8:d5ae with SMTP id
 j1-20020a170902da8100b001ae35b8d5aemr9400904plx.19.1685976984850; Mon, 05 Jun
 2023 07:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230519142456.2588145-1-pavacic.p@gmail.com> <20230519142456.2588145-2-pavacic.p@gmail.com>
 <20230519-emerald-void-066fad80950a@spud> <CAO9szn2sYRezCUQKFZ_qsVfne0gpWoirZoE-HpWTPS4G1U5fNQ@mail.gmail.com>
 <20230605-handyman-rebound-0c10df9dfaf2@spud>
In-Reply-To: <20230605-handyman-rebound-0c10df9dfaf2@spud>
From:   Paulo Pavacic <pavacic.p@gmail.com>
Date:   Mon, 5 Jun 2023 16:56:13 +0200
Message-ID: <CAO9szn0crQzy0L2Y-NZGKEVbpspxZMkO0oPpYr1WMS081ZxKRw@mail.gmail.com>
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

pon, 5. lip 2023. u 16:43 Conor Dooley <conor@kernel.org> napisao je:
>
> On Mon, Jun 05, 2023 at 04:33:15PM +0200, Paulo Pavacic wrote:
> > Hello Conor,
> >
> > pet, 19. svi 2023. u 18:41 Conor Dooley <conor@kernel.org> napisao je:
> > >
> > > Hey Paulo,
> > >
> > > On Fri, May 19, 2023 at 04:24:55PM +0200, Paulo Pavacic wrote:
> > > >
> > > > Added fannal to vendor-prefixes and dt bindings for Fannal C3004.
> > > > Fannal C3004 is a 480x800 MIPI DSI Panel which requires
> > > > DCS initialization sequences with certain delays between certain
> > > > commands.
> > > >
> > > > Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
> > > > ---
> > > > v3 changelog:
> > > >   - renamed yml file
> > > >   - refactored yml file to describe fannal,c3004
> > > >   - added matrix URI to MAINTAINERS
> > > > v2 changelog:
> > > >   - revised driver title, now describes purpose
> > > >   - revised description, now describes hw
> > > >   - revised maintainers, now has only 1 mail
> > > >   - removed diacritics from commit/commit author
> > > >   - properties/compatible is now enum
> > > >   - compatible using only lowercase
> > > >   - revised dts example
> > > >   - modified MAINTAINERS in this commit (instead of driver commit)
> > > >   - dt_bindings_check checked yml
> > > >   - checkpatch warning fixed
> > > > ---
> > > >  .../bindings/display/panel/fannal,c3004.yaml  | 75 +++++++++++++++++++
> > > >  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> > > >  MAINTAINERS                                   |  6 ++
> > > >  3 files changed, 83 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml b/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
> > > > new file mode 100644
> > > > index 000000000000..a86b5ce02aa2
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
> > > > @@ -0,0 +1,75 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/display/panel/fannal,c3004.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Fannal C3004 MIPI-DSI
> > > > +
> > > > +maintainers:
> > > > +  - Paulo Pavacic <pavacic.p@gmail.com>
> > > > +
> > > > +description: |
> > > > +  Fannal C3004 is a 480x800 panel which requires DSI DCS
> > > > +  initialization sequences.
> > > > +
> > > > +allOf:
> > > > +  - $ref: panel-common.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - const: fannal,c3004
> > > > +
> > > > +  reg: true
> > >
> > > Are there no restrictions on the number of reg entries?
> >
> > What do you mean by this? May I have some example if possible?
>
> I was commenting on the lack of minItems and/or maxItems.

Sorry this is my first patch, I still don't understand, why should I
add `maxItems: 1` to the 'reg:' ?
Isn't  part of the code:
> required:
>  - compatible
>  - reg
>  - reset-gpios

making `minItems: 1` redundant for reg properties?

>
> Cheers,
> Conor.

Thanks,
Paulo
