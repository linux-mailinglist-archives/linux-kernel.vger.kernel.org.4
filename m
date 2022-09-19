Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423685BCB02
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiISLq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiISLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:46:57 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F90125EB0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:46:55 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id u189so29591549vsb.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fKtska7zV2Fg+EfIPpoEMTUbCLRCeKFO87xJdNKwlXs=;
        b=hZ7qcRrATubjNu9J6EKzo2G34ZYs2VQWzktnPNz1RQQB229BKCnI7QQ04IdjOhNpiS
         noYMJmgZgiJOwbZTutMyxzTqkxPgPt2bgCPdjvnCuYfqkQFGkr2g8fUr4KHgZipb24FI
         z4KWMWL17qtO0cagxkH24dDB84/YklxtzvCssO2xbuRXTGSlPKw5/CUwi3xTDqnKm31V
         B/ENsTUQZTliTm92Rd+Gdci81MoL4ag72lK0A4uRGsuVu+2X7tBbpW9OkiuW3nA74Bqp
         e2Ve3D2HwkJRQR3gRS+T48vN3oD/SSpnkwFNT3Ajl1Rd3wkQf8edxKQGaiOOHkoAnWjw
         1gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fKtska7zV2Fg+EfIPpoEMTUbCLRCeKFO87xJdNKwlXs=;
        b=o/q1KJOzZHp7QqXA75cGpHkHftpQXFB7jtr9Q7U5nkLSO+mj1VGi+9rMZw+hGhhT5R
         MXUdf6sONQoIee2sO3441ErTbo3KqWYHpwrEHBMS69HK2uCLxhkWmWIy03N8nvA5ayeN
         /feWu0OQg+9YpMCo0B6DQZt3ZQ6xt5qhH4SL8z++IET4af1GYnxwCMeFMoW/ZJzUcakw
         +/qR52KWjOrsv0VPnLBPs0sMs4Ek2fZ5LVgMtCCw2pY9Q8skBtb2PWD31fvJA9NA6yFT
         xGbRO+T0d+qKexZPYoxYW1fnJOOG+VKOS8ixLiznWUaVdNwqOCgvNLUx5MmT8HLdL7Fd
         4OJw==
X-Gm-Message-State: ACrzQf3oCKtXVMG2Eu9EOina3Z0Ezchcas7F2psfMvCvQcbBtM4Ye+Xb
        i5G2rERA4sxxFK1FJN278xEq+kep3c5jaL6J99g=
X-Google-Smtp-Source: AMsMyM4M2ser5bOF6J2igC/p57FX5aXjOfh63rBKsvNVK82zChDx25dnwcFkZuYVUg+agaq0+PNxstXRhVrSUizXXIk=
X-Received: by 2002:a67:8c43:0:b0:398:6815:d340 with SMTP id
 o64-20020a678c43000000b003986815d340mr5863396vsd.42.1663588014187; Mon, 19
 Sep 2022 04:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAB7eexL1zBnB636hwS27d-LdPYZ_R1-5fJS_h=ZbCWYU=UPWJg@mail.gmail.com>
 <871qs7dav5.wl-tiwai@suse.de> <87r107btti.wl-tiwai@suse.de>
In-Reply-To: <87r107btti.wl-tiwai@suse.de>
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Mon, 19 Sep 2022 19:46:43 +0800
Message-ID: <CAB7eexL-H7v5+EB6DVLLZSaV0daHtWhr1gjpuMOspJhJSjq5Lw@mail.gmail.com>
Subject: Re: KASAN: invalid-free in snd_card_new
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tested this patch with the reproducer and the crash did not trigger again.

On Mon, Sep 19, 2022 at 5:24 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 19 Sep 2022 10:30:54 +0200,
> Takashi Iwai wrote:
> >
> > On Sun, 18 Sep 2022 15:01:11 +0200,
> > Rondreis wrote:
> > >
> > > Hello,
> > >
> > > When fuzzing the Linux kernel driver v6.0-rc4, the following crash was
> > > triggered.
> > >
> > > HEAD commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
> > > git tree: upstream
> > >
> > > kernel config: https://pastebin.com/raw/xtrgsXP3
> > > C reproducer: https://pastebin.com/raw/w2sdQWYj
> > > console output: https://pastebin.com/raw/Yyf7zw2d
> > >
> > > Basically, in the c reproducer, we use the gadget module to emulate
> > > attaching a USB device(vendor id: 0x1bc7, product id: 0x1206, with the
> > > midi function) and executing some simple sequence of system calls.
> > > To reproduce this crash, we utilize a third-party library to emulate
> > > the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
> > > Just clone this repository, install it, and compile the c
> > > reproducer with ``` gcc crash.c -lusbgx -lconfig -o crash ``` will do
> > > the trick.
> > >
> > > I would appreciate it if you have any idea how to solve this bug.
> >
> > Could you try the patch below?  It looks like a simple double-free in
> > the code.
>
> A more proper patch is below.  Please give it a try.
>
>
> thanks,
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: core: Fix double-free at snd_card_new()
>
> During the code change to add the support for devres-managed card
> instance, we put an explicit kfree(card) call at the error path in
> snd_card_new().  This is needed for the early error path before the
> card is initialized with the device, but is rather superfluous and
> causes a double-free at the error path after the card instance is
> initialized, as the destructor of the card object already contains a
> kfree() call.
>
> This patch fixes the double-free situation by removing the superfluous
> kfree().  Meanwhile we need to call kfree() explicitly for the early
> error path, so it's added there instead.
>
> Fixes: e8ad415b7a55 ("ALSA: core: Add managed card creation")
> Reported-by: Rondreis <linhaoguo86@gmail.com>
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/r/CAB7eexL1zBnB636hwS27d-LdPYZ_R1-5fJS_h=ZbCWYU=UPWJg@mail.gmail.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/init.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/sound/core/init.c b/sound/core/init.c
> index 193dae361fac..5377f94eb211 100644
> --- a/sound/core/init.c
> +++ b/sound/core/init.c
> @@ -178,10 +178,8 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
>                 return -ENOMEM;
>
>         err = snd_card_init(card, parent, idx, xid, module, extra_size);
> -       if (err < 0) {
> -               kfree(card);
> -               return err;
> -       }
> +       if (err < 0)
> +               return err; /* card is freed by error handler */
>
>         *card_ret = card;
>         return 0;
> @@ -233,7 +231,7 @@ int snd_devm_card_new(struct device *parent, int idx, const char *xid,
>         card->managed = true;
>         err = snd_card_init(card, parent, idx, xid, module, extra_size);
>         if (err < 0) {
> -               devres_free(card);
> +               devres_free(card); /* in managed mode, we need to free manually */
>                 return err;
>         }
>
> @@ -297,6 +295,8 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
>                 mutex_unlock(&snd_card_mutex);
>                 dev_err(parent, "cannot find the slot for index %d (range 0-%i), error: %d\n",
>                          idx, snd_ecards_limit - 1, err);
> +               if (!card->managed)
> +                       kfree(card); /* manually free here, as no destructor called */
>                 return err;
>         }
>         set_bit(idx, snd_cards_lock);           /* lock it */
> --
> 2.35.3
>
