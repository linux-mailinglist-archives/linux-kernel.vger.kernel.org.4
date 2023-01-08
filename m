Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D01D661A3A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjAHV4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjAHV4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:56:42 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D52766C;
        Sun,  8 Jan 2023 13:56:41 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g4so6991837ybg.7;
        Sun, 08 Jan 2023 13:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=weoSnaHHRzPUIS2PJ2baxYU/e708niinbN3stK9FOPs=;
        b=Kb+3aDB6Z3rzJfQCcq6QIY1F6jECCpWu+KDijxn7jMZbuFvEzy7OOgb8Ai0cQ48mKJ
         CZS0tOJk7ysCn9lj6/EbmfQ2H06bwahvhI36KnKwEI6iUYChksMXGCVNaP4iXJ9rvLE7
         g4bDjlykbdaMhBMI9GR9zuZzixThD62+3W/oREGuqRWuOS0tzvq1y38ySdWX3BbLPMDC
         dl5o5YQC85QyPnmTcFUHlF35tFAyD5F3oZ0rx9xjEJR7Ya49zagNKkybyVDpy3Yq5SB+
         22NKuDaJU9Quza9m3xbyPDR5c5rtQJnFRclK/O9Fd6OrilgAVQhGuv/T06o4oiixNSYT
         aNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weoSnaHHRzPUIS2PJ2baxYU/e708niinbN3stK9FOPs=;
        b=hcQh9ZH50ACB/pTh/DSSUXqHaf4TDB0aqOr+iuA6lnOLXxXWVXQ370a5z5xdmde1LW
         lkumn6+/fCeyZfmFgxBkSckiM3tvgIDrK2mY53C5r45HDKOG3rrM9ByRcL2PSrwrVaRn
         KGe1ASZmZo4Se15u8u3WduRAoTcT7dQGcxLz06y2bCwgbry3BnSF/lPZH+Cz2Mp2cO/F
         O7bqNWODYm0u4fH9d5x6ZBAY27kOcmmZldeCu8QHGuOxnbPrIvQuCEqC4CnNwoCudUu2
         Xzp9cuW10kvqR3Ovjk7ExR65ObifiGhDNiQXPTTnwpiBcyeWZgEUKv2djtdzGTrBzgkn
         G84Q==
X-Gm-Message-State: AFqh2kpxvKICrrayiTrTo7hLBMIH4TtiiWKKfrc8gl7GdEUzg7EybVG3
        IwkeApxAZxV9Vtw6mWLpcUm01uIHzSIfLjdpZbhbeZYP/rgpHfJzJIo=
X-Google-Smtp-Source: AMrXdXu3vT5SqiH7IDKisW1KgKS5L0uteSVQ09IqaZl8P7p1dT5WE0lri8gQekPgJPIu9rKWXkBWV+vte/tpx5gAEZ8=
X-Received: by 2002:a25:7653:0:b0:6f9:13cc:de91 with SMTP id
 r80-20020a257653000000b006f913ccde91mr7377146ybc.328.1673215001045; Sun, 08
 Jan 2023 13:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20221231082739.1629735-1-masahiroy@kernel.org>
In-Reply-To: <20221231082739.1629735-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 8 Jan 2023 22:56:30 +0100
Message-ID: <CANiq72nyckkPgbc9y1DS00i1+WvNGcDF7MmWaom89ZCb_ufZxw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: remove -v option of scripts/rust_is_available.sh
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
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

On Sat, Dec 31, 2022 at 9:27 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The -v option is passed when this scripts is invoked from Makefile,

scripts -> script

> but not when invoked from Kconfig.
>
> As you can see in scripts/Kconfig.include, the 'success' macro suppresses
> stdout and stderr anyway, so this script does not need to be quiet.

Yeah, let's get rid of the complexity. The script originally was
intended to be usable independently of the `Makefile`, but in the end
we don't really use it like that.

In fact, now we should probably add a warning/error if somebody calls
it directly (and/or set defaults for the variables). I can send a
patch for that on top of this one.

There is a small functional change, in that we will be making an
unneeded call to `cc-version.sh` and another to `$CC` for the Kconfig
case (i.e. the previously non-verbose case), but that seems like a
fine price for the simplicity.

> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh

Could you please remove the comment at the top? i.e.:

    #
    # Pass `-v` for human output and more checks (as warnings).

With that:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

If you want me to take it, please let me know.

Cheers,
Miguel
