Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6622366D3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 02:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjAQBue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 20:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjAQBuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 20:50:32 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC9C23D84
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 17:50:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m21so43020554edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 17:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEh/xue1y+vf8z73fYyS7XfldTpT6wk0O1HrDCS3EiM=;
        b=VsBby3xPHS1uKl0KKB6ONDtSohqkVs1saESBAlLLLJIgoU3rKb5/8meI30SXmAQQFt
         w8NK7nBDZ6AknUd5rHzamoA/D5sBSwJ77dkz6XVb4+C7RfrXu1xl4P/3L1pLXEkkqghd
         kEsmtE28z6cocdz1UcWtBBQVbKDCYK4JNpG946ZRin9iXLZVRQ+F18idjZ91D7+Otp4v
         uFQWzdXfXO/CDWuj9y9AYLlHv7NH3JovHXcwCM3fMl2h/u6dLsfISCrZaS88Ig+uJZXq
         yNqF/mviyeSEIzk6l16f/vulSF1BFix/UuBM/XZRPKpZFd0/J5fac8rjE+T/1urNnhB5
         Ob8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEh/xue1y+vf8z73fYyS7XfldTpT6wk0O1HrDCS3EiM=;
        b=wDCIdF0FWhXsfomt3Ej/s/4/yQeOANFamupgZYonHa84CxqjwGlFrxikYkELBbdTOo
         muZuoT3FuScYXZ0E8rJHtDMewyglI/RWGmyVlB2fL2JuUSkLo1P503Uz7vNTPpNN1cWp
         yLec3TU9Ht3sfUSKmQYI6xna5kWMdkuJ11ipQg+eQ/DUo3Ck/Hdx36RJZwhz0jh6+RdO
         UO5yn6voBrxv9kS7Rftph9Mgo3kyAg2I5Wf+APImJCLage7UiAHvcw8Ue3zG740xCSZG
         b4FfNAjnn7yvNXmlYQbbxgIt6Fw8WH2hA6BTh2yLIDEpeB0PacQ+R4D98twkNnyHxI+j
         SD/A==
X-Gm-Message-State: AFqh2kqyNk3NLy/+v5B4pjtsdgdEEI7gpaYVF71VXB2jsTPO3t8r7224
        uGt54gdeUTP34QdDCagqcUammgI5PdcDcdWqwzzvEQ==
X-Google-Smtp-Source: AMrXdXu2SOzDDp1V5OPTF++FjV1pWIrGlRLHn8bch0dn+SQpz9zYmJloHO1mKpCXte7nF0imgYOmSVtVOa7DAdygik0=
X-Received: by 2002:a05:6402:214a:b0:49b:6629:a494 with SMTP id
 bq10-20020a056402214a00b0049b6629a494mr134123edb.271.1673920227935; Mon, 16
 Jan 2023 17:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20230112145424.3791276-1-etienne.carriere@linaro.org>
 <20230112145424.3791276-4-etienne.carriere@linaro.org> <86a62mokkq.wl-maz@kernel.org>
 <CAN5uoS-Q5ePtNcJ2-8BBV+rxUK6xcbU1ywtcRfYf=sRbWShNpg@mail.gmail.com> <87fsccds1c.wl-maz@kernel.org>
In-Reply-To: <87fsccds1c.wl-maz@kernel.org>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Tue, 17 Jan 2023 02:50:16 +0100
Message-ID: <CAN5uoS8YbjeZYreZJ2BgXCU4=EjHqPbRBoh8QzPw00YT253Mvg@mail.gmail.com>
Subject: Re: [PATCH 3/3] optee core: add irq chip using optee async notification
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pascal Paillet <p.paillet@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
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

On Sun, 15 Jan 2023 at 11:14, Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 13 Jan 2023 15:27:22 +0000,
> Etienne Carriere <etienne.carriere@linaro.org> wrote:
> >
> > Hello Marc,
> >
> > Thanks for the review.
> >
> >
> > On Fri, 13 Jan 2023 at 10:22, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Thu, 12 Jan 2023 14:54:24 +0000,
> > > Etienne Carriere <etienne.carriere@linaro.org> wrote:
> > > >
> > > > Adds an irq chip in optee driver to generate interrupts from OP-TEE
> > > > notified interrupt events based on optee async notification. Upon s=
uch
> > > > notification, optee driver invokes OP-TEE to query a pending interr=
upt
> > > > event. If an interrupt notification is pending the invocation retur=
n
> > > > OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_IT and optee driver can get the pend=
ing
> > > > interrupt number with SMC function ID OPTEE_SMC_FUNCID_GET_IT_VALUE=
.
> > > >
> > > > SMC function ID OPTEE_SMC_FUNCID_SET_IT_MASK allows Linux to mask/u=
nmask
> > > > an interrupt notification services.
> > > >
> > > > The optee irq_chip if flagged IRQCHIP_SKIP_SET_WAKE to skip set_wak=
e
> > > > as optee interrupt notifications doesn't support the set_wake optio=
n.
> > > > In case a device is using the optee irq and is marked as wakeup sou=
rce,
> > > > this result in an "Unbalanced IRQ xx wake disable" backtrace, since=
:
> > > > - in irq_set_irq_wake(ON), wake_depth gets incremented, then reset =
due to
> > > >   set_irq_wake_real() returns an error (irq_set_wake() isn't implem=
ented)
> > > > - in irq_set_irq_wake(OFF), wake_depth is always 0, hence the warni=
ng
> > >
> > > Is this relevant information?
> >
> > The description is maybe too specific to the setup used for this featur=
e.
> > I'll rephrase that, unless IRQCHIP_SKIP_SET_WAKE flag is not relevant h=
ere.
>
> IRQCHIP_SKIP_SET_FLAG is used when the irqchip doesn't provide any
> wake-up mechanism, but also isn't *denying* its use (there is a
> separate way to wake up from such an interrupt). I don't think you
> need to document that something goes wrong when you're doing something
> wrong.

:)  fair.

>
> > >
> > > >
> > > > Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
> > > > Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> > > > Co-developed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > > > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > > ---
> > > >  drivers/tee/optee/optee_private.h |   2 +
> > > >  drivers/tee/optee/optee_smc.h     |  78 +++++++++++++++-
> > > >  drivers/tee/optee/smc_abi.c       | 142 ++++++++++++++++++++++++++=
++--
> > > >  3 files changed, 216 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/=
optee_private.h
> > > > index e5bd3548691f..2a146d884d27 100644
> > > > --- a/drivers/tee/optee/optee_private.h
> > > > +++ b/drivers/tee/optee/optee_private.h
> > > > @@ -112,6 +112,7 @@ struct optee_pcpu {
> > > >   * @optee_pcpu               per_cpu optee instance for per cpu wo=
rk or NULL
> > > >   * @notif_pcpu_wq    workqueue for per cpu aynchronous notificatio=
n or NULL
> > > >   * @notif_pcpu_work  work for per cpu asynchronous notification
> > > > + * @domain           interrupt domain registered by OP-TEE driver
> > > >   */
> > > >  struct optee_smc {
> > > >       optee_invoke_fn *invoke_fn;
> > > > @@ -121,6 +122,7 @@ struct optee_smc {
> > > >       struct optee_pcpu __percpu *optee_pcpu;
> > > >       struct workqueue_struct *notif_pcpu_wq;
> > > >       struct work_struct notif_pcpu_work;
> > > > +     struct irq_domain *domain;
> > > >  };
> > > >
> > > >  /**
> > > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/opte=
e_smc.h
> > > > index 73b5e7760d10..0cf83d5a2931 100644
> > > > --- a/drivers/tee/optee/optee_smc.h
> > > > +++ b/drivers/tee/optee/optee_smc.h
> > > > @@ -226,7 +226,8 @@ struct optee_smc_get_shm_config_result {
> > > >   * a3        Bit[7:0]: Number of parameters needed for RPC to be s=
upplied
> > > >   *             as the second MSG arg struct for
> > > >   *             OPTEE_SMC_CALL_WITH_ARG
> > > > - *   Bit[31:8]: Reserved (MBZ)
> > > > + *   Bit[23:8]: The maximum interrupt event notification number
> > > > + *   Bit[31:24]: Reserved (MBZ)
> > > >   * a4-7      Preserved
> > > >   *
> > > >   * Error return register usage:
> > > > @@ -254,6 +255,11 @@ struct optee_smc_get_shm_config_result {
> > > >  #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF                BIT(5)
> > > >  /* Secure world supports pre-allocating RPC arg struct */
> > > >  #define OPTEE_SMC_SEC_CAP_RPC_ARG            BIT(6)
> > > > +/* Secure world supports interrupt events notification to normal w=
orld */
> > > > +#define OPTEE_SMC_SEC_CAP_IT_NOTIF           BIT(7)
> > > > +
> > > > +#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_MASK  GENMASK(23, 8)
> > > > +#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_SHIFT 8
> > > >
> > > >  #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES       9
> > > >  #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
> > > > @@ -416,6 +422,12 @@ struct optee_smc_disable_shm_cache_result {
> > > >   */
> > > >  #define OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF   0
> > > >
> > > > +/*
> > > > + * Notification that OP-TEE triggers an interrupt event to Linux k=
ernel
> > > > + * for an interrupt consumer.
> > > > + */
> > > > +#define OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_IT            1
> > > > +
> > > >  #define OPTEE_SMC_FUNCID_GET_ASYNC_NOTIF_VALUE       17
> > > >  #define OPTEE_SMC_GET_ASYNC_NOTIF_VALUE \
> > > >       OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_ASYNC_NOTIF_VALU=
E)
> > > > @@ -426,6 +438,70 @@ struct optee_smc_disable_shm_cache_result {
> > > >  /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
> > > >  #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG  19
> > > >
> > > > +/*
> > > > + * Retrieve the interrupt number of the pending interrupt event no=
tified to
> > > > + * non-secure world since the last call of this function.
> > > > + *
> > > > + * OP-TEE keeps a record of all posted interrupt notification even=
ts. When the
> > > > + * async notif interrupt is received by non-secure world, this fun=
ction should
> > > > + * be called until all pended interrupt events have been retrieved=
. When an
> > > > + * interrupt event is retrieved it is cleared from the record in s=
ecure world.
> > > > + *
> > > > + * It is expected that this function is called from an interrupt h=
andler
> > > > + * in normal world.
> > > > + *
> > > > + * Call requests usage:
> > > > + * a0        SMC Function ID, OPTEE_SMC_GET_IT_NOTIF_VALUE
> > > > + * a1-6      Not used
> > > > + * a7        Hypervisor Client ID register
> > > > + *
> > > > + * Normal return register usage:
> > > > + * a0        OPTEE_SMC_RETURN_OK
> > > > + * a1        IT_NOTIF interrupt identifier value
> > > > + * a2        Bit[0]: OPTEE_SMC_IT_NOTIF_VALID if the value in a1 i=
s
> > > > + *           valid, else 0 if no interrupt event were pending
> > > > + * a2        Bit[1]: OPTEE_SMC_IT_NOTIF_PENDING if another interru=
pt event
> > > > + *           value is pending, else 0.
> > > > + *   Bit[31:2]: MBZ
> > > > + * a3-7      Preserved
> > > > + *
> > > > + * Not supported return register usage:
> > > > + * a0        OPTEE_SMC_RETURN_ENOTAVAIL
> > > > + * a1-7      Preserved
> > > > + */
> > > > +#define OPTEE_SMC_IT_NOTIF_VALID             BIT(0)
> > > > +#define OPTEE_SMC_IT_NOTIF_PENDING           BIT(1)
> > > > +
> > > > +#define OPTEE_SMC_FUNCID_GET_IT_NOTIF_VALUE  20
> > > > +#define OPTEE_SMC_GET_IT_NOTIF_VALUE \
> > > > +     OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_IT_NOTIF_VALUE)
> > > > +
> > > > +/*
> > > > + * Mask or unmask an interrupt notification event.
> > > > + *
> > > > + * It is expected that this function is called from an interrupt h=
andler
> > > > + * in normal world.
> > > > + *
> > > > + * Call requests usage:
> > > > + * a0        SMC Function ID, OPTEE_SMC_SET_IT_NOTIF_MASK
> > > > + * a1        Interrupt identifier value
> > > > + * a2        Bit[0]: 1 if interrupt event is to be masked, 0 if it=
 is to be unmasked
> > > > + * a2   Bit[31:1] MBZ
> > > > + * a3-6      Not used
> > > > + * a7        Hypervisor Client ID register
> > > > + *
> > > > + * Normal return register usage:
> > > > + * a0        OPTEE_SMC_RETURN_OK
> > > > + * a1-7      Preserved
> > > > + *
> > > > + * Not supdealed ported return register usage:
> > > > + * a0        OPTEE_SMC_RETURN_ENOTAVAIL
> > > > + * a1-7      Preserved
> > > > + */
> > > > +#define OPTEE_SMC_FUNCID_SET_IT_NOTIF_MASK   21
> > > > +#define OPTEE_SMC_SET_IT_NOTIF_MASK \
> > > > +     OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_SET_IT_NOTIF_MASK)
> > > > +
> > > >  /*
> > > >   * Resume from RPC (for example after processing a foreign interru=
pt)
> > > >   *
> > > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_ab=
i.c
> > > > index 8c2d58d605ac..0360afde119f 100644
> > > > --- a/drivers/tee/optee/smc_abi.c
> > > > +++ b/drivers/tee/optee/smc_abi.c
> > > > @@ -977,6 +977,112 @@ static int optee_smc_stop_async_notif(struct =
tee_context *ctx)
> > > >   * 5. Asynchronous notification
> > > >   */
> > > >
> > > > +static u32 get_it_value(optee_invoke_fn *invoke_fn, bool *value_va=
lid,
> > > > +                     bool *value_pending)
> > >
> > > What value? If this is supposed to return a set of pending bits, just
> > > name the function to reflect that.
> >
> > Communication between Linux kernel and OP-TEE is this case is rather
> > basic here, no shared memory used, only few CPU registers can be used
> > to shared information. So Linux invokes OP-TEE for each pending optee
> > interrupt event: each invocation returns a interrupt event number (an
> > integer value) and a status whether another interrupt event is pending
> > and shall be retrieved invoking OP-TEE again. In case Linux invoke
> > OP-TEE for a pending interrupt and none is pending, a last status is
> > also provided: 'value_valid'.
> >
> > I could maybe change the prototype to something like:
> > static u32 get_pending_it_number(optee_invoke_fn *invoke_fn, bool
> > *it_number_valid, bool *more_pending_it)
>
> What does 'it' mean? Interrupt? Spell it out. Really, this should read as=
:
>
>         get_pending_irq()

Ok, understood. Thanks.

>
>
> >
> > >
> > > Also, at no point do you explain that each PPI is only a mux interrup=
t
> > > for a bunch of chained interrupts.
> >
> > Sorry, I don't understand your question.
> > The "it notif" feature proposed in this change is not straight related =
a PPI.
> > Previous patch in this series is indeed related to PPI: it propose
> > optee driver can use a single PPI instead of a signle SPI for the
> > OP-TEE "asyn notification" feature.
> > This change allows to mux interrupts events (from OP-TEE to Linux
> > optee driver) over "OP-TEE async notif" means, which is using a single
> > SPI or PPI.
> > Maybe I should have submitted both changes separately :(
>
> Surely a less cryptic explaination would have helped.

Indeed. You're not the first to tell :(
Sorry I'll try to better use Linux wordings in Linux kernel changes.
Thanks for being frank.

>
> >
> > >
> > > > +{
> > > > +     struct arm_smccc_res res;
> > > > +
> > > > +     invoke_fn(OPTEE_SMC_GET_IT_NOTIF_VALUE, 0, 0, 0, 0, 0, 0, 0, =
&res);
> > > > +
> > > > +     if (res.a0)
> > > > +             return 0;
> > > > +
> > > > +     *value_valid =3D res.a2 & OPTEE_SMC_IT_NOTIF_VALID;
> > > > +     *value_pending =3D res.a2 & OPTEE_SMC_IT_NOTIF_PENDING;
> > > > +     return res.a1;
> > > > +}
> > > > +
> > > > +static u32 set_it_mask(optee_invoke_fn *invoke_fn, u32 it_value, b=
ool mask)
> > > > +{
> > > > +     struct arm_smccc_res res;
> > > > +
> > > > +     invoke_fn(OPTEE_SMC_SET_IT_NOTIF_MASK, it_value, mask, 0, 0, =
0, 0, 0, &res);
> > > > +
> > > > +     if (res.a0)
> > > > +             return 0;
> > > > +
> > > > +     return res.a1;
> > > > +}
> > > > +
> > > > +static int handle_optee_it(struct optee *optee)
> > > > +{
> > > > +     bool value_valid;
> > > > +     bool value_pending;
> > > > +     u32 it;
> > > > +
> > > > +     do {
> > > > +             struct irq_desc *desc;
> > > > +
> > > > +             it =3D get_it_value(optee->smc.invoke_fn, &value_vali=
d, &value_pending);
> > > > +             if (!value_valid)
> > > > +                     break;
> > > > +
> > > > +             desc =3D irq_to_desc(irq_find_mapping(optee->smc.doma=
in, it));
> > > > +             if (!desc) {
> > > > +                     pr_err("no desc for optee IT:%d\n", it);
> > > > +                     return -EIO;
> > > > +             }
> > > > +
> > > > +             handle_simple_irq(desc);
> > > > +
> > >
> > > What is this? Please use generic_handle_domain_irq(), like any other
> > > driver. Why is the flow handler handle_simple_irq()? You need to
> > > explain what the signalling is for the secure-provided interrupts.
> >
> > My fault. I thought handle_simple_irq() would better apply here since
> > its description:
> >  * Simple interrupts are either sent from a demultiplexing interrupt
> >  * handler or come from hardware, where no interrupt hardware control
> >  * is necessary.
>
> Why isn't masking necessary? What is the signalling between OPTEE and
> NS? Does the "get_it_value" function *consume* the pending bits? You
> need to answer and document all of that, and only then pick the flow
> that matches these requirements.

Yes, thet get_pending_irq() function is expect to consume the pending irq.
As soon as it is consumed, any occurence of HW event (in OP-TEE world)
that results in this optee irq be raised, will set again that irq
number as pending and fire the irq leading to this get_pending_irq()
function be called.

Thanks for the feedback. Maksing, enabling etc... are indeed needed.
I'll come up with a (hopefully) better proposal.



>
> >
> > OP-TEE secure world has already dealt with the HW interrupt resources
> > (ack/etc...) before it notifies Linux kernel of the event.
> >
> > >
> > > > +     } while (value_pending);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void optee_it_irq_mask(struct irq_data *d)
> > > > +{
> > > > +     struct optee *optee =3D d->domain->host_data;
> > > > +
> > > > +     set_it_mask(optee->smc.invoke_fn, d->hwirq, true);
> > > > +}
> > > > +
> > > > +static void optee_it_irq_unmask(struct irq_data *d)
> > > > +{
> > > > +     struct optee *optee =3D d->domain->host_data;
> > > > +
> > > > +     set_it_mask(optee->smc.invoke_fn, d->hwirq, false);
> > > > +}
> > > > +
> > > > +static struct irq_chip optee_it_irq_chip =3D {
> > > > +     .name =3D "optee-it",
> > > > +     .irq_disable =3D optee_it_irq_mask,
> > > > +     .irq_enable =3D optee_it_irq_unmask,
> > > > +     .flags =3D IRQCHIP_SKIP_SET_WAKE,
> > >
> > > Is it a mask or a disable? These are different beasts.
> >
> > Indeed, thanks for catching that. I think we need to 4
> > (enable/disable/mask/unmask).
> > I'll fix.
>
> What does enable do differently from unmask?

I think I saw it the wrong way. I understand implementing .irq_mask &
.irq_unmask operations should be enough to notify OP-TEE world and let
it manage the interrupt detection on its side.


>
> >
> > >
> > > > +};
> > > > +
> > > > +static int optee_it_alloc(struct irq_domain *d, unsigned int virq,
> > > > +                       unsigned int nr_irqs, void *data)
> > > > +{
> > > > +     struct irq_fwspec *fwspec =3D data;
> > > > +     irq_hw_number_t hwirq;
> > > > +
> > > > +     hwirq =3D fwspec->param[0];
> > > > +
> > > > +     irq_domain_set_hwirq_and_chip(d, virq, hwirq, &optee_it_irq_c=
hip, d->host_data);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static const struct irq_domain_ops optee_it_irq_domain_ops =3D {
> > > > +     .alloc =3D optee_it_alloc,
> > > > +     .free =3D irq_domain_free_irqs_common,
> > > > +};
> > > > +
> > > > +static int optee_irq_domain_init(struct platform_device *pdev, str=
uct optee *optee, u_int max_it)
> > > > +{
> > > > +     struct device *dev =3D &pdev->dev;
> > > > +     struct device_node *np =3D dev->of_node;
> > > > +
> > > > +     optee->smc.domain =3D irq_domain_add_linear(np, max_it, &opte=
e_it_irq_domain_ops, optee);
> > > > +     if (!optee->smc.domain) {
> > > > +             dev_err(dev, "Unable to add irq domain\n");
> > > > +             return -ENOMEM;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool =
*value_valid,
> > > >                                bool *value_pending)
> > > >  {
> > > > @@ -1008,13 +1114,15 @@ static irqreturn_t notif_irq_handler(int ir=
q, void *dev_id)
> > > >       }
> > > >
> > > >       do {
> > > > -             value =3D get_async_notif_value(optee->smc.invoke_fn,
> > > > -                                           &value_valid, &value_pe=
nding);
> > > > +             value =3D get_async_notif_value(optee->smc.invoke_fn,=
 &value_valid, &value_pending);
> > > >               if (!value_valid)
> > > >                       break;
> > > >
> > > >               if (value =3D=3D OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTO=
M_HALF)
> > > >                       do_bottom_half =3D true;
> > > > +             else if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_IT_N=
OTIF &&
> > > > +                      value =3D=3D OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_=
IT)
> > > > +                     handle_optee_it(optee);
> > >
> > > NAK. This isn't how we deal with chained interrupts. Definitely not i=
n
> > > an interrupt handler.
> >
> > My apologies, what is wrong in this sequence. My expectations are:
> > 1- Something happens on OP-TEE secure side that should be reported to
> > Linux as a software interrupt event
>
> Why? There is nothing Linux-specific in OPTEE. Why should OPTEE be
> prescriptive of the way this is handled?

In embedded system, we can have for example a unqiue GPIO expander to
get some input data, where some IOs are related to OP-TEE world side
services and other IOs for so-called normal world/Linux services.
Because OP-TEE is parano=C3=AFd, it controls the expenander and relays
Linux related interrupt to it Linux consumer driver through optee
driver, acting as a irq controller.
Wake up irqs can also need the same paths. The wake up controller is
under OP-TEE world control, by device implementation, but some wakeup
irqs should hit Linux as wakeup source.


>
> > 2- OP-TEE (secure world) raises an HW interrupt to notify Linux optee
> > driver that event(s) are pending
> > 3- optee driver threade_irq handler is called and asks OP-TEE which
> > are the pending events. This is done event per event until all pending
> > event are consumed.
>
> Why is this done in a thread? I'd expect the *handlers* to be
> threaded, but not the irqchip part of it (which is crucially missing
> here).

I do understand the optee irq implementation should be handled from
primary handler of the optee async notif irq.
I'll come with a better proposal, I hope.

Thanks for all the feedback and time spent for the explanations

Regards,
Etienne

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
