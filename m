Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCBC692FC4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 10:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBKJZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 04:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBKJZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 04:25:19 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12271E9D5;
        Sat, 11 Feb 2023 01:25:18 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ml19so21480092ejb.0;
        Sat, 11 Feb 2023 01:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7qfVC8/xcxrrteocNncqU8B3NKAxFwpM3QiBIMlY+0=;
        b=RcwqJHYhgP0Xuj7C0PQgU+FW00f02zBoi2KY2nkGX3dSclGREf5PHn5wzZXEkyHpJ8
         qBVFDZTyoCxOc345SB0lHmjH1iVCcGLk7hTZXOKWco0FOzozEAZwkmCJAaqIdIlEQWpL
         C4VYCzwM0kWzO+0Ih2b+PU+n3sUpf0Ecb1FovgnIEpg6zpvtlx1Rlm1/tZpwyP5uFkl6
         6YkT+zZvNrFz+Uzlov9tpgp9Ji999oFvyurCjjS96Gb60ES7eG5WjZfBiEMoPORYZsEN
         TjxCX9tdfE3sjXSaMAumpK/BTngJ2an6HrBBWWO5Ge7RiQAfwE+MzaouEFwkMrlYig7Z
         d2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z7qfVC8/xcxrrteocNncqU8B3NKAxFwpM3QiBIMlY+0=;
        b=vBlqIkONzwNi6dNEed18qwpkqJXf8AOO0K5LbxJLpuI9yEjMxFZLhCZYkqqtLc1dv2
         v7fWrzy8GdU/v+wh7eKu7aYU9FgpPTqgsru96qrBLl5UM0f/E1hp+ypE5X3vBsscbW0L
         3iGQJVKVaU8oqSR6cJX3jBnIFg6H8iMsCtTI/JXG8Zdlr0Z9g91L2mxF2crhCh7KofRy
         OURQhaP44+CIKy+iAKLF9y/bW8fqJ+DN5pfyvLKgp5Oa0v0wrqaZ55u6Xse4b3qLgYWc
         g5wSUgg1od1gslT5wVudeuK79wbpmU7dqSFFjiiQaglKmx51dO9S6HTOJKj0EdlGjx3a
         mtSg==
X-Gm-Message-State: AO0yUKU+L8VYhcgxUvlMf9yUm07hDukKWQ3Zk2Anh5GtDPpO9h7aOiyO
        IDAw2iNIb9t/ojDURdw9UNt5iLHPsm2JZtHN
X-Google-Smtp-Source: AK7set9whe/Xh5KgUp3x4UnyZd7o83TTCFDHCK0TmJW0B4Mwn2drRNToAGUU6hNXYaSs9SvwALEBBA==
X-Received: by 2002:a17:906:6a15:b0:895:58be:94d with SMTP id qw21-20020a1709066a1500b0089558be094dmr27609338ejc.3.1676107517128;
        Sat, 11 Feb 2023 01:25:17 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id se26-20020a170906ce5a00b0086621d9d9b0sm3577851ejb.81.2023.02.11.01.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 01:25:16 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 11 Feb 2023 10:25:15 +0100
Message-Id: <CQFMIYLWW6ZO.3LCN13CG142KC@vincent-arch>
Cc:     "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        <bjorn3_gh@protonmail.com>, <rust-for-linux@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: fix regexp in scripts/is_rust_module.sh
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Andrea Righi" <andrea.righi@canonical.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>
References: <20230210152622.92912-1-andrea.righi@canonical.com>
In-Reply-To: <20230210152622.92912-1-andrea.righi@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> nm can use "R" or "r" to show read-only data sections, but
> scripts/is_rust_module.sh can only recognize "r", so with some versions
> of binutils it can fail to detect if a module is a Rust module or not.
>
> Right now we're using this script only to determine if we need to skip
> BTF generation (that is disabled globally if CONFIG_RUST is enabled),
> but it's still nice to fix this script to do the proper job.
>
> Moreover, with this patch applied I can also relax the constraint of
> "RUST depends on !DEBUG_INFO_BTF" and build a kernel with Rust and BTF
> enabled at the same time (of course BTF generation is still skipped for
> Rust modules).
>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
