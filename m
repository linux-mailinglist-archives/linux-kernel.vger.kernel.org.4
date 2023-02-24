Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25E06A233F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBXUpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBXUpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:45:19 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E6422DC5;
        Fri, 24 Feb 2023 12:45:18 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-53916ab0c6bso11904117b3.7;
        Fri, 24 Feb 2023 12:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gbwZ7KJxlkNyIKWiZuH4bGbwcOZpsexyARY/sQCYU7Q=;
        b=EM6i17xmf4rHEkb6+ZAxBNfq12n66NGEbB3Bp0oCP6oXSZB+KWXgzh18MCjf8H0KqO
         buVvmlAfgnzYq7uX31oLSJ0w+3QaSYZ7LsPdi7nTrssLwQ8+j5EA9bC/WqcCz4FI4Olh
         Ox67BeF01mkW8yvtN9Z5/uQj2LxLLk1ByRbpIz5qHdqcRL+mirLXAELY4tz3FVU5pb2V
         +HO0kiEcs7n7xPiJwz2paZls62gb7WzQw0CCvRIAyYBUeLZ9dEnA29Xa+DXYQBJmkBVG
         TSgiVJ8a2gDNODRc+UclMPNqKnlCXFLZAW2SeqkdjdgQ+W8nSfg683q6VbHQfQ5WN/K9
         sqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbwZ7KJxlkNyIKWiZuH4bGbwcOZpsexyARY/sQCYU7Q=;
        b=myj0C+11H0A4zhe9HdVS23mmv99PZRqVgoYO4THmLXjPOWhcKrVVYNaCBYefo2uKW3
         jctOPqBE3+bCo+isi7ZtRs7pL3qB+1a2a5VIRPelPH5S9rsRWOC6aVrnHn8VzcM6JQKg
         +/g7tyP3QtidknZxt0oDtxjcq8y0uowRGiYKRrc9+gxPJ91Jw7qoMDDNRfQNF3IB/enA
         E6xXENk1/a46yeP4EzAba73WYG4x8yF6w/mzulPV5vmv4Q/ZxGjzteZkb1twmzeXIBt4
         BwbrJgMYgfqeN3e1lHrExTv9RIV+/AEPHosczx3vbyHQc9KG1q+zn1A+zR48NXKbXV8Y
         ve5Q==
X-Gm-Message-State: AO0yUKULKtjhMj2WiGxsf2kZui2nDkV1Cqn3EVW8h+7bjdayqtoAoBu4
        /ZvQARfpdfJLYUev0HVw1eDTzkO6hhnAZDrZJgo=
X-Google-Smtp-Source: AK7set84Zz1Zr7T7N8qHPRl6RNV3+nFpbLtN1bYDnhyNzpxCSNaUv0uEVh3ISprN44/2u3gUR//r6clsUubamtYQ/C4=
X-Received: by 2002:a81:af1b:0:b0:533:8080:16ee with SMTP id
 n27-20020a81af1b000000b00533808016eemr5353877ywh.10.1677271517377; Fri, 24
 Feb 2023 12:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20230224135044.2882109-1-conor.dooley@microchip.com> <20230224135044.2882109-3-conor.dooley@microchip.com>
In-Reply-To: <20230224135044.2882109-3-conor.dooley@microchip.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 24 Feb 2023 21:45:05 +0100
Message-ID: <CANiq72m1bnHZEd1n+tzaTXYqk8kU83CEPSFO7TBMX44J3poKOw@mail.gmail.com>
Subject: Re: [RFC RESEND 2/2] RISC-V: enable building the 64-bit kernels with
 rust support
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, rust-for-linux@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Fri, Feb 24, 2023 at 2:51 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> The rust modules work on 64-bit RISC-V, with no twiddling required.
> Select HAS_RUST and provide the required flags to kbuild so that the

HAS -> HAVE

> diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
> index 6982b63775da..197919158596 100644
> --- a/Documentation/rust/arch-support.rst
> +++ b/Documentation/rust/arch-support.rst
> @@ -15,5 +15,7 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
>  ============  ================  ==============================================
>  Architecture  Level of support  Constraints
>  ============  ================  ==============================================
> +``riscv``     Maintained        ``rv64`` only.
> +============  ================  ==============================================
>  ``x86``       Maintained        ``x86_64`` only.

I think this separator between rows should not be here (it is not in
`rust-for-linux/rust`). Please see
https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#simple-tables.

Cheers,
Miguel
