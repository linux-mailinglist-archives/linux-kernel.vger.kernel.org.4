Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03B56D8B0A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjDEXTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDEXTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:19:49 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA9846B3;
        Wed,  5 Apr 2023 16:19:48 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id k17so44444195ybm.11;
        Wed, 05 Apr 2023 16:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680736788; x=1683328788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xdWmttMtaebi+vSShIGyAU+sz8Wf4roGdslxn9RsIo=;
        b=IovCAhPl9rKqxorMiR+XEI979xtu8kG0W1HyWDDwbFfOhMAiE7t65qfk/k+dT0nEYu
         S35ACQpsr855z2Rhr/0jzicj8mYv836lTwxkONfmKZyTfCpwt4a9JpZ9nEBGbCKGUQnC
         KCWiqd7Q5fbj99py26dFqN1pvscI+3IpzCCzjSkzvEc0scmkP3CWmIxc7RRco+Z0sxcx
         mENO6Bhh1Ikdfng3a6BNcp3bVfMT+eOLH2uCbKa/4H3RC204S/06EresKMnDCIE1BQoJ
         3P7iZo/7bINDVcq2Ys7FDOFYjcpEem6zcQpOUzmw6r7r9VvXKz0EPpTrJnOhGiiS8457
         acnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680736788; x=1683328788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xdWmttMtaebi+vSShIGyAU+sz8Wf4roGdslxn9RsIo=;
        b=kg/ZkbVDijNpzyYIfKARKcYaNCUEhLB1CVWAdU+K1XAOaXZqeHejfw+AZdZf0hj0xs
         sMzYCxAIlVTK9njLlf+2YBK4wMs5PoE+3B6HtTe9RlIszJ6m2+x+6jQoftqvn9xJYTTZ
         E/flOLWI1+yHu7+qTQT9a2VAnFY7opu82XTi6yIUmqobgZOmT9V3yBnWh9vgEFIZZkEV
         4C9HtvAUmBzO548VIsaUI51ylxCmt94q4zoDAIGuTXyOZw6t1M7OByXQ1SHPMEepICtK
         zNFwqrpc1/UzlHePJbtbwxFelZR2Sf+uXafBY8Wt25xy6/0mnwURCiotYickX2GQWwUK
         U0Gw==
X-Gm-Message-State: AAQBX9c1UHSP4eAyxMDASYaU36xKoCMZaU/fnhA/5WZ6ldYos+RgMAnq
        gtKUQCljhJlrp0lmxILTxfuBkkDYy4aCaplude0=
X-Google-Smtp-Source: AKy350aebxuJNzwRIXI+ftFotr0WiAb4hMpaTqhzruVTjvEepVx/aJIXT10TUO5P1x3R58/taDGKO2cr+xfWgT0DdfU=
X-Received: by 2002:a25:7349:0:b0:b75:968e:f282 with SMTP id
 o70-20020a257349000000b00b75968ef282mr707139ybc.11.1680736787750; Wed, 05 Apr
 2023 16:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230405201416.395840-1-daniel.almeida@collabora.com>
In-Reply-To: <20230405201416.395840-1-daniel.almeida@collabora.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Apr 2023 01:19:36 +0200
Message-ID: <CANiq72m-Ez91L0kH8pYTqGNaG+stPznY7-GPq16Q2wTcvj75uw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: virtio: add virtio support
To:     Daniel Almeida <daniel.almeida@collabora.com>
Cc:     wedsonaf@gmail.com, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
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

Hi Daniel,

On Wed, Apr 5, 2023 at 10:14=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Again a bit new with Rust submissions. I was told by Gary Guo to
> rebase on top of rust-next, but it seems *very* behind?

In general, prefer the most stable base you can find: Linus' tags if
possible, otherwise `rust-next` if you need something from there,
otherwise you may send something on top of some prerequisites that may
not have landed yet. Please see
https://rust-for-linux.com/contributing#the-rust-subsystem for some
other details. `rust-next` is the latest Rust state (which at the
moment is just Linus' -rc1 -- did you need something that landed later
in mainline? In any case, tomorrow I will likely move it to -rc5 since
I will start merging).

> The first patch does not build on its own due to a dead_code warning.
> It is hard to not have dead code when one is adding infrastructure to be
> used by others at a later opportunity. Let me know if you would like to
> see the patches squashed into one to fix this.

Patches series must build between each patch. However, instead of
squashing, you may use `allow(dead_code)` to split patches as they
would normally be split. In other words, it is more important to have
patches more easily reviewable than avoiding an `allow` line.

Cheers,
Miguel
