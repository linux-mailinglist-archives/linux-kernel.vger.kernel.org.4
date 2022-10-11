Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BCF5FB45A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiJKONR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJKONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:13:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849925925D;
        Tue, 11 Oct 2022 07:13:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p14so9293794pfq.5;
        Tue, 11 Oct 2022 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=czRWuspWIHlagJO4TEuyucASTDboV9sDSZyO/JWLXqc=;
        b=Ce+BVV5v8U7whmYd/FcwKuyV+liXHdnCihvE4vxDmi/zFRXHgG5BsKzJlkvJm3ymzp
         i0kk+obd9ehg5kvdXpvifSYQKkIBJbAwLGSIa8MzHAOItPx5O2ghaGpv98wheUqfKMtx
         xYK29jqCSGAVqjF4MPQoXzVWPbY3qWyTm0lvTcEBlWPddeF6YcST3WGeI8+5CF6qMkzB
         /lDnL0m98oNEh6bOyWy8Twswwetn33Cy9kGtv+34nK50zqhZaf/wZPS7BxRAs1neYTBy
         /bZWo8ysVbEXrzMM/+HfoBHs8qu8Q0eGt0b+IXToEUouhHiAP9GLUrTwNKB7EENxNPMI
         wO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czRWuspWIHlagJO4TEuyucASTDboV9sDSZyO/JWLXqc=;
        b=R5OW/P2QXydePMlNxYLey0Q6+T7On62EK5bvSbvfdGOzozkk+z9NzDIWd2SdHvuMXv
         5dIY7zkzXo8Ya4KSifj1KhsCgbEfFZ21ZmSdN5asPC9dMfGrgGra8E2pDDJC4XP/q9ps
         Y7+feMlvoGHjLvPzGWINtt3pLgCdtvkpxGk2cXrow/897iIyNzvzz8Yt/2sjh1kmjWmO
         BOE34JhS7QsxsFfGPCm6VoW1p2gMuVVBiUVh1ZbEuWaocfZOHMxgVTmKmuAtW2ffhvzu
         XzkOTkUx42uRDnstC4mUeC0tD7OA+nwQp2UnV5HT6tIJFba9S0/WH2R+g8P/F45c/Eol
         XsmQ==
X-Gm-Message-State: ACrzQf0wsGj09y/1GVcNqcmVDUHJVu0r/Dv40s5iUUT7j/13aVrZEj7q
        WqrvNl0eCibcawR+dypxVgU=
X-Google-Smtp-Source: AMsMyM6A7bmN99+8aFFd/V9x8yL+08obUJvhZG8B8wKWgbvIl/Bh1jOgBftu0u99farGA2SFP/OdqQ==
X-Received: by 2002:a63:8643:0:b0:462:9b02:a0c1 with SMTP id x64-20020a638643000000b004629b02a0c1mr8758435pgd.536.1665497593024;
        Tue, 11 Oct 2022 07:13:13 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id q17-20020aa79831000000b00563ce1905f4sm1492741pfl.5.2022.10.11.07.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 07:13:12 -0700 (PDT)
Date:   Tue, 11 Oct 2022 22:13:02 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-actions@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 02/36] gpiolib: cdev: Add missed header(s)
Message-ID: <Y0V57gI75ik4ki3A@sol>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-3-andriy.shevchenko@linux.intel.com>
 <Y0SyVwjDl7NGfTPn@sol>
 <CAHp75Vf4oS8g0zxgismtLrzsJ7AE-bdMEq+GAzx2=Mwnhuk3UA@mail.gmail.com>
 <Y0V0IXF3sASTGdMU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0V0IXF3sASTGdMU@smile.fi.intel.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 04:48:17PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 11, 2022 at 11:05:42AM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 11, 2022 at 3:02 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > On Mon, Oct 10, 2022 at 11:14:18PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > -#include <linux/gpio.h>
> > > >  #include <linux/gpio/driver.h>
> > > > +#include <linux/gpio.h>
> > > > +#include <linux/hte.h>
> > >
> > > Ok with the hte re-order.
> > >
> > > But moving the gpio subsystem header after the gpio/driver is not
> > > alphabetical ('.' precedes '/') and it read better and made more sense
> > > to me the way it was.
> > 
> > I see, I guess this is vim sort vs shell sort. Strange, they should
> > follow the locale settings...
> 
> I have checked, the shell and vim sort gave the same result as in this patch.
> 

The original order (sans hte.h) was done by VSCode Sort Lines Ascending,
and that still returns the same result.  That matches what I would
expect to see given the content of the text.

And for me vim also gives the original order.

Just to confirm - is '.' 0x2e and '/' 0x2f in your universe?

Cheers,
Kent.



