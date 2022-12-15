Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D43364E283
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiLOUop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLOUom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:44:42 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AB24A5AE;
        Thu, 15 Dec 2022 12:44:41 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id fc4so1363591ejc.12;
        Thu, 15 Dec 2022 12:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EpH1P3RlFxyKcBx3qkk+aQuDUHsrkTX+VkNJj0MZ9nk=;
        b=AgXfi8McxnsNqZ8GZGCsYsgQTdu7EDDMtLK28lLAUziqm8EPL6B8vLha8g1i3lF0O3
         PNfsK35HiYK4IUkDDth7EVp04YQYwDKAFbL7l35TEJMlDAUYy0RbQSEz/uxuX3xalmhi
         YeU1Wc866Omt2a6x/urZHGckziTcE0nl4ECIbu3cH3oGc/ytGU1b2eqkHqE/JIN8LhYM
         SjdNs5Azz2+FPc6ihBCcY7vCiWJQDfl+7nw4RVkxwFcuDbtqGOArpaDpFf2qSUHRF2Ns
         eAGfJ0yDolA2kjcl+vL9ShLqCPi90j40DH4Hk6UD36GTl/TT0aNoH7yEkOlzgcYpDnHM
         xfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpH1P3RlFxyKcBx3qkk+aQuDUHsrkTX+VkNJj0MZ9nk=;
        b=AuQPSrCN3oz6YuQ7e9Ais2LW7+cfRNgbLY9zbu1XcRxf4qPixBWTc52dTml7z0rAFh
         zeokKgvGrtgmKb7+cqdqp2UmJRLLXbIRSAzukS1poAeGhywSagc9e0xbrujkuYR7RpzT
         u2uVIxoKi6C6nGJwO6ZuNSYsrKgq4UsbkePZ3EDUT2t0EbI8Gy+pxd8GW65rwU3G7dGR
         3biCQSEC30K76fl1BRwHGCe1p6pJyExfKnesYCOsnbaZfHy4gwfry+p6tzL5L184t1r5
         fzmq8bf3LnVc1z/if+PxTd1gkBpRuiz+emNwJRw0beDUWYOB8uAxmmhrPPzBlVlqU4dw
         p8PQ==
X-Gm-Message-State: ANoB5pmcRdlIBLoBakpMFFzZ9VU1OFBEzx4KKnCM2yhXjb5GCWQfi8w3
        dICaNkIYBzlce7Cgp0+X78XJOJaila88c1iAi0kKr9NL1JY=
X-Google-Smtp-Source: AA0mqf4syn4QkydfKh4/1mkewiJ/X+OZHLDFxoQMOKXTJQVzy8lgz6F901sz0OOKMDtbeceZiP3PE5iZbuGAu7vB1fQ=
X-Received: by 2002:a17:906:5dcd:b0:7c1:80c2:4b69 with SMTP id
 p13-20020a1709065dcd00b007c180c24b69mr950458ejv.75.1671137080032; Thu, 15 Dec
 2022 12:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20221205210354.11846-1-andrew.smirnov@gmail.com>
 <20221205210354.11846-2-andrew.smirnov@gmail.com> <CADyDSO6EBuKNZFTvuuhS9VM+dy8t8HOcHyodiQR8o_uXd8gXww@mail.gmail.com>
In-Reply-To: <CADyDSO6EBuKNZFTvuuhS9VM+dy8t8HOcHyodiQR8o_uXd8gXww@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 15 Dec 2022 12:44:28 -0800
Message-ID: <CAHQ1cqE17T+8Jvo1RnQ=KB77-nf9xBJFq+h6SQDJCmbUXG=GdA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] HID: uhid: Don't send the report ID if it's zero
To:     David Rheinsberg <david.rheinsberg@gmail.com>
Cc:     linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

)

On Mon, Dec 12, 2022 at 7:23 AM David Rheinsberg
<david.rheinsberg@gmail.com> wrote:
>
> Hi
>
> On Mon, 5 Dec 2022 at 22:04, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> >
> > Report ID of zero is a special case handling ID-less reports and in
> > that case we should omit report ID from the payload being sent to the
> > backend.
> >
> > Without this change UHID_DEV_NUMBERED_{FEATURE,OUTPUT}_REPORTS doesn't
> > represent a semantical difference.
> >
> > Cc: David Rheinsberg <david.rheinsberg@gmail.com>
> > Cc: Jiri Kosina <jikos@kernel.org>
> > Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Cc: linux-input@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-usb@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  drivers/hid/uhid.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > index 2a918aeb0af1..7551120215e8 100644
> > --- a/drivers/hid/uhid.c
> > +++ b/drivers/hid/uhid.c
> > @@ -273,11 +273,11 @@ static int uhid_hid_get_report(struct hid_device *hid, unsigned char rnum,
> >  }
> >
> >  static int uhid_hid_set_report(struct hid_device *hid, unsigned char rnum,
> > -                              const u8 *buf, size_t count, u8 rtype)
> > +                              u8 *buf, size_t count, u8 rtype)
> >  {
> >         struct uhid_device *uhid = hid->driver_data;
> >         struct uhid_event *ev;
> > -       int ret;
> > +       int ret, skipped_report_id = 0;
> >
> >         if (!READ_ONCE(uhid->running) || count > UHID_DATA_MAX)
> >                 return -EIO;
> > @@ -286,6 +286,15 @@ static int uhid_hid_set_report(struct hid_device *hid, unsigned char rnum,
> >         if (!ev)
> >                 return -ENOMEM;
> >
> > +       /* Byte 0 is the report number. Report data starts at byte 1.*/
> > +       buf[0] = rnum;
> > +       if (buf[0] == 0x0) {
> > +               /* Don't send the Report ID */
> > +               buf++;
> > +               count--;
> > +               skipped_report_id = 1;
> > +       }
> > +
>
> In HID core, the buffer is filled by a call to hid_output_report() in
> __hid_request(). And hid_output_report() only writes the ID if it is
> non-zero. So your patch looks like it is duplicating this logic?

It would be in this scenario. But then I think it also means that
USBHID will incorrectly strip an extra byte of the payload if it's
zero for reports that don't have a report id, right? So maybe the fix
for this is to get rid of payload adjustment in set/send paths in
USBHID and move the adjustment to hidraw?

> In which scenario is the report-ID not skipped exactly?

The call chain in my use case is as follows:

hidraw_ioctl(HIDIOCSFEATURE) -> hid_hw_raw_request() ->
uhid_hid_raw_request() -> uhid_hid_set_report()

>
> Regardless, if you want to mess with the buffer, you should do that
> after the memcpy(). I don't see why we should mess with the buffer
> from HID core, when we have our own, anyway.
>

I was just mimicking code from USBHID, to make it clear it served the
same purpose, that

buf[0] = rnum;

isn't strictly necessary and could be dropped.
