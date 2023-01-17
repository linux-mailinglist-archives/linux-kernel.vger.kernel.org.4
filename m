Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C266D434
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbjAQCT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjAQCTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:19:23 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A15A233E1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:19:22 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v30so43095116edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hcQxc2tbryNUtqB3FYleqM+oCMe9Hi/eZebyk02NgNg=;
        b=Yw7RS40Ju3wfv111tJNUpkOAASKxbHu2DMGPt6VJDGX2wCFlgTh4/KUu0O/n2XS3q8
         jO8VXR+6xfK/duKX7v6GKpQ9fLa1tuvOxfIBEqHMeCjEJe0zIZbbZVCNWNux2+uRo0qH
         8C7Rz+dpqvnHM+kZ7jy9XrHGpPL0gRO3S5+uATiX9SqME8f66CO51wieubwsgnRL8ZxF
         J6PNk6o6Z3oazbZwYrMMpN8Ly/W2QdnVLCZMpMFLf//2cZsPh0xRWQNV6JjxZ/tAo272
         ubpbax6ishQWvi8Z7uOjNi6ktm/CHLZubygSmyWaeTTGuYdIdi/pp7ocD4TLRHYJmUO/
         ST0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcQxc2tbryNUtqB3FYleqM+oCMe9Hi/eZebyk02NgNg=;
        b=V/cVB0G5Tel3QoL7zukLzSd87EIKHgzU2ib7EyRhHcPW02AD5ObrSmDz/GcGoyqRFP
         RIpF3zyymPXS7SYA3mEtECwKnMa4hDBOJF/pO9O6wKZrp7jCzlnbZ/r1oa5/JERzcsyW
         XSL9WTKR1O1TfJ0Hh1o86iOuURxgupl8XkW+6/nPWe2nWvjPtKXD18wZuDIuCrg4RA6k
         w2Hz6ygRriqsMIn4V4IKOlq/U08Mnbu4rnkTwOydyY8LqaKV4Tv7EheWAsRcqrrrU39U
         2aBJUob+b5d2PJ07heax5ZiSkeBLzyUW5M0Xx4S1UVAGrruehrVofhLdsUi+gVmWovBd
         +zRw==
X-Gm-Message-State: AFqh2krMCrL8WdvofCoAum6XfYBdeCrljI+8eFlPEjKOKdddxek7uNDn
        vOAZWrRXBhHtrsET7XOyQitN9GP+q54WM6aYsWjQxg==
X-Google-Smtp-Source: AMrXdXsCy8vynyxh4AU3GM9pr3pm51Ag+IGCft88mylhcRAoyRnQoxx9bZMTerPRX5zPxA07iVr4D6wqLtkheFZelzw=
X-Received: by 2002:a05:6402:551a:b0:49d:feca:266d with SMTP id
 fi26-20020a056402551a00b0049dfeca266dmr151454edb.388.1673921960718; Mon, 16
 Jan 2023 18:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20230112145424.3791276-1-etienne.carriere@linaro.org>
 <20230112145424.3791276-3-etienne.carriere@linaro.org> <20230113204231.GA2873887-robh@kernel.org>
In-Reply-To: <20230113204231.GA2873887-robh@kernel.org>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Tue, 17 Jan 2023 03:19:09 +0100
Message-ID: <CAN5uoS9MrKXUrmR1Y=c9J8D03muBKPJcQk64YFHwOwBO_GX5jw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: optee: add interrupt controller properties
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023 at 21:42, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jan 12, 2023 at 03:54:23PM +0100, Etienne Carriere wrote:
> > Adds optional interrupt controller properties used when OP-TEE generates
> > interrupt events optee driver shall notified to its registered
> > interrupt consumer. The example shows how OP-TEE can trigger a wakeup
> > interrupt event consumed by a gpio-keys compatible device.
>
> Why do we need this in DT? It's not a GPIO key, but an abuse of the
> binding. It looks like unnecessary abstraction to me.

This is when for example OP-TEE world controller a IOs controller
device. When some IOs are relate to OP-TEE feature, the controller
route to OP-TEE handler.
When the IO detection relates to Linux irqs it is routed to Linux,
using optee driver irqchip.
As Linux uses DT for device drivers to get their interrupt (controler
phandle + arg), defining the irqchip in the DT of the platform running
that OP-TEE firmware make sense to me.

The same way OP-TEE can be in charge of the wakeup source controllers
and notify Linxu of event for the wakeup that relate to Linux
services.

>
>
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> >  .../arm/firmware/linaro,optee-tz.yaml         | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > index d4dc0749f9fd..42874ca21b7e 100644
> > --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > @@ -40,6 +40,11 @@ properties:
> >        HVC #0, register assignments
> >        register assignments are specified in drivers/tee/optee/optee_smc.h
> >
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +
> >  required:
> >    - compatible
> >    - method
> > @@ -48,12 +53,24 @@ additionalProperties: false
> >
> >  examples:
> >    - |
> > +    #include <dt-bindings/input/input.h>
> >      #include <dt-bindings/interrupt-controller/arm-gic.h>
> >      firmware  {
> > -        optee  {
> > +        optee: optee {
> >              compatible = "linaro,optee-tz";
> >              method = "smc";
> >              interrupts = <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> > +            interrupt-controller;
> > +            #interrupt-cells = <1>;
> > +        };
> > +    };
> > +
> > +    wake_up {
> > +        compatible = "gpio-keys";
> > +
> > +        button {
> > +            linux,code = <KEY_WAKEUP>;
> > +            interrupts-extended = <&optee 0>;
>
> In the end, you just need optee IRQ #0 to generate KEY_WAKEUP. Does
> either the optee interrupt number or the key code need to be
> configurable? If so, why? Why isn't #0 just wakeup and the driver can
> send KEY_WAKEUP?

The OP-TEE driver is a generic firmware driver. Platforms do not have
specific hooks in it.
A generic DT definition of the irqs exposed by opte driver irqchip
allows consumers to get their irq resource.
I even think 'allows' above could be replaced by is-required-by.

Here, binding KEY_WAKEUP to the OP-TEE firmware related irq line from
the platform DT reuses existing drivers and bindings to get a irq
wkaeup source, signaling KEY_WAKEUP even, when wakeup stouce
controller is assigned to (controller by) OP-TEE world.
This is an example. Maybe the binding are miss used, but I don't see
why. Another example I plan to post is building an mailbox for SMCI
notification from a SCMI service host in OP-TEE. OP-TEE would use this
optee irqchip to get the interrupt related to the SCMI notification
channel. In embedded system, limited resources can be shared by
subsystems.

>
> DT is for non-discoverable hardware that we can't fix. Why repeat that
> for software interfaces to firmware?

Do you mean the optee driver should enumerate the interrupt lines
exposed by OP-TEE and register each line accordingly?
This is doable I guess. But that would not prevent Linux kernel DT to
define a interrupt controller consumer device nodes can refer to for
their need.

BR,
Etienne

>
> Rob
