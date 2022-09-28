Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DAA5ED5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiI1HHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiI1HG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:06:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE91C889B;
        Wed, 28 Sep 2022 00:06:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dv25so25108301ejb.12;
        Wed, 28 Sep 2022 00:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=A5+YMGtWjt1zsaH64sHGQzeK7M+r0C7weghd3as6lXU=;
        b=Vc0C+i0nGDBMb7MkXWuP2yrI6k9/Q9tnTA3e3II7+F5BR5g5s5X9Idt1xXd6LU0wOZ
         Jn2wzv/fBppQYTtH3W6gUD+Z4zpspK836By8xK8e+Sc6J8lhB8pGsz0RHCRrzhMLOqCU
         GBoPSX/kXDKJxtX2t3AMwqMxSHRCb/vtLusKowXI720np4r0dAhl/bYKsmVFetHzEA7n
         K5r0oD0hAFjKIQgRzXRflzRRfzUkyL529QrzOD8uMOm1wZYX0ZyD8Gz/r0Ub/8K4cCKh
         0p8i5aXYq7UUwZJSMbU2ksbHs6/l6MIEct42gbIe7XGslXkClURPgAhxxy27OTsBWXFL
         9cHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=A5+YMGtWjt1zsaH64sHGQzeK7M+r0C7weghd3as6lXU=;
        b=0F6ryZRdr5AolQY/3VNEZN/4Po7vsFqG9MXlfsEAMI4SwoGKzJQ1g3qK8Qt8nsZlnl
         C6jO/pSWbUxZVl38ZQ3QTN7wms/Brb+Q7KK+IA2vBJGfXdJixbe5ervFgATO8goxWYIg
         w5KXbjm/VNg976kgSeeOEJDZfV92fTYYmgqOLccsI5hSH/ASdzKoGiZFfWHZN7ju+QHj
         rZJtsToRKLgxlX27o+GJ5fF8fw0SrDB9NyNGmeoL2gXxGN/QdUX5HRyzKEGGud8m/rYO
         wXQX1Pzcu4LYG51tfF4L9UrciPrfendLJgKR70U0wqhYfmf29m7PRrwjaUaGZc48/pEk
         eFfg==
X-Gm-Message-State: ACrzQf3bcWYRiY5cLqUlX3GtiQTdluY4K1dGxH9F98GK/bjGlrTfsLSB
        unN6P6/PJ4lDgh8TMXEF96jAkt0hJi3ic27Dp0FaEXswhHanLNQO
X-Google-Smtp-Source: AMsMyM48aac9VIKFH2aErX6RmHEzKyUQp7TSRvM5RRdNK9u9u3Kd47K7f1tvTTZvIUypplQcmCDXj8qu7/LrtLa7l/k=
X-Received: by 2002:a17:906:8a6b:b0:780:ab37:b63 with SMTP id
 hy11-20020a1709068a6b00b00780ab370b63mr25821330ejc.365.1664348814125; Wed, 28
 Sep 2022 00:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220926135922.24541-1-dzm91@hust.edu.cn> <8db6ca9c-6ceb-001e-3427-c7e320111d80@kernel.org>
In-Reply-To: <8db6ca9c-6ceb-001e-3427-c7e320111d80@kernel.org>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 28 Sep 2022 15:04:55 +0800
Message-ID: <CAD-N9QWXPf0_d=mEJ3c6NNfw1V9kdTm66+-jUT9heD4Z+L6kHQ@mail.gmail.com>
Subject: Re: [PATCH] usb: cdns3: remove dead code
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Sep 28, 2022 at 2:50 PM Roger Quadros <rogerq@kernel.org> wrote:
>
>
>
> On 26/09/2022 16:59, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > Smatch reports the following error:
> >
> > drivers/usb/cdns3/cdns3-plat.c:113 cdns3_plat_probe() warn:
> > platform_get_irq() does not return zero
> >
> > From the document, platform_get_irq_byname_optional only returns
> > non-zero value, and negative value on failure.
> >
> > Fix this by removing the zero value checking.
> >
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

Hi Roger,

By simply checking the usage of API - platform_get_irq_byname_optional,
there are several issues in other code sites.

However, some code sites are related to semantics. I will analyze all
of them and submit patches later.

>
> > ---
> >  drivers/usb/cdns3/cdns3-plat.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
> > index dc068e940ed5..2bc5d094548b 100644
> > --- a/drivers/usb/cdns3/cdns3-plat.c
> > +++ b/drivers/usb/cdns3/cdns3-plat.c
> > @@ -110,8 +110,6 @@ static int cdns3_plat_probe(struct platform_device *pdev)
> >       cdns->wakeup_irq = platform_get_irq_byname_optional(pdev, "wakeup");
> >       if (cdns->wakeup_irq == -EPROBE_DEFER)
> >               return cdns->wakeup_irq;
> > -     else if (cdns->wakeup_irq == 0)
> > -             return -EINVAL;
> >
> >       if (cdns->wakeup_irq < 0) {
> >               dev_dbg(dev, "couldn't get wakeup irq\n");
>
>
> cheers,
> -roger
