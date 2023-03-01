Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381366A7202
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCARYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjCARYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:24:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC79367E6;
        Wed,  1 Mar 2023 09:24:30 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so1037563wms.0;
        Wed, 01 Mar 2023 09:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677691469;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNpkdoZmqWbaOAVmdJei7p+ZGXFT2prpPoc6LJ5dBsc=;
        b=H1hL0uZxcat8GWO9QXh3RBN3DAIwfBbtYifyqCAdNxaqgQICwyujdWtRJEcSeMXL/n
         PAngsJryhFCO3gp3meGjYeSwkPxGiR+BwbRDUN0TgiYiX46jMXB7xfIFxnrgr+HzfwK9
         VMaJsodlkF8yjTtTxIpOjV6MJKNFSD8gRGgTPBrp4RlJO8t8DjaDE6wgsfSGwg0p/qrH
         iPWPLrYNyb3SO5K0RdE6dly+Eg6sd9sc66SkgXj2Ff/V9la1H5qXDdShWPVw6H0wBl7h
         ReXY8rM2cQJtae0ZcBnQqP9o7y410Frlb7Y/ejnGH/zZsUZP83Lw+vccnBnrsfhr1LjU
         JlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677691469;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sNpkdoZmqWbaOAVmdJei7p+ZGXFT2prpPoc6LJ5dBsc=;
        b=4w2uxLkod4foKO3M+SMqeboPOnUjjWyXxaf5GvHJTolMDy0wyFRZGvLihBu6bwuX4A
         cFoHMQTPhdXesu7VqITOB1XuxJJlm7WnSyUNP/BZmFB2JiPR4WthJDhK+KIu+S7ZRj81
         WhNi2WJr3yuEla8ipOi9DrmK1SHQtqr9cMexRz3PZOmmzTDQZAaoAwv2Ztaq6T3V/Ugp
         eQSDyJnVqcpCky4g1sqCUIsvAhQHYLQjiaUn8oqjHRb0CGxh2Tm9EaZ+2JvSdmgXTF5u
         E5W+Hba+I4Ei/hi72rl5U+YDBCIXqW+o3c7+MY1Kq5iJ3uFlTnO7kKEvAJheF+TRaWk0
         4vMA==
X-Gm-Message-State: AO0yUKU4EivWDct1YxUzqhjUk7Q80oxsV0dXON7TQKoyy7EtD9qnS0L6
        +4UYxzTLlYO6iSdtDA+yO0g=
X-Google-Smtp-Source: AK7set/qEAM/YZLlke7KZF96LN1MjYAMr6V67vMOMBAYzfxb5ReD44O7Lfw2E+IZzSi1PTzv+CFdPQ==
X-Received: by 2002:a05:600c:3acb:b0:3eb:38e6:f64f with SMTP id d11-20020a05600c3acb00b003eb38e6f64fmr5419748wms.8.1677691469184;
        Wed, 01 Mar 2023 09:24:29 -0800 (PST)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003dc49e0132asm255828wmo.1.2023.03.01.09.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 09:24:28 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 01 Mar 2023 18:24:26 +0100
Message-Id: <CQV7ZNT6LMXI.1XG4YXSH8I7JK@vincent-arch>
Cc:     <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kbuild@vger.kernel.org>, <asahi@lists.linux.dev>
Subject: Re: [PATCH] rust: Enable the new_uninit feature for kernel and
 driver crates
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Asahi Lina" <lina@asahilina.net>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>
References: <20230224-rust-new_uninit-v1-1-c951443d9e26@asahilina.net>
In-Reply-To: <20230224-rust-new_uninit-v1-1-c951443d9e26@asahilina.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The unstable new_uninit feature enables various library APIs to create
> uninitialized containers, such as `Box::assume_init()`. This is
> necessary to build abstractions that directly initialize memory at the
> target location, instead of doing copies through the stack.
>
> Will be used by the DRM scheduler abstraction in the kernel crate, and
> by field-wise initialization (e.g. using `place!()` or a future
> replacement macro which may itself live in `kernel`) in driver crates.
>
> See [1] [2] [3] for background information.
>
> [1] https://github.com/Rust-for-Linux/linux/issues/879
> [2] https://github.com/Rust-for-Linux/linux/issues/2
> [3] https://github.com/rust-lang/rust/issues/63291
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
