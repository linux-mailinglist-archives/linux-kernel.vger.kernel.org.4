Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9500D612639
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 00:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ2W2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 18:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2W2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 18:28:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E963F301;
        Sat, 29 Oct 2022 15:28:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d24so7790753pls.4;
        Sat, 29 Oct 2022 15:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tbcUW3EGHqZ1aUTPa7cgPRzB5H7yKCIyPyV7RLLkwaE=;
        b=o7NRpJTcFIrBjvV1RUznTlSijFbuLNff9eO/2Uqy1luFkL4JGOL8oebnSj85/ckr4c
         852X+jfBqMXHHDaeyrHR2Ij2gSzhPGgcvyAFLx1fFLRZhoOySpXxJG3RcSzdNhdDMAiB
         bcBbAhBRn2QJy83rWdc9Hw5YWdOKL28GRTpcxeCUskSfSS8tZknmSRVMNIPmXAweRiM5
         ab8Q0SwyhcE4RkazhbVvH3X42fpvZTFJCpQHAl/ZBkb3B4aLKxTGi04S10HRlzoGb6IQ
         4NDlO2DdvfZN6tQvwozRYbNwVnC3OUgS6u9CCgmCUUvpKWtuGzxykmUMH72eehR8Ejh0
         0uTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbcUW3EGHqZ1aUTPa7cgPRzB5H7yKCIyPyV7RLLkwaE=;
        b=DnhPvzeaVt1tRouKVPFXAJ/BUcWBp6guPiBinImxhr19YKUjtZ51hPOAIOd1k7o0oO
         +j0oKrWLjG5bzeYgfEGctTLm0JZf9GbX4AtcrjmLnGAnZaL4s0iXftVimGqtpQb6kfEk
         VlJhhVimzcquaANkNO/QV+Q5boE0C407VGEM8EewLgsMZ2KpKSRhEqzVHKKoOyqLlrqI
         YAW2+1ebQgW0qVfvm32cW1rjK6Srj6mjxsl4yV3BpGUbA5hEuoVElhEeOHhRYQywsLcL
         RPVRPAO/0SJ8/Tl2ELMWnjszf9cUBqAas2U7tslXbkeRHF+M2eDs9fgjMJNB5WilJKEn
         wKaQ==
X-Gm-Message-State: ACrzQf3kOCxQcBQn5lDRgNJvEkpDde3JapS/xxW5D7tU/muoy6es9pdi
        31AjsED8PZ+Dw1jCvJQq8NKoYKgPI/0=
X-Google-Smtp-Source: AMsMyM5bQdcW8NIPlmefqQV5VXfOA/9Z5cnsKjn/nnqOM7aIS0hCqUkM5tRqArXuNDCo9Q3bhICwLA==
X-Received: by 2002:a17:90a:e7c5:b0:213:b7d8:1c4c with SMTP id kb5-20020a17090ae7c500b00213b7d81c4cmr3620046pjb.114.1667082492301;
        Sat, 29 Oct 2022 15:28:12 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id w2-20020a62c702000000b0056186e8b29esm1706059pfg.96.2022.10.29.15.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 15:28:11 -0700 (PDT)
Date:   Sat, 29 Oct 2022 15:28:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] Input: matrix_keypad - replace header inclusions
 by forward declarations
Message-ID: <Y12o+Hk2qsIsDQUo@google.com>
References: <20220923184632.2157-1-andriy.shevchenko@linux.intel.com>
 <20220923184632.2157-2-andriy.shevchenko@linux.intel.com>
 <20221029142551.GA3222119@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029142551.GA3222119@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 07:25:51AM -0700, Guenter Roeck wrote:
> On Fri, Sep 23, 2022 at 09:46:32PM +0300, Andy Shevchenko wrote:
> > When the data structure is only referred by pointer, compiler may not need
> > to see the contents of the data type. Thus, we may replace header inclusions
> > by respective forward declarations.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  include/linux/input/matrix_keypad.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
> > index 9476768c3b90..b8d8d69eba29 100644
> > --- a/include/linux/input/matrix_keypad.h
> > +++ b/include/linux/input/matrix_keypad.h
> > @@ -3,8 +3,9 @@
> >  #define _MATRIX_KEYPAD_H
> >  
> >  #include <linux/types.h>
> > -#include <linux/input.h>
> 
> Possibly, but may other drivers rely on those includes.
> This results in widespread build failures such as
> 
> Building arm:allmodconfig ... failed
> --------------
> Error log:
> In file included from include/linux/input/samsung-keypad.h:12,
>                  from arch/arm/mach-s3c/keypad.h:12,
>                  from arch/arm/mach-s3c/mach-crag6410.c:57:
> arch/arm/mach-s3c/mach-crag6410.c:183:19: error: 'KEY_VOLUMEUP' undeclared here

I fixed this particular instance, hopefully it is one of the very
last of them...

-- 
Dmitry
