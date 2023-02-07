Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149E568D536
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjBGLLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjBGLLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:11:47 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8809430F7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:11:46 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id d66so15822390vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 03:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=udATflnRYcLu2dKT7h/lAowcYLDyMDHY6fF/kn+2xc0=;
        b=waFR60uayOwhQR5ZvbTmWsQ5Ufc0ysYiAXXs4rISZt7eU6AEy4CTZ35Z9OMEm+9y1m
         1TAz8v4JVT/LqKuGOMgglbuLsjGtsTymWHjzDR9/kwSyxXR7kww+LflyMMnYzQQxI0Up
         Eazd9aUXwol0wD0QveWjDJWWr80Gf3xHj0ETNlyOcwzzO4Rrlaq9+5deQJsyNPKFLK8b
         4Ycl+iv8PMO6kFMKDJT0gBx2RABULL+YvFl4nxlBqz8g3sObWPGer0wlEDxZjI2iF6x6
         UyfGUnAzvfj914y0IBhQCnOxMdL84U5VUc0rA8DC/orqR3I15xicLwprJJubrbn2JMgo
         8LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udATflnRYcLu2dKT7h/lAowcYLDyMDHY6fF/kn+2xc0=;
        b=lQvxAp4kNYU0qLGpreCIRYU1I4Df05xlJ6KhzcJjti0G8OLe11In8z0/3jMDSokkFl
         /FsykOGmY9ukDLXGQgRfuTlVmP3GB3zz0Bb/tiwhpZs95eSg+kwqEwwE7zX0ADjuXX6P
         N/j/bMEkP60z4+Rpj6FAmhrB+i1hcmkYQfKWH2XbUKDSk8Sr30dC9dyxplYV9be0Kqw1
         osFZTtFRhqS7v+ViM64WKALca4aZgWXJSF9Gvb389cGKefFjLea6FlGYISzjw/A7H80u
         FGGDIMlUMUTbwyf4sFBmqM3cLa3I39a8Lm8KhAJoxo+V4t2sVRokNgXaOEb3kfohiWGS
         1ZfQ==
X-Gm-Message-State: AO0yUKV8i6vQYUWWQY3GcS3n0K0OudZ29JV52bflmnMM4F5Rl2XfbalG
        HSYtXeJdmEvxcsbNCYAmKjXs8vEu9Lhq/t56RBeFBg==
X-Google-Smtp-Source: AK7set8eBmrDb/TQ0DWzHU+ta4TfC00XqqaLD6L3JlhlHjAPR9B/IKqK1xaUemmM1w9ZcsV5jp+euuEubupquSpbjGw=
X-Received: by 2002:a05:6102:3e0a:b0:3d0:d172:3a02 with SMTP id
 j10-20020a0561023e0a00b003d0d1723a02mr530412vsv.41.1675768305662; Tue, 07 Feb
 2023 03:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
 <20230130094157.1082712-2-etienne.carriere@linaro.org> <CAFA6WYMDP88=3+NnrwTm_u99M-1BZe5ob-bo4mQDRA=QZ9xQXw@mail.gmail.com>
 <CAHUa44Hkd10Rby1JViiMxC9OcNjU6Fn6Q7Gvm=bCwPDWpiNqSA@mail.gmail.com>
In-Reply-To: <CAHUa44Hkd10Rby1JViiMxC9OcNjU6Fn6Q7Gvm=bCwPDWpiNqSA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 7 Feb 2023 16:41:34 +0530
Message-ID: <CAFA6WYOgFqKiS8BXaxtc-4cc3zZkRcTGX3PGqzShCAuP1OZDGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: arm_scmi: optee: use optee system invocation
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2023 at 16:09, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Tue, Feb 7, 2023 at 10:59 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Mon, 30 Jan 2023 at 15:12, Etienne Carriere
> > <etienne.carriere@linaro.org> wrote:
> > >
> > > Changes SCMI optee transport to enable sys_service capability of
> > > its tee context to leverage provisioned system resources in OP-TEE
> > > preventing possible deadlock.
> > >
> > > Such deadlock could happen when many Linux clients invoke OP-TEE are
> > > are all suspended waiting for an OP-TEE RPC request access an SCMI
> > > resource through the SCMI OP-TEE PTA service.
> > >
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > ---
> > >  drivers/firmware/arm_scmi/optee.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> > > index 2a7aeab40e54..91840345e946 100644
> > > --- a/drivers/firmware/arm_scmi/optee.c
> > > +++ b/drivers/firmware/arm_scmi/optee.c
> > > @@ -559,6 +559,9 @@ static int scmi_optee_service_probe(struct device *dev)
> > >         if (IS_ERR(tee_ctx))
> > >                 return -ENODEV;
> > >
> > > +       /* SCMI agent can used TEE system service resources */
> > > +       tee_ctx->sys_service = true;
> > > +
> >
> > As per the other thread for patch #1, this feature will only be
> > available with OP-TEE supporting TEE_GEN_CAP_REG_MEM. Can we add a
> > corresponding conditional check here?
>
> What would be gained by that? If a system thread isn't available or
> already is busy we're supposed to fall back to normal threads.
>

Just to make the dependency explicit and probably warn users that the
system is missing a required capability. Earlier I went through a
similar dependency issue report for trusted keys driver. I ended with
a dependency fix [1] to make it easier while debugging when something
doesn't work as intended.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/keys/trusted-keys/trusted_tee.c#n223

-Sumit

> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > >         agent = devm_kzalloc(dev, sizeof(*agent), GFP_KERNEL);
> > >         if (!agent) {
> > >                 ret = -ENOMEM;
> > > --
> > > 2.25.1
> > >
