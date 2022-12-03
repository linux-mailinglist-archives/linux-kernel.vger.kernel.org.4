Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A5564187F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 19:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLCS6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 13:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLCS6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 13:58:52 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A7E65D7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 10:58:51 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so4895106otb.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 10:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iggn9NGaBvUPIp9zkjxeRVT+n0l+Sec5shJh8MQOX88=;
        b=bETcumAGBoOkqCscoCWsAb9+VL8QJ4WYzfM9YwIbtFnxZZnkdzXkQxqkPkEiml3UNy
         6MpGfVPEY+7rdGbUDRxefD5L58gMWHc4si8wf6AEEq2BMSG+epZ4HsB00jsUwuTm+wqi
         PAnXWifpVnXZN5sF4d+IxF47CM2FUnvhsZ+T7mRTwX36xRp7cyU3bT1W8jDsQMok4w0p
         rXs9lGaYMBcMFl19X33SZi2cdbQoSHzM137/zszlECFS500PSW0NWc6/33CEpP0y/5j6
         EaM7gSjx13boV272Qa8+6uybZFSPzDSOua/IVIFP///a48XSLEJcJynuHMtAMqGF3mLM
         X4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iggn9NGaBvUPIp9zkjxeRVT+n0l+Sec5shJh8MQOX88=;
        b=iwQzsJpwjhLRRnUHVpJQ6p6uLtYYvXe/3Oo2tE55wSrUoFYz+qdZUaHe1lffTwm8LJ
         mzStlptTvsLIDNuwKGRAQ9o5Zl2GpoaRL3KQ1nKGKH7ZtdTAq17gsAQWDDdJ7GCDIlTT
         xuIANabNRLSJiPPxHeNTfS1mfZg0NW65URPIhnU0wklDwNFCrWbfqBm40OL3uPOnRSTc
         xKVUyJxkUWFTaZJ/RUCdTLmRTN/gVUau4ApBcb+ZjY6X8nkV7aHrbDHlJ1GJgHAbyiiG
         gA4uoAzHhm2NDZFuvj8YcG/KxyIHt4gKk8InYrQbPmIUEzGrsKdE8nZkpNTqpmv3UvNE
         zUxQ==
X-Gm-Message-State: ANoB5pl7L91xpR4Z8UZ0vsGwmy5bUTkijWobRIfXPIE/H4w3dRTk0cft
        bwSzdKSTBkzwF1fCpWSGfILhLwrtYhy/ysF7PfSb9g==
X-Google-Smtp-Source: AA0mqf69Wlr1Sqf1QUB1hB56pyNvv+V5gCvrMjCw5AhhPdowZYn157WLhf6oeUi4BN2MbO74ecthzdHT43CJxAPx1vc=
X-Received: by 2002:a9d:6e19:0:b0:66c:a613:9804 with SMTP id
 e25-20020a9d6e19000000b0066ca6139804mr37375296otr.65.1670093930526; Sat, 03
 Dec 2022 10:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-2-dionnaglaze@google.com> <Y4tAX580jEGHOU9d@zn.tnic>
In-Reply-To: <Y4tAX580jEGHOU9d@zn.tnic>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Sat, 3 Dec 2022 10:58:39 -0800
Message-ID: <CAAH4kHYz-46syE4wKPzo1N9P34wLHcs85obOCjqb6eQ=iv=n3w@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Gonda <pgonda@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 3, 2022 at 4:26 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Nov 04, 2022 at 11:00:37PM +0000, Dionna Glaze wrote:
> > From: Peter Gonda <pgonda@google.com>
> >
> > The PSP can return a "firmware error" code of -1 in circumstances where
> > the PSP is not actually called. To make this protocol unambiguous, we
>
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.
>
> > add a constant naming the return value.
> >
> > Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Joerg Roedel <jroedel@suse.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Andy Lutomirsky <luto@kernel.org>
> > Cc: John Allen <john.allen@amd.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: "David S. Miller" <davem@davemloft.net>
> >
> > Signed-off-by: Peter Gonda <pgonda@google.com>
> > Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> > ---
> >  drivers/crypto/ccp/sev-dev.c | 2 +-
> >  include/uapi/linux/psp-sev.h | 7 +++++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> > index 06fc7156c04f..97eb3544ab36 100644
> > --- a/drivers/crypto/ccp/sev-dev.c
> > +++ b/drivers/crypto/ccp/sev-dev.c
> > @@ -444,7 +444,7 @@ static int __sev_platform_init_locked(int *error)
> >  {
> >       struct psp_device *psp = psp_master;
> >       struct sev_device *sev;
> > -     int rc = 0, psp_ret = -1;
> > +     int rc = 0, psp_ret = SEV_RET_NO_FW_CALL;
> >       int (*init_function)(int *error);
> >
> >       if (!psp || !psp->sev_data)
>
> Ok, lemme chase down this flow here:
>
> __sev_platform_init_locked() calls that automatic variable function
> pointer ->init_function which already looks funky. See the end of this
> mail for a diff removing it and making the code more readable.
>

I'm fine removing it if possible for the sev-dev.c code, but I'll
still need the enum for the next patches in this series. I added it
specifically because of the uninitialized memory problem with `err`
that I witnessed in user space, and to replace the arbitrary 0xff
value in existing code.

> The called function can be one of two and both get the pointer to
> psp_ret as its only argument.
>
> 1. __sev_init_ex_locked() calls __sev_do_cmd_locked() and passes down
> *psp_ret.
>
> or
>
> 2. __sev_init_locked(). Ditto.
>
> Now, __sev_do_cmd_locked() will overwrite psp_ret when
> sev_wait_cmd_ioc() fails. So far so good.

It doesn't always overwrite psp_ret, such as the initial error checking.
The value remains uninitialized for -ENODEV, -EBUSY, -EINVAL.
Thus *error in __sev_platform_init_locked can be set to uninitialized
memory if psp_ret is not first initialized.
That error points to the kernel copy of the user's argument struct,
which the ioctl always copies back.
In the case of those error codes then, without SEV_RET_NO_FW_CALL,
user space will get uninitialized kernel memory.

>
> In the case __sev_do_cmd_locked() succeeds, it'll put there something
> else:
>
>         if (psp_ret)
>                 *psp_ret = reg & PSP_CMDRESP_ERR_MASK;
>
> So no caller will ever see SEV_RET_NO_FW_CALL, as far as I can tell.
>
> And looking further through the rest of the set, nothing tests
> SEV_RET_NO_FW_CALL - it only gets assigned.
>
> So why are we even bothering with this?
>
> You can hand in *psp_ret uninitialized and you'll get a value in all
> cases. Unless I'm missing an angle.
>

I think my above comment points out the wrinkle.

> > diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
> > index 91b4c63d5cbf..1ad7f0a7e328 100644
> > --- a/include/uapi/linux/psp-sev.h
> > +++ b/include/uapi/linux/psp-sev.h
> > @@ -36,6 +36,13 @@ enum {
> >   * SEV Firmware status code
> >   */
> >  typedef enum {
> > +     /*
> > +      * This error code is not in the SEV spec but is added to convey that
> > +      * there was an error that prevented the SEV Firmware from being called.
> > +      * This is (u32)-1 since the firmware error code is represented as a
> > +      * 32-bit integer.
> > +      */
> > +     SEV_RET_NO_FW_CALL = 0xffffffff,
>
> What's wrong with having -1 here?
>

C++ brain not trusting what type enum has even in C. I can change it to -1.

> >       SEV_RET_SUCCESS = 0,
> >       SEV_RET_INVALID_PLATFORM_STATE,
> >       SEV_RET_INVALID_GUEST_STATE,
> > --
>
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 97eb3544ab36..8bc4209b338b 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -440,12 +440,20 @@ static int __sev_init_ex_locked(int *error)
>         return __sev_do_cmd_locked(SEV_CMD_INIT_EX, &data, error);
>  }
>
> +static inline int __sev_do_init_locked(int *psp_ret)
> +{
> +       if (sev_init_ex_buffer)
> +               return __sev_init_ex_locked(psp_ret);
> +       else
> +
> +               return __sev_init_locked(psp_ret);
> +}
> +
>  static int __sev_platform_init_locked(int *error)
>  {
>         struct psp_device *psp = psp_master;
>         struct sev_device *sev;
> -       int rc = 0, psp_ret = SEV_RET_NO_FW_CALL;
> -       int (*init_function)(int *error);
> +       int rc = 0, psp_ret;
>
>         if (!psp || !psp->sev_data)
>                 return -ENODEV;
> @@ -456,15 +464,12 @@ static int __sev_platform_init_locked(int *error)
>                 return 0;
>
>         if (sev_init_ex_buffer) {
> -               init_function = __sev_init_ex_locked;
>                 rc = sev_read_init_ex_file();
>                 if (rc)
>                         return rc;
> -       } else {
> -               init_function = __sev_init_locked;
>         }
>
> -       rc = init_function(&psp_ret);
> +       rc = __sev_do_init_locked(&psp_ret);
>         if (rc && psp_ret == SEV_RET_SECURE_DATA_INVALID) {
>                 /*
>                  * Initialization command returned an integrity check failure
> @@ -473,9 +478,12 @@ static int __sev_platform_init_locked(int *error)
>                  * initialization function should succeed by replacing the state
>                  * with a reset state.
>                  */
> -               dev_err(sev->dev, "SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
> -               rc = init_function(&psp_ret);
> +               dev_err(sev->dev,
> +"SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
> +
> +               rc = __sev_do_init_locked(&psp_ret);
>         }
> +
>         if (error)
>                 *error = psp_ret;
>
> diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
> index 1ad7f0a7e328..a9ed9e846cd2 100644
> --- a/include/uapi/linux/psp-sev.h
> +++ b/include/uapi/linux/psp-sev.h
> @@ -42,7 +42,7 @@ typedef enum {
>          * This is (u32)-1 since the firmware error code is represented as a
>          * 32-bit integer.
>          */
> -       SEV_RET_NO_FW_CALL = 0xffffffff,
> +       SEV_RET_NO_FW_CALL = -1,
>         SEV_RET_SUCCESS = 0,
>         SEV_RET_INVALID_PLATFORM_STATE,
>         SEV_RET_INVALID_GUEST_STATE,
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
-Dionna Glaze, PhD (she/her)
