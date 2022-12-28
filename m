Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BC66575A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiL1LJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiL1LJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:09:31 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F7021F;
        Wed, 28 Dec 2022 03:09:29 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id d185so15248370vsd.0;
        Wed, 28 Dec 2022 03:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1CvxPRIDVT1nlOHFUSTb+riWEiFvrCUY5v0nfrRaE1U=;
        b=HMXFlEf+CZ4SixDofP0Wxuev/ISinqvAGBy2hHxXrEu7zJVWbKrEfHBbmeAkRxcYvP
         3nZzJt1ScaZzBLTK5jXqw6h5AlwjNiZfgEYLy17+YDLYKlvgSyYv8E0173Wr/CnsI91D
         gqeNqGe59TqYzrWJoigg10uuJO5HQqjqGM2x+4Rcsn4lxf3gDtcMSkEi3ups0+g3FYQV
         1oB5y4Da1jdQUtasLoQXEBZ8e/ldIHfecxdwbXhG3+pY2krptsej+802I9fKl7NKSmli
         c8Lw2Rm6TASSBu1K9DQzY2DAxKRzU6E0IhOpRg4DrgrmXzhccP/hLj+p+lU2P16PQwD1
         jEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CvxPRIDVT1nlOHFUSTb+riWEiFvrCUY5v0nfrRaE1U=;
        b=v7QsZ9AMVf3z8c+PDLrh/Xj59ssqRTLQD3/vT/GZojlshr0PNG5CszQFfOyRig14Yz
         w/BUy71zLDSbPcMpmbwwHDZWtZC5Xm08TQ3A3dR2XzWcwZn+hp9wexRLDdV1sxa1woDr
         9trZYvSAKjqp6T6VGbnfgT2UxMDJz4y94rs9gMe6fEsfrrDEzPbF8tFgB/H2SL+RHniP
         6NIPIXqG8vV0FDGVkWIK7uGLUF39kPsmVIQMslerz4h9+b9mq326fFIAgehbFqOynAqW
         LU3xBTEVgb9wd4PAxk3EcBQWwt9xQUtOsf01vqljUaA0SwwVlIj08PsIwpaFdwqKUWaP
         lpuw==
X-Gm-Message-State: AFqh2kq0APG+fpTQigKYbVUAHR7ixQCEMB0dh3NZexErpIHQxqRS59/E
        XWgu3lIegxXeYT3WLAfPUthrFg7B0Qo9JXLKxN8=
X-Google-Smtp-Source: AMrXdXuXc0bJ2Iae/CwTiyA+ZMoJb28nQikQvULssdkmceYo23LWBl6lxh2qfJufFz3h9ArkNk9Y3oyFve8Yn/ktVoA=
X-Received: by 2002:a67:fb07:0:b0:3c9:35c8:e6a with SMTP id
 d7-20020a67fb07000000b003c935c80e6amr809992vsr.63.1672225769058; Wed, 28 Dec
 2022 03:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-9-linux.amoon@gmail.com>
 <Y6wiWIH5S3jJnkai@hovoldconsulting.com>
In-Reply-To: <Y6wiWIH5S3jJnkai@hovoldconsulting.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 28 Dec 2022 16:39:12 +0530
Message-ID: <CANAwSgT5D-8S7MkDXruztck6S6vjsrPDqbGg=k1=iYW5Bm_yPg@mail.gmail.com>
Subject: Re: [PATCH v1 08/11] dt-bindings: usb: Add binding for Via lab
 VL817Q7 hub controller
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Johan

Thanks for your review comments.

On Wed, 28 Dec 2022 at 16:32, Johan Hovold <johan@kernel.org> wrote:
>
> On Wed, Dec 28, 2022 at 10:03:17AM +0000, Anand Moon wrote:
> > The VIA Lab VL817-Q7 is a USB 3.1 Gen 1 4-Port hub controller that
> > features 4 downstream ports, an internal 5V regulator and has
> > external reset pin.
> >
> > Add a device tree binding for its USB protocol part.
> > The internal LDO is not covered by this and can just be modelled
> > as a fixed regulator.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  .../bindings/usb/vialab,vl817q7.yaml          | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml
> > new file mode 100644
> > index 000000000000..4ae995160fd5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Via labs VL817Q7 USB 3.1 hub controller
> > +
> > +maintainers:
> > +  - Anand Moon <linux.amoon@gmail.com>
> > +
> > +allOf:
> > +  - $ref: usb-device.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - vialab,usb2109
>
> This isn't a valid compatible string for USB devices (should be
> "usb<vid>,<pid>").
>
> Same for the other binding.
>

ok, I will change this in the next version.

> Also the bindings should go before the driver changes in the series.
>
> Johan

Thanks
-Anand
