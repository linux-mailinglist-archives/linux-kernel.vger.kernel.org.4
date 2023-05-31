Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14B8717D47
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjEaKlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEaKk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:40:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39164121
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 03:40:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso8178685a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1685529655; x=1688121655;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9wK23t2sGNzjDkReOB3GT1QVBAdm3GmQJMkozq40P0=;
        b=AIu+b8G09ha8tBpJpcXJQCPeq0ed4+ggJKcW4dwZrO08fXZdQ2tw23V6SU1enf/pLe
         xz7/xU4WnxBkRiTFOQY9UCLBHxkOl1HE1FQp14w8Cb7OqtWtkqHxU47p2MWZTfI2rljF
         +mWsRulFmiOLUXs3IAEPomaoUPhs2XbihXDKeq1AlPIa3OBboQjHMM190lvIxiLU+Mur
         8q0igSTFZcpB+JYr1Jbrn+mKnOrrESw+GQZI21hx5lIF3gAFAk3QitJ81ceVFc+szrCF
         iR6Sqn5FZHQDvrZJEEMh4BDAEHMTi3Sen5rp4moPXJwgg0MXry5YG4eBhHEnI2SFicW7
         yCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685529655; x=1688121655;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D9wK23t2sGNzjDkReOB3GT1QVBAdm3GmQJMkozq40P0=;
        b=ZbeWcKsGfhpPK7MmB+TfaktxE2eDrVGhTQjymzck2942SmKGE/RMq7xrW7Z9bbKe5i
         TCiRxPD7YShV8u8Tib6xz2Nr4sGX+5tXxu4v2IMuci6pg0DgiN6lomUEUH6ENVJ416WD
         FZIKptGJDtXeATkzjA+MLg2x6GKZNI5zk21aJ3P3zcZmsvUG6nDjGcMCMg/xwXgUmEEq
         AdKenf7enKJoSvVBpEZi5BJ+rCwEonxEtZ4W6/L23x9JT1J7nTmPKiYEdKRoTImjuE0J
         vGa/ZiOTQHbB3kloC3y1Aqv8Pae7ZfclX8iB2mHvzdveWl7mjt7vlIVqwDbE7n4pWgmN
         Kjfg==
X-Gm-Message-State: AC+VfDzqjpvw0bLME+24KlO48wcBUhlKJa3K09VdkyldDCble8EG7qo2
        FNN70z7IJpSeiD9jvKnkyavssg==
X-Google-Smtp-Source: ACHHUZ7gkn3xn/E4i2JfCKzoMtUX7uPofz9OD1IYCOir3fHI3gRcIYfxWM4KiKVknbBOQRkWmqzCmA==
X-Received: by 2002:a17:907:ea1:b0:957:48c8:b081 with SMTP id ho33-20020a1709070ea100b0095748c8b081mr4688011ejc.24.1685529655648;
        Wed, 31 May 2023 03:40:55 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id lh27-20020a170906f8db00b0096f03770be2sm8697953ejb.52.2023.05.31.03.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 03:40:55 -0700 (PDT)
References: <87leh69par.fsf@metaspace.dk>
 <20230531090032.3667467-1-aliceryhl@google.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH v1 5/7] rust: workqueue: add helper for defining
 work_struct fields
Date:   Wed, 31 May 2023 12:18:47 +0200
In-reply-to: <20230531090032.3667467-1-aliceryhl@google.com>
Message-ID: <87zg5k3hs9.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> Andreas Hindborg <nmi@metaspace.dk> writes:
>> Alice Ryhl <aliceryhl@google.com> writes:
>>> +/// Used to safely implement the [`HasWork<T>`] trait.
>>> +///
>>> +/// # Examples
>>> +///
>>> +/// ```
>>> +/// use kernel::sync::Arc;
>>> +///
>>> +/// struct MyStruct {
>>> +///     work_field: Work<Arc<MyStruct>>,
>>> +/// }
>>> +///
>>> +/// impl_has_work! {
>>> +///     impl HasWork<Arc<MyStruct>> for MyStruct { self.work_field }
>>> +/// }
>>> +/// ```
>>> +///
>>> +/// [`HasWork<T>`]: HasWork
>>> +#[macro_export]
>>> +macro_rules! impl_has_work {
>>> +    ($(impl$(<$($implarg:ident),*>)?
>>> +       HasWork<$work_type:ty>
>>> +       for $self:ident $(<$($selfarg:ident),*>)?
>>> +       { self.$field:ident }
>>> +    )*) =3D> {$(
>>> +        // SAFETY: The implementation of `raw_get_work` only compiles =
if the field has the right
>>> +        // type.
>>> +        unsafe impl$(<$($implarg),*>)? $crate::workqueue::HasWork<$wor=
k_type> for $self $(<$($selfarg),*>)? {
>>> +            const OFFSET: usize =3D $crate::offset_of!(Self, $field) a=
s usize;
>>> +
>>> +            #[inline]
>>> +            unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::wor=
kqueue::Work<$work_type> {
>>> +                // SAFETY: The caller promises that the pointer is not=
 dangling.
>>> +                unsafe {
>>> +                    ::core::ptr::addr_of_mut!((*ptr).$field)
>>> +                }
>>> +            }
>>=20
>> What is the reason for overriding the default implementation of `raw_get=
_work()`?
>>=20
>> BR Andreas
>
> That's how the macro checks that the field actually has the type you
> claim it has. If you lie about the type, then `raw_get_work` will not
> compile. (See the safety comment on the impl block.)

Got it =F0=9F=91=8D

I was thinking we could do the type check without redefining the method,
but that blows up complexity wise fast, since we need a trait to do it
to support `Self` in `$work_type`. It strikes me as a bit of a hack to
overwrite an otherwise fine implementation, but I guess it is the least
complex way.

Also I am a bit annoyed that we need to state the `$work_type` type at
all, since it is available in `work_field`. But I can see no way around
that.

BR Andreas
