Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C1D641712
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 14:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLCNkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 08:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiLCNka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 08:40:30 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED9D1D667
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 05:40:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so2649877wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 05:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NMltp6zd8QZS4GQRHIbc7N5NBSDI6lRWzkm44FFSyY=;
        b=UUfJfjLOApqouUil5C5u0XKtTEZpl8XwY/3SKdgCvdtiT0JxyAPJDDPeT8xQIgdpGy
         9VVRhUNCJ++sc0FunLqB1GPKF0L+S26E6ZMQQll1SgD34HtR38716xWRreEr5aF0H58n
         G24m2u2NeyeZ+bmySKprTGl529MndilBQsVDV0UIjcbLlWzhZlcUOaa/Q0A0OuyJzGH2
         CpQEeCSua9EtGa0VtKQ6Q/qtlEY46tosK3mQNLNZ8aRvG1S4F3pvkIu8KGXKUvbqVztq
         z0yRBx0zMrDIw2mmgltQWG/+hmEjlJ83MpejcjfGQrKl5M7Eu11TY+56wDx2VSjqVYTb
         hmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NMltp6zd8QZS4GQRHIbc7N5NBSDI6lRWzkm44FFSyY=;
        b=eBR3U5UNrfPHKfNYJWPW3aR/DwA2bXqfAQsdeBE2zyx01zAPrA9TInC1GUeg+mQb6+
         f2y3DwMl5MPAYmQTDd9696p9G6Wpiv8vWoFtoTKQL54sLQUKYjgZ+UcTox/Xgr+YWc8N
         wd1TpOqxx/p1M4hFpnSrrrAEEL7Srr1nhNCMPKvMIEtdcf8oWXNzvyneQBx1mhTN9DDw
         cCnSVBt68Zc70IN2p7ihRRlxxxI6GJtzOy3s5DH+KOuYUcRaiqQX19aqEcjCwADv4U5o
         J7XYh595MAtSDhNipbyBaX2iRInn++hmZl9knUB2aLqe9chcqdkUKcbWyGLKPhwQMT0J
         hIKQ==
X-Gm-Message-State: ANoB5pnfnQiEhoM+iLvI1exK/uggeHo7fgkJNi3nY0Q9Q1vvrWfSO7CX
        jEC1EcS0r/zPy95MDv86YrAPlA==
X-Google-Smtp-Source: AA0mqf4XepvQu8SCbGWIRhoC0afqYPkI2JwH0NCii/cfoqFm0KDy/jm2IcoYPmzBz/6f1YpYvPmQ/g==
X-Received: by 2002:a1c:7504:0:b0:3cf:6b10:ca8d with SMTP id o4-20020a1c7504000000b003cf6b10ca8dmr59256540wmc.44.1670074828017;
        Sat, 03 Dec 2022 05:40:28 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b003b4fe03c881sm17130392wmq.48.2022.12.03.05.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 05:40:27 -0800 (PST)
Date:   Sat, 3 Dec 2022 13:40:26 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>
Subject: Re: [PATCH v2] Documentation: sched: Add a new sched-util-clamp.rst
Message-ID: <20221203134026.ert6kax2f3okajj2@airbuntu>
References: <20221127142657.1649347-1-qyousef@layalina.io>
 <Y4V5lDHNqYHEzEaI@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4V5lDHNqYHEzEaI@debian.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 10:16, Bagas Sanjaya wrote:
> On Sun, Nov 27, 2022 at 02:26:57PM +0000, Qais Yousef wrote:
> > The new util clamp feature needs a document explaining what it is and
> > how to use it. The new document hopefully covers everything one needs to
> > know about uclamp.
> > 
> 
> For patch subject, better say "Documentation: sched: Document util clamp
> feature".

ACK.

> 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> > 
> > Changes in v2:
> > 
> > 	* Address various style comments from Bagas
> > 
> 
> I don't see any of my wording suggestions from [1] being applied. Still
> a rather confused to read (maybe should be applied on top of jon's
> suggestions)?

Apologies! It was an oversight from my side when I revisited the thread and
reworked the patch. I got confused somehow.

All applied now almost as is. There was one tweak that used "40% utilization"
that I replaced with "40% performance level" instead.

Thanks a lot!

Cheers

--
Qais Yousef

> 
> [1]: https://lore.kernel.org/lkml/Y3II59dyKuvQGIhG@debian.me/
> [2]: https://lore.kernel.org/linux-doc/87cz976pwn.fsf@meer.lwn.net/
