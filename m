Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66B67BD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbjAYVAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbjAYVAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:00:46 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223E822782
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:00:45 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hw16so50980105ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a4A2t83h8jjrBIRvtMkxz3aCgx9lH7x3/nySXGL2eBc=;
        b=uf3zPHKCvZ1HIJaR3DFsKg8+ClcZ6bZRIoQE2h+ZOaEY8FLGs6HmDpkhqiV1BY003I
         mFy2mYLOFfvrVrPiooPwonrbeCdsW4GRBaE1nf1G3Z5F39YCkOfoWGHEabOnzfvqu7qs
         YFucK6Vc5b8lFuZpc82VpFs1CqNUOOBp7moYk6NT4IapthQiouc9fN3a7Bb6lHmudhL1
         +SA7ehXq6VOOxvZAZfGQ5IW225M6kV2RksOzuXBXkXLGhBvUIofJLxWhzq0IfgkjsCWH
         NU6YR9ZJDfO5q+RBikbS1WsChb2q58p0sZ2KTbtfVXdArrQzuIUUz52i9IQGzv2+gjPx
         yMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4A2t83h8jjrBIRvtMkxz3aCgx9lH7x3/nySXGL2eBc=;
        b=pmghVriC2zxe/sgTjXPW94boEXR0jaaDO+c++v3Ihs100HiFnnvVTKlueGFSS1JJ6g
         uunhbUvQGh64INjSTtciDxLDH50NnOLYQG1CPgbkZtdFgzFVU9PtNtPhJbJtlLwa2IIm
         AuajFU9ZEU5GBAp49t38R9PumjubtiiI36JHXOwbQJqO0JOnZHurzuteEYMz3ncXeXFK
         X+EnFaEx7JeZecjOHRvmSerdTLMrERgcypVLnxo4j/8lEBXqYdMZrP9NK0hmmL/2I6QF
         bX8ey4/+6R4YKs1MCfX2iwrrbIJtCXMRte0skvUFyuaLFmyGvYECc5S9FnfiSm0z7CEW
         T8DQ==
X-Gm-Message-State: AFqh2krAQZ7y9w9RDurJNK2crzvJXwcvF3vxf5bo0OnwwUlzyGOYWw3w
        YywDr7LDVxtDw/WQDb13kwuRtFaR4ujTqp7hC1F6Yw==
X-Google-Smtp-Source: AMrXdXsh30gqbmIZsBku7l4s0c30MZS9igda+Hlkp1tSA+B8JpH10Fio1eT3NdrtgKhxI7jeSHM8XqGBGeguzQCMfuE=
X-Received: by 2002:a17:906:9399:b0:871:7a08:9d6e with SMTP id
 l25-20020a170906939900b008717a089d6emr3741626ejx.234.1674680443582; Wed, 25
 Jan 2023 13:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20230124105643.1737250-1-etienne.carriere@linaro.org> <20230125202215.GA2811928-robh@kernel.org>
In-Reply-To: <20230125202215.GA2811928-robh@kernel.org>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 25 Jan 2023 22:00:32 +0100
Message-ID: <CAN5uoS9tVyRQP1-2-Umxc33APGW=EFdidbgNVq_H6wVUXauHEg@mail.gmail.com>
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

On Wed, 25 Jan 2023 at 21:22, Rob Herring <robh@kernel.org> wrote:
>
> +Sudeep
>
> On Tue, Jan 24, 2023 at 11:56:41AM +0100, Etienne Carriere wrote:
> > Adds an optional interrupt controller property to optee firmware node
> > in the DT bindings. Optee driver may embeds an irqchip exposing
> > interrupts notified by the TEE world. Optee registers up to 1 interrupt
> > controller and identifies each line with a line number from 0 to
> > UINT16_MAX.
> >
> > In the example, the platform SCMI device uses optee interrupt irq 5
> > as async signal to trigger processing of an async incoming SCMI message,
> > in the scope of a CPU DVFS control. A platform can have several SCMI
> > channels driven this way. Optee irqs also permits small embedded devices
> > to share e.g. a gpio expander, a group of wakeup sources, etc... between
> > OP-TEE world (for sensitive services) and Linux world (for non-sensitive
> > services). The physical controller is driven from the TEE which exposes
> > some controls to Linux kernel.
> >
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> >
> > Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
> > Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> > Changes since v1:
> > - Added a description to #interrupt-cells property.
> > - Changed of example. Linux wakeup event was subject to discussion and
> >   i don't know much about input events in Linux. So move to SCMI.
> >   In the example, an SCMI server in OP-TEE world raises optee irq 5
> >   so that Linux scmi optee channel &scmi_cpu_dvfs pushed in the incoming
> >   SCMI message in the scmi device for liekly later processing in threaded
> >   context. The example includes all parties: optee, scmi, sram, gic.
> > - Obviously rephrased the commit message.
> > - Added Cc: tags
> > ---
> >  .../arm/firmware/linaro,optee-tz.yaml         | 67 +++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > index d4dc0749f9fd..9c00c27f8b2c 100644
> > --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > @@ -40,6 +40,14 @@ properties:
> >        HVC #0, register assignments
> >        register assignments are specified in drivers/tee/optee/optee_smc.h
> >
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +    description: |
> > +      OP-TEE exposes irq for irp chip controllers from OP-TEE world. Each
> > +      irq is assigned a single line number identifier used as first argument.
> > +
> >  required:
> >    - compatible
> >    - method
> > @@ -64,3 +72,62 @@ examples:
> >              method = "hvc";
> >          };
> >      };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    firmware  {
> > +        optee: optee {
> > +            compatible = "linaro,optee-tz";
> > +            method = "smc";
> > +            interrupts = <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> > +            interrupt-controller;
> > +            #interrupt-cells = <1>;
> > +        };
> > +
> > +        scmi {
> > +            compatible = "linaro,scmi-optee";
> > +            linaro,optee-channel-id = <0>;
> > +            interrupt-parent = <&gic>;
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            scmi_cpu_dvfs: protocol@13 {
> > +                reg = <0x13>;
> > +                linaro,optee-channel-id = <1>;
> > +                shmem = <&scmi_shm_tx>, <&scmi_shm_rx>;
> > +                interrupts-extended = <&optee 5>;
> > +                interrupt-names = "a2p";
>
> These properties aren't documented. Soon there will be a warning[1].

They are.
https://github.com/torvalds/linux/blob/v6.1/Documentation/devicetree/bindings/firmware/arm%2Cscmi.yaml#L45-L53

In arm,scmi.yaml, interrupts optional property stands for interrupts
and interrupts-extended, no?


>
> > +                #clock-cells = <1>;
> > +            };
> > +        };
> > +    };
> > +
> > +    gic: interrupt-controller@a0021000 {
> > +        compatible = "arm,cortex-a7-gic";
> > +        reg = <0xa0021000 0x1000>, <0xa0022000 0x2000>;
> > +        interrupt-controller;
> > +        #interrupt-cells = <3>;
> > +    };
> > +
> > +    soc {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        sram@2ffff000 {
> > +            compatible = "mmio-sram";
> > +            reg = <0x2ffff000 0x1000>;
> > +            #address-cells = <1>;
> > +            #size-cells = <1>;
> > +            ranges = <0 0x2ffff000 0x1000>;
> > +
> > +            scmi_shm_tx: scmi-sram@0 {
> > +                compatible = "arm,scmi-shmem";
> > +                reg = <0 0x80>;
> > +            };
> > +
> > +            scmi_shm_rx: scmi-sram@100 {
> > +                compatible = "arm,scmi-shmem";
> > +                reg = <0x100 0x80>;
> > +            };
>
> There's no need to show providers in examples (unless the example is for
> the provider).

Ok, i'll simplify the example

Thanks,
Etienne

>
> Rob
