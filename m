Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D8A747C30
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 06:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGEEvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 00:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGEEu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 00:50:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7455E1701
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 21:50:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f58444a410so10178e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 21:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688532656; x=1691124656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lxTrp4xR0GEZ2m0ffNqJXAGvcGUnJBy+897m6qMHQMI=;
        b=5G49xGGChpfhvHhjHsAhcGMXx3gN2toKg2P9J7G1v8neSVgSuSp95j5wQUTGR6J3iZ
         QKOopdrdwzh9o5FlAJhncPCLpK8ElOtJYtGBGTeRLy91c+fjxgjWx74vpI4dOjt7aJOV
         o0Zc1r7Qai19MkBa2U84X89tQRcaZS4cGq2d+FucufUhtXnWPbi0N16B7SXWXoqmuFfH
         5NAvp2QbpsC6/a1pi/S+4jjEnz9bgmPOaqFrf3l/2Hr3ju0IEYmJu0yv8odyvk8jxBeg
         ZKNV+6vtFmaPdcrWEoYdxIEz2dVqjT7QaIvZ64B8u2ZvsAIWe7+XBvGWkr4YulJsHq4E
         DzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688532656; x=1691124656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxTrp4xR0GEZ2m0ffNqJXAGvcGUnJBy+897m6qMHQMI=;
        b=T/quXUxCW6y/z18uspc2IlHsPUlu8uUbG0BG+zyyYK1PPt/8iK8fypbTC8c5+JhDdm
         IlthDXXxlThi7IURSrq3PTXFMn7SyWN42S/CXaaUgl0e7PfjGhBhUy094mIZ2OsB7tz9
         QDzqUW+ZP+Gmyo4A0LaWD023wnq8Z14YZj7rXnRUZXVfU11je/izK1yCsWdmK3lzcY+x
         Zaiedud4H6MW4pfvnVqbhuRWqQTxnauMOLyJbng+BBlD8vvR10CBd2QbJbAyY6EWIKN5
         31VTFVBwagN1tp1XHiJyhRKLMjWAB4NwWm4Oc3+9ivJRlz+eK7ObN4j6Mdx4cOMjj7zB
         FQvg==
X-Gm-Message-State: ABy/qLaX0SiRGgvc3fzvdI1Ju/O1TKEXPSFGI+AC7sy8eXZGVjztsyzu
        /ml4Tc7zjENkzmY6AcCBzHnlk6Rncaxxk9bC0ItNpw==
X-Google-Smtp-Source: APBJJlFM/Ill4yNai9aIXJ/3LGtP7Q7TzpQDhcEAWG10KmSwLRArGtPx2RMeFKsM0ujWw1PVRqzjM9Tyi78qnDGgneY=
X-Received: by 2002:ac2:5dc2:0:b0:4f7:5f7d:2f95 with SMTP id
 x2-20020ac25dc2000000b004f75f7d2f95mr7685lfq.1.1688532656470; Tue, 04 Jul
 2023 21:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <F17EC83C-9D70-463A-9C46-FBCC53A1F13C.ref@yahoo.com>
 <F17EC83C-9D70-463A-9C46-FBCC53A1F13C@yahoo.com> <20230705043955.GE15522@pengutronix.de>
In-Reply-To: <20230705043955.GE15522@pengutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 5 Jul 2023 06:50:43 +0200
Message-ID: <CACT4Y+bGjJjmMNMQZEZFTh8UnyXNYSTy97SxtuKaJ96XkALkWw@mail.gmail.com>
Subject: Re: [PATCH] can: j1939: prevent deadlock by changing j1939_socks_lock
 to rwlock
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Astra Joan <astrajoan@yahoo.com>, davem@davemloft.net,
        edumazet@google.com, ivan.orlov0322@gmail.com,
        kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org, pabeni@redhat.com,
        robin@protonic.nl, skhan@linuxfoundation.org,
        socketcan@hartkopp.net,
        syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 at 06:40, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> On Tue, Jul 04, 2023 at 10:55:47AM -0700, Astra Joan wrote:
> > Hi Oleksij,
> >
> > Thank you for providing help with the bug fix! The patch was created
> > when I was working on another bug:
> >
> > https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> >
> > But the patch was not a direct fix of the problem reported in the
> > unregister_netdevice function call. Instead, it suppresses potential
> > deadlock information to guarantee the real bug would show up. Since I
> > have verified that the patch resolved a deadlock situation involving
> > the exact same locks, I'm pretty confident it would be a proper fix for
> > the current bug in this thread.
> >
> > I'm not sure, though, about how I could instruct Syzbot to create a
> > reproducer to properly test this patch. Could you or anyone here help
> > me find the next step? Thank you so much!
>
> Sorry, I'm not syzbot expert. I hope someone else can help here.

+syzkaller mailing list

Hi Astra,

You mean you have a reproducer and you want syzbot to run it with your patch?
No such feature exists at the moment.

Presumably you already run it locally, so I am not sure syzbot can add
much value here.
