Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FACA5F0C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiI3NN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiI3NNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:13:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9853218A480
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:13:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r6so6805027wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=oT5i6IJfZjwAPvCbeXBKLY16doFowUjbBZuf5KMEpE8=;
        b=h9KvHsBJ/GjglxgrBLry9BnzKmHC7JaY1bR/px8DrgtaylQSDT5VanNO9AQaDonfky
         MS2d2KndhpkocZWfi7Qmiza882lJubXGySkP9aeOxJskdLpgsBH6IhSmyyOI37uZ2cCh
         5DZfmD4bxuVFGqAJ8UWwh6tPL8Uycd47sKrHiX3Gy/6V7ch1dgqPPqeYKXP2hBocqnak
         ZTZh/IeGz7gii4e/Q+IN41/lRyXkb/HuOU6tVhqFBT4RxYjRbWsCa8tlIzGur6HRwzbc
         HKz0kGEzbn47d+17ynsXkgYiA4qxNfGvlhFMpRKZtZiSuy5lEMOZXdGEctUgb1IVG8il
         /wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=oT5i6IJfZjwAPvCbeXBKLY16doFowUjbBZuf5KMEpE8=;
        b=FLugHT0TWxWyAz4nDWYRAlnRb6BpDXi2istkXeiDzpnRUWGDexqyp4JeROLDNoka+T
         LEnE+51bu90GjDHbFlU3YCIrYgX9BzJFTAwXSyv33TATBNrcobzS5kgsrrkWq+BWkKyA
         7ZUYqAz1+Yv4F4peBCz6wowIsZeH/b/NlvRCHN3A9c31f7BTt+5kJtzjH9PRABG/oxqR
         EqMPX3xXrNM4QaCr+8HwEijddWF4iSUEwfoApWw4lmRZ9kprgyYcwYMqeZ+0di1c/nRk
         w1//X81CSuXoX+dqGHQaxZSbLRkpld8UvTARrngymbmKKdtMUMHVv8ob6eIAo7xrOjfF
         bb5w==
X-Gm-Message-State: ACrzQf3qgCkpI/ZvkfltHOBuIECKtcWJYqC2vtrKtIsWCnDOAflSh8yO
        FlPZhb0QT1y2iiP4JGLMK8DRP6ec6M2zYw==
X-Google-Smtp-Source: AMsMyM5RvdLdqVuVoMJdsKxVFcPhIPdiHaoRj33eIHQ59NIjjNvVEv5UdM2LhngpYSbqwe2bmgMlGg==
X-Received: by 2002:a5d:59a3:0:b0:22a:fc9b:4358 with SMTP id p3-20020a5d59a3000000b0022afc9b4358mr5955334wrr.4.1664543591928;
        Fri, 30 Sep 2022 06:13:11 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:4f04:36fe:65ec:ecf4])
        by smtp.gmail.com with ESMTPSA id q5-20020a05600c2e4500b003b50428cf66sm1964323wmf.33.2022.09.30.06.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 06:13:11 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] input: Drop empty comment
In-Reply-To: <26a2b905b259bfffaf2de5b26f2007b8606970ed.1664478665.git.christophe.jaillet@wanadoo.fr>
References: <26a2b905b259bfffaf2de5b26f2007b8606970ed.1664478665.git.christophe.jaillet@wanadoo.fr>
Date:   Fri, 30 Sep 2022 15:13:10 +0200
Message-ID: <877d1lkntl.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On jeu., sept. 29, 2022 at 21:11, Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Commit 1a59d1b8e05e ("treewide: Replace GPLv2 boilerplate/reference with
> SPDX - rule 156") has left some empty comment blocks.
>
> Remove them to save a few lines of code.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> All files I've checked were related to 1a59d1b8e05e, but I've not checked
> all.
> ---
>  drivers/input/ff-core.c             | 3 ---
>  drivers/input/ff-memless.c          | 3 ---
>  drivers/input/gameport/emu10k1-gp.c | 3 ---
>  drivers/input/gameport/lightning.c  | 3 ---
>  drivers/input/gameport/ns558.c      | 3 ---
>  drivers/input/joystick/a3d.c        | 3 ---
>  drivers/input/joystick/adi.c        | 3 ---
>  drivers/input/joystick/amijoy.c     | 3 ---
>  drivers/input/joystick/analog.c     | 3 ---
>  drivers/input/joystick/cobra.c      | 3 ---
>  drivers/input/joystick/db9.c        | 3 ---
>  drivers/input/joystick/gamecon.c    | 3 ---
>  drivers/input/joystick/gf2k.c       | 3 ---
>  drivers/input/joystick/grip.c       | 3 ---
>  drivers/input/joystick/guillemot.c  | 3 ---
>  drivers/input/joystick/interact.c   | 3 ---
>  drivers/input/joystick/joydump.c    | 3 ---
>  drivers/input/joystick/magellan.c   | 3 ---
>  drivers/input/joystick/sidewinder.c | 3 ---
>  drivers/input/joystick/spaceball.c  | 3 ---
>  drivers/input/joystick/spaceorb.c   | 3 ---
>  drivers/input/joystick/stinger.c    | 3 ---
>  drivers/input/joystick/tmdc.c       | 3 ---
>  drivers/input/joystick/turbografx.c | 3 ---
>  drivers/input/joystick/twidjoy.c    | 3 ---
>  drivers/input/joystick/warrior.c    | 3 ---
>  drivers/input/joystick/zhenhua.c    | 3 ---
>  drivers/input/keyboard/amikbd.c     | 3 ---
>  drivers/input/keyboard/atakbd.c     | 3 ---
>  drivers/input/keyboard/lkkbd.c      | 3 ---
>  drivers/input/keyboard/newtonkbd.c  | 3 ---
>  drivers/input/keyboard/stowaway.c   | 3 ---
>  drivers/input/keyboard/sunkbd.c     | 3 ---
>  drivers/input/keyboard/xtkbd.c      | 3 ---
>  drivers/input/mouse/inport.c        | 3 ---
>  drivers/input/mouse/logibm.c        | 3 ---
>  drivers/input/mouse/pc110pad.c      | 3 ---
>  drivers/input/mouse/sermouse.c      | 3 ---
>  drivers/input/mouse/vsxxxaa.c       | 3 ---
>  drivers/input/serio/ct82c710.c      | 3 ---
>  drivers/input/serio/q40kbd.c        | 3 ---
>  drivers/input/serio/rpckbd.c        | 3 ---
>  drivers/input/serio/serio.c         | 3 ---
>  drivers/input/tablet/acecad.c       | 3 ---
>  drivers/input/tablet/hanwang.c      | 3 ---
>  drivers/input/touchscreen/gunze.c   | 3 ---
>  46 files changed, 138 deletions(-)
>
> diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
> index fa8d1a466014..16231fe080b0 100644
> --- a/drivers/input/ff-core.c
> +++ b/drivers/input/ff-core.c
> @@ -6,9 +6,6 @@
>   *  Copyright (c) 2006 Dmitry Torokhov <dtor@mail.ru>
>   */
>  
> -/*
> - */
> -
>  /* #define DEBUG */
>  
>  #include <linux/input.h>
> diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
> index 8229a9006917..c321cdabd214 100644
> --- a/drivers/input/ff-memless.c
> +++ b/drivers/input/ff-memless.c
> @@ -6,9 +6,6 @@
>   *  Copyright (c) 2006 Dmitry Torokhov <dtor@mail.ru>
>   */
>  
> -/*
> - */
> -
>  /* #define DEBUG */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> diff --git a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gameport/emu10k1-gp.c
> index 11bbd1edfdb4..76ce41e58df0 100644
> --- a/drivers/input/gameport/emu10k1-gp.c
> +++ b/drivers/input/gameport/emu10k1-gp.c
> @@ -7,9 +7,6 @@
>   * EMU10k1 - SB Live / Audigy - gameport driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <asm/io.h>
>  
>  #include <linux/module.h>
> diff --git a/drivers/input/gameport/lightning.c b/drivers/input/gameport/lightning.c
> index 87eeb4b5b5b5..2ce717b25a84 100644
> --- a/drivers/input/gameport/lightning.c
> +++ b/drivers/input/gameport/lightning.c
> @@ -7,9 +7,6 @@
>   * PDPI Lightning 4 gamecard driver for Linux.
>   */
>  
> -/*
> - */
> -
>  #include <asm/io.h>
>  #include <linux/delay.h>
>  #include <linux/errno.h>
> diff --git a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
> index 2f80b7f1b736..91a8cd346e9b 100644
> --- a/drivers/input/gameport/ns558.c
> +++ b/drivers/input/gameport/ns558.c
> @@ -8,9 +8,6 @@
>   * NS558 based standard IBM game port driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <asm/io.h>
>  
>  #include <linux/module.h>
> diff --git a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
> index 68475fad177c..fd1827baf27c 100644
> --- a/drivers/input/joystick/a3d.c
> +++ b/drivers/input/joystick/a3d.c
> @@ -7,9 +7,6 @@
>   * FP-Gaming Assassin 3D joystick driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
> index e10d57bf1180..f1a720be458b 100644
> --- a/drivers/input/joystick/adi.c
> +++ b/drivers/input/joystick/adi.c
> @@ -7,9 +7,6 @@
>   * Logitech ADI joystick family driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> diff --git a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
> index 12456a196dc7..3752dc2a2086 100644
> --- a/drivers/input/joystick/amijoy.c
> +++ b/drivers/input/joystick/amijoy.c
> @@ -7,9 +7,6 @@
>   * Driver for Amiga joysticks for Linux/m68k
>   */
>  
> -/*
> - */
> -
>  #include <linux/types.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
> diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
> index 3088c5b829f0..0c9e172a9818 100644
> --- a/drivers/input/joystick/analog.c
> +++ b/drivers/input/joystick/analog.c
> @@ -7,9 +7,6 @@
>   * Analog joystick and gamepad driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> diff --git a/drivers/input/joystick/cobra.c b/drivers/input/joystick/cobra.c
> index 41e1936a847b..7ff78c9388bd 100644
> --- a/drivers/input/joystick/cobra.c
> +++ b/drivers/input/joystick/cobra.c
> @@ -7,9 +7,6 @@
>   * Creative Labs Blaster GamePad Cobra driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
> index 434d265fa2e8..4fba28b1a1e7 100644
> --- a/drivers/input/joystick/db9.c
> +++ b/drivers/input/joystick/db9.c
> @@ -10,9 +10,6 @@
>   * Atari, Amstrad, Commodore, Amiga, Sega, etc. joystick driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
> diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
> index d37645e496ff..41d5dac05448 100644
> --- a/drivers/input/joystick/gamecon.c
> +++ b/drivers/input/joystick/gamecon.c
> @@ -11,9 +11,6 @@
>   *	Raphael Assenat
>   */
>  
> -/*
> - */
> -
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/kernel.h>
> diff --git a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
> index 920feba967f6..abefbd1484df 100644
> --- a/drivers/input/joystick/gf2k.c
> +++ b/drivers/input/joystick/gf2k.c
> @@ -7,9 +7,6 @@
>   * Genius Flight 2000 joystick driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> diff --git a/drivers/input/joystick/grip.c b/drivers/input/joystick/grip.c
> index fe798bc87950..0e86b269a90e 100644
> --- a/drivers/input/joystick/grip.c
> +++ b/drivers/input/joystick/grip.c
> @@ -7,9 +7,6 @@
>   * Gravis/Kensington GrIP protocol joystick and gamepad driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/drivers/input/joystick/guillemot.c b/drivers/input/joystick/guillemot.c
> index 8eeacdb007c1..205eb6f8b84d 100644
> --- a/drivers/input/joystick/guillemot.c
> +++ b/drivers/input/joystick/guillemot.c
> @@ -7,9 +7,6 @@
>   * Guillemot Digital Interface Protocol driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> diff --git a/drivers/input/joystick/interact.c b/drivers/input/joystick/interact.c
> index ca22d84e5c84..03a9f0829f7e 100644
> --- a/drivers/input/joystick/interact.c
> +++ b/drivers/input/joystick/interact.c
> @@ -10,9 +10,6 @@
>   * InterAct digital gamepad/joystick driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> diff --git a/drivers/input/joystick/joydump.c b/drivers/input/joystick/joydump.c
> index 70f63f9550e7..865652a7821d 100644
> --- a/drivers/input/joystick/joydump.c
> +++ b/drivers/input/joystick/joydump.c
> @@ -8,9 +8,6 @@
>   * out of the joystick port into the syslog ...
>   */
>  
> -/*
> - */
> -
>  #include <linux/module.h>
>  #include <linux/gameport.h>
>  #include <linux/kernel.h>
> diff --git a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
> index edb8e1982e26..017ef8c6170b 100644
> --- a/drivers/input/joystick/magellan.c
> +++ b/drivers/input/joystick/magellan.c
> @@ -7,9 +7,6 @@
>   * Magellan and Space Mouse 6dof controller driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
> index 8e9672deb1eb..7282301c3ae7 100644
> --- a/drivers/input/joystick/sidewinder.c
> +++ b/drivers/input/joystick/sidewinder.c
> @@ -7,9 +7,6 @@
>   * Microsoft SideWinder joystick family driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> diff --git a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
> index a85a4f33aea8..fa8ec533cd69 100644
> --- a/drivers/input/joystick/spaceball.c
> +++ b/drivers/input/joystick/spaceball.c
> @@ -11,9 +11,6 @@
>   * SpaceTec SpaceBall 2003/3003/4000 FLX driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> diff --git a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
> index 557171483256..dbbc69f17c89 100644
> --- a/drivers/input/joystick/spaceorb.c
> +++ b/drivers/input/joystick/spaceorb.c
> @@ -10,9 +10,6 @@
>   * SpaceTec SpaceOrb 360 and Avenger 6dof controller driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> diff --git a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
> index c20425f52bd8..530de468cb61 100644
> --- a/drivers/input/joystick/stinger.c
> +++ b/drivers/input/joystick/stinger.c
> @@ -8,9 +8,6 @@
>   * Gravis Stinger gamepad driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/drivers/input/joystick/tmdc.c b/drivers/input/joystick/tmdc.c
> index 7416de84b955..93562ecc0ca1 100644
> --- a/drivers/input/joystick/tmdc.c
> +++ b/drivers/input/joystick/tmdc.c
> @@ -10,9 +10,6 @@
>   * ThrustMaster DirectConnect (BSP) joystick family driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> diff --git a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
> index dfe7a2cacce2..dfb9c684651f 100644
> --- a/drivers/input/joystick/turbografx.c
> +++ b/drivers/input/joystick/turbografx.c
> @@ -10,9 +10,6 @@
>   * TurboGraFX parallel port interface driver for Linux.
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/parport.h>
>  #include <linux/input.h>
> diff --git a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
> index 174c69a188fb..9b6792ac27f1 100644
> --- a/drivers/input/joystick/twidjoy.c
> +++ b/drivers/input/joystick/twidjoy.c
> @@ -32,9 +32,6 @@
>   * Arndt Schoenewald <arndt@quelltext.com>
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
> index 42bdbc28d95d..f66bddf145c2 100644
> --- a/drivers/input/joystick/warrior.c
> +++ b/drivers/input/joystick/warrior.c
> @@ -7,9 +7,6 @@
>   * Logitech WingMan Warrior joystick driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/drivers/input/joystick/zhenhua.c b/drivers/input/joystick/zhenhua.c
> index d5531179b01f..3f2460e2b095 100644
> --- a/drivers/input/joystick/zhenhua.c
> +++ b/drivers/input/joystick/zhenhua.c
> @@ -28,9 +28,6 @@
>   * coder :-(
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
> index 09551f64d53f..a20a4e186639 100644
> --- a/drivers/input/keyboard/amikbd.c
> +++ b/drivers/input/keyboard/amikbd.c
> @@ -10,9 +10,6 @@
>   * Amiga keyboard driver for Linux/m68k
>   */
>  
> -/*
> - */
> -
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/input.h>
> diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
> index 77ed54630601..07e17e563f9b 100644
> --- a/drivers/input/keyboard/atakbd.c
> +++ b/drivers/input/keyboard/atakbd.c
> @@ -21,9 +21,6 @@
>   * This driver only deals with handing key events off to the input layer.
>   */
>  
> -/*
> - */
> -
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/input.h>
> diff --git a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
> index ea9a1d8834c1..047b654b3752 100644
> --- a/drivers/input/keyboard/lkkbd.c
> +++ b/drivers/input/keyboard/lkkbd.c
> @@ -46,9 +46,6 @@
>   * http://www.vt100.net/manx/details?pn=EK-104AA-TM-001;id=21;cp=1
>   */
>  
> -/*
> - */
> -
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> diff --git a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
> index 9742261b2d1a..df00a119aa9a 100644
> --- a/drivers/input/keyboard/newtonkbd.c
> +++ b/drivers/input/keyboard/newtonkbd.c
> @@ -7,9 +7,6 @@
>   * Newton keyboard driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/input.h>
> diff --git a/drivers/input/keyboard/stowaway.c b/drivers/input/keyboard/stowaway.c
> index a4977193dd4a..56e784936059 100644
> --- a/drivers/input/keyboard/stowaway.c
> +++ b/drivers/input/keyboard/stowaway.c
> @@ -10,9 +10,6 @@
>   *  by Justin Cormack
>   */
>  
> -/*
> - */
> -
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/input.h>
> diff --git a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
> index d450f11b98a7..b123a208ef36 100644
> --- a/drivers/input/keyboard/sunkbd.c
> +++ b/drivers/input/keyboard/sunkbd.c
> @@ -7,9 +7,6 @@
>   * Sun keyboard driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/delay.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> diff --git a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
> index 280796df679a..c9d7c2481726 100644
> --- a/drivers/input/keyboard/xtkbd.c
> +++ b/drivers/input/keyboard/xtkbd.c
> @@ -7,9 +7,6 @@
>   * XT keyboard driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/input.h>
> diff --git a/drivers/input/mouse/inport.c b/drivers/input/mouse/inport.c
> index df5d1160478c..401d8bff8e84 100644
> --- a/drivers/input/mouse/inport.c
> +++ b/drivers/input/mouse/inport.c
> @@ -13,9 +13,6 @@
>   * Inport (ATI XL and Microsoft) busmouse driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/module.h>
>  #include <linux/ioport.h>
>  #include <linux/init.h>
> diff --git a/drivers/input/mouse/logibm.c b/drivers/input/mouse/logibm.c
> index bd647f9f505a..0aab63dbc30a 100644
> --- a/drivers/input/mouse/logibm.c
> +++ b/drivers/input/mouse/logibm.c
> @@ -14,9 +14,6 @@
>   * Logitech Bus Mouse Driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/ioport.h>
> diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
> index f75574766b85..efa58049f746 100644
> --- a/drivers/input/mouse/pc110pad.c
> +++ b/drivers/input/mouse/pc110pad.c
> @@ -10,9 +10,6 @@
>   * IBM PC110 touchpad driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> diff --git a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
> index caa79c177c55..993f90333380 100644
> --- a/drivers/input/mouse/sermouse.c
> +++ b/drivers/input/mouse/sermouse.c
> @@ -7,9 +7,6 @@
>   *  Serial mouse driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
> index 3bd6e723a422..8af8e4a15f95 100644
> --- a/drivers/input/mouse/vsxxxaa.c
> +++ b/drivers/input/mouse/vsxxxaa.c
> @@ -12,9 +12,6 @@
>   * Later on, I had access to the device's documentation (referenced below).
>   */
>  
> -/*
> - */
> -
>  /*
>   * Building an adaptor to DE9 / DB25 RS232
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
> index 752ce60e2211..3da751f4a6bf 100644
> --- a/drivers/input/serio/ct82c710.c
> +++ b/drivers/input/serio/ct82c710.c
> @@ -7,9 +7,6 @@
>   *  82C710 C&T mouse port chip driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/ioport.h>
> diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
> index a1c61f5de047..ba04058fc3cb 100644
> --- a/drivers/input/serio/q40kbd.c
> +++ b/drivers/input/serio/q40kbd.c
> @@ -10,9 +10,6 @@
>   * Q40 PS/2 keyboard controller driver for Linux/m68k
>   */
>  
> -/*
> - */
> -
>  #include <linux/module.h>
>  #include <linux/serio.h>
>  #include <linux/interrupt.h>
> diff --git a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
> index 7008bc101415..ce420eb1f51b 100644
> --- a/drivers/input/serio/rpckbd.c
> +++ b/drivers/input/serio/rpckbd.c
> @@ -8,9 +8,6 @@
>   * Acorn RiscPC PS/2 keyboard controller driver for Linux/ARM
>   */
>  
> -/*
> - */
> -
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/serio.h>
> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index ec117be3d8d8..15ce3202322f 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -7,9 +7,6 @@
>   *  Copyright (c) 2003 Daniele Bellucci
>   */
>  
> -/*
> - */
> -
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/stddef.h>
> diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
> index 80e06727464d..b20e5a1afbcc 100644
> --- a/drivers/input/tablet/acecad.c
> +++ b/drivers/input/tablet/acecad.c
> @@ -9,9 +9,6 @@
>   *      v3.2 - Added sysfs support
>   */
>  
> -/*
> - */
> -
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> diff --git a/drivers/input/tablet/hanwang.c b/drivers/input/tablet/hanwang.c
> index e492a0331b24..9bc631518b92 100644
> --- a/drivers/input/tablet/hanwang.c
> +++ b/drivers/input/tablet/hanwang.c
> @@ -5,9 +5,6 @@
>   *  Copyright (c) 2010 Xing Wei <weixing@hanwang.com.cn>
>   */
>  
> -/*
> - */
> -
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
> index e07e8e0fe8ea..5a5f9da73fa1 100644
> --- a/drivers/input/touchscreen/gunze.c
> +++ b/drivers/input/touchscreen/gunze.c
> @@ -7,9 +7,6 @@
>   * Gunze AHL-51S touchscreen driver for Linux
>   */
>  
> -/*
> - */
> -
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -- 
> 2.34.1
