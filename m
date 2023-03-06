Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1CE6ACE0D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCFT3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCFT3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:29:00 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0969D125A2;
        Mon,  6 Mar 2023 11:28:59 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y144so9277386yby.12;
        Mon, 06 Mar 2023 11:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678130938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ttfPrW0GRQ9nbvMrVtjoiB2Knz31FGcqjmMbmblOGw=;
        b=SU2Xcpc8fy/jDn5Hq/sgA44RX6PMSz8Z/CGlbTyvJvLrVhvSx8x2b1d6eRLg5UuFBZ
         9eVJz2MI5oZX+kbqnjMoreoLj9gtAXJEVmsGQH9WiYH5SIAaxVOwcUykaRPeUNNBY40Z
         p6N5Gg6h45DIpjQLit8V41JA6snJWQUyo8I+WomncvbRMQ/Q1RKTSADQcVgXWYMWXW3U
         BANkIPKJO9EOekb2ftXDbgdEMXarRb//A/+hqBYV49Ckk/3AGLVxvnH3CoiHh7ycyQEx
         DZ0cS4Sn1p/f5m7wcYMPv3Iio7GI4kQP1JdUN7MUomAf4xMjU4WiVFbT47UReR3zYTHi
         Sgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678130938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ttfPrW0GRQ9nbvMrVtjoiB2Knz31FGcqjmMbmblOGw=;
        b=uLZ2qf01ynt09ym2sNSmLLOcWHDSDOJbODL4GILkO8ahxV2F8A5IzL1L4OEBJQL6HH
         o1qjvis7KXB1qIvEsEmquAFzvyC8MllT6xCZOwXrVYypa1EMeevZBeLW+CXuwqf5Sc4P
         IqHEe9KwcpRmMPB+yxNSTOvokYuc4gLJfS9Ed/SqxCR0MBtG11lLzBlGGwLVH7Km/ZeC
         g1OFeNDwARZm5MeIXV+v1wqjtOqzF8AIxSzL1bYcDgaO+2UrB3CzdT2q2O1SVbgSS3tr
         kYgcmJM36d/uir2fbJ2jtaeRXQ14NOKEMUEY10poXgQxM6v8PtZiZ0EnhJEgLBO3iI/d
         NQ3w==
X-Gm-Message-State: AO0yUKX3OpUVByA53EsMhm5oQ7a9rqVWpmF9KXHCdRFKoNHB7aTalOWD
        R/niFg/b3iIM4FjFvLhFdFcUjWaAbHI1L+MG9o4=
X-Google-Smtp-Source: AK7set+Md8UTQSh/AP0LixVNnGi65tvY4YYP3IbXzgyvl8DJUVpm6e49kNmGaSXZTytFJEf4T12wESB3k1aIa0rjZuI=
X-Received: by 2002:a5b:191:0:b0:a6f:b921:cded with SMTP id
 r17-20020a5b0191000000b00a6fb921cdedmr5516798ybl.2.1678130938238; Mon, 06 Mar
 2023 11:28:58 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72ndkF0JM1kV=ewnO4uGirDowHDGLkhvjQgtLnuPEk_hTQ@mail.gmail.com>
 <mhng-a7ada57e-543c-434b-a4f3-4fbda9238eb0@palmer-ri-x1c9a>
In-Reply-To: <mhng-a7ada57e-543c-434b-a4f3-4fbda9238eb0@palmer-ri-x1c9a>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 6 Mar 2023 20:28:47 +0100
Message-ID: <CANiq72=hvS6KxxkLocFOrU4E4pNi=y4OuJLm3iSiPGmi5B178Q@mail.gmail.com>
Subject: Re: [RFC 0/2] RISC-V: enable rust
To:     gary@garyguo.net, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, bjorn3_gh@protonmail.com, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Mon, Mar 6, 2023 at 8:18=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com> =
wrote:
>
> It's time for the next release.  IIUC there were some authorship issues
> here, did you guys want to re-spin this with those sorted out?  I can
> give it a shot if you want, but I'm probably as likely to screw it up as
> anyone else...

No problem on my side, and either way is fine! Thanks!

I think what is important is that Gary is aware and agrees.

Gary: do you prefer to be the main author or the `Co-developed-by` author h=
ere?

Cheers,
Miguel
