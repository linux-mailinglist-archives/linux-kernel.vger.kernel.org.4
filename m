Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8C364E267
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLOUhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLOUhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:37:11 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119B54A588
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:37:10 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id c184so343498vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XbLIsSB3dgqBgwoNc09sfFG6OJsgoRxnvFWyrHHQZqU=;
        b=c9Nb78oCpV/p+MBfA8FnPsQj9CMC094HBaLTo0ntmu0G73JVtV8u6mwaNjPCbFve5h
         L6LshCbm5hbgrEXyym8rIYxSGEzCWuQIQDSAGjAWYVzOnJd9DNWHcmEyUowO7Oq4JZTX
         ghof8LE4D1ez3ylUa4kiEjLxVypA5q/e+MXK/PKi0YjjE9zlTzGyg08WST5Lq847jrls
         FjpWSukNoeh939gembuhVWVQDP6rB81Tru/eT00j1YSYnZZCXbXYEiRPAfrFJrKduxHT
         gbsu85M4BYyrXSrNgevlcNAPVQUmOMs1Oy9dAAK41fnAX0xW9tPFgN/oE9FDmTpRCtD8
         QQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbLIsSB3dgqBgwoNc09sfFG6OJsgoRxnvFWyrHHQZqU=;
        b=uM0nrarbhUz3WFzwUzDFh805B3FJVn/fBcL/waW6ccgn2rllFItdGqI6vN4sgHfdti
         IpA9VlmoZLhkCjZN/AnMZvTbk1qKWT8uX604lz/JkdnlGK/hfJxYPfvsCpgm1Iy0gnGS
         qof+wHg98y+91HEpT8y4hs6iUXg3ZnHik6ln2+YS+gd67WObaV0k0S99QljD3vTYPoZv
         9S2dj2cfI2qXjA7sL85iIBVENnxASO2hx99YhfHR6qR84Jk8msfVCYBwg28It4CB3m+D
         GsmjEyP3tKXE6yLjxL0sPFVjzeH4UR6uD9dluWT4HNO+FJNELKsAp3F4PlVzF5hqELzC
         LBaA==
X-Gm-Message-State: ANoB5pnoZqzfT5saY7xdW+nbAPoXk27TUKGWFCErVKrSyuhvt8tgqSFo
        S3tTq5EX1UqXO7V/UIEkgEH52xIYI8lVTaV0YTXTPg==
X-Google-Smtp-Source: AA0mqf6wD6OR5yE6mzuBWbtVy3Ifu04HAug/G5d0E3OdzvIaHPfQKJgOSmhuPMwGVhOr1S3Zwqa9a9ykU6+8ArN+RnE=
X-Received: by 2002:a05:6102:5ee:b0:3b1:a1c:3cab with SMTP id
 w14-20020a05610205ee00b003b10a1c3cabmr19263442vsf.46.1671136629034; Thu, 15
 Dec 2022 12:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20221213073801.361500-1-decot+git@google.com> <20221214204851.2102ba31@kernel.org>
 <CAF2d9jh_O0-uceNq=AP5rqPm9xcn=9y8bVxMD-2EiJ3bD_mZsQ@mail.gmail.com>
 <CAG88wWbZ3eXCFJBZ8mrfvddKiVihF-GfEOYAOmT_7VX_AeOoqQ@mail.gmail.com> <20221215110544.7e832e41@kernel.org>
In-Reply-To: <20221215110544.7e832e41@kernel.org>
From:   David Decotigny <ddecotig@google.com>
Date:   Thu, 15 Dec 2022 12:36:32 -0800
Message-ID: <CAG88wWYA72sij4iaWowLpawzM7tJdYdHCKQnE0bjndGO74vROw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] net: neigh: persist proxy config across link flaps
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>,
        =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>, David Decotigny <decot+git@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "Denis V. Lunev" <den@openvz.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Yuwei Wang <wangyuweihx@gmail.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(answer below)

On Thu, Dec 15, 2022 at 11:05 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 14 Dec 2022 22:18:04 -0800 David Decotigny wrote:
> > I don't think this patch is changing that part of the behavior: we still
> > flush the cached nd entries when the link flaps. What we don't remove are
> > the pneigh_entry-es (ip neigh add proxy ...) attached to the device where
> > the link flaps: those are configured once and this patch ensures that they
> > survive the link flaps as long as the netdev stays admin-up. When
> > the netdev is brought admin-down, we keep the behavior we had before the
> > patch.
>
> Makes sense. This is not urgent, tho, right?

Not that kind of urgent.

FTR, in the v2 you suggested to use NUD_PERMANENT, I can try to see
how this would look like. Note that this will make the patch larger
and more intrusive, and with potentially a behavior change for whoever
uses the netlink API directly instead of the iproute2 implementation
for ip neigh X proxy things.

>
> David A, do you agree and should we treat this as a fix with
>
> Fixes: 859bd2ef1fc1 ("net: Evict neighbor entries on carrier down")

Thanks.

>
> added?
>
> Reminder: please bottom post on the list
