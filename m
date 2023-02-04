Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EAE68ABFB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjBDSv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjBDSvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:51:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309BA76BD;
        Sat,  4 Feb 2023 10:51:54 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q19so8088462edd.2;
        Sat, 04 Feb 2023 10:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfFN7EWqV1F1vf3fk6as4NIr4ktnOVKAa71sjHjqTF0=;
        b=J2Y2FoUmmKXAew8ZSjpqdjQk5Rja8GR5lTev+PLm56iY3CfMlFJf2XOU4QQyGyQ2uC
         IG7uJn7Xfhz6A8ps5sPD33UjwnMYeuz3dFiyeWFFEA5e8xdSAsWzVJwO7KYrs6+AnUiG
         E5VY6Hso+wbGQzNRn1NQchvC5CHFwionOEO4cAM+tqYBA7VeVstEeYf1s4JVcXalBcHZ
         RxJ3Q6sfdyaD2vU8ZjRln7AeadA3dYGX2KVnUFvZJ3c+BZwqmwRayrTVUblnDMWn0wfY
         tl9sp1Ft7kmC9PrVXTydhwG/Mnqq6Xeh6hlph42ZdcZU1luP4uaSRLpV0vDJwN0RsVta
         700g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfFN7EWqV1F1vf3fk6as4NIr4ktnOVKAa71sjHjqTF0=;
        b=dH5rCYr7d3waa7maMjJdxIM4M7ODqO0QpJLR/al4Gf3+jVyLNcPZov/bu+HxiuKZbD
         fC/izAyiQclXt2181QCZpNsSdstUbhJzLgncbOS4ZY6EeIntVGxF6KLJiGhaRe3N4ZXk
         IM+EZw8g3BmT1/X3LYORR8qk9utL3X8Qlc1ZbkCAWNOKmXangct7afr5KzhkXSnnqwKo
         1y63ird8136ywY4i81kTveg6IQ4W5Scoa3KBxVhI4tVPVpWGEzlzLvahW0KKGs0PSFWR
         N1XKQXG4xnIVQwgrP65zMNzTKYVx4Dy+LQpnw5DprGyyimVf1BcTTtJAkumAFByoX4BF
         PREA==
X-Gm-Message-State: AO0yUKU8RxDzwRctCwuDQKyPEu3JRueU8LwymVT5tTJteQ2WnmMHfwNI
        b+e7UqFhI+Tb8YhQUgym6C4=
X-Google-Smtp-Source: AK7set9ZGp52xEl3R/rbTR6ebaA42+mcVSU3mJO9Nq5MWYAvrITlOqWSHnmGuzV7rSPln7SqRqZjjQ==
X-Received: by 2002:a50:f68e:0:b0:4aa:9f59:b6b1 with SMTP id d14-20020a50f68e000000b004aa9f59b6b1mr2502742edn.35.1675536712635;
        Sat, 04 Feb 2023 10:51:52 -0800 (PST)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
        by smtp.gmail.com with ESMTPSA id a15-20020a50ff0f000000b004a2067d6ba4sm2889308edu.52.2023.02.04.10.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 10:51:52 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 04 Feb 2023 19:51:50 +0100
Message-Id: <CQA06YLAOMGN.T1CEBGNQO34W@vincent>
Cc:     "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Subject: Re: [RFC 3/5] rust: sync: Arc: Introduces Arc::get_inner() helper
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Boqun Feng" <boqun.feng@gmail.com>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0-38-gb2afc8117fb7
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-4-boqun.feng@gmail.com>
In-Reply-To: <20230201232244.212908-4-boqun.feng@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Feb 2, 2023 at 12:22 AM CET, Boqun Feng wrote:
> Getting a `&ArcInner<T>` should always be safe from a `Arc<T>`,
> therefore add this helper function to avoid duplicate unsafe
> `ptr.as_ref()`.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---

Reviwed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

>  rust/kernel/sync/arc.rs | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index fbfceaa3096e..4d8de20c996f 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -201,6 +201,13 @@ impl<T: ?Sized> Arc<T> {
>          // reference can be created.
>          unsafe { ArcBorrow::new(self.ptr) }
>      }
> +
> +    /// Returns a reference to the internal [`ArcInner`].
> +    fn get_inner(&self) -> &ArcInner<T> {
> +        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object, so it is
> +        // safe to dereference it.
> +        unsafe { self.ptr.as_ref() }
> +    }
>  }
> =20
>  impl<T: 'static> ForeignOwnable for Arc<T> {
> @@ -233,9 +240,7 @@ impl<T: ?Sized> Deref for Arc<T> {
>      type Target =3D T;
> =20
>      fn deref(&self) -> &Self::Target {
> -        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object, so it is
> -        // safe to dereference it.
> -        unsafe { &self.ptr.as_ref().data }
> +        &self.get_inner().data
>      }
>  }
> =20
> @@ -244,7 +249,7 @@ impl<T: ?Sized> Clone for Arc<T> {
>          // INVARIANT: C `refcount_inc` saturates the refcount, so it can=
not overflow to zero.
>          // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object, so it is
>          // safe to increment the refcount.
> -        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()=
) };
> +        unsafe { bindings::refcount_inc(self.get_inner().refcount.get())=
 };
> =20
>          // SAFETY: We just incremented the refcount. This increment is n=
ow owned by the new `Arc`.
>          unsafe { Self::from_inner(self.ptr) }
> @@ -253,11 +258,7 @@ impl<T: ?Sized> Clone for Arc<T> {
> =20
>  impl<T: ?Sized> Drop for Arc<T> {
>      fn drop(&mut self) {
> -        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object. We cannot
> -        // touch `refcount` after it's decremented to a non-zero value b=
ecause another thread/CPU
> -        // may concurrently decrement it to zero and free it. It is ok t=
o have a raw pointer to
> -        // freed/invalid memory as long as it is never dereferenced.
> -        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get();
> +        let refcount =3D self.get_inner().refcount.get();
> =20
>          // INVARIANT: If the refcount reaches zero, there are no other i=
nstances of `Arc`, and
>          // this instance is being dropped, so the broken invariant is no=
t observable.
> --=20
> 2.39.1

