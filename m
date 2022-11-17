Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378F762D743
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbiKQJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbiKQJlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:41:46 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B0A59177
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:41:45 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 130so1243931pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1D/4w6h8OupdOPZxoThWXmvkI2OckLw7bE1GNpVgSAY=;
        b=Hoplveb72E1kVV/tE+2VbWw655MAZUrf6InZZdIZ3gDRxvQZOT+uKVOsWYOVxt7h5i
         pUO1shKleBno3H03+VmXvzJ9KPXmG8cPEFc3Jwilm1dh+7ykT+AF16ARmB7A4OLIG3Me
         8M5TJpTVH9XLQ9h05XSbO5fDlZAPfDhdCjduf23yhLnxlLPoKtNm8p4CS35HDatOQfh6
         m12brYNKycQ73/bThnix5asjlNmR2QYiL7xiJqE5N1k8q0Ky7XHJrV1Hb2rdrhzWx1Hj
         RYLYd/RlrtTcBB74nyklZ5rqWnRxtv6Hyk7pCjcCQPO28rsmkwcdpbcJi92ncEE96jtF
         lIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1D/4w6h8OupdOPZxoThWXmvkI2OckLw7bE1GNpVgSAY=;
        b=Ug2BVDuWXEgIF/59mHMh3TORs10iMXZ4iRwRaDhGbrPmqMjXE6kzVJqSnGSwVjObMj
         kvhknCpupOh1kK4HDd25/bCtaQyqLJzpuv82UWq9f1JxZ9TgTdyxMxJkdPSNmAk85tzo
         VCE/WJBTKWsmIsxQkZcDb1SmOtCXPpKZ8pnwySDh1C0i//zpJqDbXkb3UFkaucSrjBL+
         xKvyHz7rZZNAYB8anVKz87KVfgBW7WXCIjPklQfZSANMazxDAdbDD74bIKtOSwjzpo6t
         Z6+LS9KrI0YlfNfxu+5XZ7c54o9la0zltVkYdK9rGcVz7lFTaFi9Y6Ucl2KMqybft6iz
         st/Q==
X-Gm-Message-State: ANoB5pkIr5LJqFk86snuPn3afgQPgzA3v1Kvg9MEGbg1RoAHGp8bzUbC
        5PDZkG0Rt0+vJy5xBZJE2JrLPMoTcS3mR2w6g+65iA==
X-Google-Smtp-Source: AA0mqf4gULB1LtcsLSIa7Vl1Mff64cCZcDJDY9gtPL5+oKPdRQO/IOn+xYwQawelB/fwFLX78I21JvCg3dtZe/dt3Tg=
X-Received: by 2002:a63:1015:0:b0:470:5f22:1496 with SMTP id
 f21-20020a631015000000b004705f221496mr1250856pgl.585.1668678104787; Thu, 17
 Nov 2022 01:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20221111095313.2010815-1-sumit.garg@linaro.org>
 <20221111143800.k7xje6g23ujefnye@bogus> <CAFA6WYMdNjbMRZxt3iicmKOhQa3ax7_HYtqmNN9bmpndqT8e9A@mail.gmail.com>
 <20221114102650.qwkaxtnstujaiu6u@bogus> <CAN5uoS8SArNmaxwhJ=tRCPD8ue1D8VvQyLacDDS2sunfg4gLbw@mail.gmail.com>
In-Reply-To: <CAN5uoS8SArNmaxwhJ=tRCPD8ue1D8VvQyLacDDS2sunfg4gLbw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 17 Nov 2022 15:11:32 +0530
Message-ID: <CAFA6WYPwku8d7EiJ8rF5pVh568oy+jXMXLdxSr6r476e0SD2nw@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Resolve dependency with TEE subsystem
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, cristian.marussi@arm.com,
        Ludvig.Parsson@axis.com, jens.wiklander@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 at 17:00, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Hello all,
>
> On Mon, 14 Nov 2022 at 11:26, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Mon, Nov 14, 2022 at 12:01:32PM +0530, Sumit Garg wrote:
> > > Hi Sudeep,
> > >
> > > On Fri, 11 Nov 2022 at 20:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Fri, Nov 11, 2022 at 03:23:13PM +0530, Sumit Garg wrote:
> > > > > The OP-TEE SCMI transport channel is dependent on TEE subsystem to be
> > > > > initialized first. But currently the Arm SCMI subsystem and TEE
> > > > > subsystem are invoked on the same initcall level as subsystem_init().
> > > > >
> > > > > It is observed that the SCMI subsystem initcall is invoked prior to TEE
> > > > > subsystem initcall. This leads to unwanted error messages regarding TEE
> > > > > bus is not present yet. Although, -EPROBE_DEFER tries to workaround that
> > > > > problem.
> > > > >
> > > > > Lets try to resolve inter subsystem dependency problem via shifting Arm
> > > > > SCMI subsystem to subsystem_init_sync() initcall level.
> > > > >
> > > >
> > > > I would avoid doing that. We already have some implicit dependency with
> > > > subsys_initcall because this driver creates/registers bus and need to be
> > > > done early.
> > >
> > > Yeah but that should work fine with subsystem_init_sync() too unless
> > > you have drivers being registered on the bus at subsystem_init_sync()
> > > initcall which doesn't seem to be the case in mainline. Have a look at
> > > usage of subsystem_init_sync() elsewhere to see its similar usage to
> > > resolve dependencies among different subsystems.
> > >
> > > However, if you are too skeptical regarding this change then we can
> > > limit it to OP-TEE transport only as follows:
> > >
> > > diff --git a/drivers/firmware/arm_scmi/driver.c
> > > b/drivers/firmware/arm_scmi/driver.c
> > > index f43e52541da4..19c1222b3dfc 100644
> > > --- a/drivers/firmware/arm_scmi/driver.c
> > > +++ b/drivers/firmware/arm_scmi/driver.c
> > > @@ -2667,7 +2667,11 @@ static int __init scmi_driver_init(void)
> > >
> > >         return platform_driver_register(&scmi_driver);
> > >  }
> > > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
> > >  subsys_initcall_sync(scmi_driver_init);
> > > +#else
> > > +subsys_initcall(scmi_driver_init);
> > > +#endif
> > >
> >
> > If this is the only way to solve, I would prefer to keep it unconditional.
> >
> > >  static void __exit scmi_driver_exit(void)
> > >  {
> > >
> > > > Now in order to solve the dependency between SCMI and TEE,
> > > > both of which creates/registers bus and are at same subsys_initcall,
> > > > we are relying on subsys_initcall_sync.
> > >
> > > True.
> > >
> > > >
> > > > Me and Ludvig discussed this in private and I suggested him to do something
> > > > like below patch snippet. He mentioned he did post a patch on the list but
> > > > I couldn't find it. For this the scmi node must be child node of OPTEE as
> > > > it is providing the transport.
> > >
> > > TBH, the first thought that came to mind after looking at SCMI OP-TEE
> > > DT node was that why do we need it when those properties can be probed
> > > from SCMI pseudo TA at runtime? Maybe I am missing something as I
> > > wasn't involved in its review process.
> > >
> >
> > I don't have internal details OPTEE and may be it could be probed. Etienne
> > can comment on that. But we need SCMI node in general as the consumers of
> > the SCMI are in the DT and they need to link to the provider.
>
> Indeed the SCMI OP-TEE service is currently designed to be discovered
> by Linux but it does not allow Linux to discover which resources are
> related to the exposed SCMI channels. As Sudeep said, these
> information are provided by the DT. Moreover, consumer devices of the
> SCMI services in Linux are using DT to reference the SCMI resource
> used, as phandles on SCMI clock provider, SCMI regulator provider
> etc... For the consumers, we need these DT descriptions.
>

So it's the DT legacy we want to maintain for the SCMI subsystem even
if the underlying transport is discoverable? This simply undermines
the benefits of a discoverable TEE bus over the non-discoverable
platform bus. Also, the reluctance to carry forward SCMI subsystem DT
legacy has resulted in misrepresentation of SCMI OP-TEE transport as
follows:

    First represented as a platform device via DT (compatible =
"linaro,scmi-optee";) and then
    Migrated to being a TEE bus device (UUID: 0xa8cfe406, 0xd4f5,
0x4a2e, 0x9f, 0x8d, 0xa2, 0x5d, 0xc7, 0x54, 0xc0, 0x99)

This misrepresentation is the reason for the indirect DT hack that
Sudeep suggested to fix the error message while registering a driver
on TEE bus.

Is it not possible for SCMI subsystem to evolve and support underlying
transport on a discoverable TEE bus?

>
> >
> > > The whole idea of TEE bus evolved from the idea that if the firmware
> > > bits can be probed at runtime then we shouldn't use DT as a dumping
> > > ground for those. I hope you remember discussions around discoverable
> > > FF-A bus too.
> > >
> >
> > Exactly this is what I thought of initially when I proposed the solution.
> > And yes we won't even have DT node for TEE in that case, so it shouldn't
> > be a problem.

Why? The SCMI OP-TEE transport driver will still be registered on TEE
bus via subsys_initcall() prior to TEE bus being registered via
subsys_initcall().

> > When both SCMI and TEE are present in DT and SCMI used OPTEE
> > as a transport I see it is correct to represent them as child and parent

No it's not the correct representation. Devices on the TEE bus have
nothing to do with DT. The OP-TEE node in DT represents a particular
TEE implementation whereas there are other ways to represent OP-TEE
implementation as a device on FF-A bus.

Your suggested change only works due to misrepresentation of SCMI
OP-TEE transport as highlighted above while it won't fix the case with
OP-TEE device on FF-A bus.

> > and it can be utilised here to solved the problem with respect to the driver
> > model without having to play around with the initcall levels which is always
> > going to bite us back with one extra dependency.
> >

As I mentioned in the patch description, it's an inter-subsystem
dependency. It has to be solved via initcall levels. I am unsure which
extra dependency you have in mind but the one mentioned below doesn't
fall into that category. Have you looked at other places within the
kernel for usage of subsys_initcall_sync()?

> > And with FF-A, TEE and SCMI all in the mix we might have that dependency
> > already, so I really want to avoid playing with initcall levels just to solve
> > this problem.

There isn't a three level dependency here. The only dependency we have
to solve is that the SCMI OP-TEE transport shouldn't register on TEE
bus prior to registration of TEE bus. And switching SCMI subsystem to
subsys_initcall_sync() fixes that dependency even with OP-TEE FF-A
ABI.

>
> Even with FFA, the optee driver still registers from module_init level
> (== device_init level initcall), as when using legacy OP-TE SMC ABI.
> SCMI firmware driver is initialized from subsys_init level hence
> before optee driver. So I think SCMI optee transport relies on the
> same dependencies whatever OP-TEE is using FFA ABI or its legacy SCM
> ABI.
>

I guess here you are confusing the TEE subsystem driver invoked at
subsys_initcall() versus OP-TEE driver invoked at module_init(). The
TEE bus is registered by the TEE subsystem driver rather than the
OP-TEE driver.

So there is *no* dependency among SCMI firmware driver and OP-TEE
driver but rather the dependency is with TEE subsystem driver instead.

> Device discovery from OP-TEE bus will always need to wait for the
> OP-TEE bus to be ready.

It isn't an OP-TEE bus but rather a TEE bus with underlying TEE
implementations like OP-TEE etc. registering their corresponding
devices.

-Sumit
