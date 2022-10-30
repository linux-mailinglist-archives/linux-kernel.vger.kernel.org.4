Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCAC612750
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 05:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ3Edt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 00:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJ3Edq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 00:33:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF86B43AE4;
        Sat, 29 Oct 2022 21:33:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q1so8089532pgl.11;
        Sat, 29 Oct 2022 21:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JE+Cpx8gz9CyCX2ai+Cb3t6Lx3puUd2mwGc7R/DG84g=;
        b=f/FgDWRl2aWLKl5ZZxuNKZxmCKxjvbYSHt3iCCUxlUVoIh7fKvkgoHfUJ6UZlK6ztL
         ObFO0jJqLnEOOq7Q8AsUMDuCv7M3IAGCdXR/vR49tB/MI55RW10X0ioKNlbVMUVrSMX7
         cSEtkg6eJmF6rHDK50aIwPH/57NVGWzPCfv3tEAXX4LQqf4qf/+kUp8bCHy8rAtSO3uE
         60j/tfonM+Ty8/9kl00kgAsQPedF5032YqQfqxsvlgBpG53TDpn1kHNVw3CVYjpdLy2Z
         fjwwD7MHZonSZOtzas+kk2HU6zgrBsw5oqDz4D+LmcffBPTiegyeY4YSLh+0r9/JJA7s
         aGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE+Cpx8gz9CyCX2ai+Cb3t6Lx3puUd2mwGc7R/DG84g=;
        b=amn/bDh0heADC3A2V8gUkibWL6VSXFCyTjdhGrSjii4D6v2OnkL8OLJ6R6NmbWmux3
         KrpCUm7FI8cAjAEwR7FJ18+Tq8O2wq2uZm1gvdDezIotYMuPy/JP6R8MPSlvNpeG0xLG
         80+uJHNmPfBJvp0lV+88hcI+7MgvH+H09apZ2s5urcKa85AcIIzJmQt8hvz6M8Dma1c8
         LqGPfXEfMnFMtZ2Aaa+y11H11CkHnjtr4FI5rHuocffnP8+XBjcwaJXmBDGMAtK+Oops
         o8mkGgVTy51wHuNxsfv+wAoSTClaiip+z65E7DCsKz/ZRm5HdkvrO/9dKsx/xN0OwORx
         UjpQ==
X-Gm-Message-State: ACrzQf2D2+I30YGgq2MQnlT8ZEzorPdP/LFXXe5W8SR8WZuRSuEVFdaD
        3x1AuJhYJ7o2WPMztk0ubGE=
X-Google-Smtp-Source: AMsMyM5jZxv791wnCxf+9HnPPZLTOXAaiqvy8q8yLaSrwUJOR8AvtRRZ9GQ92iw4tRMDNhisL4WRWg==
X-Received: by 2002:a62:19cd:0:b0:56b:6a55:ffba with SMTP id 196-20020a6219cd000000b0056b6a55ffbamr7412358pfz.85.1667104424647;
        Sat, 29 Oct 2022 21:33:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id m18-20020a62a212000000b0056bd737fdf3sm1928193pff.123.2022.10.29.21.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 21:33:43 -0700 (PDT)
Date:   Sat, 29 Oct 2022 21:33:41 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] Input: matrix_keypad - replace header inclusions
 by forward declarations
Message-ID: <Y13+pV6ga5DqXyQF@google.com>
References: <20220923184632.2157-1-andriy.shevchenko@linux.intel.com>
 <20220923184632.2157-2-andriy.shevchenko@linux.intel.com>
 <20221029142551.GA3222119@roeck-us.net>
 <Y12o+Hk2qsIsDQUo@google.com>
 <086d381d-bc6f-7dd3-35b6-d05afe742b9e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086d381d-bc6f-7dd3-35b6-d05afe742b9e@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 04:02:56PM -0700, Guenter Roeck wrote:
> On 10/29/22 15:28, Dmitry Torokhov wrote:
> > On Sat, Oct 29, 2022 at 07:25:51AM -0700, Guenter Roeck wrote:
> > > On Fri, Sep 23, 2022 at 09:46:32PM +0300, Andy Shevchenko wrote:
> > > > When the data structure is only referred by pointer, compiler may not need
> > > > to see the contents of the data type. Thus, we may replace header inclusions
> > > > by respective forward declarations.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > >   include/linux/input/matrix_keypad.h | 5 +++--
> > > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
> > > > index 9476768c3b90..b8d8d69eba29 100644
> > > > --- a/include/linux/input/matrix_keypad.h
> > > > +++ b/include/linux/input/matrix_keypad.h
> > > > @@ -3,8 +3,9 @@
> > > >   #define _MATRIX_KEYPAD_H
> > > >   #include <linux/types.h>
> > > > -#include <linux/input.h>
> > > 
> > > Possibly, but may other drivers rely on those includes.
> > > This results in widespread build failures such as
> > > 
> > > Building arm:allmodconfig ... failed
> > > --------------
> > > Error log:
> > > In file included from include/linux/input/samsung-keypad.h:12,
> > >                   from arch/arm/mach-s3c/keypad.h:12,
> > >                   from arch/arm/mach-s3c/mach-crag6410.c:57:
> > > arch/arm/mach-s3c/mach-crag6410.c:183:19: error: 'KEY_VOLUMEUP' undeclared here
> > 
> > I fixed this particular instance, hopefully it is one of the very
> > last of them...
> > 
> 
> Sorry, I didn't bother listing all of them. There is at least one more.
> 
> Error log:
> arch/arm/mach-pxa/spitz.c:410:11: error: 'EV_PWR' undeclared here (not in a function)
>   410 |   .type = EV_PWR,
>       |           ^~~~~~
> 
> with arm:pxa_defconfig.

Ah, I see. Arnd is trying to delete bunch of PXA code, so I'll pull the
header change until after he merges his, and hopefully spitz will be
gone.

Do you have more examples by chance?

Thanks.

-- 
Dmitry
