Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9131C715251
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 01:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjE2XdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 19:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjE2XdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 19:33:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A4ABE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 16:33:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b038064d97so11959865ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685403186; x=1687995186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHLHVnQt1jJTd4JLoTxuUwyNL7kxiAHIigjAHGBN+cE=;
        b=V45gyUu3xKG9grwHGgnGJK0gZKqvqWFSg1HVWXa7QS4LKFtSdYUV2O8bAqDEs7QJXA
         HBJJsDN5/WvpJ9Xzz6twHvdu45Tuu7RF5quqLfJyHsR9gtWu15X88pIHxGmIDr/5rP7e
         xh8F5ywAWYBWgpsc/X6K+I28cVNqRSR+ZvTjP9n3uBrUNj4gKQYMoSvulMf3MDECjvQv
         tV5DeIIZQkIZTyUowEYCoY9T0FuxJUvLsH69N3hCev7b5aHoV100JsUX8zFx0KNqLdKL
         ZlVn6W6myAgPYGVTP5Nxr08JlB6k22xmB18le262mvfGVTaWQpkZAaO34q4LJJ6BYCNy
         O7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685403186; x=1687995186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHLHVnQt1jJTd4JLoTxuUwyNL7kxiAHIigjAHGBN+cE=;
        b=G/EPKz4skdIgLwtbg8xuh7UhX0Uj8N/IadU3MlYiqnyvjlqc00BiF45xEduUon18Sk
         jWRtwA0aLjmkvbdDugn2uPfRnAeAJBIP0lKfh7mH91BS0CFHI8fAJFUg7nyV+JDIMGgw
         8Fu8OyZEKJU8hUVq+IwHZw6ntrZCWIoogP+vAXdn0jRxliQkepw1RKYfjgUMWTIqynAA
         PhhW6iky0gJKgFff2nOYXwUvwpjIvNQy2kDAsxQumjAR77tVDnHRdt4wkpN3qLdSvXK5
         LnojvjfuStaSP9Iu8UW52HqB/ZYxbipxkEagmSmmKDrbuXk8Rc08yNw0yhqW4uuhw2+D
         R0Lw==
X-Gm-Message-State: AC+VfDzuZXzTQDnuMhQa/txzVzuD0p6L2v+ZSz9CFqJdEVsXw2OMQecs
        tPRC/NoFGSQF+PmAj/8I2xY3SshzRzytUgqFIZM+sw==
X-Google-Smtp-Source: ACHHUZ6h9OpKYs96vQ4edAgKS4YsUwgRuleYT4IFOXvz3+qiDKPEvr1WQ9SIX9vgi2zu3jFg8V3Ob5RQrIMKWH7Vvmw=
X-Received: by 2002:a17:903:2305:b0:1b0:3ab6:5140 with SMTP id
 d5-20020a170903230500b001b03ab65140mr608364plh.4.1685403186284; Mon, 29 May
 2023 16:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230519043041.1593578-1-badhri@google.com> <c181c8ef-f342-4a31-9b8c-e1fa14ad214e@rowland.harvard.edu>
 <a1d064e7-9847-4e2e-b74a-4ae4f39d3f04@rowland.harvard.edu>
 <CAPTae5JKUW6g8cvUbJ3owMGm+npJSBgjr-O_xEiRm_tzXVBV1Q@mail.gmail.com>
 <a2305ca6-d343-473d-b220-556a2c2e7833@rowland.harvard.edu>
 <CAPTae5Lke+DE3WzGuBxkMMZ=qbbux=avdDTgrxEc1A5SrCFevg@mail.gmail.com>
 <547ecbb2-921d-4714-82b7-066202ccf292@rowland.harvard.edu>
 <CAPTae5J=VGeHNio0XAj=trrwqXWgGCiwcSaKsxQ4H_9j2mCVXA@mail.gmail.com> <406371f0-db48-4195-b85d-b75ce83e738b@rowland.harvard.edu>
In-Reply-To: <406371f0-db48-4195-b85d-b75ce83e738b@rowland.harvard.edu>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 29 May 2023 16:32:29 -0700
Message-ID: <CAPTae5LSvs+4pKJRgShPzH_tt7F4ZgdvNOQJXE1aLXTgt5Y+0A@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        francesco@dolcini.it, alistair@alistair23.me, stephan@gerhold.net,
        bagasdotme@gmail.com, luca@z3ntu.xyz, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 9:36=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Fri, May 26, 2023 at 07:42:39PM -0700, Badhri Jagan Sridharan wrote:
> > Thanks again Alan !
> >
> > On Mon, May 22, 2023 at 8:55=E2=80=AFAM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > > Getting back to your first point, it looks like we need to assume any
> > > routine that needs to communicate with the UDC hardware (such as the
> > > ->pullup callback used in usb_gadget_{dis}connect()) must always be
> > > called in process context.  This means that usb_udc_connect_control()
> > > always has to run in process context, since it will do either a conne=
ct
> > > or a disconnect.
> > >
> > > On the other hand, some routines -- in particular,
> > > usb_udc_vbus_handler() -- may be called by a UDC driver's interrupt
> > > handler and therefore may run in interrupt context.  (This fact shoul=
d
> > > be noted in that routine's kerneldoc, by the way.)
> > >
> > > So here's the problem: usb_udc_vbus_handler() running in interrupt
> > > context calls usb_udc_connect_control(), which has to run in process
> > > context.  And this is not just a simple issue caused by the
> > > ->disconnect() callback or use of mutexes; it's more fundamental.
> > >
> > > I'm led to conclude that you were right to offload part of
> > > usb_udc_vbus_handler()'s job to a workqueue.  It's an awkward thing t=
o
> > > do, because you have to make sure to cancel the work item at times wh=
en
> > > it's no longer needed.  But there doesn't seem to be any other choice=
.
> > >
> > > Here's two related problems for you to think about:
> > >
> > >     1.  Once gadget_unbind_driver() has called usb_gadget_disconnect(=
),
> > >         we don't want a VBUS change to cause usb_udc_vbus_handler()'s
> > >         work routine to turn the pullup back on.  How can we prevent
> > >         this?
> > >
> > >     2.  More generally, suppose usb_udc_vbus_handler() gets called at
> > >         exactly the same time that some other pathway (either
> > >         gadget_bind_driver() or soft_connect_store()) tries to do a
> > >         connect or disconnect.  What should happen then?
> >
> >
> > I believe I can solve the above races by protecting the flags set by
> > each of them with connect_lock and not pulling up unless all of them
> > are true.
> >
> > The caller will hold connect_lock, update the respective flag and
> > invoke the below usb_gadget_pullup_update_locked function(shown
> > below).
>
> Are you certain this can be done without causing any deadlocks?
>
> > Code stub:
> > /* Internal version of usb_gadget_connect needs to be called with
> > connect_lock held. */
> > static int usb_gadget_pullup_update_locked(struct usb_gadget *gadget)
> >         __must_hold(&gadget->udc->connect_lock)
> > {
> >         int ret =3D 0;
> >         bool connect =3D !gadget->deactivated && gadget->udc->started &=
&
> > gadget->udc->vbus &&
> >                              gadget->udc->allow_connect;
>
> On further thought, I decided "allow_connect" is a dumb name.  Let's
> call it "unbinding" instead, since it gets set only when a gadget driver
> is about to be unbound (which is when we want to prevent new
> connections).

Sure, fixing it in v3.

>
> >         if (!gadget->ops->pullup) {
> >                 ret =3D -EOPNOTSUPP;
> >                 goto out;
> >         }
> >
> >         if (connect !=3D gadget->connected) {
>
> You need to be more careful here.  It's possible to have
> gadget->connected set at the same time as gadget->deactivated -- it
> means that when the gadget gets re-activated, it will immediately try to
> connect again.
>
> In fact, this logic doesn't look right at all.  For example, suppose the
> gadget driver wants to disconnect.  This routine will compute connect =3D
> true and will see that gadget->connected is set, so it won't do
> anything!
>
> I think it would be better just to merge the new material into
> usb_gadget_connect() and usb_gadget_disconnect().

I ended up merging them into usb_gadget_pullup_update_locked() so that
each of the individual helper function can call
usb_gadget_pullup_update_locked() while holding the connect_lock. I
actually had usb_gadget_(dis)connect() set udc->vbus. It appears to me
that both usb_gadget_(dis)connect() and usb_udc_vbus_handler() are
meant to be called based on vbus presence and hence seem to be
redundant. Wondering if we could get rid of usb_gadget_(dis)connect()
given that drivers/power/supply/isp1704_charger.c is only call it and
instead make it call usb_udc_vbus_handler() instead ?

>
> >                 ret =3D gadget->ops->pullup(gadget, connect);
> >                 if (!ret)
> >                         gadget->connected =3D connect;
> >                 if (!connect) {
> >                         mutex_lock(&udc_lock);
> >                         if (gadget->udc->driver)
> >                                 gadget->udc->driver->disconnect(gadget)=
;
> >                         mutex_unlock(&udc_lock);
> >         }
> >
> > out:
> >         trace_usb_gadget_connect(gadget, ret);
> >
> >         return ret;
> > }
> >
> > However, while auditing the code again, I noticed another potential
> > race as well:
> > Looks like usb_del_gadget() can potentially race against
> > usb_udc_vbus_handler() and call device_unregister.
> > This implies usb_udc can be freed while usb_udc_vbus_handler() or the
> > work item is executing.
> >
> > void usb_del_gadget(struct usb_gadget *gadget)
> > {
> >         struct usb_udc *udc =3D gadget->udc;
> >
> > ..
> > ...
> >         device_unregister(&udc->dev);
> > }
> > EXPORT_SYMBOL_GPL(usb_del_gadget);
> >
> > Does this look like a valid concern to you or am I misunderstanding thi=
s ?
>
> You're missing an important point.  Before doing device_unregister(),
> this routine calls device_del(&gadget->dev).  That will unbind the
> gadget driver, which (among other things) will stop the UDC, preventing
> it from calling usb_udc_vbus_handler().  However, you're right that the
> work item will need to be cancelled at some point before the usb_udc is
> unregistered.
>

Sure,  thought gadget_unbind_driver() might be a good place to cancel
the work item. So, cancelling it there in V3.

> > If so, I am afraid that the only way to solve this is by synchronizing
> > usb_udc_vbus_handler() against usb_del_gadget() through a mutex as
> > device_unregister() can sleep.
> > So offloading usb_udc_vbus_handler() cannot work either.
> >
> > usb_udc_vbus_hander() seems to be invoked from the following drivers:
> >
> > 1. drivers/usb/chipidea/udc.c:
> > usb_udc_vbus_hander()  is called from a non-atomic context.
> >
> > 2. drivers/usb/gadget/udc/max3420_udc.c
> > usb_udc_vbus_hander()  is called from the interrupt handler.
> > However, all the events are processed from max3420_thread kthread.
> > So I am thinking of making them threaded irq handlers instead.
> >
> > 3. drivers/usb/gadget/udc/renesas_usbf.c
> > This one looks more invasive. However, still attempting to move them
> > to threaded irq handlers.
> >
> > As always, I'm looking forward to your feedback !
>
> Moving those things to threaded IRQ handlers is a separate job.  Let's
> get this issue fixed first.

Sounds good !

Thanks,
Badhri

>
> Alan Stern
