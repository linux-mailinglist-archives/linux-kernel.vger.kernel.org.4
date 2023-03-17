Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B718B6BEF36
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCQRIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjCQRID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:08:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6D73BC56
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:07:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r11so23041884edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679072858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH6TEsBDVM4MI53sLqeA8gJU3FfyD2rvEa0T4jPrs0g=;
        b=uin8ZGTL33zCXWawAhAXYQwcl0la+DdrbH3wQndi6dXxhUMY97/l6UnHxhYvt5H0Jt
         NTgxOkbJk6i0cC6PPII0iURKbJokZLADbq8b2PbjwpAp7z7m/Rn+tuXrQqYhtULBcGAy
         hvbe70Pc1B6ZbWTV0aZKNFXDi8BZi8mwV3NRaXIkqyjRIp4Meaxs9gTqfb6HqJwN6HRe
         J1FUFFZeapU3fu/A0JSMdgNS0UT8FJEj+H9q1mi5cvboH7iMDR7ahjvtTPSKyxy2yAsL
         HIqyrc3+mEozPgtfBJ+jjqULAkX8EgSXtm/YSkFEPniiOW6okumfv0Jr6iYP4CPDzvR3
         EaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679072858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH6TEsBDVM4MI53sLqeA8gJU3FfyD2rvEa0T4jPrs0g=;
        b=VMmN+iAN0Pyw9O9ZnAcv+ac6Xh5iaw+5hmTkUoUuHSpZYayI3+Kvv258rA2rZNHlld
         dI4WSN537dDrQACbdaq3RSqvX2MFK2umR7qPnbZcVoRKHq9xzJfOmCvye/DIOw7w5oqK
         KzExz7kiawIOzjbF9XLTdFijxBC4SfOEsUyFffiCWYxxdaQVjGf2v15cQLT1KSAAb7Qd
         jxYquO3BQGoZjGdyAX2rvbY0G0m7zgv2I11KSEU+Ynsg013aoGtuHe4nf7FqRKWCDj56
         WQgPR2rYopzQQkHPZgD5b9shda0XDw+8kFEbj1bPz+8cOxBN61vHVkqpNoEJe5/QSa7a
         PN4w==
X-Gm-Message-State: AO0yUKWM5gubqHvTKRm4/Hbw4yRqOa5Np4nqmv/ryiM5kHVWgK5mfyFB
        /QoYtTf2EyyiIO9Fr0H/EAu+4XgQEeBee1p1k78Fug==
X-Google-Smtp-Source: AK7set/3kYGzlQF3tFaekELt2z+7FHJFxhiEVCvJ3/BXV31FOYeQ1rhS85S4BzSlz7OhRW4pmgBSVYjuczE+QBmBj8I=
X-Received: by 2002:a17:906:4d15:b0:930:a3ee:f22e with SMTP id
 r21-20020a1709064d1500b00930a3eef22emr14246eju.13.1679072858267; Fri, 17 Mar
 2023 10:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230315113201.1343781-1-etienne.carriere@linaro.org>
 <20230315113201.1343781-3-etienne.carriere@linaro.org> <CAHUa44FOKft9xQzc6g-CywY=jgcvp-ApG=ufR3CMzwAot4df5w@mail.gmail.com>
In-Reply-To: <CAHUa44FOKft9xQzc6g-CywY=jgcvp-ApG=ufR3CMzwAot4df5w@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 17 Mar 2023 18:07:27 +0100
Message-ID: <CAN5uoS9JqV7vGsf3630+AHOCOfsGj84xwDTUjxw4fUZ4coDqvw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] optee: add enable/disable/set_wake handlers to
 optee irqs
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 at 14:45, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Wed, Mar 15, 2023 at 12:32=E2=80=AFPM Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Implements OP-TEE's It Notif PTA API to deactivate and activate an
> > interrupt notifier and to configure the wakeup capability
> > of that interrupt. These controls are useful for efficient power
> > management of the device when an interrupt controller resources is
> > hosted in OP-TEE world.
> >
> > When OP-TEE does not implement the It Notif PTA, the related handlers
> > simply return with success. If OP-TEE exposes the PTA services, they
> > are invoked on enable, disable and set_wake irqchip operations.
> >
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> > Changes since v3:
> > - Renamed it_notif/IT_NOTIF to itr_notif/ITR_NOTIF.
> >
> > Changes since v2:
> > - Patch added in v2 series for power-up/down and wakeup configuration
> >   of the irq chip.
> >
> > Patch not present in v1
> > - Patch added for power-up/down and wakeup configuration of the irq chi=
p.
> > ---
> >  drivers/tee/optee/optee_private.h |   2 +
> >  drivers/tee/optee/smc_abi.c       | 157 ++++++++++++++++++++++++++++++
> >  2 files changed, 159 insertions(+)
> >
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opte=
e_private.h
> > index f467409e02e9..4b4002d81315 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -166,6 +166,7 @@ struct optee_ops {
> >   * @scan_bus_done      flag if device registation was already done.
> >   * @scan_bus_wq                workqueue to scan optee bus and registe=
r optee drivers
> >   * @scan_bus_work      workq to scan optee bus and register optee driv=
ers
> > + * @notif_itr_pta_ctx   TEE context for invoking interrupt configurati=
on services
> >   */
> >  struct optee {
> >         struct tee_device *supp_teedev;
> > @@ -185,6 +186,7 @@ struct optee {
> >         bool   scan_bus_done;
> >         struct workqueue_struct *scan_bus_wq;
> >         struct work_struct scan_bus_work;
> > +       struct tee_context *notif_itr_pta_ctx;
>
> Please use the other *ctx above instead.

I will discard this 3th patch and replace this PTA services with SMC
function IDs as suggested.

BR,
Etienne

>
> Thanks,
> Jens
>
> >  };
> >
> >  struct optee_session {
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index 6e6c6979abfd..046aa242b2ef 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -52,6 +52,43 @@
> >   */
> >  #define OPTEE_MIN_STATIC_POOL_ALIGN    9 /* 512 bytes aligned */
> >
> > +/*
> > + * Interrupt notification can be configured using Notif-IT PTA service=
s.
> > + * Below are the PTA UUID and its API commands.
> > + */
> > +#define PTA_ITR_NOTIF_UUID \
> > +       UUID_INIT(0x4461e5c7, 0xb523, 0x4b73, 0xac, 0xed, 0x75, 0xad, \
> > +                 0x2b, 0x9b, 0x59, 0xa1)
> > +
> > +/*
> > + * PTA_ITR_NOTIF_ACTIVATE_DETECTION - Enable a interrupt notification
> > + *
> > + * [in]  params[0].value.a     Interrupt ID
> > + */
> > +#define PTA_ITR_NOTIF_ACTIVATE_DETECTION       0
> > +
> > +/*
> > + * PTA_ITR_NOTIF_DEACTIVATE_DETECTION - Disable a interrupt notificati=
on
> > + *
> > + * [in]  params[0].value.a     Interrupt ID
> > + */
> > +#define PTA_ITR_NOTIF_DEACTIVATE_DETECTION     1
> > +
> > +/*
> > + * PTA_ITR_NOTIF_ENABLE_WAKEUP_SOURCE - Enable an interrupt wakeup sou=
rce
> > + *
> > + * [in]  params[0].value.a     Interrupt ID
> > + */
> > +#define PTA_ITR_NOTIF_ENABLE_WAKEUP_SOURCE     2
> > +
> > +/*
> > + * PTA_ITR_NOTIF_ENABLE_WAKEUP_SOURCE - Disable an interrupt wakeup so=
urce
> > + *
> > + * [in]  params[0].value.a     Interrupt ID
> > + */
> > +#define PTA_ITR_NOTIF_DISABLE_WAKEUP_SOURCE    3
> > +
> > +
> >  /*
> >   * 1. Convert between struct tee_param and struct optee_msg_param
> >   *
> > @@ -977,6 +1014,92 @@ static int optee_smc_stop_async_notif(struct tee_=
context *ctx)
> >   * 5. Asynchronous notification
> >   */
> >
> > +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const v=
oid *data)
> > +{
> > +       return ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE;
> > +}
> > +
> > +static void init_optee_pta_context(struct optee *optee)
> > +{
> > +       struct tee_context *ctx =3D NULL;
> > +       const uuid_t pta_uuid =3D PTA_ITR_NOTIF_UUID;
> > +       struct tee_ioctl_open_session_arg sess_arg;
> > +       int ret;
> > +
> > +       ctx =3D tee_client_open_context(NULL, optee_ctx_match, NULL, NU=
LL);
> > +       if (IS_ERR(ctx))
> > +               return;
> > +
> > +       memset(&sess_arg, 0, sizeof(sess_arg));
> > +       export_uuid(sess_arg.uuid, &pta_uuid);
> > +       sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> > +
> > +       ret =3D tee_client_open_session(ctx, &sess_arg, NULL);
> > +       if ((ret < 0) || (sess_arg.ret !=3D 0)) {
> > +               pr_err("Can't open ITR_NOTIF PTA session: %#x\n", sess_=
arg.ret);
> > +               tee_client_close_context(ctx);
> > +               return;
> > +       }
> > +
> > +       tee_client_close_session(ctx, sess_arg.session);
> > +
> > +       optee->notif_itr_pta_ctx =3D ctx;
> > +}
> > +
> > +static void release_optee_pta_context(struct optee *optee)
> > +{
> > +       if (optee->notif_itr_pta_ctx) {
> > +               tee_client_close_context(optee->notif_itr_pta_ctx);
> > +               optee->notif_itr_pta_ctx =3D NULL;
> > +       }
> > +}
> > +
> > +static int invoke_optee_pta(struct optee *optee, unsigned int command,
> > +                           unsigned int irq_id)
> > +{
> > +       const uuid_t pta_uuid =3D PTA_ITR_NOTIF_UUID;
> > +       struct tee_ioctl_open_session_arg sess_arg;
> > +       struct tee_ioctl_invoke_arg inv_arg;
> > +       struct tee_param param[1];
> > +       int ret;
> > +
> > +       if (!optee->notif_itr_pta_ctx)
> > +               return -ENOENT;
> > +
> > +       memset(&sess_arg, 0, sizeof(sess_arg));
> > +       export_uuid(sess_arg.uuid, &pta_uuid);
> > +       sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> > +
> > +       ret =3D tee_client_open_session(optee->notif_itr_pta_ctx, &sess=
_arg, NULL);
> > +       if ((ret < 0) || (sess_arg.ret !=3D 0)) {
> > +               pr_err("tee_client_open_session failed, err: %#x\n", se=
ss_arg.ret);
> > +               if (!ret)
> > +                       ret =3D -EINVAL;
> > +               return ret;
> > +       }
> > +
> > +       memset(&inv_arg, 0, sizeof(inv_arg));
> > +       inv_arg.session =3D sess_arg.session;
> > +       inv_arg.func =3D command;
> > +       inv_arg.num_params =3D 1;
> > +
> > +       memset(&param, 0, sizeof(param));
> > +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> > +       param[0].u.value.a =3D irq_id;
> > +
> > +       ret =3D tee_client_invoke_func(optee->notif_itr_pta_ctx, &inv_a=
rg, param);
> > +       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> > +               pr_err("tee_client_invoke_func failed, ret: %d, err: %#=
x\n",
> > +                      ret, inv_arg.ret);
> > +               if (!ret)
> > +                       ret =3D -EINVAL;
> > +       }
> > +
> > +       tee_client_close_session(optee->notif_itr_pta_ctx, sess_arg.ses=
sion);
> > +
> > +       return ret;
> > +}
> > +
> >  static void optee_itr_notif_mask(struct irq_data *d)
> >  {
> >         struct optee *optee =3D d->domain->host_data;
> > @@ -995,10 +1118,40 @@ static void optee_itr_notif_unmask(struct irq_da=
ta *d)
> >                              0, 0, 0, 0, 0, &res);
> >  }
> >
> > +static void optee_itr_notif_disable(struct irq_data *d)
> > +{
> > +       struct optee *optee =3D d->domain->host_data;
> > +
> > +       (void)invoke_optee_pta(optee, PTA_ITR_NOTIF_DEACTIVATE_DETECTIO=
N, d->hwirq);
> > +}
> > +
> > +static void optee_itr_notif_enable(struct irq_data *d)
> > +{
> > +       struct optee *optee =3D d->domain->host_data;
> > +
> > +       (void)invoke_optee_pta(optee, PTA_ITR_NOTIF_ACTIVATE_DETECTION,=
 d->hwirq);
> > +}
> > +
> > +static int optee_itr_notif_set_wake(struct irq_data *d, unsigned int o=
n)
> > +{
> > +       struct optee *optee =3D d->domain->host_data;
> > +       u32 command;
> > +
> > +       if (on)
> > +               command =3D PTA_ITR_NOTIF_ENABLE_WAKEUP_SOURCE;
> > +       else
> > +               command =3D PTA_ITR_NOTIF_DISABLE_WAKEUP_SOURCE;
> > +
> > +       return invoke_optee_pta(optee, command, d->hwirq);
> > +}
> > +
> >  static struct irq_chip optee_irq_chip =3D {
> >         .name =3D "optee-it",
> >         .irq_mask =3D optee_itr_notif_mask,
> >         .irq_unmask =3D optee_itr_notif_unmask,
> > +       .irq_disable =3D optee_itr_notif_disable,
> > +       .irq_enable =3D optee_itr_notif_enable,
> > +       .irq_set_wake =3D optee_itr_notif_set_wake,
> >  };
> >
> >  static int optee_itr_alloc(struct irq_domain *d, unsigned int virq,
> > @@ -1459,6 +1612,7 @@ static int optee_smc_remove(struct platform_devic=
e *pdev)
> >                 optee_disable_shm_cache(optee);
> >
> >         optee_smc_notif_uninit_irq(optee);
> > +       release_optee_pta_context(optee);
> >
> >         optee_remove_common(optee);
> >
> > @@ -1646,6 +1800,8 @@ static int optee_probe(struct platform_device *pd=
ev)
> >                                 irq_dispose_mapping(irq);
> >                                 goto err_notif_uninit;
> >                         }
> > +
> > +                       init_optee_pta_context(optee);
> >                 }
> >
> >                 enable_async_notif(optee->smc.invoke_fn);
> > @@ -1683,6 +1839,7 @@ static int optee_probe(struct platform_device *pd=
ev)
> >                 optee_disable_shm_cache(optee);
> >         optee_smc_notif_uninit_irq(optee);
> >         optee_unregister_devices();
> > +       release_optee_pta_context(optee);
> >  err_notif_uninit:
> >         optee_notif_uninit(optee);
> >  err_close_ctx:
> > --
> > 2.25.1
> >
