Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B48662273
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjAIKGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjAIKGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:06:12 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9440B193E4;
        Mon,  9 Jan 2023 02:04:29 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id h26so7449081qtu.2;
        Mon, 09 Jan 2023 02:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ILt2nHhZG6OAJb7Z4BVZBIlEGFuGgmOKUcbFf2IQt4=;
        b=l6V2zRJ76WHuURCEMdd2b4mH6n7Wl51cW1aSjuA5LjLkkWRCEITAkcnE6VVBmExEg5
         B9ZxwKa3U5E9Rbx0BUrmpflqX1H47YRE2Uloc/i4O+h/ofqX5X6WJjuA5JGO2LYWXwl4
         z94WFlIXOK+JFz/NQyUHIFkawNcW0Dha/5N4ZCCS06I8KZ6khKNCU1z9sr3PW585fxjl
         CSDKBFzRQrGagRWV+wNo5Y5HPcg2R3hIXdx18In/H3zhIDnqoiUKvGX9e4sI7XCglHcL
         f+2xqR8LaBqnUdVYCV7i6w+v5sSRb0rMatW0JC9LyPRoD0+x5cHC10PF40yRUlxyExoO
         GtfA==
X-Gm-Message-State: AFqh2kpeGrmU+fzMbpShSpPQNIf1QblojP0BJCtCOepBr+KqPuKbwSJq
        TRyoo2b5BvKYIiJBYuRWBd7zz8Tqs0hQbg==
X-Google-Smtp-Source: AMrXdXsszae4j6tn5vlseI06jxHmQtZtxIuPtM3mf4X22CsA4gIQ43wfeUj2VBXdi0okE1GTLKQhWw==
X-Received: by 2002:ac8:611a:0:b0:3ad:d171:415b with SMTP id a26-20020ac8611a000000b003add171415bmr1758717qtm.20.1673258668451;
        Mon, 09 Jan 2023 02:04:28 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id d8-20020ac84e28000000b0039c7b9522ecsm4378500qtw.35.2023.01.09.02.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 02:04:28 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-4a263c4ddbaso106992617b3.0;
        Mon, 09 Jan 2023 02:04:28 -0800 (PST)
X-Received: by 2002:a05:690c:313:b0:37e:6806:a5f9 with SMTP id
 bg19-20020a05690c031300b0037e6806a5f9mr1566668ywb.47.1673258667893; Mon, 09
 Jan 2023 02:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20230105094039.1474255-1-xurui@kylinos.cn> <CAMuHMdX174erGgrCUBv2WdX67H=mig-hi=SOdeMJ=0__thC_fw@mail.gmail.com>
In-Reply-To: <CAMuHMdX174erGgrCUBv2WdX67H=mig-hi=SOdeMJ=0__thC_fw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jan 2023 11:04:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVdCBxZ39BbtLDPeiMK9BK4M0W5hynrYLFx6+ibunyxGw@mail.gmail.com>
Message-ID: <CAMuHMdVdCBxZ39BbtLDPeiMK9BK4M0W5hynrYLFx6+ibunyxGw@mail.gmail.com>
Subject: Re: [PATCH] fbdev/g364fb: Fix a compilation issue
To:     xurui <xurui@kylinos.cn>
Cc:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This time with the new linux-mips mailing list address...

On Mon, Jan 9, 2023 at 11:01 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Xurui,
>
> On Thu, Jan 5, 2023 at 10:45 AM xurui <xurui@kylinos.cn> wrote:
> > drivers/video/fbdev/g364fb.c:202:4: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> >
> > Signed-off-by: xurui <xurui@kylinos.cn>
>
> Thanks for your patch!
>
> > --- a/drivers/video/fbdev/g364fb.c
> > +++ b/drivers/video/fbdev/g364fb.c
> > @@ -175,7 +175,8 @@ int __init g364fb_init(void)
> >  {
> >         volatile unsigned int *curs_pal_ptr =
> >             (volatile unsigned int *) CURS_PAL_REG;
> > -       int mem, i;
> > +       int mem;
> > +       uintptr_t i;
>
> This doesn't look like the right fix to me.
>
> The line the compiler[1] complains about is:
>
>                 *(unsigned short *) (CURS_PAT_REG + i * 8) = 0;
>
> Interestingly, it doesn't complain about:
>
>         *(unsigned short *) (CURS_PAT_REG + 14 * 64) = 0xffff;
>
> This driver uses raw memory writes to write to hardware registers.
> Probably it should use writel() instead.
>
> [1] mips64-linux-gnuabi64-gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1)
>     jazz_defconfig + CONFIG_64BIT=y
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
