Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF8C625773
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiKKJ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiKKJ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:57:50 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF95F69DED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:57:48 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p21so3860917plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n206+tJC+Ak/LTNgJlYlC5EPsXYzLVAG5DbuMJ2wVfs=;
        b=Oh8NnHkTZGYHl4wK+rN0tE0AH8GTY8kMKZBJ/7AMmP6Fm/Pkqi3zVVtbTbgRuNld8E
         LcPDJrThOXkBoVw1eg82IinH8hwXTYH0IxHVI3za+ZtCZgfvxvem6F+T5PJ1XMXLUXDm
         2T9/aUyomQa5dgatt1gUS2qJA25wIGglDRXZNrWhFv/3UsqjqWDvVABGc02kX5/dhjxu
         Oe5KT1htM3AAWxrdL7vwwE2mfJHVpLlsV/94Yta/gMo2WKT2XmwhxE3yT3rTj2RAucgy
         gc4m27i38BWxy+haYiEf2yY7EyrzTIliCq2MZqtUzS+3vE7jg81cS254rGVaG0Gy3tlA
         BARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n206+tJC+Ak/LTNgJlYlC5EPsXYzLVAG5DbuMJ2wVfs=;
        b=pIRnSbSAsoG4xkwyoAcFQ69YF5FJ5FdZHeJwuv4XZG3SBDEqWLwYF+8zoUYysYAPup
         YeqgD2blHcP4aHUwOUfDOqrNp6ORKCgR4jhn6idDc7T72YEPA8ysZG682z3IRmcZQ+in
         t010OvwXa1Tfn08hSiX8+BKTMOmhegnNFPipuTSzwzqEAOxIVK3GJ8TxURy/1p9ntcly
         MoEgHmEBiRNdZCJwGJXHab3qfAVtQegIw2ih3Wa1JlACMhBFVsw1vIKISd0EUYnWfX0f
         D8jITm7DogbD/hGXBL0HYpR3OPMUDurDgvm72AtMXgSvIgD4IaopVMkjhG56PH8hgZD6
         7L0A==
X-Gm-Message-State: ANoB5pmNeDagUUSC5BSMUHB6jJgZPM/hERh1jyrZoJRUguOets7nkS7T
        gKHe5kf3/Tk9P4IozZWY1t7BO1j2suox3kIK+dBc+g==
X-Google-Smtp-Source: AA0mqf42XzzdT0veI+pWbithrmi1rQlOURTJCj3sOF3raB7Fwl2H3/LH2Xrty17mU+y6kwEyJ00B2INAn0s8VAeCIz8=
X-Received: by 2002:a17:902:d70e:b0:188:6387:8d8e with SMTP id
 w14-20020a170902d70e00b0018863878d8emr1523689ply.104.1668160668104; Fri, 11
 Nov 2022 01:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20221109160708.507481-1-ludvig.parsson@axis.com>
 <CAFA6WYPxTET4mUQ4YHosbPN1o0UthP6PU=t8bAp91GZL+5rjRA@mail.gmail.com> <df564dc6ffbddcae12bd345b7a0525e586aba5ed.camel@axis.com>
In-Reply-To: <df564dc6ffbddcae12bd345b7a0525e586aba5ed.camel@axis.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 11 Nov 2022 15:27:36 +0530
Message-ID: <CAFA6WYPgW0ya3+yiD49QH3q4nLj1rUyEPye_x2engtihYVaNuA@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Populate child nodes in probe function
To:     =?UTF-8?Q?Ludvig_P=C3=A4rsson?= <Ludvig.Parsson@axis.com>
Cc:     "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 at 17:39, Ludvig P=C3=A4rsson <Ludvig.Parsson@axis.com>=
 wrote:
>
> On Thu, 2022-11-10 at 16:23 +0530, Sumit Garg wrote:
> > On Wed, 9 Nov 2022 at 21:37, Ludvig P=C3=A4rsson <ludvig.parsson@axis.c=
om>
> > wrote:
> > >
> > > Currently there is no dependency between the "linaro,scmi-optee"
> > > driver
> > > and the tee_core. If the scmi-optee driver gets probed before the
> > > tee_bus_type is initialized, then we will get an unwanted error
> > > print.
> > >
> >
> > What error print do you observe? I suppose this case is already
> > handled by scmi optee driver via -EPROBE_DEFER.
> >
> > -Sumit
> >
> Hi Sumit,
>
> The error print is in driver_register().
>
> This is kind of what happens:
> scmi_driver_init()
> scmi_probe()
>     scmi_optee_link_supplier()
>         scmi_optee_init()
>             driver_register() <--- pr_err() if tee_bus_type is not
> initialized
> tee_init() <--- tee_bus_type gets initialized here
>
> The scmi_optee_link_supplier() will always return -EPROBE_DEFER the
> first time because scmi_optee_private is initialized in
> scmi_optee_service_probe, which is only called after the driver is
> registered in scmi_optee_init. Right now the driver_register fails
> because tee_bus_type is not initialized which is printing the unwanted
> error print. Another side effect of this is that
> scmi_optee_link_supplier() will return -EPROBE_DEFER a second time, and
> scmi_probe will be successful the third time instead of the second
> time.

Thanks for the report. It rather looks like an inter subsystem
dependency problem. Check if this [1] patch resolves your problem?

[1] https://lkml.org/lkml/2022/11/11/329

-Sumit

>
> BR,
> Ludvig
>
> > > This patch enables putting scmi-optee nodes as children to the
> > > optee
> > > node in devicetree, which indirectly creates the missing
> > > dependency.
> > >
> > > Signed-off-by: Ludvig P=C3=A4rsson <ludvig.parsson@axis.com>
> > > ---
> > >  drivers/tee/optee/smc_abi.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/tee/optee/smc_abi.c
> > > b/drivers/tee/optee/smc_abi.c
> > > index a1c1fa1a9c28..be6f02fd5a7f 100644
> > > --- a/drivers/tee/optee/smc_abi.c
> > > +++ b/drivers/tee/optee/smc_abi.c
> > > @@ -1533,6 +1533,11 @@ static int optee_probe(struct
> > > platform_device *pdev)
> > >         if (rc)
> > >                 goto err_disable_shm_cache;
> > >
> > > +       /* Populate any dependent child node (if any) */
> > > +       rc =3D devm_of_platform_populate(&pdev->dev);
> > > +       if (rc)
> > > +               goto err_disable_shm_cache;
> > > +
> > >         pr_info("initialized driver\n");
> > >         return 0;
> > >
> > > --
> > > 2.30.2
> > >
>
