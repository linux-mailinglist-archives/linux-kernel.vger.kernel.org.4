Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4D6720851
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbjFBRYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbjFBRX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:23:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBD91B3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:23:58 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fb64b3368so1284605a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 10:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685726637; x=1688318637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwbDkzUy6Qk5difaDNXua1bNRo0UZZqSnu/ErFEprlc=;
        b=d8jByJ1PZJmeuk8EagYsF/DqAjxrBWU4gad8vpYvXne/vNgX/IDf4GWwHXV6NiU/hu
         kkl8cuQ5vsvBNhHEsnJFV267CUwy0EBs/SFk1CKiKB53AIdaP+WFl94gixrDvxoyJWxu
         nwndksvlaDuULMjSRkPvUccpmrKiSOGoP2gw47O+pTKx515bSSgUjtlUMorLrQTD81nk
         w5gz6ow21AE4zZ+/oyFgcJyf6zafnE+3lmdTYTjg5L85jjRhHKQ1KdM3lbktGK2rycW/
         o38TUh2fJL13aUVnb/BWDEP7AhkiqGchaHjNnq4Psf1o5AQeadf43KXgJWWy2b4VuKoF
         X9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685726637; x=1688318637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwbDkzUy6Qk5difaDNXua1bNRo0UZZqSnu/ErFEprlc=;
        b=g+br7qao6/XIHuhKZvA0ce+UrFU3vEBg1X6pvaNFqAMQlB4d6p0o4cPac11rpiCr07
         D9CZEYvqM0ndqHEkdaq7Hlr9rB07qDk56+azIUOhCp2bfmTSy+ITbpJmXgc7V/8PC7NK
         V4ltCsR6YC+utUbU8+v24X8MynMxVUmzGeqEO4oBUgXSwXkPmv/5tGO4izTV3c4coh64
         apV0xtFdO7xJTTJSl23XZ8tlGvVZaq33ELEJFJxXkhfauV3v2ZH75BSzEcFzpyhTZL4W
         nSQjCHLLokTBkWny/adv6KBTkvShpFq2XIjjwyZNiJVkCTBbWQA8H3+Xq+uIPp86uE9N
         Q7uQ==
X-Gm-Message-State: AC+VfDza1edsN0nibYJXcRRcdf2J0RLjpXzlgyHQl1zyfk6XwOqJohKq
        hBONO7iNO+RcqBiH/vXzxDLeIsLBEJblHUtsvjGtqg==
X-Google-Smtp-Source: ACHHUZ762nQgYgkGSGWGzTCG2EpeYIDrgmi0VEHYv1zz0QMPuLPlSiCuR3LC8MK9kEu0VQD18Frfb4iLdUYdkTlXw5U=
X-Received: by 2002:a17:902:f7cc:b0:1b1:a4e2:a2ce with SMTP id
 h12-20020a170902f7cc00b001b1a4e2a2cemr571077plw.20.1685726636958; Fri, 02 Jun
 2023 10:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230531040203.19295-1-badhri@google.com> <65dd300b-b967-41ab-b174-a7dc13ec2e19@rowland.harvard.edu>
In-Reply-To: <65dd300b-b967-41ab-b174-a7dc13ec2e19@rowland.harvard.edu>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Fri, 2 Jun 2023 10:23:20 -0700
Message-ID: <CAPTae5LV0jhLq10zj+dmg_d2oJmwx+Xe7gJGk-w27woEgz+c4A@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] usb: gadget: udc: core: Offload
 usb_udc_vbus_handler processing
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Wed, May 31, 2023 at 10:29=E2=80=AFAM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Wed, May 31, 2023 at 04:02:01AM +0000, Badhri Jagan Sridharan wrote:
> > usb_udc_vbus_handler() can be invoked from interrupt context by irq
> > handlers of the gadget drivers, however, usb_udc_connect_control() has
> > to run in non-atomic context due to the following:
> > a. Some of the gadget driver implementations expect the ->pullup
> >    callback to be invoked in non-atomic context.
> > b. usb_gadget_disconnect() acquires udc_lock which is a mutex.
> >
> > Hence offload invocation of usb_udc_connect_control()
> > to workqueue.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 1016fc0c096c ("USB: gadget: Fix obscure lockdep violation for ud=
c_mutex")
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> > Changes since v1:
> > - Address Alan Stern's comment on usb_udc_vbus_handler invocation from
> >   atomic context:
> > * vbus_events_lock is now a spinlock and allocations in
> > * usb_udc_vbus_handler are atomic now.
> >
> > Changes since v2:
> > - Addressing Alan Stern's comments:
> > ** connect_lock is now held by callers of
> > * usb_gadget_pullup_update_locked() and gadget_(un)bind_driver() does
> > * notdirectly hold the lock.
> >
> > ** Both usb_gadget_(dis)connect() and usb_udc_vbus_handler() would
> > * set/clear udc->vbus and invoke usb_gadget_pullup_update_locked.
> >
> > ** Add "unbinding" to prevent new connections after the gadget is being
> > * unbound.
> >
> > Changes since v3:
> > ** Made a minor cleanup which I missed to do in v3 in
> > * usb_udc_vbus_handler().
> >
> > Changes since v4:
> > - Addressing Alan Stern's comments:
> > ** usb_udc_vbus_handler() now offloads invocation of usb_udc_connect_co=
ntrol()
> > * from workqueue.
> >
> > ** Dropped vbus_events list as this was redundant. Updating to the
> > * latest value is suffice
> > ---
> >  drivers/usb/gadget/udc/core.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/cor=
e.c
> > index 52e6d2e84e35..44a9f32679b5 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -48,6 +48,7 @@ struct usb_udc {
> >       struct list_head                list;
> >       bool                            vbus;
> >       bool                            started;
> > +     struct work_struct              vbus_work;
> >  };
> >
> >  static struct class *udc_class;
> > @@ -1086,6 +1087,13 @@ static void usb_udc_connect_control(struct usb_u=
dc *udc)
> >               usb_gadget_disconnect(udc->gadget);
> >  }
> >
> > +static void vbus_event_work(struct work_struct *work)
> > +{
> > +     struct usb_udc *udc =3D container_of(work, struct usb_udc, vbus_w=
ork);
> > +
> > +     usb_udc_connect_control(udc);
> > +}
> > +
> >  /**
> >   * usb_udc_vbus_handler - updates the udc core vbus status, and try to
> >   * connect or disconnect gadget
> > @@ -1094,6 +1102,13 @@ static void usb_udc_connect_control(struct usb_u=
dc *udc)
> >   *
> >   * The udc driver calls it when it wants to connect or disconnect gadg=
et
> >   * according to vbus status.
> > + *
> > + * This function can be invoked from interrupt context by irq handlers=
 of the gadget drivers,
> > + * however, usb_udc_connect_control() has to run in non-atomic context=
 due to the following:
> > + * a. Some of the gadget driver implementations expect the ->pullup ca=
llback to be invoked in
> > + * non-atomic context.
> > + * b. usb_gadget_disconnect() acquires udc_lock which is a mutex.
> > + * Hence offload invocation of usb_udc_connect_control() to workqueue.
>
> Comments should be wrapped after about 76 columns (unless there is some
> very good reason not to).

Sounds good ! Have addressed this in v6. Wrapping comments at 76.

>
> >   */
> >  void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
> >  {
> > @@ -1101,7 +1116,7 @@ void usb_udc_vbus_handler(struct usb_gadget *gadg=
et, bool status)
> >
> >       if (udc) {
> >               udc->vbus =3D status;
> > -             usb_udc_connect_control(udc);
> > +             schedule_work(&udc->vbus_work);
> >       }
> >  }
> >  EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
> > @@ -1328,6 +1343,7 @@ int usb_add_gadget(struct usb_gadget *gadget)
> >       mutex_lock(&udc_lock);
> >       list_add_tail(&udc->list, &udc_list);
> >       mutex_unlock(&udc_lock);
> > +     INIT_WORK(&udc->vbus_work, vbus_event_work);
> >
> >       ret =3D device_add(&udc->dev);
> >       if (ret)
> > @@ -1558,6 +1574,7 @@ static void gadget_unbind_driver(struct device *d=
ev)
> >
> >       kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
> >
> > +     cancel_work_sync(&udc->vbus_work);
> >       usb_gadget_disconnect(gadget);
> >       usb_gadget_disable_async_callbacks(udc);
> >       if (gadget->irq)
>
> I'm not in love with this, because there's nothing here to prevent the
> work item from being queued again right after it is cancelled.  Patch
> 3/3 in the series will fix this, but in the meantime this window will
> exist.
>
> Maybe it would be better to merge the 3/3 patch with this one.  They are
> very closely related, after all, since the other patch addresses the
> matter of not allowing the work item to do anything bad at the wrong
> time.

Done ! v6. now squashes 1/3 with 3/3.

Thanks a lot,
Badhri

>
> Alan Stern
