Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5774C621838
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiKHP1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiKHP1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:27:49 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C6427DFD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:27:47 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l6so14150843pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 07:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2f8QgIK0EzZxY21GCr9/k06FhRwUGzI55oTjcY60164=;
        b=ed8BnJTkVhFd8GfrNWwzdq9WzvxSVj517ObhQygRpny/Xx4BysOyakCPPqr+s3ut0e
         yR6jG2OAsSf1FlfY+oL2wRPUUiqHpcpKyXqdA/mV8eWKKT+IpQCS7aK+XhftUK5L6Q5S
         Mjmd8O/M55md9QtuCKWdkK/3cJ9JdRdLZz/WWVnle44MRZXyxstFulfH0ho4ui3LfEM7
         cKHCRUFAxrJIETpN6a3MC7sZ/ilX/TYEdfFB0Rv8kGIK4WbSMXBwK6iqL25EWu9wraAl
         9MxUv36XiyZyEhOIBYyxRBJCJ3BaYggwyTMPyVjSuAsDKIJ1G9niPDics+Us8pUCp/IQ
         RyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2f8QgIK0EzZxY21GCr9/k06FhRwUGzI55oTjcY60164=;
        b=3tTEOQ9kES5k/uz4bIEFvBbBa2jqcVv9S8YK2/9kztHAWEDtcvCQ7FLA2Sm4rR7Kb6
         iwGLGhel1U01uCU2Ss7noMZOr7rEwuNOFohtSqhzXeReyUEjaD1UdKIsAd8olkzwGXZQ
         3ehQmmmhVkvQf2+ZyE5JJich2f9hDBeFA5lButb7uLgP1chOTS6NpBtrGOEgUVPqUwSs
         Crdl+Mstqq/eUg6po82V4UnelrRoUojKkFC09zB256X7ae729KzO0t3cHiWKPspqZDH5
         9BG6ncb414ge+Lh9TLk/bxVnTJW9m+Th1yJMM17cJr+ETY9mS924b5zSTwEqiKrKXALk
         KqQw==
X-Gm-Message-State: ACrzQf0pctK/uvDRtHEvlsp0F43Yc+G/wLhM2XPAgCprrY6BTFywQsj9
        Pjp8aVHltsmdcT8pzbSur0hR9ByLskY47J9lA/v/BA==
X-Google-Smtp-Source: AMsMyM6+cjwzE4BboPneMA/n5PWx0ZNDTCKkbyt8J0WerbAepIDd94IFQAZXd2FDi11p0PbR8iBSq2MHWl/MDVuWGTU=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr57715896plb.148.1667921267394; Tue, 08
 Nov 2022 07:27:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1667087353.git.tonyhuang.sunplus@gmail.com> <cfdf24a75afd0c57c7785da1a9b7f75f6e7c8bd5.1667087353.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cfdf24a75afd0c57c7785da1a9b7f75f6e7c8bd5.1667087353.git.tonyhuang.sunplus@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Nov 2022 16:27:10 +0100
Message-ID: <CAPDyKFq97g0bnthySGsCrmwuKg-8Yx1ZK9-tbo5SygTEG-yidw@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] mmc: Add mmc driver for Sunplus SP7021
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     lhjeff911@gmail.com, robh+dt@kernle.org, krzk+dz@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Oct 2022 at 02:51, Tony Huang <tonyhuang.sunplus@gmail.com> wrote:
>
> This is a patch for mmc driver for Sunplus SP7021 SOC.
> Supports eMMC 4.41 DDR 104MB/s speed mode.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>

Overall the code has improved a lot during the iterations, thanks for
doing a good job around that!

Although, there are still a few things that I think deserve to be
fixed before I am ready to apply this. Please have a look below.

[...]

> diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
> new file mode 100644
> index 0000000..d36c700
> --- /dev/null
> +++ b/drivers/mmc/host/sunplus-mmc.c
> @@ -0,0 +1,976 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Sunplus Inc.
> + * Author: Tony Huang <tonyhuang.sunplus@gmail.com>
> + * Author: Li-hao Kuo <lhjeff911@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/mmc/core.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sdio.h>
> +#include <linux/mmc/slot-gpio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +
> +#define SPMMC_MIN_CLK                  400000
> +#define SPMMC_MAX_CLK                  52000000
> +#define SPMMC_MAX_BLK_COUNT            65536
> +#define SPMMC_MAX_TUNABLE_DLY  7
> +#define SPMMC_TIMEOUT                  500000

Would you mind renaming this to SPMMC_TIMEOUT_US, to easier understand
its value.

[...]

> +
> +static inline int spmmc_wait_finish(struct spmmc_host *host)
> +{
> +       u32 state;
> +
> +       return readl_poll_timeout(host->base + SPMMC_SD_STATE_REG, state,
> +                                       (state & SPMMC_SDSTATE_FINISH), 10, SPMMC_TIMEOUT);

Would you mind adding a definition for the 10us polling delay? Perhaps
SPMMC_POLL_DELAY_US?

> +}
> +
> +static inline int spmmc_wait_sdstatus(struct spmmc_host *host, unsigned int status_bit)
> +{
> +       u32 status;
> +
> +       return readl_poll_timeout(host->base + SPMMC_SD_STATUS_REG, status,
> +                                       (status & status_bit), 10, SPMMC_TIMEOUT);

Ditto.

[...]

> +static void spmmc_sw_reset(struct spmmc_host *host)
> +{
> +       u32 value;
> +
> +       /*
> +        * Must reset dma operation first, or it will
> +        * be stuck on sd_state == 0x1c00 because of
> +        * a controller software reset bug
> +        */
> +       value = readl(host->base + SPMMC_HW_DMA_CTRL_REG);
> +       value |= SPMMC_DMAIDLE;
> +       writel(value, host->base + SPMMC_HW_DMA_CTRL_REG);
> +       value &= ~SPMMC_DMAIDLE;
> +       writel(value, host->base + SPMMC_HW_DMA_CTRL_REG);
> +       value = readl(host->base + SPMMC_HW_DMA_CTRL_REG);
> +       value |= SPMMC_HW_DMA_RST;
> +       writel(value, host->base + SPMMC_HW_DMA_CTRL_REG);
> +       writel(0x7, host->base + SPMMC_SD_RST_REG);
> +       readl_poll_timeout_atomic(host->base + SPMMC_SD_HW_STATE_REG, value,
> +                                 !(value & BIT(6)), 1, SPMMC_TIMEOUT);

As Arnd also pointed out earlier, we should strive to avoid polling in
atomic context, unless it's really needed and then not use long
timeouts.

If the above thing would have been the only case for this driver, I
might have been okay with this. Especially, since I believe we should
be able to tune the timeout value to something far less than the 500ms
timeout for this reset case, don't you think?

That said, let's discuss the other cases below, to figure out how to
move forward.

[...]

> +static void spmmc_send_stop_cmd(struct spmmc_host *host)
> +{
> +       struct mmc_command stop = {};
> +       u32 value;
> +
> +       stop.opcode = MMC_STOP_TRANSMISSION;
> +       stop.arg = 0;
> +       stop.flags = MMC_RSP_R1B;
> +       spmmc_prepare_cmd(host, &stop);
> +       value = readl(host->base + SPMMC_SD_INT_REG);
> +       value &= ~SPMMC_SDINT_SDCMPEN;
> +       value |= FIELD_PREP(SPMMC_SDINT_SDCMPEN, 0);
> +       writel(value, host->base + SPMMC_SD_INT_REG);
> +       spmmc_trigger_transaction(host);
> +       readl_poll_timeout_atomic(host->base + SPMMC_SD_STATE_REG, value,
> +                                 (value & SPMMC_SDSTATE_FINISH), 1, SPMMC_TIMEOUT);

This is problematic and even worse (from the polling point of view) if
the controller would support HW-busy detection on DAT0, for R1B
responses. Do you know if that is supported?

No matter what, polling for a response from a MMC_STOP_TRANSMISSION
command should be avoided from within an atomic context. Simply,
because the time we would need to poll may be rather long.

To fix this problem, I see in principle two ways to move forward. The
best would be to wait for an IRQ to receive the response of the
command, thus entirely avoiding the polling. Although, I guess that
doesn't work for this HW - or does it?

The second best option is to poll from a non-atomic context. Now, by
looking at the code in the IRQ handler spmmc_irq(), that seems rather
easy to fix, as we should only need to switch to use the threaded RQ
handler spmmc_func_finish_req() instead. Let me elaborate on that more
below.

[...]

> +static inline int __find_best_delay(u8 candidate_dly)

Please be consistent with the prefix of the function names. I would
prefer, spmmc_find_best_delay(), or something along those lines.

> +{
> +       int f, w, value;
> +
> +       if (!candidate_dly)
> +               return 0;
> +       f = ffs(candidate_dly) - 1;
> +       w = hweight8(candidate_dly);
> +       value = ((1 << w) - 1) << f;
> +       if (0xff == (value & ~candidate_dly))
> +               return (f + w / 2);
> +       else
> +               return (f);
> +}

[...]

> +static void spmmc_finish_request(struct spmmc_host *host, struct mmc_request *mrq)
> +{
> +       struct mmc_command *cmd;
> +       struct mmc_data *data;
> +
> +       if (!mrq)
> +               return;
> +
> +       cmd = mrq->cmd;
> +       data = mrq->data;
> +
> +       if (data && SPMMC_DMA_MODE == host->dmapio_mode) {
> +               dma_unmap_sg(host->mmc->parent, data->sg, data->sg_len, mmc_get_dma_dir(data));
> +               host->dma_use_int = 0;
> +       }
> +
> +       spmmc_get_rsp(host, cmd);
> +       spmmc_check_error(host, mrq);
> +       if (mrq->stop)
> +               spmmc_send_stop_cmd(host);
> +
> +       host->mrq = NULL;
> +       mmc_request_done(host->mmc, mrq);
> +}
> +
> +/* Interrupt Service Routine */
> +static irqreturn_t spmmc_irq(int irq, void *dev_id)
> +{
> +       struct spmmc_host *host = dev_id;
> +       u32 value = readl(host->base + SPMMC_SD_INT_REG);
> +
> +       spin_lock(&host->lock);
> +       if ((value & SPMMC_SDINT_SDCMP) && (value & SPMMC_SDINT_SDCMPEN)) {
> +               value &= ~SPMMC_SDINT_SDCMPEN;
> +               value |= SPMMC_SDINT_SDCMPCLR;
> +               writel(value, host->base + SPMMC_SD_INT_REG);
> +               spmmc_finish_request(host, host->mrq);

Instead of calling spmmc_finish_request() from here, we should be able
to return IRQ_WAKE_THREAD to let the threaded handler
spmmc_func_finish_req() to run instead.

As a matter of fact, it looks like the threaded handler
spmmc_func_finish_req() is currently never being invoked. Or is it?

An even better option would be to drop the primary IRQ handler
completely, but instead always use the threaded handler. This should
also allow us to convert the spinlock into a mutex and enables us to
move away from readl_poll_timeout_atomic() and use
readl_poll_timeout() instead.

> +       }
> +       spin_unlock(&host->lock);
> +
> +       return IRQ_HANDLED;
> +}
> +

[...]

Kind regards
Uffe
