Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCC36D2A67
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjCaVxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjCaVxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:53:41 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FE324AF3;
        Fri, 31 Mar 2023 14:53:08 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id dw2so199227qvb.11;
        Fri, 31 Mar 2023 14:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680299588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7Ebxk8AphIDmwnXn1+IjoPN5NSZTsfBvhDF5oJh7jY=;
        b=O2vDYkYf5AsS15gx5pSGjZzR6Axng0uCxYsCxypYqA8N355Ct3GQEHLuomCfkdNgGf
         O1AOHCQfDybxI37EoT/og7LwSDTNkJptBb51ywn9oT2hX2rTiAbIdGTJGDsPUhmu5e1o
         zN5ce0TVqX57WIMf6WoSSxSOVHx3KMNo4v8AthMjHAWxxxmpEJq5Wy3ELITEpps2kxYa
         w9hj/vCFktaYQ4prjPtwQBladnPz4T1oNYFz+yiCnnT/b5OHh6NfPXU7rtW4pmBiSG/F
         Y0WdIZafYKh4lDu9URVZuJ3Z05YdQ/cnm3NlxDxG37fQfoTF38v8Pq2arpjTSfbggUiu
         7M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680299588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7Ebxk8AphIDmwnXn1+IjoPN5NSZTsfBvhDF5oJh7jY=;
        b=ZombBOawnAvDCottEbRZvZXrMPPtAA4EVEyjm7dvrZO46oJjILQVISMNJbhTLDQ6g8
         /0iojgfnrgbV2X6PSd802l2PtlC/TEZwaBSFxuRbKiU3itV7G8BoXe4M5aexnQELx9zq
         rxl44HYn8hmd3S2QUsw5zYFJGEf7iatUoiGAkqQKET8DldaYB+W0KKxxu2pzHtpjs32z
         UAG/ChuuokMyuKFyN/xx36SVrBnzo+0dlFjvSDWLuIzoDUcLjjGu4+5Q2CoTb2CKRcru
         wCs9wU5F/QW4+AUtSPv/HvKuWJRmo8whPw+cbDRaJ9Xovr8d6oRTX+9yKyhjtNpk1Rjy
         MY4w==
X-Gm-Message-State: AAQBX9eMt72wE4fxN9POzSmZKOXweLJX/TtrJ8jwJXFQowrmaBT8nuEf
        BvBLjOGZnvLFAx9t/1glPng=
X-Google-Smtp-Source: AKy350ZF34ugc9xi1UXbPvmjKXVkZFGlTZq1tjdSY5rb+ySld+VRh+Rw7COi3L1WQX3fT4llp9DseQ==
X-Received: by 2002:ad4:5c6e:0:b0:5ac:239a:9200 with SMTP id i14-20020ad45c6e000000b005ac239a9200mr55249755qvh.9.1680299588087;
        Fri, 31 Mar 2023 14:53:08 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t18-20020ac87612000000b003e4d96eae60sm893950qtq.4.2023.03.31.14.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:53:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0B6B827C0054;
        Fri, 31 Mar 2023 17:53:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 31 Mar 2023 17:53:07 -0400
X-ME-Sender: <xms:QlYnZCAj5lCMnCKbWwduSoSjONQIWMoyvQQpCluwqZWjZ89U-Yfd8Q>
    <xme:QlYnZMjQAZ9s-G75ZXjNL3Db1hG6jU3I4Sqx8Vl66kkFw3d1sKfSOkwDDTc2hVORu
    thzLr5tLV8boy57SA>
X-ME-Received: <xmr:QlYnZFntGTUuNhfDg4aVu5f5MyFNi1tm8VJr_Ji5mRq88eHFigTkXDw7ZB2-pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeivddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:QlYnZAxxNyiMy0yc7RSsoNcPgygYljcNVYg9GOCZoMPeGh82OM6UIQ>
    <xmx:QlYnZHSuf8puKaesFqJZ6SM40DAHoub15-AWJq-BS061wyUk10r7nw>
    <xmx:QlYnZLYb8Nr6E0MmfiBeV5XNgiobGBVyBuzwjNg1KcfiBhbtGMmMEA>
    <xmx:QlYnZPaHPISlit1XU3mXDuuWeTGwg6BKMMEvPsSTW5KDOziiyoUilA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 17:53:05 -0400 (EDT)
Date:   Fri, 31 Mar 2023 14:52:18 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v4 01/15] rust: enable the `pin_macro` feature
Message-ID: <ZCdWErZLBFl205UP@boqun-archlinux>
References: <20230331215053.585759-1-y86-dev@protonmail.com>
 <20230331215053.585759-2-y86-dev@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331215053.585759-2-y86-dev@protonmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 09:51:35PM +0000, y86-dev@protonmail.com wrote:
> From: Benno Lossin <y86-dev@protonmail.com>
> 
> This feature enables the use of the `pin!` macro for the `stack_pin_init!`
> macro. This feature is already stabilized in Rust version 1.68.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Alice Ryhl <aliceryhl@google.com>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/kernel/lib.rs | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 223564f9f0cc..4317b6d5f50b 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -17,6 +17,7 @@
>  #![feature(core_ffi_c)]
>  #![feature(dispatch_from_dyn)]
>  #![feature(generic_associated_types)]
> +#![feature(pin_macro)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
> 
> --
> 2.39.2
> 
> 
