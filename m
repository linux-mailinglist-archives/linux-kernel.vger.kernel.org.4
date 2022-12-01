Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22BA63E987
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 06:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiLAF5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 00:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLAF5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 00:57:01 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A75A6B43
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 21:57:00 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id d20so1053319edn.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 21:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HDYDeayhp4F4jLRjy3U5o4B4dnh5i5WiJ3M1AeVO0Es=;
        b=Tsm30sLRx+XONDFQARwXuUPZLtEfeqP8NxElshdDEZhXiD0xnAutmZsWAGl6A1IDKo
         6liGNzk55cc05ZHG2S0v6q7RZlfXS3Zo/r/nOsSmpxIj5enr0gIYcMx9EALve1jwytbu
         xjXGjZFIF8Q5HgGwsh+1izmOkwfOVccj0ZLwJ9CeECteokWqMCJLmdDnBxx0SWP2FrBh
         3+3VVjSQXA3s1fTi6j1bzDRJXe2Xs2Rm2k6EUMZQ1JkDoVvkRMvs3TqNy9+TwydqAV/m
         0GpLpOafoCdyOP6MsswvykBJr1Xivm25ntJdANH+w5TZxfesJEBNOLe1/PM77qHQggca
         fNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDYDeayhp4F4jLRjy3U5o4B4dnh5i5WiJ3M1AeVO0Es=;
        b=LiL1AAqeHvfp87SoE8k4nzxvBVQ9xjQql6THpHrnKZsrsDMt00oiaAqsx7wa/RKbpe
         P8cHOajP3Nl5hyFQ3sggU/VlRfNzBS30zUl8Pw3Ilve4lpclt20XiwnkIWSjRpeHb49J
         e8a11e3vpyXpT+9eOK+FBvO/TB8laFQqBqNCzEp6SqkKIEThoKCimQEVTgmWyLIM409A
         Qi/Xsd0/TqYICpanXfgJ0GnFXG2wR1fLX/nj85R10Z7Zp+qNOEkQduKT9rp8IklIZvay
         EbmYTeJJQ0BKTNy156MtvhXS/ZCPb9Kg1EcplTthZs/Qzn9jcCnk2qHJUDSHp+cALGZr
         r1Tg==
X-Gm-Message-State: ANoB5pnj0GI18ZSn+r5fiKUoQdG9FStrOK0aSWUde/HY1rRcr4Z2sU+Q
        uPzJwCd8j9EVKWUNzMM9X0n8JJ/bBbEcSF8yApv2Rg==
X-Google-Smtp-Source: AA0mqf5yTOFMssM36FFBLw2deA1PNPuz933yy4B9ZSG+g2Nf/G5qN0Wdnw8m33OYFpJQ/FEjf2buhlV2tlQWr7vOWpE=
X-Received: by 2002:a05:6402:d78:b0:46b:a177:9d84 with SMTP id
 ec56-20020a0564020d7800b0046ba1779d84mr7265836edb.134.1669874218518; Wed, 30
 Nov 2022 21:56:58 -0800 (PST)
MIME-Version: 1.0
References: <20221129140313.886192-1-apatel@ventanamicro.com>
 <20221129140313.886192-3-apatel@ventanamicro.com> <174d93be-bedf-bf8c-4a66-284931a997b3@sholland.org>
In-Reply-To: <174d93be-bedf-bf8c-4a66-284931a997b3@sholland.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 1 Dec 2022 11:26:47 +0530
Message-ID: <CAAhSdy1zSdqk5B-DBv5puEutT9+5s86QRw4UpjbgkLsiXGurCQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: timer: Add bindings for the RISC-V
 timer device
To:     Samuel Holland <samuel@sholland.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Conor Dooley <conor.dooley@microchip.com>,
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

On Wed, Nov 30, 2022 at 10:15 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 11/29/22 08:03, Anup Patel wrote:
> > We add DT bindings for a separate RISC-V timer DT node which can
> > be used to describe implementation specific behaviour (such as
> > timer interrupt not triggered during non-retentive suspend).
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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
>
> I don't want to derail getting this merged, but if you do end up sending
> another version, could you please spell out the word "cannot" here and
> in the code? The missing apostrophe makes this jarring (and an entirely
> different word).

Okay, I will update.

>
> > +    type: boolean
> > +    description:
> > +      If present, the timer interrupt can't wake up the CPU from
> > +      suspend/idle state.
>
> And in that case I would also suggest clarifying this as "one or more
> suspend/idle states", since the limitation does not apply to all idle
> states. At least it should never apply to the architectural WFI state;
> for the SBI idle state binding, it only applies to those with the
> "local-timer-stop" property.

Okay, I will update.

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
>
> The CLINT and PLIC bindings also include the M-mode interrupts. Should
> we do the same here?

The RISC-V timer uses SBI time extension or RISC-V Sstc extension hence
it is only for S-mode software. In other words, the RISC-V timer is a S-mode
only timer.

The M-mode software is supposed to have its own platform specific MMIO
based timer.

Regards,
Anup
