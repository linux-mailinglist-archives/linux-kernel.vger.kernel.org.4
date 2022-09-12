Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D121A5B5A28
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiILMb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiILMb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:31:26 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6501C1E3FA;
        Mon, 12 Sep 2022 05:31:25 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id m11so4140313vkk.4;
        Mon, 12 Sep 2022 05:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=0Dx+LnkD7stFqOv+lqWr5T6SJ3eaFIY+vvAeGs5GNNY=;
        b=Z+na5+ZCq5dyAf+SvhXhrW3/pum3NVGCjZzCtVUlRRrxERQC+jBWgMYfmxuvskcC5n
         e2CYFwXNhio4R8Dts8k9RJgircAtKjCS1JjRRwuk7lrsWmcOJokJogwPYnR8ww0inpB8
         /81eD27R69nIxm7ekUzvQWDj41mdgudn1OY3W+Oe4J5kYjRYmw3TzwzIrfutTP/15fdp
         bak557ibxk1FmwhXwKSnbkOEE01+z8xX+FEXedMibdJSgCrcTQrNmUIquAktl3eluvKC
         utvDkdPtRRUHjkARs9THaO/hWmvYzMXfUrrKAJqeJBUm3jU1/Bg0gI3Jp1RjMqdtK5Tf
         Hzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0Dx+LnkD7stFqOv+lqWr5T6SJ3eaFIY+vvAeGs5GNNY=;
        b=kPEFbux+KmCFilkKAgUy6OEtSz8hn4Q0bfoECh6VbxKpUE8NPSzQiCVGvddblIZQcf
         tJzYHzgw88STBR1RKN+jTq86EFlsKSOreARskyROK2MeVVeOgg7tSrmPX4hW5J5aBh5N
         0ATJyvcSiJLOAPMQR5gjwdz+kZd7uszkvPxLhgPC9WI5EOL5A4KUMwZreHIpsDmqmBGH
         si5sdyyO2ATDgKIVQl99CCyc3WgAYCl6cjW36u5r2STs0BkuffkIF9AjzW7XUPwzc/Y+
         CWn43vfz+gthjJmS9D4DDTrtHOMPWJdaPdSrtYtEpdh+kIO0jHN+8sLQ2OeayBKhmhnj
         pz0Q==
X-Gm-Message-State: ACgBeo10tAAKElDKL5+wT0SMr0pyLlR4X+zRh5twIjOyaoNwPcWwvbgB
        t0wHsJ84qzMD83mT+0ysZkXdIqNOpyxZyUm+e+4=
X-Google-Smtp-Source: AA6agR5lSQvebPJDly5QGxqJJvopJDsu3lEMB/vOmGHNrZi0yJhJndkbIOsvtx7Dmcdd3DszMpujGt/C9qw8fyMLUMs=
X-Received: by 2002:a1f:b254:0:b0:345:87e4:17fb with SMTP id
 b81-20020a1fb254000000b0034587e417fbmr8256493vkf.25.1662985884387; Mon, 12
 Sep 2022 05:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <CANXPkT6mYusYe8O0dbq3vW+24SsUZ19PqhOL+wLFRnbFXwu0Zg@mail.gmail.com>
 <CANXPkT7nOhH+5bD0ycyRBT9FKQBBszCVuWkqp4tFtVRf2+8DFg@mail.gmail.com>
 <CANXPkT5k9Pw4ka6CihyCg0oTd-32Te-ox=f3=9rtCphVgrdctA@mail.gmail.com>
 <165590120140.1149771.2257818527859865760@Monstersaurus> <4883f0a7-6a1b-31bd-33fe-db8f6dcf73fa@selasky.org>
 <CANXPkT73ssg6RRyfDtp7c_8sO60a-UT0-Y4S1_=D=M_mcLNN9g@mail.gmail.com>
 <CANXPkT4qYOYPL+F=-Pi_NbQErq9WwrR-M-BHe=gP9Ay4bSs+=w@mail.gmail.com>
 <CANXPkT5=ryAFvb1cO+Wb0CQYmytwedS2dqVTYqt2Km1fkK4w9Q@mail.gmail.com>
 <CANXPkT7vt8gq5UO4OXK2pTUyyB102ANJ5i9s92AW+a3rAioMog@mail.gmail.com> <085b9025-bc23-37d4-d430-afc432b4d783@selasky.org>
In-Reply-To: <085b9025-bc23-37d4-d430-afc432b4d783@selasky.org>
From:   =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Date:   Mon, 12 Sep 2022 21:31:13 +0900
Message-ID: <CANXPkT5YrbRUwAWU_9kaKykKF5OEvHV6Dx_HFx5UqL8DSuobGw@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, 0215yys@hanmail.net,
        =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
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

Dear Hans Petter Selasky

Thank you for your sincere replyment.
But I cannot understand what you mean.
Can you kindly explain what kind of C-program do I have to write ?

2022=EB=85=84 9=EC=9B=94 9=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 11:46, H=
ans Petter Selasky <hps@selasky.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 8/31/22 15:45, =EC=9C=A0=EC=9A=A9=EC=88=98 wrote:
> > Dear All,
> >
> > Can you share how this patch is going ?
> >
> > 2022=EB=85=84 8=EC=9B=94 18=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:5=
5, =EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =
=EC=9E=91=EC=84=B1:
> >>
> >> Dear All,
> >>
> >> Can you pay your attention to this patch ?
> >> This is a very simple modification.
> >> But, too much time has already passed since I sent the first E-mail.
> >>
> >> 2022=EB=85=84 8=EC=9B=94 3=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 9:0=
4, =EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =
=EC=9E=91=EC=84=B1:
> >>>
> >>> Dear All.
> >>> Too much time has already passed since I first sent this Email.
> >>> Can you share how this patch is going ?
> >>>
> >>> 2022=EB=85=84 6=EC=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6=
:11, =EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=
=B4 =EC=9E=91=EC=84=B1:
> >>>>
> >>>> Dear Kieran Bingham
> >>>>
> >>>> I sent E-mail again by Linux terminal by using the command " ... git
> >>>> send-email .."
> >>>> I believe that you will surely get the diff file.
> >>>>
> >>>> Thank you
> >>>>
> >>>> 2022=EB=85=84 6=EC=9B=94 22=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 =
10:12, Hans Petter Selasky <hps@selasky.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> >>>>>
> >>>>> Hi Kieran,
> >>>>>
> >>>>> The consumed variable should not be negative. This bug has been the=
re
> >>>>> since the beginning of the GIT at Linux from what I can see.
> >>>>>
> >>>>> +1
> >>>>>
> >>>>> --HPS
> >>>>>
> >>>>>   From 108c6acb2cc4bc4314b96f6f254a04b2873a096c Mon Sep 17 00:00:00=
 2001
> >>>>> From: YongSu Yoo <yongsuyoo0215@gmail.com>
> >>>>> Date: Sun, 22 May 2022 04:53:12 +0000
> >>>>> Subject: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffe=
r.c
> >>>>>
> >>>>> Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
> >>>>>
> >>>>> The function dvb_ringbuffer_pkt_next in
> >>>>> /linux-next/drviers/media/dvb-core/dvb_ringbuffer.c,
> >>>>> which searches the idx of the next valid packet in the ring
> >>>>> buffer of the ca->slot_info[slot].rx_buffer at
> >>>>> /linux-next/drivers/media/dvb-core/dvb_ca_en50221.c,
> >>>>> has the following problem.
> >>>>> In calculating the amounts of the consumed address of the ring
> >>>>> buffer, if the read address(rbuf->pread) of the ring buffer is
> >>>>> smaller than the idx, the amounts of the searched address
> >>>>> should be (idx - rbuf->pread),
> >>>>> whereas if the read address(rbuf->pread) of the ring buffer is
> >>>>> larger than the idx, the amounts of the consumed address should
> >>>>> be (idx - rbuf->pread + rbug->size). But there exists an
> >>>>> incorrect logic that the rbug-size was not properly added on
> >>>>> (idx - rbug->pread) in the later case. With this commit, we
> >>>>> fixed this bug.
> >>>>> ---
> >>>>>    drivers/media/dvb-core/dvb_ringbuffer.c | 4 +++-
> >>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/media/dvb-core/dvb_ringbuffer.c
> >>>>> b/drivers/media/dvb-core/dvb_ringbuffer.c
> >>>>> index d1d471af0636..7d4558de8e83 100644
> >>>>> --- a/drivers/media/dvb-core/dvb_ringbuffer.c
> >>>>> +++ b/drivers/media/dvb-core/dvb_ringbuffer.c
> >>>>> @@ -335,7 +335,9 @@ ssize_t dvb_ringbuffer_pkt_next(struct
> >>>>> dvb_ringbuffer *rbuf, size_t idx, size_t*
> >>>>>                  idx =3D (idx + curpktlen + DVB_RINGBUFFER_PKTHDRSI=
ZE) % rbuf->size;
> >>>>>          }
> >>>>>
> >>>>> -       consumed =3D (idx - rbuf->pread) % rbuf->size;
> >>>>> +       consumed =3D (idx - rbuf->pread);
> >>>>> +       if (consumed < 0)
> >>>>> +               consumed +=3D rbuf->size;
> >>>>>
> >>>>>          while((dvb_ringbuffer_avail(rbuf) - consumed) >
> >>>>> DVB_RINGBUFFER_PKTHDRSIZE) {
> >>>>>
> >>>>> --
> >>>>> 2.17.1
>
> Maybe it will help if you write a test C-program to show the bad numbers
> computed?
>
> --HPS
