Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E910638B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiKYNtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiKYNtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:49:06 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07646257
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:49:04 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ha10so10510093ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=haJ0+Zw47DZVHxADOM5rnvXmfvM6Vo6rvKK2ck9USDw=;
        b=sFFdm5VLwq5bMwcixBi8KzpcffeWlzb8cFahuwLkIMYirXdu9PWyHn5ZG8NZGPiOoA
         eGf+nJ4paoV33Or+npRq89akv5+bRI8dnHCRc0ON/19qKCmjMgECiFzM5oUMkblw64HX
         d8vP5vt+NQLYhYA2WdY3CDR/RgZgkpPUeW6zejf/f5+VJMdJ+tdAv98gk+ebCbffB/8E
         jDDfaa/jqYJP63vpooT6DRkUHYoT2K3lmAddRYm+xAj2z4+lACYH+7iO8+n2KFSV98s8
         jnvTp7h7Y6J1GyAzHuVPUI9LN0DNKiyECaqUeq0Pn5ar/Uxhb9ICrae1zxn4pAPrlnG2
         NQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haJ0+Zw47DZVHxADOM5rnvXmfvM6Vo6rvKK2ck9USDw=;
        b=oLjL+59EZAfEC1SvVRbmS+pkgZvHhplQBUrV0TGaBsG1jsHKPj6kW5U28v6sj9oglk
         RMjFp2CY7ryeqWrYokBOnRjv76JhtDcKshZU6sqip3skqHSllqRIEyhkU+3qv7nxOMpk
         NxFRmTOPv0zWQauKf0dBWP61HOCPzGQpBybQNZBb/kdDuFGIMfCJqlupGI6qANhvlk5B
         qg2HXkY+aZLb1C60c5oURA8ukJe7LEzvu0SJtJ7pLKIzr05RogsqWwyEKz5Kc5IViY6c
         1NLv3lKftfNwySP081S1hCoP15OOMiW7Lmxl+jf05C9bMrb4yrrxo0GZZ7xH+8m+dEgY
         vqzA==
X-Gm-Message-State: ANoB5plCoummXe1NEKIuU03UyGlG6ZgIC+zpWHZQ03jIinBqQfNZyR5L
        WuHe6jASvk/AeciTK476FU/ZDWrUuUctFTE6s1x8Bg==
X-Google-Smtp-Source: AA0mqf4TEIj1Wj5VNktFmonDfC53U8wK+8q62VC+/rbuEe3GSX7/nwkJ7AratjgzcKPA6MzRLmMCtimLoQK6v5EOfvs=
X-Received: by 2002:a17:906:6dd5:b0:78d:a633:b55 with SMTP id
 j21-20020a1709066dd500b0078da6330b55mr33442611ejt.106.1669384141244; Fri, 25
 Nov 2022 05:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20221125112105.427045-1-apatel@ventanamicro.com>
 <20221125112105.427045-3-apatel@ventanamicro.com> <Y4C+kwLdMYkkrm/2@wendy>
In-Reply-To: <Y4C+kwLdMYkkrm/2@wendy>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 25 Nov 2022 19:18:48 +0530
Message-ID: <CAAhSdy2XkW-3NsKiCFhz4MYG3U-=CF1ysN8hxQK0SGaUgAAznA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: timer: Add bindings for the RISC-V
 timer device
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 6:40 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> Hey Anup,
>
> For the future, could you please CC me on all patches in a series that I
> have previously reviewed?

Okay.

>
> On Fri, Nov 25, 2022 at 04:51:04PM +0530, Anup Patel wrote:
> > We add DT bindings for a separate RISC-V timer DT node which can
> > be used to describe implementation specific behaviour (such as
> > timer interrupt not triggered during non-retentive suspend).
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../bindings/timer/riscv,timer.yaml           | 52 +++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/riscv,timer.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/timer/riscv,timer.yaml b/Documentation/devicetree/bindings/timer/riscv,timer.yaml
> > new file mode 100644
> > index 000000000000..cf53dfff90bc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/riscv,timer.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/timer/riscv,timer.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V timer
> > +
> > +maintainers:
> > +  - Anup Patel <anup@brainfault.org>
> > +
> > +description: |+
> > +  RISC-V platforms always have a RISC-V timer device for the supervisor-mode
> > +  based on the time CSR defined by the RISC-V privileged specification. The
> > +  timer interrupts of this device are configured using the RISC-V SBI Time
> > +  extension or the RISC-V Sstc extension.
> > +
> > +  The clock frequency of RISC-V timer device is specified via the
> > +  "timebase-frequency" DT property of "/cpus" DT node which is described
> > +  in Documentation/devicetree/bindings/riscv/cpus.yaml
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - riscv,timer
> > +
> > +  interrupts-extended:
> > +    minItems: 1
> > +    maxItems: 4096   # Should be enough?
> > +
> > +  riscv,timer-cant-wake-cpu:
> > +    type: boolean
> > +    description:
> > +      If present, the timer interrupt can't wake up the CPU from
> > +      suspend/idle state.
>
> I'm really not sure about this... I would be inclined to think that if
> someone does not specify then we should assume that they took the
> scroogiest view of the spec and so do not get events during suspend.
>
> I suppose you could then argue that their DT is wrong & it's their fault
> though. Plus the existing platforms behave this way & we avoid having to
> retrofit stuff here.

Yes, the DT property is defined to keep things working for
existing platforms.

IMO, people should always read the DT bindings document at time of
creating DT for their platform. If there are queries then they can always
shoot email to the maintainers on LKML.

>
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - interrupts-extended
> > +
> > +examples:
> > +  - |
> > +    timer {
> > +      compatible = "riscv,timer";
> > +      interrupts-extended = <&cpu1intc 5>,
> > +                            <&cpu2intc 5>,
> > +                            <&cpu3intc 5>,
> > +                            <&cpu4intc 5>;
> > +    };
> > +...
> > --
> > 2.34.1
> >

Regards,
Anup
