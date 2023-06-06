Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718BE7240F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjFFLdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbjFFLde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:33:34 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE66E55
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:33:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f6148f9679so5302605e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 04:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686051210; x=1688643210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IckSh74MQueoJ5CURvFmslyUftxhhsV0aZC8AlDQoww=;
        b=oHiTF4CHzKllyH7gJyKTvj+OaseWfXuUOG518E8MO8YkT7c+daHjTxrNq7JtTo4HIj
         sIg555k15pmfHPj6Tmn2H+Wv8mnGRUkJtVWqF4P/a8yLfBQ7bhaahETEeduBMAOXiJ6+
         bv+kThI9y31NPt9ezS56xrNkRZTwHVhY+iq0nGNygpFZbMUGe1aRvlNikY1KIXzodSY8
         TqIdMWABU8RwOxJKsGT1GqlBy14W3DcqjHWlrJDFbMW3ei93u/ThGhB39Yn7n5KifXru
         Y9qoogVHo7AmbI8/D3XR5n1eWRx8ZbMx2POSq2DifQP0SaOc6ZM+grwVYsQB6zgoExqf
         8Fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686051210; x=1688643210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IckSh74MQueoJ5CURvFmslyUftxhhsV0aZC8AlDQoww=;
        b=bixvYBNDMZ4AaUHpBuoMJV/VtPxlhMP8Uthk97NwbT6846MFUOXfpIo/wOd5kXHiiY
         ev4mn9cw1EcjAR2CBZOQCMu2qLqiIvP0qscTPH6fsYzCOxFKOWyZDn4W7jm++GzbRohD
         ug7LjonxF6LBqrVO4F/Uy2Xa6SbPDNbF/TLzPL+iHVxohm5gKicvSAh8ncC1XOpNY4sg
         5LHBTn+tvob/EHOUV9ACKuTZ3dz+eMXhB27duGoJKyotxBU6ZVzKt6SzDPE6IY0R9FyL
         DOt0HHrigF4324sD5ymYeee8FYmkJidNkh4JExzg9YxYiZf2RWKus1DCre7d4iab/Pfn
         QKzA==
X-Gm-Message-State: AC+VfDxtacmW5EefdMdZksCTrA/dp1uj4PSpfRW3Jih3W9Hr8g6bU3Te
        RHWfjEn1T06FZ1+2es04HDfUsWQ9+N4CEhbIkOe6UA==
X-Google-Smtp-Source: ACHHUZ5FuREvd266TUW6toyH9B6g0Ljs8zhY/WoP7EIRCvMEa3YFWytTcGBiY8JUHjm6e5b1quQaIzfRo/qYF6ruGKY=
X-Received: by 2002:a2e:9795:0:b0:2b1:dc7a:bc4e with SMTP id
 y21-20020a2e9795000000b002b1dc7abc4emr1055012lji.37.1686051210374; Tue, 06
 Jun 2023 04:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230606051323.17698-1-warthog618@gmail.com> <CAMRc=MfdusMAqfjnQTi_-DdjeLHQzywpk=zpKaQjahy6_gds0Q@mail.gmail.com>
 <ZH8IE5KLI73YyXEy@sol>
In-Reply-To: <ZH8IE5KLI73YyXEy@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 6 Jun 2023 13:33:17 +0200
Message-ID: <CAMRc=Mc4-2mbOoy2pNGe=G21g+=HF=9+K=TPfoXJPhR4hx+uwA@mail.gmail.com>
Subject: Re: [PATCH] gpio-sim: fix memory corruption when adding named lines
 and unnamed hogs
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 12:19=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Tue, Jun 06, 2023 at 12:01:53PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Jun 6, 2023 at 7:13=E2=80=AFAM Kent Gibson <warthog618@gmail.co=
m> wrote:
> > >
> > > When constructing the sim, gpio-sim constructs an array of named line=
s,
> > > sized based on the largest offset of any named line, and then initial=
izes
> > > that array with the names of all lines, including unnamed hogs with h=
igher
> > > offsets.  In doing so it writes NULLs beyond the extent of the array.
> > >
> > > Add a check that only named lines are used to initialize the array.
> > >
> > > Fixes: cb8c474e79be ("gpio: sim: new testing module")
> > > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > > ---
> > >
> > > After writing the comment above, and looking at the code again, it ma=
y be
> > > clearer to instead check that the offset is within the bounds of the
> > > array.  Or do both.  Consider that my review.
> > >
> >
> > Like:
> >
> > if (line->offset <=3D max_offset)
> >     line_names[line->offset] =3D line->name;
> >
> > ? If so, then I agree it makes the purpose of the check clearer.
> >
>
> Using line_names_size might be even clearer.
>
> So, either that or
>
> if (line->name && (line->offset <=3D max_offset))
>     line_names[line->offset] =3D line->name;
>

Yeah, let's go with this one.

Bart

> to also not repeat the zeroing that the kcalloc() did.
>
> Too many options.  Let me know which you prefer.
>
> Cheers,
> Kent.
>
>
>
