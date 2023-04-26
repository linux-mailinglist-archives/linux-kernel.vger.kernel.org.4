Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CA66EF643
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbjDZOVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbjDZOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:20:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EEA6A57
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:20:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bbdbso10718395a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682518852; x=1685110852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgpJhfslW9AJxpWh6L39g4b9zrGjSQZYS/g5Jt+Nqj8=;
        b=Eyg15XOqfRojyNHkgX+U5vM5JVy3wnEtjmADA5EpeYfP8poMCa7IW3j8xjCyBiO8+K
         BC/aygNk7B0kYFA5L0cq71ZO7wX6JZQnU9xAH/f1t9DDYXQb0JMvAs5rNGA9zu1GC2bF
         xW1uCY0lVr81LtB15Tku27roz5XoVg0EuUz7xgpRQcCeg1+0DQqVi4gUg84LGJh2Bm29
         9pBOcABPgS3XiF6+CH1cOIMmIAVe42GEQ9/zUcRqKVpwdnDOUX2Qo3FvAV/vniRy460u
         JHKl8UYLf2Bjvfk7rz31Lr1PyQ0EyxajN8Se3AbY+wuiVI0GnevbWPlAwZCuqq2lE9R/
         CWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682518852; x=1685110852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgpJhfslW9AJxpWh6L39g4b9zrGjSQZYS/g5Jt+Nqj8=;
        b=YzdV+TyNMuDwPN7kCP68DUvk11pNut65JBDzTUh+Io34+KBaJeNd6qwAG3kGAoqJXf
         TcLt/dTiKqyWKk64FKlaONM63JmmKbBnqTKewvrlpxa2h0KtJvF13T5M4ijQFq0aU9v7
         of4/0Jst8/Y0wQFliHib+fM6FWN+W5TDcPwRyYtPy/khPFzRTHPuk1FohFHV4/Fzjr05
         NLoPBodeVixCi+NR3DGSkEWpBkrh1IUvZAa8HWfxgZH3B9XvgRPOoXzOFc0aekkBFAp1
         KZSyhr14YSH42HQiPgQSvhnGIJo/Y33R6nMyquqfWfFw5zzQWnqMyYs0D0hLPDbKiUrM
         1Mtg==
X-Gm-Message-State: AAQBX9cbgmt9eSqpB/m+BQ/S//79h9sOss92FzdBJaMUB+lrHk4aDIZE
        8VKVciCsPouQrmxdAEoDIujGKf9kYu350o9/RQs7Dg==
X-Google-Smtp-Source: AKy350aTzZF/WyYh4VJksotVM7xC513ZMVxQO2f/MyrDCUg04y5z6fTkqYQrEXHTx1cX/GAGE2Pw6fhl5KtXY8zKwvE=
X-Received: by 2002:aa7:c757:0:b0:502:4862:d453 with SMTP id
 c23-20020aa7c757000000b005024862d453mr17094458eds.3.1682518852233; Wed, 26
 Apr 2023 07:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230426133919.1342942-1-yosryahmed@google.com> <20230426101922.49a66ee6@gandalf.local.home>
In-Reply-To: <20230426101922.49a66ee6@gandalf.local.home>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 26 Apr 2023 07:20:15 -0700
Message-ID: <CAJD7tkZ1fM4h_PYD+6XiSEiJFKU0B91anV7xEEoLgLdtpMTHRQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] memcg: OOM log improvements
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 7:19=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 26 Apr 2023 13:39:17 +0000
> Yosry Ahmed <yosryahmed@google.com> wrote:
>
> > The series uses seq_buf_do_printk() which was only recently introduced
> > [1]. It did not land in Linus's tree yet, but ideally it will land this
> > merge window. I thought I would share the patches meanwhile for
> > feedback.
> >
> > [1]https://lore.kernel.org/lkml/20230415100110.1419872-1-senozhatsky@ch=
romium.org/
>
> FYI, it's running through my tests right now (with several other patches)=
.
>
> If everything passes, I'll let it sit in linux-next for a day or two than
> push to Linus at the end of the week.
>
> -- Steve

Great! Thanks for the update!
