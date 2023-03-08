Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB2C6AFDBC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 05:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCHEIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 23:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCHEIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 23:08:13 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F63B3F9;
        Tue,  7 Mar 2023 20:08:12 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-176eae36feaso6792092fac.6;
        Tue, 07 Mar 2023 20:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678248491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kSrhhvFiNf5QauO9l2luSh5iw+y6F2KBtuL1iCSehR8=;
        b=ZwKWZMbQUxqDhCXsBMRYdlhcg/uBwCVFOkoaAoPZ/IEirpby0HsyejBh+q+2/XBIJE
         sKZPzP+27Kg2spwQK0FqoAg4DbuECbJwKlg/PrVY3uT4wwlqDCh3KjUFiRjidJzjca4P
         AFugSW4l/qEgbfUgvPm2SWeHRRF9vJDo6WHp42o7Mw5JVeByPgl/AM+0wVxW2Q3elJ5o
         UC0bl+/gYgEeImvgUj0w3YwywVOK099oZ0S6ORzN14ZC4mxFCuc40b3pSEy/TdZUdVTO
         Igaky6eRiBLz0KkARvzJYLMmAIvJh8tvCtXrobSW/TFVUjaszSHxSmD1Liq/VN83DfLt
         Tr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678248491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSrhhvFiNf5QauO9l2luSh5iw+y6F2KBtuL1iCSehR8=;
        b=4CMh+bV97l+ELEY+F8kTC7lFbi8J2T9q2iELByvbuhjNYMLeR8+PBmepR3b+JxGYjt
         AkaceV6UeuSu5pQW5xBySncibwb0/viwqj/Oo0DpE7XrQIsxUBgCjux+9SczU/4KyRzJ
         LSmzDKzz5VQ3F0TGQEso2Qmiy1T4J/prrGbswIPHaz2rIk5wcZG1erlGhjlML39GomuJ
         DY6AKnjnQ2VUZ4bLyxlEMDa2kzweTZJv1EcwgY9wEwiGRKlP5LuuKnr9FV9gDpmrUxkd
         r6ALBJ2qxv22ah5vknW5uc/eyQLRuuGkvAome4nJzCDOFfME4Gr3kCm6qbxvp99PR1mT
         4cCA==
X-Gm-Message-State: AO0yUKWJ7dBDhlEeFn+SUoC8cftGNaADY4hc0flz8Vl1uDR+/VIlxYKh
        tY6cpdu8KqEtDv/ExBlEhcvP+aIBtKe54T2bXQ0=
X-Google-Smtp-Source: AK7set8XyGZ3FE7mj7bya2Zbz6ZdnH9tTgSn9aA5i1A6BzWcek9Lrnyn1r79MXzX9iB2ZyFANy/rjTery+DegGctPoc=
X-Received: by 2002:a05:6870:8c1c:b0:176:7eb8:633b with SMTP id
 ec28-20020a0568708c1c00b001767eb8633bmr5511341oab.4.1678248491367; Tue, 07
 Mar 2023 20:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20230307130332.53029-1-daniel.almeida@collabora.com> <20230307164603.686281dc.gary@garyguo.net>
In-Reply-To: <20230307164603.686281dc.gary@garyguo.net>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Wed, 8 Mar 2023 01:08:00 -0300
Message-ID: <CANeycqoV9aDsh5aYynxGwah0=WVgboKQsTVQHJdSFwougRKqYA@mail.gmail.com>
Subject: Re: [PATCH] rust: virtio: add virtio support
To:     Gary Guo <gary@garyguo.net>
Cc:     Daniel Almeida <daniel.almeida@collabora.com>, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 at 13:46, Gary Guo <gary@garyguo.net> wrote:
>
> On Tue,  7 Mar 2023 10:03:32 -0300
> Daniel Almeida <daniel.almeida@collabora.com> wrote:
>
> > This patch adds virtIO support to the rust crate. This includes the
> > capability to create a virtIO driver (through the module_virtio_driver
> > macro and the respective Driver trait) as well as initial virtqueue
> > support.
> >
> > A sample virtIO module is included for conveninence.
> >
> > Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > ---
> >
> > Ok so this is my first Rust contribution here. It's part of a virtIO
> > driver I was originally writing. Both the probing and the virtqueue
> > support in here were confirmed as working in said prototype driver, and
> > the pieces were picked separately into this patch.
> >
> > Feel free to point me to the best practices around Rust patch
> > submission, as the C stuff like checkpatch etc probably does not apply
> > yet. I did take care to run clippy though.
>
> Hi Daniel,
>
> This patch seems to be based on top the GitHub rust branch, not the
> rust-next branch.

FWIW, I'll soon send patches for the `driver` module to rust-next,
which should allow bus abstractions such as this to be rebased onto
rust-next as well.
