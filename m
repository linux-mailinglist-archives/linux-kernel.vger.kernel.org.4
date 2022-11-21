Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C306318D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 04:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiKUDLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 22:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUDLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 22:11:45 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDE831DEB;
        Sun, 20 Nov 2022 19:11:44 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id df6so5054624qvb.0;
        Sun, 20 Nov 2022 19:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bp66fhZa23Lx4Fm33X8AfxGXPwrscAWxri9fM1lS0Yc=;
        b=RZV8fc5cIT8B4OMtuvIkS/KgT4Yovs9jGEjQV4rWHk5ggIE+zNAU7DBKOKrJAUYgvZ
         Y8iTzXpx+EGYpUbeILj752pXmObTALm/O0yg3/fL0aWZjDGrx5erLUtBsXRw26sjip25
         WuBylG7JuREKUEV2Ol5gHai65V3SRJ6WplsMF4G6e94XpEJ+WZ+I7IuV7YzvKycask/J
         rPsAxFh5nzrSF4Iirp3a6gxSgpASdaZBFhKZxwsWVug3aBcPVG/3Me8CaVMcjIi0C6vn
         HyF05qut3uu8xuR5w25JFJSh4O2Ee7V1VI90Am2eNYX9ffDFDH5RckQ5m4O/oJmL/DVX
         4hlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bp66fhZa23Lx4Fm33X8AfxGXPwrscAWxri9fM1lS0Yc=;
        b=0RDOod+aqwoARa9MJg2GNltVUa21ONvXCRLr3ilvG5PaNwQ7H0IOpxAy3vLFy9k01A
         bq5iOb12NjEu3VcBnuQrD/F0fkRKGA2PbGyYHAocortXmTcjqriroGbEgeCmUEBytREq
         Pap1JCdMWmPXMbuNW54lxL4AhREXw0VF/M3hzNeUzuI1HZSMrD7FIlRjWvdRC4JWxuDC
         5B4gjF+4PtreSsP0hPoWZnSbYIjfWHABC5oH+NeuaJqhdOqFxLfftv6z952Pz4uk/+MA
         TJ2AtPP/K/oKIsDBXCq/qNerg579Du4Lqjp0sW37psrHq4hvdIWTJmOZytZxQDFYF9nr
         VDjQ==
X-Gm-Message-State: ANoB5pmGvNjXHkQjgkDDWzIcSHszjB9q9ZYInrAZUDPIA3aAMER2t0jr
        K5kAIj7HiybrzfGzg7lr0Pp2uzjsk2BqZPs9Y7uIbwS84WAwVg==
X-Google-Smtp-Source: AA0mqf6We6WyVUBp60PZ9+PRfaSSEeFtCdkM2STx9IgiJUeoZZdHVuW/PikPKECSylPZtmKfpmDJKVbIqlc/cdA6cP0=
X-Received: by 2002:ad4:50ac:0:b0:4bb:ce03:5714 with SMTP id
 d12-20020ad450ac000000b004bbce035714mr4414352qvq.30.1669000303574; Sun, 20
 Nov 2022 19:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20221111084214.14822-1-wenchao.chen666@gmail.com>
 <20221111084214.14822-2-wenchao.chen666@gmail.com> <59fc95ec-c0db-4011-eca3-3d101f0bc908@intel.com>
 <CA+Da2qwdtUdCcv+HhNArGoriVtOmx+GGML4Avkk5QSdm8+XXTQ@mail.gmail.com> <8433ae30-2633-1f32-ef11-2168c9cfea80@intel.com>
In-Reply-To: <8433ae30-2633-1f32-ef11-2168c9cfea80@intel.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Mon, 21 Nov 2022 11:11:32 +0800
Message-ID: <CA+Da2qwBmApEZ6ejGBTjftsytkeNZbHZ-0oQDWa5TD8Qp3CYHA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: sdhci: Fixed too many logs being printed during tuning
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:57 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 18/11/22 11:25, Wenchao Chen wrote:
> > On Thu, Nov 17, 2022 at 12:00 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 11/11/22 10:42, Wenchao Chen wrote:
> >>> From: Wenchao Chen <wenchao.chen@unisoc.com>
> >>>
> >>> During the HS200 tuning process, too many tuning errors are printed in
> >>> the log.
> >>>
> >>> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> >>> ---
> >>>  drivers/mmc/host/sdhci.c | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>> index fef03de85b99..a503b54305eb 100644
> >>> --- a/drivers/mmc/host/sdhci.c
> >>> +++ b/drivers/mmc/host/sdhci.c
> >>> @@ -3401,6 +3401,10 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
> >>>               if (host->pending_reset)
> >>>                       return;
> >>>
> >>> +             command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
> >>> +             if (command == MMC_SEND_TUNING_BLOCK || command == MMC_SEND_TUNING_BLOCK_HS200)
> >>> +                     return;
> >>
> >> Normally we wouldn't get here even if a request got an error because
> >> then we either reset the data circuit which should stop further
> >> interrupts, or set host->pending_reset.
> >>
> >> Can you elaborate on what is going wrong?
> >>
> > Hi  adrian
> > 1. In the process of tuning, not all tuning values are good, some
> > tuning values may cause errors, and these errors print too many logs.
> >     Of course, we reset the cmdline or dataline on error.
> > 2. use host->pending_reset = true
> > static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
> > {
> > ...
> > if (sdhci_needs_reset(host, mrq))
> > host->pending_reset = true;
> > ...
> > }
> >
> > But intmask = 0x00200000
> > static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
> > {
> > ...
> > if (!host->data) {
> > struct mmc_command *data_cmd = host->data_cmd;
> >
> > if (data_cmd && (data_cmd->flags & MMC_RSP_BUSY)) {
> > if (intmask & SDHCI_INT_DATA_TIMEOUT) { //#define
> > SDHCI_INT_DATA_TIMEOUT 0x00100000
> > host->data_cmd = NULL;
> > data_cmd->error = -ETIMEDOUT;
> > sdhci_err_stats_inc(host, CMD_TIMEOUT);
> > __sdhci_finish_mrq(host, data_cmd->mrq);//<=
> > return;
> > }
> > if (intmask & SDHCI_INT_DATA_END) {    //#define  SDHCI_INT_DATA_END 0x00000002
> >
> > host->data_cmd = NULL;
> > /*
> > * Some cards handle busy-end interrupt
> > * before the command completed, so make
> > * sure we do things in the proper order.
> > */
> > if (host->cmd == data_cmd)
> > return;
> >
> > __sdhci_finish_mrq(host, data_cmd->mrq);//<=
> > return;
> > }
> > }
> > ...
> > if (host->pending_reset)
> > return;
> >
> > pr_err("%s: Got data interrupt 0x%08x even though no data operation
> > was in progress.\n",
> >        mmc_hostname(host->mmc), (unsigned)intmask);
> > sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
> > sdhci_dumpregs(host);
> >
> > return;
> > }
> > ...
> > }
>
> Not really following that I'm sorry.
>
> Are you saying you get a data interrupt after he data circuit is reset?
>

No. During the tuning process, sdhci_data_irq does not skip printing
because the interrupt state is 0x00200000 (DATA CRC ERROR).

> >
> >>> +
> >>>               pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
> >>>                      mmc_hostname(host->mmc), (unsigned)intmask);
> >>>               sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
> >>
>
