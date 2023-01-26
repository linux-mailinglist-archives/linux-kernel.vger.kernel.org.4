Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCE567D0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjAZPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAZPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:51:23 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B53518B21
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:51:21 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id k4so710326eje.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v6IsKkKvQ66krTdAokeWZGJe4z9XDgjrPRXuutCuv/M=;
        b=XHYeLCTKL5zftO2PC01bME8vVJoAoZziC0bsroopO76EaBON5PurQCRLeEyC955Xx5
         CgxfVsw2a47WI/ghLV44JPz6I2VQ2vz9QVmiPRPE1BwOXD9BAYnbgdWCl5GdL+ABDgM1
         rzKCCD92uyi/cUkSijeUoZIiFUQzYbYxQXp0CUla/n2hHhKRH6Cvy4UYDApef2mQieIX
         gTYtynJ2xvxPjtYgBMGSgRk1YqPQjtpMRWPCmcJsZIssq16x/NEcLlT3scnLSdQfOygY
         yvk/gMt+W3tGIUMIvgOHjYSS0xESnKtjxTJezNXshT9LeXrFD4HXwQHasAtRfaDqTc3P
         ilJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6IsKkKvQ66krTdAokeWZGJe4z9XDgjrPRXuutCuv/M=;
        b=2cTMyiIvQFWqkXsqKE8ztlhHwf80J6e+I/WD/T6CYTvcJOZpEtfm6naw+HglCRJvhC
         zjKrNH6Il5NWvxkeAM9ZTlYNBjLZ6ej85BqPsUkUXA1tBUZ3+okyLaZGTcEq2B31W2nn
         fo5PzsLho8/agmhTHrcB6F4pXTslLYrh384qmar5teYjEuwrlEFjrpOQRIXE9gvEyNDC
         B7j0qXcC/9WIH8EFyJKeLqVFSQJ2AKvwBn7oLRV7ZwXGjmV75Pyntr+ursJfp6Rk7yq9
         3g7TvSt8/9ctLDGCoc3ewW1cFx+zOOwFF8scD8fQACBuoT76OxzTHbO9tM27C8yJ9rS0
         epow==
X-Gm-Message-State: AFqh2kpcvJX4kakGZmaHQOfG2qBlHIjlaylIt+C0n2MLpD1xVhLB9PM9
        /GgRSyC/6dZEMJz54/zj/eGT/q64suinB9+xRJ0bkQ==
X-Google-Smtp-Source: AMrXdXutgw5Ig20FwSCClbnyFAtXgNLQ55QoexeLZX3scBTQOof/miV6rbHWrAUkM8G+I4CVNQC13OZMRhl89FJ9PhQ=
X-Received: by 2002:a17:906:7186:b0:86c:e53a:d212 with SMTP id
 h6-20020a170906718600b0086ce53ad212mr6377050ejk.182.1674748280100; Thu, 26
 Jan 2023 07:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20230124105643.1737250-1-etienne.carriere@linaro.org> <20230126145321.xs3hjivlpifr5hg7@bogus>
In-Reply-To: <20230126145321.xs3hjivlpifr5hg7@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 26 Jan 2023 16:51:09 +0100
Message-ID: <CAN5uoS_9t6o3NXkinMDZA6oBnj3t9kkmF5d0zn1stxVZfQwFkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: optee: add interrupt controller properties
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Thu, 26 Jan 2023 at 15:53, Sudeep Holla <sudeep.holla@arm.com> wrote:
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
>
> Just curious if this can discovered by some communication within OPTEE.
> You know you are using optee-channel-id 0 for all SCMI and 1 for DVFS.
> Is it not possible to get the information from OPTEE dynamically like
> you do for shmem. It is offset within the notification bitmap IIUC, so
> the question is can be get that from the firmware on the fly. It also
> gives the firmware to reshuffle things around if needed and don't have to
> worry about compatibility with DT ?

There is not specific discussions with OP-TEE to know which
Yet, assuming we have that scmi channel notif ID from optee, how does
scmi/optee driver relates to optee device irqchip?
With DT, we get both the optee irqchip ref (phandle) and our channel
notif irq line number (phandle arg #1).
Without DT, we still need to reference optee's irqchip.

Best regards,
etienne



>
> --
> Regards,
> Sudeep
