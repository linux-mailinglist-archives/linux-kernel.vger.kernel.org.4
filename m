Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5F96F3174
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjEANQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEANQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:16:48 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BF6138
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 06:16:46 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-430306f2196so1981128137.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682947005; x=1685539005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbXEvFB7fjq+XNje0q8/whu20PA7ZnvvxDaqHqn67jk=;
        b=H2zXZDG6tXxVQ9f9vbGaovdxaTuwv0q6kVEYTgagLqYRRHSwKdbTjTl8oLJ8VwNgUp
         z5mJufct1ITHg4Dv5LQfomDazboiwolJap+/qE5fkHdISkNr14PyuF9skfwkwX0eBhcr
         LknF8vxFQO3VT3Gp9SZd+M8cgfAVD4r4sGu0AYaxBG2+G8mObc5s+x0uLiVotgtyGygx
         vO7rTq5U13UEsRYeFqpekJtvUo5MptHQcTO4w3UPjMq/Vrlhl6JpJmIdKywjTiQtyUnV
         dYqW5ZIzbq7p1S3GZXW+z67PzGbUR8kJ1tkMdwWSY2dZJ9Cme7j2ATUwH4yApjWrQnRG
         X2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682947005; x=1685539005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbXEvFB7fjq+XNje0q8/whu20PA7ZnvvxDaqHqn67jk=;
        b=EazaIjEa3jWwLpNPuFc2MvmtsoSlT9G9hdIxa5Kb7vprL18/7Ibyd4sgjL3Bb0cZCq
         X3azvWyEizWbAoaeeo+ydGpNDGNreTq9timDmWplXe9aerAJbuFPvEZgbD+76alIaLWg
         +jjK91dWj2h3ljOwbnlKKgN1GZfiw6QS7hWWxjWcXne/55V8+7mXiV0cgf76q4u8NbdG
         w1XfZDk8XI6yydc45Zvm4ur42LzSBNBaACRmx+zMAhOPXqgfPYWCQw9yekw1wwTmKLkq
         DHDDgfNx/+QV9Wb6js8y2mDZi7RM/Ag6WU3v2hYWcfaicFvcd0+5Q5PoYNw7BI2PEz6g
         n1fw==
X-Gm-Message-State: AC+VfDzhinzxAY5u0GrGtNi15E0Pq4E93Ypcp+jcDuaDdShxV6+uKIsn
        PZ0HeG1H5tg+v5Hrm707O+F93E2HP3H3fKD6lvc=
X-Google-Smtp-Source: ACHHUZ6iFi8AEfQHzOY3l5qhxjS8jsu2YT5vX7WEuxTKuD680EpS7Vqj7vwUIXg9ZrkmEqwvMrVIWT9N2dzKYnjDEdg=
X-Received: by 2002:a67:ed49:0:b0:42c:9732:d17f with SMTP id
 m9-20020a67ed49000000b0042c9732d17fmr5847758vsp.1.1682947005662; Mon, 01 May
 2023 06:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
 <ZE9B4avbDtIXOu4O@debian.me> <87r0s0pnim.wl-tiwai@suse.de>
In-Reply-To: <87r0s0pnim.wl-tiwai@suse.de>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Mon, 1 May 2023 21:16:35 +0800
Message-ID: <CAAJw_ZsDdiB=b2PZydQWF2fjSULit3NWE-Bf1icBEryN-GuqUw@mail.gmail.com>
Subject: Re: linux-6.4 alsa sound broken
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Linux ALSA Subsystem Development 
        <alsa-devel@alsa-project.org>,
        Linux Regressions <regressions@lists.linux.dev>
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

On Mon, May 1, 2023 at 2:35=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 01 May 2023 06:36:49 +0200,
> Bagas Sanjaya wrote:
> >
> > On Mon, May 01, 2023 at 11:59:12AM +0800, Jeff Chua wrote:
> > > Latest git pull from Linus's tree ... playing a simple sound file wil=
l
> > > resulted in a lot of echo.
> > >
> > > Running on Lenovo X1 with ..
> > > 00:1f.3 Audio device: Intel Corporation Alder Lake PCH-P High
> > > Definition Audio Controller (rev 01)
> > >
> > > I've bisected and reverted the following patch fixed the problem.
> > >
> > > commit 9f656705c5faa18afb26d922cfc64f9fd103c38d
> >
> > Thanks for the regression report. However, where is your dmesg and/or A=
LSA log
> > when the regression occurs? What is the playback test file?
>
> Yes, in addition, which driver is used (provide the alsa-info.sh
> output at best), and which sound backend is used (pipewire, PA or
> dmix) with which application?

/proc/asound# cat cards devices hwdep pcm timers version
 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0x603e1c8000 irq 147
  1:        : sequencer
  2: [ 0- 0]: digital audio playback
  3: [ 0- 0]: digital audio capture
  4: [ 0- 3]: digital audio playback
  5: [ 0- 7]: digital audio playback
  6: [ 0- 8]: digital audio playback
  7: [ 0- 9]: digital audio playback
  8: [ 0- 0]: hardware dependent
  9: [ 0- 2]: hardware dependent
 10: [ 0]   : control
 33:        : timer
00-00: HDA Codec 0
00-02: HDA Codec 2
00-00: ALC287 Analog : ALC287 Analog : playback 1 : capture 1
00-03: HDMI 0 : HDMI 0 : playback 1
00-07: HDMI 1 : HDMI 1 : playback 1
00-08: HDMI 2 : HDMI 2 : playback 1
00-09: HDMI 3 : HDMI 3 : playback 1
G0: system timer : 10000.000us (10000000 ticks)
G3: HR timer : 0.001us (1000000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-3-0: PCM playback 0-3-0 : SLAVE
P0-7-0: PCM playback 0-7-0 : SLAVE
P0-8-0: PCM playback 0-8-0 : SLAVE
P0-9-0: PCM playback 0-9-0 : SLAVE
Advanced Linux Sound Architecture Driver Version k6.3.0.


# test playing with ...
aplay /usr/share/sounds/alsa/Side_Right.wav
Playing WAVE '/usr/share/sounds/alsa/Side_Right.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono

I'll try to capture the sound ... it's seems to just repeating every
second until the last second. So, if you just play a "beep", its ok.

>
> thanks,
>
> Takashi
