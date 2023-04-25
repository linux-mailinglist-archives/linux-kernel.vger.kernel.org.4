Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704416EE67C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjDYRS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDYRS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:18:26 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9464E5F;
        Tue, 25 Apr 2023 10:18:25 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so6124300a12.2;
        Tue, 25 Apr 2023 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682443105; x=1685035105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/17J/S6eU+FZeHfmVQyUAEEmZwYeCmiWS2BcpDMa1Qs=;
        b=gEZ8m2oXwCMFlbevdc/pxoJPcoUIqerxocj8c5fqEivuz/FlNRia9YA5Bggdq8Kf3B
         g5LYNsOH/KzOgWvaHCw0o/OIk+kN7IZMSj0mYIhqZoGka3RK1txklhCQ1Ci8lXZV9Ri9
         Hy00Ul+0TaX1sOHpgTyU8N6V0sqXe4XBnusJkrCJdesCbOtRQwbIcW91HXOKO9nay+eR
         PiF6rl/taWgKcTfGJkEYP5ot8sQ/eh4SDOatE7S1ZpXqeTJNOd65+iTO4CxwNV6g6g6p
         dMSOVTiegGqBeqnBKY4Ll3V/H+BWcrvpQ3OqfvKcxBjVecgD58/o0vnvbYlh7YHzbbkX
         TzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682443105; x=1685035105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/17J/S6eU+FZeHfmVQyUAEEmZwYeCmiWS2BcpDMa1Qs=;
        b=TLTxkOWAZ8sz0c5sL99DenQ7Vswz+n+6M9szeuHCqgbboJsIHvnYKvzCE1eHkN/c+m
         LHCI3sWjQe0bE5pKb07N1Pd/+o+P49DzEAHZus9xx5WYVUDJaZ6y+0yGO9jg0g/OpZOU
         pK8DaGToK6VRrbSwDHUG4877vOhgIjz6CcOJzUorf5y1gUSykxGkmJ0EeRq2h8NXKNWS
         HPFL3WNIH5NBpeK53EugBdjLzbNmIZ0lalMSxt3ADvUVqM0JjYpcE9/sKUTfvGfk+i18
         5qk/A8MdHmObWKSF+fsEbY1mVGHiG+GEU569BTud2zLwIvPTVPTdHdljshn86v6zKRO6
         UU2w==
X-Gm-Message-State: AAQBX9e9WKabsh/hd5KWXhxuG+KlHt5f2l5T5AKmxc043iq+pnY5K+na
        ONT/KqKw+bJ9L3l0Uvc69kWIn7kPkQlII6njrj/BxpZ/VHgyr0Oe
X-Google-Smtp-Source: AKy350Y6vIHyXSBx8rUF1ctIPirpYIG+UI+Vb/yjuDkAwQ4kXDuvG7sRdQmsGyIMqdPIZtOQBSz3ehn3Nf5o4tXYQCQ=
X-Received: by 2002:a17:90b:fc1:b0:247:101b:b532 with SMTP id
 gd1-20020a17090b0fc100b00247101bb532mr17338130pjb.28.1682443104942; Tue, 25
 Apr 2023 10:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230412171441.18958-1-zyytlz.wz@163.com> <2bd0143cf0e638c88f57409f854c0529a1b12b6b.camel@linux.intel.com>
In-Reply-To: <2bd0143cf0e638c88f57409f854c0529a1b12b6b.camel@linux.intel.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 26 Apr 2023 01:18:12 +0800
Message-ID: <CAJedcCzptvdgk8vMO5F==NS79gTZdWaL1id8GcbUn2UsbQr8Xg@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-ish-hid: pci-ish: Fix use after free bug in
 ish_remove due to race condition
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, rafael@kernel.org,
        hdegoede@redhat.com, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

srinivas pandruvada <srinivas.pandruvada@linux.intel.com> =E4=BA=8E2023=E5=
=B9=B44=E6=9C=8825=E6=97=A5=E5=91=A8=E4=BA=8C 23:55=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Thu, 2023-04-13 at 01:14 +0800, Zheng Wang wrote:
> > In ish_probe, it calls ish_dev_init to init the device. In this
> > function,
> > ishtp_device_init is called and &dev->bh_hbm_work is bound with
> > bh_hbm_work_fn. recv_hbm may be called to start the timer work.
> >
> > If we remove the module which will call ish_remove to make cleanup,
> > there may be an unfinished work. The possible sequence is as follows:
> >
> > Fix it by canceling the work before cleanup in
> > ishtp_bus_remove_all_clients
> >
> > CPU0                  CPUc1
> >
> >                     |bh_hbm_work_fn
> > ish_remove      |
> > ishtp_bus_remove_all_clients  |
> > kfree(ishtp_dev->fw_clients); |
> >                     |
> >                     |&dev->fw_clients[...]
> >                     |   //use
> >
> > Fixes: 3703f53b99e4 ("HID: intel_ish-hid: ISH Transport layer")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> It is a extremely rare case, so it is OK to not mark for stable.

Got it, thanks!

Best regards,
Zheng

>
> > ---
> >  drivers/hid/intel-ish-hid/ishtp/bus.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c
> > b/drivers/hid/intel-ish-hid/ishtp/bus.c
> > index 81385ab37fa9..ada7cd08dbeb 100644
> > --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> > +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> > @@ -744,6 +744,7 @@ void ishtp_bus_remove_all_clients(struct
> > ishtp_device *ishtp_dev,
> >                  */
> >         }
> >         spin_unlock_irqrestore(&ishtp_dev->cl_list_lock, flags);
> > +       cancel_work_sync(&ishtp_dev->bh_hbm_work);
> >
> >         /* Release DMA buffers for client messages */
> >         ishtp_cl_free_dma_buf(ishtp_dev);
>
