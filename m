Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED33D70F655
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjEXM0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjEXM0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:26:44 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08150139
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:26:43 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-513f8141094so941816a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684931201; x=1687523201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tIkJCVY+tMqNuU9Hdw7jNNdVzKzit4T0GD2WdhoZSXQ=;
        b=Rf0miXKtnbI4iEIXnusCA82/4rOsQIVvu9oayiSk1I7Dqc9En3wSLFxnjUErf0qLVa
         5KAMme6jheRdEI8gnBPwkCmhQVED/QGDHTgZLbzMB5ZR4iUnlN/djzTMiy0JZO/TF2s1
         nJzbPCf3eo3CYZdvYUnOuLyl/r03i2DjvnXQ3lunbiMziTZ6KXC93Jrz6kEUbg3r+eY3
         6Qb0Mzv2vDX1y4Ut2U5vyMmQcwLtKMbzG874bgg1SOn6cwo7hhWFWsaWl+Cc97/FrTN6
         ZYndWmGkM+enrawaHU4L38v9HejkFTTP3gjfqq9l7YY9WhVBau7Kt4lMFE49Rt6tgjGu
         v2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684931201; x=1687523201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIkJCVY+tMqNuU9Hdw7jNNdVzKzit4T0GD2WdhoZSXQ=;
        b=M61R43OulVGwpU+K0tn6cPwUT1KkfXIZRpITQaMGZOiOdb0g3NhR2SNMqFW+Fcxr3F
         yYEcu2ccuI+wJ3EsbqXHQcrMZlv6XGrUQSxpQjjZrM+/4n48LLIF46A2PGwMs47aJmLP
         g4R/uVldNv4G6BFDOrgC7RRgxqSv2/wKlQNtZ853m2JZ5mctcybLEMmgX89cfrFpHKA/
         1i9JI7eeJei3Sv+G5xKQa5OcbYwIJ/PYsie4tiETxtUuvU+rOBIlKfVSXOg5TJgRx30i
         KiXJ+BLWXNvy9NDKAl8yWLpksPpiUgMWZNVf/Vm59+6qtNiCpJ71mYXS03TROTw3Oxn+
         I0eQ==
X-Gm-Message-State: AC+VfDx7V/pvwyZTPgvy8mqbjQJrHz9NvmJxkdLjkLZI1pgy8UKZNl+a
        RTEue74NJv+9FRXy+PDdfBqXLQ4iOTbi78g=
X-Google-Smtp-Source: ACHHUZ6lrbZQBWSWqXTum+8RwDWhnUR59VF9KPwRaF43x13cn/85dwpHjlzTnW6IWF9TZhfFxQQ3n0FHhXp7TVc=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:bb64:0:b0:50c:d8e:5f4b with SMTP id
 y91-20020a50bb64000000b0050c0d8e5f4bmr820708ede.8.1684931201472; Wed, 24 May
 2023 05:26:41 -0700 (PDT)
Date:   Wed, 24 May 2023 12:26:39 +0000
In-Reply-To: <20230523164818.0a44fec8.gary@garyguo.net>
Mime-Version: 1.0
References: <20230523164818.0a44fec8.gary@garyguo.net>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230524122639.2500848-1-aliceryhl@google.com>
Subject: Re: [PATCH v1 2/7] rust: add offset_of! macro
From:   Alice Ryhl <aliceryhl@google.com>
To:     gary@garyguo.net
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        tj@kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gary Guo <gary@garyguo.net> writes:
> On Wed, 17 May 2023 20:31:14 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>> +#[macro_export]
>> +macro_rules! offset_of {
>> +    ($type:ty, $field:ident) => {{
>> +        let tmp = ::core::mem::MaybeUninit::<$type>::uninit();
>> +        let outer = tmp.as_ptr();
>> +        // To avoid warnings when nesting `unsafe` blocks.
>> +        #[allow(unused_unsafe)]
>> +        // SAFETY: The pointer is valid and aligned, just not initialised; `addr_of` ensures that
>> +        // we don't actually read from `outer` (which would be UB) nor create an intermediate
>> +        // reference.
>> +        let inner = unsafe { ::core::ptr::addr_of!((*outer).$field) } as *const u8;
>> +        // To avoid warnings when nesting `unsafe` blocks.
>> +        #[allow(unused_unsafe)]
>> +        // SAFETY: The two pointers are within the same allocation block.
>> +        unsafe {
>> +            inner.offset_from(outer as *const u8) as usize
>> +        }
> 
> This has no protection against using `Deref`. The memoffset crate has a 
> 
> let $type { $field: _, .. };
> 
> line to ensure that the field is a direct member of type and deref is
> not happening.

Added. I had to change `$type:ty` to `$type:path` to get that to
compile, since otherwise you can't use the token in a pattern. However,
I think it's fine - this is temporary anyway until the standard library
gets the macro.
 
>> +    }};
>> +}
>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>> index 9f94fc83f086..ec583d13dde2 100644
>> --- a/scripts/Makefile.build
>> +++ b/scripts/Makefile.build
>> @@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
>>  # Compile Rust sources (.rs)
>>  # ---------------------------------------------------------------------------
>>  
>> -rust_allowed_features := core_ffi_c,explicit_generic_args_with_impl_trait,new_uninit,pin_macro
>> +rust_allowed_features := const_ptr_offset_from,const_refs_to_cell,core_ffi_c,explicit_generic_args_with_impl_trait,new_uninit,pin_macro
> 
> Side note: once we bump our compiler to 1.71, we should switch to the
> built-in `offset_of!` macro and get rid of these unstable features.

Agreed. I mentioned that in the commit message.

Alice
