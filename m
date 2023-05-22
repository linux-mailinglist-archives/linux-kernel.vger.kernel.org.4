Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4252970B878
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjEVJGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjEVJGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:06:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D031AD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:06:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d2467d640so4638581b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684746362; x=1687338362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlEd6aZMxCpFn4lWzoL9URTNtJSWl/PRKXF7l2+sai0=;
        b=6Dx/V8Bn6piyF8b1rZjFOF2OsecwOt8m9aqf3IthfHtNn+8iuBUWve06ehGkaaUvT/
         aft/jIQreQ3vzEZ72nOEKcKVfh363eWTJGYJ+UxmnboN3uAmWeC55izbhvY3qMKPV9Xz
         oL1ycH3YrZTb6bFXCxV0foQEpEbxi13LO9OUOgc43CxgD+H6aaYQDoyy3Soaiek/gc7X
         oEp+N53T9Q9DhPh1NX2Vn8xMmkQk5wTcGn5HEjGrluPiuGGi8+Ce6m9gahNepapv6fa1
         EyxB8F2MPGcm1SnWTFhILOtTCoXza7OQfp6jwVeUhD+9T5DVWic07VOEPc30gwhrw+pC
         +Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684746362; x=1687338362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlEd6aZMxCpFn4lWzoL9URTNtJSWl/PRKXF7l2+sai0=;
        b=MVKQkzvTIemo2CJGaoCqD3K30Vw47vm2ERB5A8PGcEL/7yNP203fs/CaQj6bsMyMUx
         RrIWpD0eTz3ZCwaEktYRvOFmOMgejrxl5I73vPntRXAIrEQy7TEJI83diWUn+LM4p17+
         /TMXSEswfjKjn08xyETz4cTUHLRpm7reeQSe4n8kjhOGC+KXlwHt7git9/Ttvz6liiCp
         dF6A3rvKMlQOjCJueJQ6DUQ+CXvSzAk6sG0+zeOkeesvWWqg3g4t3+75sFJXaiA5yRHk
         2TK7ydsHCxFBGdf7IO/fMPy5JWPb3eW+Vl+zQeJ39FTR8xn/Hjvs1n+E5awKgcINqxgv
         NcQA==
X-Gm-Message-State: AC+VfDy3Wqx6BI2hP/nqFOiX4TZ6MbhwpfmRAdSxyfIuHYQSXeSaCsup
        YcPyATZ3I7wAYo7sT5stBprCVS687NGRJIOaVLiVkA==
X-Google-Smtp-Source: ACHHUZ6uVi8E/s76XpM2CRvHHNtsw5Qx9YPPbqaC6O3UAfjlysoq28A6Z9AFlC90Oeh7HoRbNbjMpzhUyqYJG9OMnb8=
X-Received: by 2002:a17:902:b404:b0:1ae:6997:a094 with SMTP id
 x4-20020a170902b40400b001ae6997a094mr9219887plr.30.1684746361877; Mon, 22 May
 2023 02:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230519043041.1593578-1-badhri@google.com> <c181c8ef-f342-4a31-9b8c-e1fa14ad214e@rowland.harvard.edu>
 <a1d064e7-9847-4e2e-b74a-4ae4f39d3f04@rowland.harvard.edu>
 <CAPTae5JKUW6g8cvUbJ3owMGm+npJSBgjr-O_xEiRm_tzXVBV1Q@mail.gmail.com>
 <a2305ca6-d343-473d-b220-556a2c2e7833@rowland.harvard.edu> <CAPTae5Lke+DE3WzGuBxkMMZ=qbbux=avdDTgrxEc1A5SrCFevg@mail.gmail.com>
In-Reply-To: <CAPTae5Lke+DE3WzGuBxkMMZ=qbbux=avdDTgrxEc1A5SrCFevg@mail.gmail.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 22 May 2023 02:05:25 -0700
Message-ID: <CAPTae5+vRLVDH4eAetufdRxnEj7mzdP15b-7d1XDWVYrYBSuCQ@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 12:48=E2=80=AFAM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> Hi Alan,
>
> Thanks for taking the time out to share more details !
> +1 on your comment: " A big problem with the USB gadget
> framework is that it does not clearly state which routines have to run
> in process context and which have to run in interrupt/atomic context."
>
>
> I started to work on allow_connect and other suggestions that you had mad=
e.
> In one of the previous comments you had mentioned that the
> connect_lock should be a spinlock and not a mutex.
> Right now there are four conditions that seem to be deciding whether
> pullup needs to be enabled or disabled through gadget->ops->pullup().
> 1. Gadget not deactivated through usb_gadget_deactivate()
> 2. Gadget has to be started through usb_gadget_udc_start().
> soft_connect_store() can start/stop gadget.
> 3. usb_gadget has been connected through usb_gadget_connect(). This is
> assuming we are getting rid of usb_udc_vbus_handler.
> 4. allow_connect is true
>
> I have so far identified two constraints here:
> a. gadget->ops->pullup() can sleep in some implementations.
> For instance:
> BUG: scheduling while atomic: init/1/0x00000002
> ..
> [   26.990631][    T1] Call trace:
> [   26.993759][    T1]  dump_backtrace+0x104/0x128
> [   26.998281][    T1]  show_stack+0x20/0x30
> [   27.002279][    T1]  dump_stack_lvl+0x6c/0x9c
> [   27.006627][    T1]  __schedule_bug+0x84/0xb4
> [   27.010973][    T1]  __schedule+0x6f0/0xaec
> [   27.015147][    T1]  schedule+0xc8/0x134
> [   27.019059][    T1]  schedule_timeout+0x98/0x134
> [   27.023666][    T1]  msleep+0x34/0x4c

Adding more context to make sure that I am more articulate.
I am aware that alternatives such as mdelay can be used to work around
in this specific instance. However, my concern is more around whether
gadget->ops->pullup() of other implementations were designed as
atomic. I only have dwc3 based hardware so can't test other udc
implementations. Hence the concern.

Thanks,
Badhri

> [   27.027317][    T1]  dwc3_core_soft_reset+0xf0/0x354
> [   27.032273][    T1]  dwc3_gadget_pullup+0xec/0x1d8
> [   27.037055][    T1]  usb_gadget_pullup_update_locked+0xa0/0x1e0
> [   27.042967][    T1]  udc_bind_to_driver+0x1e4/0x30c
> [   27.047835][    T1]  usb_gadget_probe_driver+0xd0/0x178
> [   27.053051][    T1]  gadget_dev_desc_UDC_store+0xf0/0x13c
> [   27.058442][    T1]  configfs_write_iter+0x100/0x178
> [   27.063399][    T1]  vfs_write+0x278/0x3c4
> [   27.067483][    T1]  ksys_write+0x80/0xf4
>
> b. gadget->ops->udc_start can also sleep in some implementations.
> For example:
> [   28.024255][    T1] BUG: scheduling while atomic: init/1/0x00000002
> ....
> [   28.324996][    T1] Call trace:
> [   28.328126][    T1]  dump_backtrace+0x104/0x128
> [   28.332647][    T1]  show_stack+0x20/0x30
> [   28.336645][    T1]  dump_stack_lvl+0x6c/0x9c
> [   28.340993][    T1]  __schedule_bug+0x84/0xb4
> [   28.345340][    T1]  __schedule+0x6f0/0xaec
> [   28.349513][    T1]  schedule+0xc8/0x134
> [   28.353425][    T1]  schedule_timeout+0x4c/0x134
> [   28.358033][    T1]  wait_for_common+0xac/0x13c
> [   28.362554][    T1]  wait_for_completion_killable+0x20/0x3c
> [   28.368118][    T1]  __kthread_create_on_node+0xe4/0x1ec
> [   28.373422][    T1]  kthread_create_on_node+0x54/0x80
> [   28.378464][    T1]  setup_irq_thread+0x50/0x108
> [   28.383072][    T1]  __setup_irq+0x90/0x87c
> [   28.387245][    T1]  request_threaded_irq+0x144/0x180
> [   28.392287][    T1]  dwc3_gadget_start+0x50/0xac
> [   28.396866][    T1]  udc_bind_to_driver+0x14c/0x31c
> [   28.401763][    T1]  usb_gadget_probe_driver+0xd0/0x178
> [   28.406980][    T1]  gadget_dev_desc_UDC_store+0xf0/0x13c
> [   28.412370][    T1]  configfs_write_iter+0x100/0x178
> [   28.417325][    T1]  vfs_write+0x278/0x3c4
> [   28.421411][    T1]  ksys_write+0x80/0xf4
>
> static int dwc3_gadget_start(struct usb_gadget *g,
>                 struct usb_gadget_driver *driver)
> {
>         struct dwc3             *dwc =3D gadget_to_dwc(g);
> ...
>         irq =3D dwc->irq_gadget;
>         ret =3D request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_int=
errupt,
>                         IRQF_SHARED, "dwc3", dwc->ev_buf);
>
> Given that "1016fc0c096c USB: gadget: Fix obscure lockdep violation
> for udc_mutex" has been there for a while and no one has reported
> issues so far, perhaps ->disconnect() callback is no longer being
> invoked in atomic context and the documentation is what that needs to
> be updated ?
>
> Thanks,
> Badhri
>
> On Fri, May 19, 2023 at 10:27=E2=80=AFAM Alan Stern <stern@rowland.harvar=
d.edu> wrote:
> >
> > On Fri, May 19, 2023 at 08:44:57AM -0700, Badhri Jagan Sridharan wrote:
> > > On Fri, May 19, 2023 at 8:07=E2=80=AFAM Alan Stern <stern@rowland.har=
vard.edu> wrote:
> > > >
> > > > On Fri, May 19, 2023 at 10:49:49AM -0400, Alan Stern wrote:
> > > > > On Fri, May 19, 2023 at 04:30:41AM +0000, Badhri Jagan Sridharan =
wrote:
> > > > > > chipidea udc calls usb_udc_vbus_handler from udc_start gadget
> > > > > > ops causing a deadlock. Avoid this by offloading usb_udc_vbus_h=
andler
> > > > > > processing.
> > > > >
> > > > > Look, this is way overkill.
> > > > >
> > > > > usb_udc_vbus_handler() has only two jobs to do: set udc->vbus and=
 call
> > > > > usb_udc_connect_control().  Furthermore, it gets called from only=
 two
> > > > > drivers: chipidea and max3420.
> > > > >
> > > > > Why not have the callers set udc->vbus themselves and then call
> > > > > usb_gadget_{dis}connect() directly?  Then we could eliminate
> > > > > usb_udc_vbus_handler() entirely.  And the unnecessary calls -- th=
e ones
> > > > > causing deadlocks -- from within udc_start() and udc_stop() handl=
ers can
> > > > > be removed with no further consequence.
> > > > >
> > > > > This approach simplifies and removes code.  Whereas your approach
> > > > > complicates and adds code for no good reason.
> > > >
> > > > I changed my mind.
> > > >
> > > > After looking more closely, I found the comment in gadget.h about
> > > > ->disconnect() callbacks happening in interrupt context.  This mean=
s we
> > > > cannot use a mutex to protect the associated state, and therefore t=
he
> > > > connect_lock _must_ be a spinlock, not a mutex.
> > >
> > > Quick observation so that I don't misunderstand.
> > > I already see gadget->udc->driver->disconnect(gadget) being called wi=
th
> > > udc_lock being held.
> > >
> > >                mutex_lock(&udc_lock);
> > >                if (gadget->udc->driver)
> > >                        gadget->udc->driver->disconnect(gadget);
> > >                mutex_unlock(&udc_lock);
> > >
> > > The below patch seems to have introduced it:
> > > 1016fc0c096c USB: gadget: Fix obscure lockdep violation for udc_mutex
> >
> > Hmmm...  You're right about this.  A big problem with the USB gadget
> > framework is that it does not clearly state which routines have to run
> > in process context and which have to run in interrupt/atomic context.
> > People therefore don't think about it and frequently get it wrong.
> >
> > So now the problem is that the UDC or transceiver driver may detect
> > (typically in an interrupt handler) that VBUS power has appeared or
> > disappeared, and it wants to tell the core to adjust the D+/D- pullup
> > signals appropriately.  The core notifies the UDC driver about this, an=
d
> > then in the case of a disconnection, it has to notify the gadget driver=
.
> > But notifying the gadget driver requires process context for the
> > udc_lock mutex, the ultimate reason being that disconnect notifications
> > can race with gadget driver binding and unbinding.
> >
> > If we could prevent those races in some other way then we wouldn't need
> > to hold udc_lock in usb_gadget_disconnect().  This seems like a sensibl=
e
> > thing to do in any case; the UDC core should never allow a connection t=
o
> > occur before a gadget driver is bound or after it is unbound.
> >
> > The first approach that occurs to me is to add a boolean allow_connect
> > flag to struct usb_udc, together with a global spinlock to synchronize
> > access to it.  Then usb_gadget_disconnect() could check the flag before
> > calling driver->disconnect(), gadget_bind_driver() could set the flag
> > before calling usb_udc_connect_control(), and gadget_unbind_driver()
> > could clear the flag before calling usb_gadget_disconnect().
> >
> > (Another possible approach would be to change gadget->deactivated into =
a
> > counter.  It would still need to be synchronized by a spinlock,
> > however.)
> >
> > This will simplify matters considerably.  udc_lock can remain a mutex
> > and the deadlock problem should go away.
> >
> > Do you want to try adding allow_connect as described here or would you
> > prefer that I do it?
> >
> > (And in any case, we should prevent the udc_start and udc_stop callback=
s
> > in the chipidea and max3420 drivers from trying to update the connectio=
n
> > status.)
> >
> > Alan Stern
