Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9D1641E3C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 18:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiLDR1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 12:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLDR1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 12:27:07 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4603A10FE4;
        Sun,  4 Dec 2022 09:27:06 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id n186so10602262oih.7;
        Sun, 04 Dec 2022 09:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CkwAPeoCUs3lm02qIrL4crb0Gr5/YPZRr/bbYFtEjJM=;
        b=BToVcvWVqt9/dfNi5D4HDFG8I8T1lfwFvGoyJmi++n51KK7MBib3/9z31yn7jRS4uJ
         79lNNS3qbDNxkZ4Ph2vPwmDS/DEfVp3RXu7sZ52MH40JjkjPLOUUyYn08wv6AKJBnYLY
         LERgDaCM4FeyvqtmUMhubj2De1IzVMXsM+ZxlU+tedPEY7r8hsQXhOeKafNDAbtIlq7G
         30F3Rv5YzL5idkpFXBR1zEByZowe3iROUkILvgxC+KChDIn2gMtR2NLNzF6kLSxmazt2
         x/9UnoWzn5I//QHkG//pYu1ujugrCDWBjM2hWmzKWIQvj21NtQYdjKv2STDUe7I718y/
         eQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CkwAPeoCUs3lm02qIrL4crb0Gr5/YPZRr/bbYFtEjJM=;
        b=yH8e9BI/O+Ya/0la5VtuR4iDrQEigyXeSuAAi0Zo8Rn/7vvctXzMCLFb/63SNn0rbX
         DSaz+C3hNWJQGUowWMxhK9b1lL+CIY0x9DBen2MDrY1OJRb8Zgs3bEznsJ+mQtp1uKiT
         PhCWPNYL9kaOuSeq/geRF1ml7zOxhqBgt5RxDz8auLWdM9dxFS3gENeEqrJXqCfF7RQb
         2w2VUahnPlGvPYA6Ag2y4FFOgRwln36vlhc5kVJY5ZiTJ2nCeOG9kpCHgl9/0Rgkz6ak
         La7Cpt27hmFTh1c/5cLzAvTzCTAgIxA2anJ4vdKKEdodVYLWD+NFpCCQ6PJZCnuZJtPz
         G7sA==
X-Gm-Message-State: ANoB5pl2Txukjh8YnqrhN1sOTC/kHL4POhW+SiIThiA90No9XrVjUIgg
        iQ5LimyEqH2PHAlQmKb30DdT++j+spHWOa+e+7CCtQm+/i8=
X-Google-Smtp-Source: AA0mqf4h+bzPRaf0PWI9aa0KezTRo2S2If1j3UH0ur7AeUbJWwysICYOSoL1ykwETMU6PNiPG+d7IwV9JoGpjdYFSvQ=
X-Received: by 2002:a05:6808:1705:b0:359:c652:ff7e with SMTP id
 bc5-20020a056808170500b00359c652ff7emr29267495oib.254.1670174825561; Sun, 04
 Dec 2022 09:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20221202161502.385525-1-ojeda@kernel.org> <20221202161502.385525-21-ojeda@kernel.org>
 <Y4y/ovfF3len/22J@gallifrey>
In-Reply-To: <Y4y/ovfF3len/22J@gallifrey>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Sun, 4 Dec 2022 17:26:54 +0000
Message-ID: <CANeycqrT69HJWEBZwbuhTehSy1qFF7A4q38cb5TqU1yf=nMLOQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/28] rust: str: add `Formatter` type
To:     "Dr. David Alan Gilbert" <dave@treblig.org>
Cc:     ojeda@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Adam Bratschi-Kaye <ark.email@gmail.com>
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

On Sun, 4 Dec 2022 at 15:41, Dr. David Alan Gilbert <dave@treblig.org> wrote:
>
> * ojeda@kernel.org (ojeda@kernel.org) wrote:
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> >
> > Add the `Formatter` type, which leverages `RawFormatter`,
> > but fails if callers attempt to write more than will fit
> > in the buffer.
> >
> > In order to so, implement the `RawFormatter::from_buffer()`
> > constructor as well.
> >
> > Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> > Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Reviewed-by: Gary Guo <gary@garyguo.net>
> > [Reworded, adapted for upstream and applied latest changes]
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > ---
> >  rust/kernel/str.rs | 57 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > index a995db36486f..ce207d1b3d2a 100644
> > --- a/rust/kernel/str.rs
> > +++ b/rust/kernel/str.rs
> > @@ -406,6 +406,23 @@ impl RawFormatter {
> >          }
> >      }
> >
> > +    /// Creates a new instance of [`RawFormatter`] with the given buffer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
> > +    /// for the lifetime of the returned [`RawFormatter`].
> > +    pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
> > +        let pos = buf as usize;
> > +        // INVARIANT: We ensure that `end` is never less then `buf`, and the safety requirements
> > +        // guarantees that the memory region is valid for writes.
> > +        Self {
> > +            pos,
> > +            beg: pos,
> > +            end: pos.saturating_add(len),
> > +        }
> > +    }
> > +
> >      /// Returns the current insert position.
> >      ///
> >      /// N.B. It may point to invalid memory.
> > @@ -439,3 +456,43 @@ impl fmt::Write for RawFormatter {
> >          Ok(())
> >      }
> >  }
> > +
> > +/// Allows formatting of [`fmt::Arguments`] into a raw buffer.
> > +///
> > +/// Fails if callers attempt to write more than will fit in the buffer.
> > +pub(crate) struct Formatter(RawFormatter);

Here we mention that `Formatter` fails if callers attempt to write
more than will fit in the buffer.

This is in contrast with `RawFormatter`, which doesn't fail in such
cases. There's also a comment there explaining it (not visible in this
patch because it's already there), but I reproduce below:

/// Allows formatting of [`fmt::Arguments`] into a raw buffer.
///
/// It does not fail if callers write past the end of the buffer so
that they can calculate the
/// size required to fit everything.
///
/// # Invariants
///
/// The memory region between `pos` (inclusive) and `end` (exclusive)
is valid for writes if `pos`
/// is less than `end`.
pub(crate) struct RawFormatter {

`RawFormatter` is used to implement the "%pA" printf specifier, which
requires this behaviour.

> > +
> > +impl Formatter {
> > +    /// Creates a new instance of [`Formatter`] with the given buffer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
> > +    /// for the lifetime of the returned [`Formatter`].
> > +    #[allow(dead_code)]
> > +    pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
> > +        // SAFETY: The safety requirements of this function satisfy those of the callee.
> > +        Self(unsafe { RawFormatter::from_buffer(buf, len) })
> > +    }
> > +}
> > +
> > +impl Deref for Formatter {
> > +    type Target = RawFormatter;
> > +
> > +    fn deref(&self) -> &Self::Target {
> > +        &self.0
> > +    }
> > +}
> > +
> > +impl fmt::Write for Formatter {
> > +    fn write_str(&mut self, s: &str) -> fmt::Result {
> > +        self.0.write_str(s)?;
> > +
> > +        // Fail the request if we go past the end of the buffer.
>
> Reading this for the first time, I'm surprised by this, perhaps a
> bit more comment is needed?  I was expecting that nothing would
> let pos pass end.

Given the comments I highlight above, do you think we still need more?

(My impression is that you're reading this without the context I tried
to explain above, and this context may perhaps be sufficient.)

Thanks,
-Wedson
