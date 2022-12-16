Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED19964F3D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 23:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiLPWP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 17:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPWP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 17:15:27 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326BC1F2D4;
        Fri, 16 Dec 2022 14:15:26 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h26so27827qtu.2;
        Fri, 16 Dec 2022 14:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz2yrlAl5b4n4vwlow3k9uKUHDFsLv1KcaPjbtDhLbA=;
        b=m8agS7BEjEUtwpDVmjnLFYUPMyW1gsL95j+okJxy+BVBsObjDiYYPVT9Eg5yvSbPoy
         yFtt6hp+kJ3z1Y2pWsyS34890m+HzgBCBS9ItrWo53deeVWCSLdPepYvEoJWzxxm5ME2
         erD2v7+8TSbD1f1zJQT2Y1J8yW1VCspDF0hKRhiCN/euWywkXaeCtp284vfb8GINuJFB
         CQ+5UvbzSoghBYW06ZYGBh4OZ903Erc7OVknUnt/o0B4oyP/noIAkOkgWtN067Mv28WZ
         wLUXp1TVsOH8HlutbPBirh4Cytfr2eOz/gCnBldsBHlhu4WMyWql/2Lwze38gASMh+N8
         mpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tz2yrlAl5b4n4vwlow3k9uKUHDFsLv1KcaPjbtDhLbA=;
        b=WzvOPyt0y7hOfim2Z1KkgpiPqjZXjrXwbwLmRYuV+D2MkC/u0fKfwW8gzTdocM5lrs
         FnQnGBRN7UtK2xtIV1jyk2T0glAaPoP0ON+srGPZKto2/qOyChAn/d8O5ONI/PeEej+2
         iZRrwANaJ23UY5frHkfhKNhskvp3Fz0+90ShY6I14AbFv/dYj4YMBOyCDbhzcgmIIycd
         +PvOmvdIyZyEw3X0dAYhVYFX7yC/ou+JnDK4J+Hpn6Zot1+ZSGrIY2OHuSQCnBiUQVa5
         5Ih+noGnqVff6nX9LCgaeKyrA8bA+oSnJ4hNj2u2Wsqhv++Zx62pdPFKh2QgweZiN767
         LxoA==
X-Gm-Message-State: ANoB5pkYNu/vfx8sc5wUwvWnWIezxXB0DJjCVKr2WESXHgigi3/+aFED
        ooqh8wsvdvUXKn9rwdJjky0=
X-Google-Smtp-Source: AA0mqf76osaHm971wbYphZpoHQaBEOaFHyTPCB5s/UiTxPxYC98HyVZSSNf7cgt8KU0S4s/o9Hnvcw==
X-Received: by 2002:ac8:481a:0:b0:3a8:2ca5:8f9b with SMTP id g26-20020ac8481a000000b003a82ca58f9bmr17114846qtq.16.1671228925239;
        Fri, 16 Dec 2022 14:15:25 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006fee9a70343sm2251583qkp.14.2022.12.16.14.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 14:15:24 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 33FAA27C005B;
        Fri, 16 Dec 2022 17:15:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 16 Dec 2022 17:15:24 -0500
X-ME-Sender: <xms:--2cY0srtmhLEi_q5WYEi1qk-PMzlDkSaUeZ3zvXoTxqYg4ab8WC8g>
    <xme:--2cYxftj3tT0odL45LdFBgIzvant__kBnFzn5rn6k1ioyR8fi-2byFbsmwXni9YL
    J03Akg2OasW1TGnJA>
X-ME-Received: <xmr:--2cY_z03mWQJaIJvpleIStetNWMhxl-kfCvw5U2RksyNl9LtFPOfw1lKpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnheptdegheelveffudejffegvdelgffhhfelkeeiieefgeevteejvdegveeu
    ffeihefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:--2cY3MjPFU_I4cqaduWo8_qAjZl00ib-IBh1CRrXxzY0lZByh9yew>
    <xmx:--2cY08uvPZHuYbunkKN04MHr0IKme4Dce0conaxHOWYqiQ5zunXTQ>
    <xmx:--2cY_VNddN6T-SuK7lD_bha89P4L6hYXu4awRaBCD79kDc-sSHcfA>
    <xmx:_O2cYxPrOoAqXk44y1KO-XzJsahUtgEM8M9_2G5pNjKsIiuOjo4qdw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Dec 2022 17:15:23 -0500 (EST)
Date:   Fri, 16 Dec 2022 14:15:16 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>, rust-for-linux@vger.kernel.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH] rust: kernel: drop repetition in offset_of macro
Message-ID: <Y5zt9PSUD6d1MTyZ@boqun-archlinux>
References: <20221216174927.1008629-1-wei.liu@kernel.org>
 <CANeycqo2qKUnyh6XVkBHyAcVjvN9NKJ9sb9bTzkHq7jC1C-B0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANeycqo2qKUnyh6XVkBHyAcVjvN9NKJ9sb9bTzkHq7jC1C-B0w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 06:26:57PM +0000, Wedson Almeida Filho wrote:
> On Fri, 16 Dec 2022 at 17:49, Wei Liu <wei.liu@kernel.org> wrote:
> >
> > It doesn't make sense to allow multiple fields to be specified in
> > offset_of.
> 
> Why do you say it doesn't make sense?
> 
> Here's what I had in mind:
> ```
>     struct Y {
>         z: u32
>     }
>     struct X {
>         y: Y
>     }
>     offset_of!(X, y.z)

For me, it's not very obvious that "y.z" is multiples of token trees
rather a single token tree ;-)

Maybe some examples of the match pattern of macros can help people catch
up faster? Like

	"y.z" => tt [y], tt [.], tt [z]

I will defer to Gary or Bjorn for a better quick guide of Rust macros
;-)

Regards,
Boqun

> ```
> 
> Which is something very plausible.
> 
> > No functional change.
> >
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Alex Gaynor <alex.gaynor@gmail.com>
> > Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Gary Guo <gary@garyguo.net>
> > Cc: Björn Roy Baron <bjorn3_gh@protonmail.com>
> > ---
> >  rust/kernel/lib.rs | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 6a322effa60c..2f3601e4e27e 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -208,7 +208,7 @@ impl<'a> Drop for KParamGuard<'a> {
> >  /// ```
> >  #[macro_export]
> >  macro_rules! offset_of {
> > -    ($type:ty, $($f:tt)*) => {{
> > +    ($type:ty, $f:tt) => {{
> >          let tmp = core::mem::MaybeUninit::<$type>::uninit();
> >          let outer = tmp.as_ptr();
> >          // To avoid warnings when nesting `unsafe` blocks.
> > @@ -216,12 +216,14 @@ macro_rules! offset_of {
> >          // SAFETY: The pointer is valid and aligned, just not initialised; `addr_of` ensures that
> >          // we don't actually read from `outer` (which would be UB) nor create an intermediate
> >          // reference.
> > -        let inner = unsafe { core::ptr::addr_of!((*outer).$($f)*) } as *const u8;
> > +        let inner = unsafe { core::ptr::addr_of!((*outer).$f) } as *const u8;
> >          // To avoid warnings when nesting `unsafe` blocks.
> >          #[allow(unused_unsafe)]
> >          // SAFETY: The two pointers are within the same allocation block.
> > -        unsafe { inner.offset_from(outer as *const u8) }
> > -    }}
> > +        unsafe {
> > +            inner.offset_from(outer as *const u8)
> > +        }
> > +    }};
> >  }
> >
> >  /// Produces a pointer to an object from a pointer to one of its fields.
> > --
> > 2.35.1
> >
