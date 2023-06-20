Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D01E736864
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjFTJxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjFTJxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:53:14 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A847A210E;
        Tue, 20 Jun 2023 02:51:15 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39e9d1bf835so2886997b6e.2;
        Tue, 20 Jun 2023 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687254675; x=1689846675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fy56LIoFDT1gDjDG2MhwrzFY/aTSjAoQF2DNWM4NN1o=;
        b=czz363FSEh3cBZ+vXHauhd43yT74MLlMFwcivzaIWa2LOQ2xf05Ty7kD3GYYld4g7z
         9wQ6ZkdDII5+lwjYFbq6O/f7GhxpgSctIJbaIVJotWx1neB9ahZTp+MoJyDyZPmpkmJO
         mxScnS/xPV6XN+sddXuqXZbQ+jn3m2zAyNadEEb1uY2Wxaku0EBVhHmLk6s1TxdRl31q
         ksNcQr3vxoLuKt+xpxJ4u+hQzJd9ogFe9ynj2TiMKoM+MBQLJvDIS5w8g2ol16adlQia
         1ae497brxKX4W+YA9WxBLZsGDeHkz1HRPZrELJONCyauXRx45cM78NxDrklbOGUxeRbI
         syXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687254675; x=1689846675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fy56LIoFDT1gDjDG2MhwrzFY/aTSjAoQF2DNWM4NN1o=;
        b=TLXs7wzLm0qTXU2DBDGTF/75Sl4G/LQu/s+E7km7cI0GVmJnm4rC76gkC+/5VU01Id
         HUoSoHWmjYLlasXKhMzLUANR46bGGCXtpWFsmolmD8JAz0fgIdjykOPZIGNtaGM9dx26
         220GRrC625TrsmECWl7OWUSTQ6/CXwIGzCTJYAdHsL/1cJkwXjgo0MFP+zpU2agipmWN
         SGg+GDxYS41XQmA/gjDp5wwRjh2WQjUhdQ1bHU59BtJXTG1DHNvpdkTJtqQbJNXxdJvZ
         jhQxGTmPjQO+4tW/Ap1nS5jorSAx1ISn4I1/pK/4F5Z5AYJgDzyBYl/NOt2qBHKeH+XN
         5HFQ==
X-Gm-Message-State: AC+VfDzofFaycFVmdDJJV2y9jSHrTzeWl9qOpzJIr0rKRFIGa7xoEb8v
        XkQshHSuLpWmhKSVIRaS3eYXFBMqiPuS9JH78u9E0OLyX1k=
X-Google-Smtp-Source: ACHHUZ7gkdUncjtV4VbaI2d/o/Y1RBtJ87EDKYyhgZcgV4rhVKrNyqCqOoMrY95lHqZTedOP/Xos6t1G/R0P3gstyPQ=
X-Received: by 2002:aca:2109:0:b0:398:6495:5a9b with SMTP id
 9-20020aca2109000000b0039864955a9bmr10187931oiz.5.1687254674989; Tue, 20 Jun
 2023 02:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230620093409.1411399-1-sergio.paracuellos@gmail.com> <9b0d5439-24dd-2c32-f13a-110f758591fb@linaro.org>
In-Reply-To: <9b0d5439-24dd-2c32-f13a-110f758591fb@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 20 Jun 2023 11:51:04 +0200
Message-ID: <CAMhs-H9L0GybDOdmx5_RCw-=PaO3DYUOZPswiRErRRg5Fi57tQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: add Ralink SoCs timer documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Jun 20, 2023 at 11:40=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/06/2023 11:34, Sergio Paracuellos wrote:
> > Add YAML documentation for the timer which is present on Ralink SoCs.
>
> If there is going to be new version:
> A nit, subject: drop second/last, redundant "documentation". The
> "dt-bindings" prefix is already stating that these are bindings in
> documentation.

Understood, thanks.

>
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  .../bindings/timer/ralink,rt2880-timer.yaml   | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/ralink,rt28=
80-timer.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/timer/ralink,rt2880-time=
r.yaml b/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
> > new file mode 100644
> > index 000000000000..9a315449f73e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/timer/ralink,rt2880-timer.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Timer present in Ralink family SoCs
> > +
> > +maintainers:
> > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: ralink,rt2880-timer
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: timer
>
> Names matching the module name are not really helpful, so drop it,
> unless any existing user needs it.

I am ok with dropping this. If you meant with an existing user
something that is already mainlined in the kernel tree then I would
say there is no need for this 'clock-names'. I don't know about other
places since these SoCs are pretty old and almost with nothing
documented. I am doing the effort of trying to document all the stuff
before porting some openWRT device tree files to the kernel (this
timer driver is already included in 'arch/mips/ralink' so I am
documenting already in-tree things). So I guess I should send v2
removing this?

Thanks,
    Sergio Paracuellos
>
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
>
> Best regards,
> Krzysztof
>
