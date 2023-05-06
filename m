Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7C96F92B5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjEFP2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjEFP2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:28:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8B01A63A
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:27:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so35885484a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683386877; x=1685978877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ+BiRzn20Hnf7yT5l2P5uHgKRHU8zL2d2lFy4380qU=;
        b=QWMljvSezvnehxs5Rxsg7OIe7xErrCrRBD0MqtXeFdEbmV0a+UPRjbrZAduq7/ZNv5
         gY5M/nZ4Q+Yr9Pj0j0f3l7Qq2ghgRPZQKyQ6Aq8FRnMy0ixvzTVmEMTSEMsESf321CaZ
         YGnPj9Zz3/7zMRogEO3HZs/3tViOiykJ1fPH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683386877; x=1685978877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ+BiRzn20Hnf7yT5l2P5uHgKRHU8zL2d2lFy4380qU=;
        b=DnOv67tXd7pEROZi4YlZfR+hCFHEz+cE64RpkLoL1VyLUOvEUQQ+X54NDt+A70ngcn
         k5IZhP8AZx7AgAiNeWvBKsHwQF3o6a0Qu30LlgNFhAyltSQeTMWpAp3a8nj7o+enOGni
         XpdcsJq3PfeZk8bOvvdkGJppOeRVVJZ6olL7brTb06JVCb0xg3c2gLpzSv3ViyuxlLFD
         hWAvAogDQ85lL4GWefOqpzPaOADJILhno8g7pC8tTawVn1ObZ+Y7TuyyKNb07IE0Otbw
         T18SLvZSlXqrTlHFN/unkzU4BdmZJ5bCf8tBFVMo5s71xFin8Hz3eCCl0fiyJjP7bIiO
         bcbg==
X-Gm-Message-State: AC+VfDzqYfobBKe47pqQpcatwhwvdJqYEZ4vc7syMTZXWm+lnzQBQXvu
        PxKJDa4P8VWvYii5Ow0BcRvXS5GCH4236KYS/eNjKQ==
X-Google-Smtp-Source: ACHHUZ52CRJPmbLb+vDw3//oG3Blfgr/e0F51+YvazHFZRXB1e4Tc7v5N3R1r1bSr/rRB3dkdPrnTA==
X-Received: by 2002:a17:907:72d5:b0:965:5046:f446 with SMTP id du21-20020a17090772d500b009655046f446mr4331384ejc.9.1683386876795;
        Sat, 06 May 2023 08:27:56 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id fh8-20020a1709073a8800b0095ef7268ba9sm2427646ejc.41.2023.05.06.08.27.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 08:27:56 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so36036159a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 08:27:56 -0700 (PDT)
X-Received: by 2002:a17:907:9306:b0:932:f88c:c2ff with SMTP id
 bu6-20020a170907930600b00932f88cc2ffmr4529244ejc.34.1683386875820; Sat, 06
 May 2023 08:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <26aba1b5-8393-a20a-3ce9-f82425673f4d@kernel.dk>
In-Reply-To: <26aba1b5-8393-a20a-3ce9-f82425673f4d@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 08:27:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=LwLDYrjHpMM+QnE2T+u4P9-UXhXGkAMXiyfGjGnNEA@mail.gmail.com>
Message-ID: <CAHk-=wj=LwLDYrjHpMM+QnE2T+u4P9-UXhXGkAMXiyfGjGnNEA@mail.gmail.com>
Subject: Re: [GIT PULL] Pipe FMODE_NOWAIT support
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 6, 2023 at 3:33=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> Here's the revised edition of the FMODE_NOWAIT support for pipes, in
> which we just flag it as such supporting FMODE_NOWAIT unconditionally,
> but clear it if we ever end up using splice/vmsplice on the pipe. The
> pipe read/write side is perfectly fine for nonblocking IO, however
> splice and vmsplice can potentially wait for IO with the pipe lock held.

Ok, pulled.

It does strike me that one of the (few) users is the io_uring
__io_file_supports_nowait() thing, and that thing is *disgusting*.

Wouldn't it be much nicer if FMODE_NOWAIT ended up working
automatically on a block file descriptor too? You did all this "make
pipes set FMODE_NOWAIT", but then that io_uring code does

        if (S_ISBLK(mode)) {
                if (IS_ENABLED(CONFIG_BLOCK) &&
                    io_bdev_nowait(I_BDEV(file->f_mapping->host)))
                        return true;
                return false;
        }

rather than just rely on FMODE_NOWAIT for block devices too...

And it's a bit odd in other ways, because the kiocb code for
RWF_NOWAIT - which is the other user of FMODE_NOWAIT - does *not* seem
to do any of those bdev games. So that other user does seem to just
rely on the file mode bit having been set up by open.

In fact, I see 'blkdev_open()' doing

        filp->f_mode |=3D FMODE_NOWAIT | FMODE_BUF_RASYNC;

so I really don't see why __io_file_supports_nowait() then does that
special check for S_ISBLK().

Something is very rotten in the state of Denmark.

But that's all independent of this pipe side, which now looks fine to me.

              Linus
