Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EE7720859
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbjFBR1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjFBR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:27:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48EF1B6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:27:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2565a896d07so1125757a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685726829; x=1688318829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fpfD6dSFPjERb3WSgrjh+MlljhJF3jc9HlZXFqTSTA=;
        b=IUYCIK0xCiZAsHdUed3fVFD9d2pU/AGUMVw+P+9vFpQNMuHGrNqRMJeh64m1Sp7pIO
         MD2zmNJp3z6ZahsUMLi6/QAwDGhzSf3E/7YaP119dRU+v++QAArwa4+6/14QKQA4k5JP
         +hG76DefeDovrp+9BjVsO4kLdK62pGu10DQw8S6a7pCaaISGq4JM3kz2AUUyfWwrJT/l
         wWvpWhO8U1E6S39/DUfJq6S6h/OGB/oza3IYDgYkRPIz6SDpdwEV0fBxQ2cXh3cNw7Vh
         QCckRy2fjhzB7O0+DJm3DNAR4ZC/WjFfcDO7k1T+PiBB1tbSK+IVMJ/+vQZHwRdoo+Uu
         wFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685726829; x=1688318829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fpfD6dSFPjERb3WSgrjh+MlljhJF3jc9HlZXFqTSTA=;
        b=JUIcTIRLrNnewf+UccXtj2bluJHMF/SJFBgn/2Y/tomZBbMnhNJVt+AWZbgkVp9BJY
         P8gzrYmxL8tZleDDw8fE2nfVwvhGSkYFf0hH9rq2FBAnAfWKvaVA1pU1SHZNF34Wti69
         8WVEGq6k9mc/y+vS/oryEaxWo8g3Dh7BxEhkBdOn7VpzJC8L1phyGQgpmpc0V7bnTljb
         PgZmlXcOikTeLU8DPdKFXVuChV3wpxV+gj5MlGBK46T+A/Q2eB9is4m1OvFAuTZGtwOV
         0HCxMG+69IRpVweNxeXOuf3gZyYHiMnQmucVNC2yBpgkY9pWKyGOqIVlPELmeE/8RSk+
         lrTw==
X-Gm-Message-State: AC+VfDwzip4rgk4YVHc9Bjo1JiJkFAqmwJkjGkBsadew3KjPk9BE4UW3
        ZPE0Tl8lUshzIj7c8U1y/LBkuIrzojWqNmyYGlNYmA==
X-Google-Smtp-Source: ACHHUZ6pbtpmtxeGMwVLq/moV1D3Cnb1zlxmbi5HjShJFr7DrN+ZJEzotj3K+E/kxA08p6Tci8y8rDbIc4fOwa/gegI=
X-Received: by 2002:a17:90a:48:b0:254:ce9e:53 with SMTP id 8-20020a17090a004800b00254ce9e0053mr492441pjb.23.1685726828997;
 Fri, 02 Jun 2023 10:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230531040203.19295-1-badhri@google.com> <20230531040203.19295-3-badhri@google.com>
 <9a537d74-28be-48fb-85e0-628f3385de7e@rowland.harvard.edu>
In-Reply-To: <9a537d74-28be-48fb-85e0-628f3385de7e@rowland.harvard.edu>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Fri, 2 Jun 2023 10:26:32 -0700
Message-ID: <CAPTae5K08+voWZ0gwrP7aNpuWr4x7OoaT-FboGr7fuFUbADsyA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] usb: gadget: udc: core: Prevent UDC from starting
 when unbound
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, francesco@dolcini.it, alistair@alistair23.me,
        stephan@gerhold.net, bagasdotme@gmail.com, luca@z3ntu.xyz,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:40=E2=80=AFAM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Wed, May 31, 2023 at 04:02:03AM +0000, Badhri Jagan Sridharan wrote:
> > UDC should neither be started nor pulled up unless the gadget driver is
> > bound. The new flag "allow_start" is now set by gadget_bind_driver()
> > and cleared by gadget_unbind_driver(). usb_gadget_udc_start_locked()
> > now checks whether allow_start is set before starting the UDC by
> > invoking the ->udc_start() callback.
>
> "allow_start" isn't quite the right name either, because there is a
> short time interval during which the UDC is started but we don't want
> to allow it to connect to the host (this occurs in
> gadget_unbind_driver() between the disconnect call and the
> usb_gadge_udc_stop call).  A more accurate name would be "allow_connect"
> or "allow_pullup".

Sure, Have renamed the flag to "allow_connect".

>
> > Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> > v5 is the first version in this series.
> > ---
> >  drivers/usb/gadget/udc/core.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/cor=
e.c
> > index 6ffe5fda8bb7..ac9d6186815d 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -37,6 +37,8 @@ static const struct bus_type gadget_bus_type;
> >   * @vbus: for udcs who care about vbus status, this value is real vbus=
 status;
> >   * for udcs who do not care about vbus status, this value is always tr=
ue
> >   * @started: the UDC's started state. True if the UDC had started.
> > + * @allow_start: Indicates whether UDC is allowed to start. Set/cleare=
d by gadget_(un)bind_driver()
> > + * after gadget driver is bound or unbound.
> >   * @connect_lock: protects udc->vbus, udc->started, gadget->connect, g=
adget->deactivate related
> >   * functions. usb_gadget_connect_locked, usb_gadget_disconnect_locked,
> >   * usb_udc_connect_control_locked, usb_gadget_udc_start_locked, usb_ga=
dget_udc_stop_locked are
>
> As before, wrap the comments around column 76.

Sounds good ! Have addressed this in v6. Wrapping comments at 76.

>
> > @@ -52,6 +54,7 @@ struct usb_udc {
> >       struct list_head                list;
> >       bool                            vbus;
> >       bool                            started;
> > +     bool                            allow_start;
> >       struct work_struct              vbus_work;
> >       struct mutex                    connect_lock;
> >  };
> > @@ -1204,6 +1207,9 @@ static inline int usb_gadget_udc_start_locked(str=
uct usb_udc *udc)
> >       if (udc->started) {
> >               dev_err(&udc->dev, "UDC had already started\n");
> >               return -EBUSY;
> > +     } else if (!udc->allow_start) {
> > +             dev_err(&udc->dev, "UDC not allowed to start. Is gadget d=
river bound ?\n");
> > +             return -EIO;
> >       }
>
> This isn't the right test or the right place.  We want to prevent the
> UDC from connecting to the host, not prevent it from starting.
>
> >
> >       ret =3D udc->gadget->ops->udc_start(udc->gadget, udc->driver);
> > @@ -1590,6 +1596,7 @@ static int gadget_bind_driver(struct device *dev)
> >               goto err_bind;
> >
> >       mutex_lock(&udc->connect_lock);
> > +     udc->allow_start =3D true;
> >       ret =3D usb_gadget_udc_start_locked(udc);
> >       if (ret) {
> >               mutex_unlock(&udc->connect_lock);
> > @@ -1630,6 +1637,7 @@ static void gadget_unbind_driver(struct device *d=
ev)
> >
> >       cancel_work_sync(&udc->vbus_work);
> >       mutex_lock(&udc->connect_lock);
> > +     udc->allow_start =3D false;
> >       usb_gadget_disconnect_locked(gadget);
> >       usb_gadget_disable_async_callbacks(udc);
> >       if (gadget->irq)
>
> Here is where the problem about the vbus work item getting requeued can
> be fixed.  Clear the allow_connect flag before the call to
> cancel_work_sync().  That way, even if the vbus work item gets queued
> again after it is cancelled, when it does run it won't do anything.
>
> Although, come to think of it, there is still the problem of making sure
> that the work item doesn't run after the udc has been deallocated.  It
> looks like you will also need to cancel the work item at the end of
> usb_del_gadget().  At that point the UDC has already been stopped, so it
> won't call usb_hcd_vbus_handler() again.

Sure, Have made these changes in V6.

Thanks a lot,
Badhri

>
> Alan Stern
