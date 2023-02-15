Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D8B697C02
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjBOMmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBOMl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:41:57 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E331303FD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:41:56 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id rp23so47856078ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=89sV0E32g8V2auykBOzuS5pqLPLahkNEyI/j5Mz7jiI=;
        b=VfDyWwt+pf4fAAC00oWAQmJkGieaypQdp1ah4DgryKc0zRru4xoYNjUQkH5FWxdogr
         oLO7NCO8cmBXXShUk3e7BsoBEP92Q/2aZXlLyWY8oXS3XkV84qKdcqt4ZyLV5mtxuJwm
         LAoFFCsjjBN37YfG22Mi9K0+WEM2EujPbqev0v1EMaeGhpWz34V/JA+Y0ZBu5EW7HCi2
         Tf2az2mZTothPRt0t6F0rSA15TaDk0yKUEz+TWIdLpY6tl34JfTGQQqSCoYVHM9k8amx
         EldaU3nqfyiuVQ9ujFzxOb3CmkuCB89KvhbfeZ5OBYa5P3zBRSflS1Go82wp2dyGvXeK
         bj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sV0E32g8V2auykBOzuS5pqLPLahkNEyI/j5Mz7jiI=;
        b=45q5cxPShnSYPLEd9b9UGyyWEJUBM8yEWy8iGa8H10n6J/EeFRYebV8JhGY/8zIZ/W
         auXbzzUuAALTT3qA67sE4S2l12vWypsYDx5xIcgGIQ3V4Kd7ZtjZfglvSfuSsecUTyXe
         djoyyOee7+kBnnvCBIXII3MqbT71fi5kMVaScSkuFZ3QSaGiSJ8qtc23gM76YT7yK1yL
         daSc9Q+HiR9gbp5+m6dR4R/DJHbalH02jmq6QPyhigqX72H9JK6JXncNR+KFGKq1BtlQ
         keHqecq1I9zFjN/6I6ocDDjDWaBk4nqmmk0dx+yqgIa/NoGmW53o/pDaMIth3HDT+h6/
         sYmQ==
X-Gm-Message-State: AO0yUKUUHF/n1YmqDrZ3tSs+vyefdxLibxa1Cp9GUdbZ8tJQsEcDYAvC
        FrH2Wy/cN4FUCbNd4Uo1GtO9aYPj598uI5wSnJphzQ==
X-Google-Smtp-Source: AK7set/juUkNNabWD/v8ILmekxwi2CUSXwq0YupxRBaTYiWpYyknda4hpAybx/rPnb4L/JKeqdhrhomXeVIoNBeR8mc=
X-Received: by 2002:a17:906:c44f:b0:8ae:b14b:4b9e with SMTP id
 ck15-20020a170906c44f00b008aeb14b4b9emr1023739ejb.9.1676464914603; Wed, 15
 Feb 2023 04:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20230213095829.42911-1-etienne.carriere@linaro.org>
 <20230213095829.42911-2-etienne.carriere@linaro.org> <CAFA6WYPX4t9ML_ErT8NXibdC0BOj_yQteKE=bE2225qh42hvZA@mail.gmail.com>
In-Reply-To: <CAFA6WYPX4t9ML_ErT8NXibdC0BOj_yQteKE=bE2225qh42hvZA@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 15 Feb 2023 13:41:43 +0100
Message-ID: <CAN5uoS9xW70=pwXtzHFvakpDejowJD0XFoNe18-QH-K5rTPgFw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] optee: add per cpu asynchronous notification
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sumit,

On Tue, 14 Feb 2023 at 12:11, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Mon, 13 Feb 2023 at 15:28, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Implements use of per-cpu irq for optee asynchronous notification.
> >
> > Existing optee async notif implementation allows OP-TEE world to
> > raise an interrupt for which Linux optee driver will query pending
> > events bound to waiting tasks in Linux world or threaded bottom half
> > tasks to be invoked in TEE world. This change allows the signaling
> > interrupt to be a per-cpu interrupt as with Arm GIC PPIs.
> >
> > Using a PPI instead of an SPI is useful when no GIC lines are provisioned
> > in the chip design for OP-TEE async notifications. Instead of using an
> > unused GIC SPI for a specific platform, optee can use a common GIC PPI
> > across platforms.
> >
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> >
> > Co-developed-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> > Changes since v3:
> > - Fixed typo in commit message.
> > - Added few words in commit message about why we do this change.
> > - Appended a 2nd commit to the series for request DT bindings update.
> >
> > Changes since v2:
> > - Irq and per-cpu irq no more share the primary same handler function
> >   but have a common irq_handler() helper function.
> > - Removed useless spinlocks.
> > - Wrapped lines > 80 char.
> >
> > Changes since v1:
> > - Fixed missing __percpu attribute reported by kernel test robot.
> > - Rephrased commit message and added Cc tags.
> > ---
> >  drivers/tee/optee/optee_private.h | 22 +++++++
> >  drivers/tee/optee/smc_abi.c       | 97 +++++++++++++++++++++++++++++--
> >  2 files changed, 115 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > index 04ae58892608..e5bd3548691f 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -94,11 +94,33 @@ struct optee_supp {
> >         struct completion reqs_c;
> >  };
> >
> > +/*
> > + * struct optee_pcpu - per cpu notif private struct passed to work functions
> > + * @optee              optee device reference
> > + */
> > +struct optee_pcpu {
> > +       struct optee *optee;
> > +};
> > +
> > +/*
> > + * struct optee_smc - optee smc communication struct
> > + * @invoke_fn          handler function to invoke secure monitor
> > + * @memremaped_shm     virtual address of memory in shared memory pool
> > + * @sec_caps:          secure world capabilities defined by
> > + *                     OPTEE_SMC_SEC_CAP_* in optee_smc.h
> > + * @notif_irq          interrupt used as async notification by OP-TEE or 0
> > + * @optee_pcpu         per_cpu optee instance for per cpu work or NULL
> > + * @notif_pcpu_wq      workqueue for per cpu aynchronous notification or NULL
> > + * @notif_pcpu_work    work for per cpu asynchronous notification
> > + */
> >  struct optee_smc {
> >         optee_invoke_fn *invoke_fn;
> >         void *memremaped_shm;
> >         u32 sec_caps;
> >         unsigned int notif_irq;
> > +       struct optee_pcpu __percpu *optee_pcpu;
> > +       struct workqueue_struct *notif_pcpu_wq;
> > +       struct work_struct notif_pcpu_work;
> >  };
> >
> >  /**
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index a1c1fa1a9c28..eff35f66399e 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -991,9 +991,8 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
> >         return res.a1;
> >  }
> >
> > -static irqreturn_t notif_irq_handler(int irq, void *dev_id)
> > +static irqreturn_t irq_handler(struct optee *optee)
> >  {
> > -       struct optee *optee = dev_id;
> >         bool do_bottom_half = false;
> >         bool value_valid;
> >         bool value_pending;
> > @@ -1016,6 +1015,11 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
> >         return IRQ_HANDLED;
> >  }
> >
> > +static irqreturn_t notif_irq_handler(int irq, void *dev_id)
> > +{
> > +       return irq_handler((struct optee *)dev_id);
> > +}
> > +
> >  static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
> >  {
> >         struct optee *optee = dev_id;
> > @@ -1025,7 +1029,7 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
> >         return IRQ_HANDLED;
> >  }
> >
> > -static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
> > +static int init_irq(struct optee *optee, u_int irq)
> >  {
> >         int rc;
> >
> > @@ -1040,12 +1044,97 @@ static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
> >         return 0;
> >  }
> >
> > +static irqreturn_t notif_pcpu_irq_handler(int irq, void *dev_id)
> > +{
> > +       struct optee_pcpu __percpu *pcpu = (struct optee_pcpu *)dev_id;
> > +       struct optee *optee = pcpu->optee;
> > +
> > +       if (irq_handler(optee) == IRQ_WAKE_THREAD)
> > +               queue_work(optee->smc.notif_pcpu_wq,
> > +                          &optee->smc.notif_pcpu_work);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static void notif_pcpu_irq_work_fn(struct work_struct *work)
> > +{
> > +       struct optee_smc *optee_smc = container_of(work, struct optee_smc,
> > +                                                  notif_pcpu_work);
> > +       struct optee *optee = container_of(optee_smc, struct optee, smc);
> > +
> > +       optee_smc_do_bottom_half(optee->ctx);
> > +}
> > +
> > +static int init_pcpu_irq(struct optee *optee, u_int irq)
> > +{
> > +       struct optee_pcpu __percpu *optee_pcpu;
> > +       int cpu;
> > +       int rc;
> > +
> > +       optee_pcpu = alloc_percpu(struct optee_pcpu);
> > +       if (!optee_pcpu)
> > +               return -ENOMEM;
> > +
> > +       for_each_present_cpu(cpu) {
> > +               struct optee_pcpu __percpu *p = per_cpu_ptr(optee_pcpu, cpu);
> > +
> > +               p->optee = optee;
> > +       }
> > +
> > +       rc = request_percpu_irq(irq, notif_pcpu_irq_handler,
> > +                               "optee_pcpu_notification", optee_pcpu);
> > +       if (rc)
> > +               goto err_free_pcpu;
> > +
> > +       enable_percpu_irq(irq, 0);
>
> AFAICS, this percpu irq is only enabled for CPU which is doing OP-TEE
> driver probe. How would it be enabled for other CPUs? Hot plugged
> CPUs?
>
> > +
> > +       INIT_WORK(&optee->smc.notif_pcpu_work, notif_pcpu_irq_work_fn);
> > +       optee->smc.notif_pcpu_wq = create_workqueue("optee_pcpu_notification");
> > +       if (!optee->smc.notif_pcpu_wq) {
> > +               rc = -EINVAL;
> > +               goto err_free_pcpu_irq;
> > +       }
> > +
> > +       optee->smc.optee_pcpu = optee_pcpu;
> > +       optee->smc.notif_irq = irq;
> > +
> > +       return 0;
> > +
> > +err_free_pcpu_irq:
> > +       disable_percpu_irq(irq);
> > +       free_percpu_irq(irq, optee_pcpu);
> > +err_free_pcpu:
> > +       free_percpu(optee_pcpu);
> > +
> > +       return rc;
> > +}
> > +
> > +static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
> > +{
> > +       if (irq_is_percpu_devid(irq))
> > +               return init_pcpu_irq(optee, irq);
> > +       else
> > +               return init_irq(optee, irq);
> > +}
> > +
> > +static void uninit_pcpu_irq(struct optee *optee)
> > +{
> > +       disable_percpu_irq(optee->smc.notif_irq);
>
> OP-TEE remove may be called on a different CPU than the one which did
> the OP-TEE probe. So we need to disable percpu irq for every CPU which
> I am not sure can be done in a clean manner here. AFAICS,
> cpuhp_setup_state() and friends are the commonly used APIs to
> enable/disable percpu irq.

I see your point, thanks.
Using cpuhp_setup_state() will mandate the optee driver to be
built-in, not loadable, as there is no way to unregister hpcpu
callbacks. A config switch could ensure this.

BR,
Etienne


>
> -Sumit
>
> > +
> > +       free_percpu_irq(optee->smc.notif_irq, optee->smc.optee_pcpu);
> > +       free_percpu(optee->smc.optee_pcpu);
> > +}
> > +
> >  static void optee_smc_notif_uninit_irq(struct optee *optee)
> >  {
> >         if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
> >                 optee_smc_stop_async_notif(optee->ctx);
> >                 if (optee->smc.notif_irq) {
> > -                       free_irq(optee->smc.notif_irq, optee);
> > +                       if (irq_is_percpu_devid(optee->smc.notif_irq))
> > +                               uninit_pcpu_irq(optee);
> > +                       else
> > +                               free_irq(optee->smc.notif_irq, optee);
> > +
> >                         irq_dispose_mapping(optee->smc.notif_irq);
> >                 }
> >         }
> > --
> > 2.25.1
> >
