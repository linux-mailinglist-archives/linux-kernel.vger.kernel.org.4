Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A3B6AFEBB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 07:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCHGK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 01:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHGKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 01:10:55 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118A795465;
        Tue,  7 Mar 2023 22:10:53 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z11so9564327pfh.4;
        Tue, 07 Mar 2023 22:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678255852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcMP5vlPRx03oWddxmNQBtShzXd//qFHNzh0RraWFD4=;
        b=WbiI1I2Jcr+3kClatEccOoL7DfYJvCaqlmxfHZa3rLQa/Ww9qcPhk/1jzwdp9cLc7K
         JAfoOzJPW22Pk3VWX21GYAKUY8cSLJqT6uFYrgMJvB0FERjRQ6pbw3ZPrzcGdt9/ONRm
         T/2IKrDBcSvHWh6MWg8GRewUsXoCrOD4p46JUFCOEKDiwAQH41wTs8uZmY2JST8yStia
         PrFTlmK6YUPXTUixuNPDht/e7JRo/MvXgkB+X6lNiImqUikG5Lyhkd1hwSQLu1J7zdqp
         Ed+FAELIv2xjMkOaByoDzFNZkfxpxPfua8MIbPVW3wyPUzPDrq8wwRzdmQQq4Ivzt28w
         N3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678255852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcMP5vlPRx03oWddxmNQBtShzXd//qFHNzh0RraWFD4=;
        b=LiDGpdjBgjJSNZIEttiAgi0qBYGT6yyIJFmiFP5jB8qYPtzsy2m5Vif6ymOv/miB9o
         7XMR4Bgq3nE+0w4/hy5GLh9XkhLvA6NRa+0hQgO9gQSa9nWilVbaWhjb1wK5bJH4bYvb
         b1Zuio8/GuAD+4e2vTvoBk23okr0IIKqkjuv3aMFMIBGZOmEsAiPia/4n1hLYQaW06IN
         XnA3p4VcWoeYER2hJdB8IWI7JiGLnfcsMN1vBR7MOPmDX1LFv+r4hZwsyWw/XppcLHQu
         vtLOE9tjlwk18WaHAbnh12gIR8u+mI3cCEiiaPbPRCLPrd6pBV0EG4s9AlHAc6+zxUSP
         Bx7A==
X-Gm-Message-State: AO0yUKUTJ049OPCeFvOO65sx+N8EiFJZbTX4sS3voF0FkGtgc+2cgZKK
        3U8CtjKQ9i8+wAKG7KVd3cJvOZof5iTTAIwKhXw=
X-Google-Smtp-Source: AK7set+qSEXNWRTh6oONCdq0pECNPcAH7otxC9LGn1nI3uzuJWbi/8510iMYahKIlHFdJJCrBdI7C8B4L17n9zEe2eE=
X-Received: by 2002:a63:2918:0:b0:503:77c9:45aa with SMTP id
 bt24-20020a632918000000b0050377c945aamr5771378pgb.9.1678255852381; Tue, 07
 Mar 2023 22:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20230306062633.200427-1-zyytlz.wz@163.com> <CAJedcCzeVwwi9SkkwouFXUAVhF-tKF4dkqsFqVQwszSwY1SJ0A@mail.gmail.com>
 <57c17bfd-83f3-fcce-0eab-e28469fb0ced@collabora.com> <11c2bce1e5286ad3a9a5be2ee59c2beac168f135.camel@mediatek.com>
 <CAJedcCx13sz5h=fWvJU38P_1W-zd6yZe=iSMpO28_E_kAqUGDA@mail.gmail.com>
 <cfa2f64d2d01ffc53a6afdc9a5b867bbcb07b5f6.camel@mediatek.com>
 <CAJedcCwhk_XuMF8keGZGBTVBZSMuoQeyV_7L1H2VeT2x_vj-ZQ@mail.gmail.com> <86c98d73b0d294e143014ea5e15d0a5d065e1a66.camel@mediatek.com>
In-Reply-To: <86c98d73b0d294e143014ea5e15d0a5d065e1a66.camel@mediatek.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 8 Mar 2023 14:10:40 +0800
Message-ID: <CAJedcCyiczZiKm=zQyYwJCszmEHKYX+sVEBx7UC082pS5K5Oww@mail.gmail.com>
Subject: Re: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     =?UTF-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "zyytlz.wz@163.com" <zyytlz.wz@163.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>,
        =?UTF-8?B?QmluIExpdSAo5YiY5b2sKQ==?= <bin.liu@mediatek.com>,
        =?UTF-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>
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

Hi Kyrie,

After reviewing the code, I found anothe possible code path. As I am
not familiar with the module. It has high possibility it's wrong.
Could please help me check this? Very much appreciated for your
valuable time.

In summary, mtk_jpegdec_worker was set in mtk_jpeg_open and started in
mtk_jpeg_multicore_dec_device_run, which made it running on cpu1.
Inside the mtk_jpeg_multicore_dec_device_run, it will call
schedule_delayed_work  to start the timeout_work, which will make it
running on cpu2. Meanwhile, we can call
mtk_jpeg_release to cancel the job. But there might be a race between
mtk_jpegdec_worker and v4l2_m2m_cancel_job. It may call
v4l2_m2m_job_finish too early to wake up the event.
The remove will go on, the other race is as described earlier.

cpu0                         cpu1                  cpu2
(1)->device_run
mtk_jpeg_multicore
_dec_device_run
queue_work
(jpeg->workqueue,
&ctx->jpeg_work);
                      (2)mtk_jpegdec_worker
(3)mtk_jpeg_release
v4l2_m2m_cancel_job
wait event

                      schedule_delayed_work
                                            (4)mtk_jpeg_job_timeout_work
                      (5)v4l2_m2m_job_finish
                      wake up
(6)mtk_jpeg_remove
v4l2_m2m_release
kfree(m2m_dev)
                                            (7)v4l2_m2m_get_curr_priv

Kyrie Wu (=E5=90=B4=E6=99=97) <Kyrie.Wu@mediatek.com> =E4=BA=8E2023=E5=B9=
=B43=E6=9C=888=E6=97=A5=E5=91=A8=E4=B8=89 11:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 2023-03-08 at 10:20 +0800, Zheng Hacker wrote:
> > Hi Kyrie,
> >
> > Thank you for your careful analysis and response. I still have some
> > areas that I don't quite understand and would like to ask for
> > clarification. That is, how do the function pointers for stop
> > streaming, initialized as mtk_jpeg_enc_stop_streaming and
> > mtk_jpeg_dec_stop_streaming, ensure that the worker is canceled? I
> > would greatly appreciate your response.
> >
> > Best regards,
> > Zheng
>
> Dear zheng,
>
> For stop streaming, what I mean is that stoppping jpeg decoding or
> encoding.
> Ok, let me introduce the sw flow of stop streaming:
> Firstly, the app will call v4l2_m2m_ioctl_streamoff, which will call
> v4l2_m2m_cancel_job, if it finds a job running(as you note, cpu1 is
> running), it will wait event, the event is wake up by
> v4l2_m2m_job_finish function. And v4l2_m2m_job_finish is called by jpeg
> dec/enc irq handler, which means that the waitting would result mtk hw
> to finish dec/enc, irq will occur and irq handler would cancel timeout
> worker. The follow is shown as blow.
> v4l2_m2m_ioctl_streamoff
>    v4l2_m2m_cancel_job                mtk_jpeg_enc_irq/mtk_jpeg_dec_irq
>        wait evnet <------ wake up ------v4l2_m2m_job_finish
>                                         cancel timeout work
>
> As mentioned above, if it is normal stop streaming action, there will
> be no happen that the timeout worker does not canceled.
>
> But if mtk_jpeg_remove is called directly without above flow, it would
> cause lots of issues.
>
> Regards,
> Kyrie.
> >
> > Kyrie Wu (=E5=90=B4=E6=99=97) <Kyrie.Wu@mediatek.com> =E4=BA=8E2023=E5=
=B9=B43=E6=9C=888=E6=97=A5=E5=91=A8=E4=B8=89 10:02=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Tue, 2023-03-07 at 23:03 +0800, Zheng Hacker wrote:
> > > > The timer function was set in mtk_jpeg_probe with
> > > > mtk_jpeg_job_timeout_work function.
> > > > And the worker is started in mtk_jpeg_dec_device_run.
> > > > There are two functions (mtk_jpeg_enc_irq and mtk_jpeg_dec_irq)
> > > > which
> > > > may cancel the worker.
> > > > They are used as IRQ handler function which is saved as function
> > > > pointer in a variable.
> > > > In mtk_jpeg_probe, they are registered by devm_request_irq:
> > > >
> > > > ret =3D devm_request_irq(&pdev->dev,
> > > >                jpeg_irq,
> > > >                jpeg->variant->irq_handler,
> > > >                0,
> > > >                pdev->name, jpeg);
> > > >     if (ret) {
> > > >       dev_err(&pdev->dev, "Failed to request jpeg_irq %d (%d)\n",
> > > >         jpeg_irq, ret);
> > > >       return ret;
> > > >     }
> > > >
> > > > However, if we remove the module without triggering the irq, the
> > > > worker will never be removed.
> > > >
> > > > As for the schedule, mtk_jpeg_dec_device_run and
> > > > mtk_jpeg_enc_device_run will start the worker.
> > > > The schedule invoking is quite complicated. As far as I know, the
> > > > invoking chain is as follows:
> > > >
> > > > v4l2_m2m_init->v4l2_m2m_device_run_work->v4l2_m2m_try_run
> > > >
> > > > the v4l2_m2m_device_run_work function is also a worker which is
> > > > set
> > > > in
> > > > v4l2_m2m_init and started in
> > > > v4l2_m2m_schedule_next_job.
> > > >
> > > > Before calling remove function, the  mtk_jpeg_release was invoked
> > > > to
> > > > release the related resource.
> > > >
> > > > v4l2_m2m_cancel_job will cancel the job by calling
> > > > m2m_dev->m2m_ops->job_abort(m2m_ctx->priv).
> > > >
> > > > But this will only cancel the current queue by
> > > > list_del(&m2m_dev->curr_ctx->queue);
> > > >
> > > > I think this can not cancel the posted task mentioned before. So
> > > > I
> > > > think if mtk_jpeg_job_timeout_work
> > > >
> > > > is working on, and using jpeg->m2m_dev after freeing it in
> > > > mtk_jpeg_remove, it will cause a UAF bug.
> > > >
> > > > static int mtk_jpeg_release(struct file *file)
> > > > {
> > > >   struct mtk_jpeg_dev *jpeg =3D video_drvdata(file);
> > > >   struct mtk_jpeg_ctx *ctx =3D mtk_jpeg_fh_to_ctx(file-
> > > > >private_data);
> > > >
> > > >   mutex_lock(&jpeg->lock);
> > > >   v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
> > > >   [1] v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
> > > >   v4l2_fh_del(&ctx->fh);
> > > >   v4l2_fh_exit(&ctx->fh);
> > > >   kfree(ctx);
> > > >   mutex_unlock(&jpeg->lock);
> > > >   return 0;
> > > > }
> > > >
> > > > void v4l2_m2m_ctx_release(struct v4l2_m2m_ctx *m2m_ctx)
> > > > {
> > > >   /* wait until the current context is dequeued from job_queue */
> > > >   [2] v4l2_m2m_cancel_job(m2m_ctx);
> > > >
> > > >   vb2_queue_release(&m2m_ctx->cap_q_ctx.q);
> > > >   vb2_queue_release(&m2m_ctx->out_q_ctx.q);
> > > >
> > > >   kfree(m2m_ctx);
> > > > }
> > > >
> > > > Note that all of this is static analysis, which may be false
> > > > positive.
> > > > Feel free to tell me if there is something I've missed.
> > > >
> > > > Regard,
> > > > Zheng
> > >
> > > Dear Zheng,
> > >
> > > You set up an application scenario:
> > > cpu1 is using the mtk-jpeg driver and timeout work has been
> > > scheduled.
> > > At the same time cpu0 wanted to remove the mtk-jpeg driver, which
> > > caused the UAF bug.
> > > I wonder if such an irrational application scenario could exist.
> > > This
> > > scenario, as you described, not only leads to the problems you
> > > mentioned, but also to output&capture memory leaks and unreleased
> > > resources, such as spinlock.
> > > Typically, if we want to remove the driver, we firstly do stop
> > > streaming, which ensures that the worker has been canceled.
> > > I agree with your changes from the perspective of strengthening the
> > > robustness of the driver code.
> > >
> > > Regards,
> > > Kyrie.
> > > >
> > > > Irui Wang (=E7=8E=8B=E7=91=9E) <Irui.Wang@mediatek.com> =E4=BA=8E20=
23=E5=B9=B43=E6=9C=887=E6=97=A5=E5=91=A8=E4=BA=8C 18:23=E5=86=99=E9=81=93=
=EF=BC=9A
> > > > >
> > > > > Dear Angelo and Zheng,
> > > > >
> > > > > Thanks for your patch and comments.
> > > > >
> > > > > Dear Kyrie,
> > > > >
> > > > > Please help to check this, thanks.
> > > > >
> > > > > Best Regards
> > > > >
> > > > > On Tue, 2023-03-07 at 10:49 +0100, AngeloGioacchino Del Regno
> > > > > wrote:
> > > > > > Il 07/03/23 10:27, Zheng Hacker ha scritto:
> > > > > > > Hi,
> > > > > > >
> > > > > > > Is there anyone who can help with this? I can provide more
> > > > > > > details
> > > > > > > like invoking chain if needed.
> > > > > > >
> > > > > >
> > > > > > Providing more details is always good. Please do.
> > > > > >
> > > > > > Meanwhile, adding Irui Wang to the loop: he's doing mtk-jpeg.
> > > > > >
> > > > > > Regards,
> > > > > > Angelo
> > > > > >
> > > > > > > Thanks,
> > > > > > > Zheng
> > > > > > >
> > > > > > > Zheng Wang <zyytlz.wz@163.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=
=886=E6=97=A5=E5=91=A8=E4=B8=80 14:28=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > >
> > > > > > > > In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> > > > > > > > mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> > > > > > > > and mtk_jpeg_enc_device_run may be called to start the
> > > > > > > > work.
> > > > > > > > If we remove the module which will call mtk_jpeg_remove
> > > > > > > > to make cleanup, there may be a unfinished work. The
> > > > > > > > possible sequence is as follows, which will cause a
> > > > > > > > typical UAF bug.
> > > > > > > >
> > > > > > > > Fix it by canceling the work before cleanup in the
> > > > > > > > mtk_jpeg_remove
> > > > > > > >
> > > > > > > > CPU0                  CPU1
> > > > > > > >
> > > > > > > >                      |mtk_jpeg_job_timeout_work
> > > > > > > > mtk_jpeg_remove     |
> > > > > > > >    v4l2_m2m_release  |
> > > > > > > >      kfree(m2m_dev); |
> > > > > > > >                      |
> > > > > > > >                      | v4l2_m2m_get_curr_priv
> > > > > > > >                      |   m2m_dev->curr_ctx //use
> > > > > > > >
> > > > > > > > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > > > > > > > ---
> > > > > > > >   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c |
> > > > > > > > 2 +-
> > > > > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git
> > > > > > > > a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > > > > > > > b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > > > > > > > index 969516a940ba..364513e7897e 100644
> > > > > > > > ---
> > > > > > > > a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > > > > > > > +++
> > > > > > > > b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > > > > > > > @@ -1793,7 +1793,7 @@ static int mtk_jpeg_probe(struct
> > > > > > > > platform_device *pdev)
> > > > > > > >   static int mtk_jpeg_remove(struct platform_device
> > > > > > > > *pdev)
> > > > > > > >   {
> > > > > > > >          struct mtk_jpeg_dev *jpeg =3D
> > > > > > > > platform_get_drvdata(pdev);
> > > > > > > > -
> > > > > > > > +       cancel_delayed_work(&jpeg->job_timeout_work);
> > > > > > > >          pm_runtime_disable(&pdev->dev);
> > > > > > > >          video_unregister_device(jpeg->vdev);
> > > > > > > >          v4l2_m2m_release(jpeg->m2m_dev);
> > > > > > > > --
> > > > > > > > 2.25.1
> > > > > > > >
> > > > > >
> > > > > >
> > > > > >
