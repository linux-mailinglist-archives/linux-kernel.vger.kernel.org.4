Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EAD663274
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbjAIVMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237855AbjAIVLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:11:41 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC4212099;
        Mon,  9 Jan 2023 13:06:17 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id c124so9773132ybb.13;
        Mon, 09 Jan 2023 13:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ruqurkiOPq/60Ofar99Z98QHHgy9IA7M4V3XUwPdHC8=;
        b=LxtJ+X5iYJcNmJcWpm8rjH0waBDqiQdG88taP2+j4q047HhQOLkKQ8jx0LC/bkrgRI
         kseC7SSxeKQzZ8aUlq45UXd9n6m/9OcB0UsICzX25e59lc7kS7NgzzfgPjM8Ouk973jT
         VBWfXgQ792/ytHcAoc1v2U9mvvmYKV64/XGlBY429/siIJfamy0eVNHCEduLusREe5KI
         Eo83FW6MBM/4Lhx0e3fQqnG3LljPWHuE6468vOsHUEbk9bNwWvVTlQl6zHMonFlu9Jks
         zmDi2+hDjohK5zWF8gGiP5tZZdhqe7ByGL955eFJBeRIXXo7wrOn8MBD/I4SkcS4NrHs
         xqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruqurkiOPq/60Ofar99Z98QHHgy9IA7M4V3XUwPdHC8=;
        b=hAV6w3a0J0ikByWDDCOEXZP1lX6wHXw17lPYN+5yqBSrWOu0yM04SoynbVU6s0X0+b
         Iu1/HKRYvHLEROV9tEk98RRvRjP/DRlxZSLfrFABs77afVB2sGo63ovKwlge4Q3iS7ny
         2eTWL4IRjG6GIdlmqSZzJQWYvJbDXvoAIbRcjVgoB9lnLlgvMtdL1WNIOA574j7t5Kqe
         AyW9OqMUOzWVIj22JotGRPzSFdDnpXv9ovOwYwjweXcyN2XmjjkGSK141lGKC2qK5Qo1
         rHk7fA30uvWYUZYpjxizB0U0swQADphH5v+OcMaBxqpI6bdbqzFFdhGXhDIiYD9Z5POn
         vyXA==
X-Gm-Message-State: AFqh2kpAnGXYuWasNGnz+935XNQO1Snq/IG4Ma1yB5il8BJpitqI8Nkq
        raD0zFTtwhaijrwT4RC9RdmJtqyGLLPVM7wLO90=
X-Google-Smtp-Source: AMrXdXtV6jEFbH9LeE1FPymK59PmRaEJbE++VCpZc1kGfJiDhWH47gzHv0RWTADEClSW7TO4g6lpJWsTcg61ZqgjnAQ=
X-Received: by 2002:a25:ac08:0:b0:73b:23cf:ad63 with SMTP id
 w8-20020a25ac08000000b0073b23cfad63mr8094083ybi.323.1673298376640; Mon, 09
 Jan 2023 13:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org>
In-Reply-To: <20230109204520.539080-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 9 Jan 2023 22:06:05 +0100
Message-ID: <CANiq72m_+xJYUxrwFc7vNLkuOb6zC-W-wDzXjbPb8Ursqzwiaw@mail.gmail.com>
Subject: Re: [PATCH 1/6] docs: rust: add paragraph about finding a suitable `libclang`
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
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

On Mon, Jan 9, 2023 at 9:45 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> +* Or ``LIBCLANG_PATH`` can be pointed to a ``libclang`` shared library
> +  or to the directoy containing it.

I just noticed the typo here, sorry: directoy -> directory

Masahiro: if you take them, please feel free to correct it.

Cheers,
Miguel
