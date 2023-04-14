Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5728A6E25A9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjDNO07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjDNO0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:26:33 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32834C64A;
        Fri, 14 Apr 2023 07:25:56 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54fe82d8bf5so33445747b3.3;
        Fri, 14 Apr 2023 07:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482354; x=1684074354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r62Bg7taKN8ueg/SOljV3ygfYWsD/yfJ63Sah7gnkPQ=;
        b=NfzXTOron1qvqMumHJ8TbkBENXe0W8hViQyxOSbW5oiFrYwBM5Y1PvUiLuocP0FSju
         T/ZspDaJcRa4CmndQUDdbcsp5buNAYI3giOj7fxUJYss5yQdhJp7XUK5lev34FvbBYo/
         AP9pcycJDxMDEKZ5P/PBeXcVv8iIPLCYOVQQg/EmVescSCpbmzeV9oeKqjXnDMeUGrsM
         ny9JSyRL39rWp3133GJtLcfXE4q/AGC+1ZpSJcN4wkxk2FwOvGHxRgVwBK1MUxVWKmV3
         rz+7FkQvIzwWKlQ6vnSslruQgwY1wd+BgagHkS+H3rGhKCVxZgSZL7wTELmSJ8EAJkY0
         b9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482354; x=1684074354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r62Bg7taKN8ueg/SOljV3ygfYWsD/yfJ63Sah7gnkPQ=;
        b=SgCcDQ6GHoetBsKaGHmQ//+I8f99aglPMNrzszYJyZYBsLC/tWxU+DAZW9bV0jvjMi
         xpBLN8IbDQholqb8rpWxXO8CyU5HMHTMsT861QmAj6vMc1G6FVVhLW59xkl8HuNfvV0t
         YGNw9WFTfkAD/7fiuuy6q0t/taDw5hdXU/+SbXw3qNIvH6woAK/I5MVIA8VOE+EMu7CB
         X9EXBh8v7R4VcnSattPWIDET+Gs/WGan+QWI3z87fcrpdwTKeDmczYlEl6kRQjRN7sTf
         VxtZgmKcj0zJnYb6ROiif5zh0YgY0j2RjmG4gLC2pJxBFmf9D87/Jpx9VChFvZFhpJvf
         t96Q==
X-Gm-Message-State: AAQBX9fDtWgG1BW6Wpk26K7lYUvj0AV2Dvj7d223/ia/t149/DC5KoWg
        KgqBBSre1FskGlmcI+4UyNHGDB/lzLYsT0RHFTithvtrMlc=
X-Google-Smtp-Source: AKy350bl4fFEJ+FQv7ax0cbWG0isQYHV1KwfJdd9yo2Es773geHkplzj7s0xPtYDYCmWURb4N/814xV6jEUFYsp4aHk=
X-Received: by 2002:a81:eb14:0:b0:54f:b986:9c60 with SMTP id
 n20-20020a81eb14000000b0054fb9869c60mr3688061ywm.7.1681482354504; Fri, 14 Apr
 2023 07:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+haVH-4Hgsz0PpTgUSW1pX4XxwxXwEd7nLVb0sFFwQwCg@mail.gmail.com>
 <CAPDUAqPVDi4TgAja92tMqMp6rGAyC-eabS_6+W0zThKfsZAxGA@mail.gmail.com>
In-Reply-To: <CAPDUAqPVDi4TgAja92tMqMp6rGAyC-eabS_6+W0zThKfsZAxGA@mail.gmail.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Fri, 14 Apr 2023 19:55:43 +0530
Message-ID: <CAHhAz+g-Mtz3xhnU9hDHG9DzBuBM_e9_4n0BSRpALRJcyLF0LQ@mail.gmail.com>
Subject: Re: ALSA: arecord : silennce recorded as 0x80
To:     Luke Koch <lu.ale.koch@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        linux-sound@vger.kernel.org
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

On Fri, Apr 14, 2023 at 3:45=E2=80=AFPM Luke Koch <lu.ale.koch@gmail.com> w=
rote:
>
>
> On Thu, Apr 13, 2023 at 3:50=E2=80=AFPM Muni Sekhar <munisekharrms@gmail.=
com> wrote:
> >
> > Hi all,
> >
> > I recorded the silence on the default audio card by running "arecord
> > -d 5 test.wav."
> >
> > Once it exited, I checked the contents by running "hexdump test.wav,"
> > and I see that silence is recorded as a sequence of 0x80 instead of
> > 0x00.
> >
> > 0000000 4952 4646 0024 8000 4157 4556 6d66 2074
> > 0000010 0010 0000 0001 0001 1f40 0000 1f40 0000
> > 0000020 0001 0008 6164 6174 0000 8000 8080 8080
> > 0000030 8080 8080 8080 8080 8080 8080 8080 8080
> > 0000040 8080 8080 8080 8080 8080 8080 8080 8080
> > ...
> >
> > What might be the reason for silence being recorded as 0x80 instead of =
0x0?
> >
> >
> > --
> > Thanks,
> > Sekhar
>
> This is what I found after Googling a bit:
> Since you didn't specify a format, arecord defaults to 8 bit format (U8).
> Being unsigned, a negative value for maximum negative amplitude is imposs=
ible. Therefore the value is given a bias of 128,
> making 0 the maximum negative amplitude, 255 the maximum positive, and 12=
8 the center point (or silence).
Thanks for the clarification.
So I tried passing signed 8-bit format (S8), and then the arecord died
immediately, as mentioned below.

$ arecord -f S8 test.wav
Recording WAVE 'test.wav' : Signed 8 bit, Rate 8000 Hz, Mono
arecord: begin_wave:2481: Wave doesn't support S8 format...

For other format S16_LE, the arecord hangs for a few seconds and
throws an I/O error.

$ arecord -f S16_LE test.wav
Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
arecord: pcm_read:2032: read error: Input/output error

I am not sure why recording works only on the default format of U8.
For other formats, the record either dies immediately or hangs for a
timeout and then throws an I/O error. Any ideas about this behaviour?

>
> Best Regards,
> Luke
>
>
>


--=20
Thanks,
Sekhar
