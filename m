Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE46A6B1B54
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCIGVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCIGV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:21:29 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E846A81CCC;
        Wed,  8 Mar 2023 22:21:27 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z5so745359ljc.8;
        Wed, 08 Mar 2023 22:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678342886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4NiT+WUwkl7ajY/2CHHk0PM8G8j4rSPMTj/BUb4FYs=;
        b=CC7VGKdCHTjyeoXD2aywCbXr7+99pip+zKGusJ49g3slnJw+FVdLJGeZ1Qad/gDnvp
         71ls+Ou77sosPHuQTR/uQJ9bCxv/NkLLTLaPsQakpijuYlil3EW16kTmK2SaDDUacBcv
         7bEIUGkfRMXEhTf/3ROubtT5Z/ZDq/MPCRfm54mvnjitGFJOaCiSk+1c4va9NVQe3RQn
         CJohRVyjmsco5q99fJJaVu8nBTIsb/3figFkqTH4sAdrHlfveelBXJZ2FMvDpDAScA12
         d0MT6lkg0hU1FoaVIqXWIJLCaF+slP8yOWiigye73qQvXvbXNkDBNcuLPiq5O3iLxZBI
         LSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678342886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4NiT+WUwkl7ajY/2CHHk0PM8G8j4rSPMTj/BUb4FYs=;
        b=Z5wTj3Ox41Z+peZtkWeZ5lmCR3pE9rLV+YY4asXQqaiSmN9HGPtpxYuEVcf/jo28uj
         dQhl/6ofvq4VdnFx/sKMT+l6XnIDFPLWK64zK52HgxAp0tjHWXCSMq4U4HBU4wW62Cd5
         barwA3tiYKdDyyz8M5OQ4MNKNVVz1KdCfHpNYF1Cke6GBVdRNttgsOWq7dCy+vbtxZV9
         3tqdlk4fmnyyATqMnu8U1wC8Pf6LqRW2c7LEAXzx14AF5HlpFonkJKLlekBBZxejx9SQ
         qcJRz01eCGLXTNvp43p8lsyBGecp8n6DF4sDijkLw7CVIjwlYVhJqzxkvgB7whHjMf2j
         u/ZQ==
X-Gm-Message-State: AO0yUKWswPd+/X35jXj0cCbma1XWksUAqU23nZbfdzoBNqPN8dwlB32m
        1rWfY22/JTiWYx1wAbzFuhTmf7mwoeF/kogo0A==
X-Google-Smtp-Source: AK7set+TEYjWSUmKRTNayox0YsPPffyXXRxjttlEpuX+gGMtiHJS6pL6/83NzTYn5mP2MHf0ffRtcGlpgG2TvdAIDfU=
X-Received: by 2002:a2e:b8d2:0:b0:295:b0cd:522 with SMTP id
 s18-20020a2eb8d2000000b00295b0cd0522mr6696166ljp.2.1678342885782; Wed, 08 Mar
 2023 22:21:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1678247309.git.quic_nguyenb@quicinc.com>
 <c7fcbb70f0e74d225c1a09f107ba1058270739be.1678247309.git.quic_nguyenb@quicinc.com>
 <CAGaU9a_CkxHU-k519TL2hfLZSM6Hfoo6sAELmJ+6Vy2X2ZCOrw@mail.gmail.com> <86620bee-383c-b1e4-d4df-e4d8465a1d89@quicinc.com>
In-Reply-To: <86620bee-383c-b1e4-d4df-e4d8465a1d89@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Thu, 9 Mar 2023 14:21:13 +0800
Message-ID: <CAGaU9a9QkCnN-1CvHGB78vXaARB0uWMZCeAYr7qRcUE9effGYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/4] ufs: mcq: Added ufshcd_mcq_abort()
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bao,

On Thu, Mar 9, 2023 at 1:31=E2=80=AFPM Bao D. Nguyen <quic_nguyenb@quicinc.=
com> wrote:
>
> On 3/8/2023 7:10 PM, Stanley Chu wrote:
> > Hi Bao,
> >
> > On Wed, Mar 8, 2023 at 12:10=E2=80=AFPM Bao D. Nguyen <quic_nguyenb@qui=
cinc.com> wrote:
> >> Add ufshcd_mcq_abort() to support ufs abort in mcq mode.
> >>
> >> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> >> ---
> >>   drivers/ufs/core/ufs-mcq.c     | 76 ++++++++++++++++++++++++++++++++=
++++++++++
> >>   drivers/ufs/core/ufshcd-priv.h |  5 ++-
> >>   drivers/ufs/core/ufshcd.c      | 11 ++++--
> >>   3 files changed, 88 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> >> index e27d8eb..6c65cd5 100644
> >> --- a/drivers/ufs/core/ufs-mcq.c
> >> +++ b/drivers/ufs/core/ufs-mcq.c
> >> @@ -646,3 +646,79 @@ static bool ufshcd_mcq_cqe_search(struct ufs_hba =
*hba,
> >>          spin_unlock(&hwq->cq_lock);
> >>          return ret;
> >>   }
> >> +
> >> +/**
> >> + * ufshcd_mcq_abort - Abort the command in MCQ.
> >> + * @cmd - The command to be aborted.
> >> + *
> >> + * Returns SUCCESS or FAILED error codes
> >> + */
> >> +int ufshcd_mcq_abort(struct scsi_cmnd *cmd)
> >> +{
> >> +       struct Scsi_Host *host =3D cmd->device->host;
> >> +       struct ufs_hba *hba =3D shost_priv(host);
> >> +       int tag =3D scsi_cmd_to_rq(cmd)->tag;
> >> +       struct ufshcd_lrb *lrbp =3D &hba->lrb[tag];
> >> +       struct ufs_hw_queue *hwq;
> >> +       int err =3D FAILED;
> >> +
> >> +       if (!lrbp->cmd) {
> >> +               dev_err(hba->dev,
> >> +                       "%s: skip abort. cmd at tag %d already complet=
ed.\n",
> >> +                       __func__, tag);
> >> +               goto out;
> >> +       }
> >> +
> >> +       /* Skip task abort in case previous aborts failed and report f=
ailure */
> >> +       if (lrbp->req_abort_skip) {
> >> +               dev_err(hba->dev, "%s: skip abort. tag %d failed earli=
er\n",
> >> +                       __func__, tag);
> >> +               goto out;
> >> +       }
> >> +
> >> +       hwq =3D ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
> >> +
> >> +       if (ufshcd_mcq_sqe_search(hba, hwq, tag)) {
> >> +               /*
> >> +                * Failure. The command should not be "stuck" in SQ fo=
r
> >> +                * a long time which resulted in command being aborted=
.
> >> +                */
> >> +               dev_err(hba->dev, "%s: cmd found in sq. hwq=3D%d, tag=
=3D%d\n",
> >> +                               __func__, hwq->id, tag);
> >> +               /* Set the Command Type to 0xF per the spec */
> >> +               ufshcd_mcq_nullify_cmd(hba, hwq);
> >> +               goto out;
> >> +       }
> >> +
> >> +       if (ufshcd_mcq_cqe_search(hba, hwq, tag)) {
> >> +               dev_err(hba->dev, "%s: cmd found in cq. hwq=3D%d, tag=
=3D%d\n",
> >> +                               __func__, hwq->id, tag);
> >> +               /*
> >> +                * The command should not be 'stuck' in the CQ for suc=
h a long time.
> >> +                * Is interrupt missing? Process the CQEs here. If the=
 interrupt is
> >> +                * invoked at a later time, the CQ will be empty becau=
se the CQEs
> >> +                * are already processed here.
> >> +                */
> >> +               ufshcd_mcq_poll_cqe_lock(hba, hwq);
> >> +               err =3D SUCCESS;
> >> +               goto out;
> >> +       }
> >> +
> >> +       /*
> >> +        * The command is not in the Submission Queue, and it is not
> >> +        * in the Completion Queue either. Query the device to see if
> >> +        * the command is being processed in the device.
> >> +        */
> >> +       if (ufshcd_try_to_abort_task(hba, tag)) {
> >> +               dev_err(hba->dev, "%s: device abort failed %d\n", __fu=
nc__, err);
> >> +               lrbp->req_abort_skip =3D true;
> >> +               goto out;
> >> +       }
> >> +
> >> +       err =3D SUCCESS;
> >> +       if (lrbp->cmd)
> >> +               ufshcd_release_scsi_cmd(hba, lrbp);
> >> +
> >> +out:
> >> +       return err;
> >> +}
> >> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-=
priv.h
> >> index 0527926..d883c03 100644
> >> --- a/drivers/ufs/core/ufshcd-priv.h
> >> +++ b/drivers/ufs/core/ufshcd-priv.h
> >> @@ -77,7 +77,10 @@ unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_h=
ba *hba,
> >>                                         struct ufs_hw_queue *hwq);
> >>
> >>   int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag, int *re=
sult);
> >> -
> >> +int ufshcd_mcq_abort(struct scsi_cmnd *cmd);
> >> +int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
> >> +void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
> >> +                               struct ufshcd_lrb *lrbp);
> >>   #define UFSHCD_MCQ_IO_QUEUE_OFFSET     1
> >>   #define SD_ASCII_STD true
> >>   #define SD_RAW false
> >> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> >> index 408c16c..e06399e 100644
> >> --- a/drivers/ufs/core/ufshcd.c
> >> +++ b/drivers/ufs/core/ufshcd.c
> >> @@ -302,7 +302,6 @@ static int ufshcd_setup_hba_vreg(struct ufs_hba *h=
ba, bool on);
> >>   static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on);
> >>   static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
> >>                                           struct ufs_vreg *vreg);
> >> -static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
> >>   static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba=
,
> >>                                                   bool enable);
> >>   static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
> >> @@ -5414,7 +5413,7 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct u=
fs_hba *hba, u32 intr_status)
> >>   }
> >>
> >>   /* Release the resources allocated for processing a SCSI command. */
> >> -static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
> >> +void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
> >>                                      struct ufshcd_lrb *lrbp)
> >>   {
> >>          struct scsi_cmnd *cmd =3D lrbp->cmd;
> >> @@ -7340,7 +7339,7 @@ static void ufshcd_set_req_abort_skip(struct ufs=
_hba *hba, unsigned long bitmap)
> >>    *
> >>    * Returns zero on success, non-zero on failure
> >>    */
> >> -static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
> >> +int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
> >>   {
> >>          struct ufshcd_lrb *lrbp =3D &hba->lrb[tag];
> >>          int err =3D 0;
> >> @@ -7500,6 +7499,12 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
> >>                  goto release;
> >>          }
> >>
> >> +       if (is_mcq_enabled(hba)) {
> >> +               /* MCQ mode. Branch off to handle abort for mcq mode *=
/
> >> +               err =3D ufshcd_mcq_abort(cmd);
> >> +               goto release;
> >> +       }
> >> +
> >>          /* Skip task abort in case previous aborts failed and report =
failure */
> >>          if (lrbp->req_abort_skip) {
> >>                  dev_err(hba->dev, "%s: skipping abort\n", __func__);
> >> --
> >> 2.7.4
> >>
> > It seems that ufshcd_abort_all() also needs an error handling flow for =
MCQ.
>
> Hi Stanley, thank you for the reviews.
>
> I am not able to find the function ufshcd_abort_all() in the drivers/ufs
> directory. Can you please clarify where this function is located? Thanks.

The function ufshcd_abort_all() was introduced in the following link:
https://android.googlesource.com/kernel/common/+/b817e6ffbad7a1a0a5ca5bb7d4=
020823c3f4d9d0

Can you confirm if these patches are based on the latest kernel
6.3-rc1 or the latest linux-next tree?

Thanks,
Stanley

>
> >
> > Thanks,
> > Stanley
>
>
