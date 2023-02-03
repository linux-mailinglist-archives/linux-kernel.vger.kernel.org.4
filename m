Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564626897BD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjBCL2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjBCL2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:28:38 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEC629176
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:28:08 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cw4so4811204edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 03:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LpTrii6/DfgIcK/ioF3QuHNqp6ru/0tr00toPOyvDdQ=;
        b=ink3dKg1UnMAa1A+K3+bpVndveoa9tut8ECs0fsmGZztPCZMM/o0pIrvdf+7DQ9b5F
         46G+jE365s8uA4Ge1A4/zLdDzsZu3Mq+k5wHE2n5nxrNkap5LPeNict8oKFrneV66MJk
         6qiwbJCgYQdTYJwAan+Y4OyqpFyUk6vHbOgdjt1vDTJbShxMrJKEeoIpRFPKC0ulRU8e
         deQ7MZGDkfAgwEqf5hh3PQI/RBk5LNUSHkFHwYtJkYdGl+i9a5h3XEQ2Friz5sT5UaWR
         nDt3GO5JSOJ7iq+rlW4kmag3gVdjm7bvHJgnQCONAjw+Fd0xCCi+Fzc+kpAHSMpck6+M
         ZVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpTrii6/DfgIcK/ioF3QuHNqp6ru/0tr00toPOyvDdQ=;
        b=UGI/4VSc1MGPvv8lsMptI9c0/As51nrKtijrHcMzRSJkXObPl4dFknVSbHdhP8zSe+
         8F862lv5B3PcwmNU6bu+HWvthW3NjiT3V7bP18h96TN49U3gvxXA6YTbVnqHEE2qyxiV
         ZweYZRN8xJMjGhCaMMX7VfZU1DTlbk9honkPHG+sA3t0OtJIuBhIiOCIDon3d+Y4nCvW
         z0gjHP99TbxbfFsvsK3+qipF1vEpvbkDr4u7UKk5Liek2+oqKQKL916KsyhoB9pWeEwN
         BEpKXeZ6332u5y5dduGJaxCSo26XhcnHzIW0d08PFyg4TKXcA3Ct1+ZS0hj4CRxRxpDB
         zNRg==
X-Gm-Message-State: AO0yUKV4oM3hEDhowrzBaRhEKUL1hm+k7WguFK3v+Yb8lCJY02PwU44q
        eG3h00gdIsrvSfDG2i+HksR4Q/+RQbbOKjuKBKyw0w==
X-Google-Smtp-Source: AK7set99NWp6ulEoXyq0SwpYHCUAfw4Q1IyNJLMm1kLTVSdKcPMioMk1khMLLzl9ceot1rZ2sgW0QI+lstzevnXj/IM=
X-Received: by 2002:a50:f60f:0:b0:4a2:27c2:aa9a with SMTP id
 c15-20020a50f60f000000b004a227c2aa9amr2952472edn.61.1675423686562; Fri, 03
 Feb 2023 03:28:06 -0800 (PST)
MIME-Version: 1.0
References: <20230124105643.1737250-1-etienne.carriere@linaro.org>
 <20230124105643.1737250-2-etienne.carriere@linaro.org> <CAFA6WYPwS=L_cNDO5GjwA9aWHZAvbKYG46CRs6kG5QK613ESBQ@mail.gmail.com>
In-Reply-To: <CAFA6WYPwS=L_cNDO5GjwA9aWHZAvbKYG46CRs6kG5QK613ESBQ@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 3 Feb 2023 12:27:55 +0100
Message-ID: <CAN5uoS8a7Ueo5Y4wzbsmx93-bR6JuuwX9-W4n=hbONG0RVdwfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] optee: multiplex tee interrupt events on optee
 async notif irq
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Pascal Paillet <p.paillet@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Thu, 2 Feb 2023 at 12:15, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 24 Jan 2023 at 16:26, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Implements an irqchip in optee driver to relay interrupts notified
> > from OP-TEE world to the Linux OS. Optee registers up to 1 interrupt
> > controller and identifies each line with a line number from 0 to
> > UINT16_MAX.
> >
> > Existing optee async notif uses an irq for OP-TEE to signal Linux of a
> > pending event. The implementation binds each event (an async notif value)
> > to the awaking of a waiting thread or the processing of some TEE
> > background (bottom half) tasks to be scheduled. The interrupt
> > notification service added by this change allows TEE to relay interrupt
> > signals to Linux on secure interrupt occurrences where the end consumer
> > of the signal lives in normal world.
>
> Why do we need OP-TEE as a mediator when the end consumer of an
> interrupt is Linux? Is it some kind of hardware limitation that we
> can't granularly assign interrupts among Linux and OP-TEE?

I face 2 cases.
A case where wakeup interrupts each have a GIC line (that can be
assigned to Linux) in the system but the wakeup configuration of each
interrupt must be done from secure world. So set_wake() operation must
go through OP-TEE. Exposing these interrupts as optee irq's allows
consumers to manage these interrupts using standard Linux kernel irq
APIs.

There is also the case of interrupt expanders i've mentioned  in the
commit message of PATCH v2 1/3. As for example, considering the
interrupts raised from a system PMIC device that is accessed through
an I2C bus or similar. When the PMIC bus is assigned to OP-TEE world,
these accesses are to be done from OP-TEE world. Exposing PMIC
interrupts as optee irq's for that platform allows to use standard
Linux irq's support so consumers simply get a regular irq resource,
with well defined interface to invoke secure world for the interrupt
management.

Br,
etienne

>
> -Sumit
>
> >
> > When optee driver initializes, it negotiates with the TEE whether
> > interrupt notification is supported or not. The feature is enabled
> > if both Linux kernel and OP-TEE support it.
> >
> > OP-TEE defines 2 SMC function IDs for non-secure world to control
> > interrupt events.
> >
> > SMC function OPTEE_SMC_GET_NOTIF_IT allows non-secure world to
> > retrieve pending interrupts by grapes up to 5 lines. The function also
> > reports whether there are pending async values targeting suspended
> > threaded sequences execution and whether TEE has background threaded
> > work to do (async notif value 0 was retrieved).
> >
> > SMC function OPTEE_SMC_CONFIG_NOTIF_IT configures the insterrupt line
> > for masking and enabling state and wakeup source.
> >
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> >
> > Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
> > Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> > Co-developed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> > Changes since v1:
> > - Removed dependency on optee per-cpu irq notification.
> > - Change SMC function ID API to retrieves up to 5 optee irq events,
> >   the optee bottom half event and returns if other async notifications
> >   are pending, in a single invocation.
> > - Implement only mask/unmask irqchip handlers with a 2nd SMC function
> >   to mask/unmask a optee irq in OP-TEE world from an interrupt context.
> > - Added Cc: tags.
> > ---
> >  drivers/tee/optee/optee_private.h |  10 ++
> >  drivers/tee/optee/optee_smc.h     |  88 ++++++++++++++++-
> >  drivers/tee/optee/smc_abi.c       | 158 ++++++++++++++++++++++++++++--
> >  3 files changed, 249 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > index 04ae58892608..f467409e02e9 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -94,11 +94,21 @@ struct optee_supp {
> >         struct completion reqs_c;
> >  };
> >
> > +/*
> > + * struct optee_smc - optee smc communication struct
> > + * @invoke_fn          handler function to invoke secure monitor
> > + * @memremaped_shm     virtual address of memory in shared memory pool
> > + * @sec_caps:          secure world capabilities defined by
> > + *                     OPTEE_SMC_SEC_CAP_* in optee_smc.h
> > + * @notif_irq          interrupt used as async notification by OP-TEE or 0
> > + * @domain             interrupt domain registered by OP-TEE driver
> > + */
> >  struct optee_smc {
> >         optee_invoke_fn *invoke_fn;
> >         void *memremaped_shm;
> >         u32 sec_caps;
> >         unsigned int notif_irq;
> > +       struct irq_domain *domain;
> >  };
> >
> >  /**
> > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> > index 73b5e7760d10..df32ad18eddb 100644
> > --- a/drivers/tee/optee/optee_smc.h
> > +++ b/drivers/tee/optee/optee_smc.h
> > @@ -226,7 +226,8 @@ struct optee_smc_get_shm_config_result {
> >   * a3  Bit[7:0]: Number of parameters needed for RPC to be supplied
> >   *               as the second MSG arg struct for
> >   *               OPTEE_SMC_CALL_WITH_ARG
> > - *     Bit[31:8]: Reserved (MBZ)
> > + *     Bit[23:8]: The maximum interrupt event notification number
> > + *     Bit[31:24]: Reserved (MBZ)
> >   * a4-7        Preserved
> >   *
> >   * Error return register usage:
> > @@ -254,6 +255,11 @@ struct optee_smc_get_shm_config_result {
> >  #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF          BIT(5)
> >  /* Secure world supports pre-allocating RPC arg struct */
> >  #define OPTEE_SMC_SEC_CAP_RPC_ARG              BIT(6)
> > +/* Secure world supports interrupt events notification to normal world */
> > +#define OPTEE_SMC_SEC_CAP_IT_NOTIF             BIT(7)
> > +
> > +#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_MASK    GENMASK(23, 8)
> > +#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_SHIFT   8
> >
> >  #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES 9
> >  #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
> > @@ -426,6 +432,86 @@ struct optee_smc_disable_shm_cache_result {
> >  /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
> >  #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG    19
> >
> > +/*
> > + * Retrieve up to 5 pending interrupt event notified by OP-TEE world
> > + * and whether threaded event are pending on OP-TEE async notif
> > + * controller, all this since the last call of this function.
> > + *
> > + * OP-TEE keeps a record of all posted interrupt notification events.
> > + * When the async notif interrupt is received by
> > + * non-secure world, this function should be called until all pended
> > + * interrupt events have been retrieved. When an interrupt event is
> > + * retrieved it is cleared from the record in OP-TEE world.
> > + *
> > + * It is expected that this function is called from an interrupt handler
> > + * in normal world.
> > + *
> > + * Call requests usage:
> > + * a0  SMC Function ID, OPTEE_SMC_GET_NOTIF_IT
> > + * a1-6        Not used
> > + * a7  Hypervisor Client ID register
> > + *
> > + * Normal return register usage:
> > + * a0  OPTEE_SMC_RETURN_OK
> > + * a1  Bit[7:0]: Number of pending interrupt carried in a1..a5
> > + *     Bit[8]: OPTEE_SMC_NOTIF_IT_PENDING if other interrupt(s) are pending
> > + *     Bit[9]: OPTEE_SMC_NOTIF_ASYNC_PENDING if an threaded event is pending
> > + *     Bit[10]: OPTEE_SMC_NOTIF_DO_BOTTOM_HALF if retrieved bottom half notif
> > + *     Bit[15:11]: Reserved for furture use, MBZ
> > + *     Bit[31:16]: Pending interrupt line value if a1 & 0xFF >= 1
> > + * a2  Bit[15:0]:  Pending interrupt line value if a1 & 0xFF >= 2
> > + *     Bit[31:16]: Pending interrupt line value if a1 & 0xFF >= 3
> > + * a3  Bit[15:0]:  Pending interrupt line value if a1 & 0xFF >= 4
> > + *     Bit[31:16]: Pending interrupt line value if a1 & 0xFF == 5
> > + * a4-7        Preserved
> > + *
> > + * Not supported return register usage:
> > + * a0  OPTEE_SMC_RETURN_ENOTAVAIL
> > + * a1-7        Preserved
> > + */
> > +#define OPTEE_SMC_NOTIF_IT_COUNT_MASK          GENMASK(7, 0)
> > +#define OPTEE_SMC_NOTIF_IT_PENDING             BIT(8)
> > +#define OPTEE_SMC_NOTIF_VALUE_PENDING          BIT(9)
> > +#define OPTEE_SMC_NOTIF_DO_BOTTOM_HALF         BIT(10)
> > +
> > +#define OPTEE_SMC_FUNCID_GET_NOTIF_IT          20
> > +#define OPTEE_SMC_GET_NOTIF_IT \
> > +       OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_NOTIF_IT)
> > +
> > +/*
> > + * Configure an interrupt notification event
> > + *
> > + * It is expected that this function is called from an interrupt handler
> > + * in normal world.
> > + *
> > + * Call requests usage:
> > + * a0  SMC Function ID, OPTEE_SMC_CONFIGURE_NOTIF_IT
> > + * a1  Interrupt identifier value
> > + * a2  Bit[0]: 1 to configure interrupt mask with a3[bit 0], else 0
> > + *     Bit[31:1] Reserved for future use, MBZ
> > + * a3  Bit[0]: 1 to mask the interrupt, 0 to unmask (applies if a2[bit 0]=1)
> > + *     Bit[31:1] Reserved for future use, MBZ
> > + * a4-6        Reserved for furture use, MBZ
> > + * a7  Hypervisor Client ID register
> > + *
> > + * Normal return register usage:
> > + * a0  OPTEE_SMC_RETURN_OK
> > + * a1-7        Preserved
> > + *
> > + * Not supported return register usage:
> > + * a0  OPTEE_SMC_RETURN_ENOTAVAIL
> > + * a1-7        Preserved
> > + *
> > + * Invalid command with provided arguments return usage:
> > + * a0  OPTEE_SMC_RETURN_EBADCMD
> > + * a1-7        Preserved
> > + */
> > +#define OPTEE_SMC_NOTIF_CONFIG_MASK            BIT(0)
> > +
> > +#define OPTEE_SMC_FUNCID_CONFIGURE_NOTIF_IT    21
> > +#define OPTEE_SMC_CONFIGURE_NOTIF_IT \
> > +       OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_CONFIGURE_NOTIF_IT)
> > +
> >  /*
> >   * Resume from RPC (for example after processing a foreign interrupt)
> >   *
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index a1c1fa1a9c28..9f4fdd28f04a 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -977,6 +977,71 @@ static int optee_smc_stop_async_notif(struct tee_context *ctx)
> >   * 5. Asynchronous notification
> >   */
> >
> > +static void config_notif_it(optee_invoke_fn *invoke_fn, u32 it_value,
> > +                           u32 op_mask, u32 val_mask)
> > +{
> > +       struct arm_smccc_res res = { };
> > +
> > +       invoke_fn(OPTEE_SMC_CONFIGURE_NOTIF_IT, it_value, op_mask, val_mask,
> > +                 0, 0, 0, 0, &res);
> > +}
> > +
> > +static void optee_it_irq_mask(struct irq_data *d)
> > +{
> > +       struct optee *optee = d->domain->host_data;
> > +
> > +       config_notif_it(optee->smc.invoke_fn, d->hwirq, OPTEE_SMC_NOTIF_CONFIG_MASK,
> > +                       OPTEE_SMC_NOTIF_CONFIG_MASK);
> > +}
> > +
> > +static void optee_it_irq_unmask(struct irq_data *d)
> > +{
> > +       struct optee *optee = d->domain->host_data;
> > +
> > +       config_notif_it(optee->smc.invoke_fn, d->hwirq, OPTEE_SMC_NOTIF_CONFIG_MASK, 0);
> > +}
> > +
> > +static struct irq_chip optee_it_irq_chip = {
> > +       .name = "optee-it",
> > +       .irq_mask = optee_it_irq_mask,
> > +       .irq_unmask = optee_it_irq_unmask,
> > +};
> > +
> > +static int optee_it_alloc(struct irq_domain *d, unsigned int virq,
> > +                         unsigned int nr_irqs, void *data)
> > +{
> > +       struct irq_fwspec *fwspec = data;
> > +       irq_hw_number_t hwirq;
> > +
> > +       hwirq = fwspec->param[0];
> > +
> > +       irq_domain_set_hwirq_and_chip(d, virq, hwirq, &optee_it_irq_chip, d->host_data);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct irq_domain_ops optee_it_irq_domain_ops = {
> > +       .alloc = optee_it_alloc,
> > +       .free = irq_domain_free_irqs_common,
> > +};
> > +
> > +static int optee_irq_domain_init(struct platform_device *pdev,
> > +                                struct optee *optee, u_int max_it)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct device_node *np = dev->of_node;
> > +
> > +       optee->smc.domain = irq_domain_add_linear(np, max_it,
> > +                                                 &optee_it_irq_domain_ops,
> > +                                                 optee);
> > +       if (!optee->smc.domain) {
> > +               dev_err(dev, "Unable to add irq domain\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
> >                                  bool *value_pending)
> >  {
> > @@ -991,6 +1056,60 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
> >         return res.a1;
> >  }
> >
> > +static void forward_irq(struct optee *optee, unsigned int id)
> > +{
> > +       if (generic_handle_domain_irq(optee->smc.domain, id)) {
> > +               pr_err("No consumer for optee irq %u, it will be masked\n", id);
> > +               config_notif_it(optee->smc.invoke_fn, id,
> > +                               OPTEE_SMC_NOTIF_CONFIG_MASK,
> > +                               OPTEE_SMC_NOTIF_CONFIG_MASK);
> > +       }
> > +}
> > +
> > +static void retrieve_pending_irqs(struct optee *optee, bool *async_value_pending,
> > +                                 bool *do_bottom_half)
> > +
> > +{
> > +       struct arm_smccc_res res;
> > +       bool it_pending;
> > +       ssize_t cnt;
> > +       const unsigned int lsb_mask = GENMASK(15, 0);
> > +       const unsigned int msb_shift = 16;
> > +
> > +       *async_value_pending = false;
> > +       *do_bottom_half = false;
> > +
> > +       do {
> > +               optee->smc.invoke_fn(OPTEE_SMC_GET_NOTIF_IT, 0, 0, 0, 0, 0, 0, 0, &res);
> > +
> > +               if (res.a0)
> > +                       return;
> > +
> > +               if (res.a1 & OPTEE_SMC_NOTIF_DO_BOTTOM_HALF)
> > +                       *do_bottom_half = true;
> > +
> > +               it_pending = res.a1 & OPTEE_SMC_NOTIF_IT_PENDING;
> > +               cnt = res.a1 & OPTEE_SMC_NOTIF_IT_COUNT_MASK;
> > +               if (cnt > 5 || (!cnt && it_pending)) {
> > +                       WARN_ONCE(0, "Unexpected interrupt notif count %zi\n", cnt);
> > +                       break;
> > +               }
> > +
> > +               if (--cnt >= 0)
> > +                       forward_irq(optee, res.a1 >> msb_shift);
> > +               if (--cnt >= 0)
> > +                       forward_irq(optee, res.a2 & lsb_mask);
> > +               if (--cnt >= 0)
> > +                       forward_irq(optee, res.a2 >> msb_shift);
> > +               if (--cnt >= 0)
> > +                       forward_irq(optee, res.a3 & lsb_mask);
> > +               if (--cnt >= 0)
> > +                       forward_irq(optee, res.a3 >> msb_shift);
> > +       } while (it_pending);
> > +
> > +       *async_value_pending = res.a1 & OPTEE_SMC_NOTIF_VALUE_PENDING;
> > +}
> > +
> >  static irqreturn_t notif_irq_handler(int irq, void *dev_id)
> >  {
> >         struct optee *optee = dev_id;
> > @@ -999,9 +1118,14 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
> >         bool value_pending;
> >         u32 value;
> >
> > -       do {
> > -               value = get_async_notif_value(optee->smc.invoke_fn,
> > -                                             &value_valid, &value_pending);
> > +       if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_IT_NOTIF)
> > +               retrieve_pending_irqs(optee, &value_pending, &do_bottom_half);
> > +       else
> > +               value_pending = true;
> > +
> > +       while (value_pending) {
> > +               value = get_async_notif_value(optee->smc.invoke_fn, &value_valid,
> > +                                             &value_pending);
> >                 if (!value_valid)
> >                         break;
> >
> > @@ -1009,10 +1133,11 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
> >                         do_bottom_half = true;
> >                 else
> >                         optee_notif_send(optee, value);
> > -       } while (value_pending);
> > +       };
> >
> >         if (do_bottom_half)
> >                 return IRQ_WAKE_THREAD;
> > +
> >         return IRQ_HANDLED;
> >  }
> >
> > @@ -1048,6 +1173,9 @@ static void optee_smc_notif_uninit_irq(struct optee *optee)
> >                         free_irq(optee->smc.notif_irq, optee);
> >                         irq_dispose_mapping(optee->smc.notif_irq);
> >                 }
> > +
> > +               if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_IT_NOTIF)
> > +                       irq_domain_remove(optee->smc.domain);
> >         }
> >  }
> >
> > @@ -1187,13 +1315,14 @@ static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
> >
> >  static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
> >                                             u32 *sec_caps, u32 *max_notif_value,
> > +                                           u32 *max_notif_it,
> >                                             unsigned int *rpc_param_count)
> >  {
> >         union {
> >                 struct arm_smccc_res smccc;
> >                 struct optee_smc_exchange_capabilities_result result;
> >         } res;
> > -       u32 a1 = 0;
> > +       u32 a1 = OPTEE_SMC_SEC_CAP_IT_NOTIF;
> >
> >         /*
> >          * TODO This isn't enough to tell if it's UP system (from kernel
> > @@ -1219,6 +1348,12 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
> >         else
> >                 *rpc_param_count = 0;
> >
> > +       if (*sec_caps & OPTEE_SMC_SEC_CAP_IT_NOTIF)
> > +               *max_notif_it = (res.result.data & OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_MASK) >>
> > +                               OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_SHIFT;
> > +       else
> > +               *max_notif_it = 0;
> > +
> >         return true;
> >  }
> >
> > @@ -1364,6 +1499,7 @@ static int optee_probe(struct platform_device *pdev)
> >         struct tee_device *teedev;
> >         struct tee_context *ctx;
> >         u32 max_notif_value;
> > +       u32 max_notif_it;
> >         u32 arg_cache_flags;
> >         u32 sec_caps;
> >         int rc;
> > @@ -1385,7 +1521,7 @@ static int optee_probe(struct platform_device *pdev)
> >         }
> >
> >         if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
> > -                                            &max_notif_value,
> > +                                            &max_notif_value, &max_notif_it,
> >                                              &rpc_param_count)) {
> >                 pr_warn("capabilities mismatch\n");
> >                 return -EINVAL;
> > @@ -1506,6 +1642,16 @@ static int optee_probe(struct platform_device *pdev)
> >                         irq_dispose_mapping(irq);
> >                         goto err_notif_uninit;
> >                 }
> > +
> > +               if (sec_caps & OPTEE_SMC_SEC_CAP_IT_NOTIF) {
> > +                       rc = optee_irq_domain_init(pdev, optee, max_notif_it);
> > +                       if (rc) {
> > +                               free_irq(optee->smc.notif_irq, optee);
> > +                               irq_dispose_mapping(irq);
> > +                               goto err_notif_uninit;
> > +                       }
> > +               }
> > +
> >                 enable_async_notif(optee->smc.invoke_fn);
> >                 pr_info("Asynchronous notifications enabled\n");
> >         }
> > --
> > 2.25.1
> >
