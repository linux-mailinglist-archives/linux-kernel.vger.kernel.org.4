Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A385ED593
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiI1HAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiI1HAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:00:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E980193FE;
        Tue, 27 Sep 2022 23:59:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dv25so25075552ejb.12;
        Tue, 27 Sep 2022 23:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Fbzb3euA2ZAgHD+Nl9yGVh9jtokxf9nkdqdpwnlZ3QU=;
        b=B11rtlM6SDYKPsEKmY2DwW3kIA+2ovSYbvLddlhv/z/ja0wQkw8PwMW7EJuDRAWWii
         IFjzuhq+nY2ZKVDHhRfc934kveiegXro6YqiItHv+dq5fhjQnV2BpgCTl8ZjsBvPHRvm
         J8NiKGElif4TR952g0hyWIwnyZNtGA4OahMTiLfGmgHujaDARL1LwtHcHx00MlaaTmfQ
         e6379Vi4Tc8L2VNqGsdhnk59TIrsyFU9VcrRSvUpqpaCZ9RfYpRYvKSdqSlhm40xDsnr
         EQdDPhEkOZWtmP71OUOAzRpgc0vrrwLhyczmSVkOl34LyjvKjc7y5ZHyYCnSjVtr1ZNi
         g6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Fbzb3euA2ZAgHD+Nl9yGVh9jtokxf9nkdqdpwnlZ3QU=;
        b=gRmGO30F3/bADkV0T+UjOY05Q6uY7VNryxLpGMfe5wO1XU7uFSz2RiSpOXnC0LRzSB
         seYtt0qyoJbq6J438F1j6AcKjxol98Z5z+3S2QOAFnwH9pmba9b+65AWUFb2zA0YfAlt
         FUdxrStEBWGOyTOLxSkRZhReEOoTc2tkYJO28xbTNFC9eGOnBW4huGB3ixKEjkh24OCO
         LkOM5glbPlDvqSq6ySjb1nJE5AZbK+ZozNbNlrn23KX2NiYwzbkpGq+sUkiQx15cPetS
         FzYAFo8IMjA2jqpui6gXKZg2q/zfBt49++VAVmOyjJhr1ThEyKISvC3Fbzz4SIZP5bEw
         c+5A==
X-Gm-Message-State: ACrzQf2yJ8Ro2Ryq2TW9rRfdwoNWHJ1wYIOJlpHhZNKXwUvzHoZdgUmB
        JZjmi6kBDQZ2vBD6lcx6ze9/jJ3ehGqM0e9FPWs=
X-Google-Smtp-Source: AMsMyM54gHZJclG7o6G5xwYto5Dz/yoX/Rcbxpz7ICtcvcxGOzAfllv5KBLV20Tjy+6vTzoJ4qIF5ZLtPdiT3LYolY8=
X-Received: by 2002:a17:907:c09:b0:781:ea21:3f69 with SMTP id
 ga9-20020a1709070c0900b00781ea213f69mr24847183ejc.413.1664348394341; Tue, 27
 Sep 2022 23:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220926135922.24541-1-dzm91@hust.edu.cn> <BYAPR07MB5381FCC10ABD4F92E47CF6D9DD549@BYAPR07MB5381.namprd07.prod.outlook.com>
 <cd5455e9-b9ea-9376-1440-3dbf790d4c24@kernel.org>
In-Reply-To: <cd5455e9-b9ea-9376-1440-3dbf790d4c24@kernel.org>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 28 Sep 2022 14:57:56 +0800
Message-ID: <CAD-N9QV0Y9eduWD2N3Fmkmt_CW-EwmQVvpQOWx9BozS8hX3t_w@mail.gmail.com>
Subject: Re: [PATCH] usb: cdns3: remove dead code
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Peter Chen <peter.chen@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, Sep 28, 2022 at 2:49 PM Roger Quadros <rogerq@kernel.org> wrote:
>
> Hello Pawel,
>
> On 28/09/2022 09:40, Pawel Laszczak wrote:
> >>
> >> From: Dongliang Mu <mudongliangabcd@gmail.com>
> >>
> >> Smatch reports the following error:
> >>
> >> drivers/usb/cdns3/cdns3-plat.c:113 cdns3_plat_probe() warn:
> >> platform_get_irq() does not return zero
> >>
> >>From the document, platform_get_irq_byname_optional only returns
> >> non-zero value, and negative value on failure.
> >>
> >> Fix this by removing the zero value checking.
> >>
> >> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> >> ---
> >> drivers/usb/cdns3/cdns3-plat.c | 2 --
> >> 1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
> >> index dc068e940ed5..2bc5d094548b 100644
> >> --- a/drivers/usb/cdns3/cdns3-plat.c
> >> +++ b/drivers/usb/cdns3/cdns3-plat.c
> >> @@ -110,8 +110,6 @@ static int cdns3_plat_probe(struct platform_device *pdev)
> >>      cdns->wakeup_irq = platform_get_irq_byname_optional(pdev, "wakeup");
> >>      if (cdns->wakeup_irq == -EPROBE_DEFER)
> >>              return cdns->wakeup_irq;
> >> -    else if (cdns->wakeup_irq == 0)
> >> -            return -EINVAL;
> >>
> > I think that here we should have:
> >       else if (cdns->wakeup_irq == -ENXIO)
> >               return -EINVAL;
> >  because of function:
> > platform_get_irq_byname_optional -> __platform_get_irq_byname returns
> > irq number (>0),  -EPROBE_DEFFER or -ENXIO
>
> But this is changing functionality and should come as a new patch.

I agree. Pawel, you should submit a new patch. This satisfies the rule
of kernel patching.

>
> The original patch is correct as it doesn't change existing code
> functionality.
>
> >
> >
> > thanks
> > Pawel
> >
> >>      if (cdns->wakeup_irq < 0) {
> >>              dev_dbg(dev, "couldn't get wakeup irq\n");
> >> --
> >> 2.35.1
> >
>
> cheers,
> -roger
