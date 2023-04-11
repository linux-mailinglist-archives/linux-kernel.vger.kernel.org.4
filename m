Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E676DE4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDKT1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDKT1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:27:52 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CBD4EE6;
        Tue, 11 Apr 2023 12:27:47 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54c061acbc9so317170357b3.11;
        Tue, 11 Apr 2023 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681241266; x=1683833266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmcqdJF7REkiqneRQWSmTXA5ippJbf7vn1p2E+UNdK4=;
        b=Y4k7dxpIOYo/Hi2fX77dsy7Pt+Sv8jyn6Sa961AKL58QhfT4yQoVADTHTUaixFnD2P
         NsqMlCpQGZcGmjOjxyYmEQyEPjta8dp254EkaVBJVO8rwIzP/EbkMyb5GyTaIy6zdS7Z
         XuqmA1G/3CucfSjthqkMhG2qRDRF2hka6VLPPTjMJl3/G0PWWG/aYXlARbnkItybFYwD
         dxRX2YS4cXRYaUkxPgIeiRUc9aUrDUhDKthN4FMrpR+PS/xr5rB/+02jos0jXiLGtAYS
         CmPKecpwSK0ZJumQHhcFbj4JxxrqjELEAlzMetelbxor1UYhVra9La/6JqM1S1QTmT7H
         amgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681241266; x=1683833266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmcqdJF7REkiqneRQWSmTXA5ippJbf7vn1p2E+UNdK4=;
        b=eDYBfztXdySvv2k7HeRyp5ZKbsRaJXU3SckMwxSyI1QwAh3W4cOmYMRgzJMvhVqvaZ
         +A4dIb/Mn47IlLbt2QyPBqpbi1RU3dJkAlAeN9JcoU76EqpqF0UJBfURBC7qq5MnD7Pu
         GtulDXhZ6IPvOKnq9bajrL2y/9AydwNFtXXY9PGuYgvuqpT5c4Du6+G/B7TpiLQhadH9
         r4Epa+V98LWWZWUy+sKc/oIq94vaofNNJqPiqWJq1NMbeTVYHw+G9M8I2CKbHFcy6tVj
         rTeoUh5InaIwqV1cYs4fP1xAgug6RH/MgxToZBekHvSubzWvhBbov8JS9ShAnqxAOP7J
         SL+Q==
X-Gm-Message-State: AAQBX9eUnD2vffnjITUUk/xFbmIIgivCyiUNnz2DdE/q9Hs7VcKzfoZv
        NdUvgx0WylD3wlycplBGJyyrrDuJxt+tIZ3OZCc=
X-Google-Smtp-Source: AKy350ZO5e5TTFbCkXHDfIbpLV3jkA9byRB0cc7zimZHSm+52yWp4Ywu4EpAaRlHkNmFOu5a1vetOfCaG0NnoLvo09w=
X-Received: by 2002:a81:b660:0:b0:54f:899f:891d with SMTP id
 h32-20020a81b660000000b0054f899f891dmr398566ywk.0.1681241266643; Tue, 11 Apr
 2023 12:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl> <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <ZDVXbw/097jvjKvK@1wt.eu> <CANiq72n8ZV_bs_xp5rNtar4vmfknJtZg4OHJW6vHuhVFmGs8mg@mail.gmail.com>
 <ZDWQXDRknzFhngyk@1wt.eu>
In-Reply-To: <ZDWQXDRknzFhngyk@1wt.eu>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 11 Apr 2023 21:27:35 +0200
Message-ID: <CANiq72n=s23naD4-UkmuLesekDTf4b5bsmWc+fYANYPq+X1R9w@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Willy Tarreau <w@1wt.eu>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
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

On Tue, Apr 11, 2023 at 6:52=E2=80=AFPM Willy Tarreau <w@1wt.eu> wrote:
>
> But if that code is only under a module, there's no need to turn all
> that code off if it's sufficient to be certain the module was no loaded.
> Plus it's more friendly to the user who doesn't have to rebuild a kernel,
> just blacklist a module and check that the kernel doesn't get tainted
> again.

That could apply to any foreign-to-us subsystems, including C code
too. Should we taint per subsystem so that we can easily check for
those that we may not trust?

I see one could argue for an experimental taint or making it depend on
something like `STAGING`, i.e. based on grounds of being new code. But
I don't see why that should be grounded on just being a different
language or not being able to read the code.

> It could depend on the layer where it plugs and the level of intimacy
> with the core. Sometimes you need a deep understanding of all interaction=
s
> between elements to imagine possible scenarios.

Please note that the policy for submitting new Rust code is that the
respective kernel maintainers and their lists are contacted. We also
request that maintainers take the code through their tree if they can,
rather than going through the Rust tree, precisely so that maintainers
are aware of these potential interactions. See
https://rust-for-linux.com/contributing#the-rust-subsystem for
details.

Cheers,
Miguel
