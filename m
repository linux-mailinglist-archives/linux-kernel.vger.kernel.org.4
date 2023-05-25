Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50040711825
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjEYUcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYUb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:31:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A74187
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:31:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f623adec61so575635e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685046714; x=1687638714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3+pGMFZpQsxevC8yghfGwAhu4MN/Iadq0vZk/E0FRg=;
        b=Ov46G+slWuSsRlxpdnYSw2YCoS5HVXbfF30R43NXOzwF9gM4aKoXW65gjFDOm87Bsz
         ErPbtBrjNkH19LKRdxHfmAbyTFORcmwB4Ry6XAcuS1K+ol0L+e04JuOXA90/e1rhY+fa
         7NySshYKK9CvavxGGSuopDgDorBTvb6krfHrqqEIJGmKqB3S0u2FAntRgBXSnsUHBd51
         Zcg99RCHynWb/MoEMU1XAsczAurcG69c2tyd2vjKcSHcTXDud53+hZTI8qwsztf0g0b/
         kCie/O18zzxvzhQVlnMWUcC7A+9EIG9GJw6ZLCXeiGejtR+hN3lCQLv/2q9kJ+GW7/bd
         sFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685046714; x=1687638714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3+pGMFZpQsxevC8yghfGwAhu4MN/Iadq0vZk/E0FRg=;
        b=ZSsqrXKRh7f6E4ghJRxFhD3erhFjpgaqhahYOVu36NdzhLn6SVN1eWk4gtwNeas6Cv
         tf7TfI75ygbuGgYSBeHvMN7Tlz8reC+rQlKjjjxiY78g7yw0mtEdIutRCk/UFNxHjpCS
         M2tElLrrPxTcDaBHpgOYgfA1iZg4ovnw4o65FvyKpXXU3zB5dqboPcyAahEtqr4ndmZZ
         LQomQwFU/vkTG3CIROI0/3mKtKGH36h5ZzTRf49dQf0/nl73v0Ju7Wp3RgxN0dGv6HdX
         /ilI5gSsdEiA+BjHGUo9ObMJAB3xiHEorDTA7j4usLhq+op8ZNftYelzdFUhqeF3ALbU
         BBnQ==
X-Gm-Message-State: AC+VfDy/+1fQ7Veg0meGl2g7hZpIskVKo64Lq9bGbuF5j84c8Yt2nI+2
        NQRFbkNH4CpIiNI8vN23tzF9mEoEslKh0nEmHWDAjA==
X-Google-Smtp-Source: ACHHUZ7HhxJG6JZ5es46Q+aDanXUKXYyTRInBg44ca1UFDA1uGFwzsYkswJ+wx8MpFn7XFOFOWoP+vV8Fq000NY5kkI=
X-Received: by 2002:adf:f010:0:b0:309:49e3:efaa with SMTP id
 j16-20020adff010000000b0030949e3efaamr3355602wro.29.1685046713806; Thu, 25
 May 2023 13:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230525173818.219633-1-royluo@google.com> <408575c0-2967-4cdb-92c7-1b2845038d20@rowland.harvard.edu>
 <CA+zupgwz8Mbd8=7ep7t0OU-34bbwsc9fMK4dHip0rgqD7FSd2A@mail.gmail.com> <89cf2c61-a55e-4c35-93b2-35fa7ab0266b@rowland.harvard.edu>
In-Reply-To: <89cf2c61-a55e-4c35-93b2-35fa7ab0266b@rowland.harvard.edu>
From:   Roy Luo <royluo@google.com>
Date:   Thu, 25 May 2023 13:31:17 -0700
Message-ID: <CA+zupgyErTsDEZYerfAeEyVF073x+aTW6HiWZRA+2Y=a7U4XVg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] usb: core: add sysfs entry for usb device state
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     raychi@google.com, badhri@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bastien Nocera <hadess@hadess.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
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

On Thu, May 25, 2023 at 12:10=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Thu, May 25, 2023 at 11:46:23AM -0700, Roy Luo wrote:
> > On Thu, May 25, 2023 at 11:02=E2=80=AFAM Alan Stern <stern@rowland.harv=
ard.edu> wrote:
> > >
> > > On Thu, May 25, 2023 at 05:38:18PM +0000, Roy Luo wrote:
> > > > Expose usb device state to userland as the information is useful in
> > > > detecting non-compliant setups and diagnosing enumeration failures.
> > > > For example:
> > > > - End-to-end signal integrity issues: the device would fail port re=
set
> > > >   repeatedly and thus be stuck in POWERED state.
> > > > - Charge-only cables (missing D+/D- lines): the device would never =
enter
> > > >   POWERED state as the HC would not see any pullup.
> > > >
> > > > What's the status quo?
> > > > We do have error logs such as "Cannot enable. Maybe the USB cable i=
s bad?"
> > > > to flag potential setup issues, but there's no good way to expose t=
hem to
> > > > userspace.
> > > >
> > > > Why add a sysfs entry in struct usb_port instead of struct usb_devi=
ce?
> > > > The struct usb_device is not device_add() to the system until it's =
in
> > > > ADDRESS state hence we would miss the first two states. The struct
> > > > usb_port is a better place to keep the information because its life
> > > > cycle is longer than the struct usb_device that is attached to the =
port.
> > > >
> > > > Signed-off-by: Roy Luo <royluo@google.com>
> > > > ---
> > >
> > > > diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> > > > index e23833562e4f..110143568c77 100644
> > > > --- a/drivers/usb/core/hub.h
> > > > +++ b/drivers/usb/core/hub.h
> > > > @@ -84,8 +84,10 @@ struct usb_hub {
> > > >   * @peer: related usb2 and usb3 ports (share the same connector)
> > > >   * @req: default pm qos request for hubs without port power contro=
l
> > > >   * @connect_type: port's connect type
> > > > + * @state: device state of the usb device attached to the port
> > >
> > > This member is essentially a duplicate of the .child member of the
> > > usb_port structure.  That is, it points to the .state member of the
> > > child device instead of to the child device itself, but this is prett=
y
> > > much the same thing.  You could replace *(port_dev->state) with
> > > port_dev->child->state.
> > >
> > Alan, thanks for the quick response!
> > Yes, port_dev->state is indeed the same as port_dev->child->state. Howe=
ver,
> > I still add port_dev->state because port_dev->child won't be assigned u=
ntil
> > the corresponding usb_device is in ADDRESS state.
> > I wish I can assign get port_dev->child assigned earlier, but I think
> > the current design - assign port_dev->child and device_add() after ADDR=
ESS
> > state - also makes sense because there are many ways that the enumerati=
on
> > could fail in the early stage. By adding port_dev->state, I can link
> > usb_device->state to usb_port as soon as the usb_device is created to g=
et
> > around the limitation of port_dev->child.
> > I would be very happy to hear other ideas.
>
> Is there any real reason not to set port_dev->child as soon as the
> usb_device structure is created?  If enumeration fails, the pointer can
> be cleared.
>
> Alan Stern

Currently the usb core assumes the usb_device that port_dev->child points
to is enumerated and port_dev->child->dev is registered when
port_dev->child is present. Setting port_dev->child early would break this
fundamental assumption, hence I'm a bit reluctant to go this way.
