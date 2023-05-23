Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74A70D39C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjEWGHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjEWGH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:07:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03830129
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:07:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30a8fa6e6fcso1419221f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684822043; x=1687414043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADkvNfr1IHo4TytL0dBVG682QzEg3WVl8rCNvAHIzAg=;
        b=vx7emZzR5y1H8zbQHqPjtIxa+dF1AYJkX39m/4ljZCVtr6+/6NWhiKk26ykCKv5ZDP
         1OJAdP3VYk6cin+fcyK5QAnB8WE+EzODfTYkUIfr+qVC2BKogN3Z8BkWJp82jWf8Xz/r
         ky178WqV82DTU3z/WBfvPQG4tz4PO8B6q+wCjPtGFOUDyojZFLcApduBrfZYpmMbmeuR
         bp0gzlK5AOkfz7V2JyOnLa6X4s6Eh1OrfJirMROlYoAD+6BKyg5H9T54dAMgcFIknSIa
         4EKxDWI7CJDEz9T/QM/nCYuHuwGZ6mkIMLYi7OfpKcQxG9EoaOdD9zsE/lxUo6o3zSx6
         SZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684822043; x=1687414043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADkvNfr1IHo4TytL0dBVG682QzEg3WVl8rCNvAHIzAg=;
        b=Jw3XBTMLmKgiiF0vgwIKN+5BEqn8jVLvHVPR+RAOI+6yz4gIPlcZUAVS573OmNRXBo
         KyNYDFqzQL1BkcJ5ZxQZBKn560rRs7f0JASKfrksR7gF1s3eYl2t6Ki+NAWPv3ILB4hG
         5C5d3+now+shFPC0zdKb8l35fB2Es2jFm13BWHG9abu9Jw/5gDFeQq5uLYnj+sKTky4R
         JTZyWyHF+3IEODfCrgTOvM1ZWNDfuJ5Mu551+Xvv6q5IKkc/NIFqiu5XyVsW9In+cUYG
         KHOUtXKlEvzvngcRzD1/cIwcXpieuVl4qrGvo8T2KE8qD/JUaCfSDFKYjE7MouEv/jaW
         63+g==
X-Gm-Message-State: AC+VfDxAEp8UadlGr37pHG5nU369lDs3nhxOh7Mz9b8F+hSG+ksJdQnZ
        awuKenLQjNLC9yKkyIZgLRyllnzJIC45BNHLN0duFw==
X-Google-Smtp-Source: ACHHUZ5fM6+zjm9Fzr0ss0h0BY0NH8SunWWHwPjaYiulzc5CucJTFZ2DozAWXK4rPyMiP2PgMcApI2bt0ZwnIItB0cU=
X-Received: by 2002:a05:6000:1209:b0:2ef:bada:2f25 with SMTP id
 e9-20020a056000120900b002efbada2f25mr7616629wrx.67.1684822043416; Mon, 22 May
 2023 23:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <a52cd6075f806eed82d577a6d437c705c7f36a26.1683617412.git.Rijo-john.Thomas@amd.com>
 <CAFA6WYNOjkU_4Kg=khuki3qv95f+bUB5hJUjRy2CoPXDvqW0Sw@mail.gmail.com>
In-Reply-To: <CAFA6WYNOjkU_4Kg=khuki3qv95f+bUB5hJUjRy2CoPXDvqW0Sw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 23 May 2023 08:07:12 +0200
Message-ID: <CAHUa44EStHOWapDrbunf-vazBUVdObEXj+gAm6ShWUwx8AUr9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jan Dabros <jsd@semihalf.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        stable@vger.kernel.org, Sourabh Das <sourabh.das@amd.com>,
        Nimesh Easow <nimesh.easow@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 1:19=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Tue, 9 May 2023 at 13:03, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote=
:
> >
> > After TEE has completed processing of TEE_CMD_ID_LOAD_TA, set proper
> > value in 'return_origin' argument passed by open_session() call. To do
> > so, add 'return_origin' field to the structure tee_cmd_load_ta. The
> > Trusted OS shall update return_origin as part of TEE processing.
> >
> > This change to 'struct tee_cmd_load_ta' interface requires a similar up=
date
> > in AMD-TEE Trusted OS's TEE_CMD_ID_LOAD_TA interface.
> >
> > This patch has been verified on Phoenix Birman setup. On older APUs,
> > return_origin value will be 0.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> > Tested-by: Sourabh Das <sourabh.das@amd.com>
> > Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> > ---
> > v2:
> >  * Added Fixes tag.
> >
> >  drivers/tee/amdtee/amdtee_if.h | 10 ++++++----
> >  drivers/tee/amdtee/call.c      | 30 +++++++++++++++++-------------
> >  2 files changed, 23 insertions(+), 17 deletions(-)
> >
>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/amdtee/amdtee_if.h b/drivers/tee/amdtee/amdtee=
_if.h
> > index ff48c3e47375..e2014e21530a 100644
> > --- a/drivers/tee/amdtee/amdtee_if.h
> > +++ b/drivers/tee/amdtee/amdtee_if.h
> > @@ -118,16 +118,18 @@ struct tee_cmd_unmap_shared_mem {
> >
> >  /**
> >   * struct tee_cmd_load_ta - load Trusted Application (TA) binary into =
TEE
> > - * @low_addr:    [in] bits [31:0] of the physical address of the TA bi=
nary
> > - * @hi_addr:     [in] bits [63:32] of the physical address of the TA b=
inary
> > - * @size:        [in] size of TA binary in bytes
> > - * @ta_handle:   [out] return handle of the loaded TA
> > + * @low_addr:       [in] bits [31:0] of the physical address of the TA=
 binary
> > + * @hi_addr:        [in] bits [63:32] of the physical address of the T=
A binary
> > + * @size:           [in] size of TA binary in bytes
> > + * @ta_handle:      [out] return handle of the loaded TA
> > + * @return_origin:  [out] origin of return code after TEE processing
> >   */
> >  struct tee_cmd_load_ta {
> >         u32 low_addr;
> >         u32 hi_addr;
> >         u32 size;
> >         u32 ta_handle;
> > +       u32 return_origin;
> >  };
> >
> >  /**
> > diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> > index e8cd9aaa3467..e9b63dcb3194 100644
> > --- a/drivers/tee/amdtee/call.c
> > +++ b/drivers/tee/amdtee/call.c
> > @@ -423,19 +423,23 @@ int handle_load_ta(void *data, u32 size, struct t=
ee_ioctl_open_session_arg *arg)
> >         if (ret) {
> >                 arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> >                 arg->ret =3D TEEC_ERROR_COMMUNICATION;
> > -       } else if (arg->ret =3D=3D TEEC_SUCCESS) {
> > -               ret =3D get_ta_refcount(load_cmd.ta_handle);
> > -               if (!ret) {
> > -                       arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> > -                       arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> > -
> > -                       /* Unload the TA on error */
> > -                       unload_cmd.ta_handle =3D load_cmd.ta_handle;
> > -                       psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
> > -                                           (void *)&unload_cmd,
> > -                                           sizeof(unload_cmd), &ret);
> > -               } else {
> > -                       set_session_id(load_cmd.ta_handle, 0, &arg->ses=
sion);
> > +       } else {
> > +               arg->ret_origin =3D load_cmd.return_origin;
> > +
> > +               if (arg->ret =3D=3D TEEC_SUCCESS) {
> > +                       ret =3D get_ta_refcount(load_cmd.ta_handle);
> > +                       if (!ret) {
> > +                               arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> > +                               arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> > +
> > +                               /* Unload the TA on error */
> > +                               unload_cmd.ta_handle =3D load_cmd.ta_ha=
ndle;
> > +                               psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_T=
A,
> > +                                                   (void *)&unload_cmd=
,
> > +                                                   sizeof(unload_cmd),=
 &ret);
> > +                       } else {
> > +                               set_session_id(load_cmd.ta_handle, 0, &=
arg->session);
> > +                       }
> >                 }
> >         }
> >         mutex_unlock(&ta_refcount_mutex);
> > --
> > 2.25.1
> >
