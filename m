Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CB063A6E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiK1LPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiK1LO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:14:56 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7E01B791
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:14:55 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3a7081e3b95so101950067b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOjBP/a3tIfO/JuYbG6N9UwdTZiM5SS4BwherX0QzWg=;
        b=T/MhjgcwIgu3mLxG3naRtnBkvr/vmkN4Rnv0Z3LDKgmKFB9uXCO0XqAV3a7Ig0HWfF
         rmzLQTL78ffj0rT0F6pgKffsqR43UCBxVTJ3jcYzqoxpfj4FjLw+UIU5hsVqI0WVorTF
         Ldri2+KKn061eMX5AAfca1g4KEGhDYFEcRsqtovZTJ8HhBLvcGuYgoX40T5kjkLgFmlu
         xOKlTSRRkCkOtZxDd6/t2LU7jzLjW0+DEY7FFUgQ8mQB4V64TVv1M5cPyvlepDs9/Bwe
         4Y2h3YmBrhquUT7iAA1UQRbpVrEniNkM2NpM846W9yglUnNzPehzmSeF+93IbEW1p0iG
         +h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOjBP/a3tIfO/JuYbG6N9UwdTZiM5SS4BwherX0QzWg=;
        b=kCcbLWvb1bWTKCGOnPwhocHVDwRBWbmpUHsBD/l5U2JtXTxDV6QK9VyehVNNqo1zkI
         0DeGP8KEVl+ZWpzmNwwOr50gjqSDQ+ozW2HIeJi/c6rTFRRhfBI7a8q3ER+SDoXL/9Un
         ntZCuytrAE4utoskdM1dDyOte/a2UNhZisBiQ1h0ii7zgAiKb52ks+E+AfIcqIRCJ0Mq
         DCq9SN7kbVPxuK9RKL7INqsDukHf0qV/mQOt9GYk1QUQk0GKzvQ46HET4y1p9BfQfjVi
         61y05ti7k13YOkxvjlU2m1CcymI7tY1j1vNoUFn8bW2mUnFVSDxvxMWsAEtElwzg7Ddq
         nEPA==
X-Gm-Message-State: ANoB5pkD2JTPvGkjn5IlJTL/sDYzJWBjnlQj3cGXZyuVrinm+w0w1jua
        QRTKr01UUt33nv2+KQxzl+4FfMDo0r6wWJ91ZD4=
X-Google-Smtp-Source: AA0mqf5Nf/GNUDk7nPuo0hMGqx4AAGxuFJY2dsu/B/Rd4MDVR8tULlurXgag+5Rh0H3yTvm0mbJy7VwwjmnNi2A6kuQ=
X-Received: by 2002:a81:4a09:0:b0:38e:b5bc:e996 with SMTP id
 x9-20020a814a09000000b0038eb5bce996mr48998865ywa.493.1669634094886; Mon, 28
 Nov 2022 03:14:54 -0800 (PST)
MIME-Version: 1.0
References: <20221125163748.1288942-1-ckeepax@opensource.cirrus.com>
 <20221125163748.1288942-2-ckeepax@opensource.cirrus.com> <CABDcavbtBBU7ySPK32104nZB5RHf2=LFuOOYOF-Ze1EDoM+etw@mail.gmail.com>
 <20221128094829.GH105268@ediswmail.ad.cirrus.com>
In-Reply-To: <20221128094829.GH105268@ediswmail.ad.cirrus.com>
From:   Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Date:   Mon, 28 Nov 2022 12:14:43 +0100
Message-ID: <CABDcavZy0xki9BRr350aV3Mv1NGe3hDTSGi2NY30T3brTmnzQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: cs42l51: Correct PGA Volume minimum value
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        james.schulman@cirrus.com, david.rhodes@cirrus.com,
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

El lun, 28 nov 2022 a las 10:48, Charles Keepax
(<ckeepax@opensource.cirrus.com>) escribi=C3=B3:
>
> On Sat, Nov 26, 2022 at 12:15:10PM +0100, Guillermo Rodriguez Garcia wrot=
e:
> > El vie, 25 nov 2022 a las 17:37, Charles Keepax
> > (<ckeepax@opensource.cirrus.com>) escribi=C3=B3:
> > >
> > > The table in the datasheet actually shows the volume values in the wr=
ong
> > > order, with the two -3dB values being reversed. This appears to have
> > > caused the lower of the two values to be used in the driver when the
> > > higher should have been, correct this mixup.
> > >
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > >
> > > No changes since v1.
> > >
> > >  sound/soc/codecs/cs42l51.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
> > > index 51721edd8f53c..e88d9ff95cdfc 100644
> > > --- a/sound/soc/codecs/cs42l51.c
> > > +++ b/sound/soc/codecs/cs42l51.c
> > > @@ -143,7 +143,7 @@ static const struct snd_kcontrol_new cs42l51_snd_=
controls[] =3D {
> > >                         0, 0xA0, 96, adc_att_tlv),
> > >         SOC_DOUBLE_R_SX_TLV("PGA Volume",
> > >                         CS42L51_ALC_PGA_CTL, CS42L51_ALC_PGB_CTL,
> > > -                       0, 0x19, 30, pga_tlv),
> > > +                       0, 0x1A, 30, pga_tlv),
> >
> > The original patch where this control was added [1] already used 0x1A,
> > however this was later changed to 0x19 in [2]. Your patch now reverts
> > that change. Does this mean [2] was incorrect? If that is the case,
> > shouldn't the commit message for this patch mention that it fixes [2]
> > ?
> >
> >  [1]: https://lore.kernel.org/all/20200918134317.22574-1-guille.rodrigu=
ez@gmail.com/
> >  [2]: https://lore.kernel.org/all/20220602162119.3393857-7-ckeepax@open=
source.cirrus.com/
> >
>
> Hmm... good digging, I didn't realise it was me who broke that.
> Apologies in that chain I went around and checked a bunch of SX
> controls to make sure they matched the datasheets, but it seems
> I got a bit confused by the weird ordering of the values in the
> datasheet. Since you have hardware would you be able to check,
> before we merge this revert? A simple check that writing 0 to the
> control sets the register value to 0x1A and writing 30 sets the
> register to 0x18 would suffice.

Just checked. The values are correct after applying the patch:

$ amixer cset name=3D'PGA Volume' '0','0'
$ i2cget -y -f  2 0x4A 0x0A
0x1a
$ i2cget -y -f  2 0x4A 0x0B
0x1a
$ amixer cset name=3D'PGA Volume' '30','30'
$ i2cget -y -f  2 0x4A 0x0A
0x18
$ i2cget -y -f  2 0x4A 0x0B
0x18

BR,

Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
