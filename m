Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1646FE0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbjEJO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbjEJO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:58:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC216A4B
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:58:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9659f452148so1298253466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683730711; x=1686322711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w/UBHPKxIZ4JawY5ZT352GPCH+e08nQLi6u7hwlLAXc=;
        b=j+zo9oYaEuy0CQ1yPYewsqZT8iOyo7nqk9+FS1hlC6qw557hqfck+/+BW1lj6GPgXZ
         HDAfbXHofDfmmqD2Ac0/BDIxfzfMe7xDqq0I/ix0G3tz5vI9S+lxZwOhgiOipsxJc0Yl
         d79EB2ZO5SMXn599gIj533042J8wF7fRBBxMo9LJOGhSyKtezrkOb2CS4mPzUzEqcQq+
         DmlmrIC7e8958Fij8tEqgFlomjXfBpiZZ32xxIleGaXBnTdciW4YqE7VXQP4LhOrWlEi
         6/UihfJX3NeiOVf3h9SCOwiRTGowtRjdmdmNEani6cvO74KMcMB1BwZZg9iUhM2gnVtj
         j/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683730711; x=1686322711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/UBHPKxIZ4JawY5ZT352GPCH+e08nQLi6u7hwlLAXc=;
        b=ViQEqGMFdoSDoqTxXyKeHuHKFOwqW39nqM04HeC+uLKtmWWc0P0zZZj3ZIvGlpYCC4
         8Dt9ex7Sx0fQdo0A8dXO+1TfSZASV4rpWXEUm2ts9kjW0rN22rz7jNDEPGnwMqpFakC8
         bEUo016KPJVd9glRTj8wqJBmv3OiyEfal+jRFMY0ofi1rvOQviPIZCR8/OrAjcdAKqvO
         Myte4Nj1UTOeJIVWpDHBNNbqRNhW8qBZxkg16L/LXL9SJyruZqT9CqsR6g10JbczWZau
         e4xX5ZUsA5Kb+UMtfHYqA/Jnvf4vdTxKhIhHHHbi76RgPBP7XGwYWAUKjkayGhaszhSO
         IECA==
X-Gm-Message-State: AC+VfDws8wJfrshz7UEDVGTxyh+pkG0BESNz7x+gTe1xYyivM4ASUlrp
        DVOqGuwoWatW/QZ8a/il2b+Uca5Dkwqp9hBgj14piw==
X-Google-Smtp-Source: ACHHUZ7oL9DXclxaSedBSFf8N2z5uwXAKyVZCgk8oUZzhxWZOqTyR9x4tBt3VEqdqYrfgTSxz1Eg9c9w4VUC1CxzZhQ=
X-Received: by 2002:a17:907:940e:b0:950:e44:47ae with SMTP id
 dk14-20020a170907940e00b009500e4447aemr17373264ejc.40.1683730711623; Wed, 10
 May 2023 07:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230505184318.1355446-1-etienne.carriere@linaro.org> <CAFA6WYOfFm9R2GynH0bN7hQ4t81T3hkJX5JurCUDG8oOU-RZ4w@mail.gmail.com>
In-Reply-To: <CAFA6WYOfFm9R2GynH0bN7hQ4t81T3hkJX5JurCUDG8oOU-RZ4w@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 10 May 2023 16:58:20 +0200
Message-ID: <CAN5uoS8QCL+s2Kt0QSBAz4B84KWPKFhVYNG=+3T=rtdvK-jwEw@mail.gmail.com>
Subject: Re: [PATCH] char: tpm: ftpm_tee: use kernel login identifier
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sumit,

On Wed, 10 May 2023 at 12:24, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Etienne,
>
> On Sat, 6 May 2023 at 00:14, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Changes fTPM TEE driver to open the TEE session with REE kernel login
> > identifier rather than public login. This is needed in case fTPM service
> > it denied to user land application and restricted to kernel operating
> > system services only.
>
> This is a valid restriction to avoid any unintended use of fTPM by
> user-space. But has the corresponding patch landed in fTPM TA which
> would enforce this restriction?

Not yet. Actually, I've posted some other change requests in the repo
[1]  but got no feedback. Not nice from me but I didn't post any other
changes since.
In the mean time, I think Linux kernel should be ready for this before
fTPM implementation is fixed.
Note that U-Boot already integrate this login identifier change, see [2].

[1] https://github.com/microsoft/ms-tpm-20-ref/pull/83
[2] https://source.denx.de/u-boot/u-boot/-/commit/33ba80303e93869c439828dd289fb8ef64ed3bfc

Best regards,
Etienne

>
> -Sumit
>
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> >  drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> > index 528f35b14fb6..6d32e260af43 100644
> > --- a/drivers/char/tpm/tpm_ftpm_tee.c
> > +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> > @@ -241,7 +241,7 @@ static int ftpm_tee_probe(struct device *dev)
> >         /* Open a session with fTPM TA */
> >         memset(&sess_arg, 0, sizeof(sess_arg));
> >         export_uuid(sess_arg.uuid, &ftpm_ta_uuid);
> > -       sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> > +       sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> >         sess_arg.num_params = 0;
> >
> >         rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
> > --
> > 2.25.1
> >
