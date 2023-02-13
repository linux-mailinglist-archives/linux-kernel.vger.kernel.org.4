Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FD8693EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBMHaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBMHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:30:21 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F9D50B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:30:21 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id m1so12132054vst.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676273419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCly5lnJGjaHaK7Xq00JvLhaNO/bUoGXrO09geQAYfE=;
        b=MnNgMk6dIPhSQvN1HGACMvC8rvG/C9M7f0WPejeQm8Wv0LB9hTssVDXk0NQ5oPcjcF
         GvW5YII24VVNBXJDkmJuzcEK8U7OuXV7LudeuMyCHiBnTcchZgu16fniuleIKVmQrkKk
         YPyl0n4lDQfCY503wcN84qgL8LjeBNAMocIwxbBHpUb7I0XC9WmhAInvLMi2sLjc0MCh
         pUH0dwTyglBxQTrOzGeZWTLjimC69FipRsrdw79y84pmpcu4ACW9WikiXWDeU2Fzlc64
         4yWwcoYZYtQcsqXiaaCvRlMxvtBmHEIfcjHXzRJHAN8FeL8L6dYe9nsZ4Nbd+Zf0D1NP
         ylGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676273419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCly5lnJGjaHaK7Xq00JvLhaNO/bUoGXrO09geQAYfE=;
        b=pHZqAHpoOe1M+NXdelbX7VBe4vUwLsShX1+b2kAHMobfb2Ix6t8qAze5M66sqYHB0p
         vXhTA+mTgrURK+Ke8curt8YnSFLAAYNMKqzJCD/0ryw/6mbBHQsQq2w1MKgvsgIyQa1+
         FALoa+KWI0sMn6DZMWR+wfHUa/1EZQob/0U6p1CCKzf86O5hfZNYiaBH0DwDGr6l11hF
         fkziViO4Hs3gOeBWUT+YcQoibQrInNXw3psqZKS+VgV5F5jY2wF5cTIzkb+7/C4u/fpK
         HYH1Ow0IsAMqsuxPYFHpCL7SXumhNqNuv27hAEWrLrhKL3rmLiATrjbbStA7ewnh6X7G
         LryA==
X-Gm-Message-State: AO0yUKVPiJbybPqVHtQ4NSTW5TKoJwcn8QiknqRvzQ4sP853yVSJfhbR
        pf8r56x9blcRwbojPt/4bx2rYq0FpeYZlFJhhNpmh6JSurYx8g==
X-Google-Smtp-Source: AK7set9byKE+tazIaRDJqfI7QuhDprmP8kp2mNkMr0OQx44sdM5t0jFJw1giyIPBeTYqMNUQ+hgrKvndbvs8g2krWhg=
X-Received: by 2002:a05:6102:10c7:b0:412:2b1f:e179 with SMTP id
 t7-20020a05610210c700b004122b1fe179mr230173vsr.71.1676273418996; Sun, 12 Feb
 2023 23:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20221207135223.3938-1-jundongsong1@gmail.com> <86a63zkzru.wl-maz@kernel.org>
 <CAJqh2T+h2oHZoxc5-zbjPWEGFUVnTs9JB04Dh-sR4WeUMYrj2A@mail.gmail.com>
 <20221208165820.5maej4we3mfdeprm@mercury.elektranox.org> <CAJqh2TJvkk5o+MkET8UED-8AUhsDdehvsnR2+7bfeRoY7AmPdQ@mail.gmail.com>
 <86fsdorfs9.wl-maz@kernel.org> <CAJqh2TKZJd6iuVexYV0Usq1j_+cMK5x=AyEZEip7A6KpQz3-dg@mail.gmail.com>
In-Reply-To: <CAJqh2TKZJd6iuVexYV0Usq1j_+cMK5x=AyEZEip7A6KpQz3-dg@mail.gmail.com>
From:   Harry Song <jundongsong1@gmail.com>
Date:   Mon, 13 Feb 2023 15:30:08 +0800
Message-ID: <CAJqh2TL9p-qBoJRf292MaRHFLPnXXaT-sBxUGO+-q23MCq8QAw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: remove the shareability of ITS
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 9:37 PM Harry Song <jundongsong1@gmail.com> wrote:
>
> Thank you again.
>
> Harry
>
> On Fri, Dec 9, 2022 at 7:13 PM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Fri, 09 Dec 2022 03:34:21 +0000,
> > Harry Song <jundongsong1@gmail.com> wrote:
> > >
> > > Thank you for your reply. I know these two links.
> > > My email is to ask about the root cause of this bug.
> > >
> > > I would like to know whether the driver design of ITS requires that
> > > the CPU and ITS must be in a shared domain. Such as using CCI in
> > > chips;
> >
> > This problem has nothing to do with CCI or coherency. It has to do
> > with how the GIC is plugged in the interconnect and what attributes it
> > advertises.

This problem has nothing to do with CCI or coherency ??

Now , I have a question about this sentence=EF=BC=9A
If CCI is not used, how does the hardware realize the interconnection
between GIC-600 and cache?
If CCI is not used, our hardware colleagues said that the internal ITS
of the GIC-600 sends out operations with cache attributes (Inner/Outer
Shareable),
and there is no way to be captured by the cache and directly enter the
DDR. How does arm realize the interconnection between GIC-600 and
cache without CCI?

Waiting for your reply.

Harry Song.

> >
> >         M.
> >
>
> Wow, that's a great link:
> https://lore.kernel.org/lkml/878s5i2qyw.wl-maz@kernel.org/
>
> Many thanks for your detailed reply.
> I got the answer I wanted to know, That was very helpful.
>
> > --
> > Without deviation from the norm, progress is not possible.
>
> Thank you again,
> Harry
