Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7B2609119
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 06:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJWEAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 00:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJWEAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 00:00:20 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91F53470E;
        Sat, 22 Oct 2022 21:00:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id by36so8805462ljb.4;
        Sat, 22 Oct 2022 21:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l4bdov0hgKiLdPL4WG06hOzuyjfJGS+F4udCWXNnrmQ=;
        b=VdJFQ3ZfvhFzUVrpER7HXO5aznN65zV3euEmWaJCpEzdtTPX1u6wGt8qsCQ2JaG/DL
         5A1PqSZaTvO8qEwqixMaWvWeQgTh2PGYwCMq8sjk85G/fBdx2WJpUCBBgxGGvEGOf/Ak
         LLybMsaewzhamRsbtpkAqwI9Juu+JXOMlFTHOWXjTLRfmudVrmucC1jy1Qu8kpCwexTE
         RspMhZf1LqzaI9hLphrow6gxPHuzYMUbmZwus2XbZQ8PUxdYW5GBW5WndRjHpu2pb28H
         CEpNK/OjRiCBPE79b1P0x33MN2noXk55n8mxGh3JGnQajHKyNBOnfUkBLAD0yx9gwWSs
         HH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4bdov0hgKiLdPL4WG06hOzuyjfJGS+F4udCWXNnrmQ=;
        b=n7zFjsMcLRcZ8lYS6ZAO/+AsjwogQv8UZ2gzl8tBfBgJ+6aN8195S6ArPsLqQ11uQD
         +D5+EeygerofDKLOm/xqBC6G/TigbuVqJZTWdL+/Re1cN9jLaptJLkzsVhp67mInHhYb
         D7uOYq1Ig0XWzwH9yAz4j9mCGS43iM+TJzL/F58o05UPhZiT6zbbNP7tLgpZZo6Nb3O6
         OCJwtKnrWvrCByhzSBK7RZjusU/8twudkbg/ymXPAK5AiowEhkVppvJfNlm/N21KbIx6
         91T0jWxhiCHuov542wRjCXgdkrHmkPPtHXAguZZVT72xPE0MbbZIGA4G78Vyy8wpNIyS
         Sjig==
X-Gm-Message-State: ACrzQf2KDKvAaT1maPENduTT6D9yOkLw20Zr1QNqGnBefgXWhEQFB6sI
        BC3zdQJPz7qGxf/LkntthsUndXCMrMACcTDzbMZ1WeHp
X-Google-Smtp-Source: AMsMyM6GZpf3PpNlGLfpiW4o7cSxPgLZsN0APKBGqiUo79K0wbAskgyaPMe4qeIb+U0swfrJ+6+yTLtvb5oJwurVgjw=
X-Received: by 2002:a2e:8548:0:b0:26d:fecc:5675 with SMTP id
 u8-20020a2e8548000000b0026dfecc5675mr10306893ljj.515.1666497614580; Sat, 22
 Oct 2022 21:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221022220508.37489-1-maurinbe@gmail.com>
In-Reply-To: <20221022220508.37489-1-maurinbe@gmail.com>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Sat, 22 Oct 2022 21:00:02 -0700
Message-ID: <CAEc3jaDjGBUspf5zPUfjPKgP+nk4zVFqJ0pgR8LAmX35qmx+fA@mail.gmail.com>
Subject: Re: [PATCH] input/xpad: LED controllable through input events
To:     Benoit Maurin <maurinbe@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benoit,

Thanks for your patch. I'm thinking out loud whether this is a
direction we want to go in regards to EV_LED. I vaguely recall some
discussions a while ago that EV_LED was really from a different era
for legacy reasons (keyboard LEDs). Since the introduction of the LED
framework that was really the way to go.

Thanks,
Roderick

On Sat, Oct 22, 2022 at 3:08 PM Benoit Maurin <maurinbe@gmail.com> wrote:
>
> (EV_LED, LED_MISC, #VALUE) can now be used to control leds on the
> xpad gamepad (was only possible through /sys/class/leds/xpad0/brightness)
> with permissions of /dev/input/xxx
>
> To test the code (xpad can be compiled out-of-tree with some slight
> tweaks):
>
> ```
> import evdev
> device = evdev.InputDevice('/dev/input/event15') # not js0
> device.set_led(8, 2)
> device.set_led(8, 0) # this won't be delivered
> device.set_led(8, 16) # must do this instead
> device.set_led(8, 15)
> ```
>
> Signed-off-by: Benoit Maurin <maurinbe@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 2959d80f7..fcf4d2c8f 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1646,6 +1646,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
>                 goto err_free_mem;
>         }
>
> +       input_set_capability(xpad->dev, EV_LED, LED_MISC);
>         snprintf(led->name, sizeof(led->name), "xpad%d", xpad->pad_nr);
>         led->xpad = xpad;
>
> @@ -1824,6 +1825,28 @@ static void xpad_deinit_input(struct usb_xpad *xpad)
>         }
>  }
>
> +static int xpad_event(struct input_dev *dev, unsigned int type,
> +                     unsigned int code, int value)
> +{
> +       struct usb_xpad *xpad = input_get_drvdata(dev);
> +
> +       if (type != EV_LED || xpad->led == NULL)
> +               return 0;
> +       xpad_send_led_command(xpad, value);
> +       xpad->led->led_cdev.brightness = value;
> +       /* Bit clearing is necessary otherwise two events with
> +        * different non-null values will deliver only the first one.
> +        * To work around this, we clear the bit to indicate that the
> +        * current value is zero. The downside is that events with zero
> +        * value won't be delivered. It's not a big deal since a value of
> +        * 16 can be sent which is the same as 0
> +        * See xpad_send_led_command, command %= 16
> +        */
> +
> +       clear_bit(code, xpad->dev->led);
> +       return 0;
> +}
> +
>  static int xpad_init_input(struct usb_xpad *xpad)
>  {
>         struct input_dev *input_dev;
> @@ -1851,6 +1874,7 @@ static int xpad_init_input(struct usb_xpad *xpad)
>                 input_dev->open = xpad_open;
>                 input_dev->close = xpad_close;
>         }
> +       input_dev->event = xpad_event;
>
>         if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
>                 /* set up axes */
> --
> 2.38.1
>
