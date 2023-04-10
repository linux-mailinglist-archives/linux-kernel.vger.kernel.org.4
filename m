Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB57A6DCC67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDJU6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDJU6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:58:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58537E50
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:58:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q15-20020a17090a2dcf00b0023efab0e3bfso8641888pjm.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681160288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpsswGb8pfO0+/JLJkf4UecoZuOb7ysrMIZCPuKNFWI=;
        b=qRRBUwaCPmV0mCWpqrzen2I6ZZ0j7ySPlX5bf3dUPxMcragOguwvbUoI68+HIQ0SX6
         a6KOGjsh/mrtXntWfpAcfb/9RzCJnNBK4Gb+aOdQ3HXUn4U6mkD0fARcs4WtBE2ypFi7
         C5V/TgvKdfNjO2eW1SoYubhiaanKxhsmuYf2gvUYOO/fq8PsJ4LpxfXfbw42dJBo58SD
         GM6lyZbglQnFbblLFmiLn7GjE56mQEPgdMT9IFCPXS4lQH5A/HTsQBUPBilEVexZmk3b
         R84YjVoBkknGRr04VILgGebLZejRdzz5x1p+5q8h81elKejdsT6JI7spOEMp4JPtVmU+
         pjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpsswGb8pfO0+/JLJkf4UecoZuOb7ysrMIZCPuKNFWI=;
        b=biJIOMIVUl9e/nKGi8JA7LJktr8r/Xk5NRsbNjA9fTH4ebv/xJHRO1iXS4UoO/QE0+
         ua6SzHqVp68Rgksqfc7hN4iJQ2RT/DQaD0hlGU3dKe5Eu8Xue9C47jFbYjVp4jBPfZWi
         5sfGtrt8w1Kl8tDR/8DZgyhnyB5cOQ9OuRQ4xQHAErkF4tq9gxdcfeKaUF7m+9o2ARoh
         APYafmNwXbLNgV1xYWQwXaywKH255MF0Z1uRb4T87ORwamrkQSKwmpOe9kPfNU5Bgo3S
         BuNMi5f9eeU5KAzwdKlmtwgSr+lLbFJFZGEq96SbPHT498VmraP63PxiFJPUR+oVM4px
         Hybw==
X-Gm-Message-State: AAQBX9cefSb47gFAzj72zz9l8x4UiUg5TtJ9RTIKelaxio9U4sOk706Y
        a5XZLzpeIjKo/2LmiIOmqGMr8NcGlGwugGyviVo3NJ8OApTxs44yRsMTmQ==
X-Google-Smtp-Source: AKy350ZJ+jGeTIYJCaU7jbTGcIwBPwmqPr07cxlYPqWehgNdk6BAuXOGvv0E1dlohdZcUcyNH1wp/RM7DSfDDdEUyug=
X-Received: by 2002:a17:902:da8a:b0:1a2:8fa0:fbd7 with SMTP id
 j10-20020a170902da8a00b001a28fa0fbd7mr7245776plx.2.1681160287598; Mon, 10 Apr
 2023 13:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230410073134.488762-1-badhri@google.com> <2023041028-irritate-starless-a42f@gregkh>
 <CAPTae5KZ0zkaCWrtPYzyX8oTyvDhBhc-hvxyHn9VHZ32UOqJ3g@mail.gmail.com>
 <2023041004-antarctic-hardiness-524e@gregkh> <CAPTae5JFC8WUzjrMeiyw7tYfWpsZUQThrrvG_etx7Fb2KP6y6A@mail.gmail.com>
 <b1ac0ab9-e6f3-4301-a231-519752e4a735@roeck-us.net>
In-Reply-To: <b1ac0ab9-e6f3-4301-a231-519752e4a735@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 10 Apr 2023 13:57:30 -0700
Message-ID: <CAPTae5LbWVc4Bdiwe69cwwxEGfSYvRv=419dUGR1u8n-WUkYAA@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: Add kernel config to wrap around
 tcpm logs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:00=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On Mon, Apr 10, 2023 at 02:00:08AM -0700, Badhri Jagan Sridharan wrote:
> > On Mon, Apr 10, 2023 at 1:27=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Mon, Apr 10, 2023 at 01:08:55AM -0700, Badhri Jagan Sridharan wrot=
e:
> > > > On Mon, Apr 10, 2023 at 12:45=E2=80=AFAM Greg KH <gregkh@linuxfound=
ation.org> wrote:
> > > > >
> > > > > On Mon, Apr 10, 2023 at 07:31:34AM +0000, Badhri Jagan Sridharan =
wrote:
> > > > > > This change adds CONFIG_TCPM_LOG_WRAPAROUND which when set allo=
ws the
> > > > > > logs to be wrapped around. Additionally, when set, does not cle=
ar
> > > > > > the TCPM logs when dumped.
> > > > > >
> > > > > > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > > > > > ---
> > > > > >  drivers/usb/typec/tcpm/Kconfig | 6 ++++++
> > > > > >  drivers/usb/typec/tcpm/tcpm.c  | 9 +++++++--
> > > > > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec=
/tcpm/Kconfig
> > > > > > index e6b88ca4a4b9..4dd2b594dfc9 100644
> > > > > > --- a/drivers/usb/typec/tcpm/Kconfig
> > > > > > +++ b/drivers/usb/typec/tcpm/Kconfig
> > > > > > @@ -18,6 +18,12 @@ config TYPEC_TCPCI
> > > > > >       help
> > > > > >         Type-C Port Controller driver for TCPCI-compliant contr=
oller.
> > > > > >
> > > > > > +config TCPM_LOG_WRAPAROUND
> > > > > > +     bool "Enable TCPM log wraparound"
> > > > > > +     help
> > > > > > +       When set, wraps around TCPM logs and does not clear the=
 logs when dumped. TCPM logs by
> > > > > > +       default gets cleared when dumped and does not wraparoun=
d when full.
> > > > >
> > > > > Kconfig help text needs to be wrapped at the properly width.
> > > >
> > > > I assumed that the width is 100 characters, but it looks like it is
> > > > 80. Will fix it in the next version.
> > > > >
> > > > > And you do not provide any hint here as to why this is not the de=
fault
> > > > > option, or why someone would want this.
> > > >
> > > > "TCPM logs by default gets cleared when dumped and does not wraparo=
und
> > > > when full." was intended
> > > > to convey why someone would want to set this. Perhaps it's not effe=
ctive.
> > > >
> > > > Does the below look better:
> > > > "TCPM logs by default gets cleared when dumped and does not wraparo=
und
> > > > when full. This can be overridden by setting this config.
> > > > When the config is set, TCPM wraps around logs and does not clear t=
he
> > > > logs when dumped."
> > > >
> > > > Also, I could make this default if that's OK with Guenter.
> > > >
> > > > >
> > > > > So, why is this not just the default operation anyway?  Why would=
 you
> > > > > ever want the logs cleared?
> > > >
> > > > I remember Guenter mentioning that he was finding it useful to not
> > > > wrap around the logs to fix problems
> > > > during tcpm_register_port (init sequence). IMHO wrapping around the
> > > > logs helps to triage interoperability
> > > > issues uncovered during testing. So both approaches have their own =
advantages.
> > >
> > > But as this is a build-time option, what would cause someone to choos=
e
> > > one over the other, and then when the system is running, they can't
> > > change them?
> >
> > During initial phases of bringup, it makes sense to not wrap around
> > the logs, but, once bringup is done its most effective to wraparound
> > so that interop issues reported by the end users can be triaged where
> > TCPM logs are very effective.
>
> Not really, because the problem tends to be the remote device
> (or at least it used to be), not a driver under development.

Thanks for clarifying Guenter !
Right now if we DONT wrap around, once an issue is observed with a
remote device, the logs have to be cleared(if already full) and then
the issue has to be reproduced to collect the TCPM logbuffer
logsagain.

Having a log available _all_ the time, not just when explicitly
enabled is still very useful to catch hard to reproduce intertop
issues.

Given this would you be OK if I change the logic to wrap around always ?

IMHO based on what I have seen in the last couple of years, this would
also cover the boot with accessory connected as if the link gets into
a reset loop, the sequence after the reset reveals what had gone
wrong.

>
> > Also, without wrapping around, the logbuffer logs are completely stale
> > after the user goes through a few USB connect and disconnect cycles
> > till the system is rebooted.
>
> Unless they are cleared.

Ah yes. I forgot about that. Wrapping around would still make TCPM
logbuffer logs  more effective to debug issues with remote device.

Thanks,
Badhri





>
> Again, the premise is wrong here. The idea was to ensure that the
> beginning of a problem is caught and available in the log, not its tail.
> This includes "beginning" as the behavior immediately after boot regardin=
g
> an already connected device, and the behavior observed when inserting
> a device into the running system. Again, in both cases it was most
> important to catch the beginning of a problem, not its tail.
>
> > If we don't want to pursue the Kconfig option, we should atleast make
> > TCPM default to wrapping the logs around when full so we could
> > maximise the use of the logbuffer contents.
> >
>
> I don't really agree, but then I am not in a position to argue either.
> Maybe the premise and reasons have changed since I wrote the driver.
>
> Guenter
>
> > >
> > > That does not seem good at all.
> > >
> > > Why not just use tracing instead of this odd custom log buffer?  That=
's
> > > a better solution overall, right?
> >
> > Tracing is not enabled by default in most systems. End users don't
> > want to retry and reproduce the failure to collect traces even if they
> > could reproduce it consistently.
> > So tracing was not proving handy here.
> >
> > Thanks,
> > Badhri
> >
> > >
> > > thanks,
> > >
> > > greg k-h
