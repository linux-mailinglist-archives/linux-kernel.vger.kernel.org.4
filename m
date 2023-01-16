Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC2C66D33A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 00:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjAPXf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 18:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjAPXe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:34:56 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61892B2B0;
        Mon, 16 Jan 2023 15:33:35 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-4d4303c9de6so249514867b3.2;
        Mon, 16 Jan 2023 15:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ivDU9Ro37F3LuZ7hP1KJdu6lEpnACciyXmME6mUAv2o=;
        b=UnUAoO9C4bejerdcar2SMro8ESQo9VE1qYnQdXDVVtEtHy/ZKAGbLDmDY1nZBn3MdQ
         0j6SINS/LdQ2vDXIigrTebkYjHeNAK8x43+a5hrF4yOPozgPiJdpkqLEK4W9H1XRw6+T
         +1oupZMO8d3wdWZ4JIcT65POYrz9aaid/dJzcef5Yi5VD+vjWo8Dnfr79ReqkLv47TtE
         hskPMFp7Cf45vH0BMNuCh8rY3CKuA8rqDvOsw7SwBwZbskw87wepJ6kpsjFYvSI22OM3
         9gdTnKDf1/aAqc/hTh5YiUvosRUj7t+MmwcRTY2m1c8WB42Mn95U4PrX90IyYPsANBmi
         vJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivDU9Ro37F3LuZ7hP1KJdu6lEpnACciyXmME6mUAv2o=;
        b=MKXfgJHJ1rKGR1x9hyB9UjcBNjR/+SFX+/FdxRODwYqZrmem7a1LqpcgjKZfblFcjG
         GKyGn4GyTjEUm/+a6m77Se/JA6RMPJ1TlIyYliAkQL13HVMYCFDJzG1CAFVH/3AYjxlY
         XGjXkheh69gGO7sIlgL7HNg+VZQLG74iVX9whRLhrYMbWovmZ0g7Jvs4h/LhUXThAQxn
         rrNWmCxvoaXDs8wjf4DZNNflqgpMY8mJXTeqgAymmX4UyiJPZjV3jZAop/AZJHcKydPh
         5bwN2k6ywPN3qVcq32vX9UXimRS2hrRRDjYSbvgkm3tl37VtX4Qdk4VCDEVu2Z57e+lb
         ouMw==
X-Gm-Message-State: AFqh2kqOBLclkQ7/fUcW9g+ILlFC5bfYYfjVonUw20VXwX3DRHZ9uIGb
        OLal/zAZXhPdYI/owR1K9l7PFDAB+Q8YjOYf134=
X-Google-Smtp-Source: AMrXdXuCcIido/P/3jSaJx/R83F6+hTx4BurA5zvLjkHEPpRb4KZSkemt8vYeCGVW7zRCAMwBDJ2XvxzjTrPkw/TTw0=
X-Received: by 2002:a81:5402:0:b0:3d8:8c0e:6d48 with SMTP id
 i2-20020a815402000000b003d88c0e6d48mr82639ywb.462.1673912015171; Mon, 16 Jan
 2023 15:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20221205214454.2542888-1-gary@garyguo.net>
In-Reply-To: <20221205214454.2542888-1-gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 17 Jan 2023 00:33:24 +0100
Message-ID: <CANiq72kjaNpc_e6b0fetviJAcWBAitnD+mNmJV5Xr15rFubY9w@mail.gmail.com>
Subject: Re: [PATCH v3] rust: compiler_builtins: make stubs non-global
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Dec 5, 2022 at 10:45 PM Gary Guo <gary@garyguo.net> wrote:
>
> Currently we define a number of stubs for compiler-builtin intrinsics
> that compiled libcore generates. The defined stubs are weak so they will
> not conflict with genuine implementation of these intrinsics, but their
> effect is global and will cause non-libcore code that accidently
> generate these intrinsics calls compile and bug on runtime.
>
> Instead of defining a stub that can affect all code, this patch uses
> objcopy's `--redefine-sym` flag to redirect these calls (from libcore
> only) to a prefixed version (e.g. redirect `__multi3` to `__rust_multi3`),
> so we can define panciking stubs that are only visible to libcore.
>
> This patch was previously discussed on GitHub [1].
>
> Link: https://github.com/Rust-for-Linux/linux/pull/779 [1]
> Signed-off-by: Gary Guo <gary@garyguo.net>

Applied to rust-next, thanks all!

Cheers,
Miguel
