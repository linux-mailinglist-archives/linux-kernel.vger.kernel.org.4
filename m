Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8333C708CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjESA2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjESA2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:28:44 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F416E2;
        Thu, 18 May 2023 17:28:41 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ab087111faso1112501a34.3;
        Thu, 18 May 2023 17:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684456120; x=1687048120;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xfintrOM/1fpOEzvoo+azEZAHiiUhCkQ94XfBy4YSIw=;
        b=QVGac+UY98q0Icyx2cFtitW+fHYVtcUadgrt5aegq52aXKojnveL/fVfx2un2sgvR4
         +MOfF5XMqH/9tVdVxWSWaCph9k28l9gQC3Qn8K+p/oBoAVzPLVNfJWRxbsUuVq73H+Fo
         oIT8Ig4A58FDkvJWwTNRWLdSEM0YAeJdYDKi3DroIwOASst2jSwV8ZifXCQxTyGTyimH
         0tKPhfpLLq+YS8/CTH/QW9na1K3C7XZaYNbDl6sFKCMuBAaFpkaZ/QlgA5Q1Oym/IAm7
         63pKXQzdnzttP25rtScDKFdB7BcFOeVolFWZKJNuWul84SaUkB6V0Er2wqTvLVFLdu9A
         YkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456120; x=1687048120;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfintrOM/1fpOEzvoo+azEZAHiiUhCkQ94XfBy4YSIw=;
        b=XaWivar3MT7dHrMQv0Zx0vOEZkEoPwJgSxJuR9v80GsGXzOsAJL7ttmTmh0hRaH0XE
         0pqTbDtvZELwK6bQChHVJRMYtLC6gcH/I4T4QTMKY8607MpH0l93+MsJbPKxIR+dTvJC
         sbvtmG2G1U2iElHcJJXzlQ9/Vk2Te+s+nHkNPs+HtPV4ffo+S1HDf8yXIy+WjbWoRhpt
         ZJTebMSGAwliQZce/pHC1SUw+/M9NiLF3GTLp+QdZANgZy5GRAyI7nqTZLGDJKq3UC5E
         ggHA5GfLyVkNfCrTUQl8rJLOdwdRqAAl8TNE9GIbp2u8vlgygnCMsXNAuxdYZVs8R/VZ
         hmAg==
X-Gm-Message-State: AC+VfDwDz2mRNJKo+lXLSJsRpeAlh4N1WUjdiw0xfZULwI/tPtGsmygp
        MCqjU8KZTafoXHVhqzt3s/w=
X-Google-Smtp-Source: ACHHUZ6cbUF6iirrzUPMVN6p7d9wmles1zdmr588mUVTivZeLy+yaI7bLU71vnyTekkSxXNRSGB76w==
X-Received: by 2002:a9d:7a91:0:b0:6ac:8557:b0e7 with SMTP id l17-20020a9d7a91000000b006ac8557b0e7mr145266otn.32.1684456120073;
        Thu, 18 May 2023 17:28:40 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id j9-20020a9d7389000000b006adc8d27bdfsm1191921otk.7.2023.05.18.17.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 17:28:39 -0700 (PDT)
Message-ID: <8e42aad3-d94e-3cb4-ee59-90ded31cea9e@gmail.com>
Date:   Thu, 18 May 2023 11:51:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v1 1/7] rust: workqueue: add low-level workqueue bindings
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230517203119.3160435-1-aliceryhl@google.com>
 <20230517203119.3160435-2-aliceryhl@google.com>
Content-Language: en-US
In-Reply-To: <20230517203119.3160435-2-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 17:31, Alice Ryhl wrote:
> Define basic low-level bindings to a kernel workqueue. The API defined
> here can only be used unsafely. Later commits will provide safe
> wrappers.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]
> +
> +impl Queue {
> +    /// Use the provided `struct workqueue_struct` with Rust.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that the provided raw pointer is not dangling, that it points at a
> +    /// valid workqueue, and that it remains valid until the end of 'a.
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::workqueue_struct) -> &'a Queue {
> +        // SAFETY: The `Queue` type is `#[repr(transparent)]`, so the pointer cast is valid. The
> +        // caller promises that the pointer is not dangling.
> +        unsafe { &*(ptr as *const Queue) }
> +    }
> +
> +    /// Enqueues a work item.
> +    ///
> +    /// This may fail if the work item is already enqueued in a workqueue.

Wouldn't be worth to mention that, if not implied, the item it's going
to be worked on an unbound CPU?

> +    pub fn enqueue<T: WorkItem + Send + 'static>(&self, w: T) -> T::EnqueueOutput {
> +        let queue_ptr = self.0.get();
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
