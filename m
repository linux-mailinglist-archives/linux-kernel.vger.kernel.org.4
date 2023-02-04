Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59C68ABF7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjBDSsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjBDSsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:48:13 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E015543;
        Sat,  4 Feb 2023 10:48:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mc11so23739243ejb.10;
        Sat, 04 Feb 2023 10:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTf3il7r+qUfnmE8kG0NPYBSRKTNHfVqKM3rJtokOrg=;
        b=j7YYbGOBZoGO07U6BsfJWa2yIbjdSF6bVuAmchsXj8289KvVyGiXoOOjqtqz1LqNwH
         pZPVe1RG7jI7ZaejnAQOYP3XL7oC8wW1O7Tz19JFXzdXj9F98sjY/dE00C/oMdwMTvgi
         okiJGPb4hyPxYNFf+iS4GeYmPKM1lp1QHDKWju5gdAtffoKORjx0NprU+D8ojuA73Cn6
         8RPGjKl9F6j9aN/FtIelZXygioLLdfklwhuL7kixDu/66PtWJ6RINpyUo0+3fHLsyxRM
         9v2upVU5YWCCxM93Fly1mwsdwudrYjf+goIYXjcN+7c3S5C7koRk8qRGFO3mzkiCkpF/
         iXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WTf3il7r+qUfnmE8kG0NPYBSRKTNHfVqKM3rJtokOrg=;
        b=X+DrOcoGy/o+Poau5BpbdIlmqkkl3S5Wsn0/BX3oJXx2YKg76NGqVK0sGwOykVoVTc
         M8TFxzywcmgq7exSLB388H/ALx4sXSGHnmwPGgt/UbWM+gxQoaVTE1H9ZENrhnVzifMU
         33UIG7vMND0lU1pk8XRYp60aEl/BeJgn/VHD5rqKivMM4rfgq0JoLbfItRQf5Cxqe+mw
         p+tC4lmt+pcf1U9nAx8nfQY5nGP4uJwPyYCyu0OC9njZlDr9yHRRaafJUuVTZpXXDrfh
         +JIfWl3uZGdp3MGUFHEUR2eVtl3HR0FB/frJuqOMIstGSAtfpLFur37zOOPi/3BaJRi3
         pVQA==
X-Gm-Message-State: AO0yUKXujGt44boGBMYtEgUp14vDK3+mpoSmZ25tcbMh7HXTsf3DHDve
        VXtK7HScCItwObNeABiV1e0=
X-Google-Smtp-Source: AK7set+w35CKWh4qe2pjguycwYZUgyWZznLOJ9omq/T90+qDammNPobTCd5Rj44E8fGAwXWwozGbPw==
X-Received: by 2002:a17:906:7141:b0:877:7157:9358 with SMTP id z1-20020a170906714100b0087771579358mr5959833ejj.10.1675536490416;
        Sat, 04 Feb 2023 10:48:10 -0800 (PST)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906938200b007c11e5ac250sm3171286ejx.91.2023.02.04.10.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 10:48:09 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 04 Feb 2023 19:48:08 +0100
Message-Id: <CQA044FTNTE7.AZ4XVCKT1R89@vincent>
To:     "Boqun Feng" <boqun.feng@gmail.com>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
X-Mailer: aerc 0.14.0-38-gb2afc8117fb7
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-3-boqun.feng@gmail.com>
In-Reply-To: <20230201232244.212908-3-boqun.feng@gmail.com>
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
> This allows reading the current count of a refcount in an `ArcInner`.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
Reviwed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

>  rust/helpers.c          | 6 ++++++
>  rust/kernel/sync/arc.rs | 9 +++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 09a4d93f9d62..afc5f1a39fef 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -46,6 +46,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
> =20
> +unsigned int rust_helper_refcount_read(refcount_t *r)
> +{
> +	return refcount_read(r);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_refcount_read);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` =
type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index fc680a4a795c..fbfceaa3096e 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -127,6 +127,15 @@ struct ArcInner<T: ?Sized> {
>      data: T,
>  }
> =20
> +impl<T: ?Sized> ArcInner<T> {
> +    /// Returns the current reference count of [`ArcInner`].
> +    fn count(&self) -> u32 {
> +        // SAFETY: `self.refcount.get()` is always a valid pointer, and =
`refcount_read()` is a
> +        // normal atomic read (i.e. no data race) only requiring on the =
address is valid.
> +        unsafe { bindings::refcount_read(self.refcount.get()) }
> +    }
> +}
> +
>  // This is to allow [`Arc`] (and variants) to be used as the type of `se=
lf`.
>  impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
> =20
> --=20
> 2.39.1

