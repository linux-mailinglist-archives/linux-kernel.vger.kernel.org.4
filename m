Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1555E6D997F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbjDFOVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbjDFOVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:21:13 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1039186A8;
        Thu,  6 Apr 2023 07:21:11 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso42496686fac.4;
        Thu, 06 Apr 2023 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680790870;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gf2vZItStDxoP7p7n1CKiMOBcR6mU3Do89NH68xxCN0=;
        b=MQ2z0dNChzvQBx5rJ3vgDC6Z98eGYCyaa8Mm3FqhCUIvOMotpT3RSnjEEb68vJoQ7c
         v0NRH2rHlG9uJ/+Sk9XmPmzY2TnUXMUlkg7fuYeAMQzdzK1wPc4osa+9YQjdLVD9rfTf
         p6rzO2e2/u+UhwibuQeJybysrcEA2oFQ2yo+OkE56y822ogMDX/cEGpWEk5Y03VaMM0a
         WU1v5DepAYXN7Id8pyjbq6mKU7ygQmAHlWzvDsIxHVItfmmSMGbGA83JqeYbv4JXZZnP
         KkOWJAsnqhY2GbFy/1NRZVUzEiAlv93mp52bJUX9YjAS8ObWeYPF2A6IrY15fA9EBu6W
         J49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790870;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gf2vZItStDxoP7p7n1CKiMOBcR6mU3Do89NH68xxCN0=;
        b=wVpdoa38EkPCQ4aI7M6dS8mJvoFV3mbYgBp8vZcc41qjSSvJHsKNLZMh2cOP6oEU6H
         oH0x/lTYhBCk9LgKLpOnMp2E8oWZ4784DVE4zQJRI7X77pDrmPwHBu5gV7cmBPz1TfZk
         xLBK6e6CLMV8T0n97/S9Vl/VixqEx7DT5zOqP0n/44F8HTzD2ZeOrX+XtT24KJHa91pF
         lTNUaYX0onRYQuSyQGVQsOZe+fD9vyWgXp0ubUjuVk5DPb2Tx0EzYd7veiVLIsTQ0pMd
         7aKKBvq6DyHyl+8Q1Qij9quzRCZ/wA+I4qQZ+4E4ewKi2GeS5/hS35LFytp8ZmGXbX0u
         2DJQ==
X-Gm-Message-State: AAQBX9fVjBN5xjdhzFpak22JPEAa/I1FTOX7XzCaOlVQAw2tjwfSvHaQ
        1L1iz3uS8devTYSsKQMoBww=
X-Google-Smtp-Source: AKy350ZyqSErhhGgqtZDrcL2cbISL8x2Z71Fj1+sTWjjK+kfJeh/IDQhsAPvg6mD1O5iJc570h64hg==
X-Received: by 2002:a05:6870:40c1:b0:183:cc50:f7aa with SMTP id l1-20020a05687040c100b00183cc50f7aamr2948062oal.21.1680790870248;
        Thu, 06 Apr 2023 07:21:10 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id vk2-20020a0568710e4200b0017e0c13b29asm690058oab.36.2023.04.06.07.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 07:21:09 -0700 (PDT)
Message-ID: <365497cf-6a04-de2d-f694-d63424a5b779@gmail.com>
Date:   Thu, 6 Apr 2023 11:21:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v2 1/2] rust: add scatterlist support
To:     Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com,
        ojeda@kernel.org
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20230405201416.395840-1-daniel.almeida@collabora.com>
 <20230405201416.395840-2-daniel.almeida@collabora.com>
Content-Language: en-US
In-Reply-To: <20230405201416.395840-2-daniel.almeida@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 17:14, Daniel Almeida wrote:
> This patch adds a scatterlist abstraction. It is then used and tested
> by the new rust virtio sample module.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/kernel/lib.rs         |  1 +
>  rust/kernel/scatterlist.rs | 40 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 rust/kernel/scatterlist.rs
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index c20b37e88ab2..b23be69919cc 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -71,6 +71,7 @@ pub mod net;
>  pub mod pages;
>  pub mod power;
>  pub mod revocable;
> +pub mod scatterlist;
>  pub mod security;
>  pub mod task;
>  pub mod workqueue;
> diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
> new file mode 100644
> index 000000000000..fe036af13995
> --- /dev/null
> +++ b/rust/kernel/scatterlist.rs
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Scatterlist abstractions.
> +//!
> +//! C header: [`include/linux/virtio.h`](../../../../include/linux/scatterlist.h)

Little typo, I think that you've meant this to be scatterlist.h instead
of virtio.h.

> +
> +use core::cell::UnsafeCell;
> +
> +/// Scatterlist abstraction over the C side `struct scatterlist`.
> +pub struct Scatterlist {
> +    /// The C side `struct scatterlist`.
> +    inner: UnsafeCell<bindings::scatterlist>,
> +}
> +

Wouldn't be better to use a transparent tuple struct [1] since this only
has one non-zero sized field and could be easily transmuted into its
inner type.

> +impl Scatterlist {
> +    /// A wrapper over the C-side `sg_init_one()`. Initialize a single entry sg
> +    /// list.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Caller must ensure that `buf` is valid and `buflen` really
> +    /// represents the size of `buf`.
> +    pub unsafe fn init_one(buf: *const core::ffi::c_void, buflen: u32) -> Self {
> +        // SAFETY: There are no references or function pointers in this
> +        // `Scatterlist`.
> +        let mut sg: Scatterlist = unsafe { core::mem::zeroed() };
> +        // SAFETY: we pass a valid sg entry, which points to stack-allocated
> +        // variable above. `buf` and `buflen` are presumed valid as per this
> +        // function's safety requirements.
> +        unsafe {
> +            bindings::sg_init_one(sg.inner.get_mut(), buf, buflen);
> +        }
> +
> +        sg
> +    }

If this function was meant to be used for internal use only then it
should be `pub(crate)`, or else, a function that takes an slice should
be provided as a safe alternative.

> +
> +    pub(crate) fn inner(&self) -> &UnsafeCell<bindings::scatterlist> {
> +        &self.inner
> +    }
> +}

Link: https://doc.rust-lang.org/nomicon/other-reprs.html#reprtransparent [1]
Regards
-> Martin
