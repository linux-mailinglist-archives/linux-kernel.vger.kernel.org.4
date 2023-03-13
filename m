Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BE66B7973
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCMNuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMNud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:50:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08BD23640;
        Mon, 13 Mar 2023 06:50:32 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id z10so6920840pgr.8;
        Mon, 13 Mar 2023 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678715432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0slDHNN8/BdrMbgc+7zqjHjOG9tY+7Xd79Alajn/RY=;
        b=C27H9R8cDGjOHixrgjQosdjLQ877J/bqG9ewVDIDhsHMafRjDF5uYlFkEhT2nxwGU0
         aVWHAH2M4t2LpUQ5guTQeFsJErOP7IQ1IY/qAwP3kyMRbRCZupghoobCiLhIMy4Ysjjd
         RdTE25wfHscCr1JlUyCK8JiiWZkKwQeI3Wm6z7RlemHlegslZw/y8sJhNDoyM14VZ7gN
         /2saryYRozRBktVUAa9elvO8ryrRr/jvhROVzbwvg+/9cSMUhb32Gv9CyGi/5OfbqsyZ
         H9eYeAjAq1/3325Y2n+2qudEIFHzUhbi0lXPMZzA0QqroKwErEwwyRPIc7Oj9UatK7Qn
         9Udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678715432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0slDHNN8/BdrMbgc+7zqjHjOG9tY+7Xd79Alajn/RY=;
        b=W6Gn3+m51mS2C8xIvcQ6+eOfF3T3YZHPG0QEAWFtJIjO/pSwb17sNhRWmqzHA9DtNx
         VlqdppniIdKD5q0/3aeJzpQpTuxuIZI5S3Fu5hi4ssi6MeAl+MQ9JDufUj6vGlwR6keR
         iKsCWR0iPPj6wg59qmp7sFpgs894mrxeeAgcTt29D1DpT2Mcl5z6wgWabycJtPGULPls
         Kbi/Dphr4BP0zprcVQL67aeg6CupUiTnNt9EUPq8Z1+/vJXTkmNd2Dd8d+L3g8ZJZCn/
         hjaQSCh8Rwe66+y/tUq/TA05AgqCKo9XVFgdhAVpXUEKOr6YnOXEMqNvQsthhJm4NXV9
         4V+Q==
X-Gm-Message-State: AO0yUKUOEeFPNaKZ6146sUnNzufb/SlJXCdd2sdHhSsgEZm6CSCNupDr
        FBdM6jJiZvv4d5Omc/keO23V6zyttRvI7L3ttTY=
X-Google-Smtp-Source: AK7set+3M2xZK/+NAChWKcLBX5k1lbxHO0uJw/7dcLEvcXDmIiCru+rRuyQLZI4q0I87/8eF1BfnAB51dLDgL2JIT+8=
X-Received: by 2002:a62:8643:0:b0:590:3182:9339 with SMTP id
 x64-20020a628643000000b0059031829339mr13311542pfd.0.1678715432287; Mon, 13
 Mar 2023 06:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230307153542.1178065-1-zyytlz.wz@163.com> <7f9796d2-1885-a6f2-b9e3-d6ea58524033@xs4all.nl>
 <CAJedcCwnvNK8Gbcxz2V5+ebRJFrEYjpoJsKTKZ7DOSETr_7LEQ@mail.gmail.com> <1c1e4e60-3b90-f268-8012-3193e1de4769@xs4all.nl>
In-Reply-To: <1c1e4e60-3b90-f268-8012-3193e1de4769@xs4all.nl>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 13 Mar 2023 21:50:19 +0800
Message-ID: <CAJedcCwm_2Z3stAtzAeJFgj88BsZrQ5kk7Wt4+gW=mL-p0oLrw@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: fix use after free bug in hantro_release
 due to race condition
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Zheng Wang <zyytlz.wz@163.com>, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Verkuil <hverkuil@xs4all.nl> =E4=BA=8E2023=E5=B9=B43=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=B8=80 21:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On 13/03/2023 14:45, Zheng Hacker wrote:
> > Hans Verkuil <hverkuil@xs4all.nl> =E4=BA=8E2023=E5=B9=B43=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=B8=80 21:17=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 07/03/2023 16:35, Zheng Wang wrote:
> >>> In hantro_probe, vpu->watchdog_work is bound with
> >>> hantro_watchdog. Then hantro_end_prepare_run may
> >>> be called to start the work.
> >>>
> >>> If we close the file or remove the module which will
> >>> call hantro_release and hantro_remove to make cleanup,
> >>> there may be a unfinished work. The possible sequence
> >>> is as follows, which will cause a typical UAF bug.
> >>>
> >>> The same thing will happen in hantro_release, and use
> >>> ctx after freeing it.
> >>>
> >>> Fix it by canceling the work before cleanup in hantro_release.
> >>>
> >>> CPU0                  CPU1
> >>>
> >>>                     |hantro_watchdog
> >>> hantro_remove     |
> >>>   v4l2_m2m_release  |
> >>>     kfree(m2m_dev); |
> >>>                     |
> >>>                     | v4l2_m2m_get_curr_priv
> >>>                     |   m2m_dev->curr_ctx //use
> >>>
> >>> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> >>> ---
> >>>  drivers/media/platform/verisilicon/hantro_drv.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/driver=
s/media/platform/verisilicon/hantro_drv.c
> >>> index b0aeedae7b65..cf00ccaa7829 100644
> >>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> >>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> >>> @@ -601,6 +601,7 @@ static int hantro_release(struct file *filp)
> >>>        * No need for extra locking because this was the last referenc=
e
> >>>        * to this file.
> >>>        */
> >>> +     cancel_delayed_work(&vpu->watchdog_work);
> >>>       v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
> >>>       v4l2_fh_del(&ctx->fh);
> >>>       v4l2_fh_exit(&ctx->fh);
> >>
> >> drivers/media/platform/verisilicon/hantro_drv.c: In function =E2=80=98=
hantro_release=E2=80=99:
> >> drivers/media/platform/verisilicon/hantro_drv.c:604:30: error: =E2=80=
=98vpu=E2=80=99 undeclared (first use in this function); did you mean =E2=
=80=98fpu=E2=80=99?
> >>   604 |         cancel_delayed_work(&vpu->watchdog_work);
> >>       |                              ^~~
> >>       |                              fpu
> >> drivers/media/platform/verisilicon/hantro_drv.c:604:30: note: each und=
eclared identifier is reported only once for each function it appears in
> >>
> >> You clearly didn't compile this patch!
> >>
> > Sorry for my mistake. I was hurried to report the issue and discuss
> > with developer to confirm it . I'll complete it and test it locally.
>
> Was this UAF actually observed, or is it theoretical?
>

This is a bug identified during a static audit and referenced to other
similar issues. There's no PoC but some work has proven that the race
time window can be enlarge which make the UAF practical.

Best regards,
Zheng
