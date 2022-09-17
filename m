Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B095BB73B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 10:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiIQIZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 04:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiIQIZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 04:25:42 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45443AE4F;
        Sat, 17 Sep 2022 01:25:41 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c11so17540427qtw.8;
        Sat, 17 Sep 2022 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2s5Im8YH2uK7U63hireyouAIO+Pt2Pckui2xkKi8Z/g=;
        b=fZCnFg5L8MRWwZp9wRVSN+BuEj1eR7Hy9B/D2j3lB6VFiEOLXITAQYWiunBt9jVxZX
         LxA0qk2YnqLzAUxE7xxXchiknHxUdLZgRE42UoCiwKhYWANS9BhaAk6G/MH8Qc8YysnZ
         MKNrU5NrxS95B7Qie4RDfYxvtggm92cDKe84YGVn8eQKxlj88mDMWEKWSpV0/yyPeLfD
         92LL24ZJ6VDt/bSHhfAfz0HnqzcwAdpITWL0xIUN0iGxPya+QMk6WxLNyVgNoCtBBGhe
         u6Dr9E61a6fwbUwWQpJcQ5RORivcoudZgaalzty+6o5OMrHUcCn0r9LGGTFUD2JKh2W6
         hThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2s5Im8YH2uK7U63hireyouAIO+Pt2Pckui2xkKi8Z/g=;
        b=1RtXN5sJPziutf658bPV+jdfKUJ5gyUyskcmBnoA7AMR8XnQwOrqCvQINq7oYoZcrr
         ey2iBfiM17NVya2GsvLl0JLhzAbhh6qKtrTVfhqHeT755jGOra1fcbGfwMJIws4T7uzz
         LZY7LcTjl7vFANwB9Q/Fzpggm1rV/pyxLsR8creVZQ2hvz4Pum96ykw4jX1I0uoIHGv+
         n16rAixoDeV/dljWUXsC6h7YilRlLUI6HB0LrI90t7IvLXk5fSdnDuOKGy3kiZwDPCQ+
         6+9pUTCO6W+KmVwGealB1LK6YpPciSAQ5Ctlr5CkOyQVH1khUXczZaIVDlQPMoZVYTNZ
         nC6Q==
X-Gm-Message-State: ACrzQf00xmlBrsWnXioxdE2Rp4ySCCL7GAeYgWLag5NjxVC6Zu6IjFEr
        qkzo50K/zKKZiFHQy25Taa3ctgbdjH5XSI2M74o=
X-Google-Smtp-Source: AMsMyM4IOOYQcGlpaTyFt1tkVZ4e1cDxij1c+XecvRaK9eAydYy5u1odf+ik5hk1qXlOR//gClwJmLAceEHelTDpy5M=
X-Received: by 2002:ac8:7f92:0:b0:344:8cd8:59a1 with SMTP id
 z18-20020ac87f92000000b003448cd859a1mr7703789qtj.384.1663403140990; Sat, 17
 Sep 2022 01:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220917081339.3354075-1-jjhiblot@traphandler.com>
In-Reply-To: <20220917081339.3354075-1-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 17 Sep 2022 11:25:05 +0300
Message-ID: <CAHp75VcpgVyAmzZ4hRXgUKN9vjbO-5yaJS0V28ZfSwJ7qwqxkg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/4] Add a multicolor LED driver for groups of
 monochromatic LEDs
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sha@pengutronix.de
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

On Sat, Sep 17, 2022 at 11:14 AM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> Hi,
>
> Resending this series with only a minor modification in the binding
> example after the comments from Sascha Hauer.

I would suggest to Cc a new version (if required a new version) to
Lee. It was a discussion about advancing the LED subsystem patch queue
with his help.

> Original v3 message:
>
> Some HW design implement multicolor LEDs with several monochromatic LEDs.
> Grouping the monochromatic LEDs allows to configure them in sync and use
> the triggers.
> The PWM multicolor LED driver implements such grouping but only for
> PWM-based LEDs. As this feature is also desirable for the other types of
> LEDs, this series implements it for any kind of LED device.
>
> changes v2->v3, only minor changes:
>  - rephrased the Kconfig descritpion
>  - make the sysfs interface of underlying LEDs read-only only if the probe
>    is successful.
>  - sanitize the header files
>  - removed the useless call to dev_set_drvdata()
>  - use dev_fwnode() to get the fwnode to the device.
>
> changes v1->v2:
>  - Followed Rob Herrings's suggestion to make the dt binding much simpler.
>  - Added a patch to store the color property of a LED in its class
>    structure (struct led_classdev).
>
> Jean-Jacques Hiblot (4):
>   leds: class: simplify the implementation of devm_of_led_get()
>   leds: class: store the color index in struct led_classdev
>   dt-bindings: leds: Add binding for a multicolor group of LEDs
>   leds: Add a multicolor LED driver to group monochromatic LEDs
>
>  .../bindings/leds/leds-group-multicolor.yaml  |  64 ++++++++
>  drivers/leds/led-class.c                      |  27 ++--
>  drivers/leds/rgb/Kconfig                      |   6 +
>  drivers/leds/rgb/Makefile                     |   1 +
>  drivers/leds/rgb/leds-group-multicolor.c      | 153 ++++++++++++++++++
>  include/linux/leds.h                          |   1 +
>  6 files changed, 238 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
>  create mode 100644 drivers/leds/rgb/leds-group-multicolor.c
>
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
