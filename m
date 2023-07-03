Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAA9745B44
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjGCLhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjGCLh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:37:28 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3395E5B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 04:37:26 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-51da39aa6dcso2872893a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 04:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688384245; x=1690976245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5KVnJtuQwMZQfNIqcWt+goZd/DD7fJW4ut0aNiWQuDg=;
        b=jza+LFQPyng7N+NwcIVlSKpYKdTN68JmzwedT1tGetbfa+s4q50pMmTKrM5KGY5Srn
         Cv11Cgsfy01gipGEJeed37HohlhCe+iScvcioLxDxmJQr6NJpxlqYmwqYXoZXpi0TJ5I
         3D2t2FvPk37x+uhUPoHWOyTmB75DvF04e3gx/OEvroTStoFlr+Wj0OLh6jnXJZQic9/r
         BDkHdZsIBSJZQV4WfOznp5TgfS3z3TUHKmB3R9yC9hLCYv9HkgyLwWtfleSk1+5Cud7L
         E6vOSoC8TRQDAfZeoPkOtJf4OV++xq5murXZZHVRHnzlAO/7ffs+oYxaA5TkTkny0BFh
         Hmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688384245; x=1690976245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KVnJtuQwMZQfNIqcWt+goZd/DD7fJW4ut0aNiWQuDg=;
        b=cnf9JJUGuKxXbCooS1dqon/ekm9uIjIHVKsddvalEiEj82qefQTC6zi+A1UbDIX8dC
         xO+y3QDfJVJneczoytrk3/O2HqxqXNQsWEjDCf537jq6cFVJch0xvdUanbKs1ic8RNOB
         Oj5sVq60RsYxEGGEJXcQsoyfB6AOGrW/PNtv1gJXtYoveQR+e04o0lUS+UCUGVcAhO2L
         ih1j3K+c2TN9dexlQWICGTrXd5PDr+HDq0f0S/b3VgEQySNviCxXz7WKrUdsl/elZSS2
         YM0iYIlSAjvWV5BaEDNAeiX0S4fIeocxgXSj8tRH39ypcr7as+x4J/h2bt336kzTdhD/
         grYA==
X-Gm-Message-State: ABy/qLY+1vcBkCZgs9ZbYddlO8sxWynis8vzJbnYPFZDex8CMapnRklM
        gzPCQyJ9I5fTCGKIOwYGDeFm4qxB0wvlq1I=
X-Google-Smtp-Source: APBJJlEEFQL7cz8xFtZbp6U0Zty2ffqyn0hzeT6NK8BoxMapeaKnv4aHWn3qKxYC1CiyBKDZd4KQFd1x9Uw7Q4g=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:c05e:0:b0:51d:25d3:512e with SMTP id
 u30-20020a50c05e000000b0051d25d3512emr45181edd.6.1688384244845; Mon, 03 Jul
 2023 04:37:24 -0700 (PDT)
Date:   Mon,  3 Jul 2023 11:37:07 +0000
In-Reply-To: <20230628171108.1150742-1-gary@garyguo.net>
Mime-Version: 1.0
References: <20230628171108.1150742-1-gary@garyguo.net>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230703113708.1758734-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust: macros: add `paste!` proc macro
From:   Alice Ryhl <aliceryhl@google.com>
To:     gary@garyguo.net
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gary Guo <gary@garyguo.net> writes:
> This macro provides a flexible way to concatenated identifiers together
> and it allows the resulting identifier to be used to declare new items,
> which `concat_idents!` does not allow. It also allows identifiers to be
> transformed before concatenated.
> 
> The `concat_idents!` example
> 
>     let x_1 = 42;
>     let x_2 = concat_idents!(x, _1);
>     assert!(x_1 == x_2);
> 
> can be written with `paste!` macro like this:
> 
>     let x_1 = 42;
>     let x_2 = paste!([<x _1>]);
>     assert!(x_1 == x_2);
> 
> However `paste!` macro is more flexible because it can be used to create
> a new variable:
> 
>     let x_1 = 42;
>     paste!(let [<x _2>] = [<x _1>];);
>     assert!(x_1 == x_2);
> 
> While this is not possible with `concat_idents!`.
> 
> This macro is similar to the `paste!` crate [1], but this is a fresh
> implementation to avoid vendoring large amount of code directly. Also, I
> have augmented it to provide a way to specify span of the resulting
> token, allowing precise control.
> 
> For example, this code is broken because the variable is declared inside
> the macro, so Rust macro hygiene rules prevents access from the outside:
> 
>     macro_rules! m {
>         ($id: ident) => {
>             // The resulting token has hygiene of the macro.
>             paste!(let [<$id>] = 1;)
>         }
>     }
> 
>     m!(a);
>     let _ = a;
> 
> In this versionn of `paste!` macro I added a `span` modifier to allow
> this:
> 
>     macro_rules! m {
>         ($id: ident) => {
>             // The resulting token has hygiene of `$id`.
>             paste!(let [<$id:span>] = 1;)
>         }
>     }
> 
>     m!(a);
>     let _ = a;
> 
> Link: http://docs.rs/paste/ [1]
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

