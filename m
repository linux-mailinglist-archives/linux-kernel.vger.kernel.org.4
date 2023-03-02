Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BCC6A84BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjCBO6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCBO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:58:36 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E482411648;
        Thu,  2 Mar 2023 06:58:29 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-536b7ffdd34so431941087b3.6;
        Thu, 02 Mar 2023 06:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677769109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENOJlt3xwMRN4uzULzuOggi4mlYnNttcj3DaH0SeUYQ=;
        b=Xv+/2dz2x7U7GEnoANbmC6XOEXnqfKp55x8HsynBAOTZbRcMVRrUb3oFw0sk31w1z2
         WKYTCCcCSESIPQ8yOkryFvMBSjvuZzw2ukFFBq8RPccK2RTf6kWAljoJhhYmJuh8UYCC
         R6Lc3e85ZHrds6oRKRp9Gw97Sx5eFrNnxlfF3LWvIsm8oNyURru9kUJ4jWo2O5183Cue
         91rYwBHrP4h2mP1ez+vgDEBFiB0aSqARsEw3Pn9epvYAUW41jFe8D+ob3zeYaFYcQzcQ
         jZvIOiTecB6nlCE9jukb/rMPGEeW527vO3gHSlwlbTbJEEunqNEXgf2OqwicghFRo7K3
         Aszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677769109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENOJlt3xwMRN4uzULzuOggi4mlYnNttcj3DaH0SeUYQ=;
        b=Quj3IQmPmYwcxdt0rrwM00v62O8ZJaiwRX8XGgKqY5xdXxd4fBnpCum35Y9T+P9Ept
         A462EY7xXteMQM8p71ijjuVtHzM9pgEHWytnOeGDnv9yOcjh5SsEMjqM2zj0mQchkUMo
         SSq68TsZQ92OYH/8NUY6NxkjD89QonfWRVRBee9x81Tc0ZLKsVEDG6zFuSCwQWH9Jd0F
         bIn58bTHNrpWg0eRDzUsjGb6Ydx8iqk3JpwpFSo4+twmicreXjOnppSLascabFboJGlT
         jH6c41PFChqpGdKFSWwr+0unzVkCCwyRWD4UopM+k/qFZAAGIYRQShCdjQbpuHI5LW1D
         KQRQ==
X-Gm-Message-State: AO0yUKWYA6sSLTsGeN3wDRtulbJkGrO2wPdgCGj4w248fwkqV6/q5OlW
        naNLZ7jOLzBGvMvFJ2pxaMWzw3lxZmVMjedkUQQ=
X-Google-Smtp-Source: AK7set+4zHKFgG2zpkk+Tew8gZfM0vgRWD8HKM1gPrEMsHAbj3eITO3f3RbDDBRkIfAwdsdADDuVN+ORjFTYBD60Dkg=
X-Received: by 2002:a81:af57:0:b0:52a:92e9:27c1 with SMTP id
 x23-20020a81af57000000b0052a92e927c1mr6430983ywj.10.1677769109121; Thu, 02
 Mar 2023 06:58:29 -0800 (PST)
MIME-Version: 1.0
References: <ZACvxNOuuyifQ9Nx@kernel.org>
In-Reply-To: <ZACvxNOuuyifQ9Nx@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 2 Mar 2023 15:58:18 +0100
Message-ID: <CANiq72mv5gi18Ch0C4wdwDb3Aw+TSgqhKFznpxs5nTEekCrZvA@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: bindgen: Add `alt_instr` as opaque type
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Derek Barbosa <debarbos@redhat.com>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
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

On Thu, Mar 2, 2023 at 3:16=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> To address this build error:

This is due to commit 5d1dd961e743 ("x86/alternatives: Add
alt_instr.flags") that will land in v6.3-rc1.

Vincenzo reported it in Zulip too, so I will add a `Reported-by` for
him. There was a LKP report too in tip.

Thanks!

Cheers,
Miguel
