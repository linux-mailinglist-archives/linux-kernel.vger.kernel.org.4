Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E076DC4C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjDJJBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjDJJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:00:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FFC10CB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:00:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v9so8908367pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681117245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Yf6i3dwVyGNHunqVy4wvMe4Mu5dQWI3DJrKMN6n03A=;
        b=go0HNhF8sbV56879EF0jnigLtZjM/PEkln1DJD/l30BBdvyr5OggfhblddHaccOzea
         mN76tKnyPFHmnPCnAGFrtLUvsjXhvsGfoikqyVdDxSHCUXnJ8usNxsx0BE3uPIPkGkrD
         /vwOYI0p2uw7uiv3iE+LVOHnoggggfjCrFLCVbMI/aPSnAOeOX7k/IHyoV19DkHobRTP
         F1kyBIS/irVKTGzzaVTWuGrvpjpNKbau1ncL4K7Pps9U0iJLmrk99dT1uC0A7IxTQztz
         6LLqe1KKHE4pLbI+33jFuD3L3bIFqLHBv/6c+jrHCDGI09ITIsg4UXYJIGE1YgfXwm7S
         LUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681117245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Yf6i3dwVyGNHunqVy4wvMe4Mu5dQWI3DJrKMN6n03A=;
        b=TGOhG+XJueLhiu1MSrkN81S9vjK7y/FX07748HMCVIT4FHIs9gzZYcbDWsI6TP0ag3
         7c1GmlVnAL0ggD3YLSs3wGFI4wszcVwmZ7dqdOoXJit+L45ItwxYwI0LIGM04/R+dhif
         nVwxY6EjcKRy9OY5H2fYzAa7kWrxyWMV9XkCgz6JApvvg6aMP7a1LwHdAfTMQOPIP8b7
         yIDtAQ0qKca9FQkI8raiIOndrxRPrBbndsONA6FyP9AHNKHal2rKolDmCiA1UhNWIsWZ
         SNgpvB5S3NW5JkD8som42IsRnpceqCulmYp+slIBS7CoTP6Mofl56DUK2/L9HHlw8M6y
         5qnA==
X-Gm-Message-State: AAQBX9cnC0Ssqku6OQO05lsaFy6As4aCyVk+7+qdTFna4ybvAOcfsdzQ
        sCBlf7oDyQEomQOP0mhmFnmU2Gmu8ceUPOphjUrOEHBO3Zu/2runDwBnTg==
X-Google-Smtp-Source: AKy350ZIxNWI1S019pZJHU9u88eFp+zQty20lRWIS6vsojbalefkFbcIwumPNIIx1viGM/igzOsfLF8VzL46JfYZaOk=
X-Received: by 2002:a17:90a:4290:b0:246:6a3a:6aec with SMTP id
 p16-20020a17090a429000b002466a3a6aecmr2059886pjg.4.1681117245070; Mon, 10 Apr
 2023 02:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230410073134.488762-1-badhri@google.com> <2023041028-irritate-starless-a42f@gregkh>
 <CAPTae5KZ0zkaCWrtPYzyX8oTyvDhBhc-hvxyHn9VHZ32UOqJ3g@mail.gmail.com> <2023041004-antarctic-hardiness-524e@gregkh>
In-Reply-To: <2023041004-antarctic-hardiness-524e@gregkh>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 10 Apr 2023 02:00:08 -0700
Message-ID: <CAPTae5JFC8WUzjrMeiyw7tYfWpsZUQThrrvG_etx7Fb2KP6y6A@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: Add kernel config to wrap around
 tcpm logs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Apr 10, 2023 at 1:27=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Apr 10, 2023 at 01:08:55AM -0700, Badhri Jagan Sridharan wrote:
> > On Mon, Apr 10, 2023 at 12:45=E2=80=AFAM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > >
> > > On Mon, Apr 10, 2023 at 07:31:34AM +0000, Badhri Jagan Sridharan wrot=
e:
> > > > This change adds CONFIG_TCPM_LOG_WRAPAROUND which when set allows t=
he
> > > > logs to be wrapped around. Additionally, when set, does not clear
> > > > the TCPM logs when dumped.
> > > >
> > > > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > > > ---
> > > >  drivers/usb/typec/tcpm/Kconfig | 6 ++++++
> > > >  drivers/usb/typec/tcpm/tcpm.c  | 9 +++++++--
> > > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcp=
m/Kconfig
> > > > index e6b88ca4a4b9..4dd2b594dfc9 100644
> > > > --- a/drivers/usb/typec/tcpm/Kconfig
> > > > +++ b/drivers/usb/typec/tcpm/Kconfig
> > > > @@ -18,6 +18,12 @@ config TYPEC_TCPCI
> > > >       help
> > > >         Type-C Port Controller driver for TCPCI-compliant controlle=
r.
> > > >
> > > > +config TCPM_LOG_WRAPAROUND
> > > > +     bool "Enable TCPM log wraparound"
> > > > +     help
> > > > +       When set, wraps around TCPM logs and does not clear the log=
s when dumped. TCPM logs by
> > > > +       default gets cleared when dumped and does not wraparound wh=
en full.
> > >
> > > Kconfig help text needs to be wrapped at the properly width.
> >
> > I assumed that the width is 100 characters, but it looks like it is
> > 80. Will fix it in the next version.
> > >
> > > And you do not provide any hint here as to why this is not the defaul=
t
> > > option, or why someone would want this.
> >
> > "TCPM logs by default gets cleared when dumped and does not wraparound
> > when full." was intended
> > to convey why someone would want to set this. Perhaps it's not effectiv=
e.
> >
> > Does the below look better:
> > "TCPM logs by default gets cleared when dumped and does not wraparound
> > when full. This can be overridden by setting this config.
> > When the config is set, TCPM wraps around logs and does not clear the
> > logs when dumped."
> >
> > Also, I could make this default if that's OK with Guenter.
> >
> > >
> > > So, why is this not just the default operation anyway?  Why would you
> > > ever want the logs cleared?
> >
> > I remember Guenter mentioning that he was finding it useful to not
> > wrap around the logs to fix problems
> > during tcpm_register_port (init sequence). IMHO wrapping around the
> > logs helps to triage interoperability
> > issues uncovered during testing. So both approaches have their own adva=
ntages.
>
> But as this is a build-time option, what would cause someone to choose
> one over the other, and then when the system is running, they can't
> change them?

During initial phases of bringup, it makes sense to not wrap around
the logs, but, once bringup is done its most effective to wraparound
so that interop issues reported by the end users can be triaged where
TCPM logs are very effective.
Also, without wrapping around, the logbuffer logs are completely stale
after the user goes through a few USB connect and disconnect cycles
till the system is rebooted.
If we don't want to pursue the Kconfig option, we should atleast make
TCPM default to wrapping the logs around when full so we could
maximise the use of the logbuffer contents.

>
> That does not seem good at all.
>
> Why not just use tracing instead of this odd custom log buffer?  That's
> a better solution overall, right?

Tracing is not enabled by default in most systems. End users don't
want to retry and reproduce the failure to collect traces even if they
could reproduce it consistently.
So tracing was not proving handy here.

Thanks,
Badhri

>
> thanks,
>
> greg k-h
