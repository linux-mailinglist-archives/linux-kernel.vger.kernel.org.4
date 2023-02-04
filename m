Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE41C68ABF6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjBDSrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjBDSr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:47:28 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE771632F;
        Sat,  4 Feb 2023 10:47:26 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qw12so23844959ejc.2;
        Sat, 04 Feb 2023 10:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAg+ibn+4CGh7a585kEkXzab581htTJeb9Mu1L0ikcg=;
        b=KJnNRiTQMoAsnReb9ft7g9VhsZh/7Duw4VTiXDTwtknJoeMx5+fDj+QuMJulgHzNCb
         YF772hclREZnrqgqbb5NAECtbdgtmc8mDa94Tz4T2fxz4l/GqhgrHUhyKfh3uJ3fC9BT
         h8fJZPUx72EAceEyck6fQXM8n+J7RkH8GCLr8jzQexLQBjjRZOw/wqm4ZKenBZP05p5W
         n6EGoIEPVEgudtkXFWnDsTyyO5JL5yfEJm95DpmdNW13of8dm4RBWtXkrp2jBNIsppdX
         0J7ecMxnqAJsBS13fUF1Jiz7MncDOv++JBQjD1+w6JL6O+J9VQcV973kpFj9UMoP3G+u
         WAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zAg+ibn+4CGh7a585kEkXzab581htTJeb9Mu1L0ikcg=;
        b=sK+65Aci7fiFgfnIbMWRZG4f1Vavu3JshQPJOKjibEEuKsO9DEP14NV9V6xByn/9wS
         VKwZ97sYA4KrmRGx+O14JM0A9D7lqWOTq3LQe+QeA3+T4jW8XtknV9cxQIZHdwWxzS4w
         zkGoQ3AdksnGnj7oJyhLOrjVua4DsxKNppJRT7YYzhTDn+6wSHl2lQpi3Fv0Nf5Ax1dr
         9/V9CcwgnlSvzuXSzl/SwCp7Ch9BkTgxm+xpoQl1sdgVIH3BWhPPTPDKUqS3zfeRJU5y
         9/zCopO/cjd9uwsjICvdW3PLVOA844HHN3wcR7kFnSRhuScyBg+ExdUQzsTaiYHFsStP
         Pe5A==
X-Gm-Message-State: AO0yUKXnOnZnSez6RZC86WG5hBHc6dzQZqanySB5xDHbez8BnTAiFrUY
        7ut7UtWNbhJ7fav2MNkk/qk=
X-Google-Smtp-Source: AK7set/YVHlEQ6/G6etUnvb1hR/H4NRHMKRSS86WAGVV1ondyDfWwF9J/1f2Kthmt30CfXcW+jTufA==
X-Received: by 2002:a17:906:4fd5:b0:88a:292d:be8c with SMTP id i21-20020a1709064fd500b0088a292dbe8cmr7902997ejw.22.1675536444659;
        Sat, 04 Feb 2023 10:47:24 -0800 (PST)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
        by smtp.gmail.com with ESMTPSA id aa21-20020a170907355500b0088eb85e29c5sm3136752ejc.6.2023.02.04.10.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 10:47:24 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 04 Feb 2023 19:47:22 +0100
Message-Id: <CQA03JGUK2SB.3VFUJUHGO57WC@vincent>
Cc:     "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Subject: Re: [RFC 1/5] rust: sync: impl Display for {Unique,}Arc
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Boqun Feng" <boqun.feng@gmail.com>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0-38-gb2afc8117fb7
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-2-boqun.feng@gmail.com>
In-Reply-To: <20230201232244.212908-2-boqun.feng@gmail.com>
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
> This allows printing the inner data of `Arc` and its friends if the
> inner data implements `Display`. It's useful for logging and debugging
> purpose.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---

Reviwed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

>  rust/kernel/sync/arc.rs | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 519a6ec43644..fc680a4a795c 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -22,6 +22,7 @@ use crate::{
>  };
>  use alloc::boxed::Box;
>  use core::{
> +    fmt,
>      marker::{PhantomData, Unsize},
>      mem::{ManuallyDrop, MaybeUninit},
>      ops::{Deref, DerefMut},
> @@ -522,3 +523,15 @@ impl<T: ?Sized> DerefMut for UniqueArc<T> {
>          unsafe { &mut self.inner.ptr.as_mut().data }
>      }
>  }
> +
> +impl<T: fmt::Display + ?Sized> fmt::Display for UniqueArc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Display::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Display + ?Sized> fmt::Display for Arc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Display::fmt(self.deref(), f)
> +    }
> +}
> --=20
> 2.39.1

