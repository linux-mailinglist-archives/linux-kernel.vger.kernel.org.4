Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8FB70B58C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjEVG6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjEVG6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:58:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9E01FFC;
        Sun, 21 May 2023 23:56:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f1411e8111so6204373e87.1;
        Sun, 21 May 2023 23:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684738573; x=1687330573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjIdl2Km4auVdeOee+ENz9jijVAGGq4cYOtS4qc9bPw=;
        b=Qa5AMN9DoH5/PJ1qcjvtJvelEFhNxxBIAQPSCDcdBe6uuUp62hQOTA6ZHOY3CTxCLM
         8tTlAF68S0eUqwN7/lr5FAqH2pRXZGiky8wUkM1qIGxZ06Xq3p1htMG/f0XE+oinIbdw
         auodvw8CqLHNRbWhRki9TwNKtd/zAR+3bmrJQA1WO3LnG4XEeuznf95iFr9GDwVb4BfF
         lIs4FXyVqCQPGvrRdVHZIQyM5ole0gjPHsFYZIl5K3tiz7veBHGUMgpgZC1n0JGB3Am8
         QJ9hV5QQxwECWT909gnRBT2rzzL8NhK9awsogS0CmkVyGxQKwNeZdawHgjlP6TQ3uLtl
         jx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738573; x=1687330573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjIdl2Km4auVdeOee+ENz9jijVAGGq4cYOtS4qc9bPw=;
        b=S0JZpMx1N+SvPuvWHvL5iclSVIZg0f74W1aa4LvCM5N9mjFIB6hky3BCNJumXRs8mj
         TIJa+7WcwGlvIPsFqx9IRQ43c8vzVfzfNiLmZQ8QQnpsUn7xgCwOIBGg+FNJKIK7VdmQ
         f74j8GIbQlu2sYkAxnkN8Sv5JatHpfwK+FQeynnDlD0u6q7MQ7TA/vifgyxPjL53pfM/
         ltw9NrQ33KJODOBeJ0RGitebfko2IgB7DuiS+rs+EzQ55EM/yZ0RH6FTRg14L4QoxrrO
         IBSAlJWPgGMbmaXsWh/wud4rR5tC9qbH3M20o1rE4G+kLbtujmKlG2VpGge3jnlvvyKW
         1N7Q==
X-Gm-Message-State: AC+VfDwQxWxTPejRCn9EuaIYdbSQ1uqPPpy7Zw9zumId9hkfhC7OYMBZ
        81F92Vs6epNWYQ3qM2JhQg0Xds40QA6DAE9cfA==
X-Google-Smtp-Source: ACHHUZ7ayZusqT8tJdXENnLUQn5th5A/n6VTy+8wS8fCxaS2HsOykHtX20Q3TklWfQH9CU6/xnFMAjWK5MFvYMDl+mo=
X-Received: by 2002:ac2:4c18:0:b0:4dd:9fd8:3a36 with SMTP id
 t24-20020ac24c18000000b004dd9fd83a36mr2954763lfq.1.1684738573145; Sun, 21 May
 2023 23:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683872601.git.quic_nguyenb@quicinc.com>
 <7b884263c9db9a9666086a345ede85bb56d9dfc7.1683872601.git.quic_nguyenb@quicinc.com>
 <CAGaU9a8t9CHcGvJk+GFaTO=pDQA+PwEjCWH8sMo=T6-oKvTrsw@mail.gmail.com>
In-Reply-To: <CAGaU9a8t9CHcGvJk+GFaTO=pDQA+PwEjCWH8sMo=T6-oKvTrsw@mail.gmail.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Mon, 22 May 2023 14:56:00 +0800
Message-ID: <CAGaU9a8+mDgVu9-rmH944NhbSCGocADUhbdin5gQkrc_FD1xMQ@mail.gmail.com>
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

On Mon, May 22, 2023 at 2:48=E2=80=AFPM Stanley Chu <chu.stanley@gmail.com>=
 wrote:
>
> Hi Bao,
>
> Bao D. Nguyen <quic_nguyenb@quicinc.com> =E6=96=BC 2023=E5=B9=B45=E6=9C=
=8812=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:34=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Add support for error handling for MCQ mode.
> >
> > Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> > ---
> >  drivers/ufs/core/ufshcd.c | 85 +++++++++++++++++++++++++++++++++++++++=
++------
> >  1 file changed, 74 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > index ec07e49..9345118 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > @@ -3148,6 +3148,16 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hb=
a *hba,
> >                 err =3D -ETIMEDOUT;
> >                 dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d=
\n",
> >                         __func__, lrbp->task_tag);
> > +
> > +               /* MCQ mode */
> > +               if (is_mcq_enabled(hba)) {
> > +                       err =3D ufshcd_clear_cmd(hba, lrbp->task_tag);
> > +                       if (!err)
> > +                               hba->dev_cmd.complete =3D NULL;
>
> How about always clearing hba->dev_cmd.complete? If ufshcd_clear_cmd()
> fails (for example, times out), "complete" should be cleared, similar
> to the "pending" case in the SDB path.
>
> > +                       return err;
> > +               }
> > +
> > +               /* SDB mode */
> >                 if (ufshcd_clear_cmd(hba, lrbp->task_tag) =3D=3D 0) {
> >                         /* successfully cleared the command, retry if n=
eeded */
> >                         err =3D -EAGAIN;
> > @@ -5581,6 +5591,10 @@ static int ufshcd_poll(struct Scsi_Host *shost, =
unsigned int queue_num)
> >   */
> >  static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
> >  {
> > +       struct ufshcd_lrb *lrbp;
> > +       u32 hwq_num, utag;
> > +       int tag;
> > +
> >         /* Resetting interrupt aggregation counters first and reading t=
he
> >          * DOOR_BELL afterward allows us to handle all the completed re=
quests.
> >          * In order to prevent other interrupts starvation the DB is re=
ad once
> > @@ -5599,7 +5613,22 @@ static irqreturn_t ufshcd_transfer_req_compl(str=
uct ufs_hba *hba)
> >          * Ignore the ufshcd_poll() return value and return IRQ_HANDLED=
 since we
> >          * do not want polling to trigger spurious interrupt complaints=
.
> >          */
> > -       ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
> > +       if (!is_mcq_enabled(hba)) {
> > +               ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTE=
XT);
> > +               goto out;
> > +       }
> > +
> > +       /* MCQ mode */
> > +       for (tag =3D 0; tag < hba->nutrs; tag++) {
> > +               lrbp =3D &hba->lrb[tag];
> > +               if (ufshcd_cmd_inflight(lrbp->cmd)) {
> > +                       utag =3D blk_mq_unique_tag(scsi_cmd_to_rq(lrbp-=
>cmd));
> > +                       hwq_num =3D blk_mq_unique_tag_to_hwq(utag);
> > +                       ufshcd_poll(hba->host, hwq_num);
> > +               }
> > +       }
>
> In SDB mode, the DOOR_BELL is reset by ufshcd_hba_stop(). All bits
> that were previously set in DOOR_BELL are also set in "completed_reqs"
> in ufshcd_poll(). This allows ufshcd_poll() to handle all outstanding
> requests properly.
>
> However, in MCQ mode, the CQ tail registers cannot provide the same
> information after they are reset. Hence, they cannot be properly
> referenced by ufshcd_poll().

A fixed version sample is as follows and has been tested on our end.

struct scsi_cmnd *cmd;

for (tag =3D 0; tag < hba->nutrs; tag++) {
        lrbp =3D &hba->lrb[tag];
        cmd =3D lrbp->cmd;
        if (ufshcd_cmd_inflight(cmd)) {
                set_host_byte(cmd, DID_ERROR);
                ufshcd_release_scsi_cmd(hba, lrbp);
                scsi_done(cmd);
        }
}

Thanks,
Stanley Chu
