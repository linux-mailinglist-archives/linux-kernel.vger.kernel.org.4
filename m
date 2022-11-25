Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61274639276
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKYX5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYX5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:57:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D36E0DD;
        Fri, 25 Nov 2022 15:57:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED936B82C8B;
        Fri, 25 Nov 2022 23:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BD1C433D7;
        Fri, 25 Nov 2022 23:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669420661;
        bh=jaLKaGAKU1UL+34Cy5mouKhCDu7jQB71LFKr8lUwsm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gjyk63PFqldQb5NpmQjaLrr5/MhsDXRBGqbl/eZQ6VqzIyeVDH8G9mV4dYkxgrO5j
         WXjSm/vq0rEgQJWPSu30fHWoRBT44jUW7RMOaNQwnagSDFIOc5H1RnL51hN7nDP+2u
         W7wCEgdPUYAHu4dxkD2CDZ6z3rrgWQ4sXd4u6gGcvAlwcFm8ZC7aZ4MTlufTmJ2tjf
         hciw6cpW5Hh/WTNx8xbAKBpFr9vR2BvVIXcX3a7yIDdRmNbsg16o9VuLBZSNDc26tK
         gWhBvvDWqeSpu3SG7GtleoDvDhGtiWgdegBaoXjHQYIjHciE9nT3dXpJKTx1wChdw7
         /zUeWxl50kGJw==
Date:   Fri, 25 Nov 2022 23:57:36 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
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
Subject: Re: [PATCH v3 2/3] dt-bindings: timer: Add bindings for the RISC-V
 timer device
Message-ID: <Y4FWcOtBHW/n8cjG@spud>
References: <20221125112105.427045-1-apatel@ventanamicro.com>
 <20221125112105.427045-3-apatel@ventanamicro.com>
 <Y4C+kwLdMYkkrm/2@wendy>
 <CAAhSdy2XkW-3NsKiCFhz4MYG3U-=CF1ysN8hxQK0SGaUgAAznA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2XkW-3NsKiCFhz4MYG3U-=CF1ysN8hxQK0SGaUgAAznA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 07:18:48PM +0530, Anup Patel wrote:
> On Fri, Nov 25, 2022 at 6:40 PM Conor Dooley <conor.dooley@microchip.com> wrote:
> >
> > Hey Anup,
> >
> > For the future, could you please CC me on all patches in a series that I
> > have previously reviewed?
> 
> Okay.
> 
> >
> > On Fri, Nov 25, 2022 at 04:51:04PM +0530, Anup Patel wrote:
> > > We add DT bindings for a separate RISC-V timer DT node which can
> > > be used to describe implementation specific behaviour (such as
> > > timer interrupt not triggered during non-retentive suspend).
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > ---
> > >  .../bindings/timer/riscv,timer.yaml           | 52 +++++++++++++++++++
> > >  1 file changed, 52 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/timer/riscv,timer.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/timer/riscv,timer.yaml b/Documentation/devicetree/bindings/timer/riscv,timer.yaml
> > > new file mode 100644
> > > index 000000000000..cf53dfff90bc
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/timer/riscv,timer.yaml
> > > @@ -0,0 +1,52 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/timer/riscv,timer.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: RISC-V timer
> > > +
> > > +maintainers:
> > > +  - Anup Patel <anup@brainfault.org>
> > > +
> > > +description: |+
> > > +  RISC-V platforms always have a RISC-V timer device for the supervisor-mode
> > > +  based on the time CSR defined by the RISC-V privileged specification. The
> > > +  timer interrupts of this device are configured using the RISC-V SBI Time
> > > +  extension or the RISC-V Sstc extension.
> > > +
> > > +  The clock frequency of RISC-V timer device is specified via the
> > > +  "timebase-frequency" DT property of "/cpus" DT node which is described
> > > +  in Documentation/devicetree/bindings/riscv/cpus.yaml
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - riscv,timer
> > > +
> > > +  interrupts-extended:
> > > +    minItems: 1
> > > +    maxItems: 4096   # Should be enough?
> > > +
> > > +  riscv,timer-cant-wake-cpu:
> > > +    type: boolean
> > > +    description:
> > > +      If present, the timer interrupt can't wake up the CPU from
> > > +      suspend/idle state.
> >
> > I'm really not sure about this... I would be inclined to think that if
> > someone does not specify then we should assume that they took the
> > scroogiest view of the spec and so do not get events during suspend.
> >
> > I suppose you could then argue that their DT is wrong & it's their fault
> > though. Plus the existing platforms behave this way & we avoid having to
> > retrofit stuff here.
> 
> Yes, the DT property is defined to keep things working for
> existing platforms.
> 
> IMO, people should always read the DT bindings document at time of
> creating DT for their platform. If there are queries then they can always
> shoot email to the maintainers on LKML.

Aye, I suppose so. For every platform that may exist that this change
hurts, there's likely another one that it fixes a timer for... /shrug

Binding itself looks grand though & we are in lessor of two evils
territory, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for turning around a v3 promptly Anup!
Conor.

> > > +
> > > +additionalProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - interrupts-extended
> > > +
> > > +examples:
> > > +  - |
> > > +    timer {
> > > +      compatible = "riscv,timer";
> > > +      interrupts-extended = <&cpu1intc 5>,
> > > +                            <&cpu2intc 5>,
> > > +                            <&cpu3intc 5>,
> > > +                            <&cpu4intc 5>;
> > > +    };
> > > +...
> > > --
> > > 2.34.1
> > >
> 
> Regards,
> Anup
