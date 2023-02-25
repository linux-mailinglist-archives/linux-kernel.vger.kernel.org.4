Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B1E6A27E2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 09:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBYIUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 03:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 03:20:53 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BC41285C;
        Sat, 25 Feb 2023 00:20:52 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-536be69eadfso42820227b3.1;
        Sat, 25 Feb 2023 00:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+rltlccYYLls/6/80VLpV3Rr0SI6i9Yf8jKNTUIakO0=;
        b=N1+ynUBP7BIR8yJMHSCe2coIJ9/FqCzScTFU5QefhCaAtsPLV2gl/fke00KY3aAQ34
         gPD6eDZbDEFK9pfdcCc9u5rjZAKIZJPTp4CzUH4S00DYx+A8kqDSWoWYWgMSWwUzVjPt
         1/IuNUiTrGEWQNlkt5fobCt/CdVl/29/1SeP6QdfOI7ZcKl8Rw0NlufJPiNRmQGXau/d
         nRHYTbmcKdSeDGwmwFHGPDtpyrfbRvFtnqsAoFH/oBTwyYxMdBE7uijjrwrGn5ym/CDb
         nON6om1eA2m0SAHZQzzNC/iTKPX+HssPbFK4+hVk5mWJuCnT3ofpCsnPS2SEPlTskSU9
         5PsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rltlccYYLls/6/80VLpV3Rr0SI6i9Yf8jKNTUIakO0=;
        b=C8fVANUimQDkVxSnA1dJp0Ml3shPAlk1jQbPJl9JLox7TxrdmqD0ao9k+NTomRXmSN
         0fNKViGL7RIvDOC9pSAwNQAyz2D5Poz5tnNpKNCjj3FP2o+QQhP+s/r2xVpEjG7J9ZQv
         8axR9g4VEOgKUaGiJR23ReaVhybqhLEwjsWf6sIAH1g6XK61aHX20Yw6SGKJAKLx8rDc
         cD1135Pe+gOsnk88BLjGWtlkiVHXzTjakb+RVHOewv7gm8VYr1lT8BvrWCIpmbq/HoQn
         HKxhxYlEhBeHv2Bq6Nr2rkGblByH7iJYkb+JgTG0mjEPOOBp9Erzc3VyHPTzfJAz8XDO
         yRvg==
X-Gm-Message-State: AO0yUKUHmE2HAfIvDDHWBuzIsrI/TTdTfJycstYT9OZCSSfqr5iYvgRl
        EHZzWvWqc8qwRbUcsVfr1qNPmSiIULP9skgN+9k=
X-Google-Smtp-Source: AK7set8e++moIBaY1NhFio11TdxU4kRfW6YaKQ1izSqLuJaajhPq5FeZvpdANs36njnJ85ehD+Io941NVzULcQEL6AY=
X-Received: by 2002:a5b:50b:0:b0:a36:3875:564a with SMTP id
 o11-20020a5b050b000000b00a363875564amr4043718ybp.2.1677313251960; Sat, 25 Feb
 2023 00:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20230224133609.2877396-1-conor.dooley@microchip.com>
 <CANiq72=4ZhV=u2ZUr=x-iAS_iMnV8GSiq0tEn7Tj0NanO=D+xQ@mail.gmail.com>
 <Y/kldmYcl7+2FBRB@spud> <CANiq72=btcBOmrz0=ib=2eZiiV1z4_3qm1cqyw1=jUFDiJ77bg@mail.gmail.com>
 <Y/k65INC1//tXe2U@spud>
In-Reply-To: <Y/k65INC1//tXe2U@spud>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 25 Feb 2023 09:20:40 +0100
Message-ID: <CANiq72mX+vCw=4a7X2oDR-WkVcaQ4KEV-FjYUQZKonJ0anw47A@mail.gmail.com>
Subject: Re: [RFC 0/2] RISC-V: enable rust
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, Miguel Ojeda <ojeda@kernel.org>,
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

On Fri, Feb 24, 2023 at 11:32 PM Conor Dooley <conor@kernel.org> wrote:
>
> It was a few hours ago that I looked properly, but, IIRC, it was a
> conversion from config files to code? My understanding was that
> config files were not copyrightable, hence I looked only at the
> authorship of the code. I'm usually on the anal side about SoB stuff,
> so it is not a matter of me not bothering!

It is not so much about copyright, but about crediting people fairly.
Gary has done a significant amount of the work that eventually became
part of the patches here, and I would have sent the patch with at
least a `Co-developed-by` from him.

Not to mention every commit in the kernel has a SoB, regardless of
what files are modified -- I would not remove a SoB from somebody else
when forwarding a patch even if they were all non-copyrightable files.

Cheers,
Miguel
