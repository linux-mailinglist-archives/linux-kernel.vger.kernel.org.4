Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187EF6B7BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCMPXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCMPXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:23:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0842A30B13;
        Mon, 13 Mar 2023 08:23:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so17271075pjb.3;
        Mon, 13 Mar 2023 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678721008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34xsWsWiOmbyB93Kvqs+sLtYSQIx3fZ1vJIzZ76Nhek=;
        b=qD3bJZ5NNDhYYUDMScn4rzcLrEURo6QbAFd7FnO4q8LuNThOfZza/1PDHGOvEchSJe
         il/i5JkVimFSjqyI1iq25Tjq//9HEKEhID14Kb6s9UeRnIXf9A6j/Ns5nG4uDY/C6ttp
         TQHT2/D3gXkfjfYeCrg7NbHg33t+ZWf0xwI1V7auxvYrb0++afco5js5AUZ7EWFiF37D
         lA5PSfLk/uSft3b4a1ARxItSA9D/2xGsWVEibey5jcLM9CWWYd1Ga6Hocx7d0OlS+sy8
         jLGj37y8LqvbOQ0JN9Ilq58e/UmapJn60PeiDi314YvEKXCn1zdrNCkz0ink+tLHLt6d
         xNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34xsWsWiOmbyB93Kvqs+sLtYSQIx3fZ1vJIzZ76Nhek=;
        b=0GE1MTd7QPSxRSg3AeSriWCfjvQvjkcKmQ4UGrlQrhc/Krt0PrsGYSJZBhscOa42wg
         z8qvLCJx8IVo8GR8fALPndzuw5WAX8OEpmwSx6TGowFZqzOfPLHQ8VbTbI6Eab60rE5N
         n96KyX9+u1Qm9wdJ5MUzymq7knpuv24V8HuKnTf2vvGtGEeTO1GXXXL8rwlGU6SnZ9a7
         8VzcEj5yNAq3mHj9dRX6bhDxXeHlqe1I7RYy1xD7b3SHs5MBzEAOc5uEE4YficGfu/cK
         O9iGXcG7FFUS6wTHE9rgfMsCY8Ph3Z2sLi08xFqGWMYqZAxQl1Epms40zYtC5nvtKl0A
         hzUA==
X-Gm-Message-State: AO0yUKUks0/FmaDjEDywFOV6hm/13Cawp4iFbBrZgsr35zxipGow2D6H
        mhsI06T4rrqCDtgwSvuxmM1JI91LFXNSFtkC/Kz/9qy/5BiRyzdxwqpjkg==
X-Google-Smtp-Source: AK7set9khxSE6og1PK4j9e0NTlY7s9WEuapQTurqJR1/JDOKpo7tYbBIXse/r1mgt5AXJDejtfp/khI66nunHCB4klw=
X-Received: by 2002:a17:903:3410:b0:19f:3cc1:e3c3 with SMTP id
 ke16-20020a170903341000b0019f3cc1e3c3mr1956259plb.12.1678721008482; Mon, 13
 Mar 2023 08:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230307154157.1184826-1-zyytlz.wz@163.com> <43b48f87-2343-5855-e6c2-8f30319687c5@xs4all.nl>
 <f0db2bb7-01b0-c146-6643-5509e8fa4b11@xs4all.nl>
In-Reply-To: <f0db2bb7-01b0-c146-6643-5509e8fa4b11@xs4all.nl>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 13 Mar 2023 23:23:17 +0800
Message-ID: <CAJedcCws+2eK=uu2=+PLZhVVJ+0ErmG5oHSNejDenc4Qu7mpYQ@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: fix use after free bug in hantro_remove
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
=A5=E5=91=A8=E4=B8=80 23:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On 13/03/2023 16:08, Hans Verkuil wrote:
> > On 07/03/2023 16:41, Zheng Wang wrote:
> >> In hantro_probe, vpu->watchdog_work is bound with
> >> hantro_watchdog. Then hantro_end_prepare_run may
> >> be called to start the work.
> >>
> >> If we close the file or remove the module which will
> >> call hantro_release and hantro_remove to make cleanup,
> >> there may be a unfinished work. The possible sequence
> >> is as follows, which will cause a typical UAF bug.
> >>
> >> The same thing will happen in hantro_release, and use
> >> ctx after freeing it.
> >>
> >> Fix it by canceling the work before cleanup in hantro_release.
> >>
> >> CPU0                  CPU1
> >>
> >>                     |hantro_watchdog
> >> hantro_remove     |
> >>   v4l2_m2m_release  |
> >>     kfree(m2m_dev); |
> >>                     |
> >>                     | v4l2_m2m_get_curr_priv
> >>                     |   m2m_dev->curr_ctx //use
> >>
> >> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> >> ---
> >>  drivers/media/platform/verisilicon/hantro_drv.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers=
/media/platform/verisilicon/hantro_drv.c
> >> index b0aeedae7b65..80bd856a4da9 100644
> >> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> >> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> >> @@ -1099,6 +1099,7 @@ static int hantro_remove(struct platform_device =
*pdev)
> >>
> >>      v4l2_info(&vpu->v4l2_dev, "Removing %s\n", pdev->name);
> >>
> >> +    cancel_delayed_work(&vpu->watchdog_work);
> >
> > Use cancel_delayed_work_sync(): that ensures the code waits for a runni=
ng
> > watchdog function to finish.
> >
> > Ditto for the other patch.
>
> And also the cedrus and rkvdec patches.
>
> Regards,
>
Dear Hans,

Thanks for your review. I'll use cancel_delayed_work_sync in the next versi=
on.

Best regards,
Zheng
> >
> >>      media_device_unregister(&vpu->mdev);
> >>      hantro_remove_dec_func(vpu);
> >>      hantro_remove_enc_func(vpu);
> >
>
