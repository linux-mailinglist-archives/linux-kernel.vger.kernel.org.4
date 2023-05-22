Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B6370B562
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjEVGwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjEVGwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:52:09 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78782108;
        Sun, 21 May 2023 23:49:41 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2af2ef0d0daso19882231fa.2;
        Sun, 21 May 2023 23:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684738107; x=1687330107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkyepdTep2HMvZ3/26VCTbq+JBGsvdDQELPma/gFbuI=;
        b=gnhLyfRuVLx07LIYirS88uyzkOB07ExFkviUKTmCtr1yVCyulHITJiaY1/0Hvc1XFi
         ZvHuVvHwFtq2a4EThEvOtTjULPTLNgCVmmYkTBXjQfw64nclQm7T7bzAn5ZV7B4Py36o
         qkgMGFLxOMZT5Ro/VDcIXVYm2WmjXbdYqTuoB7tloS/9kZpAuPGMDWpSGt6FqGIs94/9
         C0QEPE9tl73+89Ryd9A50fIwyun4AF2ALxYM3VpqFqsf9tvRKiUJZDy5ST6IhxDrFDWS
         h2ih3HT4OVsO9P3iyiHcsalWgTjuhBOREPpv/PWEQogMD9Unl5IXuT844338KrQi1Jcu
         eP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738107; x=1687330107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkyepdTep2HMvZ3/26VCTbq+JBGsvdDQELPma/gFbuI=;
        b=DyE3BRlM69hGZyNguDzATNvhXgGoS/W1qgkisxV5Qp/vJrGrRlXRrYMBTSeiPmURYn
         0oYA5sQekBEHysOiK08GwWLOyxE2YgymLbpAlBNC8qF+CsoKp+Q4SXdvAdll7GensNUC
         KZefzw7ZWjTLzCm+n/lI5JGLyJeTqAR6dCXTteSDdNF9yw4l+7XucF55hul/sI3vN7jy
         9KLJWGXEG7WTjedazthn4AJErPkaQmTrfbSjjyNmw/GBW4fls9Fg1fwuOZW9/x6G9p5L
         xClm2QVqgStViwFCn291kka+1glDRlLYpO9kQRBoE641TEXbIfV9jCdTG2xqoUhnUKdR
         d/Cg==
X-Gm-Message-State: AC+VfDz3DofZyo9apb3eSyEobKm3BRqINj3iRy8+1pNNWy8tiosmELWH
        I81PWMYTQ8/ZUxD/cgzN1qMqx1lEe8v7E/4oHQ==
X-Google-Smtp-Source: ACHHUZ4jkfk7xwQESCYIgiAIL8nso8HhBBnZ9562GNyBWeoH6kmXMdamFK3+U3cVuv7iWPC0Nlx5ri5yfxxi1rXlACc=
X-Received: by 2002:ac2:5297:0:b0:4f3:9f9b:ad09 with SMTP id
 q23-20020ac25297000000b004f39f9bad09mr2527102lfm.38.1684738106914; Sun, 21
 May 2023 23:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683872601.git.quic_nguyenb@quicinc.com> <7b884263c9db9a9666086a345ede85bb56d9dfc7.1683872601.git.quic_nguyenb@quicinc.com>
In-Reply-To: <7b884263c9db9a9666086a345ede85bb56d9dfc7.1683872601.git.quic_nguyenb@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Mon, 22 May 2023 14:48:14 +0800
Message-ID: <CAGaU9a8t9CHcGvJk+GFaTO=pDQA+PwEjCWH8sMo=T6-oKvTrsw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] ufs: core: Add error handling for MCQ mode
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
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

Bao D. Nguyen <quic_nguyenb@quicinc.com> =E6=96=BC 2023=E5=B9=B45=E6=9C=881=
2=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:34=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add support for error handling for MCQ mode.
>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> ---
>  drivers/ufs/core/ufshcd.c | 85 +++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 74 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index ec07e49..9345118 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -3148,6 +3148,16 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba =
*hba,
>                 err =3D -ETIMEDOUT;
>                 dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n=
",
>                         __func__, lrbp->task_tag);
> +
> +               /* MCQ mode */
> +               if (is_mcq_enabled(hba)) {
> +                       err =3D ufshcd_clear_cmd(hba, lrbp->task_tag);
> +                       if (!err)
> +                               hba->dev_cmd.complete =3D NULL;

How about always clearing hba->dev_cmd.complete? If ufshcd_clear_cmd()
fails (for example, times out), "complete" should be cleared, similar
to the "pending" case in the SDB path.

> +                       return err;
> +               }
> +
> +               /* SDB mode */
>                 if (ufshcd_clear_cmd(hba, lrbp->task_tag) =3D=3D 0) {
>                         /* successfully cleared the command, retry if nee=
ded */
>                         err =3D -EAGAIN;
> @@ -5581,6 +5591,10 @@ static int ufshcd_poll(struct Scsi_Host *shost, un=
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
> @@ -5599,7 +5613,22 @@ static irqreturn_t ufshcd_transfer_req_compl(struc=
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
> +               if (ufshcd_cmd_inflight(lrbp->cmd)) {
> +                       utag =3D blk_mq_unique_tag(scsi_cmd_to_rq(lrbp->c=
md));
> +                       hwq_num =3D blk_mq_unique_tag_to_hwq(utag);
> +                       ufshcd_poll(hba->host, hwq_num);
> +               }
> +       }

In SDB mode, the DOOR_BELL is reset by ufshcd_hba_stop(). All bits
that were previously set in DOOR_BELL are also set in "completed_reqs"
in ufshcd_poll(). This allows ufshcd_poll() to handle all outstanding
requests properly.

However, in MCQ mode, the CQ tail registers cannot provide the same
information after they are reset. Hence, they cannot be properly
referenced by ufshcd_poll().

Thanks,
Stanley Chu
