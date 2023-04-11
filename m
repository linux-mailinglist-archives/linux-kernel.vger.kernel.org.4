Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A296DE70B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDKWOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDKWOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:14:17 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1910E4222;
        Tue, 11 Apr 2023 15:14:16 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id y186so9890150yby.13;
        Tue, 11 Apr 2023 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681251255; x=1683843255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/UWLyiDh8yYEw7KICe5ElabtXdg6v0QHoKVJvAxmcY=;
        b=nH8uJEcx+2QyedS8V7Aq1C0OB1ffVwTB3pLg0RYL3XUYbuyz5Ua3JZprbonKrPKOIK
         9WKRX4CLkQsdefQdtss+nxMduRuieptJpBpfppcZhjxwf3Jt6EQ0xqsABs+oS08IsJ+E
         zCvTC66mNrHv/rFIx4PF5wBHjdELDtN5BxELoEBv0fE765gDjr9oXnE24aChIkrYz0jB
         jzWlGzVWxmQhrlqsoZQXicxm5th1d1ZPmYpOzMeZvq0NME4QBNBd0+aLzgnd809p0lBz
         HiFBe+V/aZxgjSlV4a8GC0LbtKUNJUcJPu5ji2lYQUryDSp9EIO+mBfnS8TU9zE8CRhx
         FXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681251255; x=1683843255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/UWLyiDh8yYEw7KICe5ElabtXdg6v0QHoKVJvAxmcY=;
        b=pAvNsvsUCAXYtzHdy+bG4gLj1Ab/jBX3wC7IUnZHg6PNo2GTZV+cmUu0h71P/+HzY4
         /Fxlu2k28c16XCKdFBxrPLC993Gf2oB1YTfPZuXNXFNdlxKQJJSYZXrd+C5rxrXiQY2v
         gS0RIf7DabKUc4BOVBwDnKzXzrhX3A3lle8wLo2/arbpEhK0MHdDjJm/eP612/scfSS2
         z8cK7BoCfC/la43JaFEnrP29/8pnVjPq/t6CGI2quLLj8xh6sqYEsJQ2UihjxaP5zTJI
         2SeHSAW+Q2459uuV4x5T3W6q3bnURDaDAAKDLzYRxCmfphk14aTBeJad/0cZ7RyKJQnm
         fSPg==
X-Gm-Message-State: AAQBX9d99xCDVQWQ49j5c49xYD4nBmHM95BL59yh4EQZhwOiyxjtbnc9
        uUfrV1XRgpbuLAyZaTpYmMuk1cnl6yJA51cD3jE=
X-Google-Smtp-Source: AKy350b084T3XNmq5EJ0K2FTMUxRxNDH3tQfrdccD1GPorKAlXLPAR2ZU4geQmtpsCx8vltf7phcSVqGyPdnwKuOS+E=
X-Received: by 2002:a25:c690:0:b0:b77:e465:cb16 with SMTP id
 k138-20020a25c690000000b00b77e465cb16mr2633767ybf.11.1681251255169; Tue, 11
 Apr 2023 15:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl> <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <ZDVXbw/097jvjKvK@1wt.eu> <CANiq72n8ZV_bs_xp5rNtar4vmfknJtZg4OHJW6vHuhVFmGs8mg@mail.gmail.com>
 <ZDWQXDRknzFhngyk@1wt.eu> <CANiq72n=s23naD4-UkmuLesekDTf4b5bsmWc+fYANYPq+X1R9w@mail.gmail.com>
 <ZDXCeKkbPoZi5k6t@1wt.eu>
In-Reply-To: <ZDXCeKkbPoZi5k6t@1wt.eu>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 12 Apr 2023 00:14:03 +0200
Message-ID: <CANiq72kceQ8aWk7mtB4MoepUr3hNzF34d=DfVzdeCLGRAZwE6g@mail.gmail.com>
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

On Tue, Apr 11, 2023 at 10:26=E2=80=AFPM Willy Tarreau <w@1wt.eu> wrote:
>
> I don't know, maybe that would be a bit too fine. But at least a tainted
> flag is much less intrusive than forcing a user to rebuild and disable
> possibly important features that they would only be willing to disable
> for just a test.

It may be useful early on to have an easy way to check if any Rust
modules got loaded (though note that `RUST` is not tristate so far, so
you would still have something loaded). It could be extra optional
output in e.g. `lsmod`.

However, I don't know why that should imply tainting, especially
medium- and long-term -- please see below.

> have a hard time understanding that code that interacts with their
> subsystems, even if they try hard. It's exactly the same reason why
> 25 years ago Linus asked to stop abusing assembly code. If a language
> is only understood by a subset of developers, by nature it becomes
> more difficult to maintain in some areas.

Yeah, but that is why the idea was that Rust goes first into
subsystems where maintainers are willing to put some time into it now
and evaluate its merits. That way we also build more Rust expertise
across the kernel over time, so that later it is easier for others
(e.g. by having examples of API design and drivers, more people to
refer to, better tooling...).

But, yes, if Rust grows to be really successful within the kernel,
then at some point some basic understanding of Rust will be needed by
most kernel developers. I think that is fine, as long as there is
enough time to adjust.

> Sure, but as you said, "if they can". I thought that it could be both
> elegant, lightweight and convenient. But I'm not trying to sell this
> idea, just sharing it.

To be clear, it is still up to each subsystem to decide whether to
take Rust code. What I meant by "if they can" is that, if they are
willing to, then ideally the code would go through their tree too. The
exception are core APIs, where I asked for flexibility from all sides,
so that those subsystems willing to try Rust do not get completely
blocked.

Cheers,
Miguel
