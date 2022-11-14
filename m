Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84693627C54
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiKNLaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiKNLaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:30:06 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBCCD1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:30:02 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so27542991ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u1p1y+UF6Xk43U+z9VKlg0UxFcU/tQRigW8NOXQi8iE=;
        b=BOOdnV4e+CI94lCct/Hf9kDU8BmXzPe1PKyf3jRJdPSNfGvtYnroPubcQ6sZ8h8ycC
         RBnfEkibz71BfQS+iQe8zUaVg4fsSUjq1F+QVUR/LMSHT645HRGDxIAEDVZwZ3G7Jm0q
         duqUsWbNIq5nnOmz7DnmOVpocuZSnFc+HUJsGIZef7udBLaNFkCJXapwyZAIXtJ2d3LG
         Fn7pUwyH0zUfKG+iXLYW3fnhZ9XhNVD0mDadrVdyeso3/XO+LvxP3tY1ztO5UMPxCFdK
         M5dESBHseRLL+p+1GGMBrAujBW+UkfqO4D7+jk71LrEhDcYVjgtnArVfwEbX28QH8zDc
         WYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1p1y+UF6Xk43U+z9VKlg0UxFcU/tQRigW8NOXQi8iE=;
        b=d3IXWNsF5hsC8mRZX2l4yU7T9XIueqk63dXj5DPFcsL+XowjdycTdhoEUb2gPvzHaS
         sGtcUTN1CzK9/F6oZvNUKW8Q7CC1CHltO9bRCsC48CvnVR1XuIo59WTmoI1kl27gaktk
         2h9O0dEJAAIMPwjCsFUGzTC2nMTZ6nBpNEOYRjoj24deImgcl0L/RfGI14UBNekpivoy
         9fxko32lUJuvAD0BPs4CBhA+hmOESJ7oUVa2xvUbsYvyWSZHvTNfV0Exe6UatbjFhQWN
         2wTg1Xgc3Y9pWVqTKyqk38a49V0FRKkZGiQVFi7cEAZP6XayeFh5Y6Ulgz5GJ4phxPtR
         FlHg==
X-Gm-Message-State: ANoB5pnsY2nE4IhQSlejx5TdZ8ZSBnoZcILl0bwp2UO7r9fmLcXlXvIF
        Gied8pLEI6fE41aHD8t2B+xGqoRBcA7i7DjHcSpG7A==
X-Google-Smtp-Source: AA0mqf7fsTO9ULuDUc+28iwiT2hlwIJ+sNp8ZjDa3qPF6K1y/TCel7c05YWh8DU//iwIITMTaX9GdzrgUoqMzJFK5C8=
X-Received: by 2002:a17:906:26c3:b0:76c:42b4:dea4 with SMTP id
 u3-20020a17090626c300b0076c42b4dea4mr9502606ejc.515.1668425401411; Mon, 14
 Nov 2022 03:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20221111095313.2010815-1-sumit.garg@linaro.org>
 <20221111143800.k7xje6g23ujefnye@bogus> <CAFA6WYMdNjbMRZxt3iicmKOhQa3ax7_HYtqmNN9bmpndqT8e9A@mail.gmail.com>
 <20221114102650.qwkaxtnstujaiu6u@bogus>
In-Reply-To: <20221114102650.qwkaxtnstujaiu6u@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Mon, 14 Nov 2022 12:29:50 +0100
Message-ID: <CAN5uoS8SArNmaxwhJ=tRCPD8ue1D8VvQyLacDDS2sunfg4gLbw@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Resolve dependency with TEE subsystem
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        linux-arm-kernel@lists.infradead.org, cristian.marussi@arm.com,
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

Hello all,

On Mon, 14 Nov 2022 at 11:26, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Nov 14, 2022 at 12:01:32PM +0530, Sumit Garg wrote:
> > Hi Sudeep,
> >
> > On Fri, 11 Nov 2022 at 20:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Fri, Nov 11, 2022 at 03:23:13PM +0530, Sumit Garg wrote:
> > > > The OP-TEE SCMI transport channel is dependent on TEE subsystem to be
> > > > initialized first. But currently the Arm SCMI subsystem and TEE
> > > > subsystem are invoked on the same initcall level as subsystem_init().
> > > >
> > > > It is observed that the SCMI subsystem initcall is invoked prior to TEE
> > > > subsystem initcall. This leads to unwanted error messages regarding TEE
> > > > bus is not present yet. Although, -EPROBE_DEFER tries to workaround that
> > > > problem.
> > > >
> > > > Lets try to resolve inter subsystem dependency problem via shifting Arm
> > > > SCMI subsystem to subsystem_init_sync() initcall level.
> > > >
> > >
> > > I would avoid doing that. We already have some implicit dependency with
> > > subsys_initcall because this driver creates/registers bus and need to be
> > > done early.
> >
> > Yeah but that should work fine with subsystem_init_sync() too unless
> > you have drivers being registered on the bus at subsystem_init_sync()
> > initcall which doesn't seem to be the case in mainline. Have a look at
> > usage of subsystem_init_sync() elsewhere to see its similar usage to
> > resolve dependencies among different subsystems.
> >
> > However, if you are too skeptical regarding this change then we can
> > limit it to OP-TEE transport only as follows:
> >
> > diff --git a/drivers/firmware/arm_scmi/driver.c
> > b/drivers/firmware/arm_scmi/driver.c
> > index f43e52541da4..19c1222b3dfc 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -2667,7 +2667,11 @@ static int __init scmi_driver_init(void)
> >
> >         return platform_driver_register(&scmi_driver);
> >  }
> > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
> >  subsys_initcall_sync(scmi_driver_init);
> > +#else
> > +subsys_initcall(scmi_driver_init);
> > +#endif
> >
>
> If this is the only way to solve, I would prefer to keep it unconditional.
>
> >  static void __exit scmi_driver_exit(void)
> >  {
> >
> > > Now in order to solve the dependency between SCMI and TEE,
> > > both of which creates/registers bus and are at same subsys_initcall,
> > > we are relying on subsys_initcall_sync.
> >
> > True.
> >
> > >
> > > Me and Ludvig discussed this in private and I suggested him to do something
> > > like below patch snippet. He mentioned he did post a patch on the list but
> > > I couldn't find it. For this the scmi node must be child node of OPTEE as
> > > it is providing the transport.
> >
> > TBH, the first thought that came to mind after looking at SCMI OP-TEE
> > DT node was that why do we need it when those properties can be probed
> > from SCMI pseudo TA at runtime? Maybe I am missing something as I
> > wasn't involved in its review process.
> >
>
> I don't have internal details OPTEE and may be it could be probed. Etienne
> can comment on that. But we need SCMI node in general as the consumers of
> the SCMI are in the DT and they need to link to the provider.

Indeed the SCMI OP-TEE service is currently designed to be discovered
by Linux but it does not allow Linux to discover which resources are
related to the exposed SCMI channels. As Sudeep said, these
information are provided by the DT. Moreover, consumer devices of the
SCMI services in Linux are using DT to reference the SCMI resource
used, as phandles on SCMI clock provider, SCMI regulator provider
etc... For the consumers, we need these DT descriptions.


>
> > The whole idea of TEE bus evolved from the idea that if the firmware
> > bits can be probed at runtime then we shouldn't use DT as a dumping
> > ground for those. I hope you remember discussions around discoverable
> > FF-A bus too.
> >
>
> Exactly this is what I thought of initially when I proposed the solution.
> And yes we won't even have DT node for TEE in that case, so it shouldn't
> be a problem. When both SCMI and TEE are present in DT and SCMI used OPTEE
> as a transport I see it is correct to represent them as child and parent
> and it can be utilised here to solved the problem with respect to the driver
> model without having to play around with the initcall levels which is always
> going to bite us back with one extra dependency.
>
> And with FF-A, TEE and SCMI all in the mix we might have that dependency
> already, so I really want to avoid playing with initcall levels just to solve
> this problem.

Even with FFA, the optee driver still registers from module_init level
(== device_init level initcall), as when using legacy OP-TE SMC ABI.
SCMI firmware driver is initialized from subsys_init level hence
before optee driver. So I think SCMI optee transport relies on the
same dependencies whatever OP-TEE is using FFA ABI or its legacy SCM
ABI.

Device discovery from OP-TEE bus will always need to wait for the
OP-TEE bus to be ready.
This is currently archived for scmi/optee by returning -EPROBE_DEFER
from  scmi_optee_link_supplier() (scmi_transport_ops::link handler
from scmi/optee).
@Luvig, your initial issue is that driver_register() prints an error
trace when one registers a driver for a bus device that is not setup,
not an issue with dependencies, right?

Regards,
Etienne

>
> > However, the change below is simply an incorrect way to fix the actual
> > inter subsystem dependency problem via DT. How would this fix the
> > problem in the case OP-TEE driver registers on FF-A bus? There won't
> > be any DT node for OP-TEE in that case.
> >
>
> Agreed and this is why I thought it in the first place. As I mention in this
> case there are no DT nodes and hence we can't use this at all. I am suggesting
> this only when both DT nodes are present and SCMI depends on OPTEE transport
> which fits the child/parent hierarchy irrespective of this solution. This
> is just ensuring any dependent DT nodes are populated only after OPTEE is
> ready. I don't see this to be an issue or see this as incorrect.
>
>
> Also I am not sure this initcall juggling will help if there are 3 or more
> at the same level, we need to rely on driver model and/or proper hierarchy
> in the DT node. The whole links between devices is modelled on that and
> I don't see that as any issue and we are not dumping any more information
> that it is already in DT. We are just using the correct hierarchical
> representation here IMO.
>
> --
> Regards,
> Sudeep
