Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959176F1134
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 07:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbjD1FAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 01:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjD1FAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:00:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A50E269F;
        Thu, 27 Apr 2023 22:00:43 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2a8ba5f1d6bso91398621fa.2;
        Thu, 27 Apr 2023 22:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682658040; x=1685250040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnYDs5O+lpcMObRSDdsk44BWcyPiz0zcPcKC4GaBYVY=;
        b=gkFTg/cXXXB+sw6EP6iP4NIjEbu5k0eqG3zHM9oe+HyO14Jmr5iHR57egC5GaboEzK
         Hrc6VKxGFeEZhkUXk0kY2ljpPUmejNxNRfSSCbwKs0Fz7xSg+/q6T/PP1XuuecuxJx/k
         TdDmvePdTrvCh74I66JSqz32RpTp4eQbygwDLaejhs0gbQiINS8uH76u8pD5FmX39F1E
         DAEuhYObU3RLwkrzsJpEJoXt7o306gvomsiHoUwnmvNNF/O6MsTvzclyApxtlWGQRuw5
         ZuJshfit9NRD351q6yXyBFgf18ziafsIWcpMHhxa1yEW8dfxKIIfz3W49QVMLT31cOnf
         tzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682658040; x=1685250040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnYDs5O+lpcMObRSDdsk44BWcyPiz0zcPcKC4GaBYVY=;
        b=PSIf0zLtLSUnZRhc5EviXqZYx/SjZ7lY/lUqApNU0wbayg7S3Hnzw/wmA7FVBzWCEy
         bmED+o+rlw8SdHTLVzHVjZjj2OT9dnR86tgLh/uNHYiTEXgwu1rYozqjO3q6FMHoKDoV
         G801S8N87B/G8waK1SFcxS6kM0QczrI8UQXhqhyC2Q/KaQK86Kl3BYVhMp2uhWaSWRQ1
         nkXrGcyJiePh9hMnEMFt0Y6f5mgjEdTExW7qonECAMVr0ZTe+r9TVZ0kjopn0oykscuX
         rKOwsSS7oMe4PBy3Is31904AyX9Wcdsm2AcvTMKgRiQUJEQ7Gg/w08OAse2QU6IN5796
         GT6w==
X-Gm-Message-State: AC+VfDwl4Re07lS2hCmzyA8WO7YtM9c1TEEtiCj7gkHdlR8l/3WCRqv8
        TmuMXoKGcgznjcOeeYEJmpy5MZ4kiooD3OXfW5ybYuBEbVm2re5K
X-Google-Smtp-Source: ACHHUZ4MNy+/Dtb2UrcTh7ZDuR0U++EWSFuekrVl2ZAxVG/67UxwACMHzMpdGCMCAVue5SSa61YOJVqc2KKkYOXI6Yc=
X-Received: by 2002:a2e:9987:0:b0:2a8:a5b8:185a with SMTP id
 w7-20020a2e9987000000b002a8a5b8185amr1236090lji.10.1682658039733; Thu, 27 Apr
 2023 22:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230323013655.366-1-k1rh4.lee@gmail.com> <CAJkuJRjFCXkS+osc8ezpAw0E2W7WMAJnnxMt_cs4deqgm5OzHw@mail.gmail.com>
 <2023042702-shuffling-tweet-d9f6@gregkh>
In-Reply-To: <2023042702-shuffling-tweet-d9f6@gregkh>
From:   sangsup lee <k1rh4.lee@gmail.com>
Date:   Fri, 28 Apr 2023 14:00:04 +0900
Message-ID: <CAJkuJRiJYLL2pxdRF_R_FZ8_yHGQziyhSmecypMBX04WFdv86Q@mail.gmail.com>
Subject: Re: [PATCH v2] misc: fastrpc: Fix a Use after-free-bug by race condition
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize for recognizing the email in the TOP POST format. I missed
the comment in the previous email.

2023=EB=85=84 4=EC=9B=94 27=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:52, G=
reg Kroah-Hartman <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> On Thu, Apr 27, 2023 at 06:29:16PM +0900, sangsup lee wrote:
> > Is there any comment for this issue?
>
> What issue?
>
> > (reference: https://www.spinics.net/lists/kernel/msg4731408.html)
>
> Please use lore.kernel.org links, we have no control over any other
> random email archive .
>
> And the above link just points to this proposed patch.
>
> >
> >
> > 2023=EB=85=84 3=EC=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 10:=
37, Sangsup Lee <k1rh4.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > From: Sangsup lee <k1rh4.lee@gmail.com>
> > >
> > > This patch adds mutex_lock for fixing an Use-after-free bug.
> > > fastrpc_req_munmap_impl can be called concurrently in multi-threded e=
nvironments.
> > > The buf which is allocated by list_for_each_safe can be used after an=
other thread frees it.
>
> How was this tested?
>

I was unable to configure the environment in which this code is running.
Therefore, I could not go through dynamic testing for the related issue.
However, I found vulnerabilities in similar types of functions
in other drivers in the mobile environment, so I think this code is
also problematic.

> > >
> > > Signed-off-by: Sangsup lee <k1rh4.lee@gmail.com>
> > > ---
> > >  V1 -> V2: moving the locking to ioctl.
> > >
> > >  drivers/misc/fastrpc.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > > index 93ebd174d848..aa1cf0e9f4ed 100644
> > > --- a/drivers/misc/fastrpc.c
> > > +++ b/drivers/misc/fastrpc.c
> > > @@ -1901,7 +1901,9 @@ static long fastrpc_device_ioctl(struct file *f=
ile, unsigned int cmd,
> > >                 err =3D fastrpc_req_mmap(fl, argp);
> > >                 break;
> > >         case FASTRPC_IOCTL_MUNMAP:
> > > +               mutex_lock(&fl->mutex);
> > >                 err =3D fastrpc_req_munmap(fl, argp);
> > > +               mutex_unlock(&fl->mutex);
>
> Are you sure you can call this function with the lock?  If so, why isn't
> the mmap ioctl also locked?

I am convinced that FASTRPC_IOCTL_MUNMAP can lead to a race condition bug.
However, as I mentioned in patch v1, I am not an expert in fastrpc.
I worried about the side effects of the code I suggested.
So, I asked you to recommend which code to use, and this is the code
that was recommended to me.
And I didn't check the mmap function because I couldn't find a bug in mmap.

>
> thanks,
>
> greg k-h
