Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E8D6CC919
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjC1RVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjC1RVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:21:04 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C9B46A;
        Tue, 28 Mar 2023 10:21:03 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id y7so3834958qky.1;
        Tue, 28 Mar 2023 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680024063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLUDxc64fTvqALQrp58IszRH00GyByVhptgABvFKmA8=;
        b=ib4M38AsoaNT/ByWkZktgnG5hSLV7M9xEFQoOeJ/m//6ER7yKi35CueYtjbIbPBeI3
         sb/4ZeztKoDVH4jpvy/k8LEXunOobIEfcYnjebuTcWbDHGZQ9AnQLsIIr0fMnzwqI+zQ
         nKVFcxknjRnhJmEKySt52FqlMFcoxXi5YBpBzdNNJ5VSet3p8dm/qygtJBzwSvAhDERi
         8lsKOwb2ZVAdUQ6vuUAjmJGhQZcwCWKx6H+DkJIPia0K5xPj+Yj/i0/YgqcE7rsh5D8b
         49JypF2puDhJu8phltT6gcKnyFk0YnMr/wd1dhw6VJ1niuWKvgZEyZvAHYG3jTmOWBmA
         UFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLUDxc64fTvqALQrp58IszRH00GyByVhptgABvFKmA8=;
        b=DR0i3paNDW0a3DqDUg2uT3P6pqxmzsNOe1p1YtO4RmjErnaEoF3X47Ynf9ae/x9AGj
         8R+o2GHtRN/eQPECEys88qEIUX2yj7LrACHhUDGnxulK1P38jneG6qItsdsL4/VV8ctV
         HPhMl4+tyFFMu370xDIAXJeJw9JBSNuSfYSXHw0SzmN2lveeGP8V1X6F/hrbSfXFXW2X
         r/vfoKGP7JNKz+wYGdy7+oYuS50EsTvf3tK+tbieuQ9yS4itEWOFfTBWQzOpTs10qInw
         CjkN8ZtzPV1NFMBE15MEp9kd+PR/mHldxpXmpIlh/wwfFi59TRAJCyBA6w1M2B2rY5VN
         Tvnw==
X-Gm-Message-State: AO0yUKVzbInlx7t2s6iiieVKlprz9CNGEsJ4Qs1/otZga7vtjiKkcJVV
        yNDw9IiwS1jgmD4le4CQ2upN0ELy0M0HY/yfNNFxwStqn0k=
X-Google-Smtp-Source: AK7set+Bex9Wy38A6IF3BWwlM4IG7L7PdR+ZGvqgtYB+kmHonEGOijVCBmDgj74OMH2B35COQ44xYCw6afa4ODg1V78=
X-Received: by 2002:a05:620a:85c:b0:745:a78b:b32 with SMTP id
 u28-20020a05620a085c00b00745a78b0b32mr3897679qku.14.1680024063052; Tue, 28
 Mar 2023 10:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230328161541.599463-1-jjhiblot@traphandler.com> <20230328161541.599463-7-jjhiblot@traphandler.com>
In-Reply-To: <20230328161541.599463-7-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Mar 2023 20:20:27 +0300
Message-ID: <CAHp75Vca0SKPkyPM_14Zny+Vn0a=hKWRfYW9qzTpN8AVZ_R_YQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] leds: Add a multicolor LED driver to group
 monochromatic LEDs
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     lee.jones@linaro.org, pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, jacek.anaszewski@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 7:15=E2=80=AFPM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> Grouping multiple monochrome LEDs into a multicolor LED device has a few
> benefits over handling the group in user-space:
> - The state of the LEDs relative to each other is consistent. In other
>   words, if 2 threads competes to set the LED to green and red, the
>   end-result cannot be black or yellow.
> - The multicolor LED as a whole can be driven through the sysfs LED
>   interface.

...

> +config LEDS_GROUP_MULTICOLOR
> +       tristate "LEDs group multi-color support"
> +       depends on OF || COMPILE_TEST

Why is OF a dependency?
Can't we make it a firmware provider agnostic solution from day 1?

> +       help
> +         This option enables support for monochrome LEDs that are
> +         grouped into multicolor LEDs.
> +         This useful in the case where LEDs of different colors are

This is

> +         physically grouped in a single multi-color LED and driven
> +         by a controller that doesn't have multi-color support.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called leds-group-multicolor.

...

> +               led_cdev =3D devm_of_led_get_optional(dev, count);

I don't see how this is OF specific to this driver. Maybe it needs to
be patched first, so we will have something non-OF specific?

> +               if (IS_ERR(led_cdev))
> +                       return dev_err_probe(dev, PTR_ERR(led_cdev), "Una=
ble to get LED #%d",
> +                                            count);

At least we need to have a FIXME or so here.

--=20
With Best Regards,
Andy Shevchenko
