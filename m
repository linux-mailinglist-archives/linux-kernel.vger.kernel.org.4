Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC266F0187
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbjD0HUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243201AbjD0HTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:19:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD4355B7;
        Thu, 27 Apr 2023 00:18:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4efec123b28so6125706e87.1;
        Thu, 27 Apr 2023 00:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682579882; x=1685171882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gf2k/tWWnz3zZRH7LzlPM+0OmYCFMnQ1Cd9RSWhky9o=;
        b=b4L3+D+iGRsHHP/qc0hjCEf6iBrXOxTP0EvCSs8J9CciIdPZrvW86jZd3wudSvOYvF
         0sp0CkMI4rBxh+PGWdhqygI7VSrmVr8YepdcTrPHzcSeqZo8ISYDxRZ2j7AjIq3OntyA
         tvC7szGRu67JDU0PwOpitCPL2Ewh3T3zWsgKeTTR80vbs4+tChgJz6PwPmUIoq/qAR5i
         9yiJZFuxifiAo36FWW3v+JpOjrjNkjCR8oyc7y1OAp/9ALJd1Pi7d0xcYNh25p0Y3/w4
         MsET8nY2+KODWsj6/xbxWWKQHyv1XAhfvaGnycZRN3+Y6oaSlk99S+yev4j2EogVTu/C
         sS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682579882; x=1685171882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gf2k/tWWnz3zZRH7LzlPM+0OmYCFMnQ1Cd9RSWhky9o=;
        b=I8weV68CRrWjq4IU54cIYdKM1/IBHQJ1vA7xp55EeCnOMtTgqv7iE5G+Mto/vvW6Gj
         uBCc0YrbQgcZwn1RjWL/3TprPUHl6hupNgsIyOzGGrrQ9h1f0rXSFSdHy6oZ52OyxW/t
         QtVOdfWO7uXf1KtlHczPJI6+ruLZ0WQGmyeYNX+gTTd4KEn3FvGV5J0Jx7XSqAXpHsyR
         wSm/mCtsOoRYXnnd/Ovzc5koPvKZ87v4FMFgR78URipONpwict+E8VK4TxlHKyhueR7D
         tO21OTfOEeLzKNZ9BgQjpDq1VWeHPuqoNosI3x5U4COesMN+VtYNhAiaqAfsAFaBdjKZ
         B2uw==
X-Gm-Message-State: AC+VfDwthpmviAU8l94WbXkqIDXp29/4JXeu34Qdeq8aiZU323riZFsy
        /EqTo446dHhs8wM15ihHLQ/ijFcQBtv/lKU0+Q==
X-Google-Smtp-Source: ACHHUZ56wpukJCKWGYD6esmxs8PrAGKvKOBhWwv8HUk1zBd1N3MBIj+/O8yHIi6ndUPlcu2ZXIZcI3DDF0Dx6e/1jJ8=
X-Received: by 2002:a19:7618:0:b0:4ef:ed49:fcc2 with SMTP id
 c24-20020a197618000000b004efed49fcc2mr240725lff.26.1682579882115; Thu, 27 Apr
 2023 00:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680083571.git.quic_nguyenb@quicinc.com> <56ff07e08dbaa6ca3db265c41fa8922a63797905.1680083571.git.quic_nguyenb@quicinc.com>
In-Reply-To: <56ff07e08dbaa6ca3db265c41fa8922a63797905.1680083571.git.quic_nguyenb@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Thu, 27 Apr 2023 15:17:50 +0800
Message-ID: <CAGaU9a9BUaWoKPk-7L6cE7D5c4dNuFbnG1jSaq8zR=P0m8z3Tw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] ufs: core: Add error handling for MCQ mode
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Po-Wen Kao <powen.kao@mediatek.com>, peter.wang@mediatek.com,
        Alice Chao <alice.chao@mediatek.com>, naomi.chu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bao,

Bao D. Nguyen <quic_nguyenb@quicinc.com> =E6=96=BC 2023=E5=B9=B43=E6=9C=882=
9=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:14=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add support for error handling for MCQ mode.
>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> ---
>  drivers/ufs/core/ufshcd.c | 80 ++++++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 69 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index fef1907..e947f7f 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -3127,6 +3127,12 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba =
*hba,
>                 err =3D -ETIMEDOUT;
>                 dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n=
",
>                         __func__, lrbp->task_tag);
> +
> +               /* MCQ mode */
> +               if (is_mcq_enabled(hba))
> +                       return ufshcd_clear_cmds(hba, 1UL << lrbp->task_t=
ag);

When a time-out occurs during the command-clearing process, it appears
that the MCQ path does not properly clear 'hba->dev_cmd.complete'.
This could result in a null pointer reference if the device command
interrupt arrives at a later time.

Could you please help check this?

Thanks,
Stanley Chu

> +
> +               /* SDB mode */
>                 if (ufshcd_clear_cmds(hba, 1UL << lrbp->task_tag) =3D=3D =
0) {
>                         /* successfully cleared the command, retry if nee=
ded */
>                         err =3D -EAGAIN;
> @@ -5562,6 +5568,10 @@ static int ufshcd_poll(struct Scsi_Host *shost, un=
signed int queue_num)
>   */
>  static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
>  {
> +       struct ufshcd_lrb *lrbp;
> +       u32 hwq_num, utag;
> +       int tag;
> +
>         /* Resetting interrupt aggregation counters first and reading the
>          * DOOR_BELL afterward allows us to handle all the completed requ=
ests.
>          * In order to prevent other interrupts starvation the DB is read=
 once
> @@ -5580,7 +5590,22 @@ static irqreturn_t ufshcd_transfer_req_compl(struc=
t ufs_hba *hba)
>          * Ignore the ufshcd_poll() return value and return IRQ_HANDLED s=
ince we
>          * do not want polling to trigger spurious interrupt complaints.
>          */
> -       ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
> +       if (!is_mcq_enabled(hba)) {
> +               ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT=
);
> +               goto out;
> +       }
> +
> +       /* MCQ mode */
> +       for (tag =3D 0; tag < hba->nutrs; tag++) {
> +               lrbp =3D &hba->lrb[tag];
> +               if (lrbp->cmd) {
> +                       utag =3D blk_mq_unique_tag(scsi_cmd_to_rq(lrbp->c=
md));
> +                       hwq_num =3D blk_mq_unique_tag_to_hwq(utag);
> +                       ufshcd_poll(hba->host, hwq_num);
> +               }
> +       }
> +
> +out:
>
>         return IRQ_HANDLED;
>  }
> @@ -6359,18 +6384,36 @@ static bool ufshcd_abort_all(struct ufs_hba *hba)
>         bool needs_reset =3D false;
>         int tag, ret;
>
> -       /* Clear pending transfer requests */
> -       for_each_set_bit(tag, &hba->outstanding_reqs, hba->nutrs) {
> -               ret =3D ufshcd_try_to_abort_task(hba, tag);
> -               dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag=
,
> -                       hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : =
-1,
> -                       ret ? "failed" : "succeeded");
> -               if (ret) {
> -                       needs_reset =3D true;
> -                       goto out;
> +       if (is_mcq_enabled(hba)) {
> +               struct ufshcd_lrb *lrbp;
> +               int tag;
> +
> +               for (tag =3D 0; tag < hba->nutrs; tag++) {
> +                       lrbp =3D &hba->lrb[tag];
> +                       if (lrbp->cmd) {
> +                               ret =3D ufshcd_try_to_abort_task(hba, tag=
);
> +                               dev_err(hba->dev, "Aborting tag %d / CDB =
%#02x %s\n", tag,
> +                                       hba->lrb[tag].cmd ? hba->lrb[tag]=
.cmd->cmnd[0] : -1,
> +                                       ret ? "failed" : "succeeded");
> +                       }
> +                       if (ret) {
> +                               needs_reset =3D true;
> +                               goto out;
> +                       }
> +               }
> +       } else {
> +               /* Clear pending transfer requests */
> +               for_each_set_bit(tag, &hba->outstanding_reqs, hba->nutrs)=
 {
> +                       ret =3D ufshcd_try_to_abort_task(hba, tag);
> +                       dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s=
\n", tag,
> +                               hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cm=
nd[0] : -1,
> +                               ret ? "failed" : "succeeded");
> +                       if (ret) {
> +                               needs_reset =3D true;
> +                               goto out;
> +                       }
>                 }
>         }
> -
>         /* Clear pending task management requests */
>         for_each_set_bit(tag, &hba->outstanding_tasks, hba->nutmrs) {
>                 if (ufshcd_clear_tm_cmd(hba, tag)) {
> @@ -7302,6 +7345,8 @@ static int ufshcd_eh_device_reset_handler(struct sc=
si_cmnd *cmd)
>         unsigned long flags, pending_reqs =3D 0, not_cleared =3D 0;
>         struct Scsi_Host *host;
>         struct ufs_hba *hba;
> +       struct ufs_hw_queue *hwq;
> +       struct ufshcd_lrb *lrbp;
>         u32 pos;
>         int err;
>         u8 resp =3D 0xF, lun;
> @@ -7317,6 +7362,19 @@ static int ufshcd_eh_device_reset_handler(struct s=
csi_cmnd *cmd)
>                 goto out;
>         }
>
> +       if (is_mcq_enabled(hba)) {
> +               for (pos =3D 0; pos < hba->nutrs; pos++) {
> +                       lrbp =3D &hba->lrb[pos];
> +                       if (lrbp->cmd && lrbp->lun =3D=3D lun) {
> +                               ufshcd_clear_cmds(hba, 1UL << pos);
> +                               hwq =3D ufshcd_mcq_req_to_hwq(hba, scsi_c=
md_to_rq(lrbp->cmd));
> +                               ufshcd_mcq_poll_cqe_lock(hba, hwq);
> +                       }
> +               }
> +               err =3D 0;
> +               goto out;
> +       }
> +
>         /* clear the commands that were pending for corresponding LUN */
>         spin_lock_irqsave(&hba->outstanding_lock, flags);
>         for_each_set_bit(pos, &hba->outstanding_reqs, hba->nutrs)
> --
> 2.7.4
>
