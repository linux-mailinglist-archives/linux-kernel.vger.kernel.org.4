Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB06A53F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjB1H6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjB1H6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:58:32 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4801A66A;
        Mon, 27 Feb 2023 23:58:31 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p6so8690579plf.0;
        Mon, 27 Feb 2023 23:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677571111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcgXmvlwPY/bJ8941ibAR2bWgWTcHokWpFkZZageEXA=;
        b=WXFcRAR5sgWcqhbjdHTCC8ffSkyiH5GSvkhhMxZAx26ruDdmp5mFHorHjAMzrHZNQr
         OX+tHF3mqNq296cxXdPVAmUxA1FjHDAeKVP2HmwXeKywQ3KfnbNfeZ127g3WKYOo2wEK
         3g7lZKzCgxJwLZAWs9gt6KXH8pmZvkCAetYw60vYUa2TXOaAWf72K/Znxzn6Q0S7wvlu
         Pf3ja2rUhaeW7hoPYDFXFPB+1vX/HCIoLzqhspEgF4rZ08SnlBIqz49t/UOOwd7D8liz
         8xG1Er7WtWI3B2bTWsoF2bBBQyRo5/Ey5XgCa3FpWq1D7fKmoQ/R63nFTVOoHlLqhhpa
         MtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677571111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcgXmvlwPY/bJ8941ibAR2bWgWTcHokWpFkZZageEXA=;
        b=BbRkofUOzYIeUxbONvHAHTTpOUgeXvHFY2Tk9T8JetLuF6rRFuIWsOjflQqDZ1FiJE
         KDdjhIAMTPXJMgogqslpkkP76AY5H6G9yt09QQxR5teiQ3qWNLWtnGY44LAgq6tf4pig
         L65v5dyVclX28JZau706bMEvb4J21eGf9jaSYk9zaew1GLoXuuh5sBt3NM0Cb9SWB/+e
         GTYHA8QK7bJTlFIxkqe6h6rfsX2KmNKEeHPx+FW4KL54lFp1uD9FeL1hIBuXeHOq1mhW
         9GS2ud3tYxXTBOvrR9k/dyM/khWdM6mkOCDL1wQLspXA/zH0lrnAkrYnBEj/FRxy0dsn
         STOA==
X-Gm-Message-State: AO0yUKXPyV/ZiL2idbxfnrFWZmqOiLUXiqyjhjw7ZAm/gcYwB/8SA/jm
        aVkhO+rUzhiAJgKxC025+VYDhuyTkHiKddP8PAk=
X-Google-Smtp-Source: AK7set8C62Fz1kmycCaLETHDH6hk4Z+n5TPkNZD43/Hd+LLKc2l3peEBHBZhuKkPKFkZ3/oOahDke7S7L6xJfSQHV6s=
X-Received: by 2002:a17:902:f7c6:b0:19a:985c:9e35 with SMTP id
 h6-20020a170902f7c600b0019a985c9e35mr614083plw.12.1677571111161; Mon, 27 Feb
 2023 23:58:31 -0800 (PST)
MIME-Version: 1.0
References: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
 <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org> <20230227103257.4b99b6fb@gandalf.local.home>
 <CAEXW_YT6_cSaEODPu3HLWUB5kJhs6U=CQrQ4v4ODKtk-D+Bzug@mail.gmail.com>
 <CAABZP2zZHQ22MPsWkPZ5kPW5SNDPt0mT37xw3f4VNLeBsxRPvw@mail.gmail.com>
 <20230227111626.463b8f85@gandalf.local.home> <20230227163258.GF2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230227163258.GF2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 28 Feb 2023 15:58:20 +0800
Message-ID: <CAABZP2yqc0r8auf-m_tBTq2TbE1yr3Sn3cZ2zF8NPp3axJH+tw@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in rcu_core
To:     paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        contact@pgazz.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 12:33=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Mon, Feb 27, 2023 at 11:16:26AM -0500, Steven Rostedt wrote:
> > On Tue, 28 Feb 2023 00:11:51 +0800
> > Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > > > Yes certainly, the rcu_head is allocated on the caller side so it
> > > > could have been trampled while the callback was still in flight.
> > > Thank you all for your guidance, I learned a lot during this process
> > > >
> > > > > OR it could be a bug with RCU if the synchronize_rcu() ended befo=
re the
> > > > > grace periods have finished.
> > > Thanks again.
> > >
> > > By the way, the syzkaller on my local machine has been running for 8
> > > hours, only three bugs reported[1][2][3], but they don't seem to be
> > > related to Sanan's original report.
> > > Maybe there are some configuration mismatches between us.The test
> > > continues,  I will report to you once I have any new discovery.
> >
> > Note, the above races (either bug, the one that tramples on something i=
n
> > RCU flight, or a synchronize_sched() returning early) may be extremely =
hard
> > to hit. It could have been the planets were lined up just right to hit =
the
> > bug, and won't happen for another 27,000 years.
>
> Which turns into once per week or two across a million-system fleet.  ;-)
>
> Not that I know of any fleets running syzkaller...
My syzkaller has been running for 24 hours, the bug can't be reproduced.
Yes, the above races are extremely hard to hit.
I learned a lot during the process ;-)

Please inform me if there are any more clues.

Thank you all for your guidance ;-)
Zhouyi
>
>                                                         Thanx, Paul
