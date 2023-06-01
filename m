Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03A071A143
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjFAO7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjFAO64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:58:56 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090E9E61;
        Thu,  1 Jun 2023 07:58:24 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-39a505b901dso794458b6e.0;
        Thu, 01 Jun 2023 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685631500; x=1688223500;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R3xlSxMTcF87QzSJRGtR3aRtTi9/A1XGfTJRaxTHZ/A=;
        b=fXO2nt4DOPXlgg55dIYo1i7lx9PQKx6f6Gpm0Rz30qheWnJIe4t4diKELxC+EMXRPl
         C+Noee33vW4BzAGQQlGLAFj/kgiodUXGvnpaJCSPJUXZprlzOZ9+yoSnd4suYiwwOc13
         NZ0ekwF67I6viF3BTtiZ+9w8Ir548CDqvndoLfFr7nAfIJDX3FHCY5MKoDqs2PT/JXda
         bsSrz22wG3UMqXwtHua06wYFDH/Khw8mgsBBXKGbOKVa+y0jNhUGxQHJ8qG8g9MEqzKj
         1xqW56V8/hAsI+cjrM9r5aKqX2v9wmv1mO6B6ODJDOuybd3qyWV4YPxKr6J+9vcTrWPq
         AUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631500; x=1688223500;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3xlSxMTcF87QzSJRGtR3aRtTi9/A1XGfTJRaxTHZ/A=;
        b=PnKwq/xQnzC5Op6hnSh+SKQO9D1b8o1om/PUO+ibYRfMQ2ozF31CZW1Fz7az/GHdDQ
         MPDmjrxtvrdBW9HOBx8H92DUo4l7iIx8FItQT6B0qX6ST4FMLtQWmc/wY7FD/kyXqL0x
         2uKRlz2TKpvSnx54sRtEyfRvCj+7w9D5p/0znvW76ZghSr/mMq4pwPdjARPLh+Fln2Ag
         /ukxVHO/D6jkJjASLr4vKaTqmDp2Rh4Ra9O8VHPhsG2ZUDGi7acTCy7hcz6zVjg5tPaC
         Srtw/MftFfklanZJZ9r2Z8Cyw83RFMB5Bm6Ej1k6G3ray5tGkRHe3tLsiFUr9B+yXkoU
         pQow==
X-Gm-Message-State: AC+VfDyvVSBUoNB+fBRLZ6QAs2e+6oW62C1yos8I0aDHIsfNAdepJrCQ
        q/2TCE8Ib97HqyalfuO5EHM=
X-Google-Smtp-Source: ACHHUZ7CNoLcRMmNdTH38tnwna/r/qhwjihgBIYPHH3F4/5lfaci8KOua5Jzv6Hpir4E3/bCTC69rQ==
X-Received: by 2002:aca:100f:0:b0:398:50f1:ad17 with SMTP id 15-20020aca100f000000b0039850f1ad17mr7309363oiq.4.1685631500443;
        Thu, 01 Jun 2023 07:58:20 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id a19-20020a05680802d300b00397c07e8061sm1738511oid.6.2023.06.01.07.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 07:58:20 -0700 (PDT)
Message-ID: <91a968e2-7c18-1bd8-84a4-b9c1eb9cca91@gmail.com>
Date:   Thu, 1 Jun 2023 11:50:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v2 5/8] rust: workqueue: add helper for defining
 work_struct fields
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
References: <20230601134946.3887870-1-aliceryhl@google.com>
 <20230601134946.3887870-6-aliceryhl@google.com>
Content-Language: en-US
In-Reply-To: <20230601134946.3887870-6-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 10:49, Alice Ryhl wrote:
> The main challenge with defining `work_struct` fields is making sure
> that the function pointer stored in the `work_struct` is appropriate for
> the work item type it is embedded in. It needs to know the offset of the
> `work_struct` field being used (even if there are several!) so that it
> can do a `container_of`, and it needs to know the type of the work item
> so that it can call into the right user-provided code. All of this needs
> to happen in a way that provides a safe API to the user, so that users
> of the workqueue cannot mix up the function pointers.
> 
> There are three important pieces that are relevant when doing this:
> 
>   * The pointer type.
>   * The work item struct. This is what the pointer points at.
>   * The `work_struct` field. This is a field of the work item struct.
> 
> This patch introduces a separate trait for each piece. The pointer type
> is given a `WorkItemPointer` trait, which pointer types need to
> implement to be usable with the workqueue. This trait will be
> implemented for `Arc` and `Box` in a later patch in this patchset.
> Implementing this trait is unsafe because this is where the
> `container_of` operation happens, but user-code will not need to
> implement it themselves.
> 
> The work item struct should then implement the `WorkItem` trait. This
> trait is where user-code specifies what they want to happen when a work
> item is executed. It also specifies what the correct pointer type is.
> 
> Finally, to make the work item struct know the offset of its
> `work_struct` field, we use a trait called `HasWork<T, ID>`. If a type
> implements this trait, then the type declares that, at the given offset,
> there is a field of type `Work<T, ID>`. The trait is marked unsafe
> because the OFFSET constant must be correct, but we provide an
> `impl_has_work!` macro that can safely implement `HasWork<T>` on a type.
> The macro expands to something that only compiles if the specified field
> really has the type `Work<T>`. It is used like this:
> 
> ```
> struct MyWorkItem {
>      work_field: Work<MyWorkItem, 1>,
> }
> 
> impl_has_work! {
>      impl HasWork<MyWorkItem, 1> for MyWorkItem { self.work_field }
> }
> ```
> 
> Note that since the `Work` type is annotated with an id, you can have
> several `work_struct` fields by using a different id for each one.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
