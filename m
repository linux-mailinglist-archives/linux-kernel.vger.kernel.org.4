Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C1B7428F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjF2OzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjF2OzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:55:00 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9C81FC1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:54:58 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-be3e2d172cbso619735276.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688050497; x=1690642497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rtoVNY9/a+RZXpNAvxs5m0NIRQKbmTHO92MA89OkDCE=;
        b=y6RcZw3fDktbZz2B5yIOkhrcaG6qfzzQNLCnjzBb3mTOWBvySw+yKYis5Jpbm/C/D6
         GuUWbG4Tek2T/3f/O7hOgRrWEEIEyYlTMJMBLOS3ZY+NdC2B6zYPQJvUuZZzegNCMgoF
         xiqfo9Xdbl2cIz7pUisnBYFnT1UsIWhV2VifdmUiY7l1OTj4fJ23K0pWKCCQLRJUndCY
         vU1djMxeVq3DelCrrfZdLpdwZwHCjlHGmemQ++8DdpQayX4RsN3q6f3fygWhriVq8lTR
         o6bJEeSH26Q+rwd3XohJMLZc60XhEUJVIQ83IvDeRNZDOltLtXMUWAH42jv1LBKciRXX
         +VcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688050497; x=1690642497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtoVNY9/a+RZXpNAvxs5m0NIRQKbmTHO92MA89OkDCE=;
        b=JThDzestGIXuVIFejsnVDHFI7KrF1HFvCBPlniTLPiwSFgkevaghkuAfgZpe07wdfX
         W7dfFhhvZRlUTI+DQ3qbHsdJkbL8s/ECJO//+kd7v5KXzy3+CpvzyUn4fxf+k8okLpw/
         SOHEN5o4s3kk3GcAu4jMt3Q+jDqxfUo8AuZ5V3Jec3PpkYmEXf01YzsaV35oz0S60o9r
         BSn7ME8e4lni8OC32NeUJ93OVaQ3zfMmB/+EgVL4PBjuMGHsXPADW6DWwl98Ty4QWGLy
         t8C2r64dno6/zRG6/qFuRXi3Dbo3uTUVVmEoqbcCyIxj24XSTPWNcrd3I/KIjrCL2lDM
         LBIA==
X-Gm-Message-State: ABy/qLZQGWwJbIUT9OETzrlmwJ3zeja4XQsDSr1QxeUjQ8+UbVsUFu/6
        wlrszFrHyOwfVtb4ZTuqUNhAvS/6poKy3CMHt2Kttw==
X-Google-Smtp-Source: APBJJlGOo9va/zBh5Drn3nTfzWewQJBg27NKR8QxX2EsDI1HQd7QeFC4lXte5R2+kx9UhCTMvkAPt07pEy4WaZQnFXo=
X-Received: by 2002:a05:6902:529:b0:c22:c2e0:93c1 with SMTP id
 y9-20020a056902052900b00c22c2e093c1mr171570ybs.7.1688050497433; Thu, 29 Jun
 2023 07:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <26d178dcfc2f4b7d9010145d0c051394@hyperstone.com>
 <CAPDyKFrvE6Ur3ASXOmq-2QQxRF37XK+6GzRAJZ-1mGh5hWQE3w@mail.gmail.com> <6e6386ca65964d8da994842b0404af28@hyperstone.com>
In-Reply-To: <6e6386ca65964d8da994842b0404af28@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Jun 2023 16:54:21 +0200
Message-ID: <CAPDyKFqLB3brh1grY6w5eh32gyYM=BKMLhT5geWmXS+enrc4vQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/1] mmc: block: ioctl: Add PROG-error aggregation
To:     Christian Loehle <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 08:47, Christian Loehle <CLoehle@hyperstone.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Donnerstag, 22. Juni 2023 11:46
> > To: Christian Loehle <CLoehle@hyperstone.com>
> > Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Adrian
> > Hunter <adrian.hunter@intel.com>; Avri Altman <avri.altman@wdc.com>
> > Subject: Re: [PATCHv3 1/1] mmc: block: ioctl: Add PROG-error aggregation
> >
> > CAUTION: this mail comes from external!/ACHTUNG: Diese Mail kommt von
> > extern!
> >
> > On Tue, 20 Jun 2023 at 14:44, Christian Loehle <CLoehle@hyperstone.com>
> > wrote:
> > >
> > > Userspace currently has no way of checking for error bits of detection
> > > mode X. These are error bits that are only detected by the card when
> > > executing the command. For e.g. a sanitize operation this may be
> > > minutes after the RSP was seen by the host.
> > >
> > > Currently userspace programs cannot see these error bits reliably.
> > > They could issue a multi ioctl cmd with a CMD13 immediately following
> > > it, but since errors of detection mode X are automatically cleared
> > > (they are all clear condition B).
> > > mmc_poll_for_busy of the first ioctl may have already hidden such an
> > > error flag.
> > >
> > > In case of the security operations: sanitize, secure erases and RPMB
> > > writes, this could lead to the operation not being performed
> > > successfully by the card with the user not knowing.
> > > If the user trusts that this operation is completed (e.g. their data
> > > is sanitized), this could be a security issue.
> > > An attacker could e.g. provoke a eMMC (VCC) flash fail, where a
> > > successful sanitize of a card is not possible. A card may move out of
> > > PROG state but issue a bit 19 R1 error.
> > >
> > > This patch therefore will also have the consequence of a mmc-utils
> > > patch, which enables the bit for the security-sensitive operations.
> > >
> > > Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> > > ---
> > >  drivers/mmc/core/block.c   | 26 +++++++++++++++-----------
> > >  drivers/mmc/core/mmc_ops.c | 14 +++++++-------
> > > drivers/mmc/core/mmc_ops.h |  9 +++++++++
> > >  3 files changed, 31 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> > > e46330815484..c7e2b8ae58a9 100644
> > > --- a/drivers/mmc/core/block.c
> > > +++ b/drivers/mmc/core/block.c
> > > @@ -470,7 +470,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> > *card, struct mmc_blk_data *md,
> > >         struct mmc_data data = {};
> > >         struct mmc_request mrq = {};
> > >         struct scatterlist sg;
> > > -       bool r1b_resp, use_r1b_resp = false;
> > > +       bool r1b_resp;
> > >         unsigned int busy_timeout_ms;
> > >         int err;
> > >         unsigned int target_part;
> > > @@ -551,8 +551,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> > *card, struct mmc_blk_data *md,
> > >         busy_timeout_ms = idata->ic.cmd_timeout_ms ? :
> > MMC_BLK_TIMEOUT_MS;
> > >         r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
> > >         if (r1b_resp)
> > > -               use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd,
> > > -                                                   busy_timeout_ms);
> > > +               mmc_prepare_busy_cmd(card->host, &cmd,
> > > + busy_timeout_ms);
> > >
> > >         mmc_wait_for_req(card->host, &mrq);
> > >         memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp)); @@
> > > -605,19 +604,24 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> > *card, struct mmc_blk_data *md,
> > >         if (idata->ic.postsleep_min_us)
> > >                 usleep_range(idata->ic.postsleep_min_us,
> > > idata->ic.postsleep_max_us);
> > >
> > > -       /* No need to poll when using HW busy detection. */
> > > -       if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) &&
> > use_r1b_resp)
> > > -               return 0;
> > > -
> > >         if (mmc_host_is_spi(card->host)) {
> > >                 if (idata->ic.write_flag || r1b_resp || cmd.flags &
> > MMC_RSP_SPI_BUSY)
> > >                         return mmc_spi_err_check(card);
> > >                 return err;
> > >         }
> > > -       /* Ensure RPMB/R1B command has completed by polling with CMD13.
> > */
> > > -       if (idata->rpmb || r1b_resp)
> > > -               err = mmc_poll_for_busy(card, busy_timeout_ms, false,
> > > -                                       MMC_BUSY_IO);
> > > +       /* Poll for RPMB/write/R1B execution errors */
> >
> > Except for the other comments that I had on v2 (which isn't addressed in v3),
> > I would like this comment to be extended a bit.
> Sorry, could you elaborate on the comments I haven't addressed?
> What I sent as v3 was what I understood from your comments.

No problem, it's probably me that was not clear enough.

Anyway, to help mode this forward, let me amend the patch and submit a
new version of it. Then you can have a look and confirm that it looks
good to you.

[...]

Kind regards
Uffe
