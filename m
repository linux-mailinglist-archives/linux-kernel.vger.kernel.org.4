Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02316755F0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjATNfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjATNfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:35:43 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0503E7AF26;
        Fri, 20 Jan 2023 05:35:42 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id p188so6679068yba.5;
        Fri, 20 Jan 2023 05:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJSkw8NYAyR60FvSkjNU+U9CafbrPx1XHmHc0Xx2Dfk=;
        b=IZFe8TqXyaq8kS/iPsTocv5NR4O4CyrT1UKLy6KhJcPzEyQLP/Ca2LtBF/k7AbJGlZ
         IC0Aahbncon827NINbjEwyB6ebgAd7x3FlddPn7iORfhK+1vReyo78lHP3N6DQiSpJ5J
         3hikyBmhk/xul4ezw4HyDi7vGQ5XewwrO7+ed05kbpSzTWMmLB9apv5fdYD8wEDpL3BB
         vehiMlg8RJY3YkRh+dFPQYQCJ3L5FGNnK0eBeBagr9Yx0ay6mHdUNY0nYOV1aqRqx7Ou
         swfpm/E6ZtCYwDKsqKH+XY+A6nRCqAoR0pz1G17zaCHBbOyEpnZfWhOBJtIWLBvIXHql
         JzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJSkw8NYAyR60FvSkjNU+U9CafbrPx1XHmHc0Xx2Dfk=;
        b=3jlj+52lUCvTBo5kDHty+3t8EuzWWPioM90cqD3dGWFH64+OHeM9E5/zRONWS2ORoY
         nz/Zac+RVPwpOmGpAnmTP5z76/8fx+nkPQtKgPEgUsZf8erwibbY4bPWZoueAg/ss+yL
         T7cJZMs84TDSJ+/n3Ac1mpEuQ83riIcJArKCttaURl74QHlVWnMR1dvhDOIT0bvI1SPb
         zJlgO+TTGgLZQ/wLzppuvrCium8YEL4p6+DHX2uQv/2WsrLHSLhyKg9Rn+NbQZeB1uan
         rmtJyoaYg+n6ZSnx/zgF0S2i0fCWms6qUGZBnSxFHVtcxkH+iGHi2jThnaDGTHzgMcD8
         wg9Q==
X-Gm-Message-State: AFqh2kpwW24NlSBRCfgPwcenDfg/6+z1Z95EHnH0XtGPB5OXMdgg7ZO9
        ZIRTbmxfssMs0dAOwmDw7z6QKatOEVp167pL/Kg=
X-Google-Smtp-Source: AMrXdXsrXMqKTv94jCj9wJe+SlIDf907GJDK+8bjgEZCJPH22N9zq3zA0wAwfYmKnk+2X3csG8pmY4eI3+q8mU8x4ow=
X-Received: by 2002:a25:71c3:0:b0:7b2:343d:6b11 with SMTP id
 m186-20020a2571c3000000b007b2343d6b11mr1987766ybc.75.1674221741028; Fri, 20
 Jan 2023 05:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20230118160220.776302-1-varmavinaym@gmail.com> <MzQKRFS7tVFtse-EaI1QkIlyz1NMk56vSPdOmY0M3sgG4RHsFUMubaEffsPxSDyFG9dKfhJcBxN4pYYf3R95IuAVd1Ne0P2pMqXHC0dOTLw=@protonmail.com>
In-Reply-To: <MzQKRFS7tVFtse-EaI1QkIlyz1NMk56vSPdOmY0M3sgG4RHsFUMubaEffsPxSDyFG9dKfhJcBxN4pYYf3R95IuAVd1Ne0P2pMqXHC0dOTLw=@protonmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 20 Jan 2023 14:35:30 +0100
Message-ID: <CANiq72k4cOEOykgUhgqaXPC7xhX2EoC8c4sr1oFEhKMfEdi=wA@mail.gmail.com>
Subject: Re: [PATCH] scripts: `make rust-analyzer` for out-of-tree modules
To:     =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Vinay Varma <varmavinaym@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
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

On Fri, Jan 20, 2023 at 2:17 PM Bj=C3=B6rn Roy Baron
<bjorn3_gh@protonmail.com> wrote:
>
> I tested this with https://github.com/Rust-for-Linux/rust-out-of-tree-mod=
ule using "make -C ../rust-for-linux M=3D$(pwd) rust-analyzer". It produces=
 a rust-project.json file, however it misses the actual rust_out_of_tree cr=
ate. This is due to the fact that generate_rust_analyzer.py only checks Mak=
efile to find the crate roots, but rust-out-of-tree-module defines it in Kb=
uild instead.

Thanks for testing it! Indeed, we should support out-of-tree modules
using the `Kbuild` + `Makefile` approach.

Having said that, I wonder if we should even attempt to perform the
search for out-of-tree modules. The search loop is a simple hack which
works fine for in-tree code because we know the structure of the code
around us, but we cannot for out-of-tree modules. For instance, they
may be using a different build system, or not mentioning the object
file, etc.

Perhaps we should simply ask them to give us the roots directly as a
list of arguments to the script or similar.

Cheers,
Miguel
