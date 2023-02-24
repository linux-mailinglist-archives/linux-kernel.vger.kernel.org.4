Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103CB6A1C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjBXMnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBXMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:43:38 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5D518158;
        Fri, 24 Feb 2023 04:43:36 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id cy6so48829538edb.5;
        Fri, 24 Feb 2023 04:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UePzHufhOw2aAtD6ipXcXM5r15ZRa509qtLQfzxCNL0=;
        b=SVop/IJtSIfVHFvQzKR2ZuvITHjZW7KC2Yq6z69oPYxvyno4y1js3twma1FkqjP+Lu
         AfgyWJyZWUy8+U+B83BemQq1sa4LNhfQIWe+8vdC6f2g1Kj/APhmZYM6r9l6+jFUvjI4
         at+SQjD6iWObRBhJ+Uvb8JKvxfT1flO2DaIkJ/FZYsCAiUPlc+M42sU+HfflReu7be6/
         W9nE0TbtpKMuSOxUTzJuLHAUde5g8hKU7RSHWtobdnH+fvj/nlJ/AjzerW3oUl/ew4Z+
         muo6YXwVVfNRxFy3+n0O54PWAnco/Xs+XnUBJxozudbSwM5pX0ssHdMDBS+fv8NcRFR4
         XTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UePzHufhOw2aAtD6ipXcXM5r15ZRa509qtLQfzxCNL0=;
        b=MbSk84Glu0rKMHyGifkT7bnsFnl/9pKz651i1cJKhDSWusWw/+Q75p6LNzSyywa7K7
         vMd85iR5qJ6m5GBliHTa++K84U/4lXWxPAHH3v/R9enn9CkZoloYownd1NhvlJRHH+Z3
         B5ZEXDGfnhEATFm+DoODx5L4v3p7smCaAWyMzOhdE0q+RjKKTY5MqJXlmDbYq0y1yHdJ
         Rrk95l7MXe3oY+WU5/2VWz9eYO6Y8jWV7ffkP5rnYca2bSGOSj7HaVbD0SiGrf2wTI2L
         yxsq9SMrb3BQTHHEMPdKG4Vn8rM1jgTrp4zLMsWpDoFg4VnQ75T7c09yiEvlpumRMxpa
         LuAg==
X-Gm-Message-State: AO0yUKUqOVNlZuPC0udLScFHQ0dIBEjdmECz/RZvVpVGttdJvMUkmItC
        rj/JU7AX9zpB/LuDdO8Vq0BaUG7L9kTxw7mq6QT339wg2Nqqfg7SG6g=
X-Google-Smtp-Source: AK7set9SlEUHGCv9tnfYwDDIOmZdJnA32FkeWE/CLGkDZfbQhRz8AmOY6bThTYtr9NQleNBJHnxKEO2k8gdjQQUvxbI=
X-Received: by 2002:a17:906:48c9:b0:878:4a24:1a5c with SMTP id
 d9-20020a17090648c900b008784a241a5cmr11063255ejt.6.1677242614533; Fri, 24 Feb
 2023 04:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20230224092044.3332374-1-void0red@gmail.com> <CAD-N9QX5i5toj8cs7DxBjYWtRGf3ZRnfTAf809sFW6iX0Ktfmw@mail.gmail.com>
In-Reply-To: <CAD-N9QX5i5toj8cs7DxBjYWtRGf3ZRnfTAf809sFW6iX0Ktfmw@mail.gmail.com>
From:   Kang Chen <void0red@gmail.com>
Date:   Fri, 24 Feb 2023 20:43:22 +0800
Message-ID: <CANE+tVq0fwuuyMmrs4yyC21s_P8w0+WUS9zYZDxwda=++YpwqA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: add return value check of kzalloc in mv_udc_probe
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dongliang,

I totally agree with you. I checked the other drivers using
status_req->req.buf structure, they free the memory when
the driver removed. But in this driver, I can't find such code. So,
as you said, it needs a devm_kazlloc instead of a kzalloc to manage
the memory and avoid a memory leak.

Thanks for your correction. I will post a new patch later.

Dongliang Mu <mudongliangabcd@gmail.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=8824=
=E6=97=A5=E5=91=A8=E4=BA=94 19:06=E5=86=99=E9=81=93=EF=BC=9A

>
> On Fri, Feb 24, 2023 at 5:28 PM void0red <void0red@gmail.com> wrote:
> >
> > From: Kang Chen <void0red@gmail.com>
> >
> > Even an 8-byte kzalloc will fail when we don't have enough memory,
> > so we need a nullptr check and do the cleanup when it fails.
> >
> > Reported-by: eriri <1527030098@qq.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217081
> >
> > Signed-off-by: Kang Chen <void0red@gmail.com>
> > ---
> >  drivers/usb/gadget/udc/mv_udc_core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/=
udc/mv_udc_core.c
> > index b397f3a84..6dd6d52de 100644
> > --- a/drivers/usb/gadget/udc/mv_udc_core.c
> > +++ b/drivers/usb/gadget/udc/mv_udc_core.c
> > @@ -2230,6 +2230,10 @@ static int mv_udc_probe(struct platform_device *=
pdev)
> >
> >         /* allocate a small amount of memory to get valid address */
> >         udc->status_req->req.buf =3D kzalloc(8, GFP_KERNEL);
>
> Hi Kang and gregkh,
>
> I think there is a memory leak in this kzalloc. It seems there is no
> deallocation for this allocated object.
>
> As the surrounding allocation statements suggest,
> we should turn kzalloc to devm_kzalloc.
>
> > +       if (!udc->status_req->req.buf) {
> > +               retval =3D -ENOMEM;
> > +               goto err_destroy_dma;
> > +       }
> >         udc->status_req->req.dma =3D DMA_ADDR_INVALID;
> >
> >         udc->resume_state =3D USB_STATE_NOTATTACHED;
> > --
> > 2.34.1
> >
