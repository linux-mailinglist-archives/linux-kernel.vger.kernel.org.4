Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C160A897
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiJXNI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiJXNH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:07:26 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DC79AFFB;
        Mon, 24 Oct 2022 05:21:09 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id r18so8498272pgr.12;
        Mon, 24 Oct 2022 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HjYrkoNn/w9eCU7yrVbjTDIZhBvPD6ZScXpgw+5hr9c=;
        b=jmeE2A9PVXonUBLYE7PJ3793dNwil86xAYE9ljfjd4t7qocg4X07EmUOSvkoi4GWGg
         3j7buNCyCfdU5fd4gxgIr6A7CxvUQbD/Zx1vuS2ckTB8oZxX4qQf9zGjUtYY8MuHN2NG
         KsByZ0HVvYKE6ftkVe10Iydy36VWtFpm4iwamAw4tUPqdUzqLF8xPEAro1qVFWflaBX2
         e94veiUelAor5mzz64bjMgHnN6tXsJBP6hApA2LPApkRiMHl44NyQUR/zmZ7edBiaLoF
         WU6zsVkKbCV1MyLiT+x7ZXHIaw7e68CK+CjLXpn0zFsTXD6Z/nswLva84gPZ47LRHqkX
         diSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjYrkoNn/w9eCU7yrVbjTDIZhBvPD6ZScXpgw+5hr9c=;
        b=Zyqg3oLXaCc20ECid6x4dwOrAAXNDSBlpKkr0qFw50QRitZ9/SgZfrfQq8SzBdspZM
         joVYb6/djrw9Tu4kzksBQUAE8E3FwqiXiE+RwfLhYFJl1yKACIQJFZ9NQ5ZZz/GLgSyk
         VW0inUQSDx+Z8ZpuJZzNYnu7FCtkGkhp1rgUwo2uRzut2IxJWIZn4BlG16/PMXoYNqJ9
         +rXauJ2Jpu/CDgPQKDmiXlZS/koKkG9uKzaNKDy/WYxmtaCLb0YIjR9b1Y7aLN/ZJ58f
         Hs1MjbavJAyqdfZmEVIY3Vh8zVs3KB4Zv/q9o4YtIabVgNH7eq38U8WE3BsaOtg1aDvM
         XbMg==
X-Gm-Message-State: ACrzQf1dCUM3YM+MQeC8or7JtEma/+jG3vdcuHASMKo8HPeuOmkF5MbA
        u0mdgT8MDhMLS1dmbL6LlOI=
X-Google-Smtp-Source: AMsMyM7OHnkxizf4KJ+aeemoWL1KT/VYuEttV1wJurdoHjrLQOkzJDccbujMlxPQq6ufJAVJVVSMIQ==
X-Received: by 2002:a05:6a00:891:b0:565:85a7:a6e with SMTP id q17-20020a056a00089100b0056585a70a6emr32632316pfj.21.1666613891886;
        Mon, 24 Oct 2022 05:18:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3698:60f8:9964:1fb4])
        by smtp.gmail.com with ESMTPSA id y9-20020aa793c9000000b0056bfd387c97sm549994pff.39.2022.10.24.05.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 05:18:11 -0700 (PDT)
Date:   Mon, 24 Oct 2022 05:18:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Get rid of
 devm_fwnode_get_[index_]gpiod_from_child()
Message-ID: <Y1aCgJihNIqExUR2@google.com>
References: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
 <YyzYKmsjKflqT1xZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyzYKmsjKflqT1xZ@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:48:26PM -0700, Dmitry Torokhov wrote:
> Hi Pavel, Marek,
> 
> On Fri, Sep 02, 2022 at 05:55:24PM -0700, Dmitry Torokhov wrote:
> > This drops the last uses of devm_fwnode_get_[index_]gpiod_from_child()
> > from the tree and drops the stubs implementing this API on top of
> > devm_fwnode_gpiod_get_index().
> > 
> > Note that the bulk of users were converted in 2019, the couple of LED
> > drivers are all that have remained.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > ---
> > Dmitry Torokhov (3):
> >       leds: gpio: switch to using devm_fwnode_gpiod_get()
> >       leds: lgm-sso: switch to using devm_fwnode_gpiod_get()
> >       gpiolib: remove devm_fwnode_get_[index_]gpiod_from_child()
> > 
> >  drivers/leds/blink/leds-lgm-sso.c |  5 ++---
> >  drivers/leds/leds-gpio.c          |  5 ++---
> >  include/linux/gpio/consumer.h     | 21 ---------------------
> >  3 files changed, 4 insertions(+), 27 deletions(-)
> > ---
> > base-commit: 7fd22855300e693668c3397771b3a2b3948f827a
> > change-id: 20220902-get_gpiod_from_child-remove-a62638849e91
> > 
> 
> Could you please consider picking this up for 6.1? Or would you be OK
> with this going through other tree (GPIO maybe)?

*ping* Could this go through GPIO tree? Dropping this API helps with
some outstanding work that I have...

Thanks.

-- 
Dmitry
