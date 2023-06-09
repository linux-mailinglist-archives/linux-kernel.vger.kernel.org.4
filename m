Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536A1729321
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbjFII1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbjFIIZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:25:01 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF994239
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:23:45 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-565cd2fc9acso14104647b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686299015; x=1688891015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clWHzASagbXarxkqMQp3BusxNsMWhJHA3a9/CJktoY0=;
        b=oN5x+/Jfig74uJFKFq6GopdHh9QY37GHbCi4uTjfj8Oy/+9u3FMu61GHqQgfJWmFdS
         0qz0d1eaQQtgMu+YAM4QnbgcTgolkvui06vi9FR81rDEJIjqKYyyiW8NhHIGAWM/OEAX
         ftx8e4DuOPmmHYTrqvNY+n0qm5OrCZvQavVnkE0xBLsTPPfGbxeTQJCoimov9K/etVQL
         eOMkJAs8S7zrglUox7mtcaG7LIMm2V7yX8aBIXi5xZvYmlaHcA6tdX01Js76Oof7EHg1
         CsCxeetqJ+fNyPAxgs0Vr2lG5m0gQygEmdH1T2Lbz2FUGpzLAt9Zq3oB87/OplwLBtHi
         Lj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686299015; x=1688891015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clWHzASagbXarxkqMQp3BusxNsMWhJHA3a9/CJktoY0=;
        b=LcQPKaya/4GrPbEiiOk8dKLQr6viPKuozpl3iGtM2jmoELoVoCsgiyviLEnC8+O7o5
         JQV1wZ4WySFcY1oAHYE6p9/9kysNgqfjYdoqY2JYNG9NrWl+SJLgoVlRoBD8XwC/ayvk
         Jk47bNIDnJjL0OkUbCKdJoKDiJjAzCEkfs125OYcLj5dC/vkusbBo+K9KENYNjugV/gm
         JpvRS/JXckYA8BVGzxWd95yXeJ0LGGqVykgPRn8wTQVNgGKNZdpaw7QW6P6JKF7F0cap
         vMUs7TPKOlpuGiXQBjr0JO/w+NjpN895WoPEvYcL6rmB5TVMWCHmbSg7H8Y7mjhL0lX0
         Lw9g==
X-Gm-Message-State: AC+VfDwOX4qB6VVd+f8oF6++ur84Qd1wBFV7ycWZ9di/blmrcxwNwLwi
        71IPl9Ve7X5WmRiKTaiIxG0WfYxM+GD1eta4J2k=
X-Google-Smtp-Source: ACHHUZ6V/DmgfMPkizJ3Rn3UZ9t97ZIYJzn5H5kUmpA+J9NQKEVdgg5A1LTkkqDeGW9ZtSqNJWpgddz5Mdw+UGluQ0E=
X-Received: by 2002:a25:8c8c:0:b0:b9e:6fd1:4350 with SMTP id
 m12-20020a258c8c000000b00b9e6fd14350mr480715ybl.17.1686299015644; Fri, 09 Jun
 2023 01:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <87sfb1oz13.fsf@meer.lwn.net>
In-Reply-To: <87sfb1oz13.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 9 Jun 2023 10:23:24 +0200
Message-ID: <CANiq72=G_qnoNhjrr2K7h3u=k8AXr2QTjoN9uJ53Ls2FvsQd9w@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
        ojeda@kernel.org, danny@kdrag0n.dev, masahiroy@kernel.org,
        jgg@nvidia.com, mic@digikod.net, linux-kernel@vger.kernel.org,
        joe@perches.com, linux@rasmusvillemoes.dk, willy@infradead.org,
        mailhol.vincent@wanadoo.fr
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

On Fri, Jun 9, 2023 at 9:50=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wro=
te:
>
> So I must confess to still being really nervous about installing a file
> that will silently reconfigure the editors of everybody working on the

Yeah, especially given the variety of editors (and plugins for those)
used for kernel development.

> kernel source; I wish there were a straightforward way to do this as an
> opt-in thing.  We're talking about creating a flag-day behavioral change
> for, potentially, thousands of kernel developers.  Something tells me
> that we might just hear from a few of them.
>
> I wonder if we should, instead, ship a file like this as something like
> Documentation/process/editorconfig, then provide a "make editorconfig"
> command that installs it in the top-level directory for those who want
> it?

That would make me less worried indeed. It would also allow to be a
bit more aggressive on introducing some of the unclear file
extensions/rules to test them out first over time.

Cheers,
Miguel
