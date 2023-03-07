Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23BA6AE3FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCGPKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjCGPKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:10:01 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC8B96F27;
        Tue,  7 Mar 2023 07:04:15 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x7so6252708pff.7;
        Tue, 07 Mar 2023 07:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678201449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJC6ppNXdptWxKcEOX7x0S+/F8CH+y6Fc32ATnadci8=;
        b=XvFthOYx+sU/tzNPD+dtk7FgxE2/Vlj9RMUv0R3PD/DOQbexHuauL3yD85zeVRT+vP
         YeUvHwcgigsOP6EidL3/7yBVxCfoV7/llLET84NkXiB5Ggl+23pZj3Y0LTDFC3+I9YNc
         fJ908eUyPglbWqHFnnZdEBAmggbXj5QVjLXoCqpg1uKcQX6JsdqXNNayTEZXQn3x93zy
         X+Cp19uZiJ/0PDGyjVoSOZ1jbp0B6I+AaNR638goP5WS/NT6och0TDIrB4ZXwJEgV3Bm
         XBQS8fjFHmEeS1tvz/ig2uBzAbyghiRb8v3VaIljNlwpryTXgF1oYMv7d/sTyxeWnKbq
         +nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678201449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJC6ppNXdptWxKcEOX7x0S+/F8CH+y6Fc32ATnadci8=;
        b=47iXNSk6A6owArdC/9TMdkj9HoO2stFl8fvz9Qbd/y2VTdguHoN7C4gEtKIECe2jNW
         jgkIC6wlgsUALhLE3147XA4HF5Tx3IYDzyQyGmeZii+xtpXZAcV/TM5T8VhyFx0sV8d8
         UUFlVY/g9FuVZAdUoiSMlwP8cSB6QIsNwQgP2ItAfh4lzjr2q49lFhySmXFE65bmpr5V
         tWAAfQKMgzI4OaJsc/89sSzscGOZG04L2ESFqcgcLxICm8LSyxajTEHZ5jvHFKrwwYyN
         pmHp3jDWtNsElkkpVusb3Rhw6vUPONCzsrHmxyfDgEYsfk5O6nJS/YuJmnUiiQi2QZXV
         WdEA==
X-Gm-Message-State: AO0yUKXHk+0Afync54lDmTE9j5CRaLeUi4j0CwljAVoR8VmNVrRTnC+n
        3mzp5Ui8erRsuO/08QbRGccIuh1ZyReaQHqd3d0=
X-Google-Smtp-Source: AK7set80EW60Dpt+BsD4F9qsxuHP/2Wp/5EkLzq+MFPQ3yH4YSYrQ6BPQecdqz+ML7g/qdQOvAfgqcOfRTyvJGoIHS0=
X-Received: by 2002:a63:ee12:0:b0:503:2583:effb with SMTP id
 e18-20020a63ee12000000b005032583effbmr5292025pgi.9.1678201449167; Tue, 07 Mar
 2023 07:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20230306062633.200427-1-zyytlz.wz@163.com> <CAJedcCzeVwwi9SkkwouFXUAVhF-tKF4dkqsFqVQwszSwY1SJ0A@mail.gmail.com>
 <57c17bfd-83f3-fcce-0eab-e28469fb0ced@collabora.com> <11c2bce1e5286ad3a9a5be2ee59c2beac168f135.camel@mediatek.com>
In-Reply-To: <11c2bce1e5286ad3a9a5be2ee59c2beac168f135.camel@mediatek.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 7 Mar 2023 23:03:57 +0800
Message-ID: <CAJedcCx13sz5h=fWvJU38P_1W-zd6yZe=iSMpO28_E_kAqUGDA@mail.gmail.com>
Subject: Re: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     =?UTF-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>
Cc:     "zyytlz.wz@163.com" <zyytlz.wz@163.com>,
        =?UTF-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "alex000young@gmail.com" <alex000young@gmail.com>,
        =?UTF-8?B?QmluIExpdSAo5YiY5b2sKQ==?= <bin.liu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
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

The timer function was set in mtk_jpeg_probe with
mtk_jpeg_job_timeout_work function.
And the worker is started in mtk_jpeg_dec_device_run.
There are two functions (mtk_jpeg_enc_irq and mtk_jpeg_dec_irq) which
may cancel the worker.
They are used as IRQ handler function which is saved as function
pointer in a variable.
In mtk_jpeg_probe, they are registered by devm_request_irq:

ret =3D devm_request_irq(&pdev->dev,
               jpeg_irq,
               jpeg->variant->irq_handler,
               0,
               pdev->name, jpeg);
    if (ret) {
      dev_err(&pdev->dev, "Failed to request jpeg_irq %d (%d)\n",
        jpeg_irq, ret);
      return ret;
    }

However, if we remove the module without triggering the irq, the
worker will never be removed.

As for the schedule, mtk_jpeg_dec_device_run and
mtk_jpeg_enc_device_run will start the worker.
The schedule invoking is quite complicated. As far as I know, the
invoking chain is as follows:

v4l2_m2m_init->v4l2_m2m_device_run_work->v4l2_m2m_try_run

the v4l2_m2m_device_run_work function is also a worker which is set in
v4l2_m2m_init and started in
v4l2_m2m_schedule_next_job.

Before calling remove function, the  mtk_jpeg_release was invoked to
release the related resource.

v4l2_m2m_cancel_job will cancel the job by calling
m2m_dev->m2m_ops->job_abort(m2m_ctx->priv).

But this will only cancel the current queue by
list_del(&m2m_dev->curr_ctx->queue);

I think this can not cancel the posted task mentioned before. So I
think if mtk_jpeg_job_timeout_work

is working on, and using jpeg->m2m_dev after freeing it in
mtk_jpeg_remove, it will cause a UAF bug.

static int mtk_jpeg_release(struct file *file)
{
  struct mtk_jpeg_dev *jpeg =3D video_drvdata(file);
  struct mtk_jpeg_ctx *ctx =3D mtk_jpeg_fh_to_ctx(file->private_data);

  mutex_lock(&jpeg->lock);
  v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
  [1] v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
  v4l2_fh_del(&ctx->fh);
  v4l2_fh_exit(&ctx->fh);
  kfree(ctx);
  mutex_unlock(&jpeg->lock);
  return 0;
}

void v4l2_m2m_ctx_release(struct v4l2_m2m_ctx *m2m_ctx)
{
  /* wait until the current context is dequeued from job_queue */
  [2] v4l2_m2m_cancel_job(m2m_ctx);

  vb2_queue_release(&m2m_ctx->cap_q_ctx.q);
  vb2_queue_release(&m2m_ctx->out_q_ctx.q);

  kfree(m2m_ctx);
}

Note that all of this is static analysis, which may be false positive.
Feel free to tell me if there is something I've missed.

Regard,
Zheng

Irui Wang (=E7=8E=8B=E7=91=9E) <Irui.Wang@mediatek.com> =E4=BA=8E2023=E5=B9=
=B43=E6=9C=887=E6=97=A5=E5=91=A8=E4=BA=8C 18:23=E5=86=99=E9=81=93=EF=BC=9A
>
> Dear Angelo and Zheng,
>
> Thanks for your patch and comments.
>
> Dear Kyrie,
>
> Please help to check this, thanks.
>
> Best Regards
>
> On Tue, 2023-03-07 at 10:49 +0100, AngeloGioacchino Del Regno wrote:
> > Il 07/03/23 10:27, Zheng Hacker ha scritto:
> > > Hi,
> > >
> > > Is there anyone who can help with this? I can provide more details
> > > like invoking chain if needed.
> > >
> >
> > Providing more details is always good. Please do.
> >
> > Meanwhile, adding Irui Wang to the loop: he's doing mtk-jpeg.
> >
> > Regards,
> > Angelo
> >
> > > Thanks,
> > > Zheng
> > >
> > > Zheng Wang <zyytlz.wz@163.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=B8=80 14:28=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> > > > mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> > > > and mtk_jpeg_enc_device_run may be called to start the
> > > > work.
> > > > If we remove the module which will call mtk_jpeg_remove
> > > > to make cleanup, there may be a unfinished work. The
> > > > possible sequence is as follows, which will cause a
> > > > typical UAF bug.
> > > >
> > > > Fix it by canceling the work before cleanup in the
> > > > mtk_jpeg_remove
> > > >
> > > > CPU0                  CPU1
> > > >
> > > >                      |mtk_jpeg_job_timeout_work
> > > > mtk_jpeg_remove     |
> > > >    v4l2_m2m_release  |
> > > >      kfree(m2m_dev); |
> > > >                      |
> > > >                      | v4l2_m2m_get_curr_priv
> > > >                      |   m2m_dev->curr_ctx //use
> > > >
> > > > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > > > ---
> > > >   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > > > b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > > > index 969516a940ba..364513e7897e 100644
> > > > --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > > > +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > > > @@ -1793,7 +1793,7 @@ static int mtk_jpeg_probe(struct
> > > > platform_device *pdev)
> > > >   static int mtk_jpeg_remove(struct platform_device *pdev)
> > > >   {
> > > >          struct mtk_jpeg_dev *jpeg =3D platform_get_drvdata(pdev);
> > > > -
> > > > +       cancel_delayed_work(&jpeg->job_timeout_work);
> > > >          pm_runtime_disable(&pdev->dev);
> > > >          video_unregister_device(jpeg->vdev);
> > > >          v4l2_m2m_release(jpeg->m2m_dev);
> > > > --
> > > > 2.25.1
> > > >
> >
> >
> >
