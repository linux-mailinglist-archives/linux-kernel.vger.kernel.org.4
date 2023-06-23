Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A6973AF30
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjFWDyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjFWDyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:54:14 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B144B1BFE;
        Thu, 22 Jun 2023 20:54:13 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-55e0706af99so162901eaf.1;
        Thu, 22 Jun 2023 20:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687492453; x=1690084453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMQ4I0DPbaoK5gg0ZwtWWWfM9jrJt6TfeYfzew3l+nQ=;
        b=chdBjQySJOLoZMasxb1tp0Vb3PyB+N1K6v+NFabCtndQKntAicSSc1YkvWTUyt6UWG
         kNnu+qTmxU7xhTJpjNWayDvDrTZ0h3J2MUwUz02VCmUG7KKQd+DfiSzuaWAYmgSp5TVu
         fcNbM5h2BnR/ggPUbzc41nI4Ch9V/xtjmED9RMV/fIoTLktdTQ76fOqV56Jdu8Y1gRT9
         y/qbO+SnwXTl1moxeyqZWdcHFr301hIn/ElpmZzs1IdDiDo8/f6giqC+UwPOMV5UNElH
         mjhAMsOQg9rajD2f9BIwMYeq9ErNDRY0S6KMjD7xd9HgkHdTr/hIdT+mMCNdPWeSr2wl
         ztJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687492453; x=1690084453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMQ4I0DPbaoK5gg0ZwtWWWfM9jrJt6TfeYfzew3l+nQ=;
        b=ekjEZPBWy/rvsQeXAmmOjigDrAE1TfvcAZ+Ds3hHKCJVdvyNZLNhdDbpLbPJroktC0
         yJYfwMRsL6YCMUnxPq2LujzOwghl5ZH7lnt5a3KC3Q3aa6F4EnZUG7xrWTbJ5qMl3+cz
         ZBYXy5zgoSlyJbIWz2QbfFy4W7O8t9pe1yg5MqwnnG/hvcSnuDaOEFtquUyexfigGt/f
         FxtFzhAeiEdXedLrUOS8eP6GkWneT8aNQHeWXG1qSQZwCFRl3lTGOTx9Eu3rQRsaSyTW
         Zr8imlRlJwx0B9OQjGA43t8YwD77EyY3Q/yU1FmOUUVe2xtbEsJvQFk2xhOdC8KrPow2
         umQg==
X-Gm-Message-State: AC+VfDzUKUIszv3pgKbV9sn/sBJe89AhQ0/Q5XywyoNrQEAsVLHm2aX4
        euVITmNlsrjN6C0gxUbYNdQklZBx4EdtCBTP6CBcYfVuiZY=
X-Google-Smtp-Source: ACHHUZ5cWw+zEuG0xkJuOiWtlkfgOgI0PylnGDwgJm0fhEbj1WdlqdtFnG1hkX3DvpZ9MlaV9EQTfNCVZCEfCc6Ynzs=
X-Received: by 2002:a4a:d8d7:0:b0:558:b4b6:7f8c with SMTP id
 c23-20020a4ad8d7000000b00558b4b67f8cmr8620834oov.6.1687492452657; Thu, 22 Jun
 2023 20:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230622110451.1504823-1-sergio.paracuellos@gmail.com> <20230622-algebra-superglue-40955b223774@spud>
In-Reply-To: <20230622-algebra-superglue-40955b223774@spud>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 23 Jun 2023 05:54:02 +0200
Message-ID: <CAMhs-H87rhn=8AdLgPFFbSq+=ngQW8n6NRcWKpqjXZ0wyaNiPg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: add Ralink SoCs
 interrupt controller
To:     Conor Dooley <conor@kernel.org>
Cc:     devicetree@vger.kernel.org, tglx@linutronix.de, maz@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org
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

Hi Conor,

On Thu, Jun 22, 2023 at 9:14=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Jun 22, 2023 at 01:04:51PM +0200, Sergio Paracuellos wrote:
> > Add YAML doc for the interrupt controller which is present on Ralink So=
Cs.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> > Changes in v2:
> >  - Drop label from the example.
> >
> >  .../ralink,rt2880-intc.yaml                   | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-control=
ler/ralink,rt2880-intc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/ral=
ink,rt2880-intc.yaml b/Documentation/devicetree/bindings/interrupt-controll=
er/ralink,rt2880-intc.yaml
> > new file mode 100644
> > index 000000000000..533d6d03aa75
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/ralink,rt2=
880-intc.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/ralink,rt2880-=
intc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Ralink SoCs Interrupt Controller
> > +
> > +maintainers:
> > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml#
> > +
> > +description: |
>
> FWIW, you don't need a | unless you have some formatting to preserve.

True. Will drop, then.

>
> > +  This interrupt controller support a central point for interrupt aggr=
egation
> > +  for platform related blocks.
> > +
> > +properties:
> > +  compatible:
> > +    const: ralink,rt2880-intc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  '#interrupt-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-controller
> > +  - '#interrupt-cells'
> > +
> > +unevaluatedProperties: false
>
> You explicitly allow two properties from interrupt-controller.yaml, so
> it seems like this should actually be additionalProperties: false to
> block things like interrupt-map etc?

Yes, this should be additionalProperties.
>
> If your intention was only to allow interrupt-controller, with
> s/unevaluated/additional/ you can add
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I will fix these two minor things and send v3 with your Reviewed-by
added, thanks.

Best regards,
    Sergio Paracuellos
>
> Cheers,
> Conor.
>
> > +
> > +examples:
> > +  - |
> > +    interrupt-controller@200 {
> > +      compatible =3D "ralink,rt2880-intc";
> > +      reg =3D <0x200 0x100>;
> > +      interrupt-controller;
> > +      #interrupt-cells =3D <1>;
> > +
> > +      interrupt-parent =3D <&cpuintc>;
> > +      interrupts =3D <2>;
> > +    };
> > +...
> > --
> > 2.25.1
> >
