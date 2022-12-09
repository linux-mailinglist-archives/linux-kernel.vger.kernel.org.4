Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166806482D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiLINiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLINh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:37:59 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818055E9E7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:37:58 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id j13so2273420qka.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 05:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a7ivQoLPRHYxfTiJ+5T/xChvmX/c0w+ohzF9ocLMWjQ=;
        b=qivKLqEouJ5Q8I5HqkKJ4bYguO2FzrHGo1p7hahDm2Uohz4ETzxzPESKXy075nfwk6
         8stH81gmCrEmeFWjiAPDnzP5Vhl5K5H/j9N30myP6Xpb34v56+doF+0NQGAIT7UcYC+M
         S+0TW33r+5owNXcvrV8ZQxdab6qHu/hUNqHbFwChw0sU3GsfzAIEGp0Rf1vXYBd6cRcd
         fU/6O+gXs2GFVvrpMYDFJVVo9fw/j9vyZIsflqKO1IUo0DfNBPGNV4vaaB/QNGaCdGxU
         cmdBsD5/dianZ/3+HfOLYyO96DNdbVh2EryZgKwnKfikopzdKZYYaRtNtpd9cv3Zjh2u
         hnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7ivQoLPRHYxfTiJ+5T/xChvmX/c0w+ohzF9ocLMWjQ=;
        b=NAigHzkzq2Ev40r+if/4DF4kZBcoYZS2FqY8bAyc++jYtT0QXsQI/85NT4XggKRxGQ
         Lam/fNq2TiokbV/N7ibJpp1jud7Bz7biuR3AJR1QEYXuuKAoDa+0/Mun38Im63gPjD7Z
         JPSW0ovIvLtpldJ+ymVKgNpezdmx39v2IybmVEb3knXE/WDzhU3/gaSshUREBwXRI1j+
         3ywDUZNz6RCKh3DagjbcBuNBwV00uvNZAIIbCyClWpxymTRFzcts+SE2kbwcIbyaQPPB
         3bN3acf2RS8erFUSQr0csTEfPz8F0XFGprpiGGppavd92eSoJLFTtGgZ0joqgvlXghUK
         8L0g==
X-Gm-Message-State: ANoB5pmk0Fh8gLMLkqwxcnIk5lI5dQXDEuv85iGWcBsBFUIealpF2uu5
        ALxiWrxVGKcqYo3UgwzO+u9XekUkQI7zaoekV5U=
X-Google-Smtp-Source: AA0mqf5xUFlBmhj9jEJCLfA+lUaXQWcpoX2kbCWCoBGTc4cmC8GOqYTGHG87KxMbzah97pcBc7nqSNQo6leGs0UuFSs=
X-Received: by 2002:a37:b944:0:b0:6fa:3699:e69e with SMTP id
 j65-20020a37b944000000b006fa3699e69emr83080286qkf.187.1670593077599; Fri, 09
 Dec 2022 05:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20221207135223.3938-1-jundongsong1@gmail.com> <86a63zkzru.wl-maz@kernel.org>
 <CAJqh2T+h2oHZoxc5-zbjPWEGFUVnTs9JB04Dh-sR4WeUMYrj2A@mail.gmail.com>
 <20221208165820.5maej4we3mfdeprm@mercury.elektranox.org> <CAJqh2TJvkk5o+MkET8UED-8AUhsDdehvsnR2+7bfeRoY7AmPdQ@mail.gmail.com>
 <86fsdorfs9.wl-maz@kernel.org>
In-Reply-To: <86fsdorfs9.wl-maz@kernel.org>
From:   Harry Song <jundongsong1@gmail.com>
Date:   Fri, 9 Dec 2022 21:37:47 +0800
Message-ID: <CAJqh2TKZJd6iuVexYV0Usq1j_+cMK5x=AyEZEip7A6KpQz3-dg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: remove the shareability of ITS
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you again.

Harry

On Fri, Dec 9, 2022 at 7:13 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 09 Dec 2022 03:34:21 +0000,
> Harry Song <jundongsong1@gmail.com> wrote:
> >
> > Thank you for your reply. I know these two links.
> > My email is to ask about the root cause of this bug.
> >
> > I would like to know whether the driver design of ITS requires that
> > the CPU and ITS must be in a shared domain. Such as using CCI in
> > chips;
>
> This problem has nothing to do with CCI or coherency. It has to do
> with how the GIC is plugged in the interconnect and what attributes it
> advertises.
>
>         M.
>

Wow, that's a great link:
https://lore.kernel.org/lkml/878s5i2qyw.wl-maz@kernel.org/

Many thanks for your detailed reply.
I got the answer I wanted to know, That was very helpful.

> --
> Without deviation from the norm, progress is not possible.

Thank you again,
Harry
