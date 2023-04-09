Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1EF6DC0B0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDIQrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDIQrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:47:01 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616FC10FF;
        Sun,  9 Apr 2023 09:46:59 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1842eb46746so3634988fac.4;
        Sun, 09 Apr 2023 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058818;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D0fvQTuLJsVSiFX0VfZzC1s/vcxQ1CsvIC212LbqATs=;
        b=BnoqgldEeo+cxrUrAWRyB4iXpq4/C943w1Pgx0RQTKd4ZmfM3yv6Nyg9M2WMx+InEw
         QxcvAajpxc1BTaF88kSwB4ECERGQ6lAL9mnEZy/79cM45P0dmX1tpIK4nQhnakxE38TF
         y9ybNbJwS5Q3zlS/RF253igrRBXoSNn33Qqs2k6gnzDoonP/wYMaGdB/xpdpEkX4B4t0
         yMvPeKtHQkPu+3VEXrORSL5/4BMvB3sIcDq3GjmwRP3aviAz+El54JjvmLMaJxV0EGMc
         vyTJ/5eOOdzNQ4dtKCaQQKw2gDCb4Un4tLJa5x0oiYuSS5GQZllUZAOhl4dq9DxWsLNr
         jsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058818;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0fvQTuLJsVSiFX0VfZzC1s/vcxQ1CsvIC212LbqATs=;
        b=wg3ktzw4ZmGW2M9kVf9Yk/oxH+7NDqYNMBSADmo8JxohdrUFfzBLL7H1Hh/VX+SV7U
         /ZH4TgKB/84ImASGIUMg9DR6um4S5FYDHfz2XWIR6mWpLgHvtHHuDXa1kybXNQ4V5aWB
         RYngSsvYVPVxJDrBvfhFMN2Sl7hrbBBZlVhrxJJTi2lbwNkP32DlYLs1va6G9wrXO/jX
         bTRI3DJ+hqqjkl9hLAi73a+Ys1UQeexosUOWWLgNkx6RneUJBCOpz9V6pRaq190LbwRR
         CAHlS91ggvYd0q5MnGA3RpkWrLTdk60umXRyVmK7tnEeCeesdq4WP7J6dc3gnzlU1/5P
         lyyw==
X-Gm-Message-State: AAQBX9eIt8GE5ArAj4HXIJ4Tw2mrP/LSbkFTdMD/ONvtT1nXO+EoRETY
        Bkh2Md19kyiWuAp3FIRFQ7w=
X-Google-Smtp-Source: AKy350ZhooYrSKliN3yDUCG/NrWGkrzrDpaJXDgycMA5xJ4JH7uzEGj5vHyn8A7p5P26CcxWSEjQdQ==
X-Received: by 2002:a05:6870:9a0e:b0:180:9124:850e with SMTP id fo14-20020a0568709a0e00b001809124850emr3980301oab.20.1681058817843;
        Sun, 09 Apr 2023 09:46:57 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id p12-20020a9d744c000000b0069dc250cb24sm3567715otk.3.2023.04.09.09.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:46:57 -0700 (PDT)
Message-ID: <301a83e1-0df9-7dbc-4737-0b18e87e6661@gmail.com>
Date:   Sun, 9 Apr 2023 13:46:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 01/13] rust: sync: introduce `LockClassKey`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20230408075340.25237-1-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/23 04:53, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> It is a wrapper around C's `lock_class_key`, which is used by the
> synchronisation primitives that are checked with lockdep. This is in
> preparation for introducing Rust abstractions for these primitives.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: Fixed a typo in comment
> v2 -> v3: Replaced `core` with `::core` in macro
> 
>  rust/kernel/sync.rs | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 33da23e3076d..541d235ffbeb 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -5,6 +5,51 @@
>  //! This module contains the kernel APIs related to synchronisation that have been ported or
>  //! wrapped for usage by Rust code in the kernel.
>  
> +use crate::types::Opaque;
> +
>  mod arc;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
> +
> +/// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> +#[repr(transparent)]
> +pub struct LockClassKey(Opaque<bindings::lock_class_key>);
> +
> +// SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
> +// provides its own synchronization.
> +unsafe impl Sync for LockClassKey {}
> +
> +impl LockClassKey {
> +    /// Creates a new lock class key.
> +    pub const fn new() -> Self {
> +        Self(Opaque::uninit())
> +    }
> +
> +    #[allow(dead_code)]
> +    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> +        self.0.get()
> +    }
> +}
> +
> +/// Defines a new static lock class and returns a pointer to it.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! static_lock_class {
> +    () => {{
> +        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
> +        &CLASS
> +    }};
> +}
> +
> +/// Returns the given string, if one is provided, otherwise generates one based on the source code
> +/// location.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! optional_name {
> +    () => {
> +        $crate::c_str!(::core::concat!(::core::file!(), ":", ::core::line!()))
> +    };
> +    ($name:literal) => {
> +        $crate::c_str!($name)
> +    };
> +}

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
