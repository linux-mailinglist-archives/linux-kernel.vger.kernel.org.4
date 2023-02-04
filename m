Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0CE68ABFF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjBDS42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBDS40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:56:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B292312D;
        Sat,  4 Feb 2023 10:56:25 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u21so8093438edv.3;
        Sat, 04 Feb 2023 10:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXTvsqqPQTKemZkzT9B470QmaPw1nry7mmJ+mqYkq/Q=;
        b=h2zCi2SfkjYfKH71RLy9JcK+NZvCxlXvJIlBHzQSDVsQ5L4npmlE4QiphO+6ZRnE9P
         u5oppkt2LVEgkC8he53Lv9KYaZ0lLN1Kw+T83RmxKtfsKehKPzTuvKelLI5VqaXBTK0X
         nlgleL8HxHmaMSupYX5HdMv0MazGp6nGw4L/ycNl2B/K3qpJ4CUyAavWXddSwC5X9nD2
         JoQz5nnMSUX+GEoUk4HzpDeADnNJvzeWEI0cXVElTDDts5nKyrxGSJOsumiifwyJJ9eN
         jLTFl8K7ykzdGkV3JJwy2oMOi64F712taQFxAhVn5gqywWcFenxgGHA0vcO9b/damYZC
         OYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XXTvsqqPQTKemZkzT9B470QmaPw1nry7mmJ+mqYkq/Q=;
        b=iayqYfnX3j8okc+v541nW2Rh+dhrC6WvQQ69CEt9kZmlyoMgq5wUsMi22atxwyMo99
         95CthHqCtWJxOXygdZ20twnmPy/kgH/I6gAfIWulJPqAwgDuIl11poD2vJP8/RuE4mrd
         EhYlURZeZQ3edTFZEmMcncgt8gDFqF/gX1Amc9OBiqM7m66+EvCET2zDbZ6PwDhoiuk/
         B8JAAPxUrQFbgUgx4TVP7hAfJbdcZj39S/7dOBkkx5/Ffb+KAunJi/XYaGD84LODz7J8
         xhnC7EYZaAz3krgaqj5GlprR2onnPBtDyYGm1NYJsV1XS3iuUFn4VT8HHSz5peyL3uM6
         4LwQ==
X-Gm-Message-State: AO0yUKXAu5XFaiJPNgYdjJE23RlzFU6UjY9WFn+6+8UIRz9IEiO8Z/io
        nJO/B6gj4QjibLpaUuVHDZk=
X-Google-Smtp-Source: AK7set+5q4lqvJHvDWQ8+tW0CHqwnIIYtkMKCju2FE25MD4mIhsJrn5KLq25YpKF5P3zea7o0TWmjg==
X-Received: by 2002:a05:6402:1950:b0:4a2:260f:3bbe with SMTP id f16-20020a056402195000b004a2260f3bbemr15999578edz.23.1675536983707;
        Sat, 04 Feb 2023 10:56:23 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:8c1:b772:7521:b7bd])
        by smtp.gmail.com with ESMTPSA id lv3-20020a170906bc8300b00883410a786csm3087901ejb.207.2023.02.04.10.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 10:56:23 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 04 Feb 2023 19:56:22 +0100
Message-Id: <CQA0AFBAS9NN.18QN99FQVH9ZF@vincent>
Cc:     "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Subject: Re: [RFC 4/5] rust: sync: impl Debug for {Unique,}Arc
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Boqun Feng" <boqun.feng@gmail.com>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0-38-gb2afc8117fb7
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-5-boqun.feng@gmail.com>
In-Reply-To: <20230201232244.212908-5-boqun.feng@gmail.com>
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
> This allows printing macros to print the data and the refcount nubmer
> of these struct for debugging purposes.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
Reviwed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

>  rust/kernel/sync/arc.rs | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 4d8de20c996f..f143d8305c36 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -474,6 +474,7 @@ impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
>  ///
>  /// # test().unwrap();
>  /// ```
> +#[derive(Debug)]
>  pub struct UniqueArc<T: ?Sized> {
>      inner: Arc<T>,
>  }
> @@ -545,3 +546,15 @@ impl<T: fmt::Display + ?Sized> fmt::Display for Arc<=
T> {
>          fmt::Display::fmt(self.deref(), f)
>      }
>  }
> +
> +impl<T: fmt::Debug + ?Sized> fmt::Debug for Arc<T> {
> +    /// Formats debug output for [`Arc`].
> +    ///
> +    /// Refcount is also printed for debugging purpose.
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        f.debug_struct("Arc")
> +            .field("refcount", &self.get_inner().count())
> +            .field("data", &self.deref())
> +            .finish()
> +    }
> +}
> --=20
> 2.39.1

