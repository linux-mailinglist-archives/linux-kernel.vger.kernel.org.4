Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69556FEB08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbjEKFHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbjEKFG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:06:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0794E3A82
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:06:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-966287b0f72so1029544366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683781612; x=1686373612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ObDKyM8SX+0UqX+mAIg4MkhraaGDH1WX7ttcTrJfPxM=;
        b=eYX/B5tdCWC5hzH6/2bxXrb4WOp/vhHCrUth0dV9y/8pCU9fMS4uA5Cw01mTJtlCLw
         iOdqETMuZK7DZsjVcjQwyO8N5/q9ykbqILsAlgTzO49Wc5VoCR3x1wKCoxQmMWWLWojL
         XAsI3jslb6mNQWVmUL3sZmsDDty7i8VpQcrIvKqJARwdSbSnYSihdafvgmJDhJFb65br
         MwNH0HLTxIhlAsHHo8XLA/XaJlLIyYYp9MbLfCiA7r0AXqnjZCQ1GJo0ujLvifgEyG9X
         MXaqm+HIspmyIfGN3t85RrK9RCUFKxoPxZlQyzv1f+rE3dAnVGfdg9BvgkOmUlt/lFcC
         TJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683781612; x=1686373612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObDKyM8SX+0UqX+mAIg4MkhraaGDH1WX7ttcTrJfPxM=;
        b=X4oe6Kt1bWAAGe6yqCBxG87CSm7hzS43+394bzlLSXSnsXIX/vj+CGjY+U/ZpgBFr3
         G50BDjsspei403Djc/uxGrrP7JpoJoUdArMepn7E56NZbp/VygpJLEWmdiljCdIUuHKy
         OHhihuqFF4Fua3PAHuUWkzzpgLGu9/IjRgJai1KEwciRSiouov7QcQtJUUjHUNJ9Hb4Z
         CeSaB8U+wroE83jffZVh6CrYLT1rw4UsE5wvfsFoGUz++ks/rqy6gKC5qLqsIrKMYus9
         fe8b0rGMt5vyi+8fT3Dtmdu+19vdo2BVFm1lSUp4dYtFqZHTUMGWaIEYN+CpxCjmY0T1
         Bzfw==
X-Gm-Message-State: AC+VfDxLH6KwSEQx/0dlb6dKnf9EHQm2ApySMz2QOlRgaENf35JFvAVc
        AwPqKHn6923A+sgxGLmiGTs30G2SexlYdzG4s5YJbcFHvNAnGrMlsZE=
X-Google-Smtp-Source: ACHHUZ72y8WNM+Hmf70DMBI+IqrAD6j9u9wcZ6cbv1cMCRgqiOr1ZyElft8zz1Sme4zCWA+T26cfXJNCoTFG3/c6JKk=
X-Received: by 2002:a17:907:d86:b0:94a:9c4e:d2e9 with SMTP id
 go6-20020a1709070d8600b0094a9c4ed2e9mr18714773ejc.0.1683781612520; Wed, 10
 May 2023 22:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230505184318.1355446-1-etienne.carriere@linaro.org>
 <CSIXYHYSW45R.O3II0HIIHZV4@suppilovahvero> <CAN5uoS8xB7=Ohu4WEA31hGraVBcaOmRxZw9PDtXBLGUMUeB=4Q@mail.gmail.com>
In-Reply-To: <CAN5uoS8xB7=Ohu4WEA31hGraVBcaOmRxZw9PDtXBLGUMUeB=4Q@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 11 May 2023 07:06:41 +0200
Message-ID: <CAN5uoS9UTc-Lz1+k=-7nifuv8MrRmZh_1ck3-DgwRSF58EwpxQ@mail.gmail.com>
Subject: Re: [PATCH] char: tpm: ftpm_tee: use kernel login identifier
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dearl all,

Typo in my previous post!

On Thu, 11 May 2023 at 06:47, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Hello Jarkko,
>
> On Thu, 11 May 2023 at 00:12, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Fri May 5, 2023 at 9:43 PM EEST, Etienne Carriere wrote:
> > > Changes fTPM TEE driver to open the TEE session with REE kernel login
> > > identifier rather than public login. This is needed in case fTPM service
> > > it denied to user land application and restricted to kernel operating
> > > system services only.
> > >
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> >
> >
> > Can you bring up a little context here?
> >
> > What is REE login?
> > Does it break backwards compatibility to switch?
> > What kind of scenario we are talking about? What does it mean in plain
> > English when fTPM service is denied.
> > What is fTPM service?
>
> By fTPM service I meant the services exposed by fTPM through its
> OP-TEE interface, that are the commands a client can invoke in fTPM,
> see [1].
>
> Regarding backward compatibility, this change is backward compatible
> as far as the OP-TEE entity this driver communicates with is of
> revision 3.9.0 or above.
> I understand this case should be addressed in some way.
>
> In current implementation, fTPM can be invoked by Linux kernel drivers
> (through Linux kernel tee API as tpm_ftpm_tee currently does) as well
> as by userland application (through TEE client library API [2]).
> This change makes tpm_ftpm_tee to invoke fTPM interface using a client
> identifier stating it is the Linux kernel that invokes it, not a
> userland application. fTPM implementation does not check the client
> identity when a client opens a session toward it. Therefore using a
> public identifier (TEE_IOCTL_LOGIN_PUBLIC) or the OS privilege
> identifier (TEE_IOCTL_LOGIN_REE_KERNEL) does not matter, as far as
> OP-TEE supports these IDs. The former is native to OP-TEE initial UAPI
> [3], the latter was introduced in OP-TEE 3.9.0 [4] and Linux kernel
> v5.8 [5].
>
> That said, this change does fix an existing issue in fTPM integration.

Typo, sorry, I meant
"That said, this change does **NOT** fix an existing issue in fTPM integration."

BR,
Etienne

> The fTPM entity currently only accepts a single session opened towards
> it. This is enforced as fTPM sets property TA_FLAG_SINGLE_INSTANCE and
> does not set property TA_FLAG_MULTI_SESSION [6].
> Linux kernel tpm_ftpm_tee driver currently opens a session to fTPM at
> probe time and releases it at remove time so once the driver is
> successfully probed, no userland application can use TEE userland
> client API to open another session and communicate with fTPM.
>
> [1] https://github.com/microsoft/ms-tpm-20-ref/blob/main/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/fTPM.c#L456
> [2] https://github.com/OP-TEE/optee_client
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=967c9cca2cc50569efc65945325c173cecba83bd
> [4] https://github.com/OP-TEE/optee_os/commit/78f462f646e7c037bea13aa6282c81f255922a4f
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=104edb94cc4b3101bab33161cd861de13e85610b
> [6] https://github.com/microsoft/ms-tpm-20-ref/blob/main/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_defines.h#L47
>
> Regards,
> Etienne
>
> >
> > > ---
> > >  drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> > > index 528f35b14fb6..6d32e260af43 100644
> > > --- a/drivers/char/tpm/tpm_ftpm_tee.c
> > > +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> > > @@ -241,7 +241,7 @@ static int ftpm_tee_probe(struct device *dev)
> > >       /* Open a session with fTPM TA */
> > >       memset(&sess_arg, 0, sizeof(sess_arg));
> > >       export_uuid(sess_arg.uuid, &ftpm_ta_uuid);
> > > -     sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> > > +     sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> > >       sess_arg.num_params = 0;
> > >
> > >       rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
> > > --
> > > 2.25.1
> >
> > BR, Jarkko
