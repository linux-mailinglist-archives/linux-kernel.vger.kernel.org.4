Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE76EF818
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbjDZQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjDZQFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:05:19 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C056592;
        Wed, 26 Apr 2023 09:05:18 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b992ed878ebso24186764276.0;
        Wed, 26 Apr 2023 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682525118; x=1685117118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mqgyHgpmTtE6ekyvaz6VHqa6H1ZKMGViM1lF6pUrcU=;
        b=HuRMwbdt9Ti6Er8HvO2uTFx6Z5InCQV7ON57TgLNfrbBWC00W/RrzOPNcvdyTuSJwd
         Pbnal5c9Z1ns5QKQZZm3pezXeduKpD1wP1I9bpTKC0vl7IVvOUXzLnvup5yWx4y4L0i1
         xGidfhpZ1qU1HHQ6v9b8FIDISnbYbOGFNReR4SJ1HK6OJrP5j3uDnBh3nuf3ENRiNtby
         j8WAJIJRzs9tYgywNLUldBC+N6WLyNS1OPz4GSQQXyVWUXu7eBP8jJW2hneV0//k2N0K
         khhE1WSwzVi6YSdCVFmvfh3A94EQhJNCrzSOeWK3oXbO88HiMyOBjVkLOPnomUeZ/y9z
         D4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682525118; x=1685117118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mqgyHgpmTtE6ekyvaz6VHqa6H1ZKMGViM1lF6pUrcU=;
        b=ghLGA/UqWzWX4GNftT/zwWpAzYNMedIEQ2HoRahliBuNo5EzfDTCKGdaKA+nIMPKcC
         nOby1C+3pFbTSYhJR23g4dEjjerNYJH9d6OZ33JPK5f2FVhvAJ5DZKnhueu6lQrMHVVa
         0j/KGQjdNkFdw8kPW6c8vRmXTLCQOIWdqIfYTrdJ7sIi8h6QH1QNpakLgtsVJJXnbJqD
         a8MQSMhI+plHr8fJfeS/l4AajQHeIeC33B+iQGPjEVcRm8SskZGWykYJsVZa95OLwi/K
         B8aQi4d88DW3H2Dxas6nvW42swH8fU1TvTcIvK6IuJOx5TIRztPUlp8Kym8ReiJMxObR
         facQ==
X-Gm-Message-State: AC+VfDwueecp3gfl3bs6wFrmBxGHEyo+QVWRQHOoeveZK9mwVL6o9jD0
        nu6Kdheo6vAZ9S0osAQwHpL5zQra1ZMo/XR66O8=
X-Google-Smtp-Source: ACHHUZ7+5SBYeeDO4ifJXcnHwEeatmuO9aI+wbzaZ5vy1aEX/AUwXR1q2nodEYdyq/uOl7k08/j3NVKHQBfE8NIWiX0=
X-Received: by 2002:a0d:e64a:0:b0:550:65b4:ca60 with SMTP id
 p71-20020a0de64a000000b0055065b4ca60mr2297631ywe.8.1682525117796; Wed, 26 Apr
 2023 09:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl> <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <ZDVXbw/097jvjKvK@1wt.eu> <CANiq72n8ZV_bs_xp5rNtar4vmfknJtZg4OHJW6vHuhVFmGs8mg@mail.gmail.com>
 <ZDWQXDRknzFhngyk@1wt.eu> <CANiq72n=s23naD4-UkmuLesekDTf4b5bsmWc+fYANYPq+X1R9w@mail.gmail.com>
 <ZDXCeKkbPoZi5k6t@1wt.eu> <CANiq72kceQ8aWk7mtB4MoepUr3hNzF34d=DfVzdeCLGRAZwE6g@mail.gmail.com>
 <0da49a77-14d8-cb9d-e36d-985699746b6b@metux.net>
In-Reply-To: <0da49a77-14d8-cb9d-e36d-985699746b6b@metux.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 26 Apr 2023 18:05:06 +0200
Message-ID: <CANiq72nnOGLA1bm8n=e9_NDozNUAWvs2ModigR1xu_Qij08Eiw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Willy Tarreau <w@1wt.eu>, Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 3:36=E2=80=AFPM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> The tricky question is: how much time will be needed ?

That depends on how fast Rust grows in the kernel itself, so I would
expect it will be a self-regulating feedback loop.

> Personally, I'm too overloaded for diving deeper into Rust anytime soon.

That is fine, one can always wait a bit more to see how things evolve.

Now, if somebody wants to use Rust in a subsystem you maintain, then
you can always consider letting them maintain that part. As I
mentioned above, that can be a quite nice approach to learn Rust on
the side and recruit new future maintainers/reviewers.

> Rust and golang share some common problems (when coming from traditional
> C + friends):
> * entirely different toolchain concept (workflows are very different
>    from what one's used from GCC + friends)

I am not sure what you mean, but `rustc` uses LLVM for codegen, and
`rustc_codegen_gcc` and GCC Rust are coming.

If you mean on the developer UX side, for the kernel at least, you
still call `make` as usual. Of course, some things differ here and
there, and there are still things to improve, but it is fairly usable
even at this stage.

We are also working on introducing some features that the C side does
not have yet. So there can be upsides on this regard, too.

> * fast-moving target (one has to be careful to expect/use the right
>    toolchain version)

This currently applies to the kernel, yes, because we require some
unstable features.

To be clear, this is something that we are working on solving,
precisely because we know it is not ideal. In any case, the decision
made was to go forward meanwhile that got solved, and it is not a
blocker for some users/companies.

> * rarely understood by traditional kernel devs

Not sure what you mean by this, but a few traditional kernel devs have
successfully picked up Rust already and are interested in increasing
their usage of it.

> * distro/build engine integration/support still pretty infant,

Most distros package Rust as explained above, which may be enough for
you depending on the distro you use.

> IMHO, before we can practically use Rust at greater scale in the kernel,
> the problems above need to be resolved first. And that's something that

That depends on the user/company/entity. For instance, some companies
and projects already want to use (or are using) Rust in the kernel,
because they control their toolchains.

> And beware: demanding newer toolchains (thus newer distros), just for
> building the kernel, can easily cause *huge* trouble many organisations,
> especially in embedded field. Linux is used in lots of highly safety
> critical environments that need special verification processes and so
> cannot easily upgrade toolchains. If Linux some day suddenly requires
> another language like Rust, those would be immediately cut-off from
> newer releases.

That is fine -- many companies and projects have different
requirements, and nobody expects everybody to enable Rust in their
kernel nor to make it a hard/unconditional requirement anytime soon
(if it ever happens).

> Ergo: the whole process of adding Rust to the Kernel needs to be done
> very, very carefully.

Indeed -- if you have particular concerns that you think have not been
addressed yet in the last 2+ years, please contact us.

> For the reasons above, the subsystems shouldn't take those decisions
> lightly, even if they happen to be Rust experts - this could have a
> dramatic effect on downstreams.

There is no effect on downstream, unless they drop support for what
they already have. But that is just like any other proposed removal.

> Maybe we should (for certain time) go a different path: move all new
> Rust stuff (except for bugfixes) to a separate downstream tree, that's
> rebased on mainline releases, but still let the patches fload through
> the corresponding subsystems.

That would not accomplish anything except making everything more
opaque, not to mention harder for downstream users who are waiting for
things to land.

Again, if you have particular concerns, please feel free to raise
them, but please note that most of this has been discussed for a long
time and decided upon.

Cheers,
Miguel
