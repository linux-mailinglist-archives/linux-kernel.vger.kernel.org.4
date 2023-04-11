Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4B46DDD65
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjDKONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDKONt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:13:49 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D59B1;
        Tue, 11 Apr 2023 07:13:48 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54f6fc7943eso42526297b3.3;
        Tue, 11 Apr 2023 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681222427; x=1683814427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UIC1EwSxTM9wU6NshrbwH+FuPWS1zI/lMxSprx3Zz8=;
        b=ihFWUxMIpGG0KgZDUr4x1z1u/bryBQVigUHrM5CgolcML1V93ZYxp6S1LvLOZoDlFQ
         H1KHXy/Ik0fySnpjPFsrW4ccfOmdCklF1qOHOg2JvRHYPSFE7txDCj7Wp3uWgdWCi4jO
         uaCoD/cm+ZRpN/PvCPdJWqrY2bUwu/XzxF+LD0Fez4/DHvYKAz5CcahP7Dnffid+ekmB
         jI/gTlEPEDyaUZpwFvJSQr/fyh2Rh2Dq6+YOqBNV2Ft6vMbm32YoIZGPBvFe+uRWnObZ
         nPk0hF4hGHxyzA84qGG+cUQyvVM5fVv+y3cbamPbpWs/fdxv7F7Hy0Yhb5e30n4vDISU
         Cngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222427; x=1683814427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UIC1EwSxTM9wU6NshrbwH+FuPWS1zI/lMxSprx3Zz8=;
        b=asy6eUDT8B0fUjTrP4Pb22j1zUyv69fUoBQ2tS5Sv6utQkA1Ofj4oLg4nNM/q3Qkjx
         ezxUrO3cO/5D32xKpwFS02HviAJLwn92753v2lHc9oNxe8FZACOZ2DWeuV57YQ33aA8G
         DCbejG+z6Un53QGpDE7t4mcb/8OguYFdZN9lXugfLQiQ6kx97atDWtvWrB5aegXtO03/
         z2DmIQ0ZlWLSYwDWKZX4H7mrWeYM3eRwgA2HRf0u7k/Mag8kbuSjw+byPqiJNg0qKgqJ
         IhQNDHNxro5aEmngH84auL1x2jTQMpDJ4+o0E2Yk6yGDB3G6qd9wNZbsBNi+8I/QtRzI
         kKpw==
X-Gm-Message-State: AAQBX9fO/MPYO2Ohy1eeDrK+cVWUJAGVJYdDndzg4tTq5/b+vu5UCZ3s
        n4DksZqnM+YgIzTRezu95XlpOeINcHbJKlX36dM=
X-Google-Smtp-Source: AKy350Ye9qb+Fi54dbLCOM36j58UoowOPBTPbYTtAN0NisVoIOviqQh+VDl4ijVB/Q5nu2sqOG0CmapT4DBahpnAxkE=
X-Received: by 2002:a81:b184:0:b0:545:f7cc:f30 with SMTP id
 p126-20020a81b184000000b00545f7cc0f30mr6009110ywh.0.1681222427590; Tue, 11
 Apr 2023 07:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl> <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <ZDVXbw/097jvjKvK@1wt.eu>
In-Reply-To: <ZDVXbw/097jvjKvK@1wt.eu>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 11 Apr 2023 16:13:36 +0200
Message-ID: <CANiq72n8ZV_bs_xp5rNtar4vmfknJtZg4OHJW6vHuhVFmGs8mg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Willy Tarreau <w@1wt.eu>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 2:49=E2=80=AFPM Willy Tarreau <w@1wt.eu> wrote:
>
> This might sound strange, but I suspect that having a TAINT_RUST flag
> could possibly help maintainers that are already lacking time, because
> it may quickly allow some of them to ask "please try again without the
> Rust code to see if the problem is still there", just like happens with
> out-of-tree code for which the knowledge is limited to null. This could
> allow to route issue reports to one maintainer when an issue is confirmed
> in both cases or to another one when it only happens in a single case.
>
> Of course it will not help with code reviews but we know that a great
> part of maintainers' time it spent trying to analyse problem reports
> that happen under vague conditions. All the time not spent debugging
> something not well understood is more time available for reviews.

You can already ask to disable `CONFIG_RUST`.

In fact, we asked that a few times, when people reported a problem
that looked unrelated to Rust, to confirm that was the case and thus
redirect the report.

So it is definitely a good idea to ask for that when you get a report
with `RUST=3Dy` and you suspect it may be related to that, especially in
the beginning where `RUST=3Dy` should not be common.

However, I think Rust in-tree code is different to out-of-tree code,
since you do have the code, and thus (in general) you should be able
to reproduce the build, and you can ask for help to the given
maintainers to understand it.

Cheers,
Miguel
