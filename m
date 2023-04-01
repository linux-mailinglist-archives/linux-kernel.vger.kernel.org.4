Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DBE6D3C74
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjDCEaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjDCE3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:29:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91DFB44E;
        Sun,  2 Apr 2023 21:29:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn12so112118328edb.4;
        Sun, 02 Apr 2023 21:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680496184;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qFNuFMeHCuZuwK8vNRfkVYseskXxs9aV8QWzQeRLILI=;
        b=O3PnMJaeiVRjgZmFqpPQiFSaBFXr92sqyk3ah1yc+0fl57GLlf5rQwqcihCjbESRK5
         ucqz/wDiaDtYGuTc5vr9Rqti/ajA6ZIT6J4IjQ55dcbtINB15cNU38ONGMYqFFH7o/Ac
         MG3r1sNtmx0brEljIT1UmGbERDmYV4At39yezlMxfuXuJRiMvlbFy94oF91r61C5+CEz
         xvOT0T7CZmpyNjztyG+cIpuafVFDsHadAwhSl5LBU9kLdNvGu0c340tJj1N9WgrQIny1
         QwQ1O939ji+KBa2PP1bMvjgJARNEydve0N0idWO9st/ywDj8KfcGGqB42LGt3KkpDOFz
         xLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680496184;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFNuFMeHCuZuwK8vNRfkVYseskXxs9aV8QWzQeRLILI=;
        b=2gyMvo74MDd2la7f87gLj/6T4B5HO/QYD6PYNDcS6gSW0jDTbSe8NSUYa/ZeGBflzb
         kLwnd+ntA9st2Es0leHkqfJHVISqJ9IyGIwJ0UfW1Mwkq/ZaysvQqs3umI1C88v25wxL
         yuKxOEvecOMSFIF73W82D+dVGPXMIp6sphMeeQMETAdRH0GV7QsdAn8gTxKAfqi53rXe
         Q9gw1fOg81QswzA8An/4NVtx39rtgrt7V+bLHqvCt0BF0/70SjVOVbgLc0ZDPVSQKcNG
         efWDDZReLK+eCZbANpD842An127H10LHnGSThsCLBT6QveWyurhmV3hshgvKhYewwiuX
         269A==
X-Gm-Message-State: AAQBX9fJwptR0+EKMwMaxkkSlAc5BQ/ZnLFNIC+rwy+h+pSeYgt/tMf/
        7ZnbAzWu4QiBQImfjQDzCfCzMKFSQNK+EA==
X-Google-Smtp-Source: AKy350ZjZPbag5cF4XJQDqkW5bqMlJoau4o3/q62fncdXEzK8jryyCYRpb3EBvtNhLUi0AzMg1eYXg==
X-Received: by 2002:aa7:c6c8:0:b0:4f9:deb4:b986 with SMTP id b8-20020aa7c6c8000000b004f9deb4b986mr28281834eds.7.1680496184531;
        Sun, 02 Apr 2023 21:29:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e27-20020a50d4db000000b004fadc041e13sm3996858edj.42.2023.04.02.21.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 21:29:44 -0700 (PDT)
Date:   Sat, 1 Apr 2023 11:22:52 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Li Yang <lidaxian@hust.edu.cn>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: renesas: renesas-soc: release 'chipid' from
 ioremap()
Message-ID: <d2688eb2-d7b6-4e80-a13e-55ed541ac9b8@kili.mountain>
References: <20230331095545.31823-1-lidaxian@hust.edu.cn>
 <CAMuHMdV5guFbo76nq27aZjWsYqneOfGNf0Ozyh0C53+VgnXgXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdV5guFbo76nq27aZjWsYqneOfGNf0Ozyh0C53+VgnXgXw@mail.gmail.com>
X-Spam-Status: No, score=0.5 required=5.0 tests=DATE_IN_PAST_24_48,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 02:13:10PM +0200, Geert Uytterhoeven wrote:
> Hi Li,
> 
> On Fri, Mar 31, 2023 at 12:14 PM Li Yang <lidaxian@hust.edu.cn> wrote:
> > Smatch reports:
> >
> > drivers/soc/renesas/renesas-soc.c:536 renesas_soc_init() warn:
> > 'chipid' from ioremap() not released on lines: 475.
> >
> > If soc_dev_atrr allocation is failed, function renesas_soc_init()
> > will return without releasing 'chipid' from ioremap().
> >
> > Fix this by adding function iounmap().
> >
> > Fixes: cb5508e47e60 ("soc: renesas: Add support for reading product revision for RZ/G2L family")
> > Signed-off-by: Li Yang <lidaxian@hust.edu.cn>
> > Reviewed-by: Dan Carpenter <error27@gmail.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/soc/renesas/renesas-soc.c
> > +++ b/drivers/soc/renesas/renesas-soc.c
> > @@ -471,8 +471,11 @@ static int __init renesas_soc_init(void)
> >         }
> >
> >         soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> > -       if (!soc_dev_attr)
> > +       if (!soc_dev_attr) {
> > +               if (chipid)
> > +                       iounmap(chipid);
> 
> We don't really care, as the system is dead at this point anyway.
> 

Why even have the check for NULL then?  The kzalloc() is small enough
to the point where it litterally cannot fail.

This patch is already written, it's way less effort for us to apply it
than it is to debate its worth.  I kind of feel like it's better to just
fix the bugs even when they don't affect real life.  Otherwise it's a
constant debate with bugs if they're worth fixing.

This is a university group and they're looking for bugs to fix.  I'm
like, "I'm drowning in resource leak warnings and I don't even look at
them any more because they're basically all trash that no one cares
about."  So I was hoping to maybe clean up the trash a bit to the point
where we can start caring about the leaks.

regards,
dan carpenter

