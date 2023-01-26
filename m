Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA1867CE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjAZOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjAZOkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:40:55 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AC8618B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:40:54 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so5624832ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w6NkFNKrGySeIww7WvFjilZaospsmzYauHqXlYvr3ZI=;
        b=JAgDV4vb6GtICHFhoT5mV+Q/paex2NVWbr8Lt1PdgyEZERFZ2BU9frLVtPZ0Ikt/Eg
         STl5/zzT/lHZ/CinUDU/VTgfjPKbNZRHcaT4YLxUU52aGvLKHwElL+DIjfRz1A7tKtuz
         BV3zJ8/XM1znIhuDLAmKKksPXEFsvgdNTP/hvPftgc/P2zCLD8kpMEHVeNquYdEow/MV
         YeHtH0GB5NIBJrE3rsBhh3ehzAZXZN6JA2TF5f7BTQqG1SZrKPJKx+MezfQVhqvN+WNE
         oB7m6wOqnsU7xpNxHzkG4Co/T6DmlESO8eIE5xi5aGg0SDjEK2i9bNmyezgWlQOIp9hQ
         7gFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6NkFNKrGySeIww7WvFjilZaospsmzYauHqXlYvr3ZI=;
        b=phcN5uo37ybWmVoQw08qca9wT3j9V3Llc2p7DYnuxgfTdQGp/so3ONzVCxzHfpuz5O
         wl1xIUxoRafG0rvD40dpOX6IErxq6ss+UKCEHr/Y1SfVxXds0lAr3k+Pb6cAeRt829xn
         qiLORigO5NQbZxbNfvUBkqWdpFqWyeSxXYQhIGMYIgpWT8155RLTih8mFCfCtzgDbiEz
         qs0OK2mlOTpus2HwuZM33O177SKHr+lYcHbGIHiQprjgy8XHrjXF8SV2kzbvbOVOzjmk
         hPkT+inqoEoC5T2amVV8H3tsLBGPPUBngsNOkbJwIZPhM4gO9Kmp3kN0jLselC/blSE2
         iEgA==
X-Gm-Message-State: AFqh2kovrydXvCwBELuLxdsXcqjs23fzfQYWDR51AATdOdvmON5XJuxS
        48U7lJ1CxSFrUv5c8GYu4WN+EtQIA4y86T+uVO/Tdg==
X-Google-Smtp-Source: AMrXdXsHvhXbQTYC09FtQdNJ1eZUXRTfsG7rzz4YYuYXLhBztZXV8UloV4ORvxJQmXHzkRnIHwfCstzsrt1Rd5KaASI=
X-Received: by 2002:a17:907:80cd:b0:84d:458f:48c8 with SMTP id
 io13-20020a17090780cd00b0084d458f48c8mr5301326ejc.204.1674744053651; Thu, 26
 Jan 2023 06:40:53 -0800 (PST)
MIME-Version: 1.0
References: <20230124105643.1737250-1-etienne.carriere@linaro.org>
 <20230125202215.GA2811928-robh@kernel.org> <CAN5uoS9tVyRQP1-2-Umxc33APGW=EFdidbgNVq_H6wVUXauHEg@mail.gmail.com>
 <CAL_Jsq+sv4vf6iconbitnQ33y0_B7+0T1JmCpjQvfmkqFd0Mgw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+sv4vf6iconbitnQ33y0_B7+0T1JmCpjQvfmkqFd0Mgw@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 26 Jan 2023 15:40:42 +0100
Message-ID: <CAN5uoS9xH3UN3O3Te3QJEB1CHtEcu=iGfJmRfXYp7wo=e+b6oA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: optee: add interrupt controller properties
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 at 15:00, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jan 25, 2023 at 3:00 PM Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > On Wed, 25 Jan 2023 at 21:22, Rob Herring <robh@kernel.org> wrote:
> > >
> > > +Sudeep
> > >
> > > On Tue, Jan 24, 2023 at 11:56:41AM +0100, Etienne Carriere wrote:
> > > > Adds an optional interrupt controller property to optee firmware node
> > > > in the DT bindings. Optee driver may embeds an irqchip exposing
> > > > interrupts notified by the TEE world. Optee registers up to 1 interrupt
> > > > controller and identifies each line with a line number from 0 to
> > > > UINT16_MAX.
> > > >
> > > > In the example, the platform SCMI device uses optee interrupt irq 5
> > > > as async signal to trigger processing of an async incoming SCMI message,
> > > > in the scope of a CPU DVFS control. A platform can have several SCMI
> > > > channels driven this way. Optee irqs also permits small embedded devices
> > > > to share e.g. a gpio expander, a group of wakeup sources, etc... between
> > > > OP-TEE world (for sensitive services) and Linux world (for non-sensitive
> > > > services). The physical controller is driven from the TEE which exposes
> > > > some controls to Linux kernel.
> > > >
> > > > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > > >
> > > > Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
> > > > Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > > ---
> > > > Changes since v1:
> > > > - Added a description to #interrupt-cells property.
> > > > - Changed of example. Linux wakeup event was subject to discussion and
> > > >   i don't know much about input events in Linux. So move to SCMI.
> > > >   In the example, an SCMI server in OP-TEE world raises optee irq 5
> > > >   so that Linux scmi optee channel &scmi_cpu_dvfs pushed in the incoming
> > > >   SCMI message in the scmi device for liekly later processing in threaded
> > > >   context. The example includes all parties: optee, scmi, sram, gic.
> > > > - Obviously rephrased the commit message.
> > > > - Added Cc: tags
> > > > ---
> > > >  .../arm/firmware/linaro,optee-tz.yaml         | 67 +++++++++++++++++++
> > > >  1 file changed, 67 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > > > index d4dc0749f9fd..9c00c27f8b2c 100644
> > > > --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > > > @@ -40,6 +40,14 @@ properties:
> > > >        HVC #0, register assignments
> > > >        register assignments are specified in drivers/tee/optee/optee_smc.h
> > > >
> > > > +  interrupt-controller: true
> > > > +
> > > > +  "#interrupt-cells":
> > > > +    const: 1
> > > > +    description: |
> > > > +      OP-TEE exposes irq for irp chip controllers from OP-TEE world. Each
> > > > +      irq is assigned a single line number identifier used as first argument.
> > > > +
> > > >  required:
> > > >    - compatible
> > > >    - method
> > > > @@ -64,3 +72,62 @@ examples:
> > > >              method = "hvc";
> > > >          };
> > > >      };
> > > > +
> > > > +  - |
> > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > +    firmware  {
> > > > +        optee: optee {
> > > > +            compatible = "linaro,optee-tz";
> > > > +            method = "smc";
> > > > +            interrupts = <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> > > > +            interrupt-controller;
> > > > +            #interrupt-cells = <1>;
> > > > +        };
> > > > +
> > > > +        scmi {
> > > > +            compatible = "linaro,scmi-optee";
> > > > +            linaro,optee-channel-id = <0>;
> > > > +            interrupt-parent = <&gic>;
> > > > +            #address-cells = <1>;
> > > > +            #size-cells = <0>;
> > > > +
> > > > +            scmi_cpu_dvfs: protocol@13 {
> > > > +                reg = <0x13>;
> > > > +                linaro,optee-channel-id = <1>;
> > > > +                shmem = <&scmi_shm_tx>, <&scmi_shm_rx>;
> > > > +                interrupts-extended = <&optee 5>;
> > > > +                interrupt-names = "a2p";
> > >
> > > These properties aren't documented. Soon there will be a warning[1].
> >
> > They are.
> > https://github.com/torvalds/linux/blob/v6.1/Documentation/devicetree/bindings/firmware/arm%2Cscmi.yaml#L45-L53
>
> They are not. That's the scmi node, not a protocol node.

Ok,i should have written it this way then:

+        scmi {
+            compatible = "linaro,scmi-optee";
+            linaro,optee-channel-id = <0>;
+            shmem = <&scmi_shm_tx>, <&scmi_shm_rx>;
+            interrupts-extended = <&optee 5>;
+            interrupt-names = "a2p";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            scmi_cpu_dvfs: protocol@13 {
+                reg = <0x13>;
+                #clock-cells = <1>;
+            };
+        };


>
> > In arm,scmi.yaml, interrupts optional property stands for interrupts
> > and interrupts-extended, no?
>
> Yes.
>
> Rob
