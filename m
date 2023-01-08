Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79A16615B7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbjAHOFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 09:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjAHOFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:05:41 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C87CEE;
        Sun,  8 Jan 2023 06:05:40 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id l139so6332064ybl.12;
        Sun, 08 Jan 2023 06:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mLyGyJv5EKdrM6YbNUV9Yd2+NBwyRo3dIWNfBJujseM=;
        b=ozIbY+Hmfd/o7aVcWJ7aawXa8GZUuvRThitQx4sDYlRDKAKcS7BEJuYTRaym6rW2Fh
         q/P9r+ioLW2KdE9zV+aDQF/UIDnQ8Ywy9uv2Ecqa7U1I6+LRKW5bxBeS+J4sQYs/vX5r
         CVnx1WHvGfMu9imK6mkrINqKPPyZOAK5b5knFWRoFtYRSPnTK4WT4bzgZspcNOSuK4pJ
         4HpBpQT5bmcOpBtxLuoZqehMGcDF91EDvggFxSNHTWQsrePlbrFVcWr82A6dAR6dX33Z
         PhXrjz4/Zt97zWNr8CbWc/NXlEt/zFiIzqrLPF86hPcri2EWfbgwyCuGiV51M7QOfsR8
         vIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLyGyJv5EKdrM6YbNUV9Yd2+NBwyRo3dIWNfBJujseM=;
        b=1MvTBoh4HfxIK9GkX3cUTLPgGLllqXZ1Rq3yeVRwV23dbZVi54qaiGn3t7D0JwiRcQ
         n44o4lakg7nZjcFXbPgMeroWtCSgTWzLoST2jZj2GpI/TcgFuPf2S9MmKQ9LXtJo4zJZ
         CRIBbj4b+MvLC51+WJSx3d8xzTMbNQloADyEdXvD327dd0DuTu/FxQ7DpXL6ygxhwN4d
         XJHGgwP6ouatUfFGjt06MYnp3kDiRBGIORaKQ9VR7GNuCN666BF2+vFSuGGn1EYXvzLx
         +aMT9jR0EGu9iOxZ8xLS29ZbOsozr6yOjVuQX3D1vbV43kqw6tEfvaD/mio2ivEgGN6d
         AAjg==
X-Gm-Message-State: AFqh2koXoUKlL+yAjo0jqbRtqU/pKNX3UyxzdfxX1bAgmgoRnuMasEsO
        2SLJ9xV6/KW4p57jdD3WVvINHouE6LQ1l4yaYm4=
X-Google-Smtp-Source: AMrXdXt74t7Fv3+NoS1rvMFq+6Mt8PVP5s4X2WJZuU/cPs55Yoqqw+hZRtBar4VLBZGeM7SsZHufE0ai9VyXtJ1GOBc=
X-Received: by 2002:a25:bc43:0:b0:7b2:343d:6b11 with SMTP id
 d3-20020a25bc43000000b007b2343d6b11mr1999696ybk.75.1673186740151; Sun, 08 Jan
 2023 06:05:40 -0800 (PST)
MIME-Version: 1.0
References: <20230107091820.3382134-1-masahiroy@kernel.org>
 <CANiq72nY9X1cyu=3MwfRKTcxMUNHRTUGPFC7VR=OtL8V-NPQog@mail.gmail.com> <CAK7LNAR_VTo1A7rfQq8zMzLYfRRCUzruPQL=akALTg-GYKaQzw@mail.gmail.com>
In-Reply-To: <CAK7LNAR_VTo1A7rfQq8zMzLYfRRCUzruPQL=akALTg-GYKaQzw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 8 Jan 2023 15:05:29 +0100
Message-ID: <CANiq72mTUd5ogH_GNXLdNXYwQQpx=-qk3cPpTMDw_-mmbBLJrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] kbuild: refactor host*_flags
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
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

On Sun, Jan 8, 2023 at 2:06 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> No, there is no reason. Just my whimsy.
>
> I will do something like the following just in case.
>
> hostc_flags  =  -Wp,-MMD,$(depfile)  \
>                 $(KBUILD_HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
>                 $(HOSTCFLAGS_$(target-stem).o)

Yeah, it sounds simpler to keep it the same, we could always do the
order change in an independent patch if needed.

Cheers,
Miguel
