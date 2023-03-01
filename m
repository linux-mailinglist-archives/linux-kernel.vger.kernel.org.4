Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC696A6866
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCAHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCAHt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:49:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EA61D925
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:49:58 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id bo22so923043pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677656998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOgHEwNMA5/W64rG1yukDar+bLo9DgwENvRdUUr422g=;
        b=H01sVb5kjtk+NeqS6ib+5G8Z7ttJnk/mqOxIun+L5UaMp6667TgVaOyYshDGvK4Dyp
         U/5QXVY2u7g4BJP915dGeuh8M0q4Q7PhoOXu3zcpMIJFgYPexoP7YzLqQBVobmSg++jO
         +KiP7f2f3sc3RyU77e84MIv8eW9MEddNnPH2KseLLKhJwvZWHgUlZQGLCA8JHaCgHGEZ
         JV9fmm3JAI2CmB34cADITgNmhjKwlcX0Sg8uLyJZCwddnrIfdSDrZyocHbefb4ENgwyw
         otOaV7dQaPcS+WlYZ0VN6lzkFXVx4mJrTuEn+0ZTOVImHngc4ilY5vTYrLEJ/ikBcPq2
         Io+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677656998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOgHEwNMA5/W64rG1yukDar+bLo9DgwENvRdUUr422g=;
        b=1wleL9jP15oPytrnON5Q0wdyo8eXUVGkbmt7UJRtp3TJuYocgoPjBqMndyqzji0SOD
         RSUnFDUWHif2v2wAMMHjmndE40qBNeLeHHaJbXBSHTc90uUFCrmRqgBbKE3e47WUUm2e
         gFt0EeZmNaop+uM1h787wJsImsxwj66nU3i7RrfeuME4jV5IHeKVo99LR4mUugdrskFl
         37b+YAc0jRMNEZ7/HfZ4Z0Jaog9abmWCuhCOZ+ZFXE+J64B6FzYyFrFMVGrLdS4U3YDs
         iUoHBBLd8p0eemR+XujO3hTTf2XGpHP3RbkHQrpCaM+DRlOayzBwyOFlx0D81Ba9b0yF
         IsJg==
X-Gm-Message-State: AO0yUKVpFeNpw9c54oPD60OE6An8ys8MJmAEQI+KWIUI49cD9jn3gUoF
        k+BOcI1+zaycXTP1I6uqo+gEWlLOiQQkfNRDnoAkXSwQkD+kiV6p9pA=
X-Google-Smtp-Source: AK7set8xLICJGNfKNIS5UN4B2sQOEjVokpi5RUCk0Av4IXMtcSjzZ+4dUIzMf9prZPBhvUtIQE+A97hEAby4ifG2t1U=
X-Received: by 2002:a17:90b:3c08:b0:235:1fb7:393c with SMTP id
 pb8-20020a17090b3c0800b002351fb7393cmr8956126pjb.1.1677656997480; Tue, 28 Feb
 2023 23:49:57 -0800 (PST)
MIME-Version: 1.0
References: <03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com>
 <CAGETcx-KLfxKae6-Kc74gOu2fiuu+5528j_TNEaY21U3_yZO0w@mail.gmail.com>
 <0fa79232-18f7-af96-e116-a71b735a903d@gmail.com> <f13906c0-1a0c-dfa4-dcd3-96ebc82aabd8@gmail.com>
In-Reply-To: <f13906c0-1a0c-dfa4-dcd3-96ebc82aabd8@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 28 Feb 2023 23:49:21 -0800
Message-ID: <CAGETcx-0EKYBL_fQbZSUra3LrzOnV4LABUBZ_jEBmW3sdUzZPA@mail.gmail.com>
Subject: Re: Raspberry Pi 4B: Failed to create device link with soc:firmware:gpio
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 11:14=E2=80=AFAM Florian Fainelli <f.fainelli@gmail=
.com> wrote:
>
>
>
> On 2/25/2023 5:58 PM, Florian Fainelli wrote:
> >
> >
> > On 2/25/2023 4:01 PM, Saravana Kannan wrote:
> >> On Sat, Feb 25, 2023 at 7:38 AM Florian Fainelli
> >> <f.fainelli@gmail.com> wrote:
> >>>
> >>> Hi Saravana,
> >>>
> >>> Using v6.2-10217-ga93e884edf61v my Raspberry Pi 4B issues the followi=
ng
> >>> for the "extended GPIO" provider:
> >>>
> >>> [    5.969855] uart-pl011 fe201000.serial: Failed to create device li=
nk
> >>> with soc:firmware:gpio
> >>
> >> Outside of this error, is it actually breaking anything?
> >
> > There is just this warning, there does not appear to be a functional is=
sue.
> >
> >> Also, can you
> >> pull in this patch and tell me what it says? I want to know what the
> >> flags are.
> >> https://lore.kernel.org/lkml/20230225064148.274376-1-saravanak@google.=
com/
>
> Pulling in this patch results in the following being printed:
>
> [   14.866835] uart-pl011 fe201000.serial: Failed to create device link
> (0x180) with soc:firmware:gpio

I spent at least 2 hours looking at the logs and the DT files and I'm
still kinda lost.

The 0x180 means it's a DL_FLAG_INFERRED | DL_FLAG_SYNC_STATE_ONLY.
That's just fw_devlink trying to create a "proxy" link where an
ancestor of a consumer (can be several levels above consumer) creates
a SYNC_STATE_ONLY link to the supplier while we wait for the consumer
device to get added. This prevents sync_state() from being called too
early on the supplier.

There are so many includes in the dts/dtsi files that my head is
spinning. I finally found out where the soc:firmware:gpio device was
coming from (after confusing myself with gpio@7e200000 for a bit) and
where fe201000.serial was coming from. I still couldn't figure out how
the address got mapped to fe201000 in fe201000.serial -- that
generally means the parent has some address offset, but I don't see
that in DT (but it is not important for this discussion, so we can
ignore that).

Anyway, I see no supplier-consumer link between serial@7e201000 (or
any of its zero descendants) and soc:firmware:gpio (which is the node
expgpio:). So I'm very confused why we might even try to create this
sync state only device link between these two.

There are actually two times where we try to create such a link:

First attempt that actually succeeds -- but I have no idea why we even do t=
his:
[    0.100047] device:
'platform:soc:firmware:gpio--amba:fe201000.serial': device_add
[    0.100232] amba fe201000.serial: Linked as a sync state only
consumer to soc:firmware:gpio
the "amba" prefix tells us a driver hasn't been bound to fe201000.serial ye=
t.

Second attempt is the one that fails.
[   15.516166] uart-pl011 fe201000.serial: Failed to create device
link (0x180) with soc:firmware:gpio
The uart-pl011 tells us that the driver has bound to fe201000.serial.

And it fails because of this sensible check I had put up a while ago
inside device_link_add():
        /*
         * SYNC_STATE_ONLY links are useless once a consumer device
has probed.
         * So, only create it if the consumer hasn't probed yet.
         */
        if (flags & DL_FLAG_SYNC_STATE_ONLY &&
            consumer->links.status !=3D DL_DEV_NO_DRIVER &&
            consumer->links.status !=3D DL_DEV_PROBING) {
                link =3D NULL;
                goto out;
        }

So the real question is still to figure out why fw_devlink is trying
to create this device link.

So to debug this further the following would help a lot:
1. Pull the dtb from the device and then decompile it and provide me
the result. This way, I can be sure I'm not missing something and
don't have to dig through all the includes -- I forgot the exact
commands for it, but it's been shared in LKML before. Let me know if
you need me to dig this up.

2. I think a stack backtrace when these two device link attempts are
made might help me figure out why they are being created. To get these
backtraces, can you do the following please?
a. Put a WARN_ON() inside device_add() for when the device name matches:
platform:soc:firmware:gpio--amba:fe201000.serial
b. Put a WARN_ON(1) where we print "Failed to create device link..."

Feel free to dig more into 2a and 2b if you find that the stack trace
doesn't tell much -- one problem with the stack trace is that it
doesn't show the params being passed to
__fw_devlink_link_to_consumers() and __fw_devlink_link_to_suppliers()

Thanks,
Saravana
