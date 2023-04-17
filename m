Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99086E4FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjDQSJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDQSJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:09:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8723610D;
        Mon, 17 Apr 2023 11:09:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w11so26648437plp.13;
        Mon, 17 Apr 2023 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681754975; x=1684346975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNOsIQtquipVLHz8/RMsd7IDhOh5uaDhFa5Mb/HyQyI=;
        b=K8lNZwCWAi69HuM8H5CpvXsO6JRXmF5bjsuJP4MBlqphQkWtHN5yPJgRPvhr11jBXv
         LCQ0XiBOvyWy5lLY6PjcNjovVPe+8B2Xe6pkEDe9wlD21biLd8qxrncpDxkEIV44w5qR
         Ll4g6NjbGABIuFK/2Aw4ZznxTV0HFr+kVqNBw9EFhOoDtcHJM7NTh30TWF/sisZla8kF
         MQTOLmHoxRj+FjiTizTWKLFVOZQj3LDIfwVmudGbeC1nQ+WoQobnPHtXS9WpjP9eXdJr
         TGBAsd6GCk/fy/X1ifvZpV4YZThGoaWGGJpyGQvb1oj2JnhKcLHjtGVuNJwdQBRLkbl4
         ZCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681754975; x=1684346975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNOsIQtquipVLHz8/RMsd7IDhOh5uaDhFa5Mb/HyQyI=;
        b=iewYxCK2EGK7aCjUa8MAUILzojjEGvoQDYZzkXto+kSuvt8+xMeHh2PWh+KyclJWUM
         VOULx4R7y6VMnByBgAvsoVVsvNQ8zDSR6xp3ynHbClTzWiA7jCpGuonAs8YkcChV7h8f
         A9Q0ZnfdQobIg3aVjO5xR+HR0+ilceq0WHyPmFLZmhX5iIJyFcEFThmlJGiaXa2GiL6K
         Ibk/s2/E3BmewuiJsRcBQ79T6oVCJAAc1O7oMiT/cfSDMtqWZybgWlR1vaueCGjPXsPX
         qm+GPI0ZdmgrQo3cBj4/CFfBShHf8QyZZwV5yhUAsm0uuTOvlxwisblVFGbwE8SxEcYn
         EEeg==
X-Gm-Message-State: AAQBX9cPN2GCRclL0p4WgcHTM7HT7MtfW7RGSh/hdqCVV8g7Eb4Wstvd
        32bLcqZwSy6R5aIqntOmElLdPMxlTvtuJ+X8bUw=
X-Google-Smtp-Source: AKy350ZcGwtvc9bc5OmV986re8jTS7t6yf3evE/VHZhrKbmPQSK20zQKGda3a6I2bSv/pHSjitN9vGPX2QJ/+41y0BM=
X-Received: by 2002:a17:902:ea05:b0:19a:64f6:e147 with SMTP id
 s5-20020a170902ea0500b0019a64f6e147mr4400040plg.2.1681754974933; Mon, 17 Apr
 2023 11:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230416173302.1185683-1-mmyangfl@gmail.com> <20230416173302.1185683-2-mmyangfl@gmail.com>
 <c6571a6d-bf55-14b3-102d-814af6763be7@linaro.org>
In-Reply-To: <c6571a6d-bf55-14b3-102d-814af6763be7@linaro.org>
From:   Yangfl <mmyangfl@gmail.com>
Date:   Tue, 18 Apr 2023 02:08:58 +0800
Message-ID: <CAAXyoMNKDFBnJbT0XX2LWtwDPiePjqhJ4n--cb+SDDBSmPZ_WQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: Add simple-clock-controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2023=E5=B9=B4=
4=E6=9C=8817=E6=97=A5=E5=91=A8=E4=B8=80 01:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On 16/04/2023 19:32, David Yang wrote:
> > Add DT bindings documentation for simple-clock-controller, mutex
> > controller for clocks.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >  .../clock/simple-clock-controller.yaml        | 50 +++++++++++++++++++
>
> Where is the changelog?
>

Cover now send with v3.

> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/simple-cloc=
k-controller.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/simple-clock-contr=
oller.yaml b/Documentation/devicetree/bindings/clock/simple-clock-controlle=
r.yaml
> > new file mode 100644
> > index 000000000000..17835aeddb1d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/simple-clock-controller.y=
aml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/simple-clock-controller.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Simple clock controller
> > +
> > +maintainers:
> > +  - David Yang <mmyangfl@gmail.com>
> > +
> > +description: |
> > +  Driver (lock provider) for real clocks.
>
> Drop driver references. Typo: clock, not lock.
>
> What is a real clock? What is an unreal clock?
>

Rewrite description in v3. The controller is kinda unreal since it
does not require any operation to "enable" the controller, but such
description is avoided in v3.

> > +
> > +  Usually one register controls more than one clocks. This controller =
avoids
> > +  write conflicts by imposing a write lock, so that two operations on =
the same
> > +  register will not happen at the same time.
>
> Interesting. How the clock controller imposes write locks? Aren't you
> now mixing drivers and hardware?

Avoided driver details in device description in v3.

>
>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - oneOf:
> > +          - const: simple-clock-controller
> > +          - const: simple-clock-reset-controller
>
> Why two?

It may also handle reset requests. But removed in v3 for further considerat=
ion.

>
> > +      - const: syscon
> > +      - const: simple-mfd
>
> Why do you need syscon and simple-mfd?

Kinda typo. Removed in v3.

>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#reset-cells':
> > +    const: 2
> > +
> > +patternProperties:
> > +  "clock@.*":
>
> Use consistent quotes.

Fixed in v3.

>
> Anyway, I don't understand what is happening here and why such changes.
> Nothing is explained...
>
>
> Best regards,
> Krzysztof
>
