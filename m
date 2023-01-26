Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245E067CD35
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjAZOBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjAZOBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:01:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6000F2069B;
        Thu, 26 Jan 2023 06:00:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 655EA61826;
        Thu, 26 Jan 2023 14:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA33DC4339B;
        Thu, 26 Jan 2023 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674741624;
        bh=B46HmDxNE4EPRybPZ/i6YseUbzGF3u4U7Gc3rTsKJ1g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RjQzmZK9Ne7vSXIYlHjvB8PmCT8uijDI/DE714/3NBB1xkWOvJWfYcjpENGnFJ5G/
         3Ru93qk3TR0K6DDo/R22Wnky7FWKoxHzXn1Kj4uUeMjcoOiqxi8EudKDE+ETPi2cq2
         jooHGTqSWB6dhMA2aQgyVcIN9rF2wWQFU3ZmFdKsAiMNVWvVN+qi8XolOsfa4WH9X3
         fuhZjpgT0zW6zQrsXM6Wbl8+Nyk6lztwK1azH9nMavED5FQgYUEgWyUj8bZW4zYtsz
         +D2okfNGFJoB+PClm4FaBUm/hLVGSpXjU9XurAHBH1r96lCo3w06lgt6eR89I+7KGR
         /MaYGHFetMzGQ==
Received: by mail-vs1-f44.google.com with SMTP id 3so1952320vsq.7;
        Thu, 26 Jan 2023 06:00:24 -0800 (PST)
X-Gm-Message-State: AO0yUKXnO2XPIiJe0lsdUJOy+UxH7BnCVWu8IkfrCJWJ77O8Ca+V4iMP
        mkudjCTFKaqhY3q0V8jg501y8J2VStVZ8xJuxQ==
X-Google-Smtp-Source: AK7set/2ph/nW5qH6jiw8P+E7LiM7AXtrsN3WmyK/fNrMsYOV/fRzSb1ju2QZ415GNK80U9Tie1hGn26hM+05rb8AqE=
X-Received: by 2002:a67:c219:0:b0:3e9:107e:cc55 with SMTP id
 i25-20020a67c219000000b003e9107ecc55mr627489vsj.6.1674741623822; Thu, 26 Jan
 2023 06:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20230124105643.1737250-1-etienne.carriere@linaro.org>
 <20230125202215.GA2811928-robh@kernel.org> <CAN5uoS9tVyRQP1-2-Umxc33APGW=EFdidbgNVq_H6wVUXauHEg@mail.gmail.com>
In-Reply-To: <CAN5uoS9tVyRQP1-2-Umxc33APGW=EFdidbgNVq_H6wVUXauHEg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 Jan 2023 08:00:12 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+sv4vf6iconbitnQ33y0_B7+0T1JmCpjQvfmkqFd0Mgw@mail.gmail.com>
Message-ID: <CAL_Jsq+sv4vf6iconbitnQ33y0_B7+0T1JmCpjQvfmkqFd0Mgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: optee: add interrupt controller properties
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 3:00 PM Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> On Wed, 25 Jan 2023 at 21:22, Rob Herring <robh@kernel.org> wrote:
> >
> > +Sudeep
> >
> > On Tue, Jan 24, 2023 at 11:56:41AM +0100, Etienne Carriere wrote:
> > > Adds an optional interrupt controller property to optee firmware node
> > > in the DT bindings. Optee driver may embeds an irqchip exposing
> > > interrupts notified by the TEE world. Optee registers up to 1 interrupt
> > > controller and identifies each line with a line number from 0 to
> > > UINT16_MAX.
> > >
> > > In the example, the platform SCMI device uses optee interrupt irq 5
> > > as async signal to trigger processing of an async incoming SCMI message,
> > > in the scope of a CPU DVFS control. A platform can have several SCMI
> > > channels driven this way. Optee irqs also permits small embedded devices
> > > to share e.g. a gpio expander, a group of wakeup sources, etc... between
> > > OP-TEE world (for sensitive services) and Linux world (for non-sensitive
> > > services). The physical controller is driven from the TEE which exposes
> > > some controls to Linux kernel.
> > >
> > > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
> > > Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > ---
> > > Changes since v1:
> > > - Added a description to #interrupt-cells property.
> > > - Changed of example. Linux wakeup event was subject to discussion and
> > >   i don't know much about input events in Linux. So move to SCMI.
> > >   In the example, an SCMI server in OP-TEE world raises optee irq 5
> > >   so that Linux scmi optee channel &scmi_cpu_dvfs pushed in the incoming
> > >   SCMI message in the scmi device for liekly later processing in threaded
> > >   context. The example includes all parties: optee, scmi, sram, gic.
> > > - Obviously rephrased the commit message.
> > > - Added Cc: tags
> > > ---
> > >  .../arm/firmware/linaro,optee-tz.yaml         | 67 +++++++++++++++++++
> > >  1 file changed, 67 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > > index d4dc0749f9fd..9c00c27f8b2c 100644
> > > --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > > @@ -40,6 +40,14 @@ properties:
> > >        HVC #0, register assignments
> > >        register assignments are specified in drivers/tee/optee/optee_smc.h
> > >
> > > +  interrupt-controller: true
> > > +
> > > +  "#interrupt-cells":
> > > +    const: 1
> > > +    description: |
> > > +      OP-TEE exposes irq for irp chip controllers from OP-TEE world. Each
> > > +      irq is assigned a single line number identifier used as first argument.
> > > +
> > >  required:
> > >    - compatible
> > >    - method
> > > @@ -64,3 +72,62 @@ examples:
> > >              method = "hvc";
> > >          };
> > >      };
> > > +
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    firmware  {
> > > +        optee: optee {
> > > +            compatible = "linaro,optee-tz";
> > > +            method = "smc";
> > > +            interrupts = <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> > > +            interrupt-controller;
> > > +            #interrupt-cells = <1>;
> > > +        };
> > > +
> > > +        scmi {
> > > +            compatible = "linaro,scmi-optee";
> > > +            linaro,optee-channel-id = <0>;
> > > +            interrupt-parent = <&gic>;
> > > +            #address-cells = <1>;
> > > +            #size-cells = <0>;
> > > +
> > > +            scmi_cpu_dvfs: protocol@13 {
> > > +                reg = <0x13>;
> > > +                linaro,optee-channel-id = <1>;
> > > +                shmem = <&scmi_shm_tx>, <&scmi_shm_rx>;
> > > +                interrupts-extended = <&optee 5>;
> > > +                interrupt-names = "a2p";
> >
> > These properties aren't documented. Soon there will be a warning[1].
>
> They are.
> https://github.com/torvalds/linux/blob/v6.1/Documentation/devicetree/bindings/firmware/arm%2Cscmi.yaml#L45-L53

They are not. That's the scmi node, not a protocol node.

> In arm,scmi.yaml, interrupts optional property stands for interrupts
> and interrupts-extended, no?

Yes.

Rob
