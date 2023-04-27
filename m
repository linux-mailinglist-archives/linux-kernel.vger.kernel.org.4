Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEB86F0533
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbjD0Lw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjD0Lw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:52:27 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D922698;
        Thu, 27 Apr 2023 04:52:26 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2a8b1b51dbdso79629741fa.0;
        Thu, 27 Apr 2023 04:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682596344; x=1685188344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5r6ZWi9BBJ5A0FizJsC82K01BkpGtpS/NHxJTUoa3U=;
        b=jWSrhlnxatrRKNL6zRmuH4Q0E75QRlJUDtxxcDGFg4acX0GRE74ZBnSIZNXS92EEaB
         Qj+KLmPfIV62N/44AavFcmpzc7oq3aZuaPaAyqVtmMXwMvjYbVhPq4OJogARvnTzAUxO
         C5gs+kH/T3mIKDUGWAomumrE4kl/GQI4u+yTXCJrAAnb7SSO9Js6d7qHmQdEA3AEqV+H
         AbhDlRDpFj7Pk1K43arr2+El2bawE9F4nZxSO9mB+eXREMehua2BdaTjw8KbyWlr74Sn
         d9NXHMFmEZmzw5ib044rIIE9vxDOZKekyzCXs0cs3RfezmBNXlv4avk0H2/X9ZkWmXzo
         C9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682596344; x=1685188344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5r6ZWi9BBJ5A0FizJsC82K01BkpGtpS/NHxJTUoa3U=;
        b=K9cul5K4OUq5x/AeK++6Xhqf/+MdU0Jw9eQR0r0PMVYrURpGwof9WkD3ICox/usBLG
         HVL6rSq2iwjdrwd4LojQb+qF2VCrQDaYFuDsVIQLQZqQDp0TtLmyWnUatSMQWIFFQ/Eh
         c6cFMER2hhp68cPqpobcFbXQ4cDJ4ohAw92sFgHEWsy4i/lFLdn39Lg5bAj4XHYnVIMd
         EHb5X8MHnfwvtc4nt9aQGfpppNabGGbRws7MOcbiL64E6J/Io29HhSJkRF+P3NxDNNaX
         1B8jA30L0gtH9FuBP9smK25Dz5SowO1LpSx5L02X4e/c41moH1kvQYDVtzdyACP70BM1
         3PYw==
X-Gm-Message-State: AC+VfDxrKHbQpbAKrg2k0r4Jf+2gHp7hGvUKKKtUZfIH3Pnd0hBJo5kY
        rjJX7RzPntE8pjya7hyUorHRqZF4nwhG7wqM4JU=
X-Google-Smtp-Source: ACHHUZ42uXCU7jrfCUcLudfxdNz7wHRJC7IWs6hLboDDRvfyVfImc7Hsjq3dx98X84fE38cfQSz8QoORBGNgofRmRrY=
X-Received: by 2002:a2e:80c1:0:b0:2a8:c333:1886 with SMTP id
 r1-20020a2e80c1000000b002a8c3331886mr573082ljg.6.1682596344236; Thu, 27 Apr
 2023 04:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230323013655.366-1-k1rh4.lee@gmail.com> <CAJkuJRjFCXkS+osc8ezpAw0E2W7WMAJnnxMt_cs4deqgm5OzHw@mail.gmail.com>
 <2023042702-shuffling-tweet-d9f6@gregkh>
In-Reply-To: <2023042702-shuffling-tweet-d9f6@gregkh>
From:   sangsup lee <k1rh4.lee@gmail.com>
Date:   Thu, 27 Apr 2023 20:51:48 +0900
Message-ID: <CAJkuJRhqU++S+xYPDFDyxawfz_ePGJ0oTk-ZZg8N8BSfKcSdDA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I reported fastrpc bug in
Feb,2023.(https://lore.kernel.org/lkml/20230216014120.3110-1-k1rh4.lee@gmai=
l.com)

And Srinivas recommended this patch code for patch v2.
That's why I sent this patch v2 however, I haven't received any reply
after that.

I just want to know the next step for patching this code.
Should I just keep waiting ? Or Please let me know if I need to
provide you with more information.

(Ps. I'm sorry, i re-send this reply because of missing text-mode )

Best regards.

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
>
> thanks,
>
> greg k-h
