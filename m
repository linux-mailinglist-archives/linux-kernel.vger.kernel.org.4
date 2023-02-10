Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A1691E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjBJLXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjBJLXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:23:00 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C6A6C7E5;
        Fri, 10 Feb 2023 03:22:58 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id bi19so4172236oib.2;
        Fri, 10 Feb 2023 03:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ounKjkeQatmirQO+fk8XQX135Rzi9nX3toceUVHS3b4=;
        b=WjaytSD8m+QiS0dpp4i8nbbPgKfHeAfk6+gGP6DcVOpHAq6JAw/wMeHOaPSwoGqpzF
         e3G8U+dwH6eEBKm086xDFrUsbdWTAlz0jjKswOuDth2dDPluC4miYWkGhxbEGtKT/ehk
         IxAW7MKMCpIyLUgFJUaGolxIgD5/XPvy+bPaOYZehYRF8GJYKo5xe9iL39Kn1rINX2Fy
         qgOCyL9CwF0QsgFCjJ8KwyB8KtA+HzoRLEhNH3MKHLykB7ldYb834thCxOe0FekLvcgL
         b+z2IClAXy1uk3CMruGipLR51CiTZGEWnh9i6BlHM1xU4tcjhm3xY4VaMj7uJscBV1cT
         nrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ounKjkeQatmirQO+fk8XQX135Rzi9nX3toceUVHS3b4=;
        b=eZ6hqMX2g6eAPeTt1da5nH78HJeNGrnK5i/Tb1J2NNBtWUP0FrEfFxNjBuzdscRzl/
         E6uAyfiVLiz1DRF77FCLk2t07No/1/k8SYSsotuyPfDcG7BdZJVT/Ywlu2oi7YVGCR6R
         EoyvzGAk6R05d+ZkL+JcIkpZmSeQIHhJWM0Kcy0d3mq8z25Zn/TgusLDEeNSMO/i4UWX
         qi7BSaYIquZZhVn1hqDXQyJgbmmE76Qkc8I9wGfLND6U+YB+ykO0go/mlcSwCkOtUywG
         qB/f2QRIiYxCl+7hhFZSsEtE0dpyohxXrtPR0i0fPFZpfGVlueDJq72ypvugtCt+0YBy
         R7Pw==
X-Gm-Message-State: AO0yUKVsuJSyLLRz9wHdKsV8icij/57VFDjHHisdi+xZI1FU/vg4fO6x
        0n2121g3NQPf6r9hL0jR4xoqexsIsulNtQs5V7mTnc4PX0k=
X-Google-Smtp-Source: AK7set/CWf5NHvdoqJVvEbZn94gGxaIBiabGDZNIKyZ7lj4U8WmOfabH4qIktQPEYHZjH7cxd6xi2DIb+7CpSG5bkK8=
X-Received: by 2002:a05:6808:60d:b0:37b:7c36:4df8 with SMTP id
 y13-20020a056808060d00b0037b7c364df8mr932486oih.144.1676028177884; Fri, 10
 Feb 2023 03:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20230210065621.598120-1-sergio.paracuellos@gmail.com>
 <20230210065621.598120-2-sergio.paracuellos@gmail.com> <a0a141ef-b5ab-f84a-9a77-7b6d1f54ccc9@linaro.org>
In-Reply-To: <a0a141ef-b5ab-f84a-9a77-7b6d1f54ccc9@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 10 Feb 2023 12:22:46 +0100
Message-ID: <CAMhs-H-w3O_Yjo7CcGdXyw0bSeqefR32Oj4hhQWsVVWoThNLyA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
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

Hi Krzysztof,

On Fri, Feb 10, 2023 at 11:59 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/02/2023 07:56, Sergio Paracuellos wrote:
> > MT7621 SoC provides a system controller node for accessing to some registers.
> > Add a phandle to this node to avoid using MIPS related arch operations and
>
> I don't understand this part. You claim you add a phandle to this node,
> but your binding suggest you add here a phandle to other node.

Probably my English is not the best here :-). Yes, you are right, I
just want to add a phandle to the 'sysc' node in the current node.

>
> > includes in watchdog driver code.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  .../bindings/watchdog/mediatek,mt7621-wdt.yaml       | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> > index b2b17fdf4..3c545065f 100644
> > --- a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> > @@ -14,11 +14,18 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    const: mediatek,mt7621-wdt
> > +    items:
> > +      - const: mediatek,mt7621-wdt
> > +      - const: syscon
> >
> >    reg:
> >      maxItems: 1
> >
> > +  ralink,sysctl:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      phandle of syscon used to control system registers
>
> This needs to be more specific - which syscon? It also does not fit your
> commit msg.

Sure. How about "phandle to system controller 'sysc' syscon node which
controls system registers".

>
>
> Best regards,
> Krzysztof
>

Thanks,
    Sergio Paracuellos
