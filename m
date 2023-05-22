Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B7F70B710
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjEVHvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjEVHvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:51:25 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E151723
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:49:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so5096133a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684741757; x=1687333757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXqacZ7P4o4faz/vNysvlhG0FAAAOG2qV6n1Xw8uN8U=;
        b=62rsH0qRQVhPkF00D/PVaZAfMh0xc3yvej0xDP506s/7NzkN3KHUghfPkTPaNbE8yB
         V7wSu0BUowgTLMyeW5N2gk7NWCCxV8fOKuBhyk2Yo05sl8kpJU3LkBy5eeaakiq/gF1M
         +SNhrU0MP/OdoANJ6OfPI2lfcsQ6IjH60lpsOLz0ghiS25BCHCIaaWaxhYJioRvpy1m6
         1pWw/bKRY7crrO57dAmMa9BaUD8l0XruC5aBMmy4JkkvedNzrOdKh9pdPg18nQDU9v/J
         Mocaxv3JgarDvJkQx/8/lNjoelrJEWtHmgra/uqNVuR4oeo6pz2jMb50AjXPkQR2u669
         +0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684741757; x=1687333757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXqacZ7P4o4faz/vNysvlhG0FAAAOG2qV6n1Xw8uN8U=;
        b=F6y1u8XNL75zkd0gyWUG3q6OHjMzIWoUYF5WD3nbWCk9b1Hci1G2oyPqJk00lD2rdi
         iFopTwzpLEHByBadhdWchNO9P6E6SGOhIrM8T6Y+xe5+47Sh9QCgBuPrP7rV2Z7LCFw7
         YCpY0HmRUuqt0BRmDd0OM7bAOWUuTQN2zwJIWiaSwamSa2ezSTWIVQNRa4YcqKl7GQ5K
         QzLsIEBJZ+Snn9Ogn0oB5TjdTgrmD7E17tl9lnxIOT437ywCYgL7kvnJNfNZxDFgebYD
         5bh2TsA4KMXvaaZY3hStdRNyLZvCL9n8QLuRTrYQN8wpseeMs0O3WpwmRMUbKefamgiO
         mAPw==
X-Gm-Message-State: AC+VfDyuSfo1rTAXXEoLqPrsIbT0amB2GdCIXtOd9emyGsiJAOlWUyDu
        WOfZmeBS1FnapPnkxrW90/ujjhvq0y1pvrMwQGor3Q==
X-Google-Smtp-Source: ACHHUZ6NS5u4I6xPkuvLTuCpIIAYU2qi4UK6iL3oKxLD9mYasKrRrM9Z9Y0s5FulOiYF0y1dlG3waM6ScIJvx/fIgqs=
X-Received: by 2002:a17:90b:4397:b0:255:5b1a:be04 with SMTP id
 in23-20020a17090b439700b002555b1abe04mr3326900pjb.4.1684741756884; Mon, 22
 May 2023 00:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230519043041.1593578-1-badhri@google.com> <c181c8ef-f342-4a31-9b8c-e1fa14ad214e@rowland.harvard.edu>
 <a1d064e7-9847-4e2e-b74a-4ae4f39d3f04@rowland.harvard.edu>
 <CAPTae5JKUW6g8cvUbJ3owMGm+npJSBgjr-O_xEiRm_tzXVBV1Q@mail.gmail.com> <a2305ca6-d343-473d-b220-556a2c2e7833@rowland.harvard.edu>
In-Reply-To: <a2305ca6-d343-473d-b220-556a2c2e7833@rowland.harvard.edu>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 22 May 2023 00:48:39 -0700
Message-ID: <CAPTae5Lke+DE3WzGuBxkMMZ=qbbux=avdDTgrxEc1A5SrCFevg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, francesco@dolcini.it, alistair@alistair23.me,
        stephan@gerhold.net, bagasdotme@gmail.com, luca@z3ntu.xyz,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
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

Hi Alan,

Thanks for taking the time out to share more details !
+1 on your comment: " A big problem with the USB gadget
framework is that it does not clearly state which routines have to run
in process context and which have to run in interrupt/atomic context."


I started to work on allow_connect and other suggestions that you had made.
In one of the previous comments you had mentioned that the
connect_lock should be a spinlock and not a mutex.
Right now there are four conditions that seem to be deciding whether
pullup needs to be enabled or disabled through gadget->ops->pullup().
1. Gadget not deactivated through usb_gadget_deactivate()
2. Gadget has to be started through usb_gadget_udc_start().
soft_connect_store() can start/stop gadget.
3. usb_gadget has been connected through usb_gadget_connect(). This is
assuming we are getting rid of usb_udc_vbus_handler.
4. allow_connect is true

I have so far identified two constraints here:
a. gadget->ops->pullup() can sleep in some implementations.
For instance:
BUG: scheduling while atomic: init/1/0x00000002
..
[   26.990631][    T1] Call trace:
[   26.993759][    T1]  dump_backtrace+0x104/0x128
[   26.998281][    T1]  show_stack+0x20/0x30
[   27.002279][    T1]  dump_stack_lvl+0x6c/0x9c
[   27.006627][    T1]  __schedule_bug+0x84/0xb4
[   27.010973][    T1]  __schedule+0x6f0/0xaec
[   27.015147][    T1]  schedule+0xc8/0x134
[   27.019059][    T1]  schedule_timeout+0x98/0x134
[   27.023666][    T1]  msleep+0x34/0x4c
[   27.027317][    T1]  dwc3_core_soft_reset+0xf0/0x354
[   27.032273][    T1]  dwc3_gadget_pullup+0xec/0x1d8
[   27.037055][    T1]  usb_gadget_pullup_update_locked+0xa0/0x1e0
[   27.042967][    T1]  udc_bind_to_driver+0x1e4/0x30c
[   27.047835][    T1]  usb_gadget_probe_driver+0xd0/0x178
[   27.053051][    T1]  gadget_dev_desc_UDC_store+0xf0/0x13c
[   27.058442][    T1]  configfs_write_iter+0x100/0x178
[   27.063399][    T1]  vfs_write+0x278/0x3c4
[   27.067483][    T1]  ksys_write+0x80/0xf4

b. gadget->ops->udc_start can also sleep in some implementations.
For example:
[   28.024255][    T1] BUG: scheduling while atomic: init/1/0x00000002
....
[   28.324996][    T1] Call trace:
[   28.328126][    T1]  dump_backtrace+0x104/0x128
[   28.332647][    T1]  show_stack+0x20/0x30
[   28.336645][    T1]  dump_stack_lvl+0x6c/0x9c
[   28.340993][    T1]  __schedule_bug+0x84/0xb4
[   28.345340][    T1]  __schedule+0x6f0/0xaec
[   28.349513][    T1]  schedule+0xc8/0x134
[   28.353425][    T1]  schedule_timeout+0x4c/0x134
[   28.358033][    T1]  wait_for_common+0xac/0x13c
[   28.362554][    T1]  wait_for_completion_killable+0x20/0x3c
[   28.368118][    T1]  __kthread_create_on_node+0xe4/0x1ec
[   28.373422][    T1]  kthread_create_on_node+0x54/0x80
[   28.378464][    T1]  setup_irq_thread+0x50/0x108
[   28.383072][    T1]  __setup_irq+0x90/0x87c
[   28.387245][    T1]  request_threaded_irq+0x144/0x180
[   28.392287][    T1]  dwc3_gadget_start+0x50/0xac
[   28.396866][    T1]  udc_bind_to_driver+0x14c/0x31c
[   28.401763][    T1]  usb_gadget_probe_driver+0xd0/0x178
[   28.406980][    T1]  gadget_dev_desc_UDC_store+0xf0/0x13c
[   28.412370][    T1]  configfs_write_iter+0x100/0x178
[   28.417325][    T1]  vfs_write+0x278/0x3c4
[   28.421411][    T1]  ksys_write+0x80/0xf4

static int dwc3_gadget_start(struct usb_gadget *g,
                struct usb_gadget_driver *driver)
{
        struct dwc3             *dwc =3D gadget_to_dwc(g);
...
        irq =3D dwc->irq_gadget;
        ret =3D request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_inter=
rupt,
                        IRQF_SHARED, "dwc3", dwc->ev_buf);

Given that "1016fc0c096c USB: gadget: Fix obscure lockdep violation
for udc_mutex" has been there for a while and no one has reported
issues so far, perhaps ->disconnect() callback is no longer being
invoked in atomic context and the documentation is what that needs to
be updated ?

Thanks,
Badhri

On Fri, May 19, 2023 at 10:27=E2=80=AFAM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Fri, May 19, 2023 at 08:44:57AM -0700, Badhri Jagan Sridharan wrote:
> > On Fri, May 19, 2023 at 8:07=E2=80=AFAM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > >
> > > On Fri, May 19, 2023 at 10:49:49AM -0400, Alan Stern wrote:
> > > > On Fri, May 19, 2023 at 04:30:41AM +0000, Badhri Jagan Sridharan wr=
ote:
> > > > > chipidea udc calls usb_udc_vbus_handler from udc_start gadget
> > > > > ops causing a deadlock. Avoid this by offloading usb_udc_vbus_han=
dler
> > > > > processing.
> > > >
> > > > Look, this is way overkill.
> > > >
> > > > usb_udc_vbus_handler() has only two jobs to do: set udc->vbus and c=
all
> > > > usb_udc_connect_control().  Furthermore, it gets called from only t=
wo
> > > > drivers: chipidea and max3420.
> > > >
> > > > Why not have the callers set udc->vbus themselves and then call
> > > > usb_gadget_{dis}connect() directly?  Then we could eliminate
> > > > usb_udc_vbus_handler() entirely.  And the unnecessary calls -- the =
ones
> > > > causing deadlocks -- from within udc_start() and udc_stop() handler=
s can
> > > > be removed with no further consequence.
> > > >
> > > > This approach simplifies and removes code.  Whereas your approach
> > > > complicates and adds code for no good reason.
> > >
> > > I changed my mind.
> > >
> > > After looking more closely, I found the comment in gadget.h about
> > > ->disconnect() callbacks happening in interrupt context.  This means =
we
> > > cannot use a mutex to protect the associated state, and therefore the
> > > connect_lock _must_ be a spinlock, not a mutex.
> >
> > Quick observation so that I don't misunderstand.
> > I already see gadget->udc->driver->disconnect(gadget) being called with
> > udc_lock being held.
> >
> >                mutex_lock(&udc_lock);
> >                if (gadget->udc->driver)
> >                        gadget->udc->driver->disconnect(gadget);
> >                mutex_unlock(&udc_lock);
> >
> > The below patch seems to have introduced it:
> > 1016fc0c096c USB: gadget: Fix obscure lockdep violation for udc_mutex
>
> Hmmm...  You're right about this.  A big problem with the USB gadget
> framework is that it does not clearly state which routines have to run
> in process context and which have to run in interrupt/atomic context.
> People therefore don't think about it and frequently get it wrong.
>
> So now the problem is that the UDC or transceiver driver may detect
> (typically in an interrupt handler) that VBUS power has appeared or
> disappeared, and it wants to tell the core to adjust the D+/D- pullup
> signals appropriately.  The core notifies the UDC driver about this, and
> then in the case of a disconnection, it has to notify the gadget driver.
> But notifying the gadget driver requires process context for the
> udc_lock mutex, the ultimate reason being that disconnect notifications
> can race with gadget driver binding and unbinding.
>
> If we could prevent those races in some other way then we wouldn't need
> to hold udc_lock in usb_gadget_disconnect().  This seems like a sensible
> thing to do in any case; the UDC core should never allow a connection to
> occur before a gadget driver is bound or after it is unbound.
>
> The first approach that occurs to me is to add a boolean allow_connect
> flag to struct usb_udc, together with a global spinlock to synchronize
> access to it.  Then usb_gadget_disconnect() could check the flag before
> calling driver->disconnect(), gadget_bind_driver() could set the flag
> before calling usb_udc_connect_control(), and gadget_unbind_driver()
> could clear the flag before calling usb_gadget_disconnect().
>
> (Another possible approach would be to change gadget->deactivated into a
> counter.  It would still need to be synchronized by a spinlock,
> however.)
>
> This will simplify matters considerably.  udc_lock can remain a mutex
> and the deadlock problem should go away.
>
> Do you want to try adding allow_connect as described here or would you
> prefer that I do it?
>
> (And in any case, we should prevent the udc_start and udc_stop callbacks
> in the chipidea and max3420 drivers from trying to update the connection
> status.)
>
> Alan Stern
